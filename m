Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7E0C48BF6
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Feb 2024 06:39:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6E0010E14A;
	Sat, 24 Feb 2024 06:39:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lqhhQ0aj";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9068B10E14A
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Feb 2024 06:39:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUp/Ojtf7+n1c8HQysPXaGVda6pYAQCKmXMTkHUfiHOLr8ogwq4oDb0KNoe0yP7Y444jn61YsopiecDgzcNP3Cj0A0Ii4oNaL4ndXIANr5WH2X9y185R8om5jNmxeuzlNk5Wsw37Q5lQf6TWGUT6C6/fmRyC90g/kMovNMLkHxZWESsmTGSa+tS11HIDYPktdQkXBprzxdSRHyM8cS+qL2mQC7SvxogXihNN4/FM0UYvDO+nwEeGdXFBT1+y9ef4qDj8l/UVYwtA1AJEeRV+JCGEe/f0tJsq8F/MuClPuqmFAl4BwDQdd5jI8r6WsQjmfp4rCBtgEpGp05zt8GXhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xPUQZSiz8yJNOYFB+LbNFrl3UeoPRjcymTDRd/0995U=;
 b=BTJRKTL3NFCi6PRyVTWSd+jwBK16F5AYE6FNF2NbRuzAaauXrXNfkK+JACu7mrkEJTvC90YIFVtgwBVnWZ9NOl/QGzRlp3ZO4gnKuKJA00TsDr8oQBLNaLcodm6qMo0TSJpD5NI+r+6/Fsy/r7DZPYRFJa0fqReH9aOwJuRGdHrIgc9gbmgSNZYAPNV1Op7Ff3kXWFda7e04k6sysiyWINRQii6t+KsYLnKLvHC0RCr+4ng5T0MkBRUf8kik/LBqRmNZMa3NU9dC3zsru8Rueu3YW1ZCw4TCEMnAuA8Bp44lZhQ8DV4VOo6lsCPQRdMtZz5u78EJCjXu3U7YBRWDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xPUQZSiz8yJNOYFB+LbNFrl3UeoPRjcymTDRd/0995U=;
 b=lqhhQ0ajj9qcdKu+5DnSXVVWlUmBiaqQTbfkUW5J2M5y8W2vNfP4mJ8d32Go7yf1NDf7Wvi1IaVAGApgSp8C/ylZobHq8axLKV9UBgg13QijcCGgcrOp5/1L2PGJ9VxaLO1rnrchYGt0ibKmhF/5PGN1KfWb1Wg31C+gcnQp5F0=
Received: from CH5P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::29)
 by SA1PR12MB6947.namprd12.prod.outlook.com (2603:10b6:806:24e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Sat, 24 Feb
 2024 06:39:02 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::7a) by CH5P223CA0008.outlook.office365.com
 (2603:10b6:610:1f3::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.47 via Frontend
 Transport; Sat, 24 Feb 2024 06:39:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sat, 24 Feb 2024 06:39:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 00:39:00 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amd/amdgpu: Fix potential ioremap() memory leaks in
 amdgpu_device_init()
Date: Sat, 24 Feb 2024 12:08:46 +0530
Message-ID: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|SA1PR12MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: 56aae19e-888d-45b7-bf6b-08dc35034a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAD8EqbhMfz/zLg0oqXJRRWLk/vP+1MIcLc3y6/wWqp41hDICc+Ren8f7YPNAVz3IKxDVWTvP5+kxh1ZwcliF/Yj6BFjZBs+no5JTY52sS4K+KHu3O66EFqTY6BbyyehkgaagkoM0IWxUyzgYQEZ3rW4E8hzXfOvAg7Ir1LWE42+JIfG6NT70SmA4+/szS/2r/YWPLp5SwJFuEh8bTrvuWD5stbVB9bGH1B2R9+rVprt7d2fFKyn6Hl4xo2KUFtwPvUg1lSHwwXGQTaoYUiZEuSkIqxc7V/apBexhq7Yy1DdiqmNUxwoomo8XCHt018DCZAu6F/IrM2qsAjse5u5hgrWGchH3UfPcK+Vl0PQJF2ofnTWNCDq2xgL+c2rHBVklyA1naJUu2eSURZgsRBBUdRJzBSYudJPWn5FTAzw+7iFkz3epRBMEIG1NDJi67OspmdcQKZTXx0YsDS7MsXykT3+ih+GNMx38mGPB37MI8PeXMOH+0txpFzPxPn7wCQfKT1W5tJI23NMH4rkB5MZa/TnTB8c3JL95WoaQva0I1b3h5TVflhJNTKWwe5KG/+jSxmp/Ous90nFsL7lqJjT2hj4++erKdI4em87+k1x1JkNkbBecXofZyP33la6++0qyUzGF7HV3dVDlaljxKh1ymyPwixnoajUOgl3b1EfX+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 06:39:02.2837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56aae19e-888d-45b7-bf6b-08dc35034a11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6947
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

This ensures that the memory mapped by ioremap for adev->rmmio, is
properly handled in amdgpu_device_init(). If the function exits early
due to an error, the memory is unmapped. If the function completes
successfully, the memory remains mapped.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4337 amdgpu_device_init() warn: 'adev->rmmio' from ioremap() not released on lines: 4035,4045,4051,4058,4068,4337

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1ef892bea488..68bf5e910cb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4031,8 +4031,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * early on during init and before calling to RREG32.
 	 */
 	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
-	if (!adev->reset_domain)
+	if (!adev->reset_domain) {
+		iounmap(adev->rmmio);
 		return -ENOMEM;
+	}
 
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
@@ -4042,20 +4044,25 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
+		iounmap(adev->rmmio);
 		return r;
 	}
 
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
-	if (r)
+	if (r) {
+		iounmap(adev->rmmio);
 		return r;
+	}
 
 	amdgpu_device_set_mcbp(adev);
 
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
-	if (r)
+	if (r) {
+		iounmap(adev->rmmio);
 		return r;
+	}
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
@@ -4064,8 +4071,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* Need to get xgmi info early to decide the reset behavior*/
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
-		if (r)
+		if (r) {
+			iounmap(adev->rmmio);
 			return r;
+		}
 	}
 
 	/* enable PCIE atomic ops */
@@ -4334,6 +4343,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
+	iounmap(adev->rmmio);
 	return r;
 }
 
-- 
2.34.1

