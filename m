Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FF0C54798
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 15:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46257112BAB;
	Tue,  5 Mar 2024 15:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5AhQ1tp4";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B322B112BAB
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 15:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoqB3piWAlMgddwYHYXBjLU73bhYSKRk5bs0NMlRE+04f07/Axc+ZCYqzS65l5R2lfkgkMGgmb33/Od7fXVW7Er8SOhcpO1JycTVAkT/jQafr9ytCJKhkdRi94oJ2ftprYetFgtu86zuhJSHqIPT8Qno8ti7c1OQxpPNdzaU9yktlOBF25yxaMZIjhlkRpYUeEPz07N/nPq9hrg2LRYYXrQtPah0tvn75lAtFskqSMgb5WqYaQpO2lNqOozxrfxmDTt6ihu7T2KMp456x7kxA6e2BniY5R8FfCjxDnJM+lhg6dn8astYrli8nMQ424Q1KFHv/GNkJXVNpZ8LrEi8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8VhYxifEiCQqpjNriJdqXMRM8555OjEn+Lu5RE80X4=;
 b=maYMHek5tN6O5fcNXIV/donaUXpJB1oJW3sYB2UNR+jOJXwvImAoeK01aowMtWvlWOKKTUdFp/6tsFDgtau/uIR8DTF+wZwa+GIz7xEWYJCWjBvHM+R5+0gh4p5c/EJcX1oItrxJfkOU8GfS1lj796RmG2VmExyuNv04MypPl1smTKgkSIkCbAJmToF6F64yZ/ZLqnWxbdCjIPgX5c6XatwDeSwr8mDueBJeS5nzv58INT26rNPzljBfoNenoTTSayiE8EG1abNigabXnou3kC6WfqJ8+dCmNG9dv241vD+LZo91JsthL49CK/xhwin9CQSBGg340Cg/C4RMGO48Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8VhYxifEiCQqpjNriJdqXMRM8555OjEn+Lu5RE80X4=;
 b=5AhQ1tp48bREcJ3ebKNc0bkoX2jcpFeU90cDvGr2uMRAjOVkdrMWMk52tU6ugnOWibD09K4sZz8i+awKSHqmaHPeKX7Puf5n9heKggAUhYX+bzxtmq+MYjB7RMthjW19b5vzND9rvy69L3uaHLofxWemKxhRXsK85KK+SOeRDUQ=
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:25:04 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:337:cafe::dc) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40 via Frontend
 Transport; Tue, 5 Mar 2024 15:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 15:25:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 09:25:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tim Huang <Tim.Huang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amd/pm: wait for completion of the EnableGfxImu
 message
Date: Tue, 5 Mar 2024 10:24:46 -0500
Message-ID: <20240305152446.1268829-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240305152446.1268829-1-alexander.deucher@amd.com>
References: <20240305152446.1268829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da89fd4-8f4a-4a01-d177-08dc3d286ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mS8EsfbzLaGluMiHEnK4IO6qFsfm68LDJfrFG8W0TGZlKVZvw9mvwq8RBzd0hlmqgnu/654tP6VFecb3A/MqwbmUbhIasCxIcu3zFiy8yJtjP2uZdViVm4Ip+kN4qUypyiwb3R621JxjOCwinYJJJem75tnZIo/e1XNhDjqYXfMBEgRzZildnxY6fpP44VUY2o2gGfZ6PAYssnIqMQvasyWUsFvPK2hK+wVZ0nZGhYPNGUegs2MAlswlR2WJLPzQofV6lw2ge1/EPvnJTcPEs2dqj0mK+MT73vjZ4D7IZ37b7KhpBHX6RaTARiRnL9Md1P0xy9pINSUsZQNnSOsQ6wU8RcikLpZS+ggqDbIy/c16V5clp+UKFUWjw0q5GclwBbg6J6Kq8z0eJ27YAMZ1uc7/CfEHascfEDFoU3glYipoCEP8qRqUFK4W7L/uUXx4WjdLhzA+G1I0RhoN7eYDaU0nV764Oyv2qC5+AIERRlhpvktMOOvK0XvljP5M8v6dmp1zMGJNLTxVts9UCSV98x/SIaHO1TyZE7waNWo6yKZvvmK4uPaXpy2BkDu7B4Osths4IIp1j6d+pF+kuOu3WsLRQ7D8O2FoTlyP4qLnkH+9UYYIEQHKWeGtzRKQLmRjRb7P6Vx0CvSSlHMF3mDPDKPiBjq1qcvPqVbgNSA7HkuVstDOvtkga8T44MRRTZvs3Av3RjFJTu1mP0XVtkpk4Ov9ZJj+g8sJDQ+sf8n66YsOBacEilGYchQudFVQA4Ii
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:25:04.7371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da89fd4-8f4a-4a01-d177-08dc3d286ee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381
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

From: Tim Huang <Tim.Huang@amd.com>

Wait for completion of sending the EnableGfxImu message
when using the PSP FW loading for SMU ip v14.0.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index a65c618c2f98e..b06a3cc433054 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -53,6 +53,8 @@
 
 MODULE_FIRMWARE("amdgpu/smu_14_0_2.bin");
 
+#define ENABLE_IMU_ARG_GFXOFF_ENABLE		1
+
 int smu_v14_0_init_microcode(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
@@ -1633,11 +1635,16 @@ int smu_v14_0_baco_exit(struct smu_context *smu)
 int smu_v14_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
 	uint16_t index;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
+						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
+	}
 
 	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
 					       SMU_MSG_EnableGfxImu);
-	/* Param 1 to tell PMFW to enable GFXOFF feature */
-	return smu_cmn_send_msg_without_waiting(smu, index, 1);
+	return smu_cmn_send_msg_without_waiting(smu, index, ENABLE_IMU_ARG_GFXOFF_ENABLE);
 }
 
 int smu_v14_0_set_default_dpm_tables(struct smu_context *smu)
-- 
2.44.0

