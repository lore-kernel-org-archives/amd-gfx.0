Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86F4C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Nov 2022 09:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0605410E725;
	Fri,  4 Nov 2022 09:40:16 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2067.outbound.protection.outlook.com [40.107.100.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 803AC10E724
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Nov 2022 09:40:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZqdWCW8ZmOvuid4ADP2OcFREFPEAw12Qhz/yPFxe9QXB1ixYzfevyBNafuGxR0EmveQjeQHXRpYqfKmUz6D5suycB4j3/KIZFzuNKFplXlUjRhRxmPlI5DdXMvh8A8KYJr4VPM7jjVZxP3IpEpb9bHJn4B5pC7m2G/wopcZ/tsDaLwdL7pbd2KhGbo3AxGuG0Aa08AKqXYkCCWRN+TIjCRpcwH/XsjXe54bhEmltc2rIflcB5XxAxmaJjq9ZHbq30+gjcs8SbS6js+xh40uy9Cy231SRr8qTClYhMA9Yxvf/WqiC/sXT253YV/wLehgZ0jX79WAT/Lp5jC+H78FdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8v0G747XzFUv75ibAN9gRYNMwE7UQWLwHZoGeX5eUm0=;
 b=i3EOAMZmJeAJRiAODB2/CJKyMZQ4klUGlMRrEzighgODcv11xzASJ3CmIUpwfymQgV0wL06Gax7Ki6U5Ut/fwQ9ag7JcWkf2sLNZNVuwiagQNgbX2AbRL2RYH9gcsHDMkry+Dd8rPdXHLtrWXrAQv/knU+fqTC+B4aYFDd3rqmoTjdUZCsbkItWCUAj2VfiM0r97alx466jn1cDnqk61Ym6Mtsq91hl8jMMcKaAyeJ5h46bBSu9XaFfctCbt366LJeI/KMcvTUdlFmZ48CHRNrZECVqOGzBPR0hQQQad+esNKz3SznwNJMGec9yvulkC/eI1P8BtQLafsN5tR7ZM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8v0G747XzFUv75ibAN9gRYNMwE7UQWLwHZoGeX5eUm0=;
 b=gMhw3uGOTd8Ms+hiN3UadqGU6eqsJxbengPXBdlrmdqm8Hiiz/VvPAePxIQ+u22RY4MDKIRMQtXauGRdtD4cFscdfYqzePnogmGqVwHanb/KGcS5U3SyJBS+U9/v5Wp+ywISuu5vQT+TiNtbePM53EoV+i7m7XhukUCbQp1f1Ik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CH2PR12MB4120.namprd12.prod.outlook.com (2603:10b6:610:7b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 09:40:06 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 09:40:03 +0000
Message-ID: <6d496ee7-5520-a504-e83b-2b808784cc98@amd.com>
Date: Fri, 4 Nov 2022 10:39:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: "Liu01, Tong (Esther)" <Tong.Liu01@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221104085242.11071-1-Tong.Liu01@amd.com>
 <655df54e-43ce-4b6a-f88a-580c605abf58@amd.com>
 <DM4PR12MB61343AB275950997615CF67A903B9@DM4PR12MB6134.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <DM4PR12MB61343AB275950997615CF67A903B9@DM4PR12MB6134.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::9) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CH2PR12MB4120:EE_
X-MS-Office365-Filtering-Correlation-Id: 1574ed03-0a67-447f-eb4e-08dabe488c12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9DnSxWC1w2hhcCthbkjTCoAU5XD/Mf7Mf5pi37saRDQHHcwkImjxHhX+TNUwPyoZlwKhjFK2r3/H/rbW2etW2tIYtK6ftGgB5yQTiBRTdgrIdXaCKkJH/EWAXDrXEw89jrbRx2+BJB6BsVvsHQx9THxd6DW1J5qHNGf2+t6Y4dUF6p9UUf0lgyyyAsh0lCuKQAw6GYkskTnjVeOqCXNsgLD5M4NC0xDwrAMDYCR2x8MUKsWUjTeqKeHuq4/hNKP6Y1oiMXC0F6E/kX/WdEFIpkS3tz6lqNYkHup5wxDxZuOrq58bCNz64O+V4L8V9xemD4Q61op/YjgbqoT+oUiSNWjPdfTu1+OULNdiDYvr6ZcIdRoRFFJiEtaYw/Ub5BmV25SfKNoA6XJso7hUlIexLcwZmvmVbznkRTQiHnj3PfdKp27TLfPHwERonS8R/aJvpJxfoi2J2f4uCfBg7IKwA48bhFPL9ttdItO6IgGT9briycpuw0bP/JBv7JgpIKtTz7RDmrSPMzE/us6QwY86cs9ntyV5Nx2uX4CJh3H04jSKiqCHrXApVUjBOePof3VDl2zLsZ94uLs0cVls9v+GE6720MMZb6J0hlobLBiIwNea0NQjdguBkuPUxZJTmMryAM7/qK/dIRLgV68hq8//fIvcZzJf43j5Upna0YHzc5IbP2vVfPeEt1XtltQxhmRLfeVfFtAhBHWBlj9pouVyysv5uWYcibadvrF9mMkDSjb5lKoyDUaMTaQqNht/0HyePfor34JsPR8p501VIY610tlHuq6hQ5M+maSvHtGiGQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(8676002)(6512007)(316002)(83380400001)(110136005)(54906003)(53546011)(6506007)(5660300002)(31686004)(6666004)(30864003)(2616005)(186003)(66556008)(86362001)(8936002)(41300700001)(38100700002)(66946007)(36756003)(66476007)(6486002)(4326008)(2906002)(478600001)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3hLaDZ0YzRVelJNUTQyaVdJUlY0RGdwT0RSWFhtWStSaCtvS25LWFdZY3JK?=
 =?utf-8?B?MWM4NHdNMTlNRUtQcG54NVJZQysvM2hHU3B5SnVGRE9XbkJoZ2IvZjkzOGlr?=
 =?utf-8?B?aHlwamUwK2VMenhpTi9hNUY2VHZnbHJHdjU5TG04TXpzc3lucmRoNnJxUmFQ?=
 =?utf-8?B?NDBFS0docUFCTDlCOUxwZjR1Y0tsbWlYMGV1K1NROGovenJpQU5XVmdKbjBl?=
 =?utf-8?B?SmpTamRFWnZqUm51Q2ZLMzcvVFBVUi9EZFVEc28xcXcrNk1CeEFlK3dpR3RL?=
 =?utf-8?B?emhFWllDYUFpTzJxeEVKRVhkQTFra2d6cWF0eUlsZEdVWElwUUtMWDN3RkV0?=
 =?utf-8?B?QVNjK0RtcW5pd1MrMjkyYkFuT1dGNEVNTlJhTkZVaFFJTEFBMGJiV1hEbmZ3?=
 =?utf-8?B?dEdFangxMVJBamdjdmlUZFRVWW9uRzAvYjhZcFRKWUVkbS9QZHJDc1FhOUpE?=
 =?utf-8?B?Q2NEaFJlM2RsQURGNDkzSmdaWkdJcjBwc2Q5WENPWHNuTzVrV0tibXdYTlBQ?=
 =?utf-8?B?STlBSUhhZE5RL0ZNeFRRMXdtRkdEMXY5b3c5Q0d1dVJyN2RnWWh4a1Y1RUlH?=
 =?utf-8?B?OTB2WTVQVnA4anNJNDRVNVhkdWtocnR2a1BrZk9zZnVmNlVmbzd2VmEyQXho?=
 =?utf-8?B?T2NvQTVKOEVUUDBiOGFEajYweVE4dUN3clEyQ3NkVUVuMXViSllHZzJ5T2Vp?=
 =?utf-8?B?Zms4aitlVDl3YTVOa1BPaFAxOGtyKzZjT2p4VzczYlJER0NuRG95QVFrYTRD?=
 =?utf-8?B?ZjFtS3A2ai9Idll1MEIrejFyb1JRWERmd2hSbmhTWDc0Z2IvaWozNGdGV2tO?=
 =?utf-8?B?VGFNZTlrMm9QNXhnVldyQmVRaWpoajRmWmVjOTFHejJZOVFjZHVTZXJCM3Rq?=
 =?utf-8?B?RUpRZ1ZFaXViYWVKOGNZcWdLTWtYR1ZjWS83eHJHa091Q2NBM2Rsd3dDczEw?=
 =?utf-8?B?VEZLU1NyQytYbms4aFQ0OE5RSEdPRXc4aVRFMGRIR3Q3eCsrTDRKZHRwcUxn?=
 =?utf-8?B?Y3QrZVdXNG1kMzF6dlJHVGZvYXY4TGsvMnRmaVJHUHdwOWNTVVp1WE90QWV3?=
 =?utf-8?B?NmE1VFN4WVlwZDV3ektPTzZPcjE2a2VsQ1c1QkRpK1NRNFRuNzlRWDd6dG1H?=
 =?utf-8?B?dWRrNkFGZlJFNzVwd0tsQ1NSN1JhNEpXWEcwWTk4bURNNkdMTzYxSTBhVXAz?=
 =?utf-8?B?NTQzOXlnWG5LU29qNkRlWkJDSWxnSkdQbmhyRGcwOHFVZnMxWjlPVkl2UG1P?=
 =?utf-8?B?RTRXd0tNc0pOSXFOMitOSEpINUhqaGEwOXJXR0RQblc5Wm9zc3ZkUDhPVE1i?=
 =?utf-8?B?VWJCaDZzR2pZK0hRNDdUcFhta09SSndzL21oS0dKYjNEUWNhWWtDNVJmbVo0?=
 =?utf-8?B?aUordjhpS2lhV0ZoMDZ0dE0vKzRLOGliWjRwZjlBczBuY05selVMNjFsUXJr?=
 =?utf-8?B?bkd4UzRtdm9GZ0p6cDJDWVA4SklMbmVjRzc1SlpJL2R2c09KNVJUVlZ6K3Nk?=
 =?utf-8?B?OGc3TkxyN2pLaXJwQWZhWGFiVktsNnVpSUt2U2JlbTBQNE1oMzBBTDZyZzFG?=
 =?utf-8?B?UGhOQlRYU0RuK1NnWTF4R3FNbjh3SWJRL3pkeWFheXgxcnY1Wmo1a2dZWlFQ?=
 =?utf-8?B?MEtyeitqM2p0VzFTSnp4UWtxa2NtaU9zb2ZyUVBrZERjcEJhZWVYZklwNWxr?=
 =?utf-8?B?WUF6YUVCTEF4ejFWcHpYdWRlbnZybmd4K2NrYkpPRHhMZk5ldFlXRmo5OUVU?=
 =?utf-8?B?eEt1bXNmbU1nenRuYXFWSmZBcGp0YXV6MGI0Y0NDVjBWMFV0TUM3RkFnSkhH?=
 =?utf-8?B?azMyMU5IenNrYTZxa2tiMlQwK1VnOWdubjNYdXpmaFJCUUIrbDF0UU1pSld5?=
 =?utf-8?B?OGdsZXZ0bjJHaEpkU0E5Nm42RlhieUFzSDVnQlg3ekErMUJyQ21JSyt2QnBK?=
 =?utf-8?B?cTloOXJOUnpIWHdjR0xic1dGd1JHSUtRVUdJeGh4am9uenAyUS9hUVFWZ1pw?=
 =?utf-8?B?UHVPSmlwSkZmZjlrN243bHFYZmQ0WDZiK3NESWxlYW5hSUZBTnlwOE5Ja0pH?=
 =?utf-8?B?T2NxUnlablNRUXRpbnp0UDNmaEwrQmxMMy8vdW9pSDQwZHRVVXkrR1JlN0l5?=
 =?utf-8?B?QUZxaGxQeUtDSXB2Y0JxTWk3Q29GT29QdHlJd2kyMkNCZThpTnpBUzJtbHlN?=
 =?utf-8?Q?fdv6AkLzdJ9j+XfI+5hIEQSZJntcgCB1gHXnIpKXgYtP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1574ed03-0a67-447f-eb4e-08dabe488c12
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 09:40:02.6131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjbQpLiOlSTHPV0clZDPcC5se8GMZ4SWgIzNsLmZSNBxtT+PL+Rda7XJmRD7ZlMf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4120
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Xiao, Jack" <Jack.Xiao@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Esther,

ok, that works as well.

I would just move the handling of version of the firmware table into 
separate functions. That should make it easier to understand what's 
going on here.

Thanks,
Christian.

Am 04.11.22 um 10:34 schrieb Liu01, Tong (Esther):
> [AMD Official Use Only - General]
>
> Hi Christian,
>
> Based on VBIOS's comment " driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region". Our understanding is that they are not mutual exclusive. So we create extra parameters to record drv reservation request.
>
> Kind regards,
> Esther
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: 2022年11月4日星期五 下午5:09
> To: Liu01, Tong (Esther) <Tong.Liu01@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Horace <Horace.Chen@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xiao, Jack <Jack.Xiao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
>
> Am 04.11.22 um 09:52 schrieb Tong Liu01:
>> Move TMR region from top of FB to 2MB for FFBM, so we need to reserve
>> TMR region firstly to make sure TMR can be allocated at 2MB
> If I understand it correctly the two methods are mutual exclusive. So I think you can just extend the existing function in the amdgpu TTM code instead of adding a new one.
>
>> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
>> ---
>>    .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 84 ++++++++++++++-----
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 52 ++++++++++++
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  6 ++
>>    drivers/gpu/drm/amd/include/atomfirmware.h    | 56 +++++++++++--
>>    4 files changed, 171 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> index b81b77a9efa6..f577b1d151d9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
>> @@ -106,34 +106,74 @@ int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)
>>    	struct atom_context *ctx = adev->mode_info.atom_context;
>>    	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>>    						vram_usagebyfirmware);
>> -	struct vram_usagebyfirmware_v2_1 *firmware_usage;
>> -	uint32_t start_addr, size;
>> +	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
>> +	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>> +	uint32_t start_addr, size, fw_start_addr, fw_size, drv_addr, drv_size;
>>    	uint16_t data_offset;
>> +	uint8_t frev, crev;
>>    	int usage_bytes = 0;
>>    
>> -	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
>> -		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>> -		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
>> -			  le32_to_cpu(firmware_usage->start_address_in_kb),
>> -			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
>> -			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
>> -
>> -		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
>> -		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
>> -
>> -		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>> -			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>> -			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>> -			/* Firmware request VRAM reservation for SR-IOV */
>> -			adev->mman.fw_vram_usage_start_offset = (start_addr &
>> -				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>> -			adev->mman.fw_vram_usage_size = size << 10;
>> -			/* Use the default scratch size */
>> +	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
>> +		if (frev == 2 && crev == 1) {
>> +			firmware_usage_v2_1 =
>> +				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
>> +			DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
>> +			  le32_to_cpu(firmware_usage_v2_1->start_address_in_kb),
>> +			  le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb),
>> +			  le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb));
>> +
>> +			start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
>> +			size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
>> +
>> +			if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
>> +				(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
>> +				ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
>> +				/* Firmware request VRAM reservation for SR-IOV */
>> +				adev->mman.fw_vram_usage_start_offset = (start_addr &
>> +					(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
>> +				adev->mman.fw_vram_usage_size = size << 10;
>> +				/* Use the default scratch size */
>> +				usage_bytes = 0;
>> +			} else {
>> +				usage_bytes =
>> +					le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb) << 10;
>> +			}
> That should probably be put into separate functions.
>
> Regards,
> Christian.
>
>> +		} else if (frev >= 2 && crev >= 2) {
>> +			firmware_usage_v2_2 =
>> +				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
>> +			DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
>> +			  le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb),
>> +			  le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb),
>> +			  le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb),
>> +			  le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb));
>> +
>> +			if ((uint32_t)((le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb))
>> +				& (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
>> +				fw_start_addr = (le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb))
>> +					& (~ATOM_VRAM_OPERATION_FLAGS_MASK);
>> +				fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
>> +
>> +				/* Firmware request VRAM reservation for SR-IOV */
>> +				adev->mman.fw_vram_usage_start_offset = fw_start_addr << 10;
>> +				adev->mman.fw_vram_usage_size = fw_size << 10;
>> +			}
>> +
>> +			if ((uint32_t)((ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)
>> +				& (le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb))) == 0) {
>> +				drv_addr = (le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb))
>> +					& (~ATOM_VRAM_OPERATION_FLAGS_MASK);
>> +				drv_size = le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
>> +
>> +				/* driver request VRAM reservation for SR-IOV */
>> +				adev->mman.drv_vram_usage_start_offset = drv_addr << 10;
>> +				adev->mman.drv_vram_usage_size = drv_size << 10;
>> +			}
>> +
>>    			usage_bytes = 0;
>> -		} else {
>> -			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
>> +
>>    		}
>>    	}
>> +
>>    	ctx->scratch_size_bytes = 0;
>>    	if (usage_bytes == 0)
>>    		usage_bytes = 20 * 1024;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 585460ab8dfd..099605380b06 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1578,6 +1578,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>>    		NULL, &adev->mman.fw_vram_usage_va);
>>    }
>>    
>> +/*
>> + * Driver Reservation functions
>> + */
>> +/**
>> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * free drv reserved vram if it has been reserved.
>> + */
>> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
>> +{
>> +	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
>> +		NULL, &adev->mman.drv_vram_usage_va);
>> +}
>> +
>>    /**
>>     * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>>     *
>> @@ -1604,6 +1620,32 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>>    					  &adev->mman.fw_vram_usage_va);
>>    }
>>    
>> +/**
>> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from driver
>> + *
>> + * @adev: amdgpu_device pointer
>> + *
>> + * create bo vram reservation from drv.
>> + */
>> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
>> +{
>> +	uint64_t vram_size = adev->gmc.visible_vram_size;
>> +
>> +	adev->mman.drv_vram_usage_va = NULL;
>> +	adev->mman.drv_vram_usage_reserved_bo = NULL;
>> +
>> +	if (adev->mman.drv_vram_usage_size == 0 ||
>> +	    adev->mman.drv_vram_usage_size > vram_size)
>> +		return 0;
>> +
>> +	return amdgpu_bo_create_kernel_at(adev,
>> +					  adev->mman.drv_vram_usage_start_offset,
>> +					  adev->mman.drv_vram_usage_size,
>> +					  AMDGPU_GEM_DOMAIN_VRAM,
>> +					  &adev->mman.drv_vram_usage_reserved_bo,
>> +					  &adev->mman.drv_vram_usage_va);
>> +}
>> +
>>    /*
>>     * Memoy training reservation functions
>>     */
>> @@ -1771,6 +1813,15 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>>    		return r;
>>    	}
>>    
>> +	/*
>> +	 *The reserved vram for driver must be pinned to the specified
>> +	 *place on the VRAM, so reserve it early.
>> +	 */
>> +	r = amdgpu_ttm_drv_reserve_vram_init(adev);
>> +	if (r) {
>> +		return r;
>> +	}
>> +
>>    	/*
>>    	 * only NAVI10 and onwards ASIC support for IP discovery.
>>    	 * If IP discovery enabled, a block of memory should be
>> @@ -1896,6 +1947,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>>    	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>>    					&adev->mman.sdma_access_ptr);
>>    	amdgpu_ttm_fw_reserve_vram_fini(adev);
>> +	amdgpu_ttm_drv_reserve_vram_fini(adev);
>>    
>>    	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>>    
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 9120ae80ef52..c60246f32f98 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -92,6 +92,12 @@ struct amdgpu_mman {
>>    	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>>    	void		*fw_vram_usage_va;
>>    
>> +	/* driver VRAM reservation */
>> +	u64		drv_vram_usage_start_offset;
>> +	u64		drv_vram_usage_size;
>> +	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
>> +	void		*drv_vram_usage_va;
>> +
>>    	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>>    	struct amdgpu_bo	*sdma_access_bo;
>>    	void			*sdma_access_ptr;
>> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
>> index ff855cb21d3f..9f8761407099 100644
>> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
>> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
>> @@ -705,10 +705,47 @@ struct atom_gpio_pin_lut_v2_1
>>    };
>>    
>>    
>> -/*
>> -  ***************************************************************************
>> -    Data Table vram_usagebyfirmware  structure
>> -  ***************************************************************************
>> +/*
>> +  VBIOS/PRE-OS always reserve a FB region at the top of frame buffer. driver should not write access that region.
>> +  driver can allocate their own reservation region as long as it does not overlap firwmare's reservation region.
>> +  if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X )
>> +    in this case, atom data table vram_usagebyfirmwareTable version always <= 2.1
>> +    if( VBIOS/UEFI GOP is posted ) {
>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
>> +      driver can allocate driver reservation region under firmware reservation,
>> +      used_by_driver_in_kb = driver reservation size
>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>> +    Comment1[hchan]: There is only one reservation at the beginning of the FB reserved by Host driver.
>> +    Host driver would overwrite the table with the following
>> +    used_by_firmware_in_kb = total reserved size for pf-vf info exchange and
>> +    set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
>> +    } else {
>> +      there is no VBIOS reservation region
>> +      driver must allocate driver reservation region at top of FB.
>> +      driver set used_by_driver_in_kb = driver reservation size
>> +      driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
>> +      same as Comment1
>> +    }
>> +  } else { //( NV1X and after)
>> +    if( VBIOS/UEFI GOP is posted ) {
>> +      VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
>> +      update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;  ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
>> +    }
>> +    if( vram_usagebyfirmwareTable version <= 2.1 ) {
>> +      driver can allocate driver reservation region under firmware reservation,
>> +      driver set used_by_driver_in_kb = driver reservation size
>> +      driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
>> +      same as Comment1
>> +    } else {
>> +      dirver can allocate it reservation any place as long as it does overlap pre-OS FW reservation area
>> +      driver set used_by_driver_region0_in_kb = driver reservation size
>> +      driver set driver_region0_start_address_in_kb =  driver reservation region start address
>> +      Comment2[hchan]: Host driver can set used_by_firmware_in_kb and start_address_in_kb to zero
>> +      as the reservation for VF as it doesn’t exist.  And Host driver should also
>> +      update atom_firmware_Info table to remove the same VBIOS reservation as well.
>> +    }
>> +  }
>>    */
>>    
>>    struct vram_usagebyfirmware_v2_1
>> @@ -716,9 +753,18 @@ struct vram_usagebyfirmware_v2_1
>>      struct  atom_common_table_header  table_header;
>>      uint32_t  start_address_in_kb;
>>      uint16_t  used_by_firmware_in_kb;
>> -  uint16_t  used_by_driver_in_kb;
>> +  uint16_t  used_by_driver_in_kb;
>>    };
>>    
>> +struct vram_usagebyfirmware_v2_2{
>> +  struct  atom_common_table_header  table_header;
>> +  uint32_t  fw_region_start_address_in_kb;
>> +  uint16_t  used_by_firmware_in_kb;
>> +  uint16_t  reserved;
>> +  uint32_t  driver_region0_start_address_in_kb;
>> +  uint32_t  used_by_driver_region0_in_kb;
>> +  uint32_t  reserved32[7];
>> +};
>>    
>>    /*
>>      ***************************************************************************

