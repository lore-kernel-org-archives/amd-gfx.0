Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B9CC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7008A113075;
	Fri, 31 May 2024 06:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yvix1n7U";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAFE4112CC2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFkeNvipKQD/MD89ZUCY+Y/vEynXY5Sqbnz2tjEs2C4D7lqJwjHiw01p1WDJpuQzrA4Efl5qRNlvxUn/YprVrl9cfHshET4R7V8pFkEuxOBwjeqeFrqpSZgbJLAYuIqSD4etped+CrAyGR082YX0sLNd7wusRaf7zajLOfUeRbYb4mVZUrfS2IrX/SqsISQC13ZiqF+cPXvHEWulg9CjFGjYqULMJX5Ue3B6lNiVugtyhU1eb/NvARNwONrfnTykunbgxFx2aCFAZQcVwYUHdgOj+s8IXlUuahXwn1mAf7pgMwVq6vII6GAGzt9SWUXFBfLsFwBIetlvw6N/ENDgjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ip+5ynnHbO29VTW0NEkyyWjIFCAwRsqmaUY08S5HHHg=;
 b=cmonmbi7IklKsnwltr3Igz56rqdQtZ7/TqhzAN/sWnGh9R9ulKUHZeGAW/a177eAUMFsCwYzCGzYfiawn3UPEI+G1DQ95mNYr+lCrH5It79dgyLyG1A50hdIQ46t4VFrwQrKdF12xT+fyYqCXM3EJoLDa3jo0+qw3v/hwHAakmHJ9IEGb3MXrW7xuuc4xAQ71iZ/bc7wJoVNenjUV4TP9KGMXaAzJm3/cnPf9DUT4dVR67V5u8hs+Tf5u8K3BFifMRFOr9j7CIGuwIIrcyFzHSHR01tCw9GyQMlyLc0/mN5l8VhaV40BkYLgzOMCJVAU99XomNCS2HNtlRTocDvsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ip+5ynnHbO29VTW0NEkyyWjIFCAwRsqmaUY08S5HHHg=;
 b=yvix1n7UUF/Ypm5rPTttUUpCrYtoiUzCJlxyDIsJaFx94f2qJPJc+qKsOUy91PA2qX3hJQ3gQc2ol55fl1b7iNr6xd+pS1lg8itHF5qYQWzXxdDwoZ0Ejt7fUgocdavvePHLPucPNUQq0a/w8+43P47rvPH4KaD3hkencsEWZyI=
Received: from DS7PR03CA0016.namprd03.prod.outlook.com (2603:10b6:5:3b8::21)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 06:53:26 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::69) by DS7PR03CA0016.outlook.office365.com
 (2603:10b6:5:3b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 06:53:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:26 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:23 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 16/18] drm/amdgpu: refine gfx10 firmware loading
Date: Fri, 31 May 2024 14:52:47 +0800
Message-ID: <20240531065249.1746350-16-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a6a446-a74e-4188-167c-08dc813e5f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JDVXFZ4Yvx0O3dvVw2se21pB5RRONqPxTg1lRJVm3Rd6+r85dhpTACCtZuy0?=
 =?us-ascii?Q?pdYVsyMDgeuhJPPybo363nZjER9GlFSemAOOclR2SWDMBjf2ax3X0a6H9loL?=
 =?us-ascii?Q?AhFhUTLksH8hUhyKBVGJWxtQ+07/Q5/sC3Nvp+WK4T6t/7JMKqfjYJhxW3I8?=
 =?us-ascii?Q?4mF60uw+ktbRQVcsqIugbeaNbqAYXUffO/TbZn8oqrH6EhUh7aNmCQEuq8LV?=
 =?us-ascii?Q?OZkff575AWGFaxw2/3PDzfiuNyUH7PQ3smhgR8na18prXPVF7XjRmyL/AB2z?=
 =?us-ascii?Q?W3nuDl729Fz4jY7MYrnimNcLcih39xxGUBTy7R3gfFO5mFyRiT/vaz9xLowH?=
 =?us-ascii?Q?mFfm5tOqnI1oYO01tQKNuGW/HlzWhDBNMsRNdfz2Fad+/cegU1h3lfIC76b2?=
 =?us-ascii?Q?cUQNYmG0Ba/qg9+nyFeOndXbikP6zoJgI6qjULtf1mFAFRL7xhTS8DRXWz8M?=
 =?us-ascii?Q?ImI8aAdBGDbOk3bhkencVxLM5u2OFaY44ApHn7lAr7HYXnEOmd0h6jx+EKti?=
 =?us-ascii?Q?9Qmr+2JridPSNiumqVK9MK4IfyyoxM+KRrOXl7XBrqpRzwtA9DDyGTDiJGMQ?=
 =?us-ascii?Q?zRUPUc1NIqChtuLF0gbS7pLkzV2eVyYO28LLHyeqVxl+rpo2Q4idTfSqygv2?=
 =?us-ascii?Q?ALucZCMNPk04o24zgye2tTHSn7NpYtTm4az42ZxspiG7cpQLVPOsoHMfiCZg?=
 =?us-ascii?Q?GKf8GkCTKGGweXN2pT1InSNX9jLe3EOyk0P1C82HdfF5SZnSJVNaj8K8WXX/?=
 =?us-ascii?Q?T0ItXiEqDV0gFPqBSEZtfRyWHpDNoCAUPFTs1pHin3qW1J7s9II2qjMVu1eP?=
 =?us-ascii?Q?y0Y0TLxnsh9zainrdY1jLZ9/FdU0xqDb3C++oo4qseHDCjpffm6ZdwVlI39E?=
 =?us-ascii?Q?f2AdR+h1RmrwD8xr/zvj8HTvs6qRKoWAqauduW8h+y9n9RU770nYkM+hNPai?=
 =?us-ascii?Q?Txqgc2RqpyPorkCwARo/KQ++MPy8iYxUTajeI58oYGjJeTHqbCozSmtfc7Jd?=
 =?us-ascii?Q?nJX3Yo+HLknfweTNtI7rUeDEJ4VFe6LkQDPX9DEcE9c/uUjdYOEV3syc2PS0?=
 =?us-ascii?Q?pzwOuYCYodI1xFsU7L1EWymd+qTNvF5X0duXCd88mXhUZd/knKQ5witsxPGy?=
 =?us-ascii?Q?qvUracywL3oNRNJ9uXcD+en5A0A431Ytb9w1l6poJkOeZn0KWqfrKtqdvfgd?=
 =?us-ascii?Q?X9fgrzO2Sfncz3K2a0Z3OT4ovYJ45p4/dBRMBuEIWMhcdEAPqv/i6lcNjfEe?=
 =?us-ascii?Q?wzPt/BMMyD/4iP4xeLZr0Qm8g6SbysXlZ3yDyr0iSeB2Zra9uBuOMqet9lXJ?=
 =?us-ascii?Q?TjYRQyT1wUfTPRT4D7aEp0mBh6Lkjn4pYSjrnW/VSirz35+CqHy4uPU0JcTl?=
 =?us-ascii?Q?BJQxOcx2g1LDWVOFbLBtXHa5hdXS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:26.2633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a6a446-a74e-4188-167c-08dc813e5f21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940
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

refine gfx10 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 632061b25867..84189bc15ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4116,7 +4116,6 @@ static void gfx_v10_0_check_gfxoff_flag(struct amdgpu_device *adev)
 
 static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 {
-	char fw_name[53];
 	char ucode_prefix[30];
 	const char *wks = "";
 	int err;
@@ -4131,27 +4130,27 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 		wks = "_wks";
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_CE);
 
 	if (!amdgpu_sriov_vf(adev)) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", ucode_prefix);
-		err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
 
@@ -4166,15 +4165,15 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 			goto out;
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
-	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+				   "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
 	if (!err) {
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2_JT);
-- 
2.34.1

