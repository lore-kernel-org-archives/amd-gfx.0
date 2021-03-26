Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB4AC433C1
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 13:49:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF30C61A18
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 13:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF30C61A18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 489B56E1F5;
	Fri, 26 Mar 2021 13:49:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227B46E1F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Mar 2021 13:49:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqVCjS2izh0ccEywnIescFHIdkw5Eb7vjSHQtqf0/oeugAkKOSiGcMs+z9D4XpEDIJncxrVZhV3VYrfGuc2PTr/otfLHy9+iZnHPC/AdjlZ5NmfmRW0lprwrEAcivYOlwh8ok4D9rYDS/Ab09XlDDhmUyrOdZb4zK56QPaFpq7rtAH+Z2UVZVidiBQBYqqTdPt1ij9rYlLOsTyV40lQwIfcm+tz+kaiDNg6fugOdCeUMzazHyzcutmqy36JqnMAuRlz/nFshcU1ki0dcZLIY71j/fFPrMg12MKTY4kiUWNeL9Fq0Ji63TuAwH6HOaGo6BK3sjK23ymEg+rgYLf3/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n22zWzt+v4eDWLVQoJoLOzMJdn8H7oNu/srxwmzgq5Q=;
 b=X0dFvqEEdaXZGuBefV7m3iqIodHBasauYJBLzEJCXka5+eaNAeDMLLR9l5tPzGDI2qnl+PH0SU0qZfge7iZOeVZGQt42ROzvSW+fGBKtbCyFnY9rSb0sqv2seB5vBshKB+DH63PgtizFDA/JWKY0mfjGid0a+jjolpdjVCI6Kx2J1IDs0H0CNsz2qIXyEBI9aM/WpTTweRod08oM9cnskXX+ZpGdczZHfTQwM1lJ0oB4EEphVeqg6avdvbl6wX3+eWvb0LZ9DLtAJ5sW3nzcrXNDNHHRafqsFX5Uzmu8wr9KL0f0oCkIIlD4f9kNbU5/G9/Ox9TnCRtC+zsKaVe9mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n22zWzt+v4eDWLVQoJoLOzMJdn8H7oNu/srxwmzgq5Q=;
 b=4g4TZXNgOnMObOqL2PqQmBxm2kpA2gWVTeEFDy0XQ/QBqoJGXY+4KlizwP1xbVmdQqfJePOsfQyErDSMhI6PGVttdwK3EHSKIw3lDoKEXcc4u0LB5nFG0VmaaA+nd1PIyuMrcQgITbgOXijb5rrseIfBBWlimn45ycMJcwoQ6N4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM6PR12MB4300.namprd12.prod.outlook.com (2603:10b6:5:21a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Fri, 26 Mar
 2021 13:49:24 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::b94c:2415:ad7e:6cab]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::b94c:2415:ad7e:6cab%5]) with mapi id 15.20.3977.024; Fri, 26 Mar 2021
 13:49:24 +0000
From: Tom St Denis <tom.stdenis@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/amdgpu: Add CP_IB1_BASE_* to gc_10_3_0 headers
Date: Fri, 26 Mar 2021 09:48:23 -0400
Message-Id: <20210326134823.1412878-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [2607:f2c0:e4c0:b2::7]
X-ClientProxiedBy: YQBPR0101CA0158.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::31) To DM6PR12MB3547.namprd12.prod.outlook.com
 (2603:10b6:5:18a::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (2607:f2c0:e4c0:b2::7) by
 YQBPR0101CA0158.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend
 Transport; Fri, 26 Mar 2021 13:49:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4c20fe36-96cb-419a-a01d-08d8f05df738
X-MS-TrafficTypeDiagnostic: DM6PR12MB4300:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB430040B07FFF21DD232BFE94F7619@DM6PR12MB4300.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yA0QXawZyB0dU8wFe0J8KbfSSVGIWs4nJKHXPtVh1MKXiuKkt2lXVohXlc1GbLhLFhKhyc7Ig2YSHx6/3lq8MNKZuXiTJpWn7tb4Z52J2v4GfO0NQTeOhL4sjXtlu/Afw4R3BfoWIziZfrIsfR37Gm/gVUQTIe24fpfhlcDVvKqZQkihXOPRFFLlWArjDyCTLdnTrUJ61xMnpVl7pQvwXe+kazUieipuWIIS4FFrApVcq6kl+d6HcdxkIPv/M1eFFMLbeXYYQCkb9Yw+ShjNvlnLVwIv7Pxw7tPpoytYOX7NEpzlyuc26xKe9KbIP+Jyuam8gwbR40yI0qv5F+/8ejQyYLs7d1hGkVKXV6IjQVwg3vmkWN1pHR5JXsfflqAOUI6iSLMuYCFaOz6Jw5gzKECc+Lm8feNe6nlpl8GavUIU25zAbvVLf4muud+ztYZvuCsWTw9sQb7v8Igav6u6bQRw7wOLa4D22+Hfhw232C3kc7cDPxKVNHKRFe6wQfBsh3gX2D62oadFYIWW/1Uov2eGW6PnIF42LiN2rPlfYqt1RTxKvZ+vBeD/xbZw2LrYUNbJdbou+1AWx6TkGoNgwqx8Va12ubsuycNyDN+gl2aOTmffv5a6zU4CIXjprcdEdgqA02aiDIS8e8K+hb2jVD9Y9hD/52fa6a3Fh/7Igmd+Z7my4dUEJo0N6QDWC1XF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(4326008)(186003)(316002)(16526019)(6506007)(52116002)(69590400012)(38100700001)(2616005)(8936002)(8676002)(66476007)(66556008)(2906002)(86362001)(66946007)(1076003)(6916009)(478600001)(6486002)(5660300002)(6512007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LvJ7nVUt3x/cagtmU+QJ62I2F9raOWnPZaWsbRG/JPZMqKoswxtBj85uXfgW?=
 =?us-ascii?Q?w8sh5vdx7MTCwFjI7kTifsVgbOZ1Q50E6Eyn2g9NAKCfz6Iwqb2JAtY0a9E6?=
 =?us-ascii?Q?3kCFpYHJs/b75BL9dTI8aWEZhk/u7UCcPb4qjKwscK7tD5S2xmC1saFVSThp?=
 =?us-ascii?Q?h1YjXLghQf9ZlDDrI6I6nYdrGGkc9q0s9j2jWWFujKOo3vXe5OLgmp0sogBn?=
 =?us-ascii?Q?Xdev9AMtA+CFHpquLTfVpKpfIAm0A9SjznwMlp+v/C2sZywYqiXsHD5BvpLN?=
 =?us-ascii?Q?cqSuWkL2yMiQ9jI7WFIG4M3dh8BD3Sk8aQFPnfKz3PDbwGm95jGBYJuJduoh?=
 =?us-ascii?Q?NovxLPq2WsRjQWP/w6qTJfJvL8upa4gED9OrKwdsjWPxp0nlYeVLuY+u/8T9?=
 =?us-ascii?Q?933975Er5aRTIZoNheH6QU5/YHAfGG3Gfda2Iaw2HRAV4scv4HVoHQVf4d18?=
 =?us-ascii?Q?SVJua3eCBJ/X1UiedzW511DVV1gzV4fX7K1InV/oB7ZQ0h/WYyi72cxOSznt?=
 =?us-ascii?Q?AuvlaBkWfjv5DPK/4f7J4AGosTKUup0fRTWhWHwKEpEulFcoq+88pw8cRakQ?=
 =?us-ascii?Q?EdBDhSRmqyMbTQAHjo/6+4dreo1JKzM+7s2jNbw3IqnptIMKZM8QTWr/JmKW?=
 =?us-ascii?Q?5GF0hFTcwcXNRjKxVwgMPLhyCplwr1euDy5mOFsKFtaqqYmQmrZ63FUuqTqT?=
 =?us-ascii?Q?mfOHchyMIzq05cLzXOnxggrdWzKWrdO53q/0MegLQytLi0LwK8sPOW77fKDC?=
 =?us-ascii?Q?KnSDbL56FJoRdjQ1IpaGLsy6aUaGZYw2f/MQLfGPbG14TZhfDuSMtvB/xdQh?=
 =?us-ascii?Q?luj7wDpEBeKvsAscn/cIT4MNIbLnomyp+Il1qzeJHKAX9ppDSz3S61hbGGap?=
 =?us-ascii?Q?bV71V8gyQ4L3LHW+gzupEitiw6xl8JUxpWKOBayr4chTCgrkSUCL4/nC3ZQF?=
 =?us-ascii?Q?Gs8JrOHPwnxWdRzth+EjWuoXilJV+Ws6iaBHwAv+5eH3f8YUpqiuoq2QgIEg?=
 =?us-ascii?Q?+rYfC8QcaoveYfiQfqETU6OJ+tczf/dvzOt4DWSTzfudbDxeWN8QaTNcVYMf?=
 =?us-ascii?Q?KorGdszcgCqd289JwEUVkVD6SlJw1xmlvGo8kB8JCjelg4cezXOOhpHNDyDn?=
 =?us-ascii?Q?Ap53ITvI7eeYl+D+GrfSl23ZIqYuhx/YOSnZ1JwyWeFNw3uQiVLgXBMujn/l?=
 =?us-ascii?Q?vmKfTbHjxvV35dp50/OEb8ssmc/oqx4CDpbVpSsjZaKaNGbcU6Xu1vTKLAJL?=
 =?us-ascii?Q?AxNyzl2HM+AslJOFK1gd4PfZ8ZUUNT8Fspd+V3K+Alh/F/svXDBJFeLq16Zw?=
 =?us-ascii?Q?GaJSfuwr+TbuLrIlyotSWLzvic09x39WUfHMwNmwYZoTpQ=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c20fe36-96cb-419a-a01d-08d8f05df738
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2021 13:49:24.5062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxF06U6iIt0IswFEpVJyAFexZprasSU8tQvSVg0k0wVipQa039v/ldbACXpzIv+2dLsIYTwIKk6CRx8CaYauFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4300
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h   | 6 ++++++
 .../gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h  | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 0102487a2c5f..f21554a1c86c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -6955,6 +6955,12 @@
 #define mmCP_CE_IB2_BASE_HI_BASE_IDX                                                                   1
 #define mmCP_CE_IB2_BUFSZ                                                                              0x20cb
 #define mmCP_CE_IB2_BUFSZ_BASE_IDX                                                                     1
+#define mmCP_IB1_BASE_LO                                                                               0x20cc
+#define mmCP_IB1_BASE_LO_BASE_IDX                                                                      1
+#define mmCP_IB1_BASE_HI                                                                               0x20cd
+#define mmCP_IB1_BASE_HI_BASE_IDX                                                                      1
+#define mmCP_IB1_BUFSZ                                                                                 0x20ce
+#define mmCP_IB1_BUFSZ_BASE_IDX                                                                        1
 #define mmCP_IB2_BASE_LO                                                                               0x20cf
 #define mmCP_IB2_BASE_LO_BASE_IDX                                                                      1
 #define mmCP_IB2_BASE_HI                                                                               0x20d0
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index 4d2a1432c121..a827b0ff8905 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -25818,6 +25818,15 @@
 //CP_CE_IB2_BUFSZ
 #define CP_CE_IB2_BUFSZ__IB2_BUFSZ__SHIFT                                                                     0x0
 #define CP_CE_IB2_BUFSZ__IB2_BUFSZ_MASK                                                                       0x000FFFFFL
+//CP_IB1_BASE_LO
+#define CP_IB1_BASE_LO__IB1_BASE_LO__SHIFT                                                                    0x2
+#define CP_IB1_BASE_LO__IB1_BASE_LO_MASK                                                                      0xFFFFFFFCL
+//CP_IB1_BASE_HI
+#define CP_IB1_BASE_HI__IB1_BASE_HI__SHIFT                                                                    0x0
+#define CP_IB1_BASE_HI__IB1_BASE_HI_MASK                                                                      0x0000FFFFL
+//CP_IB1_BUFSZ
+#define CP_IB1_BUFSZ__IB1_BUFSZ__SHIFT                                                                        0x0
+#define CP_IB1_BUFSZ__IB1_BUFSZ_MASK                                                                          0x000FFFFFL
 //CP_IB2_BASE_LO
 #define CP_IB2_BASE_LO__IB2_BASE_LO__SHIFT                                                                    0x2
 #define CP_IB2_BASE_LO__IB2_BASE_LO_MASK                                                                      0xFFFFFFFCL
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
