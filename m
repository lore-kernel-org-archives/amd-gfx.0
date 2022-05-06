Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B8FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 15:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B1B10E775;
	Fri,  6 May 2022 15:43:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AA3210E755
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 15:43:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRE/l85zltNKhu4g/YRaca8lMijqmNr2h4uNCFUWy4iGwDEWSEslln1Aefrowwf10LnfgH4J6C4sUHlEJ5ixBa2uJywTkcvv+k9fM2RQjOPqTvhiDB/cJ5SfZT+/xM5xGZP5D5z3sR+03z15kGWrpIsripvLMubp2njjRqjad/FiwXCqT26uXmdxj4r/pVNwGoOQPKwUjPb6EXzMAgMFvl5AGRnddoB/9YIzM7GKW/HJOM0VIx3+z2VBwQKoVf7g8R0+2LP0z6RTFJY59uHZ9gm7CU3xSWoZQb5c41C1LReu3xGms+Pa89qNKNxoTOC7P4fUmZbpC18yrXNNdFPFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1RoW7HXffJX7b+8sYcGCS5HxmcPwZb2BY0xXxkj+y4=;
 b=HwIiJT6BruysvofFiJAsomn6J09Tkh+WltApCJv/VfJ52QUYz3TkanOybRu9KDVWu1YqRoqn2o9iB1+ImJYIFL/uhCBZvapaeD06O9RmPH7yGoYtxHQBO6iuQcb+sx6e04sWY1KP+vMbqM3NpQ9ws7SHh1i5UPkvbDnIKWUz3Dh5EEuZYIbwFipAmj49bq9QoLOHMhOxd8JfrD4QZmo7IrSNICXnc34I1WwFmC0+gs+GwI+lOqAy3+YwlTzYr/kKTVzxOAAJvugbG0XyX72f40viP3PJxuyxL9v0rsXuFFUbEZK6skatuj5CBYGXmJ4JS7D9vDLpz1nLH+zuVNfZJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1RoW7HXffJX7b+8sYcGCS5HxmcPwZb2BY0xXxkj+y4=;
 b=fTZpg87jUQrJ8mgwzYcMkWMuWDx0csKvpaf0zJGMOL9zx9kXLA+iBmMSZBfH+hCRMR7UZtlLW5AqMjU3FIo/nidToBKPdNPKIjvqgB6eCmQPsG/EaQ21OM3y37d6HfTXceSHjE/J8uNasDYltL7a/6W4h5B6w0PRBEaSzNimMRw=
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by BN6PR12MB1588.namprd12.prod.outlook.com (2603:10b6:405:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 6 May
 2022 15:43:49 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::f1) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 6 May 2022 15:43:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Fri, 6 May 2022 15:43:48 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 6 May
 2022 10:43:43 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/15] Revert "drm/amd/display: Fix DCN3 B0 DP Alt Mapping"
Date: Fri, 6 May 2022 23:42:13 +0800
Message-ID: <20220506154214.3438665-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506154214.3438665-1-stylon.wang@amd.com>
References: <20220506154214.3438665-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c65dc88-6124-4e41-9a7d-08da2f773640
X-MS-TrafficTypeDiagnostic: BN6PR12MB1588:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB15881F60E914DA905AED740BFFC59@BN6PR12MB1588.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rCkoI2hGDndCnUp4pAMU+A+4+eSMoF3LPiboXWlZv6welAM3QgsM3TtMXnH+QnrQA5BShtQGV1vl/AcnOab7EI/lfKaYYPyadSApyTH1pggXxKXLfgXLgYz9CmVyn2Ha28rqxWfnzqLKFkdx4efxFDPWRczEBnzivURm41MlsZEJQcf5Q4wSyP0Ac8BMg5g1d57hmERFUaNA3Jz6X5aB3Pf8lzmlK1Sqnwdtufk5EU0+YNmSIjQ2gTP46Rji2r4mEetQg8vccWe4LU5zIlVopjuBEhEOTcNBzMQlkvEmxv+H13WjvpgBfrwPGgfcgBYIQnbnl50pcFN5sXQE74S5mT9rfaP4hQ3WCVSOuAa5fwbTPtzca7iGO4ndgBNeAIeUBYUb8azXfTVzrWEB/fbSNrsy3aq5Md/UikjUkPAugLsfSeRusAODIonIpVcJQhzjzJKaoDC7xnuz33lm0hDoaLL0BwdoOUUn3bz693jgd1UD8LmIMhrY1kEFs1pxc93SVj+tS+ZoJvvfAwHa+Jj02EmlVNI9idRcObluMg7JCbPRbwnY2L1NjckTED7vtyi4tUQ0fuyR+XzqkosfP2i0/WPiei00X1ghznLRKCYGGTA4QqzfpVYDsSeByKiflPkjwG1Tkbyo77OvZ4YNLCMDRAxNrDm5jQsZpf77Lo5n7IFrqrWw+ERKgQ4lfxJNnArVy/5vmhn5LgAxLxgHmbaXsQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(7696005)(44832011)(70586007)(70206006)(5660300002)(8676002)(16526019)(36860700001)(2906002)(2616005)(6666004)(54906003)(336012)(186003)(26005)(6916009)(36756003)(8936002)(47076005)(316002)(1076003)(426003)(83380400001)(86362001)(356005)(508600001)(82310400005)(81166007)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2022 15:43:48.2288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c65dc88-6124-4e41-9a7d-08da2f773640
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1588
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 4b7786d87fb3adf3e534c4f1e4f824d8700b786b.

Commit 4b7786d87fb3 "drm/amd/display: Fix DCN3 B0 DP Alt
Mapping" is causing 2nd USB-C display not lighting up.
Phy id remapping is done differently than is assumed in this
patch.

Signed-off-by: Stylon Wang <stylon.wang@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index f3ef52350b03..ccf1b71a8269 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1248,12 +1248,6 @@ static struct stream_encoder *dcn31_stream_encoder_create(
 		return NULL;
 	}
 
-	if (ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-			ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
-		if ((eng_id == ENGINE_ID_DIGC) || (eng_id == ENGINE_ID_DIGD))
-			eng_id = eng_id + 3; // For B0 only. C->F, D->G.
-	}
-
 	dcn30_dio_stream_encoder_construct(enc1, ctx, ctx->dc_bios,
 					eng_id, vpg, afmt,
 					&stream_enc_regs[eng_id],
-- 
2.35.1

