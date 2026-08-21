Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B63C5DF98
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:39:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D886710E31B;
	Fri, 21 Aug 2026 16:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1b0le39J";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAFC010E31B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:39:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htatAmeReycypMSZMfR5QtxeUk/vdnUuNUfe7l/QLgeVpvdm9paKFaVzyHmY66FyKxbxhhTjm1yqLJfMptXNsHGIbvr5xIT4NpzQo6cXDN6P5MyDrcuXsL3EcRmmbtBeFxgo5APCFBRx45bdXksPLQHh6UQptsvlEvA/mYKdl+YTHxgaLAmsFNVhzXFgaG+mCro+zfpcFVhGoxqnbW6LhvM/EIPNSGdn6MYOo5xni2cgtYl3eZV/josWuG3C2Br/z9xYXbDEBTfAVXUdZ2aebdhh5yZ3tWbw8SFKZcHVrSlQHlMIPY4p3t09Ru7uelYNLPqDjqZbwfC8LLoEBswbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ucs1RRxqrhK7dt7hOqP9gri9oSTUiT/wn3lvjUb6ShA=;
 b=krO+wYatmFWf1HTa3eJjdJJu2og05tdd8M/prj0swkd01P4nxCL720l+1zCDpqCtCXG545hwEdZvedicUv5VLrBzQ83lVYChUClHEsEICQPaKwjIswgko+whwiaSjYmEFvu/wmKBCWYuIhd5TN0EPNbHwiA9ufAaI/0IRxuZGjKh1Kug43uzb9U07bxx9CO1EnPSU93ImQXy1xxZ8TUK92cTG6epvZCtOSVgVgbxfn1wbZBJXRncNRVy7XRZ3oJJ9vr9oBj/l7YTkusDtfV84MR7yKrunvP1e9b6xaTYeu7ee8OyxsQclmhp4mxFtkpLu6VbbMRmyblv/BhlSjKj6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ucs1RRxqrhK7dt7hOqP9gri9oSTUiT/wn3lvjUb6ShA=;
 b=1b0le39JSnSeLh4Nv87eSfl2+O5//kBRrLiGHK/hqvS0VT2NXA+8wM/wjskPVVL6dg4ApzkBJx224YoWgbkHXiSNT4O6j+0TtgBeuZchw55OWuGe0pfXAKvR3M4mV1czxm6aIOCcCfmJ/dYYlnBic8/PJHpJ6ioSFNfYhHmcdOM=
Received: from SJ2P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5da::8)
 by BY5PR12MB4212.namprd12.prod.outlook.com (2603:10b6:a03:202::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:39:12 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:5da:cafe::26) by SJ2P220CA0009.outlook.office365.com
 (2603:10b6:a03:5da::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:39:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:39:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:10 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:39:10 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:39:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: update mcm_addr_lut data for imu v12_1
Date: Fri, 21 Aug 2026 12:39:00 -0400
Message-ID: <20260821163901.781602-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821163901.781602-1-alexander.deucher@amd.com>
References: <20260821163901.781602-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|BY5PR12MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: b3cc545b-f07d-446e-127f-08deffa2bab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: vviXAzPO8GLz2JOG+D+rfnc4I52BdgbeGcKrDDJaU0cHk2Hx7VdXTt0XHy3umhbqI5+Wx6zMDBtVCO3VvOYlK2wHNSG/2XGQZT65Fm3GpqoLrYsRXKGwglos7gH9TbxfevcvH4NKwCxccW19cqVcLzjVy4B1qjPQ7fV/YAcnQchg5YgAXDJweLYL6xE4T/1TV81oKkGUfaXKkc4UdGugW4kINWzkPWmrFw0+wE0Ko+D829Rn7HR/6AwvaOn9L6OAF8+YWexjmNTp6Xf/UpAC43gA97wq6Tjb9tOXluYLpC+w/ymRaWe06AUJWcqM/GgN5IGhQ2V4J7VsDkAeKIzZOqA1ws96u55Dr+bwx1UPc6RS4MPJf8r+iHWm0r+Ay8AyraRJLPsb67e1AZY8WV4opFGQBHfzVB8cOfRbGEO6ME1eNrPhc2jGPm0AMaC7hQ2CYLp4TopJJxul4DJ5XVYw0cqxC4EoHhTU5xKn5PG18XJhEhOnFxelfAC9610njDdawfhBJVPZPrc87e7JGk5RmEwp3zj2tlu8DbU9WYnKFCRD0mZTvv2+0uLHUeJ6A8JQVkbt6jUtcpdRk3ZG1T2ZRp5P873xlfzuTWqxjzHewJGAYcBj5MU6hbIRg3HRZoxa66+4dgCeXtbHMDI1VHNtvec7QI+2O4x0V1gjbUR65pcyVKYo4lhcHCDR2Q2mTU2X
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w3w/s6ef+Ts5r2TphFwAOc6ke+Mwtwn7x73r2L0/MN91vVwqV3z1sSIrm97SJjxQQngetnP6wYJrqa7Nmpaq3vaDbXMxo9nUFcO3fotu7rvw/4zvdnm5MweJhb58dV4pHHjJ2UDwR1zasCcVPdVuGq5/JDd8XPmrfQ4kJluQA17LboWPZDhI9BAU6gOSNXo5Hv1tiE1ggHgNcsH9xCxYGRMBTfFJpbLQpN3VTYQgo3WUCbWjNi2tIFVK7XOA3xBXxJHs5x4+xyB6630d5Vjm2/43iHh06ZsxFadeJyxi/iF0pu9OrXufJRn0EQeLEFi8cDrpDatmq2b2HXcVoLnRwRlkXTzGdvv9Vcx7evVVGvCd7f/tkVSEbmBLcHPHFlG7YJjV1rDeqJ56FMpALieo58QPv7dpJxy1hu8FV9e/FbQeGv1gGG1gLtckfmMkly35
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:39:10.9460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cc545b-f07d-446e-127f-08deffa2bab5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4212
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

From: Likun Gao <Likun.Gao@amd.com>

Support for partition mode to program MCM_ADDR_LUT.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 27 +++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index 7077f74446960..ce5c53202b34e 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -201,9 +201,34 @@ static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 	return 0;
 }
 
+#define regGFX_IMU_MCM_ADDR_LUT_PF		0x5f8d
+#define regGFX_IMU_MCM_ADDR_LUT_PF_BASE_IDX	1
+
 static void imu_v12_1_init_mcm_addr_lut(struct amdgpu_device *adev)
 {
-	/* todo: fill in when interface is ready */
+	/* Encoding mcm_addr_lut in SPX mode for now
+	 * I've noticed variations in encoding
+	 * Need to revisit the configuration later
+	 * XCD0:: Bits-[3:0 ] AID-01 XCD-00
+	 * XCD1:: Bits-[7:4 ] AID-01 XCD-01
+	 * XCD2:: Bits-[11:8 ] AID-01 XCD-10
+	 * XCD3:: Bits-[15:12] AID-01 XCD-11
+	 * XCD4:: Bits-[19:16] AID-10 XCD-00
+	 * XCD5:: Bits-[23:20] AID-10 XCD-01
+	 * XCD6:: Bits-[27:24] AID-10 XCD-10
+	 * XCD7:: Bits-[31:28] AID-10 XCD-11
+	 */
+	int data = 0xba987654;
+	int i, num_xcc, partition_num, encode_data;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
+		partition_num = GET_INST(GC, i) / adev->gfx.num_xcc_per_xcp;
+		encode_data = (data >> (partition_num * adev->gfx.num_xcc_per_xcp * 4)) &
+			      GENMASK(adev->gfx.num_xcc_per_xcp * 4 - 1, 0);
+		WREG32_SOC15(GC, GET_INST(GC, i),
+			     regGFX_IMU_MCM_ADDR_LUT_PF, encode_data);
+	}
 }
 
 const struct amdgpu_imu_funcs gfx_v12_1_imu_funcs = {
-- 
2.55.0

