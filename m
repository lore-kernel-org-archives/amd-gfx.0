Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82C6C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 18:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765E410E0F8;
	Tue, 14 Feb 2023 18:40:52 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4553310E260
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 18:40:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3//qwpr331P8Qzo5yvheszrLPSFbIOUoyJhx1J9nt7Sox0TpuFzLR45Gq8qD0ZhrsNNjGatahNpn5L1FeZ5LE3I5wxEfSlySLdu57hf87t0fJDxQ5qBty3qbHcFIlsHnlEAnarjBSe48j4PKBVZh8Kd6jF4ItYg3FeGk6+t3x0Ci7w2PrQpHDkzwr7pQfYUlKEuIccjF4k1RXlLaYYAOoCP1w0bK1vuOoSrngE9ppuaunclkfQxQT3ATQhgJBsd+jTzGuG1peZ3ZO+3qRT1UT0GMXfjKez/asU2OF/PoMp3dDLwtfcGxIo92rxxDIWVbAIESl4u1Ov82UzENwNG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siXyfuF8+9ToAZP1OwcoWNXceL1EeXpyn5rcXi3kaTY=;
 b=HxjZI+OGYY9yVkIBuO8wVIXxllTW2trFxUOCPr33XIJwrn3U1upoavV11CMIJvPrbCIOc5NLSJvYaW9wfrDUMjwhHTX+5zgIhf1OUycwcN/Fqe7pvN68imb8Cu/jzR+RpIKXaOnDLY+Slfb5mQaPGwttP+/G+RUrV0snzgknph6x3558Woi4CFpMnOKBW46jki+jW4IPNrxDrWIEirwQ79ntChKdTdAVz4OrrCrf/wwleJXgyykgW1CHgUpEecNVvREo2bnJiEMXhHSYEt91IZ2NRZE5gFmeg+3qfB+Mrf/PJzRlfR/xH0fXE7KkMXwNcUfRgFsuSg0gpfwKZBNlmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siXyfuF8+9ToAZP1OwcoWNXceL1EeXpyn5rcXi3kaTY=;
 b=My5OUtJDduZeIVtveY94FiEmBHTEuqW0eMHIdFLbIPNmmZNrr7ENfsqVRQGdvZDgs4ZiY8vNeUiw6GrXULhWF9fkBsjuQPyTWNUNzjWFC8wIME6kspDgRgGHjprO4ExvlYqUOZ2gKGFilvTrGTJva//A3h4PgaiNgCJITT6terI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 18:40:48 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::2e4f:4041:28be:ba7a%6]) with mapi id 15.20.6086.026; Tue, 14 Feb 2023
 18:40:48 +0000
Message-ID: <d890c9c9-5cc7-365a-df23-f2c16a85bac9@amd.com>
Date: Tue, 14 Feb 2023 19:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 8/8] drm/amdgpu: start using kernel doorbell bo
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-9-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230214161510.2153-9-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DM6PR12MB4514:EE_
X-MS-Office365-Filtering-Correlation-Id: 941e3afa-4202-4b15-5284-08db0ebafd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UKfAwU26zpqqKgj+V4ttSR45zskqSkSEPtw1GKeUDxbQgclad0DAsH3YqZBBSeF/qPWf+LC8H548cmPJF2r4iql6v8u9Sdfvqca4L01IEGz13Ptudl9EODdk2hnfafTCRrmulZwp5H3yS3lrNBDgmSX7auvBbXbYomdiWni12nPsvDsDWf67t/zZoIRsLRg0okQ3XUgHBA5narlhvuMKvbM/QU/VcZuhRQCQWh8XbqHZFPco0VGRa4DOVAnwErmtnX2cFTkGuv7WZthwEzsP7lePPH5L40iwOWPk2SNkFqW8dlSQk2EjTW2iIp9IkkD3/8HiJanEYYd+WLVcYg0e6cXb4TX26uCgEA1tLizW4WL0/tHWtdBMTnHH3rDyJSJA93l8XxpMZlj2R2fg9shWWVGhoUfidyBohcCbfHQrGwJR8cN9nvKBarPgrM34PhFApkn8wXnJycRyYwVfmbexnP+fjBTS4sjGSvtoKKpdPOZHnECjWtikI2kdqcwjkM1z/wohmk1RFWAaBAgQAXXqTIkDgS/09Vyz0826g3yno1QdM7sgWvGEBrm6hC+TwzqXqXcV81gty1ZiqONKJtOVmVgSGsLjR5aXGOUAH+nCa2C9LYFjXlN10n8BknFI6Sr7fcY40pVOHOIaHmdbdvlhwB2tpzqWwF89tKQ7T0Kvcy3QBFvy/b1T2NKbEJJjcmmzOyGn9I/4CN99UX7YNGXiNr9gGfdrvAqOmdQZDOpLqU8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199018)(6506007)(6666004)(6486002)(83380400001)(6512007)(478600001)(2616005)(31686004)(316002)(4326008)(8676002)(38100700002)(41300700001)(8936002)(66556008)(66476007)(5660300002)(66946007)(2906002)(36756003)(31696002)(186003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkFTWlFYWktxaVEzRDY2SGVhYXNReVpXWDIrM1Q2NExqMmJpYjZYNENZK3JH?=
 =?utf-8?B?REFCWU0wNW9VZTRUN2V1ME9mMkVRTDN0bDFpSGdHOGpjNzVXa3NEUHVpamtu?=
 =?utf-8?B?cFRZL1dxQ25yYU82N1lNdjMrcm9RVXZMUktXT3BJU2oyL254b3dHVmpLMzVu?=
 =?utf-8?B?R3lwTGlpOVJPZCtNYzA1WUt3VFI4am0wQnMrQ2FvSENaWC8vQytuUDlLOUtO?=
 =?utf-8?B?d0YrUnlvZDBQR2ZtcGhLMGY4NUxBTTIySE9LNTlSOEpWQW8zb3k4dFU2RlRy?=
 =?utf-8?B?V1p0UEtpS3BNWXY3SURPcTJuY0pWaXdkUEw4eWNHLysrQmMweTI3TXBXNE55?=
 =?utf-8?B?TG5IdkNiNDJsc2xPRWVpOFlNY2JYY3BndndtK1BFbHRvNGVtRTIwQlJRYmRs?=
 =?utf-8?B?aFc2U1F1ajI0ZGxPQzFkMWRWeDFNcmxqQWd3eGEyT3gxbnc1RDFlUGV3OVdr?=
 =?utf-8?B?cXRwUUZTZ3pGZ3ZQVmhVQUFVK2UyZ3FQNWhjazR2YTNPZWJYNVRkZUFiUkkv?=
 =?utf-8?B?Y0xPc0ZHKzBLZmltdWYrQVh3eTc2bWFCbWFBSkowV1hoMUMrenhxeC9IVE9K?=
 =?utf-8?B?R3p2dDFnTXk5TE5qR09kSXF4OGIvbXhGZ0FFcmJjS04wMzhHYzhIR0RESE13?=
 =?utf-8?B?c3RrS0pYdmRhdDNJTlFJbEF1aDVsOWZYZmQxYk5WSThQZVZKZE9ULzFDZk41?=
 =?utf-8?B?NVgvZWljQzRaRkNRNG9maHc1Sk9jQUhyMTBuSE9kNVNubGdGSUducUEyVC9u?=
 =?utf-8?B?eDVsMUp4WFRmOFczWTMrekNFd1ZwNUsrSDROMHowZ1hFU2h5MkRhZ3JTTUxE?=
 =?utf-8?B?d2NKd2JHSXYrVmhKOXJBblJqakpESi90UDRLMm5wY2xDMWJXclZEOXZocU1p?=
 =?utf-8?B?UGpsdTA0L2VpQk8rejNNSHVjenNIRWp1clQrcFVURnlMTUhPQUg4cWE5WWd5?=
 =?utf-8?B?b1kxbFVBWHJSWGxYSDhCRGp4VGp6U1BvcXlrQWhJOWJnQmVHdEZnQjdxZ3JT?=
 =?utf-8?B?QVVSUDVXTGYxZVlZYnVwVjhkNVoyM2NWVjFTdG44TmgybkViUHhiQ2JmRktB?=
 =?utf-8?B?Yllqc3YxY1F0V3V5TkVVQ2ViMFNzMzZIRHR6eUl5Z2dkNjBCNVVSSklXdHJJ?=
 =?utf-8?B?TUdCcWVLYklrTUFtcHVFU0ZPTEk3OEZtaHRYTERQUjdtYkNhbm9sZm9mNmVJ?=
 =?utf-8?B?VmJPY0YwRDZUVUJtMlpxQUxMS1ZOOGFGSGhTaUdDenljTnVpM09SUCtVd1dU?=
 =?utf-8?B?cGlMdG9lcnBTbmV5UUxNaU9hZ0Z2ck0xMXJuallYYUF3WkYyWURISWR5bmM1?=
 =?utf-8?B?SUsxTVFlTkM0VU0wYXBmM3VkYU9MMlJia25FMk5HYkFXNFhyY3VaWGZVaTdN?=
 =?utf-8?B?azJIVjlKTHJBTysrVkpiTW9oQmlJNU1BYnVkdVJ5cG03aWxXaVZibG50Q2Mz?=
 =?utf-8?B?dVVlbjZoYmE2ZnJ2SWJaaTZieWNuaGZBVDFVTmprU1lNZWVyNVZyVjZhbXB2?=
 =?utf-8?B?ajZyelVXVFNhMGFBemt6Z0dJZkdncWtJNC9xS2JJNVpRbUJ6NmtlcWY5VTZh?=
 =?utf-8?B?dVdTNXpmbXpMbVBYMGh0Nk5JNDFOaTZEM1VWWHVPZXM2Y01kTHFCakhUcGh5?=
 =?utf-8?B?WS9JOVdpTGF0MXllUDZYZjE1dTJBZHFuZU5YUUVScVd5V2ltbThqTTlOT2RG?=
 =?utf-8?B?WVltalhrTm1JMWdIWm1lWUcvNDBtK3dmeUMxaFFBSHVuSTBzNFVHY1JmS0FX?=
 =?utf-8?B?Z0VHd0ZVNWFPS2k3VWZWTUErKzZPaXJmUXhFTzlJMzI3blJRaXo0L0NBWFUz?=
 =?utf-8?B?U1gxTG9WRlNCY01LdGw2ZXFRT3dPV2FUenB2QzdCay9IeDRVMG9pbm1BKzBW?=
 =?utf-8?B?OGpNVUxxbkZmNkwrdURkUVFGZm9JMktXUTNPZUhFa092andSRXM0WWVoQzBs?=
 =?utf-8?B?L05scnRzR0swaHJvVjdvTy8vMTFlWmJiM0htOHJXWnVnVlV0Y0dMc3gzVTl0?=
 =?utf-8?B?a3BpV0d3cUdzdFF4MWZuQ3d4VE4rLzM3ZnRYZWMzaHhETUt5Z0RjUFNmVVhE?=
 =?utf-8?B?QjdzcFVwdjc0VGlpUDFjS3VVSk1FZGlNTzREUlk1NkZQUFBkQ0lvWEdoNFBX?=
 =?utf-8?B?SmpwanFEMnlsVjlnK3VhTlJNcDVhVXJPK09qMHZmb2NPdjk0cE1DTGJNcUZm?=
 =?utf-8?Q?yFtictFWM187HdrWeYMB1o29XHaZQwahsN/BlqwJI5P1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 941e3afa-4202-4b15-5284-08db0ebafd51
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:40:48.1603 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kn4TJpHeTAl57+vASTW3nBU05E66Um51Gwr7T7nRuWQhghowqel38ddsq3bZ5VJZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.02.23 um 17:15 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch does the following:
>
> - Adds new variables like mman.doorbell_bo_size/gpu_addr/cpu_addr.
>    The cpu_addr ptr will be used now for doorbell read/write from
>    doorbell BAR.
> - Adjusts the existing code to use kernel doorbell BO's size and its
>    cpu_address.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Maybe squash this one together with the previous patch.

But see below.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  5 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 33 +++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  1 -
>   3 files changed, 16 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 0493c64e9d0a..87f486f522ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -109,11 +109,10 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   		*aperture_base = adev->doorbell.doorbell_aper_base;
>   		*aperture_size = 0;
>   		*start_offset = 0;
> -	} else if (adev->doorbell.doorbell_aper_size > adev->doorbell.num_doorbells *
> -						sizeof(u32)) {
> +	} else if (adev->doorbell.doorbell_aper_size > adev->mman.doorbell_kernel_bo_size) {
>   		*aperture_base = adev->doorbell.doorbell_aper_base;
>   		*aperture_size = adev->doorbell.doorbell_aper_size;
> -		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
> +		*start_offset = adev->mman.doorbell_kernel_bo_size;
>   	} else {
>   		*aperture_base = 0;
>   		*aperture_size = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 43c1b67c2778..fde199434579 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -596,8 +596,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return 0;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		return readl(adev->mman.doorbell_aper_base_kaddr + index);
> +	if (index < adev->mman.num_kernel_doorbells) {
> +		return readl(adev->mman.doorbell_cpu_addr + index);
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -619,8 +619,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
> +	if (index < adev->mman.num_kernel_doorbells) {
> +		writel(v, adev->mman.doorbell_cpu_addr + index);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> @@ -640,8 +640,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return 0;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
> +	if (index < adev->mman.num_kernel_doorbells) {
> +		return atomic64_read((atomic64_t *)(adev->mman.doorbell_cpu_addr + index));
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
>   		return 0;
> @@ -663,8 +663,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> -		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
> +	if (index < adev->mman.num_kernel_doorbells) {
> +		atomic64_set((atomic64_t *)(adev->mman.doorbell_cpu_addr + index), v);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
>   	}
> @@ -1037,7 +1037,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	if (adev->asic_type < CHIP_BONAIRE) {
>   		adev->doorbell.doorbell_aper_base = 0;
>   		adev->doorbell.doorbell_aper_size = 0;
> -		adev->doorbell.num_doorbells = 0;
> +		adev->mman.num_kernel_doorbells = 0;
>   		adev->mman.doorbell_aper_base_kaddr = NULL;
>   		return 0;
>   	}
> @@ -1052,13 +1052,13 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	adev->doorbell.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
>   
>   	if (adev->enable_mes) {
> -		adev->doorbell.num_doorbells =
> +		adev->mman.num_kernel_doorbells =
>   			adev->doorbell.doorbell_aper_size / sizeof(u32);
>   	} else {
> -		adev->doorbell.num_doorbells =
> +		adev->mman.num_kernel_doorbells =
>   			min_t(u32, adev->doorbell.doorbell_aper_size / sizeof(u32),
>   			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_doorbells == 0)
> +		if (adev->mman.num_kernel_doorbells == 0)
>   			return -EINVAL;
>   
>   		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
> @@ -1068,15 +1068,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   		 * the max num_doorbells should + 1 page (0x400 in dword)
>   		 */
>   		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_doorbells += 0x400;
> +			adev->mman.num_kernel_doorbells += 0x400;
>   	}
>   
> -	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->doorbell.doorbell_aper_base,
> -						      adev->doorbell.num_doorbells *
> -						      sizeof(u32));
> -	if (adev->mman.doorbell_aper_base_kaddr == NULL)
> -		return -ENOMEM;
> -
> +	adev->mman.doorbell_kernel_bo_size = adev->mman.num_kernel_doorbells * sizeof(u32);

I would just keep the kernel_bo_size around and make the 
num_kernel_doorbells a local variable.

Christian.

>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 526b6b4a86dd..7bdff4f926ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -28,7 +28,6 @@ struct amdgpu_doorbell {
>   	/* doorbell mmio */
>   	resource_size_t		doorbell_aper_base;
>   	resource_size_t		doorbell_aper_size;
> -	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
>   };
>   
>   /* Reserved doorbells for amdgpu (including multimedia).

