Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429C9C27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E2AF10EACE;
	Thu,  6 Jun 2024 21:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QZsKdrMa";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7594010EACA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUbdMCYxR7o0rew0OW6CI98EF8TCzbP0T7sNIIiwA99PLPH92scBiZVrfVVe5JiAV5Qj6lXQ+vKHdLWuU0XoBv2tuYcxJPxpyg9wR1Zh98a2Wl7+okIemrpG8QHU69QZOByZzHzwksFbIn4VDpKyIhqDFJXPNblGPBC+YpXw7H0/nRihMr0m6iL5DLK6g8/S+IRwD4lRloeEq3S4QJUGBrxx7OOMJPlmoePNZBkYr9qTowbLFzuUsBnlleljdbruuehW1chqhaFmqfObX4j45wjyY2u40vhOAAK01U8Pzh/49ejLsr8nSEIlL1I9tFdKyb3TvABG9ccZ9PdKs4PsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r02KKUZ6BklxQwDg3bT3+f0qD85cG/iWiE5ffTXYynw=;
 b=Ui2QqtJRA5uEIsUNXOs64IyoQ3XgA9QeIzuD07WnnUYdt2RNgLENI77hsEeJNBG8cGqqT8hz67Tbm3wdfkPEfrpg4k4emIYZ423o/HUUcl2DnjO/l0fMKI5S72JPKyDObTS2hC7Ks0ZQ0EVCVAbCb0NfsdETata50oWfRdWKrFX2vcNEP42dupVml2VE/j/b9Kflql6oVia3PAorRuW75qjaZjQQdQHK0KRJfML26ZTThQrLIdG+ma8FrLBdfGgk6PEY0UxF2MgbKboWQidRPD/LZH8rUm7PecJmBtOiv/qOAHonEBAZmfmKqRjM4V/IKpO9hqx7BxA0FKYsDMxJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r02KKUZ6BklxQwDg3bT3+f0qD85cG/iWiE5ffTXYynw=;
 b=QZsKdrMa3ENKhyPgifLCqUooHQMCxdY+ah1N6kAjGTQGx6ZOMjKndeQ1BbU+ESjg79tKiPvB1s3w0vK85WuEU+GYlXqWuA7HypbXpyKvyGkgyBWFrZtQKTIGFsEyeNeRUannVxrapT4FqgmhHsPmgkA+kP0Il/I9njlFiHwlvN4=
Received: from MN2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:208:e8::29)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:56:58 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::8d) by MN2PR20CA0016.outlook.office365.com
 (2603:10b6:208:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.17 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:57 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:56 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dennis Chan <dennis.chan@amd.com>
Subject: [PATCH 05/67] drm/amd/display: Fix Replay Desync Error Test
Date: Thu, 6 Jun 2024 17:55:30 -0400
Message-ID: <20240606215632.4061204-6-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 67934dd9-69b2-4f13-fdd1-08dc8673962d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?byiHKOqugnmKflot47ij8IYFj2T/y4SxiJI3TZFxJUHjvqvwVSXAgNbWG6de?=
 =?us-ascii?Q?xF3PUHytdw5HjCBCyB5TnTO+PU6+N9EmtSmHEbJl3qeRjxd27USEXA6K2k3s?=
 =?us-ascii?Q?B4uW8TvordDWOC4zKikCY/06TRfdizaVwXNXR7d8pR6MzcUWTZAlUQhDcoq8?=
 =?us-ascii?Q?5vC5mLcjhZYfpNUbrXcnezkaqHGGTDFsOi8f9TvRjtVQjKhnlyRrQtsSB6QX?=
 =?us-ascii?Q?9tDKxATRZcC7aJ6/z3ZL89rafYciPXVBIWzDSf0yoCg/cthKaif4OKBdZX8C?=
 =?us-ascii?Q?LlCDVkosrKAFwLE9cywUFI7bjlpTDnBrD9LP1AEIvaJxjXuC23Usbln59eoE?=
 =?us-ascii?Q?dAzMmS+hcBCpj6SdSoeZNBFgkxq1wI6/NWOjdUhga76+XYh81QMQWazKmHeb?=
 =?us-ascii?Q?5l+aXUXdxtU88MiLWfNWR/ekd+5wJki5Z0JrIKP2Q0E6n2lCiNMfoGJtGLSs?=
 =?us-ascii?Q?2XiI9YfNz1RopnJp53vmvUHDmNQRGO+QUm8b39wCryZcfCcGhVQnNleE2TbY?=
 =?us-ascii?Q?3vlLewehQGFBdhaDk2kpy/kBKjLVQOgVOrAggIZfAvGbhbiJgX+0c/3U73k6?=
 =?us-ascii?Q?5Wjshi8LaAgWYFs6lMuMkECaXCNRTFkumF1ziaeb7qYrAKt7jlsntkMZkOQw?=
 =?us-ascii?Q?YIeYhF513kN2MVXH4xBI1eROCQASmBLyGvjaZTvRjK8zuIQYko7EaqThf+cC?=
 =?us-ascii?Q?RzQe0m+8l7IArQ5KV2pC4HUlhc1PJjcu1dw7DdsoHXMdZJgSU5Uxx3Ry7TAI?=
 =?us-ascii?Q?etwVHLO2n9jazkv4SIAAINT0RoNuAvmPnRvsuc6pHisAP779NrSEhCqbwCuM?=
 =?us-ascii?Q?+Fqssr+L1N4v7rBDv+QsArFi9qp3XAevvOXT1aXh18EXYBhNANp16UJs9L0W?=
 =?us-ascii?Q?RRSH1rlQetCd1DdbkhmOTAEP7bBpV1Z8Ks5CkoDN1+zGotrSAuGVs31jijlB?=
 =?us-ascii?Q?ZrgUNoh+wbuxRNfBoOHqJLoEuSQM69sGZysXrjz15gF0xEjRYhaMKhqkq93C?=
 =?us-ascii?Q?GIdurh9L9OLo83EqDC3+JdrmOnwUUvj8zQ4sqqEPbRHyOUKlCpHnD/yS3ERS?=
 =?us-ascii?Q?8EBhhrOfksNxTmPHwNrGiJ1m8Cx5m3MXUe8Kg69G83Ww5OLxUEn2CCD0ZNE7?=
 =?us-ascii?Q?L1t4A+BG4fQcm025XV2GWO45cu4IcPfDr9BDZxnky060N4pjRNMTjASseZIE?=
 =?us-ascii?Q?sZkQWS51vzluA2X7NEHkMT4+3QcCuaT3qFDdqDr+wfnKsXEc9mww83bszTO7?=
 =?us-ascii?Q?UpGK+8a0DegEJFRIWD65VQJTijvC4KoXT9a4flOTbd6jRiDtwZ6b4/TFTToH?=
 =?us-ascii?Q?7Y+q7M/uaIB2djH1/Mpm2NsPgCfcwQi5XXs/Ns3Ar/ME/wA7AJPVDhBfUKT5?=
 =?us-ascii?Q?/t0DE0O87ROCqcDD836W37vmwcma2kbDMvKVjU5OmDwHrdFQ6g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:57.7944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67934dd9-69b2-4f13-fdd1-08dc8673962d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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

From: Dennis Chan <dennis.chan@amd.com>

When PHY power off, the DP_SEC_CNTL cannot be configured and cause
disable Adaptive sync SDP failed. Regarding the issue, the driver will
disabled AS-SDP in replay state machine.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
index 958a927d0cea..62e03fdf813b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_replay.c
@@ -362,6 +362,18 @@ static void dmub_replay_send_cmd(struct dmub_replay *dmub,
 		cmd.replay_set_pseudo_vtotal.data.vtotal =
 			cmd_element->pseudo_vtotal_data.vtotal;
 		break;
+	case Replay_Disabled_Adaptive_Sync_SDP:
+		//Header
+		cmd.replay_disabled_adaptive_sync_sdp.header.sub_type =
+			DMUB_CMD__REPLAY_DISABLED_ADAPTIVE_SYNC_SDP;
+		cmd.replay_disabled_adaptive_sync_sdp.header.payload_bytes =
+			sizeof(struct dmub_rb_cmd_replay_set_pseudo_vtotal);
+		//Cmd Body
+		cmd.replay_disabled_adaptive_sync_sdp.data.panel_inst =
+			cmd_element->disabled_adaptive_sync_sdp_data.panel_inst;
+		cmd.replay_disabled_adaptive_sync_sdp.data.force_disabled =
+			cmd_element->disabled_adaptive_sync_sdp_data.force_disabled;
+		break;
 	case Replay_Msg_Not_Support:
 	default:
 		return;
-- 
2.34.1

