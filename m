Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BF9C49EAB
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA58E61C4D
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 17:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA58E61C4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F286E4EC;
	Mon, 28 Jun 2021 17:26:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811F26E4EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 17:26:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZJi3k9MASPUzWsf69NlFWj0rrmvxmzU8maCTiGwIxMcnaBtRVwsw65/7cM30GX53Bfk0k5zJrKklVMhV0uTWn/cehKfPL2jTtf1YufH7f+lKCrpY5l9YuA4H0kKgynwbAWihjkBqo/TKvOT2HuJm6PHUHI+SaIwYrjIDcIZbGJg6sUZG3fuxf9B2eoXKcR9KWyuJu1MFyB6CovvcZxzTkh4CkQGkvOHETZz/FvOVcX/HyJDedqL7BNiWHSRV5NIpzfgSDpZ/3s3Pfxn2LKxwUNvCV+iVLmjFl2cDonww1hwvmFg4UMFaMWpJZi5XSVYrOKiuCCV2ZZI50feyg33yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNk2dMNp831GSaJ1cDxYqm8OfERcUPx+6SpR4stsN7c=;
 b=Uihpf5chxALTd/RhOTKxeuIX7Ko4DNvoxKIh4doTmo3HWBkc14CLjMe/nnj+Lk2WYDI650nH9LLTHsMdm5ZXvDOe2T9zexOGDhz47gN4EZeK+4SWyI8TlGFeRXsghKnZ2lCjLGpHb2stnrY+Ah4QNV22v1SgSE6oIL0utYMM00aRv4lBhAtOJigBmK5ShgyHb9FQnOx1VzFNT+ltjNyK/sIXzzYQOOVK396DF9+b0xiyf/c5iBrdf12NsgP1rBI5Bz95vQ5QYvzskOi1bisD696KFo8X4ffI0RyRJlE/I3b9XAyiCLL1eX8Vgbme0+JndAiEtQESfKrsYYAWqRVm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNk2dMNp831GSaJ1cDxYqm8OfERcUPx+6SpR4stsN7c=;
 b=WEk/gCAqu6tuseicNilwydwBN9YWF/wAYCD0ORhV6aSC5n/bmTj0d4pgf3IeT7BS/r4O0OqvnY/w8eFDu3PbGnPKdy/VXQ2yeeTAIs9WmYswl/xa94oXF0fyhDEjZbHNRR/5GiSEflLUqqTrbDsn/5LKaoQ1i4r1CASsbnQxwPo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Mon, 28 Jun
 2021 17:26:05 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::6034:e3a9:274c:33a4%5]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 17:26:05 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amd/pm: Fix I2C controller port setting of Navi10
Date: Mon, 28 Jun 2021 13:25:46 -0400
Message-Id: <20210628172546.65492-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210628172546.65492-1-luben.tuikov@amd.com>
References: <20210628172546.65492-1-luben.tuikov@amd.com>
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::22) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain.amd.com (165.204.84.11) by
 YT1PR01CA0083.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Mon, 28 Jun 2021 17:26:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eeb1da0-4476-4fde-eeee-08d93a59cf0c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4958EF0AC362E2E82D7185BA99039@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TDc2RRcqdbaWy58Xf/GGqTZcA2y8l++D5Iw/MgonKaubDzjmFKiXbFOgvEP98XQaEys6Q/4YOEF2WsXi45se9L59QmQlKUtFDEuzr1xvuikoPB5VZ2xhXJVFMedfhKxDo12FW1s3AQV7db0bCunLPRSsTWiISGJjxQUkk7ma7MGAB4B3c9od3Gqg9ucf/LsJoY6d+j8MgZhQU9huHQ8A7f6Qm6pjdXt9n92QEmiw2AFETDx/kEK3GnltOkzTnGtqSWvtOaWsvGdgZkJxvpEegk/1We0IVTfDlhykafRTmHK+ZkwRryhtxSbfB/+Nz59Rb+/0BCpp3EX816jvpzQFHOukmKSa8gdvUBkam1dBb1Yux7wSp5qYEFCgABqs2WBNigA6pqSwmP1k/I3T6fKTEi35+tRO5E6VM9rlCaCT1FrbbRJRJokf5REyz98IkT6IWmdU9rxRLAZPD2DLu7w3wGT1BshQRGUNQ6uigk3LMOIlifi0ah9fn1WyvjCGHL+Mh9v+FSZorvWwQOeM1onuO9Q1I4GMvBqmudZZswB3b1verf2AdsaP5P5TBZZFxv68UMc3E2QNJPny6NfdlcCEZKCpN1/xElgyF2akGbr9Uy9S5OpTxI/8p1LwR1uFnI6JStTm6OiMAoPRplIRvmIn8M9Fqt62eh96GlYEMQWMXmMfkc9E8N/QrUdnOZoChepB/jeiBDQAWC/fdKaPuJTIeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(4744005)(2906002)(1076003)(6916009)(83380400001)(4326008)(6666004)(66556008)(8936002)(66476007)(66946007)(8676002)(6486002)(54906003)(86362001)(186003)(16526019)(44832011)(38350700002)(478600001)(26005)(38100700002)(52116002)(36756003)(316002)(5660300002)(2616005)(956004)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iv3ydiHMO8xNPLikBB4nhUudQP93s+YJ7kaVPVppKqslM8BwNBP2uKsyZXTB?=
 =?us-ascii?Q?xStt/XyXhwxmoozrW5jrpjRwpe/U/j9HXiUA0QZk8QLmCz9ibf03EVngCwfh?=
 =?us-ascii?Q?qA6hpVjimWnJOim3nyTy66a1EawMs9iTMPqBa0vCXulzOEoM7I+XnejWGbbT?=
 =?us-ascii?Q?aLbLlGa68jpuabU2ryCuB5ZddqvPyoSNug3ipuxyoCvqLcqah2Yjli7xc7fP?=
 =?us-ascii?Q?a+GWX4rt4b2qndcQsTlkxdI0tiqANqLTBw9iVWUGnpg7qjl+DVeQXzLXkXZd?=
 =?us-ascii?Q?BLZvKm3MzQe+KDKFZIn1jKCHQl87NHoC5KHRyUpRx3x+6PudwuHMOPUuQY4H?=
 =?us-ascii?Q?Jmuov3wZDm4/S5a3pJC20k6cQ6BDo1DUgIHXddlT6LnrMeth+Cf7cLb1BS1z?=
 =?us-ascii?Q?h0/d7Yu315KF3AEwNliuEbdhnl0NJP2O5wwEBZBh0XY31IQq8U7rwpBQqBuc?=
 =?us-ascii?Q?gIzUElYEx0U7gsSbnxAet5oQV6LJbvTfnjEePOWUSq2SsbvCebHwlegtA0Hw?=
 =?us-ascii?Q?KP6TN39yBKvZMHrzeBHI2293ERK9Oq0rGWqapp6xTgg0QS44YNlK99H0QgPP?=
 =?us-ascii?Q?Q0ke921Ms6H/gV+bDsKKR2ojcgSJtXAAF9xNnxIJ4KiZL/7+4wsjbHVGZffW?=
 =?us-ascii?Q?bknKrqa+B3hz3GXQJssiWcvlR86kXUIflJ8ETUlVLtzPks07zjfqwjhYguaB?=
 =?us-ascii?Q?qnIEsEL5FlvrzdPdZQ+nyZeLdGOFPE7qtPAqVZV2mTEUNhL+TNqCWhQAvbHH?=
 =?us-ascii?Q?vQKCtWHZAoRGyh12ATUaQJKa8UQw4zW9YzzUZMufyuwONbMKRy3JEqbl8RFo?=
 =?us-ascii?Q?azZijclfvBtkar2ZeHWmRYoBI6LGfPUAuE0QsOCuUko7MurQPg7CzK64jDPn?=
 =?us-ascii?Q?OhgxzIlMvQgoaq+C+xJtXM9KIHAVd6AD1mKyzhCxQ6Gzz1pyXgPSjHEO76l0?=
 =?us-ascii?Q?hnCf5Lornxbs8cxUfYPQuXwS29GfUkRkstjvPAgd+IUwGvWv7yaWUu2nGSUK?=
 =?us-ascii?Q?50GjrEF2LPTE2Z1uGltvKys7hRUWyN9U2k8sBfdz9skN7Nn6uDIL/RuRGdh/?=
 =?us-ascii?Q?PC/vkPW59EKdOy+BzeBHXh5sEzptLrK2jvCAs7cp6cXyM0k8yrWPoKFnOauL?=
 =?us-ascii?Q?ErEsyJyoZhCDstZyX8ChUUX7zM203PiQkgbLJtoqbo76e+kX5S8CORWS2Rq5?=
 =?us-ascii?Q?5n1lPx4hu+YR2pFQhaFO/4MrH/Zf4mxAWbPn6BMAmbgidpTQ1zBVKAeTbTmU?=
 =?us-ascii?Q?383Q5FNPf0ZpQ0vT4OfPKXcC0syqWxePlJ8/sF5D3HvfXXLW5kzhhoujiy+F?=
 =?us-ascii?Q?U/GXMhdhwVL4S4ZjRgxfa9HQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eeb1da0-4476-4fde-eeee-08d93a59cf0c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 17:26:05.3075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tSBlLFCXyauDwbvpGNO8n8vWCaH8kPk+urOC4EotXNlcHxu0SC83GTx1kjFyUgsq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
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
