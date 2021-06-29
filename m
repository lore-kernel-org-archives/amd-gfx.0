Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09396C11F69
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D006461D7B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D006461D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5B26E8BC;
	Tue, 29 Jun 2021 15:55:08 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F13889F8B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:55:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZDBpTgVjd6mbbE0ZtsjxVQ4qpqVcUiz8Dof18Xsqtu6eYGcViK8+AbJOeq+0prf3sD2fYY1ds1ZW6fikAC2097zHlKWssbDEYPmNPBEU8tV8t0bMk9OTkfLsoJs5dlSzsF4BOjQZGfpo4z4ME0X3zEMMNEUWJTnPwDf0ENUvOyAE/jHMQr82ITIi5YEZ+hjjXtMzrKm/K8v2P9FGx5OOgDmydJpTv5XwDrwMMRU7Z3HUPewROVl9zuLWJIAkmCFEYKQhCubGYHi2wvBvEl4knPjPtU76af2k26NsQBRab5o7rd9ACNuBMrpiuBNL9JzXNEgWNSF1McboZ9h76J9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sakb9UhBNW0D3UnCuL6QDx3oiLCdOXpD6cDRetz+9io=;
 b=FRjxLbwpc79TnjxHk6+SUTlRzMXfGyWhZia26GswrM74sKZSDwNAT4czngtQEbY4ue8NleustfSpa8uAPHfZpJau8diOv7ot8vKpVhdrfQYAQmaPQXLVOhXpYo0itHsXD/YanlIFs3oTYRXOjBT/KXP1WuRDKaxX1Ucv/MzLCRcWjbsMFf9d7ts0ddw1PG+wxMJSA6LAI/HqXlW5p3fbJBklOXXS4MQeJiHZWOxPClvu2Ur5/FbUi4zCulreybxlPbN5ycvzllG0jM/lPFJ7yG6spwmbqn0Zdi/js3Tu/Baft4kgAcmWg83+vGaCSTVrfbjYq9YhEs9XQk3b4nla5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sakb9UhBNW0D3UnCuL6QDx3oiLCdOXpD6cDRetz+9io=;
 b=F5rxck1JHFVNlTyKhBRaoG8IwUlnd+vgyAtrR/ZwD8XNmOCQ7dylccTQrCfH+X0BGFizLjnjw5XajFSV3duUsPfvuXosVWLKyCJl+lwO8maUTb9xlx091lrzQpCTLSzvOD9UhVg8AXDPDTFTlRSc7Iuiv+vTSrY6iB8AjeBuDwc=
Received: from DM5PR15CA0036.namprd15.prod.outlook.com (2603:10b6:4:4b::22) by
 MN2PR12MB4191.namprd12.prod.outlook.com (2603:10b6:208:1d3::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18; Tue, 29 Jun 2021 15:54:59 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::cf) by DM5PR15CA0036.outlook.office365.com
 (2603:10b6:4:4b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 29 Jun 2021 15:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 15:54:59 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 29 Jun
 2021 10:54:56 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: [FW Promotion] Release 0.0.72
Date: Tue, 29 Jun 2021 11:54:19 -0400
Message-ID: <20210629155422.26118-10-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
References: <20210629155422.26118-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fb09f87-791f-443a-9402-08d93b163faf
X-MS-TrafficTypeDiagnostic: MN2PR12MB4191:
X-Microsoft-Antispam-PRVS: <MN2PR12MB41910DB9FB0A2B076C98C7D498029@MN2PR12MB4191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IhnG8vuECBPOFfY+3lR0i56u2re6kF+c+yQSVzHJFu8L4Hd8hF8n8iIWMrke9GSUun0whIBhUOVUTYxg15OQPRV5kjCHBVFw8f3Lugza0qxMHqXSRUy4ahoPWp3MAxcr+f6RkDzMXZevmHXgJgqVU78xyjeExSGTbhhWeSXk03A4Jh7/0HsGv3O/3qApuD/8vUoRFnJuuioN/ZrIMcxi7GcMm7wzeZjKTAdlIBGNfZV5DTTqDpc1+ZeZCrLzlTke1PuFCCL0BFrYiMFgAhLOQmP05wH+zWmIh/5K0Ept5lWuI/z3qsVVvdEAnvPXalMBPoa2YZtOrAgrWhEIkrS82vciGxGG1Td3ziRii+iBOnDnL1KNdRWet4DiuHSjiU55E+Vy7I9rWSPulsv2CEZjah4CQzOiP0/4H4KvWTe5yQglwv4WyoZimx61m1Mme5PTUHnZ5t4jReAdbGMYFjblxo5Yct9i5pdaoDsJp6/G7Hf/Le6g46Nj9ii0GL2v6ey4dAH7sQvL2bRfh8aAYl7T8XuVzsuiN0HddEoDHa+e+UNvCGbsxAiTSuXmEszMqO6OBzKE3PhFT0pp8GYzTem/Vntp6XXW4d8QhHzZDjcZl8DSN5WjoJmLpIn1TIShdsrezN0LWuhs1V3SvBA1QR/eVX9K0XtBROesCHBM3PKZJ15bADKWE8TiwhRVH6MdEPt+GdKaJjgKglP7x6jhehKJMlhnywhvt8eqdsyFhxYXSdY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(46966006)(36840700001)(4326008)(16526019)(70586007)(70206006)(86362001)(36756003)(2906002)(8936002)(26005)(1076003)(186003)(6666004)(36860700001)(2616005)(6916009)(8676002)(81166007)(82740400003)(47076005)(54906003)(5660300002)(82310400003)(83380400001)(478600001)(426003)(336012)(316002)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:54:59.2287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb09f87-791f-443a-9402-08d93b163faf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4191
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

- Updated SCR definition for FW boot options for Separate DCN init
  for DMUB FW loaded in VBL

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 7c4734f905d9..98bda0e3a6c3 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xf3da2b656
+#define DMUB_FW_VERSION_GIT_HASH 0x2fe298ec9
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 71
+#define DMUB_FW_VERSION_REVISION 72
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -334,6 +334,7 @@ enum dmub_fw_boot_status_bit {
 	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1), /**< 1 if mailbox ready */
 	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2), /**< 1 if init done */
 	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3), /**< 1 if driver should call restore */
+	DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED = (1 << 4), /**< 1 if VBIOS data is deferred programmed */
 };
 
 /* Register bit definition for SCRATCH5 */
@@ -352,7 +353,7 @@ enum dmub_lvtma_status_bit {
 };
 
 /**
- * union dmub_fw_boot_options - Boot option definitions for SCRATCH15
+ * union dmub_fw_boot_options - Boot option definitions for SCRATCH14
  */
 union dmub_fw_boot_options {
 	struct {
@@ -363,7 +364,9 @@ union dmub_fw_boot_options {
 		uint32_t disable_clk_gate: 1; /**< 1 if clock gating should be disabled */
 		uint32_t skip_phy_init_panel_sequence: 1; /**< 1 to skip panel init seq */
 		uint32_t z10_disable: 1; /**< 1 to disable z10 */
-		uint32_t reserved : 25; /**< reserved */
+		uint32_t reserved2: 1; /**< reserved for an unreleased feature */
+		uint32_t invalid_vbios_data: 1; /**< 1 if VBIOS data table is invalid */
+		uint32_t reserved : 23; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
