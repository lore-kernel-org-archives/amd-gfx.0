Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF2DC35FFC
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 04:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB1110E314;
	Tue, 25 Mar 2025 04:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IOB+aGbw";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F73E10E314
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 04:06:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ki3NDOGwGMWuuwNHb8948vuEPz0PONjhqE2DZzj9j/ox3u6C2TzoXctEuPPnhehrQSC5Tde8nMSGDhAOnqYtxj5GzoN7gQjYNB+ypwxU8IVFf339vW2b5u4u37oW2RrI+nM2KcSP9xuz0HwsR/V8SxDlrmDO26oELklyGscGrOCyeoT8o9D90xrBm+VKoQB9PFtn9I46nRQo8srYK2TYCnH5JdFwguZqu85lm3lzso9XPSzY8fBcG3WTCqHEc4cc2Y862b96p16wcfIYmplqcvgTJLbBSzSgvVG7aZAAteBazcYJvN1riY35h2dwZs2PZ3ilOkwq6YOoCt8G16aCnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWx4ZM66UFl9ioi2ifBPrkhv2kCR7J0lPUt4z6gpuNk=;
 b=Qa3A4Mtnvuhrt2J6iqkMMM2d+ycFBVKwg3CIKee8xXjjhWzFwjZ2+hV6bRBfmMlDu+rZ/O2xdlm7bhsG8dp5HX+H23cRsOnv/9Bfydv5loqZ6yQQ2eW7Hw/lZUrExZfzXWuuv5bFGvds0uuavYnsqG5p+AgcOp/ckiLtahCw/otqCRtnkQGjzS10FhIwNnN6xwLmlSqxzf3jNt4rHXuWLELP1bofxBaHTYi11R8Ednp13kBUW0FRXp0zcbSRv231kGtL43mAv0q+k8QxWHUQMvpRsFXW7l02ehLc2i+Us3NfgUgSXV+9T8K/uNo8HYLdNvW8751W7HeeoWeauo7EfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWx4ZM66UFl9ioi2ifBPrkhv2kCR7J0lPUt4z6gpuNk=;
 b=IOB+aGbwtD38FXXcyx0r3NHJ8aePXLanVZoc+6fgjIhUBaNd8UeNiqkVUN1PgzQl+fLFiii9N5jCiyg47PujqHhr1pQk/Gll1+4IYGeRDOGa5+22HkKaIInWUncG7+qrLv0SVqyuJwoCQE1Z/Gvwi8oi2zwabB2wTVE7qPwUgk0=
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by MW4PR12MB6851.namprd12.prod.outlook.com (2603:10b6:303:20b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:06:31 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::1a) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 04:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 04:06:30 +0000
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 23:05:57 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Stanley.Yang <Stanley.Yang@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Update ta ras block
Date: Tue, 25 Mar 2025 12:05:31 +0800
Message-ID: <20250325040531.2592549-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|MW4PR12MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 88c99e9a-948d-4bfa-c7d2-08dd6b526c27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PE31ixHVrZfLgE4u3vMsd3QVaNgc0RNvsJLgzjmoDpedg2TBEWYG5nHn6A1v?=
 =?us-ascii?Q?+YIrg6eI/2Ok6864A/ihSGjCbdyBWkpGcHs/5WUp/D10ImCElJgpwVPc14Ih?=
 =?us-ascii?Q?riv8IDz8W1oDXFZjaMgKHUsleQjB1ZkKcy4Kb5Y6ywHeCucTHyK5Mh8y/zI2?=
 =?us-ascii?Q?KRmaODXxdRJ/gTY4+0cAjcwrFjtISDoGtTHggDHjEbJZ4oaBzlVW1OOMsTbA?=
 =?us-ascii?Q?TXyCqcweOwyLrhrdx9mkMmfafNXpdQuUxVHbqsIxKDBTuTW0l+BFciF7z24U?=
 =?us-ascii?Q?t54f55rZXsI7Q08rNQPmT1NBDebNHmi+biJEG/LDr33T/MMtdRCQsHZsfVVG?=
 =?us-ascii?Q?4lB4wmg9BtLfymJbjw+Lle2mUVoR6J16FCre2/R7bvM0B0VRRwe/GFCW2yT3?=
 =?us-ascii?Q?6o2tVqbcKpeYmlAQMkfKioRoXe55gF3IREG27i525JPeFsKXjlrVAzvYBIRj?=
 =?us-ascii?Q?PcddI1oBUydbdCIyf134v+brjL0RkM2Dw6Y8/vQXfN7V50WaBiO701wDy38r?=
 =?us-ascii?Q?Wa+VceaJJCaufDRhTrfDcqLMNAqeEPYjEM5I5GCCFvMVm8msHRmWEZEdRWHB?=
 =?us-ascii?Q?O6WPXedZtJV5IiBjK+mgGNT/xITTCVsBcXMyt1hm4MYh40JyMJOX0fsFw2Vn?=
 =?us-ascii?Q?MqZCbF0zOXetgnSuNLJEyCsnsX1JrJj/XIAGK8ayEX3IZD2JPNrnm7r66Abk?=
 =?us-ascii?Q?oxYOKbDqXZ47tzrwu75MgPE7Z59Ov0zCvYHfHiR/R7omH5YxfU0FXSkhizaa?=
 =?us-ascii?Q?SnPiXXuIcC9oWmjcBPmIpTNclUcMHANFzRAyfXH8SVXAdgnHYGrNz1+u+ltG?=
 =?us-ascii?Q?JNaA/S5Qf0i1PwOhPg+j21kC046kTOYx5DFdX68d+Vca5BlKf98gQts6KuCj?=
 =?us-ascii?Q?xzKziK87NpPXHWNurd1VhhLTIY4RTkIfHbuVJN8AJGEEtUuqUfG7V+12Gln3?=
 =?us-ascii?Q?gQ1lCjyGlsBT77P6OFfM1i+TJ1fLLrFyeJSpZZXiFw70TsNlAbA9CrdV+vUT?=
 =?us-ascii?Q?cfEUDF6+udzG0/I8bL+m0dCj3wztvGA2bPDqfTtHLhPY+AhHcbEQLRaQMHZE?=
 =?us-ascii?Q?EJZ93A+IfA7ATQC2NwrkmDmzN/ooSrC7dxOV87DcnOHpgM4UrO8FXva12FeH?=
 =?us-ascii?Q?G9ZnoK4q11Bqhm98Kqg186WXol1kSKosIlrydr7FR9Df0m0fDiiLvXP2nj+x?=
 =?us-ascii?Q?tDk/7C2fRtSu9BkZJyFO8qQG58CUA011ITa79ykUyMfwP81HpGiaRbi765kU?=
 =?us-ascii?Q?5nCB8WhePtK9USomKGcXVCfh+ZxB96Y+AVAETbpf9Soat9E0nyoLZDKCXDVz?=
 =?us-ascii?Q?h9WbU8rFBAexQtUmLZN3aLIDNu3oLNjT0SzXvhNfYMZI1hcXujl6egzNtqqP?=
 =?us-ascii?Q?bpf9DLfug/J401u7fb3FsXoZS71iAwh8FgabuxWslv+rzZAyzRnqhnM+akTX?=
 =?us-ascii?Q?KEgW0Oa1MDrqmqCHAkhqwsWNpQRQQHHfs2e/don/vzJwSmYe/+Se+Ec1CSTb?=
 =?us-ascii?Q?odIRLZMSJgeStqc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 04:06:30.2201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c99e9a-948d-4bfa-c7d2-08dd6b526c27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6851
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

Update ta ra block to keep sync with RAS TA.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/ta_ras_if.h  | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 5b4ffcd37ba8..e85143acf3a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -77,6 +77,7 @@ const char *ras_block_string[] = {
 	"jpeg",
 	"ih",
 	"mpio",
+	"mmsch",
 };
 
 const char *ras_mca_block_string[] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 764e9fa0a914..927d6bff734a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -98,6 +98,7 @@ enum amdgpu_ras_block {
 	AMDGPU_RAS_BLOCK__JPEG,
 	AMDGPU_RAS_BLOCK__IH,
 	AMDGPU_RAS_BLOCK__MPIO,
+	AMDGPU_RAS_BLOCK__MMSCH,
 
 	AMDGPU_RAS_BLOCK__LAST,
 	AMDGPU_RAS_BLOCK__ANY = -1
@@ -795,6 +796,12 @@ amdgpu_ras_block_to_ta(enum amdgpu_ras_block block) {
 		return TA_RAS_BLOCK__VCN;
 	case AMDGPU_RAS_BLOCK__JPEG:
 		return TA_RAS_BLOCK__JPEG;
+	case AMDGPU_RAS_BLOCK__IH:
+		return TA_RAS_BLOCK__IH;
+	case AMDGPU_RAS_BLOCK__MPIO:
+		return TA_RAS_BLOCK__MPIO;
+	case AMDGPU_RAS_BLOCK__MMSCH:
+		return TA_RAS_BLOCK__MMSCH;
 	default:
 		WARN_ONCE(1, "RAS ERROR: unexpected block id %d\n", block);
 		return TA_RAS_BLOCK__UMC;
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
index a3b5fda22432..8a3f326474e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_ras_if.h
@@ -92,6 +92,9 @@ enum ta_ras_block {
 	TA_RAS_BLOCK__MCA,
 	TA_RAS_BLOCK__VCN,
 	TA_RAS_BLOCK__JPEG,
+	TA_RAS_BLOCK__IH,
+	TA_RAS_BLOCK__MPIO,
+	TA_RAS_BLOCK__MMSCH,
 	TA_NUM_BLOCK_MAX
 };
 
-- 
2.25.1

