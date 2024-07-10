Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D24BC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 332AC10E8B3;
	Wed, 10 Jul 2024 19:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TfhGw1u0";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC86A10E8B3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMgIWscgNNOrEm94TZDLAZ8S34J+qNINB8UtAyGX2uxbVKnvJIdvjUv+4HZUZOWVP8BCmZZuJSIbZdn/Tan+6CZf36D8gR0QgaVLnAg8GpLJyjoepl2o5FigV4sn02din0br+UHOdE1eBoB0uXdGIAt51r9ajQbTnYW5wy2TxgXmcjNmeHruv6Jwyztv4UyayoMEDJ2DLqspZJU6IxSirUdwSGALVMKATJheERVTWXwEO4tnlv9LRR94UVle4xgxK9iu4CD7UlBftXu1DmCshfxwEwn/zz14zIwKR91CFKPw3U7w5QL8qKKJa3cjNw4Z2OO29g6U0qDq+uws15cE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTvQxiBQmN8UYkMUK4B3cB1b+9ugG9KraOcyO1COrN4=;
 b=TCTw+OzqYlU1mA6MZrvSXrhrYJaznHMQME6RTPCFR5z+bQX3Hy57D1WWn7YdtWB7HYgS0Z2K9LRmqJ36amuRk2vMwxiixT55qW/B+le2pm3DLligISsLKhy+v2IT4SBbSS6ti7CWIyUlpjm8MqkovmxUEODMvnovC+LVYq1e56Ters2xSr7ChZI3e0UtEAupKCoI5WU7q1TZb0xY1DrQeYRftsVduNFqppvITWwR16v0nx7YdMxupkarAz47vci4z4u4MUnPfAWw0RpmutXZ1v2thbjJb7mnH3OGmzAVJe5/upGBnzTNAn/7BGmD5L3LmgafLo3su3/XXQn1n0MsHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTvQxiBQmN8UYkMUK4B3cB1b+9ugG9KraOcyO1COrN4=;
 b=TfhGw1u084oFxzGRNPNK9eA5LlTmsIRRMmmfxjFwVp0z5gUBNsHQTkH5oyD+b+u+dZB8ZSiDiMEOXOdHRu3Hw7UrcuQQD4zjWXEwKCCVzpMBRBQ0HXRhKYPYJMCXFms7QhZP7kbpsJvyaZOCMfBhmv/h9878zhA36Q8GjI7wduc=
Received: from BY5PR17CA0023.namprd17.prod.outlook.com (2603:10b6:a03:1b8::36)
 by SJ2PR12MB9238.namprd12.prod.outlook.com (2603:10b6:a03:55d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 19:38:57 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::2) by BY5PR17CA0023.outlook.office365.com
 (2603:10b6:a03:1b8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:54 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:49 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 21/50] drm/amd/display: Check null pointers before using them
Date: Wed, 10 Jul 2024 15:36:38 -0400
Message-ID: <20240710193707.43754-22-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SJ2PR12MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0f2ba3-9309-4caf-ada5-08dca117f04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WsNQszUDRgqQnCMq19AVGwDKTfTQJG0sp/c8WKJARJYBrtG/ULa8Y3zs+u1s?=
 =?us-ascii?Q?HnauEgIqgIilBIXdi8ytHoLy+LIp+6DAIp1UdkV4+54tRot3hk2I2z4ak9w7?=
 =?us-ascii?Q?wQfmnt+lBycV/vN5fAELAce0aPJZmPuVxr4Mc+xpF+fr0VwlXmj9mHU4m1r1?=
 =?us-ascii?Q?p6TBUskDpfIjZ/YaqWdQN3dLv9bwAC7s28GYusRxvLZ9ORvn/lhqyaJzyHkp?=
 =?us-ascii?Q?gTPyhTSqLsUoG23kxNe/2xLvcoxx1G/pjdfo4i62pnY9HzZE+EYvll1NvxCs?=
 =?us-ascii?Q?Jpyyn1PM9SVvZXS5qK0K/lzXs2qcFLEykMFCHVLo7JjgeAhJY7oGUk4/JpnK?=
 =?us-ascii?Q?JfRxnTLmAVMh6vLOnOSGjziF61iMo8b14bv1ZsSdFE6cbuodkfsA1F+R1Awc?=
 =?us-ascii?Q?tDDASxayZ0G0ExgrBfLdwBfVJqyqTTrJeUwGXLcSH5FR7WppLY7LehTLuY79?=
 =?us-ascii?Q?Ub4gL/F1jyKh59Agi8Lpvsb+dc2NHok99yF3LwU9yUKW62+vtOlhe4apF8vu?=
 =?us-ascii?Q?e63BpFf+SshmVVQQFu10ciwyfuftWjH2fWFaPXK41LK3N8idbnY6Lc4AP24J?=
 =?us-ascii?Q?fGTpOu462s3DtJ48nCdKNtwXnSRlCmzx1DQnOWNhtFzrWv/dbJNIm3Z4b3Nn?=
 =?us-ascii?Q?0gJjLgUp9k+pCTjHDC4TDfMI4wsmpitzo8pFZh/M3OU1Ds1DUxcsp/yf0vmn?=
 =?us-ascii?Q?onbfLDdkhvIOzWI3U0DnbsiNyoknyaopefq0/qk+kEIalbRpxTO0RpBEdXv4?=
 =?us-ascii?Q?VS9MB30TAaGSgSMuvvequ/V6yUnqNP0soHc2JweiCD6IaT/kJJ+8wb/icaTq?=
 =?us-ascii?Q?nks369anOrPV4Vrl5njT1dHS1dlht4lN9vA/UTsyuNs1x1Gl83HG2OsByc1r?=
 =?us-ascii?Q?7y+Ov36Zu4PLNwxJHf6THj/hiP+TFOrqndFMUaLm27wnm48PQ9BahNL7gb2K?=
 =?us-ascii?Q?3z9XkfT6vbFaIJy5pPNeqwXJNxe+IZehO0Xpr8aO4a/ETDLMfWig/qJ7e29C?=
 =?us-ascii?Q?gxfizsnF64UU7bmh9upkNgGzs+Z77WAt712wDmIhey3oY9e/JY0MzxDDLL1k?=
 =?us-ascii?Q?Nf0mn3LD07Kz2IqTXAam73BIRJrVYp13EmrdXut68hHI1vDSABfi8EKygA7C?=
 =?us-ascii?Q?v+Rpy5wsamhyst2PkXgacCiej4ilspnvD9B+19cDW3IcBZEcK9mJAC7iG07j?=
 =?us-ascii?Q?h2s72jxwbhMwBxsj6WmdOpAqXMdaou4tUI7o6K1KukfAkKaHGans3lKqhnp5?=
 =?us-ascii?Q?JSWjQ47h9v1uYlBSsTJ2xA8eGla/oc1LxfSssrVM08JZifZANlHCGB+evMv8?=
 =?us-ascii?Q?WJGpQYCu8p/Jb8fu1tvfiK5G2jzgEksN9nIZB7/HLxAbj+YohuvFLEosbvWa?=
 =?us-ascii?Q?/6wnkkNYw+KrtQXFWYZqYwYe7yXWptUMSVoqWzKIj0o6hukKXHe78IaUZv39?=
 =?us-ascii?Q?dVdIrDxiMWls8rgL/ham/C/YHHRPPv2u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:56.4716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0f2ba3-9309-4caf-ada5-08dca117f04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9238
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

From: Alex Hung <alex.hung@amd.com>

[WHAT & HOW]
These pointers are null checked previously in the same function,
indicating they might be null as reported by Coverity. As a result,
they need to be checked when used again.

This fixes 3 FORWARD_NULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 44a80766380f..18d6bb485cb1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7195,6 +7195,9 @@ create_validate_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	int requested_bpc = drm_state ? drm_state->max_requested_bpc : 8;
 	enum dc_status dc_result = DC_OK;
 
+	if (!dm_state)
+		return NULL;
+
 	do {
 		stream = create_stream_for_sink(connector, drm_mode,
 						dm_state, old_stream,
@@ -9302,7 +9305,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		if (acrtc)
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 
-		if (!acrtc->wb_enabled)
+		if (!acrtc || !acrtc->wb_enabled)
 			continue;
 
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
@@ -9706,9 +9709,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
 
-			hdcp_update_display(
-				adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
-				new_con_state->hdcp_content_type, enable_encryption);
+			if (aconnector->dc_link)
+				hdcp_update_display(
+					adev->dm.hdcp_workqueue, aconnector->dc_link->link_index, aconnector,
+					new_con_state->hdcp_content_type, enable_encryption);
 		}
 	}
 
-- 
2.34.1

