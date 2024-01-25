Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEA1C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 08:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1255410F843;
	Thu, 25 Jan 2024 08:07:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3858110F840
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 08:07:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCaOhERIcIHexaDPneg1jpx7ODpoqHJZttJnNbHIzcvxBV/vBVATkib3F8aMEpJjMhY+sq2HvnpZ6ySNoLqUyghRBru+M5Nyz8+I2Q5LIKPfZHLrSorYDIE2Rb9vYtHy3nSgcuTas0aOqD9drxxLBerYDheUpGlDu+rSjB5U4s4aopQ7CjqoLzGM+49YdkDqalbdSTQrXh6Sec+Fr29olJQl9Tq1ZbyoF1OPUVXJ1xCJMJYVXNM5nMeMh4cEkQQ9F9GZO6XIHW6GmQpX6N6obJxGTvdwkjEstiV0M13GzLnmJgSZcAJca2lCpjW4vb867dDFZe8JdMRP2dpa0St0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rsafZfyC1+mU1GiDiz+BRjY3x26zh4FFmnES0hxgH7w=;
 b=F9YlUMQIpgxOn7goG/3Z5UtRdyPNwKR38s6IG3dVOZRj30NTwnfLyu/wxUf6IRGeeN9u/GwAsKZdBcE1y7k/saCAhEK5xzxH6p0x2j4MpLp5ywRJgezvL1OfmC3hdfGDkRBGXubMCDmW0fiWACB9ZBsB3YzsbPwddL74Pj3H/qbNyu04o8p5VA00A+0REeExC6Les2l662OZJSqY5MdHiDvcHBChkiTKNqdMkUnEPPeM7aFVz1yv/kiPiPBfdjNzT35cg1YgHP9rEk1KD1j/zuJKuvQD6ZCLY0tuBzLHd6BN/UwwIOxYSeBQpiwqJBTLAa9IzVZtJodWW3WBp1Z9wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsafZfyC1+mU1GiDiz+BRjY3x26zh4FFmnES0hxgH7w=;
 b=FE4BRgdWDYVo8dZrr/xfsdB7kYCgsUqBtz5/S0DjOdINUFEznxHwJdVHYBbfT51RtPN7Hl6PIQEOF4MiYWA9cF3DL3bn80wh1CCvBwfu9w87W0gWgM0zhH/psRM5cKy3yED89EVd8w70XE2FuoN0X+YyVfAwbEtgjVXWFZYX4W4=
Received: from SJ0PR03CA0172.namprd03.prod.outlook.com (2603:10b6:a03:338::27)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 08:07:30 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::5c) by SJ0PR03CA0172.outlook.office365.com
 (2603:10b6:a03:338::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 08:07:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 08:07:30 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 02:07:26 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: move the drm client creation behind drm device
 registration
Date: Thu, 25 Jan 2024 16:07:10 +0800
Message-ID: <20240125080710.9091-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: f9df8cd6-a8b3-415e-f0ae-08dc1d7cad78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYfSx2wnzXVYVMiklzrKZtl2T+kkalTm2YEsQPV9JLCA7U9Xmc3NNe8kHzyqroB+ULC6H+YcdmbO78NByIgzrOM4KPkugzwzPfYX6txWS9ttLIpB4pSjdnb+i3Qkx1F56HDTHbifYnFi7z7OTqcbnvufrSO5ExaRFhelcrmxPbqs5aIewgJtyQQU29S/1a7BGuK0hdhXM69yYenFLLnFSetCwDNcabXhPkOLkmf3J+8wKHZQYmXEVdv6jc5ZN1JhpDpWPaVS7QPyH3S98erUNVg0U7wLFtr12sxFJMYJd4JLdgc3fzBVSy4ll5TR0htXCs4qBMAwsq3LKu1PmpZh88rMOmAhhVYN/DWWnSnTyhQP5aOuTRgsrPJAxB5TaTGgbSJmWTzCskh2pIO5kzCtqjXOWbzpFuse0sZHyxIXfTf9k0mm+yT7CqMx3iWg4pViGWKs121PJPR/EIdEuoYfzpYSa/g7coyILaSiZzYcK4Z4hC4K5uoN4dEPOYBmf5NXXFMkyPSUfl0+u3Gts7G4gi8M+d5QpAXQ68z9p+e9j35j0fr+EOQzOn9YowJjQMmkmQ38F0Qg2V4h2D9UTctJNtYKQaMTqDBUTnI7sx9x7J8gTIFpGWiyAzzo9ZWwQ7qI5I/iSwfXS8+8phO2kz0GrLNhIHdjI+wLmzZIc4MXpGci0x+Dm+LrdUJKwL0zgRVhh2SVMwp0b+nDgWmq9Ah/IPQ7Pm1a6CLYW5dXtdWdbJlCBXykxxJ9hN3mRRLSIC6PEHBuPPkFRiiwpfNUmoSEOuVuKTrR/a04y2AocTEG2az1MAP5JlVHiGp+7wNyvK3a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(7696005)(40480700001)(40460700003)(44832011)(1076003)(2616005)(82740400003)(26005)(6666004)(47076005)(16526019)(426003)(83380400001)(36860700001)(336012)(478600001)(8676002)(8936002)(81166007)(316002)(70206006)(6916009)(70586007)(54906003)(356005)(5660300002)(4326008)(86362001)(41300700001)(2906002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 08:07:30.1896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9df8cd6-a8b3-415e-f0ae-08dc1d7cad78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
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
Cc: alexander.deucher@amd.com, Le Ma <le.ma@amd.com>, felix.kuehling@amd.com,
 lijo.lazar@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to eliminate interrupt warning below:

  "[drm] Fence fallback timer expired on ring sdma0.0".

An early vm pt clearing job is sent to SDMA ahead of interrupt enabled,
introduced by patch below:

  - drm/amdkfd: Export DMABufs from KFD using GEM handles

And re-locating the drm client creation following after drm_dev_register
looks like a more proper flow.

v2: wrap the drm client creation

Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 77e263660288..41db030ddc4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -141,11 +141,31 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 static const struct drm_client_funcs kfd_client_funcs = {
 	.unregister	= drm_client_release,
 };
+
+int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
+{
+	int ret;
+
+	if (!adev->kfd.init_complete)
+		return 0;
+
+	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
+			      &kfd_client_funcs);
+	if (ret) {
+		dev_err(adev->dev, "Failed to init DRM client: %d\n",
+			ret);
+		return ret;
+	}
+
+	drm_client_register(&adev->kfd.client);
+
+	return 0;
+}
+
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
 	int i;
 	int last_valid_bit;
-	int ret;
 
 	amdgpu_amdkfd_gpuvm_init_mem_limits();
 
@@ -164,12 +184,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 			.enable_mes = adev->enable_mes,
 		};
 
-		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", &kfd_client_funcs);
-		if (ret) {
-			dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
-			return;
-		}
-
 		/* this is going to have a few of the MSBs set that we need to
 		 * clear
 		 */
@@ -208,10 +222,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
 							&gpu_resources);
-		if (adev->kfd.init_complete)
-			drm_client_register(&adev->kfd.client);
-		else
-			drm_client_release(&adev->kfd.client);
 
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 584a0cea5572..da175c384adf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -182,6 +182,8 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
 struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
 				struct mm_struct *mm,
 				struct svm_range_bo *svm_bo);
+
+int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
 #if defined(CONFIG_DEBUG_FS)
 int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 475bd59c9ac2..91d5d9435067 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2255,6 +2255,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_pci;
 
+	ret = amdgpu_amdkfd_drm_client_create(adev);
+	if (ret)
+		goto err_pci;
+
 	/*
 	 * 1. don't init fbdev on hw without DCE
 	 * 2. don't init fbdev if there are no connectors
-- 
2.38.1

