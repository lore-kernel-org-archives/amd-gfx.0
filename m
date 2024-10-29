Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F91ED3A67A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD0910E39A;
	Tue, 29 Oct 2024 17:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tba89lOr";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2229110E39B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJjqNCXKBD0nr33yCbQZfTA22H1mdrFlQQtdKlD75uUxwILXvsCVgVxFFNLxBNG42Ut/hZXgYvwU4qR9eMCkqIHPzXngxLWpdAg9zA+I1wMO20MoFzW233HG5jO895/vGF4n4iUv1AHjZObkTGp0iaRr+EUnQ5yxFtRlSKWUj4mJGBt9Zqmaa/356ZCCCwEh6Bq+9otSMe+PJZLw5OlXZc1CEOhEbf+b3REXjl1ivoR1DfTcQ/gG8B9yZhYxyMyxLmWpS9O8cIwD57CcwjQpAAC3njQXX4N4IjnQ21ICNaXyQBuH8Qw9gXGiAk0PNNCasIb4oPJ3uQ6SvcC0iBDpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYWDB3DOhbNWyeRRlRpdg+ZP8p9fb+BekQ9giAat900=;
 b=iYGyCK02LdkeNm7/gG44S51X/18JwWQ7TbDONTIoyztrmd77oDseiv+UwR3Wn1L/o0VBjRTxZyZkEKtMz72wmzMBU2kbWRJhZ0AJd436ABbzOjGvQUOt4zXLDyA5edlCp6M/EIAHXHJwyS5vNwNT3e7YOyK8jA++AlBpf5vhsM8UBxsjJL1hdj61aPGg6n8sg4qNPpXy1or93tvvOhWqw77AyS/hcGTufFli9hAPePPRZjLtx1Gc+xETpuHi9ILrQBrVeY/BNpT66wPMXN/mGgdHoSsUQE9FIvxIb9xonFgHURi+V31Rf3cBbVAhDpxu7nUafUHPgKw7vxrNe+zphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYWDB3DOhbNWyeRRlRpdg+ZP8p9fb+BekQ9giAat900=;
 b=tba89lOriFgm/mgvKnxyShr+Z4AXxoJ6pRbe0U9kKWdxiXtrQPPzWkM2bWx0YW49Aws5OP4jVqRSYTjj7PfqSQSt0qG6hDcxV1jxjCrRmzzS+z2XKVaiV4I1gYWsfriAZsO32Lq4GLNdYMJA5UZfIV3QPheYrbmYRIDx8Zj+JB0=
Received: from SA9PR13CA0146.namprd13.prod.outlook.com (2603:10b6:806:27::31)
 by SJ2PR12MB8651.namprd12.prod.outlook.com (2603:10b6:a03:541::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 17:42:53 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::82) by SA9PR13CA0146.outlook.office365.com
 (2603:10b6:806:27::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Tue, 29 Oct 2024 17:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:42:53 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:52 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 01/29] drm/amd/pm: add inst to dpm_set_vcn_enable
Date: Tue, 29 Oct 2024 13:42:12 -0400
Message-ID: <20241029174240.682928-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029174240.682928-1-boyuan.zhang@amd.com>
References: <20241029174240.682928-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|SJ2PR12MB8651:EE_
X-MS-Office365-Filtering-Correlation-Id: 0324ef5d-be3f-4769-fea5-08dcf8411dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzhKbXZLWmNFSXNaUXlXaGhsa0tyM2V3bnNrV1hsaVdOdVBIYTVORHdPdnZE?=
 =?utf-8?B?UnkvdjQ5WGRya2JTeHUvOWkxd1prWlM5aHlKd0dIYlpPUFlCckhycnlMNnVH?=
 =?utf-8?B?ZmN5L1RrYXBvdktwZy9xTWNIZXZQeklBMDByaTU4V2UycEVFUVlwdnIzK01D?=
 =?utf-8?B?RHlodEIycitISk1XbmlsMjRvMzBEcnM5Z0p4TVBvL1NON2Yyci8yNisyM1Rn?=
 =?utf-8?B?QzFxd2EwTFg4QU9FRCtzbGcxUmZOb2E5czJCblZEdExyc3RkejYyMWFQTlJ3?=
 =?utf-8?B?T2YyejRnWWV1NDNlT2RVUVJzajNNbityd3J0RDlyVGxwMlpSU1pocHZOMGNB?=
 =?utf-8?B?amQrNE12Z3pEWnR1b2VXWG9tK01kWVVKQWxmWFM4QjJQakIwd3FkMXJKWFZW?=
 =?utf-8?B?MWZ4QjcvQ0hVUDhKSnhZdCtSeGRtZk5ZNlJKOWRHV2x4UzZXU3RYYTJadjJh?=
 =?utf-8?B?R0lneTFSM1IyZ3Y4UE1kYzlScnVORmk4aVdUQmpzNUdKU0M2UTZMdmkwTjRB?=
 =?utf-8?B?V2ZxTXFpZFB1NTNwc012NzdIbDhoUWU5WXBQY1BqSGhpTjk4RjNGczBJd3NR?=
 =?utf-8?B?d3dzZGhYSkxYcmpiaXpOM1IvbE45K1FidVVkK2g0dEhya0o5ZjErVlhpM2lJ?=
 =?utf-8?B?N0RaL3BWMlNRVWsyYVR6N1BrY1MxRFBBbTcxZVhYL05LQ0t2ODlOeEdJVE5W?=
 =?utf-8?B?WE9TOXAyN3dnT1lMMGtWTS9HZGJwSVdBLy84MG5lOGpOQktVL2pBekVPUEd0?=
 =?utf-8?B?UGNlR1F1em9jdUZ1cm9hekZqZUFtK0ZPbDRteWxLV1MzOGQzcGhkNnZnRTE3?=
 =?utf-8?B?ZndVeC9wNzBtZnFJdTZEdHJUa051Vi9SZkdrWUVUZG0xTVZZaGNiQjF6ejlx?=
 =?utf-8?B?NEpNejM0aHh0azFJS2UwelNQelF4QWFGZEdOQ2RmZ1FzZ2ZyZVRVZEZXT2Rv?=
 =?utf-8?B?Q2NPU3UzLzg1WUNmemVma3lOdklnaFRKUkxIdVhjbk1FbjhxWmh2bUxwODBL?=
 =?utf-8?B?WG9oYzNHaVRDb1U1dk5xbTVtcVFJaG5hVFBqcVpodEk1NnNjRGNkQXB4M2Ju?=
 =?utf-8?B?a1p0Mkx4VlFyaVpLckw0b0MrZFBoY0pMZkxYTVBNSFNBR3E1cXV2dEdISndx?=
 =?utf-8?B?WlE3ckJRM1VHWjUxc1BucnNlT3NRUWFaeStkaytnNU5aNW0wWTlveDJxY3Ju?=
 =?utf-8?B?R1V0MFNvcEp3UzVEYXVnZ0E0NVExak1UZVp3dDk1Q05kWS9rYy92MDFNbEdP?=
 =?utf-8?B?akhkbVZad0RlLzNIcld5SGZaR3VYT1FwOE5QZU9KcGRndHlLYjFQTjJCWlN4?=
 =?utf-8?B?aWNrRXJvYmFENVRHSGoxM1lHK1FxUHRjb05qd1JxendObTk0S0RxM3gwZmpX?=
 =?utf-8?B?MTFzeEZtR0oxVjJEQlE2bzJWQ21CWTNPbXZuSDVEcGpXRzQ1R1lmdmFKLzdU?=
 =?utf-8?B?TS9RRmdTK2E5em42c2dPNi9GenR5RUdGbmtGOUNaUWNMZW5qY2RpNGRxMG5j?=
 =?utf-8?B?dWUxQ1JFakN0NTFPWWdzNHV5WWFiOHBnempXOEkwY1E2MEJLVFlxcG03Tldq?=
 =?utf-8?B?MzdCVmNjYldmWS91MnNkVlNiZy91NTY2K2xzckt1ZUd2QjY5eStLR2ZTUE05?=
 =?utf-8?B?dnZUL0pXaUx3SFViaU5yNFk3U2U2RkkzRXZEb1JlS0RYOUJaNmVnaWtqaktB?=
 =?utf-8?B?bDNQWHJZS1BzTkJRa2hkeTNKWlJhOURjSFdBWDNabmIrUzV6eWJQblJZTjQ1?=
 =?utf-8?B?RFZJb0pmYlk0Ry8wZkkzQ0lCRDh1em81QlBLTDh3eWFhditmUDRtcXFGV2ll?=
 =?utf-8?B?YWdrTmFjQzdVeW1EYlFiKzU1Z1lhR0I2OEl3VmNSQ0ZpejFJWkpGMmIwZHpx?=
 =?utf-8?B?OTF4OVg3bWkycWdsc3QrVXkrTStwckcveUN0OUZpclc1dnc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:53.6309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0324ef5d-be3f-4769-fea5-08dcf8411dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8651
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Add an instance parameter to the existing function dpm_set_vcn_enable()
for future implementation. Re-write all pptable functions accordingly.

v2: Remove duplicated dpm_set_vcn_enable() functions in v1. Instead,
adding instance parameter to existing functions.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h            | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c         | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c    | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c          | 3 ++-
 13 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8d4aee4e2287..fe2a740766a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -252,7 +252,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
 	if (!ret)
 		atomic_set(&power_gate->vcn_gated, !enable);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8bb32b3f0d9c..4ebcc1e53ea2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -739,7 +739,7 @@ struct pptable_funcs {
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
 	 *                      management.
 	 */
-	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
+	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable, int inst);
 
 	/**
 	 * @dpm_set_jpeg_enable: Enable/disable JPEG engine dynamic power
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 044d6893b43e..ae3563d71fa0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -255,7 +255,8 @@ int smu_v13_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 			     uint64_t event_arg);
 
 int smu_v13_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable);
+			      bool enable,
+			      int inst);
 
 int smu_v13_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 07c220102c1d..0546b02e198d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -210,7 +210,8 @@ int smu_v14_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 			     uint64_t event_arg);
 
 int smu_v14_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable);
+			      bool enable,
+			      int inst);
 
 int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5ad09323a29d..6c8e80f6b592 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1571,7 +1571,9 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int arcturus_dpm_set_vcn_enable(struct smu_context *smu,
+					bool enable,
+					int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9fa305ba6422..faa8e7d9c3c6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1135,7 +1135,9 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 	return 0;
 }
 
-static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int navi10_dpm_set_vcn_enable(struct smu_context *smu,
+				      bool enable,
+				      int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 77e58eb46328..a9cb28ce2133 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1152,7 +1152,9 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	return 0;
 }
 
-static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
+					      bool enable,
+					      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 6c43724c01dd..cd3e9ba3eff4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -461,7 +461,9 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
 	return smu_v11_0_init_smc_tables(smu);
 }
 
-static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int vangogh_dpm_set_vcn_enable(struct smu_context *smu,
+				       bool enable,
+				       int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 0b210b1f2628..a34797f3576b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -645,7 +645,9 @@ static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context
 	return pm_type;
 }
 
-static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int renoir_dpm_set_vcn_enable(struct smu_context *smu,
+				      bool enable,
+				      int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 6cfd66363915..2bfea740dace 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2104,7 +2104,8 @@ int smu_v13_0_get_current_pcie_link_speed(struct smu_context *smu)
 }
 
 int smu_v13_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
+			      bool enable,
+			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index a71b7c0803f1..f5db181ef489 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -193,7 +193,9 @@ static int smu_v13_0_5_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
-static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu,
+					   bool enable,
+					   int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 71d58c8c8cc0..73b4506ef5a8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -220,7 +220,9 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
-static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu,
+					   bool enable,
+					   int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index f7745eaf118e..ecb0164d533e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1507,7 +1507,8 @@ int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 }
 
 int smu_v14_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
+			      bool enable,
+			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
-- 
2.34.1

