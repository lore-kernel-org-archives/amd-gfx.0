Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00372C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C458220748
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 20:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GsXymPKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C458220748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559436ED0D;
	Fri, 10 Jul 2020 20:34:06 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760083.outbound.protection.outlook.com [40.107.76.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BA8D6E18E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 20:34:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US0JimYqrmGQOMMcCh/DJVBCS2lqa2WrgWsltXZ+Fk3h+CwcrsO5c0mCycRsBhA1Vzo+ZmQUCYnHU3QS2p3bLWB2lC6QA1Ieay0bkLV/s7s8krXmwHAFNrfSnSdTC3cQd2jvuAl+19XbSbUUUg+US4BCt9Qg7AhmXCUubC6/c7Bn82k6QORC5kv8xfY0n2UJQn8fh3/T70fsVkzGYF5i6Y9MncwRELhvW1G35n1+6ZxpcrMJKwmtzEKAPtWgmfA4ieSJ13dkzV0XQODB1r33H8pKcQyfoWj9c+R/cgjW1u1VkDuReV7o6ZM8wKmhZhZBdph/HyJypb7lUKUJdeK7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDb1eCkePB+anfUa47jRWW3xQgq2f8JNAsutE2fzmpg=;
 b=PQYb+8OOYS7LniGyI04MmtowZ8Bx5julBM+r6JgjNY21IyM4jQIM0FpepfkDruazrRPMMbMzMEwL0zF+uZdx6eyFGi+m/RWD6+11Uagyk1IzloMCw7IpqljuzJIgyuK+RUmPbdGWgarskg4/yBJYm+cbfzIks2/gsXB89LguircW4pKf/lfl4RabmP7ufgytnA33nz+4RLBNsLE18aGFKlnNXNm0oWoYf2UDK8cgfi/0T/9x/dYBIdzfTbawEsK9uPHYraOTllkJzx0joylShj2NKTgWC+3UzZaPCF7Bze1T6g3rUSPHVAMSSuCSPMUkY4kFY4Xq6S+nvZ29qXWrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDb1eCkePB+anfUa47jRWW3xQgq2f8JNAsutE2fzmpg=;
 b=GsXymPKhYA+hPlSExLcYg9s02c1gQnieYTxxeSZE/5brUUmOIJR8VSPaLcJqOZhsOwFx2BUvzFawg84oQK1QD5l+5Kdq2+GcW0to6AyMvlIvc7noJMu2SDmFP3bzyhqB8zhKAqPPwZHB1hClt3t7/WYNBZA9ofOnP2w18zFVACo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 10 Jul
 2020 20:34:00 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::9013:9410:7d60:cce1%9]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 20:34:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/10] drm/amd/display: update dml var
Date: Fri, 10 Jul 2020 16:33:16 -0400
Message-Id: <20200710203325.1097188-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
References: <20200710203325.1097188-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::38) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:8440::b10e) by
 YTOPR0101CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Fri, 10 Jul 2020 20:33:59 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:8440::b10e]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a54899b5-d685-4c48-e370-08d825109377
X-MS-TrafficTypeDiagnostic: CH2PR12MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4231FCD254A4EEEE5AAF845B98650@CH2PR12MB4231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Th67OMUMlsBrkTsFiI80Pp2WMoNmi4Aji1gJSxTptEUvFj3TveokV9XfaxRt6dtlrN82kyp5Nyd8zfON3j76mbRCNe8LSYKkjnV/CVox0OA1r8/6sryu0PN36U6nZ60NN58muoehKyAQwH/XGUS+oT+yVgq+vigDSHdKyrLXrKZlGcUMAOcY7y0zWES/QfxZnv6J/h6VPJQYeJ72Jx02Kf6nshugtT4fyp+5vL+RgwlzLUO1kmX+TedVM643P09+lyy51MX+JjczJAXjVlDK/DNZNqzY8XYSpL3jGiC67ixDhNO+sw1nygrIfJCkiXjAcYyD3v2gq7REL7QXzyVStfuVlRrOxp4B4/+eA94aaZj+ZEEmhZ1LFa4JexMmFQqH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(366004)(2616005)(8936002)(8676002)(6512007)(478600001)(316002)(15650500001)(16526019)(5660300002)(186003)(4326008)(86362001)(6916009)(52116002)(6506007)(6486002)(1076003)(6666004)(36756003)(66476007)(66556008)(66946007)(83380400001)(2906002)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: N9qtjCez4dkf4l0T+hz6006YuVHm4cy7xNJulVaD5QgihYhTLAKgyDuu18N78MmmMBpy9QKnhw/XXJ28TXVlzeJ4+Zi54bUAqIOobVUX3DgNysVdWrhQPPi5vlOYpLTlqpK9Wt7ILXpDXFyRpcZQ9G22HB8N1x8bYN1rxRVXTMSNof4dPay58KQfh3JcCkWGg29lVoh4YzpfWdai6GkcvvtyniB5pfJ6KSWqHKtnP3qXkF9WX+JCShPIYdLJ14JFQ5pXMObH1ziSBdRmm+Y6Q8CdN4/ODt+dgvM1TXvZyMrjQYl5LNqP5V/oNd8weY8gWhZYvHc2moPVzGWqs3AF/iFiOVYjKIgnd+AD6hfWETzHJx26EmqNjiVg3cMxNkwnvlNumSZ9PkLh173HnHIAbOYguDJzEZVOmVGLrtiHEVM50Sm2OqSEv/IGAv7dLJWgodBa3tm+6DLmh5GsnYt4SNMl3vUc1DwYGTTwZhuXSlViW2rv/YhHJ23WIFxGxf1FA27Vikbfp/huLO0DV/1s/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a54899b5-d685-4c48-e370-08d825109377
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4198.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 20:34:00.0759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TlnBCJqGbS7sywQpCdImc+1TyJShfXb9ztmH2q9mQA/sl9rKTzyr+RRwUmL1W5DTP1HF/UGfzL6VZUBJtDjM9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
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
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

Update *DynamicMetadata variables for providing more flexibility.

Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c    | 8 +++-----
 drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h     | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 75dc4fe41731..b54814f11b74 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -2567,7 +2567,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					&v->VRatioPrefetchC[k],
 					&v->RequiredPrefetchPixDataBWLuma[k],
 					&v->RequiredPrefetchPixDataBWChroma[k],
-					&v->NotEnoughTimeForDynamicMetadata,
+					&v->NotEnoughTimeForDynamicMetadata[k],
 					&v->Tno_bw[k],
 					&v->prefetch_vmrow_bw[k],
 					&v->Tdmdl_vm[k],
@@ -2686,7 +2686,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		v->FractionOfUrgentBandwidth = MaxTotalRDBandwidthNoUrgentBurst / v->ReturnBW;
 
 
-		if (MaxTotalRDBandwidth <= v->ReturnBW && v->NotEnoughUrgentLatencyHiding == 0 && v->NotEnoughUrgentLatencyHidingPre == 0 && v->NotEnoughTimeForDynamicMetadata == 0 && !VRatioPrefetchMoreThan4
+		if (MaxTotalRDBandwidth <= v->ReturnBW && v->NotEnoughUrgentLatencyHiding == 0 && v->NotEnoughUrgentLatencyHidingPre == 0 && !VRatioPrefetchMoreThan4
 				&& !DestinationLineTimesForPrefetchLessThan2)
 			v->PrefetchModeSupported = true;
 		else {
@@ -2695,8 +2695,6 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			dml_print("DML: MaxTotalRDBandwidth:%f AvailReturnBandwidth:%f\n", MaxTotalRDBandwidth, v->ReturnBW);
 			dml_print("DML: VRatioPrefetch %s more than 4\n", (VRatioPrefetchMoreThan4) ? "is" : "is not");
 			dml_print("DML: DestinationLines for Prefetch %s less than 2\n", (DestinationLineTimesForPrefetchLessThan2) ? "is" : "is not");
-			dml_print("DML: Not enough lines for dynamic meta is %s\n", (v->NotEnoughTimeForDynamicMetadata) ? "true" : "false");
-
 		}
 
 		if (v->PrefetchModeSupported == true && v->ImmediateFlipSupport == true) {
@@ -2786,7 +2784,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 		}
 
 		for (k = 0; k < v->NumberOfActivePlanes; ++k) {
-			if (v->ErrorResult[k]) {
+			if (v->ErrorResult[k] || v->NotEnoughTimeForDynamicMetadata[k]) {
 				v->PrefetchModeSupported = false;
 				dml_print("DML: CalculatePrefetchSchedule ***failed***. Prefetch schedule violation. Results are NOT valid\n");
 			}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index f615815c73bd..756d8eb1221c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -802,7 +802,7 @@ struct vba_vars_st {
 	unsigned int DCCCMaxCompressedBlock[DC__NUM_DPP__MAX];
 	unsigned int DCCCIndependent64ByteBlock[DC__NUM_DPP__MAX];
 	double VStartupMargin;
-	bool NotEnoughTimeForDynamicMetadata;
+	bool NotEnoughTimeForDynamicMetadata[DC__NUM_DPP__MAX];
 
 	/* Missing from VBA */
 	unsigned int MaximumMaxVStartupLines;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
