Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FA3C6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 11:04:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DDD810E1EF;
	Thu, 30 Mar 2023 11:04:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::608])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CE3E10E1EF
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:04:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2UaLj/u5E7dYE6tXSI9fv5RUcgG69xvRwzXt1ODNvu7ZbRbb0t0z1KpWncoEmiOcmq3ebKJ6JLgrCBk6QAidgo91XkguDArvLjW6sJrhaZU9G2R1A+qMK2Noy0C9fiE0ECkQJiY9t4tCq5MGyszXjMd1le+ZwtYoPo7KiyuOKS5b+nU+xKy+0Brq8uKDWlNnXfzt4q37InZlOIa8Iaaiy4Z6ApTMOkc/6ez9NcS74423+yjOLYmOGeVLTCNNGrB4GnNJjCKltt4eU3JaReRAbszGLNPh8VZCW4NdXuhPl7pyRieBi6TFmJ6ERUKt3dx2N6XSDYJuceK0lNG0v1d2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmHiFJMuxz1joodDhSHNYqx6No4LMOGN1ZyBjHCnTOQ=;
 b=oeoZR0tLPwFkMlXF4L/HvRvz0KtjJLFK/QthB/ylb0x+5j6k0Us9YJSaysjm6hwICQMVldXix+yN0qOnbUmZkT3Wtip8cok/bqhY3Gr8/3DnwVQNWC5hjwN1KOO6t2vIXfsIy0w+HXxO6FwMo5VJLmZeUFg48XWe07Xr/7Rhai/DePk3WVnRuUC9BrYSTT5gdvM4X8SNWYIy/Uh489iL8scts+JMRLPL2XQu1OT5jrw90F5p+WmYKGiBEQRqg6Tbkm9eGX8b1LziwDTwpKiRszqaR5XMc1bmGNgB0ybMSh/j/MHzpbUwLdZiN2GnfI575MVL/1hBoJfFK9NpKd7Ffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmHiFJMuxz1joodDhSHNYqx6No4LMOGN1ZyBjHCnTOQ=;
 b=H2AYRZiPvgobjpO9/0epYPK6ld1vcsOCKgwKR+LcO9RFk6Py12WBN3MijGd3joY43zhQadLeEmds4a+yxVzRd5XkUdM4RvESkP4vI6kYGrXLRaeMFG8DFn475E511Cxl+1uKGaCqfoo8Hf7r7/HaqP1YgWByssrQk32se16Bxv8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 11:04:35 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::4624:dc39:943e:6ae%5]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 11:04:35 +0000
Message-ID: <930561d6-ad58-8ba5-63c8-0c6ef1f6b427@amd.com>
Date: Thu, 30 Mar 2023 13:04:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 01/16] drm/amdgpu: rename num_doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-2-shashank.sharma@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230329154753.1261-2-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|DS7PR12MB8249:EE_
X-MS-Office365-Filtering-Correlation-Id: 791ed239-db29-4f34-3976-08db310e8c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqxLbNjE3uN9YMT3+WGflQk3mUbWpfBJr3NCLdsCa2EKhQf3jUA3Mhe8VelUFtChVE8sMMDffr19yuVGn4zaTaAFkCZt6GNDkenI1bHSYFvwTlLh7Z4qJXhGGIOkCM1Xj3BV9bkvmn+pucqM1w4mpcaHihV9Fd0B3hSxmGTqGuxMWZfmAkHRuH8zwn5wC/ehBoiOPXrMplbsauZyiWBXk1malm/FBKhlc5gsGEJkTiUyt6DCed+JoUyZiDMy0x92Cs+YFk4gFIhSkJltXxxXAs3k3a3cLqDc+2TR+xE3nW0ckpuciX4GRvw3XXZZwyhNlco7RMFnhYAhgKd1eQob6vxKYLnqW5aAbYDH08Mvtaq6t+QryhEwjlfP2TO3xF9a566QNiiKUDYpLxKvmVdWjIWiLLzxDjEUiRAvxCCcqV2Q21WNjGC1Yd7IvAzQLvAoZMEXLjFMt5ajOcleKziHCOfy+nLpgboV7I6XtQrg/Dh7INFI0K3d0WqTU73q09E0PCM6RAuGdCQtCVK0hRH1CzgzCaQR57sHNnUKhmw3wKS8heTF9UTeeejo61yiZ6aM6nxGclARiDWZ6gyZ46Gz68Mea1TRR36y5npYpruNgVP45LzYo0XoQPcPZjadLT7dGHCMKsP/ubd7FoT4sbXXow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39860400002)(396003)(451199021)(66476007)(8936002)(66946007)(66556008)(8676002)(41300700001)(4326008)(2906002)(38100700002)(5660300002)(6506007)(6512007)(26005)(6666004)(6486002)(2616005)(83380400001)(36756003)(66574015)(31686004)(186003)(316002)(31696002)(86362001)(54906003)(478600001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3ZuUnpNSFNaMk5PMTR0NFN5aDF4Rm9NS1QyTGd6QlJRTE8rdkxDSDN4WWRO?=
 =?utf-8?B?VHA5dmVkZ1FLc1VEV3lFc0wzeTdsTTJ1cWNVckdqbk44Ly9kaEIwL2NkSmNn?=
 =?utf-8?B?U0VOZFhuRC9lMjV1TjU5aU0yK2djWW5Sci96S0JRbk11S0tQTERhUjJpa2xm?=
 =?utf-8?B?RHJoRysvQnl2MUIzSmlVUnBkRzBBTHBwQmI5bEk2VEVZUFBuWnUxemdKVFU5?=
 =?utf-8?B?YlpYTS9ROFQzKzF3b0hpSkl3TUtYeExORHE4Y2tiZVdIMTJQUXBXejJkMjFh?=
 =?utf-8?B?RVA0Y2VMb05nWXBYSGtpVGpud2ZCTmNmVjFvRko3N0JjdGhRU0VCYVZud0ox?=
 =?utf-8?B?eDgzNUhYYkIzcngyWWJaYkVlSkZCdE5lTnhWbWN3U1hzQndxTHNUckdtZ09o?=
 =?utf-8?B?eTEzNjZZOTBTVCtDazFDTDU3cUN4N0JTMCt4M0QzMUo0cWx1MkFHdFNaeEIr?=
 =?utf-8?B?c3poN3lXZzhFVzV1aThFR2ZSZFBLMnZDWWtOdXEySXdHZTQ1WFo0dzk1cWhF?=
 =?utf-8?B?TS9URWpCb1F6Q213YkladGswUlcrblQ0ZmZTRW5iM3R4QzFSMzhXS1g1cThx?=
 =?utf-8?B?U0lUeVc0WDR5SVZQL0hjR3VuQ242cVZGYUo0ZWRzYmVUZXRKNjMxckQwRnN3?=
 =?utf-8?B?R1l5eFg1UXZ0cE91UUx3NmY0KzlkVHR1S3pIWDVoRU5VVGlhMDFieG1OaTVU?=
 =?utf-8?B?NExRWTRhcnZoUHVFb2l0Njl6RGlORVNZYVFrcXlnR2E5bXBzUndXUGl3V2c1?=
 =?utf-8?B?VW53dHdUb1hZZXFFNldzT0xHQ0xyVkp0dFAvSk56eVl4ZENHMDN5aVNuT1ZB?=
 =?utf-8?B?aGNWblh0K2h2MVZFZFBBYnEzR1RVc0R5VTJST1V5Z2pGK3BsUFNkMHhZM2ts?=
 =?utf-8?B?TGZlakRZSFhjOU4rdEEveU9BMzhKSStGck5ZK1d5dGkwOUNUZ2c4dXFEcXZm?=
 =?utf-8?B?MGhOYXA0OHBFaVdSSE12andJSlExZ0RUR0FWb2RKS1ZwZzlVaVpPcjVvTE9w?=
 =?utf-8?B?NThHVjlUK3gzSDQ3ODBWbEtLYnNRWlV6dnJWcFFUT0NBNVRlbkl3S09zQS9B?=
 =?utf-8?B?bUJPazAyK0ZZakxvUDJORExtRVZabDJxdWVNR3d4K3c1Qmc2bGtONFlMWE5o?=
 =?utf-8?B?RDBNLzNwSmJ2RFhFcnZERmxuZXFDQmErVGd1cGpKNmRDTjdmUUdqZDVrK1FN?=
 =?utf-8?B?VDdxSWlvU0l6NEpxTk05VnJPRk15Q1FjZnVPeXdLWEd2MWJ6bE5NQ2YyZEhy?=
 =?utf-8?B?NXVIdGoranYxZTlDQ2VhUFpJeGpKU0JySWQvVW1KcXVZZGk3Wnlhb29KUnV1?=
 =?utf-8?B?eElrZE5GRHcwS3hkUStsVEdkZDNFR0Fvdms0cVpKUXFScEVUMGRXY1hOYit3?=
 =?utf-8?B?YS9vZW5HMHdLMmVmb2JnSVN2dmlabXE0RlkxTXErOGZGM3FqbU40QmdZKzNy?=
 =?utf-8?B?M3dUTktkeUlmM2d1STk4aE82cS9FbzJ4NTJhcEF5WWNSWmFSMVFKb1RIVml3?=
 =?utf-8?B?QkwybXNWaTlIZUltOFNueFZrUzBPSllIMTNiRUp1SFFOV2YrcDBtNFh4TFI2?=
 =?utf-8?B?ZXVIUkxkSkV0cUZsem5XS2wyY0ZUWVVUWEVadDlGVDVoem9QWTFBMkNWeEhl?=
 =?utf-8?B?Q3pEN2N6K3g1cTRDeW9Qa1ZnMTFDbGRRb1J3a3g4QktqUFZQTzhIV284MlhM?=
 =?utf-8?B?UFdGOWNyK1ZaRThRK0hoVjlRSjl4WlQyUzJCQngrN01UNC9Uc3NZVXcyT1ow?=
 =?utf-8?B?MFcvZDI0cUYwczV2VzMvSWJSTlUvLzc2bnpvSU5IN2Uyb0E1Z3I2dzBhamRX?=
 =?utf-8?B?Q1lqVzBtNkE4UDZVRDFod2pIRjVnUlptSDRDK2dTQVdQV0lHUTk4em1PbE1k?=
 =?utf-8?B?V2pETFJDUmxxZ05tQmgwTkM1d2MxK3VXcWhBcWwzd0hGZ1pORDNYS3Z1bDRW?=
 =?utf-8?B?Q3E5b09FSGJldGFVRmR5ZGhaTWZaM1hmRWpNWjFuU3ZBSTJnTjN4dTFoc3V1?=
 =?utf-8?B?YXk5MFZzMDRoREl0Qzg5M2JwM3AyaHVuaVROdVI5V0lmdVY3Sjl0VEk3MXVH?=
 =?utf-8?B?d0UxcktDMjVWdHc2MFMvak1LWDZWMm5xdFJmdDZOMVFiQnV3UHF6KzdMd3VS?=
 =?utf-8?Q?2GU0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791ed239-db29-4f34-3976-08db310e8c37
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 11:04:35.6602 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLuS6ulO0kqHa6wO6AKXWz6wFap/ycESF3UBjvTD1TYTgg7VuRlXExLzgflAVxk8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8249
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 29.03.23 um 17:47 schrieb Shashank Sharma:
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> Rename doorbell.num_doorbells to doorbell.num_kernel_doorbells to
> make it more readable.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 +++-
>   3 files changed, 17 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index f99d4873bf22..0385f7f69278 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -96,7 +96,7 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   					 size_t *start_offset)
>   {
>   	/*
> -	 * The first num_doorbells are used by amdgpu.
> +	 * The first num_kernel_doorbells are used by amdgpu.
>   	 * amdkfd takes whatever's left in the aperture.
>   	 */
>   	if (adev->enable_mes) {
> @@ -109,11 +109,11 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
>   		*aperture_base = adev->doorbell.base;
>   		*aperture_size = 0;
>   		*start_offset = 0;
> -	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
> +	} else if (adev->doorbell.size > adev->doorbell.num_kernel_doorbells *
>   						sizeof(u32)) {
>   		*aperture_base = adev->doorbell.base;
>   		*aperture_size = adev->doorbell.size;
> -		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
> +		*start_offset = adev->doorbell.num_kernel_doorbells * sizeof(u32);
>   	} else {
>   		*aperture_base = 0;
>   		*aperture_size = 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index afe6af9c0138..57ee1c4a81e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -593,7 +593,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return 0;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>   		return readl(adev->doorbell.ptr + index);
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -616,7 +616,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>   		writel(v, adev->doorbell.ptr + index);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -637,7 +637,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return 0;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>   		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
>   	} else {
>   		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
> @@ -660,7 +660,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>   	if (amdgpu_device_skip_hw_access(adev))
>   		return;
>   
> -	if (index < adev->doorbell.num_doorbells) {
> +	if (index < adev->doorbell.num_kernel_doorbells) {
>   		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
>   	} else {
>   		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
> @@ -1034,7 +1034,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	if (adev->asic_type < CHIP_BONAIRE) {
>   		adev->doorbell.base = 0;
>   		adev->doorbell.size = 0;
> -		adev->doorbell.num_doorbells = 0;
> +		adev->doorbell.num_kernel_doorbells = 0;
>   		adev->doorbell.ptr = NULL;
>   		return 0;
>   	}
> @@ -1049,27 +1049,27 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
>   	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
>   
>   	if (adev->enable_mes) {
> -		adev->doorbell.num_doorbells =
> +		adev->doorbell.num_kernel_doorbells =
>   			adev->doorbell.size / sizeof(u32);
>   	} else {
> -		adev->doorbell.num_doorbells =
> +		adev->doorbell.num_kernel_doorbells =
>   			min_t(u32, adev->doorbell.size / sizeof(u32),
>   			      adev->doorbell_index.max_assignment+1);
> -		if (adev->doorbell.num_doorbells == 0)
> +		if (adev->doorbell.num_kernel_doorbells == 0)
>   			return -EINVAL;
>   
>   		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
>   		 * paging queue doorbell use the second page. The
>   		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
>   		 * doorbells are in the first page. So with paging queue enabled,
> -		 * the max num_doorbells should + 1 page (0x400 in dword)
> +		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
>   		 */
>   		if (adev->asic_type >= CHIP_VEGA10)
> -			adev->doorbell.num_doorbells += 0x400;
> +			adev->doorbell.num_kernel_doorbells += 0x400;
>   	}
>   
>   	adev->doorbell.ptr = ioremap(adev->doorbell.base,
> -				     adev->doorbell.num_doorbells *
> +				     adev->doorbell.num_kernel_doorbells *
>   				     sizeof(u32));
>   	if (adev->doorbell.ptr == NULL)
>   		return -ENOMEM;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> index 7199b6b0be81..12263986f889 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -29,7 +29,9 @@ struct amdgpu_doorbell {
>   	resource_size_t		base;
>   	resource_size_t		size;
>   	u32 __iomem		*ptr;
> -	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
> +
> +	/* Number of doorbells reserved for amdgpu kernel driver */
> +	u32 num_kernel_doorbells;
>   };
>   
>   /* Reserved doorbells for amdgpu (including multimedia).

