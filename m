Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427DCC7EE26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 20:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2198F10E47D;
	Fri, 19 May 2023 20:21:12 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE31C10E47D
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 20:21:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX1LzAgvZ6OhUjUdvyZQyApBLQ3IUFrUUmD/4yCjhSZvTcQWdlwfs9MTbIETRBWjFIUn4XaXvo6/Q+lqyVMaHxJ3dovTnBCZfC9UXZMaWT33xfWfpdOYsuEtmax4Z1dkADrVysnXMwjGKUZHz6mOkBaTrLna32POcCc5ZBHsBw9kyP185wKYDfE4v0Q+wkeMknXcljo5E6Fz+DY+tz2umF0VwJMtxr5g4LdJb86tpgzzTVsr7+oGw/GZXJwkcu1m7ju+A+JnIjQ4B0jcBmMnboI8ZOaPBZ9q/TdF5QTFVkwezigdVIZ2PpMPkrJ1sAhVma5+IpzNitRv/TVBt2secQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeIbZUoyu/Ns5F9PoZ8tJX/65+1qwEiQEplBl/Evmps=;
 b=AtnSbWcHQTwcQyRiuJN23pGqhxFWBpGie/WhuZiNjROghuTWtRnXo/E5EpKkYKbUUbF5aOwpeHdSpXZXQpspNVqZqbi0aDceTlaMGd5caKWm9PSKl/V8rmkOus/bmRtlqNECUo+USHMmU3m46x6C9EAocnwGQUG1fW0NMUx2CV+xsYxRab+sBwHZiaIhjRuHl1R5c94TnxI+zuhwMVPc3uQELn9UasROz+rd36Ke7PPmgkVUIA74QeWL2SMBMZ4Arqr9Etvq2oYfxnp98FuWiDB29H1xCUaCNAERKhL37psvdMOx7sFFZPoyk+Dc5MK6xa8zIQKl3JaG8gi0rb8/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QeIbZUoyu/Ns5F9PoZ8tJX/65+1qwEiQEplBl/Evmps=;
 b=1vSHknoPLkENy3ax58erWkiwce7acFIF7Cq2wxjYb/VrXAlv83mXroFPgwRiY7CLjCkUQL9A4hEFd0Z5CPoWkqCuq4b9F4z5/pgOpuvpV0d0Umh3Eot25+2r2pK+CBO4OZQIkob3gPohGXOlQ8nslg3Y9vU3qetlyEfghqRRr7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS0PR12MB8503.namprd12.prod.outlook.com (2603:10b6:8:15a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 20:21:05 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 20:21:05 +0000
Message-ID: <7318902d-0337-b90e-6c98-09796a708c56@amd.com>
Date: Fri, 19 May 2023 16:21:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Align partition memory size to page size
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230519141914.21508-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230519141914.21508-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0168.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS0PR12MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 3202f627-6179-4050-ab0e-08db58a69288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nkeDmeCsgiM9AAxABQmQuEzTF8iLoJ4HQoPuMD9jLlul7nysd+/n2wUZkkvhyYJU3UoNCZtXQvOI250KHLGnTgELBq/W4SECnRSO2WYjxc88787A6Vkfvy8dXumXDYKnWabKfii+WQmeDP/NbnWUMFoTy4z4aG+Jwi/cJHJYHrbZ+fgtBCFYSPGJ8IPDcHDjVUMf/Bk/le0RY15LPdwa/c/fxS8VEuyHjexG+BK8WDUhzqSY4aYw7HUwy9GRfOxlRSshbSpOGrnUbpDxfvj/psGWCngSSN+uF6LMVVC+yFL6wSJKTSlE7Sj78qxv3FK5oG5nZw8L31ft5k1eYBZ0C6WUbOGl1TRsX0AR/IavYQuk9uhzbenNOAt0Gyznz1R8ej+T25xtqoymA/KCRNvLK0Fs0HpwOsJhxY7MUTVb1kV9F9x5PYKuHra8+K+AoSjSLrH7ZwzlCZ/zOqD9TK4x0gBoHfNxwawaakkZeo0ltBRjQtBvmdlJo4qiWnC2jX3rIYKYwPIhzyh5vxUZ56/jpsXgtZzcIsUoHP37h9AjJv0SGdZhQlOZbuA8U1etDBrfC58qQFhpr1/mJcTl9KpOpYOMuzOwmea2FWgyB5QIPaaxZrABlgjf9uk+zLSy2SqhhSTmc3zy5joMpEn44mTXWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199021)(478600001)(31686004)(316002)(5660300002)(44832011)(8936002)(8676002)(41300700001)(2906002)(66476007)(66556008)(66946007)(36756003)(6486002)(6512007)(186003)(36916002)(6506007)(26005)(38100700002)(53546011)(6666004)(2616005)(86362001)(83380400001)(31696002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZmd1lvSFdwMVlaZXVFNTlQWFA5WmZqZEtSU2thUXlTVFZVVy9kOE83MEZx?=
 =?utf-8?B?Y3JLUkZEcVZOUGIyMDVFdHRqSFlqc3p4QXZOMUdKMFBDNWVCMXEwOFd1QkIv?=
 =?utf-8?B?ZzN6Lys4N2NnajhIc0xaVFFKam84TW82bmRxWkdOQ05vS3VNbE9UNXJFZFNQ?=
 =?utf-8?B?eUcvbzJISm9lTkRqY3F2Skc0TUorUnFBQjE3M1JqdXdxSDdRZXZvTHZSQ3hn?=
 =?utf-8?B?emltemJJWE40SjhzTHJKdmUwL2VqSlVvd0JaRU9wL1NTekQ1em1XVzYrcVhy?=
 =?utf-8?B?eFlRYVdELzdKOXlETlZmTGVXOVlHZGFDMEFzRllMUDAwbHdyemFaQjBoSWNz?=
 =?utf-8?B?OU9XOEZtejM5M2JYV0x5ZDcyQVA2MmRZcGtpSG1TNXVrNFlBaVZGSno0RVNB?=
 =?utf-8?B?c2lDaHArWHhKZnhnZEZCdEd4UTNVeC84dk1CUlEyNHFLTzRKNUJtNkZHeS9L?=
 =?utf-8?B?U09SbTlBblNWSVZnWUJIZW5QbVlZYXIwNVJmWXBuQ0gxSWhaS0RnQkM0OUtU?=
 =?utf-8?B?MkwwVFpGMlk5alVVNTJ6dm00bGN1WE9BY09GY05VS1A2NUVIRzA0QnE0enNz?=
 =?utf-8?B?QkVSSDRWTHlFQmdDemg5cGR1YVFIQWk1ditiQ0l2aTdzTDZ3VktFMlpQSUNz?=
 =?utf-8?B?QUN3Y2FaaXlkaUs3UDdIQkxLNVJ2RURuQWZUeXlMZ01KS0dBUjVMOTV3YmFi?=
 =?utf-8?B?bG50TGpuMkpRQzM4cVErTXRLSHVvSU9obmthTnBYaWNTUWI2azN6dG12SEJM?=
 =?utf-8?B?amR3VGNuVkVWd2VsVUNqTHNCV2NnZUJHYm1WZkRhbXBBQ2YrSjE3WGRnZHRG?=
 =?utf-8?B?Q0JzMDFkWUR5Um1IMzgzTmNnOFBnZmJLZ1g1VzAvRlM3eEhPY25CdUNrQVBP?=
 =?utf-8?B?NzdMRkcxR1FBdDJtZVA1Z24rSlNKdFNNc24yaXNRdGh4citJRmwrRGMrSlhV?=
 =?utf-8?B?bHNiaE1MQmtTcFpJTGhQZTNsdXVjVWtXWUlmeVE1cXIwamtFTkMxcnlnZ0hG?=
 =?utf-8?B?NzlyOCs4aFN0WTBXUFZsOGMyUTY4MVFITllwTkdZUHNiWEVPR1ZNak5TNUhQ?=
 =?utf-8?B?R2Q2V0hSR3crTzQzR2QreFIxb2YyRVBTMXU3N0RvSXUrb2MrajJDRzY2dzBF?=
 =?utf-8?B?SjNDTmpma2hNSlZUZk5yRGVHclFKRUFWZDU4NzVpaktLRkl3OW5CMjFIcVh5?=
 =?utf-8?B?Z1FIZ2R1UmoyQmJUQThHZ3V6RWdyLzl1NGt5WnRZRkI1Tm41eDVhUlUwV040?=
 =?utf-8?B?ckwrY3U2cnZvRkhjbE4vU2Jqbk1ram1aQkZSc29yaFdtVzdaMGhxNm45b3h1?=
 =?utf-8?B?djNmRmRrTUVuS2EzWHBva3R0OUxJQndpbGx0WXFoTzhrZnRoVG1nUGpVVTgz?=
 =?utf-8?B?U1FKQ1JRNkp3YlVaV3ZrbVYxRjYxR2FucWhOd1BaQ24vQy9TN3JOM01pVFRz?=
 =?utf-8?B?NFNvT2tDS2dmL3JvODlLelZtTzc5cGZJQ1hISFJBMjI5WXdUdzVYbnNiMTND?=
 =?utf-8?B?SmlZd0JLeHA3R095bXFiZ2lwWjFvZVRPRFR3NVJvbFU2UVA1Z3dKUzNCZWl2?=
 =?utf-8?B?R0R3eThkeFhLR1lSZ2RrTmdzcTVoZ1VzL1FNZWZIT3RCM1gwMk9sY29rL1BF?=
 =?utf-8?B?SytYRy9iS29lNFRjaDE3bkZlNkZuL3BPNWhnYlBsdzd5WVVrbG9qa3Y0L01B?=
 =?utf-8?B?cnQrZGgxRWE1a2x0dDlDV3lWbm9uWkhsdDdteHdOdHV0Qi9hMjg5M1hwTUVP?=
 =?utf-8?B?VTJDb09rYnZ4NnFXR1VvZmtwY2NBZUxHU3FvcWxzRDhLWTBjM3dacFFHdGgv?=
 =?utf-8?B?dThDaFROYTV1cGRRMWltK01NWEUyNWVDeW80eVZUbFdxbEpBdy92emhjcTNl?=
 =?utf-8?B?SW5DUVhKaWplelJ2YU53RkxLaytwMGVnZUJ1cXhIdTB1d1dsRk9uK0h6S2k1?=
 =?utf-8?B?cWZxS0dzdGN5QmhJczNLSldHamN0THcybUdmUU1CQzB4TElKZVhlRThNcHZB?=
 =?utf-8?B?azAvRTRoN05pR29HbTB5RW1seHZWWnAvMWNZZDRIQmZrL1E2U2Zac0tjdVpB?=
 =?utf-8?B?ZE5mQTNZczUxMGtmZDdlMlAzdlc1bk5UL3hyOTE3Q00vL3IyNEpvcnpOVDE5?=
 =?utf-8?Q?FHBZYwxhA1koAiWG8bAV/aXRO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3202f627-6179-4050-ab0e-08db58a69288
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 20:21:05.0762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LbFBrI31LAL8fAxn1MoK7/SLOfwBjcZKDjn8RnPK13B4sCTtPHEw3ba/I49bn2Qa6nQ/XRhCLabJ6ixSGUOJbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8503
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-05-19 10:19, Philip Yang wrote:
> The compute partition memory size calculated from KFD_XCP_MEMORY_SIZE
> may not align to page size if xcp_mgr->num_xcp_per_mem_partition is 6.
>
> Change the KFD_XCP_MEMORY_SIZE macro to return page align size, so KFD
> node memory size reported in sysfs is page align size, to avoid
> application VRAM allocation failure because application may use the size
> directly and Thunk requires the memory allocation size is page size
> align.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 5de92c9ab18f..66f80b9ab0c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -804,7 +804,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
>   	if (adev->gmc.num_mem_partitions && xcp_id >= 0 && mem_id >= 0) {
>   		tmp = adev->gmc.mem_partitions[mem_id].size;
>   		do_div(tmp, adev->xcp_mgr->num_xcp_per_mem_partition);
> -		return tmp;
> +		return ALIGN_DOWN(tmp, PAGE_SIZE);
>   	} else {
>   		return adev->gmc.real_vram_size;
>   	}
