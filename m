Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A336BC2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7228F222C2
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nm/YiYjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7228F222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA1C6E7FA;
	Fri, 14 Feb 2020 14:50:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680049.outbound.protection.outlook.com [40.107.68.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DF606E7FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:50:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RluJoYbHF05+y/H0tsQ/ta/n1Vrf7ITbLqS9WMq2gZWevyPtCiTU5q98BT95W6Plc9bYhAswK0AxEf5JtF6LO5mEqXJCrJIbbHCYybcsFcWW3R2ldDA9sitnozsJ+Y+xE+7NBBQBKe7l+SuaaVwnRxdP3EeibaTGKgJT+poR1b7HGJunDQ32bjcSbZaSx+FjdoYewUt3hOWWB7AA509LyqNpQYKKcV4EDnRQgJFCetUnu2BnClduyTDacxfKI9Dqyv9aA5bI6vW7R2BDdJM+SvSefE3NaddLjh0cHKIHwqGH1H6pa11j4A/EHcaYZrhqm/d1iGm1wgq5tyYPMqqYtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoS+rtygZurX3ycvInkPvrMecQjgQpLZILQphGSMJV8=;
 b=SfXY5/x4qc/hhlP7Qc/CUsrFAKPz/4B8/za/N5vVVonqf5sf3jeE8tpI50BzDE1mxy6jM5Uxrc/xaBtLUhpjoPk0JYQIvtwamFIAQj8HUR/UgVU4w2OBoGFa+Tx7ppDUA583KrFlHNAeij1yS2IqwasZbW9DWaOgBekkASb02b1LoGBwd5NLeXXPLCRXUsgg8Mo2TvQbf8pYSMSy6dr3n6iQC08IjL4AtE0aRamzCSJLMm3E7Jfyi8xVvd096Miti9QjheAv+hdSnPhLDQ4zn9WyhkkqzEpuCG4Gn4VlpvN6sRtbA4GWc0ZnB46NoQ/+FRBFeqEQk5J6dM0QbVaiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoS+rtygZurX3ycvInkPvrMecQjgQpLZILQphGSMJV8=;
 b=Nm/YiYjgAjlpsofb4bv7xgmwAg2Ptw91YWBKf6MOjl2PV8xWL1US5W4y8t3SF1VCyl5NWEbJ/27+AuxEyZO1qtNe8ELXl/yCVyJElEUbVOERcS13HX+evpimzzux30GB9wruvQGpOxvZowUolyW4cwzrk65njzy79t2hfz5TOY8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB4096.namprd12.prod.outlook.com (52.135.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 14:50:49 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:50:49 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH umr 1/2] rename mmBIF_BX_PF_MM_* for nbio 2.3
Date: Fri, 14 Feb 2020 22:50:33 +0800
Message-Id: <20200214145034.16582-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
Received: from c0.amd.com (180.167.199.189) by
 HK2PR02CA0178.apcprd02.prod.outlook.com (2603:1096:201:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 14:50:47 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 447f12e6-a811-4a8b-fa19-08d7b15d47a8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4096:|MN2PR12MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40969F44E86321DC89D2B17089150@MN2PR12MB4096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:568;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(6636002)(478600001)(81156014)(81166006)(2616005)(1076003)(8676002)(2906002)(16526019)(8936002)(5660300002)(86362001)(26005)(66556008)(4326008)(186003)(956004)(66946007)(66476007)(6666004)(44832011)(316002)(36756003)(52116002)(6486002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4096;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZr+lFv7X4M4KO8BTgCSAd/EqLLrljcO4FSIMx8j6KatYro+AXlmW1ZUuYvh3btXcuT+kyfyeirYrINIjn4vzBzGOgsK6aQXMuMILSYdeX0U3wH0qolKsYtnCoY4kvLtBucZKMnPkYJtyZihxnFt481yniLHWeAb+nVsGaUxkV2S5AfCo61HlfcRTtLL1vuWk5RCfT4MjLR967cEmgrcNFkD2fG5kHIt6cUIZjSZVMnxA5SHLQvhVHaCOvfRt0GOeb5j4iu66PNaC0nEPvH6ZKUfmq1YpNrMX6zgYZHGxtMxE7UgGRKvb8Nd+c4EoWh8GFaHpxr1kfwWcxsfLeekhlwEDe+DepjTUXLvK4IlMoAj2bFOapHCpQdYtbcQDc0C2CGIjjkK4aC5VEgpPrgJU247W+9Q+W28VDlXMlbUZFeTZJChYi0XG2nb0iSLJ53j
X-MS-Exchange-AntiSpam-MessageData: tzVZTVvX2vjMNkjtawsKVyYVOIt0Ia5tMb1bs/iCP0OgMa2ylkoMpNOgGz/ZMmWPP/xWKK+6mmiGAyfANMsfTjliYfhsCLT4XvtcYNGNAtqFIfn0361aKxbeezNII3zUaO28sCxYjN3BW0l1jvxHwQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447f12e6-a811-4a8b-fa19-08d7b15d47a8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:50:49.1813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMGKaoPNEdECpVj9i0WKGMj+QJu2MqwkLeCGtQVC3PTR0QnTjPM/BrkLlH0zyRGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4096
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
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes following error while dumping gfx ring:

[BUG]: reg [mmMM_INDEX] not found on asic [navi10]
[BUG]: reg [mmMM_INDEX_HI] not found on asic [navi10]
[BUG]: reg [mmMM_DATA] not found on asic [navi10]
Cannot read from system memory: Operation not permitted
[ERROR]: Accessing system memory returned: -1
Cannot read from system memory: Bad address
[ERROR]: Accessing system memory returned: -1

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ip/nbio230_bits.i | 6 +++---
 src/lib/ip/nbio230_regs.i | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/lib/ip/nbio230_bits.i b/src/lib/ip/nbio230_bits.i
index 506ccba..fd5bad8 100644
--- a/src/lib/ip/nbio230_bits.i
+++ b/src/lib/ip/nbio230_bits.i
@@ -1,11 +1,11 @@
-static struct umr_bitfield mmBIF_BX_PF_MM_INDEX[] = {
+static struct umr_bitfield mmMM_INDEX[] = {
 	 { "MM_OFFSET", 0, 30, &umr_bitfield_default },
 	 { "MM_APER", 31, 31, &umr_bitfield_default },
 };
-static struct umr_bitfield mmBIF_BX_PF_MM_DATA[] = {
+static struct umr_bitfield mmMM_DATA[] = {
 	 { "MM_DATA", 0, 31, &umr_bitfield_default },
 };
-static struct umr_bitfield mmBIF_BX_PF_MM_INDEX_HI[] = {
+static struct umr_bitfield mmMM_INDEX_HI[] = {
 	 { "MM_OFFSET_HI", 0, 31, &umr_bitfield_default },
 };
 static struct umr_bitfield mmSYSHUB_INDEX_OVLP[] = {
diff --git a/src/lib/ip/nbio230_regs.i b/src/lib/ip/nbio230_regs.i
index ab57385..27a644b 100644
--- a/src/lib/ip/nbio230_regs.i
+++ b/src/lib/ip/nbio230_regs.i
@@ -1,6 +1,6 @@
-	{ "mmBIF_BX_PF_MM_INDEX", REG_MMIO, 0x0000, 0, &mmBIF_BX_PF_MM_INDEX[0], sizeof(mmBIF_BX_PF_MM_INDEX)/sizeof(mmBIF_BX_PF_MM_INDEX[0]), 0, 0 },
-	{ "mmBIF_BX_PF_MM_DATA", REG_MMIO, 0x0001, 0, &mmBIF_BX_PF_MM_DATA[0], sizeof(mmBIF_BX_PF_MM_DATA)/sizeof(mmBIF_BX_PF_MM_DATA[0]), 0, 0 },
-	{ "mmBIF_BX_PF_MM_INDEX_HI", REG_MMIO, 0x0006, 0, &mmBIF_BX_PF_MM_INDEX_HI[0], sizeof(mmBIF_BX_PF_MM_INDEX_HI)/sizeof(mmBIF_BX_PF_MM_INDEX_HI[0]), 0, 0 },
+	{ "mmMM_INDEX", REG_MMIO, 0x0000, 0, &mmMM_INDEX[0], sizeof(mmMM_INDEX)/sizeof(mmMM_INDEX[0]), 0, 0 },
+	{ "mmMM_DATA", REG_MMIO, 0x0001, 0, &mmMM_DATA[0], sizeof(mmMM_DATA)/sizeof(mmMM_DATA[0]), 0, 0 },
+	{ "mmMM_INDEX_HI", REG_MMIO, 0x0006, 0, &mmMM_INDEX_HI[0], sizeof(mmMM_INDEX_HI)/sizeof(mmMM_INDEX_HI[0]), 0, 0 },
 	{ "mmSYSHUB_INDEX_OVLP", REG_MMIO, 0x0008, 0, &mmSYSHUB_INDEX_OVLP[0], sizeof(mmSYSHUB_INDEX_OVLP)/sizeof(mmSYSHUB_INDEX_OVLP[0]), 0, 0 },
 	{ "mmSYSHUB_DATA_OVLP", REG_MMIO, 0x0009, 0, &mmSYSHUB_DATA_OVLP[0], sizeof(mmSYSHUB_DATA_OVLP)/sizeof(mmSYSHUB_DATA_OVLP[0]), 0, 0 },
 	{ "mmPCIE_INDEX", REG_MMIO, 0x000c, 0, &mmPCIE_INDEX[0], sizeof(mmPCIE_INDEX)/sizeof(mmPCIE_INDEX[0]), 0, 0 },
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
