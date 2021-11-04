Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB3BC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 03:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F3A60F9D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 03:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38F3A60F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA727B5C2;
	Thu,  4 Nov 2021 03:26:38 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AEFE7B5C2
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 03:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7xrO8miI7JIrINqiyGDZ21j7e0NU8pgUcrgE11p18jIhE2ZEUoSfDlLx9YQVO12+QhCvIIQZYJxQKQLy/QrU45zSvi+mALUts6fgynAVHzN0cHRRct00VyD3JcHKrHOjxohkGt/3gyStP3gu4uI7SKOibj5k6tAdXi8vIPy7WKeG/oK+BfvxzJPlSPZppQrHaUhv5Fp4MAje92F/1y8QJUi7Tp+9gzRsrMVAZbLqfeEz5F3DMpJEWxyQ7Z1ftjmP+/SFGRcv2rBznEpt/NVK1JEd9ToS+t+uyK9japK6fDof/dyvJjTW00bv2zbgnDO3ufSO21tr9UizKfsDV3gIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vnIJqihSXFZTBoNEzyOoda56er1pXVVDk6RRe8Z1Hg=;
 b=SgrACjbgdhibqruehdck0WQofATgwfi4+LXF4l1IHXcsGLk1nX80Qfsb8+B8LiArartxFGWorUxA+9TomJ/wp3tgn8l31hw6sexZ4v3SETR+NdjoleJT8mkwS+CdqO2s2SnBiAro2ES7CUQmZMyi88eAryuD8k7mUc5K6SSHaWkX6Sq7zYnW3KvmvvnO2q0k1JH2n2mctrGctqF0QPBPBnSVgYaXmqq9Fx4WIUVw8VL6dQi3w1Vi8xsdtAnS2uG2P3tYcB//VeuM9s/nbjK5qJYaAuXz4omM6ZHb97HV0fx3Jdljzp9nXknytX+WJ8pPpRYPuaXBX+odOjxVLOUXzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vnIJqihSXFZTBoNEzyOoda56er1pXVVDk6RRe8Z1Hg=;
 b=g0jDrTHZGdi3F710ojbk5Ukt4x5qzGYN2cjSZqNN8OtMHOUgO0fnBUa6GOlGZy1Rk5KIbetRzkQdy1TRODAaSkUMhdz91m3Ng7U/n0Gi6xj1qRejyBirc/tBvESva5qWNa0KPnJ5DkRxHXoT7lnrhod7SDyzFDMg58DaTXcy0w0=
Received: from MWHPR02CA0003.namprd02.prod.outlook.com (2603:10b6:300:4b::13)
 by MWHPR12MB1199.namprd12.prod.outlook.com (2603:10b6:300:10::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 03:26:33 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:4b:cafe::a) by MWHPR02CA0003.outlook.office365.com
 (2603:10b6:300:4b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 03:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 03:26:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 22:26:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: fix SI handling in
 amdgpu_device_asic_has_dc_support()
Date: Wed, 3 Nov 2021 23:26:16 -0400
Message-ID: <20211104032616.233937-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef0e6587-601e-4d0b-85d8-08d99f42e63d
X-MS-TrafficTypeDiagnostic: MWHPR12MB1199:
X-Microsoft-Antispam-PRVS: <MWHPR12MB119951E5A5156E02BB62193CF78D9@MWHPR12MB1199.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NkXSsSPlZltk3NRhxn1m0p9mgHKwhR0v53dI2pFDOooHbTA9utknKvN9VjylGT79VmKQt2dZk2PaJg5GVnI6TXHqcigqklOEUq1vvqgPZpdyzCBf7dceLs7YaOH+d43vyDRcYMjXlnnjLy5ML1cFvAb7ELOFrcRagislBQyGvZzUirxN0ONzgi5ZZd+hxakBmsdEoK9K5JElt/ZkarGPf9rCRSpbkCIhYS/cMgigvj6bYMirmb3mntgORLR/2SoAFmhP6D2s/+E1wWvdg5+oVBjSNwghPW6osE0qWnBRMGvsT+JqK9pJdvKbZZHNj08xLYlHry/sFIl9hnsezIt6O4l/V7Z0AJpUS0+p2jb21neYoIR2Z0d4EIWaanJL54SHHZzGbcxpMDve8ElhlLvQ7128jtWETCDSP5PZdsIr3dmrg8v2EyTLCMckAnTVzOORKHTaJdvGRsuEkv6E9N93BCGnZSIjPqsz30Iwc7JJ1qCsNZcdUd7HRwfqLZCjlOe1gOhIw0VReCR23nSDU0jBACNlTPzDuAoL4HbCv7yOxf705mbqBEpdk88dw2KZHglEb9TE+8X0OLG33fagWkv/2cShqTMoGHkjAgGI/SG7Qb4ZZ9KW/S3lGuN3qvWnqQj1ooDG0JRFPa7FjdVpy5Jwg3qo9Msxqu9aMxGFfN54gB7Sa+Pyb1UbfOpwV0YTg+cURV3zYACYg0qtRDHv8m9+WvOYs7R+0lwz3xve6LDNBe8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(426003)(36756003)(5660300002)(16526019)(508600001)(316002)(6916009)(336012)(82310400003)(8676002)(70206006)(70586007)(86362001)(26005)(36860700001)(356005)(7696005)(81166007)(4326008)(1076003)(2616005)(2906002)(8936002)(47076005)(6666004)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 03:26:32.7396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0e6587-601e-4d0b-85d8-08d99f42e63d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1199
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Properly handle SI DC support when CONFIG_DRM_AMD_DC_SI is not
set.

Fixes: f7f12b25823c0d ("drm/amdgpu: default to true in amdgpu_device_asic_has_dc_support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 95fec36e385e..db3728a11481 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3166,11 +3166,21 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 {
 	switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
-#if defined(CONFIG_DRM_AMD_DC_SI)
 	case CHIP_TAHITI:
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
 	case CHIP_OLAND:
+		/*
+		 * We have systems in the wild with these ASICs that require
+		 * LVDS and VGA support which is not supported with DC.
+		 *
+		 * Fallback to the non-DC driver here by default so as not to
+		 * cause regressions.
+		 */
+#if defined(CONFIG_DRM_AMD_DC_SI)
+		return amdgpu_dc > 0;
+#else
+		return false;
 #endif
 	case CHIP_BONAIRE:
 	case CHIP_KAVERI:
-- 
2.31.1

