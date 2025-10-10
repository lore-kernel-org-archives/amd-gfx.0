Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F5FCCA476
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 17:03:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B981C10EC5D;
	Fri, 10 Oct 2025 17:03:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fSt7uV8k";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012008.outbound.protection.outlook.com
 [40.107.200.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C43310EC5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 17:03:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcIpdTTi8h2T18C1/FN1z6tx1M+LvxGWbZBpNqQ3cIeJ2xMIaWSXBP3R438E8dlC9tvSQJVxfrZVJ5obrRwWGFN79tTE7NpZDm5tkqWeljof42/LNzxGEHYvIybZF9G4ZqnYRfRZsnQ6QlLKg2xirrtVSc8rcan1alRINN6+QAjx42yQeeq4cpwOuQrQf46O+GpfudV7G7FrX1H6iVx5ImU/fR3yrOcI2XjUy8b6xxfF0iI2T/PHnv+RbAliLLeVKAijcp4qNTCmFNPZfcppFfHNvL0ofzdWzBFQbjKky53cbxs3Uptfd1JGbhJB39EAWpLljdgatP0TMLu0M+jHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7TGbH0LVi0ieOvjAR4NamCC3NPAi+1vxNKKz4EFfzJQ=;
 b=wilTfWgezjt5l5571EUFhyCEoKJGzARwarncOsBobivwATgDCVJ0FGFy3pE3xzJdy3YpSNuq5V9RM06zUL+ZKBOn2h8PFtgzZDZ3LL5dlsF2TopK3yodHW6Na8/E3CD7STYLtWu4/aBAkhvpy842OSyPjN6MZzq2PQRr1EUd9Y1vje7c3fZQU6ILkmDo4ox4t4DVKfo2OZfhCguYFxPiqHD/4j07F/U0qed/ScodiEkcra7m6Ags1aLfEySIM+8sv0Duv69lIdr+66620HQjpcqtx+89BBuTuhzTezULRLWYgQfx3WTdMiJnL9QWPfCyBE5FjCD8pwR0sBdxayYK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TGbH0LVi0ieOvjAR4NamCC3NPAi+1vxNKKz4EFfzJQ=;
 b=fSt7uV8kHLDLfGDD2Bsl/RTETmQldKhIuloIDG+vamHzslP8aZYl/cSvFQr2T35vrjqtS4tUdBf0XMrFSpOwJ5JhWgZplk8S9fg4o8UWrwmKBdS1UQl/14mEgmu4/XcrzogFNKUfk+OyzaXFfgPph5Nn8gJgiXfnB2iW4qPrIUU=
Received: from BY3PR05CA0030.namprd05.prod.outlook.com (2603:10b6:a03:254::35)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Fri, 10 Oct
 2025 17:03:19 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::72) by BY3PR05CA0030.outlook.office365.com
 (2603:10b6:a03:254::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Fri,
 10 Oct 2025 17:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 17:03:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 10 Oct
 2025 10:03:16 -0700
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Reserve discovery TMR only if needed
Date: Fri, 10 Oct 2025 22:29:56 +0530
Message-ID: <20251010170257.3516496-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251010170257.3516496-1-lijo.lazar@amd.com>
References: <20251010170257.3516496-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b87395-3672-4cc3-fe47-08de081ee937
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qwsxt22zEBT1Kcm1TLzgPvaIUeTaH0YroDyczguLkmBdGbx39vdDsfKmiSer?=
 =?us-ascii?Q?WDVJnwB89fLA57rq+ccTBhDzaqhK8WLuAmPTcg/pIUnrQLfLOBnsh464LIAm?=
 =?us-ascii?Q?QxR/H6fYQ6CLhrZEAfHxZvy4/o07htYD8vz7WpfmXq6YCd7DT0tAeteCzIwk?=
 =?us-ascii?Q?7/SdzfCfmNBED0lrUbQGM3zcwT173oP9qV3sTD7jLHk9JuMQx6V/BHSIo0J3?=
 =?us-ascii?Q?oNzDpqUfsH9vjPwdbySsktc0ZFYPZ9UzKA/YhdFxH8R598nFBmNPDevqbNCr?=
 =?us-ascii?Q?CeqTVboOwd8UvEWhlodSEnNInbHxcANR1NyUWG/0MHV7OrwULrMC1tB8lZnp?=
 =?us-ascii?Q?7C6rYvP0qJQPkqcQJXkaXiyHwM7oKroTydZ6GeOc8NqQCN6QlsEEPY/Wrj8K?=
 =?us-ascii?Q?q8B+aSslaoEZughkTwrujB+7kcaP9es7st9TrPMxTClb+fxRp8iHdvRzYyq6?=
 =?us-ascii?Q?LZkZmlNt0CygCTyvPzAn125VIGN0hziYPJVV5xNakPQj74hehPtD01QosFi9?=
 =?us-ascii?Q?0UWkusaxQArO7/tNzkN4ayCYEvyMQIjf1kB+xZEm+YrN2niCV63JfXx8quyH?=
 =?us-ascii?Q?iIl5r6zzIZJ1K3AQWxgzX2bHStS00dJFEdk6aeviP2rMzi8vBamaYsrCq/76?=
 =?us-ascii?Q?4H0VkEBs8VVvRknbHBnQtsWBPBfDPM1qMMdolah96WAhXUNlVZsOb8Zcep9u?=
 =?us-ascii?Q?fHh+qqgnNirIk1nkBhzkp6oHIMLuQA+YtWBvaex3qLIABWlAciBLvXCFOpzX?=
 =?us-ascii?Q?rwLd1Az1VO2oikJ1hIP4k66dUTjtq1/jMSM7+IHQRuQ9nPchH0s1dprRhmkE?=
 =?us-ascii?Q?erOqOEgEcgMgBuHP1d96q9lGgfdSfc4Bmu2j3wv3B2cVFVbK9NkdLQZWPoeq?=
 =?us-ascii?Q?aTA6zjIL9gdqKE2C6BuAsv/RyBlQzpjTETh0EpCADhdxResWDdqUGdwvcNVY?=
 =?us-ascii?Q?QjVw3mvc1kQGL20dNH7hgpp8pmlDWzguW8yWFF7729vesJqtVvIdC+tcQ/b/?=
 =?us-ascii?Q?ypR4idWearg7gsqyFyRbXTTH/ypKV8RUkV88HqaNJof3s80yFSBMiZ80yDTE?=
 =?us-ascii?Q?9mtVgc4QFGOYtFTk/9Z/Tl/3GncN/aPCmTZcsu2Qk+OONkzBendX2Iq6iJMw?=
 =?us-ascii?Q?KGu/cZ8NCMGhR3eXOAS3Po0xi5KjJDC4oSDAdjEwO6b7i1Bnhpn1eBRQw3oh?=
 =?us-ascii?Q?CUE7BZKhYVNEhFsPBMW7m2uIn5sn6G+CeOaYZPjV8GWniHWQ1/3PrRRP/Rm+?=
 =?us-ascii?Q?yGaUok+DmJL+ViFRmZdN1mgnkO7oCahJ+A4LODEAUQcVTW7pf6eDu/Qjgklx?=
 =?us-ascii?Q?bjej47DUP78HdWHM/naNtKaV02Km0e9efFIsqmLQfA2aLeVEUdskFjKnE7SZ?=
 =?us-ascii?Q?VF3T94QWfeyU2r2Rf3jQvIaEpyKH+0mAxpW1xt6xTZUneaZ+1UGjPBR9ePTb?=
 =?us-ascii?Q?oQr+dQAxwmA0X1nD7hRY3wzGTC7jUmy3HNFSbuktbXJH0PbHFq6LN+NjBO3t?=
 =?us-ascii?Q?vEkaGJ+804Q15aXFr/km8K0/hEcGb45WKsKeTLNGS3o2Qx1CeqiJNcEb8dhF?=
 =?us-ascii?Q?8uvbdVuSeoLVpPee+yo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 17:03:18.6644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b87395-3672-4cc3-fe47-08de081ee937
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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

For legacy SOCs, discovery binary is sideloaded. Instead of checking for
binary blob, use a flag to determine if discovery region needs to be
reserved.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 10 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 22 ++++++++-----------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 02b661232db8..478cbfcc5b5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -298,10 +298,15 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 	else
 		vram_size <<= 20;
 
+	/*
+	 * If in VRAM, discovery TMR is marked for reservation. If it is in system mem,
+	 * then it is not required to be reserved.
+	 */
 	if (sz_valid) {
 		uint64_t pos = vram_size - DISCOVERY_TMR_OFFSET;
 		amdgpu_device_vram_access(adev, pos, (uint32_t *)binary,
 					  adev->discovery.size, false);
+		adev->discovery.reserve_tmr = true;
 	} else {
 		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 	}
@@ -418,8 +423,11 @@ static int amdgpu_discovery_verify_npsinfo(struct amdgpu_device *adev,
 
 static const char *amdgpu_discovery_get_fw_name(struct amdgpu_device *adev)
 {
-	if (amdgpu_discovery == 2)
+	if (amdgpu_discovery == 2) {
+		/* Assume there is valid discovery TMR in VRAM even if binary is sideloaded */
+		adev->discovery.reserve_tmr = true;
 		return "amdgpu/ip_discovery.bin";
+	}
 
 	switch (adev->asic_type) {
 	case CHIP_VEGA10:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
index b1eec3af3c4a..4ce04486cc31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h
@@ -36,6 +36,7 @@ struct amdgpu_discovery_info {
 	struct ip_discovery_top *ip_top;
 	uint32_t size;
 	uint8_t *bin;
+	bool reserve_tmr;
 };
 
 void amdgpu_discovery_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5bf6bb3b2faa..d0a7379255e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1767,18 +1767,14 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ctx->init = PSP_MEM_TRAIN_RESERVE_SUCCESS;
 	}
 
-	if (!adev->gmc.is_app_apu) {
-		ret = amdgpu_bo_create_kernel_at(
-			adev, adev->gmc.real_vram_size - reserve_size,
-			reserve_size, &adev->mman.fw_reserved_memory, NULL);
-		if (ret) {
-			dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
-			amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory,
-					      NULL, NULL);
-			return ret;
-		}
-	} else {
-		DRM_DEBUG_DRIVER("backdoor fw loading path for PSP TMR, no reservation needed\n");
+	ret = amdgpu_bo_create_kernel_at(
+		adev, adev->gmc.real_vram_size - reserve_size, reserve_size,
+		&adev->mman.fw_reserved_memory, NULL);
+	if (ret) {
+		dev_err(adev->dev, "alloc tmr failed(%d)!\n", ret);
+		amdgpu_bo_free_kernel(&adev->mman.fw_reserved_memory, NULL,
+				      NULL);
+		return ret;
 	}
 
 	return 0;
@@ -1955,7 +1951,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * If IP discovery enabled, a block of memory should be
 	 * reserved for IP discovey.
 	 */
-	if (adev->discovery.bin) {
+	if (adev->discovery.reserve_tmr) {
 		r = amdgpu_ttm_reserve_tmr(adev);
 		if (r)
 			return r;
-- 
2.49.0

