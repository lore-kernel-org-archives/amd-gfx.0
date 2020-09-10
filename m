Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7DFC07548
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC13A21D90
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SUH54ATG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC13A21D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C706E95E;
	Thu, 10 Sep 2020 13:48:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 692AD6E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YF0RrOADsynV13zZrtA+2eFGhqG3s/P2aDHR2iyRoYASBfy+S10b9lUi086xpV2yMpTwX9G2FXRJfhbuWfEvaXuSSJaC1oS17czX35k9S7wHUo20dCMRpGCkBXh3+5vBFF/gYr3j+L3s1Ojdu8Nm3zY2wkz8Su5Dou/bNBErYmAxd9DT0dChKLSubJwVNyKXlcERl3ZXNcem+IeyaQJEjGiVeaG7QRoWwhkP52Qp99jtC/LsYHx3cS6COq3A3vOLswEO+a7GviJ4Hr3SQwQcYT37mFi+gjUTOrN9MMEuPjfUHjEZ/MHvEPM8Iscc2TzGLS+2ifjduLlR9UMZit+YDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAM2Et5ibFNkoUUIv+D8Nyz2yy0qBFJberfZ/0CmJCQ=;
 b=U38pDDt3bL9viwn68jNAet3ysHJhzYn9XuJdliWDCbBzjmOSfek3G6WVTj95O3h5+boaYj/+7HYlF3+gZE8e4ondj1gonp3itkLz6OFnZGs5C52SX9FbU17LWroEEZ29i4YH0iRRhKDvlnCOe9yTnDK/lEsSw6mmVHm1/h4YqW5NuaZ/7a3niQ1MLr/+AZAgzLpTEDSWpAVmnc4/XDYQjxIz4W75dwTQjDtuVdTNgDkeW+iRLkcQ0OZQ11B8sriL+Hc/vbJX1ikLHAAZ6CSwE06gewhhqAUvBVbYmdoAm8/iDqievB5Lfpc8PDF5pWYHPCTV9D1+ym7JEQT+e3RzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAM2Et5ibFNkoUUIv+D8Nyz2yy0qBFJberfZ/0CmJCQ=;
 b=SUH54ATGUB3AUL6+Izoh5sh1vhd7YZ01Ramvra0GAzACAC27NuQ2JQBMMXeTs/vrbDCVB4R7C9WXXMZYFhBLMg2+agPR0unRVZyrsAvpzXnY1EeMGbRM1fsU8h5p6WO/27gGAEuOaDiNfAIeHGjIhYzniYoebfi6H0Q2vJoBFgA=
Received: from BN1PR12CA0028.namprd12.prod.outlook.com (2603:10b6:408:e1::33)
 by BYAPR12MB2614.namprd12.prod.outlook.com (2603:10b6:a03:6b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 13:48:22 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::99) by BN1PR12CA0028.outlook.office365.com
 (2603:10b6:408:e1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:22 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:18 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:17 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 41/42] drm/amd/display: update dcn30_optc header with missing
 declarations
Date: Thu, 10 Sep 2020 09:47:22 -0400
Message-ID: <20200910134723.27410-42-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6379c28d-65dd-462d-6b2c-08d855902ee9
X-MS-TrafficTypeDiagnostic: BYAPR12MB2614:
X-Microsoft-Antispam-PRVS: <BYAPR12MB26140D40950A5F90AFA500548B270@BYAPR12MB2614.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K0a1ED6YwIinoH8iGayh8OawTLREZ5ucdRb/PT8CGWOLwBkFp+89MznnZRhZVL4yDEB7NAT6CoNbw6FjmscQi2VoMi+tBTGayWeazq0UjL2+kjvhgaUX+zlTGuNp/YLkMZmCbRRmPNjmZ/2JdnDk6bpf3i79Ny6kRhdqKd6R9INCffvuqolBns45+2H3zlUsZ/g+bsIBTuiuT+5Auaua518OHaNvvzHwQVfEXm23LuRnyJgP88YmdLu9Ze8k5BnXuqjNz3oiWn1KF6DfhQEPorv2gUzW47G7RceDlXq0hi7QJ3hTOfZkYP/JVDvFbf2LMmoTrOfMYbW7hEpeeFTfTHk0jFIM3tAR3ksaGyvOInCm4bPjmtYoNyAhO+QTaxnqUQNFOygz+MCaYN1zs8YnHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(82740400003)(8676002)(81166007)(36756003)(82310400003)(316002)(2616005)(86362001)(6916009)(1076003)(478600001)(54906003)(47076004)(2906002)(44832011)(356005)(7696005)(6666004)(70206006)(186003)(26005)(8936002)(5660300002)(70586007)(426003)(336012)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:22.3196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6379c28d-65dd-462d-6b2c-08d855902ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2614
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c | 5 ++---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h | 4 ++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index 224c8d145eba..6d13431ff693 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -179,8 +179,7 @@ void optc3_set_dsc_config(struct timing_generator *optc,
 
 }
 
-
-static void optc3_set_odm_bypass(struct timing_generator *optc,
+void optc3_set_odm_bypass(struct timing_generator *optc,
 		const struct dc_crtc_timing *dc_crtc_timing)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
@@ -277,7 +276,7 @@ static void optc3_set_odm_combine(struct timing_generator *optc, int *opp_id, in
  *
  * Options: any time,  start of frame, dp start of frame (range timing)
  */
-void optc3_set_timing_double_buffer(struct timing_generator *optc, bool enable)
+static void optc3_set_timing_double_buffer(struct timing_generator *optc, bool enable)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
 	uint32_t mode = enable ? 2 : 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
index 33f13c1e7520..379616831636 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.h
@@ -339,4 +339,8 @@ void optc3_set_dsc_config(struct timing_generator *optc,
 
 void optc3_set_timing_db_mode(struct timing_generator *optc, bool enable);
 
+void optc3_set_odm_bypass(struct timing_generator *optc,
+		const struct dc_crtc_timing *dc_crtc_timing);
+void optc3_tg_init(struct timing_generator *optc);
+
 #endif /* __DC_OPTC_DCN30_H__ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
