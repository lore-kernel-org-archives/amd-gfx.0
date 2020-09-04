Return-Path: <SRS0=eFkV=CN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB19AC43461
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4ACD206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2020 08:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0iYBVIQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4ACD206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 457566EB24;
	Fri,  4 Sep 2020 08:15:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 930E76EB21
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2020 08:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/rpEIPp5VV8nADzlar4lWN9TiD+nNLe6DRsBoBAwYA+XFJKy+YHjFzer9A13TozWgMolk7aJ1WsXoB9t9S97UMkYOTh6OIu0R52045AshS07gFOXwL682nMAb22oaXSZIPlyjlbVrZQHoYpNuRJl44Jppx7ZZklr7OUmaydxL8XJ/zYewmZY8p9YsBITgoI3CL5JWRJILuf5hP8INpbF2hFSvxtD5IS0OQbkrOXaz8LtsJevdoJwrZ318OG03wjE0GLQhDMOUTa2UbEX8qVO35H7hSNzY+myHOK45u1z3mR8h05TJCiMXzGPuf6qlFvqRvnry8BIPSJvO/OB4bVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65NZOLDmikjh6Ygn4V/kiK15UyWIMnLIQWIrx6xIeag=;
 b=Mf89Ox7u6MVVwXhoszSZ3ux86auI68+vrH0RL4oVuxAFLJ77WZ1FHzW0iUyZmmgfZvej8l5FbuZFUKgbSK+UZFZ2wt4TCSnIIV2FTR4PnAIZqdrh4dXiaoIX8eL5EiUXx0QPKM0DxgAbAqTHugJgjzH9VyDbwlBjkbM82s9kHgJneczATK2VWeTyMXgfZTDOQQstgqPBmFCOszKIMLik5+F2q/HBpzP5HAIFKG3fNIB4xyg8pwXUUJhdqVO5HoidwnZVXSveE7jZA9Yv604KL/2xnzIhs5YP7Zvsq2pFxX3CmJ6U3U3K9r4/DcoL6kizNdrL7DKJFjNiA5q7eHf5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65NZOLDmikjh6Ygn4V/kiK15UyWIMnLIQWIrx6xIeag=;
 b=0iYBVIQ+P3Wd862DZFZ+pVbwfoZ3GSB0K8HQmYZBEdK7HCvHhkmoZJX8I7M/FOnxMDpNYKlzsvRWVjZiuuKvBG5elBtCW13Op+9ozJ6GDDqztzGeIUCvFW6F65B/nd2Z7LTPUe+9gXiLlb6ybHiY0D7gegJvzaHfxKXTdAC+SkI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.23; Fri, 4 Sep 2020 08:15:10 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 08:15:10 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: lower Raven UMD Stable Pstate VCN values
Date: Fri,  4 Sep 2020 16:14:42 +0800
Message-Id: <20200904081443.19768-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Fri, 4 Sep 2020 08:15:08 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 327b1e95-6423-4631-b592-08d850aaa3e1
X-MS-TrafficTypeDiagnostic: DM5PR12MB2469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2469088D9519A2F8A4C5C12DE42D0@DM5PR12MB2469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Vr5DIpxbQvFz20ZZpFU8uGd5EzuYxS5K/QDeCnWGcSEgR741k3vDozE4LW/qGGENe+VbtOoMLmcL88sJSj19eKTG/FQcNPB9E0/qBkXImWmw57PS6IlG/Jy64f7AV0hmOsBIY8ldsQRT4H6LDnbDEUf+9N7WPKrc26RWqY82IFMTqZirygJILYkoE6Bg8Qabz8IvGM9E76yh7J7NsKPlQ51Z7XYcfp5LknWZ1VTaR3JAQ2Oo4P/kKDdaBqXatMQG2dHzI343c3vS7fKQPE6g8oIz9THWy5HbfVwmPG1sOcs1PdTym/mbviRUCZw2H3Deo3HgPkZV7IIn3e4rMZF7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(1076003)(8676002)(6666004)(316002)(6486002)(6916009)(8936002)(83380400001)(16526019)(52116002)(7696005)(66556008)(956004)(86362001)(26005)(44832011)(478600001)(36756003)(66946007)(66476007)(2906002)(4326008)(186003)(5660300002)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: oHsQySDQ0BG3dR0dh50e0ym+HaqdZVxGcgujt6ZeQKkDDbW7G1FyJaWnIK+iRJqWr/e5w7VZ+zlgYWRM8Rpaqt49MmDo5eOn1tdrchTQqyBbdg+gduEdahPLK9bPHx/intEQzCcVnKXafBWMQUXKply1Z9N6CmXt+x29srfWaE1vyse6gguN1CAlvO4E7oBU/VO2U9rs+Han57I1nhMq1MFswjBpQFK5TWTrFaPoqlBmRBkuq2aQILgsGIc3BpTkpIVisDr6TEcrgyz8nGfLgHOxafN3F+daAi/J0dVT2NFjOZ5fzHTEzzepH1XDvnlwHufiYPFEXSN0QIiPWzfsLZ8W3sV56Bf2ckYtGjaSog8/zTgp/3hvIbyXQnb2/uNWN4yiBWOH9R/28MoOD/uTRzaR92BPf2E3p2aXeKc5b2cW41sQpm3kKXpaFLRD7FBam/wqDxwogkXfwcKBNWAewWQnnhX5wEoHwuWmXbeoMhV6hYVR6juhnzW6AWaqaEBrDprkr6vB17bxjef2ZCHIC9FriMLk5cSQkOZL4epMg3LPaL7z9Mu4QnTNFs0YXZA5SS72QlyT1LV/vWTMYkAXtAgQ6qr0CJbfiF3TgHxoeZJDDIgMGTjeQwpxNbZEVAYfnWVvRkQi6VWZXSAek0WZ1w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327b1e95-6423-4631-b592-08d850aaa3e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2020 08:15:10.0763 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sr97MLJdtYjY7HM7ygmMAeyXJbC5VdsLBz3Jer7wzIdXA5ML2qvNZT4X4XLtO7oW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2469
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, Evan Quan <evan.quan@amd.com>,
 changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SMU FCLK,SOCCLK have dependency on VCN CLKs. Lower VCN values so that
FCLK, SOCCLK reflect values set by UMD Stable Pstate.

Change-Id: Iddf2757be18aacc0bb66122dd2b690e58503223b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 4 ++--
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 8d606c0d03bb..3fb5f2733662 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -655,7 +655,7 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 						NULL);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetHardMinVcn,
-						SMU10_UMD_PSTATE_VCE,
+						SMU10_UMD_PSTATE_PROFILE_VCE,
 						NULL);
 
 		smum_send_msg_to_smc_with_parameter(hwmgr,
@@ -672,7 +672,7 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
 						NULL);
 		smum_send_msg_to_smc_with_parameter(hwmgr,
 						PPSMC_MSG_SetSoftMaxVcn,
-						SMU10_UMD_PSTATE_VCE,
+						SMU10_UMD_PSTATE_PROFILE_VCE,
 						NULL);
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
index a57c9eae1546..8e2838ff417c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.h
@@ -312,6 +312,7 @@ int smu10_init_function_pointers(struct pp_hwmgr *hwmgr);
 #define SMU10_UMD_PSTATE_SOCCLK                 626
 #define SMU10_UMD_PSTATE_FCLK                   933
 #define SMU10_UMD_PSTATE_VCE                    0x03C00320
+#define SMU10_UMD_PSTATE_PROFILE_VCE            0x02AD0229
 
 #define SMU10_UMD_PSTATE_PEAK_SOCCLK            757
 #define SMU10_UMD_PSTATE_PEAK_FCLK              1200
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
