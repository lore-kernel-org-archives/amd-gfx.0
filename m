Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8303E92FF8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 08:51:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A32210E231;
	Fri,  6 Oct 2023 08:51:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C415410E231
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 08:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNIw0/hwis1W/jOJqVoL3xIwfKa1IQm/59ZgZbNp/AWjaCxKQM9abcZ8RMFHPZ4NTjIOEUHIsFDjQpiW94BARrftKrDAWtVZlZcFforFyLiERCh1PDS+9Avf6o35Mr6fMLSI4Uk2CZFjFhV7ZAAJffSHmq2ArA0W+HtVFJJlXy6nmFKPd+K7yVq5X/DtyFKt+haGbspQqxJm2PrvYi9LIpGik2AKHxmTTWpSPaKT0QjTC5Dq7lbY95v3eS4pdvbz7YdIiDFLQMcbrjtRp6ZR1Adhsj5mmteH4dktKrYzwZZbjZ46fCqW30F2qt1GpaDj+zMr479bScF08qXwbV5xvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=03XfYXj1QFcJBSHnK6XQnCDxU24WzjjzvJoLqb461VQ=;
 b=V9qo+MH7VnP/jOhjbRwlo5+F53rpyILvvacE1ugweyEcjD14oqEHLirtQ6BE+9L5LymgUUz7utYP9Y1XakuYrbfMAvkcjfLgT8HoFX7N4uls6FG12DM14S/oM2ug1j8aIGmnnJ1LXwUiN6q35Uvow/8KCgHAnZwWUYNAfIbJPhaDtOfowvEF6ZuRSsao0ag9e3gA15UB8LiZSyJWoZ9kLzGcoMJV0GQI8042fqZoZMXY4jf3w0lmaR7cyaD8ElvVU2qsMY5wdtpR+F/Mvq0UmR4rWS2xEanr8Dr1Nchek6JrS27Yg9qzNTEivwV/hczgK0G4duDX7uzU1akjnGPOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=03XfYXj1QFcJBSHnK6XQnCDxU24WzjjzvJoLqb461VQ=;
 b=XvBPK0n1nr5EXWyNc7NR0rM60IriQqktICwC2ZzOhfJ9SXTmYpR93IqgOqJ2wc55m+4jk4vpnJF7PJQRkSUhFd/C7axygciapgLrmUsUst+g4/m6LWUEYeCt0mbdybj3L6tWEgGPBgK5Z5bztx/evMLUib2poYdEBSQ/XKfqYQ4=
Received: from DM6PR02CA0083.namprd02.prod.outlook.com (2603:10b6:5:1f4::24)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 08:51:51 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:1f4:cafe::9f) by DM6PR02CA0083.outlook.office365.com
 (2603:10b6:5:1f4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.30 via Frontend
 Transport; Fri, 6 Oct 2023 08:51:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 6 Oct 2023 08:51:50 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 03:51:45 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: add hub->ctx_distance in setup_vmid_config
Date: Fri, 6 Oct 2023 16:50:59 +0800
Message-ID: <20231006085059.3269316-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ecf20e-dbaa-4010-34a3-08dbc6497b68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KMN5WirIcO4kwgRqAkUcEbyhgxR3dPu4e/fXntSdKBBIsNVerqwGXczo6c/DHWGpkE/jwWVqMKU+jYscEsJkF0YlehHxN1wW/JU0AQ4WbdRIzOX4UukzksNK0dnWzVLj1G9cW75gBkRRVaFbrdrxsC/0+6QaFMvLYE9GiWjJ+13cq2IGxlfbQnZT42BoFPLOHLx88x2ZXIQwBgn6dlBy6tvM3apHi5mSLHjAofNembXe+tC/+/tLBVrYzTkJi0PGchPuAzAG0DmLto8TaoIE1U6vjvq9bLpBG6ao6dl4q+h+IO9apeOdb7Ge4PWNgj8w6ivrutjm54HySjEZsksvh5hJeBRaqPPD2sfU+lq72u55SY+4GrwzZr29DAf4zQ8K7k2oo+K1LL+AZR8DwY1M22ncbW6Nh2IHVbYrrN9jSrSkwNsOEnZn+eLHkcCykoV2GNe2HaY3CKDkKR15zJdv0eAthyAMS5RqJX2gsVBj7i9KwZKLvT+VRSF3oys5OJEM7idMtbvjRrPAWdP8+K2fLWwUR0TZafq/J42V3sd1MRs0vPOP44YFrNpfV2jNVbmmVON6Wm7kAKne6SigKvL7B98JKvAHqEhY2635D3hFlYKJgRhLwnI/C6CN7gwCKSfYtcbQzlXRktHyZnkY7zygfab/LWMROFpmy+524hkTKeqHBkkqaH8PKn/S/w9wF1mC18OjE9rFUht3Lz7GoNjnk6EAPIZywXYCU7mP/U5tkO2we1z+RlOdTT0CdRX4q9cYAqEC4/qYe/QYziZAqs4nvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(16526019)(6666004)(7696005)(83380400001)(2616005)(478600001)(1076003)(336012)(2906002)(426003)(26005)(5660300002)(41300700001)(70206006)(54906003)(6916009)(70586007)(36756003)(8936002)(316002)(4326008)(8676002)(47076005)(30864003)(81166007)(356005)(82740400003)(86362001)(36860700001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 08:51:50.7302 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ecf20e-dbaa-4010-34a3-08dbc6497b68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add hub->ctx_distance when read CONTEXT1_CNTL, align w/
write back operation.

v2: fix coding style errors reported by checkpatch.pl (Christian)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 3 ++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c     | 2 +-
 17 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index bcb6ba03cead..f9949fedfbb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -297,7 +297,7 @@ static void gfxhub_v11_5_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index cdc290a474a9..53a2ba5fcf4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -260,7 +260,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		block_size -= 9;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index ff60670b8464..55423ff1bb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -329,7 +329,8 @@ static void gfxhub_v1_2_xcc_setup_vmid_config(struct amdgpu_device *adev,
 	for_each_inst(j, xcc_mask) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
-			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL, i);
+			tmp = RREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regVM_CONTEXT1_CNTL,
+					i * hub->ctx_distance);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 					    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 8521c45e8f38..793faf62cb07 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -287,7 +287,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index f829c441640a..cd0e8a321e46 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -296,7 +296,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 89ff7910cb0f..abe30c8bd2ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -294,7 +294,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index be1da5927910..b3ef6e71811f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -299,7 +299,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index fb91b31056ca..843219a91736 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -242,7 +242,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		block_size -= 9;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 9086f2fdfaf4..92432cd2c0c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -274,7 +274,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 		block_size -= 9;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 784c4e077470..2c0419faf8d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -344,7 +344,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 		hub = &adev->vmhub[AMDGPU_MMHUB0(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(MMHUB, j, regVM_CONTEXT1_CNTL,
-						  i);
+						  i * hub->ctx_distance);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
 					    ENABLE_CONTEXT, 1);
 			tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 37458f906980..02fd45261399 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -367,7 +367,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 4ddd9448e2bc..5eb8122e2746 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -285,7 +285,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 9627df8b194b..7d5242df58a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -323,7 +323,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 77bff803b452..134c4ec10887 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -310,7 +310,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index d1fc9dce7151..f0f182f033b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -315,7 +315,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index 3d80a184ce6b..76b12f015d1d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -303,7 +303,7 @@ static void mmhub_v3_3_setup_vmid_config(struct amdgpu_device *adev)
 	uint32_t tmp;
 
 	for (i = 0; i <= 14; i++) {
-		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
+		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 5718e4d40e66..1b7da4aff2b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -308,7 +308,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
-				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
+				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i * hub->ctx_distance);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
-- 
2.37.3

