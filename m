Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869A0C021AA
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 06:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC9E10E997;
	Fri, 21 Feb 2025 06:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eAb3GHcj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D99910E997
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 06:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fb3UT8rqp08npxSpyx95LwX2atuwY62AEDp1xJuu/kofEBSxVPR7eBtuTFqzA7kTxKLh4yXWCEjKEC+6l2bXNjjFEsK8j9mRRPGJfH3l+HmTrUcTI469zL40JQE9HLgrIYD7a4DmDdTuZtEFY1gXwbIvNLDe/HLoxCxOZxQgpGd6FMZad324q4bq+9/rKDri/tkjrhu+TSZoUK7jT+SwBxiT/zEFMTr6HFv584a5WzCQC57L1FtI2dpYZlH19lOkb0K78h6nvAxP+4U6c6GAedgoMjRvYlDkw4QB1IHclZRMymziAKv9PHtE9UFL354E10L9jfidM3C4ApuE4ZELQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/H9KsXHuvmHrCs02ijkEEGkxeyYu0/sd+Vb6XD7Lio=;
 b=lIAoeMyTyBmktbPE/RKURlcHQ1pm7w0ma5aoXJqw67yt4mw6hAk81hXiKORFeNYThqk7yMd9Yn8clbNlkzRixuBDfkJENLGx1AmN2lPl2mr6hbjHMj+Yta8AO5mUxPtu+ggvMkPX+bOoc/t98ZQJCy/LrnPkEsgiqU+R9V943G8LXhrgGbN1v0TrL4QjbDxYfkplLxe1QQ4n3HDToSTNbW51pb9MY/fuROetjKo45f8tvulK1OkmFKVOpwP4qegaffHu+DuvSFIB+0NrDwd9BA4vESB99OxniXXQNUICvUNbm1oNDN0/f7shD9UrOujlYGmtp4Um1vTUZ5qy5lFC5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/H9KsXHuvmHrCs02ijkEEGkxeyYu0/sd+Vb6XD7Lio=;
 b=eAb3GHcjEiOZILryuqdWpsH/uVrUGtMHSAOeMKwnjtdymEHQJto8bBCXlHktRarO1XKfJ2jsv0jaaqF2Ukc7V7iqKrOs95S7UV9nPBrzsQnkjwLhqsuilWwSvVwwNdzvr5dSU8HU/T/ZB930u4HVLGpQr3kaKor5ESUMWRPKOFI=
Received: from CH2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:610:60::24)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.23; Fri, 21 Feb
 2025 06:18:03 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:60:cafe::3a) by CH2PR14CA0014.outlook.office365.com
 (2603:10b6:610:60::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 06:18:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 06:18:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 00:18:00 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 21 Feb 2025 00:17:53 -0600
From: <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Jonathan Kim <Jonathan.Kim@amd.com>, "Jiadong
 Zhu" <Jiadong.Zhu@amd.com>, <tim.huang@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Vitaly Prosyak <vitaly.prosyak@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH v3 2/2] drm/amdgpu: Initialize SDMA sysfs reset mask in
 late_init
Date: Fri, 21 Feb 2025 14:17:46 +0800
Message-ID: <20250221061746.3949672-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221061746.3949672-1-jesse.zhang@amd.com>
References: <20250221061746.3949672-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a95f42a-5764-4ec3-4f45-08dd523f7f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0r4/+Zqoiosf7XxhhRZ+Z8zBuyer8kR/AGCCpGS/iv7w5CRCrLYmCauIaZUL?=
 =?us-ascii?Q?Ctf4x6YVaesUyQ/jXvhGkJcylEFUoh3T6A157OI/2q9q75ZwtVXQrMRghNfM?=
 =?us-ascii?Q?rV31/dEFGCIGTQTQkc5D99L2fmARt/JuO1LpZm3IDbzgnF77jGV4eqw37zSs?=
 =?us-ascii?Q?eeiWmhpvKif59xELUirpME/1noHTkTWUEAIJ4QOc7iL9dgcEf5NmKcvBd/Fp?=
 =?us-ascii?Q?AwkepDeBTbOmb6rzZf4SJ9Dgb+HmefLXzt80b0SjSsEL9nrEKIr4uWWRWdjQ?=
 =?us-ascii?Q?KwI397UT4t2iVgpk1hPgcgtPmvlGnUCNGUv/oBkPcVTDjf+Sx+0mOpWIhKaw?=
 =?us-ascii?Q?ko5qlq7jqpalgwvNn2cZoYNBe8vJhylkWaz9kS9PlQ/Gf25fayJox6D1Gs+A?=
 =?us-ascii?Q?anJKn9aIsFXZ6C7YKeNllA858yqSyhDkz7M2gSL1QF5jN0nSzVas8Ym6F+Zg?=
 =?us-ascii?Q?AinRCG3Lv9kwgc8bDDlRV17RDoZVYCkLyJVH5Y5+KKhP4qqy1ZT9Org1KY9U?=
 =?us-ascii?Q?LtiFE50oD7Hgky8BtsTgbX1k/Kxj6z7Y82mvOOD0Kq23w9q7U6y4557J2u+X?=
 =?us-ascii?Q?cwF9OQnMlTL0lR6bjZdNcLQ+SUiN5ILzp+gQyhUbDszJP76GocYCaMARk9sH?=
 =?us-ascii?Q?SnTDo+dhVN096R+y0DfFqUiO8oApy4kR9bd9CckbPqNXr3QwPK00lm6a/mWA?=
 =?us-ascii?Q?w/DhLRJsKFGFhfgy0gsCyATh22B3hO5WwdayneM24Q7mdc6Ovh8PCmZv+Uj0?=
 =?us-ascii?Q?S6PE2ulXJpxPa+x3KrTZUbuEAoYY1xuQ7mZ/51pdYQfwCHlm9jh1BA74qXVp?=
 =?us-ascii?Q?ipo68i5TT0GyH372Wfq6/NQKp3BIIWKqybXI5AmpQxHewUXki5AhYkInQpZ1?=
 =?us-ascii?Q?C98OdDnNedq1mq98Zkr07MXHmMyMDBB7YvdZVxX/XZH6sJtmw9Ofn9Y2srC3?=
 =?us-ascii?Q?0K9B4hMSvykd8AnZUG0q21YrXT4cDSiW3pfSzpqUqt8+Lco5Y606/RwMUlc1?=
 =?us-ascii?Q?WfoYgNbq1MRWQ6KsS2v4nKEwEia4uooE9McHFEri8fB4xMFZypEjL3ACvVht?=
 =?us-ascii?Q?p3y2bcXQP8nF2QgF441+8Dkfqd8zM8h72qTGPDKY5b3uJTFTZYoxr4+XSa4k?=
 =?us-ascii?Q?60QUiw/Z5rQXMRmXZUmGSDz3QJQpv/xTICAtfFUdnU7/MswUoovh3DkhlakF?=
 =?us-ascii?Q?WhLJe4DkyAgX6ge29uOf9L4dI4dYW9n3nEZDlctkWdylX3Fs7GwciYkFV4lT?=
 =?us-ascii?Q?zHjdhh/hNRLapaWboMXVI+gBVGrV9CIlSviHMHJfoatAU4rAkzX69rT+BCOb?=
 =?us-ascii?Q?I1FF4pyhSSOZYTpPRUKw7mZMhf/kviG4hgxKDCGQrW1f53AT8a/Aduyn+qn2?=
 =?us-ascii?Q?sIeVZVR3+97cTqfkZgxwGeU7qVonqYDUywUfD6ehWx7Zp2EIPdRjzWriLPyH?=
 =?us-ascii?Q?S884d6kfWvn9Z5tEMa4LgGHHHet8/cWFgM+9yhgCdcqYjUHwWHVVsQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 06:18:03.2868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a95f42a-5764-4ec3-4f45-08dd523f7f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

- Introduce a new function `sdma_v4_4_2_init_sysfs_reset_mask` to initialize the sysfs reset mask for SDMA.
- Move the initialization of the sysfs reset mask to the `late_init` stage to ensure that the SMU  initialization
     and capability setup are completed before checking the SDMA reset capability.
- Consolidate the logic for setting the supported reset types and initializing the sysfs reset mask into the new function.
- For IP versions 9.4.3 and 9.4.4, enable per-queue reset if the MEC firmware version is at least 0xb0 and PMFW supports queue reset.
- Add a TODO comment for future support of per-queue reset for IP version 9.4.5.

This change ensures that per-queue reset is only enabled when the MEC and PMFW support it.

Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 55 ++++++++++++++++++++----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 4fa688e00f5e..fd2884de2dc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -107,6 +107,7 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
 static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *adev);
+static int  sdma_v4_4_2_init_sysfs_reset_mask(struct amdgpu_device *adev);
 
 static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
 		u32 instance, u32 offset)
@@ -1366,6 +1367,7 @@ static int sdma_v4_4_2_process_ras_data_cb(struct amdgpu_device *adev,
 static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int r;
 #if 0
 	struct ras_ih_if ih_info = {
 		.cb = sdma_v4_4_2_process_ras_data_cb,
@@ -1374,7 +1376,12 @@ static int sdma_v4_4_2_late_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_persistent_edc_harvesting_supported(adev))
 		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__SDMA);
 
-	return 0;
+	/* The initialization is done in the late_init stage to ensure that the SMU
+	 * initialization and capability setup are completed before we check the SDMA
+	 * reset capability
+	 */
+	r = sdma_v4_4_2_init_sysfs_reset_mask(adev);
+	return r;
 }
 
 static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
@@ -1481,10 +1488,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->sdma.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
-
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "fail to initialize sdma ras block\n");
 		return -EINVAL;
@@ -1497,9 +1500,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
 	/* Initialize guilty flags for GFX and PAGE queues */
 	adev->sdma.gfx_guilty = false;
 	adev->sdma.page_guilty = false;
@@ -2328,6 +2328,45 @@ static void sdma_v4_4_2_set_vm_pte_funcs(struct amdgpu_device *adev)
 	adev->vm_manager.vm_pte_num_scheds = adev->sdma.num_instances;
 }
 
+/**
+ * sdma_v4_4_2_init_sysfs_reset_mask - Initialize sysfs reset mask for SDMA
+ * @adev: Pointer to the AMDGPU device structure
+ *
+ * This function initializes the sysfs reset mask for SDMA and sets the supported
+ * reset types based on the IP version and firmware versions.
+ *
+ * Returns: 0 on success, or a negative error code on failure.
+ */
+static int sdma_v4_4_2_init_sysfs_reset_mask(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	/* Set the supported reset types */
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	/*
+	 * the user queue relies on MEC fw and pmfw when the sdma queue do reset.
+	 * it needs to check both of them at here to skip old mec and pmfw.
+	 */
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 3):
+	case IP_VERSION(9, 4, 4):
+		if ((adev->gfx.mec_fw_version >= 0xb0) && amdgpu_dpm_reset_sdma_is_supported(adev))
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(9, 4, 5):
+		/*TODO: enable the queue reset flag until fw supported */
+	default:
+		break;
+	}
+
+	/* Initialize the sysfs reset mask */
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+
+	return r;
+
+}
+
 const struct amdgpu_ip_block_version sdma_v4_4_2_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SDMA,
 	.major = 4,
-- 
2.25.1

