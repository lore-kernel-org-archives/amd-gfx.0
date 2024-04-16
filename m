Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580FBC10F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 06:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A38CF112A65;
	Tue, 16 Apr 2024 06:16:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F9jLJIeE";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFA1112A65
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 06:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=khpS2oJ++oK1+zGNTn3rVlerneZOrovM151d5Ht1IRac+RtfHl4mJem8+Z4XhTdMcktVS2CWb/9FaeYbbxmqmc0WGMSMpF1wBO9yjW3RlVZWMX+fKk59HSfnF4IaE1EVTSxW5NSs2qKIKZp0SKExk1m7+07GBCS1zotI96Jp9rExvngnr2ycG35mCDcEwlL1niSyiSzpBrm5nN8UpAacdJGIwg3uD6A21kQc8/QeOZhwLOksnyhDHvPdJ2h81kXc1PnOFlBNTf/rC/CtW/9INrh+iUcs7QqUerHlpaYnsq7Oo7P6n+I7OYrc7laB+OWAzF9MtPBiSLnFfzGFOUz8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWuUEC3dLGH/t8U33GlXB02VjEki8YqCR37xFQ4ONx8=;
 b=ipXeiN5YW8YPRBX9hcgJbBuTYf4XN5trr2kMOQr8sGtR+ud2MTGBWo565jFPkmLPIMQ1eEG4VZUiBhgunOwDcbdeshlwbjRuobd5RooBxe3PFGxNsmz5IuXEaO9/p3xBBMU0snYjcEmhfLjX6wk0HQfoS9iOBlhcCioPmA70hF4K7A5kxIQCbAaTG1TR70yhF0vgmzHOX45KxNAqCqiSQrkN/fCAmcbSv6Xn9ukseZxDux8+8X5GHG/wk4L8dtZlBPFJstG3nWKaE/0cwyzNNRV6YAJJoOYh4HPDIbI2KFo7Yqxr/YUuw6nSrEx8R9RHaJuJA0iLLMWZLa0Ggd687g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWuUEC3dLGH/t8U33GlXB02VjEki8YqCR37xFQ4ONx8=;
 b=F9jLJIeEsGqyh0WOlc01fHmJbaKDTkDPlR1xfeou9//DNnK6ggtOhXNcMWyA1n5EDz7WpFeyFXYCMeQI5GYIOIxPrusAWxpVJTfJEBwsAbyPVmmeDWp6Hw6iXTFPakWJRPevW7Dqp4TqR6E6x97KhKNaj2IzSfly2l7RNvDlsQ8=
Received: from SJ0PR03CA0249.namprd03.prod.outlook.com (2603:10b6:a03:3a0::14)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 06:16:29 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::79) by SJ0PR03CA0249.outlook.office365.com
 (2603:10b6:a03:3a0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Tue, 16 Apr 2024 06:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Tue, 16 Apr 2024 06:16:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 16 Apr
 2024 01:16:28 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 01:16:27
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Tao Zhou <tao.zhou1@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Use driver mode reset for data poison
Date: Tue, 16 Apr 2024 14:16:25 +0800
Message-ID: <20240416061625.2557-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Hawking.Zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: ab9ac58b-3aca-4ae6-04f0-08dc5ddcc11d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gUW8c+G5IYZlo4YGhuGZBKB63j1tZ7wpjrBvmb4UqvHycCk4TNvciXWFNZRpzJeBySRshKhZ0CAJHNAVaN89vXUn8jH2nzlLRHBoSvSxEZvxlgpT8FfcVeghogoOHwO64iFb+KQHadmDks5pKMhUwratoEKo+16t282n3U/c/eVxxLrDh/4yXrOgBV+cbRpehzbbA9zDGV2Ryiw2aFXaigvGC5Z5BZCeNAjg0fOm2ZTorM8c8ouNWRvQHgJaLLxFvaRjn06gbXwMONW5Fsf0qT94mhLKCKeRKbmMR859nVkJf8DC8fleyfr+c84qEZtjsk5GVFHtYvPlXPBqSjkPQStI4zS+FTlGfFmH0CvHQREhUDAsM/g898PIeZKv4u0Ls8ezvcqRw3feZmnprbqO4jKh6WQQaH4J/1h6hce8DDi2T71UfXVFpe9nFA6e6HCYfmoenoavg1XO5R63kqXYaufwYf0+PRv9MY+y3fln8QplOSgR+Iq2l37X4QCxV1/8k4ZqlKifbavHfNlj9M2TcCdPZpeawuPjxG9xgZ0PIgHG8mHMZ9YURRl0ZGOzVm/PGzHWM/2mPmJFYGkheEB/CgKc4bGD3wud4SxR/dJUml2z4H7i7P858nNJIHsLGh3OVavOn4I+uRj46DKXVpdstxc+qRyyRgqpkWbMOnvFPk1f4Vzek7+/BSme1HLSVRYA3t6U+fo8OL2QOmG6C2Z6y0Lj1rvmYYFi2WRpO9yhnQmGEdGt06bRDKiXdqVFYxU3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 06:16:29.2454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab9ac58b-3aca-4ae6-04f0-08dc5ddcc11d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732
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

mode-2 reset is the only reliable method that can get
GC/SDMA back when poison is consumed. mmhub requires
mode-1 reset.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 27 ++++++-------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index c368c70df3f4a..c3beb872adf8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -144,7 +144,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 				uint16_t pasid, uint16_t client_id)
 {
 	enum amdgpu_ras_block block = 0;
-	int old_poison, ret = -EINVAL;
+	int old_poison;
 	uint32_t reset = 0;
 	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
 
@@ -163,17 +163,13 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 	case SOC15_IH_CLIENTID_SE2SH:
 	case SOC15_IH_CLIENTID_SE3SH:
 	case SOC15_IH_CLIENTID_UTCL2:
-		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__GFX;
-		if (ret)
-			reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	case SOC15_IH_CLIENTID_VMC:
 	case SOC15_IH_CLIENTID_VMC1:
-		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
 		block = AMDGPU_RAS_BLOCK__MMHUB;
-		if (ret)
-			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+		reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		break;
 	case SOC15_IH_CLIENTID_SDMA0:
 	case SOC15_IH_CLIENTID_SDMA1:
@@ -184,22 +180,15 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 		reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		break;
 	default:
-		break;
+		dev_warn(dev->adev->dev,
+			 "client %d does not support poison consumption\n", client_id);
+		return;
 	}
 
 	kfd_signal_poison_consumed_event(dev, pasid);
 
-	/* resetting queue passes, do page retirement without gpu reset
-	 * resetting queue fails, fallback to gpu reset solution
-	 */
-	if (!ret)
-		dev_warn(dev->adev->dev,
-			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
-			client_id);
-	else
-		dev_warn(dev->adev->dev,
-			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
-			client_id);
+	dev_warn(dev->adev->dev,
+		 "poison is consumed by client %d, kick off gpu reset flow\n", client_id);
 
 	amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, reset);
 }
-- 
2.17.1

