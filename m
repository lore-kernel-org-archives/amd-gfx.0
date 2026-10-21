Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6C2606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l+bU5KyJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D1F210F92F;
	Wed, 21 Oct 2026 06:26:13 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85DA010F941
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:26:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDIxN6XEHr89VGUSPNAalWgWHwJpt2eL36UCteu0VLukkYGKoZ2u4qIbdgMEQxo2ZtgPm2t+rlCfTBYtmp0eA3U/8whM1TQoGKs1jWM9qEiKjETNN31vqTGP0LG1/ycYX3x9WefZMrYcMlOcGgI1UbMw9Oret5NzQuTHTEUBxnyniox2YI4+5DMtYllvBdJloSQiD5FEjsSoG5MsP/MPo6G7sypvB3Z5WCYUbpqUoL7yAScYtTsB6aQEnw1W973+MNjjIcgFlR9Lmj3FmJ2psgTwOo8wLbbDCbmsCiOab+q4u9+UH8t8QYIg5HSh2um/pAjvIeBV8W0k77DmPRoQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSCbpXoAntPoRfsI2buJvG/iPMjkbV6lPLrVpHWFQ8w=;
 b=ikzB8pNAgFcGWcR+a4kmzo6c3CBx7ISVGIwrk9X+toWCvkrclOUFfRtfEUPNkRIH/kxOvao1QZ+hCUT+Z+gGrm+3izGaD8wNc7o2m6MVONubw7UoQFZyJR4tG/i5/oQvJ4mIvvfW6xlNUmecdcwlTxwGnXqHq0KoiI+nm+Ge5EwPEyPYOiiK58JsnUV/jTfvA/c/bnB3jUIT1csN8ZMAaju/aAXHcaV9G93gSR9nQdx/AqprYa3nJYUNYO/713Y21ZwcxDRPRFrV4BKjPbJDY9gpSDqvD/BMP1+MvrhcPrB8YDaU7BBQWtmUURwDXjeMT5p8QhpFPgfC7cEZIg7L2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSCbpXoAntPoRfsI2buJvG/iPMjkbV6lPLrVpHWFQ8w=;
 b=l+bU5KyJnaerGBQ2SVCuhaUk5Y3uczQsy+w/9rV/gdLwpDOdf7XPwpFGPSE+GJAxApjx0+Hxx6IS7iJ7sBN0afHVPfOjZcS5LMO4BiljxNtaA0jU/70FPx6iTaHr4vwc+c6q9t1ikoIQv5sAkn4xAXghhvpzE54hHR8PCamfCxA=
Received: from BN9PR03CA0915.namprd03.prod.outlook.com (2603:10b6:408:107::20)
 by DS7PR12MB8369.namprd12.prod.outlook.com (2603:10b6:8:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 06:26:04 +0000
Received: from BN1PEPF0001854B.namprd05.prod.outlook.com
 (2603:10b6:408:107:cafe::1b) by BN9PR03CA0915.outlook.office365.com
 (2603:10b6:408:107::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 21
 Oct 2026 06:26:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854B.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:26:04 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:26:02 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:25:58 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <Matthew.Stewart2@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 11/49] drm/amd/display: Reuse mpc401_read_mpcc_state on dcn42,
 dcn60
Date: Wed, 21 Oct 2026 14:22:17 +0800
Message-ID: <20261021062519.674697-12-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854B:EE_|DS7PR12MB8369:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbebc82-ac74-44b7-10e8-08df2f3c2f03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: MgM1OYRL7H/3K1wWt2zBg3KFHc+lTqGVtMuKOYap/QlHVvNEcxKYSHQPgQGnYirn68g++NBDfgzd8NK2y+9ao7YANqki3lLwrEyLOydTiLcfc49K1dSBZolb31uMAGv0FWGaN1vjJk5yQn7o8dYT6ZWD+CiUwkx1ynibijfyu8l6rAeI94I0ywzl5lAEbUsFU0UbReqHuULWtcbqQq7fPYAi0NICKjt86FpltrXJ9dFnyQCHf1d06VS7+sXYmgOuIvWbB682VTqXxnAPtyfK+QTZ1Sz2Vs1jH6J9r8rXpu4zUtOnZRt9s204/pE0HNj9SPPm0p/8EZS0oehwOiXqRTni1t2y1RpfJpinr1K0dvJg7efr+tdwH3IGsTsDFqfcFxDzeytDrnVXiRdMnKBnVUp5WYSxycAMK/mqZLur7ZF++Wd2Q8aP5g+wahTvvpR0TBJ97ZFnd7H3KTbUA6n0xmfKb57l5ugOMv0sje9SqxdM0oSZDUDgmIWGvuvnzbWev5pjFKPJV7VlaqwWKoOY+7JZBSI0E8Usg15PTytMazJQoEIcFoR+NKmUWuTMUDbbBXWMiIO0McKv6GK17+AhbrgIyZ/9XhZc6ZB/tEAPwxOclEq5Vgt1KU/OfVXQreajDwIrOG6suarOTPpgEuZnYidYZVfeSaLvHcZluR9OK3/OezEt9LZiPyXVqC0ypaaFmCrnXB58sfehmjaJMz+1Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2/7nqyQnjVXU3tjxnL5PCTsL85E8APQukDyNPHvucsmocKGb7DTs8Ramav3o4IuwRO93Dw+MWcuNFR4sc2KgHN2QoCyqfOD9p/MGKgAs/UdACJ2E799F3rcDkCyifApO8Dt4FV3o+XsX/fE6OhMyMtAp6jovVmrwFKRAZvxzJ7jX4fkamgmTlYPe91316jp88bTNqpYHEJ/jqGPXk9yxFdPvqVspw3dgfPDHt48xXUlyZZyZ/of0xe0drXkFJsBVevmfJL6ijEZ7spvR/EFntBDAMUi8kEQaPQIyK9yhOSRP1QMmiqoh9K5M7isxwqV3WemkdkXITf5yKgAc+bo7x2biH/1JRTp+oU/HFgQGPXxTuaIt5UjS7srwuRjsMN0oFK/8iYx0mFQm9/KpNQJvGBizTXEIGafgIzIv58c9gQiY3+o11eCREVaSkkuC2aiU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:26:04.2752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbebc82-ac74-44b7-10e8-08df2f3c2f03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8369
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Matthew Stewart <Matthew.Stewart2@amd.com>

This will populate lut3d_mode, lut3d_size, and shaper_lut_mode so that
they have valid values for dcn10_log_hw_state.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Matthew Stewart <Matthew.Stewart2@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c |  2 +-
 drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h |  5 +++++
 drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c   | 10 +---------
 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c   |  2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index 5f5c27eb1d64..a485db71c166 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -627,7 +627,7 @@ void mpc401_get_lut_mode(struct mpc *mpc,
 	}
 }
 
-static void mpc401_read_mpcc_state(
+void mpc401_read_mpcc_state(
 		struct mpc *mpc,
 		int mpcc_inst,
 		struct mpcc_state *s)
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
index 75fa05ed2b22..2731045f277c 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.h
@@ -275,4 +275,9 @@ void mpc401_update_3dlut_fast_load_select(
 	int mpcc_id,
 	int hubp_idx);
 
+void mpc401_read_mpcc_state(
+	struct mpc *mpc,
+	int mpcc_inst,
+	struct mpcc_state *s);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
index 37d024cfb3fb..f15690b026cc 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c
@@ -65,16 +65,8 @@ void mpc42_update_blending(
 
 
 
-void mpc42_read_mpcc_state(
-		struct mpc *mpc,
-		int mpcc_inst,
-		struct mpcc_state *s)
-{
-	mpc1_read_mpcc_state(mpc, mpcc_inst, s);
-}
-
 static const struct mpc_funcs dcn42_mpc_funcs = {
-	.read_mpcc_state = mpc42_read_mpcc_state,
+	.read_mpcc_state = mpc401_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
 	.mpc_init = mpc32_mpc_init,
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
index e38582f0a319..89c4d431a82c 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
@@ -229,7 +229,7 @@ static bool mpc60_program_3dlut(
 }
 
 static const struct mpc_funcs dcn60_mpc_funcs = {
-	.read_mpcc_state = mpc1_read_mpcc_state,
+	.read_mpcc_state = mpc401_read_mpcc_state,
 	.insert_plane = mpc60_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
 	.mpc_init = mpc32_mpc_init,
-- 
2.43.0

