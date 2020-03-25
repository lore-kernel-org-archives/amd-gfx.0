Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E72C54FD3
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1B9206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 03:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mI1C9w2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1B9206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5296E57E;
	Wed, 25 Mar 2020 03:58:58 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D8426E0F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 03:58:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACKbps7RK71Zw/hGfafzDAJNSzPiZllcGXnVN59bQzIZ055L1na4MYmKWpQRa0zNjLIhlUkIL1uYd9QEVzpaZcMDWLp0tpX19NxYtTudnk/oOcBRYe5ZsBjDPxM3DUmjbC/XEZdO5e1aWTGk/dWH27WyQPqLF4ZPNUfgOSoS5ZAfIgs/VQmv3D0Nudu1+s8+++mi0deW3vaXozNt29VQxkfZPpYXEIbiJxhtohPnUdidZiW87LZYAluGEytSsKde/rsAI7X3h2YJpc3vA/r8GkPe84W2iVMtetwGHLsxNKD1Sb3AdlKB/TNGKT7VgYS7WblORSm0hpcZ9zH82bDHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jyYc2CRlxxnH/QpSbeX6ltyeiCMvybx2hf6yi47w7M=;
 b=RJ5EkOYOIbcnaWu9azF5ac6B5ZzUdbiYK3AjYGvFej03dQOlwEHbJBNAkx5PSpoauWl6Ca0iqSeNRoKB+KbQ/7kzkQi+wGsJoRd6AaXTKBHmarNF5czwLw97bTGNL6mOcUo3JQcMKIeZCKDu8Dy6/U/MTrlAM5cQvlBsmtgnKHGhbrg0xR3FVwFbNbTDKjprUhWE1xY7r32EfyUHwHMd3MgsUOc/ZDWpmVf3auyL4qIGWfsiTbWxsk+ViOrDV1UkuoVsupUXITaH6A8WQCoBWnWpRuEXz0NooOUS4FdSl48DnuSQmwy73ktOj5ve7nafH63lB/qajNvGFp3Y7u7Waw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2jyYc2CRlxxnH/QpSbeX6ltyeiCMvybx2hf6yi47w7M=;
 b=mI1C9w2uSBild9DypjPPyW1LjPuDfGSBd1D05OXnhg3jSMUHvjKR6nHVI+Sn1kP71VQY5iDuP4+UQoUGCeBPtGUCBKYkFHbGJW2r7HG7ne6DlfSCawM2tkAWuovkD+6hHeY8MhGKA6SpbGNE0uV0/PgpdJ0r0zkHVA9yOZWjqL8=
Received: from BL0PR0102CA0026.prod.exchangelabs.com (2603:10b6:207:18::39) by
 MWHPR12MB1214.namprd12.prod.outlook.com (2603:10b6:300:e::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.15; Wed, 25 Mar 2020 03:58:52 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::8a) by BL0PR0102CA0026.outlook.office365.com
 (2603:10b6:207:18::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend
 Transport; Wed, 25 Mar 2020 03:58:52 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2814.13 via Frontend Transport; Wed, 25 Mar 2020 03:58:52 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:52 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 24 Mar
 2020 22:58:51 -0500
Received: from monk-build.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Tue, 24 Mar 2020 22:58:50 -0500
From: Monk Liu <Monk.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/7] drm/amdgpu: equip new req_init_data handshake
Date: Wed, 25 Mar 2020 11:58:40 +0800
Message-ID: <1585108722-19098-5-git-send-email-Monk.Liu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
References: <1585108722-19098-1-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(428003)(46966005)(86362001)(8676002)(6666004)(2906002)(81156014)(81166006)(8936002)(47076004)(336012)(82740400003)(478600001)(26005)(426003)(6916009)(36756003)(4326008)(356004)(5660300002)(7696005)(316002)(186003)(70206006)(70586007)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1214; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fd26712-02c1-4b0d-b452-08d7d070d4f3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1214:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1214099F2BC587F54D03BF0E84CE0@MWHPR12MB1214.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0353563E2B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfnFu4ow526clIJDaKl2dc5jzWvMWWff6B5DXXk0l4YDw7ybTDpXk4mxNAH8ZZ21uHuKzklkDiOFgAxJ8pIFmToZrbDnENPt81+kdHxoVPDmrEHhrNnQDGYOedt3XzgMpz70o9EAZpbctWaOEXtvv20j/8L3QolIheZ7CCpH5GTnwLClyFkg6KmYuFT2eIcyi5qB3hQDq/DkjSTYmkkw3CNwsBFnWK0S/W3snvGFy35V8Rf7jyqhZb2TMk8zaLzO8ZFtOI7FvGBqxMg8BHFmYswKsvtemboA4gsdl5uUuXh/JR2d7H8buOlCa6dr+CXKeTWl35gQaKFWsMqUmnB/DkVixwmtujqHbIzslbCz3GD16tT54uYmYYYZVx6GUAA9lHqY3FGwnoLAxJjL4UMflKsk/2OuJXA5UBRcsgApVxSLHszMU5yttsTHAaao9qZQO9UcWawlCdkEcOE6sgRs0sxH4ZAfdC7xpEGxD9Erj/Clh7020tr2/jmFe02x6w0pWveh8xRMgUsjRYvfDuSPdw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2020 03:58:52.3430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd26712-02c1-4b0d-b452-08d7d070d4f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1214
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
Cc: Monk Liu <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

by this new handshake host side can prepare vbios/ip-discovery
and pf&vf exchange data upon recieving this request without
stopping world switch.

this way the world switch is less impacted by VF's exclusive mode
request

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            | 15 +++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ca609b6..273706b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1800,6 +1800,21 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_amdkfd_device_probe(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
+		/* handle vbios stuff prior full access mode for new handshake */
+		if (adev->virt.req_init_data_ver == 1) {
+			if (!amdgpu_get_bios(adev)) {
+				DRM_ERROR("failed to get vbios\n");
+				return -EINVAL;
+			}
+
+			r = amdgpu_atombios_init(adev);
+			if (r) {
+				dev_err(adev->dev, "amdgpu_atombios_init failed\n");
+				amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
+				return r;
+			}
+		}
+
 		r = amdgpu_virt_request_full_gpu(adev, true);
 		if (r)
 			return -EAGAIN;
@@ -1832,6 +1847,10 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		}
 		/* get the vbios after the asic_funcs are set up */
 		if (adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_COMMON) {
+			/* skip vbios handling for new handshake */
+			if (amdgpu_sriov_vf(adev) && adev->virt.req_init_data_ver == 1)
+				continue;
+
 			/* Read BIOS */
 			if (!amdgpu_get_bios(adev))
 				return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index a67d78d..7768880 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -457,16 +457,19 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
 
-	/* Set IP register base before any HW register access */
-	r = nv_reg_base_init(adev);
-	if (r)
-		return r;
-
 	adev->nbio.funcs = &nbio_v2_3_funcs;
 	adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
 
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev)) {
 		adev->virt.ops = &xgpu_nv_virt_ops;
+		/* try send GPU_INIT_DATA request to host */
+		amdgpu_virt_request_init_data(adev);
+	}
+
+	/* Set IP register base before any HW register access */
+	r = nv_reg_base_init(adev);
+	if (r)
+		return r;
 
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
