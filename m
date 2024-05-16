Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDD2C25B79
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0493F10EDB6;
	Thu, 16 May 2024 19:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IYviFKr1";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C41710EDAE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImSrvd4OgrhVGaXW+4KCRkLrv1AB1a9NUIK+gFAGzoiCaXSY/27lSj6KcHlwVST9uo4PWpn/jGkiBdxia+MkpCHKSXHBhftICDWHrWyEVLxbgqNPtqkRUNQbbpv1F7v8d5GD2i1ZGKgY2FyK1YlSyOI7eyX4eAZPSBiD/68nGs+bAxNt8VO1PsUAHPkudPZJiepjhBwf9Jw2W8soEjqodreiLxyRSwlbD9n0egha15EDu/xuOVLdSq3DdMqYIdcedSDVJxodQ5+cPqONMLxkZ2FgjTKGSi1Rk4zQxRyspz/cgXAAC3n7oZDhRgOHW5p+1fhBzi0f1pbt8hi3+c+3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgL9dWavdJQPUFNnl/ozUflvUSWtk5lhyTa10WZXJuk=;
 b=T+ouho0j818SXXjbOjcRcsMANcYai9tyR7jy1nzU3RUbr/6MPKt0hqBLDmhjEQB1qrgL/9KFd+95fHXm834Y/Lr1XbOgvXCcf4pQG9cnKk//d+RIH9Ue5kv9NQYpVej0Fkh9xFsGn0yUG3wwNZrwbrckByYkP8vhMOcMn4i2R4BScXznGFTra/NP4ClKIwNuM3N028iDO34XZ61FzeG0HD81yrauQHO+I11MUgTxrGywtH/A/z7vQECkYGHr/JGzdKGZfQZkTvJLq91o34ZfsNNVbETg5YoKsuq2DVX0gRisk4zocx/NuixH0DaiDXfNf5Ud2fQSwg2mMdUthId+sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgL9dWavdJQPUFNnl/ozUflvUSWtk5lhyTa10WZXJuk=;
 b=IYviFKr1yYIY89MJqOhVFF3qJEsEywav8gL939Hh72FU7uCNcM0WI2Gha+g2AtRahoBstrlK0di/fBoZ4S/Mh1LvjoD7oDJEhoV8Rn4CHfIWwqmTtVlbkMNnnLu4incx6HfSPjjdkBCNs1G/ahKKzYcidMqB7Q7U7qgeAttzXqw=
Received: from BN9PR03CA0248.namprd03.prod.outlook.com (2603:10b6:408:ff::13)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 19:27:05 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::4c) by BN9PR03CA0248.outlook.office365.com
 (2603:10b6:408:ff::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:27:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:04 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:01 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:01 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>
Subject: [PATCH 11/24] drm/amd/display: Add NULL check within
 get_target_mpc_factor
Date: Thu, 16 May 2024 15:26:34 -0400
Message-ID: <20240516192647.1522729-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c48df1e-f898-43fa-93de-08dc75de2b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9dK7wSMt3GRpnDd267vGLIIcFTVqDdiRIUSjGNg6m1aB2whelL4Hus3McDx5?=
 =?us-ascii?Q?VsnLJelPfW59NELG9d4VJeTjNZH0Ann7tye243fUJ8qBKX+Ws84jxc3vSFiK?=
 =?us-ascii?Q?mbqhexosv1+gw5fLIli0CO/lcA0ES/GyK0KA55Sced5tGZSlNHGW4zChDGiK?=
 =?us-ascii?Q?p0SiOHPhzGVeQg4MJJDelpuHSt2XvoEL6TW07O6p7AR2IzyB1mXX7jkQc3MQ?=
 =?us-ascii?Q?d4uNo0mXnv5oSIhKu299TuUyLeBnObSOfRHJppbdzrfwRBkn2mgGuQEu7GvL?=
 =?us-ascii?Q?aJR53YONCqYTQRcevIoQFiNPkldzNXb9AE/3GPkhtTFBaTi4atTUUrj6O8wd?=
 =?us-ascii?Q?/CPoPlLnW9WPA6U5+dr3lEikkTpuc7Jg6iD7XcbtnjOpfnyLwL3gUsn/WB3K?=
 =?us-ascii?Q?8SPrOpp2Y810/uMLCEnueTNlcYM5eK0ll16qvgXlRDYoMtHFStY7IB14Yf5N?=
 =?us-ascii?Q?DNlcLSfdSJyMLOf8BxqOLsw9w9vjq8FCXM5l7K2er9S9pJnFwHcJ0W2766Ui?=
 =?us-ascii?Q?Xi9s3ckJEBQNX/y3hujfmocTQcLR++CemGKwYGrOFDio10RACCjtJVXG5Z1l?=
 =?us-ascii?Q?NHI8BmbUjowMQDe3vAi6ex6A/fyp9A4L/aAJi+7hV5hLPKgoED+/Hi/CUos1?=
 =?us-ascii?Q?ps3BQCECvRPCQZE/g/gXsx09RwGJh/BQE8P6wQbnZt9JICLsD+Z3S4Ch3m4J?=
 =?us-ascii?Q?vYpUjwdRLzzvV/IUyPAA2l9kQ+0qye59zhl65NNUpuPZ1ctxxlEjRW0iqMYq?=
 =?us-ascii?Q?VVBw2IHCftiNQC244u8/Xom4j2O7Q0T8rXAawWKDYyzKASjCPiXmKjNfNogJ?=
 =?us-ascii?Q?ZemzJZjzDCQQfudiD19bPKI5NptlazSY7KC9zHhtsIGPOS2yKG3Dm2xNTryO?=
 =?us-ascii?Q?pNbdImbGkUL72OsxCLUQVT6W61ge2m172V3qBNfod8ZrkDwWSQk5UUacsLmh?=
 =?us-ascii?Q?62/dOthk2Nu9FrtvS7Ff7VjZaB434+eZnn9dLrIJD4R5TXuqnuXj5VMuOFJR?=
 =?us-ascii?Q?f8bCu2q8lmV34fRQJRTQZ5g+9ciUsD/xHkVizrxsmdQWll3Kxy/mMumJTGlq?=
 =?us-ascii?Q?IxHJhWCva6Pls3jbqziec8ILo+1kpFcQEotrIglLsohtLnfxH0IfneczQt8i?=
 =?us-ascii?Q?khsk/kQuNNLxNPm+CW36zFuE33OaSZcpZjRiWrRk+o95uLLPfrImGMq3coNN?=
 =?us-ascii?Q?3HzR6qOeZFidawlbH8wMLhVVk8XsyQ7rN+UUf09yEhu+HMhmv7AwVpmZso/M?=
 =?us-ascii?Q?JSDzSiSdgw0KUjmic0Vbtraj28rlDy3y+iV4SyDw/JZXCLtWcsOtb3pLY3SJ?=
 =?us-ascii?Q?yLI7sBLP22c0yjRz5COm+fJwRxXOGhYOiz+G1ZOA8Z0rxZHAQje9GfHCsWKC?=
 =?us-ascii?Q?lHEpvbj2ew5samzkqja3vc6R2D0t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:04.5126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c48df1e-f898-43fa-93de-08dc75de2b12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

From: Hersen Wu <hersenxs.wu@amd.com>

[Why] Coverity reports NULL_RETURN warning.

[How] Add pointer NULL check.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c  | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 190fa2962271..02fb2cb1c43c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -819,7 +819,16 @@ static unsigned int get_target_mpc_factor(struct dml2_context *ctx,
 
 			/* get stream id of main stream */
 			main_stream = ctx->config.svp_pstate.callbacks.get_paired_subvp_stream(state, stream);
+			if (!main_stream) {
+				ASSERT(false);
+				return 1;
+			}
+
 			main_stream_status = ctx->config.callbacks.get_stream_status(state, main_stream);
+			if (!main_stream_status) {
+				ASSERT(false);
+				return 1;
+			}
 
 			/* get plane id for associated main plane */
 			get_plane_id(ctx, state, main_stream_status->plane_states[plane_idx],
-- 
2.34.1

