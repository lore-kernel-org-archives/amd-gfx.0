Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD3EEE57DF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 11:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E1A10E2C8;
	Mon, 11 Sep 2023 11:45:32 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A789810E2C8
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 11:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUVB00Yaw0OUgbokiqOu8LtMmIKOOr1s6hMCvzonuNug5EBdaO1zXYnmbwix3UHwsVyuUnDm8mrpKu+cl8iIVNjPGQD/pQzd+IE8YZY8ZTXJ+Gr6nyOSmrDDY+5Yrnfii59BokPlJLN+dwn9JrPeNnzyuuQwxb0o80l9mqn7rHGqt74c6MOmEWbxjOsQ8adUIYrg+yYew0h7FxTTXnT0sNqSKruEDglgfFDOkPiiHZPra5fNdQ7FHiCaU8Z3RXtlI1ku2V/k5XdgQpkkk5DV+TeSybRYXdjMRAw7J+8OnsIPXmaMsE+BGuGBhhFrZ3MR/G927uEG8VD8pEt4rsE/+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eORqDaI1ckj0imU+/iMccxtX42iQaqgMFVGB1Ca5xFU=;
 b=SfwK/f+0/Ne2gR/RCOZzWONtQSIT4vf/cBPGF7xof0yZHne05HSMLiOf3oBPUlQmAWeN0hXYNbubkKL8uxuyrKFn9i4mhWwLDWeS+O1ojuJusRVG45ElBoxDUDiI4PBvlOaVfYVE9Os95YTq/a6HlxF6+0InagKC9rccqi0fQbCOyHjWFUgvJI/hV2yJII8sjg3Eu8OhYCZC3W/bQRF/ePnKSuR8oRWDVlAW6pYdQS9lcLYqJ99QSX2NCZWHmaXY8bE1pIJHq6RsN+qJAz2Iw8qcl1JlA6vaoc2RSDpdfGy+Hqujdozm9JVcUtDEE/I+4k7TVXX69n7xCaXyySIY/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eORqDaI1ckj0imU+/iMccxtX42iQaqgMFVGB1Ca5xFU=;
 b=beyyLnM6PAnJNg0rue0xOGlEhZtzv/lh8k/y3AmFM540zR+a/wGjmblH5LvBKmUqRbGcogDOMR5rG17AY5sUEEuhcVpGGf+bu3L3EWOsXgBrUAVhCu0/S8Hl1nCsws7xaf6bqrvt5dJGL62e0vxw9/FyZ2zeX3Me4ve/ZaHVXaQ=
Received: from MN2PR08CA0003.namprd08.prod.outlook.com (2603:10b6:208:239::8)
 by LV8PR12MB9133.namprd12.prod.outlook.com (2603:10b6:408:188::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Mon, 11 Sep
 2023 11:45:27 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::70) by MN2PR08CA0003.outlook.office365.com
 (2603:10b6:208:239::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 11:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.17 via Frontend Transport; Mon, 11 Sep 2023 11:45:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 06:45:26 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: Add more fields to IP version
Date: Mon, 11 Sep 2023 17:15:03 +0530
Message-ID: <20230911114503.1124617-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911114503.1124617-1-lijo.lazar@amd.com>
References: <20230911114503.1124617-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|LV8PR12MB9133:EE_
X-MS-Office365-Filtering-Correlation-Id: d95533f5-4431-4151-8cae-08dbb2bc9823
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkSaQYnGFS41a9VXU+nICfoQr+wVkruXR5CzmaPjWoPHdgUCK6Yp30Hbkrb28mz/ALGMUntXDnBlOYvj9t5KYmfooQSn/UYHbf05pq1ni0IVwA7IRMdimEjxtBc0+TreewSpBIicFowLtRPPOhxaCdji3eUHcNCauMbJ79D5A6zGUgVSMmoHAdiJ+wqOWiJhuyyiSNLkFVxPM24y2EzKwof0zRT4KdqPEX4LtwgpBpg6aQnj/iweW682P9CsL4mlApw2v7QAlX1ncyYVE/35+FCnz/rZ10qNG3gVuiMU4NKFxUS0ZnR0uIft6c4J/8iaS6Rjm9zLi6Ym4e54NzBJGbiY5qMtMwybNMsSgXVkXa+e08hfpOFDzgkHva4T7a/JPXzQ9FdrC3TU6q4UKAl631CQ3rVTe2q6jAjChYf/A3vHL64hBSETNyzCRWpvZMsNj0yucjLJb1NDrEf0x40+BnxwUcdp2UnYwzXoYP/isd0rFzamDMvy6+eeYQ8X6nX47TwruqsH9u3Yj11RfcwK+sKaidkQRH1CeIAimWiJZRvk5f7Xp29Kg9trDGhi6f/d1oMD1RTlM6piKw9q14wUiDB/LjFSo3c19wEDiC4653LXccXXgYdSRoKIgliBXZHj/dazyydHAPeREnnFmmU84i+20QOnmEgxvbwY0tp1FojjcXcoulHZbYRBwsf6NwdXKgiBYgkATOz+4E1HC7brD/l1Fqh+Fy2x1UUoAMisfFJ1Jl9Gb9v/q8hT3tlKYm3xTQGyI3C8BlPnwz8cf4hUDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199024)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(36756003)(41300700001)(8936002)(40480700001)(6916009)(83380400001)(44832011)(478600001)(6666004)(2906002)(70586007)(8676002)(4326008)(5660300002)(316002)(54906003)(70206006)(7696005)(26005)(1076003)(40460700003)(16526019)(336012)(2616005)(36860700001)(426003)(356005)(82740400003)(47076005)(86362001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 11:45:27.8650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d95533f5-4431-4151-8cae-08dbb2bc9823
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9133
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Include subrevision and variant fileds also to IP version.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 17 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 20 ++++++++++++++++---
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 927c049e6132..fbbb1855b243 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -681,10 +681,14 @@ enum amd_hw_ip_block_type {
 #define HWIP_MAX_INSTANCE	44
 
 #define HW_ID_MAX		300
-#define IP_VERSION(mj, mn, rv) (((mj) << 16) | ((mn) << 8) | (rv))
-#define IP_VERSION_MAJ(ver) ((ver) >> 16)
-#define IP_VERSION_MIN(ver) (((ver) >> 8) & 0xFF)
-#define IP_VERSION_REV(ver) ((ver) & 0xFF)
+#define IP_VERSION_FULL(mj, mn, rv, var, srev) \
+	(((mj) << 24) | ((mn) << 16) | ((rv) << 8) | ((var) << 4) | (srev))
+#define IP_VERSION(mj, mn, rv) IP_VERSION_FULL(mj, mn, rv, 0, 0)
+#define IP_VERSION_MAJ(ver)	((ver) >> 24)
+#define IP_VERSION_MIN(ver)	(((ver) >> 16) & 0xFF)
+#define IP_VERSION_REV(ver)	(((ver) >> 8) & 0xFF)
+#define IP_VERSION_VARIANT(ver)	(((ver) >> 4) & 0xF)
+#define IP_VERSION_SUBREV(ver)	((ver) & 0xF)
 
 struct amdgpu_ip_map_info {
 	/* Map of logical to actual dev instances/mask */
@@ -1104,7 +1108,10 @@ struct amdgpu_device {
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
 
-- 
2.25.1

