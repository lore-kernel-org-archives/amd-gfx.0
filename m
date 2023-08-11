Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D1BC001DE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 05:18:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 622AD10E64E;
	Fri, 11 Aug 2023 05:18:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C69810E64D
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 05:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeWtw7uZQz+s3eqeiFJUVSdCMK+PjgGfqtdbZ750Zob2fgKOu06pIigWgma1DweP1DZWNw6JtL8DvBHD/tVQwfL1qSXYETtAfxcLiMbty9dTpzKQ3nPwa0bvxWPWV2Wo1hH6mJleKoFNu3xd/3kKG+dUr+PDs2DFJ7K8XA91qlNkgGf61gTCKV80D7iv/nsp/6gHGtnxYGhslnY31ICNWhUfmOsGngznzoEsLf8tbupFuOu4yY14B0wRFJdkOsAFykSIQApy2z+Hbu5ZFa51W2f2PLl3UvA83G3bspyiZM5tFdLPNqPPE+ZOXeFo15sa2uhIg3ijjUOrGFxEHNxEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9lEsHEEDM41da8jSDSQnGWtPQMKgiRRId8dZSUfPP4=;
 b=al04G5olb3XFO/5anzLvoxFpxIjs2SBTAb3hoeJQDfuzKmIwC8H04VCTnEDOa8J+5ewOz7xEXC+PM2qDWN4zNTTUI2jqrxB1zjGr56Ddt9cKvCOJ9ySoubRoHJRv77Fk4qP+GkMHuoFFH/7Hk6hiVXEBDnhro+/r5c9TNZaOMpxBMIs55IjuV/mQgqneGwGqQSTkphwOVi8myuyrQvs5woks/SzhO9t9p5AhgFCbEBfQfuM9wya06ic8ZsAceCjsKMeG+HZ3d1ay850b//in6gsMHO66hLB+A3/X9Kvih+AzE4AMe72eA8UwED/XCHfM47RkB+pQGK/+ZtEQ59QYBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9lEsHEEDM41da8jSDSQnGWtPQMKgiRRId8dZSUfPP4=;
 b=V3piX/Y80SrhsZOZ32ePZBaJknDJjreRwixheE7Hlg1SN2QEbV6KtTpcR/0dcFGticEmhn/5RUa+hq8CkuC4+ZvQK9hubiVAq3yATSdxUFkRCKbuTxXbSauQdafDeS/3M/zXBdbD2+6nyPPfP623jqC1Eve5VVzHSDVUcAMyXXA=
Received: from MW4P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::16)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 05:18:49 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:80:cafe::e3) by MW4P223CA0011.outlook.office365.com
 (2603:10b6:303:80::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 05:18:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Fri, 11 Aug 2023 05:18:48 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 00:18:40 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: Add bootloader status check
Date: Fri, 11 Aug 2023 10:47:54 +0530
Message-ID: <20230811051756.653422-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811051756.653422-1-lijo.lazar@amd.com>
References: <20230811051756.653422-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 168a2579-740c-4e4c-359b-08db9a2a71a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QmuHn45csH3Tju9v3TxyTVSDPSznSEu7aVdVkRJKKZfxptKeGNCMuS+lpN1/VKCIS5S46E/nmwGKhHSMcAFZnIMv5niMwpFBuumfqL2JPA40+lvkZnOlm3pMBmoPqFNeyZQvDWuyefo+TFDqiCkH1rV0EaGtAy2lkrUc4eIF+cd1wNVk7zzIYNYMuxSd5XeBpG2yELFuG2qqrzcUprW9+1Q11KdSBDPUi/2TCSFwVkr5gW22PDy1vV63pMDaZ3enDFrhL+uB+YqH97FIemDujVitrRr//Z8MQ48BvJZ+uqB6VYSjK2daSc9878wl8KO4yYuMHehaejkce4rQMRU27+rukBQW0HNLoC64aXw7r+TRM3/64zlyuAFKsbZbkHigKn1SEuZGtDH1tLc0xcMz2eBrTAuqRBMgaUJTHVt4tyfAikjwVJFKzzlA0RuvJ8QcYY0oLOD/AL9PISGf0oUmStccN47ujBuLzo6M2uVACClv8mU2gJ5x87iRUGWPzNRI5xyCmn+JyM2evAxvC4BizlaY83HqBPXwRgR8V3oJfuY9rLKTrr+L+k85yXIVoDVBFciwVrdgoVWeFSPnc9NU4HttWIB/pCtlI7SGXiWt4UPaxHacAGzTaBH9Pz58n49mHh9I2gPEFps07h1o87ETELErZsHHskxOf+O/aYYFHAQ2S0ILYdP2FJWuOb9ss1wkPaozpWyFtgjObUfdYzJeKVoCspuJpcxlOkt708PftKy84xp/wiblm1PSOifKUS9/CJl2Mp8qiWk2hsQ+6iyAeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(1800799006)(186006)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(47076005)(70206006)(54906003)(36860700001)(70586007)(6916009)(44832011)(4326008)(5660300002)(83380400001)(41300700001)(8676002)(86362001)(478600001)(8936002)(316002)(2906002)(40460700003)(426003)(82740400003)(6666004)(356005)(81166007)(2616005)(7696005)(16526019)(40480700001)(36756003)(1076003)(26005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 05:18:48.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168a2579-740c-4e4c-359b-08db9a2a71a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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
Cc: Alexander.Deucher@amd.com, Le.Ma@amd.com, Asad Kamal <asad.kamal@amd.com>,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a function to wait till bootloader has reached steady state.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Tested-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 17 ++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 11 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  3 +++
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6809bf7dae57..9061d79cd387 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -885,13 +885,20 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
  */
 static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 {
+	int ret;
+
 	amdgpu_asic_pre_asic_init(adev);
 
 	if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) ||
-	    adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0))
-		return amdgpu_atomfirmware_asic_init(adev, true);
-	else
+	    adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) {
+		amdgpu_psp_wait_for_bootloader(adev);
+		ret = amdgpu_atomfirmware_asic_init(adev, true);
+		return ret;
+	} else {
 		return amdgpu_atom_asic_init(adev->mode_info.atom_context);
+	}
+
+	return 0;
 }
 
 /**
@@ -4702,6 +4709,9 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 		dev_err(adev->dev, "GPU mode1 reset failed\n");
 
 	amdgpu_device_load_pci_state(adev->pdev);
+	ret = amdgpu_psp_wait_for_bootloader(adev);
+	if (ret)
+		return ret;
 
 	/* wait for asic to come out of reset */
 	for (i = 0; i < adev->usec_timeout; i++) {
@@ -4713,6 +4723,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	}
 
 	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 8fdca54bb8a1..429ef212c1f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2078,6 +2078,17 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 }
 /* SECUREDISPLAY end */
 
+int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
+{
+	struct psp_context *psp = &adev->psp;
+	int ret = 0;
+
+	if (!amdgpu_sriov_vf(adev) && psp->funcs && psp->funcs->wait_for_bootloader != NULL)
+		ret = psp->funcs->wait_for_bootloader(psp);
+
+	return ret;
+}
+
 static int psp_hw_start(struct psp_context *psp)
 {
 	struct amdgpu_device *adev = psp->adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3384eb94fde0..3e67ed63e638 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -109,6 +109,7 @@ enum psp_reg_prog_id {
 
 struct psp_funcs {
 	int (*init_microcode)(struct psp_context *psp);
+	int (*wait_for_bootloader)(struct psp_context *psp);
 	int (*bootloader_load_kdb)(struct psp_context *psp);
 	int (*bootloader_load_spl)(struct psp_context *psp);
 	int (*bootloader_load_sysdrv)(struct psp_context *psp);
@@ -533,4 +534,6 @@ int psp_spatial_partition(struct psp_context *psp, int mode);
 
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
+int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
+
 #endif
-- 
2.25.1

