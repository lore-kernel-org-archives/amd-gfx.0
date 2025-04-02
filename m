Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A455AC36018
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 22:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 290A010E8DF;
	Wed,  2 Apr 2025 22:16:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xq9FnBAr";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8D110E8DF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 22:16:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H37PUG2nRqQZb33N26O/s966C6KLEJy0HUyEw1mZQDSrEDokYRNK9syFATS89jxHqN9Kfr0hIpn1fzEDHYhR+pa0IWzivktZMBLgTvi+v4DSDII7Im7EYzt1mS4NqwnEmV/680JCKTZJ2xyygcKxjkse22el6sjJ5J/twS+JxhWqIeTuJVwfX9XCX92pQWBh5K0G9eedbgR9ZkJqwNnd3OtcBMhhOonWw1CsBTH1+cRjoFmKO7wtpFRiDMbN9wR+q6wCmGvyQVkQ7BgA5WKKyLD0OHXRrhaF2oqIGPpEVa7Sb2TZhp6eR1k0c8Ws/8o+zD0W+dPWZ/b03/k1CrcTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zUO4I9EwBcGQX68HNaWhEvwbnPSWo7q5cTT3XejKPQ=;
 b=YpKUfQNEY1dJxKur45WmZaz7STH2M3GOScXWbO7FIRZPC4JBJS3L/3yy4AwAGCRtrRtSzfYTJllcS1tv25cSxEgyKZQl1Jcsw/0VBOMaDMdIMOhoh+BDVXhJFuqd1bpgm5Cmy27fiPLnEi8EqPgAClfW8Hkjrx87VnE7tdAN7buc6mRom2NrxIq+qQ4XkkiRBQe8gI5xNKhr2L4Z83KlkRZDAAIdUAODS52U+JSWuDZmpCQftXVgGv8PM+7cifBKlnESr1VXRIniSUkiijt2QrM7XapCjau9uFcztwBw5BPaPT8EnCaz7H726FILmK9nGOpFbu2G9ykwWz3baZS7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zUO4I9EwBcGQX68HNaWhEvwbnPSWo7q5cTT3XejKPQ=;
 b=Xq9FnBAre4PNt2uAuxWo5hqfDW281NtR6BmPE2PnmAWJYJZzfPmwrPge8EgOhwA3HL+c9I9zTfcZAdPHfbq4Roa39ErMxhYTVDoMGPdgQx+oXx2G0ZceQH8bUAGVtTFaLsd1tnuE0crlnP4U0C/aMbKpVOjhBAbiUNn8RrS5v6U=
Received: from BN9PR03CA0917.namprd03.prod.outlook.com (2603:10b6:408:107::22)
 by DS0PR12MB9398.namprd12.prod.outlook.com (2603:10b6:8:1b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 2 Apr
 2025 22:16:13 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:107:cafe::3) by BN9PR03CA0917.outlook.office365.com
 (2603:10b6:408:107::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 22:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.2 via Frontend Transport; Wed, 2 Apr 2025 22:16:12 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 17:16:11 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Victor.Zhao@amd.com>, <Tao.Zhou1@amd.com>,
 Victor Skvortsov <victor.skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Disable ACA on VFs
Date: Wed, 2 Apr 2025 18:15:44 -0400
Message-ID: <20250402221544.110496-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS0PR12MB9398:EE_
X-MS-Office365-Filtering-Correlation-Id: ceef5340-3fd8-4c86-a41d-08dd7233fa7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HN7Mw9pFhlflzJWPVPxXpJ9vSdyuoOIu9TvSvkvDPOQMJF9EXtfaFrZ0Ubet?=
 =?us-ascii?Q?NfE3gjre4jH30uYNcCZOFdJu8ZrJnbJUKxMs1ZveF6G4Lecbq2YLLo+tIOZT?=
 =?us-ascii?Q?CCoNm7E447qPCVAtge3FfpCtAg1zxzeTMGcLN/47LvPNpNh4fCZMaDkMnTUN?=
 =?us-ascii?Q?gawsFnLvmJOIdb3se3eoU+x/I4IaKKVcqQrymioafa51zA34xQknFEO3iaSc?=
 =?us-ascii?Q?gLBAsOvGpQjFWjdFpLTrAfWgkffmIPfLmKSoHiiKk3JX2oLBBzrkIzyM4gQI?=
 =?us-ascii?Q?vwPQbtJj1TUPlN2DSvL0RlPVxqdBDr2gfo+w3K7oZAD9f8yvZ2VMmVdQ8Cvm?=
 =?us-ascii?Q?5pLrB+UstyIr7RFqbwrUhRzssA5fR8xt56IjTPa3Xu6WvykgqvwcSJdabrI0?=
 =?us-ascii?Q?xqUPc8SRmDKtnDyzCNbMO11UuFCr1VsdEs5Vy+Y0AnJWkWt56VUq+nFRlr9J?=
 =?us-ascii?Q?NvWjVse2cxwLNTO+RPtBpEDMjDC1Dc2qnXaaTPRx4/Aj5jLZH4abpnAtROKD?=
 =?us-ascii?Q?u6+4AXK3Ehorq1Lqddc1L6fUyTLasWf7ktsLjRKr6ijOMhjrYkpnIudjfFNZ?=
 =?us-ascii?Q?6aJZyRT+FhV6hKTbTAW4KWgkIWGPOu3DUgFisXP9Szt9Zil1clghBjLHAdBG?=
 =?us-ascii?Q?wnUu7RZblZkW+oRE/T/HypN5rxCnsxeyh5vdxSou2sd7ocMydpId8d0qWVRJ?=
 =?us-ascii?Q?lEMzi9bpinx7LK67LUMeev3ysVrS3lWe4sZPWsyylXEr+hR0jS6gLle8k0To?=
 =?us-ascii?Q?fQGpshxZtTTGiNIh2e0jVdNayMS2zVztLp1aETlPlE2oc8FKVGxNdeGTA+5n?=
 =?us-ascii?Q?BVM79zAG9YnNz+rHS4fPFPc3KVQRTZ4U9pj2c+D9jS6fy7iRB07NM90DIYhv?=
 =?us-ascii?Q?K24xwF6FM7wrP25otV1exgXKXNzlNdg8HWqUIR7tAuU8/PJPTsq2HmZ/rxJp?=
 =?us-ascii?Q?Nf0PRIL+1smqOGCUW3w8SqB/jDvcimI9zePkliqo4z7pBHJqglsjur5uPNoJ?=
 =?us-ascii?Q?dlMGYQIrdU/zUnKmMOwV6AIgJGbtKdOVOBgj+D87dFy33ZlIu6xdAtHNBOq8?=
 =?us-ascii?Q?jlkYEyI5/goP2pcWy6sn8mPpeVmAOJPnV0m2zxUJX+0yTqDlD/mnp1ABgeCa?=
 =?us-ascii?Q?/X9NrIjYcRWnaqz/rVya1SoNEFaSvg2QQ09OGTcUErzgkpej9FwdjV9q/MeN?=
 =?us-ascii?Q?W5GyJ7UQgox1hG2CW+4z2QMKd4c8pyQzDB2vGMMqHNoy/IEgC+r5VzddhXms?=
 =?us-ascii?Q?n5VY4O+vW5bx6LdVvYaULDWxWReKaYYIyJgKNfxnlHVQpXQdrD1ttnPFuJ55?=
 =?us-ascii?Q?pBua41LxoCeSGMeyyaXDwxUu50h0M0EmhvhZFKR8C12vBFwSB3Qtes1tY0/G?=
 =?us-ascii?Q?wc1SD+mth6hBgOUswWN01PBC5eOEMuwMqb7wOS79d1xIRpVsp46+eoSvfGC9?=
 =?us-ascii?Q?C+B73re0+UXWvZ82GwEQQ1+PS53s35D1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 22:16:12.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ceef5340-3fd8-4c86-a41d-08dd7233fa7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9398
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

VFs query RAS error counts directly from host with
AMDGPU_RAS_VIRT_ERROR_COUNT_QUERY. When ACA is enabled,
an unusable aca_sysfs is created rather than amdgpu_ras_sysfs_create()

Likewise, VFs depend on host support to query CPERs, rather than ACA component.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 10 ++++++----
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 360e07a5c7c1..5a234eadae8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -549,7 +549,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	if (!amdgpu_aca_is_enabled(adev))
+	if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev))
 		return 0;
 
 	r = amdgpu_cper_ring_init(adev);
@@ -568,7 +568,7 @@ int amdgpu_cper_init(struct amdgpu_device *adev)
 
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
-	if (!amdgpu_aca_is_enabled(adev))
+	if (!amdgpu_aca_is_enabled(adev) && !amdgpu_sriov_ras_cper_en(adev))
 		return 0;
 
 	adev->cper.enabled = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ebf1f63d0442..5bb7673fd28e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -3794,10 +3794,12 @@ static void amdgpu_ras_check_supported(struct amdgpu_device *adev)
 		adev->ras_hw_enabled & amdgpu_ras_mask;
 
 	/* aca is disabled by default except for psp v13_0_6/v13_0_12/v13_0_14 */
-	adev->aca.is_enabled =
-		(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
-		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
-		 amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14));
+	if (!amdgpu_sriov_vf(adev)) {
+		adev->aca.is_enabled =
+			(amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6) ||
+			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 12) ||
+			amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 14));
+	}
 
 	/* bad page feature is not applicable to specific app platform */
 	if (adev->gmc.is_app_apu &&
-- 
2.34.1

