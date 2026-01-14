Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6A6D39011
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 20:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39AF010E67F;
	Wed, 14 Jan 2026 20:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nwz6gqaf";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A0F810E67F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 20:24:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1xnqgvdKTcTJVAG6eS25pvzRljmd68Xw/KOX60sPyE9jVPrroxUd2HL/9s/HgLO+O+c7FkpNpLL9NKaOuFJGyW38O1PuqKq4KsgSjY26KwgzVkSvbfz4/QSBOmL6owOdOxTzpv9HLn62wsECfT0xQsWejTDl0Td4HuwaahAIBLvVPpaAMU5IRV9ybtQ0hlsE2ViUAsL+Gzn2TH4UQry2Tg8BWlHsNUFNGoMqHcCEjuslgjpqTjL2WeSWBx/Omqo0xEHKWo7yB0vNkW3pHagsxkp6qXN6IxqVBEwu7vElX/AsYcDin2gRMzULGZdqPSrveOZGG11jX/HOyDBolpWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rohl9xQs45yRBCG8BfIPbKFHkMYplGZARyUIQTYafS8=;
 b=Sa+k1hTUFNSBLBOImtMxFOlJzGI06Wg5wwEFWrPOP3bcSO0I+Sn6ebIuc51WAdSdumPrdSWQXBsmhI+9oFRoYc6BUKhc8JVvU5gpXrFXbtOm5ZR/954+ei4mdVazmzDll+xIyK76uO5vSGU0Ute/LexZWSavtW/h1FivORIezAHurN4+WPBCEyb3cgU753QMrW/fMN9VKuDLtmID6RbNMfBKjtk+rvSV8Ie7l/Dw78Q2SIe+JuRMITV5VosolmO0VVXoFDP5lhIsIz+59t3MqBhvnfCwBZbiKLx2sG2MaoxsDguu6M8G20ukNdcyctyEAUsnCc/EVlMMsJtpUDTstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rohl9xQs45yRBCG8BfIPbKFHkMYplGZARyUIQTYafS8=;
 b=nwz6gqafoOd0uN/HQ5OwegdmeyzAOsFUsZifDOiSmPpKs5le3bXX+hDjGcKQakvHhte1W65x3TcYYtspAGpHCtm5rCDlj/vmcrpwjb5YpY96jxzw3E/kbJirxwN0NqWKaRjLfPSkuf8rg0Y2JTwS8dklxFZc1v5ckWLffJaVn+Y=
Received: from SJ0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::24)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 20:24:08 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::4e) by SJ0P220CA0012.outlook.office365.com
 (2603:10b6:a03:41b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Wed,
 14 Jan 2026 20:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Wed, 14 Jan 2026 20:24:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 14 Jan
 2026 14:24:03 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 14 Jan 2026 14:24:02 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Karen Chen
 <karen.chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 03/14] drm/amd/display: Disable FEC when powering down encoders
Date: Wed, 14 Jan 2026 15:21:44 -0500
Message-ID: <20260114202421.3654137-4-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
References: <20260114202421.3654137-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f0c63a-2d6d-45da-9b89-08de53aadebe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QifLDrMter38JJpfxQFeal37GLxjUPgJ8KabAroQNzg9TaEMLLyEu33mFhYV?=
 =?us-ascii?Q?j7eEuyM7duSFUCv2GW0zGdZQb3PZOwoXQlX/jm8bPWDwuuUlcPCe4S7UbB62?=
 =?us-ascii?Q?wEA+qMsmpqB+STUhqcbKb3ziwwjSXW44VR8zVdjto9WtrP5Yc+6+CrFVvewD?=
 =?us-ascii?Q?krPzZaqDjWC3zW/sOGtB/liZRcsP5S3h8AYDv+DgvAlACRHEGKziHZmDRjba?=
 =?us-ascii?Q?tHrkpn07EKfjzylcslDb8LP2Mqj3ufpiRzZAZHmKpES1TxUYOML7plfhIwIJ?=
 =?us-ascii?Q?A3BMxOODpUVXLcVBoqdWpFre8r+pW9xeZecFwPm7I3O8cKJltUiNd5vhZXF+?=
 =?us-ascii?Q?blaSHZsZKk4ZXhJx8AX2yjmZXHemVAexU+5ytSdcC00JlHK8RC969t7mQn7R?=
 =?us-ascii?Q?IJ3T6p7zzqfaRbNByRgmiJ+yteeuF7r5IOAPag0Z58G73jrBphSwtALhc7Nl?=
 =?us-ascii?Q?/Qwm6pC6KsWqhJiLKUo4DpjAneuPJmjqQGQ2bg1StWdGY0eeha/8r6+Hdk7K?=
 =?us-ascii?Q?dVMwgNRVdA1fLLahO6L5/8OFCbpzjs7HHugQu4jyk8eNxTekvsOKYpP59jvG?=
 =?us-ascii?Q?K/J1EyoLC/8qMrBGPAm0aoYRcW33888fk2Z01xffJcf8eLwLceecxASiRrW0?=
 =?us-ascii?Q?PQnGef6zDoSFGIYuHrrCxktYjbJZzSTxVSqk3mGvgRVUQmMi6sRgc6tBbj/S?=
 =?us-ascii?Q?XXQ9emmPNIN4LgHT96azM2tJa78jm2v44xxvfJmkhliJlVbMywisImK7xRmO?=
 =?us-ascii?Q?nD9iLO7XJ+Tyef1TMG1ILonhtnqKhXfHmVAh2Jnq42Ke4VJMl4CxQz3/0ZCB?=
 =?us-ascii?Q?NJEykYDJ1me5vM92rNAFfk6/EB0FSBr+rwTKk5/2RxSrhtWoccR5WADVE95Y?=
 =?us-ascii?Q?lQZqc6mbxmclCLaMXuU0vn0a0rMTlE5bxz61ErcVG+70o8cMUT3Ms/uezKjy?=
 =?us-ascii?Q?WnAL+ANYCAOmYcQMCRichiazxpauRks2qvUeZp9HBYAd6IpEUIXb7RNYq5D3?=
 =?us-ascii?Q?NEBNAZeLPuPQtKXG5W+DOBixQ5bDTsBEFhNrhoYfWa6+3V+fxmpQ3+RYA0Ab?=
 =?us-ascii?Q?MtCcuHOIZQk5qrIRcRw1XuEMpsxpPIFT3mE+3e9LDEBJ84ot3caBwcC4+Pk+?=
 =?us-ascii?Q?pswqopv7AGFGWqvLJd9vzJB8HzcBfX0luV4BWnrf96lXNm+a5TtFEmRRAnr2?=
 =?us-ascii?Q?lF61qxcIOTx4NcxHY/JD2P4LZQbFyIybZwj532w6zfiQ5VbC8yTqiCD6Zcn/?=
 =?us-ascii?Q?lH7O6jyBPTagSaqZiC2VQz5xr9MOdfqepl6QyiUyiupTeeSzXWl7cJPAwVUY?=
 =?us-ascii?Q?O5bS10JFc/nDRJAWe4bFvzDdp2Pn7VSCq7wMu/1r1mAei7cWN5aS2lKqaru6?=
 =?us-ascii?Q?qx/xweR+2gNDW/EaFxZuL1Wh1JKhn0MwlNa2wB+VQNwYHmDRFx5adKTV/Ybo?=
 =?us-ascii?Q?YoVEBdR4Gjyi25NeGbuZ54fZycCUWcAk5NI/4JdBMEU8RBOiLJVTc2qMielj?=
 =?us-ascii?Q?NXsuc4eyL8+nbzVIgcUjbA4MRyDryU4A3E95ZI8HenWk5CNo50b4kRvAur0N?=
 =?us-ascii?Q?U62yZmNOXJYUI73qgbJ79WNED1bI2w3y0kAfF1KNcNufY+kENzLPvoqDYuBx?=
 =?us-ascii?Q?92rU5Cy7aAjetJtGmtMJsebMg0qwLltH91uWA9wjtLEhS4zrIulbUdkO0uMN?=
 =?us-ascii?Q?gwCD/g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 20:24:07.9012 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f0c63a-2d6d-45da-9b89-08de53aadebe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
VBIOS DMCUB FW can enable FEC for capable eDPs, but S/W DC state is
only updated for link0 when transitioning into OS with driver loaded.
This causes issues when the eDP is immediately hidden and DIG0 is
assigned to another link that does not support FEC. Driver will
attempt to disable FEC but FEC enablement occurs based on the link
state, which does not have fec_state updated since it is a different
link. Thus, FEC disablement on DIG0 will get skipped and cause no
light up.

Reviewed-by: Karen Chen <karen.chen@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 6dd5db79cdd6..4659e1b489ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -59,6 +59,7 @@
 #include "dc_state_priv.h"
 #include "dpcd_defs.h"
 #include "dsc.h"
+#include "dc_dp_types.h"
 /* include DCE11 register header files */
 #include "dce/dce_11_0_d.h"
 #include "dce/dce_11_0_sh_mask.h"
@@ -1759,20 +1760,25 @@ static void power_down_encoders(struct dc *dc)
 	int i;
 
 	for (i = 0; i < dc->link_count; i++) {
-		enum signal_type signal = dc->links[i]->connector_signal;
-
-		dc->link_srv->blank_dp_stream(dc->links[i], false);
+		struct dc_link *link = dc->links[i];
+		struct link_encoder *link_enc = link->link_enc;
+		enum signal_type signal = link->connector_signal;
 
+		dc->link_srv->blank_dp_stream(link, false);
 		if (signal != SIGNAL_TYPE_EDP)
 			signal = SIGNAL_TYPE_NONE;
 
-		if (dc->links[i]->ep_type == DISPLAY_ENDPOINT_PHY)
-			dc->links[i]->link_enc->funcs->disable_output(
-					dc->links[i]->link_enc, signal);
+		if (link->ep_type == DISPLAY_ENDPOINT_PHY)
+			link_enc->funcs->disable_output(link_enc, signal);
+
+		if (link->fec_state == dc_link_fec_enabled) {
+			link_enc->funcs->fec_set_enable(link_enc, false);
+			link_enc->funcs->fec_set_ready(link_enc, false);
+			link->fec_state = dc_link_fec_not_ready;
+		}
 
-		dc->links[i]->link_status.link_active = false;
-		memset(&dc->links[i]->cur_link_settings, 0,
-				sizeof(dc->links[i]->cur_link_settings));
+		link->link_status.link_active = false;
+		memset(&link->cur_link_settings, 0, sizeof(link->cur_link_settings));
 	}
 }
 
-- 
2.52.0

