Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CE3C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 13:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7246410F8F8;
	Fri, 10 Jul 2026 13:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2yEATduM";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD8F210F8E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 13:47:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifyzMwRbOItps6B5xpSudkiZwk6T9kAZvkqU3yNXtlBvXLF7hR/y4Oi1L08NFAaTrNTzn1JmWW//SGkOS7Mik6e8fUyfYUYCRAZa/pzdRh2gVH47gtVhXvTQvWfVoemyd2TAnC2Fmhk41qrOXMw/c1Vck1hbfRt/Rxl1MqXqr1wROIH5d3IA6zRIaAiTeMWZX4Hsf2IZu8BHvmIn1XvNvkd7cs+kgOLMI5v6qQ7+NVjZcje/uFPOE725o4x1hWD8Z9hVECqQn0iEjbtPZKAXk+wUKlXeHqQMXAkRzjBHzOKfLrnadcEqQQK4YL/hZ0oNnI2MlmFCTDD849Sc1JJVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBzt2e57vafjA5tcYbmcKIAuBbxsiWWXbHwCeL8idoc=;
 b=jxt/LKcqX6qWmx//f4Pg2Z4Sl7vxjxkSbS/ZpCJgbJ+/i6pRMjL4f6lEVoNVKewvHYoyr9jSY40gro7uI8XDLrLlYc/PRC1yEYlk35XiG+ssWV5sWBGe1o03yOBhG0PZxvPzwXLWf4nKciFhverjic35xfoQW7YzACBRFCSeGzzeTWlXK+17OdQluRiO9C9k3LSOvO1LoGyo1MJvAZOEj2ZSq0fwhLORvYk/YKhMnjkflq0Aj7JmEMMfZbGk+/9X4Ad6P+Q2JyT8FvdvLDHzpIjTuAuJE89Mk4TjrK5/ix/geEGtUamWZ6048Swc/Idd/VihmNcAp/QSKtzkrO6iqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBzt2e57vafjA5tcYbmcKIAuBbxsiWWXbHwCeL8idoc=;
 b=2yEATduMZZd8+mbiqfN0Hc9oZMaGmNBE7EmeLMdRCMwLj1meRZZzkNvsEJaLkzsqBl7pDaArriQ7o6nffaD6CBduyXuplZ9JhAYqvylUE1eFQ89apKerpTRpTKq8z3f/V7YAseX8ijivlyV5WV5cJWIgOjOxNe79mbylI3aS+3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 13:47:40 +0000
Received: from CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c]) by CH2PR12MB9457.namprd12.prod.outlook.com
 ([fe80::85a8:1df:840a:cd4c%5]) with mapi id 15.21.0181.014; Fri, 10 Jul 2026
 13:47:40 +0000
Content-Type: multipart/alternative;
 boundary="------------fo0c50bLSxkqLsLDD8Gm6RFF"
Message-ID: <04d7a46f-3bba-412d-bfd4-89292d11e1db@amd.com>
Date: Fri, 10 Jul 2026 21:47:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Do not fail process debugfs setup on debugfs
 errors
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Felix Kuehling <felix.kuehling@amd.com>
References: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@amd.com>
In-Reply-To: <20260710112938.3225738-1-srinivasan.shanmugam@amd.com>
X-ClientProxiedBy: TP0P295CA0044.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:4::6)
 To CH2PR12MB9457.namprd12.prod.outlook.com
 (2603:10b6:610:27c::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9457:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: e73262bc-9450-4547-bb97-08dede89cef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|6133799003|56012099006|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: OD3dELR086X2NyhFgreyyQYo/WQHD9hp9HsR8PJRFkv6LxGCJZUndvqr7shfjvddGmRaV4OJ9ND8OpgqXNPmKnSHG4vRPzVe9bCgX2Z6wqbRaAjDvg2rR4zH0yGLT6I5bcwjb/TFp9dhfUZi1G0MG2dW2ILAWRrJ6ZHhsIA7P7XbAgDzavccC3bzzE+q9jCFmWuThv3Li0ZQUuxQ70Tl/MTQH6Sf9IuF4K9as/vRw8Yza8kNVFfEXMaqwHkKmMoN7gwrjRBCxbd+kdS+NbOwUTN6hjccbo6Y+VULVAXXPykaLXJHPyzDycxrvMPcemCxae+H5JRXeS/xmqgYZLVRDObZoeSaQzZm0mXHCPJEMwFEg3WbW2qu2yyHt6JJov/z4/Q/Hao1QbZd8Rhs7xujuCg0PHiKBg0Fz+eAaw6CsiyNIVtl70Ubg2UVhsUNUSYKixzu2kodwFgU0desLcLSK3ApLw+5UGU6S41P8ACH6bP59JIIhc45vWcejC+q2mgzH3yAKyZ0XZogV37LlVbtBwqz7sUExlLCGx62tnrWVsQ3bE/HL0b/UPVktfGkJUV9+yVBSzVaEtMMaMIbhePwU8eFntp8HnI1ru2jqRo5867iaopVQUtOe8roJQd6ttrIWo2G9Q3l318CoxmoqZZwDVb7Z2HVrJ1cO3d8inJtz+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB9457.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFFQQ0VlNjFGRENON2c1NEpTV1BxZEdFaXQxZTJRc2ZvTDYyWElEWDh4c2N6?=
 =?utf-8?B?UGVzcXZTcEpIOVlvUzBTQnhRbUhyaUc1ZkVCb3JaNzRoZFpNcEVKU05vNlpM?=
 =?utf-8?B?WnFpQzBGZkIzZXdodWNZcldxMkdOQzhpYnFqZ3gxVFk5dC83UW5tTE92ZU1q?=
 =?utf-8?B?emxaRGlnb3BXV3VLVkRVMDZZU0cxdG9QR3h4VmtXUk1xL3gzT1gzUEZrQ09F?=
 =?utf-8?B?cytOT1NKbzA5eFFOMExjT2tLU3NyU0JIMTFzdGZJeFJxaTduUmxrVjBMUzRi?=
 =?utf-8?B?azQ0S0hTK1lNZTI0ODk1WDhCRG5nQnlCV2Z0OGgyRUpxRzZ2MW5HRkFKaG1u?=
 =?utf-8?B?ckd1bW8wZVQ3c2lyL0drbVNTQlQ1S2pmdnN5RzVHRmthOC82MTVlekx5d1FJ?=
 =?utf-8?B?V3lvbnQ2bGxLWGdrTG9IYWFneVErMk5BTFlKVHVUSFZlekxsVWJ5Szh3blZv?=
 =?utf-8?B?TWNFZHFNaEVZYm5DTmZPQWxhSzdmc0dnNGxHSzZBUDFrRVRCQTE4dDAwL2k3?=
 =?utf-8?B?VnJGOElkV213TzRYYUNnQVB3bWViNmRjSTRFamozWFBrNXdMZkFMM2llN0Rq?=
 =?utf-8?B?YlVQOExuc3VOVU5sNHE2VGpxN3czR1JXWEpMM2hqaVhkSlJBS1ZqcGdnc3dW?=
 =?utf-8?B?eHd6VWJsbDJ3SDQ4Uy96WUpEdUxWZXBlemV4cW54VXMwblBoNkdndVVuZVl4?=
 =?utf-8?B?Q2xjVDZTMmlCbmVxSTN0N0FOeURFdVc2dEJ0elVQUXZudzFLcFc1NmdqSFdM?=
 =?utf-8?B?NVNOR01jdDMxTlJ6UVBCbWJ4bTMrcU5pU2tmbkhvaDZocmtTdnhZLzJieXhK?=
 =?utf-8?B?NW1DZXArcnAyWlUzVmIzczJNT3FVckpKbTZNRzUxQVFDcFNvcGlqaXRwekIr?=
 =?utf-8?B?aEEwZ29hbGtRdmdQYlVKRElsUUl6SlNTcFprWTIwZUxiU0h6YmdnczU0YytF?=
 =?utf-8?B?elhoS29UNmhYakxsSStPVUZvbnBzbFIyUUdPNGJoSjRTS3VOcFJvYmhybjEx?=
 =?utf-8?B?TlZPTHNUemRhMEJKam0vS3lXVWVFZDdNWUtiMlBYMk0zb0RwenRCbGR4VS85?=
 =?utf-8?B?VnI3Wkp1TmhsL2xndXRkOU1RR2hyZS8yZ3pkRFZhb0NsWjZBVzdRVHVMUWVL?=
 =?utf-8?B?YmIxclVNT0I0Yk9qdUwxejBpdDBCL1JKSjVuUC94bzVyNzJWNUZ2WU9ZalZK?=
 =?utf-8?B?eXptNHpTbElUTVNnSXBMaDhZYU5BOE02ellxYTlHREJkWUpDTGdGRGQzL0pG?=
 =?utf-8?B?NUQxL0RJKzFhOTg2ZHVkeUczaE9nS0p5eXFkemFKTUtGMTZyci9taGFJTEJL?=
 =?utf-8?B?T3BZU0o1cXZvTVpjTGxkNWw5MFZTRkRqc01BMkJHWjJLM1ROZG5rMEtOVnpU?=
 =?utf-8?B?b0RHOFhROHZjYVdKdzY5V0pnYUtTcU1hSzh5Yzg1eU1XbkJXd2E3cE5SMGg4?=
 =?utf-8?B?YjVBWllwYWdtaXdEckdpN0cvMHFuZUV6RnIzalNYeEFrNWQ3cDM4VTRxdndT?=
 =?utf-8?B?TDR3d09zYk5JTSsvTzlXY09Ib25JM013TmpvOWJHNXY2WDU0SWVkaXJzTHds?=
 =?utf-8?B?OHhQUm9SU3RhaUNScjRNekg2M09vYVorQWljNTNpNndhcFU5UnN0cmNwMzRu?=
 =?utf-8?B?VThUVCtDY25Ea1ZrSDgydEV4dXNKRWF3OS9ERk9iOE5HRVZhRVZ3ckQrWDJz?=
 =?utf-8?B?ejl2KzV1RnJsRkxmS3RuUGlJWjRyaUNtS0wzZmp3Rk9GWWJFUlJ6bkQwVjAr?=
 =?utf-8?B?bGwvQ1E2aGFyV1hyQ0cwRUFUMncvbHBVZDVvdmEvQ3J0UDBYcC9NMXViN3Fy?=
 =?utf-8?B?eFRDUlkwUDducWRCUXlrTzVJRWFGaTZ1QXVFRElGNFdzQ3U0U3VrOU94bjF4?=
 =?utf-8?B?SEd6eDdpclNwMCtXOEJheTlSdDgvNnZMclBsK1h1L3hJTC9GR0VpS2NIT05P?=
 =?utf-8?B?ZTJLV1VDYjhRR0xGUUNFcmJYbWZLUEIwWE5oZytuT01xMjYrWmNicThGa1lj?=
 =?utf-8?B?VVRaWVFPTmYxZEVoWjR0bDVHZmlLZHJrT1U5SXYxL2szYTVGVWttWE1KR1R4?=
 =?utf-8?B?MUZFKzdybjlWbFZxWXBRMnkxSTVsZVFEcDV1NVVnQTNmVXYyaXR0SXdIKzNw?=
 =?utf-8?B?RkF1MzZzYXE3WUQ3bHV1ZVB0VnJicHdKVWkzN0dwWGdQWTVXVG5kN1haMXo2?=
 =?utf-8?B?Y0JkNnhORTk5ekl1OUpvWWxZNjBLenFJMXRkd3gvbFJCclphbmx0ZFdKaVo5?=
 =?utf-8?B?WDYvRERpOG5xS1VSUTZyVzhGTEZ5L1dGMXZHRS9VWVlzNlpzcFhUQmZ6VWth?=
 =?utf-8?Q?pFbzS/W8NBV7HBID9T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73262bc-9450-4547-bb97-08dede89cef7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9457.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:47:39.9398 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHu7jOZ8tPD2+HoeFiH8maImKEp8UmgjMYvvUowjnTdJyHvTcs9D9hyvkEDBTBOZ/nKtP1NDKxiA7uo1W9npTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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

--------------fo0c50bLSxkqLsLDD8Gm6RFF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:

> debugfs is intended for debugging only, and failures to create debugfs
> entries should not affect normal operation.
>
> Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
> If debugfs entries cannot be created, continue without them instead of
> reporting an unnecessary error.
>
> Fixes: 22ab1bb3994a ("amdkfd: expose pasid of secondary contexts by debugfs")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Zhu Lingshan <lingshan.zhu@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> index 02673f01b448..7c5bc9c4559a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
> @@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
>  		entry->proc_dentry = debugfs_create_dir(name,
>  							primary_entry->proc_dentry);
>  	}
> -	if (IS_ERR_OR_NULL(entry->proc_dentry)) {
> -		ret = entry->proc_dentry ? PTR_ERR(entry->proc_dentry) : -ENOMEM;
> -		goto err_free_entry;
> -	}

We need this check because debugfs_create_dir() may fail.
Removing this check leads to entry leaking when fail.

Thanks
Lingshan

>  
>  	list_add(&entry->list, &procs);
>  	kfd_debugfs_create_pasid_files(p, entry->proc_dentry);
--------------fo0c50bLSxkqLsLDD8Gm6RFF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <pre>On 7/10/2026 7:29 PM, Srinivasan Shanmugam wrote:</pre>
    <blockquote type="cite" cite="mid:20260710112938.3225738-1-srinivasan.shanmugam@amd.com">
      <pre wrap="" class="moz-quote-pre">debugfs is intended for debugging only, and failures to create debugfs
entries should not affect normal operation.

Remove the check for debugfs_create_dir() in kfd_debugfs_add_process().
If debugfs entries cannot be created, continue without them instead of
reporting an unnecessary error.

Fixes: 22ab1bb3994a (&quot;amdkfd: expose pasid of secondary contexts by debugfs&quot;)
Reported-by: Dan Carpenter <a class="moz-txt-link-rfc2396E" href="mailto:error27@gmail.com">&lt;error27@gmail.com&gt;</a>
Cc: Zhu Lingshan <a class="moz-txt-link-rfc2396E" href="mailto:lingshan.zhu@amd.com">&lt;lingshan.zhu@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 02673f01b448..7c5bc9c4559a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -211,10 +211,6 @@ int kfd_debugfs_add_process(struct kfd_process *p)
 		entry-&gt;proc_dentry = debugfs_create_dir(name,
 							primary_entry-&gt;proc_dentry);
 	}
-	if (IS_ERR_OR_NULL(entry-&gt;proc_dentry)) {
-		ret = entry-&gt;proc_dentry ? PTR_ERR(entry-&gt;proc_dentry) : -ENOMEM;
-		goto err_free_entry;
-	}</pre>
    </blockquote>
    <pre>We need this check because debugfs_create_dir() may fail.
Removing this check leads to entry leaking when fail.

Thanks
Lingshan</pre>
    <blockquote type="cite" cite="mid:20260710112938.3225738-1-srinivasan.shanmugam@amd.com">
      <pre wrap="" class="moz-quote-pre">
 
 	list_add(&amp;entry-&gt;list, &amp;procs);
 	kfd_debugfs_create_pasid_files(p, entry-&gt;proc_dentry);
</pre>
    </blockquote>
  </body>
</html>

--------------fo0c50bLSxkqLsLDD8Gm6RFF--
