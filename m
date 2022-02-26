Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C523CC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Feb 2022 15:42:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5D210E29E;
	Sat, 26 Feb 2022 15:42:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2EDD10E29E
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Feb 2022 15:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoY9KUnE86KtpK6VZN05hAf8tx6xxl45Y1OlY9aSloyzBEcHlZ6hv3CKqWY+t463lCN8hB6PXJT+N6PEE+cg0BlUxDdATuSDxo4BUHPmZgspcMmsgTW2eAw9eQ7yDTZ+E/f5+posuZB4ju0WGakiSq2LmlrhHMcufLKtGHOtYnQ/8YXY8d0ReBd3DD/eDJRqkcg5D+aSVZshs1eT3Eq+vujVkgaf2IeZT71vP4Ue+sOVdxc1vHUHdaW2BHoQIGWpMoyFNgu4EIYh10dT601yeEHHdUhehNrASrSkOhHvLUWb2XklLaA7HtbpRLb9puy5T4bVPQYWRhBhWs2o0dtlpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYfjDL9PGeI3DcxForMrgXCKiq3HzA+3qp3KGoHeIQQ=;
 b=ntdaBLJ4rIBazWnvn+CSfMpFEJqSjHLbbTrMVJZAZ7rbotNnSXFmRv2ci+H3DeUvfz1SP3SMWj7PTUNy99mgkMYSuMHaP7zVYxbsV5TgJQNTQkGzgBAghHZWM9tZic7IB0NorPEOXOs+Izz7KrwUIg+ZvhJD7bRJ2/ohdLNc7RhtbNXahr3axG2j1Mmj4XIW1x3gP3Qp7wXhFCfum2Yba53hZUbbPZR+rMsdE1ChFcVZCjG/ndXT/ZPtePAkY2V4qi+zszKKRWcpyG6OSo4ynkjKjs99ZdcSL0H+PsGIuPkF2EmfHMSFGv1eRuVjNmtm9yctSF5x09FONo/AcYFDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYfjDL9PGeI3DcxForMrgXCKiq3HzA+3qp3KGoHeIQQ=;
 b=Kh7LsKaPIDEOZAIVn2zO7yqYIOVZTMTAZYE0hpVBn2JzqX9ThLYZXJ55957/lSOIkLB0HkUCJNSk36cN5c+jZ3+Ytd7+Zh2Ud7MINUNO6049Qny32HQ2e8I3A21oIJyIZ8DoU4lRB3lQBwlnmRLFGtuABQQViKZL9bxLip2dSIo=
Received: from BN6PR19CA0057.namprd19.prod.outlook.com (2603:10b6:404:e3::19)
 by BY5PR12MB4919.namprd12.prod.outlook.com (2603:10b6:a03:1d6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Sat, 26 Feb
 2022 15:42:07 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::ac) by BN6PR19CA0057.outlook.office365.com
 (2603:10b6:404:e3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Sat, 26 Feb 2022 15:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Sat, 26 Feb 2022 15:42:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sat, 26 Feb
 2022 09:42:06 -0600
Received: from alan-dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sat, 26 Feb 2022 09:42:02 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/14] drm/amd/display: Pass HostVM enable flag into DCN3.1 DML
Date: Sun, 27 Feb 2022 07:41:10 +0800
Message-ID: <20220226234117.3328151-8-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
References: <20220226234117.3328151-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3fe54e0-85f6-4b7c-6aaa-08d9f93e8b35
X-MS-TrafficTypeDiagnostic: BY5PR12MB4919:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4919E87C1AFAC96116708A56F53F9@BY5PR12MB4919.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Kf8ogqrRNDrZagUzuCLW14AmwAhN2cEiS3l5ujlyhYTaNZeFO6PG5wXeg6yVE5FaXPlU3Ita8qfFBQI9j9oQXPFyavJd4EmDNonhMSpNXzhMZuhT96tCwgKQt9kyoyEo3a08fFRqL8WIvGjGDiZaIALzMjSP5DvZjIkETOgM95Sp5ChF//1d/EDYRyZv93ZISObbl1QRNrad5svMg8zSMMEtpc4jLaDh7Xle2pGxSkRny2STanhMI4lCAfDU7GlRy/vEBFhMaIU/akjP3IAOYT80HTXGlZDj5zmBjc8zAvOI7E+eEsQdPdVQvQdbuiuNK4TLBUZskdLyZUP35k618OlfURnReYganCXjsZKnuC2aA9JxU381mlfmo17ihPWf4IbEGNFtdSFQLqKhpYyBC6GT9c+1yK2PYFVHTB0b1sRpEO6oG0F2rgsjHrxOTxCSVmun7SFuLZYbdpsfm2Sat/K44tbde53TRY7VQy7bhBAcenuPEUdCTM45T3WwMUZrpTRsBpSBHbCcNVjQe74/8PkrjbZUkA6d/X3Kk0H8uSb3IUCsChZPtqwXuf8Hp2SnEzHNkS2ePl0360aKvoBcSN3q7VpQrlEzUcSLRVRaFJMuLCx2cCHIrrlcVjHnRhZsdSswmG202SUoeUhjcXB++J4dMmuOcBfIHVPN9c8qU0w8yZyjYr+f6zXo/kr/4QjzYu1/rwEbSBiKXiLCP+JBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(1076003)(508600001)(186003)(426003)(2616005)(54906003)(36756003)(2906002)(6666004)(7696005)(40460700003)(316002)(82310400004)(356005)(6916009)(70586007)(70206006)(81166007)(8936002)(8676002)(36860700001)(4326008)(83380400001)(86362001)(47076005)(5660300002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2022 15:42:06.7676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3fe54e0-85f6-4b7c-6aaa-08d9f93e8b35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4919
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Michael Strauss <michael.strauss@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Calculations differ with HostVM enabled/disabled, causing underflow in
configs with high refresh displays + scaling due to lower available BW

[HOW]
Check riommu_active in order to pass correct HostVM enablement to DML

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 28cd4f82529e..2ecd7bbfa0d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -1810,6 +1810,7 @@ int dcn31_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.src.immediate_flip = true;
 
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
+		pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
 		pipes[pipe_cnt].pipe.src.gpuvm = true;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
-- 
2.25.1

