Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B85FC77B6E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 06:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBE3C10E708;
	Wed, 12 Apr 2023 06:15:36 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C733F10E325
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 06:15:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNa0kqe85Kas9ujjLRgIJaDK3lZB6BBCpX/3uKfjVe/MRA5qFMxdLmEBjqCgEr/G9ugi9ArIGWVeRQjYdn5ypqI6wfZwfNuh0iT4eA4aWLusUMMApul+8sdh/pxF2zVtCp1S/QM68cR/AgSOmmyxCEGR3fm6m7eXUDvukr0WdxelKnZJNqkU/UnBPYEovMXiE5PgD0x3XQobkTlEk2l9vkT0oU6YQkrlJjGbb3+Ihjj0LeLFtnEksiLkRU9hnSgaeXqgnwCxfPnI/tfhJxbrVBgE44DCjGyZ2wY8q5GbvyAeqRxP4LJQXnN7CA3bhtnPviczgDOJm4KUre6cTy8OHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVsPiyYq6GTG3VJThX45FddCAu0MOCvCNLUdWLdwOWI=;
 b=NC6t951kYKukH1gN/jbEmkyS5zdtK2QvwT3Amjm7BVXjKIybUP9QC92k3efT8TLqBwu/cjI950OvqN6ESIOM9c4sQAz9y7K5knqqME+IRqIuCSIgZE7UZmPGE8CQGxbsG6sMiPS39bMGQ8+eeQoNhvgrcjlMsNIxXhc+cEavCwMZrvYq5hOkcidCj9RG5imBnnxhCZrukGCLDMTt9Dbhiecu+I/vgXv5RD1k6l6xvyzP89a5h+WYrR17Q/iTm2hahlyDNpQNFa3gS1HiC5s6mFujkkxunS3MgDy2mIIWAZqqCCSjSpB8k9M2HaQvc9/apiCHn5twzxZ9sv3DIO+ONA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVsPiyYq6GTG3VJThX45FddCAu0MOCvCNLUdWLdwOWI=;
 b=NFhIkx3BKW6Tn0X8MWwRTIPFYGz0uGztjyE0HyijaCnh0ueE8dCvUmaT9QIYvsp1g2yOHUI/aXh+8LITThliM/cjJp6uQTMMZleSGTOhmGL5r3hBKjWraQXiUiuMbuYU+AdnBVuDgO5dmb9vk+y4e4TychMjpG9i6iUncghDYgs=
Received: from MW2PR16CA0012.namprd16.prod.outlook.com (2603:10b6:907::25) by
 SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 12 Apr
 2023 06:15:28 +0000
Received: from CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::43) by MW2PR16CA0012.outlook.office365.com
 (2603:10b6:907::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Wed, 12 Apr 2023 06:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT107.mail.protection.outlook.com (10.13.175.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.30 via Frontend Transport; Wed, 12 Apr 2023 06:15:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 01:15:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 01:15:07 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 12 Apr 2023 01:15:01 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix some issues at userptr buffer validation
 process.
Date: Wed, 12 Apr 2023 01:14:32 -0500
Message-ID: <20230412061432.207610-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT107:EE_|SJ1PR12MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6c8ba4-3db2-422c-f65c-08db3b1d4fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RfajrEbLR9gx1gWR72xHsE/HqEiD6408DW57dPS/WWvWShFzvC4uKdL/T+DVGcsfvgsRMqQrbWQthaD4R/O4ExgeGGn1pq+fnId2gt7ACozv93bOvTFpmmmocWFFKWaktaYuJZsJzL/BgPOnr+az+viiGzeXLRqJZCr7Us8vqumGrhikx8ea2dezP5980VH7JMg8NE8qvUsmDny1hyo31hzmvdSIBBc9SMO3fZ1QyOJmzNjkaiMNjl6qrPkvLyrhP+SqttZnKU5HFm1jJUgW0esgqBc7hy3XQwj6ixMP9xSxmH5XQUVFwhU2MmTv2Es+DkDEQ4vuxu2mGgDeipC75MlG2Fo+/3ZpAQRNNy6rt6oUC3ivlka+34KMg91WCH25pBpD7HTs/VTR5HG8Sykh3O9uljG0ccM//52mvYRe/47W+/EIDZtL+28xZFfM+Ii7r9MuzrPd+6y9SGZSfO4FHTTl/VzjMPcjD5aS0EHdTnik067u4Krml2uFVztvHoZWRM8VCiw7zmfgLFw80cMP1Eu0mg3JSxT5adwgRkgeenPCTiPqDdvHMZVZrEMF1Ttwl+hjMWklsPl9am/ezVFZdGOUufVmYWOPDgaiLGCVcruUeuV4U4xR6PL5UlpVPV943mpM6aTVR8PDexsIOOgWJm81tsN4gGaLmHzE0T/iD1vHjowQhqZULieh9mT1pKOVODRhLmG5vxl0keQ1zD88hEmkZiFP/zusoYK5H44KI4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199021)(36840700001)(46966006)(40470700004)(336012)(40460700003)(54906003)(316002)(70206006)(6916009)(4326008)(41300700001)(86362001)(70586007)(36756003)(426003)(83380400001)(1076003)(2616005)(36860700001)(26005)(6666004)(47076005)(40480700001)(8936002)(2906002)(82310400005)(81166007)(5660300002)(478600001)(8676002)(82740400003)(186003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 06:15:28.1662 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6c8ba4-3db2-422c-f65c-08db3b1d4fdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6051
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
Cc: Xiaogang
 Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

Notice userptr buffer restore process has following issues:

1: amdgpu_ttm_tt_get_user_pages can fail(-EFAULT). If it failed we should not set
it valid(mem->invalid = 0). In this case mem has no associated hmm range or user_pages
associated.

2: mmu notifier can happen concurrently and update mem->range->notifier->invalidate_seq,
but not mem->range->notifier_seq. That causes mem->range->notifier_seq stale
when mem is in process_info->userptr_inval_list and amdgpu_amdkfd_restore_userptr_worker
got interrupted. At next rescheduled next attempt we use stale mem->range->notifier_seq
to compare with mem->range->notifier->invalidate_seq.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 45 +++++++++++++++----
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7b1f5933ebaa..6881f1b0844c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2444,7 +2444,9 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			ret = -EAGAIN;
 			goto unlock_out;
 		}
-		mem->invalid = 0;
+		 /* set mem valid if mem has hmm range associated */
+		if (mem->range)
+			mem->invalid = 0;
 	}
 
 unlock_out:
@@ -2576,16 +2578,28 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
 	list_for_each_entry_safe(mem, tmp_mem,
 				 &process_info->userptr_inval_list,
 				 validate_list.head) {
-		bool valid = amdgpu_ttm_tt_get_user_pages_done(
-				mem->bo->tbo.ttm, mem->range);
+		/* Only check mem with hmm range associated */
+		bool valid;
 
-		mem->range = NULL;
-		if (!valid) {
-			WARN(!mem->invalid, "Invalid BO not marked invalid");
+		if (mem->range) {
+			valid = amdgpu_ttm_tt_get_user_pages_done(
+					mem->bo->tbo.ttm, mem->range);
+
+			mem->range = NULL;
+			if (!valid) {
+				WARN(!mem->invalid, "Invalid BO not marked invalid");
+				ret = -EAGAIN;
+				continue;
+			}
+		} else
+			/* keep mem without hmm range at userptr_inval_list */
+			continue;
+
+		if (mem->invalid) {
+			WARN(1, "Valid BO is marked invalid");
 			ret = -EAGAIN;
 			continue;
 		}
-		WARN(mem->invalid, "Valid BO is marked invalid");
 
 		list_move_tail(&mem->validate_list.head,
 			       &process_info->userptr_valid_list);
@@ -2644,8 +2658,23 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
 	 * reference counting inside KFD will handle this case.
 	 */
 	mutex_lock(&process_info->notifier_lock);
-	if (process_info->evicted_bos != evicted_bos)
+	if (process_info->evicted_bos != evicted_bos) {
+		/* mmu notifier interrupted amdgpu_amdkfd_restore_userptr_worker
+		 * before reschedule next attempt update stale mem->range->notifier_seq
+		 * inside userptr_inval_list
+		 */
+		struct kgd_mem *mem, *tmp_mem;
+
+		list_for_each_entry_safe(mem, tmp_mem,
+				&process_info->userptr_inval_list,
+				validate_list.head) {
+
+			if (mem->range)
+				mem->range->notifier_seq = mem->range->notifier->invalidate_seq;
+		}
+
 		goto unlock_notifier_out;
+	}
 
 	if (confirm_valid_user_pages_locked(process_info)) {
 		WARN(1, "User pages unexpectedly invalid");
-- 
2.25.1

