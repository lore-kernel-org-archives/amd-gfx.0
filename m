Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06340C5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 06:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A8A10E255;
	Fri, 21 Aug 2026 06:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LiW9TEvP";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AD910E255
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 06:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QKIhljo79KSi8xS+XNEKnXrDh9Ddr4wpudwwNXpWKCOwV3C1SowND25M8sCp1dhfpV/RIPUKrsjHjKxf8XEtOBma+MemuGBMs5LRnQKsx33U+o4PNJIzlshHN73GxElHqPjDBf7nRdECOJrnYzR0ntQ0ATXRI5nBQJ6P0xHO7zr14sXVfH0mKAahuiy2Vpu6RftP6RIRkepujrvFQHt/UVr49MmfM90tlCWXzNSIR+l6i++C++lAVlbCnAXQXELTMEjtLDX6ezyRmWcl+sqTu3ghLeTKbcHniGCukqW5VjPOHtpwOJsyN0fAbrXDxMxT1DuFFY8elATXq/uhpTXpzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPbQZA6jLH1kH6jkg4mEj0Tafds+0c+6Qn28jCSURUo=;
 b=him6zje/7/WIRf3gWo9Mpxxl9FJceWJXhpBuAA3aTc+wBXy7E3qL1LuKMLLeQVY0SmHaT0FiQOYy0S2Xur+G91qqsu6nTwwNZxWbslrHQcev12yflTlZfB48X9G+tSemh/HH/UfoL9mUmSUaQvdulDY1rI6WSt1DdUjaa2ZQ27r31vukc9fALYqXnz5PfXGKoibxBsg255F3id1lXgOUp6bP2K0hOqYRdJ3/5xENVFzehETnOZIBxzpM5O+9VZMzLK1TL5w8whkfe/yaN5x0GcVXMj0ON6IXbM5TJYvjgGdZ0zBtrTj7kyf1+0/Zh3YbGnQHqmwevQKV36gDdoyINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPbQZA6jLH1kH6jkg4mEj0Tafds+0c+6Qn28jCSURUo=;
 b=LiW9TEvP9bruxpmTGdE1WNlwXRp9Gd62ZxSXEgvUsPau/tSVFaFZbMfMdJV3FcCne41jMWH9iJ5sv+I5VKie0kO63Mfi6bWPqvjwu1sxgSGzzT+PvEm19n4/1XToVf2hv5jQvbdAv94HWO3Am5qBDo1B+zc7Cssx+y6fTxhL2wI=
Received: from CH2PR14CA0020.namprd14.prod.outlook.com (2603:10b6:610:60::30)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 06:03:46 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::6f) by CH2PR14CA0020.outlook.office365.com
 (2603:10b6:610:60::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 06:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 06:03:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:44 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:42 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: extend UAPI for reporting userq invalid VA
Date: Fri, 21 Aug 2026 14:03:27 +0800
Message-ID: <20260821060328.461383-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260821060328.461383-1-Prike.Liang@amd.com>
References: <20260821060328.461383-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 3add19fe-8006-499b-03fd-08deff49f577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|22082099003|18002099003|6133799003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: yfcbRjuXqQgnFI715cvqp6YqHxD8UWrnKYpaLQEUZcq+BvBS9aSViSQTkAZFmkqNpiJk2+L8bRwPqjj461zuuHCY+hIytN+cSp2WaIJZBcJEMvaJQ41/AmHMHiS4BtvXWBrRhy7B0VSk+p60sa9HyKktKELB/0NSYRi8lp22cxdF67EEYt0CeaYaZSL0QM3k90AVLm5F1SrXXHXfl8D7m+aGmyZDFMqyB0Cn6P9DKockB7qAK9Vx9bwwgXTkrGvXnyabclLpKFn4mnDexexS6Cb+SAedi8tdhsAgUDwf2rdwgwYRnLbWPeE/Q1pZCikhlU7V2x9jm3GNAvaNEIW/X6cFiwZqo6UR1Ei3+wmXksYp4oP0CeQtfDvSmfmpM/c903NETgoYmPqfR0RUrJxrzsYIfokB/oDQ90j4RWxLOiShptmMZN3C3DpD8Lcv//munLpu6G9WgYeOHtFjc2m3/wtIphZLOYD92rk1qbvssod/PThV1hl8bGUrC4A1eWl8+DTW8fHJPPRftm3YADkZrNc7a1xfBb61uE3tp7ZRJgm6MwSBqSJUhnrPM7Knj8iUUmlE+dJlMzGEMoEw9z5MuLja/8f14w0ogYJ9Ty+U88XUGaMzpG1BjEfejRignZcnIBpkhwnYCUzSqWdUffUQU+Jg0ZCuobalnsqDA4dBFOTkeNOASwr8UQW+/YTkGd1rqSAm81P0/YVv3SysTY431Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rsDvlZA2aLoNID0g4PxGr9ygojoIzQcAr/HBjuoVoV6ZBEuSKwcgAGB6bWQYijklg5Wk7GfpdpwcGw9VgDXVbz1U1iEHAUjfoNso0Ee8mmq2caaGkXVOqJQuY6MUUNr/u0W91Q9Pts3tVgHfr9IjwrGL7zqjKqwRCbGqsHKf+D/Dhv5NU7jRkgBnb//AK0QkHdWw2kjz+SMfbPQR0POlypZjt73KRCZsYDnvGjKaegvHu/pQuTLSBoVFFz0AWoreUXYFfeJb6T8fgVyCbcMZYQ+tqDU7JZrET0G0tUbiyO7EqKYOzi7NVAKwTfvY/+K2t3bVPfWb9Lg8Quz5hJbgztlO73EwWQP/Sl7QcqTLq3Mw7EBv0R5e6Kri6a9vIOAdJ/OiuC5j6KVwrwcDAt18fbRP6Wr/AAILApjk+HsviL93mq0HQAPlTrAq0k/L1wgK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:03:44.8558 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add19fe-8006-499b-03fd-08deff49f577
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
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

Add UAPI new definition for reporting userq invalid
virtual address status to user space.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 15b0ccfe00e5..c0c48ce46849 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -350,7 +350,8 @@ union drm_amdgpu_ctx {
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
 /* indicate vram lost since queue was created */
 #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
-
+/* the invalid userq VA unmapped */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_INVALID_VA (1 << 2)
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
-- 
2.34.1

