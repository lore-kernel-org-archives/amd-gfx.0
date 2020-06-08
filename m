Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D6DC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B10206C3
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 10:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="akoFfiKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B10206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642186E1F7;
	Mon,  8 Jun 2020 10:47:04 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCB66E1F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 10:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxWCaJFQs3Ct35BN32HcVd0dWMKeuGEPX0rOOmWshBN9upjT78mep6dzPtvPL6J0QB+TeZythsEypGo+J97R1VGRGohfHW+UzR7xV9OBj2V4eE0rz1pKj5Ucg2Jcb7dsbo9lQ/N+IppvU63m7g+v+8m7UYLQTxmgc5jgGqTPzNyKDQdIDV7RvxfK9KiyDSlii7BvOZKY+QGh4jJ9YySKFIB4uq/HMe3LsS6IHguZ3D3fvKTIUXSSl4YzLX2uiTUeTtBBGfvZe2Da8P0CFo5OuOC7dEzWRgYDjF2LmVhxFpewVSOha8eBcuzheoL/bITJ2gEIH2O4dCa8BzDXq75TIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsZXQFffuGK6dK2jxLB1Rvvpxa4md76ettneYkCspoE=;
 b=CewAGNysk6hoFCDoZEMbKjJTn1UFOsfURtpgu9zgt0D5VQ8Ria+hKKVwOeOwflEsQMgx48Q+ylg0BHfyWk4XcTy8FhYYwjNkcJo1ySbh4L5Kz7gq8dHQSuZD6miQObIpIjAhCwSvQsuiAZJt5b6mbAGp+dSoeI4g1o7faLXcuHLYMFDlECBwVTCNvWWkOmbGNaYGGOTTPKgn0OXN5+dBfKx8rNw2Z9Y/3BDqSEg1wG6XdXnTAue6/b0A71Imf5aBKJW7tg8Hthz5jyj5lqo4YKx3ycaDJKcZ7db16Ti+QKp0XIhSZHnsyYoYUoimw88d9bDSyLd8Ahg0re6DqbFwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsZXQFffuGK6dK2jxLB1Rvvpxa4md76ettneYkCspoE=;
 b=akoFfiKglMMMCpyenVRVy2WyrTFFNTrR4rsSBYmNy0OJkK1RBxcnw8XyA83BbLNZOzhW3wYmmOUxJtE0LPIIvpT8SYRFqLGst95ixJdM2kT2WhWZr5zbkhtV440wtOu3UdGSazg1DM+t9vU8mixrQGppUDakmphIm2gfPw8wkyI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18; Mon, 8 Jun 2020 10:47:02 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 10:47:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: move maximum sustainable clock retrieving
 to .hw_init
Date: Mon,  8 Jun 2020 18:46:27 +0800
Message-Id: <20200608104627.29595-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR02CA0157.apcprd02.prod.outlook.com
 (2603:1096:201:1f::17) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0157.apcprd02.prod.outlook.com (2603:1096:201:1f::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 10:47:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84682a64-6c52-4abb-a288-08d80b99469d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3546FB59E8B87B827BA7DB8AE4850@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A1F4o6h2e82vY3P42M67xvgwSs2uMWLW6o2dMZfY//3fjAb3YTG0DOjtHmPuh1puBky4VmS2S3sYc+DarAsIwocucRMID2usXjFA4X46G3z/68cOdhWkOoZNbJlPsdVSdhhUhhmuAzmrkvRmO4htWbQ3wMtJNmigFclvlF6mlUafmLpyUN5k8UrFKlWBTLF0lwXIPsX+eRgcbxY14xygQdQSPzuCfNpbJXt5yK0J2zC3mq6mk8Dlwp5O5fSQUnFTdG/ySeeywShj/sHw6XZ2P3uy8QjZC2Xb+x7j+KR7InabMbvxuq0Z+NHEQhFjNa4dNEfh1IjezJ2CQqyEVj/8xzrRvO2xDG7J01Qvs+pk9BpIkzcRvaeyLk50Z6LWo58+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(66556008)(2906002)(66476007)(6666004)(6916009)(8676002)(956004)(66946007)(2616005)(8936002)(26005)(5660300002)(44832011)(4326008)(86362001)(6486002)(478600001)(83380400001)(316002)(54906003)(186003)(52116002)(7696005)(36756003)(16526019)(1076003)(142923001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SArVbhYfktLXdbyYtQCqV/xqNzz5mChzQTSpt2tu4T5YG9H2CE2grFlrmMQVQnY4jifkzjt/laihcud/z0fPNwh3CWhlZivHag40SmGF3fD+DA7ZK4A+T8c6M1a7flXE3vxY9auDy1WiRQfuqaiZJumvEBqJnrPrArr28FCATWPTvo1V6zbkufjOC0KvAqEFz8kOq/hnskv92Iv23maZ/g5T6DJnb2a9VJ+qmQe5Yi4YYWd6BiNX2Q1NwxG4qzU5SnNFeetY4thyIFvKtz0A06Ot+KEN93uxFBWAys+pkjYJfIPJRqK5/AiSph9OLqjMh2Lb/p4S5xsCL2TAGEKGKrtfeznVWCqa75dvQoo+qgXIGdnrId3YnvZ+E6UcMay9LsPslz+a7n2Ww3oLnZVdcmEBTpNe3PqP7oE4EmMqQd3Dqm125Lj2Bg6uBT5KkP1o1Y42TwqScJIvjUPKDRSiBTyziJOd2avmiJp6WT0upi8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84682a64-6c52-4abb-a288-08d80b99469d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 10:47:01.7161 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cruwbdnjd0grXNx8dzM+mOvkG/JkMcnaciaRcEer3hmIkxqH+OMmEIJl55gt6wfh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 Flora Cui <flora.cui@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Since DAL settings come between .hw_init and .late_init of SMU. And
DAL needs to know the maximum sustainable clocks.

Change-Id: I0702b7332a0d7c0b29dfdf4999c18efb588b8862
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reported-by: Flora Cui <flora.cui@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 725ac90c0f36..6beae3b496be 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -819,12 +819,6 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
-	ret = smu_init_max_sustainable_clocks(smu);
-	if (ret) {
-		dev_err(adev->dev, "Failed to init max sustainable clocks!\n");
-		return ret;
-	}
-
 	ret = smu_populate_umd_state_clk(smu);
 	if (ret) {
 		dev_err(adev->dev, "Failed to populate UMD state clocks!\n");
@@ -1364,6 +1358,19 @@ static int smu_hw_init(void *handle)
 		return ret;
 	}
 
+	/*
+	 * Move maximum sustainable clock retrieving here considering
+	 * 1. It is not needed on resume(from S3).
+	 * 2. DAL settings come between .hw_init and .late_init of SMU.
+	 *    And DAL needs to know the maximum sustainable clocks. Thus
+	 *    it cannot be put in .late_init().
+	 */
+	ret = smu_init_max_sustainable_clocks(smu);
+	if (ret) {
+		dev_err(adev->dev, "Failed to init max sustainable clocks!\n");
+		return ret;
+	}
+
 	adev->pm.dpm_enabled = true;
 
 	dev_info(adev->dev, "SMU is initialized successfully!\n");
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
