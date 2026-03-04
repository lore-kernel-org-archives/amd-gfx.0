Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088E2EFCE4D
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 22:27:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B262910EACA;
	Wed,  4 Mar 2026 22:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vw5FEtm8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 378B010EAC5
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 22:27:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+UNYEiy7kUArcLlSEw/YpsAukUTn6T2/AI2Zsy7QVMYg3me+ENd1QF7tAlqhYfscB0cwHSWbQLOwva9zBTtv1537cFrc/RircDOWArtd1S1Soyi8R0p8ILKx/9uU/EnDRhqRtO8hyiEl0MJ1aRg2RWWs/zCCP+df7xv05tukr+6Xpba85UQkGOUgwSbPfdXV3ivkUjS8XC0gDHEFu28oaRem3hOJUwpFd5aO/o84icDpmVFdy2hUmKJkVfNotiISDuOLrmMellO0yHDhqAmGGydL0btrn3II5DoMriYac+59Nmsetv2gXMRq+kyyMbQKncwAPy7pmJL396FWnfS0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onNlhT/Ga/2vaG/0m4v5NyqdQ+7lIAnlsKfcy9Owm7Y=;
 b=ZMwxsjgXRA06uxIDoc4FkfR5+srCsw6M850YVazcmkyf6HGvQPgp+i7lNjXS2Y5b5UvMqJvqDZ7GUZAopM6Hga35HYnHtgDJjSCvZHpSN5NeWyXUQbp3p4whxkU8/YuiEe+IUJ4FuiJMK2HTCSj2FLWunwiKI0GHITLmVSjWbtALQuq3zPMxguceH728w4To10poVygWJazMMiXZrIxNrHZf9rxv7M6em5O1MCuzhHczwWVfzz6UimY+dbr8sBL0ZQf6PAM4RY9gTYqOAeWfPmzwWx8mZ9oDGQZsIdN0B8UoZxTSeMlJ8KHdV1bpTMFPIe95ixEVLE5NgUjVW/mgjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onNlhT/Ga/2vaG/0m4v5NyqdQ+7lIAnlsKfcy9Owm7Y=;
 b=Vw5FEtm8pv0Hz1RxUDHAtNyPmmfUqX0cJQ4+X/eaXbfUqFyq2MGZ9cXDVpmd8llQ8xml4W+WCe/2xRPHqAz1Ggxqg+pP2jRyobfq/C5KoAmr5dcFm7/g64+dGB8IN+mQLZiCqRqjgkhipUv8Md2yUnMeXFfUsIpy06jrLpyxE6Y=
Received: from CH0PR03CA0115.namprd03.prod.outlook.com (2603:10b6:610:cd::30)
 by MN2PR12MB4237.namprd12.prod.outlook.com (2603:10b6:208:1d6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 22:27:44 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::13) by CH0PR03CA0115.outlook.office365.com
 (2603:10b6:610:cd::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 22:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 4 Mar 2026 22:27:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:43 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Mar
 2026 16:27:43 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Mar 2026 16:27:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu/mmhub2.0: add bounds checking for cid
Date: Wed, 4 Mar 2026 17:27:26 -0500
Message-ID: <20260304222732.2403409-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|MN2PR12MB4237:EE_
X-MS-Office365-Filtering-Correlation-Id: dacf0bdd-def8-4a9f-ab58-08de7a3d412b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: u4sQzYnwZ6P70ZTbqrwolEjKqjAyvrXux7Dee5H+JnXsEYI/V9mWqHxTlVH9RGWxC5emEfpFDaf99kwxqll7Gy6FwVUuceoyFVlSOn9OMFjagtdCkn5IirHBma+gAD/6+0nuJHh58dVpAeIB6bRr7uDMSUb4PWsjsUxQ4geFJUsJqTamfpzasmA+5tRxDJfXw9i/ApnKU5xFvgQ/M/ccWPH2GiK+8I9MXExlbG8rZeitMrnvC9Emf8O4IXpbJ2JDd63ls1G5bxSO/SBvUbVaNN6IIhvDHas3YpqB1t6BxddMDPKrwBq72zZpaxSAFWgIcwxGJe1Sa43QFWSPPDXfNqf6I0kFyYeqNc7MaFZXMRZeV4wM2AX/Ec1lftZBAA+vDQfJFMQA5M3206rPvgPtGRrV4Nmjh588pUb/ncxdOpYknTnnzZzuIw/YLEy76CobvssumuU4qePLMM7QDaJ3/mbYHHambW7T+OSHUhU576T8e5ssHAgT1duloDixpKS/N6H/w93tMdK3q2ZQ2pkJLuKc0EFk/ZZ7JRaE0SjsatTjoOS2of7G+SACSFMUcIZ4arcqetQ9lxCdpH4HIfSG4Sf27jOOWKd5NhKXpP4JANzxGytoaRytz88nKr5ILC66601G31Z+LbXDQBO1d8nHu+IYwiXfH2ltBhoyRMh/zqkD3R19FXDhq6K4PyKK4xdcazGfQxCeTgRgBd/l8SRsdFTjSr4YuiFpPG6yR72HKRdQG1JK5aWYLlvVv+UgJmSMARRdFxVeNik5jgpop7F+BA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z784nbB/PUkshoQtDGgTxh4Pu1FVuyItbPASlZz051n7WKFHZiJvGgJ2CcVd/MmLxSdSpdF1pLlTVJOEBaWEjl4IpRNHw8qN+HDxc1+KDOcIGNSvfsianTzv6T6/7IR+bVBtq+t/H0DCQaJtX5nPQ1b72IQzEK4uCeIjCnv8vxvG0cV9m+vWZMfPVR8szc2f5rN0qoWJLo6CGxVr9mxfOaJPKe413ZU2/CXPBy5vfcU+jkEjK5yYSvlP76zVDgliJtw0R2LCF5AVcSgNTSYFLbmdt+VsGnnrr2pVPhuvtfViHSdiII9XHPX0yQ4sbzyylW7eCQ+OP9yEj26Qsi7DL4950GuEpun3JaGrHxpQEU5yrvXuQP9+cL8dmhMhXga+gUIRH4vUb3BODovWFuxJ7WYV8VYRR8kSEpw/Ij1B5jjzwhgDEPXluNiG9bp+zizi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 22:27:43.7641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dacf0bdd-def8-4a9f-ab58-08de7a3d412b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4237
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

The value should never exceed the array size as those
are the only values the hardware is expected to return,
but add checks anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index a0cc8e218ca1e..534cb4c544dc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -154,14 +154,17 @@ mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(2, 0, 0):
 	case IP_VERSION(2, 0, 2):
-		mmhub_cid = mmhub_client_ids_navi1x[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_navi1x) ?
+			mmhub_client_ids_navi1x[cid][rw] : NULL;
 		break;
 	case IP_VERSION(2, 1, 0):
 	case IP_VERSION(2, 1, 1):
-		mmhub_cid = mmhub_client_ids_sienna_cichlid[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_sienna_cichlid) ?
+			mmhub_client_ids_sienna_cichlid[cid][rw] : NULL;
 		break;
 	case IP_VERSION(2, 1, 2):
-		mmhub_cid = mmhub_client_ids_beige_goby[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_beige_goby) ?
+			mmhub_client_ids_beige_goby[cid][rw] : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
-- 
2.53.0

