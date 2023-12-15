Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FBEFC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 03:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E870610E300;
	Fri, 15 Dec 2023 03:44:24 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0560D10E300
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 03:44:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iz59If4/5xQrN2BQ3VCONTwGcdxAkV0hDXH+fh0I391/wtTYY8fmalSfRk/4vi1vbVfS9r9UDe8etIWRCceiy+xoKYeWCgTttQkwbryteyiq5vUOlE9pzjvD9otPFU2cwckeEmagDQ/2C7IZvP+baau5VkD+cwRB9oLBHnHe/1hfxk4LUDCiOlwnrnLpPEKaEnWbU9JBMiE3C2xiRdPcX5eG6e7HpE4AZlLVVktBM/DD64+a4u+PdkTPYoDxY6UhvvpqGiWF6sZXD4rnQgBagnaJetqqh/Mvgh8fm9ckzmOOHg4VnUzl3h+rmQdwG9SxZeVJ4YyNolZOD/SmVdDEWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXgm4PIvUdHsQDi+fYgCEx4+mty4y0r3i+XDJg3r3Ls=;
 b=LkMXpEUcJ3C2e2G6szlzLSi8s7FVR/iKGq1hfP+kik2Grppd77Ed/YSLtpwPqBJapQ79lzsHBU1inTDTcy+EEZCO8npTSmp2By2sSrCQTnkyo+gcVNWMCN0bokdndfcNX7zbgIqMpdtMcUFQlYuDzq0V+dM2tCZF5xPzyu7hFDr8jtvmxwLvMO7cVnlct1kIBBUvt6xbY6c0C2tIEPwLqXZcVGN6LlE+v1Y3pBQxxHFvEU9gl6qSArQ49cPnjOsxk7B1HbY3xJ0DzJObSL6riWuNB5F0/jf/HzcQrTRQ4k3wdj1316Kxi0+4rzhi5BIzrYk+bUXw8E7WLHMV6L/w+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXgm4PIvUdHsQDi+fYgCEx4+mty4y0r3i+XDJg3r3Ls=;
 b=nzMahsB7cvmlHlYUKtDdbbHORwANlcKKXWAURwwTWKWSeylVp8g3TKBTUB/35oe1ApHN9xh8Nje9m4Xgm2rQcEXoPA8pEp64F+8F42f/bn0+YFeNLyc+h1Pntq8Jq1wUTLwV91nJGkfRHKu4FbCGWwvLkmc95V65QHrA7B5jb4o=
Received: from SJ0PR13CA0101.namprd13.prod.outlook.com (2603:10b6:a03:2c5::16)
 by DM6PR12MB4387.namprd12.prod.outlook.com (2603:10b6:5:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 03:44:20 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::45) by SJ0PR13CA0101.outlook.office365.com
 (2603:10b6:a03:2c5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.9 via Frontend
 Transport; Fri, 15 Dec 2023 03:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Fri, 15 Dec 2023 03:44:19 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 14 Dec
 2023 21:44:17 -0600
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/swsmu: remove duplicate definition of smu v14_0_0
 driver if version
Date: Fri, 15 Dec 2023 11:44:08 +0800
Message-ID: <20231215034408.2217732-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|DM6PR12MB4387:EE_
X-MS-Office365-Filtering-Correlation-Id: e93f1af2-bc70-408e-1208-08dbfd201eca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HiSeg8sqM8+ej6wULm7ZXtW2YnLpHoDoLnYMfqZBdMKueyKKYqYF8HuNLgH9fAQtSMNH07PR7p3u34ZnQZsyY5wM/FmlXAszp8FCOT//WXKhZwssBQeExWxFjKhGCgP1tFwJ23Xd6LMAnP1g22POUudDI41/sxT3Aor3CiTkvnfbNCY6sMa4JEjEJyhXM6SkDBDyHKM8r3rbfNF7fAjxKsCyD1BPfmhiKyDPIg2wd6UD7fBBwrwUiqa8cSPMnOOzj8SyAYAvw/7KCQtWGTxw+RDneANO1tCxmGsxvmXx7ukldIv67FFgdGYJVOYSNE0vSUyfzXTpjV90AYTijmfBT/JjUkdBMmRtLd4TBIj4oD86sdnWg5XhS5VOEjDjmaOD6c8Dk4sZ/cstPgxwSm2jJh2zySMFBl0PMc2mkJlXvdEIGxJ2ZzeZdRjPfoX0bb1Xfg9sA1klRs3N1x0BGvRtxwrDAfxYcGcK+Si1vQwo2TA/pmjFGbOKuJip7QiZwynfS10y62rSo6ZF9rpkw5pJT5E4yFAEwqFyqiNi1Aphvx/yoJ2LSdB2IpfcompJncMJYvAlBJvbvQxujz+oik1oef3S5E52bIJW9ACbVnXMYqhWqI9uZxjw8MVbZOibrMM8U1NkOvnOds+TKNmtFnnJMr1mnLitKevckHfS4zEbEiUVjyy8504pGzo8EVJFj/4XKhu6itZAqsjZvfFZ8hr6KzvD+VZ/92zioe+j+B3Pj22rXNwXlU6+78Nm7B+xoVfSVpiwRBA97aSPY5sRHlOGLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(44832011)(5660300002)(40480700001)(6666004)(478600001)(2906002)(82740400003)(356005)(7696005)(26005)(2616005)(81166007)(16526019)(86362001)(40460700003)(36756003)(1076003)(70586007)(54906003)(316002)(6916009)(70206006)(4326008)(8676002)(8936002)(41300700001)(426003)(336012)(83380400001)(36860700001)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 03:44:19.8991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e93f1af2-bc70-408e-1208-08dbfd201eca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4387
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
Cc: alexander.deucher@amd.com, yifan1.zhang@amd.com, kenneth.feng@amd.com,
 lang.yu@amd.com, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There is a repeated define of smu v14_0_0 driver if version, so delete
one in driver if header.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h   | 5 -----
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h                 | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 8f42771e1f0a..5bb7a63c0602 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -24,11 +24,6 @@
 #ifndef SMU14_DRIVER_IF_V14_0_0_H
 #define SMU14_DRIVER_IF_V14_0_0_H
 
-// *** IMPORTANT ***
-// SMU TEAM: Always increment the interface version if
-// any structure is changed in this file
-#define PMFW_DRIVER_IF_VERSION 7
-
 typedef struct {
   int32_t value;
   uint32_t numFractionalBits;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index a5b569976f19..3f7463c1c1a9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -26,8 +26,8 @@
 #include "amdgpu_smu.h"
 
 #define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x7
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x1
-#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x6
 
 #define FEATURE_MASK(feature) (1ULL << feature)
 
-- 
2.25.1

