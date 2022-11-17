Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65528C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Nov 2022 21:38:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642C310E517;
	Thu, 17 Nov 2022 21:38:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::624])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41F0210E68F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Nov 2022 21:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY9uufIJTr2T9v4uccrffWwhicA8jJ6YwvepmGequmtLV8iuurbbcd4yd00cYYtb9CIDrQyuWk7QnySR5UxBZvjM+eTQGqbJpTJKsmpTVQy8fyWfrHk5Nr2ESrPmZUiWweXoUiprQS5Vc4kBdzKHD6B5lttV6h1qqX+jRS8Ol1im0u/+epBzWmqJgqvxKIxzvocpVEwU+XinguOKcYaAqVD3ayLjNQpHVm3+RLdl2cme+6bN4BLw6TXSZG85m4NXq2+WQJdV5J+Smlo2i9AR3QBmTwaFsQma8i05Le5ivP9Ih890OYIkzXjXYngbhPUG5Qo1scr1DUIz1TPnZMOaaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE8d5tcgQIla71CwToJbFniau5+D4BPJ6OPb1HdTKYI=;
 b=EokIPRvBqexsbeLcdq0U1bkVFlTwTrUHtKbb9bZcefPvdngOg1Vh8CTj4YyPqoyhXixwbW9zbORWpyq6xfRgewp1gQzF5EhhPXl9opPjPD1M0/lsiqIm7EOkwvUYbdxDvO4hr4R41usBHBP+kkZabgZ6wMro/GIo6a6GR5Ka3oZPBcmJ7J7jsXwClQK4FL7sYbF6R88D6IQfC/GsBmxmNt15IuB5tFC9HuBxSmSQujzF0vwe4Fz6IzwqJssrU9FVaaJc0QaaNw5YlyavkhDGaap3PnJacOIiRfsOwGFKDrIUhoZ5GdNpzZU0hfudm3Y3VTRgKfXigctwgvQdLRpg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE8d5tcgQIla71CwToJbFniau5+D4BPJ6OPb1HdTKYI=;
 b=1FCBzN7UMAGhxD03WmeRiddDO0Cwm2kbxWQ8lke1gWsd6YnaxumSvobtQAtA22HPKK4G69gsM67Z9Y58gt5BHLgmyHokrfMdynsf6o4ZoNFasI9qKPTu48UGjy3DqTMVSmQlnPCSVsnt5XB9rp32N+Il+RkQxDLZDoe+GBzAb2Y=
Received: from BN8PR16CA0024.namprd16.prod.outlook.com (2603:10b6:408:4c::37)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Thu, 17 Nov
 2022 21:38:45 +0000
Received: from BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::5e) by BN8PR16CA0024.outlook.office365.com
 (2603:10b6:408:4c::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.14 via Frontend
 Transport; Thu, 17 Nov 2022 21:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT105.mail.protection.outlook.com (10.13.176.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Thu, 17 Nov 2022 21:38:45 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 17 Nov
 2022 15:38:43 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Felix.kuehling@amd.com>, <philip.yang@amd.com>
Subject: [PATCH] drm/amdgpu: fix stall on CPU when allocate large system memory
Date: Thu, 17 Nov 2022 16:38:29 -0500
Message-ID: <20221117213829.24861-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT105:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ec7a37-a8d5-4d2d-5338-08dac8e41af2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l9PYspD7ETAALKVGtcQexSmX/rZquv6LyOeq3keq2ePsmDqDJDdQcTpqQXKBwLuWHgktr/5H5NCxYQdBXRA8Jto4VRIw4hZanI8tA5vNBrjAAcV3Ee1oxRC+0BcbnVT5mWSt/R1zO2z7tTkpO61fcQaWqIdsRKHX6hPjXOYBbGjqMBAJXoI87mB8i3HVjILhlk/3upA0+0N5Wj/4w2cbNtTih8ksh/yGilK2QqkJ7E7FP+l1kcG3GDqhxFSWvoh0E5mbRX4aEOpAk28hUuR/02jVkwLtF9aZRKbOgf6vJnnB7uQHSE+cHsdCPn8Yma/BMxXXWa6Gk6wqxFtu33Fy5jJ2v80E8gJna5P37gjYbwbv95VvX0yJlhDAs+7ey6DTefZ7n+sor4xGDd+6gmRdtvDhIQvmi9WRGiJ1s3QrHlYGBpiPNTpxnh87DZWR+zFsJ0yo9UwG1YdxnNfuUjdFEbBIKVbKpaV/qAnUBGb/LylyUJiDvzMTtfQy7c/QzdKz7cYaGmfL2dK712lsut/351Q1TUazpBZHeW6kxH01t71fb8pVLuQ+ZE3rOYbTNy3TUIVO5pRT4OOimXtUpVchqyeriraHC2rYB2NC4hULK7Wu6AgUK14torEgphi3/HmvfS6qUy42AOhuhDQdCsUE54P52rg3YvGslwMRz8+BftTTSvHgg/Zalus+/IlqJxZyrZvlUiD+iqUnqBogb1LZyni1tv32WcFolIAexz2NqCY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(36840700001)(46966006)(40470700004)(478600001)(1076003)(8936002)(186003)(16526019)(6666004)(26005)(70206006)(70586007)(8676002)(4326008)(41300700001)(83380400001)(426003)(47076005)(2616005)(5660300002)(336012)(2906002)(40480700001)(36860700001)(316002)(82310400005)(7696005)(110136005)(6636002)(86362001)(40460700003)(356005)(36756003)(82740400003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 21:38:45.6065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ec7a37-a8d5-4d2d-5338-08dac8e41af2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT105.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When applications try to allocate large system (more than > 128GB),
"stall cpu" is reported.

for such large system memory, walk_page_range takes more than 20s usually.
The warning message can be removed when splitting hmm range into smaller
ones which is not more 64GB for each walk_page_range.

[  164.437617] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1753: amdgpu: 	create BO VA 0x7f63c7a00000 size 0x2f16000000 domain CPU
[  164.488847] amdgpu:amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu:1785: amdgpu: creating userptr BO for user_addr = 7f63c7a00000
[  185.439116] rcu: INFO: rcu_sched self-detected stall on CPU
[  185.439125] rcu: 	8-....: (20999 ticks this GP) idle=e22/1/0x4000000000000000 softirq=2242/2242 fqs=5249
[  185.439137] 	(t=21000 jiffies g=6325 q=1215)
[  185.439141] NMI backtrace for cpu 8
[  185.439143] CPU: 8 PID: 3470 Comm: kfdtest Kdump: loaded Tainted: G           O      5.12.0-0_fbk5_zion_rc1_5697_g2c723fb88626 #1
[  185.439147] Hardware name: HPE ProLiant XL675d Gen10 Plus/ProLiant XL675d Gen10 Plus, BIOS A47 11/06/2020
[  185.439150] Call Trace:
[  185.439153]  <IRQ>
[  185.439157]  dump_stack+0x64/0x7c
[  185.439163]  nmi_cpu_backtrace.cold.7+0x30/0x65
[  185.439165]  ? lapic_can_unplug_cpu+0x70/0x70
[  185.439170]  nmi_trigger_cpumask_backtrace+0xf9/0x100
[  185.439174]  rcu_dump_cpu_stacks+0xc5/0xf5
[  185.439178]  rcu_sched_clock_irq.cold.97+0x112/0x38c
[  185.439182]  ? tick_sched_handle.isra.21+0x50/0x50
[  185.439185]  update_process_times+0x8c/0xc0
[  185.439189]  tick_sched_timer+0x63/0x70
[  185.439192]  __hrtimer_run_queues+0xff/0x250
[  185.439195]  hrtimer_interrupt+0xf4/0x200
[  185.439199]  __sysvec_apic_timer_interrupt+0x51/0xd0
[  185.439201]  sysvec_apic_timer_interrupt+0x69/0x90
[  185.439206]  </IRQ>
[  185.439207]  asm_sysvec_apic_timer_interrupt+0x12/0x20
[  185.439211] RIP: 0010:clear_page_rep+0x7/0x10
[  185.439214] Code: e8 fe 7c 51 00 44 89 e2 48 89 ee 48 89 df e8 60 ff ff ff c6 03 00 5b 5d 41 5c c3 cc cc cc cc cc cc cc cc b9 00 02 00 00 31 c0 <f3> 48 ab c3 0f 1f 44 00 00 31 c0 b9 40 00 00 00 66 0f 1f 84 00 00
[  185.439218] RSP: 0018:ffffc9000f58f818 EFLAGS: 00000246
[  185.439220] RAX: 0000000000000000 RBX: 0000000000000881 RCX: 000000000000005c
[  185.439223] RDX: 0000000000100dca RSI: 0000000000000000 RDI: ffff88a59e0e5d20
[  185.439225] RBP: ffffea0096783940 R08: ffff888118c35280 R09: ffffea0096783940
[  185.439227] R10: ffff888000000000 R11: 0000160000000000 R12: ffffea0096783980
[  185.439228] R13: ffffea0096783940 R14: ffff88b07fdfdd00 R15: 0000000000000000
[  185.439232]  prep_new_page+0x81/0xc0
[  185.439236]  get_page_from_freelist+0x13be/0x16f0
[  185.439240]  ? release_pages+0x16a/0x4a0
[  185.439244]  __alloc_pages_nodemask+0x1ae/0x340
[  185.439247]  alloc_pages_vma+0x74/0x1e0
[  185.439251]  __handle_mm_fault+0xafe/0x1360
[  185.439255]  handle_mm_fault+0xc3/0x280
[  185.439257]  hmm_vma_fault.isra.22+0x49/0x90
[  185.439261]  __walk_page_range+0x692/0x9b0
[  185.439265]  walk_page_range+0x9b/0x120
[  185.439269]  hmm_range_fault+0x4f/0x90
[  185.439274]  amdgpu_hmm_range_get_pages+0x24f/0x260 [amdgpu]
[  185.439463]  amdgpu_ttm_tt_get_user_pages+0xc2/0x190 [amdgpu]
[  185.439603]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x49f/0x7a0 [amdgpu]
[  185.439774]  kfd_ioctl_alloc_memory_of_gpu+0xfb/0x410 [amdgpu]

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 47 +++++++++++++++++--------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index a48ea62b12b0..0425fc6a49aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -163,6 +163,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       struct hmm_range **phmm_range)
 {
 	struct hmm_range *hmm_range;
+	unsigned long hmm_range_end;
 	unsigned long timeout;
 	unsigned long i;
 	unsigned long *pfns;
@@ -184,25 +185,41 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		hmm_range->default_flags |= HMM_PFN_REQ_WRITE;
 	hmm_range->hmm_pfns = pfns;
 	hmm_range->start = start;
-	hmm_range->end = start + npages * PAGE_SIZE;
+	hmm_range_end = start + npages * PAGE_SIZE;
 	hmm_range->dev_private_owner = owner;
 
-	/* Assuming 512MB takes maxmium 1 second to fault page address */
-	timeout = max(npages >> 17, 1ULL) * HMM_RANGE_DEFAULT_TIMEOUT;
-	timeout = jiffies + msecs_to_jiffies(timeout);
+#define MAX_WALK_BYTE	(64ULL<<30)
+	do {
+		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, hmm_range_end);
+
+		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
+			hmm_range->start, hmm_range->end);
+
+		/* Assuming 512MB takes maxmium 1 second to fault page address */
+		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL) *
+			HMM_RANGE_DEFAULT_TIMEOUT;
+		timeout = jiffies + msecs_to_jiffies(timeout);
 
 retry:
-	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
-	r = hmm_range_fault(hmm_range);
-	if (unlikely(r)) {
-		/*
-		 * FIXME: This timeout should encompass the retry from
-		 * mmu_interval_read_retry() as well.
-		 */
-		if (r == -EBUSY && !time_after(jiffies, timeout))
-			goto retry;
-		goto out_free_pfns;
-	}
+		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
+		r = hmm_range_fault(hmm_range);
+		if (unlikely(r)) {
+			/*
+			 * FIXME: This timeout should encompass the retry from
+			 * mmu_interval_read_retry() as well.
+			 */
+			if (r == -EBUSY && !time_after(jiffies, timeout))
+				goto retry;
+			goto out_free_pfns;
+		}
+
+		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
+		hmm_range->start = hmm_range->end;
+		schedule();
+	} while (hmm_range->end < hmm_range_end);
+
+	hmm_range->start = start;
+	hmm_range->hmm_pfns = pfns;
 
 	/*
 	 * Due to default_flags, all pages are HMM_PFN_VALID or
-- 
2.34.1

