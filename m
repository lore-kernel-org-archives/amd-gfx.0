Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76BC7ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B65810E7DF;
	Wed, 14 Sep 2022 03:26:07 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8CE510E7DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmRo7rjvYgdlpWcsKYkJhLd7Ud9A5oW4o5Ahw1A4ehdViAVtYpiK9wjAd5rrRJDgd9OxogbyJe4LDYIOISAQaTordh7Po6xAciJPo9eX1tudgr617/l82nmgYJnjHP6akFDPZKtD80woCuTcrD+SCbfQJvLUefvgvA286y78JayX8ECtmTGkAV7zBDwzR4lGDYEvybILyWptV5ebJc7/ftrfIuaLRqsaOoigqNeuuViz5g2XTpLfzy4kKXPzPmLoFhOp124Oq60adRylTy1UeKguAZK0KH7xCr7Rl1i2ge6WOcUejDCduR1z7iyZSScvPvun0rlnh3e0/3LSm38L5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z43r3GQmq04E+JSa1GafTxTNRMX5ifOP2hMGZFaFQBI=;
 b=lBKrhlFBniAbqbNiFExFjqQC0xAbXM4T+S3VLLo++Uh3y7m9R+xgPcfotN4TxCn29QDa9jLVlnlINk2pd3XJGE1XycRVZAlrWrN5Z/X+YEkSPzBjDCe8lm/08MDzUwpEsGY/pqR05MF90PVoD3YUDL1PheMnJjtzeb7QPomZH5GppU112yd1PcRTFjRXqhIDsz5sFNUebW4oP820at/qOFN540Qb8z41l/D2LU/sLEW1+E2YsBlAVw6V9fPFUb81OO54g8ZVRx8R/OTnryieWrlyuaPOzxf4Q43PY0dHIaNFnr+KcBrXzT4IcffMtRoIt1KKukbK0SpgaizmOYRG4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z43r3GQmq04E+JSa1GafTxTNRMX5ifOP2hMGZFaFQBI=;
 b=CVy5fj3/GDUYPJ2pieblFVuPaW/hVWM/bkD6YnR8ZVwe0CkHW5ak2FM6TqhniyYSmatY/fDvOt3ySS5AIgYGWNMDuS2orIG5zSssTu0k0EWDihuD/vhR1xq5+/GRpowu/VoSUQbYmvyHb8AWoCjWT8Uom0t8VpH/x6pdZ546gbA=
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:26:00 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::d8) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:26:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:25:59 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:25:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:25:54 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:25:45 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/47] drm/amd/display: Remove some unused definitions from
 DCN32/321
Date: Wed, 14 Sep 2022 11:23:56 +0800
Message-ID: <20220914032441.1075031-3-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a76bb68-ffd4-448e-efc3-08da9600d84f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gXhESYZTfckrpZubtuO3lB/1nAb3hzQpQwHqrjTIoWJPQzwtkDCw92YxxQXt2GjdiflPfowMp7v3lUVEx7GqhsV+DJNLYtUG31nkW9mn9wcrvBpkQ/2A0YE+R84u/AqVB3/lSlNryTpeYAeV4ZD0WeW3W9Ctc+J+kBxl22iA9PhwuDk2Lwoi7PcqCgD/Gq0QwT+HJaS0vL0ZtLAsMYaL3XadduLvkWOOXh1cQXxU1GU5dzGIfYU5xgNM/j/JCaVxnMOT6LvIZX2NzvmvUS+aJNDLIV4E7kaaTQ16u5PTLQU0+W+T2GiWIM4pSrUdGCN7Gi0To0SqWLIWtdoNwYgRx4CuNab5rVSD43sNF3NlrcKKauk8L66J1pHcg1eDSPjy0fTHieuEbTQeLwENzPoUzwHgj7cSVt868AN+tJQnjCpvmDyzRgb/OwAVnMJBRH7+Uo+og2djtX4Z1UCQKF49XQS/Lmr9e+vAyvBL9S9fM9wCBI1JJWvh2cn3LkTF+oPLCebUzG55C3tnh/pPg2H7d6d+ppPEtLGhTcGUek3zQTWX24Pl5cW09YmZ6EwKGrIDrzXb0z1P55WUIuLbDadmSTaunjTm1jVV4Hpuoat+bPjQA96pwzlfm9pvZp+agHsgOTalTlxVgy2NQWs4SXSSoVk9rD4WwoPeuXjb2+xc44Yv255tcj9z7pC3/haaQ8iFgB9Add05TrzbNgvaHYRDYtLqtn7rXcaNRZ0VNtwvWVDKNidtIzGf39W3/MHqc5KRUu4ool3boT/H3H9WtHMyzQXmKhCOIP0G+y7vKEUOnjTgw8kfNS9yLOIOSImXIPFD
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(426003)(40480700001)(7696005)(40460700003)(82740400003)(41300700001)(8676002)(36756003)(83380400001)(47076005)(86362001)(336012)(36860700001)(2906002)(8936002)(82310400005)(478600001)(5660300002)(26005)(356005)(4326008)(70206006)(6666004)(186003)(70586007)(316002)(54906003)(81166007)(1076003)(6916009)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:25:59.8692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a76bb68-ffd4-448e-efc3-08da9600d84f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
After reg offset initialization was switched to runtime rather than
compile time, some of the defintions are not needed anymore and can
be removed.

Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 23 -----------------
 .../amd/display/dc/dcn321/dcn321_resource.c   | 25 -------------------
 2 files changed, 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 11f1435b8c07..e0038d576aeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -90,29 +90,6 @@
 #include "dcn20/dcn20_vmid.h"
 #include "dml/dcn32/dcn32_fpu.h"
 
-#define DCN_BASE__INST0_SEG1                       0x000000C0
-#define DCN_BASE__INST0_SEG2                       0x000034C0
-#define DCN_BASE__INST0_SEG3                       0x00009000
-#define NBIO_BASE__INST0_SEG1                      0x00000014
-
-#define MAX_INSTANCE                                        6
-#define MAX_SEGMENT                                         6
-
-struct IP_BASE_INSTANCE {
-	unsigned int segment[MAX_SEGMENT];
-};
-
-struct IP_BASE {
-	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
-
-static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } } } };
-
 #define DC_LOGGER_INIT(logger)
 
 enum dcn32_clk_src_array_id {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 1bbc0bdf5dc3..60bf6e1b2972 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -93,31 +93,6 @@
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
 
-#define DCN_BASE__INST0_SEG1                       0x000000C0
-#define DCN_BASE__INST0_SEG2                       0x000034C0
-#define DCN_BASE__INST0_SEG3                       0x00009000
-#define NBIO_BASE__INST0_SEG1                      0x00000014
-
-#define MAX_INSTANCE                                        8
-#define MAX_SEGMENT                                         6
-
-struct IP_BASE_INSTANCE {
-	unsigned int segment[MAX_SEGMENT];
-};
-
-struct IP_BASE {
-	struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
-};
-
-static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } },
-					{ { 0, 0, 0, 0, 0, 0 } } } };
-
 #define DC_LOGGER_INIT(logger)
 #define fixed16_to_double(x) (((double)x) / ((double) (1 << 16)))
 #define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
-- 
2.37.3

