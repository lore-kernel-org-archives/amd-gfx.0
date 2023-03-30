Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86560C77B60
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5123910EFD1;
	Thu, 30 Mar 2023 19:32:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815A710EFE5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy5S410C1GOBWZwTguIbFjAucWRc0CX4NpLnUSVnB8WgGnKUi3EFhkn02yKH3uj6Eh01CEV/vlygEq8PuVwMHf64KFjEo5sPJyU81yrMdWx1qTBOYzyjpd8/eymwH5pUU06el+DngHxRvFp42W/i24V0K8qi+qe3kQN0XSGXMac/pW8TV+I55+fcZGklD4YY0Z8vntEupkOWykiwQz1kyEnhSooSzTQ+NPH9ssV7dvS8W+gFnQ1nKyz8nJjvORVGAGiDqtktA/YVEki+vvLaTTa6ptcMn1STopyQ2JnvpZa5ifkr2qzpaOs5uOEj0zur0k5bmWG4E5mDWiHOfCQD3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6DaDzp2emmMQeLI8z8epUHvEEWvYJ/Of3zx742KBIU=;
 b=eBW3svsBjRcyip+9d3f7ETt3WJDdvtO5uD3QMEY4By0ykXXyO8Rht/oBBLLxQaotbOceypPmeNSrmiNrZxL5HBSKKL7gL7AUcoBni31MCHlJmanffMGK5FZf/I9EarA/syHlqsZ3AaUFJK9iZtYesSv7zxn2MonJNZDPyqTkTFRVSC9ykHWNwvyR96dPNppeSJvWCKtbe1HzGs3b9x6xg5/HQmPPzktL/0NheE6HkDQf88SuFIkAlu844usA4jNL/RQP4J6hNX+0Jzqebyd6ML5INJzR+TwTeh37j5TwQZXpRrUc3AemPx8tTK8GohpOzG23weTGM0nj83RAGDA/+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6DaDzp2emmMQeLI8z8epUHvEEWvYJ/Of3zx742KBIU=;
 b=BaqxZ3J9+AsRZTDar59RztunqQDLmNGh+SLc5rOWQfZldRpzEPyiJ7Ep/wjXsnAdKwFvXbCxBOPcwMQ5i2z4rpUmYt64zVl0AQ8DG4J7LkaYUYlg5XrHMdT1z5xUzCA1tVKJFj4PK7n+hh0S6rDRCXtNcQifD6bjU8AUTZN/if0=
Received: from BN9PR03CA0797.namprd03.prod.outlook.com (2603:10b6:408:13f::22)
 by BY5PR12MB4241.namprd12.prod.outlook.com (2603:10b6:a03:20c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Thu, 30 Mar
 2023 19:32:25 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::15) by BN9PR03CA0797.outlook.office365.com
 (2603:10b6:408:13f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:32:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:32:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/10] drm/amdgpu: Add XCP IP callback funcs for each IP
Date: Thu, 30 Mar 2023 15:31:58 -0400
Message-ID: <20230330193158.1134802-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330193158.1134802-1-alexander.deucher@amd.com>
References: <20230330193158.1134802-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|BY5PR12MB4241:EE_
X-MS-Office365-Filtering-Correlation-Id: ad20154e-61bc-47a6-a1a5-08db31557d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cyAByxFr3mVAX9q8hedmGrX6br0OPSezgQld4s4V8HlfjCz2WORhFZf7qMc+FvZn5mM4JZFwn2Mlr8J35iSp/PJ+6H7Rj9iZtQoX0QoUynBWR6VAk5WHB+6CsLmI9BeLdz7ao3GT1tFIBrvresKcT8qwnXEGEh2nkV7JbTJZ77BTBEA8iun2MXjkHVu9gyvjRRLgP6yn9B8zY3UctK68O8HvEE6r9qJCXD79ko/DNoAQTt5T96QC/t0Iv3EoJDum55tw+4mIpkfRJbQhVWetNQ43aNC/dw4BnSezD46/xSVhaeX/Ss3CqMbO2ZGhdjyhsYOMbeVUwdcO+ODJMQyW9CjL1Dy1rdBUi09fYSGEtHNZrauYE3ltxMqwEUdTjTB8/w02c1726OMm+GxfXYpy6wPJBbzW9tOUqOOKakpYzJu7xQI3InKJ7FHyv/tD2LmjuU/ib2386DJOVkp0drTxFh0i9dCBauSg2Pg7aD7q2R7fYrB3x0yTaZVlGx9GcEjVqfRoHdDlU/21/4VGQOiALUUXBvnkRgI26hXtlAQ90XbQf8jp+GeZvq8jHnvBaV2qSupjZ5RjZACo3SLUZOgH1pZmud7zXXInamri7vdAjvRS/WB690fPQ4Jf/g3ejfM0TtjM8TX48TVJ/S78dACIxufM75Gmf31idUjD3qTUlRtxcnvaxsGqFGzYGGlRCZhsIVbTQAHk/x6uABjMgFK9LXh0VwOxdIRTZfjr8RCpOrw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(47076005)(6916009)(2906002)(336012)(2616005)(83380400001)(426003)(54906003)(70586007)(4326008)(70206006)(8676002)(478600001)(16526019)(26005)(1076003)(316002)(82310400005)(6666004)(186003)(7696005)(36756003)(86362001)(36860700001)(40460700003)(40480700001)(5660300002)(356005)(81166007)(82740400003)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:32:25.1749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad20154e-61bc-47a6-a1a5-08db31557d96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4241
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Initialize with the IP specific functions needed for GFXHUB, GFX and
SDMA.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 9 ++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h             | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h            | 2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.h            | 2 ++
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index bbcdececfd2f..2cbac0bccd80 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -25,6 +25,9 @@
 
 #include "soc15_common.h"
 #include "amdgpu_xcp.h"
+#include "gfx_v9_4_3.h"
+#include "gfxhub_v1_2.h"
+#include "sdma_v4_4_2.h"
 
 #define XCP_INST_MASK(num_inst, xcp_id)                                        \
 	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
@@ -205,15 +208,15 @@ int __aqua_vanjaram_get_xcp_ip_info(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
 	switch (ip_id) {
 	case AMDGPU_XCP_GFXHUB:
 		ip->inst_mask = XCP_INST_MASK(num_xcc_xcp, xcp_id);
-		/* TODO : Assign IP funcs */
+		ip->ip_funcs = &gfxhub_v1_2_xcp_funcs;
 		break;
 	case AMDGPU_XCP_GFX:
 		ip->inst_mask = XCP_INST_MASK(num_xcc_xcp, xcp_id);
-		/* TODO : Assign IP funcs */
+		ip->ip_funcs = &gfx_v9_4_3_xcp_funcs;
 		break;
 	case AMDGPU_XCP_SDMA:
 		ip->inst_mask = XCP_INST_MASK(num_sdma_xcp, xcp_id);
-		/* TODO : Assign IP funcs */
+		ip->ip_funcs = &sdma_v4_4_2_xcp_funcs;
 		break;
 	case AMDGPU_XCP_VCN:
 		ip->inst_mask = XCP_INST_MASK(num_vcn_xcp, xcp_id);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
index 4b530f4c1295..42d67ee0e7ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.h
@@ -26,4 +26,6 @@
 
 extern const struct amdgpu_ip_block_version gfx_v9_4_3_ip_block;
 
+extern struct amdgpu_xcp_ip_funcs gfx_v9_4_3_xcp_funcs;
+
 #endif /* __GFX_V9_4_3_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h
index e2d508f5a7ee..997e9f90c990 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.h
@@ -26,4 +26,6 @@
 
 extern const struct amdgpu_gfxhub_funcs gfxhub_v1_2_funcs;
 
+extern struct amdgpu_xcp_ip_funcs gfxhub_v1_2_xcp_funcs;
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.h b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.h
index 4814e8a074d6..d516145529bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.h
@@ -27,4 +27,6 @@
 extern const struct amd_ip_funcs sdma_v4_4_2_ip_funcs;
 extern const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block;
 
+extern struct amdgpu_xcp_ip_funcs sdma_v4_4_2_xcp_funcs;
+
 #endif
-- 
2.39.2

