Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2BFD3A67A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F17210E3A1;
	Tue, 29 Oct 2024 17:43:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ighLyT2t";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAED10E3A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVyo/RINaWnzGktr+XwbqvULreiQImfYuC0VA+DyluLXz0SUex9InaH+taBhgtWHJOKGxfbg9lUtquWLkw/Js7pJIUmtKaQm6m1gQgHSBKKvuW+Xe/nc0HgRpDj7jxmObSH3/zRlgmoeuV3xYKlEZWzOnON4IolojYF2q+/Ypz3GvmubXRv6NLSPE/x9Fo/7LZQTpaLp3zzp9zAnoW/9kqW/eEdyGJf8NINgo2NEFI/dsoHXWE1kwpEfH7DoEI83LfPraUyDyZJgXFT6f54Pq+pAoB9UZdWrMmpX+rMm9EiEfVPkCGr8rA5Wr+9RKacliNnvWAEQHKv4lbdNsjXfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNpG97icvWkZD5ljY9Pe+OxASL7RKtoc8VHBBs5CnOA=;
 b=jPqoMemav2kSmEwtxbB9aHYzUq0+0xasTIy85Bw19kE0BGOQHqHWBO0sjxzdwZ74DIYgECGjOe89T82DKeP5ST9duEN0WDvk2qnM1+4Ctnoxqt4A5LyL6DhAFKdROELlZJFVE4BgBoXwXkEBPndli71fCyHTK85JW5X5vWDxcAE+grcR9+agVDDDBRIq+ezz0EZah7h4yk2yQxgthJPdyPc99OXifLJSBOhYzQG3k4SK7hYURHofw2DIetXC4LTw02d7XZtPjMySqyBcX6bqHB/eg2Ee0HC9Wip8Un/BPG12uefE/Y15sZNbIvsOt6WGNNiM0icv+MfTQybT23v/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNpG97icvWkZD5ljY9Pe+OxASL7RKtoc8VHBBs5CnOA=;
 b=ighLyT2tv4JuC5rGmbRNdUy87gRHvZwk+EXwIRJyeqX8KsCOxYlb4e+q9iKKeazNynV3knr0qzGD2JbWae+STJhfWF2HgaWjU4R6ck6ArrssGD79oCMdJfDeVM0b0h0AYAEs4Us0KfqOhbhmuXOyJo9z9ndzYDn9W45Af4U8UwA=
Received: from SA9PR13CA0123.namprd13.prod.outlook.com (2603:10b6:806:27::8)
 by CY8PR12MB7515.namprd12.prod.outlook.com (2603:10b6:930:93::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Tue, 29 Oct
 2024 17:42:55 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::9b) by SA9PR13CA0123.outlook.office365.com
 (2603:10b6:806:27::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15 via Frontend
 Transport; Tue, 29 Oct 2024 17:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:42:55 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:53 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 04/29] drm/amd/pm: add inst to set_powergating_by_smu
Date: Tue, 29 Oct 2024 13:42:15 -0400
Message-ID: <20241029174240.682928-5-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CY8PR12MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfcb162-019c-4523-1a5c-08dcf8411ef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ME1MNGorT2RiZDA3bVhCSWliR05SOXBtRnZncVp2dzdxbUZ5UDFydGxtZVRE?=
 =?utf-8?B?ODJxQ0dQVGJVVzBtVUwzeGxlN25HNldLSUk1QndZUXluY3BrSXZQRFhUSktJ?=
 =?utf-8?B?bDJ6TTFrRzY2VUowRUxWVjdGeWlQVTlWZ21FdjA1MWw0cjdNSmNwYkx2bHFL?=
 =?utf-8?B?N3V0dTFJNkNpdmxLOW4xb1hMdTZRamJJSnJQbWgvVmVtM20renRROTNJLzh1?=
 =?utf-8?B?dTU2TG1MN0xvQkJEdlp5b0tCNS9SN21MbWVKeDllRmZELzdpMnZBL2pTaEZG?=
 =?utf-8?B?WW00c1BXZ0p1bkNLVFMrdWZhcUdUODdVTDluUWdZVkc4SzJyZ3A1bHgrWnhu?=
 =?utf-8?B?L0dGYzNRdTExZVN1bmxGREs4SVpnem1hZ04xZ0pkcFZVdm1kbDlLZVFjb1Zh?=
 =?utf-8?B?cHY5TVhzbEJMczJIV0t2aGhldHplWko3QWhRZFJjSklvL1N4Y1REUTJGM0NL?=
 =?utf-8?B?WGFhM01MQjRMSXYwSHRzRVpncmRPSk9oRmRuMThyR0Q2WklTS0RpSm44VHVq?=
 =?utf-8?B?dkRRUTFIRm54Vk13RW5Ta3kwMnhFaHJCUDU0b01henQxR1ZFb2VWWFoxWHlt?=
 =?utf-8?B?WG4vcWtlbnRwRk5oTmtkT0ZQTDIwWmFCRmV0WHVLR0NWSmRrTHpXeTFCZHRW?=
 =?utf-8?B?QThuUkRNQlM4SDBYcDZISDFNY1ZpSXZVaXFqVlR6bTl1KzZDMVRPekMzZ0dU?=
 =?utf-8?B?STUxQ21kaEEzTU10eHdyMTlhbHhlK29zdW9OU01Qemo0eGtqaFkwemc2Skc1?=
 =?utf-8?B?cDcydmxNbERiSTVsc2d0MDhad2g3bnVEQk44bUF5MzhNV04xVXZNSzBkVDUy?=
 =?utf-8?B?RXdqZHRUOTJVVnJjRklFdlZ0SDBRTFhXZGZ3WEk1NUNGTmRDRnhyc0g2WXA0?=
 =?utf-8?B?dVg1VVNxM1ptbTVWNVA2Yklya2VRQ2MvVS81emtKQTltRzlGU0JBNGxZVFpM?=
 =?utf-8?B?RXlkMm5KdDFiSEk3OWsydEc1b3l4Q05JRk5XN3dOMkJtaXRqS2NzS3hFL1NV?=
 =?utf-8?B?NDZzNHhRVm1PR0daUk1Kb2UvS0h1SXBOcDdTQ0lUNUlzdzdQMktjaURVL3ZU?=
 =?utf-8?B?c0trOGs5MEJUZ0MwV091dlQ5MDA0UlJaZ0xLSW5UbkVKQVhoVmtJUjlTR051?=
 =?utf-8?B?SFR4d09obVZPNjFxRnF1MjRXcDRZemxWWXpTZndiTDNIL1hMSkxLSzVOTzJL?=
 =?utf-8?B?Y2hLZzc5VDZTSUNCTHE2ZFByejNhemFZL2w1UVpFWWV4K0hHczJpRFFtWFBa?=
 =?utf-8?B?dVM1dFBhQThENWJQaEpWMnN0MXF5Rkc1OFVkd3VFWEdXams1UDJuR2hvTjBL?=
 =?utf-8?B?QXVraVV2bE5CeEIvekJvQlR1MnFMK1FkUWtZTkpPVGhEZVJGQ0VsMzRGZzRC?=
 =?utf-8?B?NnY3anByQUFMOGNGRndkc0ZGamhwamZSNTJWUVc0Y2hlUkdpTkVkUENlQllo?=
 =?utf-8?B?WmxZc2RuT1RVTUxFZnd3V0E2WnRNWmtBdEprOFJQdWtsRVdPN0V2bzFJWHFR?=
 =?utf-8?B?ZDVaeFJaREw5Tm1ESnhTdE5oZmFnSWVkdDVIL2s3NUNxRTgxTitNV25RMlQ2?=
 =?utf-8?B?TElMVXVZLzF6Rnh1SVRrZGExcW9zUkVFZUJibEZQOEMwMnFLdmltSmJsQVlC?=
 =?utf-8?B?YUhsbG5NOGV2YmpzUkdoY3VsdHBzT3VWMDR3UEg5NDdJSjI4THpuckd2MDZk?=
 =?utf-8?B?RUNzTWV2aFB6cjZXc0VHV0U1MEhVT2R4SGdaSmhta0dlbm8xZ2hLRWwyNWdC?=
 =?utf-8?B?QVVpQ09sODVEVEJ3aDMzRTg1elBkRzdiSWhYNnBqVVp2OVk5eUdHQjlBcEtI?=
 =?utf-8?B?Z2RuVE5hWnd3bEplKzJZQ3lnWWVVK1BpSVYwTnVEMDhtQ2puZVE3WTN5bFk4?=
 =?utf-8?B?VTRqa2UwdUJSRjVPc05xNXEvODcwdDRmN3ZxVUEyZy9hUXc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:55.5059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfcb162-019c-4523-1a5c-08dcf8411ef7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7515
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

Add an instance parameter to set_powergating_by_smu() function, and
re-write all amd_pm functions accordingly. Then use the instance to
call smu_dpm_set_vcn_enable().

v2: remove duplicated functions.

remove for-loop in smu_dpm_set_power_gate(), and temporarily move it to
to amdgpu_dpm_set_powergating_by_smu(), in order to keep the exact same
logic as before, until further separation in next patch.

v3: add instance number in error message.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h   |  4 +++-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 10 ++++++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c       |  4 +++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  4 +++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 16 +++++++---------
 5 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2fa71f68205e..f24bc61df9a7 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -405,7 +405,9 @@ struct amd_pm_funcs {
 	int (*load_firmware)(void *handle);
 	int (*wait_for_fw_loading_complete)(void *handle);
 	int (*set_powergating_by_smu)(void *handle,
-				uint32_t block_type, bool gate);
+				uint32_t block_type,
+				bool gate,
+				int inst);
 	int (*set_clockgating_by_smu)(void *handle, uint32_t msg_id);
 	int (*set_power_limit)(void *handle, uint32_t n);
 	int (*get_power_limit)(void *handle, uint32_t *limit,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c93..bcedbeec082f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -88,7 +88,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCE:
 	case AMD_IP_BLOCK_TYPE_GFX:
-	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
 	case AMD_IP_BLOCK_TYPE_JPEG:
 	case AMD_IP_BLOCK_TYPE_GMC:
@@ -96,7 +95,14 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_VPE:
 		if (pp_funcs && pp_funcs->set_powergating_by_smu)
 			ret = (pp_funcs->set_powergating_by_smu(
-				(adev)->powerplay.pp_handle, block_type, gate));
+				(adev)->powerplay.pp_handle, block_type, gate, 0));
+		break;
+	case AMD_IP_BLOCK_TYPE_VCN:
+		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
+			for (int i = 0; i < adev->vcn.num_vcn_inst; i++)
+				ret = (pp_funcs->set_powergating_by_smu(
+					(adev)->powerplay.pp_handle, block_type, gate, i));
+		}
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 8908646ad620..f0f81ecd9ad6 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3276,7 +3276,9 @@ static int kv_dpm_read_sensor(void *handle, int idx,
 }
 
 static int kv_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 26624a716fc6..90500b419d60 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1227,7 +1227,9 @@ static void pp_dpm_powergate_sdma(void *handle, bool gate)
 }
 
 static int pp_set_powergating_by_smu(void *handle,
-				uint32_t block_type, bool gate)
+				uint32_t block_type,
+				bool gate,
+				int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index dfbec2e2ec20..47b9591f0ada 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -354,11 +354,11 @@ static int smu_set_mall_enable(struct smu_context *smu)
  */
 static int smu_dpm_set_power_gate(void *handle,
 				  uint32_t block_type,
-				  bool gate)
+				  bool gate,
+				  int inst)
 {
 	struct smu_context *smu = handle;
-	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
 	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
 		dev_WARN(smu->adev->dev,
@@ -374,12 +374,10 @@ static int smu_dpm_set_power_gate(void *handle,
 	 */
 	case AMD_IP_BLOCK_TYPE_UVD:
 	case AMD_IP_BLOCK_TYPE_VCN:
-		for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-			ret = smu_dpm_set_vcn_enable(smu, !gate, i);
-			if (ret)
-				dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
-					gate ? "gate" : "ungate", i);
-		}
+		ret = smu_dpm_set_vcn_enable(smu, !gate, inst);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to power %s VCN instance %d!\n",
+				gate ? "gate" : "ungate", inst);
 		break;
 	case AMD_IP_BLOCK_TYPE_GFX:
 		ret = smu_gfx_off_control(smu, gate);
-- 
2.34.1

