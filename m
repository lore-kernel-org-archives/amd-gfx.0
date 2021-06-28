Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B5C11F64
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 18:49:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 338E761C85
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 18:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338E761C85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E41886E513;
	Mon, 28 Jun 2021 18:49:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5C0C6E50E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 18:49:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1KXz8lJXVN6oUIhQlbWmiYIAmLKafeDIQaPB9WeIs3D8BmLou53vGlWZOrFDGhJyMWZxa/pfLxFrAXCY0EZNPInFwFRhCBsRuUQvN4bz/D7bc6rPLqg0hTDvXkhA07uu7ggglyNEvaVb2DDTnRass7kxLQeO8CyBJbZraeVV73HqqidSnD7bRvUny5KecK2SVEcug0w1mmuCxQGe9sIPEEdmIFUsfMfsea4mJ0UriKgFEf0YvZdubHK6PviLJ3F3F81gnDiY9YixYqSpl8fKg0pSwxix8xBPNExkSdMChNM4xB+wU2CvLqzRoYNGhiSx9Z6QUrESnaRAWIxOpmYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abz5QOsYtA0n+vDFyf18jnp8lwM25NkArQa3C5INWUc=;
 b=H24MXb9rmekMGTgyvDcMOleN+A98TZAD+UfE/QzCxt/kOeNSmuCZf4LrL1z5yy/xMpmKg8NN5JSzJ3QAK8fzaW+w3nCALBgYkCpcHvBhsRCn7EBxkR5OHMQRdlJ4/eRyiCsYegeWf69VUyt0aP1/fFtintZD9oFFazVcVeZO19cuBvonbFEHNeksFe413qu5EpoMOvxOOW5pB0MeZNAVwliB/iOEgbl2KdJL5jlNl64o+q1QRcI/4HxGz1shIcA7mX1R3zqcJGtMXGrI9PVugFxDYd80EX+eCspSjdxF+5LjTKqFDeM069ZYKm+lvthSWE8y1qkTvzWUSbMsQcGAqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abz5QOsYtA0n+vDFyf18jnp8lwM25NkArQa3C5INWUc=;
 b=PP82cW+83Mu52vfX5HNHkw7UVBq1w2BgIzaSlpqqBnDXJ9g96nQpWBA6zSpkNUGkODBUkbkW+XrofrPMjACDDscwd141zgbhiQ6lWEDo/Q+XQ0lhuTUMW3mFOiAjAgiICBw5uIUnWytdKPEGRJ0k4bOgEpRkuSubEGk1qBRwpQ8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Mon, 28 Jun
 2021 18:49:03 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 18:49:02 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/pm: Fix I2C controller port setting of Navi10
Date: Mon, 28 Jun 2021 14:48:36 -0400
Message-Id: <20210628184836.84530-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628184836.84530-1-luben.tuikov@amd.com>
References: <20210628184836.84530-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::17) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.amd.com (165.204.84.11) by
 YTOPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Mon, 28 Jun 2021 18:49:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb06be2e-b8f2-4d94-6df7-08d93a6565ef
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986F0F67F992A3E2C7990F599039@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I50tK7FJ2Dn2Ozk07BnQ1RTYi1yu80XFibmXCaZSjAsOl/odKQ4+jsJEO9kkzIKKKeUpj+tSTmFLMzNszqLJpxMZJcepe1ZttPj989/8A2Kc1pFB+s78qodVW7NlNKcAb5v9RZfbIAsQ46IVi3z7FeaHpb0Z21rUG2ZIVISEJ6DA1C+vzpQZfjh0QbABmpwFgsfBk5kGRtQIyvFhOyFTFKoZQYGkCdD8Eg/x9O53KBZ5cHkh1T+hyO/35NevWBNgLLeGrByCWrLC12LEAhUfbTdDU0gX9yJTikk2dfPqCOqVmO/crHIN0PErxcSKoVfY/joKvUIKr4Onu2iTil5inSZcWGZ+HUGRC7drgdmfaQ04gDXEgelUGJNii1hOmkELdl3p79aqC3I9Oyvb5MR0qybuH5X2mMf/g835DaYyBfffW4CdPJbgPKVJDqKZNuZ4B/NNN3WBzGAD53/CGPA/0ZRoKWXKapW1wF7KyuCplTyMz39xiebGmGwUThEfttBpENa3VAc08GxcUGW9n+cZMnvhNZhna93aLTVdcUogZPB0cnLOU6+pbrlPq9irwOfL3uwr6ynhaUIRe7AACMSgAHFO6l2ewq49ESU2IJh9Pst19G4xQX4jVX7gOphQfEAQ4BPetM0jle5cH1m4i8OWxOfr3T8Q78DmPwQiZns49NZY5q2+ZHuteWB1NPIccpJIqRWk2faaVdGnnF+6OgQ7shHhNTfpJU+6IQp61LzKioM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(8936002)(38350700002)(38100700002)(5660300002)(36756003)(186003)(8676002)(26005)(2616005)(956004)(66476007)(1076003)(6666004)(44832011)(4326008)(16526019)(316002)(54906003)(52116002)(7696005)(86362001)(66556008)(66946007)(83380400001)(2906002)(6916009)(478600001)(6486002)(357404004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mLSFcA60wAESNyaRoN74GZA3fdwlWBYmltpRpX9Kt7b2Y3YPCaGTaIgVK8oS?=
 =?us-ascii?Q?PdU9bX9EzAsLp4QH29JrF2AGfOvNCrmOZzWIZhDCjKSU+PJ4ao6btlXRGkw2?=
 =?us-ascii?Q?7A/P2Afu8wNEPpdzP06VJetrpyk5mid8RfYm7a7X3tIDD6oR9F5qhnxKVKdB?=
 =?us-ascii?Q?ffTKcrntuxL9s79SvV3hifHpBgdN6YgKgeB8FTRu61sYcawF3ade20hk3+7K?=
 =?us-ascii?Q?sc2fJQC6UiNLG5etsSRjboz7vGqeAOkoW8yS/n7jkG5Y1BAsb+SiFCb5aaEG?=
 =?us-ascii?Q?ZohV099LBhn3kYHNcpiHFdoPpl/ooZ60xG30S8EwAWq//70DIp4d19Dp8GjR?=
 =?us-ascii?Q?Dn2ATyINHOS3BBp6quN++Kl3ofi8QGh3QhC4FIsw2hUkn86cLQbWLkxiYytd?=
 =?us-ascii?Q?hMpv476dgL/ITqcESx3JgO/1N24pNRfNAyrZinKbSF5hdZkQvyKRBvZYEK6S?=
 =?us-ascii?Q?iyA2U8iMEYWd5xzjlpwWP2+d+ux5ZFupPAs/Aw/KgYSkecLemhOUjL/R3Fu3?=
 =?us-ascii?Q?x/1TFRhEYplNLO1nPinMPuxsvHo21rotNXl9NUWrU5I6jueU2+mOjvrTaKlx?=
 =?us-ascii?Q?k2i88mGjGh9PkO2enIGswYCAnMJzQoTwAJwS3h4LhYKOpBoE9CelI6J4QVkL?=
 =?us-ascii?Q?X7cbWzxQ2Jr94hTIWrIaRIcob0QaY/LVq5UkrTOliiF5Lj43rb5E44eFMCV6?=
 =?us-ascii?Q?jHgjCCc2kOMF1zAaKo4nTtDkth9iryerh+NTd9FcYBcb+UO759m8R2gdQRP8?=
 =?us-ascii?Q?QkM1aWjeDyOyblOgJpoLa0IOHha3Tc5FOAPLjHeLXezbflb/EoUMJAIR+ehC?=
 =?us-ascii?Q?dOmwDgFqVjUavKpbTD7RYvkThtfGnGTgoEoFKz/+LclBgLYSLWvr+8eIrZ/D?=
 =?us-ascii?Q?rb7ZW453q/GMRMnCqMkGZRV1/Pv/B7wly3QHls2cqI0M5WmCOb0syzRrkiE4?=
 =?us-ascii?Q?FwMjhHJIyrJRrZj/7cYHjUvqM98cF0l74Yibplr2cKGRkaIcqaiOUoWT+4VT?=
 =?us-ascii?Q?BPUFxiVnSLQy0j+t2IPoare9oH8rfxX9z8pNuxlXj92ubXhDUUmGnCqQdgwo?=
 =?us-ascii?Q?gi30oA12JItpZG42XzUP7TBNZo2lrEydXp6OWPqsSFYQ0Q0acZnY817U/UtG?=
 =?us-ascii?Q?ndNVaS4hTv4iXvvX9qVTGtCIe5TVJBDtqXF+zOqcFR59shnTYPznKM5HLnpB?=
 =?us-ascii?Q?wm8j8W76BmZ02iiu95Y/b4QSc/+YTNaNuzKmWSC9vW6Za9l3oBW0WrbqlPby?=
 =?us-ascii?Q?QxRCkWgHCcXHMJblOZJi9Sfe5XGQio+kR0DCPKNP+xQK035RIIa6ry/GHrSX?=
 =?us-ascii?Q?PF/5+70Ql8hI52kncuoP+/2E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06be2e-b8f2-4d94-6df7-08d93a6565ef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 18:49:02.8962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S8WcuUHLvM9D2irC4hX737z9wlJBTCdm1FueHWIPYG8MxSydYG2h3+3Eudoglmx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix controller port setting of Navi10 from 1
(incorrect) to 0 (correct).

This fixes a previous rework commit which
introduced this typo.

Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
Fixes: f3be7dda30f4b0 ("drm/amdgpu/pm: add smu i2c implementation for navi1x (v4)")
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 205dc2e56ab199..36264b78199620 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2749,7 +2749,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 	if (!req)
 		return -ENOMEM;
 
-	req->I2CcontrollerPort = 1;
+	req->I2CcontrollerPort = 0;
 	req->I2CSpeed = I2C_SPEED_FAST_400K;
 	req->SlaveAddress = msg[0].addr << 1; /* wants an 8-bit address */
 	dir = msg[0].flags & I2C_M_RD;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
