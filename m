Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B005C43460
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02BF61390
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 16:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02BF61390
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D1D36ECDD;
	Thu,  1 Apr 2021 16:45:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E69C6ECD7
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 16:45:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYGsGa+oo/NqI2313jNtWyuHDAb2LWkvjTHZ34Np6oSvHnMgPW1BUUZrzxAK9NpNetNVaTgqPbOhWvbqbEPPmcJs70W9CQzR2Ygi4IllcdVRMm03F9PIakR4Ne1m/2WtzP4UJ8gPMgrZyVOSt0QUiNAhVOE9ZJsCJ0HWaUz+XGYDCXPvASTyCpD0kXXwLJqlv9Rj8FIpAoEU58GuENi1fXYUIkH50F7+iBl0gVs0VjW1wzTst/las4YViq2DyWM4JKiqjFqMbuBHf6hFVwDPuwLPL138H04yhUpbzRLO/6mN7eGhTDxfxgQRvqY1OKWdK99Vdx1Y9nMsrmkqctrEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuR5QK3HY88nTCLt2C5qy/ikXuEzdqyJxNqxfXyadz8=;
 b=ar1Gfsar6eSV0ZoDvsHjR458Cf2Lx5FRYwk8vsUZ6nyKT/+AEekLv041Dxuhb8kSkbFxkwWpVSS2FiwgRNrSnwtDnbdxWcy4Dz9IQuZDKoKcvRzcC88DtE2CTSAqOEBXXWzGbythUkSRR4cHdijbpuqXArupwY9LkO+MUh2TunNPr5sbcQBIfENnJJkJ97LM3n/5T4GmHgqy7v9p/nNP6udTmKvACSXPOJ9DrEcPluLkI2Bm7CdwpeFeZvBLAysrrD9d/TjLKoHTbsNQsaut0dCpQH9LtpLRrgDK/HjpQ3JyMJhZYtjYwSqj0VcDYARyxi5NIN62ArGY+SZ6wEgIpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuR5QK3HY88nTCLt2C5qy/ikXuEzdqyJxNqxfXyadz8=;
 b=Q8Kbh7pp+/iY00hsLzRQ83gihcL++r0YH0d2stR8Jficq+u74UVO0MzNPX1trVU3mUWt1dAlftjV30A0zA8h7rxwS5VgWpHVRdd9NoO7G+HOJ6T7PNutZGk1kia9zeYRAyPQlHLK6+2/IAWRLfzYqK4WexiyaEmW6NmRWLM3YQA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM5PR12MB1514.namprd12.prod.outlook.com (2603:10b6:4:f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.33; Thu, 1 Apr 2021 16:45:56 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::1887:4978:1b79:7cc1%5]) with mapi id 15.20.3999.028; Thu, 1 Apr 2021
 16:45:56 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/21] drm/amd/display: Retry getting PSR state if command
 times out
Date: Thu,  1 Apr 2021 12:45:08 -0400
Message-Id: <20210401164527.26603-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401164527.26603-1-qingqing.zhuo@amd.com>
References: <20210401164527.26603-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::19) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0140.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.32 via Frontend Transport; Thu, 1 Apr 2021 16:45:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb59ef89-7e44-4abd-d8a6-08d8f52d9f0f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15148586D778D69FBD58BF13FB7B9@DM5PR12MB1514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tgNcAEx0lpJiPjkYk5YQWCSlUaKvKyqkv57W2QfTXDHC02H1H/3Ot1cFNS9uGtUaWQaN6UzCR7CPtE86y8RQ4iECjDqn2e1q/DMfy//aCARQTlPmaRc9UVujRp+Me87ZqjCnbGTdktGj8ZaSU+a8RYrCWPDYG9IpCVbmTUcVHfIaNc45u90eQdVdLSqzw5z4EPfiqleB7sOPZBYzSFGPjJKqxIROx7HGzjWJ5XB159CZEz8kJ3bkOBqsSJ5JEhatvdWAcTs+3YD5yrzKDC3FiogFwAoE7mhQS1/ge83Fg7GdvNp0GTFphYqPEC4DjF0GFmSIP6guy/E9YEP+s2LeRsr2U3OPX+SbrfPVPSShHaG83byPZC6kt+I5nTYC2LQp8gcd3PJRcAX2zoB/qbTfiHWqA7edaEeGN/PXMDh4BuNO2VFXTcWOmeY8g7a7CwnsePk6vX04lmpVrhCCmbGje0/KDXknWyD2WUMln9AownV0aU6ekR4tjuJPq2Xl7txoQW5bUX6anKEfMsLiBFoyuaqBgUOpAUo7cZIoZgnOPXR0swT9QrOKWaSGUnpsMk1LhKWAabV8EgMVLC98CeyW6SpqPMFA9moVWCf9Fgdhh2hkWEMDu/sOzvvoqjMJG80sqh6WPczODvzum8SHYLKWzwzG2VgQZwkhPCWlil1z2RJm+vQ3jQ2aQq9EJF1NDUuB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(8936002)(86362001)(69590400012)(478600001)(44832011)(8676002)(1076003)(6512007)(956004)(16526019)(83380400001)(38100700001)(6486002)(6506007)(2906002)(6916009)(52116002)(5660300002)(186003)(66476007)(4326008)(66556008)(26005)(66946007)(6666004)(316002)(36756003)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rFelFJMNnRDx9TNeFiHDnJWbDS4n7OTN2Qup5k1Uh9obvPMHXlaQVyqnMjQi?=
 =?us-ascii?Q?EJtomeFI0ZSFSDqrCWrC0q1J3yDqR5qLwmjDa/Y+kFoDAOa/9iRK3gcfYNxv?=
 =?us-ascii?Q?H8de0MtxAurqhlGoyrkwijMg6UI0OTaYefLHp814LugCbWPIQv1331mA6q6K?=
 =?us-ascii?Q?kEtSvwV/7LYoBaFI8pXxeb23BeULWjftZ97ucBp+9cM+IL07ixGJdXCLlXXV?=
 =?us-ascii?Q?BenC2LUMOOd1gf7ETSBmyZ8ORbzLEMdepvDsWKWwjv2ZL2akPb9ymHbxwIzj?=
 =?us-ascii?Q?haWMBD26D30v+lxICM+3pONLDEaxYxS9nqCavv84Ohnh6ZxkMahy03jrS099?=
 =?us-ascii?Q?NE2bI8SLys1UJZbZxSiPvp6+wtlGG/3YIfdXDORGH2dnG1L/yjpKkflq82Zo?=
 =?us-ascii?Q?B0kxoQwgrhAQmlDtwhbKiaazh9fkdAb0+SC2407A6alg5ZvnKRuYQQwXhTGO?=
 =?us-ascii?Q?ERqORyzJ+pMD+AZmnQggRoQHyeIbIEo2PeznDy9zks5mSlirleZvl/M4nFZB?=
 =?us-ascii?Q?4GveSSM6tn0EICrAAQIuCfG73g+luXnHuTY3+j7yiHygrmApa03n+6KbeFRO?=
 =?us-ascii?Q?6htJztlWLu7xrt2BCJkXVNu4v24RibRDkAKoUaX2zO/EojtN+xHt+0yosxXe?=
 =?us-ascii?Q?Mm6p13ZDJo5vGLPY0Pi8B08oo3NR+8OepMo2kjNGY//zhXAHtBaPL63/N0wL?=
 =?us-ascii?Q?MtTcvccC4c87Qjh1MfWEINGPONo8ckZ2uqjV61wdHoEeVqt9oDBuvvU5D8k+?=
 =?us-ascii?Q?y0ILVN6A43fBYhowVYGCldgJeV5uLOZMsx+gNvfGv2iHo0SEJKdeuHAW30QC?=
 =?us-ascii?Q?347tF0QRnreymfzZy7/UZNMdiIVFlcWM1QCddnIir+knu5En7Tki1gtNOfG2?=
 =?us-ascii?Q?ADitBrdc4oJA7u5wNi2DWqiHPxh0KpHo1Wx7DJRrScvWTr2xhwMWLbq0kFXF?=
 =?us-ascii?Q?f6wnxDzI7oFHSWhx97+CTLQ21YdJW7Q7XnjkLP1yQiz3mLRoILQFt218T0/C?=
 =?us-ascii?Q?Vw+hlmu1OJ5xsKagpTD68BMeZ53WOFe3MuoQ1d1xZW18dBOdcflc9mQfVhCi?=
 =?us-ascii?Q?oDU/U1Gottst6HMvGF6w/1lWcSfGR/GWBkTPYfULruKfdlwyYqgqPiXlcE8G?=
 =?us-ascii?Q?Hs1nzW9dgZjzUPs6Z0LcoLdM5wgBJnGDpxUDZcQ6dnIlt7rzVgUxzV7szKa4?=
 =?us-ascii?Q?/8Jslpyo5CJuZKaB17c1557tnfVP4CQ+daAUBJj4j3CpMQjGiLjvtwo9B9/W?=
 =?us-ascii?Q?mpTJJe+vrDZ5TSf7H/JhMFDMuWNuFmFVrOEnn8NeUgWRG89K+WHOqTL9FvJa?=
 =?us-ascii?Q?AJJ6TDEmZ3w72Nlp3gsx9v/s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb59ef89-7e44-4abd-d8a6-08d8f52d9f0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 16:45:56.5813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJTXKdSyMk51aTshgcI/B+i94sYkDswKM2IB5uxVgvKDkFDBXLu97+p3bqvIVAwd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1514
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
GPINT command to get PSR state from FW times out.

[How]
Add retry to get valid PSR state.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 29 ++++++++++++-------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b5e875ee9027..d8912a4de3b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -687,7 +687,8 @@ enum dc_psr_state {
 	PSR_STATE5,
 	PSR_STATE5a,
 	PSR_STATE5b,
-	PSR_STATE5c
+	PSR_STATE5c,
+	PSR_STATE_INVALID = 0xFF
 };
 
 struct psr_config {
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 15ed09b7a452..28ff059aa7f3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -80,19 +80,26 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
 {
 	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
-	uint32_t raw_state;
+	uint32_t raw_state = 0;
+	uint32_t retry_count = 0;
 	enum dmub_status status;
 
-	// Send gpint command and wait for ack
-	status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
-
-	if (status == DMUB_STATUS_OK) {
-		// GPINT was executed, get response
-		dmub_srv_get_gpint_response(srv, &raw_state);
-		*state = convert_psr_state(raw_state);
-	} else
-		// Return invalid state when GPINT times out
-		*state = 0xFF;
+	do {
+		// Send gpint command and wait for ack
+		status = dmub_srv_send_gpint_command(srv, DMUB_GPINT__GET_PSR_STATE, 0, 30);
+
+		if (status == DMUB_STATUS_OK) {
+			// GPINT was executed, get response
+			dmub_srv_get_gpint_response(srv, &raw_state);
+			*state = convert_psr_state(raw_state);
+		} else
+			// Return invalid state when GPINT times out
+			*state = PSR_STATE_INVALID;
+
+		// Assert if max retry hit
+		if (retry_count >= 1000)
+			ASSERT(0);
+	} while (++retry_count <= 1000 && *state == PSR_STATE_INVALID);
 }
 
 /*
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
