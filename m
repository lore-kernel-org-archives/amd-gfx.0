Return-Path: <SRS0=5bFg=L7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6E0C07E95
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 08:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D70861C73
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jul 2021 08:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D70861C73
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDB06E83E;
	Wed,  7 Jul 2021 08:11:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC7A6E83E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jul 2021 08:11:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOh+o/WeNFMFy0uCnm2qNrr095d16/jpC3VrfhF/o/twKVSvi5JuOkphrZXNaksjn1f2G+Xmt4oypLEH9w0cIChym2WtVz+BR1CcigWb8XZvfw092w66C25e+S9jpIE/zlWgZ+nMhIA5lkHZ4NazTLGH1Yi5aUPuE7j0hNWuC4mAE9CLo1SuDCTLqvKZD8VQIGpl3lk8I4eFGqVMp45x1TDHBl4h19sDhuf8/458jBd4W8VRudA967/UbQo0h06zwdma+S+Hf0jdLeXdq8XUMXHKGZUIVyNk8XM0LPgAAOY35VhUP0mtrT3FbxjBQOrh5jxRl1aVjXwA4pvz4zT6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGcj1+jgvm+3uzvzMTe3fb50P3502csPgQ5G4eGAmro=;
 b=NrV39sUJkP1fRQZQMGBdFWxRngLOURjR/bfGHorrDupiy6JOPw+vYxxgqDkcLWYOi/uTl0BaPRx9jff5jP3uzrNCYyxRm6WTgfinx25GOnVFBBtd9zsXH/Erz4rXa21aiwEYvJ24kz6+ESmN7c52G6dAMkWHczNEOCvaXb+GNVVPmGnm46uN3pbzQ7EaghTXi+ZTesBcL6R5RNGbxcMUBrMWfiUUxDhCKd0Big+qKBtohu/kAOc62rz2uDk6XA8V1BSL4ThueCxQ94F4coRWUK2v8G0M8DZihRiH1/9Dv4g0fQSJMQXiV7El87GwFMhUbGoc7RXczWvvarU1QVP8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGcj1+jgvm+3uzvzMTe3fb50P3502csPgQ5G4eGAmro=;
 b=fDl+pywACKZ48gNJ/2QWU6hxAoqg27aAMSYzJriilEa6PWWfGz+2NK7uB2KA2p3kuL5khAEYB0AEud2X3rwuEHVcX2iMA116hjMHIqzanFMSv1F9nbAP4BBAkJIZ/Qn18DO03PJJO1+KilqpJqodc+j9pApSQ5p8IZdOzr1KBv0=
Received: from DM6PR11CA0008.namprd11.prod.outlook.com (2603:10b6:5:190::21)
 by CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Wed, 7 Jul
 2021 08:10:58 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::83) by DM6PR11CA0008.outlook.office365.com
 (2603:10b6:5:190::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend
 Transport; Wed, 7 Jul 2021 08:10:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 08:10:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 03:10:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 7 Jul 2021
 03:10:57 -0500
Received: from Roy7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Wed, 7 Jul 2021 03:10:56 -0500
From: Roy Sun <Roy.Sun@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: change the imprecise function name
Date: Wed, 7 Jul 2021 16:10:49 +0800
Message-ID: <20210707081049.38365-1-Roy.Sun@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d2ea7cb-9072-447a-b030-08d9411ec05c
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5284702733539BAB623C1192FF1A9@CH0PR12MB5284.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 91QONYY/Cqh1v+VxOioYDYRi4zm/P1PL1DHbVSsiKSWiMx0Xwnyc7MjRr1pqiEal31H7RbZ69wsp6n0G4bxy/3fKG5uzVhE7fd4g67I0YQmeYsOww0HFvRUdGke9wC+acBeH3jo5vY5E5uZ7TNROdVWoBMsDw4YrLBddjKUXfh31Vctdi5F7PK8ZPvxXJf9qtNy3iUFQsey/BLmJ8Z8i/A6xDND/hbXD3IB/Nn2TDnxpR3fop6BcShmj1nbRd4GcKrx79G73fP18CfnNPksVn+F76cpiI0Z4ENmGq3Z8twQJWZk9awiwMdkQBwuorHLAHbChBF8hM7dBy5m5WnusQdGYvv7UPDWRz2th2JAtQ6MTC/6fAcEK1COzVOiyTeqSU3MHmWmwJUm/WZt5HOINuAha2/nXfZLnOrU8DZGUkPSvOJBGtsU/JK5sgj/mPQrvyiBn7h5Cc1U0jQHvAqTK3zDjVjgl1vcTvcb/BSZ66xpxNzR5wzaxYXjGTAaFQukXeDLMyWu00VSTBfzzq5pUtEZf6+3zQ3qXGmvfvx8zjE04XawWYT/hO933FpnDyRkK50gx1IlUhXJ/bAepXZTIQbYu5NRA0/tuosrdqh1le9s03uOpdYFtc6zu6Ps2mPIgUQ4CJptreEk8PscrxOyMsCVFld+Chu7knnS/ksAbMq2HxiocndXyFIBnXKjcE5flzF0wpvGONXfPbSn+3tIBcpgubp0WQf4bnu+Jyw1pleE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(136003)(36840700001)(46966006)(6666004)(47076005)(478600001)(81166007)(26005)(2906002)(82740400003)(1076003)(2616005)(186003)(356005)(36756003)(36860700001)(83380400001)(316002)(6916009)(70206006)(8936002)(5660300002)(4326008)(70586007)(82310400003)(8676002)(7696005)(336012)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 08:10:58.0680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d2ea7cb-9072-447a-b030-08d9411ec05c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
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
Cc: Roy Sun <Roy.Sun@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The callback functions are used for SRIOV read/write instead
of just for rlcg read/write

Signed-off-by: Roy Sun <Roy.Sun@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15_common.h  | 8 ++++----
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eb1f3f42e00b..aa94ad0e9973 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -508,7 +508,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
 	    adev->gfx.rlc.funcs &&
 	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
-			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v, 0, 0);
+			return adev->gfx.rlc.funcs->sriov_wreg(adev, reg, v, 0, 0);
 	} else {
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 7a4775ab6804..00afd0dcae86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -127,8 +127,8 @@ struct amdgpu_rlc_funcs {
 	void (*reset)(struct amdgpu_device *adev);
 	void (*start)(struct amdgpu_device *adev);
 	void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
-	void (*rlcg_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
-	u32 (*rlcg_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
+	void (*sriov_wreg)(struct amdgpu_device *adev, u32 offset, u32 v, u32 acc_flags, u32 hwip);
+	u32 (*sriov_rreg)(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip);
 	bool (*is_rlcg_access_range)(struct amdgpu_device *adev, uint32_t reg);
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 705fa3027199..bc4347a72301 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1542,7 +1542,7 @@ static u32 gfx_v10_rlcg_rw(struct amdgpu_device *adev, u32 offset, u32 v, uint32
 	return ret;
 }
 
-static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 acc_flags, u32 hwip)
+static void gfx_v10_sriov_wreg(struct amdgpu_device *adev, u32 offset, u32 value, u32 acc_flags, u32 hwip)
 {
 	u32 rlcg_flag;
 
@@ -1558,7 +1558,7 @@ static void gfx_v10_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 value,
 		WREG32(offset, value);
 }
 
-static u32 gfx_v10_rlcg_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
+static u32 gfx_v10_sriov_rreg(struct amdgpu_device *adev, u32 offset, u32 acc_flags, u32 hwip)
 {
 	u32 rlcg_flag;
 
@@ -8269,8 +8269,8 @@ static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs_sriov = {
 	.reset = gfx_v10_0_rlc_reset,
 	.start = gfx_v10_0_rlc_start,
 	.update_spm_vmid = gfx_v10_0_update_spm_vmid,
-	.rlcg_wreg = gfx_v10_rlcg_wreg,
-	.rlcg_rreg = gfx_v10_rlcg_rreg,
+	.sriov_wreg = gfx_v10_sriov_wreg,
+	.sriov_rreg = gfx_v10_sriov_rreg,
 	.is_rlcg_access_range = gfx_v10_0_is_rlcg_access_range,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 044076ec1d03..03acc777adf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -787,7 +787,7 @@ static void gfx_v9_0_rlcg_w(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 
 }
 
-static void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset,
+static void gfx_v9_0_sriov_wreg(struct amdgpu_device *adev, u32 offset,
 			       u32 v, u32 acc_flags, u32 hwip)
 {
 	if ((acc_flags & AMDGPU_REGS_RLC) &&
@@ -5131,7 +5131,7 @@ static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs = {
 	.reset = gfx_v9_0_rlc_reset,
 	.start = gfx_v9_0_rlc_start,
 	.update_spm_vmid = gfx_v9_0_update_spm_vmid,
-	.rlcg_wreg = gfx_v9_0_rlcg_wreg,
+	.sriov_wreg = gfx_v9_0_sriov_wreg,
 	.is_rlcg_access_range = gfx_v9_0_is_rlcg_access_range,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index 0eeb5e073be8..8a9ca87d8663 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -28,13 +28,13 @@
 #define SOC15_REG_OFFSET(ip, inst, reg)	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg)
 
 #define __WREG32_SOC15_RLC__(reg, value, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_wreg) ? \
-	 adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, value, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_wreg) ? \
+	 adev->gfx.rlc.funcs->sriov_wreg(adev, reg, value, flag, hwip) : \
 	 WREG32(reg, value))
 
 #define __RREG32_SOC15_RLC__(reg, flag, hwip) \
-	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->rlcg_rreg) ? \
-	 adev->gfx.rlc.funcs->rlcg_rreg(adev, reg, flag, hwip) : \
+	((amdgpu_sriov_vf(adev) && adev->gfx.rlc.funcs && adev->gfx.rlc.funcs->sriov_rreg) ? \
+	 adev->gfx.rlc.funcs->sriov_rreg(adev, reg, flag, hwip) : \
 	 RREG32(reg))
 
 #define WREG32_FIELD15(ip, idx, reg, field, val)	\
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
