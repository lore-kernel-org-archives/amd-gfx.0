Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D59C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 06:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2BB611CB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 06:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7F2BB611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F6C6E434;
	Thu,  4 Nov 2021 06:20:11 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AE06E434
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 06:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0FB3DgthCvZoMsGHwT+YkuGSreJPx0UkfzeCmLUm9vDVPfyVLnX8AsuGLE7ByBMUvAzMo4PetodRkzaq1fk1jnnXm1Sn82bJF1vQjPW9RvSHZvQutg6w/b2r8P2wM3UFTUF/V20rsgyeLCexOHa72qE4p3LNo57bO84fpvvWeS5O8CkfApsnM2Lkm5dugoOzQ3PukXCK2PTocRtNlGlNhp2vOjAD7Nr03ty8tdZvP0lAuMo54ljRe+3eYyJLrFxl4/TE/QbV0D5qIdX8FAQaviHFlOypps/ITBhVAZTAg05l+uaVm4tE+TwaoemNc19SkosUIhUPKNUfTiFlz/HJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yifDc0ms9vZyFCpxoEl8OQXpXcTW7ahQ1ISTSqdaHw0=;
 b=Eq+RpTzZEJWQYpx3f3DHnLTsisZpYxjM+Udjs/DqF7FUUTwpuxFVadAzQDzhKWmYDWBHj66NtEjqfMY5whgmWHCtNoLVhGU36uDY0Kwqe8aNOzQWOjAZQ6jt9aTbASccOV8OdbMhm2rwqWpOvaGXDwPY8nr3q1tWqwwWSM1HSY1FOphhbWcC04CPImfdBBjwlPmSwzscp8tRGJfC31QnOxFjqig2ZJ/tOwNCiiIVKQHHknt6Vh3QKLh+v6Bdh5kgJdcKDyW6ekECurLa1b/5Cce3D30AV/2cpBQNI/tefe8BV+DSKK2aUI3/7U/MrpeqAVRwQXXwKuYoMu9W9nBdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yifDc0ms9vZyFCpxoEl8OQXpXcTW7ahQ1ISTSqdaHw0=;
 b=vRbhNjkvgT/dRjixxyLJ5dlckodXcZZHjqavXc2UuaFSPQ7bBAnlqe/1XJzKmcgIhK1lCc4n4E51EBpotzj5Q0TkXkT8scoGik/Di23jxrmcN5xqDg3CkGYVzfWLOmO7sLg9WEPxYwYJ0Mo4b6cP9zYvLm1RzJnlJD7Tv8NSXwo=
Received: from DM5PR07CA0085.namprd07.prod.outlook.com (2603:10b6:4:ae::14) by
 CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.15; Thu, 4 Nov 2021 06:20:08 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::c3) by DM5PR07CA0085.outlook.office365.com
 (2603:10b6:4:ae::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 06:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:20:07 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 01:20:05 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: correctly toggle gfx on/off around RLC_SPM_*
 register access
Date: Thu, 4 Nov 2021 14:19:48 +0800
Message-ID: <20211104061948.111865-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f7aa2eb-9098-48df-c84e-08d99f5b25f0
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5284C49C5D28BCEFF4593864E48D9@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvauN7y6a/PilU1ot63uSsYQAaPseAgg8yysiXWthl/17upcXsTb76d7aHq3/moYWfgCKMuC0J/J984zvEStezQS0PeGiezYw15n6GaVzoJIY+Ok6Vvm0LtnrkZa3Hy5glGpya0Mw0BTRF7LPyyKKNfWrqL4sMZjYATe0OtZ1ySelgYVIpoGEnwH29ZLaAwtyfERCgGcd6S4nQW4nDHJJLg321Qyf95PXwD5ak4/6TwUiwEDtTeH2wuuE1rAV9iJPc8vDXYOW5b5cI2NxuPdrV52LrIro3pyS1e36rfTamGOtNzLsevkWXXyJc5zMYHLdY+lQdOv0WGT5oHQqhoMjKuU0EvPaWCDx6VYNNjxkvqzHGEG/wiWw8X+IpUmVIzJUCwIr7U/uDvI1tx2PfVQ+Qs3sKaPQvHixhgdWegHBLa739z8DaY61sFTyAZooxZkK3PyB7scDeJbtRO0cXqjy/o09K1dWchia+1wJ6uyIqcraeV7k97E4qvx/0pj+2DGYOtfAQZyXcvl8uH3k1c3zHG6XIf2Os7WGfitLi2Ie68oC38QsItgjBrz2gff2U399O4QniGaLI3Aym+ndwDR+3rVAhSRrEhEVTh9sqckqO9hNnE70fJqoa00/dU5p299RoRUKTouh9PLLEnuHqBWWYRylnyHpD9epH9qdLqsDHVnd1F6b7ZSxz4hEig711EM0QhpsaXvb1Vc05UFQVgjnaRudeqkuwRnWs9VJ10Y6sM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(186003)(66574015)(8936002)(16526019)(2906002)(1076003)(54906003)(6666004)(44832011)(8676002)(36756003)(83380400001)(7696005)(508600001)(70586007)(26005)(82310400003)(36860700001)(86362001)(316002)(426003)(70206006)(4326008)(2616005)(81166007)(336012)(356005)(5660300002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:20:07.6193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f7aa2eb-9098-48df-c84e-08d99f5b25f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5284
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

As part of the ib padding process, accessing the RLC_SPM_* register may
trigger gfx hang. Since gfxoff may be already kicked during the whole period.
To address that, we manually toggle gfx on/off around the RLC_SPM_*
register access.

This can resolve the gfx hang issue observed on running Talos with RDP launched
in parallel.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: Ifae152e8151fecd25a238ebe87dffb3b17cdb540
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 4 ++++
 4 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index fa03db34aec4..10fc9197602e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8388,6 +8388,9 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 reg, data;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	/* not for *_SOC15 */
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
@@ -8402,6 +8405,8 @@ static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static bool gfx_v10_0_check_rlcg_range(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 37b4a3db6360..d17a6f399347 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -3575,12 +3575,16 @@ static void gfx_v7_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 data;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	data = RREG32(mmRLC_SPM_VMID);
 
 	data &= ~RLC_SPM_VMID__RLC_SPM_VMID_MASK;
 	data |= (vmid & RLC_SPM_VMID__RLC_SPM_VMID_MASK) << RLC_SPM_VMID__RLC_SPM_VMID__SHIFT;
 
 	WREG32(mmRLC_SPM_VMID, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static void gfx_v7_0_enable_cgcg(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index aefae5b1ff7b..1a476de20d08 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5727,6 +5727,8 @@ static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 data;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(mmRLC_SPM_VMID);
 	else
@@ -5739,6 +5741,8 @@ static void gfx_v8_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 		WREG32_NO_KIQ(mmRLC_SPM_VMID, data);
 	else
 		WREG32(mmRLC_SPM_VMID, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static const struct amdgpu_rlc_funcs iceland_rlc_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 08e91e7245df..d9367747fed3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5218,6 +5218,8 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 {
 	u32 reg, data;
 
+	amdgpu_gfx_off_ctrl(adev, false);
+
 	reg = SOC15_REG_OFFSET(GC, 0, mmRLC_SPM_MC_CNTL);
 	if (amdgpu_sriov_is_pp_one_vf(adev))
 		data = RREG32_NO_KIQ(reg);
@@ -5231,6 +5233,8 @@ static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, unsigned vmid)
 		WREG32_SOC15_NO_KIQ(GC, 0, mmRLC_SPM_MC_CNTL, data);
 	else
 		WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data);
+
+	amdgpu_gfx_off_ctrl(adev, true);
 }
 
 static bool gfx_v9_0_check_rlcg_range(struct amdgpu_device *adev,
-- 
2.29.0

