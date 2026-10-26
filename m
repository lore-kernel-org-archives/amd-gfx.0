Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D0606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 03:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=gSJ4CBQg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B621F10E918;
	Mon, 26 Oct 2026 03:21:38 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A629E10E92E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 03:21:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWPnCpb1KCV4/Ex+0+kVS3X1OmNgL1ls2HAcYSLIkMJKE27DnMIXxFnMs9UXXGOEXlSTF1eBTFsof9a3znTlLAPfQs4wg20TEaNSmylqJoBcNE0Jw0vzVxm/K+FxFDI2K05h+IKVuzhH/FPyc1LP4SSmQS6hx5iN7VZ+vwS0g9rfnYT4Iye1QJR9lUAAY7VTLHQRqRvgT8aqtH/Gcf4jUzqHrPfSdTjgcegIxv63xTtY3S+Je2fzAX4P2Bx954rqSvFE47n6kKX3v2mZlQ5QBf6xI+IuFSXgTQ9hJ+NKBZunbRJKc135pY0XwH5qT92K97gKTBfLqt9P9FTc5W+MpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPEeP+Chj/jKl3cLbrAHblIhzeQfMk0DU8MrhKue9mE=;
 b=YTAKDDW1bkQ+0xrcB0EEIGz47gb6lg5mjl/GJyL0UatW3w3wcGM/sG0QRfxSIZZ5uWGNOZsZHt8ahhOrdVn7bShTYDtY96R4sJmzg/k4vOGLyv2nH964OJrJ0XC8eKolUb7qsAZXSGeeleVPxvDBFl9HBaNMWxsqfd3RoxXqKNIWSDYAkArT8xGHD0RmH0eSz3LeVRXDuLcf0wzZ2B4RjJu4bRVRfhh9wbCkTAKQkg+6/CA3++Ut+k6nIV6P0M8uFoK8mhLwIhztSkTZp8yjsKuCPhM3ctPYpypil+X2C5yKyEF3ObUZS7hl5in165j211MHyh9ui/FYpO6hkxzGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPEeP+Chj/jKl3cLbrAHblIhzeQfMk0DU8MrhKue9mE=;
 b=gSJ4CBQgAqPRZW0jLmZbt33cq5B+di/UzSW/MbNdEWVMm2suCOjo0FxTsxKV/hxw3+aKbZ80rfF1jD9rAuxKYnW+5eVfTfq1zFnobt0al8eJtYFd65fQw/CHDXcr+2lTauo65SoxP54a5tRK1vRYe4jWNKD2RyC6eU9PtqHg8fI=
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.22; Mon, 26 Oct 2026 03:21:28 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::1e) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 03:21:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 03:21:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 25 Oct
 2026 22:21:27 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 25 Oct 2026 22:21:20 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <igocaike@amd.com>, "Jesse
 Zhang" <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v2 6/7] drm/amdgpu/gfx11: flush the scratch register write in
 the ring test
Date: Mon, 26 Oct 2026 11:20:22 +0800
Message-ID: <20261026032042.2266892-6-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
References: <20261026032042.2266892-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: 9541da73-e054-4c98-c616-08df33103900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261009223027099003|261022105027099003|261021121427099003|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: F+yGURD39tuwZMugu1VuPNrByp/irdYjCa2DtIKj5RpiddYMpMpuk3mK91MBhe84H2BUG1VCXKrqdg4oILtJO5VVeArHVx9zFHzkkflX8+tUr2vI1YLk7R8AS58XzRaOISQpxQDaFRQMr9K55vv9074b77JQfKe1nyo/JjH3tzkISvCuNgtYYAYkqqDEiSoOcU+lcNMxbOMIb3r23n4WxUKJUeXsP8mZyEaoLEher1tGwrhfGxFzmMcCQWDYqHuLnTYOBNRqOjoV/WBquBTQUK0GM5zvNnAG9BMBp/v3aDBmy6w/nkBd5RZXKtprJi0jF4K62Zs0Y7Ne71WpnedosO+tdsnqnJLxEJuoqEvH4EQEZGLXUfmxIQnAz+EwCV+ltZHltetC5ircOMcuQlpPBaaXHQHdXFjd5nXyQSvcnAWJPDK2B3/+DnFm9ElxPctuaDRVluBNd4QDgbRHw/FB9vrfDVDBQ2kKFMK8vn3vzrer9FDptH7w+tq5xByLORSZ8uOia96wyhoCWuHxl2yoLU6NgqktBj2fAcICQVZdltN9CH4y/P17mc4Ym/Jz2Coe8siHl/iRRg64lC9Z1Xkk4JiT+dUjhr/DZFuH6INCKE3IRrhyq8fG5jVINwhj55y09xpuD6bWLj7A0qJwkscsO2G6DdLa0tEylMfqewtl01gzIVkNSNFdINNhkg1IqIyxcqqajfq+3+tVDa4vcwdx2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261009223027099003)(261022105027099003)(261021121427099003)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9kWIC5QDvIzPuPbXKC9YE2CVAp80MiNpKGtvhix1keSU1cmTFuAi5YzyXBJoB8hxeTrM9UnHW32oy/RutDuI2xISJenHOVTxxntuNuZ1LwFcqS5DAclwJTfx9/M3G/2xQ534YyTtQrBMMQyDeAM76SAERlSO3GJ36Cor5tnGt7VFVSPCOciVzq0DjMPXmxBbxCiZaAJw5ErhhdeaOTqTGc+L2y1IEaMT3Z8Irsldfnx8wK3E4bu44nAE4C1pBZpEC6aBunva93gX58rXdQGYElMlVCAo/q5fDxYZbu5SM3c8lYMhGp+QTF3rPFBrN8GEwriEgG9m2nf6jX9edfNgNq9aTHLO5saa1qUVwO7cv6x/txwHaTt2RYPSEqASEktOyqf4zMfGvL4WSKWkLvq4BvY4T2UyvpOcadhm3wxZa06tAMW9anQQKiC5jpNhywM9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 03:21:27.8309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9541da73-e054-4c98-c616-08df33103900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ring test writes 0xCAFEDEAD to SCRATCH_REG0 through MMIO, then has
the CP write 0xDEADBEEF to it and polls for the new value.

Nothing orders the posted MMIO write against the CP's write, so it can
land after it. The test then reads 0xCAFEDEAD forever and fails,
although the CP executed the packet. A false ring test failure in a
queue or pipe reset escalates the recovery to a full GPU reset.

Read the scratch register back before submitting the packet.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 315dfd806d56..b7f9fa3cbd2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -587,6 +587,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 	int r;
 
 	WREG32(scratch, 0xCAFEDEAD);
+	/* Flush the posted write before the CP writes the test value. */
+	RREG32(scratch);
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
 		drm_err(adev_to_drm(adev), "cp failed to lock ring %d (%d).\n",
-- 
2.50.1

