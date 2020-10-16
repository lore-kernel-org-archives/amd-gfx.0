Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CDAC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA46206ED
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qLQw5iC7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA46206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAEBD6E9B0;
	Fri, 16 Oct 2020 03:27:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990676E9B0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:27:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgR+d58DrRwhNeBrPrOtR3lz7O8jLGw7v5YPEljWO55+HQqpLA+wCzzMzna+Gv1AHJ9d0V8Y759QqWy3m517toVQSRHijDcn0KW9BeTwVExFgbqhCvm3EBiGZQ767agB9hJnXBV+fFZ/cRrG2kBilU/z9+WkJ8ktbUYfHamLt15S7bGh91U2ghix2MjLg8/0nxvL0q7Td21qATHsDdZBp5RgQ787MF4+MG4dF4IQJcMrnEH2qFjU91MA1EpMwnvDoXpHKL0CfrB5nHbSHBLk3URS7em33ylE5+FChyumktbqXCYWb6OaLJUkvZgRaHhTRiB5yOQiOUqKlLzJNOL+FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrUqDZUgne5J5+2ypXGAXXLjBQ7RN5wM3TAz30xFJQQ=;
 b=bnpoi8Z0MxZFX7oL8EmkwBNkI85pFi6RndNzxRERwcBh39jcqPacQBSFm0jrT1XTVLEhQPnRKCpd9lvJO0Un1fMBXef8H+nIXndYe1UKsnxYiG3640RCs8Cge+CooFn/sG+E/7seRWuvDQrIwtQRo/x3puVI1a2le4bopAWa8eoekXgtOue8ZWOl5O6WZe5RCp+IgmXE6FEm+LN1baNhda/gCv1fqCxYea0YssqfpgdbkSzWOQr5LTXIH4wNFIesRREycdf7oKmWhZBnNF7aBOIrvw8AfhUfd9T1lXQWwK7JH66jWcE3DfzkwJ+eKAAmF2IJRvM8cjQOsvEVBCcNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrUqDZUgne5J5+2ypXGAXXLjBQ7RN5wM3TAz30xFJQQ=;
 b=qLQw5iC7nLeefLRxw9KJZtugpK1YmWtUhOlvAGdb1i5h8rtHQw2KPwhXtWtl0iqKLY/S5CDU5xQG5ncVXZen2roLScg6ZVNycnvdqAQ7U+YV6JcqLt7JCluB6wr6gpLHPAKmKqTp8i7JCMy1OKL96wnwHXpLKfyV/mcDm/+FYUg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.21; Fri, 16 Oct 2020 03:27:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3477.023; Fri, 16 Oct 2020
 03:27:39 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amd/pm: correct vddci table setup
Date: Fri, 16 Oct 2020 11:26:16 +0800
Message-Id: <20201016032652.507-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016032652.507-1-evan.quan@amd.com>
References: <20201016032652.507-1-evan.quan@amd.com>
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR0302CA0007.apcprd03.prod.outlook.com
 (2603:1096:202::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR0302CA0007.apcprd03.prod.outlook.com (2603:1096:202::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.8 via Frontend Transport; Fri, 16 Oct 2020 03:27:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6bbe813a-40e2-4edd-1893-08d871836ef2
X-MS-TrafficTypeDiagnostic: DM5PR12MB4680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4680AE0406835A567B796AE3E4030@DM5PR12MB4680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:400;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bESw1Dv4LE1sgzKsK/YhW8cFyg2PY+9IlYen8QKttuWAPeyFDurHJj1z2EiX/s+t/J/sOluenesX4j3cFcFIy/Azh3y7ZS9oU73lnKGB2DEvWn5Z4exAB8gIPvSMDtwkDGzmzPjmy5cWsJpLAoXtwd3fKMcxW7DEPUXtzv+xno7FbXefiNIiPzkkKRRaJSmiPWyf35RDV2drRzXIqlcPA7gmv2gHLRf3KEGK+9ylzHMuyw5zeUP+jZKMmzmDRg73KrIDD1Kl9Kz9mH0PK4+LYTHLVZ14TJkZxf58/McPOlwWf0pRUGXG/59X4z0P9DuDZUYb/ohE3W5Gm4uSVAnzeR3+oQB4TeKLh/vbucMm6xAf54EY9JrgD495qtHYzaqW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(478600001)(4326008)(83380400001)(6666004)(36756003)(316002)(34490700002)(66946007)(6916009)(5660300002)(956004)(66556008)(66476007)(2616005)(44832011)(186003)(52116002)(7696005)(86362001)(8676002)(2906002)(4744005)(6486002)(26005)(16526019)(1076003)(8936002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 2DJTmosw95GOyztCOTKUYGpiTMiOrllwHyt7YrTeasBoy8FhBuOc5FGYm2lYTk8dJczGs6WeNtVpJ1l7fi4UGgNKisiHQJSbvFLA7SiHwW8zrD7om4DVaTdmbDe/Sj8Ad3oLYG6dk+2TFmEGCys6xBzc6/tUQZ6eOsXf7QuPfPyX2ro16LnFXqGm5TilAnEjbVi26uLUOp6Uc7dXo4ma8db58JZ3vM9oO+ZMAvc9XoAdwW3YXKHIMcBIjBmWU4DcGQWlscifR8gy50QwvG9FqmErMNwyitAujGKRRSe9ZgZSi0BIASJKFQxMBXNUXGjJ0qacizL9JOIlonU3Ina3a6giV9pzrVlNeB3UTgRYsqks6Wln/k2rJhRfg63pJbXfEZmvQIs2ezweasH7VXDFbRh8dUiMcGistwxrIjB2cSpgTWz+PA+nWBAevXmO7nOW6V9/sWSduhIamgizhGZSckU8f40t1z82BFYjXejfBNKOJ2blE+oz++uZ+2UOu6hAM0x/Y8KACw4qLA0S8dv+7x1uVoGfeZGNg8YrFroJaLktd5e1bOp1wHU0lyr/Z2oK84hjrubrkC6u4J/zrWuybAhJfAnCOFhT1Ec3AeulSJv3jPJeRjF864S178DZDYHuvyN+8fBvCGgaNWfOq33P/Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbe813a-40e2-4edd-1893-08d871836ef2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2020 03:27:39.2187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5K6Os7txBsN+xoQ4aNbY3bU59IFn56egN3Bh/x+Ak5XAmkd4SP52aT35wUcuLgWv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4680
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure the settings are applied only when voltage
controlled by gpio.

Change-Id: I31edfb731ebfeb35e87d130633d29714f84d76cb
Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
index a950387b492f..34cf3bedfc11 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/polaris10_smumgr.c
@@ -714,9 +714,9 @@ static int polaris10_populate_smc_vddci_table(struct pp_hwmgr *hwmgr,
 
 			table->Smio[level] |= data->vddci_voltage_table.entries[level].smio_low;
 		}
-	}
 
-	table->SmioMask1 = data->vddci_voltage_table.mask_low;
+		table->SmioMask1 = data->vddci_voltage_table.mask_low;
+	}
 
 	return 0;
 }
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
