Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C63C3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5EA10E5F4;
	Wed, 20 Dec 2023 16:37:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9316610E5F2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGUlvstPSV065Zozbk04o3N3m+RxQGSr5e/pC5cIT5mBE8XJwIe9dWNMZKuz0lSXmqRcftigC3JZrQp+YzHF1OVvAypoHgV54Z0g2/2uAbRIDOs/lk+vUsRga1hgcpjXRpCxNjx9pjb7Kk4ls96DK+G0g9FtNgTwc6UzjpscQZWsTpVWizyDdCcHi20yKZPp2wrForxLzKbHLxAeVnTePq7UJ/aqybKOjQRwNkvR+2B6BMJ8+MQMSurkTS9LRkh2/62/YwOAK9HOtsgOmxLwYoyL3CDVimANzJ5t/RGAzA/Lei7wd9nT3krWLeIiUG5TLJxGzceLPJJKAsufnWFMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E9qaOjXllqMILfvhiNAU2M32aMPeKMlg9zGUqa6am/I=;
 b=NrlP1PuVduiX6INLv6HiIHfSgXUIrAUYheQaPJUpIcxEjbpX5dTV8aWDFUSCut7zQYfqRGSoKa8oBiyOXjlHCqbvZfsLoW337Wx8nPshVv8HxmJaRW3uhwpqBk8jeTtLZ20j7y7ai4zRXCy5+tpA5icmXBaGyBhDcktzqGosDZ/bqM7X77scPKxOZWmQ7AOSBOEmEJ0lwJztNHKV2lw6gPPlmFkXnuPm688yIMOR21XErdJvF3JhGcG33x2yVd76sjrC9SQmNhygYYT+09edhp4aTFpopOPl+hwP0hFxpX3eBH26ifC5sJX+Dh4oZsjx4Tle/VXjrt1rmSfSlpHh4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E9qaOjXllqMILfvhiNAU2M32aMPeKMlg9zGUqa6am/I=;
 b=FM6TDdRD++rlQaq1b/XwYL1wXWDUc+yvfklTp10yjNUcPJ0O0Rzo+1ckdNdbJqK9oLzodC4MXbSkEW7G8tAKa/CDAMmRWbvfmE3OUhTXzwKEiSgYzP1ei77UY4xjDP7fFmjCdPah2GF7ZkCM9wNRckwCl+B3PVXMl5ftuAjuS78=
Received: from BL1P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::12)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:37:11 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c5:cafe::50) by BL1P221CA0001.outlook.office365.com
 (2603:10b6:208:2c5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:08 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/20] drm/amd/display: Refactor INIT into component folder
Date: Wed, 20 Dec 2023 09:33:48 -0700
Message-ID: <20231220163538.1742834-17-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 740d6e65-4882-4d47-02c1-08dc0179ea20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0f/XEepoBpI0Y5Pd6MwEFulrDWpW8dMO/0nsiqI78ZlHMfsf97JyDkptQyKDH8SikIrNl0f8g7Lp2edL8NqytLlWWhy5VRjFJ++imY+MV7i3BJ0MAku92sJSldBcH3b/BmdaE7oakEd5lyT7rjJNIAuKn7F70K3+0nfOTH+cvgBYMAMe+Vflm0JtJBcQY3NPjQN589heLIL7mNABfYzPPC1Wn/E2pImoQXaQJzxGhqzm7W8e3fYnYzeuDXrv/9/XtTScowdbAAL01dlSz41OCutASbzH+NSx1tysLmo7+Uk4ZHr6ZYic4RZOS2ft/h4W01gBzgd73JaaRG9Fd6qa4j2mBuYo1KgPd9uUzTVTbGBwl4uvNX9NGzT024Fec4TxLs+LMiAJBhNE/HDPn7XdfIjcBWwnIYbMEHOsobqEeYqMNU1CZa6ZaaEXDvIG2YM3iT+8Kvj9Jd0G/vGKYOcXnigdZazxB7C8Dhft1Aagl4/KGbxtljRx4kdpnAePLurtF5WQB2U6HG5fW+QkCEMa72+ypRpiVSl+XDf2TgKhLY4RGxTnrz2YfWxR39pyqWfB1c+9x/8lkeFTP4ho1FKu5TyukAg254QaARG8k1CcRNjY7d0qVbbopLY+9fpiqNE3W8C49WhiSSHv9Q1rC3eDvRy0c6oOOX/N8cHguU7Hjn16nubCmNuceYv0Ht7L6GwdRYnOZqiSgtMmTErh8obtZ+LLqKT+MzrbwzSGnNQAf2zchieevyK6qbZ8tzUNvNkauHGhnLynD6Q+D5jMsPhaSTdEV5BbAGp4FkDAmINxE0MTzWzDKCJu6pBQUocb68CCzqyx0NAGw2D/gIvFg3GNUZGfMaLvTcer+kptzuU87U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(230273577357003)(230373577357003)(230473577357003)(230173577357003)(186009)(64100799003)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(16526019)(426003)(336012)(19627235002)(40480700001)(2616005)(26005)(6666004)(478600001)(1076003)(41300700001)(36860700001)(81166007)(6916009)(70586007)(70206006)(54906003)(40460700003)(83380400001)(316002)(86362001)(82740400003)(356005)(66899024)(36756003)(8936002)(8676002)(47076005)(2906002)(30864003)(5660300002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:10.9936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 740d6e65-4882-4d47-02c1-08dc0179ea20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 Revalla <hrevalla@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Revalla <hrevalla@amd.com>

[why]
Move all init files to hwss folder.

[how]
moved the dcnxx_init.c and .h files into inside the hwss and cleared the
linkage errors.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Revalla <hrevalla@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 -
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   4 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |   2 +-
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  12 --
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   3 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |  28 +--
 .../display/dc/{ => hwss}/dcn10/dcn10_init.c  |   0
 .../display/dc/{ => hwss}/dcn10/dcn10_init.h  |   0
 .../display/dc/{ => hwss}/dcn20/dcn20_init.c  |   0
 .../display/dc/{ => hwss}/dcn20/dcn20_init.h  |   0
 .../dc/{ => hwss}/dcn201/dcn201_init.c        |   0
 .../dc/{ => hwss}/dcn201/dcn201_init.h        |   0
 .../display/dc/{ => hwss}/dcn21/dcn21_init.c  |   0
 .../display/dc/{ => hwss}/dcn21/dcn21_init.h  |   0
 .../display/dc/{ => hwss}/dcn30/dcn30_init.c  |   0
 .../display/dc/{ => hwss}/dcn30/dcn30_init.h  |   0
 .../dc/{ => hwss}/dcn301/dcn301_init.c        |   0
 .../dc/{ => hwss}/dcn301/dcn301_init.h        |   0
 .../dc/{ => hwss}/dcn302/dcn302_init.c        |   0
 .../dc/{ => hwss}/dcn302/dcn302_init.h        |   0
 .../dc/{ => hwss}/dcn303/dcn303_init.c        |   0
 .../dc/{ => hwss}/dcn303/dcn303_init.h        |   0
 .../display/dc/{ => hwss}/dcn31/dcn31_init.c  |   0
 .../display/dc/{ => hwss}/dcn31/dcn31_init.h  |   0
 .../dc/{ => hwss}/dcn314/dcn314_init.c        |   0
 .../dc/{ => hwss}/dcn314/dcn314_init.h        |   0
 .../display/dc/{ => hwss}/dcn32/dcn32_init.c  |   0
 .../display/dc/{ => hwss}/dcn32/dcn32_init.h  |   0
 .../display/dc/{ => hwss}/dcn35/dcn35_init.c  |   0
 .../display/dc/{ => hwss}/dcn35/dcn35_init.h  |   0
 .../amd/display/dc/hwss/dcn351/CMakeLists.txt |   4 +
 .../drm/amd/display/dc/hwss/dcn351/Makefile   |  17 ++
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  | 171 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn351/dcn351_init.h  |  33 ++++
 41 files changed, 250 insertions(+), 41 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn302/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn10/dcn10_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn10/dcn10_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn20/dcn20_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn201/dcn201_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn21/dcn21_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn30/dcn30_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn301/dcn301_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn302/dcn302_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn303/dcn303_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn31/dcn31_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn314/dcn314_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn32/dcn32_init.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_init.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hwss}/dcn35/dcn35_init.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.h

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index bae4fdddbf97..7991ae468f75 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -34,8 +34,6 @@ DC_LIBS += dcn21
 DC_LIBS += dcn201
 DC_LIBS += dcn30
 DC_LIBS += dcn301
-DC_LIBS += dcn302
-DC_LIBS += dcn303
 DC_LIBS += dcn31
 DC_LIBS += dcn314
 DC_LIBS += dcn32
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
index 0dd62934a18c..ae6a131be71b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/Makefile
@@ -22,7 +22,7 @@
 #
 # Makefile for DCN.
 
-DCN10 = dcn10_init.o dcn10_ipp.o \
+DCN10 = dcn10_ipp.o \
 		dcn10_hw_sequencer_debug.o \
 		dcn10_dpp.o dcn10_opp.o \
 		dcn10_hubp.o dcn10_mpc.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
index bd760442ff89..3dae3943b056 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN.
 
-DCN20 = dcn20_init.o dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
+DCN20 = dcn20_dpp.o dcn20_dpp_cm.o dcn20_hubp.o \
 		dcn20_mpc.o dcn20_opp.o dcn20_hubbub.o dcn20_mmhubbub.o \
 		dcn20_stream_encoder.o dcn20_link_encoder.o dcn20_dccg.o \
 		dcn20_vmid.o dcn20_dwb.o dcn20_dwb_scl.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index a101e6511555..2b0b4f32e13b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: MIT
 #
 # Makefile for DCN.
-DCN201 = dcn201_init.o \
-	dcn201_hubbub.o\
+DCN201 = dcn201_hubbub.o\
 	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_dpp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
index dd1eea7212f4..ca92f5c8e7fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
@@ -2,7 +2,7 @@
 #
 # Makefile for DCN21.
 
-DCN21 = dcn21_init.o dcn21_hubp.o dcn21_hubbub.o \
+DCN21 = dcn21_hubp.o dcn21_hubbub.o \
 	 dcn21_link_encoder.o dcn21_dccg.o
 
 AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
index cd95f322235e..b5b2aa3b3783 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/Makefile
@@ -23,9 +23,7 @@
 #
 #
 
-DCN30 := \
-	dcn30_init.o \
-	dcn30_hubbub.o \
+DCN30 := dcn30_hubbub.o \
 	dcn30_hubp.o \
 	dcn30_dpp.o \
 	dcn30_dccg.o \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index 090011300dcd..d241f665e40a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn30.
 
-DCN301 = dcn301_init.o dcn301_dccg.o \
+DCN301 = dcn301_dccg.o \
 		dcn301_dio_link_encoder.o dcn301_panel_cntl.o dcn301_hubbub.o
 
 AMD_DAL_DCN301 = $(addprefix $(AMDDALPATH)/dc/dcn301/,$(DCN301))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
deleted file mode 100644
index 0fcd03569d74..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ /dev/null
@@ -1,12 +0,0 @@
-#
-# (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  Authors: AMD
-#
-# Makefile for dcn302.
-
-DCN3_02 = dcn302_init.o
-
-AMD_DAL_DCN3_02 = $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN3_02)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 11a2662e58ef..5d93ac16c03a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn31.
 
-DCN31 = dcn31_hubbub.o dcn31_init.o dcn31_hubp.o \
+DCN31 = dcn31_hubbub.o dcn31_hubp.o \
 	dcn31_dccg.o dcn31_dio_link_encoder.o dcn31_panel_cntl.o \
 	dcn31_apg.o dcn31_hpo_dp_stream_encoder.o dcn31_hpo_dp_link_encoder.o \
 	dcn31_afmt.o dcn31_vpg.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index d5c177346a3b..b134ab05aa71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -10,8 +10,7 @@
 #
 # Makefile for dcn314.
 
-DCN314 = dcn314_init.o \
-		dcn314_dio_stream_encoder.o dcn314_dccg.o
+DCN314 = dcn314_dio_stream_encoder.o dcn314_dccg.o
 
 AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
index 905b74b53092..5314770fff1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for dcn32.
 
-DCN32 = dcn32_hubbub.o dcn32_init.o dcn32_dccg.o \
+DCN32 = dcn32_hubbub.o dcn32_dccg.o \
 		dcn32_mmhubbub.o dcn32_dpp.o dcn32_hubp.o dcn32_mpc.o \
 		dcn32_dio_stream_encoder.o dcn32_dio_link_encoder.o dcn32_resource_helpers.o \
 		dcn32_hpo_dp_link_encoder.o
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
index fa7ec82ae5f5..0e317e0c36a0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/Makefile
@@ -10,7 +10,7 @@
 #
 # Makefile for DCN35.
 
-DCN35 = dcn35_init.o dcn35_dio_stream_encoder.o \
+DCN35 = dcn35_dio_stream_encoder.o \
 	dcn35_dio_link_encoder.o dcn35_dccg.o \
 	dcn35_hubp.o dcn35_hubbub.o \
 	dcn35_mmhubbub.o dcn35_opp.o dcn35_dpp.o dcn35_pg_cntl.o dcn35_dwb.o
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
index bccd46bd1815..254136f8e3f9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/hwss/Makefile
@@ -78,7 +78,7 @@ ifdef CONFIG_DRM_AMD_DC_FP
 # DCN
 ###############################################################################
 
-HWSS_DCN10 = dcn10_hwseq.o
+HWSS_DCN10 = dcn10_hwseq.o dcn10_init.o
 
 AMD_DAL_HWSS_DCN10 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn10/,$(HWSS_DCN10))
 
@@ -86,7 +86,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN10)
 
 ###############################################################################
 
-HWSS_DCN20 = dcn20_hwseq.o
+HWSS_DCN20 = dcn20_hwseq.o dcn20_init.o
 
 AMD_DAL_HWSS_DCN20 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn20/,$(HWSS_DCN20))
 
@@ -94,7 +94,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN20)
 
 ###############################################################################
 
-HWSS_DCN201 = dcn201_hwseq.o
+HWSS_DCN201 = dcn201_hwseq.o dcn201_init.o
 
 AMD_DAL_HWSS_DCN201 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn201/,$(HWSS_DCN201))
 
@@ -102,7 +102,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN201)
 
 ###############################################################################
 
-HWSS_DCN21 = dcn21_hwseq.o
+HWSS_DCN21 = dcn21_hwseq.o dcn21_init.o
 
 AMD_DAL_HWSS_DCN21 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn21/,$(HWSS_DCN21))
 
@@ -114,7 +114,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN21)
 
 ###############################################################################
 
-HWSS_DCN30 = dcn30_hwseq.o
+HWSS_DCN30 = dcn30_hwseq.o dcn30_init.o
 
 AMD_DAL_HWSS_DCN30 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn30/,$(HWSS_DCN30))
 
@@ -122,7 +122,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN30)
 
 ###############################################################################
 
-HWSS_DCN301 = dcn301_hwseq.o
+HWSS_DCN301 = dcn301_hwseq.o dcn301_init.o
 
 AMD_DAL_HWSS_DCN301 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn301/,$(HWSS_DCN301))
 
@@ -130,15 +130,17 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN301)
 
 ###############################################################################
 
-HWSS_DCN302 = dcn302_hwseq.o
+HWSS_DCN302 = dcn302_hwseq.o dcn302_init.o
 
 AMD_DAL_HWSS_DCN302 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn302/,$(HWSS_DCN302))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN302)
 
+
+
 ###############################################################################
 
-HWSS_DCN303 = dcn303_hwseq.o
+HWSS_DCN303 = dcn303_hwseq.o dcn303_init.o
 
 AMD_DAL_HWSS_DCN303 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn303/,$(HWSS_DCN303))
 
@@ -146,7 +148,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN303)
 
 ###############################################################################
 
-HWSS_DCN31 = dcn31_hwseq.o
+HWSS_DCN31 = dcn31_hwseq.o dcn31_init.o
 
 AMD_DAL_HWSS_DCN31 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn31/,$(HWSS_DCN31))
 
@@ -154,7 +156,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN31)
 
 ###############################################################################
 
-HWSS_DCN314 = dcn314_hwseq.o
+HWSS_DCN314 = dcn314_hwseq.o dcn314_init.o
 
 AMD_DAL_HWSS_DCN314 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn314/,$(HWSS_DCN314))
 
@@ -162,7 +164,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN314)
 
 ###############################################################################
 
-HWSS_DCN32 = dcn32_hwseq.o
+HWSS_DCN32 = dcn32_hwseq.o dcn32_init.o
 
 AMD_DAL_HWSS_DCN32 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn32/,$(HWSS_DCN32))
 
@@ -170,7 +172,7 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN32)
 
 ###############################################################################
 
-HWSS_DCN35 = dcn35_hwseq.o
+HWSS_DCN35 = dcn35_hwseq.o dcn35_init.o
 
 AMD_DAL_HWSS_DCN35 = $(addprefix $(AMDDALPATH)/dc/hwss/dcn35/,$(HWSS_DCN35))
 
@@ -180,4 +182,4 @@ AMD_DISPLAY_FILES += $(AMD_DAL_HWSS_DCN35)
 
 ###############################################################################
 
-endif
\ No newline at end of file
+endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn302/dcn302_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn302/dcn302_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn303/dcn303_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn303/dcn303_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h
rename to drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.h
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/CMakeLists.txt b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/CMakeLists.txt
new file mode 100644
index 000000000000..951ca2da4486
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/CMakeLists.txt
@@ -0,0 +1,4 @@
+dal3_subdirectory_sources(
+  dcn351_init.c
+  dcn351_init.h
+)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
new file mode 100644
index 000000000000..b24ad27fe6ef
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/Makefile
@@ -0,0 +1,17 @@
+#
+# (c) Copyright 2022 Advanced Micro Devices, Inc. All the rights reserved
+#
+#  All rights reserved.  This notice is intended as a precaution against
+#  inadvertent publication and does not imply publication or any waiver
+#  of confidentiality.  The year included in the foregoing notice is the
+#  year of creation of the work.
+#
+#  Authors: AMD
+#
+# Makefile for DCN351.
+
+DCN351 = dcn351_init.o
+
+AMD_DAL_DCN351 = $(addprefix $(AMDDALPATH)/dc/dcn351/,$(DCN351))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DCN351)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
new file mode 100644
index 000000000000..143d3fc0221c
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -0,0 +1,171 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "dce110/dce110_hwseq.h"
+#include "dcn10/dcn10_hwseq.h"
+#include "dcn20/dcn20_hwseq.h"
+#include "dcn21/dcn21_hwseq.h"
+#include "dcn30/dcn30_hwseq.h"
+#include "dcn301/dcn301_hwseq.h"
+#include "dcn31/dcn31_hwseq.h"
+#include "dcn32/dcn32_hwseq.h"
+#include "dcn35/dcn35_hwseq.h"
+
+#include "dcn351_init.h"
+
+static const struct hw_sequencer_funcs dcn351_funcs = {
+	.program_gamut_remap = dcn30_program_gamut_remap,
+	.init_hw = dcn35_init_hw,
+	.power_down_on_boot = dcn35_power_down_on_boot,
+	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_for_surface = NULL,
+	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
+	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
+	.update_plane_addr = dcn20_update_plane_addr,
+	.update_dchub = dcn10_update_dchub,
+	.update_pending_status = dcn10_update_pending_status,
+	.program_output_csc = dcn20_program_output_csc,
+	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
+	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
+	.update_info_frame = dcn31_update_info_frame,
+	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
+	.enable_stream = dcn20_enable_stream,
+	.disable_stream = dce110_disable_stream,
+	.unblank_stream = dcn32_unblank_stream,
+	.blank_stream = dce110_blank_stream,
+	.enable_audio_stream = dce110_enable_audio_stream,
+	.disable_audio_stream = dce110_disable_audio_stream,
+	.disable_plane = dcn35_disable_plane,
+	.disable_pixel_data = dcn20_disable_pixel_data,
+	.pipe_control_lock = dcn20_pipe_control_lock,
+	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.cursor_lock = dcn10_cursor_lock,
+	.prepare_bandwidth = dcn35_prepare_bandwidth,
+	.optimize_bandwidth = dcn35_optimize_bandwidth,
+	.update_bandwidth = dcn20_update_bandwidth,
+	.set_drr = dcn10_set_drr,
+	.get_position = dcn10_get_position,
+	.set_static_screen_control = dcn30_set_static_screen_control,
+	.setup_stereo = dcn10_setup_stereo,
+	.set_avmute = dcn30_set_avmute,
+	.log_hw_state = dcn10_log_hw_state,
+	.get_hw_state = dcn10_get_hw_state,
+	.clear_status_bits = dcn10_clear_status_bits,
+	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_power_control = dce110_edp_power_control,
+	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
+	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.set_cursor_position = dcn10_set_cursor_position,
+	.set_cursor_attribute = dcn10_set_cursor_attribute,
+	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
+	.setup_periodic_interrupt = dcn10_setup_periodic_interrupt,
+	.set_clock = dcn10_set_clock,
+	.get_clock = dcn10_get_clock,
+	.program_triplebuffer = dcn20_program_triple_buffer,
+	.enable_writeback = dcn30_enable_writeback,
+	.disable_writeback = dcn30_disable_writeback,
+	.update_writeback = dcn30_update_writeback,
+	.mmhubbub_warmup = dcn30_mmhubbub_warmup,
+	.dmdata_status_done = dcn20_dmdata_status_done,
+	.program_dmdata_engine = dcn30_program_dmdata_engine,
+	.set_dmdata_attributes = dcn20_set_dmdata_attributes,
+	.init_sys_ctx = dcn31_init_sys_ctx,
+	.init_vm_ctx = dcn20_init_vm_ctx,
+	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
+	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.power_down = dce110_power_down,
+	.set_backlight_level = dcn21_set_backlight_level,
+	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
+	.set_pipe = dcn21_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dcn32_disable_link_output,
+	.z10_restore = dcn35_z10_restore,
+	.z10_save_init = dcn31_z10_save_init,
+	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.optimize_pwr_state = dcn21_optimize_pwr_state,
+	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
+	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
+	.update_dsc_pg = dcn32_update_dsc_pg,
+	.calc_blocks_to_gate = dcn35_calc_blocks_to_gate,
+	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
+	.hw_block_power_up = dcn35_hw_block_power_up,
+	.hw_block_power_down = dcn35_hw_block_power_down,
+	.root_clock_control = dcn35_root_clock_control,
+	.set_idle_state = dcn35_set_idle_state,
+	.get_idle_state = dcn35_get_idle_state
+};
+
+static const struct hwseq_private_funcs dcn351_private_funcs = {
+	.init_pipes = dcn35_init_pipes,
+	.update_plane_addr = dcn20_update_plane_addr,
+	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
+	.update_mpcc = dcn20_update_mpcc,
+	.set_input_transfer_func = dcn32_set_input_transfer_func,
+	.set_output_transfer_func = dcn32_set_output_transfer_func,
+	.power_down = dce110_power_down,
+	.enable_display_power_gating = dcn10_dummy_display_power_gating,
+	.blank_pixel_data = dcn20_blank_pixel_data,
+	.reset_hw_ctx_wrap = dcn31_reset_hw_ctx_wrap,
+	.enable_stream_timing = dcn20_enable_stream_timing,
+	.edp_backlight_control = dce110_edp_backlight_control,
+	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
+	.did_underflow_occur = dcn10_did_underflow_occur,
+	.init_blank = dcn20_init_blank,
+	.disable_vga = NULL,
+	.bios_golden_init = dcn10_bios_golden_init,
+	.plane_atomic_disable = dcn35_plane_atomic_disable,
+	//.plane_atomic_disable = dcn20_plane_atomic_disable,/*todo*/
+	//.hubp_pg_control = dcn35_hubp_pg_control,
+	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
+	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
+	.update_odm = dcn35_update_odm,
+	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
+	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
+	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
+	.dccg_init = dcn20_dccg_init,
+	.set_mcm_luts = dcn32_set_mcm_luts,
+	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
+	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
+	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
+	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.dsc_pg_control = dcn35_dsc_pg_control,
+	.dsc_pg_status = dcn32_dsc_pg_status,
+	.enable_plane = dcn35_enable_plane,
+};
+
+void dcn351_hw_sequencer_construct(struct dc *dc)
+{
+	dc->hwss = dcn351_funcs;
+	dc->hwseq->funcs = dcn351_private_funcs;
+
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.h
new file mode 100644
index 000000000000..970b01008b23
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DC_DCN351_INIT_H__
+#define __DC_DCN351_INIT_H__
+
+struct dc;
+
+void dcn351_hw_sequencer_construct(struct dc *dc);
+
+#endif /* __DC_DCN351_INIT_H__ */
-- 
2.42.0

