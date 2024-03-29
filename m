Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0A6CD11DD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Mar 2024 09:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0556910E133;
	Fri, 29 Mar 2024 09:49:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5X2E2wnw";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBE210E3E4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Mar 2024 09:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK9vR723B1gXiwRf4V/Ig0CbgG9EsiG2wqpPbpwsB+z9PDVi6OtYX/OvC/gY8SrGGUZCQ7Oj45ovB+CAaDhODFy1lPXQXvvQf5Wz4alGSzhe7JdbgHcxPr51In90KNq+jZhY+fOxnEQpSNWwGyMMBGkMuSEd+94dccHD87X74FAjVugJR3abedSGCmsiO3j6b8NxyvrJa75vBDceCVUIB8Dn75hMEFxKfCIVjkAu+jRyUBFojSW9oJnwbTmf5E2hElvyR65pVemKgmH0HWX84jUyiuG2F0CaHfnp+cIft4ojDB+epfgpkwbWhEj7T/fIS5AhI22UyICAfOZXMhzrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZTkONdeWoOkkYUthMO20Nzg2dW1sVyDxTsf5Aztyn0=;
 b=egNbBotd1RKpqOWq8GR0YPAdychu97ZF4r8cK5gPwlz3G55IGkcAebxC3iMyb/41IsgDZpuHHZqJa54JKwgTvRhin0Um+FTsHmsvaiGLkaBUXeS8q5Svc7btWn44J2eqW+EesJeMq+VXl7MyHAIDq7BJadjg31tsJ3/rexW+fdvm4wKUBcYGfVl7XJ9AZJI7ni3ChNQORDLSiwZ3wh6xbGNygfdVtFRt21nd0UmjPre82OyCzt9tuRqHNLt3OOUFeaJsRk2PYRouAxgJz4krum2Qol4jdrXjw4LsEEwz1oTZbxS39DxMGfjb2EGJpGYX2IngQdxuoyDA9J4K202RpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZTkONdeWoOkkYUthMO20Nzg2dW1sVyDxTsf5Aztyn0=;
 b=5X2E2wnwEZ8NGsqW4wXEI4Rfc1RmuLqVbBYjQWAtoFHmkydqd+DxQCRIgwa1OCNtZUMs83IdBF6dEWMW9/wDpMRNHdJo86qUkevrk1vHBkeOA1IRrjCtK3C3hOk7EHUKEXPMZjf/PM6hx2vrMuH8rYVu3J1r5cVuaZKqcOMV87o=
Received: from BL6PEPF0001640D.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:14) by SJ0PR12MB6688.namprd12.prod.outlook.com
 (2603:10b6:a03:47d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 09:49:17 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2a01:111:f403:f902::1) by BL6PEPF0001640D.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41 via Frontend
 Transport; Fri, 29 Mar 2024 09:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 09:49:17 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 04:49:16 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 29 Mar
 2024 04:49:16 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2507.35 via Frontend Transport; Fri, 29 Mar 2024 04:49:15
 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Bypass asd if display hw is not available
Date: Fri, 29 Mar 2024 17:49:13 +0800
Message-ID: <20240329094913.32185-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 412bf109-d631-45fd-374e-08dc4fd57fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m4rXJYCJYbrYqC6B6xueHae7FwNdb1rkhJqziU59jZk9Sl4AIeGIZyD8pWQif/fOnXzyjt1lDGyCFBjh8OL/prGoSUU6XhwqZnTXAWtbY6L3jDTSd+s6jxTl22cTe3GqM8bcgn56osbP+zFpX3u5weqGw5vvyp0GikvIX0bvnejFFGQxJAObQcj3nCErj6cRT4j/VBf2yiSXfcw7oTRF76WawOvTpuJ3H3p2XFEWwiPGYdNMRfxXFUXLDn3nIlH8ijgcX5Z1o9MEngAGS0vOTCtb34jN7dPN06vZAK0/2K2mUeFNYqbwbUnDBePFH1AO2EXwlSTVs/Rl1nwSs58QInm/0yYu2DRM8W9EcYuamSRuTl4Pyj08TA+XQYEfqOg8fuAmwcA3Hc3hGH4l0BuGYM3bBjddNq/lyfncl5C3Y+/nWSfTZ2V7NO3hnYXxZ4WhvXRqCF/eCm4UcnZ5KLx11p8/fveYDcDARwn01ZUBZxdmwkraQpd3ctJ7YrlZQ98/wFKOgengkoTEfsy6STM9WWQLPrx4oxNf/rwTBbVIHtsMwjf3jBLYe7suAndJpbNeCxadf0d8WrFE/ObfCPT8O9upZMCfrGLAay2LyWDl+I0PntqjCQI3SeEv9e+ZfdKqFYreXaWbBYOOt1c9ITWhQgH2cv2lGMK68SgmmS6/FZvWsWb71Pptyqr14RQAiku3h/CS8c1+QXI80RNGkRpfkqEjadZdY+VwYdQ/5FnLJL+NFXyxzKVKNo0VTq1U1RSz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 09:49:17.1393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 412bf109-d631-45fd-374e-08dc4fd57fe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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

ASD is not needed by headless GPU.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 94b310fdb719d..063203865bbe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1053,6 +1053,11 @@ static int psp_asd_initialize(struct psp_context *psp)
 	if (amdgpu_sriov_vf(psp->adev) || !psp->asd_context.bin_desc.size_bytes)
 		return 0;
 
+	/* bypass asd if display hardware is not available */
+	if (!amdgpu_device_has_display_hardware(psp->adev) &&
+	    amdgpu_ip_version(adev, MP0_HWIP, 0) >= IP_VERSION(13, 0, 10))
+		return 0;
+
 	psp->asd_context.mem_context.shared_mc_addr  = 0;
 	psp->asd_context.mem_context.shared_mem_size = PSP_ASD_SHARED_MEM_SIZE;
 	psp->asd_context.ta_load_type                = GFX_CMD_ID_LOAD_ASD;
-- 
2.17.1

