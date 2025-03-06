Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D211CC282DE
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 18:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2A4D10E050;
	Thu,  6 Mar 2025 18:58:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pz2SMN5q";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB8610E050
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 18:58:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gvu564UtPhpOigl5w2ZFMyIoV2Iz1ZjDXkNTRSoMci3q0IJteEDfo69MOLOHSIAhnPmpkjYrptzrkU+C+vnYxtnen2nbGhrm2JPvTwzcXLoUidbgib3xXsy0GxOSGY98qFvOwsHGJL855MJs7Xwf7A0KbDJAYjGYRKajnWocrSqkpHJgVHtln08avdZkh6h3fxI87KC27CplfMk4l9CWHaKuUErVq8RC7BwEikZVk8Lj9kOwFPHGhjnbt7xtmU6gtdbc5VbBfeUecAf/GUxJNlVRoJhhe0AErjbbNWMQhzO6u8ZFPiootoLEZUssRLtnv6y5JbGvfU2LZ4zgcoNkyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQM+sSRYqxc3RaWEKhIUbQuBd8DGr/MeMv/ZMPglE6A=;
 b=a53T4ZxSjadbPcjF71u0KYssELiK8/Y4uEeyHPQ0+RJvwYOjP/ijUma2fetYPsgH7Hjn6HqnMLhSapuKm+HX/BXThsHSRx5zWSwUokd3c05yqAPRYI/1tjG1YLUQS9no9ZYfX3uVh3ISUwSEGr8xxBxsRDFzQyrUNN8MmrygtocORqqdwLFs9CXJ8SDTEqXXYQr7Btdw9ogv+KBPDsGCDuumeIVp6oz+fnbPSFgG+WcCpJmVh++XMzAlGT/FiWNE/SdNjW27kdCETCE92PgESuQGmi8DlNJOl5hW4YLHmubvqT+rEnSo/XfpQZuj80BNxIVUhOKZpBJ/d6SJlS1tWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQM+sSRYqxc3RaWEKhIUbQuBd8DGr/MeMv/ZMPglE6A=;
 b=pz2SMN5qW0tSu8l04caakTQ/3+/nJGuVulMuvmBtjxf/fE+JtiSQ1G/Qz6S2uC9eihTeeV6Cc2JraBI06Bx1RILvywIokzmS8OjgHHXXYwfncDupI7s6tOXMXeLclFCIOjZqsYova2sX8+dcZHtVBuF1nwLwlgqpGq/bawLgf7g=
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by SN7PR12MB7105.namprd12.prod.outlook.com (2603:10b6:806:2a0::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 18:58:09 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::e1) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.17 via Frontend Transport; Thu,
 6 Mar 2025 18:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Thu, 6 Mar 2025 18:58:08 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 12:58:07 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amd: Fail initialization earlier when DC is disabled
Date: Thu, 6 Mar 2025 12:57:52 -0600
Message-ID: <20250306185752.50871-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SN7PR12MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: df027f61-cc98-4266-0628-08dd5ce0d59f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?amm4FsnYNbx+XOngwDmvcbIS3wS9lEoiIpT7hwjFrra+KuG2mvPEB9yCyxQz?=
 =?us-ascii?Q?Am8sRWZBaTAcsvBSykPN5vXGdSL7w3b1kEydKVnh1S0GyNF6Zqt7Qs0xV4bj?=
 =?us-ascii?Q?Y/lqj1BDEJJlFBVV4VeLLIk+7ZQPJk9V/t+Dn6sogS3lFA6NI8bTlCkAhph6?=
 =?us-ascii?Q?WtGCb5nk340vSt3zxLduofvA8yfcEBh0YHoi1mb0G+zGLzy1uDNuRn4tb5av?=
 =?us-ascii?Q?bpFiGdds084uSDsVs09Zpp+v5KweG2h6XCiGzVt7Z02/2FhwgREPiip96x4T?=
 =?us-ascii?Q?CTSiw4/DIZsu9MRDt5+rY1oQfP+Y3EhUYD5DHvLFUOhmFbj7NJmmWLF/LnwW?=
 =?us-ascii?Q?Kf1s3KcT47SnQKgfldszt4N6w45uyPck6OJ6vOZPcoJN1fxLjQ6C8c8+2zKV?=
 =?us-ascii?Q?YGB1R6DamAF7ato6ZVLcM1+X0k66S5+FjCAV08dvDkLlXj0Nb0bhT/Zb5V5o?=
 =?us-ascii?Q?/Ehlip43HptseIGuLXbhWvmUWEJyykFs3/te8Rg7zCYbCpdH3ugxYaYWM9eC?=
 =?us-ascii?Q?JmhwzwI66qUKdmpBZzfm8cFmHFOAfTN3o6H9VQbm4PXQuqKoiUX/pQNPHR8F?=
 =?us-ascii?Q?qvIdkLS0QuWBvkaxlGTdwxLIJzAMvrx8j9ftP0Vd3MufUW430oeDJTbOKTP2?=
 =?us-ascii?Q?SqWs9jvj/oPYKYms5V4y897RO0zgGgP6JhE+qmBRCDCJUFbnqq/M/YqVGWsg?=
 =?us-ascii?Q?FAy4CM82B/482y8/aEZWcTLDcOy+8ZNZpcutBTamgHrmvKOqyQiV6zwJ6Og7?=
 =?us-ascii?Q?dDuKd6jvUDgdTJvUIiZEKAMmLoT70LI6tp+WLq1G6itAYM0If7Fp0gnvqdjE?=
 =?us-ascii?Q?zsPLMlP1S1PMVsUl3Z+Nes0WpFnO8tehNhpj1nFEXbZ4wY4GblEt2FfOz0zL?=
 =?us-ascii?Q?UKeDN7xuf26kqCrcIeZfLN3rkYno2wNoUsEgMqdxM+YXYJLPOcZE1S9QUn6F?=
 =?us-ascii?Q?b48k2g1q0NQaaClyw4HTCDP1GNfywfjmAhjWrZT80n4bIzA8nylZztbKgZ9Q?=
 =?us-ascii?Q?pwIc/Bb+u8CKVidIvMRND/EYiHDctODnlxcL/4vTmxv/pgaCuKWBR0IanVPV?=
 =?us-ascii?Q?1AtHwRSvJOMN/0Vm5WY7raMASuVnVD3eZ07DS8SKhiR+W15bVe0Y9lvpxCC7?=
 =?us-ascii?Q?OOs0RSLu56/IMPRTkEPZh/OQ+l0zQvcCutpWoVPubLst5iRxT3vxZByLL2vm?=
 =?us-ascii?Q?cWDfU0T0pinX4qIovA4O4YIOy7/83JPGbacutIpya3tIcvL1p0eiGKg6Kx9u?=
 =?us-ascii?Q?wdGMRYGs5K2vutcSMATOr7Er964xI77E5pxQs9rVdHd7/rb04kTYtm/LtGn4?=
 =?us-ascii?Q?dJWS2HndWv4F3ucTuZk3QjXkXp4cOAmWsSM3paBPUSA7KvPWUuTkPhRKuzjV?=
 =?us-ascii?Q?j2iK7CiKGfxQGNOcGYy49mJ3F8RAgd0V2LamigOCsdaEfbvDCZQtkuJ9Rk26?=
 =?us-ascii?Q?szOEvX4RXnOtv+blvkvTG0mItUJ9BtbrneHC/zA+NP/kQjfjFS1fo39kdsB/?=
 =?us-ascii?Q?WLhYDmuSKFYeta0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:58:08.1314 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df027f61-cc98-4266-0628-08dd5ce0d59f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7105
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

Modern APU and dGPU require DC support to be able to light up the
display.  If DC support has been disabled either by kernel config
or by kernel command line the screen will visibly freeze when the
driver finishes early init.

As it's known before early init is done whether DC support is required
detect this during discovery and bail if DC support was disabled
for any reason.  This will ensure that the existing framebuffer
provided by efifb or simpledrm keeps working.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Update commit message justification
 * Add correct "default" handling
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 46 +++++++++++++------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a4258127083d..24f532de6322 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2139,10 +2139,6 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	if (!amdgpu_device_has_dc_support(adev))
-		return 0;
-
-#if defined(CONFIG_DRM_AMD_DC)
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		switch (amdgpu_ip_version(adev, DCE_HWIP, 0)) {
 		case IP_VERSION(1, 0, 0):
@@ -2166,39 +2162,63 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 1, 0):
+			if (!amdgpu_device_has_dc_support(adev)) {
+				dev_err(adev->dev,
+					"DC support is required for dm ip block(DCE_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCE_HWIP, 0));
+				return -EINVAL;
+			}
+
 			/* TODO: Fix IP version. DC code expects version 4.0.1 */
 			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
 				adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
 
+#if defined(CONFIG_DRM_AMD_DC)
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
+#endif
 		default:
-			dev_err(adev->dev,
-				"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
-				amdgpu_ip_version(adev, DCE_HWIP, 0));
-			return -EINVAL;
+			if (amdgpu_device_has_dc_support(adev)) {
+				dev_err(adev->dev,
+					"Failed to add dm ip block(DCE_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCE_HWIP, 0));
+				return -EINVAL;
+			}
+			return 0;
 		}
 	} else if (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
 		switch (amdgpu_ip_version(adev, DCI_HWIP, 0)) {
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 		case IP_VERSION(12, 1, 0):
+
+		if (!amdgpu_device_has_dc_support(adev)) {
+			dev_err(adev->dev,
+				"DC support is required for dm ip block(DCI_HWIP:0x%x)\n",
+				amdgpu_ip_version(adev, DCI_HWIP, 0));
+			return -EINVAL;
+		}
+
+#if defined(CONFIG_DRM_AMD_DC)
 			if (amdgpu_sriov_vf(adev))
 				amdgpu_discovery_set_sriov_display(adev);
 			else
 				amdgpu_device_ip_block_add(adev, &dm_ip_block);
 			break;
+#endif
 		default:
-			dev_err(adev->dev,
-				"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
-				amdgpu_ip_version(adev, DCI_HWIP, 0));
-			return -EINVAL;
+			if (amdgpu_device_has_dc_support(adev)) {
+				dev_err(adev->dev,
+					"Failed to add dm ip block(DCI_HWIP:0x%x)\n",
+					amdgpu_ip_version(adev, DCI_HWIP, 0));
+				return -EINVAL;
+			}
+			return 0;
 		}
 	}
-#endif
 	return 0;
 }
 
-- 
2.48.1

