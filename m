Return-Path: <SRS0=cmay=4C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45D3C2BA83
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:50:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89180222C2
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Feb 2020 14:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ng/XHUdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89180222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FA2C6F950;
	Fri, 14 Feb 2020 14:50:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DFB6F950
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Feb 2020 14:50:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ol4x1FXsGPLBxbL3PHL9Y0jMGCf0cdmaiMWph7W7kpIXZPR1d/UQqpqIgfHm8Kyok82rnVlpz/d5RYSjrYHRyVDpBO6Pzu2QkOIxKUZNFp7kOmMjV0OyzwwJLrHmV3aM6gnbeIb0HHeDaPfTIjzlD3asOvO6E4PHnqp7m4CS38HexlbMlWueoT53El/YKbo+w3VxEE3mxWO7RTfWGpapueUdNgtw0Aauyo+rsbOA5xOYy+2blOVowyvWHqDqTdJt5rgQXRHFh4BGqTjeR5BWIV+W4BcZEcpEyZ1MokDTS+NBIu4bTaGhUN8rONlyhUa2TCTKZvd6Pg/4Ov1oTTcdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acS3qPmGQCvV7Dc4H6Px32+ehMxv2qPS0JrtozVk6jc=;
 b=SZ/L2Qgm4Za4CCoOmqbU4KfEkbO9+wnxY7U71D7p48AEfhOoxVtQBMpoI9EWMsJgBQKBayJmODpnslMqT+vw8yilFX/Ki59Mr75LYsd9HAMdxj92ojp928tbYJgluLxUZeGaBKUWPNf0Fj4+BtGYz/sCslhYmIEn2/CRrtdBd/Cec/0It9aJRowbq9WqoAGntilIwRHtTpUsuUIc3f+wmftLzuzZG9xqW3tIYnL9sZxqS+csi5lWM0dRwaEVBBFjs2q9t2eaSsz+9roqIh5YufZKpJFD9kjrmzl2cx5bd3kWJ1PkHz5w28PawZMq0J5mYO+U/6g9W2lbPMEGemvOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acS3qPmGQCvV7Dc4H6Px32+ehMxv2qPS0JrtozVk6jc=;
 b=Ng/XHUdP0MoF0X89muv4wZskZm/1q6aoBFdHBg8KscvYQLH7xsRycFQInJX/VDAj38M9xsyro5hUkOJ3Jy24a+bo1JPirDq4cNwqORSYipeVRK7QtUXZ8A4dMxHdS5l3LK+Lspqmtz0gVHZXV1DvvTRgMtYyVNxjXpogs7OFGf8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Xiaojie.Yuan@amd.com; 
Received: from MN2PR12MB3087.namprd12.prod.outlook.com (20.178.244.160) by
 MN2PR12MB4096.namprd12.prod.outlook.com (52.135.50.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 14:50:53 +0000
Received: from MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d]) by MN2PR12MB3087.namprd12.prod.outlook.com
 ([fe80::b93c:2786:619:c02d%3]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:50:53 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org,
	tom.stdenis@amd.com
Subject: [PATCH umr 2/2] print data values for WRITE_DATA packet
Date: Fri, 14 Feb 2020 22:50:34 +0800
Message-Id: <20200214145034.16582-2-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214145034.16582-1-xiaojie.yuan@amd.com>
References: <20200214145034.16582-1-xiaojie.yuan@amd.com>
X-ClientProxiedBy: HK2PR02CA0178.apcprd02.prod.outlook.com
 (2603:1096:201:21::14) To MN2PR12MB3087.namprd12.prod.outlook.com
 (2603:10b6:208:d2::32)
MIME-Version: 1.0
Received: from c0.amd.com (180.167.199.189) by
 HK2PR02CA0178.apcprd02.prod.outlook.com (2603:1096:201:21::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Fri, 14 Feb 2020 14:50:51 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca63106d-26d4-4a49-9b84-08d7b15d4a09
X-MS-TrafficTypeDiagnostic: MN2PR12MB4096:|MN2PR12MB4096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4096CDC8DE476E340102EB3F89150@MN2PR12MB4096.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:78;
X-Forefront-PRVS: 03137AC81E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(346002)(376002)(366004)(39860400002)(189003)(199004)(6636002)(478600001)(81156014)(81166006)(2616005)(1076003)(8676002)(2906002)(16526019)(8936002)(5660300002)(86362001)(26005)(66556008)(4326008)(186003)(956004)(66946007)(66476007)(6666004)(44832011)(316002)(4744005)(36756003)(52116002)(6486002)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4096;
 H:MN2PR12MB3087.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ISEHe/MGUvie+7rlGmO+vA1sDqekglFAWUMrFl8XEautxPSxVmsHGoQrztInmilkKA+XUbv3QOV/PVpLh650qOUPLdvcJLvv9sfSnN7MN/14uh6CJkvtuVDMBP1Mci7F8s9P2pT4BLxW05rvGXxBVW/XwikCujCgjaLtytE9WkVJ4OrAWmtrvBdMfrcHzZDpjJ1MQgNaJuYmKgrCyWDp4gIHi877mFInvAs0Fledhmfv2xEVg+9HzbdWf2AvBivwQjkTXTXE0qgHj0+EXVM5icASwY23w6wHv0ABnLsfL1hUjyFZqQPtZDDVFI4Rl1mr973+mscwYEV611A9OXJ6AoWus3iWAJouVqHwZ5rKJ5HwuPPw9ZUIulDxMXN3SAnguA0yTQYazdfbE6w92UDOfYfXqenzAfIYuCOe1XfLauzD9pi8CawAdBIKdKx0atoP
X-MS-Exchange-AntiSpam-MessageData: wAM2jMybJm6T7Af1UeIc/4pGqhQDwqiUGpQiJAfdGaykdM7Tm8pw6u9w4qhpgEwef7DcY0oXDZV6h8OBOKaqQDV/JrLvm0Lfk7IGJxsTYhP+n6OGEWoQvNSoW3OmfRY3APmPQbEMQatxLI3UV4lAzw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca63106d-26d4-4a49-9b84-08d7b15d4a09
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2020 14:50:53.3989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cHR4Sa9JhJmVMuxmVCyswftK5RPyeZMlW4E6dc1g+chijVI3321gtUNYy3Uvyhq
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

Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 src/lib/ring_decode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/lib/ring_decode.c b/src/lib/ring_decode.c
index 863cb4f..47256cf 100644
--- a/src/lib/ring_decode.c
+++ b/src/lib/ring_decode.c
@@ -673,7 +673,7 @@ static void print_decode_pm4_pkt3(struct umr_asic *asic, struct umr_ring_decoder
 						if (!decoder->pm4.next_write_mem.addr_lo)
 							decoder->pm4.next_write_mem.addr_hi++;
 					} else {
-						printf("DATA");
+						printf("DATA: %s%08lx%s", YELLOW, (unsigned long)ib, RST);
 					}
 			}
 			break;
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
