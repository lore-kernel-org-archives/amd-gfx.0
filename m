Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB737C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 18:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6893B10E1CE;
	Thu,  3 Feb 2022 18:59:09 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2068.outbound.protection.outlook.com [40.107.101.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8743310E1AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 18:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mr9EBlcQKCB/149fL5HTGen3/fpR6yRhz1FXg4Lg47L5L/BsefwFwgretC8nfUJivNWXvlKyZiSeqYhAsBpieIa0aR8DkcG/OVf65icdGbGrRPlcsUxHlWL5YpK4aTUhR08TT+CLmoctfM5O26UdOV63gMMgJQM+vI/WenWSx0A45PqTpKWc3nugu5WK89w1Q03gYJsA4mtr9JlmSte/v20Gp2yzwbj5dXDxJeCjW0Gxyf/jHGF8JGJVA15AQkJP31rb5jxFQmGI+uTI2mj5S/iBMZoD3ARZEezfVZj0tcLg9asZd/bD1A+UkNubo8iCXkJgZ922ZhC/cuQ5NY9nBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYUpPC2ZXMbumzV9cl0WYKMr07KlhHsnegeHCaKeXak=;
 b=F1h8u4gcRWCzscipYtgWJVvWgo3yFFXIJUJFQJEmlhx0+M7ww+ouT3e8Jx0//aWgDfK1gEa/b3pbyGxnlXUAPzaLiY1fM1me+pGG6sk5k6Wk5aUku+QwblqY8qOp6ItKAGTm9feY3bQhBSWvojs3rj5DygdLrUflombYPLYbRELXxZbz0KVY5RXFjrOfNqe1MsxzFJnh2OdhjsTUWHYLoIJxUZeVsYAR1m/pPukhx3bNyAYBlo8FtpdKOdS6aGdUufSNoA63rwyHAALUOtwUDFxkf38N5EyfEfT2ZU9E59GLetNRia5CuDvAJkkgDG3za4WNL8a6wvTQJn0JMJ5GRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYUpPC2ZXMbumzV9cl0WYKMr07KlhHsnegeHCaKeXak=;
 b=vUic2fJLLHyqZftg1hZbBLwKCK5HNxfybemgtM6qWSqiXNPw5tXqoo49HBGYjFCpmhYcLFrXKn4MfJoY9s7kgBqOV1r4Cpgq2SndcOvUve6GGd84D5GCi66s4zFSpy1uHwwneabSizcEkKqTkSgBQuO+UpqbezKJ6L+pVFDa6RY=
Received: from MW4PR04CA0246.namprd04.prod.outlook.com (2603:10b6:303:88::11)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Thu, 3 Feb
 2022 18:59:05 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::fa) by MW4PR04CA0246.outlook.office365.com
 (2603:10b6:303:88::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14 via Frontend
 Transport; Thu, 3 Feb 2022 18:59:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 18:59:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 12:59:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add missing license to dpcs_3_0_0 headers
Date: Thu, 3 Feb 2022 13:58:45 -0500
Message-ID: <20220203185847.1473998-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bac6c2c-4144-4157-f419-08d9e7473fe9
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB453375ACDAB9DAFCA1C40099F7289@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gPxTgkyJvLUa27G45c0VDa4l4q/gVS095wIhabNop3k+lsIrqRohyklARGSXb84FaeCuW7Vem1lWKUB955yML6dlGjaEcrrotHJKhflrA3aDzkZx9HLoX3MxaxoZaLIpzcPvAZyZYNZTlICiUGFiZkI+2lsuMKzZcWVyvVGiaFECqSkJKXbM9np3PBeqn5R1TvMrFxH2ZBVtZs5N3NbgKbpcx9trqilPVCpjKfCxslnd7LsgxUZn4WtV3HizdrU0hC85R2eiWdCZNLfKqxEZuIg6U8hm77B3dX4guGk8okYKUZMMu0VHmNwIyiJ9ECGplU6VsQZ8sKY11Z5Yeicp4BXNDtPRSAheLGnSYdQ6y2vVi9GjKsGLSLrWcr0pb7g2agzN3wLBeoVeeTu5djcuMdqT0iLy2p/ub1P16DuilL89FcBxcD58djI5GNE25hNbhOvSlEBsyc5p4+gtuU7vG/UNYoQ0OASlaUbx0ElD1yQ6Fk9bYfiDk9Y4v1iEp056qnCrhiZp+k45srhmwt2/lDdI4d6+aDdvIqY6hSM8AE/gp85r47VVuPUqlDYVRt6HVXDvv9tw57lGiG3EdA7ErOIVa0zKUtjnLAKs+FReqqcuPWkGl7u+z6kRcvE/XUeuVuOEHk6I7W8YaXpLbI81L0K8jwh270ECfyuNB5FhVs+7EkQmDmWeivk46wGCtO3L8trtuye55qzghbCzRvMt+w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(8676002)(5660300002)(4326008)(356005)(81166007)(70586007)(70206006)(508600001)(40460700003)(86362001)(36756003)(316002)(6916009)(82310400004)(8936002)(2906002)(47076005)(7696005)(426003)(336012)(16526019)(6666004)(1076003)(186003)(26005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 18:59:04.8752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bac6c2c-4144-4157-f419-08d9e7473fe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MIT.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h   | 7 +++++++
 .../gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h  | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
index 67faaf68e9d7..0bb47e06eee8 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (C) 2020 Advanced Micro Devices, Inc.
+ *
+ * Authors: AMD
+ */
+
 #ifndef _dpcs_3_0_0_OFFSET_HEADER
 #define _dpcs_3_0_0_OFFSET_HEADER
 
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
index b4ef50a72868..23fa1121a967 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
@@ -1,3 +1,10 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (C) 2020 Advanced Micro Devices, Inc.
+ *
+ * Authors: AMD
+ */
+
 #ifndef _dpcs_3_0_0_SH_MASK_HEADER
 #define _dpcs_3_0_0_SH_MASK_HEADER
 
-- 
2.34.1

