Return-Path: <SRS0=9uSV=II=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDE4C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 07:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC64264FDE
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Mar 2021 07:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC64264FDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44AE96E9CC;
	Wed, 10 Mar 2021 07:34:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A199C6E9CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Mar 2021 07:34:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HftA4a0As4SUSKPVeSw/0P+aZEHCzSmXaQDHBbKWIneaz/JvnK8HGXLJrHXlsq9kHP1Ijk1SVe4pe3l6/ntrWsuC2VVIdxtC2mA7O9oIQkbnifv7ARP4X6ghN4+UGgp6756ADTQmdO9D15HYq3XubtC9xC6GnpjchnYK9qpgOVASAu9UFsSGw1cNLw86XWCmr1kkaN0jh0KUEhN4clfOjWl84dfUqOfcqxygdWozr15kpdxXFZ4qD0MDB3EcS/CRSsL66JcfJR04G+RIuquhZpr9SMEZ0BOL7fRGgagVDABEcepLYuXwCT39IMkNsvOPPZ1/QjW494ctDzrdZsW5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rFWRQ4IErEojbjqdKK3UtB+tQ3M7rxRCW9eAVM752A=;
 b=ag2eziAeeaEdvrZMafITPvxVCv1BHQp87gpKUPx6em7HKVHtwUXa0auJLsrtkqn2ckKlW2ptOVF/0BeHEXqUxEeKO8gLw4OGoa8PuACxe6aI6Jy2oaXJpNaUAuaJj4+tTyCOFsMMg5UpGLRhPLo5TZ48qM8aycuZa4CvCyFL3fgf16FWCmcbMXQSR72P5KLDrQ7m3fhvJtfyky8nFENavvfPyvLsPaErRu+WPCkGuIRokYcgNtQqCa33M2tg/J/SCVPfX1Lb8LbjylXeeUPPGYaSLc9bZbyA/2T6Z0Y+Detivw1bB2FYsWEXo5RrGMY7Sm8MTQl0Im4VEO5FkiDkOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rFWRQ4IErEojbjqdKK3UtB+tQ3M7rxRCW9eAVM752A=;
 b=SZfJ07ID6tCqt71LEkXqfbKfKCSA4CiYBLaCgsR8dD/quNDzzRG0iTnID7x27DD4UtVfqMzCkesYVfxxssWuA33QJPLais4z7i7p7n8y8Oh2Eu0zVHIzsVNB5kCdHj1P4J566oIZu0f1GqNTeN+bIucklbc9iTQXMRI7FLzQI9k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.29; Wed, 10 Mar 2021 07:34:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 07:34:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: correct the gpu metrics version
Date: Wed, 10 Mar 2021 15:34:01 +0800
Message-Id: <20210310073401.815536-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0036.apcprd03.prod.outlook.com
 (2603:1096:203:c9::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HKAPR03CA0036.apcprd03.prod.outlook.com (2603:1096:203:c9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.23 via Frontend Transport; Wed, 10 Mar 2021 07:34:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84d9ad28-f90f-4f1d-47c7-08d8e396ed3f
X-MS-TrafficTypeDiagnostic: DM6PR12MB4433:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4433F7470D485FEE63BDB837E4919@DM6PR12MB4433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5s660Ch9FTXvDX0hVznkoYXNcMws1u5iK4M7FWanB3ncP6iS8nKd5qQbP6VUsvpKf3GoGNdDwpTnM9FLZFOt8dIg7E0My0QrvtPir4tWgsNXvhvLW6gR3cyuU8qLYyw3Ye3vUA1fY7OsdaNKE25e7VPkA8nGYx3oc1xjA296BN6WMtCqGdtOaoDU9O+vy8ieGaEMla8Y4SnEu2HHZmX7luyAhXeRhy+whJG/2No5oV8jgtWuv7QVQ/CHbo7/i/1lv5KdE7VGH27kdo46vTZEemDAXeYQBna//TmlHS7drTnixv0zmbqyXShEnCexRg6qrXF0IGJsr4D6KEWR/XX6oWzdsxUDQoT9Md7XEazLQbxDP8fgM1qL+yCZzO8nPRISuUmbpaXesCn0Mkpm8uKENB87n5kFexu3uO4PJMSr3+RejsQnxRLwqzzPdHmW/QSetAFe2QPUi9XXuilBfqkyjFePxjswjawYu2KuyIgB/Uj6Hm7AGkz/Dsde4SfELlsiWkfFpsEz2hLgGcAZUT2OrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39850400004)(346002)(396003)(136003)(366004)(66556008)(6916009)(44832011)(4744005)(6666004)(7696005)(4326008)(66476007)(16526019)(186003)(52116002)(66946007)(2906002)(86362001)(5660300002)(8676002)(956004)(2616005)(83380400001)(36756003)(6486002)(26005)(478600001)(8936002)(1076003)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c9dNoW4sDUDMdvB/FPwaaNFYsf2keiOMSdzTXLlhANvtTtPdQ098WzApqlJ6?=
 =?us-ascii?Q?9JHrwx3fojYDwzsK46kp3fgmSNAKzIFuAr9PfFnlp6rWDWKQxpWDPpKpPhQs?=
 =?us-ascii?Q?5YEx8GBUGn9iWfoZI8ssJuRetVomnhoythMT99e2t5LpNWOhIdSD15uM9ivG?=
 =?us-ascii?Q?m12Mrus03S2W1PGXhVhEiDj24ScqLGrO1VWyo6r4nujiwh+SC3dSdcRTgEqJ?=
 =?us-ascii?Q?L4DGiLQ3ONEXzZTowRYDGPYSwo4nyHvis0HnKKkdqbwVCVcu2ataCkS6Oda8?=
 =?us-ascii?Q?+M28/Fb2DVaZBmBFUGIMGdmxZ5VzeWZhXU7PnSR4E9BpZqLYLRNuiYADajeo?=
 =?us-ascii?Q?EknbDaX57QUn6vJHTG7v5vbF+/HBKKwa1e84i6HuW2NhkCnIJLmgG17wDdbk?=
 =?us-ascii?Q?6JIvA1tSkruna9snQkEV0RsM3ZH7+xgJPiY0fj9xW7BoGo3jMvpN1rhE42lp?=
 =?us-ascii?Q?e0qcIx3ZniQ6pbPyBdqo7CFzPBzrKQHA9qMWQ4YO5Ia3hH/FpnYGkHK5AxnJ?=
 =?us-ascii?Q?O4OoVMHrZRfZEXdACIWiUh3aoqhWmsOqs+sRmEc6RJ6lzZvAGn/Ys5bQBpfj?=
 =?us-ascii?Q?VWxNI8eM2MD3C8GFsvlB2da0iz1zI4OIwQm4vIezkVE+QpqzblP5kZ6UZPx+?=
 =?us-ascii?Q?rG9SEZOmafhH3EgWS7RZuLGGzp/uIz9Rh25M+g+Y7ciHb1vbprRzhX43b8KC?=
 =?us-ascii?Q?ZGP0jE9DryKpr7c3U1bYSQWGRnBBUF8TA6n0ghNLPweGLhJOZQd+6sIeu/X+?=
 =?us-ascii?Q?Qbwz6WEQDflPxSV2XxX9yZsckR8qQQa/qp0qc11Wct98NbVDQkYghmeEzO1a?=
 =?us-ascii?Q?5KYCPTt9u1y+mEjM97guAQHRSQQhhkqtlVPnN6+7f8Eg4sF1nvaIWFpi3mNV?=
 =?us-ascii?Q?e0IctuAYHyRsaa0v6b5IjmJQHguBy+V14QRe87VCYJOsp36x9gjX4iPZATe3?=
 =?us-ascii?Q?C4/OfjeNExBela28aZFP0layFziOE0lF6Yhh2ppgF0uhmaETF1PwP58bX81L?=
 =?us-ascii?Q?41ge+LX7zZrB0XawGGvbCfzp3J4d4l3HxUyODYYMCFsYmB1SGM5vEDV7ITy+?=
 =?us-ascii?Q?M2Bt5Z3PXyMpE4fsEFAaHksC0fqJ68XZYRSX8cc96p/6ckc7MxLn+Rj6qUZT?=
 =?us-ascii?Q?qvRMPZSRwBdFo9TP0xZK5tC+MOLJdeLRlRjgWH+mmg0i2D4iB1U1v8nCL5KR?=
 =?us-ascii?Q?tfT8GfW+hYDf8v1JOGHP6wbpX58o7Sf8Q2In++smB2dteXl98kGae4fPycxi?=
 =?us-ascii?Q?83DGdKxEsGKhDS+EA7qXGeUqFhPBDf9L2+KQ4UAtwMj1qkDCQwTvEBGyWIBm?=
 =?us-ascii?Q?7WNAH2K93X0wof1DYiAGYw0c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d9ad28-f90f-4f1d-47c7-08d8e396ed3f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 07:34:24.1140 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGE0yvQ7P10mhGhntB8GgdTPMwDgKoB9V9u6PrnXikZC9PX1st3LJqfRhK/PW6px
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For V1_0 and V1_1, they come with different size. Misuse may cause
out of memory access.

Change-Id: Icd06e673b9259d8d381301c145f0e9eff3408ee5
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 740025ee7f78..9b0bc570d31a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -206,7 +206,7 @@ static int aldebaran_tables_init(struct smu_context *smu)
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
-	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_0);
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_1);
 	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
 	if (!smu_table->gpu_metrics_table) {
 		kfree(smu_table->metrics_table);
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
