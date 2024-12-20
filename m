Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23260E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2024 21:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5FEA10F086;
	Fri, 20 Dec 2024 21:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="452j5AeH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3308F10F089
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2024 21:51:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBiQ2oxCun/VtNphl1xckvKLX7DFdSJFjA6W60/Es+isMik0k8W/6UpkDrUN+I5iwX4Qptv2MLwaMQrk193BxylrE6LxMdvtu7t2hq/M73Ksdnlr7nx4S7/Rh5scCEB9c6/dcRhHsKSV6Zzs71Ux/y6MA2Kd/UdC7WokkKnS3OA2A0hmLjunC4eeMGDEnv7Rdf3seBK/NTzOUAbtMU1HQl9XYsssbv6221yj+zBw31NdcWXx15RW075fGS40x1iwnq9YUoVDZxNWJ5PmC72vv4gPWy78zyU1Tk6lgi/CsigG88u8WPFeRDKRPf3NRmXSXJUERtge0tggayIuLcF67w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGLyAp6g0TLsazF6UiIJRa2zlw0rnHPCb4w1O3buVCk=;
 b=GP9hXwdyYY0KLxgRue6pHU9/nxh/xfmgd9zO/K3g7moFGywb30d/pSP3faFqq1AR5uZypEoMsSnhrqV2+p7IAGtghxLD4NE8hT9wx+cjO0ihbpjKCDsxT4WZiX9cDwfYn5gxR7GyUErUsJcwz0z8hmbU2ZUaS4t9SumEsiB1SeJv23f9E+jwAGnKg+EMixvNfQgs6pSaWxwkAPJ8y3amoeVckI/vLKl9Op0ZVcGOvAo6r/eyUZbbJU2mIoW7k0Os0T0KV88IaFNRSQX8xM4hAXiCu9SZNoKQ7fNvc6lcWchw8smTifb9k9a64vypaeY+A/IK6barNls9RGLiEMPOOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGLyAp6g0TLsazF6UiIJRa2zlw0rnHPCb4w1O3buVCk=;
 b=452j5AeHk6Jghz0jWrmgzde5uWgsywBpeAbdAhPc9RkfEfaDJvOn+ezsnv5rB9av/HDliT7m69cklM71cQjeaj1cR6xHGOkCYot8Bl5z4JaAzjoDAv8fWbycAKUo/ns6R4g58CXgcxDoESj+dMZbBHLdrfFxZMCLVXNZtI5lVlY=
Received: from MW4PR04CA0267.namprd04.prod.outlook.com (2603:10b6:303:88::32)
 by SA1PR12MB8142.namprd12.prod.outlook.com (2603:10b6:806:334::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 21:51:38 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::1) by MW4PR04CA0267.outlook.office365.com
 (2603:10b6:303:88::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.24 via Frontend Transport; Fri,
 20 Dec 2024 21:51:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Fri, 20 Dec 2024 21:51:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 20 Dec
 2024 15:51:34 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 20 Dec 2024 15:51:29 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 27/28] drm/amd/display: Extend capability to get multiple ROI
 CRCs
Date: Fri, 20 Dec 2024 16:48:54 -0500
Message-ID: <20241220214855.2608618-28-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220214855.2608618-1-Roman.Li@amd.com>
References: <20241220214855.2608618-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA1PR12MB8142:EE_
X-MS-Office365-Filtering-Correlation-Id: 913334fc-6251-4493-3cd4-08dd21407a84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5/eZ7l410jFZDjfnTQiERKePsvE5c8VO1WJRqZmDykh5kDe7E+zurTpy2xqe?=
 =?us-ascii?Q?hTAgfzn4QqCF/jvmyHT5mLpktggN87V3b8wgU2q5IF4YPLdZFwVm981KACOc?=
 =?us-ascii?Q?fwCGnYmIRk94XF2HUetKGaP2E5NNf0bvGnPKmdHvlSHrxKqZimxPOzQrz/A4?=
 =?us-ascii?Q?+BZ8/6IVCTF1g7kK3CsbJfd8N9YER7gOD64uszIg8yiv5dTNfHtI0AlnjPDU?=
 =?us-ascii?Q?Ca1MoBJGilT2GpJAVoYPlb+zivLYqyPF0NGZYC7Xwbp6iLium1nKJZJ3piZZ?=
 =?us-ascii?Q?9e9av86Au+w5JzcHPiUE4amiUFYUWKrpVbS14JOllQdYmodRCKKyVoDGdqfH?=
 =?us-ascii?Q?FDhwReeTSeygkYCGIQsVot5ABB2XVr8GhQWmItm0NhGjrdF0TcP+v2Nbrzzm?=
 =?us-ascii?Q?hQJ2d8WYdIamW3hkyWdZ8NjFi7RRf90N/8kmWQG6XuCQYVdhFYWcK4VBMypL?=
 =?us-ascii?Q?rVssnxRXGQ78k39YJy8AyN9z6j5Qw707j2PrzhuQLb4yymwaaWEVGET3HQ8q?=
 =?us-ascii?Q?UmmeGmLjfLpv5L5g0bKK5UoNpdJQYMbrAtoWpB6jC2dNDK6IOnly0xBxVzdX?=
 =?us-ascii?Q?qHIALHfztPOX89K+ktLi51c4dwbQd4DakGZ+TWGLY89x3QsG5r8JASQr10kD?=
 =?us-ascii?Q?Q+U1rfuothE2HbFAsGcMx3djZLLl/ZUI2ZJuQLz52Dxvb7E9QGABKLBR+Z48?=
 =?us-ascii?Q?JCwXOpZNG2Qm906ZG8vRFXnjlEOf+K4GHrK1nl5k1A9Tu/eTgSO0DFFulwmf?=
 =?us-ascii?Q?2UwJR2OFKhQ25BmxypATD49zYxZDY0Y8AOUfBkKiAkI4Xd1S6hh8MCE7BCsF?=
 =?us-ascii?Q?/Jw3V7BqCmmZHJ9KO2rhONmXWUJ+IOy98vEW3z2ph736/LYPEx1igaEJqfKa?=
 =?us-ascii?Q?ia/300zvECEzcOflodtDTHLtWLvdHbTIM6luhsuiatqOnne9bBoEU+A9Hm7N?=
 =?us-ascii?Q?BvtTnUsvMRw1XCpsxjDtja8BhQt/5JB9R2lwJmxrJbWGQDG8mHgeDD+4AuK+?=
 =?us-ascii?Q?tNvbpFWi5/3i3Txzr8Lf2V7Bjh7fCSRDfztcTch9TbqQz3qcFFPaPOuR7Ys4?=
 =?us-ascii?Q?qTCUxL8vHFtpGld8vM2SMqGFJ1wABBThACxPnwDJAJnyWUvph2bg84gOkkIA?=
 =?us-ascii?Q?eYnLybi2jNChdQXTLI5UEe9Qstcnlv7dVml8Q5ZSbla8xNrE06xmmt1lvWRv?=
 =?us-ascii?Q?MPhvk8tOt2pfIgGGArcf/blMdWA1KRv+zXvqchPlwNcacxNJh39BU3A7zE79?=
 =?us-ascii?Q?5dkIrTAe2ZtOLTJPkLRPfbrlfvM2S0xommdQsNnx+1+Ey7PtnUOY4y6D99VH?=
 =?us-ascii?Q?RSpe9VEvP9yX2LuFiCCj9/YP9Hz6hBFszrAurF+QIwDkB3YcrMLpJZ+JdO+v?=
 =?us-ascii?Q?ttO7UO+UyqUnTHH6Gmus1j22dOlphZAHxmPgOQveIqxBxUDFHTvhkHy+9TYr?=
 =?us-ascii?Q?TKx8s0G9G99I2+xeCoquFhbK3uZob5Y+YVye2UYhKj1CmU1qQ1OBOMeOzTGB?=
 =?us-ascii?Q?B+TGC7BGsoLqsRU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 21:51:37.2026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 913334fc-6251-4493-3cd4-08dd21407a84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8142
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
We already extend our dm, dc and dmub to support setting of multiple CRC
instances, now extend the capability to return back the ROI/CRC pair result
from psp by specifying activated ROI instances.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 36 +++++++++++++++----
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index a13cc6e67006..7c15082c92ed 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -343,7 +343,11 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	struct amdgpu_dm_connector *aconnector;
 	uint8_t phy_inst;
 	struct amdgpu_display_manager *dm;
+	struct crc_data crc_cpy[MAX_CRC_WINDOW_NUM];
+	unsigned long flags;
+	uint8_t roi_idx = 0;
 	int ret;
+	int i;
 
 	crtc_ctx = container_of(work, struct secure_display_crtc_context, notify_ta_work);
 	crtc = crtc_ctx->crtc;
@@ -372,18 +376,36 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	}
 	mutex_unlock(&crtc->dev->mode_config.mutex);
 
+	spin_lock_irqsave(&crtc->dev->event_lock, flags);
+	memcpy(crc_cpy, crtc_ctx->crc_info.crc, sizeof(struct crc_data) * MAX_CRC_WINDOW_NUM);
+	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
+
 	/* need lock for multiple crtcs to use the command buffer */
 	mutex_lock(&psp->securedisplay_context.mutex);
-
-	psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
-						TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
-
-	securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id = phy_inst;
-
 	/* PSP TA is expected to finish data transmission over I2C within current frame,
 	 * even there are up to 4 crtcs request to send in this frame.
 	 */
-	ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
+	if (dm->secure_display_ctx.support_mul_roi) {
+		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+							TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2);
+
+		securedisplay_cmd->securedisplay_in_message.send_roi_crc_v2.phy_id = phy_inst;
+
+		for (i = 0; i < MAX_CRC_WINDOW_NUM; i++) {
+			if (crc_cpy[i].crc_ready)
+				roi_idx |= 1 << i;
+		}
+		securedisplay_cmd->securedisplay_in_message.send_roi_crc_v2.roi_idx = roi_idx;
+
+		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC_V2);
+	} else {
+		psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+							TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
+
+		securedisplay_cmd->securedisplay_in_message.send_roi_crc.phy_id = phy_inst;
+
+		ret = psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
+	}
 
 	if (!ret) {
 		if (securedisplay_cmd->status != TA_SECUREDISPLAY_STATUS__SUCCESS)
-- 
2.34.1

