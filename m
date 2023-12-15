Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 029F6C4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 20:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94C1F10EA9B;
	Fri, 15 Dec 2023 20:38:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D368110EA9B
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 20:37:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JercGXVd82RydNhzALePSV/YtmiqIZLpOrdSFgSm7PGt91MzdTJVABf2B3VcbDp0UXLcGwYpUEaMbCj6cI5R1rZj7PKygWhHbAa+0qiTtH8ZX/+KghfRibp/D+6nmP1njSaU8oXQ/iml0dTvg3GUd8br7PztFK/SDt0FPc96nE/SeY9Z+qQlHih7SW+UOiMJvaKdtmIA/9broOt7S0oiIQX/tVfcWCBwEAalG32tQXZmhQ6ugk7ZuJ/N7/2+/GWCPUXu/F5OL14nZlGM6U0OWKvD3Rbs4kbO2PIa+vYwg0brCzEtuPu+GJ3SexNJ+lnHyQWFexXdo5W92cpNb/PHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gz5ltfPeXbN3ilVBM35eDOyHQ7yOFTLlYMrY5Sc7NHM=;
 b=N1KLDkwESnqCgEukQxNCO8o0s7Ej3KpOBaad4ux5M7/1ubrIAoK3HQXMZMkzKsYSnXaD9wYC+55AwwC1DoyRWhTewGX90ygp+CapcRuxSFr8xmmQNiO2YG33WzAHaKTBL0HCs6u/tMUFN7or3GoM4Vmn8fuG00HXmwHv9yi+gcAPAs2sTW6w9WtWFVtxasuOUqJTOdO6Yd+aHWnKVlJI1IE2s1sQdzcgWUcOlAR98spEvP136HPFfNXZTaKfRKnGOJbDn/yd0tzhZ4cltBPnDDnbFCqrePOZ7axYw9dftyjJfwxwaA+x7D5nsz9nBsXuVZg5TEHHgzjY3UALak6/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gz5ltfPeXbN3ilVBM35eDOyHQ7yOFTLlYMrY5Sc7NHM=;
 b=zB1eqN90ZdWL/632qgyIUZMqPNS4CuxcenfZRkLmdFcatVhEuttwJS3BNaMWtspuOWAfz7E14Bfwd0l8BhOMbf4i9tjbR8mKDZbVa7fi0SxuDJIx/JycEG1R7Eu9lliUsO8yGyDzcoLAcWC9GmR56WLalPNH4iIIf5RZqy3En34=
Received: from CYXPR03CA0042.namprd03.prod.outlook.com (2603:10b6:930:d2::21)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Fri, 15 Dec
 2023 20:37:55 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:d2:cafe::f6) by CYXPR03CA0042.outlook.office365.com
 (2603:10b6:930:d2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 20:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 20:37:55 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 14:37:53 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd: Add missing definitions for
 `SMU_MAX_LEVELS_VDDGFX`
Date: Fri, 15 Dec 2023 14:37:45 -0600
Message-ID: <20231215203745.21874-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: cfbab354-b0ae-458c-845a-08dbfdadb7a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pp8vhR2q++rrtUO8aRVho5bsfY1zICgGF2nZsUcbJEXtwemflCRraq3lj6jqbZkFKab8nZqQH7Yc7Oaa6D1OetW1NOxhN6nR5mfGzgkYlWJGS7Chy/A+TE7aWNY3zoT3p77SjyxlvX4GGc7kKnmj0s0GtIdbtw8hB3GL4SzWOPgu1NyHKmv8AE6TrkL47bEL4aTQmjaAu1Tw+asaD/vlye47rotiZaFqtPRZTthBzanY+HnwCgAqOpDf6QNzxDq66EnggWjvitmhVgxJ6pZFm8TnVuJ5rkmvN6LaiMWFLtkNqDJRIEpgGEuOc1L+MV+LpIypVZub6JWLBS64FF07ctMucSPN3Imrk7k54gsHWtnMLOeMrKuG3xu8a78TN1/WHxgsenFb8ZOIAmPiQAS2Bmi3U0BCjACVT9RlZ7SDTIkf4dQfTEx3Ja8GcsuNCpzhcQ7WQE/sYb3GjIphlfVYERQNnU9BGZ24WLo+Or3F/ATIW0Kgk+nIozyG5tYHtB6Assn85TaJVwAsCHpANL8mDtqXftUgzOmtrjnQnYs+WwpeqVxA+FqejJP6NFhogDyblaag8ZO9JiJOElLofm3dbSrQgypGPYg/CPC+nGgiSGuDThjQX8Z9zsU0Gu5QWrkv11HVBCi3Xcp3yF/yIUcOrQI4RoHbf+uFa4eSjE6pTNlVJ7C3o8hM7q4mgtq3F/nL8gEDWs01C5Wx2dmSnqUBaieMdaiJ1oStBfg2YsOuMP+4lMIfUK6ecrA99otk3n7+OkkhjynlcJPLA13FFVpAFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(36860700001)(47076005)(81166007)(356005)(82740400003)(2906002)(36756003)(5660300002)(336012)(6666004)(426003)(16526019)(1076003)(7696005)(26005)(2616005)(478600001)(6916009)(70206006)(966005)(70586007)(41300700001)(86362001)(4326008)(8676002)(8936002)(316002)(44832011)(81973001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 20:37:55.4014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbab354-b0ae-458c-845a-08dbfdadb7a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746
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

It is reported that on a Topaz dGPU the kernel emits:
	amdgpu: can't get the mac of 5

This is because there is no definition for max levels of VDDGFX
declared for SMU71 or SMU7. The correct definition is VDDC so
use this.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3049
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * s/VDDGFX/VDDC/
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c      | 2 ++
 drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index 9e4228232f02..afe5e18f28db 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -2303,6 +2303,8 @@ static uint32_t ci_get_mac_definition(uint32_t value)
 		return SMU7_MAX_LEVELS_VDDCI;
 	case SMU_MAX_LEVELS_MVDD:
 		return SMU7_MAX_LEVELS_MVDD;
+	case SMU_MAX_LEVELS_VDDGFX:
+		return SMU7_MAX_LEVELS_VDDC;
 	}
 
 	pr_debug("can't get the mac of %x\n", value);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
index 97d9802fe673..b4b2a3c96679 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/iceland_smumgr.c
@@ -2268,6 +2268,8 @@ static uint32_t iceland_get_mac_definition(uint32_t value)
 		return SMU71_MAX_LEVELS_VDDCI;
 	case SMU_MAX_LEVELS_MVDD:
 		return SMU71_MAX_LEVELS_MVDD;
+	case SMU_MAX_LEVELS_VDDGFX:
+		return SMU71_MAX_LEVELS_VDDC;
 	}
 
 	pr_warn("can't get the mac of %x\n", value);
-- 
2.34.1

