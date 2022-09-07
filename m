Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BBCC6FA86
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 18:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7365E10E817;
	Wed,  7 Sep 2022 18:12:52 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4676A10E80D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 18:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deT9b6qS6L2xcuP+D4aZPQZUn1FaLEJzra0Fd+ELZdHawL7XVGVda8grnTal/UKVdiNmy2tx/20JmW0AqQN30SNJv37bwxHMmtnoJ0BEEz3544p39op2ar6pYmuQ0IWH9CT1VQR0RAiS+osEYinCfN5pr3VJ9R2if7K3Fn4FconiAW0l66S6TLqet6kZbQKJqubKh0d36cCyIG7nb2IHMSY0Gn3pc0PjROrSl1PN6V41MSbqXtu9vhQDvZL5x9KHSpeoNGVFDCnT9oEYUpmqtGk641aMS0uMdThWz5Ce5dA5d+F30mHtW6701wM/iZqgP6FfKbFGYrn+eMOewj3OFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hoVswvtiEyh93+/4p8omm6zLPW0WV0tPTZkZgk9s7wA=;
 b=V2caVmKbqYlR0Q9R89fSvm0WtJ94/7TjUebHC8m5sgXsJT/Pt3DRqe2IyeyNGRp9/BgNyP3zguZ8kVcwBjfZjEl8P/05R5z5gUYWo+eyRcRtYalEB4dFjgxievjaFe7KjIRul2gjieZxQNNOxIgp6e2vsoMM0Urm3/O6hkxZBa6yKom9m+Hnf4phRwBcQPmnohm9smv4Byp+LWonQOW4tM9Co3ZAhXXLWMUedDysnRdoQuDnVkm5B68Ah53eiNo/mFA1CU/36iiKbAz3doQdiVD+JVpa6vywlNG8teS5tlZEGanzSrM8Pl4kEVIBT3BbXtzmR5nL9Nochc1o7Qy2Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoVswvtiEyh93+/4p8omm6zLPW0WV0tPTZkZgk9s7wA=;
 b=sp21Zgu+5YZFEVLYFpZ80RQ0fcRyIOhF+QU06AGyinpPFnXQ5t/Lbj7nRTspnpJiE1PkBUzBRFVviZu7heKTs2c//Qrg4EcOlq9KwntXKlCQcd6aTyN2DE14kCxVtgB8Ts6IGzWaFYC2LsnUid4/kAMHfOTD1tkXTy4CMm8BXhE=
Received: from DS7PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:3b5::35)
 by SN7PR12MB7298.namprd12.prod.outlook.com (2603:10b6:806:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 18:12:36 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::91) by DS7PR03CA0060.outlook.office365.com
 (2603:10b6:5:3b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 7 Sep 2022 18:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 18:12:36 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 13:12:34 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/21] drm/amd/display: Avoid force minimal transaction in
 case of surface_count equal to 0.
Date: Wed, 7 Sep 2022 14:11:57 -0400
Message-ID: <20220907181200.54726-18-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220907181200.54726-1-pavle.kotarac@amd.com>
References: <20220907181200.54726-1-pavle.kotarac@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|SN7PR12MB7298:EE_
X-MS-Office365-Filtering-Correlation-Id: ef012705-fa2b-4d17-0600-08da90fc8b0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0o7fAv6UYuITkrqPAKabj1YDK2WItrynzTFo6CZu82RDLny4IFZUFY7WB859ArqKXAmxihaHEOSegC1t8kLE6I2KptJVdLVslVpX03dh5S1ccKhiOvEzOYtqd/X6M6YnmP0odqYKXHsSDGitYyLpqLr9TQXnC6GFuf1ayufd4sLz4vEvhdQfugHVOgjt1JTu9piNtLd+kivMLyhN5eLMKdg+H4MlsssxSQ90+coyuvowfWXwLyvjMiugQdy9rqho1XuK4r/FP0XEZ7LmLRu4D0LimbEzUPD4nsdFbcljbzbYoynEnNW1PWmmLvQrd+0Hz0RU2bPum2xstY1PoQ2l7KvlSdqQ4i71/zSwprW8trrDKqORFvLXLwzYKnIQKzcMlksYRS2v/3OzhqVe508AJUZnRUSldRdU5YXyrrQZYaW7iP76+6RcVKHSw4jAAM/it5FkgH4NvuFJ6H0pZaYCvlkhn+EXXjObPSVOP6xHlTpvHmPggA3iiQeyRIST//sZShlvYlk6UrUHf4NosZKln5OP/CjQED30WTFRT0NlKKyiXMrIyifocc0u5zMdPzJkNgLNvxW/2vjxy/gZfhvf/v9V6KQCeRtdS5t+ANXJ/VfVTcKKgZTLRty+KSfC2BpTlhWsL5KbTdrGz8+kVH4AzTCR9NvlllfCsB8XLk9LrbhVtZhZSJXzSzv58lm3OtHLZVQNOi2jq6NBYi70OLwGzfyHMrmrK81bl65bueXD8LD2otqs2nyv7+ANeAloC/vJDB03cMv/6WmjHIrCIcd9F3sbJEWcNFE6C61drpLXIaisfTIWbDXxLIxpafUvx1zl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(376002)(136003)(346002)(40470700004)(36840700001)(46966006)(6916009)(36756003)(316002)(40460700003)(40480700001)(47076005)(41300700001)(1076003)(16526019)(2616005)(336012)(186003)(83380400001)(426003)(54906003)(2906002)(81166007)(7696005)(82740400003)(26005)(6666004)(356005)(44832011)(478600001)(8936002)(36860700001)(70206006)(4326008)(70586007)(8676002)(86362001)(82310400005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 18:12:36.4584 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef012705-fa2b-4d17-0600-08da90fc8b0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7298
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, JeromeHong <jerome.hong@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, Pavle Kotarac <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: JeromeHong <jerome.hong@amd.com>

[why]
Call commit_minimal_transition_state wrongly in case of surface_count equal to 0.

[how]
Add a condition to filter case of surface_count equal to 0.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Pavle Kotarac <Pavle.Kotarac@amd.com>
Signed-off-by: JeromeHong <jerome.hong@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7481801c6d7c..253dc4e35ba4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3625,11 +3625,13 @@ bool dc_update_planes_and_stream(struct dc *dc,
 			dc->current_state->stream_count > 0 &&
 			dc->debug.pipe_split_policy != MPC_SPLIT_AVOID) {
 		/* determine if minimal transition is required */
-		if (cur_stream_status->plane_count > surface_count) {
-			force_minimal_pipe_splitting = true;
-		} else if (cur_stream_status->plane_count < surface_count) {
-			force_minimal_pipe_splitting = true;
-			is_plane_addition = true;
+		if (surface_count > 0) {
+			if (cur_stream_status->plane_count > surface_count) {
+				force_minimal_pipe_splitting = true;
+			} else if (cur_stream_status->plane_count < surface_count) {
+				force_minimal_pipe_splitting = true;
+				is_plane_addition = true;
+			}
 		}
 	}
 
-- 
2.34.1

