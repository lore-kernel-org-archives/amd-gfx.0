Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BB6C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B78510E61C;
	Tue, 10 Jan 2023 16:58:33 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A87AA10E61C
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NvHTlSoFP6BfM063UTRTpfQZtz9TMURAanTs3TAoULQfpldTIWXPQR31GqxxdLx8fz2YdpIJ+ixzWUH977NuOFq45gCmr3x9DyBVjMmoEI9Y8zVG5s0kJSzmy81Uq6KwRHrpTRODvjNw+dAOCGVclDQ2eXcIOwi1V+ca0SmdpVQRdVBRJizPOxnMNl34Vc7WM4QSNg3k/V/lZm48z57HAvagRAvO09EezvGAHUm/vL2mvnJAWrJ8l8yyAZpuaSU/JXvxnvyn2HloG8hZjXlgq/l3p0dR+seky+0ZcUy8Azd+92Q+XFg+dyomphhucbFm7xmwd50EnHdiYb3IvxJJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV/65BhA8PFmm76aL6UvKfWxchtYt89jr8BRAIEMSlA=;
 b=Rp3Pcj1WnqiBW9BlQJZ7K/OC3ixoCUIPKoWMlrv7Eugi2+8dOXS+uWLt4cYy895u7vNrwy3JnnQhFVGXQKfpeMDHD2dhPOB1MppOFxBYd6mLaqMpQVu7xfAARb/DFOQWBe5tnArhd1+pCAr7wLSSmZ0kfj/4mG6JO731iP+/wPt9XxSuEnCRDhhOSWydmLSJ3Ln8xj+G2ofj9ksso6D7ZJRZMghNdjxP85k470ehBW1K2X39O8ntgYzXOfec9R8a8CHmf6gytoMTiCcWMTk6ua9QHo0WxEfN0xN1eaMYdYPg3wlRCt/sAKx2LiGKnqMc1OBUkWJ0W+d6SjqFQLpGew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV/65BhA8PFmm76aL6UvKfWxchtYt89jr8BRAIEMSlA=;
 b=tOC+eDOae9oOh6PRpjGoundLLZmzh4YlgeGDcUh9zvYqok4StCoRfvgHOECGUsc3B/ovE9LpOrGGovoFN1TvKWtWer+DtVvu3a1eNYXrqiqFLI4tzOl8Phbj/9yvG19SG7hnxjsvBKOEEMDPTvqBLcC8O/H69hDZjJD0gx8pXJw=
Received: from MW4P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::8) by
 DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Tue, 10 Jan 2023 16:58:28 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::ad) by MW4P223CA0003.outlook.office365.com
 (2603:10b6:303:80::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Tue, 10 Jan 2023 16:58:28 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:26 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/37] drm/amd/display: set active bit for desktop with VSDBv3
Date: Tue, 10 Jan 2023 11:55:24 -0500
Message-ID: <20230110165535.3358492-27-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddbd483-21f4-4e85-61f6-08daf32be591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zPCixnyDweL0Uu6H+/qnpP3w7U3PAMa6BlwMSpVSkV0lA53NcqSci5+jN/LucfyzFMsj+FNvsHlPPgHjOOEolOcKny3m4TO7m+7KyrEM8LTdS3DLSYZD/Ao7zd9KZknid73/9t6ZvDCOWlKLoiCiVZxXfR4GW7u+qJ7GXgemgZ5doQH/g+5J9o3nGLSQ06pgwls1yjFTjsLKtDK+Kn49ycJuG4DGZTN5+jlXCp2F/D5YTQJYgvB3/bbvoXRvOOMkRL60mrtfokWHhEetnQQBtFBezhU2Vda76V2Kv6+cOiEoFJYgPR7PZhZUhIzWFS0w3geh4kiUUtctmNaT5XnFs1D3FZ0NE6JZuhrJ1MdzZ3QXVOKwO51fXRAcxZMLoeH+UIB5O001erL8N51xpJwscVFir1Or5CSYcEtITANiBF102HCTy5vU4gG/ycyzQ58B7aYF/LH0id4fbMoU4neVz43mvAYWVffnZ22Im80Eh/TQdXrMFxCY/wexFWm9+ZlC5iGFONPNy7CVW43qa1oezEbtlurHWKuGNEB1EENhA+V1Wiq2DrE19qPu/2KCkkLqNCdps91sZzj0IZ81FlS7sVZA6/RGciM8EiPQtNjkeEitm1U65legv3fTFChYetj35qiRui0ngBQ88CWMDCOBJ6drp3vXNBMR5T0IM/2V8xK/2j9I/QF2dsNyAHSQsWlM0JxlOSvJ98D1Qj5xgcWwIxPtDI5DLOteRB8b2iNXMig=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(40460700003)(47076005)(426003)(41300700001)(2616005)(54906003)(316002)(36756003)(336012)(70586007)(6916009)(70206006)(4326008)(1076003)(8676002)(86362001)(82310400005)(36860700001)(356005)(81166007)(8936002)(5660300002)(83380400001)(40480700001)(82740400003)(2906002)(7696005)(26005)(478600001)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:28.5281 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddbd483-21f4-4e85-61f6-08daf32be591
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

When using freesync on desktop, need to set freesync active bit for AMD
VSDBv3 infopacket.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../amd/display/modules/freesync/freesync.c   | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index e61cfce9f77c..315da61ee897 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -616,7 +616,8 @@ static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
 }
 
 static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
-		struct dc_info_packet *infopacket)
+		struct dc_info_packet *infopacket,
+		bool freesync_on_desktop)
 {
 	unsigned int min_refresh;
 	unsigned int max_refresh;
@@ -649,9 +650,15 @@ static void build_vrr_infopacket_data_v3(const struct mod_vrr_params *vrr,
 		infopacket->sb[6] |= 0x02;
 
 	/* PB6 = [Bit 2 = FreeSync Active] */
-	if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+	if (freesync_on_desktop) {
+		if (vrr->state != VRR_STATE_DISABLED &&
+			vrr->state != VRR_STATE_UNSUPPORTED)
+			infopacket->sb[6] |= 0x04;
+	} else {
+		if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
 			vrr->state == VRR_STATE_ACTIVE_FIXED)
-		infopacket->sb[6] |= 0x04;
+			infopacket->sb[6] |= 0x04;
+	}
 
 	min_refresh = (vrr->min_refresh_in_uhz + 500000) / 1000000;
 	max_refresh = (vrr->max_refresh_in_uhz + 500000) / 1000000;
@@ -902,12 +909,13 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
 static void build_vrr_infopacket_v3(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
 		enum color_transfer_func app_tf,
-		struct dc_info_packet *infopacket)
+		struct dc_info_packet *infopacket,
+		bool freesync_on_desktop)
 {
 	unsigned int payload_size = 0;
 
 	build_vrr_infopacket_header_v3(signal, infopacket, &payload_size);
-	build_vrr_infopacket_data_v3(vrr, infopacket);
+	build_vrr_infopacket_data_v3(vrr, infopacket, freesync_on_desktop);
 
 	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
@@ -952,7 +960,7 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 
 	switch (packet_type) {
 	case PACKET_TYPE_FS_V3:
-		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket);
+		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
 		break;
 	case PACKET_TYPE_FS_V2:
 		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
-- 
2.39.0

