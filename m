Return-Path: <SRS0=BS7L=4O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B49C4BA21
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 19:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791012072D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2020 19:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jVD5msQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791012072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 211DB6E0C6;
	Wed, 26 Feb 2020 19:37:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFC56E0C6
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2020 19:37:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJWXVjK5Lq1rj9tZeeA77ILRKaBRiWQFzR4cTTDxBU1t6b2asEw3MpGTAVbyZrWPYNb+Alir8hta7usjjU+LYcoYCJzmdsAsDlXj9JOLDYOYmlJ1Hje0DAeSMm1JlDZABv6vOdXUHZpk5Sg9MghGG+Pz7Me7hTR7V2p58JsVwzZ0vpZkz7I+sA/x0MW3mTj1s0W+OrVjljxkVuYOqEKEOs5bVPrMKWfsaV0TBevvpTLKAz5/futZj+cL2uIMB3FTOyxulXZgUe4bzIo3Eu2ai/PGnzH8cwrr8vzag+MCLZQdMHNfBsnAizAbOdOd/HAJV655nBxXullJPLcTdejv7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HlBhXze6edKiQudlIL4huKTAMmn+lQ6+MHOo1MfPXM=;
 b=b6VUeEL343T4RRCsMDuppaaYfrj25ptU0og6JbtGqpdxI2tScZQBqjhJYcYJ2ZgKAE09gKO5ybLuM+XkN2uIMnWNyp0bgALfjAD7ydtGSUDoVrTgxdRQGDFMB39+/Y/mSuamDOSXj2h8cmahPSj0cpxnGFWJOznOXbPbAFbbUMfi5gd5T4yS40hraA0HNOkb7NlwOkaZFMSCk6YpGWkqgsShLSTtuZO+DbYXJm47EH48k3D7M2dDZEF/bqw/edTn2O9gSp8Ab+fIJ7k84RaWTxNIJR3ya6qgRjNjGKgtXHJG2UtR0a7mMFN8ePLtYyZ8NR8HwebDmrhi0DS/KIeDqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HlBhXze6edKiQudlIL4huKTAMmn+lQ6+MHOo1MfPXM=;
 b=jVD5msQaGWY3yVWDjU/s75UB9PkYN8VQbcDPm0WtePrtEvCM6cET6nOGFFmgBlUZG1CGVf5TQpGu+2slJbf2lFVIJZF6sY1TMAbJV7x6mTRXiJawtowUM8oehAKyBzdurAF8FwzbkVNHEbBgRswn7fW17ckMjkNi14n9g8uYKkc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=JinHuiEric.Huang@amd.com; 
Received: from BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21)
 by BY5PR12MB3809.namprd12.prod.outlook.com (2603:10b6:a03:1aa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Wed, 26 Feb
 2020 19:37:18 +0000
Received: from BY5PR12MB4227.namprd12.prod.outlook.com
 ([fe80::18d2:a8f8:cec5:56d4]) by BY5PR12MB4227.namprd12.prod.outlook.com
 ([fe80::18d2:a8f8:cec5:56d4%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 19:37:18 +0000
From: Eric Huang <JinhuiEric.Huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: change SDMA MQD memory type
Date: Wed, 26 Feb 2020 14:37:11 -0500
Message-Id: <1582745831-6902-1-git-send-email-JinhuiEric.Huang@amd.com>
X-Mailer: git-send-email 2.7.4
X-ClientProxiedBy: YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::47) To BY5PR12MB4227.namprd12.prod.outlook.com
 (2603:10b6:a03:206::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from eric-tp68xe.amd.com (165.204.55.251) by
 YTXPR0101CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2772.14 via Frontend Transport; Wed, 26 Feb 2020 19:37:17 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5a43215a-5c96-483c-4eac-08d7baf349e4
X-MS-TrafficTypeDiagnostic: BY5PR12MB3809:|BY5PR12MB3809:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB38098579616F9A82B7DECD8F82EA0@BY5PR12MB3809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(39860400002)(346002)(199004)(189003)(66476007)(66946007)(5660300002)(316002)(66556008)(6666004)(54906003)(4326008)(6486002)(8936002)(7696005)(16526019)(186003)(26005)(478600001)(2906002)(81156014)(81166006)(8676002)(4744005)(36756003)(6916009)(52116002)(2616005)(86362001)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BY5PR12MB3809;
 H:BY5PR12MB4227.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ql1Cij9QBm7elyZl7mLXZKq93ft2wz4/VJz7NFDj0Vr94m0ZggFGJ+ewMCU8J35kyEMqKHckK47mxXHRkhIZLonyXAmZHR2vnwml4tJtfdJa+zz6lgnySr0fJTpxUvxm4saMLHQM/CIxAMogLHaWSL4DJcTWe5gutQFCJffX+xGLv5bT1VburQR47eZIuj3NquVTlkWQnHgOBMxKwZQ7W++ix9Id7NyTjR3j49fPkcswWqFR4hWOEuR//awLGT+RooRYPxPFwgSACGAaCBkIuL8UaJZr/eS4A1oLtOiD8Jq9G57qhofMmGLmCkqiroAOMS8dpwfoKiBJQ8e8IXrZ/4Gl5WQzjK1QGB0w4QJ1c/hsN/2N+TIQ16L0BQogzSiEvxix4BC3oLbDjTfkKwEymF2KpMtOyChnYWgxgZYP7oWnKmNQrgUjTKR+LNE1USBY
X-MS-Exchange-AntiSpam-MessageData: LeUuAT9Id+siSeZrJn2BaM/ERVbvf6pJWg9yxpCGBE1rp4a5dbCTwI3VjAZ1ZLzBgbg0+8D7x6PwyE+gyelJf5az8kubCwUBPk0JAbjakJySBTpFWCnNNGQqSCOZmRFmJo2Y5qou7wsJ2CEXk5pdnQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a43215a-5c96-483c-4eac-08d7baf349e4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 19:37:18.1238 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gso3SlZy3HIntBnOsOKF9ieHzP9PQftBRX0xEZbkjk4p1/G5vuUrbnkg4xxepIT+2R45DlPCsl6Ml6XbyZwkJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3809
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA MQD memory type is NC that causes MQD data overwritten
accidentally by an old stable cache line. Changing it to UC
default for GART will fix the issue.

Change-Id: If609f47c78cb97e2c8dc930df2ab5c10c29dfe56
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 692abfd..77ea0f0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1734,7 +1734,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 
 	retval = amdgpu_amdkfd_alloc_gtt_mem(dev->kgd, size,
 		&(mem_obj->gtt_mem), &(mem_obj->gpu_addr),
-		(void *)&(mem_obj->cpu_ptr), true);
+		(void *)&(mem_obj->cpu_ptr), false);
 
 	return retval;
 }
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
