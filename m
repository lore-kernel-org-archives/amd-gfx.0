Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8ACCE8E77
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40DF110E9DA;
	Fri, 25 Oct 2024 02:36:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s54Li2w0";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36BF10E9D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDvat7jeIM5qNwV7RC/OvUwV/UzB2hgiowrpehj+xAG/08uNoH8NyaieSMuDxmCKKPPKcCPhhwEfJHnewcMZ/V54UggFsizjxvPLwHzsyNjEW94wZzIR3yoUPF52YIpnBNBAlKVcWxaAP4nqnJW2YA5OJgglRAwY88gK+Pw0W6vI4UzeIjbLPeiwMylBxVVNUjuI84azom1vvp29X0FKJ+5KRshzXmQpfot0RtXtsk8s19xgVmgwFq8bpGsL43CQUg8gN/KTskWlPYpSuQ5H1J9ouCRGVJcpL0cMvHqWLw2G5fi5Roh8af5Cv7pwmAwowhptMSJRxvu0u7Vdu3pYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ho+yi61hddhn173HDCnZDTgUpM/OqbXdvpouRp6T14A=;
 b=BO9jcekwrUPR5J1X6w6gLjJIk1uzlJG8sc7fAHQAQq6jr8Qi+vqu1/qz9cVXGJHn209BHHk3lnnvH8KYvIehtZ2S0iZHrjJ6EttBpH39ze/bc9D76fv7DYI7KVOZjSeKCGv0Q2DgDY6HjOyNAb6PwhZbBoTO4ZfoTwXx0wSJzfIGyHTosZ0NnUj7yl34sQ7ZdxJAIG+NYWInrBZ4LcQpyPda1yEm2y1ZzhORSVlcLEIBTccSsdknqUJBeN0nze9Bv54bsxwSSa3m3sRDOhW31m2uywJNwaxG1c7lgvWUsZsd6qP/ITHYdcOcmWEkY2p5sJSW6V3D8R0OcOI+lfWK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ho+yi61hddhn173HDCnZDTgUpM/OqbXdvpouRp6T14A=;
 b=s54Li2w0RSkyCmxt57ughWCRuUwBEv+IAt7ETVFgwCWZKm6UafJuQn9JHPlqlaNcFDf/+t42/3UWKjdOpflPC0Y/8xsrV2g+4x0I+gmr98ZZV6ZLXU/k9oRfjaapERDBZc/gSizOb9u3vy/Jh64+yNyzbbLPMtuccZo4jc+v6NY=
Received: from CY5PR15CA0176.namprd15.prod.outlook.com (2603:10b6:930:81::19)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 02:36:12 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::31) by CY5PR15CA0176.outlook.office365.com
 (2603:10b6:930:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:12 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:08 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 10/29] drm/amdgpu: move per inst variables to amdgpu_vcn_inst
Date: Thu, 24 Oct 2024 22:35:26 -0400
Message-ID: <20241025023545.465886-11-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dc79130-5448-4e2e-8408-08dcf49dca89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NEk5QkVJV09qTStCSkJKczdOUGp2UlA5cXdLdXhqa005Q2d1Z2h6aFVpT3VC?=
 =?utf-8?B?cm5qTU15ajB6cjVjb1V5RGpseGc2S1MzSkc0ekE0Tnh3eHBnY0pwbFF5Y1lx?=
 =?utf-8?B?RGNkODVCSXBreWdnbGgvNjZnWklwTUo1aXZibmZSdUF6MjhsZ1N0a1ZBSm1F?=
 =?utf-8?B?OGxvbE10bS9HN0dTM0ZvVnhNWlY3TGgzdnlYeGFZdUVoRkRmejNQN0tJTno3?=
 =?utf-8?B?NCs0bXF5djlaRklJM0YvMVZ4aHJnYUhkUTVVdEZqVEFIdkdDa1Q0V0JSOEFW?=
 =?utf-8?B?V3pSRzVIeUZLcTFTRWszNU1YN2pOS2NhcG80U05WSzhoT3BDbHYxOWM3WDFm?=
 =?utf-8?B?aU16VWptN21MMTlBWmVaYzV4QzlVZ1Q4THZyR0NLUkhwaEN6eEpWSGR4R0l5?=
 =?utf-8?B?a3YzV2NIUTJnWllITkNTTUVtaGczYlltTnJvVWpzWjBuOFpHdUZLRWJVV1NU?=
 =?utf-8?B?dUUveDlON0h6T0ZDNTVhMHA4YjlkRng5NmppVTZTcCtmc3RxK1kydzMram5x?=
 =?utf-8?B?dXIvZFQycnFPNitwQ2pRTXJ2L2FiK2FYbmpMRzNzMER1Ulh1YlRZZUNRYnZO?=
 =?utf-8?B?U0xSS093djQvdzd0L1luYWJhSkM1anIwV04veXVtRmZPeGFmNzFyVVdNN0sx?=
 =?utf-8?B?ci9kaW5TZnJ2MzdvOE1RNGJJdjRLWFUrYjgrc0RUL1Q4cnZ2eGZ6WnRUSDc4?=
 =?utf-8?B?TUptSHJ1Q2VIRWxnaGRBVlNDZW1tdE93UmlxblNwaFgyRFhwWkFWSHFlcUNH?=
 =?utf-8?B?NFZTOUwrM0RvUGlpK2dDenU3cWFvbHJOL2pXOE5OeXBobVIrVVM1KzdERkJY?=
 =?utf-8?B?WXd6ckpXaUdOUGVkRWovZE01cmJ2bFpaN2pRcVR3WFNYaGYwRmlxcnp5aXVv?=
 =?utf-8?B?RUcyd3pzNW5QYkRwaG5aYjgyV2xXWmdkeGR0akJHZjh0MGptR2RHcnZGYUs4?=
 =?utf-8?B?QXB0enNYelg0NFBFbHVOVWYrbytqZWgrTTBNWVo1Sld6VTNHMnkwaEdldkdp?=
 =?utf-8?B?Sit6Y3lteHVaL2tzckd2V1dsNG9nS2FVWXBhT1F3SDBVc1BkdUVLNWZKNnpr?=
 =?utf-8?B?YzJFOTFDa2tyZG5yRmgxYUtzL0dKbkRiOE1LM2RzOHU1S1g5VzBCblVodStx?=
 =?utf-8?B?TXBFcmIrNFB2WGRBZDVKTmpzb1dERHJKbXlkdDhibXZDSmRHaThyaG1EMjNG?=
 =?utf-8?B?THVvbDhWTm4zZjFXckdDT1BZOGd4L05sRGkvZzhHVVBQN3QvZkJOaXBCcGRX?=
 =?utf-8?B?UGlHQnNKdjRCTUhnU2xCSWlxN1owT3BnQ2tyN0Z0YW5qditUL0hRSXhURG85?=
 =?utf-8?B?MXVDSUhTbzEramFxYlViRlNUeVNIQkNvOU1MZHNZczVZRDV3cDlPS3krTURO?=
 =?utf-8?B?QUxKeERIQkhzSG9Cc0xibkRyRFgwME1IeCtpTWpvQkRlZFFISXRqQm5EWmJw?=
 =?utf-8?B?N3ZQT0JrYmhsYi9MWjB5STdFVmhWeUVWNmdySkQyOW93dWhNZDhCZEJSc2Mx?=
 =?utf-8?B?aUR3cldmQTZyMWpvWVd2NXc0eUh1V0ZKb2Z3S1I0NlhxZy9jczR4dHNGWHlj?=
 =?utf-8?B?alpjbUhTM3E1WnFneTNOZmlxanIyYldZVU9lakp6ZkJqN0VKNDNjZDU0NTM0?=
 =?utf-8?B?YzZIUXhvVFhjRThINnBDVXJaM05GdkJDUFgrRHMzTk9nVXBhL3psWE9KK005?=
 =?utf-8?B?Mlp3WnZNYXJYb3Z2SHpmR3R5WHdXNVRLaWl3QjkzanNQOEFWOVVvYWNReVNI?=
 =?utf-8?B?amZ0YXo3eW54VXJCL0VIWGd2VDcvODMxYUNYU0JJMVJCS2JQTTQ4RktQNi9w?=
 =?utf-8?B?Mklzcjh6UVJCNVIwYjVTS2p2eTd6emNTRGFiMU9KbW5ZaWNkb29GM09QdnZv?=
 =?utf-8?B?VnkvK0YvVjc3THpNQ2EyTHZXanp4ZFhPcHgydUlpU0RyNFE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:12.2945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dc79130-5448-4e2e-8408-08dcf49dca89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

Move all per instance variables from amdgpu_vcn to amdgpu_vcn_inst.

Move adev->vcn.fw[i] from amdgpu_vcn to amdgpu_vcn_inst.
Move adev->vcn.vcn_config[i] from amdgpu_vcn to amdgpu_vcn_inst.
Move adev->vcn.vcn_codec_disable_mask[i] from amdgpu_vcn to amdgpu_vcn_inst.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 20 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  4 ++--
 11 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 73f4d56c5de4..cce3f1a6f288 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1340,7 +1340,7 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 				 */
 				if (adev->vcn.num_vcn_inst <
 				    AMDGPU_MAX_VCN_INSTANCES) {
-					adev->vcn.vcn_config[adev->vcn.num_vcn_inst] =
+					adev->vcn.inst[adev->vcn.num_vcn_inst].vcn_config =
 						ip->revision & 0xc0;
 					adev->vcn.num_vcn_inst++;
 					adev->vcn.inst_mask |=
@@ -1705,7 +1705,7 @@ static int amdgpu_discovery_get_vcn_info(struct amdgpu_device *adev)
 		 * so this won't overflow.
 		 */
 		for (v = 0; v < adev->vcn.num_vcn_inst; v++) {
-			adev->vcn.vcn_codec_disable_mask[v] =
+			adev->vcn.inst[v].vcn_codec_disable_mask =
 				le32_to_cpu(vcn_info->v1.instance_info[v].fuse_data.all_bits);
 		}
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index aecb78e0519f..49802e66a358 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -99,11 +99,11 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
-			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s_%d.bin", ucode_prefix, i);
+			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
 		else
-			r = amdgpu_ucode_request(adev, &adev->vcn.fw[i], "amdgpu/%s.bin", ucode_prefix);
+			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
 		if (r) {
-			amdgpu_ucode_release(&adev->vcn.fw[i]);
+			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
 			return r;
 		}
 	}
@@ -151,7 +151,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 	adev->vcn.using_unified_queue =
 		amdgpu_ip_version(adev, UVD_HWIP, 0) >= IP_VERSION(4, 0, 0);
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[0]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[0].fw->data;
 	adev->vcn.fw_version = le32_to_cpu(hdr->ucode_version);
 
 	/* Bit 20-23, it is encode major and non-zero for new naming convention.
@@ -270,7 +270,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 		for (i = 0; i < adev->vcn.num_enc_rings; ++i)
 			amdgpu_ring_fini(&adev->vcn.inst[j].ring_enc[i]);
 
-		amdgpu_ucode_release(&adev->vcn.fw[j]);
+		amdgpu_ucode_release(&adev->vcn.inst[j].fw);
 	}
 
 	mutex_destroy(&adev->vcn.vcn1_jpeg1_workaround);
@@ -282,7 +282,7 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
-	int vcn_config = adev->vcn.vcn_config[vcn_instance];
+	int vcn_config = adev->vcn.inst[vcn_instance].vcn_config;
 
 	if ((type == VCN_ENCODE_RING) && (vcn_config & VCN_BLOCK_ENCODE_DISABLE_MASK))
 		ret = true;
@@ -362,12 +362,12 @@ int amdgpu_vcn_resume(struct amdgpu_device *adev)
 			const struct common_firmware_header *hdr;
 			unsigned int offset;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.fw[i]->data;
+			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
 			if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
 				offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
 				if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 					memcpy_toio(adev->vcn.inst[i].cpu_addr,
-						    adev->vcn.fw[i]->data + offset,
+						    adev->vcn.inst[i].fw->data + offset,
 						    le32_to_cpu(hdr->ucode_size_bytes));
 					drm_dev_exit(idx);
 				}
@@ -1063,7 +1063,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 			if (adev->vcn.harvest_config & (1 << i))
 				continue;
 
-			hdr = (const struct common_firmware_header *)adev->vcn.fw[i]->data;
+			hdr = (const struct common_firmware_header *)adev->vcn.inst[i].fw->data;
 			/* currently only support 2 FW instances */
 			if (i >= 2) {
 				dev_info(adev->dev, "More then 2 VCN FW instances!\n");
@@ -1071,7 +1071,7 @@ void amdgpu_vcn_setup_ucode(struct amdgpu_device *adev)
 			}
 			idx = AMDGPU_UCODE_ID_VCN + i;
 			adev->firmware.ucode[idx].ucode_id = idx;
-			adev->firmware.ucode[idx].fw = adev->vcn.fw[i];
+			adev->firmware.ucode[idx].fw = adev->vcn.inst[i].fw;
 			adev->firmware.fw_size +=
 				ALIGN(le32_to_cpu(hdr->ucode_size_bytes), PAGE_SIZE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 765b809d48a2..ba58b4f07643 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -297,6 +297,9 @@ struct amdgpu_vcn_inst {
 	atomic_t		dpg_enc_submission_cnt;
 	struct amdgpu_vcn_fw_shared fw_shared;
 	uint8_t			aid_id;
+	const struct firmware	*fw; /* VCN firmware */
+	uint8_t			vcn_config;
+	uint32_t		vcn_codec_disable_mask;
 };
 
 struct amdgpu_vcn_ras {
@@ -306,15 +309,12 @@ struct amdgpu_vcn_ras {
 struct amdgpu_vcn {
 	unsigned		fw_version;
 	struct delayed_work	idle_work;
-	const struct firmware	*fw[AMDGPU_MAX_VCN_INSTANCES];	/* VCN firmware */
 	unsigned		num_enc_rings;
 	enum amd_powergating_state cur_state;
 	bool			indirect_sram;
 
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
-	uint8_t			 vcn_config[AMDGPU_MAX_VCN_INSTANCES];
-	uint32_t		 vcn_codec_disable_mask[AMDGPU_MAX_VCN_INSTANCES];
 	struct amdgpu_vcn_reg	 internal;
 	struct mutex		 vcn_pg_lock;
 	struct mutex		vcn1_jpeg1_workaround;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 00d9fdd2869e..5ea96c983517 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -345,7 +345,7 @@ static int vcn_v1_0_resume(struct amdgpu_ip_block *ip_block)
  */
 static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -412,7 +412,7 @@ static void vcn_v1_0_mc_resume_spg_mode(struct amdgpu_device *adev)
 
 static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index de4067713d7b..e42cfc731ad8 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -372,7 +372,7 @@ static int vcn_v2_0_resume(struct amdgpu_ip_block *ip_block)
  */
 static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	if (amdgpu_sriov_vf(adev))
@@ -428,7 +428,7 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 
 static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1920,7 +1920,7 @@ static int vcn_v2_0_start_sriov(struct amdgpu_device *adev)
 
 		init_table += header->vcn_table_offset;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[0]->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[0].fw->size + 4);
 
 		MMSCH_V2_0_INSERT_DIRECT_RD_MOD_WT(
 			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 08f43a281a7f..b518202955ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -465,7 +465,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 		/* cache window 0: fw */
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
@@ -514,7 +514,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 
 static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1287,7 +1287,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 			SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 		/* mc resume*/
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V1_0_INSERT_DIRECT_WT(
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6002990d917b..63ddd4cca910 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -490,7 +490,7 @@ static int vcn_v3_0_resume(struct amdgpu_ip_block *ip_block)
  */
 static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -540,7 +540,7 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 
 static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
-	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[inst_idx]->size + 4);
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[inst_idx].fw->size + 4);
 	uint32_t offset;
 
 	/* cache window 0: fw */
@@ -1375,7 +1375,7 @@ static int vcn_v3_0_start_sriov(struct amdgpu_device *adev)
 			mmUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V3_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 2c36f748176f..1a6257d324c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -422,7 +422,7 @@ static void vcn_v4_0_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -482,7 +482,7 @@ static void vcn_v4_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 {
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -1334,7 +1334,7 @@ static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)
 			regUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index eda67585768f..23a2a80129bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -377,7 +377,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev, int inst_idx)
 	uint32_t offset, size, vcn_inst;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	vcn_inst = GET_INST(VCN, inst_idx);
@@ -452,7 +452,7 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -939,7 +939,7 @@ static int vcn_v4_0_3_start_sriov(struct amdgpu_device *adev)
 		MMSCH_V4_0_INSERT_DIRECT_RD_MOD_WT(SOC15_REG_OFFSET(VCN, 0, regUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
-		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw[i]->size + 4);
+		cache_size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.inst[i].fw->size + 4);
 
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, 0,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index f24e1eef6606..e49ba5bc7fa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -370,7 +370,7 @@ static void vcn_v4_0_5_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -431,7 +431,7 @@ static void vcn_v4_0_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 8ccd054975a1..900ca8ababc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -334,7 +334,7 @@ static void vcn_v5_0_0_mc_resume(struct amdgpu_device *adev, int inst)
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
@@ -395,7 +395,7 @@ static void vcn_v5_0_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_i
 	uint32_t offset, size;
 	const struct common_firmware_header *hdr;
 
-	hdr = (const struct common_firmware_header *)adev->vcn.fw[inst_idx]->data;
+	hdr = (const struct common_firmware_header *)adev->vcn.inst[inst_idx].fw->data;
 	size = AMDGPU_GPU_PAGE_ALIGN(le32_to_cpu(hdr->ucode_size_bytes) + 8);
 
 	/* cache window 0: fw */
-- 
2.34.1

