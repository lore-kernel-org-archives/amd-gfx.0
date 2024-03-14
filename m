Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EF3C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 10:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF5AF10FA3F;
	Thu, 14 Mar 2024 10:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="09262vO9";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2D110FA3F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 10:36:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4Eiy5TyvN7hVpXFjp6RLe7S/h37b1KaEkhZ9Hq58niUdMcu7Dh7f36O9ZOMhi22GoSP0yb3cBHMun6NbDg74C9xTPfuYXkGO9+ZyZU1kc1hk3pdL5dHkBMe16cku1MYQwChOBDLjVzsihbZnEWe1vbGAYJnmr/bmOZwJ21WBVefCfuh8VL5tLWhuy107DlFNlVP8fIm38V7KmnbUihYLB8u1v1H8Hm2TLbQzMb7DxlH3QQOsBFN/SqIEhUTtPdg4uy+RdmVIlzvDqXrGhnFhMJv41TpjHEZOtxNMW/VYq5/qN/a/SA22ZukuCEqMIUONCEkjjVoQldo4eq81fvdSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6I1fONT9u5ogtoZC6CXmptXKKh7WJ3+XW9WCbHDGWc=;
 b=PdarKf6rDSzRMPXnuoPqLn5jRJkneyVpO2RrRkLubFG8X0sdaiMZWOtfk4qy/2u/35cfZlayr5vUZ9J8XZ7ZlZWKj7a1t4LtaPiJ6vUGbVWeVe/BCE0C9h+s6VMJWErr/3G4q/TaBh7pBlclRM47zpKjYLEroTat+f1LHqS7RoAo5fBCAfAmRlJr/oduaKQ/wl8BwfhjHHXpz/5wB5mJjIvts1ijP7I/mF7GJ5zgZhWmY1TFmmCch2ekI5IIqt3ZnpLHtJ3PqyXSKY7kq6KF2Gi7NISvG7dQ28kJHXDErp94LH4w3Rh8PKNk12/uUmro8zd6E4OEUogWtJ5dF8vhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6I1fONT9u5ogtoZC6CXmptXKKh7WJ3+XW9WCbHDGWc=;
 b=09262vO9pjP5vzfLrIVTTlCkdRP7jdRfgi/GnsDi4oGVYYLI22jlpNwK0/TH2SQIMiPmBPgaqrYFDdfil7nJnjGOfmtgwdJkcgLuJKjqxqR5Sk9zf9tSmC0u5Uo1w/nBHP9nTaw/fNzw0LUHU2RoH6/J6WSYbmHMHHGwbaIfATQ=
Received: from MN2PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:23a::10)
 by CH2PR12MB4038.namprd12.prod.outlook.com (2603:10b6:610:7b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 10:36:36 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::7) by MN2PR03CA0005.outlook.office365.com
 (2603:10b6:208:23a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Thu, 14 Mar 2024 10:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 10:36:36 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 05:36:34 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Bypass display ta if it is harvested
Date: Thu, 14 Mar 2024 18:36:20 +0800
Message-ID: <20240314103620.27165-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|CH2PR12MB4038:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be5242b-485c-461c-3ad2-08dc44129ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBObJ64PNgwxnjGWEFlNx6GPA9mpHFWbcYZxFq1TAhcoc3syUQmz7eTz4IyFdH2ieYnffcKz0XsKoJt7ktFAUxmIBHpiqcN3AvuSyoRSHrUQvIhgQ4/pyuBXXCPHkyPaQwF0Js7EUuyj1k8hc96sZOX1Gim8Mmp2x9HqC2B4ZpRSkAjr7DRn/hXMIi5tBwx5aNjHy+pW/9qqYF4/K8tbNAh/6KnepY9t9fU4FhiPvm2CANf1SGLpDv+buQe1Oyq7WVXK7iP2sMLOXvVGQEug4ElReENR4LR5H1aGXExgrsSVGNBZHF9gsW9HQXsmfvr9apGFFXgiOB+Sa41CDHnXeptNHLH5M29V6cf9LCR7sv7BUEKd7iRZKmS3cRuG3APuScR9CeeG9tBLDYVTCMfqnJtKV1Fkg7VkThteOT1oX88g0M9f2iaNrQ7oncYYRpeRAcX3iTYgJf91J33gAzFDfCdxDVhYrao54GlmwurhoRbxf1nUnX6lKE7tIpPLidfcMvYbFudYa0BUKRKlLPDeJ9gtOL8s0ccFxhWj7AFOlUJzLLDDAQAw5hv26/+b9Zd/vZSktCTEu5+Qq9TkKNlxUxGTEU63DaQ+DNbuOdqN5CO812NEibK/dCjo+Q5NDA77pGOgnHYGL8RSTWmaIIeiUve11U/rC26kjCjeTAyQei+R5Qa/7xCeySprFcIVpYVqEe//NVATaODsA+JfdbVl7oS4JqBNqvMbtQgyhBXahQmhwo4XcZxa025i5Bx+s7Ar
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 10:36:36.3350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be5242b-485c-461c-3ad2-08dc44129ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4038
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

Display TA doesn't need to be loaded/invoked if it
is harvested.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 867397fe2e9d..bb4988c45ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1830,6 +1830,10 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
+	/* bypass hdcp initialization if dmu is harvested */
+	if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
+		return 0;
+
 	if (!psp->hdcp_context.context.bin_desc.size_bytes ||
 	    !psp->hdcp_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "HDCP: optional hdcp ta ucode is not available\n");
@@ -1862,6 +1866,9 @@ int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
+	if (!psp->hdcp_context.context.initialized)
+		return 0;
+
 	return psp_ta_invoke(psp, ta_cmd_id, &psp->hdcp_context.context);
 }
 
@@ -1897,6 +1904,10 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
+	/* bypass dtm initialization if dmu is harvested */
+	if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
+		return 0;
+
 	if (!psp->dtm_context.context.bin_desc.size_bytes ||
 	    !psp->dtm_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "DTM: optional dtm ta ucode is not available\n");
@@ -1929,6 +1940,9 @@ int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
+	if (!psp->dtm_context.context.initialized)
+		return 0;
+
 	return psp_ta_invoke(psp, ta_cmd_id, &psp->dtm_context.context);
 }
 
@@ -2063,6 +2077,10 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
+	/* bypass securedisplay initialization if dmu is harvested */
+	if (psp->adev->harvest_ip_mask & AMD_HARVEST_IP_DMU_MASK)
+                return 0;
+
 	if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
 	    !psp->securedisplay_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not available\n");
-- 
2.17.1

