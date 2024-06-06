Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA0DC41513
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B9C010EAED;
	Thu,  6 Jun 2024 21:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4E6IJfY";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B1B010EAE9
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lAuKV+h0HKOQqkXUeNJ2qNLxpbTUAKqQsmvfzaG4DI5inCgZkoD8dtYlRcloqN8R0Scwp+L7ZtdNmTiO33Shlhc0VsoH63TSJrFxi9v5XtwkO/oSoeiu1s6bZ+mDCsjkHmvM/A3eaJJNiEzWVvrZjaeeX70nMufprr3FAFQzRX4R4aSfMk9Nd2zJvQg+8MfwcCGY8JQuElOybQZtL9Ga/Yw07Mqq2CxYMgFa4My/q2VhAAPZKVEPqvjKyZlX+cBI0au2P3vUjuszqeHpQEXFH/5bHPw8Q6QmNlKhes747+QiP8ThCQ9FxqYvdnzArm5xJOR4wDAMQ49kkH5MpE/Qbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q3A+rAKwdeoAjlUyRaZVZew1+ZKVL5aMIATE2+nJppM=;
 b=IMkbcd8folpAgIua6Wp+0MJmgNQDNk5g+hhYBZq2An7zz8kecXgiy29lY5XybpqHH8GffGhcXRK+LcAyvbF0gW5sLobsq2WSDFr6JFkjxbbWN0tQOlHPttfYBCdgWnMx5GVkDyuy7opA0/3ZwfDJd2/vl3NCdAQBSi8JDUBMIohKrUoL9Es5chJQnrBkmkubq4oR6LfW9Zi1bh+enZKEbMnmkN9mF+G1wxA8/QtHhDU2cTlt+6lqVi2om+CGdqp23xvgzBq1/D8Zila5l9yVvCmq9yp9hSt1TtQtluqccsg1/0NhLS9ZeIWH3qFgbOcg6tpShKD+8bfYhaeId4bjHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3A+rAKwdeoAjlUyRaZVZew1+ZKVL5aMIATE2+nJppM=;
 b=Z4E6IJfYCXf/yGplxl7HBkPe2ozLMUKoeITTiQO+MYLdYxIlz6UpxTLVFXYTMnKMtGyNNKh3aURwiPCjNxUTUfuMddwD+omP6EbSP2Aj/2ljsREzx5NhLTMhrz/2OUp6QZjpsPXGfd8jeu4j2f7FBXi9E4HiICzJfQ9V1ILNTRI=
Received: from MN2PR15CA0041.namprd15.prod.outlook.com (2603:10b6:208:237::10)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 21:57:48 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::7c) by MN2PR15CA0041.outlook.office365.com
 (2603:10b6:208:237::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 21:57:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:57:48 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:57:44 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 32/67] drm/amd/display: Adjust debug msg for usb4/tbt
Date: Thu, 6 Jun 2024 17:55:57 -0400
Message-ID: <20240606215632.4061204-33-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
References: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ea66e2-89e7-47ad-6adc-08dc8673b46a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?50PUMRQk/VS6+BWJfw67pxOC9zvjR9NyrXQyahUrLvja2Y74bpvzhxITurZ0?=
 =?us-ascii?Q?LkVyr28NlZcN+Uoko8XBdHHfA0g1Qb5rRSA+KmtcfgYbkXEZP1c1IiP3fza8?=
 =?us-ascii?Q?G8trxabnZtm4WniUP6I2Zvh6ztgyFxvMYks/B9k6RXDOHyWzBG5Ehq9nNWJP?=
 =?us-ascii?Q?pMS3X+7fmzEF4hORslYB/Nyhsj2VHtSMD7z16IXYxhrPXShqV6t6ipzfJbz+?=
 =?us-ascii?Q?iM+8NgiaNiP3Cholov9IOpRxmlXppCybaTUGnojWx6j7Iba45BGd8MT8tT2c?=
 =?us-ascii?Q?xXHJH7aSNinQ+hN4HW1r+1BUW4QXXKJw4wDxmgSjnmaPuAsoLkhU3LwTM+s8?=
 =?us-ascii?Q?tZJ+GmQZRyP7jz/M5+4PAEZCeDDU8l+CHtAbI7OKDLr77en9w/6pYE5B43Vh?=
 =?us-ascii?Q?hCfFnPyBNFzU8jE9iV+exSza/5+cXOhzWNiuihXqWLZ+jJjcX6E+I/6sh+NQ?=
 =?us-ascii?Q?giLI9R4dfwugcMtBUnkWPH6CVEi04DwdBFiA5BR5JNzGVJnu7MeqmNs0tE+6?=
 =?us-ascii?Q?J3Qi9Mwkoro8GmE94RFqjbKJ+8ETjXZeGbVt7gKf2O6WW0uhm2RHYCqau6+4?=
 =?us-ascii?Q?UhqzF8PPMm5A2gRDqBEU7FV64tWk2zbwuDE4gq4kiPlE/Z1E3f4COZeIo4aQ?=
 =?us-ascii?Q?kp4QzLoJvdvV4oiWf0iSilgNyE/SoWfxHIPil3JFxKflumsOdPTHQPOsYbMR?=
 =?us-ascii?Q?oITtKhqMNRZSlFYa0EoIml5VG77rhKVZYUP6dLXpmGhhHmaKuB2zqrTPmBkU?=
 =?us-ascii?Q?XqopGOeQFFMoEJl33aISrc1CCGRwHnAey4NEkM7LmNvgFKTZHO3kIo2HCBfr?=
 =?us-ascii?Q?7y54jnZTp0dZk+B4Uk7NEUYUd8mgmdSIhW9vdPp4RACyzUROIsLklPSzj/K5?=
 =?us-ascii?Q?j77t9ywVHxExSi+X3EUpxpENoBham4hRsEuihuiigyz5eDpgFMMVLpgERdfb?=
 =?us-ascii?Q?BHkzGaR3I64UU1pXsF68c2dgOYUzkVs8+74kojm4vdf9b671jXsdQ1N5sMMj?=
 =?us-ascii?Q?VujrgLWi/OljUVIcNp/8c8eHF3EkgRRjCnTqPYf05ilX/Sl+yQyKXY/P/C/f?=
 =?us-ascii?Q?DyWy0ba+GwZ5XT3tye4bSlf3ZCvyDTOjMyyGy59dXwAXFW2HOepmriWAwS7x?=
 =?us-ascii?Q?Hlr0FCmxr+ziZOkM/vogMnACpRbXAv1uZ8jFoVNxVJqPSkqbP3lILlYxV16f?=
 =?us-ascii?Q?TbdvB92rE6ZPgzA61wYjhMcuSWTAVtVJf+EEpqf2sBbleFDa6HmcpVSncMc+?=
 =?us-ascii?Q?sHfrSXLiKFDrDjdXwHJ3FE0x5fdd1rVQYd9w4Mgs3lJelspUvnFrhgR7reEf?=
 =?us-ascii?Q?PcWu8uFZgUuJD9nWdslXHtMSoz6oy6wTOgwDx9su4TcKrwZvx74806+qt7Lc?=
 =?us-ascii?Q?NGvfeRKKLirs3OTRZRYlVJgkDJGKyxL4ST2P+7kyztHeE6i1jg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:57:48.5376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ea66e2-89e7-47ad-6adc-08dc8673b46a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414
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

From: Wayne Lin <wayne.lin@amd.com>

[Why & How]
Debug msg for usb4/tbt now is a bit confusing. Adjust it for better reading.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 57 +++++++++++--------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27acbe3ff57b..52fbd5ec7f8d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -774,9 +774,9 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (link && aconnector->dc_link == link) {
 			if (notify->type == DMUB_NOTIFICATION_HPD)
-				DRM_INFO("DMUB HPD callback: link_index=%u\n", link_index);
-			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
 				DRM_INFO("DMUB HPD IRQ callback: link_index=%u\n", link_index);
+			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
+				DRM_INFO("DMUB HPD RX IRQ callback: link_index=%u\n", link_index);
 			else
 				DRM_WARN("DMUB Unknown HPD callback type %d, link_index=%u\n",
 						notify->type, link_index);
@@ -788,10 +788,13 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	drm_connector_list_iter_end(&iter);
 
 	if (hpd_aconnector) {
-		if (notify->type == DMUB_NOTIFICATION_HPD)
+		if (notify->type == DMUB_NOTIFICATION_HPD) {
+			if (hpd_aconnector->dc_link->hpd_status == (notify->hpd_status == DP_HPD_PLUG))
+				DRM_WARN("DMUB reported hpd status unchanged. link_index=%u\n", link_index);
 			handle_hpd_irq_helper(hpd_aconnector);
-		else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
+		} else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
 			handle_hpd_rx_irq(hpd_aconnector);
+		}
 	}
 }
 
@@ -860,6 +863,31 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	u32 count = 0;
 	struct dmub_hpd_work *dmub_hpd_wrk;
 	struct dc_link *plink = NULL;
+	static const char *const event_type[] = {
+		"NO_DATA",
+		"AUX_REPLY",
+		"HPD",
+		"HPD_IRQ",
+		"SET_CONFIGC_REPLY",
+		"DPIA_NOTIFICATION",
+	};
+
+	do {
+		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
+			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
+							entry.param0, entry.param1);
+
+			DRM_DEBUG_DRIVER("trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
+				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
+		} else
+			break;
+
+		count++;
+
+	} while (count <= DMUB_TRACE_MAX_READ);
+
+	if (count > DMUB_TRACE_MAX_READ)
+		DRM_DEBUG_DRIVER("Warning : count > DMUB_TRACE_MAX_READ");
 
 	if (dc_enable_dmub_notifications(adev->dm.dc) &&
 		irq_params->irq_src == DC_IRQ_SOURCE_DMCUB_OUTBOX) {
@@ -871,7 +899,8 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 				continue;
 			}
 			if (!dm->dmub_callback[notify.type]) {
-				DRM_DEBUG_DRIVER("DMUB notification skipped, no handler: type=%d\n", notify.type);
+				DRM_WARN("DMUB notification skipped due to no handler: type=%s\n",
+					event_type[notify.type]);
 				continue;
 			}
 			if (dm->dmub_thread_offload[notify.type] == true) {
@@ -902,24 +931,6 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 			}
 		} while (notify.pending_notification);
 	}
-
-
-	do {
-		if (dc_dmub_srv_get_dmub_outbox0_msg(dm->dc, &entry)) {
-			trace_amdgpu_dmub_trace_high_irq(entry.trace_code, entry.tick_count,
-							entry.param0, entry.param1);
-
-			DRM_DEBUG_DRIVER("trace_code:%u, tick_count:%u, param0:%u, param1:%u\n",
-				 entry.trace_code, entry.tick_count, entry.param0, entry.param1);
-		} else
-			break;
-
-		count++;
-
-	} while (count <= DMUB_TRACE_MAX_READ);
-
-	if (count > DMUB_TRACE_MAX_READ)
-		DRM_DEBUG_DRIVER("Warning : count > DMUB_TRACE_MAX_READ");
 }
 
 static int dm_set_clockgating_state(void *handle,
-- 
2.34.1

