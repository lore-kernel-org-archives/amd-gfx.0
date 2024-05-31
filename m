Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AEEC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9E9610F292;
	Fri, 31 May 2024 06:53:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yC2rDvim";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027F1112F40
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGGg5X/yenvA5Z/KSQmWh96ViT83U7OiZNbGc3ZVdfqlDmKH01B5eEx/36ppTJGBGLQLPdldMGeAJeN8CLtxWI5FrWmKr5/S9eBLs7pgS9owMJ9xThlHE0w8TVYm/zoak0075D8Po532u67jgN6qTk17P72ciwnkocBE9odjecN343bbNmN1RLmHMh/RMwjiPC2CqAx1F7SmWFajt//lFMfes7o5YBw6f8DWqsoimsA/LLkqZCzUgVsYyGJ74GYYnbwSIItGcPMaCV45B9BKdzETvMohsJbQ9r/2BOJRMI4gE7dJgzvaGraQMT/F0AK/YL35IQ3zg+My32TzznFy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=arrNttrf7hWcXY2keycCXCaE81r1jkt3rEwvuDsiS10=;
 b=JS/N/HPB53QXDZtwPfTFBGZdOT1M1xzdkZT81aMtCn2pNcDsD6Rtd/GSQOBIW1YXASce+AvJAxhL5ha60Imgx2vw18CCDs3Pcirodz0pMn9xeowwUfoGzpsszpJj7RrUDy+jdxxJZTPGG3edbOA9lxSYjkoXJPb2cQctZpB8PD1ctPwZ+SIl1GMjUxKFsciG6K+z59ojBySe9m59jX0hTfoCSf4C3IxihOzywHVqsnogNsutgZ3pfO68jXsWIf0eZsSh1gCDmZ+FwQccj2RvW+MKwSU6X7Y9W3GjkbhaOv37vxIPmC8hsv78LfhshNCd+WaDZVR8kgh1qNtX0i5bJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=arrNttrf7hWcXY2keycCXCaE81r1jkt3rEwvuDsiS10=;
 b=yC2rDvimgozQSsJi7GXAf05uAYvgWlQ1WpajYLJ+E567RIXeAryYm7dtHeI8NRZM3pKOH/yR+0jbPOvp8c5f9bWvmDzXoSSfvF2o01+dhnJHPjsXfeBoN3JppSO7DnRms9Qssvs3hfrhmOOPsWoVpsoxdsk3Ul3pNTa2/anE3SQ=
Received: from DM6PR02CA0084.namprd02.prod.outlook.com (2603:10b6:5:1f4::25)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Fri, 31 May
 2024 06:53:28 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::76) by DM6PR02CA0084.outlook.office365.com
 (2603:10b6:5:1f4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24 via Frontend
 Transport; Fri, 31 May 2024 06:53:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:25 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 17/18] drm/amdgpu: refine gfx11 firmware loading
Date: Fri, 31 May 2024 14:52:48 +0800
Message-ID: <20240531065249.1746350-17-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531065249.1746350-1-kevinyang.wang@amd.com>
References: <20240531065249.1746350-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: e607adfe-f852-4fa3-d24b-08dc813e6014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Me9168yyeSbTv2SQTWbBgWdvN6XqURq5fochX4oCsArN9LQDadYqX6DvuCKz?=
 =?us-ascii?Q?pBuCvv+aWci5g2yAeLpEWU/kxip7vmJQw2lCVyWsmK1b7/PQY6Da1dOA1DNV?=
 =?us-ascii?Q?gjTtbUapR8trB6sJHN9RVEBz2Ijh8pqN0a3wQDjRN5TXRYUvG9Z0xfd+wGpA?=
 =?us-ascii?Q?O8k/mqd61h6xHz/4VJ5F/1QHhXRlkJNMHLd+EGUEf9+lAN0vgpL4agbYIvxW?=
 =?us-ascii?Q?TJXPpA3m5fYFUfvbl/HJDMJ02REw4R4QOc8xBqCxkXTEs6YkuEW0d5DVbh9s?=
 =?us-ascii?Q?HZXCxlsAiKPKPEfqLFkxqXuNuokMl4P+1XikbrmPPdzRqB0OEhyJk10npGb3?=
 =?us-ascii?Q?d+wTufA/nvkBerxlDuxgAAvh3ATiOfPbmeBBvvM/19MpDxn3eS2dkCUT3TpM?=
 =?us-ascii?Q?7I9z9f6aGG3QeCN9ngp/+Rs2OT210lOtgNLG9lFRNrMeCleN/uY6BT9F70tt?=
 =?us-ascii?Q?ZGFUBof5EKjspWB+sVCCvqOFJXhXmNhMF2++7IQePu9DJUckZDjh/BzaRqa3?=
 =?us-ascii?Q?WVxJVHKo6lBviDAoiBiwIcDxp0X1T+CgXY2xJK8HmHFIozGq6MkFIsaTFZbt?=
 =?us-ascii?Q?0msJ39iY91h/iLo8vfFgv7KrQfKpDJRf05HJcYDzXi8J9KVO4vVcY4WkOrRN?=
 =?us-ascii?Q?1j2F/cmRbauAgMtiLeesSizfeilVgn8x1R2XX2z8ZZPl5s/yscRTcG3ZNLVv?=
 =?us-ascii?Q?7fVtzHcgHBbCNCM8z4IdpJ/a4Xu1aS1KALTuDg19cqrlpgD/c5XloN7u8Syb?=
 =?us-ascii?Q?8sy9MC8QmpY+5y3KQ/ON4wkJvbGHXWFxPKv7lEzhGJmTANOkkJBuq/Ckraz1?=
 =?us-ascii?Q?3xtVVavZeZQFN1sw8wLOjNZssa7FoCV8hNpuyIggcfz0uohgeNJX5oLtVx+C?=
 =?us-ascii?Q?rdCwdhtcQbXqTyA89QrAeLliIu296h9FG648sEZJWxPKNr+kFviteehCUNDo?=
 =?us-ascii?Q?7CdUN0/gziehrbGYDgZgu6cYBnzjrFsE3qxFrQJm0A7pziSsN8K8Og3afQNg?=
 =?us-ascii?Q?acMdRc7JZ1s7n7YG/tA5+Wyu32VChguYtT0rOVd7fNc2dD+m9yQxV61OoW+J?=
 =?us-ascii?Q?GX1u0rhJ2JkbvcuPP/0CocwIbakqIH6vNbsK0Islw+GA2Iz4nbg7++eBgT7f?=
 =?us-ascii?Q?FZk5Pbn7h9rvqw8/i62G4NPbMGFQE2FQwIf6Mm3JKqYyIGdVLXZ1IYA8q4wm?=
 =?us-ascii?Q?AhF1VXqzms+wJJUjKBaMkXo40ymZyIhQcWEU0OBNRiaRvx0LBxDoWynf1Znv?=
 =?us-ascii?Q?4L2JbzKB7FdHbxiH+p9aICnlabwiG90QV2TQANpVK7hLQvwi9qy+GFp7Zg1i?=
 =?us-ascii?Q?JaH0LdMKuI9RdOvCB36CFO3QtXWMum/0G57lNjKtPOtZg5FonLX0LJEEEEeY?=
 =?us-ascii?Q?wEcnNI8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:27.8606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e607adfe-f852-4fa3-d24b-08dc813e6014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468
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

refine gfx11 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 72676bfbac8c..6691027e81cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -611,10 +611,9 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 {
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
-	char fw_name[40];
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
+				   "amdgpu/%s_toc.bin", ucode_prefix);
 	if (err)
 		goto out;
 
@@ -653,7 +652,6 @@ static void gfx_v11_0_check_fw_cp_gfx_shadow(struct amdgpu_device *adev)
 
 static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[40];
 	char ucode_prefix[25];
 	int err;
 	const struct rlc_firmware_header_v2_0 *rlc_hdr;
@@ -663,9 +661,8 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
 	/* check pfp fw hdr version to decide if enable rs64 for gfx11.*/
@@ -681,8 +678,8 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", ucode_prefix);
 	if (err)
 		goto out;
 	if (adev->gfx.rs64_enable) {
@@ -696,10 +693,11 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev)) {
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 0) &&
 		    adev->pdev->revision == 0xCE)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/gc_11_0_0_rlc_1.bin");
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   "amdgpu/gc_11_0_0_rlc_1.bin");
 		else
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
 		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -710,8 +708,8 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", ucode_prefix);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
 	if (adev->gfx.rs64_enable) {
-- 
2.34.1

