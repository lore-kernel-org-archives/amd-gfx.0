Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D836C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056CF206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ko/7K8nD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056CF206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E0936EB5F;
	Fri,  6 Nov 2020 23:19:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08EF46EB5F
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMWJAPO0klgiVqIPSwmAokXTIgAPtFNGX4L8uiKHQH3bqvb/dZUELTvCWkTSc4FFfLK73NCJBqp7lIt20e1W7j6+sbqLdlsXhUSTfsnfX6NCABFVSkEojMbEif30NVTDYi059ImBNuCScWXhFyjb9CF8LX1rbk6yorPRwngWDCqbNOakx9KFbf9+bKQEpqI+PXCzt2JIVd2lBXlmjKGds88QUcKTRpAFRM6Q/uzeDM7BO7ak+Ww0W4xnwNi5l/goA16pu5XFw1aRMb30P06IuaTN13Rz0waU3MhsYEuUjB1CNvzFRwZygz0ep740wV3XxgdL8ChR7xBhGwK8/g5opQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jjAT+L2qsn09kIqshnMlHKFKv5tvHhO0kcoc1sHgTQ=;
 b=U85PQxcawmBBJvV0uM6F6o3ZozRmyvO/m2u3Ngq7T8xbTdFtKXjqy5Zuu5ImR7lMuD04ofCYXOuq47x5qTMv/lxSjm1soFBmxNqLkHPH003txPjjuKdKbHnRUfH34FcZeFiZrAaVObm4j786yDg5rZEjbkMx068vNhf7Wz/ZjyZGKWWujEY/oHOIeuL707xim0FIX313Kfv2k/ikJjK9cE9queR0gJrAeACVmctsrOtstuZ9w15Lwi++SOGEsoq0BNCeq1Mobm7Ew+EjqiivS5ThxjvHSAZfX9wzaVO5oCWJ/64kF0Id60/kYZVxtegvFAaiapF3LdNko9pK0T7r4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jjAT+L2qsn09kIqshnMlHKFKv5tvHhO0kcoc1sHgTQ=;
 b=Ko/7K8nDPwfOKmPERg97qnMaN3Arysj60tiJ0/AQQj1kYN3y9QYtchYf2eDVqWocoYsHoiAuECEDcT0Gq8Apowkr3R1sWmFfVsFMJACgLGNAm08e4UikXbJulVJSrF7K+a8s7dnF7Sy2A9Soe6v4XmL/KrDe2V1VVafwkBcQSOw=
Received: from CO2PR05CA0079.namprd05.prod.outlook.com (2603:10b6:102:2::47)
 by BN6PR1201MB2498.namprd12.prod.outlook.com (2603:10b6:404:ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 23:19:37 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::4b) by CO2PR05CA0079.outlook.office365.com
 (2603:10b6:102:2::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:36 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:35 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:34 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/14] drm/amd/display: cap dpp dto phase not more than modulo.
Date: Fri, 6 Nov 2020 18:17:10 -0500
Message-ID: <20201106231710.1290392-15-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3d35213-1b09-4314-2781-08d882aa6da1
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2498:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB249815A87C8662811CBC5F91F5ED0@BN6PR1201MB2498.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kW+a79LBT7fkcaclfzfZfMVfs4yLHErKs18sx5i+RW8s9u73CkLMv+tiNdZBlCGx0XaqNuI2EtbeLAcTbDWVcFhs7l6VnfcVYiVM8eRMfTuDJt8XnOmRBZSp7Iia07oB6cRoyoHinlkjGAIsXi6vP/Sns9Ga9C84+i6D0LNp5HpiXWHiv3tvJ9yXpa5Y6LDgfrOFOzhxOXKAXJJ0WT5bXh/NSAc0WUe9pK4KmzdtKjA0Fko7Y5dYd0svZV3cnIZYzMWF8Ym7vFTIDX0ygWFJqFG54NWeQ7sNPHb7l50Jy/ZIUcytNX/YdaEGfiif67FHeBdt7FvsYrmZANqsg88xIUUq5FTltcoO2c/l+FtFM6LRXywZ9jxi0nqwhYkM+XzUYnmmbkqv++k6exbwiIc29g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(46966005)(426003)(47076004)(54906003)(2616005)(81166007)(2906002)(26005)(82740400003)(8936002)(336012)(86362001)(82310400003)(356005)(36756003)(186003)(7696005)(70206006)(1076003)(316002)(4326008)(8676002)(70586007)(83380400001)(6666004)(478600001)(6916009)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:36.6535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d35213-1b09-4314-2781-08d882aa6da1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2498
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yongqiang Sun <yongqiang.sun@amd.com>

[Why]
4K monitor shows corruption if dpp dto phase is larger than modulo.

[How]
cap phase value never larger than modulo.

Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c | 46 ++++++++++---------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
index f9e3a2337fbf..60cf3ff68cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_dccg.c
@@ -50,43 +50,47 @@ void dccg21_update_dpp_dto(struct dccg *dccg, int dpp_inst, int req_dppclk)
 	if (dccg->ref_dppclk) {
 		int ref_dppclk = dccg->ref_dppclk;
 		int modulo = ref_dppclk / 10000;
+		int phase;
 
 		if (req_dppclk) {
-			int phase;
-
 			/*
 			 * program DPP DTO phase and modulo as below
-			 * phase = dpp_pipe_clk_mhz / 10
-			 * module = dpp_global_clk_mhz / 10
-			 * dmub FW will read phase value to
-			 * determine minimum dpp clk and notify smu
-			 * to set clks for more power saving in PSR state
+			 * phase = ceiling(dpp_pipe_clk_mhz / 10)
+			 * module = trunc(dpp_global_clk_mhz / 10)
+			 *
+			 * storing frequencies in registers allow dmcub fw
+			 * to run time lower clocks when possible for power saving
+			 *
+			 * ceiling phase and truncate modulo guarentees the divided
+			 * down per pipe dpp clock has high enough frequency
 			 */
 			phase = (req_dppclk + 9999) / 10000;
 
-			if (phase > 0xff) {
-				ASSERT(false);
-				phase = 0xff;
+			if (phase > modulo) {
+				/* phase > modulo result in screen corruption
+				 * ie phase = 30, mod = 29 for 4k@60 HDMI
+				 * in these case we don't want pipe clock to be divided
+				 */
+				phase = modulo;
 			}
-
-			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
-					DPPCLK0_DTO_PHASE, phase,
-					DPPCLK0_DTO_MODULO, modulo);
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-					DPPCLK_DTO_ENABLE[dpp_inst], 1);
 		} else {
 			/*
 			 *  set phase to 10 if dpp isn't used to
 			 *  prevent hard hang if access dpp register
 			 *  on unused pipe
+			 *
+			 *  DTO should be on to divide down un-used
+			 *  pipe clock for power saving
 			 */
-			REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
-				DPPCLK0_DTO_PHASE, 10,
+			phase = 10;
+		}
+
+		REG_SET_2(DPPCLK_DTO_PARAM[dpp_inst], 0,
+				DPPCLK0_DTO_PHASE, phase,
 				DPPCLK0_DTO_MODULO, modulo);
 
-			REG_UPDATE(DPPCLK_DTO_CTRL,
-				DPPCLK_DTO_ENABLE[dpp_inst], 0);
-		}
+		REG_UPDATE(DPPCLK_DTO_CTRL,
+				DPPCLK_DTO_ENABLE[dpp_inst], 1);
 	}
 
 	dccg->pipe_dppclk_khz[dpp_inst] = req_dppclk;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
