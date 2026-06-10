Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1954BCD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D3310E891;
	Wed, 10 Jun 2026 09:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pHexr9+d";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3F410E891
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:52:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZH9ECCiTUhteuqqtpNQK2UhKfhNER4CEMATosHjq0daKLU0cJ0RE36lXi0cLhR/oZgNa6gCQchni06vsxDsSyviEoRookXfIVUzORoEbcEnY5rmsxR9PPfovAElBICZXaUc1tTw1F3SJugVV7jpAcjrzYiD8VSrmaZcxJnuq/craJVXa5CGudPw+ifGqETcExlCXkmd5kjVDy8w8H0D0SkphQRgc8bpeQPGYZaCpu3h1iUp03lf965SaNTFq01acn5UJXFKg+SukSLWmk/1GjfwXbxpMRLXALpVCpoFHcVcb0kohaFeYTJpeuS0qwRiaEY8MpL66ZmygdcPlK927lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMuUlJdMC9OScx/pXs9riSXmy46hmoRqXV/ytIPmROg=;
 b=YVNL31Vx8+RcEqyKKxsQdZYfht/rI8vaHO2+WNudOAiETtR75bH+al0KuT4gLYNjAX2zunRVHkdAL42rmtYNWBY5COBw2Fb2mYjTJka+LQiSstJe63fmhPu8g1WNQfK2H1p2ahUtzvG8UfoQKpqhrcXVYyGDnnRa+gf0YEz1EZTpMvtEU3e/PnwBpqA2qlqhhaQyJ2kGN4y9oeKEMawRXua/6vSoonyF0SzeJMwnxwvUs/xI1/0lTcM9uc/XjKXSWeM9fc0oliYbi00DQ41jRSB3okWCpcZ5ZImQ93Xnt+E7ARMiI97X2qVCLsx8Y5pJ37ZHGhZNUFvrUd5MOV/ApQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMuUlJdMC9OScx/pXs9riSXmy46hmoRqXV/ytIPmROg=;
 b=pHexr9+dn8csHz+iW3/ZvGYYBNfhXZ6dptgc7HOQUThXc2ZWtUMAGQv47iL8HGPusrfuei/cD2mYew4SgjXC/sd1KZ7fc8cEhrZILm4MQDRR39LI3PMJ1gJRWsFn4ej0Bxmhlj2RRWQAfx337h0ry9T0Lkx1ZZ5n7c5C2N4UZ0s=
Received: from PH7P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::24)
 by CH3PR12MB9394.namprd12.prod.outlook.com (2603:10b6:610:1cf::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 09:52:27 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::3a) by PH7P222CA0024.outlook.office365.com
 (2603:10b6:510:33a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 09:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:52:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:24 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:52:24 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:52:15 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Edson
 Juliano Drosdeck" <edson.drosdeck@gmail.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 29/32] drm/amd/display: Set default backlight without ACPI
 support
Date: Wed, 10 Jun 2026 17:45:13 +0800
Message-ID: <20260610094639.1965367-30-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CH3PR12MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: f92131ef-0b6e-4fff-8e6a-08dec6d5f991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|13003099007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: rNMvIu657jwFJYWibUne6HcJDqLj3e4Q1nOHdok4tVt81CAt99DM0CmE/csO6RAu60FN8EJyMMfA1NEZz9zPD9qKVhG5bjg/v9Lod8mJtd1QpywpWvEUK8Ptc+GOfUPTA1fRS5uC5U/EBYaJOvUYOZjfIEze7UbU1mI+eFiN4FcV/W/4omxrhU6FaGfHD7H69dBLppjemdu6/BRLmkdgdQZHay/GsbJ15QqJgaXrn0cYBzmfIEjAEPDnU85c1U9KWd268CfQxUh54bQdp6ulRM+4gO+uQbSH6MgsYpbmuiufXFDZDhnrhhBLq/8L/GvGXgdEe9sf+5L0X8fSwRkwh0AjfGy1P0dkaJoQxz2SOB4mjCm5afHjRkaT6GwshzHqz6BcFNiPdnr/9GPmfFf1PE6znoX9c289H8/EUGep6X+110MWXi/X6desZNWOk1Jli0M6yLYMj0kxG53MfQtnxG/V3yt8+YSy/iAD7fg6lnaXTSUE5tkCu7wY1I+iMv50RkkgnmlNO1aGBqiQrTMeDOlufZ9cEYW9jIqeayTufsdeGL21lQqU4uk0blvKcymHrqg0aaanpU8X9SlT0qQ1kzSyqsZH+owQDswDY5u5KjElaYOk2wnDWy8uF3CvG2A44K2hnh583UKjHMqN/sKtgOZsnkRIxtWX4WfveelpUaW7n1BL2PFj3XToHdCQO3kNUh10DHZqvbBMx/XE8117GbNrQBBadMSo5OAkmzuruAE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(13003099007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FKyrYZO2M936k0KRLVBHzoagLL8fj1mTKnhg/Wz0NKiLiULpHcXAHwZX5y+etwOPa/Skqah84i7ckJ219frnzCWHrHGgVRvqpO4QfkrPesZq6tKEVuc06EoqUBWIUB6TJlR2l7q0E9JM6xuOJAdF5xJqrhXitFRRDwdftOLlkYuipP9BT+pJ2m0KPRUhkZe16yfopJ5qiVajPQ0ffzG9OmC1+B3piO7XLwgEGPwBaeWD+oqZ2+nKjSXG3Xpqv5IZKGwIr7Zt+bV8ZeLxgDxFaWPBxS8GPm2RDDfsCs4CwFPH6JqPU7bMu+9dI37d7eM6j0WyMl3ylt/gh3SYMyUmWor32z6b4XPFGmNqMk75KkC+X7E6naPPkwQtQoPrffZ6HjePWnYiMIzvWsq8SIzTnn5h1ByqOQ+kmskJimbw3kq0RN/ANdVp75QhyEaho7lV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:52:24.9974 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f92131ef-0b6e-4fff-8e6a-08dec6d5f991
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9394
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
If BIOS doesn't include ATIF method it will not specify default AC or DC
levels. This means that backlight will always start at 0%, which isn't
expected behavior.

[How]
Set default AC and DC level when no valid caps found.  Also reduce code
duplication for ACPI and non-ACPI cases.

Reported-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
Closes: https://lore.kernel.org/dri-devel/20260526210048.1162477-1-edson.drosdeck@gmail.com/

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index f101aed75bb3..0a861d846677 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -78,20 +78,16 @@ void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 			caps->caps_valid = false;
 		}
 	}
-
+#else
+	if (caps->aux_support)
+		return;
+#endif
 	if (!caps->caps_valid) {
 		caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
 		caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+		caps->ac_level = caps->dc_level = 50;
 		caps->caps_valid = true;
 	}
-#else
-	if (caps->aux_support)
-		return;
-
-	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
-	caps->caps_valid = true;
-#endif
 }
 EXPORT_IF_KUNIT(amdgpu_dm_update_backlight_caps);
 
-- 
2.43.0

