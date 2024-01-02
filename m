Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B038CC47074
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 22:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A8D310E216;
	Tue,  2 Jan 2024 22:16:45 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6193710E216
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 22:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nezwVsVaTJ44oBoX98kSOih6If3tJcatMI83UwenZCXkXi1ENn35MJJZXRHNnycfUBzeQYTxV5JFkj2cypQBmYAe2pG6Cj0AJ9j3XpVAJ8tlgXaUw+amvtFvlFRr1WVVasOYit/80/5jv5OxC/sHroq5w4T55ad+MpjwLTBLJuCk29yl2FCFAf7NocjhI8rxmdxjSEnFPg+8oJmx8dS7wexfsPszDlkTetJgYeVwGvBLQvZab4ermVJ9YJXCXfU1KW5avm4sETKTR1ZMbvGAYuVxGDlWyObDQBewNNXcEnbpL1yfcSPZpfPh9GrzCjejbYA/SEXpKb5ZHqN3C+2J3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/i4v4BFsBl1pkan4UJYC5aRxt+uNtO1qf0uy7xI1yos=;
 b=iyqHhAYbQmvY1asdpZH7YMj9PVCMtLx1YQ3IhEAee1/EQLFZ9KuZoXn5JGqtbM/Mgtlkzbx4B7Q4Zi5UOpupboydPgMiFn6P+GPWPIcpRR8jBk3+fB2Vls2O1xTGY0JQM5CbtyFNL7uGj7Wtynf1CAZEKaRYXYzQ1FbbhdgULj0vYhskTCFolDri+wrL1LfFjIsxR2ocVw6UNVAN/k8JWTmw0QNJQp5WgcevvWfqv7L7Q2fLP5lown29FmejY1KQfl7I4/TdOvMF+ReBfqm+4qN2aK2+2HDlczcndwTr0bwP2iiEUZthuVBA4l+aGSrSXFbs1+CHYt5HRC5+Rr2EeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/i4v4BFsBl1pkan4UJYC5aRxt+uNtO1qf0uy7xI1yos=;
 b=wKYcNzakeQOQ+4GfrCwjRoFjMjvSek6ietjLXoFf9ZDhssOmG7dVDlUM5P0uF/2yhfk0cCp5Q6N+DOEoB6nSQOTqn4chlNeqHUp7U7WfbGkG7nGobPoRRW5OBiBijJbqYkPYooim5lFHOQiknXGFzC1YKXoJz87Kd4eLPDGY/bM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 22:16:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 22:16:40 +0000
Message-ID: <789a7b88-97ec-a536-b47c-ca0f15eb01a0@amd.com>
Date: Tue, 2 Jan 2024 17:16:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdkfd: Fix lock dependency warning
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240102200804.68030-1-felix.kuehling@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20240102200804.68030-1-felix.kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::14) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fa6238-9b5e-41b5-c012-08dc0be07e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zlQri8EIYuycmGltEFQ4LxFsehXb00795vGiH119+aRyh0ubNcu+6kG6AYgDGpjCLjeKjJO6dgPpQ41eWFDcwIWGdREuYZSHaHxuv08eSnRid4KmQUv7LHMQ00AQexwp/+4+tLnkNXPV3GtixN2FxxcmmY0b7v7mgX/R0jIIJyMcqnIOfbT7Gd9ed890dFfWqIiB+8Z6xS+yDG3skqA0Q5uVwCtyzekwhofKXrV1UL+g1nbDdWlA1vrtKcStssOSgUqwh23f5Vcnbp99inhLgNSz3CH59DaGxNAx321fnHzd3+SKYJp6dC+ZxYHSnh5JnirkmOxkDZGVPKYmTOSMYkYtjFhY9LtzGoxI3r3OSUn6SIkIfnNwWWjphVJeVYPtS4/MI1Fbu3tnHOgTaVBXM3iAoGvy0tXzgbtx7ZdIIyA/P3qOdEINRiBs9LUtiZfOxy3XDj7Rhw54/nzgBMPP5qpRURpoqm9zS1T4cS5EZfvNZKVWIcGylEPAa2j5oJF5snQ1iPeyAUX2Gn4SLFV9R/bQ3smVQUpYwEIApciQuqCztJbrQ48Ba62LJlax5U5CH5EEIVEz1JYGihye3dR9dCd6ZbeZGj/VRTuaM2w/z9WmWZmn9QYf+dPKUx2UoT26ffcrqmb/aA2kdUWEuDtw3hhsIza9FtZsCpIgG3j1bLk3Dba/TN6yk5m8o4yA9x91
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(41300700001)(2616005)(26005)(38100700002)(316002)(8676002)(8936002)(4326008)(5660300002)(6512007)(478600001)(6506007)(66556008)(66476007)(53546011)(66946007)(6486002)(31696002)(2906002)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qkp5NEtldk5vbGVub1BOT1ZtTHM5TXh4K3ZJZXdDdVRwR3lVRWkwQWY3dlNy?=
 =?utf-8?B?SzFjQVZGWDl5QSs2N1BsYkxES1J4Q2Vwa3VZVERiOEtHQll4WnJHRVp6bXlU?=
 =?utf-8?B?NzczRGFHYmo0aFg1amtTaGI4amtYL2RuRnM1eFdaYmFZNEZkTXZtOGF2c1B0?=
 =?utf-8?B?b3ZTOE5PeWF6cUU2RFIyVFVSTWhvY1hhVnpKS1J4Tm9ZZG4wUFkwbFByYVhV?=
 =?utf-8?B?VjY5UE5sNWkrV1BLSlE3WTE3ai9EYUYxemZ4RlVVVm4vQ09XaGk4NVIvaWFt?=
 =?utf-8?B?ZkR0T2tlQnRoVGdmK291eFZCcWdid29PTm1PZHU5aDhVaW5aTzlzMXNsOHR1?=
 =?utf-8?B?UFg1K1Rwakd2cjUyZGs3K3Q4OEZ5Y05hdm5hYjhSNnpBM2g0UmxFL3R4d2Ev?=
 =?utf-8?B?SndKNU5qTUtyTzJQc3pwWUg0NXJBRkFNeWJ5UUpKWFBibitXQk9pY3JEVkFX?=
 =?utf-8?B?ejlDRi9NTkVwR1VabVNUSWFDaUg4SVlKMlZrYUtuTW12OHQ3UW1OblNTOUdU?=
 =?utf-8?B?blgyUDVuazV5TW0rUGw3dmtXZUhuRlcyNUt6L0ZNclJURk5BV0RJWEZQZHBH?=
 =?utf-8?B?RlREK3kwVGZoUDZMTW5iNnZLc0JNWHVIaDlEeVpJYVlpNUdURmFCM2xaOTZG?=
 =?utf-8?B?clE0MEx5ZjRpMWhZQ1JzRTFIcDFrbmtZeGVudmxHV2o2bUtYeUhkdW45c3ZM?=
 =?utf-8?B?SzhsbFg5Q2Q5QWZkanl2UjdLTlFueHdUUStROTIzZ3BrWndVSzMybU1DNmFt?=
 =?utf-8?B?SXpVeFpTdU95Y1RHcGl2VktsNnVsYjdHR3lvTzBPaUQzTGlVNWE3QTFkREhH?=
 =?utf-8?B?bXFZdzRkNWJvR1U2R2tOdGNSaVEwVUU3dDF6ODJUdnRpb0cycVFIQmVBNDBq?=
 =?utf-8?B?akZoeGplbFFHSXBGa0lHcnVpOHFJS0hOZHhERUZSMlpFY2ZqUEh5eVprczBS?=
 =?utf-8?B?VE9KV0gvODRZT2tvTlpuRVlmWjdnQjVlTEFVeFdTT0ZGWjZsQlZ2SExjbVJs?=
 =?utf-8?B?NDNyMFZuampId2RoaCtUNlNBY3ZQU1pLVXB1dS9NWHhMcUlRWGs1SHZHNysx?=
 =?utf-8?B?WE1OZzZyeXZhSU52VGZRRHF0bzJnRnVJRW5ZNkxhRXdocWM1Y3dXZFl4aUVk?=
 =?utf-8?B?enU1bFJoMFZ3dWt0eXhaOWxYVm1ORExiYjJsOVNZc0tnZ3J5am5uMVRpTERU?=
 =?utf-8?B?c01ZOUNic29wOVRlWjM1ZGJxOUQwaUllci9sNW02MldTTFFpZ2tKZlU4VTRJ?=
 =?utf-8?B?b1o4Z0tOQ1NTVDZFT000K3R1WU0vYnFCUHBQYTFVRnNaNjBzY0xlWWxkSFlP?=
 =?utf-8?B?NU5aSEVDVGxVaUpoTzBOTitGUmErQUQzcnYyczQzVXVSbS9UQ0IwY2xyOXc5?=
 =?utf-8?B?bGJ5YzRmblk3RVYwSGdVN1UyR1JHSE5VUllLNytMZGwwL0c1d0xtNUNqK3k5?=
 =?utf-8?B?SXJyWHhocDBoRW9HZ1FKM2k3aWd4WEd4cllsSUh3VmZhenVlM1VTdGRuYjRl?=
 =?utf-8?B?dC9TTjg2UnJXdmFPS3kzSjF2UmZmSExpaUFjMFdIUWVORFZ3eWF0Y0MyTzhz?=
 =?utf-8?B?d3JKOGlMZ3RVVVgxZHNpT1VzNzV5dnN0SS9uUDFmYnlPWHFyQTVuYTdYTGZa?=
 =?utf-8?B?MGhtNGd6ME5RWFVaRHFLUWo4c0R3MG92UGNubzk4UEl3cWU1dnB5TGtOUWhO?=
 =?utf-8?B?UC9xMk0rNGRWUzI0dkR3SUNMSjUzSnNBR3k3N0N3RWVhejI1WFp5ZjVSZnpC?=
 =?utf-8?B?NlBjN0xOWmg5cHA0b1ZzQXl2REpHMWNNVzRuaFh1NXVUYTJZN0UvSkVPYjAw?=
 =?utf-8?B?MDJCRTJZZEVKQjZhRzRXU1NrSHZqbzZPS2l4Q2JEWmhLVkVvZGVlSkdYbHUr?=
 =?utf-8?B?OExsa3FRbDJrUzBWUlUzcDR1dC9QeGhid3NSV3dHT3MrbHRqM0tWZTRRQTJs?=
 =?utf-8?B?cTRpamoyY2duc1VQY1k3ak9tTFVybEliUjNyajZqdFQyZDJhTy8xdmp1WnVl?=
 =?utf-8?B?dFVLMDI1bzFzRmxpa284YkpIQ1M2cnUrNHF0cStkczhTZnEwYzNmS2hBUDVh?=
 =?utf-8?B?YnlYSjZzaWU5UGk2VThlODlySHgxUVN1cEZQeDV0RThCS2NISU0rYTdPVTRG?=
 =?utf-8?Q?uxoQIyWJ0f8oxsAHguVWnfD5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fa6238-9b5e-41b5-c012-08dc0be07e6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 22:16:40.2999 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KVoxEWkOO6Gp89P4wz5qIJbW3cgjbRefjorXspKmkNhQ3H2UgUJFm5qBi4By7Lys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2024-01-02 15:08, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20240102200804.68030-1-felix.kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">======================================================
WARNING: possible circular locking dependency detected
6.5.0-kfd-fkuehlin #276 Not tainted
------------------------------------------------------
kworker/8:2/2676 is trying to acquire lock:
ffff9435aae95c88 ((work_completion)(&amp;svm_bo-&gt;eviction_work)){+.+.}-{0:0}, at: __flush_work+0x52/0x550

but task is already holding lock:
ffff9435cd8e1720 (&amp;svms-&gt;lock){+.+.}-{3:3}, at: svm_range_deferred_list_work+0xe8/0x340 [amdgpu]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-&gt; #2 (&amp;svms-&gt;lock){+.+.}-{3:3}:
       __mutex_lock+0x97/0xd30
       kfd_ioctl_alloc_memory_of_gpu+0x6d/0x3c0 [amdgpu]
       kfd_ioctl+0x1b2/0x5d0 [amdgpu]
       __x64_sys_ioctl+0x86/0xc0
       do_syscall_64+0x39/0x80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-&gt; #1 (&amp;mm-&gt;mmap_lock){++++}-{3:3}:
       down_read+0x42/0x160
       svm_range_evict_svm_bo_worker+0x8b/0x340 [amdgpu]
       process_one_work+0x27a/0x540
       worker_thread+0x53/0x3e0
       kthread+0xeb/0x120
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x11/0x20

-&gt; #0 ((work_completion)(&amp;svm_bo-&gt;eviction_work)){+.+.}-{0:0}:
       __lock_acquire+0x1426/0x2200
       lock_acquire+0xc1/0x2b0
       __flush_work+0x80/0x550
       __cancel_work_timer+0x109/0x190
       svm_range_bo_release+0xdc/0x1c0 [amdgpu]
       svm_range_free+0x175/0x180 [amdgpu]
       svm_range_deferred_list_work+0x15d/0x340 [amdgpu]
       process_one_work+0x27a/0x540
       worker_thread+0x53/0x3e0
       kthread+0xeb/0x120
       ret_from_fork+0x31/0x50
       ret_from_fork_asm+0x11/0x20

other info that might help us debug this:

Chain exists of:
  (work_completion)(&amp;svm_bo-&gt;eviction_work) --&gt; &amp;mm-&gt;mmap_lock --&gt; &amp;svms-&gt;lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&amp;svms-&gt;lock);
                               lock(&amp;mm-&gt;mmap_lock);
                               lock(&amp;svms-&gt;lock);
  lock((work_completion)(&amp;svm_bo-&gt;eviction_work));

I believe this cannot really lead to a deadlock in practice, because
svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
refcount is non-0. That means it's impossible that svm_range_bo_release
is running concurrently. However, there is no good way to annotate this.

To avoid the problem, take a BO reference in
svm_range_schedule_evict_svm_bo instead of in the worker. That way it's
impossible for a BO to get freed while eviction work is pending and the
cancel_work_sync call in svm_range_bo_release can be eliminated.

v2: Use svm_bo_ref_unless_zero and explained why that's safe. Also
removed redundant checks that are already done in
amdkfd_fence_enable_signaling.

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com">&lt;felix.kuehling@amd.com&gt;</a></pre>
    </blockquote>
    Reviewed-by: Philip Yang <a class="moz-txt-link-rfc2396E" href="mailto:philip.yang@amd.com">&lt;philip.yang@amd.com&gt;</a><br>
    <blockquote type="cite" cite="mid:20240102200804.68030-1-felix.kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index afd98aace065..6b314e4d3ae0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -404,14 +404,9 @@ static void svm_range_bo_release(struct kref *kref)
 		spin_lock(&amp;svm_bo-&gt;list_lock);
 	}
 	spin_unlock(&amp;svm_bo-&gt;list_lock);
-	if (!dma_fence_is_signaled(&amp;svm_bo-&gt;eviction_fence-&gt;base)) {
-		/* We're not in the eviction worker.
-		 * Signal the fence and synchronize with any
-		 * pending eviction work.
-		 */
+	if (!dma_fence_is_signaled(&amp;svm_bo-&gt;eviction_fence-&gt;base))
+		/* We're not in the eviction worker. Signal the fence. */
 		dma_fence_signal(&amp;svm_bo-&gt;eviction_fence-&gt;base);
-		cancel_work_sync(&amp;svm_bo-&gt;eviction_work);
-	}
 	dma_fence_put(&amp;svm_bo-&gt;eviction_fence-&gt;base);
 	amdgpu_bo_unref(&amp;svm_bo-&gt;bo);
 	kfree(svm_bo);
@@ -3437,13 +3432,14 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
 
 int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
 {
-	if (!fence)
-		return -EINVAL;
-
-	if (dma_fence_is_signaled(&amp;fence-&gt;base))
-		return 0;
-
-	if (fence-&gt;svm_bo) {
+	/* Dereferencing fence-&gt;svm_bo is safe here because the fence hasn't
+	 * signaled yet and we're under the protection of the fence-&gt;lock.
+	 * After the fence is signaled in svm_range_bo_release, we cannot get
+	 * here any more.
+	 *
+	 * Reference is dropped in svm_range_evict_svm_bo_worker.
+	 */
+	if (svm_bo_ref_unless_zero(fence-&gt;svm_bo)) {
 		WRITE_ONCE(fence-&gt;svm_bo-&gt;evicting, 1);
 		schedule_work(&amp;fence-&gt;svm_bo-&gt;eviction_work);
 	}
@@ -3458,8 +3454,6 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
 	int r = 0;
 
 	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
-	if (!svm_bo_ref_unless_zero(svm_bo))
-		return; /* svm_bo was freed while eviction was pending */
 
 	if (mmget_not_zero(svm_bo-&gt;eviction_fence-&gt;mm)) {
 		mm = svm_bo-&gt;eviction_fence-&gt;mm;
</pre>
    </blockquote>
  </body>
</html>
