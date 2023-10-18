Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76048CDB483
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Oct 2023 13:13:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE36D10E3DD;
	Wed, 18 Oct 2023 13:13:30 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2045.outbound.protection.outlook.com [40.107.101.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EB210E3DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Oct 2023 13:13:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehMUe56CLYEIckzg83888G0xmpj1n+5q67r+KSK61KQU0B/ToLx9ui4Xj8ZJimsWww3uwaEmA94LnLSBvJ0k4JV7xRBC4zjyUMV2PjY8s9xXx7mT//UXN6Bdxg/KA3YWmpDGngSM8kSlcHIDeIN+OFCDHaR11w2TvB5nbHkGh1O1JHonfOuzszQRwzDA6JWyMFyukHcvFuegVzHX9IFno33E0ewtkdFsflZnkM14XZwwXeCBD0vqkJvzKMA+PAgyOWenuTe3H50NUXdK7RZ2GXt9yHHfu0eCAG6LYFCHh0KM3po8SmbQ13i5TkqAnqw8f5AkVyWkm8/i6xlHcFXdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXQhTW8zMk00Zm5SU4t+xlJA3wblYru8uhKVCnrV7+E=;
 b=kq1z4G1FH+tLGaHhI9VSGcjPL17pnsFKcowpxCV43ishqA+zgCTmWA3B/XAnUJHOaWC7EJ3YSJ5cK7Gv8y5MUndvm6QyBvcuDveEdWeR9UC7HrSAmSExAQM/NMhtLo7QRzBelEWsCKqlO5so3ZRaiDxBVCOgsuso4WxVxmkd2ZwPq0q3t2uXKBenqss4sNDyeaC9FmpP/y8RPiJPXP4JrF366pV8NfuRfnDqNtdv6NJMRTHZXklcXpsj5zsvD4URBWlEAiIKeKBJPnRGVKNzMS/EHEoEjEqVbAdM/xLF03s5p45dOGXKZ/2wSJaas/nzNCGZKYGLiat6b6POwy+s/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXQhTW8zMk00Zm5SU4t+xlJA3wblYru8uhKVCnrV7+E=;
 b=2hMfV+uqKVjBUKLCZLWGv5zR5gK14h8BPjaSbWqL4joaIQIzjBbDnKFdzgDNxQaU4PrWo4v/NXNp6FSfWVEBIxmMIoOHbucgB3to1lIHVKbpYRomIoXTqJcHuNDByFG0vYiOXRBNaI7n9ZqdjsPaBlEoZowmrRokrtKhZSmd+b4=
Received: from DS7PR03CA0068.namprd03.prod.outlook.com (2603:10b6:5:3bb::13)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 13:13:27 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3bb:cafe::b0) by DS7PR03CA0068.outlook.office365.com
 (2603:10b6:5:3bb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Wed, 18 Oct 2023 13:13:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Wed, 18 Oct 2023 13:13:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 18 Oct
 2023 08:13:26 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: don't use ATRM for external devices
Date: Wed, 18 Oct 2023 09:13:08 -0400
Message-ID: <20231018131309.2306113-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e835ad1-16d5-45b7-eb62-08dbcfdc03f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULxrJCYyLB2boVfS3gNRfkUHBIgMqE1y/SQZK7FWqO69RhcEhd72UaW6q2SltmGZiJqhSREAcwivQS43epBxDDabJ/jJxHVDxoqDx1+hCmklFgD9MaUeqmJyOphryds97xjD5haK91y+ilgpaGSXAXH4CrtntDMeMiihi7UdA15IKPgNPRoDfsUuti09M1/KRv9zB/IXhO3YypFOvHW107tbv7DcSfH75vGm9V19J+O0tDgx6ekmVrEFciAOlWmhjYrNTaqtD8z1ucwaphLObk59Nrz199RKbbgi42ouUjbX4Yxa7c9YoV3dLI9zTJFTjVxhjpVuxsrHYmX3dF3BLKyP2GSqxsPxpzK5YkWnnFv82pVFRR4lKNn8DaU+Vnnc13FowpVrMI2JhfnaHXi+qNLEwFZTs478towHpQmeBCm2qgjdgnHvCGBKmOSksEjLyLD85eh/81lSJHhvq5Ft4vH5ufhk7Zg/oyDs5h+q6fXXMCtOtLxC0Rz0X2tRP3m4DDG3lgOURvMk8fygLcHZ0RC4pIl20IR0G06TvFngJvFjeyGbIvs0kabBF1M4/Hc79Eee5yb5eDRzoP5D7EBZSCNml7nEjcloBMiqhqpSvR+UQT0Gpom6s8JBBU6T+riTZMON0vZSuQB/I9HvUoCMbujAu1yESS0CjNE7nSJkcsmbUHJopVkMtqC5weA+LnPDNlkerZ6OBz93dtWQwbtdKt995rBFHbBf52gsL2LXP7bobgkVEWmJt7sxc7A31moZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(6666004)(966005)(70586007)(478600001)(70206006)(6916009)(41300700001)(47076005)(36860700001)(86362001)(356005)(82740400003)(81166007)(2616005)(316002)(7696005)(336012)(426003)(16526019)(26005)(1076003)(4326008)(8676002)(36756003)(2906002)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 13:13:26.8413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e835ad1-16d5-45b7-eb62-08dbcfdc03f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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

The ATRM ACPI method is for fetching the dGPU vbios rom
image on laptops and all-in-one systems.  It should not be
used for external add in cards.  If the dGPU is thunderbolt
connected, don't try ATRM.

v2: pci_is_thunderbolt_attached only works for Intel.  Use
    pdev->external_facing instead.
v3: dev_is_removable() seems to be what we want

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 38ccec913f00..f3a09ecb7699 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "atom.h"
 
+#include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -287,6 +288,10 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
+	/* ATRM is for on-platform devices only */
+	if (dev_is_removable(&adev->pdev->dev))
+		return false;
+
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
 		dhandle = ACPI_HANDLE(&pdev->dev);
 		if (!dhandle)
-- 
2.41.0

