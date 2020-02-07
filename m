Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D6C04EB5
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F0520720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="1xJTSXod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F0520720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C14F6FD03;
	Fri,  7 Feb 2020 15:50:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C20636FD03
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiXqroYxrQtMI/AY5crNHfymI6mI/V6rg/hrf0CwZL5X/8fRADqdIJkkfISUDj9MwCqzt5YJ+95WRtkn9WGMLxN2HhvyeUS/5+WoCf4VJp+ILHAfAJrAR7d7YjUCIyyjZICcqBfjW0UjS9c2mW4WaZB1jZHflaCEHzmwb0iK8rfYo/ZMIzTKeR+7aOWLo1TXo6V4INWGPQPvBl1LiMmBFCyJbClCYEQ7ab6G104dd3eLLWU/KK5DRIk/pipaXeTrOWrf8a6jSUaaq4KcF+1IjUhIhgNcC455DhUq0gwFueBLNeV+IXDQaUj+sNgfRk+i8dCJhoOCNchqyH/xJYla+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKfgOrPZKg7SUDRMDibIrzxEqlrwfIpbggpnqCe40aU=;
 b=HMPtztGU5WAsW7ePzufun1WHW0GslasP6oefHCcxOtobPELrU1HkgY9F4671/5Mg0BVjakkUXKRXe004cpnVAKkZ+eijf9wKfZlAtC3i5ikmOS+QWzzGR4M5Fpt6UgwnfZAvrEMDx5haNr1EG0I5uCKi91vqXJo8lmGR+dOC6uh8Cn9xD458Ug1ToMmhmn1nWatf+4DTzul9viuQ0gcOHZiXivca24XVTj9AanPSCdWbLYaqZr32vYh9DKWmME2uPDsYkZ+IoKrOVtpJcDvRjFJCcPc6b3PWTFvUB1dNj4oUpd708Tr+4jBXXTxFsd5NdRHkro8X1za1SYuKEQd0IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKfgOrPZKg7SUDRMDibIrzxEqlrwfIpbggpnqCe40aU=;
 b=1xJTSXoddxb3He1SVnR+9i8U2GzPUHY1MdOz7gN7Z0fhmwFWl5rlWTh7xOLTN9Jnd7HavFafPDGibQ2c7t+2Yw8d+h57MdLRfLFhDU2jg1PnksDtR8t8OZr0+HMVM3tdV2h8ZK8fHMNTfixp6INh33p9JOBk31z7/FuFfQ1MKuY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:42 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:41 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/17] drm/amd/display: always apply T7/T9 delay logic
Date: Fri,  7 Feb 2020 10:49:54 -0500
Message-Id: <20200207155010.1070737-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:41 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2171ec56-e73d-465c-c239-08d7abe57c42
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24401178AFFB9689D3797F94981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 15gMXnsU+sQVK3l7lU//dKGuxFWUJgkiqoBGVpiTO2uYVoi9wWSrccvSH5Hd7lIf/CAq2jAfIvYqfEsqC15qTcHFupwrbQsya7MXPGLpbR/AVm+y1ya3//MLvWZsNpg/M1jfkCAxKtPZxys76mnlIPYqmwCC5b5s9Bf6pa2zgK1HMmwHqPPa45+JmEBNQKYbEhSwUkRX35YRjoNPa+HsHdh9DBQFqx2l30zakKdpCSP0PNcU4i92wCfbEyKi+VpO2wjgiN8FNkbCtg4EIjOCZ0Vs3N74yFE4DJnhqu2ihXmFFy9n8FQIpr0cFddBwnFVB0IdoZaLDKYVFl4Z4faY0gC4b3xdupCU75dJHNlRsGh5x5xduNMELH3m9mUTCxd1sHtBDnT61XTSR95vHF6iL1Xz7Cn4nBSPOdGqc18b7EsqwFEXKFlw5nmtyyK+66t0
X-MS-Exchange-AntiSpam-MessageData: uLGtoGnFlIz8f9piPpjZTwd8vmM328VZOLUwtAVBrQNbZJuVN2Zu4XfDZdF4Jqgq3sfGIBTrCzopY7lzFyRPCbMVGzSIoSAw5a2nYBsS+j7EUWKIWPDsPuRAx4U4byi4ghjd+aHFgP4ks3h2EH1+oQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2171ec56-e73d-465c-c239-08d7abe57c42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:41.8973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGa6PIsO1NPTgymVFA9gfrdzDdtevk0BmKVGiMX609xcG+g/OW4cWJP4RwiotfpRyZroOdDTIBIyDsKpY23bXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>, Martin Leung <martin.leung@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
before we exit early in edp_reciever_ready if we detect that panel
is not edp or below rev 1.2. This will skip the backlight/t7 delay panel
patch.

[how]
edit logic to ensure panel patch is applied regardless of edp rev.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 56 ++++++++++---------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index ddb855045767..58634f191a55 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -153,18 +153,19 @@ bool edp_receiver_ready_T9(struct dc_link *link)
 	unsigned char edpRev = 0;
 	enum dc_status result = DC_OK;
 	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
-	if (edpRev < DP_EDP_12)
-		return true;
-	/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
-	do {
-		sinkstatus = 1;
-		result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-		if (sinkstatus == 0)
-			break;
-		if (result != DC_OK)
-			break;
-		udelay(100); //MAx T9
-	} while (++tries < 50);
+
+     /* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+	if (result == DC_OK && edpRev >= DP_EDP_12) {
+		do {
+			sinkstatus = 1;
+			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
+			if (sinkstatus == 0)
+				break;
+			if (result != DC_OK)
+				break;
+			udelay(100); //MAx T9
+		} while (++tries < 50);
+	}
 
 	if (link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off > 0)
 		udelay(link->local_sink->edid_caps.panel_patch.extra_delay_backlight_off * 1000);
@@ -183,21 +184,22 @@ bool edp_receiver_ready_T7(struct dc_link *link)
 	unsigned long long time_taken_in_ns = 0;
 
 	result = core_link_read_dpcd(link, DP_EDP_DPCD_REV, &edpRev, sizeof(edpRev));
-	if (result == DC_OK && edpRev < DP_EDP_12)
-		return true;
-	/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
-	enter_timestamp = dm_get_timestamp(link->ctx);
-	do {
-		sinkstatus = 0;
-		result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
-		if (sinkstatus == 1)
-			break;
-		if (result != DC_OK)
-			break;
-		udelay(25);
-		finish_timestamp = dm_get_timestamp(link->ctx);
-		time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp, enter_timestamp);
-	} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
+
+	if (result == DC_OK && edpRev >= DP_EDP_12) {
+		/* start from eDP version 1.2, SINK_STAUS indicate the sink is ready.*/
+		enter_timestamp = dm_get_timestamp(link->ctx);
+		do {
+			sinkstatus = 0;
+			result = core_link_read_dpcd(link, DP_SINK_STATUS, &sinkstatus, sizeof(sinkstatus));
+			if (sinkstatus == 1)
+				break;
+			if (result != DC_OK)
+				break;
+			udelay(25);
+			finish_timestamp = dm_get_timestamp(link->ctx);
+			time_taken_in_ns = dm_get_elapse_time_in_ns(link->ctx, finish_timestamp, enter_timestamp);
+		} while (time_taken_in_ns < 50 * 1000000); //MAx T7 is 50ms
+	}
 
 	if (link->local_sink->edid_caps.panel_patch.extra_t7_ms > 0)
 		udelay(link->local_sink->edid_caps.panel_patch.extra_t7_ms * 1000);
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
