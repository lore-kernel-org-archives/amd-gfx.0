Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A92C43460
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C464261059
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C464261059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1C96EC8C;
	Wed, 12 May 2021 17:32:17 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2074.outbound.protection.outlook.com [40.107.101.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDB66EC88
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7YqFexWsG5Niw0Q9c9h90TXhrY0iqBc3oy9pw7qm6iAFCet4hzlfYtUKND4/Z8l3+KqixQmQ1bqU/PZ6oUE2xbfaIeLrAmT66s7R4KfcdKj/sBJuJlk94um/t0hkVWxFeQBgHqEEsL3m/pUq4keUrbSiOlNAHA8NDL4dIz8EOK7CaTGXMdDUJ8HEDWYSMJxxMjHrheEJQGDDxb3GuwVDH30yUkmOtB1VgdXkTegTr9S7M0iKnEqLQ/IStVZB2WHqJDm9MJPn/Cwm8j/pSVFpxj00D+6rJjtr5IrUTvcpmgMgEwNBdK5OYkHCK7ds0oOJD7MrHozosYD07kL3HHBCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bASMoLDETsTyLAyYUVjHaBdjeEk9DBctfdbe73qMZMU=;
 b=ERNnWomhhBouPrg3bVjUu2ifo/kMw+RcwFWQ7NaXzjKm0LMF5bqZ3ngmtph9MmrEa16nZ91ScBlJoBTwW+9Ss1TEjfhzshUCiJQDRNq/3ijrhlH238gKLZhMa1mBZjx7fMsfzgNbOoMwqLIKw9HG0N0PfeqMKTj264brAeDbwE1KDnEf9IPuY/gidusbVMAvVJgfgWOKmMcOraGaa7ow57bWAtFMQYoOKxnpL7knKsm1IKNlk7wGFW85vkXcYIhtRQxbSL9hXsZleb/h1ph3bUvwzUcF45rhSfvrjIBvHmrSAYY6rllJbkAFbowOjzsquAkdL44mG//CKaWjABOWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bASMoLDETsTyLAyYUVjHaBdjeEk9DBctfdbe73qMZMU=;
 b=zxk5/XQcGS/ELiFlQefsMTH3NFucM0aQOh16eA92CzJ6NUZJ1EZpsECZm6yTPX1zrY4mj8sKRcYYJO/TFxoTOxRuWgsSt5JUGzimDxVllihVsR+/TwbSUpdOBcx7YlqiOGJnj5LlrZppvkyi4fzVlUMZScHwOtNDK+qq71iPK9Q=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4567.namprd12.prod.outlook.com (2603:10b6:208:263::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Wed, 12 May
 2021 17:32:13 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:32:13 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 48/49] drm/amd/display: Enable HDCP for Beige Goby
Date: Wed, 12 May 2021 13:30:52 -0400
Message-Id: <20210512173053.2347842-48-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 989fe388-2574-4cd2-f897-08d9156bcf15
X-MS-TrafficTypeDiagnostic: MN2PR12MB4567:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB456762C314DFCA84552F5368F7529@MN2PR12MB4567.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ai3Oxwc7auU8oqxO7FOz0VeGLxAKGwvI2O/W/himtmKT84Wkl7RzpjhffxXyAhvGi877B6RFMJACW1Rp6ql+KPZg8DdwNnttt8rX4RVrO+BMYOBZeUeLTzVvXLJM180OKM6JRmHzVOPjsgbjtS2mJgtlS/zlzFPB4p87bzmoWHjkAla5uq5JMEk4A+0gz5kQMQMIxS5nRWAukx57GCI2JWFb+KRTOtvtbC9fyZcUYLfpwdvyMKBNka53QsjfBN9ljCrk7tX/BEwpn5ThYaOuQItCGYRfCgg6HvTNjAObZgDRcy+9r8TatoEdZJ9XN8BbTPZJqnN63CSWAhSwg2Ic6DFDTa3gsI41RKw0kv0NZFUAVkj6mt/ybOiCxgX4viDrA6P9K0Z7QQFGm4kxnctgkd/xb/+GbyAUPkWApas/2JkeDS0528IIpkt2aFZHbM5fvDzWVeelGVrU5c9fY+c/JM77PSg9xMAzSfxNMp/qvvsXvFhS8N1VbA1XaIhj4Dx0YATzl7OGT2Gc/i2+ana3Z1v0pF4DYvPE1aBm4H0a6w12IhypTt+kfPmyuWlbTBzvSG8/S5jp6hJfpl0SoYInxGiaTImjEB3IiobsnMA1b7RJq1GT6QFZWCi37A1Ykny7iBdZNs+U1xAziue6nY5X0uPaTkZepCzlLp4be+aaGIsr1lIo2bBGohiyBRko4Y7W
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(316002)(4326008)(66946007)(16526019)(54906003)(36756003)(5660300002)(26005)(6486002)(186003)(38350700002)(66556008)(66476007)(38100700002)(86362001)(6916009)(478600001)(956004)(2616005)(52116002)(6666004)(6506007)(1076003)(83380400001)(6512007)(2906002)(8936002)(8676002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?is+fVD84LMzbgbprV8MCNM4a5d7qfHqj7hmWEn3q6nJK7qss11NEZ/yEP720?=
 =?us-ascii?Q?1/9KhkLyUXlhwoIwnW6TesCb3mq+zPm9f4c9ld54RE+umDJu5GvOOup2Gzt3?=
 =?us-ascii?Q?12eaX6zvxP3xYVMd3rbjVrUZEy+56Bz0YwMx9G9Pwdd83XScXzDWvUIaAL4Z?=
 =?us-ascii?Q?8w8PzFDT7kb8oQS3QeMWoOXy28oCbTeYGx+HTPoTIs00V9zlAgMkPKuQ8R6r?=
 =?us-ascii?Q?EMxj8jsnL5+Be/+wCkrBu91GVW1ILKnC72Q3Qy6x+bXIif83ZRd/aetQaKYM?=
 =?us-ascii?Q?f8cSSeDvMYFCnY1YAraq6Sa9dvajNSkqy+guAYahrWeceDTPidqT3z5cmBlj?=
 =?us-ascii?Q?nHewE9ybYEfVVlggRVezBazBLw0p2iObL7Qhb2eZTRnWvDYbXj8IlyKg8gzl?=
 =?us-ascii?Q?AVi7SY4EtkFMsPPiYjxDnhcUPBp1LGqD+h1hAVLWEGdCgses45MhU551B3an?=
 =?us-ascii?Q?2FLKco5SfLfGc4mD1YDrGi7tnB28AaZjRDHSOBPkLi4JzwznEa95008NRS0U?=
 =?us-ascii?Q?iOzVq1wluQZBNo4q2EemjmYWe1hpCtuah9OPZJm7fN9Sb9Q66UhSp1vOZ2ke?=
 =?us-ascii?Q?NiAE2th3EzKUwiJhFm4VMYyahDskB1lXa2z7PKO9rQFot+UA+uCadILo0slf?=
 =?us-ascii?Q?u4XY7aSbjlzPUPx36yVq+KizfHY6LKgSBC20ys53l/6OwWpoo3ntMVrimNML?=
 =?us-ascii?Q?827hWko3p5Lf52fGHsdYNYEAJCyYKj2ac2wWWi+Dg9/sRGPkHnFMHClZU4wy?=
 =?us-ascii?Q?05jRHthsRRXBYlqDobBNVAwAwX45r2DoxbbSVbnfZ4o5R5X2Ncsl5E4R6K1N?=
 =?us-ascii?Q?wWWikXXHcdafJNRkxD/2xP3AerCuPOhSlFfxCVMvslnW3L8xZFQn9dSWSctL?=
 =?us-ascii?Q?HHUzlOKWN8M+/dLZMGeecdnwWyYITw5LLYWAmEwIP5PYDIBX5X+cVzofsQhM?=
 =?us-ascii?Q?Xxq2PeKRfUG1gu+xCUamHJg8/tAolTgZffscLdp7ApXP7khIcZy1HtVGO7nf?=
 =?us-ascii?Q?dpzFjqOgAzvMFk8xMBmqFZa86puWsN7/zVdOwsqu/ZRwe2z3sOtJKzjGZqds?=
 =?us-ascii?Q?0BgznbOX3N38UIrxkptge/kEwLMpV31kFAzqRamReI2Cn9yTw9bPLiDRUXAV?=
 =?us-ascii?Q?UssC65n/5h5RKgN15CgCtKtMD1z2q6S8/tvINNP7K2/sfMgLbp93d0yltGZH?=
 =?us-ascii?Q?vvnoSWZqCxqrQm4ZQtDc1fEYc8LYC2uptHJRFV5Uzw4uMP+SEk2Tcq9IHXi1?=
 =?us-ascii?Q?Q1gEjTxTTLpJ6bkqSg/j+b5k+N1eWtIN+HA0GJNYKh6hmsxbEjpTAnm7pQti?=
 =?us-ascii?Q?CoPXDkvTOJU587U4zDgerLH0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 989fe388-2574-4cd2-f897-08d9156bcf15
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:43.1027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IiQkmtvetb5Y+3N8DtZF7VPiGxQR7/PkhZqyC3zKIDo6IN4wkg+lNlOuGe4yPQi19B49lGxhCm25LcBBfmpgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4567
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
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Add beige_goby_ta.bin to module firmware table and call psp init for TA

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index ba50b16d1b1b..1f2e7e35c91e 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -64,6 +64,7 @@ MODULE_FIRMWARE("amdgpu/vangogh_toc.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_sos.bin");
 MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_ta.bin");
 MODULE_FIRMWARE("amdgpu/beige_goby_sos.bin");
+MODULE_FIRMWARE("amdgpu/beige_goby_ta.bin");
 
 /* address block */
 #define smnMP1_FIRMWARE_FLAGS		0x3010024
@@ -206,6 +207,9 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
 		break;
 	case CHIP_BEIGE_GOBY:
 		err = psp_init_sos_microcode(psp, chip_name);
+		if (err)
+			return err;
+		err = psp_init_ta_microcode(psp, chip_name);
 		if (err)
 			return err;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
