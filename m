Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F94C3DA6E
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Dec 2023 23:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBFB210E07D;
	Thu, 28 Dec 2023 23:11:56 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3983D10E07D
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Dec 2023 23:11:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uqd+oUDknXx6fG+KjMFkXcu4gs2/RFOOychYgJxfCH2nr548vqHN8sL0nEuo3tqhwRPKJFEH3lkKhTKepRKVJdKAYLnkWSAioljOaJtbpMaKL5bc5WxU57UtFxC36rugZxxFsXOBdOy+gEcKonNAhkuacq3LjCXLlJa1iE+xvsv26tL9BKPED/KHiDUWlblqpMAvyCM1ZjGhqO2O3QJDc0MDAQM2GyVj8n7SuLZAZ59kxJJkl3poMrEGRBYa1fdEeYV/mGaeBFe3PQJNSnJwwJktFZ0Eq2a9InuiXyIfrH23X5j3PHqQ1bVSoMWpghHt1Iv9+qZgIvGOj8r6CJOUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hmr1uk3OM5TXPFs0YcZ4vg3aHVtHajjQDIZ21el6fc=;
 b=FqBaLrUEcB2iWoV+IdN61MWuUrF9SQPhB71FTzzQ75MMbnjZp3lBj0OCqjPpqiwoaFN5aT8qkV6mG7SymBs60fPJDueVmoibjIDswJ8Ccnr1eKhby3m7bD61bXcv4/eUU1lVIYUED2uSoZUS5m8e3VKJOmrZWXXy3PF2lvyW4ZkKi37uy1TujQd0Hlvw3KrNbuktYy8t4l96TEvQICl0CTykDZ8gfp1wFEXdBQTdEiMLTY1piZhWQuiLQEF+fp5lyaanlkOMJF632zBVdUmCgk18JUw0B+7XueiZgNG1qG8jmCovuMxIFDRaWHV6rnSXFgCwjQAExAWVBvqwhE/IJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hmr1uk3OM5TXPFs0YcZ4vg3aHVtHajjQDIZ21el6fc=;
 b=ArcLv2d86Ez0r12r2sxZ3Y8CWe5XJMB8aa6/9ucq/c7TjK9rLc4ZXRqo6I1RuiaZLd/sFGRM+4+6o1Vcld+oW9t8WCGs8jW9v9XpMO7kINRz4SKiiJkd0sR3Zk+xmm6ufmPZgSggBgVs48u2ArVSizy6AaWkBd13sIUjpYCCxDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DM3PR12MB9435.namprd12.prod.outlook.com (2603:10b6:0:40::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.21; Thu, 28 Dec 2023 23:11:52 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::766c:af4:a36c:2c79%3]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 23:11:52 +0000
Message-ID: <a4d70d39-4515-f1f3-ae0c-d7a4d0946db7@amd.com>
Date: Thu, 28 Dec 2023 18:11:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix lock dependency warning
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231221204004.830821-1-Felix.Kuehling@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20231221204004.830821-1-Felix.Kuehling@amd.com>
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0270.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::7) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DM3PR12MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 525ee287-eff9-4ba1-22e0-08dc07fa607b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nL0JJQJbBvu2c1l9LL/Obv87q7lRUTZ7bMQtsAmBFYmI01bIwe9Lx6UND5V9ZbSTTsHoP7rk0K37BzrV+A0Z70DGU1UMe1qU03j10Cq0dDSswoZ9aFM7yL5w+xaSzigt4JK8r28ZaOhn63n5CzlNu5kFFjWRQFXmjwQQ2JSafc/b/UlGGrPu5+C9bwx01wzwStDlStk9fw3AhD+AzDG3SyKhCwAJLEqZBskPzCrKcfQY9W5ZkzL6duNKPPS3WkStva9nb6id8jDR5RmM8PPN37DGZiXX+jRwjIx/qvf5MVAZ6uxkqx3Xzb3vp/s2Fk96huzBAQRZuhGHcp6yG9Sdgm/xIThke99JB+KFg3KUrEQKuNOxUcXaD9midcg0HXzf0LOLBT8mIgurQ4hnXMwJWhoFC6r/M6WZ2TF7elTkSk3yn7T0X8l5edHT+nrOG4jEilX1v2Qt9dRzuSCWk6mmIhAMYKZ0U3P4WlZbp/Su5h8zAbC7YwAqaRzljPXeS8l3oqhHVzc+4qjBWXrc3EpYHHm4xfn7SNcFPnLrlx+7glEwZL2fIT0Hnjd2rVgoEw5q2sx9tcBdifMjqCsf9nbjzL2E+I8a0dvC0iUX0nBJfa/bob6MbFkLGC3tkVR4EI8SmlH4id1UDfUh3rpwqYQ/+iR2X5gevu9oSNgOZ+fQpYzPsMrbKcX40qowXLk3pswC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(346002)(136003)(396003)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(83380400001)(31686004)(2906002)(4001150100001)(66946007)(66476007)(66556008)(316002)(38100700002)(478600001)(6666004)(6512007)(53546011)(6506007)(26005)(2616005)(31696002)(5660300002)(8676002)(8936002)(4326008)(6486002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3JhSnRhU01YQTNCWlBOY3RIQUNkczE4T3k2Nk1KMXpLb0ZDTGczRjVGUjZK?=
 =?utf-8?B?SEt3S1NIQy9KRFlwQndBazBzSC9kckxCR1d3VjlKclhkcEFzbWFkNTVrYTJB?=
 =?utf-8?B?aTYwdTBvaDNISTY1SEJRbEttOGZYYVNMcE1oS3o2QURxcURyUkJ0bUdSWWdm?=
 =?utf-8?B?ajhydGVDVlcrUGwvY2x5Z283L1pkZEsraDYwZVdjaEI3TlFvandrYXVNc3Ru?=
 =?utf-8?B?SkFtbXFOMHQvU29VaTRGZ05RSjg0ck5rMWNIRUNNVHRDRHZySE5YSzV6N0pk?=
 =?utf-8?B?UmxsdjgxZCs3ODFYL05sN2VFVFY4Um5UcHFrQTJCN1VPVHZGSXhNOXlCb3dJ?=
 =?utf-8?B?QzVGdkIzTGM5am8xekhXYVJYbjMwL2hENGs0R0d3SCt1b2RadGNVSlNFcGJn?=
 =?utf-8?B?RHBrOUhaTWY3WThTaUlqNHVQTFJnSlNYV0RUL1ZmdGZzQWtPVElOUEI4Wi9K?=
 =?utf-8?B?L3MvUElRbW5MMEd5Q1AvMlp1SG44UjZNVUVlcmFYRGgzejFpWjlRdEdDSGZy?=
 =?utf-8?B?b3dGU3k5b2hjYlhORTFaSXZWQ1pFTDIrTzVhZnhtR1hqYVJjc0pwbmVyS2lp?=
 =?utf-8?B?b3BRWXE4OE1PS00yN1VhV1FGTWlmWEJOdy9Bc25LNGNGMEU5N1FHdG9pdmFY?=
 =?utf-8?B?cHI5V0VxTGlwZ3dWSFQ4LytZNWFLVVFyRHo4c3ovcUYwRjdvOEN5eWdUWW1S?=
 =?utf-8?B?dWQzNE9tMVZ2dWFxOUV0QXg1cFNueFg1cHcydVRHeWlobk1tN3N2amMxd1Z1?=
 =?utf-8?B?Z3RPUi9oeElGVzU4Tmt4Y1Jzcnprc3A5dmdxWjlqcDdEMi9lZ2pTMExBY1BG?=
 =?utf-8?B?U0JUNUtMUjlSWHJ5TENYVDU5SmxGM2tZb3l0YndDRTNJaTREZWRBYk5ZRUNl?=
 =?utf-8?B?TkM2UlBOZzRFeFlTNUZSZUk2QzJUN1JackZoWFBNZXRqS050RUxMZjRDR1Uy?=
 =?utf-8?B?R2VscXJRVWR5bkVoNWpRbVF1RUR6emtBL2JZaWQ4VHpQY1FoTVlDQ29xVWhO?=
 =?utf-8?B?UzNnRVVBVDVWV3dWNjU4ejdlSFlzK3htd0w5d2UxOTZhaUJTZ0lubmJFNUJh?=
 =?utf-8?B?YXpQQU5xejVjTk5lSFFuY3FIaVBrbGdMNVpEa25kNXFQNUI5c1B1WEdJd3VT?=
 =?utf-8?B?UFIvMUxrK2dWS252K3IrZWNhdWoraFo3dGJxbWtoUHgzRFhnbXpMczREQVBk?=
 =?utf-8?B?MHRYSVRXVTBPNG05Zjl3ei9TUG55RHFMbnZZcDVyKzgydVJKRU1YcVBFTFZi?=
 =?utf-8?B?Smt3RFhKNmFYbTMwTDJXdFlCTllHczRBY3hwWGNzc0tSdFRXN0FyN2dsVDZ1?=
 =?utf-8?B?Ym8rdDhFNkhyRDBtb2tqZVRDcHkrMW5Nd29PRGVaV0hZdmZqTnhVQlZnVndh?=
 =?utf-8?B?YU12QUNkOFhzekpUOTQ4cHNLR1VPSmR5dW1UUm90T1QvV0FyYTJ5WGZlNHZQ?=
 =?utf-8?B?RExHeWEwMWI4eTRuMC9qQjJXanZWYmdPTUJnejJ3czd0Q3B3c0RBUHc2K3BR?=
 =?utf-8?B?Z1o5V2JNWjdWWXNJd3BxMFlUUlJnZTJBc2dhRWo5aEtEQ3o0R0FYM1k0OW5l?=
 =?utf-8?B?aEZ3WWxML3BLQmIwSXZCc1NiTWxmL1pSOUJDbUhNdW1kNW9MVjVtTmZnZktJ?=
 =?utf-8?B?UmI4a3hRY0xVZmkxVEoxTXI1RXFVMm5vM3ZmenBhNDBkOVYvdVNweUY5OFZE?=
 =?utf-8?B?OGoyMmMvUTNRaTd5eGdVUTduL3haWGZ5M2hNNERDemVZMDNpL2J4bFVzaVhN?=
 =?utf-8?B?cXRTWW9BQWIvOWRqeFYwNXo3Q2RaMXphMTl3VW80dUtSNnRLVVIwS3Y1bXNn?=
 =?utf-8?B?ZWdMRHNGaEZLK1I1UjhRTHdMcXpjNDVLd2JLZzR1YWw5TWQzeE1IOTRXVStI?=
 =?utf-8?B?MjhLcmZBcTlsTzJzVmQvMGZHcFh4WmdBa3dZYmtIMGdrbjdnNitOaE9tTnhE?=
 =?utf-8?B?NlFkTHFzYU9EUDBaTENsU25RZk5QdWdvN3Z5aDVWbEZScWpaUnVkVGErQm9l?=
 =?utf-8?B?MXloOEM1eHpOYzFmNnlTZjRJUENLWXdEZjZ3RlA2R21CeUZETE1NOGU3azFF?=
 =?utf-8?B?UVZZVUtRb3NqRlQ4Y29vc21hNHVla2Jsdm5NK0E2SHhoYUxhMVpEQzlaSzlK?=
 =?utf-8?Q?M5tw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ee287-eff9-4ba1-22e0-08dc07fa607b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 23:11:52.2885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCOUVzRe1xtRBRC6QflQVvKKBk3vWYjPz2ED+DQ5PVHccqKsk1+TbgnMQwL7+QRn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9435
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
Cc: alex.sierra@amd.com, philip.yang@amd.com, xiaogang.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2023-12-21 15:40, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20231221204004.830821-1-Felix.Kuehling@amd.com">
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

Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index afd98aace065..7683c96f0cbd 100644
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
@@ -3444,6 +3439,8 @@ int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
 		return 0;
 
 	if (fence-&gt;svm_bo) {
+		/* Reference is dropped in svm_range_evict_svm_bo_worker */
+		kref_get(&amp;fence-&gt;svm_bo-&gt;kref);</pre>
    </blockquote>
    <p>I think there maybe racing condition if bo is already releasing,&nbsp;
      get ref unless zero</p>
    <pre class="moz-quote-pre" wrap="">	/* if svm_bo is getting released, eviction fence will be signaled */
	if (!svm_bo_ref_unless_zero(svm_bo))
		return 0; 

Another solution is to call svm_range_bo_unref_async from svm_range_vram_node_free.

Regards,
Philip
</pre>
    <p></p>
    <blockquote type="cite" cite="mid:20231221204004.830821-1-Felix.Kuehling@amd.com">
      <pre class="moz-quote-pre" wrap="">
 		WRITE_ONCE(fence-&gt;svm_bo-&gt;evicting, 1);
 		schedule_work(&amp;fence-&gt;svm_bo-&gt;eviction_work);
 	}
@@ -3458,8 +3455,6 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
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
