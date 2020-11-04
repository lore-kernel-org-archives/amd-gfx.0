Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D75C4742C
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 05:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 780A920639
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 05:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Q2G5hr61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780A920639
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 263856E944;
	Wed,  4 Nov 2020 05:06:34 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 261686E944
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 05:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGtNkmDaDz+eOO3U/DrLwJu3Cz1517fZNOSSoakuNIMmU9z7MHp8ni6NKs/M7MKIIDXKgU3A5Ki9GqBsOhd4QzJa0jWXgjdJcCWzsQFglBY5XgGJeCtsSm3yfl76CS8n+rD+3YQCAz7KKtDjmlScaNiGhprx212HNEQk+/tjhNZnn5D60a04QGOI6D/liIVi+Kfw7Hd3zbuwlE4KrQGFs39mg0y4ZqRluVCN71Lb9wstFUVbw85H+pNwebJzbO8DcH0yGCuBxd+8MJbMkPy/v7Tii83cTlBLItSnLS853qokMmxlABW30FRBpFf5xczT4fdn4Ta7z1rp3T0Gl6vI/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfQ3cCIX6EZ6Z1qB5GV7V08LwY3iQychYn/x+yTvI4Y=;
 b=K4chETWlEvg+o6PCNfDXZ6LA0PmJ+zxQ4QrHrLDiz7fVoAuuwdDxFW0u2i8eVTmFMhM6uIyuDM7ewGSuNnulLBXLEyN3iPhB/EC5lts67Ws/g1mJ+Bbh9EV6kpdP0van6r8001GHpmMYPDsiaxIGFsHM9JoKWpV/8pQ9ZADuQSmheyuMdqETZSUzDdg1Lg/SeDfBMQg2QqcgOsKNIdI48zP3p3nuRL7o5WnYL/ZV8pXUcCnl4mrTJ7ypDJJlUyD9unVqhjBkzSDZ6ioVS2gavTM+BTrBKF6leR5fDksltDGCDyGo7A3Sq2EFzgeiUC4Xx/kONE2IJmf2W0kK4Y4TGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfQ3cCIX6EZ6Z1qB5GV7V08LwY3iQychYn/x+yTvI4Y=;
 b=Q2G5hr61n6MFtwQmpX8DSRqvnKq48MtdO7NRhZNgr8lJgjI09Hk5vEsk2Kl2l7LRqXvDdhmO0D0ueMkwHZj6bTwRerMpfchj9qK23IorJ1NCavGJ/tip4vd8HIWxhgDjLL36aomU4RpLZmhZzwbApAKfKd1HJ7788On22micYj0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB3277.namprd12.prod.outlook.com (2603:10b6:208:103::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 05:06:30 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::69f0:f749:3d9b:362%4]) with mapi id 15.20.3499.031; Wed, 4 Nov 2020
 05:06:29 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: cleanup debug log in amdgpu_set_pp_features()
Date: Wed,  4 Nov 2020 13:06:09 +0800
Message-Id: <20201104050609.20571-2-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104050609.20571-1-kevin1.wang@amd.com>
References: <20201104050609.20571-1-kevin1.wang@amd.com>
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR02CA0130.apcprd02.prod.outlook.com
 (2603:1096:202:16::14) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-u1804-kvm.amd.com (58.247.170.245) by
 HK2PR02CA0130.apcprd02.prod.outlook.com (2603:1096:202:16::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 05:06:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77bac538-2afe-43a0-8513-08d8807f6384
X-MS-TrafficTypeDiagnostic: MN2PR12MB3277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3277A52B39C4C662B819CBA3A2EF0@MN2PR12MB3277.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cvm+t+15j+32lJ+QDetbVnvfF7F5wBhjdMXmZ025eBkrDccwTfXYv1vgEAtjH3k3+8TNKeBWr9AgMHp6S2yFNktRjYPDoYtWRuSzY40+2C7EARqSK6pNcuJ6t5MNfPIlBmsyRwKB3gDAmvMsbCt0N+i6K9StAC5LBDItzjw6IJhRnaB6LF0Bfk1mMv3LJmrZE67Ao0lxx+ZLXMNDxk248iRqUwkfl+jKRR83HAU4cnKLk1V2D+909rVkvjePsulPF5iEYw8UZQEFnBhbU7cjXM/pkRG15V15IHPgXXdsNlUzfm4wif58TJNjiXE/TWtdSGYKsjlImod0fhrnLZwlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39850400004)(316002)(83380400001)(1076003)(2906002)(956004)(2616005)(4744005)(6486002)(4326008)(16526019)(26005)(8676002)(6916009)(5660300002)(8936002)(66476007)(66556008)(52116002)(86362001)(7696005)(66946007)(478600001)(186003)(6666004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3Hs1WaZ64S9Ge3eWY0YPBqLCW+xipOBikvtVg0dQhdVFpwt2+goIqvUxEFQglkS1ulOEKioT3fuZdqvDsim6f/lhyCbUowf3rFOBjVBBXxlIQPT9ZJgdgbFV39F9EWkVqM2BDYkrxFYfHWAMirE+n2vJxu9eIyCef11nnqFrnXgg6W9hUUEZcKpdpWBHlejxwhSiqYvaE/aZ9uQ+8CFNoCEiPtlbhvJNOAILK2LVBd9p0nS2BaGQoLXLsbIMkUqna0zfMF4WISREIg7qEqmY5o8LT75Bi76H7ZNj0Y5va3m0uZn3zCV0dktlFRgp10kbeNTmiBM4M2N+7RxiMm+Q55CbTCD8MW/Ub3uRUfmFjD+u7Ue7qkSO7gm6cumibM+z6ukqFyP5uFA2BG+3SKF487RMu9KtJQ1/JyslJn2Wk2t2EDLTRxtqRQksPP0hDEIkVFltgmnjKh3UkZOiv6vQoOKVWQJbAd0rx41K2uhu1ylYUtF7dLnQr4514Vw9jlP2zsO72SO48H58THVAbr4cdFTmbHbBrYQh5xXbS2GiWPjzsKVemJew7mIPo5Q06DD+JCygQZC3Fo0qvTqPavAqOR7jO0Az7zk9G9nkXM6ZGgFswQGtx02BB/dbPPw34CSDL0bKHN9gZmH9x9Ivs/fYNw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bac538-2afe-43a0-8513-08d8807f6384
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 05:06:29.7083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9S2rsDJDlxQqHWFYPa6O5AdUTcMyOFeJQShuvCvvPb1JxuIrr1Od4E2GzFutSOSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3277
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
Cc: alexander.deucher@amd.com, evan.quan@amd.com,
 Kevin Wang <kevin1.wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index e57153d1fa24..a33b1cc50008 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -941,8 +941,6 @@ static ssize_t amdgpu_set_pp_features(struct device *dev,
 	if (ret)
 		return -EINVAL;
 
-	pr_debug("featuremask = 0x%llx\n", featuremask);
-
 	ret = pm_runtime_get_sync(ddev->dev);
 	if (ret < 0) {
 		pm_runtime_put_autosuspend(ddev->dev);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
