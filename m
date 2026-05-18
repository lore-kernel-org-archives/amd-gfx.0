Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3600FCD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 08:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6BF10E719;
	Mon, 18 May 2026 08:33:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JTL6NgGo";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFAB610E71F
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 08:33:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0WcdBRrbJP+BLqRPDkgQ53vdBQ4+/ESmoRvV2QoVvR6intjIZ97tjzu6FU63FPRwe1+PvZPugapKrzNUd/YleNdJCQaDzd3CtpkmLPGdckqZfDVJoGQtbC0j4NFqB5/ZphiW6FfsGS74EAc9mfr3uTvdL6ZB4s+sq3r4SqFRvHQy3a0Qoad+5JKlK/PEYbPt3BToVeRBwzh1vtozC400TbMNjfQXPlvybc349D5xoMN5UM8ICSlpriQyh1TLLeDyZRJ9Vi6oP98TD2taL8apddoaYcQaFrbr3shL5pVyWgdQELk2y+BfoWUv2Q0B8zp+gfaOso6XIg8QZNfc9WaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oo0HgpJfS74KNgXHpSuaO6AKILfEqmSxExoC/8RY9s=;
 b=FevlkYYvQIwAgE2jwUDav2sUtqns+Yka2zMbjB9ZTGIjPUjRW4bRwkaunyPZPlO+dWqjOmNxSpfYeWxFituUdE+bA68i2jrjs+B4aryEX6++PbXAEys/raLYB4PDzndTWAZzEh10tuYsBTY49D2Pd44tdllgrr5y261j+n9ekTYL6Y2OPyDpNie/eUhv3vGIaJcc+Kjoafv6qiQ1PrUPpWu+ECSEgVg+LUkZ71YC7PThujral9bHFBwUn/GcQjQmxcRJoo3U7icaxdDXAfruGbAlBWmy9rjiaTVQu+TC+pZwIUhlJAHAAQVHs+4pYWaBxngT4pPcnWAWRcUPVJP/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oo0HgpJfS74KNgXHpSuaO6AKILfEqmSxExoC/8RY9s=;
 b=JTL6NgGozZha8gvwnFEoelqQxMyha3rYz2qYjgnl2Y/NrWQ99B9waKXAAP0Wm5R+CeYuwp6CHUdw7ahAtu8tfTMYvoQeluAy+nXw1/KVEgwKcZP8tzrObnFxeqrW+0KwXBTvCyOQMZHfT0HT10dg3vVHuwYaCf+CqDcDXP/ftIU=
Received: from PH7P223CA0017.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::10)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 08:33:02 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::1f) by PH7P223CA0017.outlook.office365.com
 (2603:10b6:510:338::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 08:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 08:33:01 +0000
Received: from canli-build.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 03:32:59 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Stanley Yang <stanley.yang@amd.com>, Thomas Chai <yipeng.chai@amd.com>,
 Candice Li <candice.li@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: cap ATOM command table nesting depth
Date: Mon, 18 May 2026 16:32:45 +0800
Message-ID: <20260518083245.789799-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: b163063e-7210-4d92-f875-08deb4b812ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 2DChVWfsTw3/b9aqjnakUzlA+GmAhvcLjaXbzNuppaDDaxyuZFoGR70DPZ9u96W8b2fBR6NYxo7NufTF9QBRc65mTDgRgwMECY8wvw7oXa8552NQ91LPCJ/iAT7Iur+cim+EvPYDfTEfo5S1q6x/oZ9lziJjO49C8qLdcQt93QWGHRXlggdnC0p0tlWJLq4d8GgVyQ50YvTtdXauyjY4Vs4ADzehHgZJGtbClmd8qhuZL3FzOyWxCQ8KyOZMtVuLN1tp9Bd0tyrCluJwfQJteMUlvpTSCmC0zAZYw/ojn4VqlpQFWAr9KRM4AS3/JZiDiYgLKICrsyP0K141qpVUh4HBvpoJqU3k2UJtF+5VFqQ5lGRADQGC8FDK7ReR8qpxJv9iP41lXr9+Snl2NM/bTLcOkjHGpcu3AGiKWTLriuTDmRh6FzR+l+zkjZzt0z5q5XXsW26DLTKa45yr1lVUtanNnPdc+W5Gog14C2XJNKPBo5jYyqISaoxoe93+rDhdxfw2e8Iy8qWgjsbo2TJjJYblf70no7Ra5+Ve1/xZ80SKzSr6cOluShvxzYr7vLjN4gZ2zdUijG4EPsgj1W402MZzZsJ8onU/Idoq6zfa+M9WrRrqf8ST2032RjG0r1b2iNxuB7hGdnP7/gfgI/zq7h4XwV8l0ox/HfaQQKaPrRHAp3jgJYGsOBkZnB29Wy+7HPOYnyHmtTwb3PClFUwQsiT+Il9tdw4ryCihWvmhrL4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M2x1ivJquNiwdYhud+cVN+sleBXNeTwH2ygpUlvitWcOplZBJqRjtwHRfznKRHJReco0/EYiQUVIF+ZQCD0A4krD4tcpstmoec6M1pIvnckX1cj9DnV1aMNS93RyYjDK8ObvM7ZSFZMbA28mwtA/8UB+bKqEoUqqqr6d9X9f1J96SOVFbKj+zn/sbPX/7fvJM2DdPL/ojoCfh0VKXEpnD0qPlLKRy98sF0p5Ffi/zZ71f2Em2FnRom+15yWe3b28OiPtQRfjMxG5j4Sn7goz/iaaZ9KcXOZcvf7U/pQh5nY//bSaQLA8ct0vwNHqJYoRLzc6sBDj5iDuAjitFV3wPJnhUOmWAQGdKbaGrux54i/P7Niy5467kpcgmjDDNSUsZ+wKijQfUi9h400GfPkEKp43QHYzkl7u6ES+V9G9Zz0vASq9PO2XsVaAM3ahGELZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:33:01.7052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b163063e-7210-4d92-f875-08deb4b812ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625
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

Cap nesting at 32 levels with execute_depth and
return -ELOOP when exceeded.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index cc5b6ea7f6d8b4..a40ce7555f287f 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -59,6 +59,9 @@
 
 #define ATOM_CMD_TIMEOUT_SEC	20
 
+/* Limit ATOM command table recursion (calltable) to avoid kernel stack overflow. */
+#define ATOM_EXECUTE_MAX_DEPTH	32
+
 typedef struct {
 	struct atom_context *ctx;
 	uint32_t *ps, *ws;
@@ -1229,6 +1232,13 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	if (!base)
 		return -EINVAL;
 
+	if (ctx->execute_depth >= ATOM_EXECUTE_MAX_DEPTH) {
+		DRM_ERROR("atombios command table nesting exceeded limit (%u)\n",
+			  ATOM_EXECUTE_MAX_DEPTH);
+		return -ELOOP;
+	}
+	ctx->execute_depth++;
+
 	len = CU16(base + ATOM_CT_SIZE_PTR);
 	ws = CU8(base + ATOM_CT_WS_PTR);
 	ps = CU8(base + ATOM_CT_PS_PTR) & ATOM_CT_PS_MASK;
@@ -1285,6 +1295,7 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 free:
 	if (ws)
 		kfree(ectx.ws);
+	ctx->execute_depth--;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index 825ff28731f52d..bb3d9eb7eb6b56 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -153,6 +153,9 @@ struct atom_context {
 	uint8_t vbios_ver_str[STRLEN_NORMAL];
 	uint8_t date[STRLEN_NORMAL];
 	uint8_t build_num[STRLEN_NORMAL];
+
+	/* Nesting depth for ATOM_OP_CALLTABLE */
+	unsigned int execute_depth;
 };
 
 extern int amdgpu_atom_debug;
-- 
2.25.1

