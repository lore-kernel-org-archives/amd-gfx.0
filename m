Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90B3606A326
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 18:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=koQlfK4a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A45B10E3F0;
	Fri,  6 Nov 2026 18:15:51 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012048.outbound.protection.outlook.com
 [40.93.195.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40ECE10E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 18:15:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jRL98iR0QizDgrkIO5R/kOsBIheIF2Me12c6ffCNaulxj3oS+XFpvMQYvAZcO/rmisIm1nLcpqOTKm45dD1NU8R7t+3ZF+tSfaS9oJbMwv8XmNmvxUEI1RPuzXcHmeNsQk8PJzvXFwisB+c7s0fIK8WqLfkQ6fI/NmnAEq81S1Dpc5me0S59Wxkv7+pFdvvBWkaApOAOLF269zfiVidajsupcUZ5SS99pEzez59RCpAZ8O0bpB75Xd2HS0oMk1FEqn6QiTxCYir1hbl3ca8qcbSp8VqwYigucVrGJlHURvTGEZfrxOQRMzvOfdjGMLfQ46G2qutACZum60jmHdLmrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7Ek1/3A2e9L/ERwJnUNX1P35vMkfUhpJEIAEB2Y/4Q=;
 b=WHhQRvl4Dtoip5jUpz21RaWGSWARckm4ogVWSCoVducwrDixCgSLJCSJZf5l/8gYKcpVTN+DIxd6lHIZgvzUnG8XB8KkOP0gbYQ9KGvsa4CW+SbVcTugmHWxx/GTP1VO1A1X1E1I7uxuSMdu8sDVtCs6tTHa5T4/IZyTnXeLXyz5DbCbChKKCFxnqWSnsoXItQKFHUvdJHYyVWcibTTSCT68ngg2gZTL6M7lmFwBLm0M4tlUV8Dvg+yaYvbdUbC738nksyp+IGn36bUjKWyJ5JF/AQC+gNSNagzJuGzmSxsTh6YiZZd3rJ0DK5wbupXhOKkJJpX9IgIpzqvvMTDXuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7Ek1/3A2e9L/ERwJnUNX1P35vMkfUhpJEIAEB2Y/4Q=;
 b=koQlfK4abq7lxhiRjVu9xMWKp20IZX1AOf4JkhLLUPqPvqJBnTTiRDy53zfAbn8nQCG+pZhCdTFUVlFT1ErY/+qK5QJfwKLRwv91HK4+hrX+97enVEIgU+HKlH+H2snGhOHyBF2M/lg/mf3kk0x+n+ooGIP4v8CULpguPdARLCs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18) by DS7PR12MB6117.namprd12.prod.outlook.com
 (2603:10b6:8:9b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 18:15:41 +0000
Received: from IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a]) by IA6PR12MB893085.namprd12.prod.outlook.com
 ([fe80::3f4e:1f38:3db2:270a%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 18:15:38 +0000
Message-ID: <06d278a4-fd0c-4a2f-9a9c-ae89ac12e740@amd.com>
Date: Fri, 6 Nov 2026 13:15:36 -0500
User-Agent: Mozilla Thunderbird
From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Commit panel_power_savings writes
 from the kernel
To: Hugo Sales <hugo@hsal.es>
Cc: sunpeng.li@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20261102-abm-sysfs-commit-v1-0-e5addfd9539a@hsal.es>
 <20261102-abm-sysfs-commit-v1-4-e5addfd9539a@hsal.es>
Content-Language: en-US
In-Reply-To: <20261102-abm-sysfs-commit-v1-4-e5addfd9539a@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0321.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::15) To IA6PR12MB893085.namprd12.prod.outlook.com
 (2603:10b6:208:601::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA6PR12MB893085:EE_|DS7PR12MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: eacbdf45-38a3-4dfb-d290-08df3c31f58f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|11063799006|5023799004|4143699003|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261009223027099003|261009221227099003|261102123227099003|261026140227099003|261102130727099003|261026121527099003|261028144727099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: IVgr1Wqzb8BiDs1lxNdPML7UBEYAkUwSpUcVpTnLvEHZYaxPAmJ9KFzFfOAVgLW+sWSHpf8ZeKkg65Mat2unyECWTZLwLufYO9XWqDXbEVaxKtHU0j0hRfmlU/JDMtQxgMoC6i+5mrG88cV6cyCAAbsDadQK06F+B6M+aB8x0MFvYXMToR2ISmU9UhTyyjwQWb9DDvabNQXHNDD4e/3w4lvYl6oqjoCBlATGbWEwkequdcHzCcp2XM8znI4dr0Uu/sTNNUISQkonO9VaS0KW0y4xupZ9i/4qVDYLW7G2y/FzImI8nkRmjHjaAyXZrZW18/xdaI1h2RPeauMVYrr+jmV5LwAztjGvtcRZZa6a1ZX7r3rRRxlrKlFG9+RPzxi5cJZm7gNhwnXDAKYSyTIftA3uLcEnRBC/1LLEJT1O3N+Z6EZ7zzbLzLnUlZIzxGtRO4xGu+souwN93x/kCItullB3ik+pVT73KIHdnBWdxmgz/AbkzOU1xg55c8+iUhBjw+FgNhYS6SruztZDXe78e5DB+nqtLylXCWC/e+NncKiPqqGXVGNszdxOZZ0y6s4Ne+SbmbuRA5BaqZZZfC/dqKZRunp+/hT/k7lDyrp38SIJhJ3EXCvPhucYLkCWoQbfM8obkxAQRSkn9apD15N+etlWRfVaalaeycKuoz8mqt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA6PR12MB893085.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(5023799004)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003)(261009221227099003)(261102123227099003)(261026140227099003)(261102130727099003)(261026121527099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mzkvc1R1TWM4MXpHRGVvLzZLK25WWXB4ZzZjdnVrcmVISzNiZ0hsMkczc0s0?=
 =?utf-8?B?Nk00Y3hnRTEvdzRGSFhCMHEyZEhhdTYwVUhxRUJ5OFM5OG02dk9ycHNMWFla?=
 =?utf-8?B?WUNjVjYyZVU5ZDdEWDVYK1RiTlY1cDlPTGNQa0NmWnM4V1gyekxIdlFvSitY?=
 =?utf-8?B?TzYyM3YvVStoaWZOUnN2V0E0Y0hOZ2dSODNFQjdrUUJaMVhzVFJZOGFWOGlp?=
 =?utf-8?B?aWxHOWt2OVFYQ3lETVUzOEVmZGpWTEFxNzk4Y1BhNko1OVNsSnAwbmRvdXov?=
 =?utf-8?B?YWNOL2hGQWZZUWVOU0tQQm1RZnYxaGRNT3llVkdETW9IdGZoemRWY2M1SmNE?=
 =?utf-8?B?SFJKQ1ZDc1RiUFhpNkxNd2piS0R2TG84YUJkdlRJS29HQ2NSK0lPS25vUEs0?=
 =?utf-8?B?QTQwVC9tbmZocDd2Z1p1YUNjM0tPNUpnZS9oM2IzWVFESlJkT2xLbEhZU20y?=
 =?utf-8?B?bEEwWGIwYkQvSjJFNkV0RWYvMlNYaTFCakVsVnBZckRadlFXYitsbWdwaHB3?=
 =?utf-8?B?NU5PNnVDaUV5ZTAwK3pqUnhWaU1LdXhyNjRHam1vQjlnMGd6QXlRQzd5Z0Ri?=
 =?utf-8?B?RnBDbkR5R29jVi9HeHhmU2htOW5KbHdZdFRONHJxRGlEdGFXSXpSTnROVW55?=
 =?utf-8?B?L3BpMithYklaSWdzM3NjdkhaQkw3TVgrZzR3ZTM1NTF1cWpjUEFqd3BWWTRX?=
 =?utf-8?B?ZU1jL0ROaHk2MzhtWXdUVlRaY1VnM205MytTa1dONEdiWVFoNkhKVWFZNjlP?=
 =?utf-8?B?dE1JbGN3TjJ5YjY5UzErZnZCdXc5dXhVMWdNTThzdm10cWEyaDB3Rk1KL3dR?=
 =?utf-8?B?Yk5XeHNZak1zOHF1b3krd3RqY3h4Z1VNSlFYeEo2L2FGM1EraTlaLytUbjFV?=
 =?utf-8?B?Mk5wck9ZVGhlTzRzZnkvZUhnU1RhWlVaWUNRU25BTkdzcmxOUzVrcU5iN0Fu?=
 =?utf-8?B?SmIySFcyWG5HTUNxcGZDK2wwRWxnY2EvTGVpZU15QTNXSm1qSE5XdGRwTkdY?=
 =?utf-8?B?SGl0WVlCR2FvbUZsNE1MRWRBQnZtVmVPaE1mM3lYSTRyV0RMM0JvL0kvYVEz?=
 =?utf-8?B?Wk1xaVFVQndpV3I5K2RpcWVRYWZzdC8yTG5ZQ3dzdW9WVktTNDM3N09ZS0lB?=
 =?utf-8?B?dkgwOEN4bzFqVTAxWWJoYWRKRUhURXVZT3ZSM0E0cjQ5eHY4dmUzblp5a3NL?=
 =?utf-8?B?UStmUnVKUTVJM0RnMG41RFNsME9HdDRHb08yKy9idlljSm9uL3RjV1p5cDRi?=
 =?utf-8?B?NmJlQUthYmRScE55WkUvR1ZuOVc5azJUQjE3K3llM3JPNWo3MUNVbzU0czVq?=
 =?utf-8?B?dHNjK2RQdlh4WjBKdzBlTWhkaVBNQSsyTjJaSU1Qb3ZqclBHNTAwRkgrTFNR?=
 =?utf-8?B?V2ZXR0lUVlc2UEJ4TVM5d1pYQ1hzeXRlbzZiUnVtaklHSFpjb0FYQ1VQWE1B?=
 =?utf-8?B?cHJ4b1VSSHlpZHg2aW40OU9ZOXVIZCt3Nmw5SFVjeHVNb2JBcnhhSHd3TWlw?=
 =?utf-8?B?OFZULzMydy9PR1NQUGZQL3p5dEFYRXQzVU84V1BRVGhJMEhrS1hXSTc4Wnkr?=
 =?utf-8?B?VkkzcDh5OW8rL1lzYnVvUUFmTjUxcFhnak4vdEQ0M2VET2p0Tit3VTI4RTNE?=
 =?utf-8?B?Z3ZYUm5UZkt4UVRPMTU5TWtlM1ZDalNqaWZaNEhrNmhtcU9Ea0xybVdqL0t5?=
 =?utf-8?B?Rjc2ZE5zWG9PQ1NvZk9KRjN0NjBIQzlzTnhKaldIVXlWaG5xYlZGVFcyZHgz?=
 =?utf-8?B?MjJ5a0FUdXN3ek45RWFPTzRsVURkaWtmY1ZYVUdOYTdydFE3UGVzalk5MWI1?=
 =?utf-8?B?ZjhhUGtYbGlTWUd4a1dNMmQxZHpudVVTK3ZBQURPNC82OGRrOGtmakdCL0ox?=
 =?utf-8?B?enVUWktBMVdxTGdFT0JqUHZjUG1OeEpxV1R0NDVCT25yTzNxYlRWZHlLWnAw?=
 =?utf-8?B?S2c4WkVCeUdGYnBxMmV4eElrejJqeHdoeStYMldiVFpMR3ZzTUh0K0VEVlNo?=
 =?utf-8?B?UGY1eERzK0lQYkpZZTdkU2FYUUs5ZUtkb015eHE0bGxVZ1l4d1pkUUlxS1ZH?=
 =?utf-8?B?ZjgvZm1BZnFvaHJrL0M5ODlFYjc3Z29US0owS3NTckM3eldhWFFpOSttcXFz?=
 =?utf-8?B?YVdGUHl0bFVYSXk3Y3pma3ZUeDMyMDJPN3dkKzFuNVVZY3BBdzJKNy9aVGUr?=
 =?utf-8?B?VzY2U0k4NDFLSFI1ZXpZb09JR2dRTDJ0NTBjRlFkWTlaanBLcFlHRWFUZDF4?=
 =?utf-8?B?b25XL3J2eDVUSzlobmNsdWFuVXZ4NU53MU5LSnExSWxNWkswUzFDMldDN3ZE?=
 =?utf-8?B?amtSSEdMaHUxTkU0QjJYRVk5M005NTVWZzVkcjk0QTIyYWFncjQ2QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacbdf45-38a3-4dfb-d290-08df3c31f58f
X-MS-Exchange-CrossTenant-AuthSource: IA6PR12MB893085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 18:15:38.1522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3vdNbxXdAos+rNNyYibo8+U/wIi/oko6s+eg3M6zNAwoHr6TZGejyy+4DYOKMmqS8+HY8PD/VjHE+pdTv8lFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6117
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 05:17, Hugo Sales wrote:
> panel_power_savings_store() currently writes the level into
> connector->state and sends a hotplug uevent, and the hardware only gets it
> on a later atomic commit that includes the connector. Hyprland adds the
> connector to a commit only on a modeset or when a connector property it
> sets changes, so it never applies the level
>
> Programs that write the sysfs file, such as power-profiles-daemon, aren't
> the DRM master and can't commit themselves, so they depend on the master
> taking the uevent as a cue to commit the connector, but nothing documents
> they should. A master that wants to control ABM sets the 'adaptive
> backlight modulation' property, and from then on writes return -EBUSY. The
> file has to work without the master's help, like the backlight device,
> whose writes reach DC without a commit
>
> Commit the level from the store instead, with a duplicated connector state
> and no modeset. The write returns once the level is applied, or with the
> commit's error, so no uevent is needed. A connector that is off gets the
> level when it is next enabled
>
> Document the new behaviour in the kernel-doc
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> This needs "drm/amd/display: Don't force a modeset when the ABM level
> changes". Without it, atomic check sees the changed level, asks for a
> modeset and the commit fails with -EINVAL
>
> A failed write used to leave the level stored and send the uevent anyway.
> Now the level only changes through the commit, so the store reports the
> error. power-profiles-daemon logs a failed write and tries again on the
> next profile, AC or battery change, because it compares against the value
> it reads back. It ignores the hotplug uevent. Compositors used it only as
> a cue to commit the connector, which the store now does itself
>
> The commit is blocking, so a write can hold the CRTC locks for up to a
> frame while a compositor commit waits. The other way round, while the
> store's commit is pending, a nonblocking commit from the compositor on the
> same CRTC fails with -EBUSY, as it would behind any pending commit
>
> The store takes a runtime PM reference around the commit, like the
> atomic ioctl path, and its locks are interruptible
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 90 +++++++++++++++++++---
>  1 file changed, 79 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> index 27546febf90d3..a661fd558686f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
> @@ -40,7 +40,10 @@
>  
>  #include <linux/backlight.h>
>  #include <linux/minmax.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/power_supply.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_drv.h>
>  #include <drm/drm_edid.h>
>  #include <drm/drm_utils.h>
>  
> @@ -691,6 +694,18 @@ EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
>   *
>   * Modifying this value can have implications on color accuracy, so tread
>   * carefully.
> + *
> + * A write commits the new level before it returns, without a modeset. The
> + * commit waits for any commit already pending on the connector's CRTC, and
> + * while it is pending, a nonblocking commit from the DRM master on that CRTC
> + * fails with -EBUSY. If the connector or its CRTC is off, the driver stores
> + * the level and applies it when the connector is next enabled
> + *
> + * If the commit fails, the write returns its error and the level stays as it
> + * was. While the CRTC needs a modeset, as after a DSC override in debugfs,
> + * writes fail with -EINVAL until a commit that allows a modeset clears that
> + * state. Writes fail with -EBUSY once the DRM master has set the connector's
> + * 'adaptive backlight modulation' property to a value other than 'sysfs'
>   */
>  
>  STATIC_IFN_KUNIT
> @@ -712,13 +727,75 @@ ssize_t panel_power_savings_show(struct device *device,
>  }
>  EXPORT_IF_KUNIT(panel_power_savings_show);
>  
> +static int panel_power_savings_apply(struct drm_connector *connector,
> +				     unsigned int level)
> +{
> +	struct drm_connector_state *conn_state;
> +	struct dm_connector_state *dm_state;
> +	struct drm_device *dev = connector->dev;
> +	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_atomic_commit *state;
> +	int ret, idx;
> +
> +	if (!drm_dev_enter(dev, &idx))
> +		return -ENODEV;
> +
> +	ret = pm_runtime_resume_and_get(dev->dev);
> +	if (ret < 0)
> +		goto dev_exit;
> +
> +	state = drm_atomic_commit_alloc(dev);
> +	if (!state) {
> +		ret = -ENOMEM;
> +		goto pm_put;
> +	}
> +
> +	/* Kernel commits allow a modeset by default, which a level never needs */
> +	state->allow_modeset = false;
> +
> +	drm_modeset_acquire_init(&ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE);
> +	state->acquire_ctx = &ctx;
> +retry:
> +	conn_state = drm_atomic_get_connector_state(state, connector);
> +	if (IS_ERR(conn_state)) {
> +		ret = PTR_ERR(conn_state);
> +		goto out;
> +	}
> +
> +	dm_state = to_dm_connector_state(conn_state);
> +	if (dm_state->abm_sysfs_forbidden) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	dm_state->abm_level = level ?: ABM_LEVEL_IMMEDIATE_DISABLE;
> +

It'd be good to skip the commit if the old and new levels are the same.

Harry

> +	ret = drm_atomic_commit(state);
> +out:
> +	if (ret == -EDEADLK) {
> +		drm_atomic_commit_clear(state);
> +		ret = drm_modeset_backoff(&ctx);
> +		if (!ret)
> +			goto retry;
> +	}
> +
> +	drm_atomic_commit_put(state);
> +	drm_modeset_drop_locks(&ctx);
> +	drm_modeset_acquire_fini(&ctx);
> +pm_put:
> +	pm_runtime_put_autosuspend(dev->dev);
> +dev_exit:
> +	drm_dev_exit(idx);
> +
> +	return ret;
> +}
> +
>  STATIC_IFN_KUNIT
>  ssize_t panel_power_savings_store(struct device *device,
>  				 struct device_attribute *attr,
>  				 const char *buf, size_t count)
>  {
>  	struct drm_connector *connector = dev_get_drvdata(device);
> -	struct drm_device *dev = connector->dev;
>  	long val;
>  	int ret;
>  
> @@ -730,19 +807,10 @@ ssize_t panel_power_savings_store(struct device *device,
>  	if (val < 0 || val > 4)
>  		return -EINVAL;
>  
> -	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
> -	if (to_dm_connector_state(connector->state)->abm_sysfs_forbidden)
> -		ret = -EBUSY;
> -	else
> -		to_dm_connector_state(connector->state)->abm_level = val ?:
> -			ABM_LEVEL_IMMEDIATE_DISABLE;
> -	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> -
> +	ret = panel_power_savings_apply(connector, val);
>  	if (ret)
>  		return ret;
>  
> -	drm_kms_helper_hotplug_event(dev);
> -
>  	return count;
>  }
>  EXPORT_IF_KUNIT(panel_power_savings_store);

