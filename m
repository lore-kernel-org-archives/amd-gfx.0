Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5405C5DF8E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 06:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531A510F218;
	Fri, 21 Aug 2026 06:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="stp0EGaQ";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012064.outbound.protection.outlook.com [52.101.48.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CC810E255
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 06:03:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwdYVkk+lvmq60idSetwM7Wa/jOPaLDbxo53oaFhs4h5UcbZpXEnQbG1d8B4Du9klv3MtQDPQpnDW3PnYlIu/lYf86lF8lmfbMLum+ywgO7qSX3TkfuqZsHMrhwjGS6LGIAOqmyA/74UFMkZgFxShkQ91NKBWAWOdo4KqYjUalPuHgI5xQu1ojjbj8ZPG8ucpC6A3cgMTJA4eBekXoGEANthp3rv1794C3mL4kvVAu9T+fGzyAHGqKV+iDcfb3SoJ3Y984vFUdWWZN7hkw9vL08nYJ20yOyr9bgzmpfO5bQqe4gCFrWk/uOtlQiYFRaeeAlRUlDoVT60Rp4cqZPkVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/V0n3vILd8+9SjHxPofZUUH3WOS0t06o25nl0kjPJk=;
 b=jNH8sjqPct7OL8JAOmCkl8F6QBULLSu2V5NnNz13GPyb1U4ix18E0DEKioHc59b7pcweaOnjiGq79+MIpUC2JjlPaFA1BYbBVi82kVElVk+MAZ5b4uW8JyhI8geWpMZ+IHN04PENwK60amSuK7B50o4SgaWJ3qLlhfgODdAvC+PQY7rMO/9ebV3ICBkxRISvYq0SaxBFN4qOVdAdG1fdUlzKh9dkOH/m+PsIhhawfwh2XroEa/OzS2gvwRJ9zpt0b4Mh36GXjj2HECtqqmVeuygQHFGld8De88THW7KjXpT8I5SOfiasVX1P2CoS+nXUHR5XAdHGdjgNLEJD04v+GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/V0n3vILd8+9SjHxPofZUUH3WOS0t06o25nl0kjPJk=;
 b=stp0EGaQSoZOO8op7Zu+3mUeVyOnVKUs+p/KgsV0hpadXP5XY5jx8cwEMtrX85ZSr5kR/YQk8f4WA9uNrHFJndCHZGcRYGKVC+M/dBjfktFHwx8f8RRpwB5YksCGeNBvdBodKZT0rQur6q8WRI6VArfGGK8vITBJEJx908qbEvQ=
Received: from CH0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:610:e4::17)
 by SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 06:03:45 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::74) by CH0PR03CA0192.outlook.office365.com
 (2603:10b6:610:e4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 06:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 21 Aug 2026 06:03:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:40 -0500
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 01:03:38 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Pierre-eric.Pelloux-prayer@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Sunil Khatri <sunil.khatri@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 1/4] drm/amdgpu: add UAPI for user queue query status
Date: Fri, 21 Aug 2026 14:03:25 +0800
Message-ID: <20260821060328.461383-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 2485f60c-faa2-45f4-a70a-08deff49f54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|18002099003|56012099006|3023799007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: WppQkUwqvxAmcXO+nWkiwreTuwDcBjz2xOowlUnSN++qVFb6BnCb3Uh1Og37JCY81wQncB/nx7PLDTfrthd6Pm3JzMeYlBshLU3129ABBVzAd0mWEAmgXr2loiU54jkDQRLYjvw8YGZcrvRuVoqRKaMcrJuo7WumU9j7leVAwlsHOXyTgXM+fYFpoHkIODTpYUuPOUyeulkqmrciW+t+TBTDIb+95tDphg/cbh4rXyopjOfRmWtiTRURw6KRuvLaKDJ3EI4mjpyzFsim5lR9O4ucU5n3KwuDs5buhYBTqxRkfcwXUQgksMZdgcTzTSIzVOhIAMkzl9XZr4Tvf14z8w6FuMYkO3BzvmLBsIzCGQRZIxBKy9H+QfyI68M0GMrObKV+SAyIJ6LJ9nINzZpCZywK5uvJt+C2Y1NlOu7w6TNd6f3Uaq0ko2PrlVD8ISGOYnO0Cj//+hhjpWPBnlbTenNwwPUtYNbtzQDx71UeFj6jSYnswRj6V1OJ+jHvWwqhcQoAxSfPt7HOzsaln3QF0dleRWqujhMiOacoRRN/qaoU4B5DA0fNQKiWFzdapbqX7mP3J/q+MnqTeWDCKG1BNZm+mT/g5rjNoU4KTqKVTBMF3RcoRcUyalC+aB4kvzOlA8aafhJ9RbibwiL2CaWcNOIKrAclH9cjQ9RgJF5pNdM/xnbYzXwwfdcv2KDv+Nvsuua/GqcxSsEVBZezuJ86cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(18002099003)(56012099006)(3023799007)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oiRksuCl7rH7CQmk9Xm80n2aHseBaCq0V28+xXQDdiwm2WUgfofHwASyqW5cc+3qYBaKkkNsNriQ89+NK1UOJEOzrEMkkGEMU7MsRuyvyCGqWS8YgU44YPRarTno94WWz8Fa0MiW7Qib6EbNj9OTw7xpANLVF9/Gj/5ZPtT+Dx7Q1Gjk1x50oubvbFT+Hngg9ox8KzpZGfLzIqjwWiU73G/JLf9hSq5NN2BmbEVDjllTSMXmsKf8F6rvJTnuamPYFLs4UC2qqrkYopRNHpKicm8bW8vEmjdt4fAvHJoCdJNoxlHIy7cWdIEU6FktkLySUSjpvpibYe8UVIBxNTAPfMEtn0nynTSvEQ6oSL6HKWuIckn6JbqeLeMdXP7udwzn/jrKenfWHZ4myVhG8oSxf9b4spYbdmVLaXEmVSjaloVfgyKO9NYGIPcgSu4BsZVs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 06:03:44.5721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2485f60c-faa2-45f4-a70a-08deff49f54b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114
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

From: Alex Deucher <alexander.deucher@amd.com>

Add an API to query queue status such as whether the
queue is hung or whether vram is lost.

Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Prike Liang <Prike.Liang@amd.com>
---
 include/uapi/drm/amdgpu_drm.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 0a113529bdcb..15b0ccfe00e5 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -332,6 +332,7 @@ union drm_amdgpu_ctx {
 /* user queue IOCTL operations */
 #define AMDGPU_USERQ_OP_CREATE	1
 #define AMDGPU_USERQ_OP_FREE	2
+#define AMDGPU_USERQ_OP_QUERY_STATUS	3
 
 /* queue priority levels */
 /* low < normal low < normal high < high */
@@ -344,6 +345,12 @@ union drm_amdgpu_ctx {
 /* for queues that need access to protected content */
 #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
 
+
+/* the queue is hung */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
+/* indicate vram lost since queue was created */
+#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
+
 /*
  * This structure is a container to pass input configuration
  * info for all supported userqueue related operations.
@@ -425,9 +432,16 @@ struct drm_amdgpu_userq_out {
 	__u32 _pad;
 };
 
+/* The structure to carry output of userqueue ops */
+struct drm_amdgpu_userq_out_query_state {
+	__u32 flags;
+	__u32 _pad;
+};
+
 union drm_amdgpu_userq {
 	struct drm_amdgpu_userq_in in;
 	struct drm_amdgpu_userq_out out;
+	struct drm_amdgpu_userq_out_query_state out_qs;
 };
 
 /* GFX V11 IP specific MQD parameters */
-- 
2.34.1

