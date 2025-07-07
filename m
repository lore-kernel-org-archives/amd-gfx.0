Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E281C83F0D
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 19:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 273AF10E545;
	Mon,  7 Jul 2025 19:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D5GGt6vp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C64110E538
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 19:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dONnJwUtqgT59DO/1wqyRXuN0yJ8XOJW2Mab4fBp3beaNSebSaH53kvhqZI/tnd0PJh+DWzJqDyUlIV0CcxtguJrWXEOtdXanl/VYkrweyrUk/9db3wEap8yKJBhWMNHp6Zw8O165F0wjaMvCQe2YQl+8pP0QPMrnSIPhVz4kYIiR5XfLjDefx3rVVKB+ESUs8k+lBFmNe8KBrCXlpvEyaIU5GgsK9P3hfgyT+ae5SrOSxvSj/qe+WAiNDK/agcdQ3JR0BTaFp9Q+dA6t7pja20SSY0vyyJSh/DGw8Ceo8dQ86mhICahNtkUr20C7YVc3FpHW/bVv29J7T2YggHRjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHaZMSWjaFf2rtN2tdwcd7L623gY19x6wPlkYu0KCvE=;
 b=byG7jlJghhpXqrHfCtVhzxjS12dnlbncqjT74BYjQLLztTG9FwQOcuajas1Y2A1ouubgxvQExyazgotWhA449nnFay4pVYtzFUgN5yo7Ih9ddSXIWnJ47qqLSBQagjCju2gRraerpctGhPhzJXwQYj/8kFlrlGyD+TgLEApW1tfSLhFGu3eBPu8yQOJtOOaLsH8QDEP9jAj0hD9H6XGzIgIItHWOF4hsX8G6elo0S7SoTUKnrfEjqRy/WRLzHVNVF6FKnJWulAquKPq2Pb85oiujOMeVw5KOQTX1fjjpY0cMvfciMdKgb87x1c6c4K6+Asd84rLvNRupU977WLjwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHaZMSWjaFf2rtN2tdwcd7L623gY19x6wPlkYu0KCvE=;
 b=D5GGt6vpWnnjeqsa0Qak7yfNHdfNgO2A5icfgUS2S9iSrkO673znVofpXtu9MoAMVaXYesulw2u8TBhjCTQLEAXQ7zWitoc7elj9nxgXKashLeCAUUpI3+PsWGpJX1HVofvp67mmNh1usHVKcllx7AJ1xcEeA6rSV1pUWrLU+Ns=
Received: from PH7P221CA0063.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::11)
 by DS0PR12MB8044.namprd12.prod.outlook.com (2603:10b6:8:148::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 7 Jul
 2025 19:04:37 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::9c) by PH7P221CA0063.outlook.office365.com
 (2603:10b6:510:328::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 19:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 19:04:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 14:04:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 36/36] drm/amdgpu/vcn3: implement ring reset
Date: Mon, 7 Jul 2025 15:03:55 -0400
Message-ID: <20250707190355.837891-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250707190355.837891-1-alexander.deucher@amd.com>
References: <20250707190355.837891-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS0PR12MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: e9c9ad49-80e0-41ae-e8c4-08ddbd891dd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+2asWXAkGQ4/WkxesIhsN1lKKEJR/Ap5mDkJpja6/JZFPl9HtvIKRoYcvgy?=
 =?us-ascii?Q?epAizj+NRRWXawEbpAE9P+wlCewk/WrtDApe/89nxZQLhgYl0o/zm+yz5B39?=
 =?us-ascii?Q?M/5VUTxJO72yWdxYF33/fgofw12UJNDVDmChU8O0klFQprlWDvtAjnlPrflX?=
 =?us-ascii?Q?/oMB2ItMIpryyBW175axfoAKz3qz2I477YoZjXHFfOx1YL9r/RyjIv//Qcr+?=
 =?us-ascii?Q?BHTT+PWlfHBWg2alH59w6BeDeAmjvYlcy3XcweGcCaCQXRWY3lWDB+bNtr2G?=
 =?us-ascii?Q?gjbdJUHovQjltIHG2bSRUQTojuFlCUnFXreRYhv2FJjxuWOT+JRIy7gd0Kjy?=
 =?us-ascii?Q?RIPfzubLES96klI4ntyIybMAcUuD9/2aLFw6XgBuKqHzrETmjgxHOqv062OI?=
 =?us-ascii?Q?Pocb49rW9EAVfvOqrNM4Hd6Spd8ixbjhxu85oxDnQxuR/mWimCmWhKBhx8p6?=
 =?us-ascii?Q?rwboSGMHVYzSwzad2nlRbZLfFQpiSFdTcSpg0xcVuebjPABz26JECaqklLdX?=
 =?us-ascii?Q?M3B6y/xKn0RD8mADKjV+cC9jH+ZA8b3vkkgzi8k2FnI9s1A/6rm5HjWtS+rV?=
 =?us-ascii?Q?xkwaFKReDHF5ubweuT/BIfMsGlL6PhXXTHGOA6c70l8dFAUwc2gSVPbmuKlc?=
 =?us-ascii?Q?7R6UFwyR0JuCNIhvigEwRvdCrqDwLbwgsLZifN7AAei20NQRzAF85nWZv5Xw?=
 =?us-ascii?Q?os49DEBpISOwtqWJoK1WpmBDCxNnXrTeZyjyvUpCm7DvJWIZlVw+d42rQkiX?=
 =?us-ascii?Q?NKXR2I1CFN2WNnkvdaGdenIxhh6LoxIUPZn+DCh5VA2/9MsP6/b3dyG/7XZb?=
 =?us-ascii?Q?cTDAYszm7I82dB8GAjVSIuPRrgut7IY2RIF0uy5xrN0aHMJRQO5WeJg06kL2?=
 =?us-ascii?Q?keGFcg0GM25eExxTtV65JCyUoaYZBEO5dhTUt88iabCmRbm1chjBEYw1gHyn?=
 =?us-ascii?Q?VSXCc8xX00T7bcjY3WtZo38N9UOC4IXcpgQ0RdkYY9YIoHc/gp6l3tbWK1tD?=
 =?us-ascii?Q?Jt7mV3NGDLaBkGTXEXM/xxOqvvetERAWig3G4rMSfnL/BIDRHK51rSHrlr6K?=
 =?us-ascii?Q?uZvoj10QIB0Q7FtosCoP4Jr/alLRh5D8/dIDUyyc+rxB3FMFZZQ8MWOnR2lB?=
 =?us-ascii?Q?okzVbPdenupYxKsm/peyhb/ABuQBeDz1KclDP9InbWtXpiWEWnpAxlWQFakq?=
 =?us-ascii?Q?bJdsTnDLzHIGam1MI7Bh2LYQkaQA+IICNkRqIkoDQHhlVfCT3bhOXtg8RPwc?=
 =?us-ascii?Q?49m9zwAp2vUl1eqWL6fAvtniNqKtJO49FReaYQwqKx/RejGs1DvZ3VYEIwml?=
 =?us-ascii?Q?JP1JaJXElXaWDuFMPB3/MGsdScMmog4GT/3nWSSN5OosXvFnZ8MKUcJDTdkE?=
 =?us-ascii?Q?E/HWvW9qtfwFylQGwLtJcXfI8QEcWZIo2/Kj++yLflvUVT+GQYSevcDI4hKa?=
 =?us-ascii?Q?pPGIjI40uhGAYNOB1x+oN2uKqxJeMnYGjmJalKYZeYoKKgI/USGM/ok2mDyD?=
 =?us-ascii?Q?i48upW8uOiw7gK2MlvaNFsdneBGncOx8fL/c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 19:04:36.4117 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c9ad49-80e0-41ae-e8c4-08ddbd891dd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8044
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

Use the new helpers to handle engine resets for VCN.

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 9fb0d53805892..0fd6675707ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -110,6 +110,7 @@ static int vcn_v3_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst);
 
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring);
 static void vcn_v3_0_enc_ring_set_wptr(struct amdgpu_ring *ring);
@@ -289,6 +290,7 @@ static int vcn_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 			adev->vcn.inst[i].pause_dpg_mode = vcn_v3_0_pause_dpg_mode;
+		adev->vcn.inst[i].reset = vcn_v3_0_reset;
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -2033,6 +2035,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 /**
@@ -2131,6 +2134,7 @@ static const struct amdgpu_ring_funcs vcn_v3_0_enc_ring_vm_funcs = {
 	.emit_wreg = vcn_v2_0_enc_ring_emit_wreg,
 	.emit_reg_wait = vcn_v2_0_enc_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = amdgpu_vcn_ring_reset,
 };
 
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
@@ -2164,6 +2168,18 @@ static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v3_0_reset(struct amdgpu_vcn_inst *vinst)
+{
+	int r;
+
+	r = vcn_v3_0_stop(vinst);
+	if (r)
+		return r;
+	vcn_v3_0_enable_clock_gating(vinst);
+	vcn_v3_0_enable_static_power_gating(vinst);
+	return vcn_v3_0_start(vinst);
+}
+
 static bool vcn_v3_0_is_idle(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-- 
2.50.0

