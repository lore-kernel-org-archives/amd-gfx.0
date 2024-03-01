Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391ABC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 23:42:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC2ED10EDC5;
	Fri,  1 Mar 2024 23:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sgtkviFJ";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2698A10EDC5
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 23:42:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkrKz8wxz1zXJwKiEV4jORZoluInZzYPLDzg2agbvD7Fc3NlW1qA0XOjRQOTAhzF7kmmo5m7VM0lsdE98iT+30geL3lQhDQfxAE+/2L+RQ46KO4BFV/VXKy0ARbBrui16Y423eu36Y1KP97X1fnFaj7C4cApmYpLJGAlSNFiic9XVB9ZilChfPDb3a+Ja2GtiMeOVt6R4MNYCoOR4iuBbJtd2grhAc1qnrqE1QaMuF6e21+Eszicg1EOYwfmFBs8P5DSBbtyBkgUZb4doFU3vd+KDxVL27RZmt5DVOoYtuc09Sh5LcFqAQ2DCs9Z4rLIX2dHv/Li8JL2XXs318BFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2gGEIBqTqDv0+GgceMnL+qhaAai3BHyt9ZtP4/MEK8=;
 b=fWzJlTAJ8IRaNURs2483fl9suLHotXaCjbaq8NJ+s1CCb+X62pb+KjnwdG5S29W+MA4EgpYpKwqv2LAm7XO+SVO5FFqk4CDVT2DBgC714itpzyiMD40seM25zTcDYpTfu2LBWUBDbtcq6rBV6Ng6qVRaeD3OyCowEPeI4KFJQd7u26hdlLxSqlbXSXsfPR25DyozBWyjyohVPK9Erk014Aa63SCKgzBxVOX3IbyGLzHtCSqDHkSZkO7vmgCzci4ncEiSJLVGeHvRcoFLQr00d6NcHLX6F6WisnHZFVJ0g4qFoVtiL/TRxjpwDxSr9yvcH2sc4Xx4LPqylpOUckex2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2gGEIBqTqDv0+GgceMnL+qhaAai3BHyt9ZtP4/MEK8=;
 b=sgtkviFJB+RJ3pG2kGq6nNMIKEHAbh6tKE0GVrvLlwKX8rqY2rU4Uj5I/tIXzU7NgI7AccWgTkZknLXSuV+Js7cVbKvn1xo7+PgcIXtDNu87dvlFvWN726c9vcr1mGfommFB74m1rfxmyJsli5uz8wvXOq8+x5O5mdel6XfqoPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by SJ1PR12MB6268.namprd12.prod.outlook.com (2603:10b6:a03:455::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 23:42:00 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::9494:43c8:64df:6c1a%5]) with mapi id 15.20.7339.033; Fri, 1 Mar 2024
 23:42:00 +0000
Message-ID: <c0858e76-1a57-b502-8735-1345573829c0@amd.com>
Date: Fri, 1 Mar 2024 18:41:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/2] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
 <20240301110724.947-2-shashank.sharma@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240301110724.947-2-shashank.sharma@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0136.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|SJ1PR12MB6268:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c21bfcb-c5d1-4fef-1f75-08dc3a4930cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgVoAYHLf9co+F7lV97QlNBpeNGo21Z36dkUgmqQ/Qoamt/+cq9R5eoR0DPKVacq7MIGg767BogFGSn1l6aGoIXTaShlCtDpJKsIYfGGKgwPkRcKIhKLRq92ZX/4BUvFnvJVAFPswoVSpamcTCd1vgcQVipyYR7jmLJYIRAVMaVq9GaWd3l7bH6pGOvbY3sJsNOocHaKdugcWX2/dXVcTtk/LfMNNf9VYn2H44r/gD+OWx39t9iGjBGDdRcrnQ44BpxxAohDzMfMY0LdhIVto1hHuRn68rlpXhsJO15HixfGGh4ED/BHQbO7lc3OSGGc4TgO8L6DN4A9UNe7g0Tt77idJSTN1n5SA35M+UFXtuygqI9q8N013JROzxlNeoHPnrn3Xr1zKfGKZLuWVo7F/VwqK2wciZKbmWFH9O7mDJFVg8/K94AdWfNKj6kO+UlR0y3hTDOVO7X8BCt5ZTbGaShoCfm4fHWwb7TdIONa/AMPNNuAndFDL+2yZu0yYVFTO9NEfyaDD3dQl9q0JDtFL+YkbqqNP0s9Hb138pLFA18BtHt8uUQyA8R3gZqfZieKrTUj8uYpnx1xpUtEu4fMW+QQXCbmQA8j/KJnsE6UAv7dFhuH/NZEv+dvk6HoraN+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckhxYVcrbEhOQmxaLzlxdGJrWk1HeFRiTEwzeUVsUW5tTHFybUhvaGwrWGI4?=
 =?utf-8?B?c1FQQ3RQdWQ3RWVFV3A1SmsvODJTSm14VXBianc5cHNpTllwdk1obFMrelNX?=
 =?utf-8?B?SkQ4SnkvNHBHOWd0bDUwd2Z0bm5FaHVxenF5NUJPUi9xcjUzWVpUSk8xYWtm?=
 =?utf-8?B?YTFqOEhha01ub2lEYzlndGkxWThxU0VET3VFS0dMVTlWcGFqU083WkU2WExE?=
 =?utf-8?B?RXhVdVZqaTJhNkxBNmZMWG0wOTBXV1F3Rzl1UFRnT3pMSGJDN1RNb2I4M29x?=
 =?utf-8?B?TU9zd1hwcGY5RTFlWkJrYWx6ZXhCdndBM1BRRklJQUkybVE3bFlGMndjUnZt?=
 =?utf-8?B?YzZ4ekRVcVlnN0VPQjJXMCs2TWc3VHFsVlNCY251eUxYcFVVdTFJdHkzdVJz?=
 =?utf-8?B?YnMyQUhDSDQ3eTN0US9YZmptdVd1TTBXUGZxS0lNVVQ2SkNQWWtmTmFRWWg5?=
 =?utf-8?B?UGFlSldVT0o0bEdRTzlqdG1JVlNic0s2NHlzMjhjRm5nczFsWDRwZFNrdjNm?=
 =?utf-8?B?QWdibDFOcU1HdmlmaEdmeWlMN0IxUmxlUUM5K0RuWnl3bk5KSE9HN2thZ3Nm?=
 =?utf-8?B?RW81Kzg0eExrT2JOeDBDZXcrc0IwMkFrNzdvMWhSYTc4YkJxZnZjQkluMmVN?=
 =?utf-8?B?MUFPcG9YWHdYVjZ3WVZCVUpEYWlEc2F1bVp3SStETzJuNzB1M0xmU2VWc0lD?=
 =?utf-8?B?dWtKMXE2MDNYU3BZSTkzTC9vRXFEZ0V4bVpvN2p3TTA0dEIra1lpNDR4cHU5?=
 =?utf-8?B?M21DTVFnbm9sdU1CdGRqaXExQUpMRTlTckllYWdObzJ1a2ZYd2dCWXU5dXRV?=
 =?utf-8?B?d01GaXIvaWpSYkJrTmowd1ZDTDJCM3hNSGo5RTNhdnJHNURLQ1crZlhUNDd5?=
 =?utf-8?B?Z1VBcWY3ZFA2NFR6YStucEEvVlUvdjlERVhkT2lrZklGQmVWTnEzbjlwb25O?=
 =?utf-8?B?NTkrQ0F2TDQ3aHR1dFZuZExEWE1qMUxQZmJTU0E2RHRxUjVFQS9PQi9SUHZa?=
 =?utf-8?B?TURhVU9lb3ZwT1Q5UDVXbVlEaG44STJaL09WV2ZmTFFvRTFqVGVGVkFpTSs4?=
 =?utf-8?B?N3o5TjQvNDhKLy9VZlMxRmFzSnVjZGprM3RtRG5QYjd4WUI5eDh3MkJuL2NH?=
 =?utf-8?B?WjkvaGx0R0lDeFlzNXFRVVU0VVJpQnhzYXpORVBMMkZrNnRyeHZiTjhLVjFr?=
 =?utf-8?B?eW5qVEY2Z3NzaVJvdkpxK283NEF6aHIzL0pDL2l0Qy9OVU1ueWY3UHlyOGJt?=
 =?utf-8?B?QUFLb1YyUWdzTldoeSs4QnRvVGxibU9KUlFEbUI4RnIzQjk1RlpSWG9jTUVh?=
 =?utf-8?B?QzBZT1Z5MWQwRmo5a2d2TVJxSWJhV2R5c0YwNjJvYWpUTml0UDdtbHgzQTB2?=
 =?utf-8?B?VWwvOWpGdm9Bb0dHVTZRYUZpVy9wU01XeWVZK3ZSWWRBNDAvR3VMZWgrSW5u?=
 =?utf-8?B?aStVYlVpSVhDYjVWdGw0NXMydVhIZmVJYVhxQ0dIT0t4MEFaeTMwaThrY2I0?=
 =?utf-8?B?UGZhbDRnVUlNNzIxOThnTVJzSXVPZHZpSEFHaTBKRzlPSWZWdUtnVXd0U3lp?=
 =?utf-8?B?RVFPaHlOTmhoalVYdjFob1RJU2V5SlI5ZmE4bnJyWjM1OUNFSEY3RVhtTHlj?=
 =?utf-8?B?S2RmOEg4T05nMXBNbEhIdGlsVlFFRHJQdEdDZCt0RS9ISWpGQVpXR3VyT0dN?=
 =?utf-8?B?Y1dKM2NXc2t4b3VnNWlnN0FwbXBQYWxJT092dzQ4VjBJOEVFeTNlYjU4Mll6?=
 =?utf-8?B?cmdmMjBpUEtvMkE0TVZmYTA3VjJEK1dVWk0zcHRMcDd4bENWOXhKRlhvbGl3?=
 =?utf-8?B?bTJqbFhndFE3aUFyQ293bmg0WkxGSzh2dGJWdDNJbithOXdqcUk5ajVuU0Ix?=
 =?utf-8?B?SlhtSVoyMTh5QUE5U20rSFl3eVczdVBPUHNxYXhJQSt0dDVWUWMyalRVb1I4?=
 =?utf-8?B?RTJ2dldoby9SKzl2UElIWFo2TE9kS1pMbGdOcVhuNVRFQWVpQTNrNExRRUho?=
 =?utf-8?B?NWxockhBTXMvWkVQZDFsSERidkZscTB4eG9ZNC9CQnFQcnpSNTVjNW0yUWNv?=
 =?utf-8?B?N2ZENVV2Yko5MEpaaTlpOTBlTWFSMzJKTTNCV0dhQUxMdVVON1BJL2JCc3NO?=
 =?utf-8?Q?PpqE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c21bfcb-c5d1-4fef-1f75-08dc3a4930cb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 23:42:00.6970 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXSQtsXIPiDSjsm2OfUvm1oFYdS+bEecXYUJoD1QuYvvkMsYHY8NxUdFl/29orvo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6268
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
    <div class="moz-cite-prefix">On 2024-03-01 06:07, Shashank Sharma
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240301110724.947-2-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">The idea behind this patch is to delay the freeing of PT entry objects
until the TLB flush is done.

This patch:
- Adds a tlb_flush_waitlist which will keep the objects that need to be
  freed after tlb_flush
- Adds PT entries in this list in amdgpu_vm_pt_free_dfs, instead of freeing
  them immediately.
- Exports function amdgpu_vm_pt_free to be called dircetly.
- Adds a 'force' input bool to amdgpu_vm_pt_free_dfs to differentiate
  between immediate freeing of the BOs (like from
  amdgpu_vm_pt_free_root) vs delayed freeing.

V2: rebase
V4: (Christian)
    - add only locked PTEs entries in TLB flush waitlist.
    - do not create a separate function for list flush.
    - do not create a new lock for TLB flush.
    - there is no need to wait on tlb_flush_fence exclusively.

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a>
Cc: Rajneesh Bhardwaj <a class="moz-txt-link-rfc2396E" href="mailto:rajneesh.bhardwaj@amd.com">&lt;rajneesh.bhardwaj@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com">&lt;shashank.sharma@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 ++++++++++++++-------
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 310aae6fb49b..94581a1fe34f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -990,11 +990,20 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	/* Prepare a TLB flush fence to be attached to PTs */
 	if (!unlocked &amp;&amp; params.needs_flush &amp;&amp; vm-&gt;is_compute_context) {
+		struct amdgpu_vm_bo_base *entry, *next;
+
 		amdgpu_vm_tlb_fence_create(adev, vm, fence);
 
 		/* Makes sure no PD/PT is freed before the flush */
 		dma_resv_add_fence(vm-&gt;root.bo-&gt;tbo.base.resv, *fence,
 				   DMA_RESV_USAGE_BOOKKEEP);
+
+		if (list_empty(&amp;vm-&gt;tlb_flush_waitlist))
+			goto error_unlock;
+
+		/* Now actually free the waitlist */
+		list_for_each_entry_safe(entry, next, &amp;vm-&gt;tlb_flush_waitlist, vm_status)
+			amdgpu_vm_pt_free(entry);
 	}
 
 error_unlock:
@@ -2214,6 +2223,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&amp;vm-&gt;pt_freed);
 	INIT_WORK(&amp;vm-&gt;pt_free_work, amdgpu_vm_pt_free_work);
 	INIT_KFIFO(vm-&gt;faults);
+	INIT_LIST_HEAD(&amp;vm-&gt;tlb_flush_waitlist);
 
 	r = amdgpu_seq64_alloc(adev, &amp;vm-&gt;tlb_seq_va, &amp;vm-&gt;tlb_seq_cpu_addr);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 298f604b8e5f..ba374c2c61bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -343,6 +343,9 @@ struct amdgpu_vm {
 	uint64_t		*tlb_seq_cpu_addr;
 	uint64_t		tlb_fence_context;
 
+	/* temporary storage of PT BOs until the TLB flush */
+	struct list_head	tlb_flush_waitlist;
+
 	atomic64_t		kfd_last_flushed_seq;
 
 	/* How many times we had to re-generate the page tables */
@@ -545,6 +548,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			  uint64_t start, uint64_t end,
 			  uint64_t dst, uint64_t flags);
 void amdgpu_vm_pt_free_work(struct work_struct *work);
+void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
 
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 95dc0afdaffb..cb14e5686c0f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -636,7 +636,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
  *
  * @entry: PDE to free
  */
-static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
+void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 {
 	struct amdgpu_bo *shadow;
 
@@ -685,13 +685,15 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
  * @vm: amdgpu vm structure
  * @start: optional cursor where to start freeing PDs/PTs
  * @unlocked: vm resv unlock status
+ * @force: force free all PDs/PTs without waiting for TLB flush
  *
  * Free the page directory or page table level and all sub levels.
  */
 static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 				  struct amdgpu_vm *vm,
 				  struct amdgpu_vm_pt_cursor *start,
-				  bool unlocked)
+				  bool unlocked,
+				  bool force)
 {
 	struct amdgpu_vm_pt_cursor cursor;
 	struct amdgpu_vm_bo_base *entry;
@@ -708,11 +710,15 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
 		return;
 	}
 
-	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
-		amdgpu_vm_pt_free(entry);</pre>
    </blockquote>
    <p>I feel like if we attach tlb flush fence before free pt bo, then
      don't need tlb_flush_waitlist.</p>
    <p>Regards,</p>
    <p>Philip<br>
    </p>
    <blockquote type="cite" cite="mid:20240301110724.947-2-shashank.sharma@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
+		if (!force)
+			list_move(&amp;entry-&gt;vm_status, &amp;vm-&gt;tlb_flush_waitlist);
+		else
+			amdgpu_vm_pt_free(entry);
+	}
 
 	if (start)
-		amdgpu_vm_pt_free(start-&gt;entry);
+		list_move(&amp;start-&gt;entry-&gt;vm_status, &amp;vm-&gt;tlb_flush_waitlist);
 }
 
 /**
@@ -724,7 +730,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
  */
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
+	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false, true);
 }
 
 /**
@@ -1059,7 +1065,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 					params-&gt;needs_flush = true;
 					amdgpu_vm_pt_free_dfs(adev, params-&gt;vm,
 							      &amp;cursor,
-							      params-&gt;unlocked);
+							      params-&gt;unlocked,
+							      false);
 				}
 				amdgpu_vm_pt_next(adev, &amp;cursor);
 			}
</pre>
    </blockquote>
  </body>
</html>
