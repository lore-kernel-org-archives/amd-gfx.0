Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65107C5DF97
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B8510F38E;
	Fri, 21 Aug 2026 16:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jFRNraal";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D5210F38B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:16:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnYORr8r1E7oyHJ3EFojj5zkC93Sln1k+KIkzo3OIAx1nLjSuBNElcInsCcuAzdVcRgy4E563HZKZl9UxRd/TQVjoZzzk1keo0bo9BTxhkg0eijUzfFgtQKSSWKJABDws8R5w5wToA25Lk2750fwewNJYARe7MB6JnDtydFyxOxbKLBO9zgNZjnQs5RiX6fRlA+0CX6KgUenPyqJMcKyAqvceYAVIMCa5sgHQckCQOor4rFr5FftoGRTgcMLkYhKjPcz/CaIoSJfk4yMYxJRUWLFjvecRH1HdLWynRyIIi1ZPvNgKW33yYDtXrjXJbFexqcq0D3I5JnfnkbpSJ+FkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JT+ii1pHqo04MMpAFDDEtA4WA6r5S0nr1IjNMtQBx8=;
 b=YOvRNaRWqZrJ40RZJzBcYGjYnS7L69d/KfUF9iDkQl32HjFSmfB8oppOfOLpHV0bYpIZ9vLVOHqPOJUdVI47TVe15i3klUcqLbqdG2pdrWz4WDqCAXj7rGQqnObM9y+oUuckHJ7x1YfzIgea9c5xTlxcIn/iipnhtC181iEWBBQ9CaDuMViotTuYQZPRZBgLL1+x+57KG3rvQxm8A5UADCb/S9iL8EyAsjDlNqEJla+1mx/PvIu+fjEFaIg0R73Ky75KB8eJO60f8hwkS7/mn5NZYU9pBFFWPnQvuY5H+ogVCN8g9ZWSzzPQbWU64oNmkyZa5Ghkf/UmbleTDtUuyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JT+ii1pHqo04MMpAFDDEtA4WA6r5S0nr1IjNMtQBx8=;
 b=jFRNraalW49JuAqVFOn3aNgjBRZCfkw8ghSvktVFsqZy0YH6WsKYCKvrZBtGoE/WiyL0ApQ4yEPaNex/TTarefWayp/u4vdiQVxkOIkxwmacIc1WF18ZCklizcEo3IkXv3/q21vU6azunMXguc5SPWoTWJ4TOPKS1PyJ+Y4vO58=
Received: from BY5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:1e0::31)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:16:05 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::68) by BY5PR03CA0021.outlook.office365.com
 (2603:10b6:a03:1e0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:16:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:16:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:15:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:15:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mangesh Gadre <Mangesh.Gadre@amd.com>, Hawking Zhang
 <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: add DPX mode for 6-XCC configuration
Date: Fri, 21 Aug 2026 12:15:44 -0400
Message-ID: <20260821161546.754333-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821161546.754333-1-alexander.deucher@amd.com>
References: <20260821161546.754333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: e05b8c02-235c-4e55-603e-08deff9f7fcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yKvfYn/UMExTlQ5kHc55lk7IOvztczdfWnOKuPTyx97A9eSSV4oQ30a4/30bloscppJNXxBmYbEZV3UyYWi3Z3cfVmAhNyhKZdnjgCXTiL1z7FqonX8vYIbteQI/1MN2C2OjVP8G5YQMXYoNa6DKy+dVUr/WC74pI0UjKlTRAFNUqRrAhhrgcx28MluzhaJdTux2MRNLPsqLvLHVGAp3Ez/n2KukNl6BtH3HkRCSYwypJx8xJqUSBo0pOPZjM8DgkGucsVzTZuSWto3YMx9OrIfQGBghhe2DhKacFQg39R9mO5mfhPRkyuGuvy8cwBwtZNTKWxOsIaUUQ0MXUT54WEzXLlSE7Ehaoso8KM3nZJj6sqJtgE8QfKB8W2FbtPunGsdNMyB6Zf82QQTsVdGpTvk8JNY/LfyUmmRxuHmbnXjyyuFDjpfw7Rk/wa3R3zX3nOypyC7SKDsiXW+T77Qgz80mI44wmadG5Cx7OT+ML1QH7sCnz30fEPBBFPOX6JVUBSxwsusQrCFl15riB8QLCvJpq/K+hmcOt9Qqaje+U9IhiujFnmknpP5Sm9k7ww8wICiHPUogsZLI2msB8iN8KxkqdQA3bV/l7+GkAiNMKh1MH/Md4x+NJ93onctOxOIksCGCFVP/VjLYM68IDYtHvSj+sVea6TetYvKSO/rjTtKeurMlyh59LuqUJt3VfjWheI8eGWq5P790MrxJPHOYJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Rvblg8qH1UxY5jtZM5TWaMtqsnMDF7EcQ8xOG6c5N7byEeO33en5sVXE4PSoQV842xHH+K/gBMXLbdt0luZ9SAbiiu9eaQRMxtEAOjLQYMG2DHF8zbWL9d3RG4KV6ObJiSEl4SGy8mEztU/9foEn1nqPgno0SPpvsaTepL5rEUGRwX/4KRSqccUo1wUwZMdMURguYLrg/k8jIMP5Je5rsV8JYOCqqEdC8hZldjxkG0/8AQ4jHIVyfOkPkCURrQughF46y5wBUUmI2hz4rffRYMfdZFljE0vV/QY/4+Wj6jUx6Hb3QRM/JHgnkq3a6sKfDNQz7DXoyCy8bmYyFTOyKwFf1H/sARGP7esEdO7LBXYrnxYPZJx2aB0fot+6d1JdPA6G6rbF19qorC0gKTRUf2vZHl7rekWHw65/hgt9jYwssajB3x5IQC/YwZ7s0aqL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:16:03.1663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e05b8c02-235c-4e55-603e-08deff9f7fcb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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

From: Mangesh Gadre <Mangesh.Gadre@amd.com>

Add DPX to the 6-XCC supported mode mask
This allows DPX to be advertised and selected

Signed-off-by: Mangesh Gadre <Mangesh.Gadre@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 35faea0ff17ff..14293d52cf104 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -665,6 +665,7 @@ void amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr *xcp_mgr)
 		break;
 	case 6:
 		xcp_mgr->supp_xcp_modes = BIT(AMDGPU_SPX_PARTITION_MODE) |
+					  BIT(AMDGPU_DPX_PARTITION_MODE) |
 					  BIT(AMDGPU_TPX_PARTITION_MODE) |
 					  BIT(AMDGPU_CPX_PARTITION_MODE);
 		break;
-- 
2.55.0

