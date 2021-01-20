Return-Path: <SRS0=ixe6=GX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D10C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 04:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A62523137
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Jan 2021 04:46:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A62523137
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6846E131;
	Wed, 20 Jan 2021 04:46:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A713D6E131
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Jan 2021 04:46:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kk08j+Z6/5stIBVhH98u8nu0dtlZgXB+VjgMJHSQGFDLLYnRiRw/Y3vGkCqvFrrJMyJT1poj8LsdXTjzDRnSrXjamgZtf+KAy6BRamxxGxTl87Bu6K9m8t0zfBh5Wo3mhNR3t/7pTcqW3WggR/nrwK14T6KA7gqFJ7FSHHOGqcq98NLSOEktNmTSvVtFZUrvrPtU0SXAXi9sZXH6DrRpmbn+JSTUiVKYK0ruY2VlsrTsG1onk3C3aQv2OHs0nzVHLqsikJji3GSYiTPnRqNmoZiUm4E9atx/DtN1dNi/eW0QOtXf74yUaAN/6EKlz0MlakKdLf8EJXLCg8MKnpkqRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnxJ5cILyzs9JyRbGVuxSXEjDlVU4wRHK4AUDJ0Ryus=;
 b=C0Uu9OsqM7E+pItMqCZkVXFPNA9E142sQYb535a/r7nwgocDJ0sI0fkk36yjmOfX0OxdgUdcdPqsB534MEeHYSZRH4Fs8hVO9XVllEMzadAZAW3MTWSaHk6eTTq5z4evOtjCfCpKXH4Zd01TZqmDSnO4rY8NP3T7LMiO1XpxfHmn5V0GvMBP37KDf/Ju0+cEEnbN9OA/8iSZjqXdZB5ndYWbStcgK5WBkJGQB5Ehmw2fJ7ssWSmzToIhaOZDGT2chDa2cg2H+q37DilOcvQBGEyKwoRZH7VNVQIwH2Zkcp9IPvwHqcZ+IDu9C9P9WEKlWjRLWUGWYhn4ZJaGB284Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnxJ5cILyzs9JyRbGVuxSXEjDlVU4wRHK4AUDJ0Ryus=;
 b=RO/WKEu2xgN8vpt8G8fwMhnrFKp6UtnjjsNjLSNwFRRyrjyrFnLkxh8cufTaDnNe4hbF4KuQZoP5TbDnDLFBHcjAYntqhWpdfdZZTboCcg10ECuFy0ONAJMPi6521qdcYY121jEL3i18yueqqKgU0YPmq0iVj5m4i+mTdlbj1Fk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2954.namprd12.prod.outlook.com (2603:10b6:5:188::22)
 by DM5PR12MB1801.namprd12.prod.outlook.com (2603:10b6:3:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 20 Jan
 2021 04:46:24 +0000
Received: from DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1]) by DM6PR12MB2954.namprd12.prod.outlook.com
 ([fe80::19b:66f9:83d9:7cb1%3]) with mapi id 15.20.3763.014; Wed, 20 Jan 2021
 04:46:24 +0000
From: Darren Powell <darren.powell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu/ras: Fix bug disabling DF_CSTATE when injecting
 xgmi_wafl errors via debugfs
Date: Tue, 19 Jan 2021 23:46:08 -0500
Message-Id: <20210120044608.4645-1-darren.powell@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [142.126.157.31]
X-ClientProxiedBy: YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::45) To DM6PR12MB2954.namprd12.prod.outlook.com
 (2603:10b6:5:188::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (142.126.157.31) by
 YTBPR01CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 20 Jan 2021 04:46:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7c55813-b7f4-4e9c-9621-08d8bcfe5747
X-MS-TrafficTypeDiagnostic: DM5PR12MB1801:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB18012EE025356EAF7F58EAAAF0A20@DM5PR12MB1801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8R1AlxxuewIMBXVanzUUqPouSV/6IG9MeZPWzzYjIKYTzEJ+qoh4fbUwBHJJPXx7tJ39sWWnuwkvBgS2GR5rPG4TUklmeCs0fkyoG+VJN4DSp/FBsV4wWq7k4U3j0Uve2ZLwYhM7hijn68feXJn2hKp+iRrbkzrx6mE1Y8wVUkK4kBTNsKYfFQSuCskbSpRkC+fAAjxHg+1Ei2hNNPNilfBALixBjXQ36rscCgSlq5PaC9k93I7RkN5CAQ139fDrfBdhbQ94S83AvlpYWMZX7jH8XJ74hPx0x0hn7o4kcDlTW9vsA4t6Q3B2Djp8YlWV5tzXkD8lqO5cs8UJVoXphHbFE6/ncCS09jW7ZhAOpfstfKQouj2XxLlnnfi6JBE9FWLptCJHEbSV/QZgxZE/AcVR+oNZjOzieZN53PQjHGKBMAGVgHkJIGnU1j6AJdvGVYOlOj48DokIanOiPwihYg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2954.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(2616005)(316002)(6486002)(8676002)(6666004)(66476007)(86362001)(6512007)(8936002)(4326008)(26005)(478600001)(36756003)(44832011)(6506007)(956004)(69590400011)(66946007)(83380400001)(52116002)(5660300002)(1076003)(16526019)(66556008)(2906002)(186003)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UskugF4ngbv+Ntvjef5mYtu8DeBwN+EghnsKxBvClwftnGtvjwxcJlMHxI9N?=
 =?us-ascii?Q?huuvyJy+QV+6Ta3MV8C/DG+U12a02RKHB9b+WT56OznS/t0NQCfBZ+7Pf3t0?=
 =?us-ascii?Q?mdcgebBcFr68JjfGBXWys5DtwIuRgoe0lkdfndxks4bnWwYXuBchjCR1PHaQ?=
 =?us-ascii?Q?1dR2d4X3ASKRBft9TBN7CaEIK9vThBHRL0bLmZs2IRfhkd1YsI/Dufr5SDHv?=
 =?us-ascii?Q?zkwCN09aYaZiFCZVmoT0QJ+tg1+iSYdKfVGsAbE33VAlIF6oWTX/ag/Jzpba?=
 =?us-ascii?Q?ImivPiBbu22m9WfItVTIH3ODpjWVkc8oGR2h8qfWLtfZYQTjHlr2+CwucKi1?=
 =?us-ascii?Q?FedOaThwNF3bJbIuV1bCMcFfyF+PmJf9Dzh1yAQ0G3nICRBP3dHzBbNcrLLA?=
 =?us-ascii?Q?FjzzIlLbeskO/x6iYnDK8jtiOl3mZF8tfFoS41xG5J7cOiE/eJhYFwr34WB8?=
 =?us-ascii?Q?GYKXaucIk59EU7bLQH+K0IYDFZ73BpPmqb0vMotdvfBqWp3BDztPuY4AmKfP?=
 =?us-ascii?Q?IjHMfnLRVg0QwVJz1l8kwEHJe0A8cvYMmyAdTDDkD/ileUmYz4quD03GTV7t?=
 =?us-ascii?Q?TUfJpsfMOVb7eaXA7OTTt0YQ2+LjsYaN0L+V7bkOkCDdBn1d2cf7EXBswyES?=
 =?us-ascii?Q?D6t474AluBnRcdpVliLChuNPSiLwhRJM322vc2yxauMZ7cLgjn67NaBINck4?=
 =?us-ascii?Q?cvOe4XgqdFW7B/OM0w1bS+cVcLhLQYS1Du3yeI5QqkNrMdb4dmfwm+c0rAxP?=
 =?us-ascii?Q?3jwmhLWU/HdHNKal83k6BDa9NMkQhZ80seVP/ocb2IfD/tPfk4MWpzEw8aP3?=
 =?us-ascii?Q?sgvruzefb9t7RLguXGVvXBOmRX9JFwPRtZ7k2xxo3XqM2ZFsY1eHRLia0YHM?=
 =?us-ascii?Q?59nExI8ooupSzHwIVAQYxWaCktz+rwEZU1JwXmQICPsZfnm4nCkPyLVN1LrX?=
 =?us-ascii?Q?t/GelVAxlaIagmWLcm1z/F/t4Vv5y0+log/dolFPlZH6eyXbV811tVUhTAtA?=
 =?us-ascii?Q?gRmU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c55813-b7f4-4e9c-9621-08d8bcfe5747
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2954.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2021 04:46:24.8087 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eZlvCZv2ZyNLpjMWfXekR1R6VXe4WrNAI+xASGR/npCZ7yv6MwNrXtQ3RUnZGtGx3kLKtcAoP1PfQV88Gk3X4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1801
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
Cc: Darren Powell <darren.powell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Typo in amdgpu_ras_error_inject_xgmi() does not set df_state back to ALLOW after test
this can be tested with the command
     echo inject xgmi_wafl ue 0x0 0x0 0x0 > /sys/kernel/debug/dri/0/ras/ras_ctrl

Fixes patch 5c23e9e05e42b5ea56a87a17f1da9ccf9b100465

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index c136bd449744..a6ec28fead07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -846,7 +846,7 @@ static int amdgpu_ras_error_inject_xgmi(struct amdgpu_device *adev,
 	if (amdgpu_dpm_allow_xgmi_power_down(adev, true))
 		dev_warn(adev->dev, "Failed to allow XGMI power down");
 
-	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_DISALLOW))
+	if (amdgpu_dpm_set_df_cstate(adev, DF_CSTATE_ALLOW))
 		dev_warn(adev->dev, "Failed to allow df cstate");
 
 	return ret;

base-commit: ed94c622f91453aaca80029b0afdd2551a12e777
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
