Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C24F417F3
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B485B10E527;
	Mon,  9 Mar 2026 14:57:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nW8THgv0";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 224E010E526
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qphdDIDfx2MZfEsOEM1S/zKPQHAi+jW2fhAPxGejC9WeorC47D4gWo5ReZW3XeG0AuMiz8IZFDY6WijlEBSJvJ+qrPiVZfMFsJOwEcfdbkl8MjFK129Zh8Oq52cOz+QicP9VLlqg7+GqJSN5dYemlDcnCUoWttX9lS5OYkAlfkefF2niOse3bHLVhp09nPpAK0ZAy1esN1nMjrVQk75cq44xDR382JIPwC9OguS2qI5NXoy2tmnz0RxDWO9xA2Z9z/U1Fo93gKEGC5cSv6SITdwBoHePS1Ycjdo1ISjr+LFYCeBrtwY/Z7AbizCLr2spUcatFEyo4Wf9AkttP9FCUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmQ7Y703HirS9c+US54hsRrqIG13MO1HyxYC4zCCWKs=;
 b=KOkuwIdqHm8h2LhiY3dzfW3BzYy8khWCpka+Vd7OJVCw9bTquoEJ1i+F5FXGJX18wH/KkUZ5TnZh7iCBpQ8CZ65uN3fQ3eJgPhoZTXPZ6lGCJfvyogjNHB5i+plthDxv7kEmvZpim0HjiQ6zZ+B18tNa0bcIlK7Qgd1/v/s83gMXnQRxSGDLis94Bx/v8JXrjJLir4/1YXG4s+rqt9eS0ahCyTQGiZ/0yQRKXalFtOsURhxUivThQVvecSxEgveNqEif6NP5JKUogB0gHI7mKlGO9sZdwrYczJdufwv8quY/RFUo9ebf6ED8DqAJEQDVQwB8ZHrjmATGP00DMsq1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmQ7Y703HirS9c+US54hsRrqIG13MO1HyxYC4zCCWKs=;
 b=nW8THgv0LDoqVnStLFTSB2PU6KTOqA5L7XbXXJOKUBU8jgnXLaPFlKNwKGTrDTOHQse5zPlsosvxj7LWKxqiKF7ySpndzewQjC1y1LXFMqxRsQF4VmufM0AJFEGDUuZqGFnlW1+UiipE6iu7dMPpsnLp5JOodfmUGgn2QHEhH3Q=
Received: from SJ0PR03CA0372.namprd03.prod.outlook.com (2603:10b6:a03:3a1::17)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:57:15 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::2c) by SJ0PR03CA0372.outlook.office365.com
 (2603:10b6:a03:3a1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:57:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:57:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 07:56:51 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:51 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Place firmware bo in vram for A + A
Date: Mon, 9 Mar 2026 10:56:29 -0400
Message-ID: <20260309145629.2844495-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb4558f-9818-4260-3318-08de7dec26d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026; 
X-Microsoft-Antispam-Message-Info: K3SRcYbw28xbZqiHP/rGxq8LohyFY4vYzmtkyz9NbuHDib03y1wmlq/nldwi0cx/M2kGnhTFQKndlqPZC1VQT0xnaVWZuIRBHxQRyHV870ifsqdRFbCTH02UAeHE8Wsg776gezyPEQ8fYWogdJFPCPqfoBDGxxy79DePvZuwFmRZw1MSqdXN6qmV+GhaNUcgSQokCc8Gn6p/M8UuwiHpG9xKraZRGHLJ7iW/Kg3V+G+3BLOAFvF6CtkEiWaGwwRJ2IXVy8H0go+yreknOAzu2s7C8uBd/M+a7zisqnDR9VQ1hduysizAuorfAtqO/GXYNs8IpCd8KvFy4NSx4L+b39TYV05HjeZ0UGGES/IcEPe7L3ThVHWodtURMVlSsYQDz44GF/PYgwOMMDUVmeEnEVTBHAZc3rrYCV4/LDxtzmpTj8cWz6ra43gweAjsaST8q4xQc/pYRoXLnPSJFnyUDTADOy8PvNp+3od32xbgZCPWQxFYDtQibvVCfLLM1p56HHrI+N2UuyQW+5A+xZCbSfrEWMMmwFgqpTS8iDC2MRyrQEBSHDgjwC5Tx+/eco0DBK27QcmB398IBctuWANmib0+mmnO0cUEn9tU18Ge/pvN0eEXjEH2H8ULYaHtf/AoCAzUfB+Wjl/iuBQ1nsQBxx9vDs+8bGb/+xRe4Y1PTjn/IugyoU5T/gnmAK2828A1ecF1MH7Kp1lDY7rwgibK36vBXxH+sZOlUvLgEkJ2RXAfo4l+LOU6FxFSwVClySO4XKtSPIY7731+Bz3SACcB5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +ivPmJ324GQG4+qcyoHQksUk+SVmjaUGXkhV7uYe5RDxZ26uTxjIwS8Y8fIYq4V2PVGFKt6Nqox/Yq5s68U2j5Tl2tE35NH0xIGm/5sRDxNVPeJB6MexQzYJy/kSkR0bkZx2mPpjWaC69evOh2f0YR6zJMQaDp7eGA1SfnlDFFboDkbS2ivESBweS692KT+nLE7ir+xMDI5iw7UTa5fO9shX/nYHWT0Hw4gugK0oBJBCsjukFrUEtjWpkIa66s+MeCqu1c30tgtfUhSEOtW5o9dhJ7lIFgWqfCksmkFHYdi3APF9tIt0XUQF2hYnqLiYjq/QNPR88wq5YRWUnAlBmwQ9PNfwV9A/41ysa7s6gQd/7Wlm0POkYeqSQOi6yghFgxXj+EEXCJ+Ow9YBcXF5nqNl6s2lB8J+J9qow4QFp0+E43W73/qkkfNj91lsOeqd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:57:14.9410 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb4558f-9818-4260-3318-08de7dec26d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

On A+A platforms, PSP requires the firmware bo
to be located in VRAM

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 82333aeb44530..6d9e96fabd581 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1150,7 +1150,7 @@ int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 	if ((adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) &&
 	    (adev->firmware.load_type != AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)) {
 		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
-			(amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf) ?
+			(amdgpu_sriov_vf(adev) || adev->debug_use_vram_fw_buf || adev->gmc.xgmi.connected_to_cpu) ?
 			AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
 			&adev->firmware.fw_buf,
 			&adev->firmware.fw_buf_mc,
-- 
2.53.0

