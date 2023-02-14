Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158E1C6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FA110E92D;
	Tue, 14 Feb 2023 16:16:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51C0010E91E
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/cByO2QvMtVIoAuMJ7hKk4oag/iay8uuowgTCbS0CqHvvk6pMFBx2267mi94Qe1Etk0ZZ8KIpl8LDSJ4GqTpceKImR23QzwrIAQbea87eoS7NuzkMEaJPnbzw2VEvtzskK1DLtuktKsflZP9P025Tstilpc9GpJAxMQaZl2pR+985u0U+7VPS4VpZYvnqyL1/gEbhKZYA15mHWVmbaTy5Uhl/FSTZ0TbmmVGZC8Q8HKOhOX5sCf3uNlGlaLWRQIrRPyvPaZjXxgjKbxTPt34bPHJ67imGKU7l0TH+KcvT5rYPPGhAbBO1UN7SQ/7ETQZ+ApufSNLdjGfJZw1wDr3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qD8hgf0j4oM2DK0g/aNG6G2tw0k2on5OnN55PJAdGo=;
 b=lHwSFmeqyBvRDCpkNA1H9ip90R5EAHq8eXtIdOBa8HbpGJjJsIqKgh9kG8yMrcaS6ZdxDWGECaQbT/Pkq9vwZ2mAbVvjTNO/MQstGuhpmMoNGH93N22p8uw/TRJbWTQUWPUylwloTETutCciurabDKu7MVx6B/mQh6rhn2GShLc+bqnzyWGA+D8Wct23ZP2r4NQzctj18GX+CYCxlR+m3Hz1q6hy9nOwyRLHtrH0ANRHfkUVY6jhJumHL4MCZUUfOrTyY+m59rz86EnCLxr6sfNkxfk8sXdsX1WtxhP64yRM1If7QChCeSdYTMPqo8q3xR6T3Bzl7Bv6p7si57DnWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qD8hgf0j4oM2DK0g/aNG6G2tw0k2on5OnN55PJAdGo=;
 b=SpWwvkUYWw8RfUxRe1/OlU02+13wc4rDNUynCXy1pOOYeSg7Oy0ouOb/2Z1NzCCyO0gXs6pCQ55LTxwWo+zWs5ZXXlOSvBI2aJ8MQfMexVheCDSGqkABIulJSS3ySEdOHfOdBj64y1qm7mOzPgvBs1b4DUTHuo2EfA749PA4KRQ=
Received: from BN1PR12CA0005.namprd12.prod.outlook.com (2603:10b6:408:e1::10)
 by MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 16:15:57 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::fa) by BN1PR12CA0005.outlook.office365.com
 (2603:10b6:408:e1::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.26 via Frontend Transport; Tue, 14 Feb 2023 16:15:57 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:55 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 8/8] drm/amdgpu: start using kernel doorbell bo
Date: Tue, 14 Feb 2023 17:15:10 +0100
Message-ID: <20230214161510.2153-9-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230214161510.2153-1-shashank.sharma@amd.com>
References: <20230214161510.2153-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 614ef0dd-87d2-4cc2-d267-08db0ea6c160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aXKJrDMB+Z1JbOrnfrGK2k7itSBMRoCDzSKYyjN9zWNVCWMmZ53joXvWXZeTuu1xVyhOqf0XDyUJ9MCGYaIC5YhGZy7htWoxDfBxDn5MGD7vUpBIX7glO2H65NVmXmjmeo4uhKP48wq4ydJBk/f6AamylcKep4Vbs3JhN8CBikbb3yy/grRfisS4oqNl8qXwN7QY2nvFPXo98ugSt5Ms7mLA5suwS53PcgDJ3a0+af3zOShBtLRjtkwMtadjt5YWFv5mE2TzvTYdEtXtnKqAo9d4/FMdHUNTB8cwEzrVo9+7G2feyOPszpBOkkavLH2Rvv5uJtU0Irv4i4YMUBjYlLAAM6XWdEmICxWinLn0F9A4bRE8wNrtGFh5N9yJb6thnV04RsM7yoQb0OJyk2xVRqdG9skdDM6iF0G7gX/3NS3TsLw5VDGzUJvhqxUjzBnvz8iOSX2OaMCFCJnqxO/VosPrSMqyxopTN1ifbS4k30JjBYcOgzNPX+q0e+viFQZ/DTf3P0KFideaUiXdK9R86k3UIyGcj05Wwdp5dYW0uRnMzKY15SBdlFw/FMwzmO0JDqpd+HfcPnBe8v9jiZdCchKfsyBX5RpAAl9q+BL8+tQSDxdtaGFEQkwoURh2p0/U5zf4qK1qy/OV/mtRERE7yM84IYp22NfZMSugwqPJQ8cqgdhKVdY5V9AGDVy19vfXAAoVXBJRBfhnhC3k/ZVuwRbv69q9LAlusc83CDzFqMs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(1076003)(4326008)(41300700001)(5660300002)(6916009)(36756003)(81166007)(86362001)(70586007)(70206006)(40460700003)(356005)(478600001)(40480700001)(336012)(2616005)(426003)(47076005)(2906002)(82740400003)(8676002)(82310400005)(316002)(54906003)(6666004)(26005)(83380400001)(7696005)(16526019)(44832011)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:57.4296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 614ef0dd-87d2-4cc2-d267-08db0ea6c160
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 Arvind.Yadav@amd.com, shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch does the following:

- Adds new variables like mman.doorbell_bo_size/gpu_addr/cpu_addr.
  The cpu_addr ptr will be used now for doorbell read/write from
  doorbell BAR.
- Adjusts the existing code to use kernel doorbell BO's size and its
  cpu_address.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 33 +++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  1 -
 3 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0493c64e9d0a..87f486f522ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -109,11 +109,10 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 		*aperture_base = adev->doorbell.doorbell_aper_base;
 		*aperture_size = 0;
 		*start_offset = 0;
-	} else if (adev->doorbell.doorbell_aper_size > adev->doorbell.num_doorbells *
-						sizeof(u32)) {
+	} else if (adev->doorbell.doorbell_aper_size > adev->mman.doorbell_kernel_bo_size) {
 		*aperture_base = adev->doorbell.doorbell_aper_base;
 		*aperture_size = adev->doorbell.doorbell_aper_size;
-		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
+		*start_offset = adev->mman.doorbell_kernel_bo_size;
 	} else {
 		*aperture_base = 0;
 		*aperture_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 43c1b67c2778..fde199434579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -596,8 +596,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
-		return readl(adev->mman.doorbell_aper_base_kaddr + index);
+	if (index < adev->mman.num_kernel_doorbells) {
+		return readl(adev->mman.doorbell_cpu_addr + index);
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -619,8 +619,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
-		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
+	if (index < adev->mman.num_kernel_doorbells) {
+		writel(v, adev->mman.doorbell_cpu_addr + index);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -640,8 +640,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
-		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
+	if (index < adev->mman.num_kernel_doorbells) {
+		return atomic64_read((atomic64_t *)(adev->mman.doorbell_cpu_addr + index));
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -663,8 +663,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
-		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
+	if (index < adev->mman.num_kernel_doorbells) {
+		atomic64_set((atomic64_t *)(adev->mman.doorbell_cpu_addr + index), v);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -1037,7 +1037,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	if (adev->asic_type < CHIP_BONAIRE) {
 		adev->doorbell.doorbell_aper_base = 0;
 		adev->doorbell.doorbell_aper_size = 0;
-		adev->doorbell.num_doorbells = 0;
+		adev->mman.num_kernel_doorbells = 0;
 		adev->mman.doorbell_aper_base_kaddr = NULL;
 		return 0;
 	}
@@ -1052,13 +1052,13 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	adev->doorbell.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
 
 	if (adev->enable_mes) {
-		adev->doorbell.num_doorbells =
+		adev->mman.num_kernel_doorbells =
 			adev->doorbell.doorbell_aper_size / sizeof(u32);
 	} else {
-		adev->doorbell.num_doorbells =
+		adev->mman.num_kernel_doorbells =
 			min_t(u32, adev->doorbell.doorbell_aper_size / sizeof(u32),
 			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_doorbells == 0)
+		if (adev->mman.num_kernel_doorbells == 0)
 			return -EINVAL;
 
 		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
@@ -1068,15 +1068,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 		 * the max num_doorbells should + 1 page (0x400 in dword)
 		 */
 		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_doorbells += 0x400;
+			adev->mman.num_kernel_doorbells += 0x400;
 	}
 
-	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->doorbell.doorbell_aper_base,
-						      adev->doorbell.num_doorbells *
-						      sizeof(u32));
-	if (adev->mman.doorbell_aper_base_kaddr == NULL)
-		return -ENOMEM;
-
+	adev->mman.doorbell_kernel_bo_size = adev->mman.num_kernel_doorbells * sizeof(u32);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 526b6b4a86dd..7bdff4f926ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -28,7 +28,6 @@ struct amdgpu_doorbell {
 	/* doorbell mmio */
 	resource_size_t		doorbell_aper_base;
 	resource_size_t		doorbell_aper_size;
-	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
 };
 
 /* Reserved doorbells for amdgpu (including multimedia).
-- 
2.34.1

