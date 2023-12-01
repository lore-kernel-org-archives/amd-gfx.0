Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500B1C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA82D10E895;
	Fri,  1 Dec 2023 13:29:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1289010E881
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:28:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/yzLIvFBSuIGAnRwOqfe00ErcNByed8G+hWQDHjSiaPWm30OZnPEJChdYZdFrTn4fqaaN3B0bviU8whk2uPP4xxKiEp5EZMc+puBQ23osqqTIoX79EcnR2BzNqqVs67rtAB1Q6lIuHwPkGKouUAsfi82yoI6VUv/nSSwo3ztJFGp3S+CWQxdwNGaKvM5ZTmc3M+YupwOALpwc337jsOmpH7HfJ78jymDd2OgHqkWSXZv7zRkl+A/awi1UP8SKR7gy6NkV7k9Gu22EnSUZsXgLmA6iStftJG64bWBj2+DTUxS7xYgor4enWqmumdnANKVoVUo23bHMkjMjjYTubbzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1bihNCPA7XvadYmmFmGjQoMddfjIo2JmxaYnlLR9AQ=;
 b=MyqZe7Hz+k8M8VX92tyigNmOsz/Wk5fIVfGtA6wZsmfRukqwd9cNClseB/4/sZZan2j4A3i+fixefgqYxtR5A3pH1TiV5Sg0TOHnfg87VtrM6pJJTXyvOK1fWespzHBBPRNXNZTMNCdLjJVyWeKlBy+kwNdAjZq8X7cbvYDiirGDWMe7zc+4KSa9g3aOhz62seHid+vYwehYZIBi+d3ciASQG+38JY2lps7LpSFpHELag+DqsOFjyJY9VnCzYLCojEMokRX+rTONVyM/4VUOaQ/Fbp5Y8374S9ZMCZNmsuKlbFiTs8yLSM0J9lQ0fJWT1iGFTBP5+ECmB3aBs6zzBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1bihNCPA7XvadYmmFmGjQoMddfjIo2JmxaYnlLR9AQ=;
 b=BJ2VpjFTOpSSM8tZfppkQEFrsLAKMKO5fZYigpF2PtWWnWBs8Fz55Wz9HiUWp+8zFSAgHJlmdJN/+XeE5BETFNuclGlCgBq3VnNgHJTzoI8jxnOo5KVvWIrs643hGcfP9y2dTJCY0wYzQTr7Ylkx91/Cw67gVk2cn/lGPr/TZ8c=
Received: from BYAPR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:40::14)
 by CH0PR12MB5316.namprd12.prod.outlook.com (2603:10b6:610:d7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:28:48 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:a03:40:cafe::15) by BYAPR04CA0001.outlook.office365.com
 (2603:10b6:a03:40::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:28:48 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:45 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/47] drm/amd/display: Avoid virtual stream encoder if not
 explicitly requested
Date: Fri, 1 Dec 2023 06:25:21 -0700
Message-ID: <20231201132731.2354141-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|CH0PR12MB5316:EE_
X-MS-Office365-Filtering-Correlation-Id: c07da080-8bcc-4b16-9739-08dbf2717367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gkZSYi5hLTu4Ti7r7H1nQfcgrdylLUgJHNm3F4S13jOfwRWECN1JrVB+nkC/GUbavoddB7arm2DvkZGdyiAWAzEHdsQbrRv/N6uGj5YfkkthMraYm8H4oSNR7pqkmRvHxpB8j+ZB7gzm4Yb4+9V2oVQwQyKfD2/FxeC38VgziO50I6Mwutg0WZklmm/pOrarHw06p9FJcrDU+hLm7VFYnkDNqkJrNnfFmpM1Sa+oIMEo5AYGi39T0lrVdg4GtCgZYlDvCrVXXbSJGvBINtsJ4TB2094BOuViVKUCq7Mn+P8wjzyNm+FzAt6/1brEucLkCEq/rjOLmE0nq2GA8m1eMkQMVAY8nGDB6nUUhK8rteFsKkJZwu0rkp1XRKtAFiZe892Q0IyjP3mz/Oca34C9H74LV4j2OFjW6OYxk1IJkaXgFJ2hrQZWWYnc+NQgs6ioWS41QVIE8zZJrkiOMBN0+qYeuInJz0+bKO3Ah9c6xGKhVif5UO+KXsGDyS2MYHqpZ9ePAakilcAj34zPsb5/PqXZrBeRtYhQKi6pS5nfuyhaFlN3h7vMbr4PU5i2xB+fG88iPJ9f70o5hH7oLFxpQCsOrn5UbGA83L4pBmrr/8eYOdIIIP+1hXi2NhkCD6SVJzXclqgob28m4188L2PvFXVvxUpraxNw7UxeKpUGh0bncXDxu0LWELBr0TIi02/29iPjzYlWDBuo9JIu7baVDPNRglVqV1rdLagjRJesRdrupbKQlPWKAgSHMXQQKq6m5b775qBM2uO3qopoF8cZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(36840700001)(46966006)(40470700004)(86362001)(40460700003)(336012)(16526019)(1076003)(83380400001)(426003)(2616005)(6666004)(36860700001)(47076005)(8936002)(4326008)(8676002)(5660300002)(41300700001)(2906002)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(26005)(36756003)(81166007)(356005)(82740400003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:28:48.3670 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07da080-8bcc-4b16-9739-08dbf2717367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5316
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

Virtual stream encoder should not be a free match for thunderbolt or
usbc, and thus should be avoided.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c   | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
index af1b31f4e69a..d08d10969251 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn10/dcn10_resource.c
@@ -1250,7 +1250,10 @@ struct stream_encoder *dcn10_find_first_free_match_stream_enc_for_link(
 			/* Store first available for MST second display
 			 * in daisy chain use case
 			 */
-			j = i;
+
+			if (pool->stream_enc[i]->id != ENGINE_ID_VIRTUAL)
+				j = i;
+
 			if (link->ep_type == DISPLAY_ENDPOINT_PHY && pool->stream_enc[i]->id ==
 					link->link_enc->preferred_engine)
 				return pool->stream_enc[i];
-- 
2.42.0

