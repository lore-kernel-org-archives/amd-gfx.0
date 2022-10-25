Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F269DC04A95
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 08:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62D2A10E278;
	Tue, 25 Oct 2022 08:29:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A048310E296
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 08:29:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9gxMeK/1s/QzNx3hSmiMRbhOHQl2R+zmSEfLu+5WYxvS5CeXkgQW5xcyWVYEX9miPQ7KdrhIlGdtE7F0nP4QJgh20htd1hqXCVjBmshlkCCmCaNeC93lUSYoDw1QCfwhsdDwxPvTe/veVFJCuB5xVFoGzT9UfkpZyZZ6jjpAYxYUNdFY/+PNh1tKFYF5mpj05avbaCT/v2Z+sDulVDygxYgZ+sU8LlDufAON1Vvnlq+mRH33xJ+aLfnCMeqLcxh1SpibKc8zlcG5vt75dVnFePg8kDniz6Z1LQHSGS4lbDJWkvoq3kPf3Vx0NMtTmKO4u/q6Cnp4Y6m6qOihs7i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkqLqLGN5mcRHrV6LqM+Y4WixD2/Lu6CvolLoNps0jU=;
 b=Ox/hM6g9uh2b+4qWjZ0cWiGUEyyunL9gUPRcw6+n53TMwrs+ppg6FASd9Y159j6gdmDp+Tfo5uhdptXVqI1fykd3+vRdZvZAJXrTi3rGpoLVRPlv2qkunuWCRO91X0JFILR7jaouYsVgTld+o54s5ArrJp/FTYe3szz6YVuXHOAWry7fQTg5DiuSDbJZYOodSZ/bsUyGfVNz180x6gVbA7/7A40WH3G0IcTrFIHkMnLbAVMSrVqvPYjPRFbHra0sYIkMnWK/ZTdCsTcpaWwPS7aM6AoGYuo7nFhY/dJytVgENccm1vhzItlCEuQ4M4deL8Oe3lzNTpmg5QTJ5J8MEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EkqLqLGN5mcRHrV6LqM+Y4WixD2/Lu6CvolLoNps0jU=;
 b=eNz+gc3LI98QuR957GBkB8ymNvxSy0RaFlo2EkVtmXYvGKkPtftr3WjC9odEOJSkVcW8hUZFrSBhznj4awBleHhuGRt6ySp2lZD0sIe69K1kVFl9BSL/pxhJq+v+m+u5H0948LC3fGMQE30oBfBevFmy+09qv+PzY+veQnFLNwQ=
Received: from MW4PR02CA0027.namprd02.prod.outlook.com (2603:10b6:303:16d::32)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 08:29:11 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::8a) by MW4PR02CA0027.outlook.office365.com
 (2603:10b6:303:16d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26 via Frontend
 Transport; Tue, 25 Oct 2022 08:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.18 via Frontend Transport; Tue, 25 Oct 2022 08:29:11 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 03:29:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 03:29:09 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 03:29:07 -0500
From: Yifan Zha <Yifan.Zha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Skip program gfxhub_v3_0_3 system aperture
 registers under SRIOV
Date: Tue, 25 Oct 2022 16:28:25 +0800
Message-ID: <20221025082824.1509079-1-Yifan.Zha@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|CY5PR12MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: 528661d3-0a3e-453b-e1ed-08dab662fe29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDxDZDSzRy1ex1rVrAYK8LvvJjviRlZuELwLr+kxDLaZygU+7bH/HYcZu19H49tlgGl0xsI9T3YjDUufk80gq7j4PYQ7XEfjcvd1NzKl0oKp7jmTBhI92aPkUXv5A9fsUVCythEDK4K8pkVU2G0JcMTbr13BDNDVdlVchq8vsAGRj1swKV3/WQRLOe+LtFHwuXes/3vIxueKmQRJ6VjuHbh5X0OGW5QtvqNuXowfSDo/golK3lushe9BqEaJdblDJtmvCx5IqU2k/aYtLx86oox564QjmnQdWFRIPhtMX0VcGaHvc33pFIn8ESfYNSvWAbca4JfQab/0XxDXR7MJdl5w4npnXoG/RXoeNXMxFRXLYXCqj6U6pbyO6MNGvDyN7htRNnrigV7u3bS62Ng+w0o6Z7OLk28DPu7cx8b4JivIgKUYAhrzzsNbAPRl9ltKrdWzprq1rolabVvTIra9YYuVJJxiG9B7/y7Y/Fa8IsaEXtR4UuzIbYuvkc7urhqKPzM9qTZ+jVPwfPv5w1nJ5brc5tcqMAJMNFzxyzNC3VFYKSec6IQ6hoH9gIb5POe8vUvLqPjsSazakcf39TTM5ch9luHnc12I+B/huRcE4N2frjB9pYsPu7USpoDRcpYfLa7ge+5lnhIxrW8qZRJ47PHyu+vZi7QGgSwxumdm3Ii3gUvNj4pS4Mjd/vVtq/uzBh75P1jcilmhscBJrHHNDvL0aLBfptZqeyoPsSkHB1cNH0h05JZxwagvWFpSL45vl1UBTDwOusrE2JkJicP/8t7UBzapBWjV1ZI3owdwgOytbZL6mZ2mrRJyCTEPXnF+LYmoCFzrpLwYWG+TUnKUUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(40460700003)(86362001)(36860700001)(8676002)(316002)(40480700001)(356005)(36756003)(70206006)(4326008)(70586007)(110136005)(6636002)(81166007)(2906002)(426003)(2616005)(8936002)(1076003)(5660300002)(83380400001)(4744005)(47076005)(336012)(186003)(478600001)(82310400005)(54906003)(26005)(41300700001)(6666004)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 08:29:11.1992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528661d3-0a3e-453b-e1ed-08dab662fe29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
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
Cc: Horace.Chen@amd.com, haijun.chang@amd.com, Yifan Zha <Yifan.Zha@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
gfxhub_v3_0_3 system aperture registers are removed from RLCG register access range.

[How]
Skip access gfxhub_v3_0_3 system aperture registers under SRIOV VF.
These registers will be programmed on host side.

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 5d3fffd4929f..716ae6f2aefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -154,6 +154,9 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 
+	if (amdgpu_sriov_vf(adev))
+		return;
+
 	/* Disable AGP. */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
-- 
2.25.1

