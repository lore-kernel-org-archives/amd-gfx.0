Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD0FECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 04:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC52A10E0AC;
	Fri, 16 Sep 2022 04:40:05 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 557CB10E0AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 04:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYaVSeBXNEO5VEaercn2JfrcNrQeP9XPrAs0UpcKRGStZpAxaKs9jMWGeWKzIbTogYxNzNhJJfPfbWIbrj712nxJib86zTM9geAlC0HF7eVGDX4wEF7ESerItPLBaUnvsqSlarYnCz1AbbkQ4uHgn5XVYJW/mmWCO0ZpctpTuco9R0yE0KkIcxgvJbvlVR58/ply83lFTrwgwqdH4+JLhMJCnlR1jmH6cAyQvQtn7gazhl3e8H+fTTJ8mRaTDCYpL6OA1n0pSf8V29S6H7WfY004yKF5UEvB3704y+b0ltcZsrPjb0JW2aEV0x1LNm75BdSfaZZQfyH7IT0JtOOEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehBZYHBdmZgTRd2AQ5/S4MlRVOWW65oQwLUAWbvFwAU=;
 b=awoV9VahrTWRAIL+w6XrJgZJW2dT1szFo+DAD09isXtLIenLP1iHJ/8rc18u9J1k3tX5XtIK6wyBOC2B9eO0E50xkgNcqip7o4f0D60dc0Soqbgp1azCPFL55B9AOI9askwsP/FFAAGymkabkLr+hWqdyY0sMx3tJHjtZ548mc5Pm4qE43rNtun0Hrg7C1RULweZt87Y7bP8gsvfZyRDNoWzHyJPccj7LvvWfxsb28zr7koZ8KTyIx0TPvqs2GNg8Qsl0RDziblvWlOef38tuF/6EukTspIDPOP2QHlEwX3gZJVA3xdmE9oNd0ZaWrSa5aPsiqHaHzUhW7kzYc0oPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehBZYHBdmZgTRd2AQ5/S4MlRVOWW65oQwLUAWbvFwAU=;
 b=YMeS7ya+I/k8iGZQ1iV+/BeTi73sXzQfzB8DNssce4RUcnrcJkMopICYAoxpu0lgmZi1j/Xfbgq5swxGP/L/Nw7hlD9fahVRgj80ryrB/cyfF1ori6eXRTDTIw6dBhzsVabg0CeSgtbZVJhHERW+ryYlT8NMQavwu/xDzn1tH3w=
Received: from MW4PR04CA0205.namprd04.prod.outlook.com (2603:10b6:303:86::30)
 by DS7PR12MB6262.namprd12.prod.outlook.com (2603:10b6:8:96::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.15; Fri, 16 Sep 2022 04:39:59 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::ab) by MW4PR04CA0205.outlook.office365.com
 (2603:10b6:303:86::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 16 Sep 2022 04:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Fri, 16 Sep 2022 04:39:58 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 15 Sep
 2022 23:39:24 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add MES and MES-KIQ version in debugfs
Date: Fri, 16 Sep 2022 12:38:59 +0800
Message-ID: <20220916043859.109621-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT031:EE_|DS7PR12MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 901b6c48-187c-462f-d30c-08da979d82e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nk8tSM5MnqcJ8w48mGKD/S/55WqBSLNYI6PBlPmywnn9S7Ya21l8mYNKCC6rw/7VyVoeOLKUb8OehXWCjbvvFYmCTRVN43dY8BBAHSeaGtQ8qRn27TE8zcCKf440R1pzkHDWB5LpskB514XcbG1j3l90C2dN9fEKDrdKCnD2Rj42RIIWLzumw69MiDTeIxzM/BMcAswbbFrmeQXRohhJyuLxQNoEeL2+8q1vKI5G4vo0vFHq7hr5bDPffWuNdsGGPWy27Qwl7cb1Jb4ILKZQG7mJkya6XYoNUwzP+4xaDZv8FKCCsSrptGt6l6QxC00oZnCME8grzVux2E9DnQNwRmsn3PiojRBtLCiLyGkHGiS/wlLRPEXZEF2wolhClYGvnIsHJuOhgb12/tLExwh9ZDHBEFxP3koj2o3vfAPD1Sm403m2n5G5gmsQ3HkE6iThlgSmn4zWpOo3bXJ2n8X6tuUdyNHfkUAXncM/cXOIyr72+iJjS6IGhGFoVJp+9ppy1//Q30oka3nBlJjwM7qD0qXI2LTN38BczbouhgCbB8WP0/LLx/nfOd1b/UZJRuo+W5iOrBq2nRpYUyrxhKeY7aQPcuhm2iHLGXg01bAW+t2juN+MBO9LtmQEZUy4zo98TxR8tFC3mDiK7qFvNNEoS/zPj0l5idA/A5nXVMO9nJYHoZAatYhdSwLA8+IZpyzgGlxTVNtp9oWJ2zgHU14AOGHQ7eT2URO0v8MQrP5LTon71HyeEfpayygwb/oKZ05JWEfRydU0kVeQuNDX2etqePGNl0pdNe/lTLdYpgk9hgy6YMe5Aquy5VVI4R9D018I
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(36840700001)(40470700004)(46966006)(316002)(54906003)(478600001)(6916009)(26005)(5660300002)(6666004)(41300700001)(82740400003)(8936002)(426003)(47076005)(16526019)(336012)(2616005)(36756003)(1076003)(186003)(4326008)(8676002)(70586007)(70206006)(7696005)(40460700003)(36860700001)(86362001)(356005)(2906002)(81166007)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 04:39:58.6387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 901b6c48-187c-462f-d30c-08da979d82e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6262
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
Cc: Alexander.Deucher@amd.com, Tim.Huang@amd.com, Xiaojian.Du@amd.com,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch addes MES and MES-KIQ version in debugfs.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++
 include/uapi/drm/amdgpu_drm.h           |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1369c25448dc..bb0ed358909f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -328,6 +328,14 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 		fw_info->ver = adev->psp.cap_fw_version;
 		fw_info->feature = adev->psp.cap_feature_version;
 		break;
+	case AMDGPU_INFO_FW_MES_KIQ:
+		fw_info->ver = adev->mes.ucode_fw_version[0];
+		fw_info->feature = 0;
+		break;
+	case AMDGPU_INFO_FW_MES:
+		fw_info->ver = adev->mes.ucode_fw_version[1];
+		fw_info->feature = 0;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1581,6 +1589,22 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 				fw_info.feature, fw_info.ver);
 	}
 
+	/* MES_KIQ */
+	query_fw.fw_type = AMDGPU_INFO_FW_MES_KIQ;
+	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "MES_KIQ feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
+	/* MES */
+	query_fw.fw_type = AMDGPU_INFO_FW_MES;
+	ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
+	if (ret)
+		return ret;
+	seq_printf(m, "MES feature version: %u, firmware version: 0x%08x\n",
+		   fw_info.feature, fw_info.ver);
+
 	seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
 
 	return 0;
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index c2c9c674a223..12fdf62730b8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -755,6 +755,10 @@ struct drm_amdgpu_cs_chunk_data {
 	#define AMDGPU_INFO_FW_TOC		0x15
 	/* Subquery id: Query CAP firmware version */
 	#define AMDGPU_INFO_FW_CAP		0x16
+	/* Subquery id: Query MES_KIQ firmware version */
+	#define AMDGPU_INFO_FW_MES_KIQ		0x17
+	/* Subquery id: Query MES firmware version */
+	#define AMDGPU_INFO_FW_MES		0x18
 
 /* number of bytes moved for TTM migration */
 #define AMDGPU_INFO_NUM_BYTES_MOVED		0x0f
-- 
2.37.3

