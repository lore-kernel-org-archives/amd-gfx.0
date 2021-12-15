Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A40C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Dec 2021 18:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EEF810F836;
	Wed, 15 Dec 2021 18:55:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F1B410F836
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Dec 2021 18:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hdHgQEPsXBkzQuaLLNjrCfWUrwgb6DP6TOeKhVw6SoDzsxs5uKm21A12TW4EW1heTxuLSZnY/PUbcZsI/nhICBTnVTqivWRi+JGeUj7qRqi5LP8kt1rCyPFuc3SLNxuKO0u1pk5mY2RTAX7UDMVDinvzfVEAAraD0nFzfc7hbtprGXnuADaiWaLydCVB2OmXNWkQnqUP8Nz60eF1Piyk9ZfseenHcVqd9V05TDF6d566kWqZ+IQ4cxn6DQ4OZmeIqjEToaaaMqtJBT7rluHarPxmTGTD9UOhHlfXPNRf2rVLwFr83Wu7nA0pFKEQphTHw3i9nyOtmJL8WgSHROS5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CVl4dP6+/nyWDK4eb2VsNkp8AutsLvDHwzbS7aHVKM=;
 b=DSrhWrhZZmXaYdlYUYN0eWFHVpNNC07+gGnU4YZl/DjcUKjSzveTmU6DaVUrtDUMaaM2WnoreU/1dH85RgEnyMfNWOJwZxlsTaWMqAuBKzZAwct+Wv4iZf3+QgJI/FZ2eK7XIufgScNvLl9iicjna18FLkofEcOCDNfGL31ee5MU42aTfbJTjKLBdo7ZUw+lEz8aBjJG+fO80cceO81IanJkKv+L3qaLa4NZuamDnpmsEItjVwpIbN8iBW8VNfmzNlgaA4Vi0ULdW+E7Lty4CumjSPHkG8m7gnit8AivRjhWnEEhPW8MFvu7sJfx8UhaW/C5lwM9fvHkLpTAajZkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CVl4dP6+/nyWDK4eb2VsNkp8AutsLvDHwzbS7aHVKM=;
 b=bROdExxfgl8Vec1bL25OMw9xoFsPRbMZHjGJC2X7iFaLXuGocEhnRGAoF5fyKFJYcvCED4ynGGbs9opO+CXGiMTcA6eMYbRRxMC/O+oiCvul6DUZ20me9id5xBHPaCDA8Xmw9+vptaYvELDWt4ircHzzkkj7baREBl5UW5RvF9Y=
Received: from DM3PR12CA0137.namprd12.prod.outlook.com (2603:10b6:0:51::33) by
 BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.17; Wed, 15 Dec 2021 18:55:25 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::31) by DM3PR12CA0137.outlook.office365.com
 (2603:10b6:0:51::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Wed, 15 Dec 2021 18:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Wed, 15 Dec 2021 18:55:25 +0000
Received: from sriov-scm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 15 Dec
 2021 12:55:23 -0600
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Emily.Deng@amd.com>, <Monk.Liu@amd.com>, 
 <Davis.Ming@amd.com>, <Shaoyun.Liu@amd.com>, <PengJu.Zhou@amd.com>,
 <JingWen.Chen2@amd.com>, <Horace.Chen@amd.com>, <David.Nieto@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add *_SOC15_IP_NO_KIQ() macro definitions
Date: Wed, 15 Dec 2021 18:55:06 +0000
Message-ID: <20211215185510.15134-2-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215185510.15134-1-victor.skvortsov@amd.com>
References: <20211215185510.15134-1-victor.skvortsov@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 547f70f7-9632-4d56-3271-08d9bffc744a
X-MS-TrafficTypeDiagnostic: BYAPR12MB2631:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2631849E059A7CC81F21C8878B769@BYAPR12MB2631.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjqiXZqYvZgZjDbrf4oqo+a9gzJvxm03dMEvRDo0c+nWys9u5rB/riSUPRH/+iyFKUCnEU8oCJ1qhq/zXGsRQJS185DNdgAr3rLrq8tNT2fSyin/5/KqDOw84k1os/64Nb2YCfOR8UWhnhxGbYOm6YcZxDJAlcVuOTsw0peSwBryByEjjChWdC7VrHQOJJrn/36MgKEwgcPKfJ7fbXaJDDFMNKdxD6m1Wf5oDm/rU0uMIOa1GsRf5w4LzwDWdctVcZE5Lc6JLa3XDNaCRfgmXtr5cektXtwBh/MOmSzUAXCMaXanaCSzkn8QLhUAHhvOg5KjUEzfz7k15lYAtfww1aaLK4HJJ/eU5KjkoM8SmM47XZ6oMMCoY5tez11k55iuTaATRu1CtHfS7X05EZ0WzucIapk3ZP8sldKW3JOBYRG/Qda3qH3yCdhgjBxryJnTC3acqQsRt6QGidf1WiewICiuKGC9LS32fwxGKzj8uAyMcN1v0idqV3wYqebL6Q4NyjAyMjbKwQ283LTfwGK4SW5g8p6aGUrGXa89NoGVvsiVR/IzyKK04H8+WBvbtpuo7zNMY+kuigLjbcJZmHcbSLMIfA7sgq/9r+/pAJuWCXw+aCMD126DViv1UWqjsN51Oi1npQr50r/4q0UQZQkv2mV0K1BJoxqbK1IlHdVIDGA8+JrMPdHvpknEY2g5BTE5IJ3/pCLJHGYmqeXsIeeQ6svMvHFsCp3cYrafijEQHwybnaQfUCII2HDloYDGkS7wlP2mhheQcLtcEQdnHzv+XtWf40hfCVzCWBhvL/APQOA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(508600001)(1076003)(5660300002)(316002)(70206006)(110136005)(83380400001)(16526019)(2616005)(7696005)(6666004)(81166007)(186003)(6636002)(356005)(70586007)(8676002)(426003)(44832011)(8936002)(86362001)(26005)(36860700001)(40460700001)(4326008)(2906002)(47076005)(36756003)(82310400004)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 18:55:25.2381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 547f70f7-9632-4d56-3271-08d9bffc744a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
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

