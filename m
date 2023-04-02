Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 970F4C7619A
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Apr 2023 22:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF0310E106;
	Sun,  2 Apr 2023 22:08:52 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C83510E106
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Apr 2023 22:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPkZiRYluoIx/ca9fYfJRka6Tth6s4kKT3MLeACMAUOekVFM8Tbx1Xr3/ZC4ADAdwA2IAah/sK02FH8AT7UE9DpPT6WX7CCPG5GG6bqQbsoAtKerdneJeuxrrD4nPhKYQatW0DVAiFtPNutRPiw4AdqijPz5bCyI2GRvxEg57xep3LsRXTszj9VQMkUw1F+cmarK/fBSO0t4Ca88wSIJmin7IgeCmfpS5QoOPihp+d3AVtz7u8oYwPK3WeNFfwh2BO2IfesHrefBTbFAwPmuhCWt7r2xIdncoynfSN/Uz/Zt76k6PTSk+8pxUHGi77PJBTm51Q7/+5cJWiCLazaO1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3gA1cRT/zTE5hCLeLLq6g5Buo9ojt6Trbh2vqdy6NQ=;
 b=TRjmQ9BgBft5zRuT1ibEFpF4gAkLWv8r93eupdDUtIiqp8nVjXU8YiJBiXZ7+ODyHdyWtC/pIe5q+EgReEAYvh3zg2b6g/+3T2JZoiSYZK7eknepffLGokC3W8livlRbwsC96OxNGlEr25ryW/RVe1gl0WcX1ppq10/M/Et2bMzy4sCKzWqtdZo1k5GO1ntCTtWCQnWPTFeNxWIdxN58QTe3nnEZan5W5phx8XCWPPveD7QJlLufoDcwwKQ47ZDBVkvYL68RPjvx23iEhuQNvYobLAzsy7LQjjJfERNbMBHg4McKM2XK6GZhwH6Jo21ZRWQIgKI2nwVJWH5WvgKn5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3gA1cRT/zTE5hCLeLLq6g5Buo9ojt6Trbh2vqdy6NQ=;
 b=XQwXl1GbK9mxzfQJo7jdkXUL/LjBr9jJ300THwUKPmNiy7bUTRH4DT9kQpVlv+PXX5F6VYehReJ81kk7qhVKvHmTFN8RFZH365pa5qHHl7LFXyEpbUrY4JfdflVrY2rGiY0DphMzEPwFoUMKpzTCAGn4uDzMYZxVEzqGM0SW38w=
Received: from MW4PR03CA0346.namprd03.prod.outlook.com (2603:10b6:303:dc::21)
 by SJ2PR12MB8831.namprd12.prod.outlook.com (2603:10b6:a03:4d0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Sun, 2 Apr
 2023 22:08:46 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::3c) by MW4PR03CA0346.outlook.office365.com
 (2603:10b6:303:dc::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Sun, 2 Apr 2023 22:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.16 via Frontend Transport; Sun, 2 Apr 2023 22:08:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 2 Apr
 2023 17:08:44 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Fix an out of bounds error in BIOS parser
Date: Sun, 2 Apr 2023 17:08:32 -0500
Message-ID: <20230402220832.17792-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT061:EE_|SJ2PR12MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e263d5-6b5d-4d7e-1a13-08db33c6d3ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 69eT4oSfgac2WAwS4xzuzseGAFlckqCutDOip997+/Vx+toc0Hw8e1NrOKkdvdQDHG1+pTp36A1KeEpLRr4Nc0DGiK3PY/SjkBOxIdRE1nZ3N8WUj0WyLZAZdnKvxS+e39l60rKt0GvKJ7zxJolO3+ZnT7jNX8w+vJgFXnI55PkkZPPgc/6QAMa54/rg5o+gMbH25V9gZUIfn0vAPPbDS3V+mTdrUKBAZgNTfXBzKR4RpG7wFIllqMJb2Ym7rJdpE0n1pYfYHRsn8utl2tbreaCu93Kibvq19Bvm5B/MZr7yIFM1/ulzH3o6TyTk/bmj2OLo4aCnu7iFaQg6ddrvPZiAxUR+LS4796ql8qSdAb5vYCgIdyOwly+chY36M1VVh/NLAL6z1u+X6jdpikQoDnkROdDonpyx09x8N5YXpbTSi+CTeMbj+bUMSrVZIO0kjdn+y1K++rnRfyAaUDWm8+1M1wk7sb+M1V9im52MFudhDT3RYnkFwUOF8Sm6MJjcRM8+k1MJ4QCalM+Mk72zKc3nvQlyEF4aisAw+E2cO/qfur4Twp8b9Z/8G0j/njjtyZgcwxnAmrBUsjUB0TMfmAC0z75t6hEPIVDBDcBPhQY0Tz6PGhsmRUqjpDX0xN+ZUkDDTSrto7eea3FmSR3q9+8VIHYayx841lLsgdsP/mD10MoHAu3GllZvvHM4/WUa/XIV70LMOufXsWXBIe3rtkqn1MDTQ5GH8nHEK4HZwtw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(478600001)(2906002)(2616005)(40480700001)(16526019)(186003)(1076003)(6666004)(36756003)(7696005)(336012)(426003)(83380400001)(40460700003)(966005)(26005)(356005)(81166007)(8936002)(86362001)(316002)(5660300002)(41300700001)(82310400005)(4326008)(82740400003)(6916009)(70586007)(8676002)(70206006)(36860700001)(54906003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2023 22:08:45.4746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e263d5-6b5d-4d7e-1a13-08db33c6d3ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8831
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
Cc: erhard_f@mailbox.org, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The array is hardcoded to 8 in atomfirmware.h, but firmware provides
a bigger one sometimes. Deferencing the larger array causes an out
of bounds error.

commit 4fc1ba4aa589 ("drm/amd/display: fix array index out of bound error
in bios parser") fixed some of this, but there are two other cases
not covered by it.  Fix those as well.

Reported-by: erhard_f@mailbox.org
Link: https://bugzilla.kernel.org/show_bug.cgi?id=214853
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2473
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index e381de2429fa..ae3783a7d7f4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -515,11 +515,8 @@ static enum bp_result get_gpio_i2c_info(
 	info->i2c_slave_address = record->i2c_slave_addr;
 
 	/* TODO: check how to get register offset for en, Y, etc. */
-	info->gpio_info.clk_a_register_index =
-			le16_to_cpu(
-			header->gpio_pin[table_index].data_a_reg_index);
-	info->gpio_info.clk_a_shift =
-			header->gpio_pin[table_index].gpio_bitshift;
+	info->gpio_info.clk_a_register_index = le16_to_cpu(pin->data_a_reg_index);
+	info->gpio_info.clk_a_shift = pin->gpio_bitshift;
 
 	return BP_RESULT_OK;
 }
-- 
2.34.1

