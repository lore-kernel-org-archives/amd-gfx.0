Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31999C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Nov 2021 22:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89D1689F1B;
	Mon, 22 Nov 2021 22:25:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2080.outbound.protection.outlook.com [40.107.212.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B43689E33
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Nov 2021 22:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkdT+pR7gqEsVC+K+6wc0ZDBd8lfNNzGgAVWt2C9cSoroHX92jjloAXaevbwJGSlhOvuQH++9qcSH8Mj5W8YB96EEjMX86WgfGMJHQyTZ70e2rgoiJlUl4WF2N6EDmgG+eVjcRFSwP/KFHNlwdVCJmKib/ru40kiWAvFcB88qP6N76J5jUIybRESzKUFpbW5+rZv8/PO1TLmq60fGsiNLR2ERnTIUby2hXqEyZNDNkpaQo3ahO12ojL2cQAJyN8rLwXOfnJzl5uPpNV5KNHeYQnGpA77K/Uxl20R7BhaYwxzQUAJNXyXXje4zWxVjBD8x+UQjR/+CCZe2zooEBztzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pQtppwVwXhZPLET694lpmomamUOFJ/7LKUEPCNe9igw=;
 b=BnKDmo+1/LjYlpoe1/RPbyEi6I776QTBgz0250A6syA7xjAvFjZEpT4dkLhZGTDdlzr9+9c2HIUMpae98SmYqcsN086AWWZKWIelCH9CevORnRtrUCT0Tfw/bJDWaJ7cyDqnahk/0EWKtRvLQsJIM55DOEE42Lc4t9Hjun+JOjIOSh2l8u0HYpaoBVqUMkx/fuUIoYr9DPBCu6W7o2NEZqnkGu5872ew3KAom1aA7jggNhEDoAqala7Fduh3vSqW1aDa/DiBagZeJi4SW1NEnkbXAbHOCr/7Sa/MjieeNWfZgJkxEJ7inNj7l569swGgAguk3LnbZv5NQU8XaTxoBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQtppwVwXhZPLET694lpmomamUOFJ/7LKUEPCNe9igw=;
 b=cdwy/rBmI4p7bSceb1qWTpPEG5oQDxW3ihnWhSaE4XIxTB4IwwazEWuncxClCc4W94KQs6h9h3N28GwS+tM26vmlMjgMGhsdqewQp4yuAK+cWOPwGJU4ojd2w/wIcwU+fuFNxw6TmujNABOwpoSucfaWRZtB0v0n6hNUaB6Ia6g=
Received: from BN9PR03CA0902.namprd03.prod.outlook.com (2603:10b6:408:107::7)
 by CY4PR1201MB0087.namprd12.prod.outlook.com (2603:10b6:910:1b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Mon, 22 Nov
 2021 22:25:34 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::56) by BN9PR03CA0902.outlook.office365.com
 (2603:10b6:408:107::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Mon, 22 Nov 2021 22:25:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Mon, 22 Nov 2021 22:25:33 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 22 Nov
 2021 16:25:32 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: Add debug prints
Date: Mon, 22 Nov 2021 17:25:10 -0500
Message-ID: <20211122222512.58886-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4f34012-6071-4911-92f3-08d9ae070002
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0087:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0087F8012827029C24E75B62999F9@CY4PR1201MB0087.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+fN10ag06cBp0lSIWYvgqCYBXCAHdD+KQirBeHOoYFm2GXh5/2bRuj62446R2c8jS11gXjCvbdmuXeNQ6y03vMV2hTlPHBLvyLylyMXE261JpN8fze4CgjETXD3F7ztU8L9khLfErrzpdL5H5skMHQ7y6CzbFplZRdRug7+y9alYqHHazjdtzu17+dm6il0VnHn8K9IMf76uN92IDyZiaD4aoisOR6iYOycy+edcKkXWJvbs7ogcjsYW1EFo3WCIKG1VWiCzm3nZ+/jnygy2ty6MLjRSfRPYhkXUk8gHVWQ3b6tpCO1hGpao1C0n3Epijd2mAY7IpAYdvNKNk+zYiOqrQoUSL/XBy2CylCzcSRyJ5qjWjoLnpFZkg3DiGOffAEWdg8Iamb+Q3WJjfmoN23M29OfrFQqQ11WcXdq4cORhk2tg318NDbFHImTFzXPS6QK6MvoyyTrph/+TtOxTtnVYv6fUUC7gGoJrwPYZfoEaP686uoEmhZP5HjvOhK/k9WR0bVhjOs4ji6l0hhiSTuSA9KihSrh+5b6HEa2jUznFrHr6N5sDQmi4Cv32ptHexRbdG7zhwrIkPf+aMPAOKQa18WbHplCJF8FKvLGSXgfDvr1V9/oNDj2sp4TndHwRnaPNGIt0fpFTMQu9A8QZb+w/i5lC31jZ2u99UZzjfwJoN1+VQJqlrB2OE5nJ/BRgmNHNMIFiY2NS7ljBenPJj4PXXrmye+l6fNKHhhqUzw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(336012)(4326008)(426003)(44832011)(81166007)(2616005)(16526019)(508600001)(6666004)(26005)(2906002)(356005)(7696005)(186003)(5660300002)(82310400003)(36756003)(1076003)(47076005)(316002)(54906003)(8936002)(36860700001)(86362001)(8676002)(70206006)(83380400001)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 22:25:33.7358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f34012-6071-4911-92f3-08d9ae070002
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0087
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add prints where there are none and none are printed in the callee.

Remove the word "previous" from comment and print to make it shorter and
avoid confusion in various prints.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 8 +++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c    | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index f5e739d40b0467..e156add7b5609f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1153,6 +1153,8 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 		case IP_VERSION(11, 5, 0):
 		case IP_VERSION(11, 0, 12):
 			ret = smu_system_features_control(smu, true);
+			if (ret)
+				dev_err(adev->dev, "Failed system features control!\n");
 			break;
 		default:
 			break;
@@ -1277,8 +1279,10 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	}
 
 	ret = smu_notify_display_change(smu);
-	if (ret)
+	if (ret) {
+		dev_err(adev->dev, "Failed to notify display change!\n");
 		return ret;
+	}
 
 	/*
 	 * Set min deep sleep dce fclk with bootup value from vbios via
@@ -1286,8 +1290,6 @@ static int smu_smc_hw_setup(struct smu_context *smu)
 	 */
 	ret = smu_set_min_dcef_deep_sleep(smu,
 					  smu->smu_table.boot_values.dcefclk / 100);
-	if (ret)
-		return ret;
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index ea6f50c08c5f3b..f9a42a07eeaebf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -97,7 +97,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
  * smu: a pointer to SMU context
  *
  * Returns the status of the SMU, which could be,
- *    0, the SMU is busy with your previous command;
+ *    0, the SMU is busy with your command;
  *    1, execution status: success, execution result: success;
  * 0xFF, execution status: success, execution result: failure;
  * 0xFE, unknown command;
@@ -143,7 +143,7 @@ static void __smu_cmn_reg_print_error(struct smu_context *smu,
 		u32 msg_idx = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_66);
 		u32 prm     = RREG32_SOC15(MP1, 0, mmMP1_SMN_C2PMSG_82);
 		dev_err_ratelimited(adev->dev,
-				    "SMU: I'm not done with your previous command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
+				    "SMU: I'm not done with your command: SMN_C2PMSG_66:0x%08X SMN_C2PMSG_82:0x%08X",
 				    msg_idx, prm);
 	}
 		break;

base-commit: 1dbfd7295d5cf91be6f37b4d0241b371e5f5b4f3
-- 
2.34.0

