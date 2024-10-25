Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054FFD1039C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3B510E9D5;
	Fri, 25 Oct 2024 02:36:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rxMapGfX";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DE7010E9D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBEOUCk+bY3CWDj8gxahlgZ8ATKfrQSCFRVCXnzkCDFEsx2L3LoOkhs32jZePZe/4EtZKXyWrwy/BBHEsLimYXFCNQTQoT42QbSa1KdZ0UbwWY4X8kN7+Fumq9tEQq7PhTFg+rPIybwtrsq2MlvYeurKNAOVK/scZg573WoHp9lnukvcJHGgFdVOS8lQtbN5CvpqhDSzkZajwrtyABf4fgSlObYxuTdoDCiONBTzKPbuVROos7mJ6UaLCLH4Ssn9D9lzzCVkV0z8Q7ijC7MMsv3MwwaLcbf/rbX8vvUUyzBOemFmOJ+3fNBcWvgUxjVCDxSAA9wwoOCmtCXbYbb0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtdA8xpOtdzVy+OzVhOpNz/GXJGfqXaZ3FEs0/nmQX4=;
 b=vpJJ/69hlmqPVqZmpr0GVZ+Tw9V3+pVxHgEC2VV71rMh8DsL34HjfZtgyQ2TkN9JxzaRlfx+6YDA1CFXafA8gEV5Mk4kjyyXaVVdB2vpA2YhGNOdrUyB7ILic5HNmvmGqgUqBHVObhZlzxjtxcgbVxRbdotzBwNt3YBu3lvg9g8uIFWtznpR8g0E3ev7eBG1tFqbyD6A0GB/UKKAJuMHus0Ym9kd+ArgK9eDFhuRM6VZ+yInLRZMTQh38dQeXo6W5SM14H7+XdtQYpRiApFBsPBquL3JJd29yn6hZi8t83sMxie+IrvaLAVsXls6UOgzOGiYP0Lb/sNkFiPR+iF9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtdA8xpOtdzVy+OzVhOpNz/GXJGfqXaZ3FEs0/nmQX4=;
 b=rxMapGfXWKPXzb1ylMuFBj1RiTwJPeryIY/NTSkwp+hDxEyO7kj7g8Uwv3T2yIM4+zgVzXROrgK23C1NC/0889vISCFRwmq0fPfgbuA6ErCkK2bqE6XBkCjrJTpRRp1Et9rVbNyA4JidbWuVOFNw6P9wbs8zzyKxQ1lN/Vtdb00=
Received: from CY5PR15CA0175.namprd15.prod.outlook.com (2603:10b6:930:81::20)
 by MW4PR12MB6876.namprd12.prod.outlook.com (2603:10b6:303:208::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 02:36:10 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::c1) by CY5PR15CA0175.outlook.office365.com
 (2603:10b6:930:81::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:05 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 06/29] drm/amdgpu: add inst to amdgpu_dpm_enable_vcn
Date: Thu, 24 Oct 2024 22:35:22 -0400
Message-ID: <20241025023545.465886-7-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MW4PR12MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: e8548951-cf44-44b0-92da-08dcf49dc934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXhycTh3blJPWFhrQUR3OFRPNmVHQmpnUXVXTEpGYWVPeXlDdGtrY0k4Q1dQ?=
 =?utf-8?B?emMyZEQ1V2JRRXExNXVjSGF2elY2WVhQU2x4bkZvV04yeGVVZHdBVU1oTnVx?=
 =?utf-8?B?Y3ZGbmcvbVFGYXEwZmZyT05NODQ0MnVSUCtuNmo0T2dCd2liSFIyRC9kUU5U?=
 =?utf-8?B?N0lnbmt0VlRVUzZMUTBUSW1hVDd6ZzZXT015UUpNM09RM3VwZzlFMFVmNGRn?=
 =?utf-8?B?ZTZMK3p5eXpCanRxYVdaK29PWFd1c1VtOTdJaTBPOVVIWjlyNU0zckJGNXBK?=
 =?utf-8?B?WHRwSi9UUDg5MDdLemxIczhuYWdyQmU1N0tKQWFodXB6WXBtcHU2R1dBamxZ?=
 =?utf-8?B?bDVaN080eXQyNGorbklLbG1XWE5mSEhEWG96NjhjQ3RyTG1iREFSVVpUc2I0?=
 =?utf-8?B?Ym1iYkpISzIxN0lFK2YwVVFhREZDOUxYVFdwaGZjbmdNcGtzZmFzc2dkKzRR?=
 =?utf-8?B?bTJwa2pOU3NMUlU0YXg4ampnWDNhdjdTYmo3VE9vRW1VOEt6RjNHenpwK09u?=
 =?utf-8?B?djc0NnlGMDdPb3hRc0U4eGJBRE9UZ2V4UU80VW9jOTRrUkxTejJVbDYzK3Zh?=
 =?utf-8?B?WGt0SjkrVVNZVllJMTJ2Y0NCNHFVSVdFRFoybEhjUkNwV1RlQS81UTFpck5k?=
 =?utf-8?B?MW1zKzhVVDZNendJUkJTNnpGRU5kcU1FN21RL1kvRjFjM1dNR1VpZFlmcklz?=
 =?utf-8?B?VEo4SGVwYlhzY1VuMUx5UUo1YnpKUC9Mc3NpREdlUjc4RlU1YXNoaFM4K05v?=
 =?utf-8?B?NlF4MkgrQnYrbjY4V3VHbmVEUXAyWkFXaFlyZ08zLytITVZWTExMSFcxT2FR?=
 =?utf-8?B?WHF4aUZFUFZPVnRVeGVGMDlpRGMzeDdQZVI2SG5zZ0ZwMmtrVVhwR3hPVWV6?=
 =?utf-8?B?S1k0VDJRV0RNMnpmWmMySnB1OFNreld6SzNHc1JHVjErL2h4U0FDQmo1S0pL?=
 =?utf-8?B?TktXenByUEt5WjFRRlp3bjhHTmVQRVMvbGUzWkZZcGFPZjVqbG01SXdHcGsx?=
 =?utf-8?B?Sy9VU3RaYmhXQVY4a0RtMXpiNHYwT0w5WW8yTHlKaGx1OGs2VGxiWmFibUNT?=
 =?utf-8?B?QlRlZlhOS0MxTUhHbS81MjBpNW0reWttWnNLMmpWUksyUldkcThoU2xHUDV5?=
 =?utf-8?B?V3l5Zyt0eURZZjRNTzNIVDZVTkw1MllLTFhaM3F3OVZ4RUtGdjFlNWJRa0hi?=
 =?utf-8?B?dGFCWkx5OWRVaU1DRzJIQXBrVmdWc2VyZ09sOXl6TzNqRDc2Nkx6VXB4T04y?=
 =?utf-8?B?ZTNxZGdGTjdhd0JJTGhBTjdZWjduWXZERXpKYyszR2xVNDgvK0FROHBEdjJp?=
 =?utf-8?B?RHlqL2J1enJnbHRwL3FyRHZRdGdDY0hEN3ZIMHR2bE9oNzhBekxLRlBzbzlw?=
 =?utf-8?B?Smhod2VTK3hpVEkyWFhyUXlFOS8rZjR0R2JERDdVY3FPclhFVUdpbmNOWVho?=
 =?utf-8?B?U2Qyb0I1blFHb29lbWEySzdkcDJqSTcxc0hJc3VXYnRmYmJVWGMzNWpndGIv?=
 =?utf-8?B?ck5xL2M1M1ZnS3pKbmhnMlEybTJjTEVIQmE3T2tMUHplWnJpSjR2dzdNajky?=
 =?utf-8?B?RnduMllrZ1ZuNmpjdCtDRytHNVJreGlOM2VvbDBPTUtQOEZoUjZBYXN3RGZm?=
 =?utf-8?B?a2Y3ZGlqVTF0VVdYQTdicHVOWUtyd1Mzd2pna2JULytuRjYzRHN4T0xHdWlw?=
 =?utf-8?B?MHJObSs4TVAxaGh1VHJHQzNDczB0L2Vza0VKVkNtSzhBcGFvY3FwdzM0Vm9l?=
 =?utf-8?B?NDBCZ1pWUzZsaXhxTTFpZGR2dXYwYmpBaThsUGNLN2xzLzh6S0VHM25GRWIx?=
 =?utf-8?B?K1djOHk3MEhQcTF3ZUJ6UnBQMDJUaUgwcURzTWJrakNva0FiaUNzckNFVGJS?=
 =?utf-8?B?MEtHVDh6K3lWMzdtZG9DZ09zcm42WGdkUmY2U1pJMkJSUGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:10.0445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8548951-cf44-44b0-92da-08dcf49dc934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6876
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

Add an instance parameter to amdgpu_dpm_enable_vcn() function, and change
all calls from vcn ip functions to add instance argument. vcn generations
with only one instance (v1.0, v2.0) always use 0 as instance number. vcn
generations with multiple instances (v2.5, v3.0, v4.0, v4.0.3, v4.0.5,
v5.0.0) use the actual instance number.

v2: remove for-loop in amdgpu_dpm_enable_vcn(), and temporarily move it
to vcn ip with multiple instances, in order to keep the exact same logic
as before, until further separation in next patch.

v3: fix missing prefix

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 12 ++++++++----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 12 +++++-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
 10 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 511d76e188f2..7ad2ab3affe4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 	}
 
 	r = vcn_v1_0_hw_fini(ip_block);
@@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
@@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true);
+			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 697822abf3fc..f34cab96d0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	int i, j, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
@@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 power_off:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 0afbcf72cd51..beab2c24042d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1012,8 +1012,10 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1485,8 +1487,10 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index b28aad37d9ed..6d047257490c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1141,8 +1141,10 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1632,8 +1634,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 		vcn_v3_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index d87850dec27c..4b836b4935e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1088,8 +1088,10 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1614,8 +1616,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 		vcn_v4_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6fc52a1bda31..868302d63a4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1091,8 +1091,10 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	int i, j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1365,8 +1367,10 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 		vcn_v4_0_3_enable_clock_gating(adev, i);
 	}
 Done:
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 398191a48446..f0ec8bc031c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1000,8 +1000,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1277,8 +1279,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 		vcn_v4_0_5_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 58f0611b8fb4..9f89e152e875 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -761,8 +761,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1008,8 +1010,10 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 		vcn_v5_0_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8531e0993b17..5a9006bfc3cd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -581,7 +581,7 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 			  enable ? "enable" : "disable", ret);
 }
 
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
 {
 	int ret = 0;
 
@@ -599,12 +599,10 @@ void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
-		if (ret)
-			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-				  enable ? "enable" : "disable", ret);
-	}
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, inst);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index e7c84d4a431a..251b389dcf6e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -442,7 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

