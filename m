Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3155C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 12:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B63A10E330;
	Tue,  6 Jun 2023 12:07:07 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA8BF10E330
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 12:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDb8aS89zQ5LO0sXnP8XCPpdmYTS41OTKIsox3xWvv/UwSnZYZYS9++TtI/+Kpo3Ov/yO1qwlXLhBGcAL+Vp+oIkJvYSiSNFqKEWiUsLJMWcyEDVQp3ahl8D2EMdwNanYyjgT5NYm/MNqkEQlgggyJWn0fxOZg5DDMDamrrVK9FC6LI2sjELUeWckP9kEae/w9vDDIYDjsRPC7R4lSzRIzIKPKqyPCGdu/0oslUNfVrJ6S0uFGt4TNabgAyLvXiI50VzOrk+MF+RU+b3BvD3hCjV1EHb5ryf/mBdYnXbTigwUZQNLz+0MxuLeBL8JCoA6Ir+fpLFgJZDSq4VkDJm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8/25Ln4mM9zScETN3UYEbJyFHxoAW2Vz/USYBFt8r4=;
 b=gaz7uwiYHT+ASagnv5V/IekQbVfv8/wAYo+MYhURb9EZtn2m6hJO9fvbKzwKuzo+cRWpIlxsRknCxaCap77DwhIZusR9dIWMgJ40Q2MGIWDdD5TgqStLREPpTqSVkAEBapRlKafX8gJozKx21QMBWv2vK9O0vdOSLr8AxMa0F0VnR9ZJy1pSyK7sVzcDMVUrlYRdZDAgElbMOttDL2SdNfEFIFg4UdUsYF+JJ3z6DH2KD7r8C/oNRIyQgvMYiBWvHjcV1AlwdoNjiERBpb8C2cUPM/zSL14euYF9MviOCFXTnINcRtaFwLGsX7dxINbXcPtifUwwcrFAdS8wGU+waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8/25Ln4mM9zScETN3UYEbJyFHxoAW2Vz/USYBFt8r4=;
 b=e1gMik0Shz2nbch6+5x6sRmE+jwdcuXoefpcHXVNiqtj4u61atm8e8TF1GfWo4+dq0BBkM4nGiJHZu9S/Ydwp9ZwODMdQep04bvD+bTf6mlINj6p41JY0vo1FHdlTitMM+OzL2+Un6ZQmHfRWm4d9pWNMfs5bJ36ixFL+37VJEs=
Received: from CY5PR15CA0099.namprd15.prod.outlook.com (2603:10b6:930:7::9) by
 CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 12:07:02 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::de) by CY5PR15CA0099.outlook.office365.com
 (2603:10b6:930:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Tue, 6 Jun 2023 12:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 12:07:01 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 07:06:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] =?UTF-8?q?drm/amd/display:=20Fix=20unused=20variable=20?=
 =?UTF-8?q?=E2=80=98should=5Flock=5Fall=5Fpipes=E2=80=99?=
Date: Tue, 6 Jun 2023 17:36:45 +0530
Message-ID: <20230606120645.2603967-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8597dee7-1fcf-4b4b-eea7-08db66868942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szsVtNbzrV58EX2TX7JVX+sfoc9htC5FFu0yEtf+4tDWuCV7TqJpljhdPDC6K2p/HyEluNPFD/y9Xw5EBxkWRutIc0WpgdJfkjOv8c5w/kwelI04WNrg6MteQN434/nVpi99FvVdfqTFyyeuOSxdAuY6eo1YexOfLPS9XCKHf2kocUGd7nBksBD/syAtkzN/4DS53msOXv64Rpbw1CIr91TMwtwIM29mn0aKmPbV2XGshoEeamA8e4MWVMTf9jWhz8Rqe0cI6i1gqsOC/JdL82bV6rlMgey6sKAm/ic3hg9R4nrhY2Exqn9VNlr8ybBvdNm5NAgolqVkFse/eqnYsdkt2Zt3FJAly6pDUK93g4UT07jsVud4mfmyr5sMLGFOTZaxlhMj7p5NPJWlHfGxjxqA5toGGoOttqqwmeEVyOqMiX7DPycVwh0zCcPPS5jHY+jP5PcPP2FAImm+8qEohCCYuw6Yh4y8wIu6KDhWXi6kBPvou+Aaq0YRONzP/zugPSoSppXWPZe5nLBVcOBD7wmBPK+xy2ooE4bD1tufCJ0V/a2h06xx5apTDRrYMrrI2GW6M+wZ/MLlLzGV9WTfvMlykSkhjDWV71gLzLKib6mjamON9B0oXrECwtL7+TjYhl2fN+NCbpU7VhOnNCR0+OvZnIVJrIWIxFKyUeI2ilLUZeXr1Y8DRcqd2Ca3ISbv9NlaxmcehD1Yr4KWyBZzLaAujXevlOBlMT3waxnMAUTdnaP612JxWTbFBALWhddBtA9qK5RFT9ez6Xko6IrNJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(47076005)(86362001)(83380400001)(336012)(426003)(110136005)(478600001)(82740400003)(44832011)(40480700001)(40460700003)(8936002)(316002)(41300700001)(356005)(54906003)(81166007)(70206006)(70586007)(6636002)(5660300002)(4326008)(6666004)(36756003)(2906002)(7696005)(82310400005)(36860700001)(26005)(186003)(16526019)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 12:07:01.6479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8597dee7-1fcf-4b4b-eea7-08db66868942
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408
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

Fix below compilation error:

drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3524:7: error: unused variable 'should_lock_all_pipes' [-Werror,-Wunused-variable]
        bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 172bae983425..5e18fc0c79d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3521,7 +3521,6 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 {
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
-	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 	dc_z10_restore(dc);
 
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
-- 
2.25.1

