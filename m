Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9233DC83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 06:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13E9610E3F9;
	Mon, 14 Jul 2025 06:00:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TvlRbMXH";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9C110E210
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 06:00:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwLbdRQTDu4emGwOB+hONAzo/cwlcW8M0kR1pYbczLPFoxFFKtir5RgNNdk6u1Qf6pY3a9cAFHrobEd8jqc86IhalMfH9X8TseSreLAb2o/giz1PvrKRo56Jyyq4wrBjmR7MxyFFpWpmTLeXEpZiCJVcOa17RWAUKenfsgr2ybYpKDDkYC+0ktvS4nW8KlAvNqSdEGPMUNQRjgLGoBZVdw0C5M3AeoNEsbOj5SM25pJQzZ/tZ+xuEujGIZ9ei7OOXCJ25kulRgXkjwyoBsLDQFRPE12l8yym+zst6TwIIK66Q5/ZYiW1EP5Ifa4xuJ+6KDYPyJSBLzsEsV4PJAgn6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulsBGJw9fxDyb78E+hWv4ScseaCXcU5tHp9k+yGUWp8=;
 b=B3obbCkj5/AVWwLRarISZTSlW2F1aFtSX8892FvFQt5XEw0cAydmciKb924q0NgJ45e7WzRgoR/B8EWTEWe6nbI/P7np3zzOdNmElM/zzC3OpLc4DFhwWuzP5mTmBbaTzOXospCEpOZ+qVYB/1AsUnjBJ1sL0XIu4ok+WIrvDIJ5dzhu3mE1yU2d9RAwu0KkjI9ehpJSCCEpC3TNr1jos/LC6GBZlQhYYBnGU/ad34R3n6JJIbkpUeEovOmaz3Bo7Fib6qjMPeMdx5kkPhY2HxJiNWTVOFB4VA/pVHp3FpY1Q0vf1xIp5A4eiNMwR3bIdKYaqB0K5/UHPmxdhczSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulsBGJw9fxDyb78E+hWv4ScseaCXcU5tHp9k+yGUWp8=;
 b=TvlRbMXHkE/Cx3lVp2XaMx3ulu+jp5zM2py2O7O91GlCTqVsKwrStjDHq9gflMHYUr6K0rmVy/Z5zkL4DV3fuMH1341r66N7l3BfpS7UJx38q1C+V9EyLAiuqc7VoZnvjAyWxJI7mh5XVjin3sxowlbmWOERTZLFuKbZojDKDFk=
Received: from CH2PR05CA0007.namprd05.prod.outlook.com (2603:10b6:610::20) by
 CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.32; Mon, 14 Jul 2025 06:00:41 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::24) by CH2PR05CA0007.outlook.office365.com
 (2603:10b6:610::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.15 via Frontend Transport; Mon,
 14 Jul 2025 06:00:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 06:00:41 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Jul 2025 01:00:39 -0500
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH] drm/amdgpu: Check vcn sram load return value
Date: Mon, 14 Jul 2025 11:30:30 +0530
Message-ID: <20250714060030.1889474-1-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 2510cfa6-57da-4c39-d12f-08ddc29bc3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bCtBMVM3WWpmWmpmeVBLbUN5THFSdFBXOVNzTHlXQXNCWUQyWmQ1aDkvOGY4?=
 =?utf-8?B?V3BPamRtNFU3ZHo0VFNNU25UVWtXVFZDUHVUNzcrenJlbm9uRGRPbFh6RGZa?=
 =?utf-8?B?b3RhYldBalZSZWJtZ0I4UGdhcGFSMEIvbnl4TUhJdWkzV2RYVkExeU9RajMv?=
 =?utf-8?B?YTA0U1g4YjJ6a1hzV1BqNko3OEZscGkvZnNyeldjdUZWb0YySkhMazB6S2or?=
 =?utf-8?B?eHB6VTRacTBuMFl0UDZmSitydENlVUtZKzI5TGNGNWR5bDhEZFRBS3BKUXQy?=
 =?utf-8?B?MjZDVm0xZHZWNUFMWTRhQXhDWkd6MmhPb2FFTytLcW1xUEk5V0hqZ2Iwaml3?=
 =?utf-8?B?Y2FrcDF2eVNueWRNT3J3V2FKdGROT3VpMGNQVEFRTWg3bVRRS2ZWRTNkM1gx?=
 =?utf-8?B?SEFDZ1IrT2M2MnFYVHpqRmdhMGRqZGtlMDdEeW8xOVVVOHVlRzdqS2R6YkhI?=
 =?utf-8?B?SUxYdFcxT0RTYkxDcm9zOHBBRFB1VEZuRC9wSm9RMGp0M3VsZW93NlZjVCtn?=
 =?utf-8?B?UjRGVy9oTFdHSUhkVGxHTURDdkdOaEVEUTFhbWtvZnRSTGZtV1dOdFFKbFVH?=
 =?utf-8?B?MVYwU3ViT1ZYZG1HTnN3eWc2WCtFbGJvZEY1L2hqT2lhSkRjZlZuQ1Z6UFhQ?=
 =?utf-8?B?YnZGTzZUaXVhNnk1S1k5NDV4ZGVaUm80UmFDR21BaGVvQUZOR2ZXR1FQTno0?=
 =?utf-8?B?dmovM1VRbGRGbjQ0K0J6VDlKcEcvYzBwZ0ROUUhIMW04aW8xWktjODBTS3Rs?=
 =?utf-8?B?clRQanhHdEp2akN5bUN2WXNUMi9EWGxKZ3c2WTdHNkNsVlhDQjdWWHdsY1Nw?=
 =?utf-8?B?UlFjUFpVYTNrT09kUFJEdGpHb3NxWFlDaXZ1S2s1TFlJNml5dmtLWU42Q1NT?=
 =?utf-8?B?VnRadWdhM2RFTjFZbzM2b2xDby93Q1NhNHpNUXIrUlZLUjRFUEJ1OXBqekhn?=
 =?utf-8?B?ZTVFOEtkdmN6SG9JNU9DVTYydkVBdEVGdklBZzM4MkdVMzZJSWl2RjhDakgr?=
 =?utf-8?B?QlFYczlCMUlGQlNkejVOa1FyQ2Uzc3BwdjJ2VFRtMHhYbWFhN3ZJR3h0RmJG?=
 =?utf-8?B?ckRkbmVnUUZub2dDM1U2MVBEeFNVN1ltUHp1cjh2Nm00NHRFSUJka0pNSnpR?=
 =?utf-8?B?ckVNQ2hYOExtdG1hcEEzelhBb3dLVVpPWk93OXRvMDdUQ1N3QWlYOTN2cUdM?=
 =?utf-8?B?VkFvQjN5UnB2cVJJaHdwUXd5ZUpCeDJ5dE1SbWJYWkJ3RDFTdExlcXNzZzBO?=
 =?utf-8?B?cXVSQU9CcEFycjBKSEJyVlBFdlVoZ252bWo3UGY4UVh3cXh2SVhUTm9tbjdM?=
 =?utf-8?B?anJnZUpONzJyb0VnMlZ5ck92a2tLWFRzUVNDYUJ0ZWk4MW1hemVTbUxSU3hw?=
 =?utf-8?B?RmZCNmRjV3RhYXVUa3NRejV3WWVwSHk1RjF5VDl5eGFrVDJnSGhmR1c1UUZQ?=
 =?utf-8?B?eHRXL0EvbjkvWW4vRXBuQndFU0J1TzZzTnNDSktnL2t5WlRJZEYxWjUvaHQ2?=
 =?utf-8?B?dVRrUkRNOGtOM2dIYkt2cnh3WUwyeVBKYW1HbGtOdmh3N2tVUitVQ2hBYlA4?=
 =?utf-8?B?cVQ0clhVSkx5NEJQTnZQZ3lmMEJKV2pneHU5amd6ejF3a1RuTmRJUmJhT3da?=
 =?utf-8?B?dGZ6bTFuM1NheE5tZ0xHeHlEblNlTU42bEhzK3QyRVg5RmRzQ3I0Z1FhOFFj?=
 =?utf-8?B?UGtVODlIZFhPWi9WODhoamFZWFFRK3k4TzhSYkdKcGN4aEptZFJIOGdpcHhQ?=
 =?utf-8?B?RGF3Ym5NRFo1ZnFDc0RUTkcxeDI0bms5RVVhVXl4TStLZ0FvT0l5TnB5S1FR?=
 =?utf-8?B?RTUycitQSTQ2ZThOZUJERjNZYmdlcGlEdmZXWkNnOGVwVkJaM0h3cWMyYmpE?=
 =?utf-8?B?N0tLVWZzZUI4N1lqNGVxVmdpaFdFeE1jYUNHSmZOY0E5MmdtR2RzRjVyMnJp?=
 =?utf-8?B?bEQ5QzJ3cmJxcmdjb2t2VXArYW5wZE82RVVCeHdxdXF2NGZyU3gvclB6Q2Nh?=
 =?utf-8?B?WlBiOHpmTnZLc3hHekllRm9rTE5RbE9TRXlORG56S3I1d2tOektRMGpkUkFO?=
 =?utf-8?Q?Tsg7BV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 06:00:41.5647 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2510cfa6-57da-4c39-d12f-08ddc29bc3bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

Log an error when vcn sram load fails in indirect mode
and return the same error value.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 11 ++++++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 10 ++++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 11 ++++++++---
 8 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 148b651be7ca..a17629b7f4e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -851,6 +851,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
+	int ret;
 
 	vcn_v2_0_enable_static_power_gating(vinst);
 
@@ -934,8 +935,13 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 		UVD, 0, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, 0, 0);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, 0, 0);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
 
 	/* force RBC into idle state */
 	rb_bufsz = order_base_2(ring->ring_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 58b527a6b795..cbdc3c451bdb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1022,6 +1022,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
+	int ret;
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 1,
@@ -1112,8 +1113,13 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 		VCN, 0, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d5380589..021fef318ab9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1029,6 +1029,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t rb_bufsz, tmp;
+	int ret;
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 1,
@@ -1121,8 +1122,13 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index eec9133e1b2c..e8a2cb1a0c1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1011,6 +1011,7 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
+	int ret;
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 1,
@@ -1093,8 +1094,13 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d8fd32c1e38e..056d9f3aa2a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -851,7 +851,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared =
 						adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
-	int vcn_inst;
+	int vcn_inst, ret;
 	uint32_t tmp;
 
 	vcn_inst = GET_INST(VCN, inst_idx);
@@ -944,8 +944,13 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		VCN, 0, regUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 7e37ddea6355..beade6f5be64 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -925,6 +925,7 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
+	int ret;
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 1,
@@ -1005,8 +1006,13 @@ static int vcn_v4_0_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		VCN, inst_idx, regUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 47c0bcc9e7d8..af74da292a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -712,6 +712,7 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 	volatile struct amdgpu_vcn5_fw_shared *fw_shared = adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
+	int ret;
 
 	/* disable register anti-hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, regUVD_POWER_STATUS), 1,
@@ -765,8 +766,12 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		VCN, inst_idx, regUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, 0);
+		dev_err(adev->dev, "%s: vcn sram load failed %d\n", __func__, ret);
+		if (ret)
+			return ret;
+	}
 
 	ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index cdefd7fcb0da..d8bbb9376731 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -605,7 +605,7 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		adev->vcn.inst[inst_idx].fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	struct dpg_pause_state state = {.fw_based = VCN_DPG_STATE__PAUSE};
-	int vcn_inst;
+	int vcn_inst, ret;
 	uint32_t tmp;
 
 	vcn_inst = GET_INST(VCN, inst_idx);
@@ -666,8 +666,13 @@ static int vcn_v5_0_1_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 		VCN, 0, regUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
-	if (indirect)
-		amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
+	if (indirect) {
+		ret = amdgpu_vcn_psp_update_sram(adev, inst_idx, AMDGPU_UCODE_ID_VCN0_RAM);
+		if (ret) {
+			dev_err(adev->dev, "vcn sram load failed %d\n", ret);
+			return ret;
+		}
+	}
 
 	/* resetting ring, fw should not check RB ring */
 	fw_shared->sq.queue_mode |= FW_QUEUE_RING_RESET;
-- 
2.48.1

