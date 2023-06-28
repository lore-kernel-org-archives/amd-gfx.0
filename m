Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B607DEB64DC
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 21:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C2ED10E39B;
	Wed, 28 Jun 2023 21:24:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2114C10E39B
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 21:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpPkiaO47w9EEKVIsxvAxSylFvKvGehOqazyDrOCxruztCjSBMEiCOVz7UtXAi9u4QoLMhH8frJKnUct3mirMwSoAX+EU0C3tB3ThzfB9F6uoBD384YYHMNjmSSZ0P1F7/CmPnFQMFWGGIOUuKGRIEPM391IaHYQ9OEJJt726VNjhO3p0+e7WL/Ss594S3trXL+BtheMh3am7O40MKpmhnNgOCmjRR4I5VqN51l5ZOqhwVG5qcdAbyOY339vE8PjBHHsSf4LNepK1tNWxO+ZytToRRagCaK9u7RsP9pGgiLG99MqexNymGN+ZILe3MM7wd35WEI2MigLnSviu0Vx4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qm4h2IIVLx/50RkYv57X9ad7i1I1qYz9ZD/h3cnU1Q=;
 b=Md2Y/jxtGopERiLbkGIpqp5FHwdI4WGfxoTA2IsnGPVWnl1sXMIhEC7yq4XaWzufgAJzGEE1abTC+hREF8WHpxE4Gow2GFsltnDcRCz7ohDsJuk+nTx9H+/rwR6sO2x3LSNjkD+t51ZOSgujj89sSzkr4ILS+lA3oYMKLrt1ghRtssgMNMNFxvqSF2U7XVwjlrTO80IKPINujsj96frIIn2xZS7y6242K+xz07qCa8GJAboWCYASW379rXx10K68Eqt6S9b9c6lEcgM8XSzKprcvnQSffaoA5Zcoq4tOt1X/gsg5/FcnEStfIBRgBqNOjtQ4EFhSd0kdOTkdEvhGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qm4h2IIVLx/50RkYv57X9ad7i1I1qYz9ZD/h3cnU1Q=;
 b=gMbmAMPu9PIqiRc5L7NzaRh0Q0axpNj7sYXISAj1KtrUmGT6w56BQbyzOoqodfSd1C0/hREnXOmE1UMdwofz2s0bUIgsvhPEUoA5+OI6uiPKpQw6i2HxS30bswCUKIDKGdqfArd1EX3em2Ygg9barv63nH4Y6an8tfxvblhgsTM=
Received: from SJ0PR13CA0049.namprd13.prod.outlook.com (2603:10b6:a03:2c2::24)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.47; Wed, 28 Jun
 2023 21:24:03 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c2:cafe::ba) by SJ0PR13CA0049.outlook.office365.com
 (2603:10b6:a03:2c2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.6 via Frontend
 Transport; Wed, 28 Jun 2023 21:24:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 21:24:02 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 28 Jun 2023 16:24:00 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/5] drm/amdkfd: add xcc instance for debugger APIs
Date: Wed, 28 Jun 2023 17:23:22 -0400
Message-ID: <20230628212323.248650-5-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628212323.248650-1-jinhuieric.huang@amd.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 04d74fc7-c1b4-4032-d363-08db781dfef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: APwS7tLwiD+hKnHY4j2kBmWhBMuGOUIUzydHNh8gLN2ZFRH/H9ab1A6fyjrVI+9A6BMvilGIC+tB+DM5/JIvnWLq9s81yDLYEy9bhQN4j/H+Me4gTH9aZubTj3RTBF/Q3NciVzXighCbvQa/ah/v0K61qagCJnr9cpA7g/0gGoM4YJ3B6hJuevzbdZn8unJRgQR/EoStUh57Z1FGQ6uBVkF+CPs31pxSsqEfuOFuflFFvDgAy6hw7qCU60fqwKgzmRmCEIItmJCkHoEz1yJYFMnh0I8V0g6VrZmWVE+o9twtpeWFljGG+POvk/TFe1DL6f9/4ou6t4NS38Ngj5w4f0U9euiJNz6VXxpzZc+VRF2NbWvvxq5X9EQrlNJz/s2GEZVasWyMphlaCxuhNKSp8i3GhWZMoIg4fIxB1Ik6Y+nFivZi2NOhFfIyvDL2UoKwViW37wCMRsITITPQ5ksnj08Ty2lxFU9prdRXhI+9FhSmpG92q6JiWQX3FiJ1nQ0b+kwspRQfdqDEBqB9gRqj92TgoIBkBtO2x7oSHiVvxFJUHilkaqX+dMDGEgTcwS6O0GZ5/DiZu0DdKCUxpTFhyvJRCMiQ3e3AkgSC6poCAfCqntWCYtnWTXS2NXc8Rj97kjyEQnHjtWMV8pBhUbY+fy8TJULSgFCjnMLBeKY+csgbnvfSZ2DgP1EeZThw54O3U216NjIWGjh0pRmM5W6+F4KLM4QSCSp+D/3wYyWJ+WaSyrnVBm6htJsxWDPKipivhreQtmfeFHQTlMFylKPOzGThDGIPUSw1l2ENOgeK/FIV+qfv6V9K+0o2vzVPX17B
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(478600001)(6666004)(83380400001)(2616005)(426003)(7696005)(336012)(54906003)(1076003)(2906002)(186003)(26005)(47076005)(16526019)(86362001)(4326008)(70206006)(40480700001)(41300700001)(356005)(40460700003)(5660300002)(36756003)(70586007)(81166007)(82740400003)(316002)(6916009)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 21:24:02.8856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d74fc7-c1b4-4032-d363-08db781dfef0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan.Kim@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since GFX9 GPU has multiple xcc instances, this is to
implement this change in KFD for debugger APIs.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c  | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c    | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h    | 6 ++++--
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c               | 6 ++++--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h      | 6 ++++--
 9 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index f3f7e0437447..c7f88bfa1976 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -126,7 +126,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst )
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -163,7 +164,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 }
 
 static uint32_t kgd_gfx_aldebaran_clear_address_watch(struct amdgpu_device *adev,
-						      uint32_t watch_id)
+						      uint32_t watch_id,
+						      uint32_t inst)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 7aab8dcf46e1..17fe4e90f203 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -454,7 +454,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 				uint32_t watch_address_mask,
 				uint32_t watch_id,
 				uint32_t watch_mode,
-				uint32_t debug_vmid)
+				uint32_t debug_vmid,
+				uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -491,7 +492,8 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 }
 
 static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device *adev,
-				uint32_t watch_id)
+				uint32_t watch_id,
+				uint32_t inst)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8ad7a7779e14..225b8929a878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -942,7 +943,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 }
 
 uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id)
+					uint32_t watch_id,
+					uint32_t inst)
 {
 	uint32_t watch_address_cntl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index e6b70196071a..c904a08b022b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -44,9 +44,11 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id);
+					uint32_t watch_id,
+					uint32_t inst);
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 91c3574ebed3..d5d0ca6a14d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -780,7 +781,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 }
 
 static uint32_t kgd_gfx_v11_clear_address_watch(struct amdgpu_device *adev,
-						uint32_t watch_id)
+						uint32_t watch_id,
+						uint32_t inst)
 {
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51d93fb13ea3..7aabe6722726 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -878,7 +879,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 }
 
 uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id)
+					uint32_t watch_id,
+					uint32_t inst)
 {
 	uint32_t watch_address_cntl;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 5f54bff0db49..519f05b86a05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -89,9 +89,11 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
-					uint32_t watch_id);
+					uint32_t watch_id,
+					uint32_t inst);
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
 void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index fff3ccc04fa9..dcc49183364b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -427,7 +427,8 @@ int kfd_dbg_trap_clear_dev_address_watch(struct kfd_process_device *pdd,
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
 	pdd->watch_points[watch_id] = pdd->dev->kfd2kgd->clear_address_watch(
 							pdd->dev->adev,
-							watch_id);
+							watch_id,
+							0);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
@@ -466,7 +467,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
-				pdd->dev->vm_info.last_vmid_kfd);
+				pdd->dev->vm_info.last_vmid_kfd,
+				0);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index d0df3381539f..3749d193238a 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -315,9 +315,11 @@ struct kfd2kgd_calls {
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 	uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
-			uint32_t watch_id);
+			uint32_t watch_id,
+			uint32_t inst);
 	void (*get_iq_wait_times)(struct amdgpu_device *adev,
 			uint32_t *wait_times);
 	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
-- 
2.34.1

