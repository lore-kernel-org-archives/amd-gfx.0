Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDCDC433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62152208E4
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 13:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62152208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC70D89F35;
	Fri, 15 Jan 2021 13:55:13 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700040.outbound.protection.outlook.com [40.107.70.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5314989F35
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 13:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjNsFXBfAQDVK4ix1pr8VDG/+mM9JuEb/GAVyl6gMcqaZV9A2nyE8WBQ5ZJmDuGudJR78nXqsQs1xzuiH7ceFKuzrYH69lUmvsQtrCIM7YlQQlYzUVs/pSWI5Pk8u4v0fpIW8ARTIPel231RJaI9z7npQ0XpFqU/r+o2D2JKNo9FdGB6JGye9HYnAMXzf8oUguy9OPCt0bxJ35TWnxC21H8X1MJHHCvIJg7Gzd0U2uJ4i9o5nSzutmK+52r4Akg8Hw2isWdqhxBe2K5ZT3d3069jDPZzPKLG69rBUMsdh5D9qRAlL20/lgn07hmLBgFdqWMQyUQxYNUSV2UMltY69w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/7LvZgHLcpbGWxOc9X/+WZ4oDHkiAnLwTVR9mQ8N5Y=;
 b=XBw24EUU5LhWLgW7xPtOHQQvjDvCGa9fAq/VSfI5Ffr3m1CyUMIDhEnskdoNiOeJLiUlYK2RZ42AOWhKaQgxkwxejO92HnUOCcpwDiEd70nwlgCp+qcftYpOz7drcOp3YZWWu4sTRjP0baUjHRakeyyJQatD/vxm0QDuEoa1RQuE88t5a95XYz7i9RFs0gEhco89U3Pom00+dE5YxucKEGnNslY+ksRZ3s27kMuhwk7HOhCCyvrwiJt4uw533Q0nUTEHN+yQZyiHzIXB2kQ8Bu1K05IV4q98taD3/mxbHuI6p3iS0x2lLSbXdHU8GJeKYRPR3Ui6MFgoiNJKAO1NSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/7LvZgHLcpbGWxOc9X/+WZ4oDHkiAnLwTVR9mQ8N5Y=;
 b=uAxWiECX1dbSI53zGBcKOzwT/nJOHX+k7iMBHK4uzGxWesZeR3tujJ24fiGTv0ghrU/XkGZHufbtXbVDrvafgrdY2eiQtlz7A2KW9LF2cPRMxq54ffuMYKEarsnOlWp8DmJn2aKflKOT2QM+795KH8vXNsEBhEXpu9LUT3ac0DU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1235.namprd12.prod.outlook.com (2603:10b6:404:20::17)
 by BN6PR12MB1876.namprd12.prod.outlook.com (2603:10b6:404:104::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Fri, 15 Jan
 2021 13:55:10 +0000
Received: from BN6PR12MB1235.namprd12.prod.outlook.com
 ([fe80::41d1:8070:766:e2e0]) by BN6PR12MB1235.namprd12.prod.outlook.com
 ([fe80::41d1:8070:766:e2e0%3]) with mapi id 15.20.3742.012; Fri, 15 Jan 2021
 13:55:10 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix the coding style issue of integrated_info
Date: Sat, 16 Jan 2021 05:54:23 +0800
Message-Id: <20210115215423.525965-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR0302CA0003.apcprd03.prod.outlook.com
 (2603:1096:202::13) To BN6PR12MB1235.namprd12.prod.outlook.com
 (2603:10b6:404:20::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR0302CA0003.apcprd03.prod.outlook.com (2603:1096:202::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.6 via Frontend Transport; Fri, 15 Jan 2021 13:55:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 115115b1-2eb6-463b-9e03-08d8b95d2c56
X-MS-TrafficTypeDiagnostic: BN6PR12MB1876:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1876E3DBEFA3781BC219978AECA70@BN6PR12MB1876.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oo1D9LY18vT+OWNARRUZ8jRJ6HShB6+osZIvhwD41NRNlaXPcM6c65JMgwWT9H4DqVXTs+BiMp3N8x/kIR6bGnibRAZrB0YV4PhNI4Bx/Z8gSstCidCkYMX4xrWmP4FXm38PoYFdDHPkxHkKpHc9TZzfDOH+qgLTXBNJ03egoAsKBqNpNu0RwJIijn7QAMeAnBB5QSUxk6LPBUQmSdeWn/pdlEohaQD0c+Mtjci6iVhxRM+acupv5ldzHtYHphSDab7civcyEUfO8xY/7SDqJVtrelzT76zYrovzEiQBbV/IaWKo7KYS7efS6dXvB14KiK7BlmUz344Sy/0yrrtT8YmOD69yDRZZMGnfROG101cdS1uezBLFZxy2y01HjVhNVil+aMifB2lwVMU3oEJuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1235.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(2616005)(66476007)(26005)(36756003)(186003)(1076003)(7696005)(956004)(66556008)(8936002)(54906003)(52116002)(6666004)(478600001)(66946007)(86362001)(2906002)(6916009)(83380400001)(6486002)(316002)(5660300002)(16526019)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?v56VdHAzK8jTyPVaG5RN7WNITo38dU8+8c7u4Mwa3b+kAKM05pEOg5Q/arnE?=
 =?us-ascii?Q?tdCgFm9/WdX/EIDFext3VUgArQ2clknAPX2hNDonFidNg1JpnTQ7g30mdqHo?=
 =?us-ascii?Q?cHJFj6wwqQTwpNM24sF0VrWmgm/X9m5iiQBnGNOA6OljSBFUUM+1MnszV68u?=
 =?us-ascii?Q?ooaTj6ySN5cnoaXLpZuAVhcurxy3fny9LgNndoCafzEvS/Kqy1dKIyOFvFiq?=
 =?us-ascii?Q?t4BnHTfsLs66hxYVNwqVF1K6vVzi/Bqsgr9/dN0J3k8pWcjdASHQVv7yEHHL?=
 =?us-ascii?Q?IMAstI9RFBQF1bvWeFxvfspd/XM0GXVxk+1fthuFyLxC2w//H2jUBbwbvqvy?=
 =?us-ascii?Q?rIj1ElmjF6znmMjnsxfccln7TLqpjl86GbM1icPnw/Jg+3fdi4vOHm6AMe3i?=
 =?us-ascii?Q?irCktR1s4nHKDJX1CPMN/Cmma1qPQSuTxXADTIrVazfBSavaA16jfv1boXhr?=
 =?us-ascii?Q?9U6cnJI1WF8LCYe6fcNlX6dPibfcuVWtz6EoszKsNkqGoldzWZ6pcK6N8MQS?=
 =?us-ascii?Q?8OqCAmxauKgvtOFlSWkcmLkucVZPh8pD1WFGNypShND02hT0W1GMwIDrTXzg?=
 =?us-ascii?Q?purzi0gtu3guTkIkGbKDXH4M8SCM4SPbJV4NWcWDsDynDXVo046kRwJgEEmM?=
 =?us-ascii?Q?z2Er+CgS3Nx3gN9WjfEUih7da4sppaVIl2+b9hef6FqwhExbMqUaQr+a0Vjx?=
 =?us-ascii?Q?W/NlEbcx0ZPyajWpPOv3BjNHRx2PnldyAoXqlZB2Txv0X6a0N9kUkmKo6ZYi?=
 =?us-ascii?Q?fCQZYlTaB856shs65Uu2Q90GdKGOEOLQxkcrMkUPh0SeHitJtCB+y+rdnRPv?=
 =?us-ascii?Q?et4nOmNj5KkrhFr4B9TFPGVdGfhGqtHqEubgZuCF4tsssZ4xrwnqMCxKxlhQ?=
 =?us-ascii?Q?dfQcrGXnu1jnA+LS6/gd028u3g4Yvt1iymJfIqoHNRUCr1WhOYoEJmcyAv+U?=
 =?us-ascii?Q?7C11oZgGiSTkjTJBSkHsiUOUlpTEXolPmIBiJs8froNU1liR+xxAHu6e3kDJ?=
 =?us-ascii?Q?ykfi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115115b1-2eb6-463b-9e03-08d8b95d2c56
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1235.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 13:55:10.4154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2akuHOzY1P8fl/fa7vEdsvXJee9IfKsmgTAY2Zo0ubxvbpyyG/9XPEyGdqoT5NEpoQKl/AECN+wSJ4eB8qq+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1876
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Lee Jones <lee.jones@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jiansong.Chen@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Follow the coding style of size of a struct, changing to:

p = kmalloc(sizeof(*p), ...);

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 73178978ae74..9885ef21cc05 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1380,7 +1380,7 @@ static bool dc_link_construct(struct dc_link *link,
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
-	info = kzalloc(sizeof(struct integrated_info), GFP_KERNEL);
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
 		goto create_fail;
 
@@ -1545,7 +1545,7 @@ static bool dc_link_construct(struct dc_link *link,
 	}
 
 	if (bios->integrated_info)
-		memcpy(info, bios->integrated_info, sizeof(struct integrated_info));
+		memcpy(info, bios->integrated_info, sizeof(*info));
 
 	/* Look for channel mapping corresponding to connector and device tag */
 	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
