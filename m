Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0CBC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71F946186A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F946186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E1A26E209;
	Thu, 11 Feb 2021 21:45:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5A76E204
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:44:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhwNZMXmIZEwgeIpRhlJ1ed9kHTWTCtM1DPPHZo8cNi0xGwrJONNRpwlmqwhePQE3jz6aQx2MPnZu2Afro7YiPNc0oucdzZYKys5KiLae1tp5ukOKRnlFFV0jsabXa9l2tnUB8GweanMMA7xHV0z1kZvzzFFafQnjJdQmvDHEsTZTWGYrsTxRPLXURqfzXsAKC0YEQk9DTsvmyQatfJ/Sk2DI70J6NrZ4XT3Yoo3aobwXNcw2iOaTh6zxlecBQ+QtdhgOTWU8lzeEhDZA/QroEDZbMdZa4o3PwlPQCNZ2eSoqG6+iy8PM16ES/WwdUDO2XqC7CjlveCZR+PR9zUhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAdYV9rnAz0i8V+fZEH2w4V9LfD5GXrMx+iOKZnMJL0=;
 b=cp8rWJ/CUpWZANDfkf0EP0tFy5VYK8EH+0sQSVCR448uoNgCSY+wXSQEwT+j+Bd97UNsFuoJsGKK03/jGAOZoFMwcCkQYF0r1iynn13BbGrT4h1RY3D9UkGS3tTtncfXmtGJIVZ7IUPoxvGHxPZNsOIJvnMpegeTag7Aq/1inKnmwUg0KNu/qY24KmYNeqhEyxatdG556tOnQCHoAbt6DBVt59gyVGnSBf09sA4/x7QoxXQ/c2uXfUcIMNHzw2YqR5y177kdibs0c49TqjADmWuffNknheE601E9mRafFRXYRRrnfRK05Zqpk9cRXCMoplI7475lPP8hbjGWWICg1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAdYV9rnAz0i8V+fZEH2w4V9LfD5GXrMx+iOKZnMJL0=;
 b=rN25Dv/A4FGMy4KlwMv6SLZ29LDIcF4zYeN1hE0xw70K/ea3/ko+Pq47CRiAc3Ni8unHogWoIrBIYBgaaJBlezK6sHXOAkvc2ROqqU+nh89p6Cn6yvuuL/x0hSlNHck5Y8X/iw+Xml12GrFR2/wjF75RKv5fWrBMMdvIygsHTCQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4235.namprd12.prod.outlook.com (2603:10b6:5:220::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Thu, 11 Feb
 2021 21:44:57 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:44:57 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/14] drm/amd/display: Change ABM sample rate
Date: Thu, 11 Feb 2021 16:44:31 -0500
Message-Id: <20210211214444.8348-2-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:44:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ae91e74-466f-4928-7b31-08d8ced64655
X-MS-TrafficTypeDiagnostic: DM6PR12MB4235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4235619775F1ABF066029FF4FB8C9@DM6PR12MB4235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V70weVQ4ohFQupN5z8nl+Y8vQdRCdkQhRvgooxAqpci+LdEr/Y4pq9TktRG6d7Cq3mAltWCkAquRPw0aAdb82K5woWP7iH9Cxa5pQoycpD6pvtkmF/F0FKoARgJ4BVneFOmARYA3U40yqsXjfkn70yUR6nNyHZbIipGyePf8oSdhHFZZWJsc4pY/yqe8118cPECPFHoXBZwcFriyQLqUAQPOP/2aTGPaTsQ97KhoBImN8GS075i99kVrRwS5EOVuQmvTuAyKu5PFFPtlYPWiOc9KEarlYmMlSjvCQhVVTBEvDuUvfljjQ9uqZB6RHDEgc/g7idhp0MKfwIHVZeYv/OAnPqMjwq2zasNojTLifdBnjJe6Cq8bF/SQDMXsL1R0CI/wcq+BQC+BaDGriTs5FyPdYtlOWJjRiosMdAgIUGfQxMTC0UrdhB+Gk2U/jCbzx6tdIxyo/kDOScMJ8WMwxXV3xEDjc/WlYFSzE1ACvOb7nz9PPvs9Om1/DcOTFelBI+a5vriVPJ4xaB9gaQNtO6O7LPWh12p1e1O5/x2HYL5ZlHPARBegkuyfVFAslmwWnasoZgcoXoR7Ie27psab8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(83380400001)(16526019)(8936002)(8676002)(478600001)(86362001)(6916009)(6506007)(66946007)(6486002)(6666004)(1076003)(52116002)(186003)(36756003)(4326008)(956004)(44832011)(69590400011)(6512007)(5660300002)(66556008)(2906002)(316002)(66476007)(2616005)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?pqs4VLB0kcYtFhariSDcZ3IIq9h/S2Hl8nZOPHF5tVmAurN0/8ve4AvwikVK?=
 =?us-ascii?Q?fgJlDXXjetrJpsegcIwb+cuPcjM5SQpMWfed7gehkQ6FdiggX7IBNo80KUmp?=
 =?us-ascii?Q?wJcbKbF0rSavxwwuobJ2DAgfYPVTjiJM8GCLamoGGH2Sa+T2W9aVcOpzO5Kh?=
 =?us-ascii?Q?v4G/IAqtHgESmDZ8swF8gxP9O5ZRDt9ZaCMBV5tumqJ7+x2FQ9kr6cLLAvlB?=
 =?us-ascii?Q?TOEoFdHX+Nc3XipPJtzcBWyD7MxImR1IB0gfgUyqt9sM7FuEjSJPm78nRrbB?=
 =?us-ascii?Q?cwIgfLDThug1gvIylvO2/kbl89xPtIUJ8CTSJmlG2j8E3DP63X0hlIV+0z36?=
 =?us-ascii?Q?fTzdQlb4m8CWkgrJ1DjUjG8BF7zoqz07sO8Tp57UL0UIhHl9mDJuF41RE9hF?=
 =?us-ascii?Q?EDV5OaIsWPIqNlaUc1WBTAVjMjH/pRLNptPuVZxvy3O3b6eodTXu13yxJqUf?=
 =?us-ascii?Q?jsa9ClDs/QTWXDtTvLxF82i/KRfoFdS0PQIM5qimm0BTi562PMp1B72JVBqm?=
 =?us-ascii?Q?FxBXgKLkU9Y42FDen/Ni3O0s386kV2QFLaz6dajViXckWOdnsQLY/Rb+RoqB?=
 =?us-ascii?Q?E55wPm+t7J9eT1rg+Mm5uOMhPaXLODDhpht5KHURpl7wEMOAgymBj4WIuIEm?=
 =?us-ascii?Q?gArI0EA0pdY+4FO/vejs1R2akneTzeL13j1XuenGXo0rdyKt4xetJv6u961U?=
 =?us-ascii?Q?WtUFbKE1T/zVNzVJMZ3cwXMoYJqloxQMY0OK5pICegJm8j93DZXANY+NsDIF?=
 =?us-ascii?Q?KQYJxxy8dqeP4stCZKjDWUEpm4ZZqlWT7WH83rQMWRia/FzV9RraiYa5HyEg?=
 =?us-ascii?Q?xTlN/9wDK52NjqU6lxmyj4qgF0O1wkCetA1n/PU64oPutAzDma1tFTbmA5Va?=
 =?us-ascii?Q?dheuz2W/cRmYOG4mdvsjYl3v/J/CDoSWQnJkKkYCENSLMn4SAagkWsGZYsM+?=
 =?us-ascii?Q?arjY8nbPX3/Zd0zW6GKR3HVejzmGOTLk+i8JPAs4wCYTjWxqiA3Y+o0jZ0Pw?=
 =?us-ascii?Q?vV1T1W3Aw5vUe3Hwbpr2ZYSxFWiHX57MqTjNFJniochnhNerL7CXSSYN2XsD?=
 =?us-ascii?Q?JaTOr0zwFS6998TcZRvL347ulLTMqzmknQHnYOl6LdP7ESyVHqwhbG190+5P?=
 =?us-ascii?Q?2O/k4ENFLGP5M08Fjcs9ioEYN5i/njPcxShIBwXxdDcyq52tgR3DFpVuNX+i?=
 =?us-ascii?Q?SlmjAj1IHHpGlF9PLlMLc5i5wsxhD8PbaDLvq7UIrKojjelSr0AHU+1uup20?=
 =?us-ascii?Q?m0H9JCNVJjxSneMq853y94TaDR+l9HMiwRt5Y5L4UNIBkVMrkf+LTFeostHD?=
 =?us-ascii?Q?ct7gA2YghUvhVip62D590sX8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae91e74-466f-4928-7b31-08d8ced64655
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:44:57.4173 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2uXL3nkSGCqOvldm2kwOr5DTYJVbEXBiXyWQiMmRRF3WTZhmi4XzEt947FxqYP3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4235
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Po-Ting Chen <robin.chen@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Po-Ting Chen <robin.chen@amd.com>

[Why]
To get the pixel statistics on every frame, change ABM
sample rate from 2 to 1.

[How]
Change LS, HS and BL sample rate to 1.

Signed-off-by: Po-Ting Chen <robin.chen@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
index 453aaa5757bd..eb1698d54a48 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c
@@ -72,11 +72,11 @@ static void dmub_abm_init(struct abm *abm, uint32_t backlight)
 {
 	struct dce_abm *dce_abm = TO_DMUB_ABM(abm);
 
-	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x103);
-	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x101);
-	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x103);
-	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x101);
-	REG_WRITE(BL1_PWM_BL_UPDATE_SAMPLE_RATE, 0x101);
+	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x3);
+	REG_WRITE(DC_ABM1_HG_SAMPLE_RATE, 0x1);
+	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x3);
+	REG_WRITE(DC_ABM1_LS_SAMPLE_RATE, 0x1);
+	REG_WRITE(BL1_PWM_BL_UPDATE_SAMPLE_RATE, 0x1);
 
 	REG_SET_3(DC_ABM1_HG_MISC_CTRL, 0,
 			ABM1_HG_NUM_OF_BINS_SEL, 0,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
