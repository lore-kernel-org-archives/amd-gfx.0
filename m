Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFE8C5DF75
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABDEE10F70B;
	Fri, 14 Aug 2026 21:03:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EmTJHsRP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012055.outbound.protection.outlook.com
 [40.93.195.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CF810F705
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEXZQ1rEWbQ2mm4UfANCGckB9GoaQ71QskgVvHnUegrryyU8Bhb9VTywsZwpO8PGAodiPj5eQtaC1RGs3oqjixOsjUYC7o9MMEUZRt33TYw3MBOyoFpv2pQ3qxwV5JIcRKOzAelZME2kzOKoKnaG+husx9k7N2RIeHlJinwsaPRtgCEl+JtGroHCDTTnW5EZwQoD5vONRI9LAEb2cc95IyN3BMwiEsRx/TQ+ZR6blYeukFDBXDZMLE+0UksCZrfsw/vS9l3oUO4mZQ2vWUk98jjHT+cyTRcu7F5GfKm0VGE506JJ0jN9lHLrk7i4GIzydxe2h0Vxs9ZfWvPEzRjjKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpzQsnmQsP19Mr7fB6NnUQhAkYTlbRBj+6Pb4GTlyeo=;
 b=hnyPwZy2h7VZV8yBvQEoXu1SMe4P5MmbQVVWvQ8VDVgCzozzo2zO0/RUxYCx84msQoVQpsnRs7m9kHiUMwePnY2viJj5dfO0X2xG2xvqa/xuPVzxrUwsIy4fnQj0nE6VFIa3mzftursiyn/2kE+y4zng9VpwMiBu5e570CFITyNd1Y2nBUuYHU82UC3MPp4URcuWNcxu3d+080XNxx7aIaPP5GdmDRc1ijav4/Z0aluACJsvoeGs7c/jCX600w4EmsJG4REM7kmBjk1gsfewULMbzn9afwaj3p+XoYoTt0xVW8r+9ZMKW66oFbLA0ZBXg/DYdnaP85FBOaoFyxqTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpzQsnmQsP19Mr7fB6NnUQhAkYTlbRBj+6Pb4GTlyeo=;
 b=EmTJHsRP0VuPG1/nqidFaF5jOMyKRBgnRjBFSPDCj4XBYOxKOoMsJ+SsjA3y045drw+OozLofaped5J9Rf9r86oSwl5PW0OslnSv2vVC9djUM0BolE3LvCvLvmn7impLEBLEWKWXnlzF6rgoNXTgG01k5WjpUS8QMR6tAyly9O8=
Received: from CH0PR03CA0334.namprd03.prod.outlook.com (2603:10b6:610:11a::25)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:26 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:11a:cafe::20) by CH0PR03CA0334.outlook.office365.com
 (2603:10b6:610:11a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.16 via Frontend Transport; Fri,
 14 Aug 2026 21:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Fri, 14 Aug 2026 21:03:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 036/109] drm/amd/ras: Isolate ras mce handler with
 CONFIG_X86_MCE_AMD
Date: Fri, 14 Aug 2026 17:01:33 -0400
Message-ID: <20260814210246.3067612-37-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 968ea474-6be0-4836-117c-08defa477b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: JTFthX80892yAMhWekywL+ohDjGx+xtDgtk6FFGR4ZJQhjm8BufsUz3kaT1b5XtKSLEWnv2RXTlKF2TZLgUYyQBN6x8urLaA4jenLqQqq8i4c4sOVgQCPu14nx3SyC5n056Q/V9EYNernBNU3/yrG2vwlpmJ5BxKoN5QaGr9Zv2KUkveJO3Bf7AKJTUrnVHwHNiyY0V1y3wb+xdy6US3CsU1re8KC//ZaYhUq0ZeWU7Sfvqvrw2vDNeYUCcwdvihEb9R8Q10XEmQ+IgF5Em0vOC/T71OYTHJWV5S8ffa+50pOqJfm0AGM6Evuy1Sz2i1LEd/iBnwSJlR+8QsjJKll1h9dG5v2MdxMVrHga8R5inS2Ds3+Uy8z2OwAIMvMcxCCXSzl5dillrEXVtrk1i9asJl4pDTsqRgqXjHvPHOOZj5hVxHB3OeiGiikD3w9JR0FGsqDL2nwlpuXCt4hjy5YbEVlQ5TQJDalCGGkGZi0Ro1/Goi/LrP30ommFG3GAFTIe5d32XI71tV1p4oQS0BslSthDs6F5deF7cPFYM4iAHm9NczJVb/U6uxllsklDHWmRGFDmiggAsRx7J6o3lXBSRgKzZqJ6BHjxRE+KvwjkOMDtOL5XdC8pC7lT0X4SahQgVg+m5BbHeJ85SunyOgfl8+AJpzyeaIzW5a16N1lxA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JTc34C7ineMsOL8ORJxcFNizzNTa/MMTCdwo5n9y596GMQCicdmmpp4kJHcvnEl9UJjEs/ebqpOmWX6QB/veFgNZN6ZT/YFjYkBfqJfbyx7m4bCSubvAY1eLdrbE/i3FgN8YDF0lvcWPKkzMslkI/zDC/8KWTQczB8DhBN4WfNr/Dq/sEoPhggHN3a5xUigZ/3gmj0sqBN2AjAAV8u57Z5oQwDyCyp0HvPJrWYQ601PcISVn/RyWu8XvJRuqptV0wBeJWM0qPvttfZ2t3qJR8b+/Jo+sWvM3d0R11rdEQ09ZJ7hn7/ON4tVh9idL4hh0CU/UDgNVtEJ9JsS8fjBimXIdmgIim9hNGuleBH5FGO1x0GLSqDyjLFXPx2EEK8R3Th9BgjRhoIuLGzL50wSg+1qoWIieZKaj+b/KXE7akC1WvbmKERX6F3tbSnpLNXJ0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:25.6033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 968ea474-6be0-4836-117c-08defa477b97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Isolate ras mce handler with CONFIG_X86_MCE_AMD.

v2:
  Isolate all ras mce handlers.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
index 795085beb1986..bc7a44618ac6c 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mce.c
@@ -27,6 +27,9 @@
 #include "amdgpu_ras_mce.h"
 #include <asm/mce.h>
 
+#ifdef CONFIG_X86_MCE_AMD
+#include <asm/mce.h>
+
 static int amdgpu_sys_mce_notifier(struct notifier_block *nb, unsigned long val, void *data);
 typedef int (*mce_notifier)(struct amdgpu_device *dev,
 			unsigned int id, unsigned long val, void *data);
@@ -232,6 +235,7 @@ static int amdgpu_ras_mce_notifier(struct amdgpu_device *adev,
 
 	return 0;
 }
+#endif
 
 int amdgpu_ras_mce_hw_init(struct amdgpu_device *adev)
 {
@@ -245,12 +249,16 @@ int amdgpu_ras_mce_hw_fini(struct amdgpu_device *adev)
 
 int amdgpu_ras_mce_sw_init(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_MCE_AMD
 	amdgpu_ras_register_mce_notifier(adev, amdgpu_ras_mce_notifier);
+#endif
 	return 0;
 }
 
 int amdgpu_ras_mce_sw_fini(struct amdgpu_device *adev)
 {
+#ifdef CONFIG_X86_MCE_AMD
 	amdgpu_ras_unregister_mce_notifier(adev);
+#endif
 	return 0;
 }
-- 
2.55.0

