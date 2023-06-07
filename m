Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D67C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 19:30:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7671E10E0ED;
	Wed,  7 Jun 2023 19:30:22 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::627])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C635210E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 19:30:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUiRczJByCV/kR64THEtBEM5Ao3UGX9EyuCQVlZJXxfHPunsK/CKt2vABSH0SKtcIQRL5sqo2bjTxBecm9PNUyyNgRcmUnzGBAVAHWHi+tKq7PMk2LJaX9nLGjVtJ59EOumDFTuc0L6I3AgZodhiXjPXgahWQJCL2Rpzr7Z0m+RqK0nY2UpL4YpxhTwGeRwqxr2RylIbFwdfjmLg4vQm7OB1+P9IvplAaKFTuqVcXhDgVYQ7pD0ur75EUaZlhN6wBOwOw/v18pOo5j8OwhY4ZnvUOsMrdNU7qF+q4uCEirRhRsDCNel4FyWujs+rahtbuiqXMHNI0uPxFPdXdF20TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JhLTjZBH4QRSEvyyr6QhCrUmd2TeaQLWWzvS7EHXWk=;
 b=oPamWyx7fYA+/gzKnTOmUor2smYLQkONpR8ubvI4V7ZjljcYxKlED5pM+rEsPkkB08ejlawi5ri9BDUrMtd64xXahr9CG5XDo3EiW43MdbZkrPJM/Xc4SsaXUx7QOXPO7Ak8G7LPfnntgML4EYZbJ+9NWH9V2XyREDO69z5w3JZvpYvHyqhiDTf+d3D9vyJ5wF+AiI8xUtkAs9HyGyFw3WMsPsYXL3QSAe6mcof1urEal+CgYQHo/ekSQllmnhjbnLQzxPwftPfirbdBqHrDFnx1oH5qXs4Uir1o5a/hRw5/eu34Y1XIDApPNVtK6mSe5Oj8HklDKPw50PwOiKsqiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JhLTjZBH4QRSEvyyr6QhCrUmd2TeaQLWWzvS7EHXWk=;
 b=XicGoF9Ks4cHAeLlVsu7sMcJBF3uqunUaXt7IRTs2jqXDZfpd2lWn0dOXiTtcjjfqq/key93VfcD9xL/Ti332QbB3pKOrtZ01EYhpXuRpgg3n7hiGa2iBdVxNdYT18O3wpp2mCXJwGkF8e8t9f5mpdoxr5J2NhPjXNCTN+jzSOA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Wed, 7 Jun
 2023 19:30:18 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 19:30:17 +0000
Message-ID: <7fb080c9-3a5d-5346-9fd9-05ecec308e82@amd.com>
Date: Wed, 7 Jun 2023 15:30:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: optimize gfx off enable toggle for debugging
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org, "Kim, Jonathan" <Jonathan.Kim@amd.com>
References: <20230607173211.1824941-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230607173211.1824941-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0290.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::26) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 937c797d-c439-46e3-9fb0-08db678da016
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SA3IksJ1whmqvfydeXmpa/lJPsDaYYzGtqqarUuZJf2e5b2zd2c9W3UkoJ54geizqFx7E0DoC6bctMMdekfui4b5MK4MkE0xGv4zG7IkDMflAgHfMlsFrNVMG6U3AO1ABmijG+WOu8NWJ5by6bZf44YNn6q9cd8ELWxupwPSfV2mAFvx72tFwW+QzYGV2p9AVejoiLiRh8Umlh747npN9T7SAhhGO/29VrdUc6XuJQt2MJJ5RHDrwjHrqo3o/2g29n6Cm4mj5zwXUp3BIvIT4lg2+WzjtsfEvUVGU5a1i8zVFLhILezphlzex+tA3GPykp3tYT/ZDNQ0tVPvIRMorQQeSXcTtjNr1SHIUSXVLrSZcIOFdWiYm/ut/mtlW3fgzCArvlxZbz/5vJ7+DXBc/UW6EsOjxxQnobt99YxDhAEPG+6RxE+1PHXUvBP0P2wargeCjW7kV8LkD0KzgGK15nXkWiUb7jtJG31JgywkXv7eBNgwOQ02HRasR5daptJc5EWaK/SdcHbdSrLctm2VV0mc6hJCJ3SKy2JBCAGpa6nVReFWAkRs/f76jCa/QLwNp+H/0TIB1XfRaNHnmgOTrWQnB4v5jPa5auPmQbMYHilNWqijXkdoJzCrulfgx/BAGkk2cPoTkNR9ghhDE+Hmxnf/xhDQCAzVILCoPDR0PPs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(41300700001)(8676002)(37006003)(83380400001)(2616005)(478600001)(6636002)(186003)(4326008)(36916002)(316002)(66556008)(6486002)(30864003)(66476007)(66946007)(6512007)(6506007)(2906002)(26005)(53546011)(44832011)(5660300002)(8936002)(6862004)(38100700002)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1hMK1RyblR5ZW95WGJ0eVdOY0ZheXhZZHdUdWRNbHRHdVNFMlZjM2RnNWV3?=
 =?utf-8?B?VU1Ba2V5UCtNOEM5ZjBzTUIyMEdXMzhkQUhuY1lmQThsRGVnQ0JYSkFXa0Ra?=
 =?utf-8?B?UTl4Y2lsRzhNcDRucVVoWnpkRnVpbEVxSlhjVUpFSnBzR203S3NpaFZaM2t1?=
 =?utf-8?B?U3pIOWFsWWFUWG9kWnFzOE1DSFowOFZuVFRYMjlQbFJSOVhNU3hqYWg4bXRS?=
 =?utf-8?B?Q3hUWkJLOWpha2JZenNhamxaNEc2ck1Tc1pRZnkrK0szckh0dzgrV2ZZSldo?=
 =?utf-8?B?WU9KbytMZjVLb2VUa0Z5Slk4RTdsa1loZWQ4Z0ZlbGQrWEwrcWhVWHI4VmZC?=
 =?utf-8?B?LzFWUUxqTCtlVjd5T3FvR2FNQmg0V1dlT2l0dEZJNXBEN1dsRittN3ZTZ3Zr?=
 =?utf-8?B?b01LSlBxY2NuUHBNRk9ER2M1Qy9tMWN2dUhkL01LcUU1Z0hZdDhSUlFONWlj?=
 =?utf-8?B?bGJ3cDdxUnB2SWpSWkNYMlFFRVR5RitWK202NnM5eFNjM0VFUEtrOTd2UEFw?=
 =?utf-8?B?czNjVVJ4bEJsOU10YkE0SHlzdDhzTm81R3hxSXY5UEEzcWJ0RDlqSmV3cm5j?=
 =?utf-8?B?TC9lZE5HQlNtUC9WaXhwRGltYVlPbzdndU5YenRtQ2poc0UxRTZMby9NT3dq?=
 =?utf-8?B?TmFYdWp5cHF3ZjVja3BYcC85TVVQWmVkVWp3eEVBUWljSU1TcG5ZR0VKYklW?=
 =?utf-8?B?UDNxcEo0bk84YThKOS9hUUZ5YUNzT0krQ3ZwYWdWcjlmMnVnMEpHMDljeHha?=
 =?utf-8?B?TmlsUXEzUFhLNHA4ZWJXN1RUWDZzT1AzNVU3Vk9pT3lDaVJoR1o1VU5mMlhH?=
 =?utf-8?B?cnUvQkZNZi9rWlB1eWRVMEZyay95UkFqOU5IcWdhRmwzYytOaUlZU2FsWk82?=
 =?utf-8?B?QWM4djE0M1Z0YUFWK2oxQ2RGMDlPT1ZCMVZ0T2JHMjdONENYc1AyN2RwK0dW?=
 =?utf-8?B?MjJ0RG5SMXo4Y0RvMGU4cjM2dzN0cHYvUUZBZkdVQ3A2RlpkUGZiRGszc3h3?=
 =?utf-8?B?b0hJOWVUOERjRWtpZnk0anZTWjdRQWxKdEdoTHFpRS9idWJONUJ3QVRYTjdX?=
 =?utf-8?B?c2k4NlpYejVONEpwNzQzL2ZXQVBQSVh0ME90SkM5azJsZ1V0RG5WTWRZeW5X?=
 =?utf-8?B?UW0xazA5MnlFMjU5eWk4aGQwYzRGMUkzNDNCQXlhOElyNmQwdkc3ay9qb2Ju?=
 =?utf-8?B?Nm1NcTRsNmpqNWtiZEQ0NEduOUY5UWhmc29Sb0xCcTlkYlFXYjlJVi9md2xx?=
 =?utf-8?B?UDVYYStLcVRocU9VY05CWFNLdUxjWGllS1Zvb21QSkFjQnFwOFN1UllQLzlk?=
 =?utf-8?B?VVNpdkN4T2tnRDMwUjlUZ2Q5bFpxZWo0Zmo0ajRVbzg0d2wrUlovMTF1RFla?=
 =?utf-8?B?MUlVTlVPSXJSeGxlRmh4c2NQcG5DT0c1ZXBoSlYxa25rUU5QZlpuNSsvaE9i?=
 =?utf-8?B?bmZuSzRjcWpKU3llMkNEWElVMG0yK3I4OWEvV2pGMm1GbWozdmtoeHdVNGJ6?=
 =?utf-8?B?cHJOU2hNT3ZpeEtURkF5TkhsVzRLM3pQa3B6TmVOMWs5OFFZdnNyTDRBNG1t?=
 =?utf-8?B?M1cydkc2Sm5FenRIakJBRFl0dk85UlZ0Y1RYYm9yNm5sVDFHbEtsOWR0YVFE?=
 =?utf-8?B?M3orMENzUGdxOXJQYm1MazhKekZ2ckJIVHlrbHlmYlZhMTNIbDhZUEZqU2p2?=
 =?utf-8?B?c3NMMHVMaS82TWUycHZNWUF1b2xKUGRqUFFzRVE2UHRhMnE5dmhWQ3VuKzcz?=
 =?utf-8?B?d3hmRFZuR1VwRWJLWHBlemxaZDNMMDdaaFlRNFNJVWtlNk50TFk1Z0puSVlY?=
 =?utf-8?B?eUZxc2NmWkJCN0pHeG1FNFJUek1td2ovY2U4REQydStnQjg0dVBST2xPekF0?=
 =?utf-8?B?RDRqNHAvSXhzV3kzU3hNbzd5aUd0bmt3QXhOK2trT0JUblVxZk9wWW5IOEdw?=
 =?utf-8?B?V0tiSS84YjJoYUV6YUF4a0FrY2VzMlVzZE1ENTJYNWdqMjZqa0FxdXJxSTBE?=
 =?utf-8?B?TllRb2RjZitlcTU0blJYbytrUm9ZV1cvaEo5TUxuSnpUcjRxMytudWVVVUlR?=
 =?utf-8?B?NWlOc1k3M1U0ZGpYZUIxMStRQTV4aU4vQjdHallHUDVZRDIvdmsrdVF6QlBH?=
 =?utf-8?Q?JX4MPh+26v5NbpPhfyfnhgCTO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937c797d-c439-46e3-9fb0-08db678da016
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 19:30:17.8404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kocuqZ7CRPDwgIXSSPeSyHIKWmGuJlGBDSAskPI14Q1iTPz+fLb5yDtK8KiG+vONIgYEiAaJuRPhDecW3kQBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
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
Cc: "Huang, JinhuiEric" <jinhuieric.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-07 13:32, Jonathan Kim wrote:
> Legacy debug devices limited to pinning a single debug VMID for debugging
> are the only devices that require disabling GFX OFF while accessing
> debug registers.  Debug devices that support multi-process debugging
> rely on the hardware scheduler to update debug registers and do not run
> into GFX OFF access issues.
>
> Remove KFD GFX OFF enable toggle clutter by moving these calls into the
> KGD debug calls themselves.
>
> v2: toggle gfx off around address watch hi/lo settings as well.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  4 +++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  7 ++++
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 33 ++++++++++++++++++-
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  4 +++
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 24 ++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 22 +++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 21 +-----------

Looks like you missed one amdgpu_amdkfd_gfx_off_ctrl call in kfd_process.c.


>   7 files changed, 77 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 60f9e027fb66..1f0e6ec56618 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -150,6 +150,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
>   			VALID,
>   			1);
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +

Aldebaran doesn't use automatic gfxoff, so this should not be needed.


>   	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_high);
> @@ -158,6 +160,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_low);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return watch_address_cntl;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 625db444df1c..a4e28d547173 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -350,6 +350,8 @@ static uint32_t kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
>   				bool restore_dbg_registers,
>   				uint32_t vmid)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
> +

I would need to double check, but I believe Arcturus also doesn't 
support gfxoff.


>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -362,6 +364,8 @@ static uint32_t kgd_arcturus_enable_debug_trap(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -375,6 +379,7 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
>   					bool keep_trap_enabled,
>   					uint32_t vmid)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
>   
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
> @@ -388,6 +393,8 @@ static uint32_t kgd_arcturus_disable_debug_trap(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   const struct kfd2kgd_calls arcturus_kfd2kgd = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8ad7a7779e14..415928139861 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -754,12 +754,13 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
>   				bool restore_dbg_registers,
>   				uint32_t vmid)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
>   
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
>   
> -	/* assume gfx off is disabled for the debug session if rlc restore not supported. */
> +	/* keep gfx off disabled for the debug session if rlc restore not supported. */
>   	if (restore_dbg_registers) {
>   		uint32_t data = 0;
>   
> @@ -784,6 +785,8 @@ uint32_t kgd_gfx_v10_enable_debug_trap(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -791,6 +794,8 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
>   					bool keep_trap_enabled,
>   					uint32_t vmid)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
> @@ -801,6 +806,16 @@ uint32_t kgd_gfx_v10_disable_debug_trap(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
> +	/*
> +	 * Remove the extra gfx off disable reference from debug restore call
> +	 * for asics that do not support rlc restore for debug registers.
> +	 */

Where is the extra GFXOFF disable added? I don't see it in 
kgd_gfx_v10_enable_debug_trap above.


> +	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 10) ||
> +	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 1))

This duplicates kfd_dbg_is_rlc_restore_supported. It makes me wonder 
whether kfd_dbg_is_rlc_restore_supported is still needed at all. See below.


> +		amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -832,6 +847,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   {
>   	uint32_t data, wave_cntl_prev;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
> @@ -853,6 +870,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -863,6 +882,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
>   	uint32_t data = 0;
>   	bool is_mode_set = !!wave_launch_mode;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	kgd_gfx_v10_set_wave_launch_stall(adev, vmid, true);
> @@ -877,6 +898,8 @@ uint32_t kgd_gfx_v10_set_wave_launch_mode(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -916,6 +939,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
>   			VALID,
>   			0);
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_cntl);
> @@ -938,6 +963,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_cntl);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -948,10 +975,14 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
>   
>   	watch_address_cntl = 0;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	WREG32((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_cntl);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 91c3574ebed3..bb6ad733b3d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -768,6 +768,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
>   			VALID,
>   			1);
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_high);
> @@ -776,6 +778,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_low);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return watch_address_cntl;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51d93fb13ea3..e30d1f9f5564 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -704,6 +704,8 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
>   				bool restore_dbg_registers,
>   				uint32_t vmid)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -714,6 +716,8 @@ uint32_t kgd_gfx_v9_enable_debug_trap(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -727,6 +731,8 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
>   					bool keep_trap_enabled,
>   					uint32_t vmid)
>   {
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -737,6 +743,8 @@ uint32_t kgd_gfx_v9_disable_debug_trap(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -768,6 +776,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   {
>   	uint32_t data, wave_cntl_prev;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	wave_cntl_prev = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_GDBG_WAVE_CNTL));
> @@ -789,6 +799,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_trap_override(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -799,6 +811,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
>   	uint32_t data = 0;
>   	bool is_mode_set = !!wave_launch_mode;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	mutex_lock(&adev->grbm_idx_mutex);
>   
>   	kgd_gfx_v9_set_wave_launch_stall(adev, vmid, true);
> @@ -813,6 +827,8 @@ uint32_t kgd_gfx_v9_set_wave_launch_mode(struct amdgpu_device *adev,
>   
>   	mutex_unlock(&adev->grbm_idx_mutex);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -852,6 +868,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
>   			VALID,
>   			0);
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_cntl);
> @@ -874,6 +892,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_cntl);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> @@ -884,10 +904,14 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
>   
>   	watch_address_cntl = 0;
>   
> +	amdgpu_gfx_off_ctrl(adev, false);
> +
>   	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
>   			(watch_id * TCP_WATCH_STRIDE)),
>   			watch_address_cntl);
>   
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cf1db0ab3471..f597e1c8ebee 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2766,7 +2766,6 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
>   			struct kfd_process_device *pdd = p->pdds[i];
>   
>   			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {

Is this condition still needed? Or could this be handled inside 
kfd2kgd->enable_debug_trap?


> -				amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>   				pdd->dev->kfd2kgd->enable_debug_trap(
>   						pdd->dev->adev,
>   						true,
> @@ -2823,33 +2822,22 @@ static int runtime_disable(struct kfd_process *p)
>   			return ret;
>   	}
>   
> -	if (was_enabled && p->runtime_info.ttmp_setup) {
> -		for (i = 0; i < p->n_pdds; i++) {
> -			struct kfd_process_device *pdd = p->pdds[i];
> -
> -			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev))
> -				amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> -		}
> -	}
> -
>   	p->runtime_info.ttmp_setup = false;
>   
>   	/* disable ttmp setup */
>   	for (i = 0; i < p->n_pdds; i++) {
>   		struct kfd_process_device *pdd = p->pdds[i];
>   
> -		if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
> -			pdd->spi_dbg_override =
> -					pdd->dev->kfd2kgd->disable_debug_trap(
> -					pdd->dev->adev,
> -					false,
> -					pdd->dev->vm_info.last_vmid_kfd);
> +		pdd->spi_dbg_override =
> +				pdd->dev->kfd2kgd->disable_debug_trap(
> +				pdd->dev->adev,
> +				false,
> +				pdd->dev->vm_info.last_vmid_kfd);

Are you sure this is related to gfxoff? Is it safe to make these calls 
(and refresh_runlist below) on GPUs that do single-process debugging?


>   
>   			if (!pdd->dev->kfd->shared_resources.enable_mes)
>   				debug_refresh_runlist(pdd->dev->dqm);
>   			else
>   				kfd_dbg_set_mes_debug_mode(pdd);

Assuming the above change is intentional, indentation is incorrect here.


> -		}
>   	}
>   
>   	return 0;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index e7bc07068eed..5b381018407a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -441,11 +441,9 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
>   			return r;
>   	}
>   
> -	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>   	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
>   							pdd->dev->adev,
>   							watch_id);
> -	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>   
>   	if (!pdd->dev->kfd->shared_resources.enable_mes)
>   		r = debug_map_and_unlock(pdd->dev->dqm);
> @@ -476,7 +474,6 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
>   		}
>   	}
>   
> -	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>   	pdd->watch_points[*watch_id] = pdd->dev->kfd2kgd->set_address_watch(
>   				pdd->dev->adev,
>   				watch_address,
> @@ -484,7 +481,6 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
>   				*watch_id,
>   				watch_mode,
>   				pdd->dev->vm_info.last_vmid_kfd);
> -	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>   
>   	if (!pdd->dev->kfd->shared_resources.enable_mes)
>   		r = debug_map_and_unlock(pdd->dev->dqm);
> @@ -599,15 +595,11 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   
>   		kfd_process_set_trap_debug_flag(&pdd->qpd, false);
>   
> -		/* GFX off is already disabled by debug activate if not RLC restore supported. */
> -		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
> -			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>   		pdd->spi_dbg_override =
>   				pdd->dev->kfd2kgd->disable_debug_trap(
>   				pdd->dev->adev,
>   				target->runtime_info.ttmp_setup,
>   				pdd->dev->vm_info.last_vmid_kfd);
> -		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>   
>   		if (!kfd_dbg_is_per_vmid_supported(pdd->dev) &&
>   				release_debug_trap_vmid(pdd->dev->dqm, &pdd->qpd))
> @@ -699,14 +691,10 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>   			}
>   		}
>   
> -		/* Disable GFX OFF to prevent garbage read/writes to debug registers.
> +		/*
>   		 * If RLC restore of debug registers is not supported and runtime enable
>   		 * hasn't done so already on ttmp setup request, restore the trap config registers.
> -		 *
> -		 * If RLC restore of debug registers is not supported, keep gfx off disabled for
> -		 * the debug session.
>   		 */
> -		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>   		if (!(kfd_dbg_is_rlc_restore_supported(pdd->dev) ||

Is this condition still needed? Or could this be handled inside 
kfd2kgd->enable_debug_trap?

Regards,
   Felix


>   						target->runtime_info.ttmp_setup))
>   			pdd->dev->kfd2kgd->enable_debug_trap(pdd->dev->adev, true,
> @@ -717,9 +705,6 @@ int kfd_dbg_trap_activate(struct kfd_process *target)
>   					false,
>   					pdd->dev->vm_info.last_vmid_kfd);
>   
> -		if (kfd_dbg_is_rlc_restore_supported(pdd->dev))
> -			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
> -
>   		/*
>   		 * Setting the debug flag in the trap handler requires that the TMA has been
>   		 * allocated, which occurs during CWSR initialization.
> @@ -851,7 +836,6 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
>   	for (i = 0; i < target->n_pdds; i++) {
>   		struct kfd_process_device *pdd = target->pdds[i];
>   
> -		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>   		pdd->spi_dbg_override = pdd->dev->kfd2kgd->set_wave_launch_trap_override(
>   				pdd->dev->adev,
>   				pdd->dev->vm_info.last_vmid_kfd,
> @@ -860,7 +844,6 @@ int kfd_dbg_trap_set_wave_launch_override(struct kfd_process *target,
>   				trap_mask_request,
>   				trap_mask_prev,
>   				pdd->spi_dbg_override);
> -		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>   
>   		if (!pdd->dev->kfd->shared_resources.enable_mes)
>   			r = debug_refresh_runlist(pdd->dev->dqm);
> @@ -887,12 +870,10 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
>   	for (i = 0; i < target->n_pdds; i++) {
>   		struct kfd_process_device *pdd = target->pdds[i];
>   
> -		amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
>   		pdd->spi_dbg_launch_mode = pdd->dev->kfd2kgd->set_wave_launch_mode(
>   				pdd->dev->adev,
>   				wave_launch_mode,
>   				pdd->dev->vm_info.last_vmid_kfd);
> -		amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>   
>   		if (!pdd->dev->kfd->shared_resources.enable_mes)
>   			r = debug_refresh_runlist(pdd->dev->dqm);
