Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B99C3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAC5110E8BA;
	Wed, 10 Jul 2024 19:39:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ITixQLUm";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF34A10E8BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pat3oIt6N7gLkBjflZS9tTAJZ2mrr7EUybeBiZxu6lipOHcX7mxpzadv9kmYN0pPMDPC+h1oOpvhNKne2lNlbZEk2sSIYD3ntocpCluU9+ql9CvSTtHDZiWLaa8DFcGmDsT9R5TbVFGrcCw/a3/ORIi9kn4Voo8tkXmyXPmbR/fZzDGLvYaq1lYmRn+jePGBvJ8DFPSqlCm0UEqDpqze1SJFIHSz9wbMyXPjRRRlO1SZVh0NfbOLheaaMjWrcpgIn0mMO8CY7wi6WeDSgrPd4cOAIA6kRVBvssGOriSb8AOJWceRknVqyjN7L3p+lsK3hCJ+VP5kYznGk4ieaOiRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i12V3CwMoE/oFmDsoKDPOgMIJsiygI+s7aI+IYheExs=;
 b=hyO1T22boaY7ruXoNlqILrOLpg+/DC6ZlX68MBtUVHFp1VTmZMhn7tFPCxBEzrGBOXUD9sCZ/1QMf89mS029qGxySu9wESk0dFjDI9KfgC1tm8jghN5Wi2CEGAfekL1DIherH/dpmwTAM9jBfNKVimiYRRnEfMxbG33cU3o9ahNbBAEYivAMIL1jYgSjbwub7YwdVzfaQEDIhFym6+wZs3FP65Q+8VVLrprdzdjUX/scc1v+rquVwnKiYmViF/Dz/RAyI9nldq+LZZXYgVmDjYoQaFQbgGwsKk/b2JA8+LT5GYIhIszSHXMqjEh1mKb/mgKrUFrCXQzVzmxQ+os1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i12V3CwMoE/oFmDsoKDPOgMIJsiygI+s7aI+IYheExs=;
 b=ITixQLUmThPSRg3FwiDdU7yWhgSx9+Oe3hpf79xIz+zwdPk9/wJrBXivp35gNBmDgpulY9TFPEYC852YMmbKXpOGBTZOPWY1U+5wE2FwKjW8ClVBNr4YqItvhnjP5VjtTQMJbddIcmY64fAvkTj3eM812F+2f9dtibcE0H1zq3k=
Received: from SJ0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:33b::13)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 19:39:34 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ad) by SJ0PR05CA0008.outlook.office365.com
 (2603:10b6:a03:33b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:32 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:26 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Arthur Borsboom <arthurborsboom@gmail.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 29/50] drm/amd/display: Re-enable panel replay feature
Date: Wed, 10 Jul 2024 15:36:46 -0400
Message-ID: <20240710193707.43754-30-Jerry.Zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 92eb2f67-d39d-4e2f-4526-08dca1180687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F1/SQ/KcvUrYl521SI/HkLLU+6ryb1urYxy0rp//6R+UTj6lP/Z+l8DhpJ4X?=
 =?us-ascii?Q?Yol1miK7U5VFkyT0eYOwWumM73EsLIcHBg8Yf+0s+DSjH4XyciTfCXD534vq?=
 =?us-ascii?Q?T9vpcU4KyGt6759dtJDCicasO8PUKRBX0XyFNuNrfFo+oUzpPLLGZ8h1Tvt1?=
 =?us-ascii?Q?t6Sf9abrwz95kFBeFN7mLlJK+li9d7wIz5HnB3tP74+m+n8zufNkSZUGAwm5?=
 =?us-ascii?Q?Vaa7b6E45weU+R9qnltyjwp0vPLLb63UCrBDoOl0Z0nIAWmYo5K8VOrSn5wB?=
 =?us-ascii?Q?GknX2f8BqsYVh5JYYxX0a0B7p6FEc/Sv+ttRyagaAqQwu9T1FJ0Ykmbmbfai?=
 =?us-ascii?Q?+DML/c0XF1DIGeCZkaysYc8SCNY3+M+7V6EB6V5t/2y57XBcSq2JURdsgwn3?=
 =?us-ascii?Q?KDRotHS/5+vNgSteGQ+vE+v2a4e+uNAiI8ArAwj34kgzY2QirM0ZGd8Qh6Wn?=
 =?us-ascii?Q?SB6vojsAgBYzXGKA73jwfuOLycVt/4jOxfHu4l1CmWDvltQGqEK0LnwBowvN?=
 =?us-ascii?Q?5Oe+FslisydbvfKXBWsQv2r3nzVIy3GvKJUPpTAWx3K921OtD31krJUrmhga?=
 =?us-ascii?Q?wYojqIaY9Funa5fmm11aZ6AdNVHwq6qoOTMrimXl+h8xnmKT2MFroAf+AuHF?=
 =?us-ascii?Q?Zou2kurggKxcM1EV9hPXPhRCNAvmD2ZlfC3oAHdY6HEz2cBu/k4bWAVlNyss?=
 =?us-ascii?Q?DYZO+BiEF9tmqXTxRwkNFPqpXRydqwk3dw2VhvhCmC8m5lCAkSR06lhKBswI?=
 =?us-ascii?Q?Bp1rMjPpLpxsh4c5ZMMujckgr2+0wqKTjX2JW2v34868JT2WtR+4gZ/jAM63?=
 =?us-ascii?Q?poKgYfJM9waDuqUwo5nV2DPbFX9ibxLsMSyPIExvD+66+IpicGBqXaQiosLq?=
 =?us-ascii?Q?52WZ6EqmMu41uZ2ySarB6jnUoQFKwZt8PMxBLevH20tEFen5JPcPm/ZnucYB?=
 =?us-ascii?Q?pg9Rp5QkWtO5T1OEUVu6TaodOcdNWjZ4jwNZt42KjcZXPSISYbvj5FeBs1yi?=
 =?us-ascii?Q?KJ41gCV9T/tU48t2cn3B5LmrYmiuRJtGZNpq1jgJiombnHOsmiJgmlFdo595?=
 =?us-ascii?Q?ynf0CYcTKxdfTt1f2ciQcDsJ3I3gQ/P+PUYBlSzWvednHyAmROIaHmcxHkRF?=
 =?us-ascii?Q?1WuPPAm9A3ECF7ipCoNXSyFMf97TTKqE5uKQuEhMiCbYc6T4Rg0xGzXUu96V?=
 =?us-ascii?Q?CBXOSNu5yOICxuB3BGJXBapXLKM1W9OvqW1DrhK/nyUdmdx1nyI6djxd8Agj?=
 =?us-ascii?Q?BG4IoKTWbv21UZbPZlWSgmjNaE6V+RZPijJbO8+6ILTVs6h4tXFQV4F7jfnO?=
 =?us-ascii?Q?JYtOVvOF7FXFka3tGyxK7kMLoXKa9QS19jr8FY6Y3nrrid20GLcminufialx?=
 =?us-ascii?Q?Y8Z3kJKA+CYXqRSrMGiF470H+W6h?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:33.7145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92eb2f67-d39d-4e2f-4526-08dca1180687
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why & How]
Fixed the replay issues and now re-enable the panel replay feature.

Reported-by: Arthur Borsboom <arthurborsboom@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3344

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fe5a96e5c70a..864a66406f8a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4836,18 +4836,14 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	/* Determine whether to enable Replay support by default. */
 	if (!(amdgpu_dc_debug_mask & DC_DISABLE_REPLAY)) {
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
-/*
- * Disabled by default due to https://gitlab.freedesktop.org/drm/amd/-/issues/3344
- *		case IP_VERSION(3, 1, 4):
- *		case IP_VERSION(3, 1, 5):
- *		case IP_VERSION(3, 1, 6):
- *		case IP_VERSION(3, 2, 0):
- *		case IP_VERSION(3, 2, 1):
- *		case IP_VERSION(3, 5, 0):
- *		case IP_VERSION(3, 5, 1):
- *			replay_feature_enabled = true;
- *			break;
- */
+		case IP_VERSION(3, 1, 4):
+		case IP_VERSION(3, 2, 0):
+		case IP_VERSION(3, 2, 1):
+		case IP_VERSION(3, 5, 0):
+		case IP_VERSION(3, 5, 1):
+			replay_feature_enabled = true;
+			break;
+
 		default:
 			replay_feature_enabled = amdgpu_dc_feature_mask & DC_REPLAY_MASK;
 			break;
-- 
2.34.1

