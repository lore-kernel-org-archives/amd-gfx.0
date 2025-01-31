Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1B7C02194
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0418610E3C7;
	Fri, 31 Jan 2025 16:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3sxMot9s";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4E910E3C5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkDAtYKJBqQpG354LQiVUgMkLI+bfLoEU647eySCK3yVRGQuHS9EsEB0Ow8Bbpuk2JpHZHyySiEy0vU7HZBWucC8pJq/A3TLAa0Nnr2Ol56UDUsRWN5jcc9KuxWZq9dukEf4GyClAYlQE/s8LtgcpwpL2Pg5NU6qBykr3MKOgdHPDloaidD/Xw9ueWen14j2yglzX7ggQvDlB0iYyCzhXLO7mTwncFSsS34XGcnglU8B5BkjTEAn+VRea+0SPCLdTdvyC7phyJ5GpxcoRJKMI5r9VgIi8LH5UJOHL5Z7Xnt77SHvkBOire/ZqD75CAwZYv+gaHuy3iqe1nZYm4QvPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMIMPXtMukTyTfNLx8j25i7LTWvghZe0T/2ozg/u3aU=;
 b=tbxxiqaGZRIwc/TwX9gBeEjBQTleoUAL6N+PStGu+DjoDrmurfYh6oOIN7QpK0r6Q9aU9fiIJLnJoFjsBQkhgP9ZvbfuR3UvRg22V57qlJdJ3W2Xviw/U1iZqv5bjNwgO5/8wVaFYR1bAOj8b6Vu8Ma/nGPQ1Oel+YitDuJ959/jBhIbPcZWLVJ0q+HM/aB0fFTBcYvbj871K7dWijEwHnPqGqx5iK3u3IzUi9dFoVuH34rJbH40ZLzccxmGfW5678/HUB9vBpJdaCGMdwbc5btGRXZZnbhTM/0L4BhZVT6aIycF/AJoc+Z72U8NuXJPN9BvWmMfMsyUFXsIkkOFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMIMPXtMukTyTfNLx8j25i7LTWvghZe0T/2ozg/u3aU=;
 b=3sxMot9s+9D2DUY91ILt/u+BDVdCt8pxymiA6OymkoJYLdIzicI8oovod7PMyAhQxnygibNB8Aml4ZVt2ASMZXWz4Xk47/WsYkR5ChGJGD2DqSFB5QZPk3UnCtYzM/y9pzD1uzSg2zw2L/rtM4mDtnAlOIdEMSPrT1Tb5Wu0Vko=
Received: from CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::10)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:11 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::77) by CH5P220CA0002.outlook.office365.com
 (2603:10b6:610:1ef::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:10 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:05 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/44] drm/amdgpu/vcn: make powergating status per instance
Date: Fri, 31 Jan 2025 11:57:05 -0500
Message-ID: <20250131165741.1798488-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a94d0da-12b4-4e8f-838d-08dd42187174
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HC01kIaZUcPHvhV/VVQn8xLf0RobxulTzGkB8rOspw1t998L5J4IsvZ0iSip?=
 =?us-ascii?Q?CnwG95rLFNxITbjQSIgLqN6iswSsqnRLQm9gR9j9mTlTdyMIJmCV0mObp1Z7?=
 =?us-ascii?Q?xIR6aVWntTBYhAivwoFpj3WDakfcdnOh/qP13CLA6K1OwEQeQbaOsExYa0ei?=
 =?us-ascii?Q?E1HqsqSr5xOKjo8HeYsPz1ZxGcYPJ4w7ku5QYsWPEVisOFP/Yr5/L1iDdfxJ?=
 =?us-ascii?Q?a7X93bAeTd/Hn2e6miBtZFwuTtHh+i2RfavmUiwzrHcgrmegaRSaqQiMpz0v?=
 =?us-ascii?Q?SOIMehqPPvoxmU/k0/MuxxH2W9PHZeAkv0UYvynJmaBpqYpVmWmRifgwxpJg?=
 =?us-ascii?Q?BYRI/e5xqyzEt/FpXL21eoE1kO5HrkeXSj3MSqcy9HssEN9XjUr1NbRXW7Cz?=
 =?us-ascii?Q?kTnXIL17ted3OsCjCDU9GXdl3BfOkJ7w7WNNIvZaPbMXzTFH+T0tOuSbCahG?=
 =?us-ascii?Q?G/pusp5Ce05/OjXycF+xykFBx5lTpzRwdJxTduO3FDP4go8ho5FLoD1X8lVb?=
 =?us-ascii?Q?uMV8Zg1VXAAhozq+HNdDZSumGoxxIcCylWegEadXlBXvil1f7YPCHMQDTYrU?=
 =?us-ascii?Q?JLRKaHdlLZ9L2lTkOJ62lgvEedw/jaClLvMlLDoxmRrnbEtreDNyqTKPQwZa?=
 =?us-ascii?Q?imr2z6a5YNNORO5gi+ZbwrUSc/2NB9nPhZitVcZ5GotcGpE00Ubi9sX+eXaH?=
 =?us-ascii?Q?PEMEvzqmtSvTK254s2raZGXJpfI+XEIKYcMGb95eRF+nCk+ETRBT2Wdz3wTc?=
 =?us-ascii?Q?nLkdvAl2jg8F4ILHRNqSva9NzjbWgkYGeYzQDH4wSBvDzPFeXiI+/p8OKAOC?=
 =?us-ascii?Q?jVyADH5KM11wE/Cox7ZpQxrEkgcRKhau1koCZcWxIfOS0AHP27rovcNlXKkz?=
 =?us-ascii?Q?Eky59q1/LIEnjJxGZAtNBZYC/SpN4ufHNjNBeeA0hDSmGUJ1KYIO72sdgOPI?=
 =?us-ascii?Q?WfqnANlg5l2wUMM4+BI//QzM2GYVhZ+P4nh3Ah0n/9KwUOrtzI1+Z9WDrH2r?=
 =?us-ascii?Q?UTwv/fslsEyiXArEBT/Kh73XtPG9QG/mXIJDTd4FqXNsgB9HZk4rHnUP1fRU?=
 =?us-ascii?Q?5+PNm4QhQgyeB7s07u+djtu31sTtS9G5rZz9Y1dosFD7mOrTqIa4hb1xLSdy?=
 =?us-ascii?Q?IOCdfyhs42XLNQLdVhAdistaNaRkXtyQ80ddo9j4SdGHHcS14F2oxK5OFDTO?=
 =?us-ascii?Q?I3zxyyeC8D5snwBUxVP+KViziChLv0PepB+3jiCfg0+ytFpze01Z/G6fibjj?=
 =?us-ascii?Q?EVHpfKfLXGVyNVa+mBG1w3x3w09cnqLNl26R87VuUoaWypf2wzPfDOqRzJR8?=
 =?us-ascii?Q?0qvD4aSab7RraMtjRsFYLkiP5kabEXCxg1QZexT1A4RfdzMTglbL2i7w2ZuK?=
 =?us-ascii?Q?HoOs1G412HFzG2UMtiC0IzyGO78oX3aDzxo/zcQjLt0EYYUBTMRZfHXB7JXz?=
 =?us-ascii?Q?xwcQ5e2QC5bJ5syK9OE10Swgs+xgqg4yjU0K1bdhRoXzpvHIGzD+Yw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:10.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a94d0da-12b4-4e8f-838d-08dd42187174
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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

Store it per instance so we can track it per instance.

v2: index instances directly on vcn1.0 and 2.0 to make
it clear that they only support a single instance (Lijo)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c     |  6 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c     | 11 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c     | 43 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c     | 49 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c     | 60 ++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c   | 63 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c   | 48 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c   | 40 +++++++++-----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  8 +--
 11 files changed, 241 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f1685283c2f13..0bcf4d1c7175d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -320,6 +320,7 @@ struct amdgpu_vcn_inst {
 	uint32_t		vcn_codec_disable_mask;
 	atomic_t		total_submission_cnt;
 	struct mutex		vcn_pg_lock;
+	enum amd_powergating_state cur_state;
 	struct delayed_work	idle_work;
 };
 
@@ -330,7 +331,6 @@ struct amdgpu_vcn_ras {
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	unsigned		num_enc_rings;
-	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index b90d41cd001c8..757cacf11a817 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -280,7 +280,7 @@ static int vcn_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		(adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
 		 RREG32_SOC15(VCN, 0, mmUVD_STATUS))) {
 		vcn_v1_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 	}
@@ -1813,7 +1813,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1822,7 +1822,7 @@ static int vcn_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v1_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[0].cur_state = state;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index a51691c6d6110..e55c1f8f260e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -316,8 +316,8 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	cancel_delayed_work_sync(&adev->vcn.inst[0].idle_work);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-	    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-	      RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
+	    (adev->vcn.inst[0].cur_state != AMD_PG_STATE_GATE &&
+	     RREG32_SOC15(VCN, 0, mmUVD_STATUS)))
 		vcn_v2_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
 
 	return 0;
@@ -1810,11 +1810,11 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[0].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[0].cur_state)
 		return 0;
 
 	if (state == AMD_PG_STATE_GATE)
@@ -1823,7 +1823,8 @@ static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		ret = vcn_v2_0_start(adev);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[0].cur_state = state;
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 6fb08ed093101..1d3780a2d8513 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -95,8 +95,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_2_5[] = {
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				int inst_idx, struct dpg_pause_state *new_state);
 static int vcn_v2_5_sriov_start(struct amdgpu_device *adev);
@@ -397,9 +400,9 @@ static int vcn_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
 		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-		    (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+		    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
 		     RREG32_SOC15(VCN, i, mmUVD_STATUS)))
-			vcn_v2_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			vcn_v2_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
 			amdgpu_irq_put(adev, &adev->vcn.inst[i].ras_poison_irq, 0);
@@ -1805,27 +1808,39 @@ static int vcn_v2_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v2_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v2_5_stop(adev, i);
-		else
-			ret |= vcn_v2_5_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v2_5_stop(adev, i);
+	else
+		ret = vcn_v2_5_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v2_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v2_5_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 70a1b85a4efae..13b9ed96cccda 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -105,8 +105,11 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-			enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v3_0_pause_dpg_mode(struct amdgpu_device *adev,
 			int inst_idx, struct dpg_pause_state *new_state);
 
@@ -430,9 +433,11 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				 RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
-				vcn_v3_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, mmUVD_STATUS))) {
+				vcn_v3_0_set_powergating_state_inst(ip_block,
+								    AMD_PG_STATE_GATE,
+								    i);
 			}
 		}
 	}
@@ -2147,33 +2152,45 @@ static int vcn_v3_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v3_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v3_0_stop(adev, i);
-		else
-			ret |= vcn_v3_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v3_0_stop(adev, i);
+	else
+		ret = vcn_v3_0_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+static int vcn_v3_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v3_0_set_powergating_state_inst(ip_block,
+							   state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 4a846c9a2b039..dbbeeffc90726 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -96,8 +96,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 static int vcn_v4_0_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i);
 static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-        enum amd_powergating_state state);
+					  enum amd_powergating_state state);
 static int vcn_v4_0_pause_dpg_mode(struct amdgpu_device *adev,
         int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -367,9 +370,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+				(adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
 				 RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+				vcn_v4_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 		if (amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__VCN))
@@ -2032,41 +2035,52 @@ static int vcn_v4_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+					       enum amd_powergating_state state,
+					       int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_stop(adev, i);
-		else
-			ret |= vcn_v4_0_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_stop(adev, i);
+	else
+		ret = vcn_v4_0_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		ret |= vcn_v4_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 8343cee899c71..8396ef6831b69 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -87,8 +87,11 @@ static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0_3[] = {
 static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_3_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_3_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_3_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -351,11 +354,12 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
 
-	if (adev->vcn.cur_state != AMD_PG_STATE_GATE)
-		vcn_v4_0_3_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+		if (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE)
+			vcn_v4_0_3_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
+	}
 
 	return 0;
 }
@@ -1646,41 +1650,52 @@ static int vcn_v4_0_3_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
-/**
- * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
+static int vcn_v4_0_3_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
+	int ret = 0;
 
 	/* for SRIOV, guest should not control VCN Power-gating
 	 * MMSCH FW should control Power-gating and clock-gating
 	 * guest should avoid touching CGC and PG
 	 */
 	if (amdgpu_sriov_vf(adev)) {
-		adev->vcn.cur_state = AMD_PG_STATE_UNGATE;
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_UNGATE;
 		return 0;
 	}
 
-	if (state == adev->vcn.cur_state)
+	if (state == adev->vcn.inst[i].cur_state)
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_3_stop(adev, i);
-		else
-			ret |= vcn_v4_0_3_start(adev, i);
-	}
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_3_stop(adev, i);
+	else
+		ret = vcn_v4_0_3_start(adev, i);
 
 	if (!ret)
-		adev->vcn.cur_state = state;
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
+/**
+ * vcn_v4_0_3_set_powergating_state - set VCN block powergating state
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ * @state: power gating state
+ *
+ * Set VCN block powergating state
+ */
+static int vcn_v4_0_3_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					    enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0, i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v4_0_3_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index e784f1457ee0a..f6b347fcdb7ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -95,8 +95,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v4_0_5_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v4_0_5_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v4_0_5_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v4_0_5_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -308,9 +311,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v4_0_5_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v4_0_5_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1517,6 +1520,27 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v4_0_5_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v4_0_5_stop(adev, i);
+	else
+		ret = vcn_v4_0_5_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v4_0_5_set_powergating_state - set VCN block powergating state
  *
@@ -1526,23 +1550,13 @@ static int vcn_v4_0_5_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v4_0_5_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v4_0_5_stop(adev, i);
-		else
-			ret |= vcn_v4_0_5_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v4_0_5_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 03c7252e28ba9..c5d59edf3a482 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -78,8 +78,11 @@ static int amdgpu_ih_clientid_vcns[] = {
 
 static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_device *adev,
 		int inst_idx, struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -288,9 +291,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
-				(adev->vcn.cur_state != AMD_PG_STATE_GATE &&
-				RREG32_SOC15(VCN, i, regUVD_STATUS))) {
-				vcn_v5_0_0_set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+			    (adev->vcn.inst[i].cur_state != AMD_PG_STATE_GATE &&
+			     RREG32_SOC15(VCN, i, regUVD_STATUS))) {
+				vcn_v5_0_0_set_powergating_state_inst(ip_block, AMD_PG_STATE_GATE, i);
 			}
 		}
 	}
@@ -1260,6 +1263,27 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v5_0_0_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_0_stop(adev, i);
+	else
+		ret = vcn_v5_0_0_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
  *
@@ -1269,23 +1293,13 @@ static int vcn_v5_0_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
  * Set VCN block powergating state
  */
 static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state)
+					    enum amd_powergating_state state)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret |= vcn_v5_0_0_stop(adev, i);
-		else
-			ret |= vcn_v5_0_0_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v5_0_0_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 5950ec4c7f6db..51a2d70a65c9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -40,8 +40,11 @@
 
 static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
+static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i);
 static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
-		enum amd_powergating_state state);
+					    enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -994,6 +997,27 @@ static int vcn_v5_0_1_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 	return 0;
 }
 
+static int vcn_v5_0_1_set_powergating_state_inst(struct amdgpu_ip_block *ip_block,
+						 enum amd_powergating_state state,
+						 int i)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int ret = 0;
+
+	if (state == adev->vcn.inst[i].cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = vcn_v5_0_1_stop(adev, i);
+	else
+		ret = vcn_v5_0_1_start(adev, i);
+
+	if (!ret)
+		adev->vcn.inst[i].cur_state = state;
+
+	return ret;
+}
+
 /**
  * vcn_v5_0_1_set_powergating_state - set VCN block powergating state
  *
@@ -1008,18 +1032,8 @@ static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0, i;
 
-	if (state == adev->vcn.cur_state)
-		return 0;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		if (state == AMD_PG_STATE_GATE)
-			ret = vcn_v5_0_1_stop(adev, i);
-		else
-			ret = vcn_v5_0_1_start(adev, i);
-	}
-
-	if (!ret)
-		adev->vcn.cur_state = state;
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i)
+		vcn_v5_0_1_set_powergating_state_inst(ip_block, state, i);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 51c2a7f4aba28..e8cf4aa6c43dd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2037,15 +2037,15 @@ static int smu_hw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
 		return 0;
 
-	for (i = 0; i < adev->vcn.num_vcn_inst; i++)
+	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		smu_dpm_set_vcn_enable(smu, false, i);
+		adev->vcn.inst[i].cur_state = AMD_PG_STATE_GATE;
+	}
 	smu_dpm_set_jpeg_enable(smu, false);
+	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
 	smu_dpm_set_vpe_enable(smu, false);
 	smu_dpm_set_umsch_mm_enable(smu, false);
 
-	adev->vcn.cur_state = AMD_PG_STATE_GATE;
-	adev->jpeg.cur_state = AMD_PG_STATE_GATE;
-
 	if (!smu->pm_enabled)
 		return 0;
 
-- 
2.48.1

