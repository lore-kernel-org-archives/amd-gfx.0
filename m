Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD34C25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Jun 2024 01:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 535D710E22C;
	Mon,  3 Jun 2024 01:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LYnWnYMH";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C0A10E224
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 01:43:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FckNz0pMh5NBnpEjdbUOiBKpooGsfH/X5gFyc10VBMDI0Y0I5WxTQcaHoWVWdjPEUYFdx0OkNH+1Qm+8UQ2YckDUymhS5G9LOLbqNfJEkcvfA979FaUd4hxUZINg7mm1ucgfJh4GelrMlMDqYtDhg0DO/lnn0c8jZw3DpTCXTP7NoRCOeoBvjzQugy5AEmtOWWHtllHm3/By1MqvY3LRlRtDYSGmxSGwuzl1vZnFN9hi/lahWc0LTQQc8PTk+Usl3tk4v1o/J8Jza4WwG8tUvDzHOT72oRwlNrn9zbtsYvwOEcd5HGRo4jIGhDcWzZygkffnMePpUvgkK4uliTJJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ska1UR8bzaXuqZsnMiTCYtzS/gBh/Huude/G6L6rTgo=;
 b=SZ9rcy+qgMlGrXgzHkC4DG4RDA6EBcwBfeT3WFx2Pbd1NgJ9anxKYXSl7Cb6qCHDttxmhTWlFLH2j3Cuo10Iwo3wD58A8d5ihLr/F963BCajPdUfVWWOQHcwdI/z0zAY9Rx97ky4J3yTpMp2RDrULphyoJmziS5w5dUw9+y+NJsx1oihPu8sxdWj2YYj3QSsTkddn7Yt1dWNIyT1H7mXlawV9QaHtwDRt5RIhIKZLQjnq5tQpgqSR4f7RJoIwV8hFrS8UU7RMapVf2Nh3MzXELzKjixcVUx2zS+0bTHulO899i7KWCyfW5mcW6n0LBr/OmXkRtVdLGAvOFZ/7VH7Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ska1UR8bzaXuqZsnMiTCYtzS/gBh/Huude/G6L6rTgo=;
 b=LYnWnYMHcDIeutXltbDskKn1mnj7ivHLOGs88WJ2WOVpa8aGm0cMsqSp+TcNvYi3hlQF4YkNkyRt1vMicOde0Jl/BhyIzVtG5Rl7cpIpX9kx76EPJgL515vCrJJPILEbQ2hERz+fmWM/cg0vUoZHFjABjjNhr42HpcGapOO1fDE=
Received: from SJ0PR13CA0224.namprd13.prod.outlook.com (2603:10b6:a03:2c1::19)
 by SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 01:43:06 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::1) by SJ0PR13CA0224.outlook.office365.com
 (2603:10b6:a03:2c1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.13 via Frontend
 Transport; Mon, 3 Jun 2024 01:43:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 01:43:06 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 2 Jun
 2024 20:42:59 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 14/18] drm/amdgpu: refine gfx8 firmware loading
Date: Mon, 3 Jun 2024 09:42:08 +0800
Message-ID: <20240603014212.1969546-15-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240603014212.1969546-1-kevinyang.wang@amd.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ab31d7-86d2-445b-3c32-08dc836e8400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MxsOnC6QPWFg5Ds7BqEM95ri20mJiLXFmB4gmQ9SHdf/ouGwDvwGut0kfcB+?=
 =?us-ascii?Q?jjqSo/OnbIxw4PjbqyimcqA6iNNf+nNivYYvoDE3MVmjpPIWLEmxyM5nPE3q?=
 =?us-ascii?Q?nO+suCiOs1GaiK+1lhf/qHWSe7uIHqTuns6jPgQYIzEJK84wQkmZaLkkQ3T7?=
 =?us-ascii?Q?sXCFZz0IweOlst/nSdnUdNiNo8cBpmFV8UqQ8ajpjQnwceqKx1BqBjxCLRm8?=
 =?us-ascii?Q?lTCNnFQbGdYThZKGkQ3wJeYsHhw0EAjbscokuSOYH4AXQV6ficglJ4XJ3AA4?=
 =?us-ascii?Q?w94HlCy8wyBpLsTFQAEAWh6+X30cMG1P3RrPExcG6aVaVfC7hE8G9q/zqpLF?=
 =?us-ascii?Q?za40JGqwi13b696WeRBB3/bhFT0TlnK2Wh8FxALd0RPyeo1FvsUleJAWrPdu?=
 =?us-ascii?Q?TkmGF2XVMD6DxyaMUDCxTCN6Vq06IuaqQGzDSdqhOaYoDAVBUbMpIHa5bRMW?=
 =?us-ascii?Q?ge8e79qagAMKe1ZDzn5cubhDD6zVlhUn8b6gRe1+A8t+pTwou4C7KCvA1Mkg?=
 =?us-ascii?Q?dZvRmdqE2cs03+zKuFv//lMI2c/RVynA4vdK7cNnROasO8IHtYtYV0Hk+3bJ?=
 =?us-ascii?Q?22UonaVmNRX7xKN8pkqVf1X6vv/6vI8+yHhd9SSVHLrtpu87PsW3bCSedG+1?=
 =?us-ascii?Q?J7dLeJYWtiQJ7+XCjuocXLDb53axwZTjI4OQVzFWtynEVkoLMFhUogSmJGAt?=
 =?us-ascii?Q?D4vR3rmhxj8/Ocrlw9T9Y5v7lsJZh0v8xdE0/e0TLjTycglV7hppYFm2Fa5d?=
 =?us-ascii?Q?+4TIKXxFSPM/r+aMaLAgwcMooWlg+FiazLCwZXABKEWFPmwmr3tPbnzr9v2E?=
 =?us-ascii?Q?FXnZe0Msd0Cn2kzLXXEMKjMeYNkCgEI64bhRGhpqMWHQrghb7tc5CHgHANEY?=
 =?us-ascii?Q?1BzzzZgUGYWg4dYbd1PaCTJ6j5xKG/ildGy+7p7htO8cOTctvZsjv2rQABKd?=
 =?us-ascii?Q?PjQkJpXA0ZPqsojiF6hTwzjgxKdTg2PiCdIsnyx05n41BXyAR4IzMn6FqAlY?=
 =?us-ascii?Q?6y+BrEmvZD5mC2APPDWtah+euSAMZPpJmVjjDTF1JXDMhpqH2F6FWeGLeCAk?=
 =?us-ascii?Q?8QlwZCfFxzwFlq6z2jJeEZNKmALEIwrVrTZbeuLe8Vq61OcKB1tpCJUQQ7s2?=
 =?us-ascii?Q?bVPzeSOhAQ9GDyXg4KcdR0HY6U5rz/6NLjDuL5HKl1sPtK0O/xdpNPnjiR9q?=
 =?us-ascii?Q?iUgr/NAop5DvrhYOEd9Mp32gc3G3tO+rG7o0wLW79p6QXbv0kQjvmSzdPkTY?=
 =?us-ascii?Q?O5y8r/FC0kaOiJNvLpHcvHbuI5mGYGoaLyHdoFDngiKGqhmX0UOSnM8CSEdq?=
 =?us-ascii?Q?QofDgClFgHCGiPCJNrznD747q60yvSmUSdBlVvcEDiSgAaRQP0L2PCwcayJE?=
 =?us-ascii?Q?kwvb7GRdgs6wxgVevCj390OGcBPf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 01:43:06.2923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ab31d7-86d2-445b-3c32-08dc836e8400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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

refine gfx8 firmware loadin

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 69 +++++++++++++--------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 2f0e72caee1a..b4658c7db0e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -939,7 +939,6 @@ static void gfx_v8_0_free_microcode(struct amdgpu_device *adev)
 static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 {
 	const char *chip_name;
-	char fw_name[30];
 	int err;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
@@ -982,15 +981,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+					   "amdgpu/%s_pfp_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+						   "amdgpu/%s_pfp.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+					   "amdgpu/%s_pfp.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -999,15 +998,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+					   "amdgpu/%s_me_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+						   "amdgpu/%s_me.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+					   "amdgpu/%s_me.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1017,15 +1016,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+					   "amdgpu/%s_ce_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+						   "amdgpu/%s_ce.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+					   "amdgpu/%s_ce.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1044,8 +1043,8 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	} else
 		adev->virt.chained_ib_support = false;
 
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", chip_name);
-	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw, fw_name);
+	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
 	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
@@ -1093,15 +1092,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec_2.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_mec_2.bin", chip_name);
 		if (err == -ENODEV) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+						   "amdgpu/%s_mec.bin", chip_name);
 		}
 	} else {
-		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", chip_name);
-		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw, fw_name);
+		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   "amdgpu/%s_mec.bin", chip_name);
 	}
 	if (err)
 		goto out;
@@ -1112,15 +1111,15 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	if ((adev->asic_type != CHIP_STONEY) &&
 	    (adev->asic_type != CHIP_TOPAZ)) {
 		if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2_2.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_mec2_2.bin", chip_name);
 			if (err == -ENODEV) {
-				snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+							   "amdgpu/%s_mec2.bin", chip_name);
 			}
 		} else {
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", chip_name);
-			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw, fw_name);
+			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   "amdgpu/%s_mec2.bin", chip_name);
 		}
 		if (!err) {
 			cp_hdr = (const struct gfx_firmware_header_v1_0 *)
@@ -1194,9 +1193,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 out:
 	if (err) {
-		dev_err(adev->dev,
-			"gfx8: Failed to load firmware \"%s\"\n",
-			fw_name);
+		dev_err(adev->dev, "gfx8: Failed to load firmware %s gfx firmware\n", chip_name);
 		amdgpu_ucode_release(&adev->gfx.pfp_fw);
 		amdgpu_ucode_release(&adev->gfx.me_fw);
 		amdgpu_ucode_release(&adev->gfx.ce_fw);
-- 
2.34.1

