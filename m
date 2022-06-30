Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81542C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09DFE12A699;
	Thu, 30 Jun 2022 19:14:28 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C9110EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0UQmKhTqLGpAuvfBxdTrT+1ooIJiISRH0tU1VrglEXKhtlF9NPzJu14rbkWVLgNPQwi8xseX44Zin+Z/5B1hGBOle71lEMkhIC3Ki8BT81X7pfTjJadasOJwyxxUkZycvyS03LsEFkb49yUhoa6zxfe/g5KGZ3VZdNYn1fpv93f+bZXVtt161hwSaTKWEKPjAJPIXKWPuptHuL6cEqk25zjLd/sAteI0XgVccTJ47/WzcFHl5YVMHaX7ax4HGDBqT5+FmkqLqJim1hZdEnM/y4b58tWMx9LM6cm9+fDxJiFmcWBogsV8qZLdLOCy4wk/Ac83AIbvgKPbjgTLlXAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akd0KWcR9oqXeB8EjTrmEIv+uS3+HDdpr8qJdhVEpTE=;
 b=YQyeLvVuOalc1emUUmV6mpEQkhhs9oNCFHs2VBsxKqIrx+csEcJ1RujE2XsrEIOfK2WgntqVwrhEgcb9kguUQjYIunEhP13ojXH4yMojV7OsZtq09MgcS6MDu3aiP+M4kgyOvNMf5fKeMBGmZHY0uk6a1iGWh5OIXWU/RR+uzpG/gm3B3IEZAcwHW1WhG0vMidyC5w3ceLqcD6A4AB77Y/7VOzo2qJotCo5sbzB40m7CofmGiS8Xuw0UK5uL1hBN9Up2Gle93jUsTfrnTpkmAfKaY8WvRie7b0z+I0tlxh90273zc8MrFukv1xHt1invhm1gQPcGKndYmRxM7vUBqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akd0KWcR9oqXeB8EjTrmEIv+uS3+HDdpr8qJdhVEpTE=;
 b=NV1SPf5jQeuRnynSBx6SIhavhKhVCQGsYnjRL0dCwl4xnfQRl0H7Vbi9NgeiCjaRquh2r+SC4aSPOvfvY3ribCUlzg0JMc6tG1QBIYptemA+Tc2bT5Zo5Q7UlXaqWZwX+TJxGrQsUH4wC3tGwSdI40RGRJd1XtWLLV1zIeLRXEc=
Received: from BN9PR03CA0441.namprd03.prod.outlook.com (2603:10b6:408:113::26)
 by CH2PR12MB4837.namprd12.prod.outlook.com (2603:10b6:610:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 30 Jun
 2022 19:14:23 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::15) by BN9PR03CA0441.outlook.office365.com
 (2603:10b6:408:113::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.17 via Frontend Transport; Thu, 30 Jun 2022 19:14:23 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:21 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 33/40] drm/amd/display: Move all linux includes into OS types
Date: Thu, 30 Jun 2022 15:13:15 -0400
Message-ID: <20220630191322.909650-34-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e571cb22-84a2-4aab-349e-08da5accbde2
X-MS-TrafficTypeDiagnostic: CH2PR12MB4837:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOzkBcnJrNjvRVC9htk9RaYJzan240v/cAuMn1B7vuOV46Ohd59P6IkBO8CTREL337qLtmHNi+S9v7MZY8zDzoEehm+zM9aqt413qB8GGlrvDVwdbQN8zDE9EYWM63g5bW8reBHs3TFqHHdZ7/G/j6jq/mmUnrxDoqaeYVbvqR1WwJ3oGsf9AzkOio2MNT4UFF3/77pw2WpCdX+5AArxDt71eOyzmcakTk2FDrVcRFBqz//MQ2P+f64Rf8bWi86Yt8E8l8ve/x1JGa5bLFVUUA4mDUOHqiFNe0m+o7dmSdkLyToJKaWqVjrvdN5V0+tlR5T/8vgvWM/uhMWKuKQy37ugock9EDm+HMdlL6smv2mm8mO0CzNDAUR+xsC7dz10d/WMnFL6IoRi/EgYOSV90C5aPXiaJ+ujMQeJdrc3YQZQVHEYFD5gxkvEVCQNij/iWav4oaeFCaYo5OIsuRZ6z6zveCqrsR6naScK046UbCK2JwI2RCNdBcTWYiGkIFWknRQ2CEHV1ZijDV374lfIDzDt0xLtpNodTwFV6rQMGr3jx+F+FfpMIStX4i8yGvW3tbFFYKSGODns3EL2nQhCjuGkKh/S3kg/AoQ9A6MVLHxDA6KDxY4Ef60/rygScR2exmB4zOpglOBAps86SwdPdYsJLGaM+jGDEy7cjzNRROnOX4TUMYdfXmeTao3CMonsVZ1j2p3OJZV/Qlp/YwwcVDKnAD+PfFFqDgXjBoGL6sSDKETp0VCs7BQ9GnSM+CK9XD059nwa+AgHAag21d1kS1umJEdu+GdPp4KwzHwXl+RxQdqzY5UdNVFiZBUp5Css3c+56AwVZSoEud6ydLeg4oHo5PbOJ4BDJ1RfS4jWx50=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(396003)(136003)(36840700001)(46966006)(40470700004)(8936002)(30864003)(81166007)(5660300002)(478600001)(82740400003)(6916009)(54906003)(86362001)(316002)(40460700003)(356005)(70586007)(70206006)(4326008)(8676002)(426003)(36860700001)(336012)(47076005)(83380400001)(1076003)(2616005)(16526019)(26005)(186003)(2906002)(82310400005)(41300700001)(6666004)(7696005)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:23.1268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e571cb22-84a2-4aab-349e-08da5accbde2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4837
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry Wentland <harry.wentland@amd.com>, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Harry Wentland <harry.wentland@amd.com>

Move all linux includes into OS types.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/dc/basics/vector.c               | 2 --
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c           | 2 --
 drivers/gpu/drm/amd/display/dc/core/dc.c                     | 3 ---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c        | 2 --
 drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c            | 2 --
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c            | 2 --
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c                | 2 --
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c              | 3 ---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c             | 2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_audio.c               | 2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c                 | 3 ---
 drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c        | 2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c                | 3 ---
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c              | 2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c                 | 2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c        | 3 ---
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c                 | 2 --
 drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c      | 2 --
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c      | 2 --
 drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c    | 3 ---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 2 --
 drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c | 2 --
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c      | 2 --
 drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c   | 2 --
 drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c    | 3 ---
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c      | 2 --
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c      | 2 --
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c        | 2 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c          | 2 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c             | 2 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c    | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c             | 2 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c        | 2 --
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c  | 2 --
 drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c              | 2 --
 drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c           | 2 --
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c                 | 3 ---
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c             | 2 --
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c                 | 2 --
 .../gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c   | 2 --
 .../gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c   | 2 --
 drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c | 2 --
 drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c | 2 --
 drivers/gpu/drm/amd/display/dc/irq/irq_service.c             | 2 --
 drivers/gpu/drm/amd/display/dc/os_types.h                    | 5 ++++-
 .../gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c    | 2 --
 .../gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c  | 2 --
 drivers/gpu/drm/amd/display/modules/color/color_gamma.c      | 3 ---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c      | 2 --
 49 files changed, 4 insertions(+), 107 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/vector.c b/drivers/gpu/drm/amd/display/dc/basics/vector.c
index 706c803c4d3b..84aeccf36b4b 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/vector.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/vector.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "include/vector.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
index 25791ed0559d..c332650b7048 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "ObjectID.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 8ed208e5def2..89a2f6749239 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -22,9 +22,6 @@
  * Authors: AMD
  */
 
-#include <linux/slab.h>
-#include <linux/mm.h>
-
 #include "dm_services.h"
 
 #include "dc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 9039fb134db5..2a8007928210 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dm_services.h"
 #include "core_types.h"
 #include "timing_generator.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
index 2b09310965bc..b13a516ba0f2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dm_helpers.h"
 #include "gpio_service_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f7b47bf3ee59..85cbea4dbf72 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "resource.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
index 4b5e4d8e7735..455fa5dd1420 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_sink.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dm_helpers.h"
 #include "core_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 167bb3310877..6752ca44e6e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "basics/dc_common.h"
 #include "dc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index 5bc6ff2fa73e..a80e45300783 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/mm.h>
-
 /* DC interface (public) */
 #include "dm_services.h"
 #include "dc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index c06888add4a0..eb5a7fe88971 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "reg_helper.h"
 #include "dce_audio.h"
 #include "dce/dce_11_0_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
index 49d3145ae8fb..919c2c2ba84b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_aux.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "core_types.h"
 #include "dce_aux.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index 4b57657b5322..5cc7cc0b2f2d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
index 7183ac5780a4..fbb19e253f50 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "core_types.h"
 #include "link_encoder.h"
 #include "dce_dmcu.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
index 6846afd83701..f1aeb6d1967c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c_sw.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dce_i2c.h"
 #include "dce_i2c_sw.h"
 #include "include/gpio_service_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
index 80569a2734eb..34bff9aef66c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dce_ipp.h"
 #include "reg_helper.h"
 #include "dm_services.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 0bc41414481e..09260c23c3bd 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "reg_helper.h"
 
 #include "core_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index 895b015b02e8..63ae4bc2a2e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "basics/conversion.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index f7e1027d4b3a..f810825322ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dc_bios_types.h"
 #include "dce_stream_encoder.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index 635ef0e7c782..9ad8ad4550d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "link_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
index 44564a4742b5..d241ee13b293 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_compressor.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "dce/dce_11_0_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 8662703f306c..76e1e0966064 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dm_services.h"
 #include "dc.h"
 #include "dc_bios_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c
index 34c5e3c7c6d2..9b65b77e8823 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_opp_regamma_v.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dm_services.h"
 
 /* include DCE11 register header files */
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index ef56eab4e5da..41804059550f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "link_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
index 45bca0db5e5e..28d3b2663cd3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_transform_v.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dce110_transform_v.h"
 #include "dm_services.h"
 #include "dc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
index 51cb45d8b9ab..faae12cf7968 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_compressor.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "dce/dce_11_2_d.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index 560da6cbcaa3..62da6bc3094d 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "link_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index c65e4d125c8e..c4353a03b48a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -24,8 +24,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 725d92e40cd3..0c3695e79652 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dce/dce_8_0_d.h"
 #include "dce/dce_8_0_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index 80595d7f060c..0f746bb4e500 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dm_services.h"
 #include "dcn10_hubp.h"
 #include "dcn10_hubbub.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c
index f05371c1fc36..24b68337d76e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_ipp.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dcn10_ipp.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
index ca39361f71c8..fbccb7263ad2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_link_encoder.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "reg_helper.h"
 
 #include "core_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
index 2c409356f512..41cec7acf51f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_opp.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dcn10_opp.h"
 #include "reg_helper.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index bca049b2f867..e75be799012e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index 64640c6b1c45..c99c6fababa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-
 #include "dm_services.h"
 #include "dc_bios_types.h"
 #include "dcn10_stream_encoder.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
index dac427b68fd7..8183cdf517b8 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_base.c
@@ -27,8 +27,6 @@
  * Pre-requisites: headers required by header of this unit
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/gpio_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
index 778c206f754d..3ede6e02c3a7 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/gpio_service.c
@@ -27,8 +27,6 @@
  * Pre-requisites: headers required by header of this unit
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "include/gpio_interface.h"
 #include "include/gpio_service_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
index 7a8cec2d7a90..6fd38cdd68c0 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/delay.h>
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/gpio_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 9756640411b9..5c419225c3d6 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
index 692f29de7797..1489fdfaf0e7 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/gpio_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
index 6b5fedd9ace0..44649db5f3e3 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce110/irq_service_dce110.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/logger_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c b/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
index 2fe4703395f3..0a5e1a2a3c61 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce120/irq_service_dce120.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/logger_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c b/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
index 17e426b80a00..85f63b4a8b90 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dce80/irq_service_dce80.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/logger_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
index cf072e2347d3..532e506d027b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn10/irq_service_dcn10.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/logger_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
index cb38d4c527d4..7bad39bba86b 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/irq_service.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 
 #include "include/irq_service_interface.h"
diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h b/drivers/gpu/drm/amd/display/dc/os_types.h
index 5df1d80c8341..cd4af87ca58c 100644
--- a/drivers/gpu/drm/amd/display/dc/os_types.h
+++ b/drivers/gpu/drm/amd/display/dc/os_types.h
@@ -27,17 +27,20 @@
 #ifndef _OS_TYPES_H_
 #define _OS_TYPES_H_
 
+#include <linux/slab.h>
 #include <linux/kgdb.h>
 #include <linux/kref.h>
 #include <linux/types.h>
-#include <linux/slab.h>
 #include <linux/delay.h>
+#include <linux/mm.h>
 
 #include <asm/byteorder.h>
 
 #include <drm/drm_print.h>
 #include <drm/drm_dp_helper.h>
 
+#include <drm/drm_print.h>
+
 #include "cgs_common.h"
 
 #if defined(__BIG_ENDIAN) && !defined(BIGENDIAN_CPU)
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
index df8bc44bc4be..1d226e0519a5 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_link_encoder.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dm_services_types.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index 1e39aae6b1cf..ad088d70e189 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "virtual_stream_encoder.h"
 
diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
index 64a38f08f497..859ffd8725c5 100644
--- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
+++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
@@ -23,9 +23,6 @@
  *
  */
 
-#include <linux/mm.h>
-#include <linux/slab.h>
-
 #include "dc.h"
 #include "opp.h"
 #include "color_gamma.h"
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 0686223034de..da09ba7589f7 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -23,8 +23,6 @@
  *
  */
 
-#include <linux/slab.h>
-
 #include "dm_services.h"
 #include "dc.h"
 #include "mod_freesync.h"
-- 
2.25.1

