Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092B8C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D02510E6F7;
	Wed, 13 Dec 2023 06:14:23 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E5D810E6F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQnI4mS/2Bo8v0U0oP8DkYECI4N67PQ0lrDxZY7RucqmcSeaTB0+UkT/j9SQ8d75J0lMdmJ01Rpp+EeWOtaAbVq4MzdEzfW5GRQ9LacGTE94+MEA+siapoZoyQQPLAFgID7jH7YEsJJZvVM/APvkI5TYBawrxo6NzDyHD3waoqfTNXnXms/mDxjt/HBCw0OnwHT44l4K989QM3BIKPnyROI6oPsMzcD2gkzqasQz22Q7PyuThxg8y/4ZkOA2IFgSnYGLQtZRs2gOFOs31BtNPhwDabtVBnQgjsmBfHJul9atwyFCGkrwivEu3MJ1YTExfpb5KUNFFI1w1mL89qdvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lf5k7kHp5Jr+9BoX5QrAH1Akmei/pGF1NSwm/JPxkAc=;
 b=ZpmnjZHawqGZFkQRsRs2GGXNbEb8/ER/m/Mp9NOZOxpdzjvNQCeMOC4Z2aHrHLADtk40iWSw0ew/2k02YzVOCl8Ydol8pDfk4yX2Xvs0Go/sbGamCusKkwq233kfoBpNL03RCgSAiN/gNNs+KTIJGHF4kHUo41Uj+niLcpDoHZcFk7zvmT9BppUOiG8GzO2RbKWFSAjP4U3bGkUeYDrQHSby73VedL/nsJXzizkqAuKhZW+adoU05rpRcGqOgwT7xD4fB+tkYZtRKCWqLYP3jnHxO5U/jlAj1i78bsTrHKtFp1eNswzefTRAZxgwY2iUJtEJkdu0xio+8vMafHup/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lf5k7kHp5Jr+9BoX5QrAH1Akmei/pGF1NSwm/JPxkAc=;
 b=PgYwziCTN4bM82SDpw+RjMOowcAKjKK6PuSwyNEdjaTODICuRqq8Li0QiGGRO6601t+RbhOuOg2A0NXAzBJXE2kQiLi8033WvMDOW1+Stw9j8cmB89Stm9NoTEFiF73tFe29IyiyzA6fobG0m2fmWZhOvYrZIErugRkokXKaoF8=
Received: from MW2PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:302:1::42)
 by PH7PR12MB7915.namprd12.prod.outlook.com (2603:10b6:510:27c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 06:14:17 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:302:1:cafe::97) by MW2PR2101CA0029.outlook.office365.com
 (2603:10b6:302:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.6 via Frontend
 Transport; Wed, 13 Dec 2023 06:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Wed, 13 Dec 2023 06:14:16 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:14:15 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:14:11 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/25] drm/amd/display: enable dcn35 idle power optimization
Date: Wed, 13 Dec 2023 14:12:16 +0800
Message-ID: <20231213061227.1750663-15-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: c786ddfe-38ed-4169-c92a-08dbfba2bc9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CM3c6JYm9IXwMqpYZeDjaFUKl5GRKCj8W4As8GlNVut26N6RlpONzO/lIvBMDg/BcuC03kYhkgoTveIrnBMbVcWt3hW7ArOJw8fYVS4qNa/wzP1oCFoGLQPBBBzdnuInbJHiJbRYqGhTxhd8b74VPCtmWGCy/0wO3k95kKbvXmtQ+JollBNi6aBAZNB5Erz9mBo5ZuZYzQkO6TuV8UsZg4uQl3G8Hk2ofKbjnjKXGcV/nPQdBb7fdIscPtNCfvmx+MGno4YvgxDBjLfFS3b294G8OoOfq/tQQBfXL04QfXp+4jcZa0eG71tJjnyuAKMKofhj5bpiQrP6ViQHnDOrD1qFtuPD+KMlaKpFWvIMAi78SQKcgOOTg1UH0lh5pQ9j92b6QQDhYaIK8xkMiLDVuOSXU+5kDwPdnbSybSTP0YKTsRtLhOzJd9p6ektRsohJndOVo2nveEFhnJ+SF7rOSgpBSBkV2S2TjMeWJb71Zj/wJZ44ecb7qoRS6Qy65QflCeOB80A6qrzVZzwSjE+IcNonICPKOH2IMLav3zDtFDwpFUTdyWAbtxzdeuPKc8yXgRRGUsH/ZIynPWznF1DGmBd3aP/rdjihEB8nRNNWi1PfnVfHKfhqCfIlU2SM+oRcOrf1QOL2gPA75rRHpFrw22VZk5nKfx+Ct1Ztt31FjaBHSfxY1+w75pjleQT3UZk1eYK5XBL6RiGwLvOqLLnMMqbSmm4wADlmjA0Y+3WPdsVMNQmvNkoJOW4iZMBNAm2ZaUUg61qMxzMXsdgjCw3ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(1800799012)(451199024)(186009)(46966006)(40470700004)(36840700001)(5660300002)(40480700001)(2906002)(40460700003)(4326008)(7696005)(41300700001)(8936002)(8676002)(81166007)(86362001)(36756003)(316002)(82740400003)(478600001)(356005)(83380400001)(47076005)(70206006)(6916009)(36860700001)(2616005)(26005)(54906003)(336012)(70586007)(1076003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:14:16.9094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c786ddfe-38ed-4169-c92a-08dbfba2bc9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7915
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <roman.li@amd.com>

[Why]
Idle power optimization was disabled on dcn35 by default.

[How]
Enable by setting disable_idle_power_optimizations to false.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 4e1db842b98c..04225cdc1904 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -766,7 +766,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.enable_hpo_pg_support = false,
 	.enable_legacy_fast_update = true,
 	.enable_single_display_2to1_odm_policy = false,
-	.disable_idle_power_optimizations = true,
+	.disable_idle_power_optimizations = false,
 	.dmcub_emulation = false,
 	.disable_boot_optimizations = false,
 	.disable_unbounded_requesting = false,
-- 
2.37.3

