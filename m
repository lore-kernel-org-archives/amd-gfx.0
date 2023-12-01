Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BFBC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 13:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3687310E893;
	Fri,  1 Dec 2023 13:29:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3598710E880
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 13:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6gdP+E0VUyvxeoBXR1gjrwzmvAKnow+ad6FyifISlGr/x6f47A4TcI2Ckza6BraLc3aD1pwzxh4xAep56zu+uajEi5xYVlKqHmA8DyTAZQ94LM6mmAtKdw5II7Gfb/A0PAo2Lw9W3vh0Rn1eLtOavu9B/AOyGdV3RYMh+0d624OORTVGvwaztC9wmlQzJnHmNa1dfwxEtbj4EM3k9oBaMgrQWhIeR9suj5XoLK8dIAPu4pTrBXSCfN3zQRGiqIJ72Jq4eFnhpKx1/wdnJ3UKXG2GI30QUtnLk9Nsoe44CE7QlxHKClXZf8vceBKwviN/RzZFI53LOGalkPuaA4cAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HVLEyCpwv/zs+9t0/V3bod+WYH3wIJ5pnSeGyrRf8pM=;
 b=BNLakVsa0zTBBT3JVQ7/+lmTxCc77RpK/Q7Qovvta+LGCIep5vZX8P9/Inkxk6+asHANps0nXl9uhu1uuACNkQt8PiQvufiYURCHQqAwh4Z4IoNf9H80yTVZVFwBi0Ah1ZtXADhzOvZMJyPSuXw83gSE2ZqwWIpAK5t8s8SnpZvF2foiS8Q96keHVViJuLcY2BExkQmpi5HFPBiBm76lRSTzo74DURm4XWM9zKHiAu8EKoeoYkWatWufXML2a2ITo093ldaFzn0VlOhaXFRYCedyor79KX06pajDusWl9s0lVJa6HyW7A7fP0oll84pCd1Qsx/Srv0+JdIXbFXJJqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVLEyCpwv/zs+9t0/V3bod+WYH3wIJ5pnSeGyrRf8pM=;
 b=Rr+Pk8AKDKz+oJ5D/SHUao4YzFneDYhfc9Y4oiWop9ZWCnjI+GtkIf5umzUu4cadpUMVUQS9liDPamK5Rzny1/BKioO2+bKlCpHWjTEC+GICAM+Q1Jtkeu9YTPKa8DAkKhf0gVyNeFLzSjrc8fo55l9IB1OtkZm/TG4lDOKQAcM=
Received: from DS0PR17CA0018.namprd17.prod.outlook.com (2603:10b6:8:191::18)
 by SJ2PR12MB7991.namprd12.prod.outlook.com (2603:10b6:a03:4d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Fri, 1 Dec
 2023 13:29:00 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::dc) by DS0PR17CA0018.outlook.office365.com
 (2603:10b6:8:191::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27 via Frontend
 Transport; Fri, 1 Dec 2023 13:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 13:29:00 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 1 Dec
 2023 07:28:48 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/47] drm/amd/display: Skip entire amdgpu_dm build if
 !CONFIG_DRM_AMD_DC
Date: Fri, 1 Dec 2023 06:25:22 -0700
Message-ID: <20231201132731.2354141-27-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
References: <20231201132731.2354141-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SJ2PR12MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: 3299a527-8b60-4ef5-658d-08dbf2717aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHdRRntdFEwScK/rS46+w6SaWhwHcy49qmTaLqHngsUw3rUA3eINqjQ0NKaLPSftifjEtc4bGj1TJpEaGA+ftDq4Pr1Da5QRgZ6WqKn1d5uOr2GKDP9NWj8LoVECubO/x0bVZW9uVaSZEzzPHAF9qxO3DuHePyn/+nYjl9MVfMlfKTGmZsPefFS7EtMwwbQ4lKCXDp3XpyMpt2QW1pOSUUzrkHTJQDASz2n/zE9Bu7h7Ao6Bl6qqC7In1ghHrdMoWMBGKmMcAjM6BSYdTknYz2zCLM7NQ5HafqUvXiMm20eABP9wiZO1mrmJtoQwRXOYzbUY+s76ly/zdTA7u+a9TSPEtkN+RgqZfj56j07wktBdc0tgpD4jsycU9Az0U/PvDRGnQUhN3oPHgiZkcZw1qSuRsVoWPAr7vAJMm4KIHkChbVqnSFdjiu80jPmusZPKzHyjLg9R8fz0fxPWQbU+g+ARYq1GonkLX3lFCJkqqZbvqIUL0qo4Kz4efoVsHUTwVZwjU5saRp/CJ3bZscfuGOcYJrccuqbuagqhOumI84rWCTqRMxXc2vtGtO38S1phom06Fjj6sfc+FXnz1770bMwnybKPYfcPBG3AAggmyQa8cX6EiR9hsetuUtKb0GE3vByeqcVHPsAFmASMGuWHTqEJZQT0B95K+FKqkAMsPif+NgrlTiFZITLVaOCd67eZYpaib+7hOKs0Yn1jG1P4fuId6Hp39v6XBknee0bu9UQxp54FtDtzC7DFTBCRGK9+pBzfjYfKKOuiOWEbdaiMsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(40470700004)(46966006)(36840700001)(81166007)(83380400001)(40460700003)(356005)(47076005)(2906002)(54906003)(26005)(2616005)(1076003)(70586007)(70206006)(6916009)(86362001)(316002)(8936002)(4326008)(8676002)(5660300002)(16526019)(6666004)(478600001)(41300700001)(82740400003)(336012)(426003)(36756003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:29:00.5489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3299a527-8b60-4ef5-658d-08dbf2717aaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7991
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

[WHY]
Previously this only excluded build for a few amdgpu_dm
binaries which makes no sense.

[HOW]
Wrap the entire Makefile in "ifneq ($(CONFIG_DRM_AMD_DC),)"

Reviewed-by: Alex Hung <alex.hung@amd.com>
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
2.42.0

