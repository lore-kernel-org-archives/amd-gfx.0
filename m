Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4814ECA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 01:04:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2F9E10E31F;
	Tue, 12 Aug 2025 01:04:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GMNRKCDL";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A20C210E31F
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 01:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yp7XblmebCVj5+jdrFB7yOUsJv/nv/rsJkbLbpLL3sLjbGb7jKwyEtBItJrMsYJbcQSh/kWMAH066mTFP8iyZ+MAzQSQ0omApTCU1akC/P7kPlUpvdjRWw32dMhxFKIMSqc7xxCV5mbiUJOzvZMEhqc2wuBZGhm9xFCbi0yF5OB7WjeDGsZ8B2dJ90wYTjRyQQCaUGLb4bRPJY/1IbsDt1VM5pLZtdUgrVVqw/Rngg9+FQ06IQviFCFb0PdzxBS6glOCt+Ym2wHOggHrVFGXelSWE8zKEdOeD+ZQ+FXDgJHrXnKK0dbXW1t44aoGKrFu6mSdE9f+q1NX20gq/xlU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bk7kkDA91xTpVozTiIlbuGctQVky4cdwJGPn4EkoR4E=;
 b=w3GKNZaZ1XN1PMU6ug85nM1PwMIrEUulK2hdE/0kfp4BD6zSct+ArBINNozHQyNod5G/HQTVNNeF2gn7jtEHtLzZ3M4Ox2Xb7cyjdmi0m+ATS/5Ddv5y7i0n4GC5qYl49JMy+wS/nDzTgjC9uXMdfUWANckJTTkEUJMvA/Uo6uepTyKxS0bBnCcG5fOfTUwD5lcjJmz0VnWALBHjlEPsa7y1Te1c+qROtx5S30X+kDiqV2R7Up53PYflh0nkMjGKoDHp64jCsln8Jv5XgELURtIzaYnTa/8YuBEd2jpgPR272ICIxH63K59ffIO8950vKslefq53e/anlfJECOosBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk7kkDA91xTpVozTiIlbuGctQVky4cdwJGPn4EkoR4E=;
 b=GMNRKCDLG6bqK2HQwy+bn670Qm2WjjBpQ1XIRizDRYLbKwA7FIlKSYHWnQJumt0MHPLSlsyM3JewgGo/YqEJcUymJUVOWpAveDEmzba0QsOyGtKAT2jB0lDuMvp12NKlr+AnxPFoK/AEROXwXS2BhRLJ5mq5ns2YEjYFfMwlHv8=
Received: from SJ0PR13CA0217.namprd13.prod.outlook.com (2603:10b6:a03:2c1::12)
 by PH7PR12MB5880.namprd12.prod.outlook.com (2603:10b6:510:1d8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 12 Aug
 2025 01:04:00 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::e1) by SJ0PR13CA0217.outlook.office365.com
 (2603:10b6:a03:2c1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.13 via Frontend Transport; Tue,
 12 Aug 2025 01:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Tue, 12 Aug 2025 01:04:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 20:04:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 20:03:59 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 11 Aug 2025 20:03:53 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Ruili Ji <ruiliji2@amd.com>
Subject: [v3 2/2] drm/amd/vcn: Add late_init callback for VCN v4.0.3 reset
 handling
Date: Tue, 12 Aug 2025 09:03:14 +0800
Message-ID: <20250812010345.2261810-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812010345.2261810-1-Jesse.Zhang@amd.com>
References: <20250812010345.2261810-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|PH7PR12MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de030d2-663e-472e-6982-08ddd93c1f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H8uV8Rcj38/bmru3W7vwbMeE8KChS1D0QAm1KPlLAOWzyMkw+6YZYGkts3l3?=
 =?us-ascii?Q?YMbXhszw6hICjFLM45zoez5Dte+tTIuwwR05psxNT4yQtMOnt1JY6BMjYXWj?=
 =?us-ascii?Q?cjIy0ybO5uoXoCsCkYAvk3KDkKv5mzYx3YuEGUG2iudsGhOgjaVmR8oVmO9h?=
 =?us-ascii?Q?EAP+J1STCYnVfNqNwLSo2F4yhUdjb10cdSBpFsrt/7lx0uYrgPH3L4Y0RTdF?=
 =?us-ascii?Q?+3ZAksHvEANFrwJsZwuMA9tBS91k0K0vHDqcKEkT1Fw7vw7mDxpfk+EP9ym9?=
 =?us-ascii?Q?SbyYlbEg9rFOUloPWHbIyfG0skP4319Xqbq23Uq7yzj49X3Tn7LDaoisUS/v?=
 =?us-ascii?Q?RFhvAMDGr8pzLBVXJgE7YEFceLR65tx2ZA8piRbsb/g2eAn1Wty06AO68Ka/?=
 =?us-ascii?Q?CMV8wvYVoPEU58sECY+3rWu2ll2ZL9SXHv7Oc4bXWtj7KWuDF9dFC7ck9mvS?=
 =?us-ascii?Q?b/uP39IaByVpmnp8CM4pJ3rQiTQCCacVxBbIy70OSiuF0NS/M4r3qNe5wWae?=
 =?us-ascii?Q?KEwUBnmy3hamBlAVDlFta+gR4UqGjFSOmCmD6F+fnbvwg1WxEdf6tdxuPKIz?=
 =?us-ascii?Q?+UORpBmCkTtbYMX57NOOvsIpmtu3c51KyPFQDB1FAfUV3b+EXn4D078ix8Xh?=
 =?us-ascii?Q?+gMh56ae3rUjIPsx5tdeD6IiW8dQ7YAEjoQII6uWqCXc16ayfZAhGwbblmfn?=
 =?us-ascii?Q?5gHbIiVklb3+67eCW0Cd83N0GwHaMstokqVbSwnDtbCgMxzNigDEhNfsVOoZ?=
 =?us-ascii?Q?1wXkwWDPLDv3yiTTUQWW+3Nyw9JyT80tHLvxMdqm2gvsFqei+E+z/DHoBwck?=
 =?us-ascii?Q?7W/R93Y9fCGe//tD85MyW09JHDyshIshkJyk3qEpa46AXFq/N8APLC1kIphs?=
 =?us-ascii?Q?gt7I9/89bak3rPhQ9QyVojWgMxG577GATa4QrH+G5XBA3BMl4K3RHpEoc9KV?=
 =?us-ascii?Q?eIwNCKPUHwoAJs/S9NnamRyVwoW8rTDQvhXzdvSFU5/ThmYFjLigQ0fYnPqG?=
 =?us-ascii?Q?0V5eAopaKYUegTKH4/P9S5Ncstu3WUWbIPuzDpL7VNZP2SonQtm9YKm3ZrV6?=
 =?us-ascii?Q?0PkR4W92g6qWHDb8ECCjczfhdPsoBDjvXI2opeBwaD6em7blPxkUCCP15yrR?=
 =?us-ascii?Q?wIY4L4J1Ckq9OX3MWpRK/f0zGGuSvI69MNstfxK3mrqcLkXF50rkDnU9LRRR?=
 =?us-ascii?Q?PIVZrMUmxjlClFdk8WUvhUlaIitVH135yOKLxvBgdn87T8kmQ2WjkmreT5PI?=
 =?us-ascii?Q?5cnDrHhO2DqVbnqkfBlTI8hb5uB6gItFIybBrWbgZF82bKcvM1RBU+Q7rhpx?=
 =?us-ascii?Q?O9quNkCD8jvW7VUNSBOAWhWGtCYnqurO895uE60fMgRPHBDN9xzNSg7IEA6k?=
 =?us-ascii?Q?fFiij3BZlC8lhBOCMdWMVQtlfq/nXGKcC0AyZ2hHpZVfc5V9N5KK5tmrj4VM?=
 =?us-ascii?Q?m7JA8DgZ2uraQZlL8CLrEj37Wt8zIztyXDrwRWDFi5ZdMY3H+JCsPbpWzJWv?=
 =?us-ascii?Q?o278aiZTlYHT3UlELBsdRfqLbnBY38rem1Be?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 01:04:00.4319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de030d2-663e-472e-6982-08ddd93c1f77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5880
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

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Ruili Ji <ruiliji2@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 019bd362edb2..03fcd6833c26 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -134,6 +134,16 @@ static int vcn_v4_0_3_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
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
@@ -211,7 +221,6 @@ static int vcn_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
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

