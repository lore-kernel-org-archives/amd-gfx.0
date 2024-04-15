Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC535C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Apr 2024 22:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3782510E2F9;
	Mon, 15 Apr 2024 22:02:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vW/w+BFs";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920A310E2F9
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Apr 2024 22:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N66h7VqI2pIFJXbMPEmtcsS7B7UZ+4JpK1ZBVfxtKzkmraDXalzZ91FRzZBgJ0z0onuXh4lymUyk/v+EuNsD7OCteIs66+zsk5ipnsokUtf5yRY6RcIVQxxl6aKel+z6GCrij23cjBkcHI5Eqi11MujWiIT0wKmkdnSJcs5ZBj02U5TIW7VCT5is4n4/lyZ5g4A1riMrh0XFXdV8SfWY8DEo+S4va0k9co5C2TlOjVLL/rC281nPm5w3dF3xuO/mwxF8LZ6H/MZ22z3TxFrUbnKOyLAFjoc9mlZoXJo5a0yD7URJQhBwYMC2vpJT2+qYM0a+rqMsJWJ5hMbUxTanmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8axun9pP27pCiMjA1w0kCCpsscuPoDMGIHhWjt0OAI=;
 b=CQNpKV5m7nh95Nv9cAMd3xJMk9UptNz1p+GVxKN+xjEe6Q1M4DLDykM3ga+T0I+4TQEnRpus8+EJrO51zS0bkZvBYw7ziw9o4GNUDMSsARaZ8+cwZw7nWiC/tTCX+yiX98i1Y7AmnAE9EESostMaUfL+eNhllFUzIYIjubA9pXJ7seL92pwykDH/nH7qIy3AjJD909cN+Gzr6tNqKlq+OGMsFOwAoiHPYm6eJgJBFjx6UjyCTS8Hd/OjcXqeobdC5NbXp+QVZq5k4owpSgChXnsZS+cmaBC67qbU9kNGXGxEFzY+0c/1eR11ByE2dd5ZlCyuzbFLtMX61Q6DCmwbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8axun9pP27pCiMjA1w0kCCpsscuPoDMGIHhWjt0OAI=;
 b=vW/w+BFsaDhKF+0ryocloAiNtYpuNyCQgo7Tb0hQoFyJGzyBSADW8vcX7trGnMsYwRkaIMAJJuK7hZOBAI+CuyACF+71d4mJ8gVkaeRmTjIC3ZPLMZIs2DVjxxLuU4hCDVzMNbLZBqr6OTUk336xzgTp0aN4jFOqjnY/4jBunp4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 22:02:51 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 22:02:50 +0000
Message-ID: <01b794f2-1f9f-e8ac-1c0f-1acd199e09ea@amd.com>
Date: Mon, 15 Apr 2024 18:02:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Modify the contiguous flags behaviour
Content-Language: en-US
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 felix.kuehling@amd.com, philip.yang@amd.com
References: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0160.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::33) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 8feb3a54-88c7-4e91-e822-08dc5d97caf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TF7DmFUQM+hnj0QazOSvZZXdUQgU0sH/ZZR44IpooppVL1s9LLpC/YfhCinqY/O1DHOClgIjdXyocotzlXjOAlb18Dr/JgS+G5VcG8R3lJSLgSG0j8Tpng/EOFsWIAJ3k7UCn6DtxKc8D5mwedm4NC0bd65p3t9H+Cr9UaRIJhHw4KfvO0UpUBjeU/v8qfrawanEJKpQcRS4QhgGY1slT8/DPc4YReIomC0jBoQ2er1kmH06E3F8ClDoFAlbb1GVqEaSc+Q8V9vFPpDS7gs7Ap/fF1tNhUpTxQkUX8kIQVb8OcIlcjxEVuUoAtiJMSM303tn+pQWkc8vP1UnsjQhQjCauSB0epGM0nT4V/NntDjkZjFep47H08BnNfGBCKQsCCebV3xtglLE2+mynb+NoRCZCaceSP6cKecxqo7xk6/AfpD1q6f15RYovmK4g4/sxjRFQzp2X8y5sknFrAhOSIZDPHUaE1JhYkGJ22DjLclZ54Y8LPm3Toj+5TiMHdYNHBWiQs6c/j1xq68ZgSiWAl/XFTM46r7W0V9uXJDVAaKvCBWv4c1sjXOiH42nx+uVrzCLsXu/fxVCLgVKk0jQpmwFtXsec/OXf4oo6iZZMPBaWBE0aVXHnKYTBgy5lhgcBmMMIwB82VgfO9e1612KscIqGMdKb2+FWDpXf1oi62o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzBVV1BKTzJOeFNXTStqaFgxd0FONml2RTZxbERIbnNhQUhCK2hiLzZySCty?=
 =?utf-8?B?ZzI2aDA5MVI0Q3RYZE4rZUtrQUVqN2c5dXp3S1VFeWEyYmgvVWNUTDRjM3Qy?=
 =?utf-8?B?T1U1eFJTVjdOVVk0RVcvRDluK2NQRStGM3JiLzRIYnZxMEYxMzBJMC9FTXpX?=
 =?utf-8?B?Ti9Ra294ZDZ1SklDaGRjdHhNUmpCOTZteUUzMzVocVJkcGJZWXBnbjA0RzBn?=
 =?utf-8?B?NHk1b0o5YVNtN3NVbWs0MC9LSWdrYVJ5aDgwS3F3dU1kYXVQM3h3aWJNdU9U?=
 =?utf-8?B?Y0RJV2RaelJOSHVHZm5xUzArdnNOcjkyTzV0eGRyRHVUVk5sS3BBNU9OTTgy?=
 =?utf-8?B?SnRNWWJxU0lINHBuUXU0V25Cek4yMVRIMlVsb1UzNElGbU91aXNqeVFmRDlP?=
 =?utf-8?B?MUwwS2J5WFM4N1JrY2pkdjI1bzlaWDYxRkRuQnc1RjZSaG15ODNIZFBYUlk0?=
 =?utf-8?B?WG5sdDdzWTdRUFAzRDN1TmFVa2xpcGZobkZDZTRETSsvUVFGRzZ1dENXV0Fk?=
 =?utf-8?B?T2x4bWJuVDRjdmZkVDFCb2NSMkpJYjlGd0E4N2MvTzJHZ0xmUXN4OS9SWTlp?=
 =?utf-8?B?cjdzTnpla0JrY2wrRkpVYXRpak1wYmZPNFllRUxGYVB1SmNqZVFPV3dpRFoy?=
 =?utf-8?B?REF4T2ZQL3F1dE5VbnhjdmtTYUdhZm9Pc0hoenhJSjlRbXRrWm9CU2FZUFd1?=
 =?utf-8?B?SGVwaFlZQlhva2FSL0hlQXdrM2YrOEZMUVBqUU9xREhGWklIYmI5amJjZzRi?=
 =?utf-8?B?QkdCcFdUVjFoKzhNY3lvbDVVa0tnY0hhVjFmWDhxb3VLZUY3dTlJa1hCQkRR?=
 =?utf-8?B?Si9Kdmx4N0xtMEcxVSthM3gyRnh1bm1YZHFqLzY0dkRNbDQ1VW1FTEo0SHZ1?=
 =?utf-8?B?Mk9XbUZSWmJwZVlYRUh6Y3cxWFh1Ryt6b1h3NThsalZsaXlLdERYL3JxZUh2?=
 =?utf-8?B?ZUJjMGZ5Z0w3SEJxRHErNUNTNGpCdVc4M1hFbmlGYm9kRE9IMStxQUlGOEds?=
 =?utf-8?B?N1Ixb2grcThWUzlVN3BKQ2prVXdKK3JDc0ZwWmo3VFVBcFN5QUdXbHhGNzRt?=
 =?utf-8?B?cGNobm1Jc0JXb2ZuNTlXcHpSLzZqTmpoZG9NZjI2bWZCK1FpdUhxcHpqR3E5?=
 =?utf-8?B?NkozVnB0STY4WnZBRkZjcDJQMmJZeDdDeWFFcGlVOUpuWkZZWjNscEtzbzkv?=
 =?utf-8?B?cjRmVWh6Y2N6VjM0ZGlqTkhIWjNkSmxpUHlMSWdrRnN2RVpPa2pzU21QMUl6?=
 =?utf-8?B?M0hhUE1UZDVueG9tTDh2SGtPWndTbytIdm1iZzVEUFNPOXB6WGRJejV6SUNX?=
 =?utf-8?B?RFAyaHorbmpwRTJvUHdRK3BCNDRRTVVlTUFCY21lSmdnQkM4Z08xM3RZdTZ6?=
 =?utf-8?B?Mll3SnM4NEhibXMwTDNlVnA5YjYxSDh1VVVmcHRWMmxOZGdXaEdkZHZUckgr?=
 =?utf-8?B?a0pZYUZqYUhMaTU3MnVER0JHVGRRaFJMWi9WTk05cFZ2T1BhUERyZUs2NFhn?=
 =?utf-8?B?Ky9IZUZkMlFZdERQb05xODNDV1h6SWZCTFFJZGFHMVB0SUJVN2xEZ1UxQWM4?=
 =?utf-8?B?VGFvalgwYjZ5ZHMrZEN6bDFGNU9HeUl6M0MrR0pyZ3JNVWhYQmM2TER2OE5Y?=
 =?utf-8?B?cEdNelJMdmIrQlpvazI4WFZWS2dYaDZzMUxNblNDMGFzZGp6eXVURzhsbGpB?=
 =?utf-8?B?cTJGTHhhTXdBR3RDdEZ1bmcrWldReWpsdVZKZVJtYkM5OS9Gc2I4a0czZjZi?=
 =?utf-8?B?NmVOb0U4UkFIOE9KeHdWb3JFZjZ4anpQU05DS21jVUJCSzFpVUNQTFZaV0lX?=
 =?utf-8?B?ODNaTTBHbUJwR1ZTd1puQWQzZ3lqOE5hakxRUXhhWXAzNjN2UHBOWlFoU1E0?=
 =?utf-8?B?Nm9uc3haVHdxTEpwTy9CQTE3OGVCL0lKNVRPUWhoS0t4dGVXeVNtWXZhNTNz?=
 =?utf-8?B?cjViTmltbjBzZER6ZkFBUVZ1MDZvT3ZPVWVQanNwZEhzTE81MWJKeHFqUlZm?=
 =?utf-8?B?cFpONVpNRUNvcytzUmVyQVdqSVV5SjBDYTZHTG9nd0dKSUY4TTJjTDhNU2oy?=
 =?utf-8?B?RDNhUndOS2VJay8wajNQZDFtS2s2dTAweHdCc2JlQTBZTlY2QURDYmRvSlVy?=
 =?utf-8?Q?6jmc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8feb3a54-88c7-4e91-e822-08dc5d97caf8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 22:02:50.7910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCOW2Cx1rqlqf6eN6NWgRJaSJaDrLODs/Tcv2oZp6niSXZXsbL06vFbzNTkduND7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682
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

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-04-14 10:57, Arunpravin Paneer
      Selvam wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com">
      <pre class="moz-quote-pre" wrap="">Now we have two flags for contiguous VRAM buffer allocation.
If the application request for AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
it would set the ttm place TTM_PL_FLAG_CONTIGUOUS flag in the
buffer's placement function.

This patch will change the default behaviour of the two flags.</pre>
    </blockquote>
    This change will simplify the KFD best effort contiguous VRAM
    allocation, because KFD doesn't need set new GEM_ flag. <br>
    <blockquote type="cite" cite="mid:20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com">
      <pre class="moz-quote-pre" wrap="">

When we set AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
- This means contiguous is not mandatory.</pre>
    </blockquote>
    <p>AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS used in couple of places. For
      page table BO, it is fine as BO size is page size 4K. For 64KB
      reserved BOs and F/W size related BOs, do all allocation happen at
      driver initialization before the VRAM is fragmented?<br>
    </p>
    <blockquote type="cite" cite="mid:20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com">
      <pre class="moz-quote-pre" wrap="">
- we will try to allocate the contiguous buffer. Say if the
  allocation fails, we fallback to allocate the individual pages.

When we setTTM_PL_FLAG_CONTIGUOUS
- This means contiguous allocation is mandatory.
- we are setting this in amdgpu_bo_pin_restricted() before bo validation
  and check this flag in the vram manager file.
- if this is set, we should allocate the buffer pages contiguously.
  the allocation fails, we return -ENOSPC.

Signed-off-by: Arunpravin Paneer Selvam <a class="moz-txt-link-rfc2396E" href="mailto:Arunpravin.PaneerSelvam@amd.com">&lt;Arunpravin.PaneerSelvam@amd.com&gt;</a>
Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c   | 14 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 57 +++++++++++++++-----
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 8bc79924d171..41926d631563 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -153,8 +153,6 @@ void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain)
 		else
 			places[c].flags |= TTM_PL_FLAG_TOPDOWN;
 
-		if (flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)
-			places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
 		c++;
 	}
 
@@ -899,6 +897,8 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo-&gt;tbo.bdev);
 	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_place *places = bo-&gt;placements;
+	u32 c = 0;
 	int r, i;
 
 	if (amdgpu_ttm_tt_get_usermm(bo-&gt;tbo.ttm))
@@ -921,16 +921,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 
 	if (bo-&gt;tbo.pin_count) {
 		uint32_t mem_type = bo-&gt;tbo.resource-&gt;mem_type;
-		uint32_t mem_flags = bo-&gt;tbo.resource-&gt;placement;
 
 		if (!(domain &amp; amdgpu_mem_type_to_domain(mem_type)))
 			return -EINVAL;
 
-		if ((mem_type == TTM_PL_VRAM) &amp;&amp;
-		    (bo-&gt;flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) &amp;&amp;
-		    !(mem_flags &amp; TTM_PL_FLAG_CONTIGUOUS))
-			return -EINVAL;
-</pre>
    </blockquote>
    This looks like a bug before, but with this patch, the check makes
    sense and is needed.<br>
    <blockquote type="cite" cite="mid:20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		ttm_bo_pin(&amp;bo-&gt;tbo);
 
 		if (max_offset != 0) {
@@ -968,6 +962,10 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			bo-&gt;placements[i].lpfn = lpfn;
 	}
 
+	if (domain &amp; AMDGPU_GEM_DOMAIN_VRAM &amp;&amp;
+	    !WARN_ON(places[c].mem_type != TTM_PL_VRAM))
+		places[c].flags |= TTM_PL_FLAG_CONTIGUOUS;
+</pre>
    </blockquote>
    <p>If BO pinned is not allocated with
      AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS, should pin and return scattered
      pages because the RDMA support scattered dmabuf. Christian also
      pointed this out.<br>
    </p>
    <p>If (bo-&gt;flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS
      &amp;&amp;
    </p>
    &nbsp;&nbsp;&nbsp; bo-&gt;placements[i].mem_type == TTM_PL_VRAM)
    <br>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; o-&gt;placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
    <blockquote type="cite" cite="mid:20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com">
      <pre class="moz-quote-pre" wrap="">
 	r = ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);
 	if (unlikely(r)) {
 		dev_err(adev-&gt;dev, &quot;%p pin failed\n&quot;, bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 8db880244324..ddbf302878f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -88,6 +88,30 @@ static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head *head)
 	return size;
 }
 
+static inline unsigned long
+amdgpu_vram_find_pages_per_block(struct ttm_buffer_object *tbo,
+				 const struct ttm_place *place,
+				 unsigned long bo_flags)
+{
+	unsigned long pages_per_block;
+
+	if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
+	    place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS) {
+		pages_per_block = ~0ul;
+	} else {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		pages_per_block = HPAGE_PMD_NR;
+#else
+		/* default to 2MB */
+		pages_per_block = 2UL &lt;&lt; (20UL - PAGE_SHIFT);
+#endif
+		pages_per_block = max_t(uint32_t, pages_per_block,
+					tbo-&gt;page_alignment);
+	}
+
+	return pages_per_block;
+}
+
 /**
  * DOC: mem_info_vram_total
  *
@@ -451,8 +475,10 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 	u64 vis_usage = 0, max_bytes, min_block_size;
+	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
 	struct amdgpu_vram_mgr_resource *vres;
 	u64 size, remaining_size, lpfn, fpfn;
+	unsigned long bo_flags = bo-&gt;flags;
 	struct drm_buddy *mm = &amp;mgr-&gt;mm;
 	struct drm_buddy_block *block;
 	unsigned long pages_per_block;
@@ -468,18 +494,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (tbo-&gt;type != ttm_bo_type_kernel)
 		max_bytes -= AMDGPU_VM_RESERVED_VRAM;
 
-	if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS) {
-		pages_per_block = ~0ul;
-	} else {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		pages_per_block = HPAGE_PMD_NR;
-#else
-		/* default to 2MB */
-		pages_per_block = 2UL &lt;&lt; (20UL - PAGE_SHIFT);
-#endif
-		pages_per_block = max_t(uint32_t, pages_per_block,
-					tbo-&gt;page_alignment);
-	}
+	pages_per_block =
+		amdgpu_vram_find_pages_per_block(tbo, place, bo_flags);
 
 	vres = kzalloc(sizeof(*vres), GFP_KERNEL);
 	if (!vres)
@@ -498,7 +514,8 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 	if (place-&gt;flags &amp; TTM_PL_FLAG_TOPDOWN)
 		vres-&gt;flags |= DRM_BUDDY_TOPDOWN_ALLOCATION;
 
-	if (place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
+	if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS ||
+	    place-&gt;flags &amp; TTM_PL_FLAG_CONTIGUOUS)
 		vres-&gt;flags |= DRM_BUDDY_CONTIGUOUS_ALLOCATION;
 
 	if (fpfn || lpfn != mgr-&gt;mm.size)
@@ -529,8 +546,20 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_manager *man,
 					   min_block_size,
 					   &amp;vres-&gt;blocks,
 					   vres-&gt;flags);
-		if (unlikely(r))
+		if (unlikely(r)) {</pre>
    </blockquote>
    <p>If pin BO failed to allocate contiguous VRAM, this should return
      failure to application, as RDMA cannot work with scattered VRAM
      pages.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240414145731.1829-1-Arunpravin.PaneerSelvam@amd.com">
      <pre class="moz-quote-pre" wrap="">
+			if (bo_flags &amp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS) {
+				/* Fallback to non contiguous allocation */
+				vres-&gt;flags &amp;= ~DRM_BUDDY_CONTIGUOUS_ALLOCATION;
+				bo_flags &amp;= ~AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+
+				pages_per_block =
+					amdgpu_vram_find_pages_per_block(tbo,
+									 place,
+									 bo_flags);
+				continue;
+			}
 			goto error_free_blocks;
+		}
 
 		if (size &gt; remaining_size)
 			remaining_size = 0;
</pre>
    </blockquote>
  </body>
</html>
