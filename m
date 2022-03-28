Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFBDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 21:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C312410EAEE;
	Mon, 28 Mar 2022 21:20:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 898EC10EAEE
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 21:20:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYbpqkeV7+jkQehU3bpjWAVEnoE1TmC5uCNJTKINxq+sv4YjXCcVK1VWKmTwY67fyRUuyBh4r8JyA3TwcQHXVAYoGY9QQz5Rah4PB7N3Wgfb2OqLhclPtSyWW81XPni3SDENlk2w9qOAta8i7U8YGoanV7EPiQYw5d87sJphoJqZDkBmUkqopYXmzL8fw6NwVxDJzPvDv/l46llULgUiyc+NjEnf7+O0T2iRSI3nNr0XaNreZFcfqAcYoETnEq1lu+ImTFyqFDD5iBKmsFIhOhFasCPPjwPU8vWUjFftgH/fUN9P+LhCy6Wkd01ls4Lz7gf87wfFjhpYNSCiu1Eo9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJBKtl3gxa+UbU3EMVdyKrmxC/JNsN9ENNmMM3NlHuI=;
 b=e3kahGYEJqvzRTm8pLrA1MDcIcV9BAlwFfPv1HVwI5dEbt/w97fBtjhF0kc3Acey82veFy7JYgeZgNnx15N9d8syWYFO125DVIA7zsAr4vfTmYO0NawjqzLpOtZ9S7Qkx7Kv+XFXWMryTr1oxsSqBl3rlF7qjb/9JOXd9O5h1V30ui/wvH6VeBnayoQCalwxZmNzGfseQ4zLhikKSrLp3kdyTB8GgYFiZmSG8mK+wtGTydxCWJax7tcrsWIWlpaM90JGHkdwl3ybJdAOyFiIFAWH+M18Pz9+As3FAvlYvayk2hUVBDRz71skyQjydHqzRgHlVtgTTLTquxe92dK3iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJBKtl3gxa+UbU3EMVdyKrmxC/JNsN9ENNmMM3NlHuI=;
 b=ZHZ/ON/SyHSNQKthw5zsO+wR4KeAf3o1zoPmQRUGnzvrm9Qfw9RnknnIP6gAJIN4609Fg+lMMUtaBfN1DyZ4j7P4mbhyJi0ZddJ6BkbYS29GM4ZFjtC6T8bQ8MwzLgRbFQZOLBbsEA+O0/9LBMiEV0vlSpTzZ1XPkkktWYd/DR0=
Received: from MW3PR06CA0004.namprd06.prod.outlook.com (2603:10b6:303:2a::9)
 by BN6PR12MB1153.namprd12.prod.outlook.com (2603:10b6:404:19::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Mon, 28 Mar
 2022 21:20:39 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::68) by MW3PR06CA0004.outlook.office365.com
 (2603:10b6:303:2a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 21:20:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 21:20:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 16:20:38 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/1] drm/amdkfd: Use atomic64_t type for pdd->tlb_seq
Date: Mon, 28 Mar 2022 17:19:52 -0400
Message-ID: <20220328211952.21889-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 343f0f5f-24e4-4a2f-5945-08da1100ce9b
X-MS-TrafficTypeDiagnostic: BN6PR12MB1153:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1153456F5285107103FF00BFE61D9@BN6PR12MB1153.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42TCcBZQ5SRZ8A4Ftz34r3uC7iNBPC/xanTOPERI1UBEAR4dtzX32Yd7r53AyxWNwK6HXOu6HEYfz2iwfCgcc4T5VrL5Xl8bYMxjVtCGdbDc4g/9/qj7VvBFrDVdyffFQQA5UmsOtN737N4mY/3hkA+kGi/aRbO2S+Yc3U7a+HI1rWKGVrOYo0T49q+sTfLGKrUn+uIl2ba/8HsqFu5ijaV+fPBurv8IOb90vUKEyq9+QSxvN3e9/3YT+qMCqrJ13ABX8RBVTg8hS7Hw9ldHQxjIcMOGko/kTyK4MUBYSwXXe7mJ79MISq9LbNoUo/d2LHvjdTzNm4hKzSKlClLYJqhoL+pCQicATuL0cUuAWnbs1decFKJnEYrWGZAgfEshvnYDP7e2mNwXwqEd6bbtrpM3Ul6ViQC1VlH7NrMZ7iznDpzXUykbLkEutpIvI0SoHib8iGhhzUEaUf9G9BxriDIpAsqnxvs64PyBCyIl3hA/vNs0gKOkYSW74T6LJCQiSzCLTvTleuVLL0qxAY3ad6mjhgFu+Kfc6uBfZvuUsDXX9pPm21WtsRA4ZZ7dXu3yGdNlDtlDpyQsGUvMunydWnRIr+3UN8yYx8nkBRMezM6A7NuRtDAs61HNes1tSm+bJ6C9GpcbpDrWMoPWqSiBuxxljzcGzjxTFUXI/gsmQmRAKhebPZxSlxL4os+qVvXm7XEHPTk9UkqPPMilTivu1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6666004)(336012)(426003)(82310400004)(7696005)(81166007)(26005)(356005)(1076003)(2616005)(86362001)(16526019)(186003)(47076005)(36860700001)(83380400001)(8936002)(4326008)(8676002)(70206006)(36756003)(2906002)(508600001)(316002)(40460700003)(5660300002)(54906003)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 21:20:38.8431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 343f0f5f-24e4-4a2f-5945-08da1100ce9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1153
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
Reply-To: 20220328130700.29642-3-Philip.Yang@amd.com
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To support multi-thread update page table.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 945982a5d688..e1b7e6afa920 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -705,7 +705,7 @@ struct kfd_process_device {
 	/* VM context for GPUVM allocations */
 	struct file *drm_file;
 	void *drm_priv;
-	uint64_t tlb_seq;
+	atomic64_t tlb_seq;
 
 	/* GPUVM allocations storage */
 	struct idr alloc_idr;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ac8123c1ee8f..267ba8c434c0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1560,7 +1560,7 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 		return ret;
 	}
 	pdd->drm_priv = drm_file->private_data;
-	pdd->tlb_seq = 0;
+	atomic64_set(&pdd->tlb_seq, 0);
 
 	ret = kfd_process_device_reserve_ib_mem(pdd);
 	if (ret)
@@ -1954,10 +1954,9 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 	uint64_t tlb_seq = amdgpu_vm_tlb_seq(vm);
 	struct kfd_dev *dev = pdd->dev;
 
-	if (pdd->tlb_seq == tlb_seq)
+	if (atomic64_xchg(&pdd->tlb_seq, tlb_seq) == tlb_seq)
 		return;
 
-	pdd->tlb_seq = tlb_seq;
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		/* Nothing to flush until a VMID is assigned, which
 		 * only happens when the first queue is created.
-- 
2.35.1

