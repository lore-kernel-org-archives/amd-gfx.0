Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7125CCDB482
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Oct 2023 19:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA2410E638;
	Fri, 13 Oct 2023 19:26:45 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::628])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF64110E605
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Oct 2023 19:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hyEvl1jiHUtwmPRWA0YjS8HsJeVd61Bv+e572+3aQ+TpJFb42RSLbKS8CpVgzYgrzb05TiIXVkHeiz+oASD3mOj6IERTE0jGdb/ApYpPt5hr72Ez6joQLd1t23enFS5xWHo1hrg3dBjotcoCBy1+kW1dkqpGrwuo2eyQOogXabEZ7HeEEJF7/+5IUiGPLWp4GIwE/0Rv6+qhmXlE7Mm4EtNdSM93gz0EHQqJBalNx+B+FW0FU8w35eAuK7xC5ZyyvBge/oeg3sYiiDcMyPJV95iElT0cWqJm1MzII9fSQ+ZK8Zr8skswde/vb8WrprilexZhwk+dwe+uvI4o/vxM2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cS+ap3QMC1GLDPMecfIEKr2ifqixZXBK5sRzGDWVlc=;
 b=PvXFsiOgSYkmLRZJw0/A6M4J5UAeJ5JbHoPxiQeCnryannCyEqYC4cV0I+sFr+i1Y2tkszTBqckdcypL74WE1OCXFs5foS7Nd+MvPvrXbKhz9cfq5tFJIkJDPsOIC5wzQB22G+v1zGn3D+HX5Zaql/Qwc+uLU8CORZReG720PMvWRoKMbViJ1y9Qw1zk+ltYIA/DD1IvO2pisT4hNI/EDJeNyo5q9KU5uNJcjWhOOIph3VQOPgV5juslUs7sGlngJI2ak2gpGo5gv9ubzRT1aooEo1eGlg30+FjcemG+kMpLO0Tt6pJwpUyks/UXQKPQ1iB4SLsdWDYWkgHuIQYfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+cS+ap3QMC1GLDPMecfIEKr2ifqixZXBK5sRzGDWVlc=;
 b=jfJqjdWcUKbzXaKO2uUEyLgAAz0/1A9uEGlhDsYjv3w24QyN3gCV/Y2UKkgVvzOLeNbl14MO/FvOSBhdaFADZELj4D4B2fWoqJaJBsCtB7FbsxFTSToYvwuEySURDqp8YRpxFld1QUwSZDdgq67jjJm6bbmFoIdbiiqJGRkxl54=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 19:26:39 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::b4) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Fri, 13 Oct 2023 19:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 19:26:39 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 14:26:38 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd: Read IMU FW version from scratch register during
 hw_init
Date: Fri, 13 Oct 2023 14:26:04 -0500
Message-ID: <20231013192604.200515-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013192604.200515-1-mario.limonciello@amd.com>
References: <20231013192604.200515-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1c5779-a9e8-44a0-1b80-08dbcc2252db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yI/gozyjwpvABFGr3uqHCT7NTVU8vgCxcoL6jBJ9jFXagFfiuRZrubO7DsP9P2sSI6yIJdJJttgvGr/OTVh2HqP4EtZeuwRtJjygP5bypjYzAEDI1odJKlnZy5XSFPUKEn1z8oJhAlns2ym8jTKOPunoSC0zdPiFPjnvhcT777soi0WoXfMaX9gRqPCA9x50XCNMZfVuqWpv3bQOfLnFatOsq/QQOk8bEPu1mc/ZGiNNegKKCwxpbkVAx5xL07+FTKpY4NfoQikKim2ppwytEhZDPRAM6hgCcoIUkr8OwKb8a8MkRl4Nt8nLfTPoa943pijBwNQL6S1sukwIMPx87neD2jHvNvDGqo2r/ETduvDXfVW1k/Oo8lH5jE605stntkJWQYkjMP9s4GCY2rdO6QHN8HVGHSP9NMIWfXoqsy+Ggoor12zHKYiw7qKBkSjPIRyi0vAxdgnIdUL0nJhrHj8xljw7d15Y/EWi5q9ubnHH4NlDSKXlSihoiuyawPW6l6nguNiix+8GArJ4wfm0DzzJqK1vqw3xUYF/sqFS2rciM0Pv/JBHv81ju4OXvQ7DHw5sjhKVo/6E6f8RnDRj7DAfj15lw1UAwpdGh15L8yFntC+XSq63XpPN0wiNd1/4Kif5qjaXZY+N1VD2BoBrlvx2/YKidIJJ3Ad4yMDn7j0viDb3t90Jbl676xuMsTHBF0I/d0KECNxEl5bdn19sPNLwHuK5VdDbWg2ckNW9SMEQ0lgjq5t61/ygH2IAAYZbh7/KEUq07Z1hPA6qnqphow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(1076003)(40460700003)(86362001)(26005)(36756003)(426003)(36860700001)(81166007)(82740400003)(8936002)(16526019)(44832011)(47076005)(336012)(4744005)(6666004)(70586007)(356005)(2616005)(7696005)(478600001)(6916009)(8676002)(4326008)(41300700001)(5660300002)(316002)(2906002)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 19:26:39.3477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1c5779-a9e8-44a0-1b80-08dbcc2252db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If the IMU version wasn't discovered from the header, such as when
the firmware was directly loaded by PSP then there is no firmware
version to show to userspace from sysfs or IOCTL.

The IMU F/W stores the version in the first scratch register though,
so fetch it in these cases to let the driver export.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f0957d060750..154b20492123 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -4373,6 +4373,10 @@ static int gfx_v11_0_hw_init(void *handle)
 	if (r)
 		return r;
 
+	/* get IMU version from HW if it's not set */
+	if (!adev->gfx.imu_fw_version)
+		adev->gfx.imu_fw_version = RREG32_SOC15(GC, 0, regGFX_IMU_SCRATCH_0);
+
 	return r;
 }
 
-- 
2.34.1

