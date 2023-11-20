Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00152C197A0
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Nov 2023 16:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86A6410E05B;
	Mon, 20 Nov 2023 16:23:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6148410E05B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Nov 2023 16:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzMd4us1lnK5cDNVwY/r9Z70aewEghrFvL8HFTh6QOHQ7/nyfXOspecysspAAR5WoVWMMurTjizhAlHHskpm8W9T4K1/Su1+hkFzeb5/5gNq26VJ5q2qjHgMZUYJe5/6W8hQB0Mijg5ajr5hgMIKc/N0uX6dsKuXKJW0KJ3Ig4X0Uf2mIThGxzsfsgmdt4SQ1SAGkogdsNPImRmzcMSbplSmKCE0IWdtfVl/FwMWG6ceEWxXPnd+atocBLjNXU7wyJVM0v7/dE57knZMSWV+Py3QZwzh65M5/pI3jzZyFEXulacz/YSbVIxiQ8M9ys0F3rpIxE7RqHquEyhGa54t1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhP3Mn+sPTQdyT73+5Jzu5ppAVjcyRYlmW/yDMtj2cw=;
 b=KPd+LRKeuWY3NiOo5jcAAJaQ1OxZb+sbszEDvhnQVOI2bJLx9bPEsOqGGYXKLcbdjX8Bs7QqaANFIfsqkCTHHe1QKMS/qNFS08s3IySCIqEzvIM24JkgbobYpLKh25nBJSG9HuwthsGh/LNszriwCGoO4zZZSRf7U/kgplHdwCPhUys8ngJnLBIDhOBYPuseyS/XpAmUxrc5F6kIZ5OWtitEldIKGlVt0/CJ8a9q5x+3QwczlTPCMLvvkGZ3U2hWmIt30IETD4d5/wcTx2p6rFGBKHmWo9FX+OiE2ZKBEh/t0giCswiFM1jg0OcvmllNUYlMfD2A/4d4O/XnRKAh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhP3Mn+sPTQdyT73+5Jzu5ppAVjcyRYlmW/yDMtj2cw=;
 b=rOmNFUEJumIh94+nFQEGFlEKTlSN0N/88yCjKawC+F69o+zz7552gXaKBg36sh5A7/vZnmMH0qfquTm5Rt0Z2F+Wlv5ox388x193B9NhqNEE6wd1ij5PEmA/eFKdXj7IGsPlNrEeLQOIAzp7D33xyunjg0hfZZmdtWnO1HOYl/c=
Received: from BL1PR13CA0396.namprd13.prod.outlook.com (2603:10b6:208:2c2::11)
 by IA1PR12MB6162.namprd12.prod.outlook.com (2603:10b6:208:3ea::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 16:23:33 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::a5) by BL1PR13CA0396.outlook.office365.com
 (2603:10b6:208:2c2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Mon, 20 Nov 2023 16:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 16:23:32 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 20 Nov
 2023 10:23:32 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 22/24] drm/amdkfd: add pc sampling release when process
 release
Date: Mon, 20 Nov 2023 11:23:20 -0500
Message-ID: <20231120162320.2545060-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-23-James.Zhu@amd.com>
References: <20231103131139.766920-23-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA1PR12MB6162:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8b6c66-4e67-48ee-b61b-08dbe9e50a21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KEJCkLhjyeJdCj50GgXa8wR12aqQhjzLL9auu38mngE0eYT/SMEj6V2L/NAmLqv80/yWwEq96b0qpAN6Wfmb1kBaotYiTiCNxCNHSAlNhInvUygSbEGj+0++T4TTFuqNgOv6L2jhLRRVE8R8ov+d6BJqsJcwOCNQNWu/SuRl6VxJuHr8D0LgKNFa2jt6rDrXe9AK/zzcuvxkbeQpodAGZSBZOYgPA2GrN7nbGMKPrfwJ/m5sbspt79oB1FdVpzermYXgpvjj0dgBenhRZUi+JWdfSRQ/WuQiXOf9hVot5T99o8qMUtJlT2NwP55VF28GWdgOnyuvXYk6r5Y7cKp8IVxkJ8YszUZJYjYE29GY5lix1utatCaE0Z4XwsTGs6ws2OLnvDtRRPIuPajv6WMHo/DCaaTGWbfeTjBc0Y0G8fkKJ9Ve5aJFESeFw+DFP+4+me9qe2LlGPnwafRmpPKMIFZYjo9O5X2/qP0ioGvtzRnnSRByHWix+mgMvg9ucf7CPNVg892Hrx2tkuucLMyjorSDgERFodpgg2eUNjbcDJDQuwKT7NWEKARNjQA/cFVZiojt605YYkxw4BrouyClKXLfUpmDEKSA8hqHSFIsyT9xYaRVSIwvfBbNQh05KS0t8oK12Aa9lBJVe0/ArjAlfUIYKx8fmPlWeYEYZRLLPZmyBe2R1Qc4HuhsyRr4WbOkfKBLdv1iQzngIb11UTOGeVEFAciGx1aiKW3EYcs9CzmJ14IwBFjpj+KOPJTsedSt/yxBNGkim42YtJ1u+2581w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(41300700001)(36756003)(40460700003)(2906002)(86362001)(5660300002)(81166007)(47076005)(7696005)(40480700001)(356005)(2616005)(26005)(1076003)(478600001)(83380400001)(336012)(426003)(16526019)(82740400003)(8936002)(8676002)(4326008)(6666004)(316002)(6916009)(70206006)(54906003)(70586007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 16:23:32.9352 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8b6c66-4e67-48ee-b61b-08dbe9e50a21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6162
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add pc sampling release when process release, it will force to
stop all activate sessions with this process.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 21 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 66670cdb813a..748c548f7e7a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -274,6 +274,27 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 	return 0;
 }
 
+void kfd_pc_sample_release(struct kfd_process_device *pdd)
+{
+	struct pc_sampling_entry *pcs_entry;
+	struct idr *idp;
+	uint32_t id;
+
+	/* force to release all PC sampling task for this process */
+	idp = &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	idr_for_each_entry(idp, pcs_entry, id) {
+		if (pcs_entry->pdd != pdd)
+			continue;
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		if (pcs_entry->enabled)
+			kfd_pc_sample_stop(pdd, pcs_entry);
+		kfd_pc_sample_destroy(pdd, id, pcs_entry);
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+}
+
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index cb93909e6bd3..4ea064fdaa98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -30,6 +30,7 @@
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
+void kfd_pc_sample_release(struct kfd_process_device *pdd);
 void kfd_pc_sample_handler(struct work_struct *work);
 
 #endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d22d804f180d..54f3db7eaae2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_svm.h"
 #include "kfd_smi_events.h"
 #include "kfd_debug.h"
+#include "kfd_pc_sampling.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1020,6 +1021,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
 
+		kfd_pc_sample_release(pdd);
+
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-- 
2.25.1

