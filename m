Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FBBEEB595
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Sep 2023 05:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5FD410E267;
	Wed, 13 Sep 2023 05:58:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE5510E267
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Sep 2023 05:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESZfFfnKvXqLEbl+w4kzyw09B1/xyCgP+GTmLekz+ujqAqWNze12bPM8/oEheTN+rMHARMVxqAOyvc5PDmE9ws2cgsJDtV3OSPRjPeD/djnM00gv/IKCMvtl5KRdI3qyPxVwT2Z8Oj2FdyudjvKmHCdnE7qhH3w9XNsNx75WYoFYXpSgZh3QJN0cufbAuG8V5jn2x4OwHzzRowcqMEZHVWSEOZnCW30HIPSAYgTk0Yj/FlsAliG6W+mCPUpS1FJoxPn6oBqYLP0vCCj9BSCNNn4hH4rfMYPqNeNzgdlP9S6BXJHqkJVvVq0PtoYZvokFvctgeOG/Kzbvk4Vky42Deg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1OhL22saaSFJYFinJUbrYYSws7Y3H0wHwrMRzzJxtI=;
 b=FZSHune4ij8EV3UKB+hsxWXVpLczB+JQD/LAMVNLHl4O0q14xzkptAXVt9UjTSi5LM9G+gbD2sQV90dz88OADghT3Igk+vbCWNm19HPkyhHq0ZeA+3Kt9Dqg6dd65XPGhw6DYU0tqpJRc/WG0bb0F0yS+2wE7TpvH8lfjtZYsjnbqQBPoThnJOp00aQndX+uuhuK3/riVknM9HvG6EdIYi4cAo6+ji3IcAOfvqf+TwWg/kVy4ABsZs5W/mvQhSGO1i5iQH2IU/AqoVy/vEikhx32++EO4xWCxUyJLgXY36v3f+oApmAi2TuM0h8rdYR8/+7dNgo/m8K7aqSPuxmG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1OhL22saaSFJYFinJUbrYYSws7Y3H0wHwrMRzzJxtI=;
 b=UkLHy0Rr+X8Ii08fM+3fGSAKS/mGeQrbzmGEZM/SjXfgaq6zSRKY8ZDBToagxjdxWkChcTrCGcjUKbjki915QA8RJ+dvM59mv15pbWolQ93MZqJHY9vWBZ0g0ZTOmwLnCjgzMtSpW36BZisaiprCrOM2SLlGQfQ83SrS1kF+1co=
Received: from DM6PR04CA0007.namprd04.prod.outlook.com (2603:10b6:5:334::12)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 13 Sep
 2023 05:58:18 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::1b) by DM6PR04CA0007.outlook.office365.com
 (2603:10b6:5:334::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19 via Frontend
 Transport; Wed, 13 Sep 2023 05:58:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Wed, 13 Sep 2023 05:58:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 00:58:15 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdgpu: Add more fields to IP version
Date: Wed, 13 Sep 2023 11:27:44 +0530
Message-ID: <20230913055744.1162406-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913055744.1162406-1-lijo.lazar@amd.com>
References: <20230913055744.1162406-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH0PR12MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: ef44110d-2bf8-43aa-ea91-08dbb41e6dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xct/hwkVyBZyPwd+B0RUdGUv2O01IyO+buhw32H9wCdZUglHvTqDs90obAxAWwrwc+G5ZioNNj7iePPjwgFdFR20Ru4aDZVv3Ypmm5DgsHBrerNT39aSV3S95W/tcY3V1aYvw73g2CvEXafIZDb8NHTKwnatR+ALmai4qeHAdzEeJKVwx2i6t8H5qmVPziZI3HL0p10tVo3K9Fbfw4u7lXWKCqihY6UokOWJ/b5OhXvhuw0oSqgInL8wcuLE0ICkMiXFzYc/N+IMtbEY7XnmO6XHtWbdLWhawyx9dlws/zJYwlrLRm9c50KKOFxm3MHIZfAPQDy1s1Cobxc0FhZIbMwbo7qcgolJ5oxxQpL1d3D0LTMPCMV7Futf+HhK66sjZFZk4gInmP2DFjWqPBHAsf6647ahfpvsIBb6T7tiE9XGBBegpBpvh/Xc/KcV4+WEUeAhG6/Ro0mXpWc95ITgZEzusSBECLOBx3pw2yD4pM2zO1DDIvYwZQFnohRk8eaNlXsPX5PL3IMMY8IuDCyNAG3E5YT3yqaughUIDHxV4mfWtKOx5h2M8tgVtf1S71qsQ6vcyBtYyBLUy7MDTMfZ75Mmr2PoilElMRM94ktgaHhtL08Ja3MY77MjfSroMUDa5P3/DMErbaxZrDl9OThXVCHr63HM2hUUeB3R9rRQaZ2f9EuEVy05NZFCtycqjjP9vWkDPwJH1TsauhG0yEHYmEHqzIMtZPcgJwWn/xVv6hd6ZKaazGTUHFQH9cycdCjsuDZwh+crQ4grEGslYZhfAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(81166007)(7696005)(6666004)(356005)(478600001)(47076005)(36756003)(40460700003)(82740400003)(36860700001)(40480700001)(86362001)(2616005)(26005)(426003)(16526019)(2906002)(336012)(83380400001)(54906003)(8936002)(1076003)(4326008)(70206006)(41300700001)(316002)(5660300002)(6916009)(8676002)(70586007)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 05:58:18.7201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef44110d-2bf8-43aa-ea91-08dbb41e6dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Marek.Olsak@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Include subrevision and variant fileds also to IP version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
v2:
	Use major/min/rev format in drm_amdgpu_info_hw_ip discovery version

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 18 ++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 ++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  8 ++++----
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 30f44db6c9c5..d62c245d8ad7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -681,10 +681,15 @@ enum amd_hw_ip_block_type {
 #define HWIP_MAX_INSTANCE	44
 
 #define HW_ID_MAX		300
-#define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
-#define IP_VERSION_MAJ(ver) ((ver) >> 16)
-#define IP_VERSION_MIN(ver) (((ver) >> 8) & 0xFF)
-#define IP_VERSION_REV(ver) ((ver) & 0xFF)
+#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
+	(((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev))
+#define IP_VERSION(mj, mn, rv)		IP_VERSION_FULL(mj, mn, rv, 0, 0)
+#define IP_VERSION_MAJ(ver)		((ver) >> 24)
+#define IP_VERSION_MIN(ver)		(((ver) >> 16) & 0xFF)
+#define IP_VERSION_REV(ver)		(((ver) >> 8) & 0xFF)
+#define IP_VERSION_VARIANT(ver)		(((ver) >> 4) & 0xF)
+#define IP_VERSION_SUBREV(ver)		((ver) & 0xF)
+#define IP_VERSION_MAJ_MIN_REV(ver)	((ver) >> 8)
 
 struct amdgpu_ip_map_info {
 	/* Map of logical to actual dev instances/mask */
@@ -1109,7 +1114,10 @@ struct amdgpu_device {
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
 					 uint8_t ip, uint8_t inst)
 {
-	return adev->ip_versions[ip][inst];
+	/* This considers only major/minor/rev and ignores
+	 * subrevision/variant fields.
+	 */
+	return adev->ip_versions[ip][inst] & ~0xFFU;
 }
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 430ee7f64a97..42d379956ef3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1191,6 +1191,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)
 
 static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 {
+	uint8_t num_base_address, subrev, variant;
 	struct binary_header *bhdr;
 	struct ip_discovery_header *ihdr;
 	struct die_header *dhdr;
@@ -1199,7 +1200,6 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 	uint16_t ip_offset;
 	uint16_t num_dies;
 	uint16_t num_ips;
-	uint8_t num_base_address;
 	int hw_ip;
 	int i, j, k;
 	int r;
@@ -1337,8 +1337,22 @@ static int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
 					 * example.  On most chips there are multiple instances
 					 * with the same HWID.
 					 */
-					adev->ip_versions[hw_ip][ip->instance_number] =
-						IP_VERSION(ip->major, ip->minor, ip->revision);
+
+					if (ihdr->version < 3) {
+						subrev = 0;
+						variant = 0;
+					} else {
+						subrev = ip->sub_revision;
+						variant = ip->variant;
+					}
+
+					adev->ip_versions[hw_ip]
+							 [ip->instance_number] =
+						IP_VERSION_FULL(ip->major,
+								ip->minor,
+								ip->revision,
+								variant,
+								subrev);
 				}
 			}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index dfd24a582391..1bf545154e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -502,21 +502,21 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 		switch (type) {
 		case AMD_IP_BLOCK_TYPE_GFX:
 			result->ip_discovery_version =
-				amdgpu_ip_version(adev, GC_HWIP, 0);
+				IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, GC_HWIP, 0));
 			break;
 		case AMD_IP_BLOCK_TYPE_SDMA:
 			result->ip_discovery_version =
-				amdgpu_ip_version(adev, SDMA0_HWIP, 0);
+				IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, SDMA0_HWIP, 0));
 			break;
 		case AMD_IP_BLOCK_TYPE_UVD:
 		case AMD_IP_BLOCK_TYPE_VCN:
 		case AMD_IP_BLOCK_TYPE_JPEG:
 			result->ip_discovery_version =
-				amdgpu_ip_version(adev, UVD_HWIP, 0);
+				IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, UVD_HWIP, 0));
 			break;
 		case AMD_IP_BLOCK_TYPE_VCE:
 			result->ip_discovery_version =
-				amdgpu_ip_version(adev, VCE_HWIP, 0);
+				IP_VERSION_MAJ_MIN_REV(amdgpu_ip_version(adev, VCE_HWIP, 0));
 			break;
 		default:
 			result->ip_discovery_version = 0;
-- 
2.25.1

