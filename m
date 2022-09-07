Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13EF4C54EE9
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A98C10E804;
	Wed,  7 Sep 2022 17:33:32 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA74410E7FF
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISjIA/wM3LfzL1GJ3woqscqhQjvPI3ZibtmmyyF8AglwW+3JToc3kWp8PoWNlQLUvsumpzLDsMx9FKAZmtclHYtTjnVeuQAvWewzsTYhdKaq0VRaFDaBq4bhp+wktb9USGnkqXTKP45wjYQrVC3Lc7CqRHhfoEodT2UruMFrp/3iUecCvUkxSQAm7PpFS9oCY62f9RZk6yYFhRdHeKvB7JwazxRFJBTyUERGiiuv+n5Vb7tit8uJmvDrv9+ZkM96wG22Q/mFiqhE1WZISvSGjiLMHxnsCDCSCNb7yTV+MdsCFzpbNwBAuLqVMt3OIjobdb9wBzFbO0yVHosABoulCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBbN+xqhdBQN0zyYOxZbFdL5QMo4g4M+DJitsyCXVCM=;
 b=XskP5OlkuxLRqDXAYahkbz+fcRqP2dEHIbVS6xwDbqhum90yqsr0YQd7PTxZv78qgw8hVMtXgES7ve1LV+0Ej04bpUUfNR/kiMeWmyRLNyllM1TWJqg/3UMGoIOMuiSLCrMN7Gl08M849+ZVBaCzOpgcW4Cjgrd1gxXKAg+6MBjRvX86g1zz1DDdW29XPPXR8WtxKNHeZ3HSzBgPZyZRsPTw7F4vyPY1K9haQgSZqcIT526FhScZ/+x/0KbLDRlv6CP6sipoCZ8Ifwvnx1thtJoxaC+UhQ3vgimhbbCCepkEhhk7fcGoJtbpYS19wibInjRasBbwWizv5TOwaV3OuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBbN+xqhdBQN0zyYOxZbFdL5QMo4g4M+DJitsyCXVCM=;
 b=bn5XYVZciFfkSpuHT/TXe/ifb3N9wbecBLHM5+R9PFp075GJiZX2DgU2i25D1PtrXYel9Ja+/CfyrOrJ1ia7TdleTvGnj5Q1U3cdFluQYaSFnQ4shXY8vpe2VfhHMza5fQPXEMg9CgPSIb5xk+JwuBu/WWBlCMgFl7aApueVK7k=
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 7 Sep
 2022 17:33:23 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::42) by BN0PR04CA0026.outlook.office365.com
 (2603:10b6:408:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 17:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:33:23 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:33:22 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/27] drm/amd/display: Don't return false if no stream
Date: Wed, 7 Sep 2022 13:32:11 -0400
Message-ID: <20220907173232.11755-7-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907173232.11755-1-pavle.kotarac@amd.com>
References: <20220907173232.11755-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|DM4PR12MB5165:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c413e9-e247-48d3-db28-08da90f7106c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLOGUFsvanHk/aMP6G45C7jZ1wf4bcHOfYfGEVWsvjC4R2opNUjPmaN/UTwy2gMnRKY2tbhF6DWvhZZPPtnFYTp6yCsZbrsroZjx/Z92S2vLPTpFo6xe72lnUFkIVsATSV1rVl9qfS85E+5HwqQL1bNmAF5Ah9Nw7kietgMwcex6zY8UV/2+7q9MHoHOQYoXeUk5p8G06CUgPBEQBC90PEtSfzngenuim0TvkAcemxy53Xn226J7MUHr2AZ+FInWGRSJvVum8hdBQDIs7SRBfNVx6YPRpQsGuNjKLmDzk4FBMQIqusc3K6PCgaM2QedIryW0xOYppVuFpm79Et+kYeYey8NSs4aONGir3BcMrSzXgOynLQuVrzz32OTnXjRfnr/lu7ndxBOg2HRa6CKOSoIX5yMvNfWpV5XZb0gylLxTi8suMzuLJtiPSFtVW5/nIeG3H9r8KfwgEMJQ1ZZVobjQWmLvx0q3wEbplAYBrXyWHwCjpVcpiBvG2FIFir6MVbg5TaqpePYOsu5MU88kgPAtyO+2l3noN0jQKoZ4PBbPDMV/ugD2qoqNkaSZ+nmN3Fpv3KSWsnE37koOi0qx762qFIVIpaPRq5qxv6KNiNM3jkInbBGEekVOz2K2IeGYg1MCIdKHFAzT597yPHKrnfV2VR0+tFWmZ1bpnuEBqWml3ObHhQYxl+yEVF7gRV594qlpq4LE4ra4x9Fgu2W+OJBx2GpvxgwX6ib33HbC9FkeffR8MtwUSpt3Tpbr8yr9ifJJb6qnh6xIK6J4OPi6P5BTohkCp2LY4ALsF+xExgQoqWPRAvEo7PjDt+357tGP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(40470700004)(70206006)(83380400001)(4326008)(1076003)(426003)(16526019)(70586007)(47076005)(8676002)(5660300002)(36860700001)(186003)(6666004)(478600001)(26005)(41300700001)(2616005)(336012)(86362001)(36756003)(6916009)(54906003)(82310400005)(44832011)(316002)(40480700001)(40460700003)(7696005)(2906002)(82740400003)(81166007)(8936002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:23.2612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c413e9-e247-48d3-db28-08da90f7106c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5165
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
pipe_ctx[i] exists even if the pipe
is not in use. If the pipe is not in
use it will always have a null stream,
so don't return false in this case.

Reviewed-by: Ethan Wellenreiter <Ethan.Wellenreiter@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 1f195c5b3377..13cd1f2e50ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -187,7 +187,7 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (!pipe->stream)
-			return false;
+			continue;
 
 		if (!pipe->plane_state)
 			return false;
-- 
2.34.1

