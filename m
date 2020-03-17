Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B5AC10F29
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 16:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 184EA2073E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 16:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PtEHNzPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184EA2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A906E58B;
	Tue, 17 Mar 2020 16:55:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA71F6E58B
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 16:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcpVOlEuc7broA9mAW1EEC/tzyevV8oVkynSmviDDQ4/1ymIF/lHDHx+TlJXKTg2GvOX+F57Kh0jS9VkMWVA2T23bBjVbh+iSlWhuIWGev7Kk88YUbqwB4ZDw0p5ge00yMmOvn+rFym6PRQCRnt8Lphl1xK9C/XVNYcrwct5XMR7KdJiRsCvl4C00n/dF9y7Jxzaeae1XonqMW1qRxTL8B/8H6tXDqLwM9NbszIy3A62vPJkHSvYfNtBHRT2WT7dvRXke7av1RtRppygEgSHlnkGWnvW4T2vGJej62Q66dRts/MrWFWh8XvyDnXZL5MnOgM69E82jhdiUBFgfsmXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz8T9y9GOGLeWhy1nsLfGnS7wBGxXlrvxXnYsKO+skw=;
 b=ISdIDHGEXBt9AhIBRMTYSzv57/AkoKS9NoyCBJEhdD/MARYnVHYbPS3KPGtd+iNgAMDXAv0q5bhmGhJ+3qj4aAIiNE1fs0EwC1oYuZsG+I3EJZza3RbBx4i7qmA1FULbmdF8rS3WzwR82gATLBOIx6HTQ1B7x7tBtRg5o6kBJ+w/lx3v/sEILH6d4swo+K71lWg0zmqDkkCAT+oEzj4pZQajQS5GcgKLVqBKpQjhxdD31kEQgtAaPibxwxDyQJa6g++CFAihyQjxkcrrNOUtx2JUPBAXry4xU1xiFQsheAl/TYgG1jchQrBC9MozHmwQh/Cj14ZESW7BOsABEL5w9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz8T9y9GOGLeWhy1nsLfGnS7wBGxXlrvxXnYsKO+skw=;
 b=PtEHNzPK3Ed06q4JBenBigxxq6wfi6AI4bmuX/GbUWossGGaQSfZT1a1E7fsA9s5OQ0CzhTZ2eQAxTfPvZKh6B8mRtszLxNmCBS6zD4a4Hiu5e4cAXA9Eh688op4G7eg5gN0IrsvVEnJiq+TWtT9LYMuDpRTNXpBgS1mJQu/6zA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (2603:10b6:5:186::25)
 by DM6PR12MB2713.namprd12.prod.outlook.com (2603:10b6:5:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Tue, 17 Mar
 2020 16:55:03 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::36:e79:de19:78a4]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::36:e79:de19:78a4%7]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 16:55:03 +0000
From: shaoyunl <shaoyun.liu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/sriov : Don't resume RLCG for SRIOV guest
Date: Tue, 17 Mar 2020 12:54:57 -0400
Message-Id: <1584464097-12866-1-git-send-email-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaoyunl-dev.amd.com (165.204.55.250) by
 YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2814.18 via Frontend Transport; Tue, 17 Mar 2020 16:55:02 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3984a056-c410-4386-183b-08d7ca93eff4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2713:|DM6PR12MB2713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB271398289B2F831CDEB9759FF4F60@DM6PR12MB2713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(6666004)(316002)(66556008)(66476007)(6486002)(4326008)(8936002)(5660300002)(81166006)(8676002)(81156014)(956004)(2616005)(86362001)(4744005)(26005)(36756003)(16526019)(186003)(52116002)(7696005)(66946007)(6916009)(2906002)(478600001)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2713;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xphIXuD/3aLstQ/YAk+Q4OvHq7dUaWoD0KPfpmmhEslNwQlenowvH8N7WJjA1HXCA+aQ/Y2hCj+mOiLRQ4EE7IvTkFbV56Ppbx9uCKv3sWcBHVgb9dJk7kMTW0TmHLbzYVXuH2Our4OSd9ErltWifXh7xm38H9qEHjG9yYFpZySbYrZOqdOTwUT1N9l7OrEPekjZvkujjYNI4swNj+7t9ANmFzULmOvV43UyfhlSbV5WwxzaxtiTAJUOMJmafmbHCZ4TfBcIfbTaGRpfvp1vcGIhL87vR4cNwHJ0B9rUJAGtFJQtRYGIoDPXLP3YxrPMekNjfIMkU8SN+MQI63ybU9HXKMfacvK3UxJMfpCrZnAnCbLm1nWcI9/oXx1WOn27Is+lYMpVULLnrlYXjaDOUacb9pz5fu1HzL7tnO5oOgQ2dEdE1plechf9Z2iEnBbXZHrSvobJG8+l3GV/8ENdwk7cDcLx7bF6u99I7LTrYisAHjlYUIwspcN9YFNOUqHN
X-MS-Exchange-AntiSpam-MessageData: rki1TQA6Mg+JPyYDjVwkQKvwoPgjpicGyejAm+lsyE39zdC74tMKmlV+SFMD4O30HFY3QaC2Y8V8wm98qj97f7egi3oX/ANIHnQIp4LZcXNR+mfMB13tN94L7jf+YWifLW/CT5wt34/SlrXyL0MIPQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3984a056-c410-4386-183b-08d7ca93eff4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 16:55:03.3537 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1fmyVYiK8e0DQkrKoG9ZpPTxhIWLsgVjeLQNkdQz1V44YqraxlelxSV7/ee0TOG4c4EGkTQbbNDSO+2e+kJnjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2713
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
Cc: shaoyunl <shaoyun.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

RLCG is enabled by host driver, no need to enable it in guest for none-PSP load path

Change-Id: I2f313743bf3d492f06aaef07224da6eda3878a28
Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d1cdcb4..e134bb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -1940,6 +1940,11 @@ static int gfx_v10_0_rlc_resume(struct amdgpu_device *adev)
 		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
 			gfx_v10_0_rlc_enable_srm(adev);
 	} else {
+		if (amdgpu_sriov_vf(adev)) {
+			gfx_v10_0_init_csb(adev);
+			return 0;
+		}
+
 		adev->gfx.rlc.funcs->stop(adev);
 
 		/* disable CG */
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
