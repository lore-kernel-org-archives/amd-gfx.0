Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9EA4C433FB
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C3F4217A0
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 08:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0COLPFzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3F4217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59950895F5;
	Tue, 14 Jul 2020 08:07:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24682895F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 08:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxD9CIBJEjzQmnU818BkQXu3si02rQiiHFd7cytDzUkFVivcA2aHZWqMSZJjV3L/Iruskp0Do0q5QHNzThVNhBpiQlZHOMP97cyCXlmuH8nI4ol7JgZnbbp87O7GyW4130s8wk2xQS6IoGySzeCY88m7Xra30UkRF6zftnCNwAv1gOrm1lDLMt9wyckbyo1Qy1uGFw2uPeCeVM/BUoNlYy5c/Ns24CAoqv23eI90+B2+U6vATd+bbtkFNrJq6PmA/zZZBbfK05kfnZp6J95XPFRfaGFLlJLRskuVb4x5QYb5W6ivAEQIvjD1BdrzOT1rWc7cfupApA8+Zg1/qIA3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gLQQtp3MjsGB+XAMZHHOprTC8pM0xZq7ChMrBFKlK8=;
 b=bWgb2Xy0iILkUDNCDYDvRrrvMyekoU2+mOmWHwGTJyf2HM+GWD+4VrTztCYdi9dRg+WczJBcQX91gbtX/pueJWKLZ1tDEuWValjoJTYNbD9g8Gll/vrG/51zEaXC4solRFA7FfNy8q8YZTzsBLddFHz/5IaNC3M2btvZy2Eu5+sqqynhDReIP09z1fG/wke76+UVQYiobTZWjUad+V+o//0gOrc2EMb75Mqy9pXkkoz1ft8a40IgngCmy0uCwcLPUUkAGEEicSTJPUnAW8l6E5qhsJj6v3kJLNhMm3OSQWK+sodAvwQW8udKxcNwRBooKJVf06njOqp0pgT21l5pvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gLQQtp3MjsGB+XAMZHHOprTC8pM0xZq7ChMrBFKlK8=;
 b=0COLPFzSuq+j9BMGxhyOVkizR0niB4Dn12PeVvgnq3e7sprRpHF9wmILDed2TxSuoOWhueZK8cbR9OJEN6pW5aIOeMbylXgGk6a7taHfStGbQjKN6SwJ6NWgSNzUpBYi/BzV+eL1lRxvXjoI5tjFz66Rxf8Y8mHV5hw1yNRznUk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Tue, 14 Jul 2020 08:07:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 08:07:13 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/17] drm/amd/powerplay: drop unnecessary message support
 check
Date: Tue, 14 Jul 2020 16:04:14 +0800
Message-Id: <20200714080416.6506-15-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714080416.6506-1-evan.quan@amd.com>
References: <20200714080416.6506-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR04CA0078.apcprd04.prod.outlook.com
 (2603:1096:202:15::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR04CA0078.apcprd04.prod.outlook.com (2603:1096:202:15::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22 via Frontend Transport; Tue, 14 Jul 2020 08:07:10 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6d1a2405-8578-4854-9a6e-08d827cce932
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4355616CFF4A1341929D761BE4610@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: milCLBy3zFn5Xh13rn3dQjYBo7/OPVTKMZo63n+xRh37dkFwAH9OkJwvzFaD5OXNawtxvvR8KpFCE3o3AIrG6sKNkW6qIqptzrDg5Lbm6sPRcqhTZaT1CCqgKyjvItZmmhnO7L2FXWdCi83Bq+NmYmUtsk+GKWikPtIuwrM0IofGOUVrlCpUIF0KHs+BbMOSSYxloz3VYZ7BPneQKgOYdYuY5p02AyHKPCCpq6SnSWo2esWqNggMdoFq5Zyor05VrQmfD2UUnN74duu6+X/S9zu2b3FRyBvbMsYNU5RInSM00En0dRb9aLJfAxauNA8VRfyMXgXfbpwstkN+Zl4UrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(478600001)(83380400001)(316002)(4326008)(2616005)(8936002)(8676002)(36756003)(66946007)(66556008)(1076003)(44832011)(2906002)(956004)(66476007)(6486002)(5660300002)(52116002)(186003)(86362001)(7696005)(15650500001)(16526019)(26005)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: t+85YIIXjyc4kQb93oRr3Reodzs7TwZNOaPTTpjEX+bs1yocmqWRBxYyj4Hf0h/cPDfFbEsUcYy277Adw63HX8ykLNNmvMrgprvkeBTHb6BWvLvZR3yERepMXUeE9h4ezIMVlybZy9babVbg96i2TnQBmbswkG+KHy0KvpWI86AFGmXu1fXb99jwME7bwEbUSJPYo/NCxO0ipNyNBbUAgHz3Bij7eXlQ8/wBTkXJPX0J1YwKUiu1Axdfk6F5E8NxvSJ5viJuMbaN+FbUK1fN0HNyGdNhJc5mpA+XAzf/jHtOfx8j3ERKqKlTsPu6AR9FkpUZN/g4T6NjHK+uG5TJXtd7nFl5QPumMsAzBUqaEZI5zmxwIKyRFtF6XvQm8LcepNiGG1oFV1P8UsZru22vCLk+RVUBGFfPApTqx772XK3EAxaKqMM3ebzfcOkcB9YJnZFlZBH4kman7b64KMv9ygyr0p+pxIT2BgxvO9MoKSs/wMWydQ/BCwkL0qyWdwSN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1a2405-8578-4854-9a6e-08d827cce932
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 08:07:12.5986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOgZRNbFnOqglPkgTJhRo7en0Bmd2q6aLae1DrIUWCpbCtWnT7wt5SN4cPQ8gy52
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These messages are known to be supported by all ASICs.

Change-Id: Ibd53a0edb54c696f81665a41830a56b046e468dd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 849adc946505..f32a64c91dd3 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -34,7 +34,6 @@
 #include "sienna_cichlid_ppt.h"
 #include "renoir_ppt.h"
 #include "amd_pcie.h"
-#include "smu_cmn.h"
 
 /*
  * DO NOT use these for err/warn/info/debug messages.
@@ -1576,14 +1575,6 @@ int smu_set_mp1_state(struct smu_context *smu,
 		return 0;
 	}
 
-	/* some asics may not support those messages */
-	if (smu_cmn_to_asic_specific_index(smu,
-					   CMN2ASIC_MAPPING_MSG,
-					   msg) < 0) {
-		mutex_unlock(&smu->mutex);
-		return 0;
-	}
-
 	ret = smu_send_smc_msg(smu, msg, NULL);
 	if (ret)
 		dev_err(smu->adev->dev, "[PrepareMp1] Failed!\n");
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
