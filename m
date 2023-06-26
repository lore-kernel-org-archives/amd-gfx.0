Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732AAEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E015910E218;
	Mon, 26 Jun 2023 15:04:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8459210E216
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2B/QtdLoz/H81MfrBcr+G4xCeAUYM2okzK3fOR88/HQnHf5+690rcmR2NpRIBqfM/l9P38NGrGP+ETWRyx6hxGbUSHkrTtrq2IvnOkEBnQo+rrH55ayfwP/3WAG282L38Fbv3vjy7mELpCRZQ9/BN0OyFLs7Ms12x3EOha7bFSyxzMoQ1kK/pdCHx2BoSp2bIfec+i6NcBJesTSYkehN1XF5Ve2QjHhMkQNLSNu+/PEjdvKTq3gYSgn7nC/ATIX6G3etYcynOp2D2h7WbyDVbtdjggI5M7xMHvd+hOwiJmIcnxegWoNJ5x6g6YODBRbF0t1zGw9hBmTXLh9aLPFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrLy6LiocCnkdfNEH4ST7C1Ip0kz+tKHRWL17k0knAg=;
 b=WQ2l2tKGiKP8HA6eLi1P6zAUX1x3gSrHtmEdS/K7DCJyMrbU0IkVz/OhrxG7S3RTG54oVYQn/zHvfXm/Jsb5/Bi4PJRPbrb/PX/llUnDOebJkckHz8DnAoNsuzp8el+x0sCowz1DosqfRRD8/NuxRcWbPufc8lY54iRzQlt2oaL+IzfcY/lFYXPCoyyWmJ95/D6U1S1MmYZE72bmxcvN8bPH7tw1GY8ViR5dIWOa0OiPojLeLYPQwXIS/VNo+x41cR5dsNDXNCxWQJO7gX15yAm/aeU6eGZVhxbc+/1502N3GCjsSBjLs2gVilrbKlEtx4np1jRxAnUbee7K+nMK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrLy6LiocCnkdfNEH4ST7C1Ip0kz+tKHRWL17k0knAg=;
 b=FU8ULiznf6T32X+hNTAXW8QajiE6BLL7G5bcgmtjopGdTPF+f2NO2bNP5ox8Al+QGujSwUeWUVLXpQ6DY1EulbqL9wA6FYoaASG7uh4tEPAuAY2SdN4MPF6O0EIL7RW4BDtoS2r/45LiVVolgrLWjDhystfCsL/FKq0dg8jOZd0=
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by LV2PR12MB6014.namprd12.prod.outlook.com (2603:10b6:408:170::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Mon, 26 Jun
 2023 15:04:27 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::e2) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 15:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 15:04:27 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 10:04:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amd: Convert USB-C PD F/W attributes into groups
Date: Mon, 26 Jun 2023 10:04:06 -0500
Message-ID: <20230626150407.1447-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626150407.1447-1-mario.limonciello@amd.com>
References: <20230626150407.1447-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|LV2PR12MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: a753dba9-0c67-41df-840d-08db7656a2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRsUb+Zg17k7/X9kFECU1TGsSipzdK/DUEYDx+sQwOhS9GtVNJquvpHCj/zeU8o5Ony9Knuk2Vkpigoj9JasQ2YdS8QA/9hO3chFLbHxvqKWSDenjqQ/2dU+pLjDZDrFIdWKQ+/RtZaaQA4eDN3AD1P5FDvVqwKnMnHzEH9epHoS0O78n0ekSAuYUf87e85Zk39hZjps8T5if+rcDzywaIe724x3dih+z2hZKOP0VsoFwJfCbrIp7bXLfqzAS+5MGsh4i8AkDX8qAxh9GOGcvcAkXvdBia/0VyukE5z7Bz7aQ1Dv79YX7tvrCRaGHXG4foujZ6+ZL4xeWKr2e2jo10mPecm2PJBP1wAYjLadXGv8tQPIJSLEfdPnMj+KqVXoPjBFvbjSUl8SnPCskwm0LAIfhWBLAlrV5SCdG09SfVchQYpNG32j+2WMYmFsp9Cw7LTsIaiXkfP2ZGOBhkQW7FzBeUJWpWfnaokMhgPSf9+X+d5tvwuy1gmUVGLQUEdi+bACMcekNCZfbD/Qw105PmTIde+A70yRaCYFDrdAEMWTj97ukSz12AMUX0DUW06iR8eIS4KxCidBXHic2scIGoRm81GKEk7K/m1Mwn2UFpGf7zYuzWF5q0zUVymQjNOyOxUvbiaRvAaX53IstL0rmqbT4cMr6M3e8QAGNAjgKIC0mM2TDSJJSZtvXhSNrz0WLoLV0Ab6RdaG4UTcxKNlyyw07a+TYUeoo+zfYVtWNJVvQObmypXrLW2WoW34gYP3tzQENN71EsHHau944iBLJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(2906002)(47076005)(478600001)(426003)(7696005)(2616005)(6666004)(83380400001)(336012)(16526019)(26005)(186003)(1076003)(5660300002)(356005)(44832011)(40460700003)(36756003)(70206006)(81166007)(40480700001)(82740400003)(70586007)(316002)(4326008)(8936002)(8676002)(41300700001)(86362001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:04:27.2177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a753dba9-0c67-41df-840d-08db7656a2d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6014
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rather than special casing the creation of the file, special case
the visibility to the supported dGPUs.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 40 ++++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 -
 2 files changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 93d014e69ee39..7872004ed7f9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -45,9 +45,6 @@
 
 #define AMD_VBIOS_FILE_MAX_SIZE_B      (1024*1024*3)
 
-static int psp_sysfs_init(struct amdgpu_device *adev);
-static void psp_sysfs_fini(struct amdgpu_device *adev);
-
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
@@ -456,14 +453,6 @@ static int psp_sw_init(void *handle)
 		}
 	}
 
-	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
-	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7)) {
-		ret= psp_sysfs_init(adev);
-		if (ret) {
-			return ret;
-		}
-	}
-
 	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
 				      amdgpu_sriov_vf(adev) ?
 				      AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
@@ -513,10 +502,6 @@ static int psp_sw_fini(void *handle)
 	amdgpu_ucode_release(&psp->cap_fw);
 	amdgpu_ucode_release(&psp->toc_fw);
 
-	if (adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 0) ||
-	    adev->ip_versions[MP0_HWIP][0] == IP_VERSION(11, 0, 7))
-		psp_sysfs_fini(adev);
-
 	kfree(cmd);
 	cmd = NULL;
 
@@ -3612,6 +3597,7 @@ static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
 static struct attribute *flash_attrs[] = {
 	&dev_attr_psp_vbflash_status.attr,
 	&psp_vbflash_bin_attr.attr,
+	&dev_attr_usbc_pd_fw.attr,
 	NULL
 };
 
@@ -3625,9 +3611,16 @@ static umode_t amdgpu_flash_attr_is_visible(struct kobject *kobj, struct attribu
 		return 0;
 
 	switch (adev->ip_versions[MP0_HWIP][0]) {
+	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 7):
+		if (attr == &dev_attr_usbc_pd_fw.attr)
+			return 0660;
+		return 0;
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
-		if (attr == &psp_vbflash_bin_attr.attr)
+		if (attr == &dev_attr_usbc_pd_fw.attr)
+			return 0;
+		else if (attr == &psp_vbflash_bin_attr.attr)
 			return 0660;
 		return 0440;
 	default:
@@ -3658,21 +3651,6 @@ const struct amd_ip_funcs psp_ip_funcs = {
 	.set_powergating_state = psp_set_powergating_state,
 };
 
-static int psp_sysfs_init(struct amdgpu_device *adev)
-{
-	int ret = device_create_file(adev->dev, &dev_attr_usbc_pd_fw);
-
-	if (ret)
-		DRM_ERROR("Failed to create USBC PD FW control file!");
-
-	return ret;
-}
-
-static void psp_sysfs_fini(struct amdgpu_device *adev)
-{
-	device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
-}
-
 const struct amdgpu_ip_block_version psp_v3_1_ip_block =
 {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index b441c07e5a16f..619b27e891b5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -521,5 +521,4 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
-int amdgpu_psp_sysfs_init(struct amdgpu_device *adev);
 #endif
-- 
2.34.1

