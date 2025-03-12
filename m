Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55366C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 14:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5FE10E781;
	Wed, 12 Mar 2025 14:19:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b/r9jF67";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41FB710E740
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 14:19:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uCWgpxUYNKODPpRNGE8okXlbpTqeo0qlnQzRdpQ8lOhfdDuhLruaeyJBq/4DWys8egYqJWNN1a3I3o429+8xe3pPb7+rrSJ9k6G7HCD2Q0E79v8dJdzqX3h/IkewYiGJCN5Cp3hZYiAEkQuNVlGVlvgJyFyfiBANFzAeGAjsEsph8mDgn4wv1vCAIqP6VvJbg92TF0kjH1tmAVPc6nt8Qv52Gywq1uz5srXQaBQvJSWtI2aGm4jnpsPcgmtSB1ZTK0sOnovadS1Swp25+DVtFCIbDc2jw9vVUkJ3jycA5MwyV8qjxSVI6l7Ct/0p0RX37k4jWCQntncvztFp2CJwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rF7XfRX4OpbnnmbzU4j9nEpNGjkdwwuavwta8KiZno=;
 b=UnaX9UOLVvORbKwiORcvS1voDMFfm3GAytFDN/Q0UyXC6/z472mZpbSgHpJmC13U3ss3c7oyAHfzu11kSZ8DQmjkQVKH8k8+uANqK9kGzYJFznhowe7R2GpWC0Fml8oQdW0NIIjPRZ8GB68IrUgLNIOO00fEiwxPk/zGwi12ml5lABT/+OUSVjxKtp9BhrPD4mmzpHg8WNWrIz443RxVz+NsyReG4vX+cAQkxrvrCOl5dIIcPyQuh4qRr5xwoB2RxWHUzJDXL0ByIFpyDUT8euspAeNxjY+bk28jVo73twnjSC/sK8TZorYt4O6RNBYaqybD+K0v/h0iRm5jzY56/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rF7XfRX4OpbnnmbzU4j9nEpNGjkdwwuavwta8KiZno=;
 b=b/r9jF67bI0VEx0EumdfYaB+g8BfKpT73uwyRqAInCztpwtPmiuW0dooDWtD1D+yOb+HcAJ7SwRjJyWL44OiUtR1VHjP3rbpexBr7YIV5KuK0lQdTmwWZyYDG9RhHzjhhpsOkpJeeyS8gLLrgpXxx/jrpXB/lZdKqsEFnEWnevA=
Received: from BY5PR16CA0023.namprd16.prod.outlook.com (2603:10b6:a03:1a0::36)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:19:27 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::2f) by BY5PR16CA0023.outlook.office365.com
 (2603:10b6:a03:1a0::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Wed,
 12 Mar 2025 14:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 14:19:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 09:19:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yang Wang
 <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH V2 2/2] drm/amdgpu/vcn: fix ref counting for ring based
 profile handling
Date: Wed, 12 Mar 2025 10:19:12 -0400
Message-ID: <20250312141912.10994-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312141912.10994-1-alexander.deucher@amd.com>
References: <20250312141912.10994-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 764a9e32-76aa-4a0a-9415-08dd6170e5a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkdrakYrTVFZSVJJOVBTNHJzRHMyTDNSeXdtSHBRTUtBOFpncmw1cTVkN3g5?=
 =?utf-8?B?bjFua2NoOXhRVHBzM1YzbUxLWmg4cEFQbk1renNXZXhKUEFyRTQvS3JkRlJP?=
 =?utf-8?B?ZEZDQ3JiNUkraWRVam1JVWE3WUhCanBDVUNBM1cySUIwRmZ3SGdRMlZZNWMx?=
 =?utf-8?B?MGpnSDd1Y1p5d01kMFU0bG9FNzVNTkt4a1pRVDFuR1IrdzZqbFdkYVArczJF?=
 =?utf-8?B?VTZCNEdJR2dBejVzejl0Wld2UExEMmZ4M2QzQWtaUTErcmd2OUtnR0FaMmV2?=
 =?utf-8?B?N0ZJWHpyZ0hsdFBVdTVHeVhGWkxVUGdHSjZ5a1VCeW5TZ3NBc2l5SDg3RDBj?=
 =?utf-8?B?NTRHZHBtL0NwNXdMeVJiZkRONFp4am5tYTUranBQZnhSQzMveFhsN0pUdGJX?=
 =?utf-8?B?TXRYaXc3RURLNWlSTU1xUVRvMXpEQytNUGVTK1FheTcwZTBIbG04ZzBleHB6?=
 =?utf-8?B?Vkx2bzZkODVrZDBpL002U2tRYm1wVktGYml3anJrd2JEZzRYczNLOTdwK1p5?=
 =?utf-8?B?TEp6aytxYUlmOXV1NUVMeUYrK3NqVktiTElQRktFODhicFZpSm9wZUZ3QjU0?=
 =?utf-8?B?QkF6YUxSVVZzNFNhK1M1VVRQQzc1di9VOTJWdkt2YjAzelEwWHoxY0E4bnZL?=
 =?utf-8?B?ZnpLSndnYTJxcXR1MWh3ODZ5VmYxZ0hSWUFYR2xsdit0Qzd1UjZGWDQwZksv?=
 =?utf-8?B?d1JnUFZkNUNiaFcrb1pqTklhc1JNT3MyVEdnVElheHJ4OEZtUjZIamc1dDhL?=
 =?utf-8?B?azgvUU82cjlGVHZqSlNSWXJkY2NBZUxiKzVMWHRuT3VxYVhacnYvRUZLS3lh?=
 =?utf-8?B?b2RsK2M0WUxhU3haVFpGVVVkNDdMd0dzVXBtWndjTFlVY05tcjFDSXRZUlhk?=
 =?utf-8?B?bHNaZGdrT0VnVjR3RHRHakIzQ2QrT1NwU0xTNHJTay9COXJFa096MFg4YXhV?=
 =?utf-8?B?d1F6RjdEZGZKZkRrb1I3d2ZZa2pRaTRmOEJWcUM2N04yVzNmV0I4YXFNeE9v?=
 =?utf-8?B?RVlTaElSRXl2RVBsVm9PRUprb3F1aEF6KzRvdXpiSHpwcW5kL2thNTV6MlFn?=
 =?utf-8?B?eFNzUHpWcUlXVVJZRGhaNTY4TC9FY1VSQXB0REd3VG5xR1F6UVBOc0kyMzJB?=
 =?utf-8?B?Rml2MUJFTVdSeTBvakYvejEvb0I2MWxONllsQVppMWsyUjhqLy9JbktiOTc2?=
 =?utf-8?B?cHRIdHNxYVI4ZVBKVkppbGJGUU51V3NNVUpJLzN2L3RBSXVsYS9rYmJqZysr?=
 =?utf-8?B?L0ZUTnl4dE05M0c1WGdLbXVQL2g3MTdnYWQzVWRvMFpPS2pCekc4cHAxUTdE?=
 =?utf-8?B?U3VDTmNPTnFyaGRCL1RYcDdwaXZVRlZYWDQ1R0J3UWdkRUl5TkRXMmE0NG5n?=
 =?utf-8?B?dDhnOTV4Wk9obEszNUdJbm9PL3dDZ3Z4SjZxeW4wSE9tcjliRjhkS0RBM2k4?=
 =?utf-8?B?Y0xNRy8yTE52VmZ1anpZOHMwaDM1UTRFZjQrYlloSVBydjR2LzdmbytxYjVK?=
 =?utf-8?B?anI1a0FGdVd6WnBuQmNqTnpqcFljTVIxTmpvemFlWGZqNHIrTnR0UFZMN2hH?=
 =?utf-8?B?ZEtVYXRnSHBGeEVrNW96MWFVMzkwODd6OWJrTXRpeGhxQ0s0ejdLS25ERmxF?=
 =?utf-8?B?aXFBUHUrbSt1dC90bitmSjM2KzVwMGFtRGh4REFmUXFRNnEvQm5sMEwyRHo5?=
 =?utf-8?B?UndyWDA3c0hMOTVTSmhadXhCY2lMNjlLamFsYmFrTlZqeUVFOGMxNFgvSGFP?=
 =?utf-8?B?NEpKZDVmaFNUMm1DcDY5NmpxbHRoSFNKWDRaR3FqV1I0S3cvSTJWZ3diSnV0?=
 =?utf-8?B?UUpyaFRNUjJuUkxNcVRmVklUekVhOENRWjF1Nzc2bXl6VXcwdUh4dC9JQ3FH?=
 =?utf-8?B?VHJnSFpoc2dFditXb3dyOGhWR0U2bnprNkRiVndRelY1YStPV2JNNVZyaW9Q?=
 =?utf-8?B?WDFja1NLN0VCYXd1L0RwVG5rREpyUTJvQUVwZkVZMnNIVXg0ZGNRbW8rdG1S?=
 =?utf-8?B?aCs0eGttT1BRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:19:27.1562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 764a9e32-76aa-4a0a-9415-08dd6170e5a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334
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

We need to make sure the workload profile ref counts are
balanced.  This isn't currently the case because we can
increment the count on submissions, but the decrement may
be delayed as work comes in.  Track when we enable the
workload profile so the references are balanced.

v2: switch to a mutex and active flag

Fixes: 1443dd3c67f6 ("drm/amd/pm: fix and simplify workload handling”)
Cc: Yang Wang <kevinyang.wang@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 26 +++++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  3 +++
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 26 +++++++++++++++++--------
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 8d8b39e6d197a..6b410e601bb65 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -438,10 +438,15 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 
 	if (!fences && !atomic_read(&vcn_inst->total_submission_cnt)) {
 		vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_GATE);
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-						    false);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
+		mutex_lock(&adev->vcn.workload_profile_mutex);
+		if (adev->vcn.workload_profile_active) {
+			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+							    false);
+			if (r)
+				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
+			adev->vcn.workload_profile_active = false;
+		}
+		mutex_unlock(&adev->vcn.workload_profile_mutex);
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -456,10 +461,15 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	atomic_inc(&vcn_inst->total_submission_cnt);
 
 	if (!cancel_delayed_work_sync(&vcn_inst->idle_work)) {
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-				true);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		mutex_lock(&adev->vcn.workload_profile_mutex);
+		if (!adev->vcn.workload_profile_active) {
+			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+							    true);
+			if (r)
+				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+			adev->vcn.workload_profile_active = true;
+		}
+		mutex_unlock(&adev->vcn.workload_profile_mutex);
 	}
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 26c9c2d90f455..cdcdae7f71ce9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -358,6 +358,9 @@ struct amdgpu_vcn {
 
 	bool			per_inst_fw;
 	unsigned		fw_version;
+
+	bool			workload_profile_active;
+	struct mutex            workload_profile_mutex;
 };
 
 struct amdgpu_fw_shared_rb_ptrs_struct {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index ff03436698a4f..b4b8091980ad5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -147,10 +147,15 @@ static void vcn_v2_5_idle_work_handler(struct work_struct *work)
 	if (!fences && !atomic_read(&adev->vcn.inst[0].total_submission_cnt)) {
 		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 						       AMD_PG_STATE_GATE);
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-						    false);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
+		mutex_lock(&adev->vcn.workload_profile_mutex);
+		if (adev->vcn.workload_profile_active) {
+			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+							    false);
+			if (r)
+				dev_warn(adev->dev, "(%d) failed to disable video power profile mode\n", r);
+			adev->vcn.workload_profile_active = false;
+		}
+		mutex_unlock(&adev->vcn.workload_profile_mutex);
 	} else {
 		schedule_delayed_work(&adev->vcn.inst[0].idle_work, VCN_IDLE_TIMEOUT);
 	}
@@ -165,10 +170,15 @@ static void vcn_v2_5_ring_begin_use(struct amdgpu_ring *ring)
 	atomic_inc(&adev->vcn.inst[0].total_submission_cnt);
 
 	if (!cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work)) {
-		r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
-						    true);
-		if (r)
-			dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+		mutex_lock(&adev->vcn.workload_profile_mutex);
+		if (!adev->vcn.workload_profile_active) {
+			r = amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_VIDEO,
+							    true);
+			if (r)
+				dev_warn(adev->dev, "(%d) failed to switch to video power profile mode\n", r);
+			adev->vcn.workload_profile_active = true;
+		}
+		mutex_unlock(&adev->vcn.workload_profile_mutex);
 	}
 
 	mutex_lock(&adev->vcn.inst[0].vcn_pg_lock);
-- 
2.48.1

