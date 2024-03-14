Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBE8C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 13:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34BBD10F9F5;
	Thu, 14 Mar 2024 13:18:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AsYrkMqf";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A98710F939
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 13:18:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiFGHv5AjjvwuO09fuakuR7CKFbbx+NFSJQDciyzkTsQ5LgzaBU+gM0AtsGGZy+FFPvzv0FCjq0NBnfNfN5t6erHTn7NPTJpfPq3ZJEhpFxG81HwTkwrW4ord4Qz6j28z4gDt5yKQ0DbZjVndRttpKjLRa8TKEZ5Mv0L7Qk6yiq5x1mUdFmBkGEV33L/BmYO2eUG5dQBaFxKu4uNtxaYIMaNbAb1sDmf2VdCo/2BQc/9MKkYimYQZK+lPsA6VDcWNWGxspDJyKnblVOl4rGzXigmyr7h9hr+N8o0ifCgNgX7b6XNoj3RrMnGCuuqTPXmnB0SWbYamJxSt+TK2VGhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWx7G5lmE2FK94/W3d2fDPb5wVr/AdjOp6NETyci38E=;
 b=GKfq5ycfN4M1YS8h/D4YC+s9vVBAAMOYLtTk0vdkFtM+UbJ0rratK+/ep2tTckEGOuslNR5TF34jygZ85hKMXKT2C0jCWTIRO41L9L224SRTCjh8B9H24kvRWXup33p3SywIlUn1OwS8gZ5rKn/FmANgovDfrWOOjr1Dzj28+sIomk0VJ/HqrK3qm2Kqxyd9mX+sqIscPRKLpB/ZPJPIWUfc9sRksxd/dm9m1DRI70H9ev2Rt1lpdFns39k4AIZaHape0XranbzHQrViHoNdGWH9GcUZc9Lw7PHpMOU3YSy3/sYrZkUZvkcCHYlWI2jG2YUhwhvi01wVPGGhKXpXcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWx7G5lmE2FK94/W3d2fDPb5wVr/AdjOp6NETyci38E=;
 b=AsYrkMqfhdlK4WDfg3Yilbmf40hDssWh9DZqslo/PS5LOG+5epDH7Ms8cfkFEkfW4NpiMpIy2P29UZIWlriEFIqJwrcVwImCb5x9wuMHeRh9O4wb9xcQcjWpvBNj7LuIKAf5Ip+oSogE1cLHjCtC+O3RuRC81t/tt+a8F+FqoeY=
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 13:18:45 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::c9) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21 via Frontend
 Transport; Thu, 14 Mar 2024 13:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 13:18:45 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 08:18:43 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Kenneth Feng <Kenneth.Feng@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: [PATCH] drm/amdgpu: Bypass display ta if display hw is not available
Date: Thu, 14 Mar 2024 21:18:30 +0800
Message-ID: <20240314131830.27538-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: eaaea7ed-da9f-4973-f4ad-08dc442946df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RIHA3PQb6UGu+PD1esFbE4jah8TfZfCgGqVR8jMIuUe9+0tSjoKthZ6vlPSl9vXloDAY/tQ58LdboS3NN3J/cRtAUl7OVxZ7aZ47c/DGnhjf6QVDBVVI/OaqqRNqS8OWBmIycDFVYxTV7gThz9udxigtnwOY8qpzjorbgpuSjVEG+zeTm6rEAkmH+mjsiziF8htKrUHZKlL84HBzcZY7Bb2Oj4+q+gkVgDW5cd6AjnYW/jBuBRiJ8xgUmcVd9ZiUpIG6YpqyxsOmQtufUrtZ/dC0m9mf44jMcrIe8u996K9m1eSN3oAahvpkqN+pNxJTnmwLrZC5lMyrl7i91IjepkOrKfmjNU6VtEGvFiXUffbNkub6ABR/pJaCmb9O1P8eIBbAal4grxRNz44teNh5f4D1BEkwSXInmRpAjTD8uNwj3FnelL/PZdbDipQs4EASc8ausTOU9lcO3tRXGhi4U3Eb9IIIFL1odayK1I8MLUBMDM49g1cpp5Vm7Mi/c+pa19KVs4GPLpHpa1hi1KXhXynaTbnb/qk+BokJ3EaQJo7x5SdmMOhTsKbLqTt7DuaCfSJdOTsLzabyNTF28P52e7xyUoyqTpTKTFyUxUy/GE1cQUqki4juAUZqtWUkrtoc4+hAvCGSvz85NRpoRKqzHskdE5jGZ5pEJWGlhk55kE0FBj7GHkg63NAer7nVjl1XovGghxgQfFzItudQp+jCEeePXPhCNPpo9nkKTk2AFezEc49tvgls5BWkKl9p1BqJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 13:18:45.2729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaaea7ed-da9f-4973-f4ad-08dc442946df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453
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

Do not load/invoke display TA if display hardware is not
available

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 867397fe2e9d..e7d7fd2cc31d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1830,6 +1830,10 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev))
 		return 0;
 
+	/* bypass hdcp initialization if dmu is harvested */
+	if (!amdgpu_device_has_display_hardware(psp->adev))
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
+	if (!amdgpu_device_has_display_hardware(psp->adev))
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
+	if (!amdgpu_device_has_display_hardware(psp->adev))
+                return 0;
+
 	if (!psp->securedisplay_context.context.bin_desc.size_bytes ||
 	    !psp->securedisplay_context.context.bin_desc.start_addr) {
 		dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta ucode is not available\n");
-- 
2.17.1

