Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7193BC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB32610EE69;
	Wed, 26 Aug 2026 23:34:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JWVDg22A";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012016.outbound.protection.outlook.com [52.101.48.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68E6510EE69
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qvfg6Ed5EdjTTd4D1ptcKxqjxwUDzI+AFoneyZpEYLTf9X2zbo2B6i1ObIWMX0y9U+JLnnRMJc5XAqqmZ+U7VGtwzYMaqPqpEbCSJJUhnhUjX7u0VQkl6J116gNhqCxRoa3gG+O5DBprlKY+d3jdC1vUwMg5oB3EjzfDpfvRcyoPhR9HalstHoksEn2lgP9bCvYv2HSZ2YM/fn2qDzf3efkukHwlaJ4xJdvtb6CzsvJFWwdxsHPg7jUIa1pYMjW7TcKAvTSIYmCQXAqxvZviWHgbFrgttm4Awlt+9TNbMns5JCBGg2GVELlMj4OqO7X+bWDH+rcI/7UPt7Nb+nNElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7blbGYh1BN3pUFyur39xMUYAJJ3Ggv+zXubIAw//0FM=;
 b=Wt8Dq1XRvudnzvGpoILhsJo1w42ebtP6pi0dKBNBryWvlmnaKBICaXi9uQszB1v3y7LNfwkzX8vzZpYsJZu0nobo1gtGfXm3y+YkwArc+tgO8/wQzvV27g/ohcEq9UT1g+CgSe2f25ZUGRIStvEf6zfr6UEfCLO+BRImUvIxYgULUWFGixJYcKc5rdLguwgSrU6IKnVIunk1LPC1ROlv9wmV9RW4wtBGJYNFDbuJpRjgTG0Hqcm/M6GU4zx9gWG4LhmUs+O/DFJqQC8yAj48fQfLUK5nitDq128R5shg9B/WwTrZsSimrN9JP8rcEcde7XGNv5x9shdAgg9OtHKRng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7blbGYh1BN3pUFyur39xMUYAJJ3Ggv+zXubIAw//0FM=;
 b=JWVDg22AzM9EKBDBsuB1ejiaVR1h+ntpwdM5be8EiNpRDjyDRF+ZEtzgCIz0IFCeuwep8wPCxbsnUZrW9Y/xiEa5CG6MvGnAE14ZTllnZGt8Aefy6i3cXkgGsvFmPs5RoAlB3R3rsBvEFwonO5YeSe0iGJGigPDKHf8J6bhQUnk=
Received: from SA1P222CA0165.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::11)
 by CY8PR12MB7413.namprd12.prod.outlook.com (2603:10b6:930:5f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 23:34:43 +0000
Received: from SN1PEPF00036F3C.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::81) by SA1P222CA0165.outlook.office365.com
 (2603:10b6:806:3c3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3C.mail.protection.outlook.com (10.167.248.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:34:43 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:34:36 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>, Hansen Dsouza
 <hansen.dsouza@amd.com>
Subject: [PATCH 56/59] drm/amd/display: Fix backlight control for
 luminance-capable OLED
Date: Wed, 26 Aug 2026 17:05:27 -0600
Message-ID: <20260826231519.881949-57-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3C:EE_|CY8PR12MB7413:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a88b35e-013f-4903-f711-08df03ca9b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: gN29lR02bt6DrYRdVyFLm5fihiSqwAqckcwXE2PbHl3cBIbbeY3YcOSvitGfCdIVr1j1Lt4bXFIEJhOw09i852xacfYCErqbBZKUoL31FItFjpeGWsfNPT1YMW/6oNoSE1h0jsOsGKifmxBoRPIaUcDpXBg3zQ0hHPVA6l+PYckTBXlXLB588hCEcttwpWCu1kh/i3KkJffgjlE80/3yt7v/l0rbf3iRyokgW0dtJ3bTe2ya5rWTCigyrwuTbXhATWWkwVdU5XD2f71hTI7RUkpXe+ZG45Vbbzh262PrQziS/EitcXl1LINC7okI6zJFj1Vr/6kfVNsoiihaJItHD7/hqSu0QsfMGH4CW75I5deUEQnBvLYyTSMWiQGFEsSwsC6N8YSJCxfz4RAN7BVnptqIf/9Qt41dL5rMT6wS49EqYVgWXDAF/0JArjcJ2TqdsmDwlSgfAnvkAkyvllkD4OF7b6DOK/j8PnZE0SbojP6Y1V0jF/p8yJcnTFxY9o3nW+9M/0MbzSTf84DfUd/imN0F6S8r9lImc9xHh45Sk7+COSCY+yqpfj+Az2dfhbMrdjRoxwdKhvfSKWoHluU9NR13E+4UVtLllnC6joDFUYyxmdbvgWLtGWAgzGZOJvwNVhnIL/edVlDZll+CMq5QKgaLEEpNFaXecb1EPskt0puIoP/XToMiDvPk3Mf7K1Cho78zvY4GS2RnQtoeuCEKvg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PBdQVqanO2iVRd7TMTRnNeitwGmEjvLHZxi2s4oBfe+Q34HdgpxR3YZVmWFYGdvu9Ysx5kYr2yxDmNk/DmCuz58j6A+JnCQorsbF5N8oP+m0w18JAmP6oqezULy05o6pwim3oQnfTYZQr+uSKBAop2FTeb8ftdSLgFleJbruB0pjMhwzgBZrH6RhlpV0WW2wkftpt68N3praAQhA1qMQ61C/ygrxzxRscx51Qylv3dd2gMf5mWiJMzC9w40otKvYG6jsnv41j5C8cJnxzFVo67NFYyv8j5V0I0U1FON6dBrux67OTiJOSmiSUZfjjznOHtiepdkZES+3k/vdL2/aFr8id7alAdIb8KLOmjVNDk+TL+JYeH/zZ7Xt4+415GaAJ0Ide/SVm52x4cPmG+ySe/y0KpySAuruwFelbAeGx+bMNvGmdLGKEnOoLnI1hJ5P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:34:43.4770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a88b35e-013f-4903-f711-08df03ca9b6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7413
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

From: Roman Li <Roman.Li@amd.com>

[WHY]
For some eDP panels VESA aux backlight control is necessary,
otherwise they stay black.

[HOW]
When AUX backlight control is used, select BACKLIGHT_CONTROL_VESA_AUX for
panels that advertise panel_luminance_control.

Reviewed-by: Hansen Dsouza <hansen.dsouza@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c   | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index a5ad59ec3e81..45e1732a5b04 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -543,8 +543,12 @@ void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	else if (!IS_ERR_OR_NULL(panel_backlight_quirk) &&
 		 panel_backlight_quirk->force_pwm)
 		caps->aux_support = false;
-	if (caps->aux_support)
-		aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
+	if (caps->aux_support) {
+		if (aconnector->dc_link->dpcd_caps.panel_luminance_control)
+			aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_VESA_AUX;
+		else
+			aconnector->dc_link->backlight_control_type = BACKLIGHT_CONTROL_AMD_AUX;
+	}
 
 	luminance_range = &conn_base->display_info.luminance_range;
 
-- 
2.43.0

