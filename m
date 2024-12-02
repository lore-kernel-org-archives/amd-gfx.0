Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207C5D78333
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 16:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFAD310E2C0;
	Mon,  2 Dec 2024 16:52:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oL/CR06d";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F093910E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 16:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjdOYMFp2gJY/pkL+FMOI6wpOrdgNMnsYd6mJAZ2IDNaZ6jDXd7oNwauYsCS7i2it6KRNkvXFedVioLOpKRh7kptcJDyqZgZ/n5EmBclepIi3Y23+QMU32GEzXlfX15VTxkxLDUP5G2mY/K+S65UnXdHXczW0abMGdm6pZOnT0uomQfyfFlkWLn3lfkLP9IM+f5JREaJ97XbczMyodSq4+ne26qezFSFCdZaa9SGzPSqQ2qztr4Q8nDnzc8xukIGFfyqTIRHmSrde0TOkdl19p/20C8bD3esuBkF7PDe33BZ1HLDT/4E8ZsJGJgPrZLLviGU+sYMeKJpbx/hAsszkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjCw4InxfC6gaTHoXw+t5tJkEkcpCS64DLvgiH3ys6U=;
 b=GFJw27smnbNOAHbs700C2Snp3Cvxowujktuuh0OP0UCeVhigKs+Ma18/WXp4XmcEnwuyv3wD8pjqxUNN4VT4qFOU31d7PI8Mg1aCaD0W+BwIUPOmG56rhmp4HfSy2owUAwTXNPxolcT/GT/5a5A9O2L361zxBqXluAKo/iRa9GNKsSuRpBSaOk2q13mGHeuYdhBd2LlYLrwkg1mZ2jkMF/Ydqj6rFUmzKH7hv0Jt540/5eRZPuLVKV+KnGGKtLEOtxRf0DtMN/JbKr9I1ZWYRAsFMpxR+e1fpthOorzDt0khWH1Ew2z3ahy/dzL8iwbH9GUPcDG8zC06C9BEnx7ucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjCw4InxfC6gaTHoXw+t5tJkEkcpCS64DLvgiH3ys6U=;
 b=oL/CR06dRpBoRvwy7knvYBQ8Afp5tpAjkKx3pYy1xRddP+DpGTu1W8gzxVW8Sig34R/COAm5ozAt+zbBQxOv2LiBdKN7P2sqTU4OZibyFROj8zsYnnZ7xQpGwbGIk7OjZGJbtCYCfXRLzCWALAQGJb6ANtdywuabPvubskYi8/w=
Received: from BN9PR03CA0708.namprd03.prod.outlook.com (2603:10b6:408:ef::23)
 by DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Mon, 2 Dec
 2024 16:52:55 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:ef:cafe::d9) by BN9PR03CA0708.outlook.office365.com
 (2603:10b6:408:ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Mon,
 2 Dec 2024 16:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 16:52:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 10:52:54 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: rework resume handling for display (v2)
Date: Mon, 2 Dec 2024 11:52:37 -0500
Message-ID: <20241202165237.971604-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM6PR12MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2d520c-57ef-4065-f843-08dd12f1c4c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1rpV1p5bLL0cBq+MlYuq7l/N2z/G1KfhEjPZHDv3XQE2yrUzAxA6FmXhjOqt?=
 =?us-ascii?Q?ETZMjG8Y+r1U4E7OHoX98a75lC3oMgMOHSexxZNYmWeQHT5mpOyssLO/7N1u?=
 =?us-ascii?Q?+TadmD6ITGYLzr1bDzbaHeWkFi2NdSSY+0KH91QKTS6f4tZ85eFcMCJmzGd+?=
 =?us-ascii?Q?FLQE+DPBUQrtzA542PB5IZ1zSSbKPm2JIDUpakWUldtI27x0rfgu65lShqKL?=
 =?us-ascii?Q?IjuTDSaW2/8G3jM0IAl5OTSkVZZnJf75Ht4UUt893YaaEsT65NElhTs++OEs?=
 =?us-ascii?Q?legEpj6Mf/XF7bghImTOO94uyyzEdSJxLDJRe3WzqACq85oYwAyvgozD9uil?=
 =?us-ascii?Q?drhfT9MMNH6OeAReptuPKrA6fRe+f/jqzhWYT5LtfLFFxQV5Jcf99ROrnkEh?=
 =?us-ascii?Q?/F1B9novebr4n8YdQ5bDW0t9OMmmLpuzwlKdVTp+PxXFqWOBgMFV6sWAe0WV?=
 =?us-ascii?Q?V4zBNfpcrRvSpdEIedVre0FhLavNKfNh5GAChPiWUPlZvAhigVjYacJR9U0D?=
 =?us-ascii?Q?f70Kb1Nn9DFypwT1gdAVaIABSPwpFSWC4MN0MX+EajGbAZ5gjTsO1hk951gD?=
 =?us-ascii?Q?JxiUJEH2/tMzjsBC/TivKPlo+ZOrM+ES7YJNxLZatDm5sfOsxlnjDt1GZ9Z7?=
 =?us-ascii?Q?MKedqQAxFSqMuLb5Wfq3Vx+ZvYnBTDM9DG9Wh8wP4MixROL4Xfmb1weFxflc?=
 =?us-ascii?Q?etAv8vtb21qvynyM5DEy8t7alpiZzUP6wjZJJ6U0+ScWkflcmzZjPUeXKSAT?=
 =?us-ascii?Q?18KYzvc8HQa72faxTNa9Hp/ZXAzzcgl+lusIDuUlJynH9Ogf8dpwZssy5IPE?=
 =?us-ascii?Q?akyozYtCJz7YSA1xgyzhc1je0VGXVPs3hhWi4/m2sF9VGqnCoApabSuW/WPz?=
 =?us-ascii?Q?V0LHZY5iiFRU2ewZHkHDbNo9M91WDjE07I1TISwNunS1Urr7ImYo4dkmIp8E?=
 =?us-ascii?Q?nw8WG3dg+JNDdLFMqe2KBFL/ScjHKUNwZKVFWnAWexY4mEbeVcFw7PTO+SCV?=
 =?us-ascii?Q?jAOn1Ci0VhQ+dJ+rC/fyFXQpkMMv4PCDutH3oEINmbmCnd588RxJdsvCdMJi?=
 =?us-ascii?Q?aospwWSYK2F9lLtqk2v2bH/upYBoK1xuMMEbnQuPslmMCCXzKNS3rwKNUkzD?=
 =?us-ascii?Q?5oWHz6jjw8V7/SxDKdPOBm9R7NL6EfPSZb6Zii8QQIZqAvNlkf4H+93uDWJv?=
 =?us-ascii?Q?s1yLd4bE7UwP4B/WSZ6cZrDlZavSBJ9DC0IZ7zDMC2T1eVD5Y94pT3uJQyZJ?=
 =?us-ascii?Q?r05CevN8FwOmHidZmDKgd6HN9Pcc0W6NoVkvmE7Lab3yMd9OeXfwfjzTG4md?=
 =?us-ascii?Q?Ne21A48ZIU/xQEyT6rBRheM63mBpy73fw/47xfFEs4y4qEp6k+IskOmIR56G?=
 =?us-ascii?Q?lN7darUNDIuBTJ7l7mjJKixI770IgxSOPhJ++3+R70ziksDIcflHa1/GR2f1?=
 =?us-ascii?Q?Lyb9HGt+lyYercoDGiItd+7kE0V29Idh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 16:52:55.3318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2d520c-57ef-4065-f843-08dd12f1c4c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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

Split resume into a 3rd step to handle displays when DCC is
enabled on DCN 4.0.1.  Move display after the buffer funcs
have been re-enabled so that the GPU will do the move and
properly set the DCC metadata for DCN.

v2: fix fence irq resume ordering

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 +++++++++++++++++++++-
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2a25e0742f8e7..d882d46de1416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3764,7 +3764,7 @@ static int amdgpu_device_ip_resume_phase1(struct amdgpu_device *adev)
  *
  * @adev: amdgpu_device pointer
  *
- * First resume function for hardware IPs.  The list of all the hardware
+ * Second resume function for hardware IPs.  The list of all the hardware
  * IPs that make up the asic is walked and the resume callbacks are run for
  * all blocks except COMMON, GMC, and IH.  resume puts the hardware into a
  * functional state after a suspend and updates the software state as
@@ -3782,6 +3782,7 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_GMC ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_IH ||
+		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE ||
 		    adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_PSP)
 			continue;
 		r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
@@ -3792,6 +3793,36 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * amdgpu_device_ip_resume_phase3 - run resume for hardware IPs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Third resume function for hardware IPs.  The list of all the hardware
+ * IPs that make up the asic is walked and the resume callbacks are run for
+ * all DCE.  resume puts the hardware into a functional state after a suspend
+ * and updates the software state as necessary.  This function is also used
+ * for restoring the GPU after a GPU reset.
+ *
+ * Returns 0 on success, negative error code on failure.
+ */
+static int amdgpu_device_ip_resume_phase3(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->num_ip_blocks; i++) {
+		if (!adev->ip_blocks[i].status.valid || adev->ip_blocks[i].status.hw)
+			continue;
+		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_DCE) {
+			r = amdgpu_ip_block_resume(&adev->ip_blocks[i]);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_device_ip_resume - run resume for hardware IPs
  *
@@ -3821,6 +3852,13 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
 	if (adev->mman.buffer_funcs_ring->sched.ready)
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 
+	if (r)
+		return r;
+
+	amdgpu_fence_driver_hw_init(adev);
+
+	r = amdgpu_device_ip_resume_phase3(adev);
+
 	return r;
 }
 
@@ -4909,7 +4947,6 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
 		dev_err(adev->dev, "amdgpu_device_ip_resume failed (%d).\n", r);
 		goto exit;
 	}
-	amdgpu_fence_driver_hw_init(adev);
 
 	if (!adev->in_s0ix) {
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
@@ -5489,6 +5526,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (tmp_adev->mman.buffer_funcs_ring->sched.ready)
 					amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
 
+				r = amdgpu_device_ip_resume_phase3(tmp_adev);
+				if (r)
+					goto out;
+
 				if (vram_lost)
 					amdgpu_device_fill_reset_magic(tmp_adev);
 
-- 
2.47.0

