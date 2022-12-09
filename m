Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C132AC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC65410E56F;
	Fri,  9 Dec 2022 16:37:49 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F6C10E567
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDe5+0CM4YJXC+llVtNn+ZRzXg9RUrEg+IV6Htnk7i1sJC4XuTzLBaOge3SI7xGekwf+GDEVpkD4ncTVyliMult/UlEyT0MvV9uOPVWzqattTcW/A+fYHHWCn14Q0nstTZriMCo4sKfpXRAKN2ZjCJNe+Ir4Jvx519qI5qPLH1j9HoHULIWAcJw0NFMrI1wr98vOoTSXu2SPGm+MnoT9OwAbSupp1RTi4Dz97ZfyCvFCvGp8mCKTvBMF32F1vnIvcHTCryXmJ2+lB5TUik2RMt1IobN8XiTc+ygqHZaPCjOrHcNNYU14yNUaij8Wvg/wPbHG78zEeplrQD4mKOJwmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEeUz37u2cfnAxUDVmDwZF9b8HRkW0KuqGTgDPxwUx8=;
 b=lRXoeLbxLufAIc8WPrfwY6eoOdgdrcrXMFm0EmoZ1mY+H0NehyiVakDONRqBiJX7Hitm9C2S/Ssk0r1aBXEH0f3DTM7RRPSvYMgWo7i5zl0elz2KeKQRltC/0YK3u72Bpmx/MZhllCFj2LS1KcixifxAUpD9wUe6xXcKA+F5FzNdOBhlrp9MAIiJhbjrMqV4An2iCY5AOjntBajlVBa77zgcnUEebF+FewnVafck2y5HKPWsyV2fBeK1LOJAGs5X95oaqcn84If+B4Q7Qh1NWYU6psAeHFNjaNU4sGO0BheUsAATMuCmr5A6Fb86FbA9DWk1PCW6tE0NGtxKEYQjUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEeUz37u2cfnAxUDVmDwZF9b8HRkW0KuqGTgDPxwUx8=;
 b=Zf/PmwcfyGjB068ozbnXh+44jKM+VmgohtrtIJKdwTV8c8U5xaoLIfTRh3KNyL+0F3GpODzzs9FOdZemlwYSzpTGR85mK/sdcXt+mkxWuNO4my5JhgdH9dSP5vyoZdNKVwanIIxYIiJ+J8Mv2Nlwx2A4/gPLO8CKZ7TmTD8X2zY=
Received: from MW2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:907:1::17)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Fri, 9 Dec
 2022 16:37:34 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::1f) by MW2PR16CA0040.outlook.office365.com
 (2603:10b6:907:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.14 via Frontend Transport; Fri, 9 Dec 2022 16:37:34 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:31 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/23] drm/amd/display: use encoder type independent hwss
 instead of accessing enc directly
Date: Fri, 9 Dec 2022 11:36:40 -0500
Message-ID: <20221209163647.25704-17-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT056:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: af0d6822-629c-46e0-0feb-08dada03acdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2exr9cMABKJGiEAy9EPY3Ubc+ASmkUhZ1wsToX25RYDFkugek/gHGeurGMqrD/HScaAjIF4ojBDxptLwWhohZRWkIuruvzGKOQ5AQWO8eYbN8T7DVAOcyARGmooduUb8GuqHRuzgr3TUMf4C37EMLFS442muzisnKkZ736XmXqkA05YVvWx8NcRebq1ItLzLN0YfVhv3mJhG+YOudycRYDh+5QOs8ik4jk/HNejbLkgaiwYeJRdFDZz1svCH7DLdlxbqB3ZFerjNFxw9XKO0qkAFM3WmhfNbXKhGMDpZ1uj3ysPy3Vp7OEHkxm0vSGq20nXe0F8rutJRDdZNgfNHnBiP9JT0C+AoP63MxxNg/aKJBkgX+/KkM8XmwHBLPu6nxSGT4uqkNaMRqpJVLG0bNg0SycLbG/gdB2IJKKAvJ0Qga3rit/M8xbTvndqtgTb7sIFwm9YFPCFBkl+1l+/AQ25HgJ1eMSSPzw+4vCvFrn4El//j6jj+TSFDVjapWTMpKBSK9gUKdAjb+6zZ1OIlxFpGX2NWfTX0s1l/1JElQPYHlIP+1LzzhIlntWLET31WENlI4hLVCYLzR2NB4Jlf2OlFLMmbgixGZvM37xd4Id+fEWe+8u7tWBTs1rJ7rMfJjNWupb1C9tXlPHhaXkVth4huAp5Q8d1nm89cZ/gYc+zq7XsCXUPCpsr5Veux8UuBe9XkaYS0so8Y6GRjStJdL6Y9XcFq4l09ywxknlU5RA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(426003)(70586007)(16526019)(316002)(47076005)(70206006)(8676002)(4326008)(8936002)(41300700001)(5660300002)(186003)(6666004)(478600001)(82740400003)(1076003)(40480700001)(54906003)(36756003)(2616005)(36860700001)(336012)(82310400005)(40460700003)(356005)(81166007)(6916009)(2906002)(83380400001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:34.4800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0d6822-629c-46e0-0feb-08dada03acdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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
 qingqing.zhuo@amd.com, George Shen <George.Shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
in dc_link_dp there still exist a few places where we call dio encoders
without checking current enabled encoder type.
The change is to make these places to call hwss equivalent functions so
it won't mistakenly program a wrong type encoder.

Reviewed-by: George Shen <George.Shen@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c   | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 909434faf039..905642349ba2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -6137,7 +6137,7 @@ bool dc_link_dp_set_test_pattern(
 			 * MuteAudioEndpoint(pPathMode->pDisplayPath, true);
 			 */
 			/* Blank stream */
-			pipes->stream_res.stream_enc->funcs->dp_blank(link, pipe_ctx->stream_res.stream_enc);
+			link->dc->hwss.blank_stream(pipe_ctx);
 		}
 
 		dp_set_hw_test_pattern(link, &pipe_ctx->link_res, test_pattern,
@@ -7298,8 +7298,7 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			pipes[i].stream->link == link) {
 			udelay(100);
 
-			pipes[i].stream_res.stream_enc->funcs->dp_blank(link,
-					pipes[i].stream_res.stream_enc);
+			link->dc->hwss.blank_stream(&pipes[i]);
 
 			/* disable any test pattern that might be active */
 			dp_set_hw_test_pattern(link, &pipes[i].link_res,
@@ -7308,17 +7307,10 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			dp_receiver_power_ctrl(link, false);
 
 			link->dc->hwss.disable_stream(&pipes[i]);
-			if ((&pipes[i])->stream_res.audio && !link->dc->debug.az_endpoint_mute_only)
-				(&pipes[i])->stream_res.audio->funcs->az_disable((&pipes[i])->stream_res.audio);
+			if (pipes[i].stream_res.audio && !link->dc->debug.az_endpoint_mute_only)
+				pipes[i].stream_res.audio->funcs->az_disable(pipes[i].stream_res.audio);
 
-			if (link->link_enc)
-				link->link_enc->funcs->disable_output(
-						link->link_enc,
-						SIGNAL_TYPE_DISPLAY_PORT);
-
-			/* Clear current link setting. */
-			memset(&link->cur_link_settings, 0,
-				sizeof(link->cur_link_settings));
+			link->dc->hwss.disable_link_output(link, &pipes[i].link_res, SIGNAL_TYPE_DISPLAY_PORT);
 
 			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
 				do_fallback = true;
-- 
2.34.1

