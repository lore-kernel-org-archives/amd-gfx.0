Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8D1C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 682B510E61B;
	Tue, 10 Jan 2023 16:58:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31ADE10E61C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDj1ITakn7FsYdHR81oLDjorY50bo4pXZvLJV3etPKMoVGVkvQT0bwQVwWszsO0jQONT4cuNQt0h+5bLt/UyusfWE8L+mWoOujnbbXbNPAq9wlSh/n5Vex6baCaRLuPnpV+UPSXwEHM7BcrZT2V7VHudLKaAfFfVHawnqBpa16rnSBWToAagKI8QGQ+mN4MtEGnnRlaxf0NkBK0qb2XiSsKQUK4dNIPiC096BTgtZKe1zq2y8oFPl7bzY/2XV/dNFKdJDA0HZmhiZs2NJ9R6c2GFI0hHdiOPchc5122wYDCbXWEL9h2gTv3owa2/Fk6A6bS4/X44d7xp31U5AVEeiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WRl7y7egr+YbJ4S4QwE2DEoM4tFNOAXYt1qHTdn4V8=;
 b=EEFnki7xoDJ1I6XSAJ7+wPdut7XNyu2TJEHY3/RiZAqhYmXmuRv0qolpvmVhUyuGEGWRkpDArAbTByf6u41u6q3oss5s86SHWONkk4sYirl4N0lcqMOpQBlRUGDwCWgVepQGU5FJ2Y5sFemQR/59i7/h8FsWZJL42/wAZ/K8vvmTs+PJZRGEC03R4S02ZJpY2w8ap/murlcbjShFuNCgyYGKzvjyaBivTRKU9PtDcj88Zcz/Z/qmKCXfCoZSCwVLH1YLsCl4nk6MbvapzBGY1BX1/ZFhKYmDOVZUFvUpMvgo4gLmaGbIDwrdiQSLlgj6Sc9XfNTBT2PDBbFQMNQkyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WRl7y7egr+YbJ4S4QwE2DEoM4tFNOAXYt1qHTdn4V8=;
 b=MFGtNrfZR++OFuMejJ1HVj3HIf9m2Y8i7Z7OHnyFaA/3y+P6ASHNyQmqWrhfxbMYbPzDu3or8A1Azaa/ye1OnezK1t3gIgWVs5aArz2pTj+uFbQjvqpF29R1sx0gojF2vsDOCW1xRVBBAcdrKco/eHxnvxbF2ckhuQtnRCnwZVg=
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:27 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::70) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:26 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:25 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/37] drm/amd/display: Remove unused code
Date: Tue, 10 Jan 2023 11:55:23 -0500
Message-ID: <20230110165535.3358492-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT058:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c7e7ae-eb45-41f8-663b-08daf32be46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeq7IMTyQV4H/vs5AMbyfLfgAHzBkGgD1nlIKzw4KZHjyIUQYvY8nObcftVqqm4V5ElW0EXI1YlXLw558wyWzbMiHPxMujCz4SCcracVjj5ZZ6EfpUXveSCfTi1xpdjr6FbhoNYJw/Rzs5wsdIBOGAWIYDsFCddttuwLLP7cB00hD2lUuXvD/cVncHARihmH1QmgxBsIvm0IOoXQL8dS1oCj3WJGQPnwmZdraM7P/K+448JYO/FJHcogUV73NWSW6M8d2AAwgXMesbiK9yMBUEoRfPyyI+NNRR+bXlqayPVStSJwKOmhnj62dGNkSf5qnN/FwlEOmtHf+HsZKXdGbA2aNUI7hlJscQ3N8LurBFNJmLWx2hKXJYb63s7uspdJyVee8zZbFjbyTGrGLyqfZv6xT3OqZIa5Rmca2dIF/ieqqZ3sh74G8w0ftodJwIXlDxJPi6uRh+5ilb5qotF8DVOcYLlqcC1fP8/A1CtKvXY0IUGihoFN9C9yp1z7gl/K4nCcL00Fkapn0PgGlT/HJdTFs2V3iijuGT/+0wkzZHWAVN+bN0aGqacTPFz/s02CJf/js/l3VWN7+ff3agGzqzlYz8SrBHqy3Sr3dU8YsiSuKoVv0aGLk55YsMSclTE+PCnyDmcN7WSeGwnoYn8X5HXXvo4EZFyVocj1xM2mWgvU6l+KuS6FbptMI3JEwhqWMw/sV0viNqq8JDhrSXuO3VNXqpiVPtr4tNrvwn6cHR8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36840700001)(46966006)(40470700004)(36756003)(186003)(26005)(8936002)(2616005)(1076003)(81166007)(16526019)(7696005)(5660300002)(40480700001)(6916009)(316002)(40460700003)(4326008)(356005)(86362001)(82740400003)(478600001)(54906003)(70206006)(41300700001)(8676002)(70586007)(82310400005)(83380400001)(47076005)(2906002)(426003)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:26.6236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c7e7ae-eb45-41f8-663b-08daf32be46c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove some code that is never used from freesync file.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 44 -------------------
 1 file changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index c2e00f7b8381..e61cfce9f77c 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -898,35 +898,9 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
 
 	infopacket->valid = true;
 }
-#ifndef TRIM_FSFT
-static void build_vrr_infopacket_fast_transport_data(
-	bool ftActive,
-	unsigned int ftOutputRate,
-	struct dc_info_packet *infopacket)
-{
-	/* PB9 : bit7 - fast transport Active*/
-	unsigned char activeBit = (ftActive) ? 1 << 7 : 0;
-
-	infopacket->sb[1] &= ~activeBit;  //clear bit
-	infopacket->sb[1] |=  activeBit;  //set bit
-
-	/* PB13 : Target Output Pixel Rate [kHz] - bits 7:0  */
-	infopacket->sb[13] = ftOutputRate & 0xFF;
-
-	/* PB14 : Target Output Pixel Rate [kHz] - bits 15:8  */
-	infopacket->sb[14] = (ftOutputRate >> 8) & 0xFF;
-
-	/* PB15 : Target Output Pixel Rate [kHz] - bits 23:16  */
-	infopacket->sb[15] = (ftOutputRate >> 16) & 0xFF;
-
-}
-#endif
 
 static void build_vrr_infopacket_v3(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
-#ifndef TRIM_FSFT
-		bool ftActive, unsigned int ftOutputRate,
-#endif
 		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
@@ -937,13 +911,6 @@ static void build_vrr_infopacket_v3(enum signal_type signal,
 
 	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
-#ifndef TRIM_FSFT
-	build_vrr_infopacket_fast_transport_data(
-			ftActive,
-			ftOutputRate,
-			infopacket);
-#endif
-
 	build_vrr_infopacket_checksum(&payload_size, infopacket);
 
 	infopacket->valid = true;
@@ -985,18 +952,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 
 	switch (packet_type) {
 	case PACKET_TYPE_FS_V3:
-#ifndef TRIM_FSFT
-		// always populate with pixel rate.
-		build_vrr_infopacket_v3(
-				stream->signal, vrr,
-				stream->timing.flags.FAST_TRANSPORT,
-				(stream->timing.flags.FAST_TRANSPORT) ?
-						stream->timing.fast_transport_output_rate_100hz :
-						stream->timing.pix_clk_100hz,
-				app_tf, infopacket);
-#else
 		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket);
-#endif
 		break;
 	case PACKET_TYPE_FS_V2:
 		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
-- 
2.39.0

