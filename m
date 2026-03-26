Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D406109E542
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 03:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14C610E916;
	Thu, 26 Mar 2026 03:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gYe7Lmwb";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D9A10E916
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 03:00:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jayKGjKJASPrX8iM8Knj0TPwiMNWy2taXDqFnDnUdQnEcrkqdmc7jjpIng509k3BgwT2BHT5Sq0TUlrwTa1oU8J6NE12GyhlgM/4QEGo+PWDXEYajVLNphjI5NTbOQZuDTreNlR8PGWZA1igaY/hfTiYAHWmqihvq9rtryI6C/3UgEtqnOPN18dsikB5nq/BYC1wR/gkzaEanPcXzufJkhkJwcHSuyjw7Y8MIC0F4GuAg+xsEWFxg/pyc/yN6vsPTp4zwzNUByM4k+ybXqtDF4nHZG9Qg1qkvAP3UxwvLNA49/gotCSPnfPJUSU/5D5J5px7nW8SHv4kjK5sN7SogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+bOpySWx32EqyxHjYR9J+OSsVQf7X2rl11LbTUg+gE=;
 b=jQ5c8+PCL9hxNF0oJg7evp/dNqpqpNSA69KKp1JEMm5O6qg9eoY1wG+pI+UuroYa+XF47FqqwIxrqEPxG8sz1Qg2JG86Kqkpf5tOYwlp70GMfw5Uf66ehgAfJkGeP7a/XHSCGVKL5y3cq2rNOpv9gyoOpZk/WYOon7kqGST5BlceF2tpn6UcEw0P2gTmEFQ9mzcpz6xe+KV8Fp23KseVBmKYt8Ne4Kh7oVYRXeLTPKOSiyWp7UnCM5FFQGMEt278S1QEXbJosWJX2kM/9UkJ/3WhXg/N1nyjwddJOirl5QOVoQFzyjMYpVbti+L4krxI53atpIlEs4GxioXHau6INQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+bOpySWx32EqyxHjYR9J+OSsVQf7X2rl11LbTUg+gE=;
 b=gYe7LmwbdKUTPlZncfJg6kKZ3njbLx7C2NUG0rykOzBkm0IbZaSv8ipjIuPnJNHJSVHQow9TXCaKiLJzpZDJqlMN5kWTcH8vcBgRwJtgXpSugCXNsdSL6iRZ8zg9GzAIWtx5EbFqiJFOBeEfuV3KLgNG+QHEpge8XPm/VI8JkQE=
Received: from BL0PR0102CA0018.prod.exchangelabs.com (2603:10b6:207:18::31) by
 BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 03:00:41 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:207:18:cafe::27) by BL0PR0102CA0018.outlook.office365.com
 (2603:10b6:207:18::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Thu,
 26 Mar 2026 03:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 03:00:40 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 22:00:36 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Gaghik Khachatrian <gaghik.khachatrian@amd.com>,
 "Clayton King" <clayton.king@amd.com>, Dillon Varone <dillon.varone@amd.com>, 
 "Chuanyu Tseng" <chuanyu.tseng@amd.com>
Subject: [PATCH v2 04/30] drm/amd/display: Fix Compiler Warning - unused func
 parameters
Date: Thu, 26 Mar 2026 10:56:55 +0800
Message-ID: <20260326030153.406612-5-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: b41abc5c-dec2-474b-651d-08de8ae3dd4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: +XxSzEe3kBQznyCJ/Xs6H3RZ6HMY7uG8NhFxfc1riCgM6WhjuABSC3OfpKwNLuy9omv9Qq1mV/KKOR9JNTIQV9cJpCFAQkxZoCGE25jfOE24NrJQpF9BgRdR1b7FaZmbnQRR/JtDrJ5ldynNewm71xc7Teny9KkeC1WoRycnFZObTSzQ1ziMTpZGTEa7cKf1MQsrzxbJ+rsH839ct1g3Wx5cjdlwYW9TW8LByeZ39sGWx9xgcftERFqLonjVZClSQNI23gc+r1eYik4a9dl951n9z9N1HTeo7CyEPE2QezcCA+fCLvnxRtgOsDnHthdU25czp/AniHvij64q3Uf8iu7CTCGOxG0h/y2X2CmQ3Z3/+zUkov/WJshIOr/ftgQZfLQX2rcme5gDjz4lcS0LMIzhnZCz8gPtHX7V/3JttJW5iR9XIFKTSHYgJagDRLU5WJWr2jFMX/Ue88Qvj00t2J40+I0Rv6c1OfhY2Zks3X/hthB1ULz3dipLbUX2K89Vl5KXNh+yfQ6poFjBFt1/oWj9DK3IBelDgTMt01wZviqqrazhOHojA6R2fRsgfkTmz/uUOgqg2V8/fuov5PMsefBJ8GlCBxIj3D8WD32mVxcFCH73V5ACM1bLAxU6cvbP7T1X+hSSFi4ruv/6pOvosjCMYtOYBMjNfRsSMIhd6EZP9i0jtKahFWEFibg+WmLuaLULk426biUqE1MADW5JmdAl72xVR5geOb7Di1DcNfagA9OO0HT4lofMIq+CR5q5mo3RHXXyX0ikTPiVIHIS8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AiHm4Ir4pXiZQJwEAIs2UWWkJdcR2JHKt29cDqvs+rnQbOSosOaMV/Cgpmwc0F/vm+ifaFew0niLzMnYPlt8ycD5AAXZdFfxQbxr2H6OJzHcnPKL41Fn0l28Cqj1079db6k0E9nv2/lH+HbwDiKOskW88vT9fpeZXuOeJCxq84Dsplwe8h/7Jwh/HsZpzogWyLZa648tERnz/G06AAeh7zBqIOJUL5DfVkuaGe4uZCPzYhODB1QOmsblksrULkeBTFtKG6Cf3UIiKQmKAY0DEM+/evnAYTFrV5JYZXLj5KfK6GibSacaY1NpUMitXCEbaPvmO/O9ftUs0PYUTxPOXQ4aQ+snum4Js0KJC2H+3LoUX06DgsE4wc19kDiVIedzr/WDudwPYtl/pHWEVsotKBijYqyOiWlKSaHDxmmcpO8pbLH1/xh1rghnLbBNfba1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 03:00:40.7867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b41abc5c-dec2-474b-651d-08de8ae3dd4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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

From: Gaghik Khachatrian <gaghik.khachatrian@amd.com>

Handling unused function parameter due to cause compiler warning

Reviewed-by: Clayton King <clayton.king@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8b21816cf7c8..5d27666bbc7f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3142,6 +3142,9 @@ static struct surface_update_descriptor check_update_state_and_surfaces_for_stre
 		const int surface_count,
 		const struct dc_stream_update *stream_update)
 {
+	(void)check_config;
+	(void)stream_update;
+
 	const struct dc_state *context = dc->current_state;
 
 	struct surface_update_descriptor overall_type = { UPDATE_TYPE_ADDR_ONLY, LOCK_DESCRIPTOR_NONE};
-- 
2.43.0

