Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66528C021B2
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1527A10E56C;
	Tue, 25 Feb 2025 06:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EbPp3O6W";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7E010E574
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:38:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ueLE8Q0WFpAbsd/qGUXQwXLOy4l7H5gXC34HQnVdLLfdIcFpNGvWZdx9fq8fwr81UokNT9W0PAQwbJitzcex8HPPM1v6jM1meA/7z00zSVGb6NU1YPxpwHZShxpZTZsjwiFO6hiIIQvZ1RnQNy4Vctadeu85xZsH9koxngDhJXnI9CwZUlIJCo6eQD4P2Kb7w+y08KxP3SR+5xLPc/ibboxkcW7wN19FzVPEVd1obduRJGPcUxDL4pCB8bXPdAyO51KL3oDM712NY+OiPWpdmg7Km+MNSd9ON2yhKzwt+UlPecrDn0LpLOYHe42ZTdZeePudPtEt8sAxXTnwpXoviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNq1tcx3dWRzJZoqEqmJ2S6FDsHAvbfYWDZXpUJthlQ=;
 b=c8YGS8ruXx8ZqGpzGkh1trMmcpfV8W7+c9EXroBn7823lQCWM4Mva75zqq49m5R3uTc6g/OPZJSLyfJ2kOJF6tL1eYeIslEWdDEFw755RjHB7hE/2rmywcVuKO/+9QZtzGl5Jbtd+LeRMymYeqqcgju/acLvI9CGjy9MlCJ6HuSvLQmjrmiON2lqChuW0id/zsW+2U4mIJh3AtoAmikqq8ajaEotsYsUUSaBbFau1omFDRHLwO1nL4RB7pRNrpk+9bCJf9xAUvw/hfbv66HqekaRbdKDZHKApRiPKCLQZJNRQiwkQisfF+TTE3GSinMmkN1yEFYFgdJYlRRzm7sGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNq1tcx3dWRzJZoqEqmJ2S6FDsHAvbfYWDZXpUJthlQ=;
 b=EbPp3O6W32KkcughFYuLgC0+HfdsOWD0JGNMD+CsRMWFggTDdxM1Knt0HWFeYSed1gGB67o3kYPAuqimk88AQM+XZ3V8UIK2i8Z4ISgSG8qKuI5tqtAOQK72yvMO/7/zELayvCFqnYZdZOwYRDo0ikL/6fXynheTDNQahciePk0=
Received: from BN6PR17CA0038.namprd17.prod.outlook.com (2603:10b6:405:75::27)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 06:38:32 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::95) by BN6PR17CA0038.outlook.office365.com
 (2603:10b6:405:75::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Tue,
 25 Feb 2025 06:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:38:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:38:31 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Feb 2025 00:38:27 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 24/27] drm/amd/display: Use _free() macro for
 amdgpu_dm_update_connector_after_detect()
Date: Tue, 25 Feb 2025 14:36:07 +0800
Message-ID: <20250225063610.631461-25-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20250225063610.631461-1-Wayne.Lin@amd.com>
References: <20250225063610.631461-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 827630d8-260b-4c74-1e16-08dd556705b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A0tI8pM7pZwIumUHwu6J9j2grJhQFMdgRucWd+7B3bSUt5YAMiTLGHWEUWtQ?=
 =?us-ascii?Q?bRSw970dpNCuJuwDm7O22J6rH7pUEXYrs3zOeGl448Yo16Gvf52S6fJRMsR5?=
 =?us-ascii?Q?Ued6cJfNGalFQnS622FE+Sx0aEsb+Xa1NQNGpm4O0rxKLxwag3wwtCJX3gln?=
 =?us-ascii?Q?Ls7ewjZfl/Pw/cXG0xfc9U+OCxx0UgYSMdfrKTI1T0odl2kwPi++56qArnX0?=
 =?us-ascii?Q?5OfqQoreV6kS0sl3H3oH9Eh4EeMUQEqG2Na5qLV4kSXGZieqcDA7hT/G7pez?=
 =?us-ascii?Q?5cMopBiay8k2qm1BwYx2tu9boa0XYYbo4lrKgwbo8ysfC6NTH9J8rl9juUJk?=
 =?us-ascii?Q?ePyKmxP195yxaS5g9UVR3+Tweo600Wy6V/tKZ44eXPAPzvjVGlDTIc5n0OIq?=
 =?us-ascii?Q?qU7CgYWF64XLyPDReJpbPn0xTZ5ou7kJez8koH439XMYxxVym+yexwvBOBhg?=
 =?us-ascii?Q?wJvIQSkd4gI1UlJOMXuX/B0mJfcAzBuxwxdaO79+N1Nf8aAKmz9tSdr7Qgh6?=
 =?us-ascii?Q?JIVBqyhGNhzd30X4NVq2ZrbniPDtwqFZvik8kAaX916QBezrCDcjzRImnVXF?=
 =?us-ascii?Q?Eq8AMc6O2YAhSjA5m4g+yMIlfeeHdMNiZs9QzvTg00REOofrNnND1Vvrmmpw?=
 =?us-ascii?Q?K3Kl4g00ntfVss5GTP+s6GMLmwo8xeODOZHYeAf+vJdLeykZ+rGg76M3RMm2?=
 =?us-ascii?Q?6xcgZxO10VyupUw9AOW5r2UmFQ5cDjJEzBliVpoDvHZa9EDwfrsxpNNH7ZBr?=
 =?us-ascii?Q?hRo/PF+7iOfRGvoenhLUCknQ9CPzqQhDX7ViX8J45mHc+NxAviQZnPbAyGoL?=
 =?us-ascii?Q?WrjcLu/s5a7JEX4xUIZJMUE0dY14y8RgELuPilHpMS6T5SH1IYKUnf/HaDb4?=
 =?us-ascii?Q?2KD6jLi3KAkFNH1BjWlNaAi7xJSoIrniv6A/0SS1l+fxmm7V0WqFg9QNBcQ4?=
 =?us-ascii?Q?EN2OCkXW4GXl0k0+WOqSxbvbvTecpH6IA7zIvYJppXNpPW6ItppAdck7CkDt?=
 =?us-ascii?Q?u2XwaGHnlDbYZd1Rk7OeFy/YQ3Rx+C8RVXCKN3Blq0iYBQZDf18DWtxCnBdl?=
 =?us-ascii?Q?Wik37e+HKgWiRHnpQcmJNIu0ra7IUvvuopI5FF12Uzb/sGYqOSO+BX1o2ynh?=
 =?us-ascii?Q?2xZzPxcwzseysV88nA1LSi9Mnz6HNGCcOcMhjmetEnBvYwVmncynPU641XBm?=
 =?us-ascii?Q?r8wJwmh5qBvWmUwIR1rtS5tlymjfnF+jLLG9YxhCJT+rntRpH/UPNa2Z/CTp?=
 =?us-ascii?Q?O+6QDMKymwCCSYd8EWWDJQKWDVVIsVRSpD7oXiOYZJYYVY+Zsm0q/QjQq5Dv?=
 =?us-ascii?Q?CIYLi5Phej3Li8e2HidlBWjxO0HfVNOMXAMhtlizyD0RtQ5HdOeg7pNlzvRm?=
 =?us-ascii?Q?7rHtTV8+lOQvAA0NMJl54GHdH/koXE6XPxcjjeLC76kfG8KCNkakE6dO1w6f?=
 =?us-ascii?Q?3xo5eo28oU968QLgeC+WizrePk+eI/abH95rXplBK1puLBRpw50ZtNh8x9nt?=
 =?us-ascii?Q?uL1LjxG2ylLHq9Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:38:32.1495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 827630d8-260b-4c74-1e16-08dd556705b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592
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

By using a _free() macro multiple duplicated snippets of code to free
the sink can be dropped. The sink will be released when leaving scope.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e0cce4883148..b6fae48a9599 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3646,12 +3646,14 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	}
 }
 
+DEFINE_FREE(sink_release, struct dc_sink *, if (_T) dc_sink_release(_T))
+
 void amdgpu_dm_update_connector_after_detect(
 		struct amdgpu_dm_connector *aconnector)
 {
 	struct drm_connector *connector = &aconnector->base;
+	struct dc_sink *sink __free(sink_release) = NULL;
 	struct drm_device *dev = connector->dev;
-	struct dc_sink *sink;
 
 	/* MST handled by drm_mst framework */
 	if (aconnector->mst_mgr.mst_state == true)
@@ -3698,8 +3700,6 @@ void amdgpu_dm_update_connector_after_detect(
 			}
 		}
 
-		if (sink)
-			dc_sink_release(sink);
 		return;
 	}
 
@@ -3707,10 +3707,8 @@ void amdgpu_dm_update_connector_after_detect(
 	 * TODO: temporary guard to look for proper fix
 	 * if this sink is MST sink, we should not do anything
 	 */
-	if (sink && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
-		dc_sink_release(sink);
+	if (sink && sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 		return;
-	}
 
 	if (aconnector->dc_sink == sink) {
 		/*
@@ -3719,8 +3717,6 @@ void amdgpu_dm_update_connector_after_detect(
 		 */
 		drm_dbg_kms(dev, "DCHPD: connector_id=%d: dc_sink didn't change.\n",
 				 aconnector->connector_id);
-		if (sink)
-			dc_sink_release(sink);
 		return;
 	}
 
@@ -3790,9 +3786,6 @@ void amdgpu_dm_update_connector_after_detect(
 	}
 
 	update_subconnector_property(aconnector);
-
-	if (sink)
-		dc_sink_release(sink);
 }
 
 static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
-- 
2.37.3

