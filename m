Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4D9C352A2
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32D5F2082E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pTVCaomU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32D5F2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD256F97E;
	Wed,  5 Feb 2020 23:29:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7B66F982
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 23:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CTZjCUmbtD+6kclqnkGG6C7No4CAof2OAbRWLyc4VK/FgW9Vl6lgtAd4fxwfNA9ukvLruAPHEq3CfqylZ664yhXJG0tyyhfcIbmi29fO/o3AiUS+OYlHEulrMqWPlOIz7dmZYtMZHOV7bnvWeC077HOaT5WsrINOuCJIguTW29c8zPji7F6urgsYlsdzjPHWat4pj0f5OFnFS37NBN2AfP2v91q8W5D2l+Qg/R5w+dClgzhn1fgZP/ONHsLirczvj2NzXQgmCSVpHqeNuYoTbkQ13z54CKsNokgevvgnUMeir4oEABwv8u0lWGG3VmKI3dDRf3f+VgXMVft2C76g7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK1nEjBsmO61UHJU8OBbU8cJn4FhTaMqpSQu/H5qiz8=;
 b=Jl2gywMirSxH5M6PDz7no27HWnGZiCgHwjEywC/caSXSQcak6FkFCqHSUl8gAxtSx+tP8kWcDrgvFelK8bhdMpd4hY6ZMW2yxBvLDU/6zgYNVcACbrsm8IYolg8XcNGlboqsFzZ/elg/gfptdeZ1dQKVNsFSMW8vcPfZdholhNOpWGqzdBVrHvUaAl75t9FI+B8PCQ37tGA3rFTmpK1yQFUYWy7wzPQbfrI5fOwH1EmtppAhFi8ZJJ+lqZHsazr5l9XShTgkKWniv5gg8sksHhyW5yPuLDoZUWE63u25hbEK5M3/NxgbaiIyJY8zYLH+yuOIrMNNv9TlM4NvqFkvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mK1nEjBsmO61UHJU8OBbU8cJn4FhTaMqpSQu/H5qiz8=;
 b=pTVCaomUOmpU7rhdPUHBoRIjz4nxKQl6aJ5+0a1LRp1cxoMHQJzKbWK6/HZVC8BIRdeDVZFd7OEHY05Q6JMZbXmvWAOqYq6Ay4m7VfEyE/RXOM55Xy2/jye+z8qLCf0eEgsCEeyNeDAmSSW8/Ti2I/9PTbG/HTEAPGw8KMXNpx8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4072.namprd12.prod.outlook.com (10.141.156.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 23:29:40 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 23:29:40 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdkfd: Delete excessive printings
Date: Wed,  5 Feb 2020 18:28:32 -0500
Message-Id: <20200205232832.26226-6-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205232832.26226-1-Yong.Zhao@amd.com>
References: <20200205232832.26226-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 23:29:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dbdce48e-8938-4e3a-622d-08d7aa9345f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4072:|CH2PR12MB4072:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4072CFA5B3285D7B25805B65F0020@CH2PR12MB4072.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:227;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(4326008)(2906002)(6486002)(6666004)(66556008)(86362001)(478600001)(66476007)(8676002)(8936002)(81156014)(81166006)(66946007)(36756003)(5660300002)(316002)(186003)(2616005)(956004)(16526019)(26005)(1076003)(6916009)(7696005)(52116002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4072;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLbysJAWCftaX/50+w4tJ6Wwqaft5atmJncoqV5pn7ljGiYeGWEGQz/I9S8jEfadXXoxgxU+I3Kvg8RqS6Xyi+aiFMgyFz00oGp4aycSh79hvXecvGXeeekBlN7cKa7JILkgAlPNoTt/yw7vrmXr7XLvCoMJHIGEbH+y9JgWaD5ikN+RZMD2RcAdc5QRi8YV46PBeQV105WrslnR8oQbxavtCgFSnvZPQEXnQhkQokY3zLZazpaK0g97RHf6bPObwr4cpjsInOKpbNx7djOEjkNy6Sx8/lYbxa7C8htWDsNOkmkSHbv8c5Pwl6cO2LPtRbrqLb55IACILgdPbR+WZAxcdLvf3/93fVytg1YPvRUMbfDIq7nb6p0l60sN1t+rhNiqKGlc+3JI/XVkty9P7wavWMXl45ujkwqUiTDmhiJRdVCW7hn4I8iNEgt1N/AL
X-MS-Exchange-AntiSpam-MessageData: 3p+rtOoN02MdLU+R+JdvbC9fYMtpTx2CBZfqa7JMWe3hkKsBAgzSxU1mSnoMxoX7hzShI2KDP/f4W1IRH8qlO8Z7ml2slU3rqAcy+mDvzLYRhUzCc47yz/kHBQ8q2YN5sG41VUt+eDhc9sdJaNEaiA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbdce48e-8938-4e3a-622d-08d7aa9345f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 23:29:40.8183 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jaZFgaY3L0XpcDj6N32iODBEOEvRmWfAPV2mboeVTwKu0vkeIb7VOQxSVnSiIchQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072
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
index cf77b866054a..3bfdc9b251b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -305,8 +305,6 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	struct mqd_manager *mqd_mgr;
 	int retval;
 
-	print_queue(q);
-
 	dqm_lock(dqm);
 
 	if (dqm->total_queue_count >= max_num_of_queues_per_device) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 941b5876f19f..cf11f4dce98a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -253,7 +253,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		pqn->q = q;
 		pqn->kq = NULL;
 		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
-		pr_debug("DQM returned %d for create_queue\n", retval);
 		print_queue(q);
 		break;
 
@@ -274,7 +273,6 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		pqn->q = q;
 		pqn->kq = NULL;
 		retval = dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd);
-		pr_debug("DQM returned %d for create_queue\n", retval);
 		print_queue(q);
 		break;
 	case KFD_QUEUE_TYPE_DIQ:
@@ -295,7 +293,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
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
