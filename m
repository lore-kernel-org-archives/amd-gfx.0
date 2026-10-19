Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAAB606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 19:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1Gp8rAwc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B5310E1B5;
	Mon, 19 Oct 2026 19:06:11 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC0210E1B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 19:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkWl6fzN9ELqmZ9VxGQWhM6Wkne0IOe01anPNft2qMUlEjgcC3M00c3kllo9sytGT7Y0CuBCBS0E+vSLJQtJ6t79/q0mEW5JZ2xpPu0W7HmRyUyhMF0r5Gp/cOVnRErIThF3TK56S2HT2N+AcOGf/GUMj9OV8Hh9pfJQsiknt8ElvbJsKsG7kv1vU7SiDjnkRQUqQfhZ7f0qjAsonsnYkuO0ssm6AO7Awhqfyzs4kck5vnXbKBXveaqSRUttqGXIZwl2nX2YfyAn/eztZorIJOHsjezfdAeVAzjOTBl0P3SJXOHZdPdwqxQFRrGymPpwjpN86tIGspaAp71Nv710Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N9TL0zq4trsjFvTpnqCsuNIC2Ce27IIimF8qQwU+i0=;
 b=VHeqy71mh1/KrMj6OMNEFovv89GawOVHVPJx8CVyL5JPar4vejcssowfZw65mtCaSPEV/MeQ1COJ/0yUsA+0Du+cGwC/SdKohJKxYWHnRPdOx2Zkm8ZoSl8PfroqJhPU5tNVjW9R39Su1QmCjWYr6AFwW6atQPpxIukkSLGs9H6D1o1S30RpUNPmLvGahLRspi8WnOq7qdd/jrYmfDj8kLw0DnZwAHBbamyarw54vi2XMQrq2cZbtp44U3Em/155YXAqdkZoGaSlxLlbK7E8tyUsCNOB1yp34yBOhQe0O7gBC/fcywxg8mvTW65cWqHH2TbB5yby5boE0dZcaAow/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N9TL0zq4trsjFvTpnqCsuNIC2Ce27IIimF8qQwU+i0=;
 b=1Gp8rAwcJDfJSNUA+ga2JrL7ZbrOm9UN6Xv/m4fOpNLmuqjQZpjVkhQgBbR4E0wJrkwaqXtglpPJiOTLzhKNnxJy8h9qXTKIfnHCDCDIOSXrhJlxW48PAnkIBx8rcUvI/Rac2ngGgl6JE2E5GGG45W/S2T86XfbCcNOQkXp+KNQ=
Received: from SJ0PR05CA0002.namprd05.prod.outlook.com (2603:10b6:a03:33b::7)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 19:05:54 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::61) by SJ0PR05CA0002.outlook.office365.com
 (2603:10b6:a03:33b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.14 via Frontend Transport; Mon,
 19 Oct 2026 19:05:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 19:05:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:05:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 14:05:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 14:05:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma: explicitly set SWITCH_INSIDE_IB
Date: Mon, 19 Oct 2026 15:05:40 -0400
Message-ID: <20261019190540.2773908-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 248b6451-e645-4677-aa21-08df2e13fe35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|82310400026|1800799024|261009223027099003|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: WtpyiwJNXS9fRrZ9b8UBbx4cgJvZ96P1QZZKp216uCjJmutkA7BlhxyiIMazGiq2DB+xeecgHzUQveWgcrKvgSlGSyocZ9Hb8kj43o59taj2LICovVJp5FNFnq4/1Ly4gjEBHOAYW2RRzOjyZ4tphH47GjZ56pt/pS+tBlPubFmppek/ynkYF03b4P6n4dnPTokpd++9gSemFkMMWpboPCDufqZzILV8kpJ8sl4aEyMgGrHw7FhNX02zf9Ob52k4daPL3wmHF0lEk9561QD/qxwUImtv9JxGTOFm8zSj7fgBVEcM1A96WBvky+ZVqhb2nxbBAtd4N+3WrIzDOPrdAPJgkFnO/5gNDN1NUd0d2Nl2v1bi1w3dbQvWTb+Rc26tlO98820offk0GFuTVBbBEZhdMGDvXChXvtreLCqeonDLKxZCwgELPygd7YOAIIuFLI3r1z6GdRSBvFgse4QHjQI8upZ2aDtO2MZOPy087mcrXRPa042WyrVXvkYXTjBk530t5uH1khyodWMawemvU7ubwHlBk0ypbtgdMLpVTzh/D1toD4vrI6uSCsefEygH5UGS8QT4y2fKm0Yg8PPuDZt3y8ltvwTEHCHJLugcBx5UYQzTRM44gBXUndfd1ZCYuJpWiQ28VkA60+7eNSsFm7EjGMcaL2ar07t6mVkaapVP8YWdkpsmUrJA3JEzMdPEVzkV2ZpNo0wNLqnQCgH2Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: itnjosm+x3FhzvIGjsxtDsOIFARHwbvPnQWEIOVFWKjuOzpzVxMHWodVTTDSWfa2JU2GU6fYZcfWFctqyUUIQo/YX9pOrVg/im8xm5aVvy4RCgHXylJff+cW6IAEl5CA+PCQfDsQruID54GFK8auFikB8XFNcNNcE8Iy2zCSRyihtN3QF4muqId1avAfA/y84GDvYa6pFBcl+yBcEt/WxdZdHb8Ibmwo6wwiqvxubM0Up3q3UaHKenLfZK2Gw9KvfHDU+L+je9dM8/xn48HnA1uKAPiSRDrX46daNBkOunCtf+VexgnafOXdievXYE34rXZJOn6O3JDLjW9ZQIUkDxDlOI2ZUQxk6xSgprSYK6dyysgLAr7xirIm77TnfdK85qohemPf3tzhwSeI87bUeJPwisJvm5KYYE3X+/zyvOAHjZttyy9YZtqZDik+4SVx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 19:05:51.2746 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248b6451-e645-4677-aa21-08df2e13fe35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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

It's the hardware default, but set it explicitly in case
something changes them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 1 +
 7 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ace34357c7705..17f01c3ffa304 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1142,6 +1142,7 @@ static void sdma_v4_0_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 
 	ib_cntl = RREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL);
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
@@ -1228,6 +1229,7 @@ static void sdma_v4_0_page_resume(struct amdgpu_device *adev, unsigned int i)
 
 	ib_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL);
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index b99fbad2ea013..bc9ca86f012c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -738,6 +738,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
 
 	ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 7b0ce48b446f3..1a1427d2dd20e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -807,6 +807,7 @@ static int sdma_v5_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_0_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 281a503bea848..b3692d22fb6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -654,6 +654,7 @@ static int sdma_v5_2_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 01521207ae9c3..7c8ddc4ff3ce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -601,6 +601,7 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	ib_cntl = RREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 2ea5a056187c9..62d432b23cbc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -594,6 +594,7 @@ static int sdma_v7_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_IB_CNTL));
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index bc7de4c3861f3..73c60d928fa85 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -590,6 +590,7 @@ static int sdma_v7_1_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, i, regSDMA0_SDMA_QUEUE0_IB_CNTL));
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, SWITCH_INSIDE_IB, 1);
 #ifdef __BIG_ENDIAN
 	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_SDMA_QUEUE0_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-- 
2.56.0

