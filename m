Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11E1C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A7AC10E1D5;
	Tue,  9 May 2023 22:14:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D76CE10E3E2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7RwTvDWfRG1/lccGbcOuBvm+mbslZd3BbJZ39TBLxxIOceJvVU/jiLv2XBgaDoVJakDNVqLLGyLzFCAB4fZflFSKc2EvF1hZ3LvB9l8cSzjyT22v0JCLwsm3qSGfi7Hr5DOOsjgUvoSyOwEzoVihn+/Gf53Zkoz5eSRm4xy+B6fu+xrsvrZzs1+bxeC+86b4Npt+DTqa72QcoZUk1u86KoXAMSJjPkNH91gorLq0EftL6pODf30glm8XTS88w45UhbrzCXXZy4y05DHTWXMG1sd8r7Ag/QYej++vcK4ddalR5i/hjPlCdoTz655bXLPmPbkE+xUF7b/OOuXLlqKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i0xplxHzCqsZ7MqQAgi+c5lFLDtV+bNg75sBPBKidU=;
 b=nBGZUNve1jYwEMoQZ0VpKPImJMwWIXGzY/0ogyxKUT3svcUff5ltLjAloH61/g344h8mzdVEYA3zxHHzb/Rmai2KxT3LkIor6F+n1nqO538silsfiPcZJ9ao8+JQSPvNKRBqFZ+BvriSE3r+I8crTFsKXQ6yiuKXIfaupFEeqEzR00SfYpl7/D1hccZZIG16eF2cLR38kH+qO50C31IW1vEjq10GV/lnxgOchZXERxI9r3RJJqeVQ2yj2VoW7YglriHx0epuPvB2SQAI6kVzy/bxrA2ebn937Sgqh4HLZpYXGXF199MsgG8uyvjxuiy+aMnhenaBKEAdwlcmvU0dzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8i0xplxHzCqsZ7MqQAgi+c5lFLDtV+bNg75sBPBKidU=;
 b=irdHSuthKoAIiQq2O03G69HSF9vz0ZGaWtCW680cRtcFGSX0fmJZkoqKKXb5qZUQ2nlym70P7En7n0CRiL+tsnxSni12aRxzZh/xMr6PcOusZ7fdD2L256PHgoBOm3flvLggw/zfaXRp4SHGDcWJ478XUonfGlx8r2ZjyQyxF6I=
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by IA1PR12MB6601.namprd12.prod.outlook.com (2603:10b6:208:3a3::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:14:24 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::3f) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.19 via Frontend Transport; Tue, 9 May 2023 22:14:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:14:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/14] drm/amdgpu: Get supported memory partition modes
Date: Tue, 9 May 2023 18:13:57 -0400
Message-ID: <20230509221408.476829-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221408.476829-1-alexander.deucher@amd.com>
References: <20230509221408.476829-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|IA1PR12MB6601:EE_
X-MS-Office365-Filtering-Correlation-Id: faa34bfa-772f-40f1-9dca-08db50dabf03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xgEDutiIeIYzA7YmdKW7kHDEl0SlwagXZ/HXiFrGS6krJqnzpIwaQ+fqI0h/V20ypHU4zP9OlryxOh/J8ttNv78NGA9X/lz9gMlOXX1a+0AWvb5rj+HVBTwqw/TD6k9NANaH41wQRjmjAOFAw8D0yqkW6vdMjQFhRZE7ZFb+01W6nXqNczO0C9sw3fTgCgiKeNyA5Bsf9Mqy/igaxwl7HEMmDCyApPNk6hTGez2fn5R9G749DNtqf8ie0vQAVgZsCMCJCvUEXwQfelmLSeqgbWvkJRbRXVToN5eveuIAnqhwx28KIwnlkWshkidPmc7akS5l4R1gAd+13md3+N6CCQ+I495zSgrYWV4amiIoH9+2nUMz7FeKvvQHYr5qNuGDiMIKVmfST5qWiJdSUSvympS4UbxAwB9k6lseqFEDRcLhN+CBKwE3oice0L6BobNdVPHqUOuRHrFfbCash58Q1i6Pb7WWDg7h+Jr7wOrX3suq8aNpfnJUk3arka6nKpRtZAgn5qrVNNm541aWjFwrMzhfCq5w+sD7qOtTmEaAGGqQASisHgVI0tdAvqTgU7vI8SFMkMhq/RodDEfXrUwvMjULwX5cUCx+9VquySfo7kXnmFAbIwarbbxwxVXd0pwJ1dLJtEwKDCz4bRi+Rf8q4j/TVdhVg1XBYaSgaBmrP2L1ndRkm6M3OC+Ha7e38Crc1ZbbdAr3eq6LvW9GAOPIIK4JBdV8VpM0EsuBsO3oRWA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(6666004)(6916009)(478600001)(4326008)(70586007)(7696005)(70206006)(54906003)(316002)(86362001)(36756003)(336012)(83380400001)(1076003)(36860700001)(26005)(2616005)(426003)(8676002)(8936002)(356005)(41300700001)(2906002)(47076005)(40480700001)(82310400005)(5660300002)(82740400003)(81166007)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:14:24.0366 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faa34bfa-772f-40f1-9dca-08db50dabf03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6601
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Expand the interface to get supported memory partition modes also along
with the current memory partition mode.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 11 +++++++++--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c   |  9 ++++++++-
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index eb25ac98903f..095aecfb201e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -97,7 +97,8 @@ struct amdgpu_nbio_funcs {
 	void (*clear_doorbell_interrupt)(struct amdgpu_device *adev);
 	u32 (*get_rom_offset)(struct amdgpu_device *adev);
 	int (*get_compute_partition_mode)(struct amdgpu_device *adev);
-	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev);
+	u32 (*get_memory_partition_mode)(struct amdgpu_device *adev,
+					 u32 *supp_modes);
 	void (*set_compute_partition_mode)(struct amdgpu_device *adev,
 					   enum amdgpu_gfx_partition mode);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 17459c4951fe..59412b263dee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1331,16 +1331,23 @@ static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
 }
 
 static enum amdgpu_memory_partition
-gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
+gmc_v9_0_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes)
 {
 	enum amdgpu_memory_partition mode = UNKNOWN_MEMORY_PARTITION_MODE;
 
 	if (adev->nbio.funcs->get_memory_partition_mode)
-		mode = adev->nbio.funcs->get_memory_partition_mode(adev);
+		mode = adev->nbio.funcs->get_memory_partition_mode(adev,
+								   supp_modes);
 
 	return mode;
 }
 
+static enum amdgpu_memory_partition
+gmc_v9_0_query_memory_partition(struct amdgpu_device *adev)
+{
+	return gmc_v9_0_get_memory_partition(adev, NULL);
+}
+
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index fa4b423c399b..e1552d645308 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -408,12 +408,19 @@ static void nbio_v7_9_set_compute_partition_mode(struct amdgpu_device *adev,
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS, tmp);
 }
 
-static enum amdgpu_memory_partition nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev)
+static enum amdgpu_memory_partition
+nbio_v7_9_get_memory_partition_mode(struct amdgpu_device *adev, u32 *supp_modes)
 {
 	u32 tmp;
+
 	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
 	tmp = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS, NPS_MODE);
 
+	if (supp_modes) {
+		*supp_modes =
+			RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_CAP);
+	}
+
 	return ffs(tmp);
 }
 
-- 
2.40.1

