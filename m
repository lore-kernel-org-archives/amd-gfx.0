Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7FCCCA47F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 18:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8D48E97D;
	Tue, 19 Jul 2022 18:35:11 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8533A8BB72
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 18:35:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Buk6kmxJBvQICWcTvv5NDfnMxz8qrvU7JrOavYJVvu95FLHP1D/K43rtC4FXe2nZOcNe6AQLYyikBUwv3JfzLm4/FYAC30KcTvAxiFFwamXDz+uOHaTCFi7lnOdXhlocyERAlK0oloF/BgzLhGtuvcmYImNix6dAzzovxX9mS56qfTEsOw32ik4nlJqrHMdek22QkuNeo9QmXxujrQBlw5yWSnzewJLmAEP3z+1zOjLS1qnwUXJELsctUKNTU/Ry5hmbYF8Q29V9I3XwAHv7DpCZiqFrWOUZ0Fu5jjix1OVByN2twO8D9FSnongjpcnTFrUavVY8+sVOL+3NXYecUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFy0jP2W3wTc1tAtQfR2+2cqrmuGmkaPdG0qKOOULHE=;
 b=L6yuoQyHrFKCJq5gAwtLVM9vZTOz/gIl9P2DdoCORVNJ71vWpcC4DBFJSO9QKdGPM37utIT5SH2fYYaccEkrjRF7P0tN0bLmqVT7LntoTGYHdIioGG0mRDlXde5U0LWqjFK8Mz6LWE7KqpFXjyJia+spSKSY2ANr9kXoPJ3dYzK8K5iEcPFWQru6c/Hp/gEieilQJTq4RWNS68Os88GHJMejGiyP7Id+L0EsR9S9Zq46CgbmjFKP0MudJh2xUCsu5HPGdxR1BFsuV/2Cdj7Pt207jPqd/wSL652T4TQX/rO6UOx0jpEAf3cJvWDvw4kN7t64qezu4kq6Vx/5iZw0Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFy0jP2W3wTc1tAtQfR2+2cqrmuGmkaPdG0qKOOULHE=;
 b=G3AHKoMMeaPcOZEJ3K+jMncQlrARS3gwZviOm16jcA+ivEy9RDIgwCAgz2An9ghFmrUCs3J3ODpkjE2qxEIhIjq56JR2WD1dU4hKTdbOd8wD+sFjLf+2W4QKz7KRE1D8Uz+7icB5kYKWzCEgwfcxYvIxRwRZz8apj8lvvHQepK4=
Received: from MW4PR03CA0001.namprd03.prod.outlook.com (2603:10b6:303:8f::6)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 18:35:06 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e6) by MW4PR03CA0001.outlook.office365.com
 (2603:10b6:303:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17 via Frontend
 Transport; Tue, 19 Jul 2022 18:35:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 18:35:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 19 Jul
 2022 13:34:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: rework SR-IOV virtual display handling
Date: Tue, 19 Jul 2022 14:34:34 -0400
Message-ID: <20220719183436.1705006-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220719183436.1705006-1-alexander.deucher@amd.com>
References: <20220719183436.1705006-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5413205-5371-4115-2c40-08da69b5671e
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZI43BEQbiIv3HzjEjdqPEbmcvLZYkmwtYzgpXFitm3Tsx5Rzv/SxVV5CRSejA1uSA/yssOoEIXlb4IU61Cr89FJboaL3qLEQrww1p1utXH5ZeUut1G607Ei91V6PkYrsf2ncsH5aJwPPEc7uKk4LZIp2GS5AyqMBlxT3CqFE11vlt8GrXfwnDFb53QTUDx0bT/YUFS3PO1Ma2UdLDZoVh89ITf++Te8sKA7O1s1lVA1DLTeNx9nB/ZqRDrrlNKrSgGvnEQ23NgTnVlO29JKm4r+QjggDqhzVJ+sNRw3q/JChX5h0f4t9hnzIj3+R1Ko8vqQzzg4U6Hi/Th4mK7Hl7VpDDh77aBoOcy0YftbhCNwLGWDDF81yuZeG81OKq52NLJHVSKqeXGAmIopBiHFMVj8N8SRdofUg9alL+rXgU1a3G4p3oR20yoDepeom6KPdeZ/Z+8LPNUFCm8kYkzEBnnfZO818FVRn1kpya2npZGXvjiamJx4PNPBeDqfhvLT9aDKkXTJM7HXSCIr0k0ZLzV/OebOPZaqKWGbfvA/3cqtNCviyppGB9z9PURCVlnuT/4grUOrqnMAR7gss7I3xbJkzdlvUTFfvsd1oxvCE3jRpbRZXxk7hhegORo/TMjyWQvbV9LPF4/1eouKO/M+Mpvk5N53A9kFmsaCeX+V1z+WWvA7m0mphPRDY4fLFvp6DaH8+STs9CXNlMol2yHY9hfM32WoHfsRYeTsewnILjQhsLzscAVEWqAu2IrhXxorJ0yZPGU4ghIcILsCU6LfYZuGxphRCkAaf7+EyrbyViE+FhbRv9HRkVjbr2vEJMHW03bVgVoQW08kAz96SqPzUug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(40470700004)(478600001)(8936002)(8676002)(4326008)(316002)(6916009)(86362001)(36860700001)(70206006)(70586007)(40460700003)(2616005)(36756003)(47076005)(2906002)(7696005)(41300700001)(26005)(1076003)(82310400005)(356005)(5660300002)(40480700001)(83380400001)(426003)(81166007)(186003)(16526019)(336012)(6666004)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 18:35:06.4030 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5413205-5371-4115-2c40-08da69b5671e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

virtual display is enabled unconditionally in SR-IOV, but
without specifying the virtual_display module, the number
of crtcs defaults to 0.  Set a single display by default
for SR-IOV if the virtual_display parameter is not set.
Only enable virtual display by default on SR-IOV on asics
which actually have display hardware.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 13 +++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 18 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/vi.c               |  6 ++++--
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 1734d967c35e..f111694cea2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1116,6 +1116,8 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
 bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type);
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev);
 
+void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev);
+
 int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 				 struct amdgpu_reset_context *reset_context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 041bd906449d..f7ffd60e1dd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1915,6 +1915,16 @@ static void amdgpu_device_enable_virtual_display(struct amdgpu_device *adev)
 	}
 }
 
+void amdgpu_device_set_sriov_virtual_display(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev) && !adev->enable_virtual_display) {
+		adev->mode_info.num_crtc = 1;
+		adev->enable_virtual_display = true;
+		DRM_INFO("virtual_display:%d, num_crtc:%d\n",
+			 adev->enable_virtual_display, adev->mode_info.num_crtc);
+	}
+}
+
 /**
  * amdgpu_device_parse_gpu_info_fw - parse gpu info firmware
  *
@@ -3317,8 +3327,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
  */
 bool amdgpu_device_has_dc_support(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev) ||
-	    adev->enable_virtual_display ||
+	if (adev->enable_virtual_display ||
 	    (adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK))
 		return false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 22144ba6c7ec..ced70bf3e14a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1698,9 +1698,15 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_discovery_set_sriov_display(struct amdgpu_device *adev)
+{
+	amdgpu_device_set_sriov_virtual_display(adev);
+	amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
+}
+
 static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 {
-	if (adev->enable_virtual_display || amdgpu_sriov_vf(adev)) {
+	if (adev->enable_virtual_display) {
 		amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 		return 0;
 	}
@@ -1727,7 +1733,10 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 6):
 		case IP_VERSION(3, 2, 0):
 		case IP_VERSION(3, 2, 1):
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_discovery_set_sriov_display(adev);
+			else
+				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
 			dev_err(adev->dev,
@@ -1740,7 +1749,10 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 		case IP_VERSION(12, 1, 0):
-			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			if (amdgpu_sriov_vf(adev))
+				amdgpu_discovery_set_sriov_display(adev);
+			else
+				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
 		default:
 			dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index f6ffd7c96ff9..12ef782eb478 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -2111,6 +2111,8 @@ void vi_set_virt_ops(struct amdgpu_device *adev)
 
 int vi_set_ip_blocks(struct amdgpu_device *adev)
 {
+	amdgpu_device_set_sriov_virtual_display(adev);
+
 	switch (adev->asic_type) {
 	case CHIP_TOPAZ:
 		/* topaz has no DCE, UVD, VCE */
@@ -2130,7 +2132,7 @@ int vi_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v8_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
@@ -2150,7 +2152,7 @@ int vi_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v8_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &sdma_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &pp_smu_ip_block);
-		if (adev->enable_virtual_display || amdgpu_sriov_vf(adev))
+		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &amdgpu_vkms_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
 		else if (amdgpu_device_has_dc_support(adev))
-- 
2.35.3

