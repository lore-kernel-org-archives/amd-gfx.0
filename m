Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4851C77B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 04:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4264B10E655;
	Wed, 25 Jun 2025 04:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X2Kx0FTa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F4810E655
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 04:05:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ge/M1sTfjPVCLaskMqtEbSYSRGOIBrGe1I3VKplDC5G3CbD8uFZoBC0LZRsDzE3Nsl0SzG+jI2n9tKbQv6tQHnzPKF8SWJhzBW+FzO9megIEc8G4wD3HJyXD0gcgZTrxZLaazgf/eudm5Ps8uNeCUzbBYAtn1+n43zfYllFKT6Un8DYVJBTPagdOFVJpefhIr1pNvJB6cXYNMOEzcNttVLrWzSwUU2jiNGQBXfmdYvS6cXeSfyaZW02DEtyHQX4ugWClzly1SZ7cltK/klAS3AAUSPBPiaYRVRGKhumoFkWuRYb1yJiXYOhqy1cckb/fHcopHiwR5I0mzscraHvXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJCgjhQC9G34QVk9p+q8SXT2FdoRDOqf5KGh+tk5PEg=;
 b=xZ20030ZUCJM9ucc4buDVjD9QOPKDAAjOu99wp0s+5974e5f8GsPpFHipvHrjJNqW9lmPs7Xj62jCmZbrprLstug///R2tnR3WABQLVC6JZyM+6/KplL/ADuNUASP1o2mp9t/MNhT4P5Vbw0b6zyeV7pmxqMVqT1WTxZmYa8nUv+1DHhxzuATyddwVJJdiSX9NtQdlDWtwrEXA8NCfkukrNAWCPyKvf2DbicobILOJOWeYTf9ePkeNHhX01THYG2VXU9Hs3Xa7ZuaTQNIBGSkMjC4fAjHzwe0gZBHEPw7bzpYLUMXBrrTJ6v8h5NHVhq74XwbHICqASIs3vT2GmwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJCgjhQC9G34QVk9p+q8SXT2FdoRDOqf5KGh+tk5PEg=;
 b=X2Kx0FTa5zS0Wq+oJWouFxJ5tSP/pqxN6AeUcXCPQo+QbACPCqGV8hvI9GXiKwTmLfVRwmKdH9Gr9IZXVisSvZ1vAmxqvDS0DjTQ2EGArtNGwYN7yKN/tR7Ma/twaA/7pvfDFNu9VqjNhm9w0fv+FTv7afz26BvJec+gfYokREQ=
Received: from DS7PR03CA0058.namprd03.prod.outlook.com (2603:10b6:5:3b5::33)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 04:05:34 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b5:cafe::8d) by DS7PR03CA0058.outlook.office365.com
 (2603:10b6:5:3b5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 04:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 04:05:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 23:05:32 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 24 Jun 2025 23:05:29 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Ilya
 Bakoulin" <Ilya.Bakoulin@amd.com>, Nevenko Stupar <nevenko.stupar@amd.com>,
 Ray Wu <ray.wu@amd.com>
Subject: [PATCH 05/11] drm/amd/display: Separate set_gsl from
 set_gsl_source_select
Date: Wed, 25 Jun 2025 12:02:23 +0800
Message-ID: <20250625040420.886013-6-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625040420.886013-1-ray.wu@amd.com>
References: <20250625040420.886013-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: ray.wu@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a0f2a3c-bf4b-4e3c-0bb3-08ddb39d884e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ffGpaApVwXfdTocm0IOUsc2CPUhHf4/sWHqk8SU2v2Cpbz5wR+S+TX2Jkbyu?=
 =?us-ascii?Q?RsZveJhL8vbMl1GAGLTFiNwZcV0cRuFH4I1PnMxeou2yUn8MXZ2V3OxV2/yD?=
 =?us-ascii?Q?kBysAn5p9B3HgVKD8iahsXwUU2JQKg8cANwUynn+DKfUlaIgkiHmXQLOiJUK?=
 =?us-ascii?Q?k1tTwfH8cuSH9mk1JF4r3/DwftpyrOVJBGGYaUbSAqauauYQeEhHVItwlI2i?=
 =?us-ascii?Q?K7MGL9dGxwu275DKW2it2NRpinL4GuUmz4IANqO0BbVn95wHzTZxEaLG7tN+?=
 =?us-ascii?Q?H6qnN4Nro3FANeR4U0kKTkz/6U9yJ7icT1NC1T+C8pdmUJxBBfja+HjFYC0D?=
 =?us-ascii?Q?3sdW6ilJWaokCpjm27mQEFOspjXNJX7OX6bNRtPqhgoyuohcHoJlQayUGrkH?=
 =?us-ascii?Q?hqsN/tpjnvVU3LLkj9zb7KYQSNtfV8dDAMOkJBSYB+okofrEJfR0UL5odbFi?=
 =?us-ascii?Q?LtgCEPV9rKs4IwHP8739v+/Wc1lY4Bj3STkbgeEWhLVTw7VX5vsjuRIQwxvD?=
 =?us-ascii?Q?V9pS7YmbCvxoTrwABKub0EHlsTaNWOhP4yzbuvbGep3UllWl/tGlTRbrxy2s?=
 =?us-ascii?Q?IuFv86YEslz9pRRH/t2uycYOZdzlq51cRZAnKCxaSl/tagjfb95L2GUjISV+?=
 =?us-ascii?Q?j5uROlUff2+k7oBN+Ve3mSCvOErIRsx+I9V5SjR7xDANadaz39NtGkbLZyZ7?=
 =?us-ascii?Q?8aL8uxow4G4rmZrKmtCEMG9M76WQ7fc7s37LU8atBW0xHXcozyqcb4capIfl?=
 =?us-ascii?Q?J7cyE1CEKL9f6Ia/STPhT/XMABq74a8V7TLreb/SJpCnPROMGR9RAkYjK+sc?=
 =?us-ascii?Q?lEbpfVPBeFuGuZDfvhD/PtxSsC5dst0fLxWiMWYvoi9Wxlx8KG32hp1ScWlJ?=
 =?us-ascii?Q?RekpW00AC50jps+M8Wqu5mN8iG/K+lvsN3vy0+XSt38V45y2riSILkxRDIna?=
 =?us-ascii?Q?aTjq0Mve1D2B4aTSoF2CRGw5N2tC5etixC5iZRWx7tvme1lI3wmf6HqPdGw7?=
 =?us-ascii?Q?UhOyG7+VAU5oP75/slx8xo+XBskugxmpXrJ5kh05nqZNbgVBjXFN0Uc5winT?=
 =?us-ascii?Q?9tYhTW2BvmbFVOZTJIQoKZPn6wYo9AZSsoJdMzU8vEtLoNKDeGeAP3TkrCxm?=
 =?us-ascii?Q?watfY5VoQcIzkdXX7U4CywHbBb/o1zSBDstonygyd9QkpvwSfnK+nNwSgNUI?=
 =?us-ascii?Q?MdyOLHJkGKCLKjGlohVD2Vftvx96NbYoVROfYHcUEC3bsyW+nFDONLZ49riz?=
 =?us-ascii?Q?VtnVyzIa/h3Tmr4X+sgXplfroa5WLbrNDh/U8rm7z2jYLsvH+Pftuvds7ESS?=
 =?us-ascii?Q?DVyvAu/un3m6ddm+ymI0lJkXqupltRaXB3GDaKYgZmmisI/6xjNs9HO2N7OH?=
 =?us-ascii?Q?d2dxBbxhyWLSTXvHfU+lgj/eTRIem9wtnFuhSgder41hdq4Zd2JPUME4/L37?=
 =?us-ascii?Q?doCmvoukvhOZvt2NNGKCo5cMrlUF2qVn89L1Suk0AqdQmYAgRsE3MPPdCzQd?=
 =?us-ascii?Q?C8dOWo1wSaqFU1ibqhos7FTk5hUbpd2TpILb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 04:05:33.3773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a0f2a3c-bf4b-4e3c-0bb3-08ddb39d884e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why/How]
Separate the checks for set_gsl and set_gsl_source_select, since
source_select may not be implemented/necessary.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 7f9b6c4bf889..3207addbd4eb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -283,14 +283,13 @@ void dcn20_setup_gsl_group_as_lock(
 	}
 
 	/* at this point we want to program whether it's to enable or disable */
-	if (pipe_ctx->stream_res.tg->funcs->set_gsl != NULL &&
-		pipe_ctx->stream_res.tg->funcs->set_gsl_source_select != NULL) {
+	if (pipe_ctx->stream_res.tg->funcs->set_gsl != NULL) {
 		pipe_ctx->stream_res.tg->funcs->set_gsl(
 			pipe_ctx->stream_res.tg,
 			&gsl);
-
-		pipe_ctx->stream_res.tg->funcs->set_gsl_source_select(
-			pipe_ctx->stream_res.tg, group_idx,	enable ? 4 : 0);
+		if (pipe_ctx->stream_res.tg->funcs->set_gsl_source_select != NULL)
+			pipe_ctx->stream_res.tg->funcs->set_gsl_source_select(
+				pipe_ctx->stream_res.tg, group_idx, enable ? 4 : 0);
 	} else
 		BREAK_TO_DEBUGGER();
 }
-- 
2.43.0

