Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2FDC48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 10:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26B210E612;
	Mon, 26 Feb 2024 10:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bEKw8NwV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBDB010E6CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 10:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNfItBEnIttQczk80yAx+dsKY9Fk2QlpSiQ2+nOio8dRqhc+U4kmnJDpddlKC6PkNhSDckWy4suQM5ilbg7Hh+a9Xqd0Lq1TtbJo5rgvQB1xmO2eQdH99gE7wGZu3VvctBLOZrvgo92YobC+sOw6pcpE3dR5iNBzxRAvFTyGwMqiFYZy9pGctgMYh6ptMRhq1TozoFADEQe+mHRl2RSxcTbzAkExHXfNyedOkXy3tGVNg5LEsrYEkptuQR1dRwdpZiSBdNyfGmXVDMx5mirJjwyNXw7OKa2UM24ji1mzZOHwjWIkdHcNg/bLfzWbv6Q41p/DY3UeerKAL20lHpd5BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xkQwq1whQ90g+d9pytJGrGn9vmsO9D4pn92UhbDhdxU=;
 b=AWj/dKlvfLGUsFPDFwRuplonUaMdPHFXIYNPuUlYVMaul+5AT9hOwkOhMMjTZBadZbAuWdz9deqPQ7TP+CizhmtPD+VWDXfOwqmXwA8L1jCYTSQFw/ONXocRyW29iNblO37xJvyFkZJG7o21PzZWNg+3qxean0w/Gu/pjr10ncTSFRV9jnF/xfwBqquE760zs8lYKfy72rK/K0QqBiebBxBycOxPUCIP8vIuHJ/j+rInqbqk6Qmqo1j+ZhOKnlaSyn7tOr39ZwFCd8VimirFKIIF+IUdtQCvcV7GRqwWK25OleF7vbqh+sjFPy1wT4XNLlz8CHAgST7CmTVZh17uYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkQwq1whQ90g+d9pytJGrGn9vmsO9D4pn92UhbDhdxU=;
 b=bEKw8NwVpP01MAAbdy6cDoq9h4Xgc/g+Q6vMmQJbt90R80cN2FlBORPAukPE/7d3Boh2mPfwSCLWtsgpqzO3xncH7b8dgeNex7FC5OAFSghigYzSYuuBHoc1N5Vy99iNFExrRousJfqxVI9N/L7igRH0G1bJX8sOq9vOg10kl+g=
Received: from BN1PR10CA0027.namprd10.prod.outlook.com (2603:10b6:408:e0::32)
 by MN2PR12MB4439.namprd12.prod.outlook.com (2603:10b6:208:262::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 10:20:19 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::7f) by BN1PR10CA0027.outlook.office365.com
 (2603:10b6:408:e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 10:20:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 10:20:19 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 04:20:14 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Fix potential ioremap() memory leaks in
 amdgpu_device_init()
Date: Mon, 26 Feb 2024 15:49:47 +0530
Message-ID: <20240226101947.2311748-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
References: <20240224063847.1512027-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MN2PR12MB4439:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ebf6ca-3cd4-4111-4258-08dc36b488d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFhWfcvU51XmN5ca9rBE7dlQKMSYz77gqJZQeGNhZV6+Nx/uSpXG8EVAT7NFgkdzGJD2+7h8VZmXW5E0Yhgk/JyamV2m9yLpTOveg510El5MIpCgTO+VyR7EwRfhiBjonrJvv8TwQtjQ7rWgAZE0MZdjc3+nEemvxDrayVE2AHk8S8DGJPzrkCGk8B7IIk0LJfXKhBt4MYvVVRLMUboquqtIVL1QvnEex0jkdqCSqz8S89AmrdVkxNIF0B5IURLu0wKPHRfKK/CQpS5L4jeeb+/Ed+W9XqBK+UdL7ShilYor/0Em5GnVRBtpZMZ93CCDfWzc5Ar5NfUmO8f8tiYJlCARsjDwwu2FuxufmSr70gLV0Mg+azV9QFiKFS5Dl+ytbaukA+qk7dixFFm5n8coLCuPBunrXRvl/5XmT3Afinsdp99iPv+t1rRwK1ni44rGKUtfIONjpMnQCIGnFz1EL/04WLpSmNdIbRv6O3naagjMFSFzU09k3gEbUGdfFOoAhsqwMBHCkytVzCDc8LsAl93Y4axeh3Hw3cLtgP7wBcfZb/6GqjaCjEa6AMl1kAgHrUXrr0SktQYei65UsVlk+nZZ2EqFtl/HVsC/ZD1NijoiLSomDabTx+pGFpjVjxEvE17j+mNdqgpTUp+BcqEiTEqEPG8Ybkee65I9CucminIy5myqle4hydECMlVXYGOGF1uo8l5B3wofkE5seyRfYxNj5TzaRPtG6Wv+7WLfLihr4Wn59fBYGn8jwa499RJk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 10:20:19.6793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ebf6ca-3cd4-4111-4258-08dc36b488d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4439
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

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4337 amdgpu_device_init() warn: 'adev->rmmio' from ioremap() not released on lines: 4035,4045,4051,4058,4068,4337

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: 
 - updated commit message
 - use a goto label and error handling instead (Christian)

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1ef892bea488..d0e77bbee60e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4031,8 +4031,10 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	 * early on during init and before calling to RREG32.
 	 */
 	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
-	if (!adev->reset_domain)
-		return -ENOMEM;
+	if (!adev->reset_domain) {
+		r = -ENOMEM;
+		goto unmap_memory;
+	}
 
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
@@ -4042,20 +4044,20 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		return r;
+		goto unmap_memory;
 	}
 
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-		return r;
+		goto unmap_memory;
 
 	amdgpu_device_set_mcbp(adev);
 
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
 	if (r)
-		return r;
+		goto unmap_memory;
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
@@ -4065,7 +4067,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
-			return r;
+			goto unmap_memory;
 	}
 
 	/* enable PCIE atomic ops */
@@ -4334,6 +4336,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
+unmap_memory:
+	iounmap(adev->rmmio);
 	return r;
 }
 
-- 
2.34.1

