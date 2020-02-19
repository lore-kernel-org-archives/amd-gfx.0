Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EC0C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2BF21D56
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 11:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vaNLKnSs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2BF21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B776E16D;
	Wed, 19 Feb 2020 11:27:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930E16E16D
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 11:26:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K42j5/VP6DJH83V1tVgRj6YZKzeC2dZzXPiG3z2PbeCONbo7c1HT0slmYSmFMrHJmuJrRoU3WJElh3XSlaJ6sh6EuwYzSiRmLezQXxxzfSQVHgsxjeBnX1Z0VVrDnIIdpENBZElBK78W525//rzvElKGxwJYd2vj61OLinw5nR76KM+0qAbB6ekbuIZc1HNlulf3+mdTGfx83C4tNCZ5oWVgT83/NQ+Jaweap6lW7k/nKOANXxUBzBL+jSn4XWBy+6SJ/y2lJmbqlb9t+Lh4MPyIhzd6Sy7ePpQ5Mh8eWGB4Xg6b0pXX+X6mpbp7Tb7GOtBalIb61F5wxvv5Omq7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIM+CYTo6PrwTV6I27EHku5sVgdlfxjvUSv2lrMMWFU=;
 b=WJmtlMU67rjj6S5zAzrJHXCv824Bcpv8pC8VIcedWuCj3cWFNAzBoid6Y/xx4s6QBURyvj7OzthCVBqXMzMT8+QDZygqv8JJUpy4wwhzd5/GlutjCyQQUjQsBRx6m3ax0jwb9d+oq0yp08uhQ+pKsuWaKJdZQT6VtRCJV3c7+s7kLjhlFoU99+qsc9C90i3j/MtpZywPW2HJcKXnusCNcp16IDvMB3APKCcF6AvFvZ4alZic/Duppt3eYmve03fD8oLxk0YVXTPJLe6FIzKrzqf5+UHQYpjea2ScED0Kutfrj5aJaaxZuDnIvbRMQxHVIAWVJ3HNW5BOU8jhyXCR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIM+CYTo6PrwTV6I27EHku5sVgdlfxjvUSv2lrMMWFU=;
 b=vaNLKnSsNZUSN+acq0C1AyC6Ao9VCnSGh49ClynmroZRylrw52MwJYeAdWhmcFDHI2cmHT8yyfA+sygjgiumGre4TiouamoKZnVeE73UOs/davwW1e5iGRGs4d739OWvINmBQW+H+CzhRhbYpm2GtViYrVAQGaGFNOCHgPRDx1E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB4109.namprd12.prod.outlook.com (52.135.50.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 11:26:58 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 11:26:58 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH umr] fix field names for INDIRECT_BUFFER_CONST/CIK for
 gfx9/gfx10
Date: Wed, 19 Feb 2020 19:26:29 +0800
Message-Id: <20200219112629.6154-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR03CA0061.apcprd03.prod.outlook.com
 (2603:1096:202:17::31) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
Received: from c0.amd.com (180.167.199.189) by
 HK2PR03CA0061.apcprd03.prod.outlook.com (2603:1096:202:17::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.9 via Frontend Transport; Wed, 19 Feb 2020 11:26:56 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6700bd53-6e25-4a2f-2e34-08d7b52ea149
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:|MN2PR12MB4109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4109A7313C1C389CF74BBB5E89100@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:154;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(199004)(189003)(44832011)(8936002)(66946007)(8676002)(4326008)(2616005)(66556008)(66476007)(5660300002)(6636002)(81166006)(956004)(36756003)(81156014)(1076003)(6666004)(7696005)(52116002)(2906002)(316002)(86362001)(26005)(16526019)(186003)(6486002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4109;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XV9uq40WS6VRMHS+TlEWfVaoJcyktRTtDTiO92OqZm3kGo4bRmsKYrBdCMw6azrRMgcSeTIzcAIInTAHa334WHNP6es4/yUXSZ+Iy/2SGiMK4ej1xYqm+a4mE23A5/Pa7xDF9lHcwPJH5oUedICyq31dQCeKmAxYBcvb7YFV/jWgnF8I3Q9KFNZbCUQ+uVaP6/6Q70bilku4P6X+Eo5hdag6uqnFKSXy/IUrVjbMGonhnRFsmZxlUUs3rtoRRGXefmAlrkbnMiqv3V/uYaCeBcjHGrAv4uOqM/xiL1yKZEd1PZGTblzrKTfjp/3V5AVtybTEyPYkzHs8RpLDR9eoAA3YGkXINoX9upZ0WKbe2QYCM8FkvLrG7ZWC/2OID9ZAECTMKc1+v2FiIiAIfHxsYuQ3iRIu9l9pvarqCde0exQlVf3tUZJ/AU8QTYSbu0zQ
X-MS-Exchange-AntiSpam-MessageData: R2cxF7kWXAI4j7wPs0AkuVeZVZIbjkS5VU0wqGiGtcWiT3CyopUYFuGM7JpCwud1OUAdc8TduU12GQZbkuj4BYHDUJQ850moozCTuM9wHHLjReR2SvDFNVrmrttDtt/QAzfalJLSgkfcXOoKCtCcbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6700bd53-6e25-4a2f-2e34-08d7b52ea149
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 11:26:57.8353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gDacOcgMa33WxyV1exzEKM9AGE4MJ0J355OwHcjKL5uoBGNHke4MiSyO9vSM7To6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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

field names for INDIRECT_BUFFER_CONST/CIK of gfx9/gfx10 are the same.
fields like OFFLOAD_POLLING and VALID are defined in mec's
INDIRECT_BUFFER packet, so not applicable here.

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index 250dfd7..fa44f27 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -617,22 +617,13 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
 				case 2: printf("IB_SIZE:%s%lu%s, VMID: %s%lu%s", BLUE, BITS(ib, 0, 20), RST, BLUE, BITS(ib, 24, 28), RST);
 					decoder->pm4.next_ib_state.ib_size = BITS(ib, 0, 20) * 4;
 					decoder->pm4.next_ib_state.ib_vmid = decoder->next_ib_info.vmid ? decoder->next_ib_info.vmid : BITS(ib, 24, 28);
-					if (decoder->pm4.cur_opcode == 0x33) {
-						if (asic->family >= FAMILY_NV) {
-							printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
-								   BLUE, (unsigned)BITS(ib, 20, 21), RST,
-								   BLUE, (unsigned)BITS(ib, 21, 22), RST,
-								   BLUE, (unsigned)BITS(ib, 28, 30), RST,
-								   BLUE, (unsigned)BITS(ib, 30, 31), RST,
-								   BLUE, (unsigned)BITS(ib, 31, 32), RST);
-						} else if (asic->family >= FAMILY_AI) {
-							printf(", CHAIN: %s%u%s, OFFLOAD_POLLING: %s%u%s, VALID: %s%u%s, CACHE_POLICY: %s%u%s PRIV: %s%u%s",
-								   BLUE, (unsigned)BITS(ib, 20, 21), RST,
-								   BLUE, (unsigned)BITS(ib, 21, 22), RST,
-								   BLUE, (unsigned)BITS(ib, 23, 24), RST,
-								   BLUE, (unsigned)BITS(ib, 28, 30), RST,
-								   BLUE, (unsigned)BITS(ib, 31, 32), RST);
-						}
+					if (asic->family >= FAMILY_AI) {
+						printf(", CHAIN: %s%u%s, PRE_ENA: %s%u%s, CACHE_POLICY: %s%u%s, PRE_RESUME: %s%u%s PRIV: %s%u%s",
+							   BLUE, (unsigned)BITS(ib, 20, 21), RST,
+							   BLUE, (unsigned)BITS(ib, 21, 22), RST,
+							   BLUE, (unsigned)BITS(ib, 28, 30), RST,
+							   BLUE, (unsigned)BITS(ib, 30, 31), RST,
+							   BLUE, (unsigned)BITS(ib, 31, 32), RST);
 					}
 					if (!asic->options.no_follow_ib) {
 						if (umr_read_vram(asic, decoder->pm4.next_ib_state.ib_vmid,
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
