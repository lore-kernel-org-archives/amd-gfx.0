Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52307CDB474
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Oct 2023 23:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCE4F10E4FC;
	Thu, 12 Oct 2023 23:09:43 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C6B10E4FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Oct 2023 23:09:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4PKOBQ0Y+X6lSwW8Bb2yVJmIF9TGl4kjJ8Ygv1mwmqLOBJSshFjv29tC80XtTj13R2dCrdFtvXT8skFyZMcmbET3Y7tzFtj6CCJzM2KA2BVNl8ZM1DLj+9E3L7dsl0HiLsK9E+zeOxI6Utq/7O00EOTAjfDkebhcM9FSgnd5a6OhZ4m6SLMtcC8IK4WVg+OLudJLrVRnhSWIyS+cmM9fa7/I1RRulxfhAd0e0plL5Ld5yx2qufuWJsMg3nogVYCLsAJqDb7AEqkmZdZ7fcP5wpqKRSlaTmz4mPiAruQTAU6dx6Z70uH9uXZqku2KXoojtdHWi7vD0wMUj0BPMV7jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3mZOntNoFWVmbzVAPfggAYBJ2Tkbmnl9fx9s2hMFh8=;
 b=Z14bRPgNL5uLe1GHCZ2pqTDC7B9NBpb65dqt31YMKJ8B10R63eCgNPZgOQGT1GJ3/bQPWvKgjM3h+v3Qbw8Gj2mVf9iJttOwBuyI36hR7bYbjfH7gUQNfAYUjwBzGkOccT7RvzrnJPFngTZj89KItH4NfwC3EZWCSSUxOc/4t7lxzKgQ7BY7PqKmBIx38QP+CixODPS8+5QApgxDZEHWzFgV6t8zuFdlTqjqU3zC7D4wGIqunoRusfF0rZvxeyCWv7JT+qDtfzC7KLs5TY0oNBgGiZr6Xax+Js92VpvSd/EovMenoDspz6ovxKxOqFMYjlti9jShyvpzX9IE1yWbuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3mZOntNoFWVmbzVAPfggAYBJ2Tkbmnl9fx9s2hMFh8=;
 b=REo9DxdSLzJ9HJm8sEJweWRQMvv3bx/kmqIjYquLTNUb4GK6K/jbncfBFjKWCqg3TFPUm6nDgOZuBx6iHwssZ8t1xZevI3fPvW7o04xmOflXyrnDxhFNftbVwnToXgu/XsaplXn0r81PN2zgEO6acmh0DLRYge6vA56jsp8ByEo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB5758.namprd12.prod.outlook.com (2603:10b6:510:1d1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 23:09:37 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::e166:610f:a86e:d33a%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 23:09:37 +0000
Message-ID: <d2a72646-b3b5-91e9-eebe-73450ca4fc6e@amd.com>
Date: Thu, 12 Oct 2023 19:09:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Add EXT_COHERENT override for NUMA local nodes
Content-Language: en-US
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231012163941.553980-1-David.Francis@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231012163941.553980-1-David.Francis@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::10) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b5965e-dd8e-4d56-a78b-08dbcb784e29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+bqJFs6y/EV7poSZrhTKxsOGjm0xyQEsmQ/IXw4dqKXdxREpkBhlS00HBeqPwAtqNZ5ErOvvtXo5KbdUjRMRfuEs0Ajo3dYDjzl+THrFqMtOty+ugZNh5xDJrL7BKGJ4fWTD8nF7wPRBJKjJS7VHHuL/MihwCAHkLu/GA1uQ/lBXui4eRS+x6vTEids+X395Z1XccOc2kXpaEv0rIXJazqqcnm+OwpzKTJrdYPGH49UTju9CwzmaLcxcbdyFwqZSylO9Ne+6gZtmYUmW4HuapzuIu+EY2+AAyZA8lNO0WJzMLVtJxm0WDX66MTrFtukl9gWmhJ+5hn6pD+aEhw19s0KI1yUmF/U5RoANxu67bLO6+V123x0YtQvZMmO3EKpiKiEvVqcyEv7K0Amz1nyknBHRQABkXgQF1HUDH5H0DIliRgFLWnqgNhpgB8XwxXTcmxouckz3YQi7ZjczlFY0lB9C2BkzJcq1sTHCVQXaSOoeC+Ax6tW3ArnUzjwXQwINtHZywBaGLkUYfxgv3XsHS2FQ+IT+UDzw268kkH2dOiiOazAQbJd+ESDRf85ZR94Zi67Ve02M3/pLhqyykAdnKRcfxE9HZMK40tgrUdw0V8yLVIMVx/vPU0Mhd8GzelfcSOYyfYj18NUha96cg8SvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(376002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(4001150100001)(2906002)(36756003)(31696002)(38100700002)(316002)(2616005)(66946007)(66476007)(66556008)(41300700001)(26005)(6666004)(31686004)(6486002)(6512007)(53546011)(6506007)(478600001)(5660300002)(83380400001)(8936002)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ayttaHlNQjZhNHdwOWF6bldDaDJGMnRnUGNvdFRFWkYzUHNGV1QxbUhMSFR1?=
 =?utf-8?B?SXM2Tnp6cVdhZ3lQclBGNUZQR3JFV1VpVkltVGRIejRXNElObHp4cU5iaTAv?=
 =?utf-8?B?RkdONXFLbjkva0RVaVlkL1FPclJMbDJ5Y0V2RG5vckhxckJrWDYybUJXWmZC?=
 =?utf-8?B?Qk1UM2tsWHhSS0lTeHMyZHNOQXJ5TEFhQXJzYmxMWmZGK2xlUDR4VzBodktM?=
 =?utf-8?B?cFJDaVErbmZqZWQzRm11ZXJYWDUxODA4ZUovWDlPN3UxMC9YaWFnTnRySElC?=
 =?utf-8?B?b1pFcXZXa1pOdWtDUHA0bEQxaWcxUnMvV0dRanFaWDZFZVB6VkFBN3h5MU1M?=
 =?utf-8?B?eWpSSHZhNTU1VVEweFlNQ1JkM0txUHJlbWhCbm5zWEJudjZ6TjdPclYwSTk4?=
 =?utf-8?B?ekpDaFgwQVF2WklFN0I1L3pGTVhFK3JGdnZpTGtvYm9hcjlTRVpISzRCTGdu?=
 =?utf-8?B?bmNzSHE3dlF3MWtZbEVmZm1wTXZJekFxeEtLWXliMmMvMnFwblhDTklkSm1V?=
 =?utf-8?B?RHFzeFc4RkZBaDdaTk4rRTRObjRlK3MrWW16M1ZRc1k3VVRuZUExcmdkVU5H?=
 =?utf-8?B?Zkk1bTZiNHRZRjN0UEFWak9QcTErQkEzek00THRvUGt5ekl5REJkTm5aWm9H?=
 =?utf-8?B?ZjVWeUd5SWhIV21nRXNWU1l3K3BrbWdndmRvSEY1cjRvVklOQ3hjMEd0MCs4?=
 =?utf-8?B?b1pBSzVTNmJRb0FBbVMzYmV3Q1VDSUt5L3BSaFRVSkN0V0lueGpWSDVycEx1?=
 =?utf-8?B?UHE4L2IvL3hyMVRMU01ScXVWOUJFRlJEZncrdkl1TEtqeDl6dWRBZFZuM0lD?=
 =?utf-8?B?ZmdqcWJoRjN0QTM0eU1mUG9DN3NzUjdiQmdrQkp6ejh0ZWRydm85RWlTV2h6?=
 =?utf-8?B?U1h4Q2ZEQ1NOSStzL1A1eDQyaHVRZDRPMXo1eW00bnN6dUhoZjZzMnVYL0Rq?=
 =?utf-8?B?cTh5ZE1lQWVZRE54Q1U1SnFlbW5kSFc3MzVuRi8vdjdnYXVzTERTdVBGU0JB?=
 =?utf-8?B?eGdBWEVJMS8zaytaclREUTJNeVNvN0RtVHlxNDlEVDVBTE1sRXUrQkFoT21p?=
 =?utf-8?B?eWMwdnhwNVc3VXdtMW9oOFpsWXhudzY1dmtZU2tZQjdwM1JoVDVNYmREaGta?=
 =?utf-8?B?WGViWGM3QnJ3emtzaHo1L1h5dDJIUHB3bnBkME14RzI0akMrYnZhM050Y0J3?=
 =?utf-8?B?NGhmME9GUVNEUFBneHI4elNEZEtySFRxRkNrZm4vaENNOWlodGt6anRFKzBv?=
 =?utf-8?B?elc2QXorRzlyMmFGM3kxMCtGcTBBa2dQN2J2eWNjRnpaUFY0R0Y3TTlrbklT?=
 =?utf-8?B?eXM0dnI3YXgxWGlId0N6dnpJUjZxTENvUkd0VXdlNzIyZ09wMGZFSHo3Y3E5?=
 =?utf-8?B?eVhsd3pWaW9NcU1FUmZ6RFQzWmgzU2pmYVVwb09rcmowVjdzNDBndEV4SDRF?=
 =?utf-8?B?T0piR3RtWW14ZHpQQXYxQk1WUVJqRjV1STRxT2xGRmk0SEg3Nm8rbUpXeU1V?=
 =?utf-8?B?dklrMTRtc3kyU0lGc1lyaFA0Tk8vQThhWlhLUWd0NXBJTnhSSW12WmxDS3Nu?=
 =?utf-8?B?c2tMZGtOZ0lzcWdnM1JFeFdYNjBUMC9IcC85TFEreTZhckFjdXJBMk9JZzdo?=
 =?utf-8?B?WkhOVmJuSnIrUGNIbDFZakJkN3diOTdLaHNrTUtiQytXSUdxNFkzcGhKTERV?=
 =?utf-8?B?YnFBMEtGN1hEODRLL2tQUUxBN2MyUnFFRHMxWmRCc3hUYXhpMXRUeVdDRm1Z?=
 =?utf-8?B?YkdtV3g3RlF5RjJxNHhYNWtLQ0FvTHhQQ1B4T0IvZExaUkVnS1l1UnM5RHVs?=
 =?utf-8?B?akdGNkg2bE52Q3poRnQ1Q0xDR0xkbks3TTVaK09kbVpKVlZvTWxiZUJuM0RS?=
 =?utf-8?B?OXRsY0ZDbktVWU0zdkw5cEQ2WERLV1AyVDhVNnJqTk5Ed2c1WWhMSUEyT0Vr?=
 =?utf-8?B?NnpCUEx5ODJzNHg4TFhSeVJQeWhhRlNjNU9DSVhLcGg1ZTFnUDdtVmhBQnhl?=
 =?utf-8?B?eGlQUy9qbEVhOU0zc2dhaWZBRUY5TDhmTEhPRWNJVnpUaXV4dXpZQ2xyVDJI?=
 =?utf-8?B?REFzYXlQdlh4K1ZWRFNYSXBVbThYQ090REdBZmNRQjRoeWR3czNRT2ZVUVhV?=
 =?utf-8?Q?sdxM=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b5965e-dd8e-4d56-a78b-08dbcb784e29
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 23:09:37.2451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: btoQcDaDmip00laKEyegzRulyGPoZqLfFBZNMmUSRjOYFQBcOqAZVsIv3StiP1M/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5758
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
    <div class="moz-cite-prefix">On 2023-10-12 12:39, David Francis
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231012163941.553980-1-David.Francis@amd.com">
      <pre class="moz-quote-pre" wrap="">On NUMA systems, local memory gets the local mtype, set by an
override callback. If EXT_COHERENT is set, memory will be set as
MTYPE_UC by default, with local memory MTYPE_CC.

Add an option in the override function for this case, and
add a check to ensure it is not used on UNCACHED memory.

Signed-off-by: David Francis <a class="moz-txt-link-rfc2396E" href="mailto:David.Francis@amd.com">&lt;David.Francis@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 13 +++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  8 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 33 +++++++++++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  6 ++---
 5 files changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 46d27c8ffff7..189341944bf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -761,6 +761,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * @immediate: immediate submission in a page fault
  * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
+ * @allow_override: change MTYPE for local NUMA nodes
  * @resv: fences we need to sync to
  * @start: start of mapped range
  * @last: last mapped entry
@@ -777,7 +778,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * 0 for success, negative erro code for failure.
  */
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
+			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
@@ -815,6 +816,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
+	params.allow_override = allow_override;
 
 	/* Implicitly sync to command submissions in the same VM before
 	 * unmapping. Sync to moving fences before mapping.
@@ -1062,6 +1064,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		trace_amdgpu_vm_bo_update(mapping);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
+					   !(bo-&gt;flags &amp; AMDGPU_GEM_CREATE_UNCACHED),
 					   resv, mapping-&gt;start, mapping-&gt;last,
 					   update_flags, mapping-&gt;offset,
 					   vram_base, mem, pages_addr,
@@ -1257,8 +1260,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		    mapping-&gt;start &lt; AMDGPU_GMC_HOLE_START)
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
-					   mapping-&gt;start, mapping-&gt;last,
+		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
+					   resv, mapping-&gt;start, mapping-&gt;last,
 					   init_pte_value, 0, 0, NULL, NULL,
 					   &amp;f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
@@ -2546,8 +2549,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
-				   addr, flags, value, 0, NULL, NULL, NULL);
+	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
+				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 6e71978db13f..9ea8b5b644e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -244,6 +244,12 @@ struct amdgpu_vm_update_params {
 	 * @table_freed: return true if page table is freed when updating
 	 */
 	bool table_freed;
+
+	/**
+	 * @allow_override: true for memory that is not uncached: allows MTYPE
+	 * to be overridden for NUMA local memory.
+	 */
+	bool allow_override;
 };
 
 struct amdgpu_vm_update_funcs {
@@ -436,7 +442,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
+			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
 			   struct dma_resv *resv, uint64_t start, uint64_t last,
 			   uint64_t flags, uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 9b025fd17b84..80273809c93f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -842,7 +842,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
 	 * to be on the same NUMA node.
 	 */
 	if ((flags &amp; AMDGPU_PTE_SYSTEM) &amp;&amp; (adev-&gt;flags &amp; AMD_IS_APU) &amp;&amp;
-	    adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
+	    params-&gt;allow_override &amp;&amp; adev-&gt;gmc.gmc_funcs-&gt;override_vm_pte_flags &amp;&amp;
 	    num_possible_nodes() &gt; 1 &amp;&amp; !params-&gt;pages_addr)
 		amdgpu_gmc_override_vm_pte_flags(adev, params-&gt;vm, addr, &amp;flags);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3a1050344b59..1456f76b7fb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1251,12 +1251,15 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 		return;
 	}
 
-	/* Only override mappings with MTYPE_NC, which is the safe default for
-	 * cacheable memory.
+	/* MTYPE_NC is the same default and can be overridden.
+	 * MTYPE_UC will be present if the memory is external-coherent
+	 * and can also be overridden.
 	 */
 	if ((*flags &amp; AMDGPU_PTE_MTYPE_VG10_MASK) !=
-	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
-		dev_dbg_ratelimited(adev-&gt;dev, &quot;MTYPE is not NC\n&quot;);
+	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC) &amp;&amp;
+	    (*flags &amp; AMDGPU_PTE_MTYPE_VG10_MASK) !=
+	    AMDGPU_PTE_MTYPE_VG10(MTYPE_UC)) {
+		dev_dbg_ratelimited(adev-&gt;dev, &quot;MTYPE is not NC or UC\n&quot;);
 		return;
 	}
 
@@ -1283,15 +1286,23 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
 			    vm-&gt;mem_id, local_node, nid);
 	if (nid == local_node) {
 		uint64_t old_flags = *flags;
-		unsigned int mtype_local = MTYPE_RW;
+		if ((*flags &amp; AMDGPU_PTE_MTYPE_VG10_MASK) ==
+			AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
+			unsigned int mtype_local = MTYPE_RW;
 
-		if (amdgpu_mtype_local == 1)
-			mtype_local = MTYPE_NC;
-		else if (amdgpu_mtype_local == 2)
-			mtype_local = MTYPE_CC;
+			if (amdgpu_mtype_local == 1)
+				mtype_local = MTYPE_NC;
+			else if (amdgpu_mtype_local == 2)
+				mtype_local = MTYPE_CC;
+
+			*flags = (*flags &amp; ~AMDGPU_PTE_MTYPE_VG10_MASK) |
+				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
+		} else {
+			/* MTYPE_UC case */
+			*flags = (*flags &amp; ~AMDGPU_PTE_MTYPE_VG10_MASK) |
+				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
+		}
 
-		*flags = (*flags &amp; ~AMDGPU_PTE_MTYPE_VG10_MASK) |
-			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
 		dev_dbg_ratelimited(adev-&gt;dev, &quot;flags updated from %llx to %llx\n&quot;,
 				    old_flags, *flags);
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7b81233bc9ae..bbaec633a806 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1321,7 +1321,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	pr_debug(&quot;[0x%llx 0x%llx]\n&quot;, start, last);
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
+	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
 				      last, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }</pre>
    </blockquote>
    <p>This change from the last version is still needed, right?<br>
    </p>
    <p><span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI
        Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">@@ -1286,7 +1286,7 @@
        svm_range_get_pte_flags(struct kfd_node *node,</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0);
        background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if
        (num_possible_nodes() &lt;= 1)</span><br style="font-family:
        &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,
        &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,
        &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mapping_flags |= mtype_local;</span><br style="font-family:
        &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,
        &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,
        &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0);
        background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mapping_flags |= AMDGPU_VM_MTYPE_NC;</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0);
        background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC :
        AMDGPU_VM_MTYPE_NC;</span><br style="font-family: &quot;Segoe
        UI&quot;, &quot;Segoe UI Web (West European)&quot;, &quot;Segoe
        UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,
        &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* system memory
        accessed by the dGPU */</span><br style="font-family:
        &quot;Segoe UI&quot;, &quot;Segoe UI Web (West European)&quot;,
        &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto,
        &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667px;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span><br style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0);
        background-color: rgb(255, 255, 255);" class="ContentPasted0">
      <span style="font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web
        (West European)&quot;, &quot;Segoe UI&quot;, -apple-system,
        BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;,
        sans-serif; font-size: 14.6667px; display: inline !important;
        color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class="ContentPasted0">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mapping_flags |=
        AMDGPU_VM_MTYPE_UC;</span></p>
    <blockquote type="cite" cite="mid:20231012163941.553980-1-David.Francis@amd.com">
      <pre class="moz-quote-pre" wrap="">
@@ -1428,8 +1428,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		 * different memory partition based on fpfn/lpfn, we should use
 		 * same vm_manager.vram_base_offset regardless memory partition.
 		 */
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
-					   last_start, prange-&gt;start + i,
+		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
+					   NULL, last_start, prange-&gt;start + i,
 					   pte_flags,
 					   (last_start - prange-&gt;start) &lt;&lt; PAGE_SHIFT,
 					   bo_adev ? bo_adev-&gt;vm_manager.vram_base_offset : 0,
</pre>
    </blockquote>
  </body>
</html>
