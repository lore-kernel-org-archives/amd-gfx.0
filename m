Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F01DCD1039C
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2441D10E9CE;
	Fri, 25 Oct 2024 02:36:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pXZItLEa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7664010E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMqiUG50w52MTn7wiwNSBUv3r8HLMpAn2yHGHTpLEj3LnGVeQY9dxIm65fEO2xiw+WRWtZcWXZ+PcWRwcRQIGnWLSkwaJo07VAx40qMzrwABL/YAmCBE7i3zvy3ai1yLX3SnBC1eMnH0wFTdYS9BrvV0MFdEIaHflR5K1resUE9P+4UvKr7/y9KVjD4dqa2YZB+TemJaKt9o7lS2aHjd0DA/p4Djqodjl8CnCFg8yGbPqp/nz7yRlQeUvooqWv8pCaM7i1EX23QT4zOLxKShf9nT1uq4CusmdhCWv+In0qcgzDnNC3IPl7SQXRH8BV9/tKJzp2BnRFDV0SYPXF2DHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvpV6j4cTUjcvaKngjcCGcAYhDdIS+OVGVbpJtQw/s4=;
 b=jb9IdjthoEwX2i6CFS4BAI6IyLJmTPm0MtC1GOdSLS7dSOztnPFUfISyJXMs5afwqlQ3ZWiOhHSh1gSKhtlQ0PSI5jik7AJemgIAWx2LlJrgC4eSWflFHV3/SzPoue9bJ/uVnxQxZk0itUU4xfeoZrp8Voy8+mZyNm9DAXCtFb7uJkWGORV8+5NDBC5Fpl9bJDjqM9zQDFSjhdqom3sh05LjVPZkNPx5WeRgyTa5Ya3XpbBnz77f8iIRJk50YGy8ANcoCyX8AHw5nel1IuByB6AmCBRN1CAiZa+VVgons9PQI4yODW+DiKum5Bvi4+T6VjCVZrNwdrzEquJS4U536A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvpV6j4cTUjcvaKngjcCGcAYhDdIS+OVGVbpJtQw/s4=;
 b=pXZItLEaM7VxgAPA7PpNakm7ZCX5U3ZZX6ioTPuHXU7mODVr09GLr9Y9zkRx1lwN3a5bGbY57Yn5LpcULUZE7BaGcvpNjRcfIx3NsxY5s0ed7GObFFJFJKCekRPEGaP9YJf4BuyItZRb7Wzd30MZAsSUfukPzymc4LW70TTHoW4=
Received: from CY5PR15CA0170.namprd15.prod.outlook.com (2603:10b6:930:81::9)
 by SN7PR12MB7833.namprd12.prod.outlook.com (2603:10b6:806:344::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 02:36:04 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::b1) by CY5PR15CA0170.outlook.office365.com
 (2603:10b6:930:81::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:04 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:02 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 02/29] drm/amd/pm: power up or down vcn by instance
Date: Thu, 24 Oct 2024 22:35:18 -0400
Message-ID: <20241025023545.465886-3-boyuan.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SN7PR12MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ec7600-a25c-4fbb-f38f-08dcf49dc5cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0lxRDZpeDBiQ1FBcUIwcnFBeTJPdDU3SXp5cDRqaSttR1p4T1ArdXMydTE3?=
 =?utf-8?B?dFkwclBscGVxZHM5SWlYaTI3bUdrRFYyRjNXNGYvc0RmTGZTcU5vZkJ4NTdG?=
 =?utf-8?B?WU8yL0UvTEVpNWw0QW8ra3JXRGNLamNlWGtJMDFvb0l1YXJjNlZHb2tyN0Nm?=
 =?utf-8?B?dDllSjltMXh2alZzelA1UlVDQnhrSTJLN1VkVGFaaklRaUxkQkNaRUxwOHpz?=
 =?utf-8?B?N0wvOGFiWW41OXY2L2gyL3BiRk96b1lpNDlSb1dzSFBRM3FseCtlK3ZsQ1U3?=
 =?utf-8?B?YVVwN2ZEMVd5RldZNm1DRFVNTW82Z1ZoQmZQd2NNVTk1YzN5M3JQNWJ2Z29k?=
 =?utf-8?B?d0hPQ2pOVEYyMVkxSDhlSDB2OW94MHl3M3grd2dGZFU3T2dxTTZQbEFiSTN1?=
 =?utf-8?B?K3pCTjUwVXQ2OG5GQnhwekNzbGk1REhZUGRNaGlqaEF6VTh4N2VoK2Q4bnF6?=
 =?utf-8?B?dXkzazdlMHdKYWg5Vkc4aXJaR3VMeVJPaVJaWG5SdWN0NmZBTjNlZXdYZW9L?=
 =?utf-8?B?aVdRaU54TS9jZkFoNDlTMVRpNjg5ZU5JTVdpMmRVdkdKZFlHeGhVdXZheDhX?=
 =?utf-8?B?SDk0SlNvaGtmV2J2dWtGZ0dLd1RwMTRHZTVybm9YTFFRT1o2S3R2RVMrR2ZG?=
 =?utf-8?B?SjlpRWlnazVPSmpvZVpsTitiUGJvTm8rYlVORmQwY255UzJsajFxbXdQTGFs?=
 =?utf-8?B?UHRQTjE4VENTbVB0V3l1Z21XSE5KL3dkT3NTTXhVVFptU21Jb3dic0UxTUw4?=
 =?utf-8?B?WGxKUGFBbEpXUGtCSVkwclhzcU93RzJmc0FROE9Zc2MxbzVjT0IzY1BuRm9x?=
 =?utf-8?B?cFNqQWsxU3owRG5zRm5KcTV1dDZkSlJEY1djVVliSkYwKzgzZ3hlSUtZREYy?=
 =?utf-8?B?RW14VHVFTFpPVmQreWRXekZhT3JQd3RmZnRxaWhKUnVQV3NUOVkvVUh0SXM4?=
 =?utf-8?B?c2paVnJ3SGpVVEFKckkyS042eWNxSlBCSzhjUlhOKytNTmJ4anIvZzZXT2ZJ?=
 =?utf-8?B?dnVpaHRnTkZGU1dHNzBCT1EvMUhUcWJ3aEVTRitRVWUwQnl4ZGxvcjRtN0t1?=
 =?utf-8?B?ZVBYa3ltU0Q5bW0yV1RISGdtb3BNdGtBTzkvbHBuMjFxQjFjbnJzTTRNQ2V4?=
 =?utf-8?B?UWR1OG1ValNVVE9uWWFUV0hrWUlMYVcyYUNXZXVVS2lqeVVZbFNJOUVoaHcr?=
 =?utf-8?B?MEdIM3BEVjVZMlgyL3AwS1BXb1U1eFJ4Tklxekl1SnJYVWNJOFg3RjF3QzhB?=
 =?utf-8?B?elRUZm1YRzhXNW5oYUpkdEZlNmRDQTNla1hZd3VjRmMycHBuaGQ0cXlMUGZt?=
 =?utf-8?B?LzhLSml0ZWtKbkg1RFp3U3F3MlJuRFgxVEZzZDlncTR6RDdBUVZlS0VzV1c5?=
 =?utf-8?B?UVhNTFNyTmh4MDRsNUpKZjVnNEJ6WnlQSkpjQ29JNS92dklCN3pwVHhRZ29q?=
 =?utf-8?B?MGo4SFV3ZlQvNkw1cWZhZndqeVp3RE8xdzRTUWpvL0RuSEYxM3V0VVduTjR6?=
 =?utf-8?B?cURVZGVNZGVQdUl2NVRIU0hqSGp1M05zU3dqUGFWR1ltM2ZEL3JRNTA1MUk5?=
 =?utf-8?B?K3o1SUtWeEZ0VDR0RXQ0c2I4SGl3dHgveisyTXdXWllKcDhPajBJWStRSmdV?=
 =?utf-8?B?Z0pHSk1VaUprajIvdnJDK3FUWW9Sc1liOHhhQ3RTNlkzdHZ6d2lpK2JNbExY?=
 =?utf-8?B?ZGRuNVUxOE52RXcxenUyNndWYXh2T0JCampBTnNJMEcyODQxOUI0TGFLaitU?=
 =?utf-8?B?MGMyaHFUempyK0JjYTFlbXY4YnZVSTFFNC9DenBkTDFHNVplVVpmbVRqWG5n?=
 =?utf-8?B?YWpCaTFmOU9RTzc3ZklSQzlVK1MvMXBBZmlvUkVZU25nSmptREtPRWs0SjZ2?=
 =?utf-8?B?enhScmo2NytreWpwUUU1UCsvbnRRRXRTSVdSajhJTUtjRmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:04.3257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ec7600-a25c-4fbb-f38f-08dcf49dc5cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7833
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

For smu ip with multiple vcn instances (smu 11/13/14), remove all the
for loop in dpm_set_vcn_enable() functions. And use the instance
argument to power up/down vcn for the given instance only, instead
of powering up/down for all vcn instances.

v2: remove all duplicated functions in v1.

remove for-loop from each ip, and temporarily move to dpm_set_vcn_enable,
in order to keep the exact same logic as before, until further separation
in the next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  9 +++--
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 20 +++++------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 16 ++++-----
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 35 ++++++++-----------
 4 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fe2a740766a2..ccacba56159e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -238,6 +238,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
 
 	/*
@@ -252,9 +253,11 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
-	if (!ret)
-		atomic_set(&power_gate->vcn_gated, !enable);
+	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
+		ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, i);
+		if (ret)
+			return ret;
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index a9cb28ce2133..24cf17e172f4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1157,19 +1157,15 @@ static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
 					      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
-		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
-			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      0x10000 * i, NULL);
-			if (ret)
-				return ret;
-		}
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
+	/* vcn dpm on is a prerequisite for vcn power gate messages */
+	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+                                            SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+                                            0x10000 * inst, NULL);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 2bfea740dace..bb506d15d787 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2108,18 +2108,14 @@ int smu_v13_0_set_vcn_enable(struct smu_context *smu,
 			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-						      i << 16U, NULL);
-		if (ret)
-			return ret;
-	}
+	ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+					      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+					      inst << 16U, NULL);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index ecb0164d533e..5460f8e62264 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1511,29 +1511,24 @@ int smu_v14_0_set_vcn_enable(struct smu_context *smu,
 			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
-	int i, ret = 0;
+	int ret = 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		if (adev->vcn.harvest_config & (1 << i))
-			continue;
+	if (adev->vcn.harvest_config & (1 << inst))
+		return ret;
 
-		if (smu->is_apu) {
-			if (i == 0)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
-								      i << 16U, NULL);
-			else if (i == 1)
-				ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-								      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
-								      i << 16U, NULL);
-		} else {
+	if (smu->is_apu) {
+		if (inst == 0)
 			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
-							      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
-							      i << 16U, NULL);
-		}
-
-		if (ret)
-			return ret;
+							      SMU_MSG_PowerUpVcn0 : SMU_MSG_PowerDownVcn0,
+							      inst << 16U, NULL);
+		else if (inst == 1)
+			ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+							      SMU_MSG_PowerUpVcn1 : SMU_MSG_PowerDownVcn1,
+							      inst << 16U, NULL);
+	} else {
+		ret = smu_cmn_send_smc_msg_with_param(smu, enable ?
+						      SMU_MSG_PowerUpVcn : SMU_MSG_PowerDownVcn,
+						      inst << 16U, NULL);
 	}
 
 	return ret;
-- 
2.34.1

