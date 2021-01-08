Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED70C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BDC23A9C
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 21:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BDC23A9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1C76E8D0;
	Fri,  8 Jan 2021 21:50:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA2B6E8D0
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 21:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlH0SOLKZPcLEpiGO7ZizwnnamPMPD2Q5gjeW8q7WKkkaP0/T5PYLLIrlNlpAam4Y5I49hRZEDixaOAe5jkrkrhj3T4nQeD9WZDi3Da0CGVBdQljJuq1kdUhdYVv2PDN7PHmIQ3HJZwGLf+tpZj5tQiJN3KaDd/cIr0oxRm9IsOquyYpNL8Ulke/TsihwvEos3yA/W8xri7fG1C3gdN8O1e5UVlYdYuzuAMOWmsFETl4yMvPdMUvADiKtLDYTHwOZGBu2QOZzqhu+JPRXuXpRUKBl8qbaiIS/wtCaepm9Gzh6pV2Q2jYNnoTU5rjVxWy1PlPSswQclHXyG/gfIgZGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUoOJLEjEZHS8+Viu8uENcJ0UkgFhsdJutfwm2P6yGg=;
 b=OfbRtt2KiXIsNlVtyzKrOs69gw0JxwbFQFsj7v+ttNtwPPuWk39J7pUp79zSgF7gie8yk6zdFiNBKuDijYjAB1FIcAPez1bl5bqpTjj7rUAdLeXSJ2JJXV4aU9m5ZUAKWch06vwZkp9dBJfCX5uLXWjgEXCls2vHdXYTvoU5604rLyKOnjsYV4hFsIlNwP5qWfW0EghTjaQVmzC7bqFGSqQd7kX6HDcFH25u3FoMwBnCMXYBqk8ozafBRKk1hY0df0WcG8gBngXacMlU4ETA6WqgYF2vHC92Qrt2YLwSw1zIhr2eMUQmKP0gLXo41z1hZAsyBd2SR0KneylYNWONJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUoOJLEjEZHS8+Viu8uENcJ0UkgFhsdJutfwm2P6yGg=;
 b=1JxLKnFfdMwPA76B90VtoFZNSlkbMXXYgzeKpcb9xXt2jGJjKtmroOzizP/FolWTQTLGdQ0dHLfQ4EJX4YefPFoVp3oAV3cYiFJJAfILJkvJnCbIn1Ige3x6Ag90g2s3WkeRxNFd+fehJ/3hdP2bI59qoUcQRTKD4N5TfiASLAQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1882.namprd12.prod.outlook.com (2603:10b6:3:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.8; Fri, 8 Jan
 2021 21:50:31 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.009; Fri, 8 Jan 2021
 21:50:31 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/21] drm/amd/display: 3.2.117
Date: Fri,  8 Jan 2021 16:49:47 -0500
Message-Id: <20210108215007.851249-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:691c:c3e7:a457:38d0]
X-ClientProxiedBy: BN6PR19CA0063.namprd19.prod.outlook.com
 (2603:10b6:404:e3::25) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60:691c:c3e7:a457:38d0)
 by BN6PR19CA0063.namprd19.prod.outlook.com (2603:10b6:404:e3::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Fri, 8 Jan 2021 21:50:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 380aec5e-54e8-4eba-73ca-08d8b41f6b4f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1882789ECECD46AED3A1FE3A98AE0@DM5PR12MB1882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jINw+RIouFIT4DhoykArDChJIcfO+I2DyIQ8oni4IxDLIRFAdQDKiO38bpv8O+Ei3f6RpS7iVCwMHXssjhQbAmk9W1aCmhy3Jcd47kAshEwsqreNiyilNLOZNwF29mKRMRi1ZdUSeSbY48FfuSameWxqdsnmXXZVMOyaqeOSfajQyhFBhkrAePpRajpZ2RAii+97po6JM9GbK4kBgvOYO7ZBhVQNBngHQy5nU8W6/Luqa2NQ9/OxxrPlusmDm5Q6+Ib/QahS0GtS8iQNo/oO784FIAkEkKepfjCcW4erUmEf4kY1S0hPa49O9ADWSbwh5wjZpdINLIpq/o3m4vQ0d41WyGNIEaED+40EcB5TRL3+aQC8xZy6bajy6qncGrqCcmiQ8dvu+bAyeGKyBEUMxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(5660300002)(6512007)(478600001)(86362001)(4744005)(66476007)(6486002)(4326008)(52116002)(83380400001)(6916009)(66946007)(66556008)(8676002)(1076003)(16526019)(36756003)(2906002)(6666004)(316002)(54906003)(6506007)(186003)(2616005)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mXIWqBojwe3vTZxLrwE+KpIQnMy50NmbGY2dB2wr//U+A/nTueAaf8K6ZAKB?=
 =?us-ascii?Q?9A4185FcAdS2n49ceptmX6yD622SlZfbnTbtcYYdvUV1vQ6tWm0KW20W+uH7?=
 =?us-ascii?Q?h1sVOSO7NwD/SqWlNkhnSfE3+O7sughYBqd17b2G58/dy0E1zE0XQNi1JKez?=
 =?us-ascii?Q?i4BamhVQ2n4xR7HQn2RQAHl/jhvEpWTWrS9e9ZHnxoPW4A3kKf0aS6d1i3nL?=
 =?us-ascii?Q?k6RADSGFcknsxdu44VnqpkmblC+4i4rdrhZFH3dFDpyvAZAZ3C8Kfdqudhrs?=
 =?us-ascii?Q?2AVXZNh0URcjqgogefnzbVQRS+M3JVlrW/GKZKoFR4bsO8sgcvJuuyD5J3aZ?=
 =?us-ascii?Q?1IpdTArSYCv1w2fEz9XNYs8HP+jR9QDUSpk62HpAZc6yf5BdFjGVz3hpBOsy?=
 =?us-ascii?Q?NbB79QP3e8HkxwDrUDk7/9ZP3/tIVaPgdLdEXHKpImIKtfBvvzzBFjTMSWnq?=
 =?us-ascii?Q?dsCg/kk+pk3l+wP/puRVLJTO19VAt3ujALOZnnMEGGFZaTCTUjEGrxNAR8q0?=
 =?us-ascii?Q?LAApO6pOnYqLECypyibr87L8EAcp/Cj5xx6Tn9aDAAYRLk8E5UrEDvmrxtFF?=
 =?us-ascii?Q?C2+WlCfBhhmA4HUpEv5Ybn58fFX+jmGKJ7PlfDcSIh/smuaZ7vw96blFKNJQ?=
 =?us-ascii?Q?UOI1llPZkXdkHDtn+cen7KlRiS8KsdMy+/svubytse5x4IGaOAGfCKSM3sgm?=
 =?us-ascii?Q?asOofaYXC+8DoCJhGjmC0R2MctMvwcBWaFMm/k2/kcPg6W99ViHSgmtPDXh1?=
 =?us-ascii?Q?VEIHUiexYHNuNemz6HtCtW/K45R4MsKatjA8rKRrIdalQ1+R0ndiHu2T5gfi?=
 =?us-ascii?Q?gQ8n0HmyGu1rOFb8EQbH4tlLsHfUWknt6oeAj1HRe77esUJ4i2mFwq4Vhe/h?=
 =?us-ascii?Q?5plKqozLrY+f4Xo7gsF9yeR4oNe7e+WCFszAT4K+FnE4EyKuexpB6CCdMs0x?=
 =?us-ascii?Q?i9BPhU5auN64c1N3phsFo3PjqC97lmPOXKIaMDvl1n2+V+QxEaWIqkOv1s29?=
 =?us-ascii?Q?9nOT0K060BppUxQQROrJPSEApNQrs1GQMtuMZJGdpwpYVx6hynIkQdtTS3xB?=
 =?us-ascii?Q?nZmSjX+y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 21:50:30.9010 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 380aec5e-54e8-4eba-73ca-08d8b41f6b4f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UDNHp3FpMdgCZsdF/5fwQ3vjNMhRNmNbjFzwEOmwx32uAQe6pLSrDpUvCysimvnX1nZkWzr0tzrSrRVU+XATg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1882
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 90fdddb72e3b..38a962bc28f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.116"
+#define DC_VER "3.2.117"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
