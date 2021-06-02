Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AD6C4709E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A2661C49
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A2661C49
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A934F6EDE7;
	Wed,  2 Jun 2021 16:51:28 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5D46EDD8
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:51:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfzogTaertNFeFIuQZOWI+0kOgXevEN/sH7bix+SCvT5e/qu7bGSYblku4+CQgKMjQezgSTm4ztKn39QmbsKYQGVGzMXzqNeNcbQEyZoX23aSwe3t2x85yLdJld3Ep3bpp87IFqk+E2xNboCpN+FJCcbF0D1HOA3xtmDEits5uxCdht9wn0W3hT5+C8KCkQpfPG5EfiDSl7oaNW1HWlzGQpcumoaVsR6ldNHZ81sKRg18rL7q9GKvGhHLn7nYS4r9eMuXrigZUtMEvSe828yBnbq2kayUmal3coH5xdadDPR5SeDfxLmTfLSiHLbqr4BFPgRW2RJ6+3+yyHtRs3kIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id1lx0PKy+RIwAqcMsfoBVRb7B8IjFGbjjYLuLtQlTk=;
 b=QfaBETaO2XpL/EsHN3P/9usOu5y9VjfupOvbNZwTTqyvbZSUCaqAGe8uLoVzSP62EmN5+8cc1t+YedAclXEGXuwhHWnBYXXaB7h22I8WNr3KDEsxhinrv4W74C2KteBsapWTnSBWksLCIZ3Gsy7bPv90BvvkwOYGVPruYM85psc/PYJ6HNwiVFYS1F5rLwkzThYgrLIuGQ4n7iuGDkalVz9HYq5QHNr0U2yKgifmvcRz588HL/yIE7xqMTNhFj6RA1XbW6nhP08kMw9cnE34fa7MzowPWDsIb4m/pMb77DIOaVvcnuGHdR03zVrqvDZ/z0LnN8JnMky95NC/FqYNyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Id1lx0PKy+RIwAqcMsfoBVRb7B8IjFGbjjYLuLtQlTk=;
 b=CP++S6aBAL4tBKxxMsOAMFQQwL84z10YCQYTCk5tmjKNOXxk001B6YGtJXFWkDyuegz7VYdY6w8Uk0pXJReke/VBN9zuma97N1CU3AFTPrhHxMn5ebUSBi0bAzb5+Bxz+2zvrGNWwHOV8K1wu0VvvOf7T9e/iRtA4uLjR0loOu0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4534.namprd12.prod.outlook.com (2603:10b6:208:24f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Wed, 2 Jun
 2021 16:51:21 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:51:21 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 78/89] drm/amd/display: Add DCN3.1 GPIO support
Date: Wed,  2 Jun 2021 12:48:57 -0400
Message-Id: <20210602164908.2848791-78-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:50:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d869c26-deaf-4b9c-3604-08d925e682f7
X-MS-TrafficTypeDiagnostic: MN2PR12MB4534:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4534DC32ADB4945F09D044D4F73D9@MN2PR12MB4534.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHmSPnAZAJ0OK49Ctc3r2UJnc8Yd6MydPFBkJGfUYxWE4DTII0gQqh6aPa3AoY2HFZ52mfnfI7X6JgCIJZ0YzGQTIZ5auQVDuNmbFMZiPeB75Wca5ZJg/yLfierxONcCxqwyjQde+oGQQq5oUGW0c0YCCsbEhUhYazwzVk3NyPqiMeBGvBlxWsMQFJL6+DcxZdCudL0n1FHQhSUXRrQhPUrmwtmRKjNIMyvkJjUUfl7J1KMYZR51FUQNjgJ/dRLAafqpyafsLdGosF1OIpPaJnDJ8/GnJ7hYEi/D3VWGiEAIRICXtTdx19IDhRMhIwyg2NIS5GOl/zZPrLCgWmDvLMzvuByL+IgkFweqY7ShAjbrHN5DJy/VwYBDKPLfC7hIZQU7By3G2D4mubwqABe1PLp1FeFcv/ZigA5Cx/J0kaoQznhiZ7f1rjiMZSogEkHtCaXc3jdzvfeZMxm5D/0rqYesy88FHJf3CBs51+EZshwtijBDfBa6tMSSnDAIPFUxa8Bu+wWWPnUP/bIWi3ntsFUTNg3PPTN7/MFB7TnKEWRsIwIDUYXGatY43rLcMJuLxKQGgfDk4/5G76VuxvLy8sIZjZARdaHpwbhFbQHyWfaUpK7D89W4/drwRNRBwdbV2F74hP1vy8LowB1sDsOzkRqlx57kyYSkajjhlV6XHSCov+gjDV+BZWxW7OHAtsdp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(1076003)(8676002)(2906002)(8936002)(4326008)(2616005)(956004)(38350700002)(478600001)(38100700002)(66946007)(66476007)(66556008)(36756003)(54906003)(6486002)(52116002)(6916009)(316002)(6512007)(6506007)(16526019)(26005)(6666004)(5660300002)(186003)(86362001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dnU8Xa1Y3tdxgQUzbcSY7e59COTgRy3IzplI2GWNwfNjugWvqvV9+D/2JNLW?=
 =?us-ascii?Q?Cg8dl7iDcrwhOCEUOsVi3GCCTOJ+w6f7jmTau30ghRokbpVLubQTvqKjQixu?=
 =?us-ascii?Q?ahSHmtptGeON0WgVQ/CZqx8VEn1XjlgnuPUjFBtrS4SnS+p8Fc5q6gfpPHuW?=
 =?us-ascii?Q?NNNa++a00nBUe9k1HjVDDzDVnxQiZr+DTMkqKtDIQHOfHZJnee3MwVe33FEH?=
 =?us-ascii?Q?8GHas78/g5IAOR1dbmwW5jZWKGzOCp/L4tyt6L61h8iqEytiQdtFmJu7OYW8?=
 =?us-ascii?Q?xCaNbTtjTmIwSMj35KBu+D35KAmR1evK9VY+inkyfwrljyWLXiJZHMCX5jYG?=
 =?us-ascii?Q?SydXW/vT/EkvJoB+O2+U3udj53kNrFXwDOC1cw1EzHXB8OAlhzSRXewhgzgI?=
 =?us-ascii?Q?I4J7GyiW8Q/VKKrTJ2ZfJ2X6kRd7zedupLROhd2ALy5scMQ1S0erwHLZeYcR?=
 =?us-ascii?Q?hkF+EpQBWt+Y5wP56t369FiICK+VWd3UTkiUSFzXoQPnbXKgu1gLVAMUeM1E?=
 =?us-ascii?Q?gvfO/JtYVSteVtpfbrbilWW5nv3YfPdenYTb4z+W73ELeVjoSapfanHPwGjq?=
 =?us-ascii?Q?PGVflkTHOxRcvoBIkciz4TiN5Q9ZnnBnxLgik+k2hD/Tjx0+KX7mqN6H6iIL?=
 =?us-ascii?Q?LTvpfs/hrJyYsI0O6/ePdFhySWyqR2A65uiHsX/1beM8QEo/RBIPMomPkqUV?=
 =?us-ascii?Q?el4ugfzgW2JDs7rsL4CtwQdqOoZpiFD77gJP1OsAyw8izC8wa/yIOVSG25fe?=
 =?us-ascii?Q?SR5+jTm+QGu3/rLMsqxg4CBlTc9khkx61BeYP8riOqTvMwpnCFvqWOmpXoii?=
 =?us-ascii?Q?VFmL9qarCXJF56HHskJWuN93BYGiZGAG+nUoFT5H8CseW4wbQ7p0GPDrZ3xT?=
 =?us-ascii?Q?jlkhBr1NaeCY0Bg1q8BWao8Wg0qHlb5EkNjFXCvjE2cryV0Cu6YrqaA4iylH?=
 =?us-ascii?Q?QBSPSpzHfXFM6HMhxKs8ALRnY2bO6RjeSPN5OL/G3sRWa7LXOlUVDI8eiUEF?=
 =?us-ascii?Q?RJ3SxQFSQDF7HPzLlK7QSG5L7Z+8ZKqE9zjWfSittaBgPqL0hZ25l3wUuNlB?=
 =?us-ascii?Q?kEBVY/xg5f/LWHaZnHv+wf0G4L/ISoSjAWAzBrXWigLDs5VZscBC4B26/FLc?=
 =?us-ascii?Q?s9mOy8fPHMuAE6Q7/IdqVe4LZV56LOmhnYT9bZftsCCTcFDYro+z3ubERU4M?=
 =?us-ascii?Q?QPMBmR48HNIQJGpJPBy3emk5IUAPOkMtcHlLK7brLjwdk37ASC0FZMjX0Hxm?=
 =?us-ascii?Q?FVtPV0HDTnjDBibyGL4ptCV+zhMJt3+bQE5MOkA4kXyq9ovf4Tmoo4JoOm1R?=
 =?us-ascii?Q?PML9Wghi3lfLmDaje84I7GzM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d869c26-deaf-4b9c-3604-08d925e682f7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:50:22.1223 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A3sfvrKVlu2p9bxcqw5ZNMUduS2tJt08arzibJCu1T92sRK0Bf4hIs+8ACxx7AYa2eDGeL+8VsK87ab2u16YWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4534
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Extends off of DCN3.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c   | 3 +++
 drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
index 5aa714e831dd..fbf71ff0a402 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_factory.c
@@ -112,6 +112,9 @@ bool dal_hw_factory_init(
 	case DCN_VERSION_3_01:
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case DCN_VERSION_3_1:
+#endif
 		dal_hw_factory_dcn30_init(factory);
 		return true;
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
index 199a9dd0e0e3..89794687f6a0 100644
--- a/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/gpio/hw_translate.c
@@ -107,6 +107,9 @@ bool dal_hw_translate_init(
 	case DCN_VERSION_3_01:
 	case DCN_VERSION_3_02:
 	case DCN_VERSION_3_03:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_1)
+	case DCN_VERSION_3_1:
+#endif
 		dal_hw_translate_dcn30_init(translate);
 		return true;
 #endif
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
