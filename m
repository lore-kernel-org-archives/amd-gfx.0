Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E2CC282D0
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 20:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F224B10E185;
	Mon,  3 Mar 2025 20:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rebXxuL6";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCCD10E185
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 20:45:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feq/y4JxYyQ202Ouj167o0o1SXu32GU6R/E8X1H9+LA4XMt4JUIiz/0Oup3A0kClM5Trglq4Fh3/pJGXN4ww4il7FkUDTjbAdws6hOGEmb3dSKXKHCrKcTRLeX0TwaAx/8fv2HXKtJwGnpiDOf2Y0oJNj379VYGIJTKWi4sdn1yO455M10LzVaX/fwqVCALYTfcZNBRAdlWxKeDSLXS+xfh0Ry82B/OTmtBOCQU5f1xhKTbfy+eu9qfw1iYGyNT62K6SSeyxCl1utC18ilv3Wx/gI7fUBSGsBLfnjhbEoMOoy8YvLJyUvWtHGh8/LsAfJtJvWNNCIFuwqhXWPGrhzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PT3e4YAtE5007MLogsWh37ZNyki8ef8rr6HcvZvWamA=;
 b=dW6D45PuFA9hhg/eVLZsKWaKv5DGueqvNSDuijyErM4eZ2ujq9uGEu78DtrAtJXa+PE7Qyf7jv616/6g8QRYmW+xLT3tH+deegJxnD99FvnU4Y2fU3K4TWZJtZqZo3QD+kuT9mfyTADXhDdLAnmex6R3lexuDPmlvC/sXSt7X41kMFXFifLznI2aJFeUmmemr8J6qdgXVl8NOluMJuaLhBpPocmpDOa/zwZj6lmd9OX3RM/YfXLGov5RIrJhD6VCok7e9uCWwv/vDGiBKmSWjofpD8rQbSuaDzD8FbCNgI+qfau1ZIGFg2RvIxOeGNple0XwfvQ+PXni4vBQO5gbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT3e4YAtE5007MLogsWh37ZNyki8ef8rr6HcvZvWamA=;
 b=rebXxuL6+VEZ9O6ozf6JzKkrenmPTTJqkn2dFTUps6yK5KbdaOdaIHflqn+VN+8F05hxzC0L57dUVhgUi6Pd5pnCG3U32ziQPi3Kq0MLLUL+EinWQdnEKMNzbFS92WqsqgRUK6OGF+JMkkyDLZ5USs9L6oKQI4HtUG3AQea7Nks=
Received: from CH5P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::18)
 by PH7PR12MB5784.namprd12.prod.outlook.com (2603:10b6:510:1d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 20:44:53 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::c2) by CH5P221CA0024.outlook.office365.com
 (2603:10b6:610:1f2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 20:44:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:44:52 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 3 Mar 2025 14:44:50 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, ": Jonathan Kim"
 <jonathan.kim@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Reduce dequeue retry timeout for gfx9
 family
Date: Mon, 3 Mar 2025 15:44:27 -0500
Message-ID: <20250303204427.113261-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303204427.113261-1-Harish.Kasiviswanathan@amd.com>
References: <20250303204427.113261-1-Harish.Kasiviswanathan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|PH7PR12MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fd551e-3733-4f41-d2c5-08dd5a943f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eBFOJqa9pKCbE85oICx75/1fX+sKnF3TsyMkKScrXsGYlziDh9XY6KL9jTBm?=
 =?us-ascii?Q?cwCWlhr3j2JFXIkmaP3uPSV6ZuGL3zYqbcK/OIB8iW/a+jWf0emwHN0xGnR8?=
 =?us-ascii?Q?SxnbCLxodCoFwixby9aGWQMhrlPwduovMnyO9+ea9q1T6nMrGfe1rynufUzI?=
 =?us-ascii?Q?M/trwSFfsQ/Rrubq07sR6NbxUVY1RQ/pxVqBYS7m4Zald3Y8eLwhwYpP7okI?=
 =?us-ascii?Q?WkFTBt8J1wxWExyFC6dKePpY2d31kJsH4835Sz+4AQ7VG0cpooTE00RXw4n8?=
 =?us-ascii?Q?p9Pqmz9UlCtMjLh47gScvf3iy5VF20qzJ4rUs6I8fiuivit7CEnUp02gLPYk?=
 =?us-ascii?Q?esNigYuFfSCR5w2a1XrjYMrwDwlJH+nLfklZm40lLlo+pY3X9EpZWIaU+YDi?=
 =?us-ascii?Q?uiC1RUOOgXIAnCudCAW6hSLfcKTvdsT+r4QBxePUoBLm4lTAGLUbkkUeNOL0?=
 =?us-ascii?Q?9cLS4DoEO5M+6j3H82KSDLjpr67NDHX/cbs5127WpSCODHqMvxl9bU2XA1Kw?=
 =?us-ascii?Q?2kbcrSu5ouO52WeJIgjaW3bsoFS3uzTeOgwGIycm64EfJS0HHqfRdROWATVg?=
 =?us-ascii?Q?FxgQIpA54XP8/v0CK7yZVON5CPMzngwxSlOxNVMWRe7/uI1UWqBAVzhXAJ5c?=
 =?us-ascii?Q?qpyurTzK24uNgWNk1gpxr+muDG2PUQxHbsed2oXM4Yw3yG7u7kB6rWvFt3zk?=
 =?us-ascii?Q?FbeSZqcpO4dTDvaZ57SWplP8kUN3iH7ClmVDvupJJF/UKo+6aok45ihQfxrS?=
 =?us-ascii?Q?RlBijkNDQBHnA9Bp+lC4yysF6mg8f1io/H+iau73SvcCTN8DCA9I15Bdez9U?=
 =?us-ascii?Q?9kvTbVBSLdhvLo1Wno083ZSkJHN8X7Hps2izcbUhbXgonJ5S/UKH5LAwDs6k?=
 =?us-ascii?Q?KS63d+6bColhrcMX8NH8eMC+nbWdficQIprXXcxka7YaGxshBxsNN9w1tSY0?=
 =?us-ascii?Q?cZQdXp0Uz1ThR6JP7W99DR3lBl+TUcEvXZZOjkoJ5I+uLN37KdLC588vfLKZ?=
 =?us-ascii?Q?WjgDC1pDHAILBm9MkxHsW1H1bnf0b2q4PXydib82lMvQohrXEAW3MbAu92jn?=
 =?us-ascii?Q?HBxGxUGA0t9Jim+Vd+EmJfCiSVrjPn5e06ZUIh+1D3l2U10tmVqbDC6G++tZ?=
 =?us-ascii?Q?O/xxxBIAf73h9ACJaCTmpiAQC+Gtoza3sV5WzzseWDwDZH9SKNra7Tk0+5x0?=
 =?us-ascii?Q?8Wo8Kwx8WsLT/F7OWHHfXOPtIHlcrY269hZc8SNbjuCQ07Arq+fsYMI92Cqt?=
 =?us-ascii?Q?kuxX7ecLoiOPsZvRTftVXcWo7aU0ekSJ2nddrdAjTz4wg1NDoS0bDsaFzp5w?=
 =?us-ascii?Q?ALeMoh/cBQCUg7icNP3UZXWOCWvXHkhy5mGnWLyJVa6WG6LC6O+hoWswJahS?=
 =?us-ascii?Q?uQJoEXlGSNx4imeg6x3oi1mWyMWmpT4Htzs8xkrfeuZMSNSiB4qPfi0spc0n?=
 =?us-ascii?Q?cPKvMv39aztg/1v+/8eeieaXrYrnoC0vSEu/7lWZ4g2cNj8hEp7FQlC50rCa?=
 =?us-ascii?Q?9zZExJkC1acYVYs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:44:52.4820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fd551e-3733-4f41-d2c5-08dd5a943f9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5784
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

Dequeue retry timeout controls the interval between checks for unmet
conditions. On MI series, reduce this from 0x40 to 0x1 (~ 1 uS). The
cost of additional bandwidth consumed by CP when polling memory
shouldn't be substantial.

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: : Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   |  4 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 28 ++++++-------
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  5 ++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c  |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 28 ++++++-------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  5 ++-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 40 +++++++++++++------
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  5 ++-
 10 files changed, 70 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 8dfdb18197c4..53f5f1885870 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -189,7 +189,7 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.set_address_watch = kgd_gfx_aldebaran_set_address_watch,
 	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 9abf29b58ac7..6fd41aece7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -415,7 +415,7 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v9_set_address_watch,
 	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index e2ae714a700f..95f249896275 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -530,8 +530,8 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings =
 				kgd_gfx_v9_program_trap_handler_settings,
-	.build_grace_period_packet_info =
-				kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info =
+				kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
 	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v9_4_3_disable_debug_trap,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 62176d607bef..0b03f2e9a858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -1021,25 +1021,25 @@ void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
 	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
 }
 
-void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 						uint32_t wait_times,
-						uint32_t grace_period,
+						uint32_t sch_wave,
+						uint32_t que_sleep,
 						uint32_t *reg_offset,
 						uint32_t *reg_data)
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannont handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
+	if (sch_wave)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				sch_wave);
+	if (que_sleep)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
 
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
@@ -1109,7 +1109,7 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v10_set_address_watch,
 	.clear_address_watch = kgd_gfx_v10_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
 	.program_trap_handler_settings = program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v10_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v10_hqd_reset
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index 9efd2dd4fdd7..89ae07288b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -51,9 +51,10 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
 				uint32_t *wait_times,
 				uint32_t inst);
-void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v10_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
-					       uint32_t grace_period,
+					       uint32_t sch_wave,
+					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
 uint64_t kgd_gfx_v10_hqd_get_pq_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index c718bedda0ca..2c5f22838fe0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -673,7 +673,7 @@ const struct kfd2kgd_calls gfx_v10_3_kfd2kgd = {
 	.set_vm_context_page_table_base = set_vm_context_page_table_base_v10_3,
 	.program_trap_handler_settings = program_trap_handler_settings_v10_3,
 	.get_iq_wait_times = kgd_gfx_v10_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v10_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v10_build_dequeue_wait_counts_packet_info,
 	.enable_debug_trap = kgd_gfx_v10_enable_debug_trap,
 	.disable_debug_trap = kgd_gfx_v10_disable_debug_trap,
 	.validate_trap_override_request = kgd_gfx_v10_validate_trap_override_request,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 441568163e20..d2bbe9973c93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1077,25 +1077,25 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev,
 				adev->gfx.cu_info.max_waves_per_simd;
 }
 
-void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 		uint32_t wait_times,
-		uint32_t grace_period,
+		uint32_t sch_wave,
+		uint32_t que_sleep,
 		uint32_t *reg_offset,
 		uint32_t *reg_data)
 {
 	*reg_data = wait_times;
 
-	/*
-	 * The CP cannot handle a 0 grace period input and will result in
-	 * an infinite grace period being set so set to 1 to prevent this.
-	 */
-	if (grace_period == 0)
-		grace_period = 1;
-
-	*reg_data = REG_SET_FIELD(*reg_data,
-			CP_IQ_WAIT_TIME2,
-			SCH_WAVE,
-			grace_period);
+	if (sch_wave)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				SCH_WAVE,
+				sch_wave);
+	if (que_sleep)
+		*reg_data = REG_SET_FIELD(*reg_data,
+				CP_IQ_WAIT_TIME2,
+				QUE_SLEEP,
+				que_sleep);
 
 	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
 }
@@ -1254,7 +1254,7 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.set_address_watch = kgd_gfx_v9_set_address_watch,
 	.clear_address_watch = kgd_gfx_v9_clear_address_watch,
 	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
-	.build_grace_period_packet_info = kgd_gfx_v9_build_grace_period_packet_info,
+	.build_dequeue_wait_counts_packet_info = kgd_gfx_v9_build_dequeue_wait_counts_packet_info,
 	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index b6a91a552aa4..54ee8992be5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -97,9 +97,10 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
 				uint32_t *wait_times,
 				uint32_t inst);
-void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
+void kgd_gfx_v9_build_dequeue_wait_counts_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
-					       uint32_t grace_period,
+					       uint32_t sch_wave,
+					       uint32_t que_sleep,
 					       uint32_t *reg_offset,
 					       uint32_t *reg_data);
 uint64_t kgd_gfx_v9_hqd_get_pq_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index b9c611b249e6..6861e8f7a2f7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -298,13 +298,14 @@ static int pm_map_queues_v9(struct packet_manager *pm, uint32_t *buffer,
 }
 
 static inline void pm_build_dequeue_wait_counts_packet_info(struct packet_manager *pm,
-			uint32_t sch_value, uint32_t *reg_offset,
+			uint32_t sch_value, uint32_t que_sleep, uint32_t *reg_offset,
 			uint32_t *reg_data)
 {
-	pm->dqm->dev->kfd2kgd->build_grace_period_packet_info(
+	pm->dqm->dev->kfd2kgd->build_dequeue_wait_counts_packet_info(
 		pm->dqm->dev->adev,
 		pm->dqm->wait_times,
 		sch_value,
+		que_sleep,
 		reg_offset,
 		reg_data);
 }
@@ -320,26 +321,41 @@ static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
 
 	switch (cmd) {
 	case KFD_DEQUEUE_WAIT_INIT:
-		/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
-		if (amdgpu_emu_mode == 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
-		   (KFD_GC_VERSION(pm->dqm->dev) == IP_VERSION(9, 4, 3)))
-			pm_build_dequeue_wait_counts_packet_info(pm, 1, &reg_offset, &reg_data);
-		else
+		uint32_t sch_wave = 0, que_sleep = 0;
+		/* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default 0x40.
+		 * On a 1GHz machine this is roughly 1 microsecond, which is
+		 * about how long it takes to load data out of memory during
+		 * queue connect
+		 * QUE_SLEEP: Wait Count for Dequeue Retry.
+		 */
+		if (KFD_GC_VERSION(pm->dqm->dev) >= IP_VERSION(9, 4, 1) &&
+		    KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
+			que_sleep = 1;
+
+			/* Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU */
+			if (amdgpu_emu_mode == 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
+			(KFD_GC_VERSION(pm->dqm->dev) == IP_VERSION(9, 4, 3)))
+				sch_wave = 1;
+		} else /* non gfx9 */
 			return 0;
+
+		pm_build_dequeue_wait_counts_packet_info(pm, sch_wave, que_sleep,
+			&reg_offset, &reg_data);
+
 		break;
 	case KFD_DEQUEUE_WAIT_RESET:
-		/* function called only to get reg_offset */
-		pm_build_dequeue_wait_counts_packet_info(pm, 0, &reg_offset, &reg_data);
-		reg_data = pm->dqm->wait_times;
+		/* reg_data would be set to dqm->wait_times */
+		pm_build_dequeue_wait_counts_packet_info(pm, 0, 0, &reg_offset, &reg_data);
 		break;
 
 	case KFD_DEQUEUE_WAIT_SET_SCH_WAVE:
 		/* The CP cannot handle value 0 and it will result in
-		 * an infinite grace period being set so set to 1 to prevent this.
+		 * an infinite grace period being set so set to 1 to prevent this. Also
+		 * avoid debugger API breakage as it sets 0 and expects a low value.
 		 */
 		if (!value)
 			value = 1;
-		pm_build_dequeue_wait_counts_packet_info(pm, value, &reg_offset, &reg_data);
+		pm_build_dequeue_wait_counts_packet_info(pm, value, 0, &reg_offset, &reg_data);
 		break;
 	default:
 		pr_err("Invalid dequeue wait cmd\n");
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index e3e635a31b8a..4f79e707bc80 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -313,9 +313,10 @@ struct kfd2kgd_calls {
 	void (*get_iq_wait_times)(struct amdgpu_device *adev,
 			uint32_t *wait_times,
 			uint32_t inst);
-	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
+	void (*build_dequeue_wait_counts_packet_info)(struct amdgpu_device *adev,
 			uint32_t wait_times,
-			uint32_t grace_period,
+			uint32_t sch_wave,
+			uint32_t que_sleep,
 			uint32_t *reg_offset,
 			uint32_t *reg_data);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev,
-- 
2.34.1

