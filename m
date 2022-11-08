Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7803C4332F
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 18:13:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2BC10E4EA;
	Tue,  8 Nov 2022 18:13:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CBC10E4E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 18:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcngwZ8Fbwjcje0dy3HS33vUZ4NDgAunquESXd5iRz2NsVc050eemks6APd8++Z3cOVDCPlJiYjBUuEEFzUzoUhdFuFvH//fx890scN0Wn/gebxbyh+oWnJJ9CvScTZ0nlKuGWocWukQtVHje7/qECW2cpzH0fS/8jdDJPK6qUKxHqmAiVbUfsYd40QV6gzOEfcac0v1HaP3/8wTYOecExREUSguo3ex+jRzlRBUu8LdxojFsNXNPfe+kJhq2dCFLm0polIIaGJZk4oFNJtbSd1xX0po2wlAHpxcyQ8fKjgN5fe2sZp5W+K4XgmH77fK4+zvpmKWY9NFk47rAVCjaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUnyRo0VTx70sZEgWOPXMPC1ezQ52WuJX5jm6DhpDlQ=;
 b=XXVwsdeY/7tmIw0RByyT5I/TAERdKKH2WS0a4SzbvWnWdfP7ydzaqtA0Y++hjsxbx2LGIZIW4VuRkl3NtyxXqB+vLmtdPvtC9zWWRfO1LpFp6450gVHENawEf6laFwLRT3kMHJSiQMbz/S+iGojkha6UPI9rjz23JdncJQtP7n7kAOtD2oiQJBaO3H72qmcxstR/b+yG8SD9vHsvx5YHVROo7EJEKlf+NB97lcSZcjIPuFZqp86Hq4rPHDBv1dZiK8vLu3iUhZijBSGWqf9kVMYG7nvHtxb0ECdgJ8YwDYu+T/av89CI8i4VSTavlqMpFdDpbkInuzDEQDW4n1t+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUnyRo0VTx70sZEgWOPXMPC1ezQ52WuJX5jm6DhpDlQ=;
 b=ExzzPk9J3EyQzJtVWiWvg8S+D/+xZwDI5eP1WLENl50aui97+HeA7e3PrQ4iny8lSQG0rzQcEf+w/eJj9i9CoGNVNxgpqC1C3LKSj3CmzPNwQu7dwxi036XbjuGJ13c2V3422VhwhgzhS9Ab5EgyiZgx1c6BJbbrALQht6eutnY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 18:13:36 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 18:13:35 +0000
Message-ID: <d4dc37d6-fc35-fbb9-6f56-7fbd49a13cfb@amd.com>
Date: Tue, 8 Nov 2022 19:13:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: FW: [PATCH] drm/amdgpu: add vram reservation logic based on
 vram_usagebyfirmware_v2_2
Content-Language: en-US
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Chen, Horace" <Horace.Chen@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Xiao, Jack" <Jack.Xiao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Sohail, Rashid" <Rashid.Sohail@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20221108172851.48141-1-bokun.zhang@amd.com>
 <MN2PR12MB29575895289DD727583B13A4F43F9@MN2PR12MB2957.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <MN2PR12MB29575895289DD727583B13A4F43F9@MN2PR12MB2957.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::18) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bc444f5-41ec-4e07-4b5e-08dac1b4f3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7GzyaitnkGHOnrBOVjNdUTXWnB7/skJ+smGrsNEp6lks7tiTW62HbByhtr68Kxbh8WIMNCX9YAadOuhuiPXf0ctFGvIPutVEbVOXxLGhiyiT3DtR1mz6eKfhdBGl8i14N81njDNPv4hDoaiLxQuwWK1UvKO3uMyOirtTI2Dr5Vpoti3o/Mw2oBH/b5Q677d2J6VMFozdcJUAC7YRHySiSeW8wFLx895Kj/lsfMjm11Q7TnJx4SaGX47isIJsThN89BydWbGmxmzDeuUJBPE/nYrNJcZqj+oqprEz7gWSbd+F/x6rgQral0hWifRj2ssMVg4H+YeplKBqggyptiHZsuFXMeRIj6Sr3sV4qPrDzPJ2mTM7JUi3sQ5T6pnquszokrWBh+1jtoxTBSt5aphxrmmtD3/9EB64qThneoSvXgWWnE57rq8Cp3efBUkfRYM7MzDv0YNsmH+7SjVknPWF6dE+96X5111Zc1A9D23fznS1T9ogyuugtleAL7vEKlINqJtrjEz74F7cRqFnDHBhSG0Dwj5r3+P+TJbE7eTr+pYFMLhJqesSbgT+x0vHEpLpM+lVaskwHB7nklob35GO2MldwBAbRAwP6aQJcCwaBIF6UvdgMx5QY3B4a4mVXIPt04s9whla/INxe7bZM5Yefa73/cukGN5XPaLfA+L0JMSiVgmxWXqbOgN2plUhGxbORMtvq3bNyTgQk01xc1s/n+ZIYR9912Lh9jpmHd6zUTHce7DJzewq9QwM4w6+zAxqJj5rzPraLbyNbFk7yt6knlwkiWYPJmU4IzK7VeekoxhKUYx29iPyuB3Afc3iIPT9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(451199015)(186003)(86362001)(31696002)(38100700002)(83380400001)(921005)(110136005)(30864003)(2906002)(5660300002)(8936002)(41300700001)(478600001)(6486002)(6666004)(316002)(8676002)(53546011)(4326008)(6512007)(6506007)(2616005)(6636002)(66946007)(66556008)(66476007)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eURFbjVLNTZvcTNobUlscUFXQWhkRFF0dXM0TDNDaTRMTm9ubHNMbnZKQllW?=
 =?utf-8?B?WnQ5N2RPUUpJNmF0bmRoSmJDenNhK1ozQVN6aUl5MDBGT0RMeENTQ08vVXZm?=
 =?utf-8?B?WS8rOGxsR2hnSnVLRnR5MzQ1RE9EVmJ3UmVScEZmMStRKzlmNlRrMzZXaXRn?=
 =?utf-8?B?QnhCb1FUaEc5NzRnQ3VRNklNN3lQbGFMdi8xZUs4Uzh6VWxkc2Ewam1vWUVv?=
 =?utf-8?B?NVl4UlhUSldpZXJPSno0UnVMNnJiSzN5M2NlaythR0FpNklwQnBBdzVyMyt0?=
 =?utf-8?B?STZ5VWU4U0ZnUjB6azZXWWh6ZU9CQ2hqSDByKzRxNldDZzlCS3dWUGJsVXBo?=
 =?utf-8?B?SUs0ZlkydmlhSGVybDlvZnFkaDBtWHJKdVZWWXdxajEybW5yUWorakI1Um5Y?=
 =?utf-8?B?QlBWeS9lV2NGanBPSys2ODRDdFgrY2NDUHIyUk83dWFuYmVKZUxNUkU4c0Ny?=
 =?utf-8?B?a0tFTGlGc2NyRGd6SWh4Zlo4cnc4UTRIaHZFWHcwLzRZMVJkeWxFMjJQclFp?=
 =?utf-8?B?NzFnTk1ONVRhYlZPODM1N2l1RVJlQk9VSzlJYm5wQkF4cXpld2RlL2gyWmhE?=
 =?utf-8?B?M0FPRkZuRXNXV3pSNk90cG1VRnQwTXRRVUVCL3BYb1pKWmZRZWNubTIycTJo?=
 =?utf-8?B?OTJiU1dsOWhpNDRXQXdJOE51TlQwTmNoT3hxcjUveEliVTNOT0dMM1dnWmU1?=
 =?utf-8?B?by90Y3oyRmM4N1hpMThqbGlvTzMvMzlRNE9JRmJPdHVBcDlyRG1qbWdhYVVD?=
 =?utf-8?B?YU1oWmxGMzhIeEFoOHZYNG0vQXcyeEorbnk2a3hVbDV6RE1ScE1sTjJmaXN5?=
 =?utf-8?B?elV2Z2hPNmNaOU8rbHBVdVVEc1Jla0tVMlVVL1VDMy8rRG1DUjQvS1Z3bmp6?=
 =?utf-8?B?L0lKT3FTTlVHSE80WjN6M0hZSmJGT3hCM21UcG1yOGhBV2ZJblZNdk5XNVo3?=
 =?utf-8?B?dlJBdGpJT2ViUGJUWVJyWEJndHJnUGlvRGxlRWREWkMwOWVremdwRUFNem5v?=
 =?utf-8?B?VEtEazh1ZXp2WGZWV1RnMUtrOVkwZDk3aFNicmRrckVicFZrNlIvRTBDVE9a?=
 =?utf-8?B?RUNMci9WZ0xRd3hIbUxUNTRPaUpBZG5sam15YksyYS95SmpFVlRhMkpQa2RI?=
 =?utf-8?B?UERRMS9EbFdpOEd2ODlzU2FIelRybi9YSU90N3MvUURpTmx6RjJJTzBUZ0dh?=
 =?utf-8?B?L2FXQUExLzFtcTFPYjhNZDJYSE9UQVJ6UFdCTGlLTDF1MGVpbTJNd3pMTkU4?=
 =?utf-8?B?Szh2cXVqL1Ixak5LSW05WTg1R3Nyb3VjS08reXpHZnNFQUlGUVYxRHNkYXZm?=
 =?utf-8?B?TGhtQ0NaUzluazE5Z2V3YmdNeWk3elFvTmJlNDQ2WnhWK1piQlRMek9XbEk5?=
 =?utf-8?B?d2N1RE1NQmVPRGNBR0orTlQ0b0VMZWxKSVdrMHcrOExCY1JxQlpNb3dTa1g4?=
 =?utf-8?B?bmptNXR4Y2NUbGRwejJaY0t6cENRR1V6WGRzd2wwYklLSitmWEMrSmhDY2hH?=
 =?utf-8?B?dW4ydGI2bCtraEp4eUpMNThJUVBCcGx6K013bEc0MEE2R1orWEVMcXVYa3Rx?=
 =?utf-8?B?K0l6eUxWNjN6dVBHVmtLaG5EQ2x2SHNPRUNJTWZ0TUR5dWZ0WlVlU0xxdzBI?=
 =?utf-8?B?UlJQbEYvNGc4Q1doQ2R4Y1RENkV0bENBZzJLVGo3aUxMaTNyT1d1ZUVqUVRW?=
 =?utf-8?B?alIvTTZUZDJURzE4SXFkWllPVklKdHhoRGRKSmNOSnlqR0lKZW9OQTlZdnNO?=
 =?utf-8?B?am5xUmFHVk5WajJaNnpCK1pWTC9JamNYMUFMc0tKUW5mQ0tuaFUvTjRLSWt2?=
 =?utf-8?B?YnNyNzBkTjh3djVRSWdVZkxYTWloaFZMeVkxTC9EUVVham5DN1dOcXpOdWxN?=
 =?utf-8?B?VmViQ2tYMWV0S1JzOEJrN3p4blY0VmdUR0hQTVNLK1R3NUR5RVlnSWlOYld2?=
 =?utf-8?B?azZkUldDd2cwb1g3czRQYzdUMmxuSFhTSHI1TFl4NFV6cGMwbnYwMjZ1bFFv?=
 =?utf-8?B?Z3g0NnhRZE93MzdVdWJFL3VHVUtJUjM3Uzg1NnlSamZ4eU45WUdsSFlRa0xh?=
 =?utf-8?B?bnVTUnBRNmwvV0o0MDNXMFpPUE9kRmErQjRpV2RoWklvRlhFVno1M0pzeW1N?=
 =?utf-8?B?M01Fb2lUem1OVG9zZ2VoL2RtMHdGc1VsY2xpQlF2bzNJeWdPRkxSY3dpNHZh?=
 =?utf-8?Q?z23VHM7B/EI3aTP6pQWMCe1kmp8Kwv1C9qKePhHsEpJW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bc444f5-41ec-4e07-4b5e-08dac1b4f3f2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 18:13:35.8925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGdrNcr6odk0HfdP1cRMs15wcBaj+XJHpppnm9X74HsjsuPDdsKfc9e0gNnE4Fxj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.11.22 um 18:30 schrieb Zhang, Bokun:
> [AMD Official Use Only - General]
>
> Please find below patch after passing code style check
> Thanks!

I'm not sure which coding style check you use, but when I use 
checkpatch.pl it points out tons of problems with this patch.

>
> -----Original Message-----
> From: Bokun Zhang <bokun.zhang@amd.com>
> Sent: Tuesday, November 8, 2022 12:29 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>; Liu01, Tong (Esther) <Tong.Liu01@amd.com>
> Subject: [PATCH] drm/amdgpu: add vram reservation logic based on vram_usagebyfirmware_v2_2
>
> - Move TMR region from top of FB to 2MB for FFBM, so we need to
>    reserve TMR region firstly to make sure TMR can be allocated at 2MB
>
> Signed-off-by: Tong Liu01 <Tong.Liu01@amd.com>
> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  | 106 ++++++++++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  50 +++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   5 +
>   drivers/gpu/drm/amd/include/atomfirmware.h    |  68 +++++++++--
>   4 files changed, 198 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index b81b77a9efa6..032dc2678d7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -101,39 +101,99 @@ void amdgpu_atomfirmware_scratch_regs_init(struct amdgpu_device *adev)
>   	}
>   }
>   
> +static int amdgpu_atomfirmware_allocate_fb_v2_1(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1,
> +		int *usage_bytes)
> +{
> +	uint32_t start_addr, fw_size, drv_size;
> +
> +	start_addr = le32_to_cpu(firmware_usage_v2_1->start_address_in_kb);
> +	fw_size = le16_to_cpu(firmware_usage_v2_1->used_by_firmware_in_kb);
> +	drv_size = le16_to_cpu(firmware_usage_v2_1->used_by_driver_in_kb);
> +
> +	DRM_DEBUG("atom firmware v2_1 requested %08x %dkb fw %dkb drv\n",
> +		start_addr,
> +		fw_size,
> +		drv_size);
> +
> +	if ((start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> +		(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> +		ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {

This still doesn't looks like correct coding style. Please align the 
second line under the ( of the first line.

> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = fw_size << 10;
> +		/* Use the default scratch size */
> +		*usage_bytes = 0;
> +	} else {
> +		*usage_bytes = drv_size << 10;
> +	}
> +	return 0;
> +}
> +
> +static int amdgpu_atomfirmware_allocate_fb_v2_2(struct amdgpu_device *adev,
> +		struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2,
> +		int *usage_bytes)

Same here, the parameters are not correctly indented.

> +{
> +	uint32_t fw_start_addr, fw_size, drv_start_addr, drv_size;
> +
> +	fw_start_addr = le32_to_cpu(firmware_usage_v2_2->fw_region_start_address_in_kb);
> +	fw_size = le16_to_cpu(firmware_usage_v2_2->used_by_firmware_in_kb);
> +
> +	drv_start_addr = le32_to_cpu(firmware_usage_v2_2->driver_region0_start_address_in_kb);
> +	drv_size =
> +le32_to_cpu(firmware_usage_v2_2->used_by_driver_region0_in_kb);
> +
> +	DRM_DEBUG("atom requested fw start at %08x %dkb and drv start at %08x %dkb\n",
> +		fw_start_addr,
> +		fw_size,
> +		drv_start_addr,
> +		drv_size);
> +
> +	if ((fw_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* Firmware request VRAM reservation for SR-IOV */
> +		adev->mman.fw_vram_usage_start_offset = (fw_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.fw_vram_usage_size = fw_size << 10;
> +	}
> +
> +	if ((drv_start_addr & (ATOM_VRAM_BLOCK_NEEDS_NO_RESERVATION << 30)) == 0) {
> +		/* driver request VRAM reservation for SR-IOV */
> +		adev->mman.drv_vram_usage_start_offset = (drv_start_addr &
> +			(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> +		adev->mman.drv_vram_usage_size = drv_size << 10;
> +	}
> +
> +	*usage_bytes = 0;
> +	return 0;
> +}
> +
>   int amdgpu_atomfirmware_allocate_fb_scratch(struct amdgpu_device *adev)  {
>   	struct atom_context *ctx = adev->mode_info.atom_context;
>   	int index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
>   						vram_usagebyfirmware);
> -	struct vram_usagebyfirmware_v2_1 *firmware_usage;
> -	uint32_t start_addr, size;
> +	struct vram_usagebyfirmware_v2_1 *firmware_usage_v2_1;
> +	struct vram_usagebyfirmware_v2_2 *firmware_usage_v2_2;
>   	uint16_t data_offset;
> +	uint8_t frev, crev;
>   	int usage_bytes = 0;
>   
> -	if (amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
> -		firmware_usage = (struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> -		DRM_DEBUG("atom firmware requested %08x %dkb fw %dkb drv\n",
> -			  le32_to_cpu(firmware_usage->start_address_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_firmware_in_kb),
> -			  le16_to_cpu(firmware_usage->used_by_driver_in_kb));
> -
> -		start_addr = le32_to_cpu(firmware_usage->start_address_in_kb);
> -		size = le16_to_cpu(firmware_usage->used_by_firmware_in_kb);
> -
> -		if ((uint32_t)(start_addr & ATOM_VRAM_OPERATION_FLAGS_MASK) ==
> -			(uint32_t)(ATOM_VRAM_BLOCK_SRIOV_MSG_SHARE_RESERVATION <<
> -			ATOM_VRAM_OPERATION_FLAGS_SHIFT)) {
> -			/* Firmware request VRAM reservation for SR-IOV */
> -			adev->mman.fw_vram_usage_start_offset = (start_addr &
> -				(~ATOM_VRAM_OPERATION_FLAGS_MASK)) << 10;
> -			adev->mman.fw_vram_usage_size = size << 10;
> -			/* Use the default scratch size */
> -			usage_bytes = 0;
> -		} else {
> -			usage_bytes = le16_to_cpu(firmware_usage->used_by_driver_in_kb) << 10;
> +	if (amdgpu_atom_parse_data_header(ctx, index, NULL, &frev, &crev, &data_offset)) {
> +		if (frev == 2 && crev == 1) {
> +			firmware_usage_v2_1 =
> +				(struct vram_usagebyfirmware_v2_1 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_1(adev,
> +					firmware_usage_v2_1,
> +					&usage_bytes);
> +		} else if (frev >= 2 && crev >= 2) {
> +			firmware_usage_v2_2 =
> +				(struct vram_usagebyfirmware_v2_2 *)(ctx->bios + data_offset);
> +			amdgpu_atomfirmware_allocate_fb_v2_2(adev,
> +					firmware_usage_v2_2,
> +					&usage_bytes);
>   		}
>   	}
> +
>   	ctx->scratch_size_bytes = 0;
>   	if (usage_bytes == 0)
>   		usage_bytes = 20 * 1024;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 76a8ebfc9e71..06673a756231 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1579,6 +1579,22 @@ static void amdgpu_ttm_fw_reserve_vram_fini(struct amdgpu_device *adev)
>   		NULL, &adev->mman.fw_vram_usage_va);
>   }
>   
> +/*
> + * Driver Reservation functions
> + */
> +/**
> + * amdgpu_ttm_drv_reserve_vram_fini - free drv reserved vram
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * free drv reserved vram if it has been reserved.
> + */

Please no kernel doc for static functions, except when you need to 
explain what they do.

> +static void amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device
> +*adev) {

The variable name should always be on the same line as the type.

When this becomes to long you can write it like this:

static void
amdgpu_ttm_drv_reserve_vram_fini(struct amdgpu_device *adev)
{

And BTW the { should always be on a new line.

Regards,
Christian.


> +	amdgpu_bo_free_kernel(&adev->mman.drv_vram_usage_reserved_bo,
> +		NULL, NULL);
> +}
> +
>   /**
>    * amdgpu_ttm_fw_reserve_vram_init - create bo vram reservation from fw
>    *
> @@ -1605,6 +1621,31 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
>   					  &adev->mman.fw_vram_usage_va);
>   }
>   
> +/**
> + * amdgpu_ttm_drv_reserve_vram_init - create bo vram reservation from
> +driver
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * create bo vram reservation from drv.
> + */
> +static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
> +{
> +	uint64_t vram_size = adev->gmc.visible_vram_size;
> +
> +	adev->mman.drv_vram_usage_reserved_bo = NULL;
> +
> +	if (adev->mman.drv_vram_usage_size == 0 ||
> +	    adev->mman.drv_vram_usage_size > vram_size)
> +		return 0;
> +
> +	return amdgpu_bo_create_kernel_at(adev,
> +					  adev->mman.drv_vram_usage_start_offset,
> +					  adev->mman.drv_vram_usage_size,
> +					  AMDGPU_GEM_DOMAIN_VRAM,
> +					  &adev->mman.drv_vram_usage_reserved_bo,
> +					  NULL);
> +}
> +
>   /*
>    * Memoy training reservation functions
>    */
> @@ -1772,6 +1813,14 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> +	/*
> +	 *The reserved vram for driver must be pinned to the specified
> +	 *place on the VRAM, so reserve it early.
> +	 */
> +	r = amdgpu_ttm_drv_reserve_vram_init(adev);
> +	if (r)
> +		return r;
> +
>   	/*
>   	 * only NAVI10 and onwards ASIC support for IP discovery.
>   	 * If IP discovery enabled, a block of memory should be @@ -1897,6 +1946,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>   	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>   					&adev->mman.sdma_access_ptr);
>   	amdgpu_ttm_fw_reserve_vram_fini(adev);
> +	amdgpu_ttm_drv_reserve_vram_fini(adev);
>   
>   	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6a70818039dd..7c38843f411e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -84,6 +84,11 @@ struct amdgpu_mman {
>   	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>   	void		*fw_vram_usage_va;
>   
> +	/* driver VRAM reservation */
> +	u64		drv_vram_usage_start_offset;
> +	u64		drv_vram_usage_size;
> +	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
> +
>   	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
>   	struct amdgpu_bo	*sdma_access_bo;
>   	void			*sdma_access_ptr;
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index ff855cb21d3f..68a86b14dff4 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -705,20 +705,72 @@ struct atom_gpio_pin_lut_v2_1  };
>   
>   
> -/*
> -  ***************************************************************************
> -    Data Table vram_usagebyfirmware  structure
> -  ***************************************************************************
> +/*
> + * VBIOS/PRE-OS always reserve a FB region at the top of frame buffer.
> + * driver should not write access that region.
> + * driver can allocate their own reservation region as long as it does
> +not overlap firwmare's
> + * reservation region.
> + * if( atom data table firmwareInfoTable version < 3.3) { //( pre-NV1X
> +)
> + * in this case, atom data table vram_usagebyfirmwareTable version
> +always <= 2.1
> + * if( VBIOS/UEFI GOP is posted ) {
> + *    VBIOS/UEFIGOP update used_by_firmware_in_kb = total reserved size by VBIOS
> + *    update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;
> + *    Where: ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10)
> + *    driver can allocate driver reservation region under firmware reservation,
> + *    used_by_driver_in_kb = driver reservation size
> + *    driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> + *  Comment1[hchan]:
> + *    There is only one reservation at the beginning of the FB reserved by Host driver.
> + *  Host driver would overwrite the table with the following
> + *  used_by_firmware_in_kb = total reserved size for pf-vf info
> +exchange and
> + *  set SRIOV_MSG_SHARE_RESERVATION mask start_address_in_kb = 0
> + *  } else {
> + *    there is no VBIOS reservation region
> + *    driver must allocate driver reservation region at top of FB.
> + *    driver set used_by_driver_in_kb = driver reservation size
> + *    driver reservation start address =  (total_mem_size_in_kb - used_by_driver_in_kb)
> + *    same as Comment1
> + *  }
> + * } else { //( NV1X and after)
> + * if( VBIOS/UEFI GOP is posted ) {
> + *    VBIOS/UEFIGOP update used_by_firmware_in_kb = atom_firmware_Info_v3_3.fw_reserved_size_in_kb;
> + *    update start_address_in_kb = total_mem_size_in_kb - used_by_firmware_in_kb;
> + *    Where: ( total_mem_size_in_kb = reg(CONFIG_MEMSIZE)<<10  )
> + *  }
> + *  if( vram_usagebyfirmwareTable version <= 2.1 ) {
> + *    driver can allocate driver reservation region under firmware reservation,
> + *    driver set used_by_driver_in_kb = driver reservation size
> + *    driver reservation start address =  (start_address_in_kb - used_by_driver_in_kb)
> + *    same as Comment1
> + *  } else {
> + *    dirver can allocate it reservation any place as long as
> + *    it does overlap pre-OS FW reservation area
> + *    driver set used_by_driver_region0_in_kb = driver reservation size
> + *    driver set driver_region0_start_address_in_kb =  driver reservation region start address
> + *  Comment2[hchan]: Host driver can set used_by_firmware_in_kb and
> +start_address_in_kb to zero
> + *  as the reservation for VF as it doesn’t exist.  And Host driver
> +should also
> + *  update atom_firmware_Info table to remove the same VBIOS reservation as well.
> + *  }
> + * }
>   */
>   
>   struct vram_usagebyfirmware_v2_1
>   {
> -  struct  atom_common_table_header  table_header;
> -  uint32_t  start_address_in_kb;
> -  uint16_t  used_by_firmware_in_kb;
> -  uint16_t  used_by_driver_in_kb;
> +	struct  atom_common_table_header  table_header;
> +	uint32_t  start_address_in_kb;
> +	uint16_t  used_by_firmware_in_kb;
> +	uint16_t  used_by_driver_in_kb;
>   };
>   
> +struct vram_usagebyfirmware_v2_2 {
> +	struct  atom_common_table_header  table_header;
> +	uint32_t  fw_region_start_address_in_kb;
> +	uint16_t  used_by_firmware_in_kb;
> +	uint16_t  reserved;
> +	uint32_t  driver_region0_start_address_in_kb;
> +	uint32_t  used_by_driver_region0_in_kb;
> +	uint32_t  reserved32[7];
> +};
>   
>   /*
>     ***************************************************************************
> --
> 2.25.1

