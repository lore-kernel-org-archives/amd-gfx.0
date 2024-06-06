Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DBCFC27C52
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B108310EABE;
	Thu,  6 Jun 2024 21:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aFOwhvKF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B5B10EABB
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JarQOQcLtGMuqaKb9hniqM6x69SkaV7+BwAT2Ur0hRd2pY2A3MKUsMwFol3z97RhJ25FmFOK5IZGolhExEtxABadfYJj/iMXbqC4qw9KSC6ldSNllGKODBSucMVkXPw7fGHCzGT7Fw/SujdwMBdv5I4mh3Jbm/sIt7uK2ZqS+cBVLYuaFKzu+s9kJ01R5Yt1nnUDbdiEEoV1C2AujEV059rO97enErFb+XKlXxjJgmBSsdxDjzfG/nDNzVgfFLl5uFDrp7T0A/xc2iDoukgF30wB8oFykfI4DOkSfVmAa8GqIOyZovyW0CYvngnRnTk3OKvCXG9POkNeinw0OOWtYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm15vZfAnNhBXcsXMsd+itv/6fPEWv8rDOl7zcaVoPI=;
 b=QoryLl6mR7r66s3qqMkAWlFsG6AZi5xYfqDAM4GkM5aFH/cYq+9QSrOR+GYUPWuTwFh4YNuCibPhccauhvAfTb7jLZVoMiEsRUNAB535seTr1bwcTUuGKm319GSrS9/KH8s+dBFQ/GMU7huHqy+5yN4QTl7c97SjBzpNndvoI8mUvAtD7KcX8zhkTi3HY3tWOtW+y0EWZo8PuWJvbyTVauMc8ulG0l9GsiDdZ6DoP7ateQwr2LAmPUg2pBBa6S2ziYdpga/6c7nt3ZMuUeuvI8TyBphy9fzJBzKuhqzeHeS4cGq+tjSHpio8nnznAEHA5IdrQmQm+qcyqOOE1tyyZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm15vZfAnNhBXcsXMsd+itv/6fPEWv8rDOl7zcaVoPI=;
 b=aFOwhvKF+SAVJlfhCrLbh0RFTz3vm80F6g3jyLPRdwyX02tLzLBTpVLXLkhFnzVPu8crJmh+ZBrauVaq+Au8fw4T49UguVtjl561NQbpCgYscigsNxRenV3WL75L4qfnYNuEm0HgCC7ivv90QTjvyJkWTpZoBcn75+wYbn2oGXo=
Received: from SA9PR13CA0013.namprd13.prod.outlook.com (2603:10b6:806:21::18)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:02:27 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::bb) by SA9PR13CA0013.outlook.office365.com
 (2603:10b6:806:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:02:27 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:02:22 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, winstang <winstang@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 22/67] drm/amd/display: added NULL check at start of
 dc_validate_stream
Date: Thu, 6 Jun 2024 16:58:43 -0400
Message-ID: <20240606205928.4050859-23-zaeem.mohamed@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 06c6fdbf-7124-49ed-04be-08dc866bf8b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hyFFXU6zyxLzSTn4bHrFKIrOUjkHJ7rWd6AYxwtEMOPSLT5qWWjiTZtGchvm?=
 =?us-ascii?Q?XIrYY+Nl9GkM3JPwIq/uq1MXN/xGNklv+JnSRNFQlbr/SAoZqMxBc/kgl4oi?=
 =?us-ascii?Q?23qStNIAebpasSLOAOcxzIcKFe1remrP4gyhCIZmtAS1Pv/WDBSv6zZKg+qX?=
 =?us-ascii?Q?Q8ypTeV5XVbX4Ln3PQIe65pIBmPu+YGtC96dDJEPmybvlczM0JUyZOrsTDlr?=
 =?us-ascii?Q?ZjSIh2e7EmJZ3lShmkOQZF0lvN/0HtoC2KfuqOCHaFVCuQqnbgBlIR+jMFBm?=
 =?us-ascii?Q?sEGK2bVr4h+Ob4+etoOUSbXSDxoMAXFc8JNiDyH8E5jDXIWcHqWe4JBt3VcA?=
 =?us-ascii?Q?ik81vyCxZgiT/yqBogLSZ6+mppGVLf/S0cqAyIDfrbtWsn0J0/qdKiHFm/Vz?=
 =?us-ascii?Q?6KGp2QcDmUFo/q3JSZ3B0RjwBYCn6+V4m6wfLvs4uPzdTmkLwOH0KF5u8R+E?=
 =?us-ascii?Q?9p9/8TzmBw47G617rGjFV4PlNrENGnY2zwmxKNcXZlLVz5cSp57nzrSzEZFK?=
 =?us-ascii?Q?hw8OttyYRRqxBy5bIY96lQWfKhm96lCYpydf8k6VK/CRfM2pqD3VMMCnuj2w?=
 =?us-ascii?Q?Ly8BahbjJbY5/u0q+Q866kS5PqpfNAbbTTmbpCYrCUQeYLpUPA4wUqU/Whf2?=
 =?us-ascii?Q?yty/ZE3hE4ZKNr+k1kHIg0y4VTcMNO5gGUF1AF4T47nCNsI+Ogga7W6Tk+1D?=
 =?us-ascii?Q?sLw6QJj6usvqqO5CvkPdw8yOSWALuvozFyDLlFDnIgAXGt2LKZY1ja7Mi68Z?=
 =?us-ascii?Q?+61nhrfrFhUMEh2LeYALfFFoU4Wsx+6JQgYdR7UGBIeF/7SH0ateSl7b9XIf?=
 =?us-ascii?Q?Dwl49mQE3LvjJ+JUyTiPDyXpE3aqMR9+EykwFzHjxjlapYG/UE2Kx/rqtlUl?=
 =?us-ascii?Q?BzA4pMcvyeBBB0TBdMwN64hEtEVCGkZ9V51izhfjUhpJCw91Px8EdCVnVPNX?=
 =?us-ascii?Q?W1K9D2S3TNT41l3dvYFTnfuTtsH0C3wDI20vsPpkTbr7aXwOcpeqW7ofQsg/?=
 =?us-ascii?Q?T6Omd1kwBVoLyjimIr4zqU2noZnhVGIzthqAf8vMk18Kvq681ypAoKV4smIS?=
 =?us-ascii?Q?B/c6JTl9Hry3caJIT7ViQXu8Y0FjcVwNDKZn7vyBN4hsF726ftn8Ac9gZIY7?=
 =?us-ascii?Q?2ZD6UO7j2Gc9GsVp/kqbZptB4uAeYQQnxg/I6rO7nOytGu41YpQVfgS508Pr?=
 =?us-ascii?Q?33ZI8fLZ/pzcUrnlG+yUAcIi0DQlHAzg8Nmcg+VcIFQYPN4LGzsV9mMB8HX8?=
 =?us-ascii?Q?N8kjVFtXEbZRKmtcrE31EtZA/rrovqVEkXNd77tk4Yan2KVKpAjbIp8DONKU?=
 =?us-ascii?Q?g+wg4kHQ3BrqjmrzrkIShidCUOkSojykaQAonQRpJMFhJetEP80puQ/VXAcU?=
 =?us-ascii?Q?MKqB+gARCEMVWGngXJCBUNorGlCSHDAP4U7YXRbKPz++G//EKQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:02:27.1287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06c6fdbf-7124-49ed-04be-08dc866bf8b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
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

From: winstang <winstang@amd.com>

[Why]
prevent invalid memory access

[How]
check if dc and stream are NULL

Co-authored-by: winstang <winstang@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: winstang <winstang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 45a719fe884e..6d4d4c95243f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4754,6 +4754,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
 enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
 {
+	if (dc == NULL || stream == NULL)
+		return DC_ERROR_UNEXPECTED;
+
 	struct dc_link *link = stream->link;
 	struct timing_generator *tg = dc->res_pool->timing_generators[0];
 	enum dc_status res = DC_OK;
-- 
2.34.1

