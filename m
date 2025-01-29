Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E9AC0218D
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jan 2025 08:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B99D910E767;
	Wed, 29 Jan 2025 08:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lohP6xH6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E2DA10E767
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jan 2025 08:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qim+4W+qObTk4NiVpXu/+iYre9iO6zxy+lbc3Ybu7EGJ5SqJZAkUAtWppY7tWOOLlc5GuA7KUbhPLMDUONvb/IDecF120fNhfovonjOJwqRwpNlsXtTfsmMrOrtpVXeXTQ2owdJ2ieMduJnoVJvQpyLoA6PK3Qx6MxTQPVIPcec1QTivRUjdTWfxWe11NhCU+RTzhwaphox03CutU4xHJk0a4I8pOVDD0DklkeYKACiv9C/MtcwkFx5KXNCvdiJLUAWbrZleJHjWKHc6ip9iWGNUfuMf2Y3b5H6WnsdzIbbyXheMU0tg2c+aTnYQ13ZjK0YzdPb9Wn+xhg0xXa/7ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwBP5cSQOi7A9XggpE3uSCi3nSjIWxi8RxDuMWtTsyk=;
 b=yI6sf9gXpfi646/lWm/0fvgZV92BrS+iztX1mWp19Sk26pgQ+lBjwMxJO6aklERp+7yMIpha4OHl2lfXNAapG3RhQzkMmWYMnLE/hDQAmHOkz4OP+7jauqjSFKR9gAjfflCwVSS5f92122DSmoBm4AlMSkSPJDRjkMsOCC3usyOGD5dBK4B/bCCMtdwd4vDss0UQowyZM0AN/hw3cJJEMfw/+ZspSSBthqeOmoPNwbU5eHZWnZPO52FdUAy29CzLViSG66gTzVhvl23P5mGRVR4KWXsJ9CDGDsLYXK8ENlCVVD4Ww/j6f+cv9/ta1wDFJuOFg8hEL0v+qXwcxTwl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwBP5cSQOi7A9XggpE3uSCi3nSjIWxi8RxDuMWtTsyk=;
 b=lohP6xH61Sj+nLpC496MwQzP2MOy5jDZ1Q+6BOHOBQlgpb0uWql8O9ugO/vaFdCjBqAlchKPT7VeFaLUKj67qqeNfDhnfifi7vhggwwG6+1vSTN3uarrViC2dDdWNOmFhlU5EAZlS+9BAZfM6w3xq3MZ4hpuZ4/hjCjwX6idJbw=
Received: from CH0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:b0::25)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 08:48:22 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::17) by CH0PR03CA0020.outlook.office365.com
 (2603:10b6:610:b0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Wed,
 29 Jan 2025 08:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 08:48:22 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 29 Jan 2025 02:48:20 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 5/9] drm/amdgpu: Enable devcoredump for JPEG4_0_0
Date: Wed, 29 Jan 2025 14:16:39 +0530
Message-ID: <20250129084643.507727-6-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
References: <20250129084643.507727-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b16af21-61e2-4ba8-43c1-08dd4041afee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXZEUGVxREV3bE00RXo5Q2VmSzhlNUdkU1hGQ1B3QXBjdGZmMmVaQnZkaVpr?=
 =?utf-8?B?dTJkTXc2Q21QWFlsSE1hV3dEU2JmT29UL1BrT29NTjYyNjVpYVZhQms3QjVO?=
 =?utf-8?B?Y1VVT0lhSWdKcmhJVlkxeGVsMlE1aWpPVTFrZTU4OTRIUkdNK1E5R2lCTTA4?=
 =?utf-8?B?bjk4dXUrVW9NOVpITXIxelNVaUowVkk1Q0YyU09qc0xvMzBJMCtIaHN6dURZ?=
 =?utf-8?B?ZFFzODM4TGl5QW04Yi8yNlpXZ1ZPM1E5QndKU3U5SFQ5M0hKWnZrMEVLK0Vt?=
 =?utf-8?B?ZXlSK01hVC9NV04zWm1jQmQ0VWY4ckpyN0tNcGl6Z0I3M1RoUi8vbVh0N3Fq?=
 =?utf-8?B?MHNKM2tLNFlIYTZQcERBRm9KREJaREd5UU5PU1RjQ25DMFJzekwzNmVZc0FZ?=
 =?utf-8?B?NGxMaVk4Y2ROWjg2ZW1YT3BsR3FPblFKYXhYb00xdW9CZXNpVmEzRzlQeEhG?=
 =?utf-8?B?TC84MzZ1d0tEYks2WktrQkYzakJIZDFDbFR0dlVIcVpCbTFzeWIzUEI3aWZl?=
 =?utf-8?B?Rmx5RlBGbm5Xb3ZzU3RNQXlabVREczNMb29paHBMbU0ycnBRQ1d6dUw1dXVB?=
 =?utf-8?B?elgzbC9TUUpVbmgwMHJtR1RmZHhzaEpraW8vUnY2RXRTUjZlcENvMVZmZ1RP?=
 =?utf-8?B?Ly9ySGFZRWlETDBCN0hwRmsvTFBQQkovV2RRMjR4TUNvclVydUQyWW1JQUwv?=
 =?utf-8?B?M2puQUZkTk5taThmdmZHL2VSYXNNdzFVS1JGQkxnclllcWE2T0x4Znp2OWY2?=
 =?utf-8?B?a2JaaTQ5eUUzWHBXOXc0dENocGFxOGxQazhreFRGV3dCM3F4YmppeVBHNUls?=
 =?utf-8?B?WnlWOVN2RlMzOHNyWU5UaFEwYUhKODFBOWtwODBuRko0VWRoUzNDV1Y5UjlQ?=
 =?utf-8?B?YXZyTkplWVo2ZEZzWnRubStsdWlvd3FIcmxzWFRGR1Q5RTAxWm5zelFNdUx5?=
 =?utf-8?B?L3NNSXhIaU9PaW0vWkhPaXFXRU5uZlR1SXZ6aENYbXVlUTk2ZU5WdHdWbXVr?=
 =?utf-8?B?aU1CYmZsS3cwME16cmJvR3lENFZ5UFFMbHppWXpIbTFhenVNS2RQaCtaMUFZ?=
 =?utf-8?B?K1hldDB5WHNmMVpUemlFa2l6Q1pkMzJuZzFLNVBOM21ycVRrMFJMYUZLUzZX?=
 =?utf-8?B?SzlsdkUvL05IZnJiUVVjY24wbmZJeTcyZStoNXhWNGtlV04rb0tLNXUyak54?=
 =?utf-8?B?OVZ2eW04Z1ZYNkNMSUg1Z0M5QnljeGYyZGRKVjd1TDEySGNGUnduOEVZY1Ex?=
 =?utf-8?B?ZEV4a1VIZXIyaFZhcWgxT0hUNUZxRS84VStpSTM0KzVCQ0xOeS9WakdVUzYz?=
 =?utf-8?B?MHBCYUIxMC9rZGloUXRBU3BmbjRoaWpRVEhNSHVhYWtTazhKSGVnb05SbHBy?=
 =?utf-8?B?aSt1Smx4MEcreG9saE1tNXNXY0xyck9zNVdhOUc3dGVneWhqeHpkMnJxcXIv?=
 =?utf-8?B?T2lDS2JmTWUrY0lRcmNock5nZmlPOTZUUWpJOEM2NXd6dVBWcExkVDFINWRB?=
 =?utf-8?B?cDZOemtlcTU0bEVwbVFiNitFN0l0YWcxZUEvUlpnVDQ0aEg5YjY0b2plZUth?=
 =?utf-8?B?bzJvZ0VYVGx5d01wTTY0Vm9CRU8vaWVUUENydGRrbW5jU2s0cHUxY3hKM09O?=
 =?utf-8?B?djdRTTR3UkhiVWkvdkpncWF4UnNiTWFhMnBSVzkvMnVVVVJUcy9WT2FHK2tt?=
 =?utf-8?B?NWRsOWVzVHZDanVEZDZ3eXJJVlVWQ3k1YWFsay93eUxBNHBvTzluS0V1SVhH?=
 =?utf-8?B?QnVZV2dPZUFvZFljd0ZyOG5ZSWVwUlZzMlMvM01ZK2RUN3NJeUhIRTBhVDVW?=
 =?utf-8?B?TGtRL2EwSk4zUWx4bG1xbGZ6a1lrZVA4QnZpZmxFRnc4ZERFUGRsNDV3R1oz?=
 =?utf-8?B?R3dQYXdHRHZrQVBGa29tWTdaMGhaYktCRzRoRElsTTBGRG5aQlVCdHZWMlN0?=
 =?utf-8?B?Kzc4Y2x2ZC9ZVjBZcTdlKy83R0YzR3pUbXlwcVh1WHF1V1VlaUdTU1hHUFBW?=
 =?utf-8?Q?svaYSy8PqyIDYUHGUELF9/ia9luDNc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 08:48:22.4220 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b16af21-61e2-4ba8-43c1-08dd4041afee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

Add register list and enable devcoredump for JPEG4_0_0

V2: (Lijo)
- remove version specific callbacks and use simplified helper functions

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 0aef1f64afd0..0ff0cb659394 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -36,13 +36,28 @@
 
 #define regUVD_JPEG_PITCH_INTERNAL_OFFSET                  0x401f
 
+static const struct amdgpu_hwip_reg_entry jpeg_reg_list_4_0[] = {
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_POWER_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_INT_STAT),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_RPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_WPTR),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_CNTL),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_RB_SIZE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JRBC_STATUS),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_ADDR_MODE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_GFX10_ADDR_CONFIG),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_Y_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regJPEG_DEC_UV_GFX10_TILING_SURFACE),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_PITCH),
+	SOC15_REG_ENTRY_STR(JPEG, 0, regUVD_JPEG_UV_PITCH),
+};
+
 static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v4_0_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 				enum amd_powergating_state state);
 static void jpeg_v4_0_set_ras_funcs(struct amdgpu_device *adev);
-
 static void jpeg_v4_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -123,6 +138,11 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	r = amdgpu_jpeg_ras_sw_init(adev);
 	if (r)
 		return r;
+
+	r = amdgpu_jpeg_reg_dump_init(adev, jpeg_reg_list_4_0, ARRAY_SIZE(jpeg_reg_list_4_0));
+	if (r)
+		return r;
+
 	/* TODO: Add queue reset mask when FW fully supports it */
 	adev->jpeg.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
@@ -152,6 +172,8 @@ static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
+	amdgpu_jpeg_reg_dump_fini(adev);
+
 	return r;
 }
 
@@ -717,6 +739,8 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.wait_for_idle = jpeg_v4_0_wait_for_idle,
 	.set_clockgating_state = jpeg_v4_0_set_clockgating_state,
 	.set_powergating_state = jpeg_v4_0_set_powergating_state,
+	.dump_ip_state = amdgpu_jpeg_dump_ip_state,
+	.print_ip_state = amdgpu_jpeg_print_ip_state,
 };
 
 static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
-- 
2.25.1

