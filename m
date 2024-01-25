Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B447C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 06:19:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EB810F7F3;
	Thu, 25 Jan 2024 06:19:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2356710F7F3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 06:19:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Na5qHOcZUtjdJi98QVtstH81/DNHn81ERmclwnhXe7Vq+61h0waTXge5tU3Kd69EAxOqAySBT28FOIaPyZe6tpWuQTGG5rdmN+aZEGGC9MzUbR2N9CskonScX9gzRdS0xAAJQKeH79p31RN3QpZ/xDBfOnhqMI68ZXQQf//+lnf09I41C/b7skXabvPxIwU8blWUYkQwdxvm2IzsPOtKJKSV60LsI8C2BWH4SuZSHKzgchNdUYkFbpLKcX53jSmMyoLy/i0fYxdQhIeJIWTO9GFH4DnUyAdE/iI7rgTd4ni6BsGLnrHap/pxFUzWWNSZGrkCM+Jb1fGkHJOC1BMW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6t3cS/TA/UtCygMqK19MASxpWkyJpVDcb6hCjejymxo=;
 b=DkZkr+CK3wwzGiq/d8P+80vLVyTGhWGnc5qxMYGrQ/wyCmKcV7HoCgHbvQp084LAI6kOVGJYkB/vhy9ijRsal+yOkmu6jZWZLcr7JSduSRnV6yphhHq4I5/revM0gO3ohLwHyM4zWjlkcM+zL1Cj7NDoBnoDydxeaObyJ5K8MrIFmTJ8ns1xfiRxnPacRNDb2loOnvxYnd/NA9eX4GRTjigyyn748eXoA77HKO8XbxR9hUgBIZjhXcS0syOsuT/8TcWwrTpkFRhfeV6vesRUHMVzvjSK2wu6Vb6uSKVwcI8yTrjdXv70o1i59dn2GLkTLLQvLCvehaqsdxwz+1zJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6t3cS/TA/UtCygMqK19MASxpWkyJpVDcb6hCjejymxo=;
 b=BO6/7chJxVu9BerobLXNACrySR2tUH1AOHBV4Rr+nQHYQfr5rE7UhfqiIyuPlEPTtCVOUFtiZK51aLuSOusostneMrYRq/5CUXcpjaAPf9F4i/I2PgpTmu9Z5PB6FnReqe8Em3nP2/FdYtNtKdWsfctb16yG7zOuVyKRoVEvivA=
Received: from SJ0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::11)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 06:19:19 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3f) by SJ0P220CA0028.outlook.office365.com
 (2603:10b6:a03:41b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 06:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 06:19:18 +0000
Received: from lm-srdc-pc1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 00:18:40 -0600
From: Le Ma <le.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: move the drm client creation behind drm
 device registration
Date: Thu, 25 Jan 2024 14:18:31 +0800
Message-ID: <20240125061831.28290-1-le.ma@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|DM4PR12MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 246decc5-ca66-484f-25c6-08dc1d6d9051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H9BYH9YKo37ug7cKPJb6wBWBfNldZSE79K6Ldi0vnlC+UqwaBMcCgLUbeUf2Jlyhq5LzQv5UsciLduDKtSTiyFPFV02rlEB1prGOcsUlOp8k98l1Nnbh4V9hPWr5uTMnCb+65QSQ59oB47K/L4bRtJelEjZwjOulB9jd1ZTXzn6pv1B48QkzV2EozbYvINuIou25dwKDLGkyA8ijXGINbJtofGBxWvve8AYRvqIoMRcniIUnwpEZTDcXLLiD/mnp8VqEZfIWjNNupyZ6YPm4xsM4FrXW86HC2d0tuNUMFVKGblFPjqy3srzKVhMtIGXuGtCX3rQHrhF0tWjMTDdGxJr3MBrruQnDg9eQl0zDSlhjsHrqShRoDD+zOkz2Q4oFtiP2B3+5c+/Z6DhQDGCBPYU/HyIImWn6LkuFphJvgf3UXMa12fmgWJ9QFu71Ofv0uHWDEHjIllRFUYG0dkpOZKNL9aa4t03sJpltIfLJyN8Haem34hjjHSXbJsrkBMllnUPWpwl5Bx1o0YDUzOf06Vad8rdtA8Y+KoJKhLgx7c+PNfzSVly44jZC1PiDZOgazCyrAmz/Nh488gRDBHwUF86PITVBkYnWbYV1Qb5umAuCndLbit6tC9hPIKJ8g3zk23k6Zma6VKixaGvv/O+3zu7A5t+PVihvf127VqZKX4T9mf+s/Qdi0AAQYHpQciPjK/hGeyl0c66frw5waw0fLTvSchbc03fiB1h2sAJlq5pBqW07E9kUffmVEWcJbdbUcxtJMqtsgEXtwUyPbMdiSi+yYMmiv6h6FpioUrhOZs8RvegiJB4Al3qIZQ0vbvb1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(83380400001)(1076003)(47076005)(40480700001)(40460700003)(336012)(426003)(16526019)(26005)(36860700001)(44832011)(82740400003)(4326008)(8936002)(8676002)(6916009)(70206006)(70586007)(5660300002)(356005)(478600001)(54906003)(316002)(86362001)(81166007)(2906002)(7696005)(2616005)(6666004)(36756003)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 06:19:18.8239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 246decc5-ca66-484f-25c6-08dc1d6d9051
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573
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

Change-Id: I0fece177b78345187068f92a823d96b3b7581140
Signed-off-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 13 +------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++++++++++
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index add315644773..69eb0f5574d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -139,14 +139,13 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
 	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 }
 
-static const struct drm_client_funcs kfd_client_funcs = {
+const struct drm_client_funcs kfd_client_funcs = {
 	.unregister	= drm_client_release,
 };
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
 	int i;
 	int last_valid_bit;
-	int ret;
 
 	amdgpu_amdkfd_gpuvm_init_mem_limits();
 
@@ -165,12 +164,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
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
@@ -209,10 +202,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
 							&gpu_resources);
-		if (adev->kfd.init_complete)
-			drm_client_register(&adev->kfd.client);
-		else
-			drm_client_release(&adev->kfd.client);
 
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 00eed8c10cd4..b2c6f2b3c0fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -40,6 +40,8 @@
 
 extern uint64_t amdgpu_amdkfd_total_mem_size;
 
+extern const struct drm_client_funcs kfd_client_funcs;
+
 enum TLB_FLUSH_TYPE {
 	TLB_FLUSH_LEGACY = 0,
 	TLB_FLUSH_LIGHTWEIGHT,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0d0aa4b798ac..d0b98343481d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2293,6 +2293,17 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 			drm_fbdev_generic_setup(adev_to_drm(adev), 32);
 	}
 
+	if (adev->kfd.init_complete) {
+		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
+				      &kfd_client_funcs);
+		if (ret) {
+			dev_err(adev->dev, "Failed to init DRM client: %d\n",
+				ret);
+			goto err_pci;
+		}
+		drm_client_register(&adev->kfd.client);
+	}
+
 	ret = amdgpu_debugfs_init(adev);
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
-- 
2.38.1

