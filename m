Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DAEC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 14:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AB8910E03C;
	Mon,  3 Aug 2026 14:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1mLfyq+4";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010061.outbound.protection.outlook.com [52.101.56.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6793310E03C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 14:21:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJjNR553ZVOASFxrHn5c3oLnGVwZ4DpoG7HhGmr3Vh/bzP7C2hNCf1xSBt8f0dtuD7PDNgFcWfnWcvdQ3wR5uk3jgmE7x2HY5X9SKmq1q8i47jqmWTfFX0u0++mMOI8rF0ApKdQPrIbAMz7I3ByyswdTvSSXVjL+URXMr3AeoXG/8ZU8ijrHxBte6b4ChMFXaDq/cFzaDHUkPiM2GGeHhEkNboBEKASQV0IGRymZPm9eK4pVN/NNOcoh4UnA3ZNhF9bMEk/RKqa1yOg7YNNayybl2FWinGKhWGqkZ7IQ5FOnJ2KQw5iPahX7Et1dfaYUQDIlxENd8ou2NfpFnVZ3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtBx2LYkxWgZFkRUdQ41rg5ZnZZbwKIkjMWZLqGzHRo=;
 b=tRxEUNqAOfxcShZri1M09EF0ET2aEc7BliuO136oJYHoGDySWpebPJc2MpWgECHXEPtcTbKYOmqRTEubVDPQ+o44XiJEQfAYxDGY9/9vtOUwjkWkwWjSTe1WwGkGk6aYyNmakA1fIh9PNg2HgbOpWdOHeJpoNCusDe4QURPIP636eoXjhJR+neiq73OpXq+ZjjODfVhFgXPGJWZwhSC7MqAD2kIRF//wf5duhkzY1N/4Xu6ZhkYypmmKlWPW0GXKnnYAJK0XRqdfVxL0dHdHE0kHIH+JcXXk5wHBiv2Ti/CMYLBv9BZ+ueYH3EIPhM3GAbfoI+3vIFD+WjnnaQtUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtBx2LYkxWgZFkRUdQ41rg5ZnZZbwKIkjMWZLqGzHRo=;
 b=1mLfyq+4QV7sDUXu8UyZiMxQFG0yDgPXaRlIiBVWN6MdfY5DDFHOVxeI97v7oB4xmMVHizjf13tl98irJ2MRk6AzOhRtRWz9kN00MqVEUiPrdFpbEWxZdtqo9XrzIzuVnswe/0RGT3gbV5OYb8XR7luQblzktpS8TFKs7xnBh1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 14:21:19 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 14:21:19 +0000
Message-ID: <e52e3da4-d295-475f-b01f-713a74044d65@amd.com>
Date: Mon, 3 Aug 2026 16:21:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix BO placement overflow with four domain
 bits
To: "Li, Candice" <Candice.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20260721092124.1967369-1-candice.li@amd.com>
 <IA1PR12MB7661DE87F8DE4F6AC41CC84D91CF2@IA1PR12MB7661.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <IA1PR12MB7661DE87F8DE4F6AC41CC84D91CF2@IA1PR12MB7661.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0436.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab8b1ef-f0d4-41ec-1ebe-08def16a7ccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: C4JTVyGwJkfb5c4kJQP640h5ots+J5EGqzMlQEDTKrOQo/3Zy8VtX9JPRTodgVBq7uRu997OTQF1VP/oocktzbgFCcawmn8cNgveArKxbKZQ42eXZCHDnMQnxv1CFjGSnRFur45GgLJWlx8znbUHuoMeQXp21elg/ZcAnp8cy59Sh5IOVKHmDhuoi42S+9fzvaDbeNIzc/7GxwlcUIfSJYxU0aJ9/1od0U/I3ouBfow6Qd5duzvgIy61rFDbhf3dDEy5B+V7oS9G0TVbyL9faHlF9Qd9+eFHxA5mEhsnwpZmw8NjXK4HXgrYRsLp+HIe0XgDbI0IO0eim7gHx4swgXaAF54OyTi9voVedueY/64sLu2CA/rPRCSRVVcTqFqNUWpYsIv5HiMRx602ocoFj5dbUw8m5g6PnK9s2d6FxEKZTeaNKOCNTiXXjDfufL9PgIG2I3UpOOmHmo+V+XYFAQTB1QF9nVfLh1pUEqm4gWpUEiv5zjQ4mEqMAF0EjiJzXHL9xlwWZDkyix38hkv6dMWV2yBt/FfYLUqDPtnaHBU38lhR5BbMh4rSFzNH25lKaDPuj0rKeIvW/dMSI4AeI49vFphGzJLhY4PA2RbzaPmi4Sx5biNt0+Wyz8GnD9PHRMIAq5kFiiO6pRp3TJX8cL+Tio+Y9f1W62n0atbW81Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UExYVWY1LzMyNUgzeDZsZFV0VWNEbUJWZTZEbE9kc21MVWJxVE5OSWxvUmZL?=
 =?utf-8?B?RFYrU0JtWmtTRFpQdHhCTHJsVlBYMlU1T0xnTE0xQmdFTjB5SWRaNTM4SytZ?=
 =?utf-8?B?UFp4OXRiejZJRnUvUlZNejlKWXdmVk1SNzZ6Z0c0WVplK085b05YUGFvQWVR?=
 =?utf-8?B?bWtCVlY0cUJNVjNjL3lmWnIzbEVmZXByb1lDRFpQblZoNWNxQ3cvSDVrb1Vy?=
 =?utf-8?B?dGZPakNLdDl1QkNLaW50bkI0Z3BsUUppYjk4VFJkS3FSSDJTMGtOUG5rSll3?=
 =?utf-8?B?cWFMWUFwYUF0Zlhoc0ZGbjE4RStGY1NHUHBicjBITWk3RnVSczNKSzYyOFhL?=
 =?utf-8?B?bDI2aEtCTDNwWW9ZeTZWamZxdnpXN3E4blVIVUhMdlFBODRIeVJXdzdoa0lu?=
 =?utf-8?B?Q21JcHZpM2N0alNxQ0J2YkZjZGxabnhWc1dOYWQ4SS9RRVRZSnhvclBWQXlv?=
 =?utf-8?B?ejZSQkl3cmgxUXczUGlpUi8rS29XUTFWRVBmLzZOTVhwS1l5MkkreDJFR1pl?=
 =?utf-8?B?U2NWaFdMeU01eDYrRGJsclA4QXB3ZkQ5aXBoZWxJNk9leDdyVTBRdmlhWE5G?=
 =?utf-8?B?UzI2RG1SUVg2cXdVZ0VtRG9rVzREaGZTQU5EbHZqeHpIamRPcndReDJ1RkZB?=
 =?utf-8?B?TGFwWndVeTRRdkc1SlNnY1JKeVN2NmVKd0ZQaTI1eG15angyakkvQnovQlNJ?=
 =?utf-8?B?L3IrcVBSMGs2aG9nTDhuQ1VUN3poOUlOUE4yQzVNVHlnVGFlRW5JUEc1Q3dU?=
 =?utf-8?B?SWFMZUdheWgrMm9OdFlzVStFQzk2N3plVHFUVkhHbGE2T2xGa0ZiR00vUGpB?=
 =?utf-8?B?UUJkOW5aemprOC90Yit0bDlTNkFZd2lyQlNrUTBOaXJjU2N4YW8wNGVkU0JX?=
 =?utf-8?B?TnpPZ1Q3aHlKWWh0OVh0UFZ0bDg3b0dHaUhaelpoUmZRbEVyNTJwS2hybnRl?=
 =?utf-8?B?Q240alRNaUlpVFVwUENNTWNTNjJhQUJxb0lOUzZqSnpwK1ZsSWF3TitqOU5r?=
 =?utf-8?B?aWpXNHhGUGpJRGhhc3IxaWtCWTFKZ3dvVVRhR1pvVU0rWmtMTDhWZTNoQWhO?=
 =?utf-8?B?Z29peERUaGNLM3o1OURaOWNtUUYzVWs4QjJvcU9pYW55Q2FlUVMwZXlaQkla?=
 =?utf-8?B?bnFnQ0daaEI4UW5XUTlKWUlVTnlxbi9jVFVpQXBnRHhqMHZ4SGFKQVUzRWpO?=
 =?utf-8?B?cnZESlJhRXpEcS85TjJWd2VXMGtFbHNhaFdxNStFTERLN2Fqc1UvUmRLYlEy?=
 =?utf-8?B?WmhPTkt3alR2M0tBU1JTbTRqcWFJZWxOM3F3NC95SkpycFY0U1JQQk55SDB1?=
 =?utf-8?B?Y1BvbDBPdDZIRFJOWGJUU1BPL2wvY3J0WFg3MEVrNTgwaHAvcmVpRDZlODN1?=
 =?utf-8?B?VENyUnp6S3RmNHBVSUM3MHl0ektNbVJxcGFkR1BUNkkzVGZGVzZOYVpmdXBs?=
 =?utf-8?B?WWlDbUFsZnJNZ21oQUlFZjA1YXJwWmh5Y0R2ZHBqSTJibmEzSk5lQ3lmbENm?=
 =?utf-8?B?WVRKd1d1UnBvY2tCOHdBc0o1T0p4UlBVdWhUUjBnRUpDZDJFeG9IVGxYT1Fh?=
 =?utf-8?B?N0JQS0VrZ200OHJTck9EUTNjYWZ1OWVxd3R3d1kzdzZHRWt5ckdDL0lRZmVW?=
 =?utf-8?B?NktDTktVUDhLSVJyVzA4RndsR3lkMEFyU3YvYnJzWnRNZ0ZSSnEzbUFzSk8w?=
 =?utf-8?B?a25oVzMyc0Y2SmNSRk01T2lJU1ZEd3hveXZPQTRVa3FtMTBDOUE2S3M2MlA1?=
 =?utf-8?B?RnpyaXI1QkpCZ3R1a3dsOEZ6TjVWUmVLVkh5eDVrSWZTV3MwMGFhU0t6TStU?=
 =?utf-8?B?ZUhTYTNlMUlXd2YzbEllY2N0MkVHemZWakpTR3paOVRCb0MxQU5Sd2ZMZUI1?=
 =?utf-8?B?SWpraFovNWg1MU5VNEVpSERMSWxkL2FtQU5Hd3EvUEpQMmNvbFJBUHRKOERj?=
 =?utf-8?B?TW9NSHpGK1BST1RXNVFISDBWeElwQjdDS1ZhNCtuekdEcGRrWmFmbExLbmdx?=
 =?utf-8?B?Q2VSMHZ6TzRIQ2QzWTYyQzVNUVFvQ0dnYlV0WFIvcGZ6VGxjT3BMcVVvVVhP?=
 =?utf-8?B?QURpWDRlcEl5SkxHbXRxQ0lWdXNvdFJ4L0Y0K3doSEtzZ3hNZkF0SFFHcVBW?=
 =?utf-8?B?QUpqem5ub0dOenZLbm94MkVNaU95bTlJY0JGR2NSZGdGTU9ONkNmTUx1K084?=
 =?utf-8?B?dUhNM3dpaERWbEY4WTB6SjRKRWh6a1pXdERzRUd5YWNuWmxWd3JKcGxDanRk?=
 =?utf-8?B?YmFNeHNQSzdPOEx1UUl1aUJwWC9RVTd1NzJJVWI2WWtFVnJTcUFPUmdjNmpY?=
 =?utf-8?Q?/O4SmnSCLkhlLN9T9m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab8b1ef-f0d4-41ec-1ebe-08def16a7ccc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 14:21:19.8103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ntv9nBvBlUZnsm4ZD4BkKCLCLgR0ajUjE0WYRC006U0QmXTVUF73s3C4V6alzXY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725
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

That change doesn't make any sense.

Only CPU|GTT|VRAM can be combined together, that's why AMDGPU_BO_MAX_PLACEMENTS is 3.

DOORBELL, GDS, GWS, OA are special resources without alternatives and can only be specified one at a time.

On 7/24/26 05:12, Li, Candice wrote:
> AMD General
> 
> Ping.
> 
> Cc @Koenig, Christian and @Deucher, Alexander
> 
> 
> Thanks,
> Candice
> 
> -----Original Message-----
> From: Li, Candice <Candice.Li@amd.com>
> Sent: Tuesday, July 21, 2026 5:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>
> Subject: [PATCH] drm/amdgpu: fix BO placement overflow with four domain bits
> 
> AMDGPU_BO_MAX_PLACEMENTS was 3 but amdgpu_bo_placement_from_domain()
> can emit up to four entries for CPU|GTT|VRAM|DOORBELL. Unprivileged
> GEM_CREATE with domains=0x47 writes past placements[] and triggers
> BUG_ON().
> 
> Increase the array to four and normalize mixed GDS/GWS/OA domain
> masks to CPU-only placement on all rebuild paths.
> 
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  3 +--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 18 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
>  4 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6a0699746fbcd6..bcf81aba942842 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -431,8 +431,7 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>         flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
> 
>         /* create a gem object to contain this object in */
> -       if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
> -           AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_GDS_GWS_OA) {
>                 if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>                         /* if gds bo is created from user space, it must be
>                          * passed to bo list
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> index b558336bc4c6ca..321db2ca29f4a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -31,6 +31,8 @@
>   */
> 
>  #define AMDGPU_GEM_DOMAIN_MAX          0x3
> +#define AMDGPU_GEM_DOMAIN_GDS_GWS_OA \
> +       (AMDGPU_GEM_DOMAIN_GDS | AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)
>  #define gem_to_amdgpu_bo(gobj) container_of((gobj), struct amdgpu_bo, tbo.base)
> 
>  extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index d4a9d5e8fb429a..bb02858cbebf0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -99,6 +99,19 @@ bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>         return false;
>  }
> 
> +static u32 amdgpu_bo_filter_placement_domain(u32 domain)
> +{
> +       /*
> +        * GDS/GWS/OA are not normal fallback placement domains. When mixed
> +        * with CPU/GTT/VRAM/DOORBELL, fall back to CPU like amdgpu_bo_create().
> +        */
> +       if ((domain & AMDGPU_GEM_DOMAIN_GDS_GWS_OA) &&
> +           (domain & ~AMDGPU_GEM_DOMAIN_GDS_GWS_OA))
> +               return AMDGPU_GEM_DOMAIN_CPU;

Absolutely clear NAK to that!

That is simply a complete misunderstanding how things work here.

Regards,
Christian.

> +
> +       return domain;
> +}
> +
>  /**
>   * amdgpu_bo_placement_from_domain - set buffer's placement
>   * @abo: &amdgpu_bo buffer object whose placement is to be set
> @@ -115,6 +128,8 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
>         u64 flags = abo->flags;
>         u32 c = 0;
> 
> +       domain = amdgpu_bo_filter_placement_domain(domain);
> +
>         if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
>                 unsigned int visible_pfn = adev->gmc.visible_vram_size >> PAGE_SHIFT;
>                 int8_t mem_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
> @@ -690,8 +705,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>                 bo->flags &= ~AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> 
>         bo->tbo.bdev = &adev->mman.bdev;
> -       if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
> -                         AMDGPU_GEM_DOMAIN_GDS))
> +       if (bp->domain & AMDGPU_GEM_DOMAIN_GDS_GWS_OA)
>                 amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
>         else
>                 amdgpu_bo_placement_from_domain(bo, bp->domain);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index ff11a09034997e..20f4d8c243afdd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -37,7 +37,8 @@
>  #endif
> 
>  #define AMDGPU_BO_INVALID_OFFSET       LONG_MAX
> -#define AMDGPU_BO_MAX_PLACEMENTS       3
> +/* Covers CPU | GTT | VRAM | DOORBELL placement candidates */
> +#define AMDGPU_BO_MAX_PLACEMENTS       4
> 
>  /* BO flag to indicate a KFD userptr BO */
>  #define AMDGPU_AMDKFD_CREATE_USERPTR_BO        (1ULL << 63)
> --
> 2.25.1
> 

