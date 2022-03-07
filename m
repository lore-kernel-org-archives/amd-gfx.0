Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1ADBC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:51:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC4210ED5B;
	Mon,  7 Mar 2022 05:51:40 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C97F10ED64
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:51:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvAO88kS61aENvLIkhhZFU54Rn8lRZJNDV5sLZHFv+v7mYnHXro/QxuR72oTxG5qPKnwf9YCvfQ4inOPm1SWuEcdhHVgwCzT0uVojAE6S+Gt36V0Z3BfyUBTQd4ESyQ739rSu9FLV15w8IR8zpOAEm/l9RdFHPT6cpyCw6zSkbgJ9aODP2795lqpHeY0VwhPEHiFWmJ28fuLK9vx/HA8Jfv+6KGGY442ipiYbrrBoxwPqyX4Lf16tHXXHKonDmMl3RsU9StnB0osLix+6IlGwLKbe3OWI8nxwT+zAQ7hpN2tGWaoYd1Iy/vMQnUXV8ZTjpamplmc55xyJLXs8HiVHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbBTOb0lcW02YLRR+sJyjsdk4waCw4sslB+9G1Ywo6o=;
 b=Etg5BFg3fUKNlv/g8tuXV52R59YNg+Sy/1sj4w9XgKDOPy/LmNZYobaXlD0aQE/iFShyXy++VeLS5SfM/E0MAa7HhhdP/IaXvRAfpZaowzI/icmlpkZYo866NfPLCsiS1AW+3IzVgzbgNzVqerGXO8Gat6SVFqd3PSH0rONRmrfPdeGGbpgU5x2PW3D85hoaLb/a2xSajycQMINMTC5O8AZ4pByUSX7t6Y94BIop0cncCvHf2gyWD1nUlaHLQcgSoq8WGdBGEHTdBDwFr8HBXwRa5uccgwvXQwQWVM/EV7ejQxQRIatvNh6ITdv2agsa6Iwk5xQ8GZXbypV672Jj5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbBTOb0lcW02YLRR+sJyjsdk4waCw4sslB+9G1Ywo6o=;
 b=uaeM3slcYy4XiPH62mHEL0Dm5XagXf/jyFKaGoYaJRWD5Oz7pxLeZWd5KxMxHUVoCEqUXLUzWe3kLaVDiC0VATHFNk77gj8bKBkkltuJj4IHFv47tJvUzeqipBYcHN8tT+wHP+VkqHJTL7LdgPnfLhwW36N7A+uVxd0g+ZPILX4=
Received: from DS7PR03CA0154.namprd03.prod.outlook.com (2603:10b6:5:3b2::9) by
 BL0PR12MB4723.namprd12.prod.outlook.com (2603:10b6:208:8a::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 05:51:36 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::6) by DS7PR03CA0154.outlook.office365.com
 (2603:10b6:5:3b2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:51:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:51:35 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:51:31 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/21] drm/amd/display: Add NULL check
Date: Tue, 8 Mar 2022 05:09:39 +0800
Message-ID: <20220307210942.444808-17-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99000152-9d3e-4441-6abf-08d9fffe8a75
X-MS-TrafficTypeDiagnostic: BL0PR12MB4723:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB472327188362B0CDA2242BEEF5089@BL0PR12MB4723.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnRK47Wf54I3QoRPZ/Cto+NenaOvofzr3MRQ3xxtfwlKhhHadNaKLJ9PWixrRaxiHIWCXUK69HP+S4RQ2yrmjD2UFU9e+szje3blB/x/pE2EWNmLEQCn8RzYOIr0Sob1W4R2/SjKdakQwgpP0D7VwugY1jWoyEkcnTFoRUrMTi4ORwH6PyaJFezmeyNgXPE7MlmbSSD5fB4YzeatOkgLPbVBPkFr+tZCEUWaHd5186JT38NSVDxhmYkkb/uN9pFxw81ecVlObyvAg8f2/VKLu2QQwPn9GIhS0oHP1klSC7aEfctTSgon+XRfqvCZv8nNnMLPVfSLjngmA0YTpPbp9rlDOBsVoD3b5AKx75pJwmgoWX/PQAO2tPrI+Bmh6zCthDFWt9zLO15sPgIQqGcTG7gGvPB1onEkadxzztWpRja1Zmo6QaVIctMRdd64AIdHAR0JtV7OuZzlY0oFJQTq4uPcXUb1WzHDUx46bBXVBx5Ep2pDrNo5qy/hLH3FSQrk/UMQ4wiYSHIUFTdFOWs7PC1hmD4ejzY72oUQtiAXF3nTHbKDCeuGBexHlQ5mM1TwLtDBBRr0uIQtCxxyr9quI3sUSyDsO10RekFTnf2kvTLB/d9Rz+5OK+K61i1MjgGoZPPHyDOA5ySwV0p5LJlpieNKNec1EnSb3mgFgjKnaSSgiqmy+N+noSC20ji+mnlZKEHsOKv+ewOO7775NecvQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(82310400004)(81166007)(7696005)(36860700001)(86362001)(2906002)(356005)(316002)(47076005)(70206006)(70586007)(508600001)(8676002)(4326008)(336012)(26005)(8936002)(426003)(5660300002)(186003)(83380400001)(36756003)(40460700003)(54906003)(1076003)(6916009)(4744005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:51:35.8425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99000152-9d3e-4441-6abf-08d9fffe8a75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4723
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Chris Park <Chris.Park@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
Virtualization enters blue screen of death (BSoD)
due to NULL res_pool object when accessing DSC
encoder capability.

[How]
Add NULL check to avoid blue screen of death.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index bc2150f3d79b..7af153434e9e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2335,6 +2335,9 @@ void dc_resource_state_construct(
 
 bool dc_resource_is_dsc_encoding_supported(const struct dc *dc)
 {
+	if (dc->res_pool == NULL)
+		return false;
+
 	return dc->res_pool->res_cap->num_dsc > 0;
 }
 
-- 
2.25.1

