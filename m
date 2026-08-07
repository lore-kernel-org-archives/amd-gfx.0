Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 868CAC2A09B
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Aug 2026 19:41:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC1810E076;
	Fri,  7 Aug 2026 19:41:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GIZz5M78";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011071.outbound.protection.outlook.com [52.101.52.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDBCE10E076
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 19:41:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ODoRlNHplTVh+XsrcjLcV09U88jWq/mqRyL7qAx5jsKM35ivWx04VihiDhQ7kgW/GougBIvubiQgL4jR5UqmOx7dlZR7QRslGmc5/XYcwja6YfxmjKMhEYpM9LyKDzLUnKCZM6sOkEHX4tnEAbDFCcG24PWETEW6oSRL0bLFQfho3XZ4exDuutkdSAA7Ls3gCEGtkRp+zAOVKoSW9jSuFaJmTchHqAoonBp668GnOMsOhcizLZTJufEraThD4FR8o7RwEUz4tedC3/Q//tVOJ/P4EfXbk1VoHV0iQEjIJjaPNCVfwXs7Dit5yqUw5UqeutB/W0Jmn9g2gQphsc4J9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCQt4/5Np6Zq98XOQQU6WsQHogH0T+hCwD4dwCFKWkc=;
 b=pQKMS+WyEOOhU4Oj8bDeHOy9UPXbSdPL+T65ezJSaK3P7KI4M6tZVARDFig5/x8zmN5FdpTDZxBje3laXRhmqvpqNfQMswxUVgMeuInKN/MR7bFIv8D1apNjD5oYGZtDQ2vPYi4om8zkoTaAc0MaF/R7iRToTUdGgTJfO30d8egHdKxIx3QGdfaOa9+5BcpstjqgiLvoLsuXI80auTE6a9PXR4Wdp1m5hLm3UdXJXP/eexYKMs6AGiejnmVGG50RmysfsHv/6k9SQn1drHZp6gso0RUprTHFrfEId4aHoyjKeP7agbVgAOlSS4iadR+zZltvnI+NZMpfF/hXsteaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCQt4/5Np6Zq98XOQQU6WsQHogH0T+hCwD4dwCFKWkc=;
 b=GIZz5M783zaYOW+YATI6RR9RTwyxVym4diGApHKy3SGz/aW1yacVOe7gf26mtZlxvjQOealvLs5wABUzoJIVJAfIf6RXw+NN8X8BRuiJ1kt/KCqxyDoULYlY5B92b7fLhKmV6bYAnpfO6DYy+Mj0iGYAFjbmVbfyUcuNth9DDIA=
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by LV8PR12MB9155.namprd12.prod.outlook.com (2603:10b6:408:183::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Fri, 7 Aug
 2026 19:41:50 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::60) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.23 via Frontend Transport; Fri, 7
 Aug 2026 19:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Fri, 7 Aug 2026 19:41:50 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 7 Aug 2026 14:41:49 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>
Subject: [PATCH] amdgpu/vcn: vcn dec_msg integer overflow fix
Date: Fri, 7 Aug 2026 15:41:31 -0400
Message-ID: <20260807194132.3214839-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|LV8PR12MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d97b1d3-ca0e-4018-8fab-08def4bbecc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: H/JsC04gKkUbrTRlmu9E7fuBVvslOYGRvrBfxB1aRKhAK7Ar+OZfBQ2l1WcjkOxKGheFO/pOg/NeWU8/RKVOvD9Mn7p0dt60/xTm2CM5DTbF23G825MA4JSsf+LaEt3E6DZZKHQFi1R/GRIITWHNsyL6hatdZZZqV2WVMJvmHX64hiswoH8YL3uKajViUlPWs+CKrnEHs9xOXigCgL4qze2U3R1A2Ta4rA5U07nUjdNhyxciPp9epifYZ1VHeqKftFWlzFLXlf3MONW7LrDdJ6ePy6RQBsKfxplpA4een2Ty14WTO+NEiu5zk5rFyQWBlPqtCCm+aHJ7fpvv3NSyFNhB3gtBjhtsCe2zTGdpPvBz3LA9lqiT79tmZ8lcn9LlmrIJv9fczZi4+W8+JnjGv7+y+vIh3nZlefm2fZuCR8Ncy+TmKOVhPdYxJNLklU0uglERQageAHQiTmCrBT0GQfV8TqHTZv+y1Bz1RQ0wd4xAcm/x82V2Dh7wGIJkLj/dPCKhLeOPoK9HX3fytqZkKX+WVaacgCYPQeGW8fMH0A/wQ25BVUcVw06wCA1W+ZuzqFXXdLji+O3zl4SxUnFn1/8tP8r2btnuU802R7m8N0SvdBmbMCPg+Xsq/J96BTJuB4Ih6dWM3F6/DVt8YYNbJabQIiNGU/8uNz6jOuFSlrnCzmiAXH+pJXKjAB2fk6gXSo1WTaMm0TOl0wy6kTSdqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Wtqw5mDIzEM75CqJt/Ztsi11Ra5L8iupj76mFOXDfjSnXWZr2BM24uFKdpYGILXei7k2ttf2aBMIMoeI1eSqfW/NKibU2PL/U7NcgJYt5YmeQ8BRouXFDTVSCxBVbt6y/jJ79YVA5+omD5MEMx74Q0+aogInWRdHMCnpCOr+qJnCxrjQorbzj2eGDfn/KrfWZJE58+FVgKgUWH7bLGCF9lrohho4xarWeARcCYYSWRBTbY/SmP3A+61Qgal3wAsv3zuK8IRFAuIY41dRB2m9XQhszcdN/gqn2AhdxifA6YAJ9ZVNQpILKpu3h9GeUUpGE6T/YHYaON09EpwV0Z2G4ZTsRMbr5yYqmegLNLY8lX78+887RnngaEAxhiXWYlaJbf4OV39XG+1+dIzmqhdTOdDwRZAJfUsVSbl8+R+700kqjzquffe1R2FYO++cJ4ff
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 19:41:50.0933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d97b1d3-ca0e-4018-8fab-08def4bbecc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9155
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

if supplied msg[2] in the header is too large (around
0x40000000 and above), 4 times of this unsigned 32 bit value
will overflow and the test could pass.

Widen it with uint64_t instead. Also drop the redundant
first check and make the check clear that 6 dwords of
header plus 4 dwords of each msg cannot exceed the overall
packet size in dwords.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 81bba3ec2a93..06dcf736b15a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1965,7 +1965,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	num_buffers = msg[2];
 
 	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+	if ((uint64_t)6 + (uint64_t)num_buffers * 4 > len_dw) {
 		DRM_ERROR("VCN message has too many buffers!\n");
 		r = -EINVAL;
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 0cce78b205a8..7950a020f4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1881,7 +1881,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	num_buffers = msg[2];
 
 	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+	if ((uint64_t)6 + (uint64_t)num_buffers * 4 > len_dw) {
 		DRM_ERROR("VCN message has too many buffers!\n");
 		r = -EINVAL;
 		goto out;
-- 
2.43.0

