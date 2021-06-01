Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C4C47080
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58263613AD
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 22:59:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58263613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E01A6E952;
	Tue,  1 Jun 2021 22:59:28 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2078.outbound.protection.outlook.com [40.107.95.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB21889CA2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 22:59:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xm2Xv04i8V3J/3BM+kykSe7RdkF6Ps8LIbrYccdHxSeSow4qXUzJ8y9a/2TB/6HjpONlxatAPdF8npYjziQNjylf9glxY0h7r6jErk/xS+BxnVPJqq7S7Uf5RNQoUfZkaksNFdUZrzDkEo4yL8J5GPjka4mjCSGgIYej69RgnhrhhgNrQL9/w4gQlABHyq3sx8z6I3NF/raf88Rs7zaIPmjR0OYbTsjmmJLKSnWTjNRHeKksbdjsHyvQpmAC+ScHHEe9MCkXVidJCaTIONlQWh+wYxsh3UT/kIv3w4192B0TF6J6ZiPnVuwLeBY7pxalqwZBnFYpQQf8kV0qDAueDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB0KTORcu0pYpTsGth9FazwLTjHkYBxCFyWDU5vP9i0=;
 b=l6xejLgtQXLV3XL9FmMyBAADTip24F5UAn8swXB/XZua95k/y/2SpQG+EfcWpDWQZy89J771GHk99hiIKgdjRppeN5y+EN78wjPuoiI5Td0TT2LvGRxS4MwPTSp4NeyKjZ0uSbjHT9twpNKgQnlza6Or8RNbGnVQSkAX0WgeC9Ml0Hq17IWsfB82lz6LmUO4owvVNOuwda9Wu01Nif33N3oclEkfKgbcDs09oxF5OA29ynZmkcuY7KGGt6pgHPmgno4AJiRl9G7fgEh0tCEHP95fuo9MPvi+wQVi0EgriU+KAks7fQCFRT49hLRPWovbdDwSQnqo9LbbvRyrK2akqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dB0KTORcu0pYpTsGth9FazwLTjHkYBxCFyWDU5vP9i0=;
 b=Wo1nuesJkUiwl/eGg3xhkR5lI8MgQhp6LlaQoe1Q1N+/DvImBifqFkE8T/r/HZzI3FINjlfv1piYf5jGG6nTlK4HmNNtZQ61ymd2Xp1qnAPpQJ9E/s7CS7k9lFwc6VYUjkvlN1wC6RWgPRxN2oL0xtiZrPEKR9tbk2LRM77CN4I=
Received: from BN6PR19CA0096.namprd19.prod.outlook.com (2603:10b6:404:133::34)
 by BL0PR12MB2577.namprd12.prod.outlook.com (2603:10b6:207:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.26; Tue, 1 Jun
 2021 22:59:23 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::6a) by BN6PR19CA0096.outlook.office365.com
 (2603:10b6:404:133::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 22:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 22:59:23 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 1 Jun 2021 17:59:22 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdkfd: Add flush-type parameter to kfd_flush_tlb
Date: Tue, 1 Jun 2021 18:59:04 -0400
Message-ID: <20210601225907.749049-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeaa5d90-e5e4-40ce-e452-08d92550e5ae
X-MS-TrafficTypeDiagnostic: BL0PR12MB2577:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2577C17E74FF31129856DA60823E9@BL0PR12MB2577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UAIrX71qVXcM66LEbR5Ue5lLJBGWX8QpWFb/sx8mNslXIul2lJLUm4WRa0yu8bveSu/4cCACqbQX1ZLA9IV9Rxkd/GhwEonQX2wkFwnBA2ISWjeB6uN3k/LtUi4wIIipmUmwSyqH1YtraE8o2eMBU9bdZdfhgS+TX+cu440VuXUAOl/DlIelBJ8K0uP/ahLNuXdKjnAIodflkwvIQgXGXH4O6RdrQ1gqsGCjDYKureAJOYBnXrwI2Hhj79Ebu+hj5i6gRtHSypkCXJ8LMCSRkjcamGrOOk3WpG4LVn7H4tp2zx0BnMCsqxhg0xDX8eEqKzk5en9unD3BbALUyW6Cu7rJ3d8SC9Di9bcsqnejxRKeECGPmE5pz9Y1dK6zH+3PjDxzY0VK30+HLizfRIf41d+X5RWgDaCmT31bc42EzdCjzOsk3o6GtADDgw0CPZuO6/yuoo/ZpnzZtFQumuv+Q7EhorK9cdmY8HtLSqRm4Hkz3mK0yNpZ6ftufYhkhcXe853ArFRobqs/sY8IIV03yGg1otlI+3GI9Kbit0hPFGQJeX1Y0ZdxyKQzg81XueLoSxA9jUbfJKYzqkrJX6y0nShIwtbWSpHZNtCCyJi26U+GX14nhm9TA+3iw/B3z24LsNAfgtk3aAuSWrkKAtt+So8GKlRsoZz0O/wyClR9iyKaGfqaP9RXG6hv26YTjaV4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(86362001)(82740400003)(186003)(16526019)(356005)(2616005)(81166007)(26005)(36756003)(2906002)(5660300002)(336012)(7696005)(47076005)(70586007)(70206006)(478600001)(82310400003)(36860700001)(8676002)(6666004)(8936002)(4326008)(426003)(83380400001)(6916009)(316002)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 22:59:23.0251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaa5d90-e5e4-40ce-e452-08d92550e5ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2577
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to provide more tlb flush types opotion for different
case scenario.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c              | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                 | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c              | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 960913a35ee4..4da8aff3df27 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1666,7 +1666,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
 		if (!amdgpu_read_lock(peer->ddev, true)) {
-			kfd_flush_tlb(peer_pdd);
+			kfd_flush_tlb(peer_pdd, TLB_FLUSH_LEGACY);
 			amdgpu_read_unlock(peer->ddev);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 2bd621eee4e0..904b8178c1d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -278,7 +278,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd->vmid,
 			qpd->page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
 		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
@@ -314,7 +314,7 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			pr_err("Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	kfd_flush_tlb(qpd_to_pdd(qpd), TLB_FLUSH_LEGACY);
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
@@ -885,7 +885,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm->dev->kgd,
 				qpd->vmid,
 				qpd->page_table_base);
-		kfd_flush_tlb(pdd);
+		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index ecdd5e782b81..edce3ecf207d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1338,7 +1338,7 @@ void kfd_signal_reset_event(struct kfd_dev *dev);
 
 void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid);
 
-void kfd_flush_tlb(struct kfd_process_device *pdd);
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type);
 
 int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 3995002c582b..72741f6579d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2159,7 +2159,7 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
 }
 
-void kfd_flush_tlb(struct kfd_process_device *pdd)
+void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 {
 	struct kfd_dev *dev = pdd->dev;
 
@@ -2172,7 +2172,7 @@ void kfd_flush_tlb(struct kfd_process_device *pdd)
 							pdd->qpd.vmid);
 	} else {
 		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
-					pdd->process->pasid, TLB_FLUSH_LEGACY);
+					pdd->process->pasid, type);
 	}
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
