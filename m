Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D97B7CCD18C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Oct 2025 18:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779D410EC7B;
	Fri, 10 Oct 2025 18:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="362OsN3F";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82BE410EC7C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Oct 2025 18:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l77JFVFemwrHd09KNveWvFL2I5w+reI/5TTMGy8jEQz46/6Xu2weJCdYPr2/1HEsY+Kz0sbuvJZF9A+ctWlfKwS9ZEHX3YUEeQEu8joKid4Q/A4C5Vx57eap2LQ5mxXXdNVDgvciTlnmmiuVnVLGKjsv83VfrU4wsofv2KjKQcBBhXyZ4MLy2TTmJiUH5MzhqSTGFCHzz3V3Nu2WNsaWGOcN/D/6M5zSIDUjubKKIHKnoSvsn7Skjo0dWB30p03fPOz6wdrwAnpLOjzYkHvjT9IazU5wPtTLQk9nU1ppKQla7hr8OiHYHBl4/uhKtpGUZtJOjcUF+MywKTg7NDhG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dah/lrpUE2m08ldz5Fcg0x3n0rQLeFmPss20cR2+O+Y=;
 b=XKaKczGav586D0pgcfSD8+VKjrrO4Z6tduE9sWzKGAcMUmqbO6x9ThZK5lqgUxtH/EXmsfS2Rc6IuEI9KLlAjYWAgQIOAvHT/+pSuNu2jc5dPg1jW3TCfmHRk/7iuwbZKqAefwdZYfk7hXQcihM26YNLc5A099BJ0bKNxFqP09K7jz7KAhKa/jaKH+VN2FnfWPMDYj7KO6tabNsgWoB42+SBNM9EUvacZci2Ld8KeIVQThYPD57jHseO9xj91dWacxA9pUBbk/3+65rFkLw8UjsCu7xaZYahq784kbcUzojnxEbn/xMa8o0mIs6cYsM3oTkjpTdFoH4XMSe5ibHrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dah/lrpUE2m08ldz5Fcg0x3n0rQLeFmPss20cR2+O+Y=;
 b=362OsN3FHgrdACuGUu/JrtN9bAO2mNfHamI6LDhVyhPtDgEYEc1Ea4es7WvChhnGz82sdN3LbstLBXqTktXPhBLOEERxbB5csWvqjYC1X0EdQKLy/sPeqzZJwOvQVmEFzg296xQDbqyfjQkbubyDQx1bvcIRha3q2HCAIT5zsMg=
Received: from CH0PR04CA0061.namprd04.prod.outlook.com (2603:10b6:610:74::6)
 by MW4PR12MB6826.namprd12.prod.outlook.com (2603:10b6:303:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 18:49:06 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::89) by CH0PR04CA0061.outlook.office365.com
 (2603:10b6:610:74::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 18:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Fri, 10 Oct 2025 18:49:06 +0000
Received: from cv350-ccs-aus-h13-08.cs-aus.dcgpu (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Oct 2025 11:49:04 -0700
From: Ellen Pan <yunru.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Jeffrey.Chan@amd.com>, Ellen Pan <yunru.pan@amd.com>
Subject: [PATCH v3 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to init
 from dynamic crit_region offsets
Date: Fri, 10 Oct 2025 13:48:48 -0500
Message-ID: <20251010184849.9701-5-yunru.pan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010184849.9701-1-yunru.pan@amd.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MW4PR12MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: db6fae14-7cb0-421d-7513-08de082db0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dvMtQSc9EpLxlIplFBW9WD29Blk/Fcp+6y99m7WoS3M5M4uZs3+EtfFKbtB1?=
 =?us-ascii?Q?df3ZFgmF42k/0PJAwIamp2v6ZDal5nvxzCsA26zFENlTptRulMmh+oZ/niA4?=
 =?us-ascii?Q?7tn8s4p4Y0cv24t25HlH4y74s1o3xK97vgi4Hve35yhlI9YHsnF4+v/zACsp?=
 =?us-ascii?Q?kMzgkid4aWihtsN/RGXe5l80MB2SBs6hXFloy+8XMtkOh154oFyX1rEIGyjF?=
 =?us-ascii?Q?gVqkHeZFtu4PjRSJ+MKS1Dgk/q5RkL2u7O+RfklIvRYztWF5ilRyFZDHGaAZ?=
 =?us-ascii?Q?+sNeNffPgWofgK6oodGFfyGbykdOYoJI99KO4+JXMPSXflpicCP2xX/mImM1?=
 =?us-ascii?Q?5MeQ/PRYKLwu0xqFFC213fmL02ooLuzFOBBbsyStUA4/+QLecIolbrLA3aTE?=
 =?us-ascii?Q?e6w/o9LHuRTi7h1GjqvTKMPg439rgry8M/MXD/Ro9BY7GLulrgs/v26CtzyM?=
 =?us-ascii?Q?8gvIA5EVkOqfpU+vM899QpRZ2Dc21V/pxI9BlJBVmNx9leS4WTuxNnhGN5yG?=
 =?us-ascii?Q?/NKUZMDaeH4OLKrv9KKi+vV31KogUiRf2W/lPUSavndcsnoTlWET21DHjhdu?=
 =?us-ascii?Q?lkrnNCgDy1at/Oef6AHgXSvGo8oSlfMz9WeMMHNE8UFwZfLl8P4VheMWm7ap?=
 =?us-ascii?Q?oxVPbWb1RRZNF93jUgPC40vUVMeltDIwmKfz5BVV3utUNgyxXFSjTm8gCktE?=
 =?us-ascii?Q?li0dVaujEPAyN2/BiPEiKFbK7E4cYaQeuLS61p8uykVNI5zz3H5vOC1dJ7el?=
 =?us-ascii?Q?xXEQTmPtqKYRpJPguGV+LVTAB9H9VjFocFagZW0mxNvb9ZsToCgY3h0gvxl4?=
 =?us-ascii?Q?mZqDu5Ap07MNqd14niNjW1nsxWEOH7wxzIFw+ndhtWrazGHOqHPAkYFKqUIT?=
 =?us-ascii?Q?gW5EHwRgLzluBN9/P+WDM1hmAT1D7q9b00GXPjc1qzbCucyo0Au+EBxethpl?=
 =?us-ascii?Q?P0d7h0PPwdn2dohpRez41rkoSpJrwvQBOf+R2mEWYyR44TZdN69+QiLp9SvL?=
 =?us-ascii?Q?TScseBHQzXrhmHaa508nvTiIoeMa/r0UpFp1B47cubKn7Va4bPHooNgLDcpa?=
 =?us-ascii?Q?U4GDNFV4Gnwz9VQQuZT2tW/4fpSToj0h8L7uctEUjFdI7JBMdpgnoMJroNdW?=
 =?us-ascii?Q?gwYF2M8iwzGK2lfA2l4/I73V3bvTZPt/hClOLoYqJMvqzNBDO5N3GeO4/o84?=
 =?us-ascii?Q?V2ZU94vfTSXVV7NK/bvmgr3H3XYSRYWXoG1t9eW/OBt0kjWaIDpT2eKo1F/a?=
 =?us-ascii?Q?Pi//xsvtGQ4pk9jY/kAsZS+BwnEop4hKqr/JS3HpxD9yuIQpNAnzD9z8xa4B?=
 =?us-ascii?Q?7jGdj7SWq508z49A5uLg0Ypa07C56Oh7YU4twGibO5iWasNOxwKrV0kFzCdN?=
 =?us-ascii?Q?iZUlYY2U2gvI4I26oLNUx0HfWTuB2utmVrCOYtX7DSWy/4PHQNQRC6dAJajI?=
 =?us-ascii?Q?zbudcm7C8JerrArrevUGXpxGBGL4ED9TORdmuSOk/gJc3FX+4ecVTKIbbPWI?=
 =?us-ascii?Q?mJpmysSFKwSr7+7E6rcZXVGR3ZsWgN15P352VpkLUZXsPTkcX/BfvZWGudA2?=
 =?us-ascii?Q?NJrr8texp8NQw8oy+no=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 18:49:06.5386 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6fae14-7cb0-421d-7513-08de082db0cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6826
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

1. Added VF logic in amdgpu_virt to init IP discovery using the offsets from dynamic(v2) critical regions;
2. Added VF logic in amdgpu_virt to init bios image using the offsets from dynamic(v2) critical regions;

Signed-off-by: Ellen Pan <yunru.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 17 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 53 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
 4 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 00e96419fcda..41f8fe04126f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -96,7 +96,8 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
  * part of the system bios.  On boot, the system bios puts a
  * copy of the igp rom at the start of vram if a discrete card is
  * present.
- * For SR-IOV, the vbios image is also put in VRAM in the VF.
+ * For SR-IOV, if dynamic critical region is not enabled,
+ * the vbios image is also put at the start of VRAM in the VF.
  */
 static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 {
@@ -114,7 +115,19 @@ static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)
 
 	adev->bios = NULL;
 	vram_base = pci_resource_start(adev->pdev, 0);
-	bios = ioremap_wc(vram_base, size);
+
+	/* For SR-IOV, if dynamic critical region is enabled,
+	 * the vbios image is put at a dynamic offset of VRAM in the VF.
+	 * If dynamic critical region is disabled, exit early to proceed
+	 * the same seq as on baremetal.
+	 */
+	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+		if (amdgpu_virt_get_dynamic_data_info(adev, AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
+				(uint8_t *)&bios, &size))
+			return false;
+	} else
+		bios = ioremap_wc(vram_base, size);
+
 	if (!bios)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73401f0aeb34..23aec57295c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -283,7 +283,6 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		 * wait for this to complete.  Once the C2PMSG is updated, we can
 		 * continue.
 		 */
-
 		for (i = 0; i < 2000; i++) {
 			msg = RREG32(mmMP0_SMN_C2PMSG_33);
 			if (msg & 0x80000000)
@@ -292,6 +291,16 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 		}
 	}
 
+	/* For SRIOV VFs, if dynamic critical region is enabled,
+	 * IPD binary is retrieved via this call.
+	 * If dynamic critical is disabled, fallthrough to normal seq below.
+	 */
+	if (amdgpu_sriov_vf(adev) && adev->virt.is_dynamic_crit_regn_enabled) {
+		ret = amdgpu_virt_get_dynamic_data_info(adev,
+				AMD_SRIOV_MSG_IPD_TABLE_ID, binary, NULL);
+		return ret;
+	}
+
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
 	if (!vram_size || vram_size == U32_MAX)
 		sz_valid = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 461e83728594..4a7125122ae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -965,6 +965,59 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	return r;
 }
 
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
+	int data_id, uint8_t *binary, uint64_t *size)
+{
+	uint32_t data_offset = 0;
+	uint32_t data_size = 0;
+	enum amd_sriov_msg_table_id_enum data_table_id = data_id;
+	char *data_name;
+	uint8_t __iomem *buf;
+
+	if (data_table_id >= AMD_SRIOV_MSG_MAX_TABLE_ID)
+		return -EINVAL;
+
+	data_offset = adev->virt.crit_regn_tbl[data_table_id].offset;
+	data_size = adev->virt.crit_regn_tbl[data_table_id].size_kb << 10;
+
+	switch (data_id) {
+	case AMD_SRIOV_MSG_IPD_TABLE_ID:
+		data_name = "IPD";
+		if (!IS_ALIGNED(data_offset, 4) || !IS_ALIGNED(data_size, 4)) {
+			dev_err(adev->dev, "IP discovery data not aligned to 4 bytes\n");
+			return -EINVAL;
+		}
+
+		if (data_size > DISCOVERY_TMR_SIZE) {
+			dev_err(adev->dev, "Invalid IP discovery size: 0x%x\n", data_size);
+			return -EINVAL;
+		}
+
+		amdgpu_device_vram_access(adev,
+				(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
+		break;
+
+	case AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID:
+		data_name = "BIOS";
+		if (data_size > *size) {
+			dev_err(adev->dev, "Invalid vbios size: 0x%x\n", data_size);
+			return -EINVAL;
+		}
+
+		buf = ioremap_wc(pci_resource_start(adev->pdev, 0) + data_offset, data_size);
+
+		*(uint8_t __iomem **)binary = buf;
+		*size = (uint64_t)data_size;
+		break;
+	}
+
+	dev_info(adev->dev,
+		"Got %s info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
+		data_name, data_offset, data_size);
+
+	return 0;
+}
+
 void amdgpu_virt_init(struct amdgpu_device *adev)
 {
 	bool is_sriov = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index f46edc03f57f..5d8e3260f677 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -438,6 +438,8 @@ void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev);
 void amdgpu_virt_init(struct amdgpu_device *adev);
 
 int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
+	int data_id, uint8_t *binary, uint64_t *size);
 
 bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);
 int amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
-- 
2.34.1

