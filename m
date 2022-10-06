Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6311AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F287A10E8B3;
	Thu,  6 Oct 2022 21:27:44 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E547810E8B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVqieUpLPPhfGbRbl2h33eWmwWiDXFG+TUWucaL9SLx0bRZuY8AOkEEkDfMjGCiGR7XDW8UjDusxrsWx3CWX9WGfR3BaOjuOFJOggov7jd0QGB5A/ZOKBHjDBa3p5E8yKCSs5nZZW6ZMty8PH5TRgQxF7ZE/NWdxsIUFD8vQ1E7fMVOxBBIhpfDGPf7Z3MDJ4B0iEkQDQpeI2dctKwwfP0Ggl/rkNh7wWDpE7GBAvptU/r1yO0JfO/C4nbC9X3bwOGBtBFEzNU0/biQO1Jb7uhOcHTALhNOVxE3LdDgYlZEJ3gT0pVleHlwQffKaQIJe5WFM+PMdppJ+iUbwuNCDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnsCK/C/U9LU5TYvQfM+g13yMIijXDvOPkFdJeoeNYw=;
 b=j+3zTYBBm6b4TkBPrmsAaHURECLulFwL/xGjK1lXuHFssKSQzUEFlqS+PUn9ftnRtZEsqWedkz0F9CnDXriMQdehlMxlnQyuzYZhUBdjX4QhKM4tgYqoc/y9M8Q9TJ8eLCx/4kBbuz5lSAc9U95dCIgdACaMMCpRaRqZKBEWbP2L09vsZxvEC5J7DeiGBrEPGijjM79xbiTjTeGSJ0Zgy3u4XmGw2/4xZyi0iMo42v7EHEZQe98a14nzncozcnToJNDHeYk/1w0XrS7br8ZCmHdOfFADqsIDN/Ki2F4QpYRDWcGbMIP5MFpbcQIutlSeEG1RSGhpGMOmDBcpBnDxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnsCK/C/U9LU5TYvQfM+g13yMIijXDvOPkFdJeoeNYw=;
 b=zW/XX6o2r1Q19iK52IW63PgNtlEdGywV/X95ZvSgwtNIiQMkiWFSV2pMbMLfok+sQvcOFXGUZGFZ5Fl8xOIFWSb/EB0Opy8Isw5PDBAM0Jk4iAotvx1eqsZoP0ALCaSi/FqkrZnjMxPAaKy4dorOB2LTBJ/BM3WBekpJTMRGH50=
Received: from BN8PR15CA0026.namprd15.prod.outlook.com (2603:10b6:408:c0::39)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 21:27:35 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::cb) by BN8PR15CA0026.outlook.office365.com
 (2603:10b6:408:c0::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:35 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:33 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/23] drm/amd/display: do not compare integers of different
 widths
Date: Thu, 6 Oct 2022 17:26:32 -0400
Message-ID: <20221006212650.561923-6-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|PH0PR12MB5497:EE_
X-MS-Office365-Filtering-Correlation-Id: dd19eeff-431b-4ca6-437e-08daa7e1963d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZAMQP7rkd7Y58WdDzDYZBxvd0p+RouAZnPRyYBZ41+JVqJttmbSb390TmDs1Obs8W7Dfhvz0r4T7opQZwM0G47v3WEKV5GQelx1ze74MWat1JOX0ZpfjRjSZ6Sv0OXZhXFE70YaWoDpsdbP6B5iftBSMetzQ+ZlnfXfEiPt8EWYt0ar6LVykY7X3q9QH2cFoBBwY2dr5e/9yRSVIevFYnGlFaLzw5Hu3HttLEKc0+pJbohtOXoAHItliJTGXM5jEshevZHjK7DQfrAtPxOtu3c1dHCDvjAQv3tvp4yuPvfKhegHZJlgQs3Z7jw/5pQjt5lUUt3nTtj3DMuARPQ0feLToZ0FDtIf2BT430uMk2vD2FPyjNHzPqvOzMJDdnnIoaVGQ5Fmfi55660GcT6kHIUEZzUX5OV4NNBgX6BfjzDuk4JCEgUeDjS3dr0Lnoe1NKrgOy95I3yzwMi5kLOILVRyvz5mAa+ANA6iUx6/zWfxc3gvjKcN1NOrFqE5+v5IO4vXP07/0h7DKftxf7L5dI0QYTvd/SOM78twgzFjtI1thlhfKZZKOn9GGAYdRQpp3GFk4/6Odt+4QsejBvhkR6LbN6VKHEXn/2aO5rUt+hhmz9OAyoPjtOsGMvFU4bTh4wI4HLfhT7yZDLR7x+8SEEJBtI4xxtwifxynPu0swSODe9TVIOIaX2X4O4hjHCHrfZJAzG2ojhiMF/qfIGnv39YtTcr/YnL2F0UR6PoTRR3Sb29umBwMuH5Aa7XMv1oNdMnRfqbaaYMfu+C4sm+ZtMIz4Yaa7TetkT/QtvU6v7Ytf57F22LelH65ktY4T7hj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(356005)(186003)(1076003)(16526019)(2616005)(336012)(426003)(47076005)(82740400003)(81166007)(36860700001)(44832011)(4744005)(2906002)(5660300002)(40460700003)(82310400005)(8936002)(83380400001)(40480700001)(41300700001)(478600001)(26005)(70586007)(70206006)(4326008)(316002)(54906003)(8676002)(6916009)(36756003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:35.5642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd19eeff-431b-4ca6-437e-08daa7e1963d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
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
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Josip Pavic <Josip.Pavic@amd.com>

[Why & How]
Increase width of some variables to avoid comparing integers of
different widths

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 955ca273cfe1..426b07edb426 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -206,8 +206,7 @@ static bool dcn32_check_no_memory_request_for_cab(struct dc *dc)
  */
 static uint32_t dcn32_calculate_cab_allocation(struct dc *dc, struct dc_state *ctx)
 {
-	uint8_t i;
-	int j;
+	int i, j;
 	struct dc_stream_state *stream = NULL;
 	struct dc_plane_state *plane = NULL;
 	uint32_t cursor_size = 0;
-- 
2.25.1

