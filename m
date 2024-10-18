Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF26CD3C54C
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 06:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545A210E350;
	Fri, 18 Oct 2024 06:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xs8Alt2O";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5486E10E350
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 06:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUescSaQ6nGvwxo+dQFao1C9JUvxM2gm5Zqj5tynueB+iNRpe6Q1Px4E/If7ZnHOF00UPHrsN2lF8FVkcIvrM7p65rfKJ1ZLawexIRTMPPCPym/MuDC4vslEIGbYDAtiJtVFGRNxvKEytWe1iIotAN0IJCwmz6lrMjOYzc8gNHoMvY+VUfiIhhrRBHpqGk0fAN4WP3nvpHqonOKM2B2Uy/p+yfPWfyNN+JT+lQfiS1vCcuPYJJGHH1+LOfFhZGi1YHrvTLfPPhum8wEZKcuUFblz57cwgxiPz7yqG7/Gs//4JTPguBNOBSpyI6rfjz75fukmtr0c9J0LmEZ2fq5V2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnPQd1I1k9aEhJPQ2x8AhNS9WcQvv87sI3pf39YsGMg=;
 b=BEDPHBBR3a6HIu2dIY0f2iEIe3pD0Ah9cOE46fL7dP8Ig4xrJWu5ep5aDhDqegaybXPzUy6ekqm6D4Iu8rknePL2n6jf+ZN/nQxmgiGMn7ksM7SsEIYrM1jTA64wJulG2/Txmz4Ayh35gCLZPJjFH0uYfjAhuxsL5buYn3Zp8cjMC6RrR/Mw67TsV+g/7vMUEvLIsijDOib++V6ym/aYwkwcJvp3bFS3GNAr8QFdEp2xSwUaYDAbq4kj3fQUcBZDMAHlvP8B/iSmscccdHmsl+/qZkxcRX7PR2mHPfvEvmJPYwZWFCeBBAo3p4CeWp79z/O19zVyVpQeG2PzDXgZIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnPQd1I1k9aEhJPQ2x8AhNS9WcQvv87sI3pf39YsGMg=;
 b=Xs8Alt2O2KsY2dCheEOtusgfvK/9LfiI0BUHX2AegcbnBP4bNrQSg31R316J4xQlxYVkUDBOJDk6DPbBaHeu3ne5K8rc3NthwBF0DdBWtvlws52Bec9ZhzAUmkql2Zc3Gv7KC2nUpKsd8er71ZCXYW9yWLKMOtTm2XbEHDC4aI8=
Received: from CH0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:610:119::34)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.32; Fri, 18 Oct
 2024 06:41:22 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::e) by CH0PR03CA0374.outlook.office365.com
 (2603:10b6:610:119::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20 via Frontend
 Transport; Fri, 18 Oct 2024 06:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Fri, 18 Oct 2024 06:41:22 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Oct
 2024 01:41:19 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <rajneesh.bhardwaj@amd.com>, <Ramesh.Errabolu@amd.com>, Hao Zhou
 <hao.zhou@amd.com>
Subject: [PATCH v2] drm/amdgpu: Save VCN shared memory with init reset
Date: Fri, 18 Oct 2024 12:11:03 +0530
Message-ID: <20241018064103.3087876-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: da1cb4fd-8464-4321-ed7b-08dcef3fe187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LOF2G4HAG3YagNKwvp4l8uWjkFeub+5teLDQMFieqZ5enfSoVMX+yuAdD8tE?=
 =?us-ascii?Q?JOtKAHBcKA0h4TuLMyxtiJb/AKvMj03UaIEccBT1yeAxVFdsz6W29RszYowu?=
 =?us-ascii?Q?nUBmOnYJ+vTq8tVZkh3y/A45m+2YnzhEm5AjcUFSU8TAqcBRuTOYdu1NNlhY?=
 =?us-ascii?Q?qTJwq5RiZKt5O/9NnKneEEMYcUrIomiApAVaS6tbFuP0Ab7HV5rHKzGHdAcp?=
 =?us-ascii?Q?iAgChFS5dRdujH0jfjwODVRutM09UfqISAD9+mJAqSZ5mPc2VIf8ASqSNRqo?=
 =?us-ascii?Q?aau+bbpt33AJAjpnEgzgEfL/bRN418zW3QaYNJla16/bsQYdLgfMNFJGPzVS?=
 =?us-ascii?Q?Rd4qRK8cAYefRHk8Wvf5u0Y9XEzl26PDbIo9WPGrASo0Ou2AYOMnRsnp4N3L?=
 =?us-ascii?Q?nD8iyefi7k2v79lSj2VUSMNYCwhDQMACCCmo2ifgSy9GnsJl+e+tQGLfxoR0?=
 =?us-ascii?Q?3OvW71pBQVrcR7QqJwRBiKhyT8TRRmSPh8StlLBonfNhZAIouteZhHJaLm3m?=
 =?us-ascii?Q?EY2NBATK0Gt7rlXM3/ZlszEBgEwJSza8SPhKCfTGovuw9QVgTmxzBm/PhpP0?=
 =?us-ascii?Q?4/85n3sOY2/uadupeQ1cEfN1vAWx4RrQcQToqrRFl16ftEfBIF60PyoZsZXM?=
 =?us-ascii?Q?PkVDAGlLzwZrP8u/4dICeIMRyHHGSepztggY3pTxsLsBBjBDOnTTJZGakYBA?=
 =?us-ascii?Q?ukDHWJONAkRkO6LJvMlEyTj5LZhpdZKI7AhB2Rqs48mnRVkRpBT0cUwaQg5e?=
 =?us-ascii?Q?Mb/4RbC3FU+qWeI1UyTDyv3g4oM/Jg0s3GKl0FpjWHXzWeXckmS5DvKI+NR8?=
 =?us-ascii?Q?YmW0HZKzRrf5suJHLIh4oRlG2jtN3svAV9Yt4BwbNBY86hlQ71KKWRdfFqVg?=
 =?us-ascii?Q?D0FvqHESgOEPIULIAAva8JJkesTSTw7P5Il04ZuQh7o3FbJVUMF3OGVVuFkt?=
 =?us-ascii?Q?8eidkqhQ5F0roppsvp1lV6qPLY5OGKr3aIsHLeQ2VZ6PI3VCXpTH9J9Wxsc/?=
 =?us-ascii?Q?/3AOdGDHBW01/Cn3AvRMYkFnXCNu7c/7Lb87Dg3mUa7va8BYkq+IML0Kylwp?=
 =?us-ascii?Q?DTmqRWLcDVThBN3bbzt3y40B+5gcox06niSw/KRKjXM+EqPQMpwv6e3qFami?=
 =?us-ascii?Q?c475GPzHEIN+LlE0rrdAgY8xaVWSi3mk3vtkPsAfqt/9ud3pGbVcEl4rj74R?=
 =?us-ascii?Q?gCaeKioOG/+FV/kSM5+t/K8Mhjfm1B6Jra7PnITefR2ico5nIZOjAooH1Ss2?=
 =?us-ascii?Q?c9TJJzl5D1GSKjhr+Si/XcQgwf/6m1sHdZWmqAVfHZUjGZOabWLdpbff6tPE?=
 =?us-ascii?Q?KuzqfX1KKfo2Wmb1duxs1xbd+p1bQrNojdJoNvK56445eAm8x9w0hLCojHpz?=
 =?us-ascii?Q?gnhuNlD6upAyaDKViPXVUFoCW4pxcIG/H7aPpMwruw2sXoQTQA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 06:41:22.4902 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1cb4fd-8464-4321-ed7b-08dcef3fe187
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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

VCN shared memory is in framebuffer and there are some flags initialized
during sw_init. Ideally, such programming should be during hw_init.

Make sure the flags are saved during reset on initialization since that
reset will affect frame buffer region. For clarity, separate it out to
another function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reported-by: Hao Zhou <hao.zhou@amd.com>

Fixes: 1b665567fd6d ("drm/amdgpu: Add reset on init handler for XGMI")
---
v2: Rename save function to a more appropriate amdgpu_vcn_save_vcpu_bo (Leo)

 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c   | 26 ++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h   |  1 +
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 3e2724590dbf..d15438ec81a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -49,6 +49,12 @@ static int amdgpu_reset_xgmi_reset_on_init_suspend(struct amdgpu_device *adev)
 		adev->ip_blocks[i].status.hw = false;
 	}
 
+	/* VCN FW shared region is in frambuffer, there are some flags
+	 * initialized in that region during sw_init. Make sure the region is
+	 * backed up.
+	 */
+	amdgpu_vcn_save_vcpu_bo(adev);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 43f44cc201cb..aecb78e0519f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -294,21 +294,12 @@ bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type t
 	return ret;
 }
 
-int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev)
 {
 	unsigned int size;
 	void *ptr;
 	int i, idx;
 
-	bool in_ras_intr = amdgpu_ras_intr_triggered();
-
-	cancel_delayed_work_sync(&adev->vcn.idle_work);
-
-	/* err_event_athub will corrupt VCPU buffer, so we need to
-	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
-	if (in_ras_intr)
-		return 0;
-
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
@@ -327,9 +318,24 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev)
 			drm_dev_exit(idx);
 		}
 	}
+
 	return 0;
 }
 
+int amdgpu_vcn_suspend(struct amdgpu_device *adev)
+{
+	bool in_ras_intr = amdgpu_ras_intr_triggered();
+
+	cancel_delayed_work_sync(&adev->vcn.idle_work);
+
+	/* err_event_athub will corrupt VCPU buffer, so we need to
+	 * restore fw data and clear buffer in amdgpu_vcn_resume() */
+	if (in_ras_intr)
+		return 0;
+
+	return amdgpu_vcn_save_vcpu_bo(adev);
+}
+
 int amdgpu_vcn_resume(struct amdgpu_device *adev)
 {
 	unsigned int size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 2a1f3dbb14d3..765b809d48a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -518,5 +518,6 @@ int amdgpu_vcn_ras_sw_init(struct amdgpu_device *adev);
 
 int amdgpu_vcn_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
+int amdgpu_vcn_save_vcpu_bo(struct amdgpu_device *adev);
 
 #endif
-- 
2.25.1

