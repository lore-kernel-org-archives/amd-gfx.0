Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A46CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D7C910E843;
	Wed, 10 Jun 2026 09:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v0xpjSYH";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31FDE10E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:43:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEgV8boPjz97uL4s5Atjw2PzssOdXtTz3CLTAZRNPdXw70Cys/p6m7x+50jZLv/EqK7Ey+oCBapcq+NhMx+tqumw/WRqYsTIqWZSNZndFOeJBMcODHbxDRfwxg92brI95WKWOj5rb9iloNoNkuEnbCdhneuENIJjjlC+cOk0gMe4ml3D4F2UIBezXIWV7WWpvzubpVKQ0GDsXBdXD3PuonXLaYzpdWC2yARVTcVU3oKLgNU2t8xwINhHzr7IeVgxsNVrBG0E7RGp4+rSBV1hj7GQcTJjTn4lVbMFdkIsSpIf/7zDYbZnBdr4dN+DByEspr6Yc1gDJyye1neCp86Ysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOVtDyfEGHJXIDr82rGpXpKny+wQOgdKvp6wPBhAPdA=;
 b=gZNc8j2EFQnAMZ42FRKoKpUHhkv661EbxLW8lBvyPJADgHlDCCUQGpuRw8SoMfThr4+eqfnRZzzPhr1bKdWFTcTF7p/B/uXKzANX+tgrXgcFT7gsC7vbEpXC/rusXDXEufWIIDZYPiYIjZiLIOs61cM8hLLxv4vSM0Vaw2J7noiM8T0awVxqjJnUXZ5BY7kAAWbXDfOBNePx5gwRg5XPNqlp1OkXkvHFX2++VKoiZ4ZsCsxPbyWm+Kgz2zztSIiDrR7CWp9TgxmjYZMRLCllvGla+DnsJIU36GDSeHnHAaX7+tz7r0kxGY2xVWxj6c3+KGzJLTfr9U+Kx2HxF6IFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOVtDyfEGHJXIDr82rGpXpKny+wQOgdKvp6wPBhAPdA=;
 b=v0xpjSYHmK9BXRmTMC5fG1r12L9BZzou7tzNvKCWEy+/PmeQJkMIYjTF/BuiU2XDau6P2dz4ziEoA1OSRAEc//3YLd7iaosxqzSmXXfh3T2Nq+29qbqSpzBpjwDNUsxOuk2U20SaP57UIKvBHcV6yY6gQpewgGwU4XS4V0NwEI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.10; Wed, 10 Jun
 2026 09:43:03 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Wed, 10 Jun 2026
 09:43:03 +0000
Message-ID: <f129da3e-310b-47c5-abfc-6b3526e8bebb@amd.com>
Date: Wed, 10 Jun 2026 11:42:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/9] drm/amdgpu/uapi: Define kernel event types for
 EVENTFD subscriptions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260610060402.2769642-1-srinivasan.shanmugam@amd.com>
 <20260610060402.2769642-5-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260610060402.2769642-5-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: ed6d0959-5702-4604-a60b-08dec6d4aa6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fgyl5te+2RxlQp3BI3P2jnqDdCP5WtRP86jNnniPP/uDGlY4+AJ1J22soRml6Mu88AiUkEVnLtfL2gkgzFVU9Db9XRKCjX/k0MShKBTF/l4q0/RXTbYnmTZ/uthLAdUHSRHZutC8EOKLKUryaWzyYoYwDOVwb1BGnXhA4SHSat0pFw7DaCJqIbEVmIAERRhSkUNpKMLrA/v5XYsvJpXRfvbc8qki7uVBQAGBDgn8hhv8LYuNtymWUCzpYC8CKHi0v7fyQ+780d4j8ClhNoG/w5FJVsRoLiDM9b+0HV8uQaOJPYJ6cUh3GGIRLWSU3V4grDkQBbnnB+4jgTH4j1P5L7pHllbOmiEDPQbQifEFgKi77nXTGCQS9U0tDQapmsfBwIUY0y5UuUqko/gX5Z+VASLj47lz8SQT3ec5tRX8fu+F6DwCDZOqjFGn3nGQy7OyDuZY6XEfkJDUj49H3wnjPhM+WOXpSStz+uUYzfx0GCKmOT4L5fRpMtXJVQ4UTr1DtrEL9Gn1MesmZmPKbOQVAzVeagHE2WJjPQHowpufWF7GqDXisKA6bjoRvi4QFC3r6AYd3Cnd61piyKLRrZANMOA8Mu1OoUCHQ6es0AUDqKIQBofgUEMqIHNr5cvhnxTkeE1gkvUqlDFDkOD+8cRtP9pT7OjX4VkiTeSDjBEn6tphjlC9S0wMWOL5ErkLjhND
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eFh2WDFoQVNRV1doaU1jbmRLakRMOGp5eWhaN0EzMHBFWUZxbEFkZnFuT2Nh?=
 =?utf-8?B?cjQwOHZQTklHNXBxSDBmUjgzRkFHRDRBR1I3VlFBQ1FiMEhqOEcyclhmYTYy?=
 =?utf-8?B?Qm9CUUU3b0llTFpjL2hMUmxrbnA5ajk4QVdsMjRZY21VZnZEMThUK3cydy9t?=
 =?utf-8?B?emVsOG0rdi81amxUckhFVkc0QU5oN0Z1YU5pdmdJWHB2MnlXbitHR0xXczNS?=
 =?utf-8?B?NWkySEo0VjRqNkRwNTZoNlg2MUlnYWNSeGUrL2NLSldkL0hRNUQ2WWJNSFFJ?=
 =?utf-8?B?WHplU0FpN2tTMyt1aXRXemFLSTk2Z0pjUlFEdXRLY1VJTDdHVUY3cXd6N0xu?=
 =?utf-8?B?cTFHaCtMSnVwbHp1ZHpVN3poSy9lZUlOeFc3VDR0SnRtdnlHMzRqcVRsVUpG?=
 =?utf-8?B?bS9sdm1PeExVM0h6c2tmNUtHMEs2UmdhV2JWNVJTSjR4MFN4YUFMNVJYdys5?=
 =?utf-8?B?NjM3VTZVVlloUnQrOHRBU3RBcGtOVnBYcTM3QS82c1QyR3g5ZHhJbkFOL09w?=
 =?utf-8?B?bEQ2ZDFjbFhpZ1piZmlVQmNFOCtHQjBlTllXSlRNNG5FanJBaFZCOFVBNXd6?=
 =?utf-8?B?Mk5ublVRNUtnRm5Ob2FwNHdkKzFxU3RCclg2UG9jQUg4WVhpTFdGaXlXN0Z6?=
 =?utf-8?B?VE5yNnpiUEVCSlcrNjRqbHJHaWtQQkJHT2dJWUd0OUsvYXV6SUdJN3d0aGVk?=
 =?utf-8?B?SWhkWXB1c1k2ZFd3U2cwZGpTZUlGUUw2UFpvV1BwblVFRVFkem5kb0JEWS9i?=
 =?utf-8?B?TndMNHlFYldqZk5RN1FtT0RKZEFCOTZzQzhianFGLzgrbWcwRWhiZS8vM0pv?=
 =?utf-8?B?UkxjK2Q0T2VrNmtsSHMxenVxYWE0aDJ0RkgxYmVMZXhjbUhkRUh2Zm4zeHRG?=
 =?utf-8?B?d01GZ0lCUHpoaWc2Zk5SQnVBelRJU3J0QXE5dnRDb1Npc2JjNEZTdXZnaUkv?=
 =?utf-8?B?UlNzQjV1NjNCNXRMdXNCRnFRL0tWa3h6Z2k1RVlMUjhSVksyTkdWSGhkRlZV?=
 =?utf-8?B?eU5XWkhOc0Z4Vkg0UzBZREtZd0RtYzhVeTRMVG1wSUxHSjNiZUFIOWhqUmFy?=
 =?utf-8?B?ejlMUjdwVXRMMTk4Q01mTXZma09LU0prbGxwUWgvajViT2JpUUpETDN0VTJ2?=
 =?utf-8?B?Z21xRzE5S0dwemh1ekhEQWJ3dGorc0x0d1ZwTVNwMXFLdVpLa1JsN3J3R3M1?=
 =?utf-8?B?SUtrdHpEQk44aXNob2N4K0RvSGdxSE53cHJ3d0cxSGZJWThVN0s5anZ5Ylls?=
 =?utf-8?B?Y1d0bTZ2RmdqQ0tZRTBnRVJneUE4ZFJQZW9NL3lwR1I3czJQeGxQQzlURXhY?=
 =?utf-8?B?N1V2TW1aSzNJbmVWTUZaOVNlWGhjZ3RnakZnd0JJVlpUbzhpa1pzdjBIU2NX?=
 =?utf-8?B?blNhdVdoVHlDbXY0N2YwL0dlQStHeGJhUzYzRENtWEhOYWc4anF5RDREWE9m?=
 =?utf-8?B?Znh4QktYa0RSVzRBMVo5VmtyN0FidEwwSExCYmpFVjREcExVbUoySEV5NHBJ?=
 =?utf-8?B?dFZvWC85MFN6d2k4TE1QVnhySVAyVlowQTJBd3RtbGpPRDFGWEQzbHF4cnpi?=
 =?utf-8?B?WFpTMFFxTXd3M2ZnWG5CSlFjUlUvWTUxMEtsS2orODEwaXFLaFdYTUM3S2FY?=
 =?utf-8?B?MDR4aU9zUlFJTEtNQ0NpNjl0U0EyZ1lUU2xoVVppMkVSYmRMaFVMc0l1MTVK?=
 =?utf-8?B?Z3VtdU5NRTZyUE5XRjFTMU1qWGRYNDQ0aDh3MjFHUHpyREJaMXFDd3FBUzEv?=
 =?utf-8?B?RkE5S0dGWkxMdWp6UUpsTXl5UUVDNFBvN0dsUm5pU0M4R1ltbDN1eW5uR0to?=
 =?utf-8?B?MmduaGU5L0tpN3MzOG85dVRacHMwOUVKdVA3WlZyeU5ublphYkxxSTVVcHpX?=
 =?utf-8?B?R2NaSmlrUTZRU0o0TFV0ZCswVHJLUkI1TjNnR3R0L0w0ZHBMZCtSRnF1RENR?=
 =?utf-8?B?MUpDemR4VkdCei9ZcmhFREF3aFNYRmRHb0U5MXkyczJLUWhnbXphLzRvVFJu?=
 =?utf-8?B?K0VSRjMvVytFL1lnVStXRlFQaVJNSWd5bDVUc0wvQzhTRmNsWFhlKzFYWW5t?=
 =?utf-8?B?Zzl4S1ozRjNHcldoS1Vmdk9kTzFqdDAxMkpjNVpZeklvV3dJUGhLdmJnYWxI?=
 =?utf-8?B?dDJ5RjNWbUIveEZrVEFwVlRHam11andId1BNWmowbGgzclRhZlltN0J3RnE2?=
 =?utf-8?B?dy9NRTBGNmNWdzlRa0d4T0xzV3NqakkvYyt3MUwyVHhWaUd2c0Q1ek8yWXhF?=
 =?utf-8?B?U3N3d043VTUyekhRRU5yRlNIbGpzYjdtSzlSb2NaY1B1b2hJYm1jbTdseTFq?=
 =?utf-8?Q?tBR5kbelw5lAUDybe1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed6d0959-5702-4604-a60b-08dec6d4aa6d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:43:03.0991 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1MtfmOU9+LbHWpNOISSOFPQBmej/QgZWrEpbPiuoJ3oXHLaD0tCSgpmxZjoieCO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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

On 6/10/26 08:03, Srinivasan Shanmugam wrote:
> The current EVENTFD UAPI uses a userspace-defined event identifier.
> 
> For render-node event notifications, userspace should subscribe to
> kernel-defined event types instead, allowing the kernel to define event
> semantics and signaling sources.
> 
> Add a shared AMDGPU EVENTFD event type enum and update the EVENTFD UAPI
> to use event_type instead of event_id.
> 
> Value 0 is reserved and rejected by the existing event_type validation.
> 
> queue_id remains part of the UAPI and is used to distinguish
> queue-scoped subscriptions from GPU/device-scoped subscriptions.
> 
> Eventfd signaling remains notification-only.
> 
> v10: (per Christian)
> - Add a comment clarifying that the flags field is currently unused,
>   reserved for future UAPI extensions, and must be zero.
> - Introduce event_type directly in the EVENTFD UAPI.
> - Remove the INVALID event type; value 0 remains rejected by validation.
> - Squash the event_id to event_type rename into the original UAPI patch.
> 
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  5 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 36 +++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           | 43 +++++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index a75c68195df9..54bc31ee795a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -460,6 +460,11 @@ struct amdgpu_fpriv {
>  	struct amdgpu_eventfd_mgr	eventfd_mgr;
>  };
>  
> +struct drm_device;
> +struct drm_file;
> +
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv);
> +
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
>  
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..aaa4dd57099f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL, amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  	DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES, amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(AMDGPU_EVENTFD, amdgpu_eventfd_ioctl, DRM_RENDER_ALLOW),
>  };
>  
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index f5719500527f..f7c750094393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -634,6 +634,42 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>  	return 0;
>  }
>  
> +int amdgpu_eventfd_ioctl(struct drm_device *dev, void *data,
> +			 struct drm_file *file_priv)
> +{
> +	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
> +	struct drm_amdgpu_eventfd *args = data;
> +
> +	if (!fpriv)
> +		return -EINVAL;
> +
> +	/*
> +	 * flags are reserved for future UAPI extensions and must be zero.
> +	 */
> +	if (args->flags || !args->event_type || args->eventfd < 0)
> +		return -EINVAL;
> +
> +	/*
> +	 * Queue-scoped subscriptions are enabled by the later queue-reference
> +	 * routing patch. Until then, keep queue_id zero.
> +	 */
> +	if (args->queue_id)
> +		return -EINVAL;
> +
> +	switch (args->op) {
> +	case DRM_AMDGPU_EVENTFD_OP_BIND:
> +		return amdgpu_eventfd_bind(&fpriv->eventfd_mgr,
> +					   args->event_type,
> +					   args->eventfd);
> +	case DRM_AMDGPU_EVENTFD_OP_UNBIND:
> +		return amdgpu_eventfd_unbind(&fpriv->eventfd_mgr,
> +					     args->event_type,
> +					     args->eventfd);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  /*
>   * Userspace get information ioctl
>   */
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 9f3090db2f16..bf4fc61cf0c7 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -39,6 +39,7 @@ extern "C" {
>  #endif
>  
>  #define DRM_AMDGPU_GEM_CREATE		0x00
> +#define DRM_AMDGPU_EVENTFD		0x1A
>  #define DRM_AMDGPU_GEM_MMAP		0x01
>  #define DRM_AMDGPU_CTX			0x02
>  #define DRM_AMDGPU_BO_LIST		0x03
> @@ -79,6 +80,8 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT	DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES, struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_EVENTFD \
> +	DRM_IOW(DRM_COMMAND_BASE + DRM_AMDGPU_EVENTFD, struct drm_amdgpu_eventfd)
>  
>  /**
>   * DOC: memory domains
> @@ -204,6 +207,46 @@ union drm_amdgpu_gem_create {
>  	struct drm_amdgpu_gem_create_out	out;
>  };
>  
> +enum drm_amdgpu_event_type {
> +	DRM_AMDGPU_EVENT_TYPE_USERQ_EOP = 1,
> +	DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET = 2,
> +	DRM_AMDGPU_EVENT_TYPE_MEMORY_EXCEPTION = 3,
> +	DRM_AMDGPU_EVENT_TYPE_SCRATCH = 4,
> +	DRM_AMDGPU_EVENT_TYPE_GPU_RESET = 5,
> +};
> +
> +enum drm_amdgpu_eventfd_op {
> +	DRM_AMDGPU_EVENTFD_OP_BIND = 0,
> +	DRM_AMDGPU_EVENTFD_OP_UNBIND = 1,
> +};
> +
> +/**
> + * struct drm_amdgpu_eventfd - bind or unbind an eventfd to an AMDGPU event
> + * @op: operation type, see &enum drm_amdgpu_eventfd_op
> + * @event_type: kernel-defined AMDGPU event type
> + * @eventfd: eventfd file descriptor
> + * @queue_id: queue identifier for queue-scoped subscriptions, or 0 for
> + *	      device/GPU-scoped subscriptions
> + * @flags: must be 0
> + *
> + * This ioctl lets userspace register or unregister eventfd notifications
> + * for a render-node event.
> + *
> + * Eventfd signaling is notification-only.
> + *
> + * USERQ_EOP, QUEUE_RESET, and SCRATCH are queue-scoped events.
> + * Userspace specifies @queue_id when registering these subscriptions.
> + *
> + * MEMORY_EXCEPTION is currently GPU-scoped and requires @queue_id = 0.
> + */
> +struct drm_amdgpu_eventfd {
> +	__u32 op;
> +	__u32 event_type;
> +	__s32 eventfd;
> +	__u32 queue_id;
> +	__u32 flags;
> +};
> +
>  /** Opcode to create new residency list.  */
>  #define AMDGPU_BO_LIST_OP_CREATE	0
>  /** Opcode to destroy previously created residency list */

