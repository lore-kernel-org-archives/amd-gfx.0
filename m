Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4742C7EE23
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E73610E437;
	Tue,  9 May 2023 22:21:51 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61EE110E42E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:21:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrIHxyIY6ec3EHbHqH19BN6PiGKbgB3yLASUHtil8KaH4q+gm3iX2Y8ndjv3LRpZVsOP/MqydwGoc4UKf+YmhFkjUrqxJ0P++ps14gNIaIwur6rixU5nQmjAbSFhjIanaTMqW/zmS+bDMQZVrTLYypbabzMCkNTpgKGzx5a40IgTuHqKJ7TVOmuXQKZRQlLrIjFqL33Eh4xDq9IyL9dY0l0h7dJ34aJP8x5UtLml3ow4vzskZwP+5O9wVeNpX2N2Gs1BXpe3SXPYdrbgDUWbk9I5lwZi61iP18aJkxkNoSs89jIZnIwhDqCKwfiTrKeI17tI1KJrgKLBU+9NjK5t3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irYJzEC4gmqMrlPSkOhdqhueLDF0PdyCrScBsUIJRio=;
 b=kNT1mNMgmeL3rsgNbOx5JN+ukDiIlvNDUkVYFH95Frjx5VZDy7rabb5hjT8vzolu/9bKxzV7NukE2nMzEsGL+zZFklAEWU16QTH+Gx2wu9q3YqJpQrkf2WvrkKQnuwu2uBbZdtNJO2E1n9s6mU/WxrL0IWfyPUNU9DeNePaVC/7B7WHbzsiEUa4LeiRrUTbIbfKZ276+kvXNthAc+6Y6cY3prBPEPtvsCzwdGQsHwMFWadteo6keroCqqmHlXegTUgxhwhltC/cUEaGk1LOAxdJSA24OhhJb7YYCdIv1G1A+GP7msL6hWw5Gc09EUg8UApzgu0S22QH0gE47tTf53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irYJzEC4gmqMrlPSkOhdqhueLDF0PdyCrScBsUIJRio=;
 b=PSyIIx6dpLFHyu5a7FI5cwt/f5tAEhzqZ1Z39UzfRoESH9bE261bQwMmD7Lgb+fugSV27vjRf6inhDyArj5atfr23jyqsBzAP7tpfl48gSDxiVDn9pJHsy/B8Ud7sFgIAOV185Lxgo8wIXxeRDwMeicKVUDFJabM+T1TC5x+amo=
Received: from BN8PR15CA0026.namprd15.prod.outlook.com (2603:10b6:408:c0::39)
 by IA1PR12MB8520.namprd12.prod.outlook.com (2603:10b6:208:44d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:21:43 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::70) by BN8PR15CA0026.outlook.office365.com
 (2603:10b6:408:c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Tue, 9 May 2023 22:21:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:21:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:21:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/9] drm/amdgpu: Add query_ras_error_count for jpeg v4_0_3
Date: Tue, 9 May 2023 18:21:23 -0400
Message-ID: <20230509222126.477847-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509222126.477847-1-alexander.deucher@amd.com>
References: <20230509222126.477847-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|IA1PR12MB8520:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e95df74-890b-4fa2-6e13-08db50dbc4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QAHMSmPvvdd8sQ57O+6zYzw1Z9J5zqgm/1DSz9GlXk87Nx1pVj4zhZyjrL+S/rJszS5WHXCuBwpOm3HfMZmkVU58wZKi+Lja7InBYYrR+lov/lg1Tpo/tHh51JgLRMYPl25JrKN7Il6ypsI4yVWn9gjUtRMzXUaWxWYdrgdW10GEQWaoNyVyuNUnuz5W9Iqo6M8KjLqga+PsKH+Ftc8z4F2P8K/VgxQWHoOQ1ZLOBdC03/8II/fbbsVmyNcl0R+h4WgA2NUGCOKCz9bPRPRtduqFKw5QGCxI3SgezeS3258VMcyU3UnYTowAI9P78CaFbcK52P+BbZyfYUUzWJvvx7UC/hF6iF8v/PTK1FiU9p4Uu4eg+KqwrRHKbfVwpLZK1vr5JAHkr2x1wCBC47wvB+ltZZ64b7SGg9v0v1xv/C+f/eAFnfxRvgynhW817+yLp5IMalE9qZtrRr73+4tByzOQq2atlAeqXb+k6EoFmK4zDsFvTU+r78rX9OKhDWrZASWroUkkri4Bu8WQB6NCcl9NW+WgI7fHTWjdeF0h3T11kli9OZHlYu1bh+59LaiuUuiPvaW1j+R5mNyeAHbA7QwLceJYTEefLieIw+J0rNdWCc30w0FyIBslsCK7xpDvCTVITUZTjErGZgjA39ccmT9DrwHT/3RmpsRJ1QgvIMCZQOOYqGp6hHN+nqxr0ge32TiXZ7SUBd0ZlG92M1SdUweB/kRXgVedZOsY1NkPl0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(86362001)(36756003)(6666004)(316002)(54906003)(4326008)(6916009)(478600001)(70586007)(7696005)(70206006)(82310400005)(5660300002)(8676002)(40480700001)(8936002)(41300700001)(2906002)(82740400003)(81166007)(356005)(16526019)(186003)(1076003)(26005)(36860700001)(83380400001)(336012)(47076005)(426003)(2616005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:21:43.0741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e95df74-890b-4fa2-6e13-08db50dbc4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8520
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add query_ras_error_count callback for jpeg v4_0_3.
It will be used to query and log jpeg error count.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 64 ++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ea9cb098a144..5dedba91fa32 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -960,3 +960,67 @@ const struct amdgpu_ip_block_version jpeg_v4_0_3_ip_block = {
 	.rev = 3,
 	.funcs = &jpeg_v4_0_3_ip_funcs,
 };
+
+static const struct amdgpu_ras_err_status_reg_entry jpeg_v4_0_3_ue_reg_list[] = {
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG0S, regVCN_UE_ERR_STATUS_HI_JPEG0S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG0S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG0D, regVCN_UE_ERR_STATUS_HI_JPEG0D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG0D"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG1S, regVCN_UE_ERR_STATUS_HI_JPEG1S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG1S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG1D, regVCN_UE_ERR_STATUS_HI_JPEG1D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG1D"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG2S, regVCN_UE_ERR_STATUS_HI_JPEG2S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG2S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG2D, regVCN_UE_ERR_STATUS_HI_JPEG2D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG2D"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG3S, regVCN_UE_ERR_STATUS_HI_JPEG3S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG3S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG3D, regVCN_UE_ERR_STATUS_HI_JPEG3D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG3D"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG4S, regVCN_UE_ERR_STATUS_HI_JPEG4S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG4S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG4D, regVCN_UE_ERR_STATUS_HI_JPEG4D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG4D"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG5S, regVCN_UE_ERR_STATUS_HI_JPEG5S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG5S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG5D, regVCN_UE_ERR_STATUS_HI_JPEG5D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG5D"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG6S, regVCN_UE_ERR_STATUS_HI_JPEG6S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG6S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG6D, regVCN_UE_ERR_STATUS_HI_JPEG6D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG6D"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG7S, regVCN_UE_ERR_STATUS_HI_JPEG7S),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG7S"},
+	{AMDGPU_RAS_REG_ENTRY(JPEG, 0, regVCN_UE_ERR_STATUS_LO_JPEG7D, regVCN_UE_ERR_STATUS_HI_JPEG7D),
+	1, (AMDGPU_RAS_ERR_INFO_VALID | AMDGPU_RAS_ERR_STATUS_VALID), "JPEG7D"},
+};
+
+static void jpeg_v4_0_3_inst_query_ras_error_count(struct amdgpu_device *adev,
+						   uint32_t jpeg_inst,
+						   void *ras_err_status)
+{
+	struct ras_err_data *err_data = (struct ras_err_data *)ras_err_status;
+
+	/* jpeg v4_0_3 only support uncorrectable errors */
+	amdgpu_ras_inst_query_ras_error_count(adev,
+			jpeg_v4_0_3_ue_reg_list,
+			ARRAY_SIZE(jpeg_v4_0_3_ue_reg_list),
+			NULL, 0, GET_INST(VCN, jpeg_inst),
+			AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE,
+			&err_data->ue_count);
+}
+
+static void jpeg_v4_0_3_query_ras_error_count(struct amdgpu_device *adev,
+					      void *ras_err_status)
+{
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__JPEG)) {
+		dev_warn(adev->dev, "JPEG RAS is not supported\n");
+		return;
+	}
+
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; i++)
+		jpeg_v4_0_3_inst_query_ras_error_count(adev, i, ras_err_status);
+}
-- 
2.40.1

