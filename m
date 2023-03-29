Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42CDC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFD910EB63;
	Wed, 29 Mar 2023 15:48:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C2E610EB6D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoPIcCvWbSVIkedg0kqxDg/FiM5vlA/2MKBTVRCu7ux0yN2knevLM0B9V7KcwHYoAV62wUwome3Ljn151KdXdXdEu4I9lhqIsJp9Rz6MG6JYLfBNxX9WcM4rJ5nQxa1xnYuFWfCdCnlNTfBUhZWqbilMmxmS+CSDETKmEKIZeomnqmZVbLHYO7n53f4bq3aZ4KUK+W2qgZtu6801DE+g5FFKXzEj2XEgd3zPhKeehvU6wG2ecoL+PDf0YB8beQ5nywkkgZI2LrdoGfiMrS0q/AKxTlhopsYBln8+O8/VwTWHELdSiDW/+TC6RlUxlg8KBYlLyL6SR/HNBA01ksOcyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO58dQGYaeXgwk2XnYFpegmEoAV7oU9JZ+3uN+Y8rd8=;
 b=cKPy6O3TLF/qwZYU4mE7Q0wcvtnTf7l6C29EVP/YmIxU+ivXSKOSt0LDRbPhdiuf8p7GaRxWc3fDe3JCwwpsPpwW1Fth+W1+bG0bK4fGorDsozm/3Hq7F1+FCiNEDBqa11vDTMW1hEbRZqxpjvYsDfHfOuZDkPQMIS8qM0I7BByezkGqE6aaQqVmstepDpGpB0WdRbE6j0EtR34k0SfWcissPe0q/c1blcVGYWfIGsHgRBWg78wnMVKl4xEr2aOp2Ptt2OfV+WCqDVO14QSFqnul0Zs1XEp5ym7SJZiolSrN1zp1OKqbJXLFEnF+scS/9gsgDH2v4egClC5hBk//Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO58dQGYaeXgwk2XnYFpegmEoAV7oU9JZ+3uN+Y8rd8=;
 b=v0zyXNXqegHQyOZSLWEhv4b3UVipXYTpsfzdfDJGSw6s78De8be7ockzZW+ntPdqIOEdkHmW8QUlzGmskOUCIM7J+amaD1zEpFu/NyHko5CqaFC5TYU+l087WIo5GMfWgL+4xONA/yyl81YJFsF5IPcLYNj3GhWPHIuyVnwiaBQ=
Received: from DS7PR05CA0051.namprd05.prod.outlook.com (2603:10b6:8:2f::12) by
 SA3PR12MB7880.namprd12.prod.outlook.com (2603:10b6:806:305::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Wed, 29 Mar
 2023 15:48:16 +0000
Received: from DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::94) by DS7PR05CA0051.outlook.office365.com
 (2603:10b6:8:2f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT085.mail.protection.outlook.com (10.13.172.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 15:48:15 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:14 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/16] drm/amdgpu: rename num_doorbells
Date: Wed, 29 Mar 2023 17:47:38 +0200
Message-ID: <20230329154753.1261-2-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT085:EE_|SA3PR12MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: edca637f-54ab-4d94-e3f9-08db306d02d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q4vX0RFVg8Ue/8Zlwz9Al5r1QOvP+3tqyGfwn3YVI9KS6SOHM58nMMLUHFgmLmu1zr2kp8joej6yHIeVdSxmIdVr8/TVg77RS22GNbgUP8a8DBQP383H/I1OQiJSP8C6Wp7bEBEkaJKlMtecVkwj6enq/7FLtOyitNfAsDD3enEEQSCFs0LIgcjJAVXU7QG5TY2TXtBAo7iH4xPGqxNqqGq+oo3b9Zx7DOSCRsjTKnbK4pO34l5JlcUjj/SPUW3Zdq7r37+ofItFNu+FL6hikJrCaMUSHxxTZFBdMj4H3qKx+tjMt9yLCC0ezw9z6/nTcR1ky4W+PicQKsOCdTCpxic4ajZdyAoIrMjBY+uT9waaFxNl4tu0N8OfcyeJDrz4iEn93ngYedOaRVO2eeUSAj7safNWnitpSW1aKBvrH9rcoB1UUsV3s0AOTwJFhXhXlt4Gfe/29xK254H53NxcDANCBMsn0Gg1rH+Gpwh/WEwcAMq8fh2awkeuxfX29QhWcN+FdhLAXNYVbdf7yxTcc8PwaKK5QLKCm/hSPnGy8TyDtG+RQaUuNb6IVoAoP7EeVZx5XZietKaQzNGFngf2pk/0yPuLXF3YEiNpxHbpq26tFNDdZhtNYW3TD/m4vks+jJF80lBhJzfNuhzbEwvWDEA7nQ9/jKBX/p7s2cIG94yKyBuNXhgwvk0pZat1aYvLwJJgh4i9jaiS4M5W4KaCaj00tyBf4M8DQTNTUsllpEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(40460700003)(5660300002)(6916009)(4326008)(70586007)(44832011)(70206006)(186003)(36860700001)(316002)(26005)(41300700001)(82740400003)(1076003)(8936002)(356005)(54906003)(16526019)(83380400001)(7696005)(8676002)(2616005)(47076005)(336012)(6666004)(426003)(81166007)(36756003)(40480700001)(86362001)(82310400005)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:15.9547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edca637f-54ab-4d94-e3f9-08db306d02d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7880
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

Rename doorbell.num_doorbells to doorbell.num_kernel_doorbells to
make it more readable.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 22 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  4 +++-
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f99d4873bf22..0385f7f69278 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -96,7 +96,7 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 					 size_t *start_offset)
 {
 	/*
-	 * The first num_doorbells are used by amdgpu.
+	 * The first num_kernel_doorbells are used by amdgpu.
 	 * amdkfd takes whatever's left in the aperture.
 	 */
 	if (adev->enable_mes) {
@@ -109,11 +109,11 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 		*aperture_base = adev->doorbell.base;
 		*aperture_size = 0;
 		*start_offset = 0;
-	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
+	} else if (adev->doorbell.size > adev->doorbell.num_kernel_doorbells *
 						sizeof(u32)) {
 		*aperture_base = adev->doorbell.base;
 		*aperture_size = adev->doorbell.size;
-		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
+		*start_offset = adev->doorbell.num_kernel_doorbells * sizeof(u32);
 	} else {
 		*aperture_base = 0;
 		*aperture_size = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index afe6af9c0138..57ee1c4a81e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -593,7 +593,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
+	if (index < adev->doorbell.num_kernel_doorbells) {
 		return readl(adev->doorbell.ptr + index);
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
@@ -616,7 +616,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
+	if (index < adev->doorbell.num_kernel_doorbells) {
 		writel(v, adev->doorbell.ptr + index);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
@@ -637,7 +637,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 	if (amdgpu_device_skip_hw_access(adev))
 		return 0;
 
-	if (index < adev->doorbell.num_doorbells) {
+	if (index < adev->doorbell.num_kernel_doorbells) {
 		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
@@ -660,7 +660,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 	if (amdgpu_device_skip_hw_access(adev))
 		return;
 
-	if (index < adev->doorbell.num_doorbells) {
+	if (index < adev->doorbell.num_kernel_doorbells) {
 		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
@@ -1034,7 +1034,7 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	if (adev->asic_type < CHIP_BONAIRE) {
 		adev->doorbell.base = 0;
 		adev->doorbell.size = 0;
-		adev->doorbell.num_doorbells = 0;
+		adev->doorbell.num_kernel_doorbells = 0;
 		adev->doorbell.ptr = NULL;
 		return 0;
 	}
@@ -1049,27 +1049,27 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
 
 	if (adev->enable_mes) {
-		adev->doorbell.num_doorbells =
+		adev->doorbell.num_kernel_doorbells =
 			adev->doorbell.size / sizeof(u32);
 	} else {
-		adev->doorbell.num_doorbells =
+		adev->doorbell.num_kernel_doorbells =
 			min_t(u32, adev->doorbell.size / sizeof(u32),
 			      adev->doorbell_index.max_assignment+1);
-		if (adev->doorbell.num_doorbells == 0)
+		if (adev->doorbell.num_kernel_doorbells == 0)
 			return -EINVAL;
 
 		/* For Vega, reserve and map two pages on doorbell BAR since SDMA
 		 * paging queue doorbell use the second page. The
 		 * AMDGPU_DOORBELL64_MAX_ASSIGNMENT definition assumes all the
 		 * doorbells are in the first page. So with paging queue enabled,
-		 * the max num_doorbells should + 1 page (0x400 in dword)
+		 * the max num_kernel_doorbells should + 1 page (0x400 in dword)
 		 */
 		if (adev->asic_type >= CHIP_VEGA10)
-			adev->doorbell.num_doorbells += 0x400;
+			adev->doorbell.num_kernel_doorbells += 0x400;
 	}
 
 	adev->doorbell.ptr = ioremap(adev->doorbell.base,
-				     adev->doorbell.num_doorbells *
+				     adev->doorbell.num_kernel_doorbells *
 				     sizeof(u32));
 	if (adev->doorbell.ptr == NULL)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 7199b6b0be81..12263986f889 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -29,7 +29,9 @@ struct amdgpu_doorbell {
 	resource_size_t		base;
 	resource_size_t		size;
 	u32 __iomem		*ptr;
-	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
+
+	/* Number of doorbells reserved for amdgpu kernel driver */
+	u32 num_kernel_doorbells;
 };
 
 /* Reserved doorbells for amdgpu (including multimedia).
-- 
2.40.0

