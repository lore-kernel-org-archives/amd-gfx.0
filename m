Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF09C27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A17C010E11E;
	Wed, 16 Aug 2023 21:28:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9419F10E11E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:28:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0bFMInykrRV49oD3uc0IYF2X92uEahdeWS8uSc/mWDNDrP3vCjZiIBZ2tY9k8r2CJVGNnM7FxjhroPUzm9a+/+8vYkRVhhwLc7k7xwC/aD+odGPPbqkGaYPSA+OqSDprIluLVCxbFA/5k1Kr0QM6efoTQ8ICzCGsEB7kKOf9/kgq9jCNL0rtIeq82JccP+cE8WNVIBk6+/GtHKb1R02H77Nl6axw3/gabayFmPNLb+OqCjF2XuCG48nx9fn9tL4gy+iTybeRkKq/t4ZVYVECujnw75fUSPt4JbYVYdi0CHB1Ik1nClKpWRk2ep7jrXIz70eZ275ksd8nW2X9aB7Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxHmPkUMRgnQ5998YTLy3XYO/hC5y5+IV96DazSg4AI=;
 b=V8ns9e5YpI2B7X+zSyfWjGskpS0yKBpDv/15G3nKr0Efmp9QRgfzk8Sn7JjkZITTp9yAa/LSXhzwsLsjjytqdIkudpeWcPAKLbP4j/vLiRgYKzO6fRANI1uGoqWYO+EK7BzS+AL1PCU/o5in01dZUiVGqJ1LFsqfKpNQQHP1G2qIErg15nGNWPEPYY1/KJqGYw0tWMj8un8vniOzl7n4Gel/U/IzQRpFdAEQ8wPzaaGlAM7xRNsCsNbWvrYEh2Dr1PWr/LGQA0/Miy85oLkx44/3czYKdpiBlsYjKrXl7CaJxWn9nCZKlAgCUmR5pnGPohOQq00uDjAuKsh4gVhVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxHmPkUMRgnQ5998YTLy3XYO/hC5y5+IV96DazSg4AI=;
 b=oEmdkQAF8H1Q4/dYTkAZwtAw83fJLPLb78vXOKlQQyV+9yrL33s2w+r+WwR0MFvfs7mTsIzdvIi41Bqv2EEC0UmaSiIGHL3UarIL2MsGSUjlxUoHvDs5q30clqnPN3fTNjLpCn7xoqK9tZsemXqqwISR6kXaft2l1gGM5BF2WYk=
Received: from DS7PR07CA0006.namprd07.prod.outlook.com (2603:10b6:5:3af::16)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:28:47 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:5:3af:cafe::76) by DS7PR07CA0006.outlook.office365.com
 (2603:10b6:5:3af::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 21:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.80) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:28:46 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:28:45 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/18] drm/amd/display: Skip entire amdgpu_dm build if
 !CONFIG_DRM_AMD_DC
Date: Wed, 16 Aug 2023 15:26:09 -0600
Message-ID: <20230816212626.987519-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816212626.987519-1-alex.hung@amd.com>
References: <20230816212626.987519-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH3PR12MB7666:EE_
X-MS-Office365-Filtering-Correlation-Id: b722d05c-52f4-457f-7a05-08db9e9fc688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fI/3nE5PjcOspagysaXH/MkjIqhc6hQGxF5PtMKZA147Waf+XOPTYRPQeWbzaRgDNLM/Jd5T6v4wWROQkgv92foSZ+kmdGk1OhreBrLwpW5hqWZ+LjZEmCgEmakgE/Ac9ALko1EcZJuhMAWtVt3A2odsziKxhhytVIOFHGEUc9nmFW14+mHiM/bgngQc/AfSMneDluLbSC/TAJR55Mm51Ke+pG9c9xlJ3xEvFrkLa2IqxrpNzkOYoKv8u9TwE/M42RfaJhhqxjaCe6xFuBIVK8cK9IPdM6O5PH53Pbhj5de/cVNWdiEnlfA+MOIDyxKrokFyP7npiy/Zq/trryxqt68WmPXueLFoKqKJCm4R6S3jT6uzvfceXFfQQiu5AJiT6hvLvBNBlMRjHKJFVjQ6sdYLLeTIu+R81KgGrXB9HjjjRV44VQSQarR1BvpvoUhC2ZYH7nwDBGkEh1KiKikm2ozMM561FIuHrIYtVNjQvFxNsr0HfX7ku6OLxcxt1egVOJgI1bqRKNj3Np+nNtBQJxfEnDWU5v5X3XI/dBTa8TFA2D0lXHXEo89fJcXlSSdmyHApR4HxooK0s0mtsV7KYID0xNxkwLGRSzfSvZz8tj/yTT/xxb5ilZppPN3/Ex+kObm85g7a2slqYARUES0vqrFgIz7w9SJOzlHhKcYkp4gm01DmPQZQjdIEXips3u/8iyVgiTzjuMKoBUYqTMPbe2NnZAAdPWd1nvysHh8hiSdmY8HUTahxCr4AbulLv1wVaWIVdjGy6/BAavVWG4FwxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(44832011)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:28:46.9784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b722d05c-52f4-457f-7a05-08db9e9fc688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666
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
Cc: alexander.deucher@amd.com, Alex Hung <alex.hung@amd.com>,
 harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
Previously this only excluded build for a few amdgpu_dm
binaries which makes no sense.

[HOW]
Wrap the entire Makefile in "ifneq ($(CONFIG_DRM_AMD_DC),)"

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/Makefile | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 8bf94920d23e..063205ecb137 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -25,22 +25,24 @@
 
 
 
+ifneq ($(CONFIG_DRM_AMD_DC),)
 AMDGPUDM = \
 	amdgpu_dm.o \
 	amdgpu_dm_plane.o \
 	amdgpu_dm_crtc.o \
 	amdgpu_dm_irq.o \
 	amdgpu_dm_mst_types.o \
-	amdgpu_dm_color.o
+	amdgpu_dm_color.o \
+	amdgpu_dm_services.o \
+	amdgpu_dm_helpers.o \
+	amdgpu_dm_pp_smu.o \
+	amdgpu_dm_psr.o \
+	amdgpu_dm_replay.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
 endif
 
-ifneq ($(CONFIG_DRM_AMD_DC),)
-AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o amdgpu_dm_replay.o
-endif
-
 AMDGPUDM += amdgpu_dm_hdcp.o
 
 ifneq ($(CONFIG_DEBUG_FS),)
@@ -52,3 +54,4 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc
 AMDGPU_DM = $(addprefix $(AMDDALPATH)/amdgpu_dm/,$(AMDGPUDM))
 
 AMD_DISPLAY_FILES += $(AMDGPU_DM)
+endif
-- 
2.41.0

