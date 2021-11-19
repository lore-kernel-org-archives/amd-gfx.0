Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E95C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD9461A58
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BD9461A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 231D76E835;
	Fri, 19 Nov 2021 19:44:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2045.outbound.protection.outlook.com [40.107.100.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6EF76E457
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM8Q+vE7jCcTjf4mXMA3V0GkfMwLeRrDdh80m5Q242rxGW/GOAZISH1C6MrLkkFv20pn4CxG+NMDS0w0Aqy2cdlobYGntA6f168v/N9NTgKKcOABnxwCmmkm+UJawnhGMEyF1WwZp8KBCR1jeyRphFqhVKOfFP11PcXUiVf9xw2b5Dp7bM4oPVdWT4k4bXL4e1x0k7AmELGBHk1iBgPILR5873ffIPVtPV9bu4Zm+R3WCIhH3HiDyI9uZRUvyWkrHlarjM/JMqXnu02UbGxin2q0/8ABAXCJQ8VKOh9NLtQMyB7jQDNaSFTarivZh2R0jjPLkX3plAand6PUdVI07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iyZUFxwz+PEKlQkbUulB/AkyJE5kpERsI0Hax6wKFo=;
 b=DkCegrEbhVU553BHywa0E9DosL5bzo1ElF/1wSvtAFDNFlw/X9J3mI7QZgfTIMgjgEIOG4pNwlYyaCVmsKaRAj810TxVC/9eq72xIW61/CywY9Szyw7M1448KZwijw8Ish4a8iM11sD2B4fbtwR0fSMCJ5GuJ5p0g+DHqunH5ImZZMFJ7mlsDINQiz+X+6TqqBVJ3mf2pI+ZDhq0VAS2U8wxgKzYtTKetbk3Mg1+oVnRB4XqaQsDmMxJc7EZcFWWfInmx+zJ8/5d/28IOG4rJ6nTr4aFfH2r8lf0rPh20RpqatlZp9xMITrrVwmvm3ZGIQK6vET68rnta908aNYyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iyZUFxwz+PEKlQkbUulB/AkyJE5kpERsI0Hax6wKFo=;
 b=RBLt01v6RMeiHmdUGQf4JzBZI9JiEk0fd48vWukI4t5h1dmDM4BhuVzVvFGLmLjoCp9omhT+34MQlrtIfZTNR+9NAFPdScaCxmpEVjYcOKYJdn3mzf+YJOPTCdkv2sxAa01PtXCP4uvA6OUeg0DpxShDHj+yn+Lmi+mT7/xeUcY=
Received: from MW4PR03CA0273.namprd03.prod.outlook.com (2603:10b6:303:b5::8)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 19:44:13 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f7) by MW4PR03CA0273.outlook.office365.com
 (2603:10b6:303:b5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:13 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:44:04 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/16] drm/amd/display: [FW Promotion] Release 0.0.94
Date: Fri, 19 Nov 2021 14:43:38 -0500
Message-ID: <20211119194339.97573-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd02138e-9899-475d-2b9b-08d9ab94f70c
X-MS-TrafficTypeDiagnostic: MW3PR12MB4348:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4348DA1DFC45C8A891D053B8FB9C9@MW3PR12MB4348.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +jFYgFOZIKgMyHeKU23BYpoPK/ws+N+epiddkhVuPwWooFZWamy8uyFC2tkYeBWopCU7HvUcuzLPSQz3TA+kxDa8OoB26WCFsO+yfwyVvTEYdxOGBiF0gchPKuvz9ygEIuakYagTTP6Ii1vP9bAxUNAbfHWj8Rpu1dvUGkLqhx7M4Eyb85UQeXTZt8K2mEKgwG/u1LM9wYki/OISzhZy0Ios/UKdUOs+QXyIfv8W8mrW4XRhao6sor6CAXMxJ7L3bIlW9RB4MAU1IfQJrOq5tpwB1rOO9y9RqjpqjDqC6CLQW9v09ctF1jLkAMknUojcUO6oHsMCLj8zW/CuuM1B2QebLdx6aMmekPHRGo5NF2GC5OsurcfVb721xsqiWvzNf2N2s93mAyChVIaljLsfa2oD4hOuQlbnrGrXX1PBzoF6OMI6v8VHKUquf8oNQYd1w2Q2C4SNYLOE0kM2Gyh2sQPNknIIH4eTdTOXuFdYGtVrNjLYGCn83EsdxqFBJ4BH+4T8gM1JKXJPTjHcgp+1diYpF/KM5bjCajm7xG1KaXzwKGlL4FTW8XjG/hf888GLHSSkiWyfchdzX88Okvr6uaHMF0psDPTmC8QjTxgjmTJjO/HD1t050InDhQApUk2I/sE/1muDCmbitO2o4No9DGSnjj3WhKoVf0vQQJsVHUnoZQmuRZza1wrAO+L1//pRICaBFnlrlbc63ctVTa8Ez6/QuImGiSeLAaJU21SAye4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(6916009)(83380400001)(1076003)(81166007)(356005)(70586007)(26005)(8936002)(47076005)(508600001)(5660300002)(426003)(36756003)(44832011)(54906003)(6666004)(336012)(8676002)(2906002)(86362001)(16526019)(70206006)(316002)(82310400003)(36860700001)(2616005)(186003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:13.6336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd02138e-9899-475d-2b9b-08d9ab94f70c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 solomon.chiu@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why & How]
 - Remove tick count definition since it can be different
   per HW revision

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 20efa1f61914..6499e5c790bc 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0xcd0e1e7a
+#define DMUB_FW_VERSION_GIT_HASH 0x465e619a
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 93
+#define DMUB_FW_VERSION_REVISION 94
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -173,13 +173,6 @@ extern "C" {
 #define dmub_udelay(microseconds) udelay(microseconds)
 #endif
 
-/**
- * Number of nanoseconds per DMUB tick.
- * DMCUB_TIMER_CURRENT increments in DMUB ticks, which are 10ns by default.
- * If DMCUB_TIMER_WINDOW is non-zero this will no longer be true.
- */
-#define NS_PER_DMUB_TICK 10
-
 /**
  * union dmub_addr - DMUB physical/virtual 64-bit address.
  */
-- 
2.25.1

