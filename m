Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FFC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 08:41:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A15310E29D;
	Tue,  1 Nov 2022 08:41:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF8B10E29D
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 08:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eElMU+dJIB5kSIZsAq7mZazcubCd5c0MefjeqiA0ai9CYOPnkjWjP5+e68cQni9+JwapiOkH/wdxmG/zgUdB2cjA5nVAr8I0iGfZf3XDldLycg4EcKezLLVeceNCsjTWlHE26exBrr8yejWoHZbLsin5t3ucqSetKIGkA7lzJa6DpvETB+YCdNrogHbOmbIO+Q04THEpM6zHz867Yys0Gvgp/19tCoCyXdXo46cEv5gtj6Ds/UekK/5BnQz/pE5fAi65OJqxMZCm8kfLNHWNRF0QinxUO2RWfdruOWeebqk5EJyasuKcMhQTl6AczYCGe2m7PdU1ruMcvCsE2I4Xlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bv4RK38ahRCG5rWo3V1xCiTJGDhvx38kibqB1qJ2mBY=;
 b=LMolx1oFltwUOJ926G7cF23GTDXJji5QeGJJEm5+YmmDS67PJmkcr0ni9/zuaOghfLNXdMfT7D791KF7krKVpKrq7M84oLPiXJk3CHYsrXY4RzUIVFJnqgwHRPouEhIraWK7QGkY4YeEobYK8z2BKZAhph9ZZcjdPMF5jSZtVrcfipuHcJLiPK9JvovNEkuCfWf+PhlvQIqyqryjSHaAInNazts6Ukh3yXR+5fE0WBkUW6v+v7meKIASCaVBuPxrmm3NfX70in1tDRgRTfLR7w2rlLnNbWHg2PsjQCI498GVWGJxfSw8506zF46eLju53MSN4e95cKH8VCEps1WmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bv4RK38ahRCG5rWo3V1xCiTJGDhvx38kibqB1qJ2mBY=;
 b=A2F38pYzqL1L8cmyegPxwE1bBXO8kLez1xIv7K8eDtADJKAPHlA/CCcyU71ZFnmC9NPD8WSCVlotBhGrpmEeaKtUOdkhPoZiHluE+NhLHrZcjbRauXgIInICXHp2aSEye/Lp31uKYQ/d66n338qX9GVS/PEVLwc2iM7mQmesq9w=
Received: from DM6PR08CA0066.namprd08.prod.outlook.com (2603:10b6:5:1e0::40)
 by BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Tue, 1 Nov
 2022 08:41:02 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::69) by DM6PR08CA0066.outlook.office365.com
 (2603:10b6:5:1e0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21 via Frontend
 Transport; Tue, 1 Nov 2022 08:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 08:41:02 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 03:41:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 1 Nov
 2022 03:40:36 -0500
Received: from yiqinyao-Pro-E800-G4-WS950T.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Tue, 1 Nov 2022 03:40:34 -0500
From: Yiqing Yao <yiqing.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Disable MCBP from soc21 for SRIOV
Date: Tue, 1 Nov 2022 16:40:01 +0800
Message-ID: <20221101084001.707650-2-yiqing.yao@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221101084001.707650-1-yiqing.yao@amd.com>
References: <20221101084001.707650-1-yiqing.yao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|BY5PR12MB4291:EE_
X-MS-Office365-Filtering-Correlation-Id: 56f916f0-216f-4789-ded7-08dabbe4ceb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: onv9QivFKc1qBI7d7mZo/IrMSTlUI/z7SzWnAo+T2VoiuTbfdcMn1PUG+sDDGjeHxunjR1uzQoMLOD43cJN9/Ke1uyg8Imyhng48o5ehWX6pxmaZj2HHmFanULagr4s5JUkKqxbeLOKHg26h6fp1HWVqNFLqos4/DBHHN76B/1ALlYkEe42MkhBnILfz0DVUzm/2U0jI14+Bzk6YzzztMIHlTKfKVwHr/AY7g8mQg03I0BKTH4Wqlnd0mHc6rz31CtuKYj5P26z5tNls6WebJRXy6Yh+glhPOKZLAdSMTcovviotz2BecrcTLSPjJSQUhDwcWMk1HhhzyhWiaI2Y+aw8AMy73W10lnyuaBqGK4AdCckjk8/boqC9DkIiIz9/wS5uSlsSweP5Dssz5lZaA5ECUqITB2dy3KlcmuCID2e6U6xeZBLrT25ExSyHQa8bIIwLQ0cwzd6+c1SVILtV8HaIInimNFzcPe3iiEk6ioKZXdZP1bLHRgBDzrxFXLUUTtocaUwTZJEaO9uWpClYGIZk+E6Lb6TZ0AoT+ysMScpoEPzUG+grQYsBtPB4Yh0ytah/0nlNKcYEbwZBRty/zSWasSrDx4SZBDLAbST8+wt7ZvpWv2BDSHS4mJP2FjMpWWMSH5BS3UeY7KeueDc/7dUg4Ac8+f6LTy23/6t2poYIezgUr79oxJDrb6sF7CI/8PvLrqb4a9V0iqFvsxhA8esGN4qjBuaC1TdIfo5cJoQkZFon415RLj2NDk7Kccp4RIIy6S9k0tpt7JGzPTaCClVCLvrgSAbotsCESTBeRqI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(47076005)(426003)(83380400001)(36756003)(82310400005)(40480700001)(40460700003)(86362001)(36860700001)(6666004)(81166007)(356005)(82740400003)(316002)(54906003)(6916009)(478600001)(5660300002)(8936002)(41300700001)(26005)(336012)(2906002)(1076003)(4326008)(2616005)(44832011)(7696005)(70206006)(70586007)(8676002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 08:41:02.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f916f0-216f-4789-ded7-08dabbe4ceb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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
Cc: alexander.deucher@amd.com, horace.chen@amd.com,
 Yiqing Yao <yiqing.yao@amd.com>, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Start from soc21, CP does not support MCBP, so disable it.

[how]
Used amgpu_mcbp flag alone instead of checking if is in SRIOV to
enable/disable MCBP.
Only set flag to enable on asic_type prior to soc21 in SRIOV.

Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 2 +-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ae10acede495..522820eeaa59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2397,7 +2397,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
 			adev->ip_blocks[i].status.hw = true;
 
 			/* right after GMC hw init, we create CSA */
-			if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+			if (amdgpu_mcbp) {
 				r = amdgpu_allocate_static_csa(adev, &adev->virt.csa_obj,
 								AMDGPU_GEM_DOMAIN_VRAM,
 								AMDGPU_CSA_SIZE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 363946de78f1..c9595cf1dd0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -796,7 +796,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		dev_info->ids_flags = 0;
 		if (adev->flags & AMD_IS_APU)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
-		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
+		if (amdgpu_mcbp)
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
 		if (amdgpu_is_tmz(adev))
 			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
@@ -1172,7 +1172,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto error_vm;
 	}
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+	if (amdgpu_mcbp) {
 		uint64_t csa_addr = amdgpu_csa_vaddr(adev) & AMDGPU_GMC_HOLE_MASK;
 
 		r = amdgpu_map_static_csa(adev, &fpriv->vm, adev->virt.csa_obj,
@@ -1236,7 +1236,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 	if (amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE) != NULL)
 		amdgpu_vce_free_handles(adev, file_priv);
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
+	if (amdgpu_mcbp) {
 		/* TODO: how to handle reserve failure */
 		BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
 		amdgpu_vm_bo_del(adev, fpriv->csa_va);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index c73abe54d974..dc032c44e924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -64,6 +64,10 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
 	ddev->driver_features &= ~DRIVER_ATOMIC;
 	adev->cg_flags = 0;
 	adev->pg_flags = 0;
+
+	/* enable mcbp for sriov asic_type before soc21 */
+	amdgpu_mcbp = (adev->asic_type < CHIP_IP_DISCOVERY) ? 1 : 0;
+
 }
 
 void amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index af94ac580d3e..ff3c127cf70d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8489,7 +8489,7 @@ static void gfx_v10_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
@@ -8664,7 +8664,7 @@ static void gfx_v10_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
 {
 	uint32_t dw2 = 0;
 
-	if (amdgpu_mcbp || amdgpu_sriov_vf(ring->adev))
+	if (amdgpu_mcbp)
 		gfx_v10_0_ring_emit_ce_meta(ring,
 				    (!amdgpu_sriov_vf(ring->adev) && flags & AMDGPU_IB_PREEMPTED) ? true : false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f68e13b6282c..84a76c36d9a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5326,7 +5326,7 @@ static void gfx_v11_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
 
 	control |= ib->length_dw | (vmid << 24);
 
-	if ((amdgpu_sriov_vf(ring->adev) || amdgpu_mcbp) && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
+	if (amdgpu_mcbp && (ib->flags & AMDGPU_IB_FLAG_PREEMPT)) {
 		control |= INDIRECT_BUFFER_PRE_ENB(1);
 
 		if (flags & AMDGPU_IB_PREEMPTED)
-- 
2.34.1

