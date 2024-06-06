Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789A4C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0696310EA95;
	Thu,  6 Jun 2024 21:02:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="laYIb6sA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5073A10EAA2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk4lViXiI5dXKXNZFyr7upQECZ2rI357n5G82aP69f2rletPxPO+PjYS+thM9HbZthp2Ko21/tDzIEiyMlhgv2H+Df7KmAMJizxn9evs0GeHfh6f/MN4/GisULSv6sRAifa+f2j56PsVvXqjzmrGzJTXysExAMI3DyRgC2j3j2MKkSovvzRGC7Fbby5ymU/kmGzLQQ+EFSsJrZbFLAFa2dieB2I0mWNmTt6+ENFgj/FK4Nb57jEth1KtanpYldSa6rs97vL1Dyk0XV1ZXToDmRZfVLijTKpKa6NEBy1MSK63/xrwXzurufSlx3dPHBcfc9M5oBDA4ig4XyldvxOJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVcr0MVV2RRLpAi+PS6r9UBy4axNBoGv8L4w+XnziEo=;
 b=n9B/4QnQ171EibyXVYbW07F3fp+hrGzYm5VjLqxLQ962FM/S50teNrEQYMN9En4WpT4pOaojVifZljsEZKf8mME1169rCPheKq4wg6Zk0xx/7FwejkGrYcQlZbQCSFVNiA5cjayY1wtmlrt1nldHCN7tPMUOWp7lzkIROfaw2i5ZsCJ7UeW55OramkBQyyA5oGkF8L8Orj16x1lOJ7ut75PiOBb83th28JTCj9AM5fO/2EGqo7595HEiGB+E1fozunldt8xedGGXRfteF32jgUKO0DX3ADmowtThCS9MynX1ihu9e/Niaea1jOKxeosfCW4CrqnIHkkIyo2U8Jyd8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVcr0MVV2RRLpAi+PS6r9UBy4axNBoGv8L4w+XnziEo=;
 b=laYIb6sAmXTNI0H4gr1D/1WmgbmJStI2UF/Az3q7pvw/BkEbIxKh/j/VUnWwDbPkYJ6gvQYmPYPpXOExpeTH1+K+oYw/Th4x9YsxIICRmPeS5Me5fk+gxm/CoyCnDf95eVq+y8plurY4XXvJDQwrYpFVMd3rvVnzEE1FpioaC2U=
Received: from SA9PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:21::11)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:01:56 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::f2) by SA9PR13CA0006.outlook.office365.com
 (2603:10b6:806:21::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.7 via Frontend
 Transport; Thu, 6 Jun 2024 21:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:01:55 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:01:54 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Rodrigo Siqueira
 <RodrigoSiqueira@amd.com>
Subject: [PATCH 03/67] drm/amd/display: Expand supported Replay residency mode
Date: Thu, 6 Jun 2024 16:58:24 -0400
Message-ID: <20240606205928.4050859-4-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
References: <20240606205928.4050859-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 99739295-6b0c-4b87-eee7-08dc866be623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O3M+R4sPGEBpqos91k87z5FW4eShqlDKDZGAEF5GsxjKMpfHkOdJcyMwXqi1?=
 =?us-ascii?Q?anxrdqSq9QCJuseyk5Xy6cWKBkWDIJCpwBjobwGraMQ+Vm+sRbkMKepO8nF1?=
 =?us-ascii?Q?sA9G0kZs19N9+MzHBRr1sBFTKIXNqd3NPzjLsQt22J+z8+wcjTDz07TXsgkv?=
 =?us-ascii?Q?8D8EjFpa5RFStxWaJ8UkF5aDENPfdQX5T6wGWA6Hsj6OyJMD/8Xkedcby+j8?=
 =?us-ascii?Q?OwVnoQx47nUygzoUEO58o4D6KWojI/NQ3oBD5EJygyAnxAenz8yb6s7odKFV?=
 =?us-ascii?Q?wqoSSRElRuvUmZV1V5ZylmO3sh3evoXU7A4J97q3xu3SSHcBuo4G+bPvv3gA?=
 =?us-ascii?Q?acQccdaH1N29bhdMeRhiwjFzJ3fLA87u5EvzMh68hPDOno22ylrUgbH4GiSL?=
 =?us-ascii?Q?qtSDF1rYKcmdoEqe1wyESMT3mnWG1UzOkL8ArwhMlHk5xMAPaEsJIJPbe4C7?=
 =?us-ascii?Q?sUEvSCqQMZ/MiFbBTFRmmuGd8/GPrF4rpKK/yJHC0PlIgs+SEM7PZ2+s56aW?=
 =?us-ascii?Q?TrPx/SDvTElTHH08jRgJDXqYjwCtmJP+52w9R07GQFZnBrC9yYCFlEumaa2r?=
 =?us-ascii?Q?afH6ejeTwMlFHkIq/fxeByTRSIPdcWf5ZH9bfLt5vHQSl/d2e7ObkMG33nmu?=
 =?us-ascii?Q?57SzQjwEaTKJALClnEwW0P5h8BQbMVYFjtEEXLu9zlgVXWWcK8wRyIAX79N9?=
 =?us-ascii?Q?g0q0/2ZUDP9hPu9cJf+VRXKcMNqSR4yF2xeEY5v5bfZ3NIAeE15e6wwFrNpd?=
 =?us-ascii?Q?RBvw/1mbsflFwW3Kc/Q28xRFkFxbAjPD3mC7m0X1mjfyHoGk7bXEz0PrDZTQ?=
 =?us-ascii?Q?NfRmTnsD7Q6N2vClaLdMZ6ttEUQjYVDAypNiS/B6qRHS/+C+1Badhz5xAK7j?=
 =?us-ascii?Q?dVoP2zG1DVJhRPWzXT3fNhPbfpZYK6TyPAhivsZLb1miEJL6H5Rs2v2jg6q6?=
 =?us-ascii?Q?O85ucLAzvFrGRkC0Z9dt2GKUHkyVgDgOUvT9elPLGxHa83ChFo4RGa6KaKjW?=
 =?us-ascii?Q?bPK99HujoIf8DU8Ef1gBIhbL/7r2xwbR0YGjgn5G8WPsypC3/A18fox2DpSr?=
 =?us-ascii?Q?QgDKwa6TOtVcpYv/JK8YQd/8gNQXlbtVrCmNrMOt8xyHBKwFSABs5lwijK5q?=
 =?us-ascii?Q?J3uP3h3AAjIiFgG79iObdYRb1QqIQmOVwHW27xeu+JmPYo5PlNXJ5Wz5gbZP?=
 =?us-ascii?Q?6WImrLFkocPR20SgiVJIUDdowwADC8BtAtiaCgCZQUO5w0gMo2JoxfBpEpIU?=
 =?us-ascii?Q?7si5mR+VKuBz1xbhEnP/Ud2G0Oa9XMq4xT1saTrCct/d6TT5WyPMCKqPPFJU?=
 =?us-ascii?Q?QRgWFsFNbA8cSFgEbGV5rgZiumpxAREt8tlQuDt+Uvm91C2gu998ee2DkI4w?=
 =?us-ascii?Q?IfvKyqZu305Uphfy/DWEp44zotfq873I6qXJHwj3akR1tHQQIg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:01:55.9567 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99739295-6b0c-4b87-eee7-08dc866be623
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
Dmub provides several Replay residency calculation methods, but current
interface only supports either ALPM or PHY mode

[How]
Modify the interface for supporting different types of Replay residency
calculation.

Reviewed-by: Rodrigo Siqueira <Rodrigo Siqueira@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 32 ++++++++++++++-----
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  2 +-
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index fd91445d4d8e..be27ab7ef2da 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -239,23 +239,39 @@ static void dmub_replay_set_coasting_vtotal(struct dmub_replay *dmub,
  * Get Replay residency from firmware.
  */
 static void dmub_replay_residency(struct dmub_replay *dmub, uint8_t panel_inst,
-	uint32_t *residency, const bool is_start, const bool is_alpm)
+	uint32_t *residency, const bool is_start, enum pr_residency_mode mode)
 {
-	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
 	uint16_t param = (uint16_t)(panel_inst << 8);
 
-	if (is_alpm)
+	switch (mode) {
+	case PR_RESIDENCY_MODE_PHY:
+		param |= REPLAY_RESIDENCY_FIELD_MODE_PHY;
+		break;
+	case PR_RESIDENCY_MODE_ALPM:
 		param |= REPLAY_RESIDENCY_FIELD_MODE_ALPM;
+		break;
+	case PR_RESIDENCY_MODE_IPS2:
+		param |= REPLAY_RESIDENCY_REVISION_1;
+		param |= REPLAY_RESIDENCY_FIELD_MODE2_IPS;
+		break;
+	case PR_RESIDENCY_MODE_FRAME_CNT:
+		param |= REPLAY_RESIDENCY_REVISION_1;
+		param |= REPLAY_RESIDENCY_FIELD_MODE2_FRAME_CNT;
+		break;
+	case PR_RESIDENCY_MODE_ENABLEMENT_PERIOD:
+		param |= REPLAY_RESIDENCY_REVISION_1;
+		param |= REPLAY_RESIDENCY_FIELD_MODE2_EN_PERIOD;
+		break;
+	default:
+		break;
+	}
 
 	if (is_start)
 		param |= REPLAY_RESIDENCY_ENABLE;
 
 	// Send gpint command and wait for ack
-	dmub_srv_send_gpint_command(srv, DMUB_GPINT__REPLAY_RESIDENCY, param, 30);
-
-	if (!is_start)
-		dmub_srv_get_gpint_response(srv, residency);
-	else
+	if (!dc_wake_and_execute_gpint(dmub->ctx, DMUB_GPINT__REPLAY_RESIDENCY, param,
+				       residency, DM_DMUB_WAIT_TYPE_WAIT_WITH_REPLY))
 		*residency = 0;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
index d090ec900c08..63bbb1bb0ad5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.h
@@ -50,7 +50,7 @@ struct dmub_replay_funcs {
 	void (*replay_set_coasting_vtotal)(struct dmub_replay *dmub, uint32_t coasting_vtotal,
 		uint8_t panel_inst);
 	void (*replay_residency)(struct dmub_replay *dmub,
-		uint8_t panel_inst, uint32_t *residency, const bool is_start, const bool is_alpm);
+		uint8_t panel_inst, uint32_t *residency, const bool is_start, const enum pr_residency_mode mode);
 	void (*replay_set_power_opt_and_coasting_vtotal)(struct dmub_replay *dmub,
 		unsigned int power_opt, uint8_t panel_inst, uint32_t coasting_vtotal);
 };
-- 
2.34.1

