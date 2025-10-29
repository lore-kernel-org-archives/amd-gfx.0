Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3EECCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 17:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D345C10E80C;
	Wed, 29 Oct 2025 17:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aV/HW2/c";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010013.outbound.protection.outlook.com [52.101.61.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26FF10E21A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 17:51:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk4l3zHY3SbNQpFoi0jxjfibckigkbP7WlGXd1tDHp9c3c+5QEhRI8caA84S0BZn+emzJS+/O/RD5Lr6hloLfbTCsxuqdqoiJp166uAVPTaX0Obn9YJckEy9YYsfdqUaS/Bb27JSw/+FfkndoNCwGz4xNdMkwrVrI0Jf1QWHOTqbPIG0Q5+48e9swb113B7m5bkUO8vFt7yxsFwjr6392f6nHLVHd025oWmkSI3bGyvYQ61BlLuvEbzohoP2wcb98ZDwTFtQ2kCa3jtD42WQBAKPTVV77BOmIksEkOsvUSJHIJVh/8peHS2rvZt/+OfSpYYF9OjyPEr6a8hBGAS5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUuGfXOkipye1PBREgJTvZ8NAhGBNuYnTPNmnqRcGXo=;
 b=LkUnSBzmtKDRgjrLOgxXX9be6kDWETlgmQtczTW3DsWPQaiJQh0kOwlkTxS+12mEMlhX/O7PGJed2Ph6lHX+LWw7qcvNjU9t3/4dZjAWGqggHDXIcWlbZRf+tLn9i2rdhGzVjvhR1a91k1XHjWF1kjt7/SQ/hMSrp7oqEgiBEpMVLh9Fb/XPX6a/PlH/vXrXvIEPCpfVKxDz9UCsL7CeE9l+U4aIiHT6SCyTrIBeMhrJoh6uc0VbKh3UEtRZxI/2ZWrSV3ERXvMZqZjnHnScAyzWJDRLKjuWa/kMJI34X3l16kOlXY3LU3z0dOHqmiEMkslLrNZN98/1bBllLJ58JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUuGfXOkipye1PBREgJTvZ8NAhGBNuYnTPNmnqRcGXo=;
 b=aV/HW2/cvfdTmwwDanwPokk3kcp0FxEpOnnOR+i0AHJJ0Xt64HmGqnGPqKqYyCfi5xQqkcp/JOYtWqQqDg8Cy5ThK+0wa17exArRkpWo2cV7BHUiwXtD3EqWaty/a7dFiSoQ0gbLwKaMAH77p0wTesQ5+tqT6JuuUpQ/4Xm1NDU=
Received: from BN0PR08CA0028.namprd08.prod.outlook.com (2603:10b6:408:142::27)
 by DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 17:51:55 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::fe) by BN0PR08CA0028.outlook.office365.com
 (2603:10b6:408:142::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 17:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 17:51:55 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 10:51:54 -0700
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Increase the maximum number of IP instances
Date: Wed, 29 Oct 2025 13:51:26 -0400
Message-ID: <20251029175137.2861556-2-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f1e60e5-2c26-4a45-ee3e-08de1713d970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/AhROLCYtAyj73eSGdNbqRBA8rsb25KyqWeYP4QbrB6V9xY4EBcjkvb0VZDZ?=
 =?us-ascii?Q?5j5VNQYj7XUfUOHe8mQ4FN2ANrIqkZ+z7/deQhuZteadpv1fTNpTaaBcGxyh?=
 =?us-ascii?Q?CTWKB9nhl+Q7sm6pYFkD+znJmNOZZT5bk2hR7MpnIQ4A5hSlJK08hjJ5Y+xH?=
 =?us-ascii?Q?wgKSSXokrz2T4PRYPSn7Om3M2JKInt5/H85rdiDQFu5Ogs06FB5Tzho/ZcEZ?=
 =?us-ascii?Q?LqOGj3gi5BX8auckeJqBanp6SOnXjHC6FTWzVoThT4Eqqbq/GcyYBEKwyBMM?=
 =?us-ascii?Q?+bk976UdBm0XQkmDfTTP2U+mL1FNw66G7FCqxT3rKxTy+ulamJPXnVM00jbd?=
 =?us-ascii?Q?033BJbCqXjkQu1xRYPI5Ak9GHDhyJa0aAPHPfpsQyOnqPIZx/sAAf0IFOOTP?=
 =?us-ascii?Q?Qo72vRApthc6hPS42u32l7VXwteymeef3nUDaXFOU8FTNbGRB20xfUPtM2u2?=
 =?us-ascii?Q?9j0NDNw/uxIaNPHQl55zO6CkX8rblo6wmLO71MEGVgJaE07pQeIBuo/3bBEG?=
 =?us-ascii?Q?e4/hwNe7wIQCgvbEta7iKcS+OPbRBNWRdTX7dCIMKiaPTYpuaDUUqyVKx1Tj?=
 =?us-ascii?Q?rym0k/6I5G7AZ2AX/aOl5K9O1lk8128gcgJOmXeoKZc8uaOmJNgSB92oohIc?=
 =?us-ascii?Q?YDpasV470nPSzMW5X1pANQb7Uey8Ep/hU9GXKjlY8FoRuThla/u2RbtOxE5S?=
 =?us-ascii?Q?hKJBAxczTsH7k4VelxoabDb3YFuEqgMWNfLdA+Feo3EPOvqueI45zURDbcti?=
 =?us-ascii?Q?va93tFlQEN8J/La20AMR3xZfzHXbbh7rza6cHOnmkwR52fspZ6fMzQKccgVe?=
 =?us-ascii?Q?N6667pToS0rguUjAofG/qem+zrFQuPjgPly/So6JQgH/H7e3K+d2iYrIY7J+?=
 =?us-ascii?Q?XeB8tbpgwcwVINKrbnrD26PgwBlcJv+CP6aSZdAdqSPswWqsbEjwEXB+IiEv?=
 =?us-ascii?Q?EIzralsIl5BweHsMbMyGl8u8nMoCejEzWP73cFdlb9osSxP4SgV3VWk1kFFC?=
 =?us-ascii?Q?xE4vARG26PYp1iX9OPcrGGWjEpxH9OebF12ByT6nhwyue6WTEGqKzgscWgN0?=
 =?us-ascii?Q?SzQ2CSCdBkxYQMa/wRdSQwOSLGjIl/5TuJ11/ePSl+KTipB/x7abRO/jCOFC?=
 =?us-ascii?Q?0tILradXfPbB/jGQiknbKwcVdrzcrvQjX2LUxRmEzkVVDHIJW73hX/UtsbYs?=
 =?us-ascii?Q?Sl3jLaC2B30biiz+1uminBECdaVF1svMdqIMIuO0v3OrZ12UER8qoMPkiHaW?=
 =?us-ascii?Q?uBqEuOKZbzApy3VUNLBLeLlkijiOZoGNw1WziMf17xkEOGJfc2v3pnKNJ8zp?=
 =?us-ascii?Q?N5mnZZjHEVPY8zjvppfQD5E8V6A88ld8wjMaUfhAHp/jh76R0cHY8cviKaqf?=
 =?us-ascii?Q?9+HkvJSWjXMgzt769x4bN5mc2uo5l0LcCKkRkhyIjWg9GUxir0aLZAL6h/qV?=
 =?us-ascii?Q?XrI4KsELbfeAMe/2XX0HqCMl3vJwntWKL1/AkPrZUZDC+Pz2HlsKhidC0oOM?=
 =?us-ascii?Q?DY1jUmdFBoyKLrfL8FiWUCnwYrW7F2pX6o8kH36Llwp7ZIQAacd2xkWqKG+J?=
 =?us-ascii?Q?QDQGL2UZvb2KLNYEk5Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 17:51:55.2646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f1e60e5-2c26-4a45-ee3e-08de1713d970
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358
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

SOC v1_0 supports a greater number of IP instances.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4771d6de9c0a2..af9c2b927a1ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -798,7 +798,7 @@ enum amd_hw_ip_block_type {
 	MAX_HWIP
 };
 
-#define HWIP_MAX_INSTANCE	44
+#define HWIP_MAX_INSTANCE	48
 
 #define HW_ID_MAX		300
 #define IP_VERSION_FULL(mj, mn, rv, var, srev) \
-- 
2.51.0

