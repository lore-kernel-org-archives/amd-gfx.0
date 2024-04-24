Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED08C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 08:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE29210FE1C;
	Wed, 24 Apr 2024 08:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3q74u/O6";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D116510FE2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 08:53:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgRh/db6ZcLHgSsVT82FCg8GcJ4ZAkbHjYnW5XY0J9JTnlYPWAQNvl0RNDAEtTmHlMcmT3j62NzIfP+Dwm30wLrgdnp22+OpJ+ZSmyzEBWdYUyK6PzFU4ObhC9Rryh8oGvjlrxbiHrV+/A56xa7vxpU02eVgu2+PQ4qoQ6Fr6we7DC0qEOnNkoDutTBgY2eqilWNK1cDKjjCLtjLalNfnHFAlbpuL52wBSIf44/dZfzcUVo92z2iOBWRiwY9udTW1no6+5PaWEf19EOwXs7fng20B59jYQ86rl52FrgQ8W7Qj3CnZrl0jXV+z+ZPAcE8wmRMZPhu8RlcIOpFWPA8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrt4liviT5+9Po94TOGDYKFZ1fxBOknDmwKhvl/pcyc=;
 b=TxbtnjuN8EPPzKMJHibmXLr0/EFz/gwFWP/yTvkFgYY4L18St9njjg24mgiYAZgLTMrURnoUYfqqXMJb+RtI5WAg/DN6MhyFNucksDZos4LG5/4YO0ISyMsFACDu87QCPKuIWEq52fOrKBmgX1Ts8LKhzkiU7nzeRT1qAQKYNgY6hUPl/XM8++nv47FwuAm99r+M4EaPkA/bxaSXKmtInUXh/H847+s5UFaGTFWQamYAQoKWza4/vRpZ51UpiL5muBDjmyOyYR6fqzAgvuIbk+oonQh5T0CPFADIYuOAV+FS3Eru1d2nQaCLLV4eqYKhPaidshPyUN+jzAC6/LkQcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrt4liviT5+9Po94TOGDYKFZ1fxBOknDmwKhvl/pcyc=;
 b=3q74u/O6tJF6Rru/0CgO99GMaT+JOqBAQvK7P642h0g3+Wap2UaunRy7RqBTKlXitJ78pXosrNtI7/9j2PnKRVKaWsEUoPxqi5KzCWuMDIMtMTb1HAmztkwPD6GeBVfkCcvyFdEXrFDAQWtNVtEIlY9myj5OlP07nv7tQdWdNXk=
Received: from BN6PR17CA0047.namprd17.prod.outlook.com (2603:10b6:405:75::36)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 08:53:16 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:405:75:cafe::73) by BN6PR17CA0047.outlook.office365.com
 (2603:10b6:405:75::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Wed, 24 Apr 2024 08:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 08:53:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:15 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 03:53:15 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 03:53:11 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Revalla Hari Krishna
 <harikrishna.revalla@amd.com>, Martin Leung <martin.leung@amd.com>
Subject: [PATCH 32/46] drm/amd/display: Refactor HUBBUB into component folder
Date: Wed, 24 Apr 2024 16:49:17 +0800
Message-ID: <20240424084931.2656128-33-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240424084931.2656128-1-Wayne.Lin@amd.com>
References: <20240424084931.2656128-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d9fcd6-2a3f-4ac4-a492-08dc643bfb3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2t9i18//rUlhxdQZJJAiuIG3w2mb851dd3wW4+3mAPPlV4ERBuJcEYSXGkga?=
 =?us-ascii?Q?/hci3BnqReKASVF2k3WFaf0aYDEeQBPo49VNWY/2Ays9lMjG1AdvTfAWrCiL?=
 =?us-ascii?Q?l3+mMKEUls35HKvJI0QTww5UfiCbKZUzKVUjSNC3qGkR7M8/uo71BdTKAHTF?=
 =?us-ascii?Q?Gl/S0uyP6dKzy7lVaUP5fmTazRtuYAYAf2VycBo3Xa9tleaoZHn3PDwszsBn?=
 =?us-ascii?Q?SlMBFUc2AHtoSyieli8irBxa6RchXhodemTwloH8fFIfj20s0S2l2PzWbAw9?=
 =?us-ascii?Q?ftN/Dykt3hYJys/NmSBh4mTImuJ3XeMNbQLxFqJ25DoVq0I6dmcQaHKeD0S3?=
 =?us-ascii?Q?Llp3Xb/RV61PBzfd7e2B08JXf1ZPNLBUqwUVa7iCE2gFYsKBTASS9YjXD6FH?=
 =?us-ascii?Q?PKavkpTxyBozRjrLCPuG9Cs1pziqLyj2YsVgllrVUVLIsNFz9nxcA9gI8fzT?=
 =?us-ascii?Q?x18rsk3oLDS52I0WQ6shs3v8L+2bw1QJfFmn0wN2Vn5aCZgRG8vDC5bnbOYE?=
 =?us-ascii?Q?OFc5mobIplGu4yzrqL134vY9J1M4bcbVPDv53z8aIzDU+aTMuy8V6VVbKrOX?=
 =?us-ascii?Q?mssuroLvAhnItQeZ8aAfNp3JAAufyUYINaUO9WwvY7ABcU6LJcXImHkvqc5c?=
 =?us-ascii?Q?Q8jPHUEbenJRfFZpl1UJpLIQtxIWJYm/mqw/06O8AK6uP5kLZnf9dYQQQ7We?=
 =?us-ascii?Q?kMZ2AZUTTUKXbSB340T9Gq8pXCdmLOMl2rSB36YHOKf9cE5GozVwZF7A2NEA?=
 =?us-ascii?Q?LVRYlr/cN/YcfSVZZ/ET0ADj9qePMboIBNT/ai3zFeJCwAZMKhBK9KxgaEVO?=
 =?us-ascii?Q?j8/UvQCOmf2ffNyRJtjucZTtQCJ/MUbDQ7jlAgo9NjFZ5z5/G8D1pbat78gq?=
 =?us-ascii?Q?Cb7urMiB4Qr1259KYtKNAhjn46Povwq9lZPo7SlV+HsHdA/SPmyzAbxBdRVb?=
 =?us-ascii?Q?0XwbNFJvR/wLv8xPRiXUBprO09ILLSFtsej5/uTi/JkTt0KfsENBMKKnKYNS?=
 =?us-ascii?Q?7TeYR3wfnkrfYnWsLPIFPUzWcolyibCNbaxpM+bw9S3nhzwAL01Y53rooK89?=
 =?us-ascii?Q?5z4NlixQsA/ajUAjZ2FaTbiDp6N3qXMSpDI8xjXs/iliHxAKE3X+8DxyG8Ea?=
 =?us-ascii?Q?fI24bs3JyKbKPCdWXHDV4gTOCfYwiYMrBMyXpUWHEV2n8kWWsn6B81FrcKk0?=
 =?us-ascii?Q?kV1M4bWlO1VVArj3t+kktgjYYGzf9srmfInKNg/LTtl1fAmimgRC6PUitSWE?=
 =?us-ascii?Q?UmrEyduToOIxCmpW6bcnkaIH1RxIxvfXQCIyNaA3QFZ2PXHCoYxIG1pjUkKP?=
 =?us-ascii?Q?EjUKQoZUp5qMkXcOAYZsoRnvMh1B+VgGxQqkoienhD26Gewj0/caAIBOM/5V?=
 =?us-ascii?Q?/1MyZuQOQgu55Tbf7wd+epP9rLBB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:53:16.0293 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d9fcd6-2a3f-4ac4-a492-08dc643bfb3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974
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

From: Revalla Hari Krishna <harikrishna.revalla@amd.com>

[why]
cleaning up the code refactor requires hubbub to be in its own component.

[how]
Move all files under newly created hubbub folder and fix the makefiles.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Revalla Hari Krishna <harikrishna.revalla@amd.com>
---
 drivers/gpu/drm/amd/display/Makefile          |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   3 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/hubbub/Makefile    | 100 ++++++++++++++++++
 .../dc/{ => hubbub}/dcn10/dcn10_hubbub.c      |   2 +-
 .../dc/{ => hubbub}/dcn10/dcn10_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn20/dcn20_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn20/dcn20_hubbub.h      |   2 +-
 .../dc/{ => hubbub}/dcn201/dcn201_hubbub.c    |   0
 .../dc/{ => hubbub}/dcn201/dcn201_hubbub.h    |   0
 .../dc/{ => hubbub}/dcn21/dcn21_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn21/dcn21_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn30/dcn30_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn30/dcn30_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn301/dcn301_hubbub.c    |   0
 .../dc/{ => hubbub}/dcn301/dcn301_hubbub.h    |   0
 .../dc/{ => hubbub}/dcn31/dcn31_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn31/dcn31_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn32/dcn32_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn32/dcn32_hubbub.h      |   0
 .../dc/{ => hubbub}/dcn35/dcn35_hubbub.c      |   0
 .../dc/{ => hubbub}/dcn35/dcn35_hubbub.h      |   0
 31 files changed, 114 insertions(+), 15 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn10/dcn10_hubbub.c (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn10/dcn10_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn20/dcn20_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn20/dcn20_hubbub.h (99%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn201/dcn201_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn201/dcn201_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn21/dcn21_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn21/dcn21_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn30/dcn30_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn30/dcn30_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn301/dcn301_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn301/dcn301_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn31/dcn31_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn31/dcn31_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn32/dcn32_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn32/dcn32_hubbub.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn35/dcn35_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn35/dcn35_hubbub.h (100%)

diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/display/Makefile
index 9a5bcafbf730..839e71aa7d0c 100644
--- a/drivers/gpu/drm/amd/display/Makefile
+++ b/drivers/gpu/drm/amd/display/Makefile
@@ -34,6 +34,7 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/resource
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dsc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/optc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/dpp
+subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc/hubbub
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/inc
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/freesync
 subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/modules/color
diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 8d963befc756..f1b0b1f66fb0 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for Display Core (dc) component.
 
-DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp
+DC_LIBS = basics bios dml clk_mgr dce gpio hwss irq link virtual dsc resource optc dpp hubbub
 
 ifdef CONFIG_DRM_AMD_DC_FP
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 8dc7938c36d8..508306baa65a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -27,7 +27,7 @@ DCN10 = dcn10_ipp.o \
 		dcn10_opp.o \
 		dcn10_hubp.o dcn10_mpc.o \
 		dcn10_cm_common.o \
-		dcn10_hubbub.o dcn10_stream_encoder.o dcn10_link_encoder.o
+		dcn10_stream_encoder.o dcn10_link_encoder.o
 
 AMD_DAL_DCN10 = $(addprefix $(AMDDALPATH)/dc/dcn10/,$(DCN10))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index c51b717e5622..3adef474ed26 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -41,7 +41,7 @@
 #include "mpc.h"
 #include "reg_helper.h"
 #include "dcn10_hubp.h"
-#include "dcn10_hubbub.h"
+#include "dcn10/dcn10_hubbub.h"
 #include "dcn10_cm_common.h"
 #include "clk_mgr.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index 9b6070c99794..6e5b7fcf8dbd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -3,7 +3,7 @@
 # Makefile for DCN.
 
 DCN20 = dcn20_hubp.o \
-		dcn20_mpc.o dcn20_opp.o dcn20_hubbub.o dcn20_mmhubbub.o \
+		dcn20_mpc.o dcn20_opp.o dcn20_mmhubbub.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index 3880db59e457..c5716ea5886a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: MIT
 #
 # Makefile for DCN.
-DCN201 = dcn201_hubbub.o\
-	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o \
+DCN201 = dcn201_mpc.o dcn201_hubp.o dcn201_opp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
 
 AMD_DAL_DCN201 = $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index ca92f5c8e7fb..b0803403fe23 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN21.
 
-DCN21 = dcn21_hubp.o dcn21_hubbub.o \
+DCN21 = dcn21_hubp.o \
 	 dcn21_link_encoder.o dcn21_dccg.o
 
 AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index c6ca70f3c061..435979febb79 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -23,8 +23,7 @@
 #
 #
 
-DCN30 := dcn30_hubbub.o \
-	dcn30_hubp.o \
+DCN30 := dcn30_hubp.o \
 	dcn30_dccg.o \
 	dcn30_mpc.o dcn30_vpg.o \
 	dcn30_afmt.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index d241f665e40a..bfda72fa4f42 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -11,7 +11,7 @@
 # Makefile for dcn30.
 
 DCN301 = dcn301_dccg.o \
-		dcn301_dio_link_encoder.o dcn301_panel_cntl.o dcn301_hubbub.o
+		dcn301_dio_link_encoder.o dcn301_panel_cntl.o
 
 AMD_DAL_DCN301 = $(addprefix $(AMDDALPATH)/dc/dcn301/,$(DCN301))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 5d93ac16c03a..9608c1f418ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn31.
 
-DCN31 = dcn31_hubbub.o dcn31_hubp.o \
+DCN31 = dcn31_hubp.o \
 	dcn31_dccg.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index a58c37165f5a..8a6bc529f376 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn32.
 
-DCN32 = dcn32_hubbub.o dcn32_dccg.o \
+DCN32 = dcn32_dccg.o \
 		dcn32_mmhubbub.o dcn32_hubp.o dcn32_mpc.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_resource_helpers.o \
 		dcn32_hpo_dp_link_encoder.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index d5b4533d2f62..09fd994ae158 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -12,7 +12,7 @@
 
 DCN35 = dcn35_dio_stream_encoder.o \
 	dcn35_dio_link_encoder.o dcn35_dccg.o \
-	dcn35_hubp.o dcn35_hubbub.o \
+	dcn35_hubp.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_pg_cntl.o dcn35_dwb.o
 
 AMD_DAL_DCN35 = $(addprefix $(AMDDALPATH)/dc/dcn35/,$(DCN35))
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/Makefile b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
new file mode 100644
index 000000000000..ab2fddc4a858
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/Makefile
@@ -0,0 +1,100 @@
+
+# Copyright 2022 Advanced Micro Devices, Inc.
+#
+# Permission is hereby granted, free of charge, to any person obtaining a
+# copy of this software and associated documentation files (the "Software"),
+# to deal in the Software without restriction, including without limitation
+# the rights to use, copy, modify, merge, publish, distribute, sublicense,
+# and/or sell copies of the Software, and to permit persons to whom the
+# Software is furnished to do so, subject to the following conditions:
+#
+# The above copyright notice and this permission notice shall be included in
+# all copies or substantial portions of the Software.
+#
+# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+# THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+# OTHER DEALINGS IN THE SOFTWARE.
+#
+# Makefile for the 'hubbub' sub-component of DAL.
+#
+ifdef CONFIG_DRM_AMD_DC_FP
+###############################################################################
+# DCN
+###############################################################################
+
+HUBBUB_DCN10 = dcn10_hubbub.o
+
+AMD_DAL_HUBBUB_DCN10 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn10/,$(HUBBUB_DCN10))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN10)
+
+###############################################################################
+
+HUBBUB_DCN20 = dcn20_hubbub.o
+
+AMD_DAL_HUBBUB_DCN20 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn20/,$(HUBBUB_DCN20))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN20)
+
+###############################################################################
+
+HUBBUB_DCN201 = dcn201_hubbub.o
+
+AMD_DAL_HUBBUB_DCN201 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn201/,$(HUBBUB_DCN201))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN201)
+
+###############################################################################
+
+HUBBUB_DCN21 = dcn21_hubbub.o
+
+AMD_DAL_HUBBUB_DCN21 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn21/,$(HUBBUB_DCN21))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN21)
+
+###############################################################################
+HUBBUB_DCN30 = dcn30_hubbub.o
+
+AMD_DAL_HUBBUB_DCN30 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn30/,$(HUBBUB_DCN30))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN30)
+
+###############################################################################
+HUBBUB_DCN301 = dcn301_hubbub.o
+
+AMD_DAL_HUBBUB_DCN301 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn301/,$(HUBBUB_DCN301))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN301)
+
+###############################################################################
+
+HUBBUB_DCN31 = dcn31_hubbub.o
+
+AMD_DAL_HUBBUB_DCN31 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn31/,$(HUBBUB_DCN31))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN31)
+
+###############################################################################
+HUBBUB_DCN32 = dcn32_hubbub.o
+
+AMD_DAL_HUBBUB_DCN32 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn32/,$(HUBBUB_DCN32))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN32)
+
+###############################################################################
+
+HUBBUB_DCN35 = dcn35_hubbub.o
+
+AMD_DAL_HUBBUB_DCN35 = $(addprefix $(AMDDALPATH)/dc/hubbub/dcn35/,$(HUBBUB_DCN35))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_HUBBUB_DCN35)
+
+###############################################################################
+
+
+###############################################################################
+endif
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
index 6dd355a03033..d738a36f2132 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.c
@@ -24,7 +24,7 @@
  */
 
 #include "dm_services.h"
-#include "dcn10_hubp.h"
+#include "dcn10/dcn10_hubp.h"
 #include "dcn10_hubbub.h"
 #include "reg_helper.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
similarity index 99%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
index 24a9c45988ed..036bb3e6c957 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn20/dcn20_hubbub.h
@@ -27,7 +27,7 @@
 #define __DC_HUBBUB_DCN20_H__
 
 #include "dcn10/dcn10_hubbub.h"
-#include "dcn20_vmid.h"
+#include "dcn20/dcn20_vmid.h"
 
 #define TO_DCN20_HUBBUB(hubbub)\
 	container_of(hubbub, struct dcn20_hubbub, base)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn201/dcn201_hubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn21/dcn21_hubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn30/dcn30_hubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn301/dcn301_hubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn31/dcn31_hubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn32/dcn32_hubbub.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.h
rename to drivers/gpu/drm/amd/display/dc/hubbub/dcn35/dcn35_hubbub.h
-- 
2.37.3

