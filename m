Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD92C83F20
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jul 2025 21:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7D710E96C;
	Thu, 10 Jul 2025 21:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="33gIJpJT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81E8410E96B
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jul 2025 21:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKxoV2zMGYLxB256V6mRxNaTXUb/yg79OvcMlERdC+Dfyr4PbugLtP0GKkRGWkcY20jl1zroIyVuu0HTQY0X1/McSwNrCnHm//JYHVNFxTvuNyzztF+X064WvgyX6+en5LCMx72E8Eos6g59tOe5nyHNV6sUbKXkQu/Rn3J3IwilbeiHuIP86PqF29Gw3I0/kw95axHOfhahiPO51YfVpxPrm8YJZPWnH5a3VP3jP5ayg+X2Gb+2A5emwqaysVpUjoeLv7rtikPf+Qu61lxsIMNfd7I3tc4hkdM83BfE/iD5L93ewkNQaImbo0Ijwdj/+6tIsVDRKwJ2+3syR7sBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejPLng73wicBiAFByJnve/r0621Jt31+pxKgd0ABzo4=;
 b=eFOBELPHR0nMviihoFX7bX2qsx2wmcKIfcpsyfmIg1ehnJCGxgvq53wbAASmIC5FFjCdsVd2flQVkRPTMBc9fgWjYgBNbtAAIGmlDiFqDyCQSUNSPl+2daTdvXD/iIyk/bGkMT5x2WUGfY2tPFyIFrpfWiOuZEmMXMXZDUs52m87e2zU+BnyohYDb2Id/pb4AOvlRwxH9vbEBPVKoSBujIT/eN1K+rHLOlremthHR3CI83AeAneOKu5eNRTKVwsaXTHKNnHRE2CF5fTeE7Vc+OXNp6tY+KyZfkDX6c/1hnNItFs3/PFCr0Chbpx+1cR1dGxM/uMhB3hHgBnIa3bAJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejPLng73wicBiAFByJnve/r0621Jt31+pxKgd0ABzo4=;
 b=33gIJpJTdOS5fj2OlNFNPDFiz8CFJeFwiVu8usS4HBVPC0GysyoLlK6iSnANF+I8/eIOBAQPnwqDlsg+LQWx22wlt7Onkn6q7oj24aMxCo0RPkeN7TbVxZpnj4Zw6nDumY/eeGpEnaD8Z7VoqIkaTDH8JTc55yOpjXpgRdFXjQs=
Received: from CH0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:b0::24)
 by SA1PR12MB9246.namprd12.prod.outlook.com (2603:10b6:806:3ac::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 10 Jul
 2025 21:31:10 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::3d) by CH0PR03CA0019.outlook.office365.com
 (2603:10b6:610:b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Thu,
 10 Jul 2025 21:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 21:31:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 16:31:01 -0500
Received: from box-0.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 16:30:56 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Duncan Ma
 <Duncan.Ma@amd.com>, Duncan Ma <duncan.ma@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>
Subject: [PATCH 09/18] drm/amd/display: Notify DMUB on HW Release
Date: Thu, 10 Jul 2025 17:25:42 -0400
Message-ID: <20250710212941.630259-10-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
References: <20250710212941.630259-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SA1PR12MB9246:EE_
X-MS-Office365-Filtering-Correlation-Id: ee448b88-c455-41c2-75b3-08ddbff916a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VgXlhHZWTzoBek8q8BB8CxH46sDejN8f7q8xgbtK6b5RbtmpF8LAfrUZH+tM?=
 =?us-ascii?Q?x0P1o8mSCXpyEQStJWcD3x23jGmA4tzhNaan93HPoXcdwpJX47J711cw241R?=
 =?us-ascii?Q?qA6XFvsMDAd5eDlkvxpGN2i4LuB4OxGk0cuRsQPvDa4rwueZSXC5nwp3Yoz6?=
 =?us-ascii?Q?zXH0diCnOXQ13v+rYHzsuqG3DXaioE9PZZG6KwOQdBodNgRzHUa37nkjK+1F?=
 =?us-ascii?Q?P9GgN48Ogh4pimVPP4Gbeg3ib3RGBe+RP7Oe+Ead25ABvisieA+JdbBbcza6?=
 =?us-ascii?Q?R68uco9cqL+g0+0Keywxlyk+HeXBTgsCq13X+7F1ZeMu9T2NgE285fo2UEuY?=
 =?us-ascii?Q?eM2V91wziVH5UtAQ6gArDhaQlyjE6fA/J6pSEeYbBkX6MiUY3Uh8mzzCwFgg?=
 =?us-ascii?Q?qGfpox6vUzaHgxpEskgMAZ4rQLuR48gbuq6wR0K1iApTzy1/BimBD3fRsTvC?=
 =?us-ascii?Q?IFfECGHHzPUhe9IsF4259u48C1MTFvEOLQIekNyoNP+sfQbfgfeC94JcDRyT?=
 =?us-ascii?Q?5DUjwYfGFAEkLm9N8fiNtkiIv0hJD7HfNMI9Rpa+e9dRW1fyEkNg/kbqpQ1y?=
 =?us-ascii?Q?iUFsHcSlvFWUDWfhQuCj4UQNlPYQ4oyewWMv7VlNmCUWXgo6AnFqzwkL39yn?=
 =?us-ascii?Q?44Ej5va0eDeW8vp43YxqztWo+OISEmMmKzKrJUJAv56WHl4EPsqq7DyfmEVX?=
 =?us-ascii?Q?NBOARObG4FgfzrgW9RBGmASGkbnXLrtTp8+Vu9q1GPKlxyjZo2ehqeQKYVAI?=
 =?us-ascii?Q?Si9063Rwo5zr/4VTzA/hgmbZ/6wjuZwI9jubYbqCGAbgf1rgXEU9IhOpdJng?=
 =?us-ascii?Q?Q0R/ErioQUhEPwYvnTx7NZ3akXXd2OmgkLvaVpX20Y3D5EiUh25WixFPrTk6?=
 =?us-ascii?Q?G4yjRZ3a1hOdtdwhf5etw4GsfmKl2RMA0GS5QYOXOJGFYSlAhn6CsF/7NlXF?=
 =?us-ascii?Q?i9M0U5mWXi9OZUhnsS3C8iFiajn8gUMDrODif6cGmEIttqvggotjnyygIO/W?=
 =?us-ascii?Q?QY4ihoy4F9CGzmuH6Y/AjZh1RyM8xpeG5V0zdc2oaGQsMqm/1GCQ5625XL/5?=
 =?us-ascii?Q?w3qfZQro730MscDYhPwBykTek8fwv/qtEHRi4//SeiAuO4zvjW+BCsWhK2lR?=
 =?us-ascii?Q?xGLHvdo56JRjkIgScFifMgfcVz3qMLmFrxkb9xDFqZWZBocOcvlrR7E2OGkL?=
 =?us-ascii?Q?TKju/0WcM6FbOkqpKfJFCNI0y4gP7pYrcsLs1aFg7bT2fb/1v7NocDxhT8Oc?=
 =?us-ascii?Q?ccQBElDtbMVUzWLy1qhAhL+VBPxsb2X2jjGTKUVVTQBw4FSLWljqcBULxhVF?=
 =?us-ascii?Q?zw8O8nu3VCKH6zzYc5Bknts0K8RHGid0pZ2yYk3I6AdFskM6b4JVyz08NMdT?=
 =?us-ascii?Q?0Ond1iApSSFrFykSKMbpsirZUdHi90eIlACmREV8K0khTS+ozNtYQFXcA9ep?=
 =?us-ascii?Q?xsBKrKRPv0gnRR4zs9VI4l4Hlx2+3McI9QgbH/9QD/OCjUDWzx0e9pG/sDWX?=
 =?us-ascii?Q?/ISO5CF7qXCdyME+l9G9M28NfhAq7VW6ovtB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 21:31:10.3568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee448b88-c455-41c2-75b3-08ddbff916a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9246
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

From: Duncan Ma <Duncan.Ma@amd.com>

[Why & How]
DMUB shall be notified on driver hardware
release. Implement notification.

Reviewed-by: Duncan Ma <duncan.ma@amd.com>
Signed-off-by: Duncan Ma <Duncan.Ma@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 17 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c10e603b54af..b4525b1fc11b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -2176,3 +2176,20 @@ bool dmub_lsdma_send_poll_reg_write_command(struct dc_dmub_srv *dc_dmub_srv, uin
 	return result;
 }
 
+void dc_dmub_srv_release_hw(const struct dc *dc)
+{
+	struct dc_dmub_srv *dc_dmub_srv = dc->ctx->dmub_srv;
+	union dmub_rb_cmd cmd = {0};
+
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return;
+
+	memset(&cmd, 0, sizeof(cmd));
+	cmd.idle_opt_notify_idle.header.type = DMUB_CMD__IDLE_OPT;
+	cmd.idle_opt_notify_idle.header.sub_type = DMUB_CMD__IDLE_OPT_RELEASE_HW;
+	cmd.idle_opt_notify_idle.header.payload_bytes =
+		sizeof(cmd.idle_opt_notify_idle) -
+		sizeof(cmd.idle_opt_notify_idle.header);
+
+	dm_execute_dmub_cmd(dc->ctx, &cmd,  DM_DMUB_WAIT_TYPE_WAIT);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 1f1c155be30e..8ea320f21269 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -291,4 +291,10 @@ bool dc_dmub_srv_ips_query_residency_info(const struct dc_context *ctx, uint8_t
 					  struct dmub_ips_residency_info *driver_info,
 					  enum ips_residency_mode ips_mode);
 
+/**
+ * dc_dmub_srv_release_hw() - Notifies DMUB service that HW access is no longer required.
+ *
+ * @dc - pointer to DC object
+ */
+void dc_dmub_srv_release_hw(const struct dc *dc);
 #endif /* _DMUB_DC_SRV_H_ */
-- 
2.43.0

