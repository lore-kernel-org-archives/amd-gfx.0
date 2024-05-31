Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8505AC27C44
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 06:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A87A112ADC;
	Fri, 31 May 2024 06:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UfPmxXhX";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151751129ED
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 06:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7/4iQzefjdrxyrBRoZRU+HnJYaePlV896ptql5SHbyk+FfkTS8VRGmf+IOCmwE7RlWrVLHmYpiVgKSJFV2i6gmNCGggj1Id6eYBhvGcW/5oMjwSzfHldf1MJoL8+s8Vw6zwIRdz2hbqwLC22Zvtve48E3RcU8TicrV/Cs28QwhrhhnRIZF1gmJhZU6C2+fWVRMdf6VpLimjTVAYDIupOfIZjLq3IVWJbgMuhNjElgC0ycpssWnpd/THDX3ek9lB4dKBiTqKnBAX7aZFRpJy3xAJjr4y/l0CgIEJYnuFNvc/jSU9PFq68y+0L6Dkywsz3g83OBheNXYxI42DR5Tkgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvXPxe8S2FpZ5rAVOFja213gIx4aL7Fc7tUuDLFxbEw=;
 b=dhhP88mxiUIQAMD+CVWO2FPP4U0FRURUfyNeiObZuL7bwUg3KQe12dOcL9Nt2cj6CgbaHOmZmZoZY2z3gZWdgRf6XHyMFEnWM1s+O7zcR0IoOnLmuYPNwqSWQIAWnrKRcVQvkrpVRDzcGNpIoFqHcfPbTLhol6JLpDrBBMRCBV0DWfzVdqoOV1cKa8WNrKD/uNDDdi6bwwnLx4BUg65p42MUvJRdJeBvxW+nnVk4NyL0M9X3Jd8sfpniebGDGQJXC8E7s20gudf1Zqduct3Ce7P++eh9KNSMaq9eKodCUWWffC123BZIK5Tp6WpdozkBGBztEbMSmUYS2Z8YCbxeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvXPxe8S2FpZ5rAVOFja213gIx4aL7Fc7tUuDLFxbEw=;
 b=UfPmxXhXirL6ILZYsPDiw12cHT+KbNqEvKoL38TNSGVGOYFvthUzrTbnmQP5kSRK+Ncuh4sTE9OVm/u3efN5kpW5HXRNdgf8O1sNN2s+jCBwzCMuCDsMdOIVPyPv5jKw90bfzeRHx/9sLxjp1zxyUkiSJoCznUMt4APDueAxWTY=
Received: from BYAPR05CA0063.namprd05.prod.outlook.com (2603:10b6:a03:74::40)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Fri, 31 May
 2024 06:53:19 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::17) by BYAPR05CA0063.outlook.office365.com
 (2603:10b6:a03:74::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.8 via Frontend
 Transport; Fri, 31 May 2024 06:53:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 06:53:19 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 01:53:17 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 12/18] drm/amdgpu: refine gfx6 firmware loading
Date: Fri, 31 May 2024 14:52:43 +0800
Message-ID: <20240531065249.1746350-12-kevinyang.wang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: f6a982d1-dc87-464b-859f-08dc813e5b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t4Id5Njj6yQWgSBNCgS33ll5XQNLfm3A3Rn83/woMsza8eZZuMAxXJdpqbCg?=
 =?us-ascii?Q?2CqOMPo1AeqJqvfmLqSiboKhKLgpGWFc+SQwmWy0RQBqdTDcogofilOLPOXt?=
 =?us-ascii?Q?QmkeIDL/PY5aNDK6lz3uHcnpyje83zhgFYAnoeN5q5nW4rfKVRN6d790PfM+?=
 =?us-ascii?Q?ki54QZ+mDUCZeLWzdAv/sM+g/hjx4LVkGuTgnVBLeHL9QwU3Afb955pjJg3o?=
 =?us-ascii?Q?aeOV1xd9rAoxYqXmYC6P9gcVS9auYR6LAWiZt2ENjB2EkIg9ZwU4aDeAQVAG?=
 =?us-ascii?Q?OlA3xqg0PjfZdlZOzWjUBvoU6072Y1gxvCFAE6Yw3nkK6ShvOknu3uEwNaLA?=
 =?us-ascii?Q?3RNSmOr39EBmhWvdMGwmKzcJeFpItXuI0kpfVpezGLGTLEyoNyyxeEnqcPgF?=
 =?us-ascii?Q?f1qrsbJxiOm/b5M3LgtgoZWU5QAOpJlGEGhhbVnIPyMfv2QtKc/d/5yQwExD?=
 =?us-ascii?Q?nfl+BOSBgIt441sd+xEpJcLjPgUb0ExeQAQTcY/a2tPGnpEb/jHl1YvIlwcx?=
 =?us-ascii?Q?lHDC7nEM0khHwMKp8Up9Ao4/T+++hH4dPqDSAgu/+eoqSEGw6GSD6PBmv3Gw?=
 =?us-ascii?Q?9aqauqSYSVKKejWkIWUs1Id6kvHE4AzOMltcdXV9239JLPgN1Tt6jfCopswW?=
 =?us-ascii?Q?YwJJ8W39rJxBLFuZkf49CyKzMOvTizqlwa7TZBVBxIu705FhfKbnSXNCgLCX?=
 =?us-ascii?Q?72Zg5lL1BkhVNWbMNIP7ct3R5ZtIEh4TRLjkL7LRdAk+7EU2ccaRDzzapzCl?=
 =?us-ascii?Q?5yEDVW5cr5d9ucVQeSZSBqkUdzwM+9hC7pJrKtN+SM6u912dlPNnVwzE5DCm?=
 =?us-ascii?Q?0StifDvxGHCvSBJn1ZOKTVZ5qjrfSaf6yXCR+qVUslbeiRe0G7TX1fuC2znH?=
 =?us-ascii?Q?bmIbUA6F6TiR3lG3en4V+uyY2gGjWf31g849DgdT4q9Gk4Jv/nSUlkIszUMJ?=
 =?us-ascii?Q?R6K2mYNmXrABctnjUwJscAOX4GELj0l99uXNbKtIj5GzI/0sLn6US556h0o/?=
 =?us-ascii?Q?VdV7sWbfJURJlfBVu2gCxrFFCyFXq21peOWyBJBz4QVlZYw99tvdAS6j+t6x?=
 =?us-ascii?Q?dZrBxUQ0CLd3xcMbsturIhT7W2spkildLUqa0ehseUwxsAS+L86ASsfePBj7?=
 =?us-ascii?Q?ugBBCL7bJ3T1xVbb0BnnpE1Y80SCEK9ISY5TVmzQ6vNDuDQlHp/8b9lMQPee?=
 =?us-ascii?Q?a9SAqO+EIdRJx8vFvAEYMq+oDrd+Wy3ndGqWdlojdw9pkJPFAOrS8yxZSLP5?=
 =?us-ascii?Q?5J4khrkgTwzwDffZRbEHksX9ev5SjGlqba2ljnv75fAyW1/k6NGkl+WWa/xy?=
 =?us-ascii?Q?R/InK8WqYcIsyr1gqbxZo8vh9/3VKNblG8CfsQj8LlsXqqfKM6CYOHiuixDI?=
 =?us-ascii?Q?t/DDlyLDhknkpBRBwy3x2ljNWWy7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 06:53:19.3234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6a982d1-dc87-464b-859f-08dc813e5b00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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

refine gfx6 firmware loading

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index d0992ce9fb47..564f0b9336b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -311,7 +311,6 @@ static const u32 verde_rlc_save_restore_register_list[] =
 static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 	const struct gfx_firmware_header_v1_0 *cp_hdr;
 	const struct rlc_firmware_header_v1_0 *rlc_hdr;
@@ -337,32 +336,32 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	default: BUG();
 	}
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.pfp_fw->data;
 	adev->gfx.pfp_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.me_fw->data;
 	adev->gfx.me_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 	cp_hdr = (const struct gfx_firmware_header_v1_0 *)adev->gfx.ce_fw->data;
 	adev->gfx.ce_fw_version = le32_to_cpu(cp_hdr->header.ucode_version);
 	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v1_0 *)adev->gfx.rlc_fw->data;
@@ -371,7 +370,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		pr_err("gfx6: Failed to load firmware \"%s\"\n", fw_name);
+		pr_err("gfx6: Failed to load firmware %s gfx firmware\n", chip_name);
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
-- 
2.34.1

