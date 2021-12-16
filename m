Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C61FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Dec 2021 19:42:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0673910EDA9;
	Thu, 16 Dec 2021 19:42:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CF010EDA9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Dec 2021 19:42:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVUkKVRq+t7pjf6N1GGrS/eIWk2C7RPCk9lmZ8vocSay0IkDknHJSPj7OCVViSojKwIdu5XySr11E68gcC/BzYmHcK1hCQAKWxBC1PDSYzSFUKzfWrenOrvH2T+L5oi2ntiET62vi6H9LIXPibXwgBrZ+sX7Gd30ZOFUiyd2FRb2AX8WfyOuW3WAxRf0Z+2OTPiuXZ64NbJaWsu/bo1URV0sPBXVi9ZVue+wut2GBL38N7B4saNa+98cHcF7wm9mbVyv2esFRVqsg0QHPltd17uDW89H6IMqZ0bCyAACaz3jepwBOHTLWk2MvCTA3BtxogHebG+hfnMkIUXaY37AuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CVl4dP6+/nyWDK4eb2VsNkp8AutsLvDHwzbS7aHVKM=;
 b=idaBxa4WnAUSQSyfnmbZfXNeSKcVh9WeUW4fx/najO2ArbW1TDlhhvJoZnMuSDF28SAfMYFXhXwgz/XOT/8bwEgBiWHruVLMDlJKbU9aDBRDosoJOAOg2tPAdo7YlkxJiYm23BX2teqsPKWzt7tHrqIvizvXcz+FMQ9lli2f1pXg+wk6nCkpwS6Re4zBVZCEqYd7fb20qlgghlK4sFToCUjduqF7VFikyA17/0qUax6A9myOOMBEy6mJp0ClK4uEEA5tDKi9DZK+cSeAkFiUohXVF8k5KtPy2RCB+6U6iIm+Av4sivgDFQdfwTToUfha9wSiyEoiHLO1XMwNSRn7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CVl4dP6+/nyWDK4eb2VsNkp8AutsLvDHwzbS7aHVKM=;
 b=b7/W9w0PaX4vWYBsfPWk1DCe5QrIsHL2qdE2yJecFM0wCWXailJLjDPijOA6sZHDlmcrv7e6MnfM94++xQec65pN30I1dZw9fya3NolI+3ivZYeLBwITql9Tn601fpOeHTy8q+C9FL7J1kAIMQLSPPLQ2w3R52WEku/dtxzvOPM=
Received: from DM6PR07CA0083.namprd07.prod.outlook.com (2603:10b6:5:337::16)
 by MN2PR12MB2912.namprd12.prod.outlook.com (2603:10b6:208:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 19:42:49 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::f4) by DM6PR07CA0083.outlook.office365.com
 (2603:10b6:5:337::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17 via Frontend
 Transport; Thu, 16 Dec 2021 19:42:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 19:42:49 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 13:42:48 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH v3 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
Date: Thu, 16 Dec 2021 19:42:29 +0000
Message-ID: <20211216194233.3839-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216194233.3839-1-victor.skvortsov@amd.com>
References: <20211216194233.3839-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e372f84-4681-4618-4a9c-08d9c0cc3e11
X-MS-TrafficTypeDiagnostic: MN2PR12MB2912:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB2912F18308C66C3709826A688B779@MN2PR12MB2912.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d6mIE5ZtCxFosKSZs0GqpY5gJ8ykpiWB7HyMv/rh3gWkAibU26b1PLV9o45Xpv26L5wDfgVp3dNTc3D1VmNXBvc9SiPtRHqcojjvwnXT1xUOmYX6+HNwUaY4c3824cK3cbTwbrsZb+JhM1e805buA8C18gWD2pubwx/baxuqn/WOl6QloPcFbncS/llv9n7W1xBBqVWcMFGDSX5psMFvUfG9iDpaJ722nIoEYCs4TwyL79lq3q/Vk+3H4hOZhQlJoD8rP9PWNsdarnjEQPi+KF1LcuHhypa4YHsenFM+GEoIL8ns8mHF7Yab2FeogyBm6b2i+VBW/RmhzN3HpDc0jXPRoyaacGBvLvT39ty5Rclod95ghnTDimKpBbVvhzngI9fs/cb2kho+ey/TlYfJB5Xo/4ItOQstUNmunB+XEFDkxgEMW0GvDkKw0JokMmiNMo0G5N4tlrKhc6MzB0BP0rblkkqfxMv7z43WdSeLI8tjmWEJepCIVcCHAc76psVsAfbZfwc6FGoGGHFLe8XYQk5i1Sg/WhWe5aVfh/jGB+oCQW8RN8hEG4VWEOjRpv+hnmLiewvkw9li1iZdvehs1UW61du/qb19tvq83wE4/kpb2GXZZuegDqDI3xtJGM9DnFAdvslSKfGf69kKLuCavAcyTiWcrbi1ICFMxFHhF1c2Zaw2Dn8to4BTVc9mjTTO6bQ7VJQUUWM3QbL9A4KJSzq0fw0WbpXV8w+pxnBYzULJWfXj8TbCrC47ArczoA/gIHp0HhcupTmIcGGO4B00xGAtL4G0qhfZHPFB783PWo0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(356005)(2906002)(508600001)(81166007)(110136005)(82310400004)(40460700001)(8936002)(70586007)(426003)(316002)(44832011)(86362001)(26005)(36860700001)(336012)(6636002)(6666004)(47076005)(70206006)(16526019)(83380400001)(186003)(1076003)(8676002)(2616005)(5660300002)(4326008)(7696005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 19:42:49.5880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e372f84-4681-4618-4a9c-08d9c0cc3e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2912
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
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add helper macros to change register access
from direct to indirect.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15_common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 8a9ca87d8663..473767e03676 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -51,6 +51,8 @@
 
 #define RREG32_SOC15_IP(ip, reg) __RREG32_SOC15_RLC__(reg, 0, ip##_HWIP)
 
+#define RREG32_SOC15_IP_NO_KIQ(ip, reg) __RREG32_SOC15_RLC__(reg, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+
 #define RREG32_SOC15_NO_KIQ(ip, inst, reg) \
 	__RREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
 			 AMDGPU_REGS_NO_KIQ, ip##_HWIP)
@@ -65,6 +67,9 @@
 #define WREG32_SOC15_IP(ip, reg, value) \
 	 __WREG32_SOC15_RLC__(reg, value, 0, ip##_HWIP)
 
+#define WREG32_SOC15_IP_NO_KIQ(ip, reg, value) \
+	 __WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
+
 #define WREG32_SOC15_NO_KIQ(ip, inst, reg, value) \
 	__WREG32_SOC15_RLC__(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg, \
 			     value, AMDGPU_REGS_NO_KIQ, ip##_HWIP)
-- 
2.25.1

