Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDAACD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 14:10:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C47110EA15;
	Fri, 12 Jun 2026 14:10:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="am5zcz/L";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013022.outbound.protection.outlook.com
 [40.93.201.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAAA710EA15
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 14:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+LdERQP8txiwElNkyGZ5uEmmX299EXLmnbyobPotU8iarVR8vwHRjFy3R4cVKn+Q1cbaSkNvdSVKz/PdoQGcrCZzD+C6h1Sxr/hGyMjAWUFZwmg+2yaWSNe8LsDyHp4y0Ru3FeRzH5q4WwmhGLywt41+K1JMBHQsTByp+RMABDfYTf3LwOIoDJNoEvhfwe6VmfPdtvTbazuMWtH95FM+25SVOyyvO2GxqILBe0UrEnT/qmpKgtaYcuuHDbz2vnl4Zb2F8a12gbXZSYgh5Oaz95hSGo3US1oirt9wInkigzm159gLJiAOoFdmS1ubhiuKBpcCRWe4EA2V7cqx4Z3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSrVJtg94IPOfwrLC/1sN+3tJ2lQDRNsEyVyGIZWN/M=;
 b=ue2XAzThxDlbxgmuZUglnGjl4wRhS/WxBJLxwaQFOZpyM8QbneBC68z84fliT8e2daXfSm9JLE7vzmgQNUcWx+Gx9Rm+6IA+alTM0GgeT7JQtNG6oza761ItfG+TESNX0AtAH4Bb3SbW4CBILy81w4e3CtnAlfSiV1gbpzpZf7WBM6iz+ghTxbwQt8cyDNZR+id49thbFlUe6xPmABzOC6jffpIDZ59n5oN+YxAs846X2pel8p9or+K72rDEbXi33HqCBn07FtViMsx0K/xgcUZAURSJ/mARJfFmkYXMgg8x1ZfcZg+0z6ZOkNmhKz9Zw1MFidRjCnl5asJ8onMM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSrVJtg94IPOfwrLC/1sN+3tJ2lQDRNsEyVyGIZWN/M=;
 b=am5zcz/LtblOVrCO2aWEVAvvhFEV+3t/IPcwpvccbyGZl/mhJf/szTZLpMxMKd1es1icGWlhb7lxba+nZtEjgEu4RSwTbqQF614SqnFksmAB2sU6vzu8JUQespo7fJrEvuTLlmkMZ3ihQV3Rk/CGT/yw268OkZjoe3guXZ+egFE=
Received: from MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::23)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 14:10:29 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::17) by MW4P222CA0018.outlook.office365.com
 (2603:10b6:303:114::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.14 via Frontend Transport; Fri,
 12 Jun 2026 14:10:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 14:10:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 09:10:28 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 09:10:27 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 09:10:27 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, James Lin <PingLei.Lin@amd.com>
Subject: [PATCH] drm/amd/display: Add IN_FORMATS_ASYNC support for planes
Date: Fri, 12 Jun 2026 10:10:25 -0400
Message-ID: <20260612141025.3049776-1-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6456de-1fdb-49c5-5b42-08dec88c5b8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|6133799003|18002099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: zN4GycfojbwcXorlWfjioqM7m8ok/X3kQGZ8WLdlgFPl0AoM4DDkUGiWoW7KDn4bzhVl8itvC3YjJr3v36m9Gm2PVO23K134Yyy2L0ZQYg/+PLsviQCcWdsUm7DVnhmSyVY6DoqZYcGdhEsmRdvCIDN7DtXMFjIPBfdDjG8EKagv3UJS2YRsq0xalMhX+KLPIyCjfXz3SAf+pqoxIOKMak4FzWdF76xVHmQJ0NcE7qJvKiNA6uvwB6ubrpcpqs5SnvN8kEhSe3OX4d2KyOYajxl35Y8JdHmcmoNqc2VxP+cLIR36CvKfAdWWfdUR0BDDc/08Edq8kbU0uI+U2DAGvMMbLm7p3bnOAy5zJlCJ5B+21zZggR0W9WZPA6Phogr0Z3tNxL7c7c/CD3SVEywCwXiTcxvBMCj+stsQ1yxuTktVx/mItjAo9OOuRRYtg/EUD6wPZXR2Vgq/5RaK+X9DQh8jyfAV4SyiUuTi7eKXEUsmMP+OJZyTIxYNvNVsmQClEDnoxfaXj/doHMjSBskoxgYM5i4pzIXDY14gnjmw7Da982ta72R31XJWmHb01/JC9W39GdQefp61mBbgJjIhDtXDL2MTRsmA+W62bfqwuDxoITZybtfJyxP4MSgVqCXfuevJdHkh3VL1CU6HWVV3rZj17g13EAwUT1eO1EBpjOLYWpp9JVF3ENB07KqC+oOPvlVt4IbXO6UUgTusgVD11clnewehNlepGPZmBnlugkg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(6133799003)(18002099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pSwIluCf6UPN8qZm9oUdDlPaFNe8Ug7ZtZGfx1dnW1eGaUvUHFj+bH4cHirp+YK1MkTGSCEmSaTB41ZZ4g9WhtqNbwefiNxRijPqtxfKNHX0jaxyUWqjShSn0qO/g+Dmjk1nzSg1PUzuxDEgwE2Mly3GFszk3MTaiLzDXLk19PS0PIHp4VBQf0rZdNTPTPwwNHEX3XLiqHQygxaIDIReRMjKyOVj6BFpRl0yXazk9bk8GSu2XMHLDA3yXtaYUuwNrAq4CKzYJCONhhyJuPo8WDixHi+en6g4GYV7X7Jf0fSThQ56wgAt+vVHGYsCbqAF7H6bb0QfLSfKtmB4jNDhEdndKtPKZIZVGfdqLaeXHK8wYsgtByLgZKdO3WnvG8cwND8lGhWR7cGcci5TWtBIzky4k31qbuDoeJfLtrZ4wixNGbS5K6ACR7p0ehjTAQA9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 14:10:28.8606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6456de-1fdb-49c5-5b42-08dec88c5b8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why]
The DRM core exposes an IN_FORMATS_ASYNC plane property describing the
set of format/modifier pairs that are valid for asynchronous (immediate)
page flips. amdgpu already advertises async page flip support via
mode_config.async_page_flip = true, but never implemented the
.format_mod_supported_async plane callback, so the IN_FORMATS_ASYNC
property was not created.

This inconsistency (advertising async flips while exposing IN_FORMATS but
no IN_FORMATS_ASYNC) causes userspace, such as igt-gpu-tools, to emit a
repeated warning during plane initialization, which in turn demotes many
otherwise passing KMS subtests to a WARN result.

[How]
Wire up .format_mod_supported_async to the existing
amdgpu_dm_plane_format_mod_supported callback so the async format list is
populated. amdgpu does not restrict async flips at the format/modifier
level: the async flip constraints are enforced at atomic check and commit
time and only require a fast update (no change to FB pitch, DCC state,
rotation or memory type) between the old and new buffers. Therefore the
set of formats/modifiers valid for async flips is identical to the
regular IN_FORMATS set, and the same callback can be reused.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 23a9faa2ea89..b122bdd3ea6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1859,6 +1859,7 @@ static const struct drm_plane_funcs dm_plane_funcs = {
 	.atomic_duplicate_state = amdgpu_dm_plane_drm_plane_duplicate_state,
 	.atomic_destroy_state = amdgpu_dm_plane_drm_plane_destroy_state,
 	.format_mod_supported = amdgpu_dm_plane_format_mod_supported,
+	.format_mod_supported_async = amdgpu_dm_plane_format_mod_supported,
 #ifdef AMD_PRIVATE_COLOR
 	.atomic_set_property = dm_atomic_plane_set_property,
 	.atomic_get_property = dm_atomic_plane_get_property,
-- 
2.43.0

