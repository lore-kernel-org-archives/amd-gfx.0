Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3115C5B572
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C90A10F6D2;
	Fri, 14 Aug 2026 21:03:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zeMHbJ/Q";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 967AD10F6CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOgUTWgeJzRD3eo8IibU6uZhVc3pbvYzhlZTvVaIxUTfAhBRlkDGBnrE+1V62dJJ9u088LVAENhll6nvI8MW2+yDJxzA8+N/LokEGtl3R+Mp5XzTTvKz9mpXvsg0DNVdapsRMlRcQkF5ESwM0wsm4A0VxQW0eiWdlBbeHNmhki+e1VZ77dbLJDam1sDQBf87oRp3C5CN8fRPqMo35wB8wJw1QSiYAvdLbEY4Q8+DuTpFMa/GwdeWHo5+mMNWiUkHhGx7UznrgDJE9KqtvrviTbg50dzPIn/UvkA/NqqHk9MaH6WskqP5Jk9EEJPCx5weJmPe56LG64uOW1R/TiaR8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyNMbZR5YcdjIncDtESXbiejSorRDNQx/twpwt3wnQs=;
 b=lMy8w78btAClb8YAmHLO1L4YRMirI0ddlEJBHn2TVvGyLkes+PNxedeMWSMuIcY95AOnkb2hATo9KzWmJgCOdbuYCopwTNFw5UPVydkueQvPJ4nNQtIqsrf/hAVjBXn49Kx3f26dplUbt/LiFgcTGvkrLJfmIGOCLwH7HX3b6S/TWQONXh47Z+MABMdxkg/PB9bWaw/rzMLXHb4F55Easn5knuAtnfwqf9GtpKqCqwrQ/kfstSw6n6DLl2CdV8dBjN+7zEkCFXJz1FO5zw/FQ42+Mzgqc6SyLkropGIJ0jqpoLjhtUkeNtmU1x27/bpbSsWEm4IZ3EBzr29TevxMKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyNMbZR5YcdjIncDtESXbiejSorRDNQx/twpwt3wnQs=;
 b=zeMHbJ/QriswBL9MKfMXKBQIagYhbwrMmZCd+6JP1XVd2mHTou9sOsXsOiop8EJ54SCGLxEouTw5jTJTkXkGu98mVaTjcJEPbn24WxLceUI2FcW7yv3SQ6TEigtScI52Aa6ZvFoAzs54+1KHeVJlIStHRRoBFJZ1uwUDf3KBucU=
Received: from DS1PR07CA0025.namprd07.prod.outlook.com (2603:10b6:8:44d::9) by
 IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.16; Fri, 14 Aug 2026 21:03:03 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:44d:cafe::14) by DS1PR07CA0025.outlook.office365.com
 (2603:10b6:8:44d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 009/109] drm/amd/ras: optimize mp1 dump bank interface
Date: Fri, 14 Aug 2026 17:01:06 -0400
Message-ID: <20260814210246.3067612-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a426f7a-1e45-444b-47a8-08defa476e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jZYkvuy+BpNBt2YoMDsbPndU7v39YLqeHWTgqsCa/JBd0O9bcU5GCxmM/KHVYyfsHmwUjcb/15Vs3KJosg9HZO7ViElgJuaAuN6K4syhjzkRbgKo0dW3VgvwAqTWjo9V1kG8hWMZtVBYQoALQuMqbnc3Gg0VsEkvnyVw5omKhC6CmDg7oSaq2rzHtBMcST8zX/DNiOHK3bif2a+st/eH7S+oAXbl84FsZNDekOAf7d0KAF1Cw+RppLHSiuVU5IO5WO/7sF0goJkMYAWCtU+RFFBNg54/rJxuXLGmDD4RA8C0wtl0EjWB7JkMhztNACSaO/3FTtFH7vmIyr+2RYqBE+1m9MZPfrWuOmNwjdO5189p2wOYIHWQnU9rSk0xt5WeDhhk1CsmkrR5Q8GqEV+05uTVj1Wvg1A+6IXMeht933q1vP3FwG+W7sgVszHqhM1XV16sHaXmxkff91ubbIDq0fI1TOwIFT51/DoUxEU4onW2v1J3yK09eP/1oRYfIfjcWxAmYpa68xm/zfOzEF4SYHz36Inx6klOt5oAGHlXovy3NsWQL3JqT7nj+HR4U4+nuC+1+m4YDxQmscRgod5eqsNtTc6yxsaOFdm2ILxzVX795xuj215+JekIrjIpqh75RgBoYEShZqmAA5EMmhJzMoQ7p/DF3f6M3TADJOwOowZPJDZNUjvv0u6frcZxZhLpJeklckgyZsGX3VbIKXC0Iw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GIkCUX78ds4UXTbP/iGM/+9qWnmdcDN3nrIJ/hGCHEY4aJWDtbJDm6jCi5wG28hvP5PtBXdqgd5dh8KmnD/BXxTgPBlgJkHsuJZ9J2uybNKdx7q+oJghtjDyF3uAlvGHzJXqOWBHMpo01XwJDi+sPAlY7p4LyY3gDAFQdQnBv7I9LkrUq0rIXZoRtx0Te0KaxAyGfVFPBC8euSI79IAtj4pLHMV98QK41UJWwknqqnCX8SUZHaEX2JC45hdCGPFlPeZoPzjBqnzEGpnRYreT+jATjkDVEGzrjDUp0nY8snusL/h+mLdv7uasdILhVFqDHg0J4S6FjUm7/Fff1aRDpGuWfVrGl3Jgdnbn7nhSwTdzg1N1Xq2eYwRhFOQomZZ6/GrGUmLSboEJ+aDbj1mIa0W9Cd3jj5QtELm9w/u0my/xbay8ywPGf9JY/ucTj+vK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:03.0353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a426f7a-1e45-444b-47a8-08defa476e23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Optimize mp1 dump bank interface.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c           | 11 ++---------
 drivers/gpu/drm/amd/ras/core/ras_mp1.c       | 11 +++++++++--
 drivers/gpu/drm/amd/ras/core/ras_mp1.h       |  4 ++--
 drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c | 12 ++++++++++--
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 0b5d55e39e25a..de47137379a16 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -284,16 +284,9 @@ static int aca_dump_bank(struct ras_core_context *ras_core, u32 ecc_type,
 			 int idx, void *data)
 {
 	struct aca_bank_reg *bank = (struct aca_bank_reg *)data;
-	int i, ret, reg_cnt;
 
-	reg_cnt = min_t(int, 16, ARRAY_SIZE(bank->regs));
-	for (i = 0; i < reg_cnt; i++) {
-		ret = ras_mp1_dump_bank(ras_core, ecc_type, idx, i, &bank->regs[i]);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	return ras_mp1_dump_bank(ras_core, ecc_type, idx,
+				bank->regs, ARRAY_SIZE(bank->regs));
 }
 
 static uint64_t aca_get_bank_seqno(struct ras_core_context *ras_core,
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 26af09f3574a8..97ae049fea496 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -48,15 +48,22 @@ int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
 
+	if (!mp1->ip_func || !mp1->ip_func->get_valid_bank_count)
+		return 0;
+
 	return mp1->ip_func->get_valid_bank_count(ras_core, type, count);
 }
 
 int ras_mp1_dump_bank(struct ras_core_context *ras_core,
-		u32 type, u32 idx, u32 reg_idx, u64 *val)
+		u32 type, u32 idx, u64 *regs, u32 regs_sz)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
 
-	return mp1->ip_func->dump_valid_bank(ras_core, type, idx, reg_idx, val);
+	if (!mp1->ip_func || !mp1->ip_func->dump_valid_bank)
+		return 0;
+
+	return mp1->ip_func->dump_valid_bank(ras_core,
+				type, idx, regs, regs_sz);
 }
 
 int ras_mp1_set_debug_mode(struct ras_core_context *ras_core, bool enable)
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index 5bc7c1b7fdab6..17499e1c9c54b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -30,7 +30,7 @@ struct ras_mp1_ip_func {
 	int (*get_valid_bank_count)(struct ras_core_context *ras_core,
 			enum ras_err_type type, u32 *count);
 	int (*dump_valid_bank)(struct ras_core_context *ras_core,
-		enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val);
+		enum ras_err_type type, u32 idx, u64 *regs, u32 regs_sz);
 	int (*set_debug_mode)(struct ras_core_context *ras_core, bool enable);
 };
 
@@ -47,7 +47,7 @@ int ras_mp1_get_bank_count(struct ras_core_context *ras_core,
 			    enum ras_err_type type, u32 *count);
 
 int ras_mp1_dump_bank(struct ras_core_context *ras_core,
-		u32 ecc_type, u32 idx, u32 reg_idx, u64 *val);
+		u32 ecc_type, u32 idx, u64 *regs, u32 regs_sz);
 
 int ras_mp1_set_debug_mode(struct ras_core_context *ras_core, bool enable);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
index b9db91859e5dc..6fd746fe64c48 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1_v13_0.c
@@ -75,10 +75,11 @@ static int mp1_v13_0_get_bank_count(struct ras_core_context *ras_core,
 }
 
 static int mp1_v13_0_dump_bank(struct ras_core_context *ras_core,
-			enum ras_err_type type, u32 idx, u32 reg_idx, u64 *val)
+			enum ras_err_type type, u32 idx, u64 *regs, u32 regs_sz)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
 	const struct ras_mp1_sys_func *sys_func = mp1->sys_func;
+	int i, ret, reg_cnt;
 	u32 msg;
 
 	if (!sys_func || !sys_func->mp1_dump_valid_bank)
@@ -96,7 +97,14 @@ static int mp1_v13_0_dump_bank(struct ras_core_context *ras_core,
 		return -EINVAL;
 	}
 
-	return sys_func->mp1_dump_valid_bank(ras_core, msg, idx, reg_idx, val);
+	reg_cnt = min_t(int, 16, regs_sz);
+	for (i = 0; i < reg_cnt; i++) {
+		ret = sys_func->mp1_dump_valid_bank(ras_core, msg, idx, i, &regs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int mp1_v13_0_set_debug_mode(struct ras_core_context *ras_core, bool enable)
-- 
2.55.0

