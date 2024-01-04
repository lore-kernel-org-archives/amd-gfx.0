Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD468C47073
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5342710E4B7;
	Thu,  4 Jan 2024 15:53:22 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EFFD10E4B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRyuNmVAo9Okzi1uhq9IUNkpl2V3Ct9IIlk36I9NiJcfdjl3w246aFJABJbM+G9d4vAzChXJkZyTmmf+Duj/XV22+axOxxxA0bVJDqxKcCinIVj0cYbOFVLfOZto46rP0tQtscM9qZYkdPIJTwbIbBiakIwb2jXV3OkbS9SOF79GuDqHACbyP8kcpZ05AZvasqn0IOkJBJBnEra5NBTcaVTM28gUPI+au8CtSAaTmjxAtbvYAFU7zQTCs9eTD2e8fM0EN32yBXe8nkEDClmug8OmV167qGS2cLzYxwuxEH7+12/33Ie8XugAS+RtVjTKN4DsuznkmGs0/bw0IFkzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQlqlEocwtA97iPEZYhUOaJOA8JJrH1y40U/MEt6D04=;
 b=JwjjHbk/+vgE1PDzKTZoFMAlKW2P3q4dlW07Q+J5wWWo58qBGhwtwd7oqEqPM9UpFTnDgnuAGJZQ0rpRRUYjg/cd3EnDmxaXzZ7QdiEv/6wlVWS82LDnuOWXXJp503aMPuz2w3IAMHpDE9v9pThS2YdvcFiIyhGCTQfDuNb3Cw99W0PgKOEkhHedJP2a5vnw82Go8w0GurmZFDidPgZjg04HbRwgJsUMkkfUZNpFPdNvEE1P5cQKzNqsRUhGIE8aa8Yu/mY72pyu90ObHRoGe55o9D6pBIsa1AzCcHC4gAv0s+viWtAoZWJcjGDUxusRzoc1mVcqH6vj4u+w+q0A7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQlqlEocwtA97iPEZYhUOaJOA8JJrH1y40U/MEt6D04=;
 b=DYZSzGHaQtWijq9g2LNdBisBmvq0Pw3AZ6tr94vLnh3YeWLb0IXh7h1bLrHgEN6DtBcxaRghQ5/xAON0wKPgpvZ4i1l0AKIFnyfvwNixEPP+hXWVEOO3QdBRyvpZamyHaOdFiWntV8XaP5BO+p5ol8R1SsNt6hSzCNYXet7b/xI=
Received: from PH0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::26)
 by SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Thu, 4 Jan
 2024 15:53:16 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::b8) by PH0P220CA0015.outlook.office365.com
 (2603:10b6:510:d3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:15 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:11 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/10] drm/amd/display: allow z8/z10 from driver
Date: Thu, 4 Jan 2024 08:50:57 -0700
Message-ID: <20240104155238.454117-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SA0PR12MB4576:EE_
X-MS-Office365-Filtering-Correlation-Id: bcca36c6-f851-4160-9156-08dc0d3d4380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YfsT8DK+V+/FV/zr/3dmOTPEBR40blwQNixChAEMUfg7C/Wex/tyTHxipxqEW4/7j/T4g3nJumbeCTK3w8cmhLXORROgNLpczSq+K/D5Neh4zfIHmRReXPVHVUVA7XBBvzP//63K/mRO+fbn0Q356WXt5PnUPgSZMTD0s1+JMjUscyQGReg9H/5Fb06jgyVTtYVdSphPC67gCj2Msc5PdafyWnvwZ0d+Nbfg4GlhZwKz37Q13WQb91kLrbdUrIjEVpQthAYuAf6M2Tt3AYUmgyfsEmw3tzDfb4BNg98PHxCozvkb0OuvBIVTpBQkeiuYwIs+3tOMhZX/z7h9QxMtiOdQRIOUp0agnMY94GXnJ4uQbxQFdlZKb/Hj8qChqcUrmozcHsYjZJxHR4Xmft6K9GSNKVPGY7tXU4oT6cbrDoLRSIBj36vWPyuuhFyz0EpzwyXqEg0yiC7+n61Qdsyz82K9pR0SQ99Hw5Gp5J95M3cweloGxZh3G096a+nrJTxiMDbhmGWrzPrev5o4XcnvQOVWZ9R/Hv9Cri+s09heV/bUUY1E+vISI4Latrn0ewXylQmw/C5yCRjL+Ul0fIUVbVvt5OmpI45az9TvjgigW2pTecjE5DA7xylgo5KjKWOh59j3VlpdPfO+vlblbLSW2gSI7+NYexVOb6LpG5Ez/W8MNFSWcOYN2RfEMUVQ25Mzz/1LJjlni9v8YgcNKVE5PwoxMuLxxLCD1cWEIyCAvbP/rwmLmDbsXfGRQ18HxVpVq6FZUB7vg7iDX4h/z95amw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(46966006)(40470700004)(356005)(2616005)(81166007)(86362001)(478600001)(6666004)(70586007)(70206006)(6916009)(316002)(54906003)(36860700001)(47076005)(40460700003)(40480700001)(83380400001)(82740400003)(426003)(16526019)(336012)(26005)(1076003)(5660300002)(8676002)(4326008)(8936002)(36756003)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:15.5808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcca36c6-f851-4160-9156-08dc0d3d4380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4576
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, Aric Cyr <aric.cyr@amd.com>,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Charlene Liu <charlene.liu@amd.com>

Copy StutterPeriod from DML2 into DML1 StutterPeriod parameter.

Reviewed-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Charlene Liu <charlene.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 638591ed057d..26307e599614 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -634,6 +634,8 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.b, &dml2->v20.dml_core_ctx);
 		memcpy(&context->bw_ctx.bw.dcn.watermarks.c, &dml2->v20.g6_temp_read_watermark_set, sizeof(context->bw_ctx.bw.dcn.watermarks.c));
 		dml2_extract_watermark_set(&context->bw_ctx.bw.dcn.watermarks.d, &dml2->v20.dml_core_ctx);
+		//copy for deciding zstate use
+		context->bw_ctx.dml.vba.StutterPeriod = context->bw_ctx.dml2->v20.dml_core_ctx.mp.StutterPeriod;
 	}
 
 	return result;
-- 
2.43.0

