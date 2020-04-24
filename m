Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A745EC54FCB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 10:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539B22071E
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 10:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="f8HC37BZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539B22071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034A56E451;
	Fri, 24 Apr 2020 10:41:42 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB916E451
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 10:41:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgjQE+V5YnHGIg1uIQ2pupt4CiGW6dbebLgQTwArPnIPd5xBfFnhn/kG3sSRo+qj5DHNMk3t4zjrsjR74yIB8+7ZgvA2PEGhr+Hp/qhiAC/e0WZtmC4ceNn1l9eabDYPrXcxVVz48e+corEEFcGobSHN/ZWyTOJJkNLOB/jjsH40ri33HOi7MhqByaH8FOaszIAvwopfGU1T6MwoL4rQLP689X8Wp64t3hqUJC/uQ2ooPWgn0h/RnqHoIolWaNY2xpb/Fkwlq9nq6kcbe9WQ/6z2bflDIz3pTmM6QIbsRJIZwrDMgXL9jTktW0iePQQ8oyL9GbnI7MLyRWKyR2lwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4T/6znc6Oqk+KZf5I5MNy9b45nlLtHNFHblodKAF58=;
 b=Kdf7D2pxLedTcMZ0QMv7Fjgw3ddvlQtB6JuzpqaNgC9dZf9hteh7uCv9kLJQx8NH1/0Np9mEFGjtqQfVmUZK++zCKzkMJI6Ay5MgtJ5B6MZNT5cYWR4NoGyyR7cBzMZgbp20MCNKqXBUm2t+xIFpShH1RnMzhDK96SYqYd1eSd/u9PRnNQiCStQZiSmC68CNHhnn4F45Tc/UGh8Uwfg6wYixNMi1sGxutoCdxGAfwOe0JZBycXb70xCLPEt0MsjuAe7ZVwegQuQYpy+TaVMkIXHkuurwrB7sBx8KNj0oLFz1F7kJaWuZnNZS36BV2/Qs2sampqhj6ZdUcpC0O/wKtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4T/6znc6Oqk+KZf5I5MNy9b45nlLtHNFHblodKAF58=;
 b=f8HC37BZZo/LVMXtdUxsH8A72C9zQrqcEiMstKN6HpdAtfNyTZ9m9RPy7GG3tcXb0U4vRTdFWHtkhIgIUjDC88HtGmluTEeipCzB76bFCisXiD8ABL4C/Acht6KXj6Wlr+F6cUTerfavmawAwiBnm0Cth2SPbWvH/23zQYHJIlw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Fri, 24 Apr 2020 10:41:37 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5c27:185c:be20:1fb6%5]) with mapi id 15.20.2921.030; Fri, 24 Apr 2020
 10:41:37 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: address the static checker warnings
Date: Fri, 24 Apr 2020 18:41:15 +0800
Message-Id: <20200424104115.28738-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.26.2
X-ClientProxiedBy: HK2PR02CA0154.apcprd02.prod.outlook.com
 (2603:1096:201:1f::14) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0154.apcprd02.prod.outlook.com (2603:1096:201:1f::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 10:41:35 +0000
X-Mailer: git-send-email 2.26.2
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c29d5bd-4a2e-448a-3187-08d7e83c1045
X-MS-TrafficTypeDiagnostic: DM6PR12MB4281:|DM6PR12MB4281:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4281AAAD44944FA0FA09C990E4D00@DM6PR12MB4281.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(2616005)(956004)(36756003)(81156014)(478600001)(86362001)(1076003)(4326008)(186003)(8676002)(16526019)(8936002)(44832011)(2906002)(6486002)(66476007)(316002)(66556008)(6666004)(5660300002)(7696005)(6916009)(52116002)(26005)(66946007);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sC1HSRDEFJuGQBQk+3xa6EeKgnhtaDl1VdilGx2ZubfGlVYrwNK6nEe3WklkUfdV7i2kcitDPyoGGHVBa+mFNQkCZx+xAi5My5J5VI78tixUliPU2PWDamGY2xH0dmRlzKysVLfFl4pOqN6CK8KgnrzYshm5glgMc2xhGgFnv6VpQf/QmtKp2CRbAErZHGmz5kMt4FysNz7XAdJfROUKUvFXnJg20zT+sEwnGoO17NebhqfMlUtP/fBuPQEKMnqRhUhuTS1wQzGOgtHv4vYJXySAnaaOwwqnbOhdPWeBchu0M+iW/tBu2HfMIwTpklmkWGQ5VmGGg/boQ88/1ACWTMdRypC9HrclAOPv1+gyxdPQUMJHfIM38nP4DyVMf9Po1V/kkcZxP4EmXmqrLlpS/Dnvv+cfdaXpGtDMVQMtYUWxGRo8i2yn6O583TbCHyFy
X-MS-Exchange-AntiSpam-MessageData: 9chJmhyWfydTHYYsguTflZi4DjCNpES2IzwtNepH7AbohAJKT8D3AkSd6BYf+WWTKE+mr0PttsfvwCfvc37C5gQrxVZFaWQwcfo/coenCQ2wi+SNd3DXsruD0l9eE2gQdrUfOIzHTiGq8dNzdZZMdQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c29d5bd-4a2e-448a-3187-08d7e83c1045
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 10:41:36.9063 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KpZpmlC04MNnXaFGDK21b8JEVR/fNUf0GSwB02Z9RwzUOW2IYSGLRg3JEDtxCsO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4199 amdgpu_device_gpu_recover()
error: we previously assumed 'hive' could be null (see line 4196)

This is introduced by "drm/amdgpu: optimize the gpu reset for XGMI setup V2".

Change-Id: I9c22b57abc9f512114112f93fb035f1fecf26beb
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 71278942f9f0..898338dc9605 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4274,7 +4274,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 		if (!amdgpu_device_lock_adev(tmp_adev, !hive)) {
 			DRM_INFO("Bailing on TDR for s_job:%llx, as another already in progress",
 				  job ? job->base.id : -1);
-			mutex_unlock(&hive->hive_lock);
+			if (hive)
+				mutex_unlock(&hive->hive_lock);
 			return 0;
 		}
 
-- 
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
