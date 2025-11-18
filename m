Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49FECF2562
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 22:07:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A06A10E537;
	Tue, 18 Nov 2025 22:07:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WX0l3Ad+";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CC9F10E205
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 22:06:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EC85am0Yj49RXciuG+6/EE2bgb8YIls4W7LZ6uro8QW8Tzr/KoYjwILlU0X37V6BmBC+hVGgGZpD3lQmUM2dKp97c/PquYSf3ORwtL4pZknNguZAf4e6IuzN3aiLY6JicbiRS9tXZ4ycE4RjEp39JuZz1+GfpS3CqTbG4NlUn8IA4+SIqaMQIIbRn80Oqj0P20xuPhouOo2NsDROYuEdIOuJrmv6roryzMz55/GqS+HoBvjKr1lTStsHGsGuMEi0YYtcg0SzItsTG7NYSNsU8MlrFZBQwyAU5O8o/DSaYXtBhRuvJu74T7VcF1PaVG3/acaVWyvIQRrhepzpPq1xTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9cXZcGmKThYNRb7ECCIBpwRfSigGr+v4qfYw/K/7tg=;
 b=NY6Ggm6awXh2E4dJdJx+4gYXs+lvDmAdPcfbMMLATldX5OlZXrlDjgwcKPIN9vfIMLvM7R69bNmVNdB6qjrMC28l0JkwZ/9OjIJPO73rATSPmGriOlCkpWPYwasyStvEfXAGJU4FnQOAyJPlS8BHnt9OeX0n2Y8vTO7rusnvYL7fyOrFtDcVufD4rUaWZoaKFGNKEQ0cj6vwfcTKuSLMyJs51E6pilhVVUhZAvVx0EppkP4mhi2GspqEIlBd9C93tkv8OAC4XPeLO8EAAGYkBf2tI1tWLbG/G9AjtE5vmXnVz8Z0p16DmLR1S3SbDVR+u3dvaT/v8OuiFFoLU2e+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9cXZcGmKThYNRb7ECCIBpwRfSigGr+v4qfYw/K/7tg=;
 b=WX0l3Ad+5DCghU4EZecD+mlfwWwSdxYCqDpMaKoug09ZHXxPyfP0KL58BcVUiI56LVVdGuVqrJy2MO3EGw/ju82rIp1roVWNTw6yQN96DHr+jhiET7csXwwqrjq1hzgCZNCHghC5ylo0zXIjdp6R9lBTh/n6jQtAaFmVB5qsjog=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by MW4PR12MB7262.namprd12.prod.outlook.com (2603:10b6:303:228::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 22:06:52 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::e5) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Tue,
 18 Nov 2025 22:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 22:06:52 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 18 Nov
 2025 14:06:50 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu/gmc12: add amdgpu_vm_handle_fault() handling
Date: Tue, 18 Nov 2025 17:06:36 -0500
Message-ID: <20251118220637.3594610-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251118220637.3594610-1-alexander.deucher@amd.com>
References: <20251118220637.3594610-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MW4PR12MB7262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0245b8-39bd-4e54-9248-08de26eec768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YAvYvd+kezps4DvtHHEMj89XZElbx/WMnsLBzpAS40yATnPN91QgOZ5L9OQI?=
 =?us-ascii?Q?vYWfRd11UeXKVyBjaAQyEqEakKeSlxQTo5/mW7KagKeI2vY0rO7R3z0wIaQk?=
 =?us-ascii?Q?JI9rBThF2v8ty8+w2ccHSggYunwhbzDFZZlyWoTjEmsEUBetCF5j5q+tA35r?=
 =?us-ascii?Q?cSPCeNj9UB3z+YHpAsauw6jlwe2YLVp+cBj28eZdOIEWs5pi3Uf0qbpAYJEV?=
 =?us-ascii?Q?1Ygif9cZTYEMQO3Nee0BTjKhyw5brOiyJHNjhWdYN0Wy+qduhA96FGTirAbh?=
 =?us-ascii?Q?xfgeBcG4nwixfsb6ILUpfvCRl+/3HkXEETvcW2x9nZD3tF8hI0pMUU+c8dUY?=
 =?us-ascii?Q?CLFM/u8EB51424mvmJtXts6UyEw2+uicoVpFPNVDyGj6Eiq3aksh8y7lp+m2?=
 =?us-ascii?Q?V7v88SAh0dS9+E1aCavvK7IS6W3REGrEixqEdFDYWkPSzyAGgyqsglTLbhio?=
 =?us-ascii?Q?CHH2F6wx3pjFdqPx9mmX57dpz2sBRfHzylWVTa2DL78+cBVaIpXPTJJ1z94o?=
 =?us-ascii?Q?CtO8Ieb3drgLdIKHt9+gtFavJAYnur6B7UIkDyKo4bGJsq3jtmKug5BYRmD6?=
 =?us-ascii?Q?aqHO5OVJnb4MzSTGFr1O7isUd8r1l5byxP8wLGbBqvSU3B4IzRvESOAv2lNm?=
 =?us-ascii?Q?wzKkxPP4odwgIQCsnRTS8QyNxCTcgVbW0B28GU+lZiEoRhiSvDStaz5jo3yT?=
 =?us-ascii?Q?4HukJKMMs+T56sPlanLInXEKV+tg5zjyD4tAUbsFUqLtK6xGz5r2//SR6+7e?=
 =?us-ascii?Q?LJbu8nG8i5C+iHYIf6th3Kd+8IC+HTGn2HDI5kxzQZosgeEH5jipG6pPD0xM?=
 =?us-ascii?Q?+EMc5ittiIl+Sfb6hAkkIuHunZqsQ+MXi7xLQOn+/H9s9lAfO2IUzCZiE8e8?=
 =?us-ascii?Q?kLon/70tPVlBwp4RIwPZdD7TuWisWXDPi10AIMURft8YwgOqh0plSElhVH5d?=
 =?us-ascii?Q?ekL8agPgJ719rhhmhrt3mw+C0cGG5c78KVSsxOr/aFmxvSJroQPcpE4Uwjtk?=
 =?us-ascii?Q?NJpK3UdAbclK8+bTfNnGIoQe5V9mrAslvRX1A8am8psuunliARI0cGbdTF2w?=
 =?us-ascii?Q?yrVhz8kUMxdc7G7VZYXukk6FQKfPebY5kGQlWcWPnbUJj8fNIfXCJqpgTUg4?=
 =?us-ascii?Q?enK5BSGq7xUs9R9jsQS06G3NjhDGdUJ2Xpcc8B/TyxPQQy8M4bSxtnEugVsE?=
 =?us-ascii?Q?kZoVdT2YBflUwtfOvHpxNLv3cedovTeOSacV2FHAZ5OxpwokYai4iQ2WYG9a?=
 =?us-ascii?Q?XFYUt9hteSnZkqCaXyor6CI4NRFb+sktbVccoSF48897kOzm8BxljG708Q3G?=
 =?us-ascii?Q?nh16qBSwRlMu7V4QTS2P36VNMh6lEKQ7Gp5Y4w06z3wWFRoQUZLOFEvsejjl?=
 =?us-ascii?Q?Ecj/dIFTbanKAM/h2oreCsDYs+40a/E5mDk8I1sXztXPJbd5yDfABWcU7zkI?=
 =?us-ascii?Q?JdfnKpVtSWxnwj/y9KChgiKOZf8v/BmWfyWWYpUXkAk7RUlwW2bQNzMSLCvN?=
 =?us-ascii?Q?Eq3s5qpo376F6b1Y7U3RZ60KH3v2NNc0+/dnlXalUJs8SYSkUn/vzwtrCmdX?=
 =?us-ascii?Q?QfxavqZ4V+hYXXuHIyU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:06:52.2355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0245b8-39bd-4e54-9248-08de26eec768
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7262
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

We need to call amdgpu_vm_handle_fault() on page fault
on all gfx9 and newer parts to properly update the
page tables, not just for recoverable page faults.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index cad2d19105c4c..43f8e96d3fe53 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -91,6 +91,8 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_iv_entry *entry)
 {
 	struct amdgpu_vmhub *hub;
+	bool retry_fault = !!(entry->src_data[1] & 0x80);
+	bool write_fault = !!(entry->src_data[1] & 0x20);
 	uint32_t status = 0;
 	u64 addr;
 
@@ -102,6 +104,31 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 	else
 		hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
 
+	if (retry_fault) {
+		/* Returning 1 here also prevents sending the IV to the KFD */
+
+		/* Process it onyl if it's the first fault for this address */
+		if (entry->ih != &adev->irq.ih_soft &&
+		    amdgpu_gmc_filter_faults(adev, entry->ih, addr, entry->pasid,
+					     entry->timestamp))
+			return 1;
+
+		/* Delegate it to a different ring if the hardware hasn't
+		 * already done it.
+		 */
+		if (entry->ih == &adev->irq.ih) {
+			amdgpu_irq_delegate(adev, entry, 8);
+			return 1;
+		}
+
+		/* Try to handle the recoverable page faults by filling page
+		 * tables
+		 */
+		if (amdgpu_vm_handle_fault(adev, entry->pasid, 0, 0, addr,
+					   entry->timestamp, write_fault))
+			return 1;
+	}
+
 	if (!amdgpu_sriov_vf(adev)) {
 		/*
 		 * Issue a dummy read to wait for the status register to
-- 
2.51.1

