Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63C9E776F4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:24:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597F910E351;
	Wed,  4 Oct 2023 09:24:05 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A03510E34F
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:24:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3deNn7lW3QKSzLgf42dEF0FQzX0P6rDPi+6f0tYZwYZxrqixYkJU+UltT6jXRPzYoGoeTnqdN82hAfAHqpfgtWHAilmQBLaWzWElY0rQy0N8biTE7AZxwIqSkzaGHOD87HHZXcj1/eEgrhL5/b0JiOvaG7fio9OrJ8iZ4bPuMB4XMnjBqTNqthI2kwvJnfBNA7s7Myx8umfQ/JxcvqOLX9BRr6EkjSNAZSE04OqBeDPnoxwJzJyqBozTbPeYIrOWXJoY33G2Cq03z+8+RuU3/SDGSVGOgcXkqovIRNm1aFfsxcDGytqoH2GtZB8KC7hsBhBtfBSGKxvI94yhTs19Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wO+NsDbkkTzDMmcsAr+uqB9nFzgp5ac7Y40gHOmgDc=;
 b=ZC8JTiv9y5UVxFiafQJlQGIPPm980sxIZrtWgl7k0+bf212YZjWJMDVrwtf+IMiVLEEAZCYzYeXB33SBHRk/Z1HF7gIWDkrHDILhUilHwUWe6sIR5mEWM0hdNvZ086fA+5EFoHPzVTkcvrNk3BXEptmNbD0gQXOXDnbmc3OisEcxHI1EmBEpu+7xhiJh0PYOZWTF8MUJ/jRohqmzvzzorjeP3JhugeiSbruyTpJs/Inrl+Sm+8WbZQkBKvgjWwFWRrl9NtaKLb1kRfKcOR8IUfwkRzmxImlp1gcUIBWNOzxnIpy5EsRGSDHGq3gs3qHhd2szkmX+BB9Ta5PnEsCJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wO+NsDbkkTzDMmcsAr+uqB9nFzgp5ac7Y40gHOmgDc=;
 b=KJHsLpusYk0/mbUPXyAtILmq5pnMAeGfimNn8IuSI9gl+CJ1OYNZtRaDke/aVxR0Dz2Edga4Evx16pnIz7cpM3mCGlszHUysu1q5X+hGq5u4mJEqDX2xlF+GCpd0PGYtjJp3g5lIj9KCVchN5l+guzRn82sq0L8YO3N4N/bpv44=
Received: from CY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:930:10::34)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Wed, 4 Oct
 2023 09:23:59 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:10:cafe::c0) by CY5PR16CA0022.outlook.office365.com
 (2603:10b6:930:10::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 4 Oct 2023 09:23:59 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:23:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 02:23:57 -0700
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:23:52 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Update stream mask
Date: Wed, 4 Oct 2023 17:22:51 +0800
Message-ID: <20231004092301.2371458-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: cd72b76a-6f55-47b5-1b6c-08dbc4bba433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tol/zvhwZ7TycVt4Pi2+/njEt74T+DnMP1VSkeW+qvDOx9+ndOl5wkUuQWEY/e5VXbZw7BrlvKtY6sa/b40tCP1ram2GAjkSRp5W5JqxjyNdWncyR0YLE3c7gPTuz0cBHZIxI9/ohLsOuaJ4wQxojAvN2FHFqz/U1RPI5U95ZPLNgZayn1Wo+qHZ7rEGdDa7v3Fhnu3x2oZvmgL6eHQ4p1nuKIZTWdFE+8e/QwNiTvSOkMSyA59lfkvXYcxIkFFobn6txF1Van+ACwDxA1sK/ML4/gYes2W8wYcDaanpin16EOIaHfs+iOKbcjYq/xkzIGdtG7lHAjp6hcxAdGLUrm/hZfCrlKFqLjDkoSq9c0ZhSY9k+2DEOd2ePoWxCtF7SHlivBiwUEKZHQzfbzT45wS4eYYNRXtEwnaJbyiovCigSWTB1uyrqp6Du2TTeYnOlxDTOBkxigadCs8IrRWRY5YnQIUH4DIkFHGvNajUUQwAV4rwBpDwjI9WT5u5GrvDtJP/OQJDuF2O49LD5Ew1DBL0Gv3kpza99q2SX+mCns+5MZvzAqHvmpXHEEAH1s1F/eGF6MdD2ssnq7DkB36D//7PtEX2bVH7CJ9gCt9pTnojz9+awgHkQaikShND8Q9th8IzokAzKJbM15DHm5Ufo20BRx7Qmhtr+d6n8MlO1jczOkm9CJW0eUmrqWGE30XkclAC51VMMkZtHEXa2zSPJr15Ev9BJBAGBoFjV6vqgpvXzTGNTgmvXGrLWI3CZ4mn+AiDv4ulTMtKPAEpFjf6nw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(7696005)(81166007)(356005)(83380400001)(478600001)(40460700003)(426003)(86362001)(36756003)(82740400003)(40480700001)(1076003)(47076005)(2906002)(36860700001)(8676002)(15650500001)(41300700001)(26005)(54906003)(4326008)(336012)(70206006)(8936002)(5660300002)(316002)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:23:59.4704 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd72b76a-6f55-47b5-1b6c-08dbc4bba433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 chiahsuan.chung@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Duncan Ma <duncan.ma@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Duncan Ma <duncan.ma@amd.com>

[Why]
Whenever stream changes because of new
pipe arrangements such as ODM. The new
stream mask is not reflected in DMCUB.

The mismatch in stream mask is blocking ips
entry in some scenarios.

[How]
Whenever stream arrangement changes,
update stream mask and notify DMCUB.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Duncan Ma <duncan.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 17a36953d3a9..825f275ea9eb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3561,6 +3561,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 	bool subvp_prev_use = false;
 	bool subvp_curr_use = false;
+	uint8_t current_stream_mask = 0;
 
 	// Once we apply the new subvp context to hardware it won't be in the
 	// dc->current_state anymore, so we have to cache it before we apply
@@ -3910,6 +3911,12 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
 			pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
 	}
+
+	current_stream_mask = get_stream_mask(dc, context);
+	if (current_stream_mask != context->stream_mask) {
+		context->stream_mask = current_stream_mask;
+		dc_dmub_srv_notify_stream_mask(dc->ctx->dmub_srv, current_stream_mask);
+	}
 }
 
 /**
-- 
2.25.1

