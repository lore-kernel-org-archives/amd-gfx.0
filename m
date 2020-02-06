Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38FEC352A2
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78CAB20674
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 02:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DapFkMhd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78CAB20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED2B6F9A4;
	Thu,  6 Feb 2020 02:35:52 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680062.outbound.protection.outlook.com [40.107.68.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21F96F9A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 02:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2whbe6hYIU6clGTsG46ylDucD9hn9sB9v3V/rKWqRlm62EEZoqZ4PAqkkNPK7YtAkramcl2ZB4mkPwyqPkyHqEzOt4qb5FEI0V+wRZ+vjaraQLvkzkfLhBKpha0gr148ZYsBowESYV0Cilo1mpxzIULaJiICOqYFpvzlhR5RIsqF+xTQu0Uvm9U1zl5IG7DoJBGsQ7iARWKeXQr4GoNMX8bYFprt0mVMaJMPpAshUZJclIOB4aHFkAqkUNyXeLmTHY6kf5Nps7O62kyYmjj3wavlPSbcd0g8Az0jchUwgih/ygBFSFpFFa72+dirh8Ow0Z1ybcV6qYYftxvIqKX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhs/XO0ksZF3q9Zd8CA+FbdkeuHAwc/PgOGrSlK00vU=;
 b=U6i7ud4AssW+WEr0c1cH7h/P1qLTsxOmrWobpEyJn5wyZEpXULcJUrkK9/73WjLVpDoOgwgcM1xipLGDyeYhm81tDLSEe+JAH9pviVIvQgJBwAVnMUfMLUcJ/xD8+JkNbvYSa+t5rbj7SIue1hULFolZpk/t2jXMnPHMQGgFnkGCW0DhXhhLo7+XCrxfPiWv64Xsz0fJtC90Fc6l+yflwng0r+FtUXdrg2hRaFg2Ia1SyueG2aKODWUCZrQCiHfbK4gH4TSfJbHNVNEaqH90S9Cohuj9CP8y+tqFgaBuHAzNVX491ft+CuBrUO6cYAd+QCWKUPtLUFtOatFBsxAYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhs/XO0ksZF3q9Zd8CA+FbdkeuHAwc/PgOGrSlK00vU=;
 b=DapFkMhdXcWJqU8/Rj80QL9/ZE+ndpTXHtmYpKlUO0+mJnrd1GilsBrwuPyAPvMdxYFv3tqKl8Mxs5W4Od5p+VH44J9h/NaOpzge6t1qXY0sHim6Pkk+zD9vVcQYwlUc2TnaJCXi3x1TphcqmDBwZjHmMMdKtwwOwU+F8a+L86Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4246.namprd12.prod.outlook.com (20.180.6.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 02:35:49 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Thu, 6 Feb 2020
 02:35:48 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdkfd: Delete excessive printings
Date: Wed,  5 Feb 2020 21:35:34 -0500
Message-Id: <20200206023536.4417-1-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::38) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0061.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Thu, 6 Feb 2020 02:35:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ccc0fa46-96bf-4120-44ab-08d7aaad4695
X-MS-TrafficTypeDiagnostic: CH2PR12MB4246:|CH2PR12MB4246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4246B3D206B140E6263ED37BF01D0@CH2PR12MB4246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(199004)(189003)(4326008)(6486002)(1076003)(66946007)(6666004)(81166006)(81156014)(8676002)(8936002)(86362001)(36756003)(186003)(16526019)(478600001)(956004)(2616005)(26005)(316002)(5660300002)(66556008)(66476007)(2906002)(52116002)(7696005)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4246;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZP60ZRRshwkcEjz74Y1uWYCQMlK/+K1RPiZdZYlbfaiAv7GpP4VPnH373/I7e44QrnjRPmGycXSH07wsnz0BCXii0n3hIM8Tk9lAHQkRd7a+eRTmMJGi1WQDgwUnS1N6KlHN7MswQ6UQjfFxhRjHUgwScYuk6SWv0LdrIMjWlw9PtjFxgwTRI7oWO0lNLGu24yd1V3/raqIb3MKOW+WdtiOD0zaIY9I5YE98Wxmh1l1hpBuwX+78YjwI7JUsVh3AkH5wrsH+tAOS46otTz9pdvjqq6J6KQCdaDMBD8DF+Vy1SOccszAwki72HXFVfL3KorZ9y2d6489U0i0CWBU90upS9KnDXuwKGzpJWUISdzSQuaWij/ioJcHGBFtj+icYOHhwDlMKWxB66yJEwW95GCuix/mTyRZ4fOVn5uHLPjQi411lF8JgMu/pa98zqjFT
X-MS-Exchange-AntiSpam-MessageData: xSEe4L2Bew1chSvOQ6WGaQZ9SZ9T+gzirmU1F4nUMlNiBwdBAAyy9CSdg/IL1z9JcVNjKlDrTCF8BBszXz6KmXxx1VulhZYPq8oivP7M9ITxv5CvAj1AhUOVyL85ZwYgei6mgQi+9FeF6AGGpvGTxg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc0fa46-96bf-4120-44ab-08d7aaad4695
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 02:35:48.7735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uZ2x3xhdr0xLltimUHp+HEP7v43qaaP1AufbcbRp8W6k+aIRI8vofWx8/OECuwu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those printings are duplicated or useless.

Change-Id: I88fbe8f5748bbd0a20bcf1f6ca67b9dde99733fe
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 2 --
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a3c44d88314b..958275db3f55 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -297,8 +297,6 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	struct mqd_manager *mqd_mgr;
 	int retval;
 
-	print_queue(q);
-
 	dqm_lock(dqm);
 
 	if (dqm->total_queue_count >= max_num_of_queues_per_device) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c604a2ede3f5..3bfa5c8d9654 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -257,7 +257,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		pqn->q = q;
 		pqn->kq = NULL;
 		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
-		pr_debug("DQM returned %d for create_queue\n", retval);
 		print_queue(q);
 		break;
 
@@ -278,7 +277,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		pqn->q = q;
 		pqn->kq = NULL;
 		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
-		pr_debug("DQM returned %d for create_queue\n", retval);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
@@ -299,7 +297,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	}
 
 	if (retval != 0) {
-		pr_err("Pasid 0x%x DQM create queue %d failed. ret %d\n",
+		pr_err("Pasid 0x%x DQM create queue type %d failed. ret %d\n",
 			pqm->process->pasid, type, retval);
 		goto err_create_queue;
 	}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
