Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96387C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699CE10E89B;
	Fri,  1 Dec 2023 13:29:39 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2365410E89E
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLSb2PDVNIHHxg7SJ1lmihOmIs6o03Nr+uqwoGsBPqK7KWmDGIoQ03kjDvaz1tBUypNC6Rt3vrRQMleTtiNafrJD4qOWxJY2TuLnz8iu5Y3/Dflm+tN5STSqZAuqYT7aVILoZBiXzlcpyDG5gt1HixxdRCBM7KRM1CFrgIe0Gts9jjICQsWJRgoMswwIDnfEHHcE5ymU+dKcuL1ABGDR5YHw0hGxNqKoJgLzjN6jO2T8GppUkEa4Y4QyE8lFO1c4K9jdAz57VM2YAaSxyEVcJx2dkxkR+KQVGpPCet8c/JhhGZOcvOgZLHli3i3nOw1H7DdiN7SkzgCuF6PW/cpkhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ktdnv13nvmmUVRSKnKyv6XaKzR52V3FIkqmnHnuIS/M=;
 b=NKgKadOjyBMEifoZZrgsbPoEsJIRUeUrxSwB4mt0GPo863RPMMD/zrMvxcVzMhmYaGF/Rks+Nf4R4U4dpYwopKrrpHBt0nm68c/MyDq5DqJfsq3Bq2dGf+qY5elkLaeq+VqAGnIy51qPBoFXrSbCPyzYSsgOfoCSy4c185DDYteeKEETR9FusnfB0tsiCo/AZFFNyhuTKJmLmf7xCL7QiBfbTm/6n9zfXtEhdJWUfY/WM4CC6/EAhrA5K/KR00c+OFX5tNsx2mu75mCkx06TV3IaIAb5Qk2LsMLQlEFsMXSJYEWugzZcEQz9WWOAm+NJEYmoed1SP5YtUqBEnSVEdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ktdnv13nvmmUVRSKnKyv6XaKzR52V3FIkqmnHnuIS/M=;
 b=noy1f3azKgXdFr/4RjNKlhPnDmisWwwoGdgIcq0+4vJdTVslRri2DxMLc8TqA/30FOX9OOy4awbnRG0yYFAdCt9qjRi0D0jaPArJQ/4foFDMBqZ76hCmsRrgQx/PKj+z+LzTOXqCZWHdv9lqbrlE081dCHxMKXiHquZF06YxewY=
Received: from CH2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:610:50::12)
 by DM6PR12MB4482.namprd12.prod.outlook.com (2603:10b6:5:2a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:29:23 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::bf) by CH2PR16CA0002.outlook.office365.com
 (2603:10b6:610:50::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:23 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:29:20 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 37/47] drm/amd/display: Fix writeback_info never got updated
Date: Fri, 1 Dec 2023 06:25:33 -0700
Message-ID: <20231201132731.2354141-38-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|DM6PR12MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a70d78-012d-4bc4-8306-08dbf271886a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GKyBgndieOcBlx8Bce1xPGrCnvUZMIPmkXB0WB+5Mw196yM2uDyNY00E7C0f3XKZe/cgbgMe9UCxNS/7wazQ5d7YIzNk5sAhkRFkC43qPKHnaZ7xeKd9o30PzlIKyYIKe7hkXwTKJkh0hBX3uEt1DHCCAVxqBlLKTfAEsw4qHqoaqXqvjQUXa1eZWzUFwVBgj0GmVDVHQh1sbgYRglCaXcdzLFHTgFo4zGGZrj2qr/cY8Tok6ID2LQJxd+2Kq3KIU9TQwZ8P/PNqtgsmKfYVmNWPZaxjSz/SXjBrHAhkuKuHT1VyURjvm6+YA8UD+MnELLtjdk8lUbRuauww+WRf0ANBItajjW8chFb51uN3ennpScMAAut2g8DRU9dUarJWM8oeNy7/uHvFgO7BdGzUFF6N8c1LJgRHjRxbHTp94bup7WTgqdatlEFmZiJz1Igk8itWpLR8VO2u9FUxlZOXCSk+AWe240nD3j6g1CJxQLFwDHXFCUl4CUIQ9sQ/mF+bKqxCX0uPIiNs63AwTjUjq04yLg7E/i8DIrzj1c17TZM+IC/K2QVrAxsorddrpDkOMldUfYFjRhnAgVbbV7hhxmTbrtrBT6Dm0josoNHRU1Jw9UeNKC5lPh1VqK2Nx/n1v7GVbQpqqJSFafQlgi+rjFlV4TsJhEg63AUvTfETbTFcBb2XXbJMJHSPC4o+JqOgJkXT6lQBzzilPtzY+gyo+aRmyg8f9T2XnidiaR7QVrjkqH2tukRawl3g3mT3Ki3zDVXPKh54ffB83bhbH9TUEw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799012)(186009)(40470700004)(36840700001)(46966006)(316002)(70206006)(70586007)(54906003)(6916009)(478600001)(40460700003)(6666004)(15650500001)(5660300002)(41300700001)(36756003)(2906002)(4326008)(8676002)(8936002)(86362001)(1076003)(16526019)(26005)(2616005)(82740400003)(83380400001)(47076005)(81166007)(356005)(40480700001)(36860700001)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:23.6183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a70d78-012d-4bc4-8306-08dbf271886a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4482
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
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[WHY]
wb_enabled field is set to false before it is used, and the following
code will never be executed.

[HOW]
Setting wb_enable to false after all removal work is completed.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index e71d622098d7..8e7bc4a30f27 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -509,18 +509,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		return false;
 	}
 
-//	stream->writeback_info[dwb_pipe_inst].wb_enabled = false;
-	for (i = 0; i < stream->num_wb_info; i++) {
-		/*dynamic update*/
-		if (stream->writeback_info[i].wb_enabled &&
-			stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst) {
-			stream->writeback_info[i].wb_enabled = false;
-		}
-	}
-
 	/* remove writeback info for disabled writeback pipes from stream */
 	for (i = 0, j = 0; i < stream->num_wb_info; i++) {
 		if (stream->writeback_info[i].wb_enabled) {
+
+			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
+				stream->writeback_info[i].wb_enabled = false;
+
 			if (j < i)
 				/* trim the array */
 				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
-- 
2.42.0

