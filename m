Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CFF606A31A
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Oct 2026 23:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MAxPjCdu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942FE10F8A7;
	Tue, 27 Oct 2026 23:25:03 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F3310F8A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 23:24:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKG815xZuZd1JC1KUr+jRRrPsZla0ZyHcq5Q5zTJhM3/Q8FnDMpX7/JHaEeYtiwT+FPmKYfbFcMOPTTc8GJFsROkYx/9kdQcqdh1p25Zef8GX6EmXxU/8CUMvEYf76JmHVA0Ju1DEG4/XUZ3gF3OpPNHHhB0shdo3I1cCM8m27JcoORlg/YJ73yy1qfhxwWM6jAiWAHxLY94l6FBpGMSWrRW3hwHJfqZNmoNW2Pz15iMAdYryWjRILNGIzPxWvR1FMvB/U1PBtASRbETW1J6IvYe1YwdZonddVS65zAqJwilhJ2YtH0irkyyGKHxSI7ydKgPdnqkqEcz2M3TwPn5Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xT+QpwV0WYdBD3vqPqjWt+Zr/5oMuQegJMaLq4qjdMA=;
 b=Jl3f0vl0K4qYNeSiu8+hurS41sxVrAdSU2PeFqZAIryxcwx6woWV3QUw452K6SyqOXm+kqzoAqiu+ShLHDi12z4XFA2JWTqlqpIC7uDIU/RKYt0BTXm/qFHzYBtaGwqvSySn0tRT16+ZFOaJUfE00QutE+/RPCcFOZ6PG8N1tCkfHBNiMOgsTYI/7sRxmyoOGo6WwQSNAVHXc00t5MDmufmXCA6j39BZ4bx3D+HYDPkNw2nKy8M0dYwuGNaSJNxuvg/Yn/GQh0vZ5hdzupVNLyRqvyguS5WeQ4LpduyCBB+dM6sijbWBxvLofHYjLhRjQ+xVpyx9pV12rQRA8A4zSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT+QpwV0WYdBD3vqPqjWt+Zr/5oMuQegJMaLq4qjdMA=;
 b=MAxPjCduWTqImX664O0h2/NXEiBMpH7Axjqvdv/y197SkRtfpvSD47Vw81o9ZOF+mJ1CpJXwL42gSAi7kLbLaT4Oe37mUY35lH5gfUVdrvZsc7rxY9pXmUQpzEhglhc1UspYUSf/b5wdYcDJ1bz/yvZdMfgz4EZjeieoLJdU43Y=
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Tue, 27 Oct
 2026 23:24:52 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::8b) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Tue,
 27 Oct 2026 23:24:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Tue, 27 Oct 2026 23:24:52 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 27 Oct
 2026 18:24:50 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 20/28] drm/amd/display: Enable immediate restore for FAMS on
 DCN6
Date: Tue, 27 Oct 2026 17:17:16 -0600
Message-ID: <20261027232005.2879750-21-alex.hung@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027232005.2879750-1-alex.hung@amd.com>
References: <20261027232005.2879750-1-alex.hung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: e8a0a7bf-8af9-44b2-a5a0-08df348180ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|11063799006|56012099006|261009223027099003|10067099003|261021121427099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LTxYwy3GTC+REbYy4CVRaj8Z4afAwkkBzpEW7R6+J7/qIe77V79ArpDE9io6rIndEMTx+lR/z0DXr97bHGkVjaH6SCEa1qkCFj8Kff0iysbdNFs1EpcDn5nE9xo9oRcXhQCrgUZrT0yJEsmSPRWpcxHQfaySmzJUE35v3UwOyPIpmjcfXekg4GrDp7OGpE1Zt66HWZBolNi+mLQ8QG+tTxp08D8soXmJgtOSDgKpDtvnSptJH+Pex7rE8AlSKsNvL5VTYk7diRrv4an4un/kZmvUHkWLIpsaLo2X56qCXEnyh6tESaPGi13FBIYDC+is5yATkSjHApCS3Xn4xKiO42NV2CIW7tiAlXbQicG1r6Hy6Ui+8k4SiILw82kOHhZZA0413YbzzzVgtIL+MSekf2AMfcu4ofJdm4Uvo2W1xLarDeLbbW59EAhcByvCEF1NL5P+v6dxIcAlxwzaeHdCOjn2zD2zmWkYraeiys3WISgiBbX06LRB2bVVS+QtolgqfiQeKPafXEQavM3XB6Bm699oE2JP6KhWsN1qm5CWwYunfjCfXeiItSrQN7qtrXsOJDO/59zH/y5KtJmwbFcy/G44CT1TnEXPHrplO17zuJzKFO49Efs1Rza+kF4s/8wK1WYB+MuiLaU3Br5CsDBqXhH1z/PKRbukVwAROfCg3zQv2VMu4NzcyLWmZLYM1bRyy0tk10ara7D0TWYm/6Ovag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(10067099003)(261021121427099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ehxh4a3eU7nynNDMYym05hOvGp4gEJ+3B2RihQEp1E7cDuOmjHADx33KSjRIAeSNlI0PDndwOxv/fYYAb17yteCbonS8Fx9y+mxWpSIjmzsxr0dEe5HileiS92dYh8+l+uNGcthGAzQtInq+D8GqXPMjUi04G2Igc84q5/Hf+jKyyXSErP7fLuRXrRFYtCjg0GrvbA7TVItlnCGWmW9igDi1Gn1aEPSKJLvuIJuUztP5/BFMQE1/RnFfFM+fXbhBpOL7bP4iND8mpxMe9ONJdN+thxCgYjsKOAVHOnfQ5hegSj7tpYrBqEbdssXaJKl6iPG8ZqZa8bsQrP5xVhhXUgSbLto6NpoRB6yXcJLULA81xxQN9btWrJQe1+Xjl1MWRDQdRfVf0zdVpLCVu/rdQmlFxrnicO9GDKHxw+RUs30fXTSRGgKvzT6oCGXTyAMj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 23:24:52.7882 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a0a7bf-8af9-44b2-a5a0-08df348180ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

From: Alvin Lee <Alvin.Lee2@amd.com>

[WHAT]
Enable immediate restore for FAMS on DCN6

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c  | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index 50b7779a6ce7..b46b396f45d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -721,6 +721,7 @@ static void dcn6_populate_fams2_programming(const struct dml2_core_internal_disp
 			break;
 		}
 	}
+	base_programming->config.bits.imm_restore_drr = true; // enable immediate restore unconditionally for DCN6
 
 	switch (pstate_method) {
 	case dml2_pstate_method_vactive:
-- 
2.53.0

