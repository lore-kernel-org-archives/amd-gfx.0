Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360E5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA9E10F00D;
	Mon,  2 May 2022 19:08:23 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77C310F00E
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:08:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5hDhYHSKbzGrE3jZ7weC1WWvR/lG3NMnAAW1OpKfiGJhp0vevR8gf7I1se4hdIRS2kBIAD+yX6TCKUy3jzfIUOZd6FmejcmqDp+zayGAFmV92Nw4MyNSLRMe6CZkVL95PWJKL7BrCDsZ02xP6qYNylbchH/NTORgC9R3ECAgQMzF8/z6aHKr8Plo6az8iPsrjhbvQ808LOb6RW8g6ey5ePTY9jwEw9YsUzLIpCVIyy+1A3eqfQ16vSI49qK24IV/d18FBTPJXY90CeWRRLq+hDJ7VfskMlLwDFUn69T9+QCFAzcWccqZ+N8U58O8TEfMZL0K+3IGatU7GKXx6HgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umyqdJSuh7PPacCMljTb7XQYz8Qgt2q1xhMjKHgwbQo=;
 b=PUfFopHHX0vPUYVwXWczdLI39g1s7U/jq2rolDxO/2p6uEijXVvEGunzmVezjfKGrnQZNL6058yZHgo774x8JA7HQjI3JlSPIkhYwDbgQhjy63H3jH2nTmGsazY6i72jY/WmpOD18ei6gQvtA6+NinQi9TXnx9hyGQKNgPU8+kMv9bTJvvuakAhofiQCAf9652uYucgM8qxLdUcjM9Hm3kjQrrNtI/wPBHvk5YceU45imPrPZqKmcO6Ph5VdLQoL4mPRmKnVxYj9y+PuAS5j+1e2yVwrcqUnrunl4GcDkxxKiu4zTT9zF1moLFDpdAUW9vDhXDP4JmjUq2w2wassYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umyqdJSuh7PPacCMljTb7XQYz8Qgt2q1xhMjKHgwbQo=;
 b=SYDgrp3uCdWLr5G5jh6KCWpyFTJ5oQCTAOYF2578B6afrD5JeLFMrWyzhrBJ2onwQz6t3ZswNOqjlv/9vFnDnE5lbYYtTIvBPrTPpOXwz7T1BB9HSNmEXwcJ9kxeCEq8XGwzuNjD2OWKUGQOMt8NFA4Gf80+ulneJQqVaPFt22A=
Received: from MW4PR03CA0046.namprd03.prod.outlook.com (2603:10b6:303:8e::21)
 by BN8PR12MB3204.namprd12.prod.outlook.com (2603:10b6:408:9d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Mon, 2 May
 2022 19:08:19 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::29) by MW4PR03CA0046.outlook.office365.com
 (2603:10b6:303:8e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Mon, 2 May 2022 19:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:08:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:08:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/11] drm/amdgpu: move out asic specific definition from
 common header
Date: Mon, 2 May 2022 15:07:56 -0400
Message-ID: <20220502190804.784271-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190804.784271-1-alexander.deucher@amd.com>
References: <20220502190804.784271-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62e7cf79-7def-4097-58d4-08da2c6f1e4f
X-MS-TrafficTypeDiagnostic: BN8PR12MB3204:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB320456D4367E8AF038F0E62EF7C19@BN8PR12MB3204.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUAOKbp54MaeHYwLMg6lnHUTCffyghMv1vzLk4d53kkcDOscPh4dkclgquhZeA79IBIefACg0nLIubpjjYMgfMQ6++SO8EJ2yxcfPeJrIWt8VL8qePelFUndIXBcQAbKDzUmWY0XT9osHLimJtXRo4+XEEN99drM3kggegMllJoHZjUF+g8z1ZghXhlJQMC7baj2ayhMXaMYVdeMwYhRMEWUqgvw6id22Ln0Sysi7900vYPmtxSMXxep02LO/A3Fj4Hd4o6blwmD6X7uLuSfVjP9RJiy0BoGpQC5ewhZ24gWwlCvmINI0+qgOPpW4qmkTbRRViUrv5NxNDJXLdITldTmHJwWawZdsaRQANi1bcYm3xFRe0BpaP+DAcEzVb493oLt6gsy/4oaca2YfQRY9dE8ymvws1eDcE216Bl97VHVwGIwXWwt/ZyC6N0WG/qbl25JfOlvSxnNfZluYPoWkULSxJ8piDFzN7MOYD3xzBM3hU81pEkF/WjUOR5k7yyskzE6GFeGujyr5lkbHVckOcAfuemqhdBokuH1td2SFdFo94Cn2RxbxEj/1AdkNL2wLMfWhumpl13In3Ti9SsaqXqsRKA6G7eG4kP4UZFABQGFpoCtcFkHihAFyBjI6eonfIjOX+tY9ae7ZaRtB/LZCRQsue5klCJ/Ud9KFbaLuTtAwWsBj6hglOJ0oohVCm6iloy00eLuMqVKB3UHU5s/5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(7696005)(336012)(81166007)(36756003)(356005)(2616005)(54906003)(426003)(186003)(508600001)(26005)(1076003)(6666004)(40460700003)(83380400001)(36860700001)(16526019)(47076005)(8676002)(70206006)(4326008)(70586007)(2906002)(86362001)(5660300002)(8936002)(6916009)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:08:18.6136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e7cf79-7def-4097-58d4-08da2c6f1e4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3204
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sonny Jiang <sonny.jiang@amd.com>,
 James Zhu <James.Zhu@amd.com>, Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Move out asic specific definition from common header.

Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Sonny Jiang <sonny.jiang@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 --
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 3 +++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 5f7da4c19822..912ead2e5bc8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -65,8 +65,6 @@
 #define VCN_ENC_CMD_REG_WRITE		0x0000000b
 #define VCN_ENC_CMD_REG_WAIT		0x0000000c
 
-#define VCN_VID_SOC_ADDRESS_2_0 	0x1fa00
-#define VCN1_VID_SOC_ADDRESS_3_0 	0x48200
 #define VCN_AON_SOC_ADDRESS_2_0 	0x1f800
 #define VCN1_AON_SOC_ADDRESS_3_0 	0x48000
 #define VCN_VID_IP_ADDRESS_2_0		0x0
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 8421044d5629..08871bad9994 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -37,6 +37,9 @@
 #include "vcn/vcn_2_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
+#define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
+#define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x1fd
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x503
 #define mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET			0x504
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 9352d07539b9..abf5ea238962 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -37,6 +37,9 @@
 #include "vcn/vcn_2_5_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
+#define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
+#define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
 #define mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET			0x10
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 930d3bcbb3e4..c7280ca5e836 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -37,6 +37,9 @@
 
 #include <drm/drm_drv.h>
 
+#define VCN_VID_SOC_ADDRESS_2_0					0x1fa00
+#define VCN1_VID_SOC_ADDRESS_3_0				0x48200
+
 #define mmUVD_CONTEXT_ID_INTERNAL_OFFSET			0x27
 #define mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET			0x0f
 #define mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET			0x10
-- 
2.35.1

