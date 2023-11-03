Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32B7C001DB
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4414510E9DC;
	Fri,  3 Nov 2023 13:12:20 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB35F10E9C9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFTpErW8HUQ9qUmhcju3Amnr0qHWalOBcPbv+2WAHbXJpKrA6sB4FgK3ttpw1HIvx8lX4Ms/RlvWKRyAA2/30oJy7yKwUCrGHgHZAmryJF3lqoxVvIv60zrITo42BssdRKsugm1ecqF2UPhLesL20Uq7dQ9xbU0XsomHtC/x9XBZmArWvcvJefT1vCw4Au9jWhcX+oEUE6998jjfcJmdQ2Ar8b6Fm6HZ/6D7AY16pTBGBaDY+w3zNmxzRkX+2hQsHJIQQJ6Rv/Caw1RQw6WwNwwuOnfD6zshjTZha+jB7Rq3NWJF/y3L7HUU7Pj7nZSxtr4OWSZuavYN5rZpOX7wUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeB/3YsS7fUhM0tsgZ9u4ljurn0IcEnZj3bVLbMR0rE=;
 b=g3gMSM10Z9bvb8HqCZDRn5H5dsQNaVzYkSTvX6VymwG+8xiJp7hnZnAv7wKSdFmTFoWNPi3GlBpbnZjlSwFRF7e3AmYVXwp4Wx7cs7onZMOxMTYLZFcOu9RdaOqkT6/jIRjZjAgUWyirmzmMK5aCPTKkqJV7VHxzflEI4DhzTbyu8mtPdQOsFogQ24/KqyosYnGXfIyRfMY3pm48uCL/syeQxS31S7WeZ/IyFIGImoRMxAhmZllAUo4k2DznsDo+FNPWwjtYDCYmFbYN9VFrEwIPVfUuR0sOIWvJLLJlda7PuZ8cDlrgstyDY5VqoH22sMvqEaTrDSMgejYkknOd6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeB/3YsS7fUhM0tsgZ9u4ljurn0IcEnZj3bVLbMR0rE=;
 b=wOtG40Vb7tAXDw948uyo++ZQP7dfXFVexCR1N20FbFIOqPRpCsSRMadHWkuTpB/9/PMZfgj7k3r3qa5riIWMgV6sJpxPz5P/U6ViFJri4zx5kUCQt6uFqnmDPdSsibaAqSyu2S3AMWj8qlnYnQE9jBTqTMIw12uADV5w0pAqyDQ=
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by PH7PR12MB7966.namprd12.prod.outlook.com (2603:10b6:510:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:10 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::5c) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:10 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:08 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/24] drm/amdkfd: enable pc sampling work to trigger trap
Date: Fri, 3 Nov 2023 09:11:35 -0400
Message-ID: <20231103131139.766920-21-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|PH7PR12MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: f9aa1f55-bc70-4645-ca0b-08dbdc6e7cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afn7RKQ9iT9wIHgn9ZpbrkErFv4Z9Pmde2/QyIUecgm0htcGSwMLSch6wcedWCGoOaCjBAGyaDXPu+pTjl+JehxkjKPiGAY5Vprliwjutj/ugXYGVEj60gkhL/STgiv/PAa6JIc/gVugwqaPiN1Cdqp4TUlEXGhSBi84AtB4D9b4FVqbXM0wOvaJwMWtcd0E5vOCjm3/6zE8MxKmvuMdTcciJF/XtgGKI3nFRTbCn6y0h0e20x7CkjTNR57VAkQ4Lc3VY90147WYws6PAZvn/Er+83wTa6Ep7fjbMLSsl4IBoNxjJvzNwZPwYzm2FP7Ud98HZMwFYlOuOu/Vqw+gq6Dqx35jNFrWaDv/hCfnH3Z2a9FRoRbfSYfkR+ssKDgXBH8hmfPhA8XLlbrLy6oBD0rgkPr2qoqGCDpHTgLf05iP9qQWIIxHzM2nLfiwpZ0j+U2wnruL/3ZnhT9Xib+FHYfArFvHtjvqENh2pptFvI4UKmoINcb3+czRD39Re5ynTZcts/0xIyKCMYQsMEEgAhopC2vtzXWgrPfFDno0m4DoLZH8ExYA3C37oQdawLhwGhaIx/7ZASD9z6XoNRXJ4ckTf3EQEEReO8YdtqMZilI2UKm2x2+MisevY8p8TQjXE7oWHN3YFgF5OOenRzTbndfUUtIRn43jIV8jT/BGesdjb5cO1GJEjVT1+KDdY1jtgrL/6Rl38aMuF3hsmUQblUgT9YC0zihpGrMvMUO8YeNnVRGW24+l0UjVM6LrCWEDbM1YvGgvuVd4ttsOhuwIpQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(82310400011)(1800799009)(186009)(451199024)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(36860700001)(47076005)(356005)(41300700001)(81166007)(16526019)(336012)(426003)(6916009)(316002)(70586007)(70206006)(54906003)(82740400003)(7696005)(478600001)(6666004)(4326008)(8936002)(8676002)(26005)(86362001)(2906002)(36756003)(5660300002)(40480700001)(40460700003)(2616005)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:10.0453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9aa1f55-bc70-4645-ca0b-08dbdc6e7cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7966
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

Enable a delay work to trigger pc sampling trap.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c      |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 39 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  1 +
 4 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index bcaeedac8fe0..fb21902e433a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -35,6 +35,7 @@
 #include "kfd_migrate.h"
 #include "amdgpu.h"
 #include "amdgpu_xcp.h"
+#include "kfd_pc_sampling.h"
 
 #define MQD_SIZE_ALIGNED 768
 
@@ -537,6 +538,8 @@ static void kfd_pc_sampling_init(struct kfd_node *dev)
 {
 	mutex_init(&dev->pcs_data.mutex);
 	idr_init_base(&dev->pcs_data.hosttrap_entry.base.pc_sampling_idr, 1);
+	INIT_WORK(&dev->pcs_data.hosttrap_entry.base.pc_sampling_work,
+		kfd_pc_sample_handler);
 }
 
 static void kfd_pc_sampling_exit(struct kfd_node *dev)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 2c4ac5b4cc4b..e8f0559b618e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -38,6 +38,43 @@ struct supported_pc_sample_info supported_formats[] = {
 	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
 };
 
+void kfd_pc_sample_handler(struct work_struct *work)
+{
+	struct amdgpu_device *adev;
+	struct kfd_node *node;
+	uint32_t timeout = 0;
+
+	node = container_of(work, struct kfd_node,
+					pcs_data.hosttrap_entry.base.pc_sampling_work);
+
+	mutex_lock(&node->pcs_data.mutex);
+	if (node->pcs_data.hosttrap_entry.base.active_count &&
+		node->pcs_data.hosttrap_entry.base.pc_sample_info.value &&
+		node->kfd2kgd->trigger_pc_sample_trap) {
+		switch (node->pcs_data.hosttrap_entry.base.pc_sample_info.type) {
+		case KFD_IOCTL_PCS_TYPE_TIME_US:
+			timeout = (uint32_t)node->pcs_data.hosttrap_entry.base.pc_sample_info.value;
+			break;
+		default:
+			pr_debug("PC Sampling type %d not supported.",
+					node->pcs_data.hosttrap_entry.base.pc_sample_info.type);
+		}
+	}
+	mutex_unlock(&node->pcs_data.mutex);
+	if (!timeout)
+		return;
+
+	adev = node->adev;
+	while (!READ_ONCE(node->pcs_data.hosttrap_entry.base.stop_enable)) {
+		node->kfd2kgd->trigger_pc_sample_trap(adev, node->vm_info.last_vmid_kfd,
+				&node->pcs_data.hosttrap_entry.base.target_simd,
+				&node->pcs_data.hosttrap_entry.base.target_wave_slot,
+				node->pcs_data.hosttrap_entry.base.pc_sample_info.method);
+		pr_debug_ratelimited("triggered a host trap.");
+		usleep_range(timeout, timeout + 10);
+	}
+}
+
 static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
@@ -101,6 +138,7 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd,
 		} else {
 			kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
 				pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, true);
+			schedule_work(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
 			break;
 		}
 	}
@@ -123,6 +161,7 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 
 	if (pc_sampling_stop) {
+		cancel_work_sync(&pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_work);
 		kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
 			pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index 4eeded4ea5b6..cb93909e6bd3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -30,5 +30,6 @@
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
+void kfd_pc_sample_handler(struct work_struct *work);
 
 #endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index badaa4d68cc4..b7062033fda4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -263,6 +263,7 @@ struct kfd_dev_pc_sampling_data {
 	uint32_t target_wave_slot;  /* target wave slot for trap */
 	bool stop_enable;           /* pc sampling stop in process */
 	struct idr pc_sampling_idr;
+	struct work_struct pc_sampling_work;
 	struct kfd_pc_sample_info pc_sample_info;
 };
 
-- 
2.25.1

