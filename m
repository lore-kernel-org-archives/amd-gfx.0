Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB336C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92FDE10F3A0;
	Sat, 16 Jul 2022 14:35:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49AA10E2F8
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTqK+OMajtiBL3uJHPTBq39KO4X5d4uGRP7Sum/ovrZAWPnIAr+mb1jjWip0CygFdbsM1M6YpVDqonOPnb0rFtbRIyaxKhoAjekPuCP6qq3KX+TxrHDS7G5VsjoE5APSPRGvFWIn1exYFmj/CH8zrTq1SGgBtrVSVgoj+tvLZaoyYs81bl6y3TwPYJuyCf4T0ctzxCFLRUd5rBUuiJPQg3eRFSVpKcP8qp5U1BIo6Vh/MtIPP2u0UFUeLF3zUomWVUWSrUkOYdgjzl1dAvvX51bfj+Fadj2HV+B1kOmYYRAKuUfhu9UYujalKTZvk4W6r0H+VIg+QIIFWh5w8ZgWtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYXd/0NVjNDsNzxEnlyof2rM8kdD+u5k8C/P6zTmU/o=;
 b=cLC4x9ai/zQdVelwFuuY4xaxGkx8BYnY+I2JhB/TRavJN+IAkdDyKqwzAzonzm1r02v1Z5yMGK4D3xA8CAgzfN4HS56AZbP0n2Op1QYHrVQrjXF+7YLPzce3cZFcSzRepksrc5/gnAK0pV8eMgTVUAtjPzoNNXMdnQ5qfdomq3LPc9kq30KPNlYcxyHUrCP8ucYPFM00DHv4YuP9cvruL12z24rhZ4WjlLO8qkR6Q1fPNrU3zI1OEAqlOJNdXW/LVTcxtJsphQnASAXj1YsPSTQjItVf1gK1Q7PM+02DxPXBz5Ph9fl96Urb8aDY6fjER6QXUlTpQjSCABUE/vfCbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYXd/0NVjNDsNzxEnlyof2rM8kdD+u5k8C/P6zTmU/o=;
 b=tjLFNH2eRIdlWRJ7Y38MJmUQcmvZG1QKZd8TsqW2sGBup34qPmYOeWnhXL62TAKyThnTmdjAvsYqwVoRgAxE7mtd0UC+KmTilEMDx6TZVxnjnsz6br/bNmDJuZw7OL2cxtddm0QqKYWMmEW0TnbkKQPH2ogpzdjO5p8pOkVNSqg=
Received: from DS7PR03CA0174.namprd03.prod.outlook.com (2603:10b6:5:3b2::29)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 18:17:09 +0000
Received: from DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::66) by DS7PR03CA0174.outlook.office365.com
 (2603:10b6:5:3b2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT048.mail.protection.outlook.com (10.13.173.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:09 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:08 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:02 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/31] drm/amd/display: Support vertical interrupt 0 for all
 dcn ASIC
Date: Fri, 15 Jul 2022 14:16:35 -0400
Message-ID: <20220715181705.1030401-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bf4cc13-0c89-4afb-3bdf-08da668e3b4c
X-MS-TrafficTypeDiagnostic: CH2PR12MB4183:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ph1Kjhtr85h4jmiOj4MJFX04HN39zlLmvhyL1xoIrx1LXSGsxp26kHfZdAwiqgF0KnXXdBboIpDciTLc3wWzGkhswbZir3PW430RJytchP3TA46otPvmx/wUWDzXky/SdTAHMJ0q/KR+oBGVLrD1ZJ8o6hbv1TkxvyxiDVI1bNrSfnmyBjL6qHJGO59Vm2vUqUocLVZs8zx87e+vPcxLLWzaqPdq1jYa70lmiGBEpWR+oynzvdow3LJxOXtGdwx+6P9jsTech+uvpJXrAgpEfIQiouCFSW2kyeSvmisBZ1or2928NdyAIs6Tn0HwgFCYM1xR4xVGHgZB7AyLUkDWCdZPCgMnWNeK3pyF49X+572CHueEjUSTXTpuJbukwwPtxfR6BNMxeij8hTWKY4zzMwPhBwoedUNg8qYS9GGDTcMB4+atykajK/tnD6HlAiNp6ZgJakXfk/GZor1lgmgxjRjtxZ2VDS0wV8hrfNgEWCet64OIVIU8kQrgAOoAlWBIo6xdelY8mu+iDElOC+hOvksc7WseCdCWB68897tN8gm8jiWvuke3RI0duuyObXoR6snM0J0Sp+OItVlR+hGDU8NYcwjPt1ClvkvqEwpAb4I1ayBaqAJHHoQG7f0jfH5nOYQZp+b3yxY86W+I/ym0uxdYPLp7bHmIBBuhCJ2fDtmWOEH4IqqOiZQ4sUH4wV3t2RyPPHezH3aa69uNS26v92rCjAoWUtt5gT4vKhghm4+WHmzRZNzvzzT2Vpflv42GwT4fex4HVyOghxBTeM3o+QB+nk+9mHDGq61FYRgd61gNVT4QZt2KDQL1uHKkFufg78i5aZ93HguURCsnSEm20jZkgP9DwfnhkP1YPB+pvBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(40470700004)(46966006)(36840700001)(26005)(6666004)(41300700001)(82310400005)(86362001)(6916009)(54906003)(36860700001)(316002)(40460700003)(478600001)(356005)(5660300002)(426003)(1076003)(82740400003)(2616005)(186003)(83380400001)(47076005)(70586007)(81166007)(336012)(40480700001)(8936002)(36756003)(2906002)(8676002)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:09.1650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bf4cc13-0c89-4afb-3bdf-08da668e3b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
When CONFIG_DRM_AMD_SECURE_DISPLAY is enabled, it will try
to register vertical interrupt 0 for specific task.

Currently, only dcn10 have defined relevant info for vertical interrupt
0. If we enable CONFIG_DRM_AMD_SECURE_DISPLAY for other dcn ASIC, will
get DC_IRQ_SOURCE_INVALID while calling dc_interrupt_to_irq_source() and
cause pointer errors.

[How]
Add support of vertical interrupt 0 for all dcn ASIC.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../display/dc/irq/dcn30/irq_service_dcn30.c  | 14 +++++++-------
 .../dc/irq/dcn303/irq_service_dcn303.c        | 19 +++++++++++++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
index 146cd1819912..2aa74ee1502a 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
@@ -289,6 +289,13 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
+#define dmub_trace_int_entry()\
+	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
+		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
+			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
+		.funcs = &dmub_trace_irq_info_funcs\
+	}
+
 #define vline0_int_entry(reg_num)\
 	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
 		IRQ_REG_ENTRY(OTG, reg_num,\
@@ -297,13 +304,6 @@ static const struct irq_source_info_funcs vline0_irq_info_funcs = {
 		.funcs = &vline0_irq_info_funcs\
 	}
 
-#define dmub_trace_int_entry()\
-	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] = {\
-		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
-			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
-		.funcs = &dmub_trace_irq_info_funcs\
-	}
-
 #define dummy_irq_entry() \
 	{\
 		.funcs = &dummy_irq_info_funcs\
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
index 66e60762388e..1d149d290147 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn303/irq_service_dcn303.c
@@ -24,6 +24,10 @@ static enum dc_irq_source to_dal_irq_source_dcn303(struct irq_service *irq_servi
 		return DC_IRQ_SOURCE_VBLANK1;
 	case DCN_1_0__SRCID__DC_D2_OTG_VSTARTUP:
 		return DC_IRQ_SOURCE_VBLANK2;
+	case DCN_1_0__SRCID__OTG1_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC1_VLINE0;
+	case DCN_1_0__SRCID__OTG2_VERTICAL_INTERRUPT0_CONTROL:
+		return DC_IRQ_SOURCE_DC2_VLINE0;
 	case DCN_1_0__SRCID__HUBP0_FLIP_INTERRUPT:
 		return DC_IRQ_SOURCE_PFLIP1;
 	case DCN_1_0__SRCID__HUBP1_FLIP_INTERRUPT:
@@ -96,6 +100,11 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.ack = NULL
 };
 
+static const struct irq_source_info_funcs vline0_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DCN_BASE__INST0_SEG ## seg
 
@@ -164,6 +173,14 @@ static const struct irq_source_info_funcs vblank_irq_info_funcs = {
 		.funcs = &vblank_irq_info_funcs\
 	}
 
+#define vline0_int_entry(reg_num)\
+	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] = {\
+		IRQ_REG_ENTRY(OTG, reg_num,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_INT_ENABLE,\
+			OTG_VERTICAL_INTERRUPT0_CONTROL, OTG_VERTICAL_INTERRUPT0_CLEAR),\
+		.funcs = &vline0_irq_info_funcs\
+	}
+
 #define dummy_irq_entry() { .funcs = &dummy_irq_info_funcs }
 
 #define i2c_int_entry(reg_num) \
@@ -236,6 +253,8 @@ static const struct irq_source_info irq_source_info_dcn303[DAL_IRQ_SOURCES_NUMBE
 		vupdate_no_lock_int_entry(1),
 		vblank_int_entry(0),
 		vblank_int_entry(1),
+		vline0_int_entry(0),
+		vline0_int_entry(1),
 };
 
 static const struct irq_service_funcs irq_service_funcs_dcn303 = {
-- 
2.37.0

