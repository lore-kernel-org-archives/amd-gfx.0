Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E25C636D4
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5417110E2F5;
	Sun, 12 Feb 2023 17:00:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF32210E2ED
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxzy9dFuv97GK0ng0W9BKV8jyy+Mb/A3luSI6sNrlkHkE1IPmpQeEFiGXoerir9aSQGcmfdyAbxySx3Wnwj5hfnf3fGqMtzWl7Pz+ULizQi4owSl1ZorB7Wat/WO/9t4hXAA+G9AfqSPlNQl6FtHDyMTCbMTE32zSujet1Zyojxj/FPWW7vFWGxv9K2Y3TfjiKEmMvARKOz+RWcTxa7x08NlwHhPXopIz6Ldh5ZTKYdBRbKPxP7kZJCYTTxkvU2w9rAK7DTyPsherycL5jTzy/uycx6x6o3nTpYYTzuV4IBcfHidAfE9on0ZqMZnkO/+isAfZadfZXxsWddtI5Bukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6VpugIB8XflTTvxvhuoInKCQGb+uxj5XzzxI0cRb7Y=;
 b=n/ayOPvIKGxTG6OuwUnjX2rg9hrImHpTj/ONfL9JDqPRmq1or7dRX5c9eR9LjjsqmQrDEc/MICAz/lB8hEMkdyTJt/UV2Hy955slAJEi0YB40E5NQ7v7xxBBWAbHbImsi/D0ThsX9yYoKFMwgTVdszTUq3oTeM8R268n7yrafNoZZUJdkjP281pEdZGm9uAY5qbSHpKOld2yBuXvm3bwjt12AjL1RwKKHticZtBjouyTtujMHNrq0H8qFD+JxBWgXFH9hoouWYetPCXp8/HVtLrMyLjzs7hidvU0jDO3e3ub18FZn3I8PnV61S48FQEumv87i1PkVb4EiGHQnCLJFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6VpugIB8XflTTvxvhuoInKCQGb+uxj5XzzxI0cRb7Y=;
 b=4Xjldo9FBhGykjG25NLx9LCbK00UaTGwXDh825nOsI045ACd7MixiV/Xnqlo8Ic921gqQQr4XO9E+KWAXrAja9SN9PB0U9TYCc/awdcigdvJi8cHgVggWTH17YWP058QSjNlLg4JxMXW6SCKN/hJVUL+/WSKcWiEe4pq7FCx3do=
Received: from DM6PR02CA0082.namprd02.prod.outlook.com (2603:10b6:5:1f4::23)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Sun, 12 Feb
 2023 17:00:47 +0000
Received: from DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::4b) by DM6PR02CA0082.outlook.office365.com
 (2603:10b6:5:1f4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT070.mail.protection.outlook.com (10.13.173.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:44 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:43 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/22] drm/amd/display: Disable unbounded request mode during
 rotation
Date: Sun, 12 Feb 2023 11:59:47 -0500
Message-ID: <20230212165955.1993601-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT070:EE_|CH2PR12MB4085:EE_
X-MS-Office365-Filtering-Correlation-Id: b93bd295-6373-4f01-c318-08db0d1ab014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03jHuUKWe0m0hmYjKvI5xcT4dkda+1qMsjaZ1VUYFTRoJSwxUYpJzYtgi1kD6xG1+sIVg2dEPei3eXxFSBCBBq+U+EjXY7FCibgRb9Ec40VbcgvCjGYVwwzhnIq0WRUVpK8o8fBhk3gviUlora4VZQeGGAXQnkhThcnjLwpHrcUiUrF4VaGGliKQ9HXUuLnzTVZF1XL5xmQGwqCikwxnSPjsivxz/qzuvRE9E66sd0RPMMnorLBQ21K3Pqp9LW9njeFl75BFcRSr+zqwEIQzq9aVcPEMPh+jZY3N0+4dmvu8jPUMggM45o1nzUsMQ8T8WuNJh0b6CT8TfisBTYBeVY307S7eYghdMVV9RtemuBZdzAAyxttY8KaadpAJngzx94MUs9w2/jfPEv5BHvM6IxmQrwsXu7XgDFl0PR0lpYeXABX/uYbmX2wdc3LO5twmJI74+zQ2ZoatI3LmKGwa0yj8Lz6Gj8fVgWceYZ9tAHSlRHmcdWzVSMcLYPMFZpz99wppdmyzYhqnea8AgIzvcJeYkLJhfbfCeTSq5asWAt2ThdYFmA5yMIC/BY0bNnpUR/LZhtsWjuP2MoYbI8nbQFYh9N/i34Udw5vvJgMHVm8ILLAKxuQ2NG4QM91xrYFxBih8YCI4MQQkguYfRF89G0sMAPK63RTQQOoVVRFWWR7lBNNh00Y+UyDpRsCWdH7TAnPj/0Tk3R6Q295q5nX1L3s5gXmKsGNCbHZBHo2/hMo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199018)(36840700001)(40470700004)(46966006)(82740400003)(426003)(82310400005)(47076005)(86362001)(316002)(44832011)(40480700001)(54906003)(70586007)(70206006)(41300700001)(36756003)(8676002)(4326008)(6916009)(36860700001)(5660300002)(8936002)(2906002)(83380400001)(40460700003)(356005)(1076003)(81166007)(2616005)(16526019)(186003)(26005)(336012)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:47.6737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93bd295-6373-4f01-c318-08db0d1ab014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085
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
 Nasir Osman <nasir.osman@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nasir Osman <nasir.osman@amd.com>

[why]
HUBP_UNBOUNDED_REQ_MODE being enabled while the display is rotated (eg.
going from Portrait mode to Landscape mode) appears to be causing a
p-state hang, specifically during full screen mode on the Tiktok PC app.
Unbounded request mode doesn't appear to be supported with rotation
configs, hence disabling it.

[how]
Within DML, modified unbounded request mode to be configured only when
the rotation angle of the plane is 0.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nasir Osman<nasir.osman@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 6a1cf6adea77..a86a3a9fcdb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -346,7 +346,8 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_14_DEFAULT_DET_SIZE;
 
 	dc->config.enable_4to1MPC = false;
-	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
+	if (pipe_cnt == 1 && pipe->plane_state
+		&& pipe->plane_state->rotation == ROTATION_ANGLE_0 && !dc->debug.disable_z9_mpc) {
 		if (is_dual_plane(pipe->plane_state->format)
 				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
 			dc->config.enable_4to1MPC = true;
-- 
2.25.1

