Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A02C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 13:56:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15429360A;
	Tue, 12 Jul 2022 13:56:00 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7347A93707
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 13:55:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6qwEcKZuiOoY24YKVcdhfg74JMKE9G7B4MHAdqS/+8gxPnzlaipuogah7nVR7n3/ddSu5d8e/fFwd5FWcLdo8d42cH/F9THjHhWGXsrmC0iaX60iS0Nn//Wy51lNfGsaiM69sr7+07IReDSU/ekuIgp+3uNn93iOrHF22/zi5smMod7t2FsfgcKuhyNCk7dB2Ikh2lWBt1PkPCZjh+2spFx3kpcFez0zJQ3TJqp97QaoDkTQia6RUwhrhbo/rCOOfU6QEYGpk2irrZCkU4BefNaXELFiRtfiPaUsLtoKYTBo5hfj4iPlfSj7BmzV/lT99ceTQCl/DmxKOO/HIiHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXd2gnsuYuvEu4Rya5aumendzm79pNoHqxwclSzONWg=;
 b=AbbHBBcUvZkV78fuczoQHKncAW0/fTiQE5C2pE0QhSpE5bYu9OJmR4yhe3Q0V3H7CEASuLOMiCEpX4fvi21cAHcvts4/L5WIVyeli+BmYL7LvcNmweFNXXSkxRMV/zv8pYu8gGQC51JfZLnWUzAl6sEXdRniz1TYP/cKIOtgoshUA0iuX6iO9swoxRT79l3ZOVIke4nqHystz8mbk18V0vmxcaF+gpMnDhxJsJ8MTTqOUmPMykZd2rYBZpgqlVGqYHusrpBvxfqaRPEWpFx5snmFQ/KKSPMQ7KdaFVLFRJ2Jiw0mB/76WF46/9bAN+Vjey3ayWGKDE+V23w1v14hHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXd2gnsuYuvEu4Rya5aumendzm79pNoHqxwclSzONWg=;
 b=PZgL04zteA5QhltYqP570glbIczVc+UwQtNKiK/MvVHtxr/bHIlOs79ZU/+gq0NEkj4RL8X7Vyo7Ap5vfYSfhpnBF98/ZmtiKZEZdqyhrFwvWutWA8E+PP6S51STrawhHfSOXIIqvgitRGI8iwlENkWSIRK7gbGr/liwobTV+yg=
Received: from BN9PR03CA0384.namprd03.prod.outlook.com (2603:10b6:408:f7::29)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Tue, 12 Jul
 2022 13:55:56 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::75) by BN9PR03CA0384.outlook.office365.com
 (2603:10b6:408:f7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Tue, 12 Jul 2022 13:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Tue, 12 Jul 2022 13:55:55 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 12 Jul
 2022 08:55:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: remove duplicate dcn314 includes
Date: Tue, 12 Jul 2022 09:55:43 -0400
Message-ID: <20220712135543.2639877-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47398997-1ac4-42a4-7ae5-08da640e3e0a
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lhv2VGOeECalUQ2O3P0I7dV6nEw6Ue13y20jkvT4rQURJe31dAsj0EIJOjPuqiCh0c4tURbKA4SuVsLaQOksjVcYairwB9VYr+mEbkNIXQ7ywxmvjgCPCDpn10JBShtUVX06hzGt2BjwXhY8Eww8FIEBfvmhn3IDupNc9jPHo+6PEP9jSZnh3Dgw38IbsIJDWrZiT/UVLiyKgbOKL6PlCKHF7v81Wzx4O/2RTTgsBuTLS0TPEqeOaf5ANc1Roj14lwK38X/sOxjqtwSSSNe7PofrTczGVgP1CFBoP5XMeLRMjtW9b2S4NRQp8M2OhGESVjgTqP16IymbdPrKVc4kDhJYLsEaPoSwMkN95IHkC2BRNzoTbIXfXi3TBxqysfuu35biL/JJrFaTES1L9aobrw4Y7Y2wKTZLn6yrT4d3ee3GQrSGDsoTUlL7HHttk7wlY1SS7gIBU2exMmuFUXO+mHZUVJcD85OFlyN5X1h2qDjgNfsan1eOd8BFfej4odxMfhKLDlPxIlkGg6qbFuqKQ9qr/CVHVVCMy87hHcmWq1XtOu9TCVwaLEjLEkwRbw5IAI+TjreOeNfZCMKzzWwXOJFiKt0gRVziznTxPfB8B1pbQAdzmDIZmccuodilF+rUlV3GiKEtYcoyJcWLn4gF2KO3k/ErtT0l8kvfyUOqcw8w2yxDwJGWx4ln1duhEHzufoHLXgk2eL46gNIhzb3JAIfCtNrzkTcwtoTRGOVQSu0CHG7nxk93iUXzDPYCmvV/kyytCBCqys3QoSO75CFg74oegvAeXcztgtAhmLlIDJXElYUw9yVLgKdZV7bQRlu3yjSubT3s+fhH3D7pI/6Ycjva1miogGDUxWiQOZPgilM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966006)(36840700001)(40470700004)(86362001)(41300700001)(7696005)(26005)(6666004)(478600001)(40460700003)(82310400005)(2906002)(6916009)(8676002)(2616005)(1076003)(8936002)(82740400003)(36860700001)(5660300002)(40480700001)(70206006)(186003)(336012)(81166007)(16526019)(426003)(316002)(70586007)(83380400001)(36756003)(4326008)(54906003)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 13:55:55.8759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47398997-1ac4-42a4-7ae5-08da640e3e0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 kernel test robot <yujie.liu@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Several headers were included twice.  Fix that.

Reported-by: kernel test robot <yujie.liu@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c    | 1 -
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c     | 1 -
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index a0c132666b5f..90ec76487264 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -34,7 +34,6 @@
 #include "clk_mgr.h"
 #include "reg_helper.h"
 #include "abm.h"
-#include "clk_mgr.h"
 #include "hubp.h"
 #include "dchubbub.h"
 #include "timing_generator.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
index 4ed6e24b8231..c4a5f8198209 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c
@@ -25,7 +25,6 @@
  */
 
 #include "dcn314_optc.h"
-#include "dcn314_optc.h"
 
 #include "dcn30/dcn30_optc.h"
 #include "dcn31/dcn31_optc.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 053a06b2fff9..ba371769dc3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -60,7 +60,6 @@
 #include "dcn31/dcn31_hpo_dp_stream_encoder.h"
 #include "dcn31/dcn31_hpo_dp_link_encoder.h"
 #include "dcn31/dcn31_apg.h"
-#include "dcn31/dcn31_dio_link_encoder.h"
 #include "dcn31/dcn31_vpg.h"
 #include "dcn31/dcn31_afmt.h"
 #include "dce/dce_clock_source.h"
-- 
2.35.3

