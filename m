Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A68CA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 05:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240C010E1BA;
	Wed, 13 Aug 2025 05:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nAiJpEeF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AE4B10E1BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 05:21:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPEFdcp07673NcS2Vg8tvmszihbcXjmsWzz9zETF45TNy4mkw0O0e2K9EZpYHL1NV3fqo+ANru20AKzL6X8akFJAhHoOGiPo69PJf0FArGMbg2t0FsiHl5GUtqLxc3+yEzQfmTOShqFXdQSg7V0SmjbRjCkZtQSVi6b9yPa7J9CA8uwozCvYpSLlU9EopWGkopFj7PFejemZDjCUxq9EpSajVJLr2yVPjgR6MSP4AIpRq/lZSKXSWKUl1geRgKDRzQM10ARtY0zx/5VBnGmjrNkdGj6WjwH1RAmVlI14Wz5JCuNBtoY3rD49392aZuyCmnGcXLjE5LSopoeLHqsK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q1FFbEGoW6n1wUyNtQiVZKSTGVMJpdZSTrnssGSNsw=;
 b=cBTm/prfTro0gDvGrUfPoV3j1v70GbPLBLL769uhW7vCMWliKBsUn2Th2QX5NXSTy7d0KHpY8Oy1ZOCwv+kSgMdWfg7Ydg3n/jAsTRB59JyJBl9DFP9eFBo4Y/y07l+hth2chtJ0v/9jzneDgcQB5IQ+a0yRWXaAPHp4wa5VQ5u0PljDAHvrGRvH9eexw+KplEHAARTmnOAcJ6El/7572MsE+VL3qrPY5OzS6n3++0aIruiZDZwn7W2ZEiqJr56+YmIToAeszlb6IqmzavF6IB3uJbdKZB/C00G6PaDwetCSQOXFbhSeEOq4P54O9eSNxGA7KYUF1h1FtAMRnNvP/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q1FFbEGoW6n1wUyNtQiVZKSTGVMJpdZSTrnssGSNsw=;
 b=nAiJpEeFDrNmqq8RdbtK67L7l3bd0K0/1RYzXt5pVt0EkwElk+tfe1Q3/5Ssawp4RufKA39hmqp7axV6xDrJdHdPGFkY+rgkRyo5Wibqq0rg98a3N5YdojeT1/iJyUVxLcUFgdRUhc81Ral5l3nZYaTORL6AfsMk7052+d7p8RY=
Received: from CH2PR02CA0001.namprd02.prod.outlook.com (2603:10b6:610:4e::11)
 by CYXPR12MB9317.namprd12.prod.outlook.com (2603:10b6:930:e2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 05:21:25 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::58) by CH2PR02CA0001.outlook.office365.com
 (2603:10b6:610:4e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Wed,
 13 Aug 2025 05:21:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 05:21:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 00:21:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Tue, 12 Aug
 2025 22:21:23 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 13 Aug 2025 00:21:17 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Ruili Ji <ruiliji2@amd.com>
Subject: [v5 3/3] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
Date: Wed, 13 Aug 2025 13:20:01 +0800
Message-ID: <20250813052102.3438895-3-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250813052102.3438895-1-Jesse.Zhang@amd.com>
References: <20250813052102.3438895-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|CYXPR12MB9317:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec2786a-596f-45c7-eeda-08ddda293f63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sbTQWy6f63xV5eOKw4hGkuQGkTiuXLYYoUuwE9b4VUwOe0igEvd4hGWFHUHX?=
 =?us-ascii?Q?egItc/oQKnY3jMNB0t2j+rZpGZJTL+POfgKLV77VgsTfjHbgKQ4NK35PdEzs?=
 =?us-ascii?Q?XbKcZffHQl0tjP0+g9xTJFanDYKn86SL42U9QKpHRVV7az+1SKoBEJFmwMna?=
 =?us-ascii?Q?ydXoywiPtRePhjeB+uFHLKe3WK0RG855rtBRj36hlQ4S54L5+GcppRY8Q1ER?=
 =?us-ascii?Q?bTt+c/h5dI9HmOKlfEnr5G2v1Ib9NYG8TlbAVR0MdvIXVAr3jsTqv9nm22k0?=
 =?us-ascii?Q?l7AM37W8ZAGx09mm7bMOxpddiTFH/S+9QGdnKX/urk9sDcS795m1hzbo62ZZ?=
 =?us-ascii?Q?pBj/2qg2I7P2ySXY1/4OKHMP3dhN2F0+l/rsDpjUaN6rBESvo/RYoBctdmFI?=
 =?us-ascii?Q?8+y9qMer0kEjUt4T7zBir/fxoRbbMpzWHgYiSf+hl71U6c9KHiuHJE3xpDIP?=
 =?us-ascii?Q?watsGohwJRmPHlvPHqiAiWgRR9EjRoL3l7tEHIKLlHZ9GHaMmjUK5FAki+Vp?=
 =?us-ascii?Q?3m5Ojw0osi2hP5EZsqBWMP5jBsJwQCDwidaOdCeNBk56IK6nldBtMbCbBn8M?=
 =?us-ascii?Q?8/n0CIi3GI54ynDVP0fsReLczkWj8sAQ7gC7WSLCnN7dLlalpmqIiYnVrLLs?=
 =?us-ascii?Q?8Ou0P5eQb+r1plx082fVdxOJrW6gBBwe4jTyiURnfaz22ZXtfekn5kvVBaLD?=
 =?us-ascii?Q?Lt8W19bQDFt0ei5fiNpEO5E/uXBBALgv6Tcz5PPL3n1qMz9pcpIYpiZ38lFE?=
 =?us-ascii?Q?eBQ8DV9rGKuZ13wBAhGoxIxc0ehmuX3Vdlgarj5M8ZJhBN4oTm4o6f1Hb8qV?=
 =?us-ascii?Q?Ua8Rv4mtDB4VZWCGtGaeFSNvZeU8zVbYfdRHdXDdwIv9n9uO/duGYP85rLPd?=
 =?us-ascii?Q?b3ygiXCIL8ewAyTSK1hRl5esbLWIVurz59e2GinpviuPWy2dMB9IMM8oWVmT?=
 =?us-ascii?Q?dbOSZrE7xBv+HPaqdkRHMGmm+nT/2f2NAV288MiHQhHbjT83iuDKemStkHvk?=
 =?us-ascii?Q?zEIB5VZ8WUBerpFZF5bV3P37hy6XJhVIfVKEnqAyFKTfS8TwYxPvFQ5hERaQ?=
 =?us-ascii?Q?slRImqhX1nCe2Hgy9GG1KjZ+e5UXFMJhX6rDsyazl4VUZgzgxneiO9gC5yBy?=
 =?us-ascii?Q?7K0eH5VOcqpQz9Bza92Z38oqYKFPtyEJnmaDSRy1OYRqg1zBqf8EcbJ8azE/?=
 =?us-ascii?Q?ZCwWeBsEJyxV57/6Fh+7gctosCdngdV8S+pYMMfxe1UKlQRnWWPw8fX25fLh?=
 =?us-ascii?Q?ceSuKYLLdDCcN58voFb+qnqpGLcrl+aCv3Q/18FjB0W6M70gzxXBBgTTrWif?=
 =?us-ascii?Q?ebuONj04xBqdmNJNDQgLmGJLtz+keF6jgodrTaDTvWAF3wDZDh3BGFO5EyK6?=
 =?us-ascii?Q?DFN3KBlQK6pHFeV6p7vHwnxn0PIlcijwudBdr871yjfZEmsArpT/W2k1YSRF?=
 =?us-ascii?Q?iT2m/SmZBnKDSmcKer+HrJ2ck6aOYbI4EVm1xotPAWtEdw3wWdkQ7CPmXahy?=
 =?us-ascii?Q?ZcbvKeQ3yf5Rs9fQ0oqzsvPtTgEhzssLc+JL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 05:21:24.7770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec2786a-596f-45c7-eeda-08ddda293f63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9317
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

This change reorganizes VCN reset capability detection by:

1. Moving reset mask configuration from sw_init to new late_init phase
2. Adding vcn_v4_0_3_late_init() to properly check for per-queue reset support
3. Only setting soft full reset mask as fallback when per-queue reset isn't supported
4. Removing TODO comment now that queue reset support is implemented

V2: Removed unrelated changes. Keep amdgpu_get_soft_full_reset_mask in place
    and remove TODO comment. (Alex)
v3: set the flags at one place (all in late_init (Lijo)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 019bd362edb2..a63a1e3435ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -134,6 +134,19 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->vcn.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
+
+	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	return 0;
+}
+
 static int vcn_v4_0_3_fw_shared_init(struct amdgpu_device *adev, int inst_idx)
 {
 	struct amdgpu_vcn4_fw_shared *fw_shared;
@@ -211,10 +224,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->vcn.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
-
 	if (amdgpu_sriov_vf(adev)) {
 		r = amdgpu_virt_alloc_mm_table(adev);
 		if (r)
@@ -1871,6 +1880,7 @@ static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev)
 static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.name = "vcn_v4_0_3",
 	.early_init = vcn_v4_0_3_early_init,
+	.late_init = vcn_v4_0_3_late_init,
 	.sw_init = vcn_v4_0_3_sw_init,
 	.sw_fini = vcn_v4_0_3_sw_fini,
 	.hw_init = vcn_v4_0_3_hw_init,
-- 
2.49.0

