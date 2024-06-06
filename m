Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEFABC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9EB610EAC6;
	Thu,  6 Jun 2024 21:57:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nUaa24Bx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E200B10EABC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:56:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhS4qobJ9UdMmXw/0iwxxec5h7OP6+Ls0TQq9HrcvXH4FHDy+z7vD2uiltJVDo4Lt3PemWTY6HUdNbwYOaMQOXIRUfsvfY3i6iT29KMamXC0kGrVDbbvUw6MFlwa/sCWGKyo25fp6LSIG+zBz7EgZeNVMH6XdeW81BDsrIRIpWnEUUktuRvteylwjAmdzfd7Lgq7Ppsnpu+0wC9m4I9iQzwhR9dLpmGvdqkSQQs0HyGHdYAmTCbJrBC8TFVYu1RVFV8rvwOMA615PkkyXNY+vEL5mNGgsll6kux9T/qLtSwpD4kr1AUFvHHxHBONn7dZo0eARu/zb/KkUqCwc+6ELw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJNNubwPauCoahu4MeyDQ50aLdt7Vt+gXYUMwGqzYgc=;
 b=WssZdUqqxatSf2DbFVebaIrgKMI7yr5Bcu7Ek6/Kk34/t3voHTvCL3U7uUPpiauFzonOpJbXtYPUyo0X1E+QRTw/yhb6rAfcL/wf8+LmKtSGyZKRVZjakYb9ffsoaNKK8frJjnVSQ7hSwzMcLnR6z6dxdFDOvRzotbPggHmIh1VLVIU7qnbZZh8sp3DUy13bYYNfEqodC49VSQizdFgaHyjA7pZ0DDcQi/VXld7taZgJLWyqCaBC2/ifFWFJPrZr2xSlxgcxG6ePkZ+26Sn/FVsPgBVTCb7q3DFT1ApswQY9pz7Y4qlN2jsd52kMJBwAoJFrDRcH7arc8htpvcHL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJNNubwPauCoahu4MeyDQ50aLdt7Vt+gXYUMwGqzYgc=;
 b=nUaa24Bx/N2Wbc7MAWwWsyVsckK8CEgK6PeBr6sfTVWlMBfozXySHSwDSV09PlNyj/tDl5C0I7ShaC/jpPWx9f+YoJUI7FF17YQNKzdNHpaBLTKs/xnm0uFftiacR0nCaAjo5nVsp8Fw4n/gioW0O/PR/ZQOl2ZZiwBXRfj9bqA=
Received: from BL1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:256::18)
 by CH3PR12MB9148.namprd12.prod.outlook.com (2603:10b6:610:19d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 21:56:54 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::23) by BL1PR13CA0013.outlook.office365.com
 (2603:10b6:208:256::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:54 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:52 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, pochchan <pochchan@amd.com>
Subject: [PATCH 01/67] drm/amd/display: Use TPS3 for ALPM on Specific Panel
Date: Thu, 6 Jun 2024 17:55:26 -0400
Message-ID: <20240606215632.4061204-2-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH3PR12MB9148:EE_
X-MS-Office365-Filtering-Correlation-Id: 405bbbd1-b00c-408e-4ac3-08dc867393f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|36860700004|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7tgSF0gRRceFxpJvKUeBVvWAXCpke3QzRGOx3t7dcnVe6WFDJvfC76Kjs0AJ?=
 =?us-ascii?Q?V7ifEPvJYFDckXIjdBZqK9ym/WjX0sCUIIplWd2yxBb27GS+q3STzZpGTwAP?=
 =?us-ascii?Q?4lq9Seax9qz4eb9q9VrAkMWS+1Xk68dqaBKT4wgEAehwIKxK+hQyOtc9yj0W?=
 =?us-ascii?Q?MgGH1R4eZ6EoFjq2XYXtk/iqzXAO2fQ730T1IznMzrKhV4yQ/cNGggIZ+GhX?=
 =?us-ascii?Q?VeQztJSkNhXLl2S+xGTtTMPU/qRHHNmQHoQ86079BWCpsao12aqtqU21SOoz?=
 =?us-ascii?Q?TNo1AqYR0XymGPVcQtWs15quEm/sIpqwW3wCeYMisII4Qo+8E8aC+z4fNz5I?=
 =?us-ascii?Q?COqJ8Tnj4IZKaL0cXBcg5E7P4MV/OpU+ViM0H0coJ/LhNyO0LK86UZE65q/P?=
 =?us-ascii?Q?KOKdQ+8y2iGqDkZ7FecQjepvleJ9ugoN4QeRjkduVK4206JMIYC7Ro2tBxxs?=
 =?us-ascii?Q?ry5+s42vecHuE827etxmIdchF5U2x3P+snQ4aUpfm6AhsZrFjyHwA9ZzfhI1?=
 =?us-ascii?Q?DTzA7ITotNkZE/1Yr0jcNC3hLlLLQEIVrxd7uXnHIEL8UzXSWOhb5lUq5g5a?=
 =?us-ascii?Q?djl1VskobxEqjnskxRaXOHy6Xh7QPKyceoYIgId4GidQfa0H1DBcs95d5E74?=
 =?us-ascii?Q?8U/moM49kQGmdwkZ1g0dWhAkVEH05j0BAWHzCtaMiqRbA0rC9bsEGLkFwuSF?=
 =?us-ascii?Q?gUw4O7BA+ZwY4eCeXHpEUm+H8x5jPpKEJR1r2+Xsyt9gzB6EZuUNdII/EZXP?=
 =?us-ascii?Q?qMxem390ddl3/dEHvVQuNCld2uSF+8xcSADWJOoWBDGrjuVIBtwzYJEI66+f?=
 =?us-ascii?Q?U9bIO8zmuP3V29SxnOzxIDqKE5YAgNbIHrXsRXvNIP5SQ9Ehe/bdI+NgjYFQ?=
 =?us-ascii?Q?Id+z/TThXSb9c0qe+WKD1FpdZlFYpklWnjL5TP7NxhAldpu08f4FqOe02oEC?=
 =?us-ascii?Q?ecYXJWw5dP9b8YxpQVFlt8TMuaa6+gd8Qk2mFf8Fr9sA22RKLro+O5tyoM5R?=
 =?us-ascii?Q?NzF97N4ibvfSs7o6Gae/NH3VbYYb7TOKNzpoLgNaBOt3A4qjFPLS85sZN787?=
 =?us-ascii?Q?3FXjdyeZJ/V6pNwaAdUI1lR+ksUMHGb06i0wfjaabnRF/JbrsOJHO9MTUpjk?=
 =?us-ascii?Q?fFRg6Uh7BaZuVi13BQqjJ1f5A5MneLlR/e6jy67MmEYC0EfU77vdbxy2xnMS?=
 =?us-ascii?Q?h1e4YYagiHUYpjV7a5rcQccCAZezgdpqhVvZ2cSH1TrnjzZKPImIDcP/gO9w?=
 =?us-ascii?Q?jPuQpwPmLxE92OevcHdlmpClZi/ou5rz2vb0VXqAo9Y85CqnDRbu90BYySJ4?=
 =?us-ascii?Q?M9d/oo1utFSXTNStgAEo8tanfwEV6ynb5w8fs//v+K9buAOV2UKQWi/At41q?=
 =?us-ascii?Q?LH2Lm64jD7pVcDlcJlo6vLYuuR060OGplgikCOOGKSAglZKTqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:54.0633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 405bbbd1-b00c-408e-4ac3-08dc867393f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9148
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

From: pochchan <pochchan@amd.com>

For some specific panel, it need to use TPS3 rather than use TP2 in ALPM
when DSC is enabled.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: pochchan <pochchan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 318d0dc113e6..b9769181269d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -33,6 +33,9 @@
 
 #define MAX_PIPES 6
 
+static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3};
+static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5};
+
 /*
  * Get Replay state from firmware.
  */
@@ -194,11 +197,11 @@ static bool dmub_replay_copy_settings(struct dmub_replay *dmub,
 		(link->dpcd_caps.dsc_caps.dsc_basic_caps.fields.dsc_support.DSC_SUPPORT &&
 		!link->panel_config.dsc.disable_dsc_edp &&
 		link->dc->caps.edp_dsc_support)) &&
-		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 /*&&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
 			sizeof(DP_SINK_DEVICE_STR_ID_1)) ||
 		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_2,
-			sizeof(DP_SINK_DEVICE_STR_ID_2)))*/)
+			sizeof(DP_SINK_DEVICE_STR_ID_2))))
 		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 1;
 	else
 		copy_settings_data->flags.bitfields.force_wakeup_by_tps3 = 0;
-- 
2.34.1

