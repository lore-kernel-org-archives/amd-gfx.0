Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2377C77B7A
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D8A10E46F;
	Wed, 31 May 2023 04:49:18 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFBF010E46F
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:49:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmS+5OS/v1Kyn77dJKzZ9NXNPBJQAvw+cJ7LVBcm+kDED/7f3BzUnViqlEuBZKB77y40U0hV4jvPfcVpPTkNsZvKhcRtEFoEOuCfpOTbm4lTtndxsvqcvamn8pszUxNsL8sgPN1lTRXnTEW70ich22xUeF/bxyD+VLkcrTam+rSVuT1lx8+yYK+pA7kS5kypbWx8SVn9I8P+DbFtWRChZtGL+/LcnBkfXoj8jXQTXeXSkQm9d9UwJ5zyxyKp+/LnuTLNul4U6bzmcZcukQkLo8TDUVHCuj5MtOzTprRemmfV/iRBhetT97d9jMACnpJAUXVeoVwuco46VYao//2XrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi8DMcOGjcnBFu6aTBHsKUVeoR9Jw+cTun3NRdHqSTY=;
 b=XEdi8P4CBVbx/PXDb44kzmHOOaQaZEzhQdSiqNMVpsbuA2oWCMjK07XYHyDK3TjYjzGi3m3JuU7Em2xVId2wcAuCU1rMWLcwJek8lnbHjgkvEj5uhoDJG4coLhJr4BEvdaVoF/Quqw9PmvJCV8EQbbmyly9zvC81/c2KBH8Jw/M/rNT1OzZ6n75a8KJ/3acd8fNTkbiO9HdtSAkfKNCVzuod5MEYZ+W3olV2PJE9LoQeHo0hVjVosKLwLp1mGypilHoAT3Jz7bhBd1Yuc51cU1751RdZC6a1pGQuMRoEbcd7x5fgamRnpDqW6i69jCeaCvLPlPyTvYjY1yK5pTSqnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xi8DMcOGjcnBFu6aTBHsKUVeoR9Jw+cTun3NRdHqSTY=;
 b=AUI/uIQeyAM22IMPm/qwlWMGK0QBYreZ4mjUF5DUNesavVwY/hdNF0WjhTa21wsRNmZdoq5fdpKOQKSn4lNaxWkljC4TxsV6OiEUWHGRavvIG0zNgyb+bWDhwEiw7qjeEZHSd8vX+Flfb90/m0JxYTIuNgk3lEjLNIMeKmBLaFA=
Received: from BN9PR03CA0077.namprd03.prod.outlook.com (2603:10b6:408:fc::22)
 by DM6PR12MB4172.namprd12.prod.outlook.com (2603:10b6:5:212::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:49:15 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::d4) by BN9PR03CA0077.outlook.office365.com
 (2603:10b6:408:fc::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:49:15 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:49:04 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: Wrong index type for pipe iterator
Date: Wed, 31 May 2023 12:48:04 +0800
Message-ID: <20230531044813.145361-6-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531044813.145361-1-stylon.wang@amd.com>
References: <20230531044813.145361-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|DM6PR12MB4172:EE_
X-MS-Office365-Filtering-Correlation-Id: ab571a97-6d5e-412f-6ad3-08db619262dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNhyCPlnX5x5Vd13tXkzIxZW3S5U8xCREclpADvIktnQmIRdA3A363woBr6cMiLf8el/+OP90YrrADjmFsztPtUHgfh2uC5bc17OEUo9soP7X/canA0JADHBZ6sP+PS1UugcLq4pdl0Sd9+OLpuwuZpp8DHjzKoMPC1fuBx3EgTKsIBjBfHhPn8JRMBIaJGTWNmOFXoMfGynFY4NCEtChuCzWSTszHWv8IyfcQemeVh7MPZzQVKzdEoEWFLpT57gWR9Lutb0QzSFE+QojcaIw/NDBGJD01fXT5vNGi4CnTLAqIAxx4/CA6PmGP487uhDXxOhOEbpqyWEYXn6/kKN0EqnTRpnWTk+mOcWbT0qF3oGuMEi/sAYzIez0r/oTWHNkTojlSmrrW2aTHXYp/rKvU4u/MQp+oLOmltmDEFUo2LXMJS9EyHfYXPKSbDhsvYlMBHrvAFxdwcPxd94ZYy/oog9zNXkZAwYeGPvY2QyZB1WMGT6P8j6Syz53SjIl6MpIrtltx1xoEAlgnWzGA7ip3m3fs+NdStc1dSUsmdX4SYDrjtdJ2j6ojqTWEu8iRFTx/eFJ4vXrBSP2X7g7mKTOfEdIazLOW0dohUhsIfUwBA8wQPA2AIFl8ypuLP/aXSCkeO1MC0CFUSOUwC3l5a6arX423rVE4iFlHzmwHNsg24HO3LKLDQMZsLWRWoCNfFoVHaQk1L1voc2UMcpj1H7M8mUZfU4k8rqLHz1JIuvgkFVzH2VWF4Y/DGT7L2o0v3gT42eYoXhMiHcq3ADjbiYBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(70586007)(70206006)(6916009)(54906003)(4326008)(316002)(478600001)(82740400003)(36756003)(86362001)(36860700001)(336012)(426003)(16526019)(186003)(26005)(1076003)(41300700001)(8936002)(8676002)(5660300002)(44832011)(2906002)(82310400005)(7696005)(83380400001)(40480700001)(81166007)(2616005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:49:15.4385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab571a97-6d5e-412f-6ad3-08db619262dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4172
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
Cc: stylon.wang@amd.com, Josip Pavic <Josip.Pavic@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Saaem Rizvi <syedsaaem.rizvi@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <syedsaaem.rizvi@amd.com>

[Why and How]
Type mismatch in index and pipe count might cause an infinite loop. code
Change should resolve this issue.

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
Reviewed-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index 46b6f4f9e1fd..ce7e6f20b31f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -392,7 +392,7 @@ void dcn314_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 
 void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
 {
-	uint8_t i;
+	unsigned int i;
 	struct pipe_ctx *pipe = NULL;
 	bool otg_disabled[MAX_PIPES] = {false};
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 3f11992e380b..00f32ffe0079 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1201,7 +1201,7 @@ void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 
 void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
 {
-	uint8_t i;
+	unsigned int i;
 	struct pipe_ctx *pipe = NULL;
 	bool otg_disabled[MAX_PIPES] = {false};
 
-- 
2.40.1

