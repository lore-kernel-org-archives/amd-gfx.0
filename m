Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1FFC7EE24
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jun 2023 15:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4691910E0BF;
	Fri,  2 Jun 2023 15:19:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69E210E0BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jun 2023 15:19:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+RevLeJzapuEjNeOsVzgE2mY9mXqNQ64ekFnMYW3t4ty7LLO7YsubnxeBEbEOQXOel9/IXbZYycRzhR0kck+KUT1hlPk1Aans0thEH5yhxihmzqMdyTOSxUGgvT45qLBDl46fjrKm9/HQwydpMr68S83xEaDXDf9FtHVOnSx1R/dkBR09JayX+kRGjuniN3Cp23UQSH/KfPnx8Dp5Ce7zbaYiLEmwsKMhmr0O9rB8IB98W6BvxlDHo+FUq7UymTcWdaKpGLNZf75LE8I0HmeAG5IizqOSG5+d179RgWCIQe/9jcSQ2cw5/qpHE78QPeTeHJynt/mn3yGtRhqBad1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSsbjX1owKSKZWnvPrhXgOlsMDkXrjUyk+TBulZckus=;
 b=atchMPLQ4j2BaUdsLFR7+/FHv2sVer5nBUwNpnScyJYOfJcS/aMdO8zXVtj3I/bfjGegaZ3LL13Ifr9XhIOFaBA51u1Icl6p9txMcuVi7gs3vnh3cSyD7EbwvyOynsNNdjCWc7UT7LjclwSLfwxQPWw7TF7avKFQJkuK3XJcK46S9rkkeg1P5j7u0iaJIkgh10UqHO7NFVUVMcVvPJYCBXXKnH7IZ1812f+rdjSDyGvYDVDnUDPleLEiUJd6pyTUqT7MdSfzyF1r/qD0sULKxS3PbGhTZL519abvpgEAAC/64ABvAcugye4Pqr18wSdrgpGzDuV3/MwrQ4M+Ml3hVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSsbjX1owKSKZWnvPrhXgOlsMDkXrjUyk+TBulZckus=;
 b=v+hvoyyEakK/G/6Zd824Upqz9bFQOBqVfKLgh/nU1k3Mpe+CGBEgZVriSkHHdMp5NsEvcGwcJYXRmKawStWw40y//YmzgDY+dRgVYZNlNmbrazaZ3DENOUQzUcaMuM2SOc2veewXmyQrUB5tNyYKpNT3DSCT4FG9lAeEPJDOymI=
Received: from DM6PR03CA0015.namprd03.prod.outlook.com (2603:10b6:5:40::28) by
 LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23; Fri, 2 Jun
 2023 15:19:39 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::ea) by DM6PR03CA0015.outlook.office365.com
 (2603:10b6:5:40::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 15:19:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.27 via Frontend Transport; Fri, 2 Jun 2023 15:19:39 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 10:19:36 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Rodrigo Siqueira
 <Rodrigo.Siqueira@amd.com>
Subject: [PATCH v2] drm/amd/display: Address kdoc warnings in dcn30_fpu.c
Date: Fri, 2 Jun 2023 20:49:17 +0530
Message-ID: <20230602151917.1674529-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT008:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 959cc32e-4182-4d69-77d2-08db637cc865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMrPVNvHIJr7JXw/AS62B45m2fEMa5XHd4otdiREXRIzp+f4w4BOIiXp4JrqirzR1ZOtp8Y4v2VVOnLQcgDu4sIVo5zc4dT5L3mniOmRylp0SWf/eHOqbnpxwHpYHiMOEXy/07gaucmLDlKWXN4V/N/VTBHlqPdv4b1JXptIMyjGUm8jr9xhHmB+eoRInPdFsACdrNqvudeWnK0xnUlgMs0TPl3HmthI9kPWV4DrMhSz69CqBNkxRnuHIJD/U7AEbrVPH0YouwdLYMPDdFB+fl5IpHKWgVF/l5XiU9bPWkqGRybEBJQ5yvIouojJMYFCyJboBjmARfh9XDccf3DEnru6k85bYnNCisKeSg1IHMf3tJcNcebbJB2rgt4PEInKdbiaoVoOmicCwBXZd4RSO0dGdxUQZJXXlZNHA4j1+a2/ygSNqMXAkO9NZMUn1aoYa7UoGfsq4LPHWf7qSEtEeiMOjSbFYIskkUxF+X1szLZ38nV5JECZJSB71wWWv+4LCH0LyjXn5iG/6l/npDeMJMQ6l0sLbOEcblI0TnI9Tr2taCGSEI6MEsPynHDLoD6hZx9wpLjfdf/b+v4UKhpw41Tp5P0TYLWeQggBn9S95MUG1ewDXFkvesbZ1K8rHn5T2TGkZaAf4SqRVcjTDl9xkEt+jDJpa1BKuLd814P29K4yXF2baZMtpV+P5ixoA8VBiTSGTwqgEjq7oz/DAxZY6gaInrElr3w7BPcFf/BNM8/J712oYK3xM/KPwLFr/qEWPJ5FKDIYo/dobrjDjV4l5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(7696005)(40460700003)(426003)(16526019)(336012)(83380400001)(47076005)(2616005)(186003)(36860700001)(4326008)(6636002)(70586007)(316002)(478600001)(70206006)(6666004)(54906003)(8676002)(110136005)(2906002)(1076003)(44832011)(5660300002)(26005)(8936002)(41300700001)(40480700001)(356005)(81166007)(36756003)(82740400003)(82310400005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:19:39.1463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959cc32e-4182-4d69-77d2-08db637cc865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

display/dc/dml/dcn30/dcn30_fpu.c:677: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * Finds dummy_latency_index when MCLK switching using firmware based
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'dc' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'context' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipes' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'pipe_cnt' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'
display/dc/dml/dcn30/dcn30_fpu.c:688: warning: Function parameter or member 'vlevel' not described in 'dcn30_find_dummy_latency_index_for_fw_based_mclk_switch'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:

 - Change the commit title keyword 'Fix' to 'Address' (Rodrigo)

 .../gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index a352c703e258..ccb4ad78f667 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -674,10 +674,19 @@ void dcn30_fpu_update_bw_bounding_box(struct dc *dc,
 }
 
 /**
- * Finds dummy_latency_index when MCLK switching using firmware based
- * vblank stretch is enabled. This function will iterate through the
- * table of dummy pstate latencies until the lowest value that allows
+ * dcn30_find_dummy_latency_index_for_fw_based_mclk_switch() - Finds
+ * dummy_latency_index when MCLK switching using firmware based vblank stretch
+ * is enabled. This function will iterate through the table of dummy pstate
+ * latencies until the lowest value that allows
  * dm_allow_self_refresh_and_mclk_switch to happen is found
+ *
+ * @dc: Current DC state
+ * @context: new dc state
+ * @pipes: DML pipe params
+ * @pipe_cnt: number of DML pipes
+ * @vlevel: Voltage level calculated by DML
+ *
+ * Return: lowest dummy_latency_index value
  */
 int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 							    struct dc_state *context,
-- 
2.25.1

