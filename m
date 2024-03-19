Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDD4C54E60
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 08:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE5010E496;
	Tue, 19 Mar 2024 08:07:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jZRwvCbJ";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C89A10F54B
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 08:07:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jU2tYPWKIPLFWqVwD+0UJlZ7YC8gtQioriEkhyWnVKXy2OvEwTSI1nUEcx+ZR5bjLjFXp9yanP/LBrV85yPfGfGgfOjL6wiOBPLSjNormyGvpjeaNsg/CLnJgKWSXDHzzrnzbeW/LDgEDVra1FTjnGkI8gyKjSNw3PRXzAWNDpy/J5l7oI9s0Cc1M0jjvyvhU/k9+duYnPaOXH7aRxZK+sMGYcXzefT2efYAfgIgS4BIz47vzDV/pmcEGf3R00E15C510dZaBCn/3yzxFQ6iXycr1L/xwMIYFdt+nh/tPoSMqn9CMlCBo4UJN//17PJSQvy4OkiStwD7sig+I7BMBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn+o8dB8hbi9YSAxrkphQXiNfyHXSiuCC3hdr5SGKtQ=;
 b=ISLAiuvyPFjc5Re5rb2k/RkWPV5QIB8xd7fjJA3wU4Az7eS+2GZAsfgZCn5Y1RgkcmJBNjEt1h3Nym2tJR3LHaEeL90ImlDYij1neYXEfbXe27S59B+jRvP4C7iDToqvq7x92obf9ifdiCFFaOwmylnhkiYfz4G803Z/YM4VXZa2WVrtRhFsgx8XUZQ4XZhYJ1AzRfFKWZeMkvtVTb4g7ScvvcD67hu/WWNdKpQWoUbcqecDXa5ZTLKZrBMJLD6Nx7G2OSAtU2GVw8Q+Onkho/PnGFFT4F86w8FYN1kMMIFBTCOBy+I24u6CQDE5mcqnDouu8dWtslNwwJhLt8E1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn+o8dB8hbi9YSAxrkphQXiNfyHXSiuCC3hdr5SGKtQ=;
 b=jZRwvCbJ3GubzLqK/bNmE1wiob8BtAKKUgyKY8y5e+5NXcQw54V32+HRqMNg1LO/7I5gW69OTLijMDNjqdxIn5aV1PMq04Z4vpazN8CpSo8sPr4iLz6TlcOhL5X2p/7QClyY5d1wvfUwDiSubMT8g/NEgjg0/752NYHmjej8LHc=
Received: from PH7PR17CA0015.namprd17.prod.outlook.com (2603:10b6:510:324::26)
 by LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 08:07:45 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::78) by PH7PR17CA0015.outlook.office365.com
 (2603:10b6:510:324::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 08:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:07:44 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 03:07:42 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Alexander.Deucher@amd.com>
CC: <srinivasan.shanmugam@amd.com>, Ma Jun <Jun.Ma2@amd.com>
Subject: [PATCH] Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks
 in amdgpu_device_init()"
Date: Tue, 19 Mar 2024 16:07:28 +0800
Message-ID: <20240319080728.2558078-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|LV3PR12MB9265:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b20eb5-3237-4075-9d4e-08dc47eba821
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gyr0C7876l59cd1QINPL+41E4z0HYlHJo+tx7OkdyX5HFdO0dEqnfBdZVxxIbmnIuoLfWaUGbRx2Sh/fBGEQ234qY4Asp/XTlpuFUGSsq316xNeyicM6h9P8sazmozty/BCNqkX15dI+ONY4SF8M3oy0cfEKbrChbaDgADD0xQt4L4ROV1pcfaB4BOm634fKTaApUsgDUBStP2dgRpZ6gO3hHRyhUYlDkM7vi5Z9ml0Xv/LZ37xIadGn4GezDJr9UQRlfhuyOTZaaYawi16sb4YNaYlFPvB9hkiezlKq55DSGfyoScoTiKdiOYKCnBHZJ87WOyp0v7cgcgiZlcdEb/4c8da9Rv5sE1QsM+3RLwoCdG/JDhXe23YGAoeJO6We6vuxuw6/hd2kTAFJX5Rxo4tJ2ejw0JtlXNEbE/6x612MpoIROBclK4OhjD+4Z9/0s3Z3w9ivDhwTzDjnobRlO4mDrmwLUgaxHHq8F0fSmNPcrEAjLsFWrV3vEnjCPXeh/dfontzXdrlFgsYS19oDXlzuMxHveuerg+MhogSzGTdsHXy8XM/0bc6y8YmLSq2c4hyTc5YWGiK+ZpMNY9TOuWu7JD6MHPIUKW1gtD2Igv8gjWzdQRNtPEnrEk8JdtLmE9We4ZwFv4EYeElk0AwivdnddEY01dxl+YGUuXDXnexBw78B2gYQJhmBGTfv6psPybfD/5WFatIMr4xVJNSKA+tEaFSvf3gJi1VW+1tGXST1nuE/tG/ZSpnEozxbB2YJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:07:44.2804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b20eb5-3237-4075-9d4e-08dc47eba821
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9265
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

This patch causes the following iounmap erorr and calltrace
iounmap: bad address 00000000d0b3631f

So just revert it and amdgpu_device_fini_sw() will cleanup the
rmmio mapping.

This reverts commit 923f7a82d2e12a99744a940954f3829ab18a9dc7.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 70261eb9b0bb..3204b8f6edeb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4042,10 +4042,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * early on during init and before calling to RREG32.
 	 */
 	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
-	if (!adev->reset_domain) {
-		r = -ENOMEM;
-		goto unmap_memory;
-	}
+	if (!adev->reset_domain)
+		return -ENOMEM;
 
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
@@ -4055,7 +4053,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		goto unmap_memory;
+		return r;
 	}
 
 	amdgpu_device_set_mcbp(adev);
@@ -4063,12 +4061,12 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-		goto unmap_memory;
+		return r;
 
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
 	if (r)
-		goto unmap_memory;
+		return r;
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
@@ -4078,7 +4076,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
-			goto unmap_memory;
+			return r;
 	}
 
 	/* enable PCIE atomic ops */
@@ -4347,8 +4345,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
-unmap_memory:
-	iounmap(adev->rmmio);
 	return r;
 }
 
-- 
2.34.1

