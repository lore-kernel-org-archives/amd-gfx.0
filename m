Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0657C4829F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55B77112CAA;
	Tue,  6 Feb 2024 15:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mgDpFZrZ";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8227F112717
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipvQAm5DKENlTd/NvV64yc+zURm3QmpB5lVrTB2IjgrlITRtpYjzIQ3vSMMnBIFVvDSnuF4MODRHYusGlhgIjzF5oppOJyBiIBcjnm9M9j8U/oTJVlGmmY8fE0ITdZx4+v+IMEIP0avyumqXLFSD20yygIr+C677498/pH4MPbF7irg/9bRZd6E04SaVQtlwwjabH2VDEyW88qkUoU7YAJMcZx7M1TkHex+WJeDA/QFvmBdpKiYuaw5HKj3LmQgLf6X3aet1cpzRbsNT5OcNR7Q5ZoS6kUG0RAdeSCP/8hTiejwplQO5S9IC0DHO/wCpH/aF2E8Zq2NtPC/uK2h2kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnBPfh4QAI6YLSx2gA6ZV4t52FDioyIJH+/Saw68Tfs=;
 b=gGmpGY1FyNDKHZZTRgrDqA+t7Zy8mGWJo21VRwz+nWzF/F0WBzbBGMinmbi0NIg1X5ebdkwT4pA8oJemA3OrC27q5Ww3wQQdANpAA6MP8NxLJVxLn2a5Uf9s/9NXWaF4QVR0uq9SmmJTH9ZDu9CPQOwYAPTwxYII+D79biPOYTzSz/3AeQUq+n8xBwytZSnHVqIumft/qQaiHzszTnRL0XbOMXTivNr+nPiEHzDleDCJX81ZHkxWaPimWVpjVFwOoBQfxsybPiTp7j8hz2MlxZlwaLK9BqRrlZ/g2axfUNzzf43/689o9r6eHmVODLsAbdKbeM6XG9twWF5CAeXI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnBPfh4QAI6YLSx2gA6ZV4t52FDioyIJH+/Saw68Tfs=;
 b=mgDpFZrZNh48JSitF3Mllz8JhienwxLvdsludgZz28G4L8+V86FEiQ2KDR2M3ndHsdIMoSDE8AM0A0Wpksjx74xQXC0qkOeFAqsq0mAUiNF4mw6xpeImJHvDWVy3ofQVSSJoGbNZv4DXuD350yxW2twWKWFmDbqYF65QYrY9dQg=
Received: from SJ0PR03CA0220.namprd03.prod.outlook.com (2603:10b6:a03:39f::15)
 by CYYPR12MB8871.namprd12.prod.outlook.com (2603:10b6:930:c2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 15:59:44 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d4) by SJ0PR03CA0220.outlook.office365.com
 (2603:10b6:a03:39f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:43 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:40 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 18/24] drm/amdkfd: enable pc sampling stop
Date: Tue, 6 Feb 2024 10:59:14 -0500
Message-ID: <20240206155920.3171418-19-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|CYYPR12MB8871:EE_
X-MS-Office365-Filtering-Correlation-Id: ff50282a-5e83-4b6b-1d02-08dc272ca294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfqEyXNP52VYzg4Ouqn6ZLIIHRBDwTR8AzA9nGt6PJPyLtLMYVBhEX1U1fZsepU/UMHEbCvOrcbJEVe8bhjiqV5vqEwKdZzw6KfwANJLbouzlvOXvtDzEs7ApvIT2VHvx05jyP9Zdl6zdQUtMmWF+QyrjPRlsgFQ6RGRwsix2kFekD4ImMI4rm9bnDfnSmcmZN2csUksfzzzOTt4zAALgL/srC/dai1wxS4Z4S1YjpfTW/x2l2qAO5ogKsX0f9uq/TVMrOZDw5z1k6g+5dEPB/eqgNqFmmYfqf+9cVuDqtI8xeomDTvEZtDCpM+NYtD9fF/w6tYhKaA91u+3zrDcUlOv1RfK9p9dqQakBEy/fz+zgbOz1om4dCGrKWO0TdQCjO9F2YO6zA0EP49M+EX2uHO9rthmywS9YRmbpnBtESK9+U6jUrZxy9dXyyQwebJL5hUywFH8AA7FSy/kULfhIgqtP0vVNlfYzhYjMIZOr0XzhhbpWi9rEGY9C9UX1aWhO5ttwOGEHfYo/fVwzbTi0ja3svpNxzHJcmS1zMG/JZwpTm56DHFzv8Uh4f4sDbHaEd9DOrPVYYTk0ZsFT/ZctCSEuXzmzCd+kLWiFJ2TTWUHuiy7ZuyoKZ/U/GbeMOrpzcSU6CZzththmlkdAA4yWHTvA2zasEbGymxpmBaraSOoInorvuIwMQDKTRIIjE5MUFJ7cvB66+/SGQnvXgQmOo9jpJ7/0KCPHMa00VVpm6O/JyFmW9VkT/CiKvfOPrZxlPG2m9azk6xZm0FMU8AUWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(4326008)(8676002)(8936002)(2906002)(40480700001)(70586007)(70206006)(316002)(6916009)(54906003)(47076005)(36756003)(7696005)(478600001)(2616005)(6666004)(1076003)(356005)(83380400001)(81166007)(82740400003)(426003)(336012)(26005)(41300700001)(86362001)(36860700001)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:43.8177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff50282a-5e83-4b6b-1d02-08dc272ca294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8871
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

Enable pc sampling stop.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 29 ++++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        |  4 +++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index b46caa52fbe8..53e44e68408e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -99,10 +99,33 @@ static int kfd_pc_sample_start(struct kfd_process_device *pdd)
 	return -EINVAL;
 }
 
-static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
+static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
+					struct pc_sampling_entry *pcs_entry)
 {
-	return -EINVAL;
+	bool pc_sampling_stop = false;
+
+	pcs_entry->enabled = false;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	pdd->dev->pcs_data.hosttrap_entry.base.active_count--;
+	if (!pdd->dev->pcs_data.hosttrap_entry.base.active_count) {
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, true);
+		pc_sampling_stop = true;
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+
+	kfd_process_set_trap_pc_sampling_flag(&pdd->qpd,
+		pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method, false);
 
+	if (pc_sampling_stop) {
+
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		pdd->dev->pcs_data.hosttrap_entry.base.target_simd = 0;
+		pdd->dev->pcs_data.hosttrap_entry.base.target_wave_slot = 0;
+		WRITE_ONCE(pdd->dev->pcs_data.hosttrap_entry.base.stop_enable, false);
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+	}
+
+	return 0;
 }
 
 static int kfd_pc_sample_create(struct kfd_process_device *pdd,
@@ -250,7 +273,7 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 		if (!pcs_entry->enabled)
 			return -EALREADY;
 		else
-			return kfd_pc_sample_stop(pdd);
+			return kfd_pc_sample_stop(pdd, pcs_entry);
 	}
 
 	return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 5a7805147da0..7bdcbe6be4fe 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -271,6 +271,10 @@ struct kfd_dev;
 
 struct kfd_dev_pc_sampling_data {
 	uint32_t use_count;         /* Num of PC sampling sessions */
+	uint32_t active_count;      /* Num of active sessions */
+	uint32_t target_simd;       /* target simd for trap */
+	uint32_t target_wave_slot;  /* target wave slot for trap */
+	bool stop_enable;           /* pc sampling stop in process */
 	struct idr pc_sampling_idr;
 	struct kfd_pc_sample_info pc_sample_info;
 };
-- 
2.25.1

