Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82903CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1962D10E807;
	Wed, 29 Oct 2025 17:52:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CAqoZU+I";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B617410E806
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtLlmbfY45P4vQOdezxNOpWgq4CjFOMZhDCKZnQiRdflUIubwjPNwSbbiRyCykdDfVyeBPP0R+61wrtu2MP3eUGdc9gn8Y082sXRcjwGkuU1phXXDjVrVAAp4IwHlbUwh46k/XgJkSWfoPFeMIPkoxPafRqBHJYHW99b6Py8aZ4bf+HSmYOjvYQqHcZNUciFmHTTyYLj4L+zc7hOpys/sTRyxb/noH0bCGZFG33HvpgmdEauRxt0/Sa6PacJo3mu2tSH2LCbpHMFaiFkeYuPJqrXLC5cw70/5St++9e+oCprPOSKRHUF9gzWY2tp8VEz5W9qgM/dI8SgjfK4ZtE4Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7/bZBGQ3Dv/HCSI4RtwxBODFvrV6WITqcq/Jy3rQuc=;
 b=RpMXCSOuGEbOjuufw2+yIcPAU4cHWa5K9ddn/HQMmfkoCEnZzE2c1Ucf1vImiY+fvmkYoGl7lVOK+UoQZWDvEEqobg4TrIEKhV5GMi9Uj+Dj669mdzhbqiNAKZyt4a9dIKRyjqCklCmb+KG8vNh0X2wbWMDQLr956TATtdrkOi3X9wYIz3wfF/E4YgsIVIIc9MEkyyxDawlLRziNLtpxMWeaYSyo9HRvU+gwZeoAvm099i9DTM84mzkB8uKRo3Bd4zemsEFZU8aGWnHGtt7TV3IGvcmkVV4dmvW5Lpx+u3PAn1HUR1HSQQZ1Dku/pJyXyL2RxIxxMSGaKuCpPnNLig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7/bZBGQ3Dv/HCSI4RtwxBODFvrV6WITqcq/Jy3rQuc=;
 b=CAqoZU+IFw4JumbhnTfG8ulyYyrBzYairdrM0y2LJg0VXw3bKkSAVRIfUaC2O0oqOcQvknsapVOl+fGzhur+v5fqNia9IioComHipHPiHPZWyC7YsVTVTB2O1DDWg/22F5aZplhlUOTqAiFYLPnhC0eM711R2Zm9B31NJ/bCVKs=
Received: from BN0PR08CA0020.namprd08.prod.outlook.com (2603:10b6:408:142::8)
 by DS7PR12MB8083.namprd12.prod.outlook.com (2603:10b6:8:e4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 17:52:06 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::8d) by BN0PR08CA0020.outlook.office365.com
 (2603:10b6:408:142::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 17:52:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:52:05 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:59 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Move XCP_INST_MASK amdgpu_xcp.h
Date: Wed, 29 Oct 2025 13:51:35 -0400
Message-ID: <20251029175137.2861556-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029175137.2861556-1-alexander.deucher@amd.com>
References: <20251029175137.2861556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS7PR12MB8083:EE_
X-MS-Office365-Filtering-Correlation-Id: 544a3b13-2305-450b-0fff-08de1713dfd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pT/zJlpAXhtfBw5Lg+B+kJFhAbFiJ7S9FQMXY3VjR7C2+yXKGO4GJZis6Uts?=
 =?us-ascii?Q?vtm450Dz5dS/XCHzsYUTVB+J8Xycp0DurdhJYor3pN/DPdcgf0etF0O1pTB+?=
 =?us-ascii?Q?iq9d/9ly1jtMsJ05FEqL2X/fbSpAN1Pkb6hR6CSJNzE92xiHFp9MrsIOt9gX?=
 =?us-ascii?Q?0Eo0a9272e9bGwg7iEU+aEwFsmtO1vS/GP9541d+oaVgkrGSMxFfiIpu38GB?=
 =?us-ascii?Q?SIn2sVzsCriYkb07ZRTr0N1lX0IvhAgR2XdSL20H6o7TzUyW1K/E6u0gXpOy?=
 =?us-ascii?Q?3uBSFvvrU4LTDiItUz14RfhuGaEuZgdXw29AeumKSbuKo1WxOII+/fm4ItSu?=
 =?us-ascii?Q?EGffcAMFFgvQV4h0hroNd+CXYpC7wVaMPU9HIwKwyLXvaMNFOphcw7ppGh1f?=
 =?us-ascii?Q?V7xvhMHbjhNxJbi/y9AiuPz4RI4T9VcDLAheNHcJpGySwnc03StDn70YYd9t?=
 =?us-ascii?Q?BQsO+cL352J0XJOsuwpRsgry1u6hIdgiGzusF5yY7MMRLcZvyfRszOw6AaQ3?=
 =?us-ascii?Q?Y/MwU5HuDcH/HhECWcYJXkW7QCRnQnpCV3jcDoMl4yXRnHKukJQR8ID1HTPC?=
 =?us-ascii?Q?D2P/etEyte7i3fIMrC4/8TtjhgbQ05xO/TW1zGTK3YRA8bxZ+N/kFeEmU+oY?=
 =?us-ascii?Q?L9c2dnWies2wog1cspR567muC3Wz05nqptROPjqx2XIwCFRMeXYedXKXZ5Kt?=
 =?us-ascii?Q?1z0qcV+p60G/iZ7vvziIiixS9qWJ4WwzAGygGU6lXnLdxGdY/qsAnyewi/4w?=
 =?us-ascii?Q?g9RqJ1xW2UizBZiZGxrql8wE8srAiK5LSdNniemTGWzDe7vFXNgE+MRoDf14?=
 =?us-ascii?Q?/t4Tr/yxhEX3SsCoae0+7IWpQ8tpClyRWh1o614U/+EjRKZDBO3v6ZD8mPPH?=
 =?us-ascii?Q?/wpQ976NXY7/catF4ePi+Z4KAAdAkFUzCjuSsIt8HFsvBLXJdD87cAiT9HG7?=
 =?us-ascii?Q?ZlgcFijvbrc0/31/Bk1WLVyfYHkOCc2yZgx/uWqn2dm3gP3FLBEIM1B3Z3dk?=
 =?us-ascii?Q?+tQMfIORud9nLWwuOHVyuqa937Kyqy/tXmbI2DmtcMNR0M3k//KBWw2LoT9y?=
 =?us-ascii?Q?YtR2Yb4pDRIB8v33oO9mxQl1HHhYbErX24ay55/yR2zgB51WL9FCXwmZZogn?=
 =?us-ascii?Q?rOS8eOi2SUokvS+trndAEnT64GONINEcnc/DB9myGnZFkJPMnMGiIrUi6aAX?=
 =?us-ascii?Q?AUrKGfu9HK6LUVhNx2Fd+PTj66nPmTzFfmVVwTQPT/Jk0d/X+qxtmf6+O6H2?=
 =?us-ascii?Q?o2Pp8OQpOIXLmVWshoX97pMLXmJuc6mXCmDdoBLr+WDrGFHD25HNaiBPoRDi?=
 =?us-ascii?Q?pSC6CXthmqJB50LyjG7bjWCIfZY5KQAPDBT5Zr4of7glQJ+DszbWJnyuvDAw?=
 =?us-ascii?Q?t3TQdwIBfPplup+ocM5PDCrBbw8/Tw1+K1+F9L99SL8wL5GflPslLRt5lhp6?=
 =?us-ascii?Q?orJqyxno/yS9LXtFxTx9p63J0JYoIMPWJkn7DCFIYunXF1HCHogMNPatjxwF?=
 =?us-ascii?Q?pJnlRJI5POZZbxO9YbXuAvKeGYI3+HpoWLSXu34hcy20LDdY8fmRZ+D1Ojeu?=
 =?us-ascii?Q?AnTfWyJR6BmdOaYCijg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:52:05.9646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 544a3b13-2305-450b-0fff-08de1713dfd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8083
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Move the common macro for xcp manger to amdgpu_xcp.h

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    | 3 +++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 1928d9e224fca..8058e8f35d414 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -41,6 +41,9 @@
 
 #define AMDGPU_XCP_OPS_KFD	(1 << 0)
 
+#define XCP_INST_MASK(num_inst, xcp_id)		\
+	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
+
 struct amdgpu_fpriv;
 
 enum AMDGPU_XCP_IP_BLOCK {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 811124ff88a88..d6760050854d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -31,9 +31,6 @@
 #include "sdma_v4_4_2.h"
 #include "amdgpu_ip.h"
 
-#define XCP_INST_MASK(num_inst, xcp_id)                                        \
-	(num_inst ? GENMASK(num_inst - 1, 0) << (xcp_id * num_inst) : 0)
-
 void aqua_vanjaram_doorbell_index_init(struct amdgpu_device *adev)
 {
 	int i;
-- 
2.51.0

