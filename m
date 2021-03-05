Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA7C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 03:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA1EA64FE1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 03:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1EA64FE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93B926EAC3;
	Fri,  5 Mar 2021 03:13:15 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B176EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 03:13:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWEEe9Si/b9R+M0sTyMEuLk4EfUnsVoqKqJs1b7V7uySNT4lPywgpW9uEdRUee1fzvrrUTqsQ0UYn1oVe2LLP6QdQ6zS99nDfMdQN6374yZ2mwSWZ9Jy5Nx5oXn1c8jyyCrQJod0gZ7/4qjFcTY98MWLG9UWuThbAbeKZw0hiQo9rBzNzGQj+BjxuRsV/g0J4Io3JWJzBou90hBvdsUy3ETqxLe7hSyOljRcI/XOWauZz6b+xoSjlADC8oZ0sEAuzQtzJ4VEVzbVyHb1WnSFr9P26r2tQD0NCx1ZVWfEYTs2goXraWYNphpFG44XH0hFf/CfE4tphK47psWlJCLSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnfurHwHYQjCy0W3uxhKWYS1hy6AqsnF1gasIKnqNx0=;
 b=dpzYzIlbV9+D8PCLgsnssoST7T7NewdYi3jSf51YW3kpY3g9EsKB03ZTJdRpR4knwKcuqFmDoG7nI4BUooDj0+/051lpw3hGaQgurl3IDvzInGd7SDKHXutkEzU8ZT2HrXBfjeJLjxmtJHgF0vwkh9Wo7ZanhiqpJlTe/UhqQp3HmcjFGuul4gOFtyX2lK4xx8BK5Hi+RroVS+tu5u3m+o86k1HceNwodiAvxbB3JAWk04D1iWSid5CKpAwl673DW4yZ/CERJYs0pjZcHzGYN0lBCwKOepWrp/wxXiJaPUJYi9ZK36fQ/6ygJ508f9nlPQe8usBRjoejrSljMa7CqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnfurHwHYQjCy0W3uxhKWYS1hy6AqsnF1gasIKnqNx0=;
 b=thTjk5UPXm57eDOvG82X0N1Q3MjiPEG8eYuvAuf/VDp2rvn57TqIN+hEWNXEh9AyfYX1RROIDkoU/zKsuEOpJCeioxYtNLulknQtSU3obgiDt/llyn4dk5ob4DaAzEUenA/QIsd6uJPMnXLXXlCTo7L4dpo6tGCxn5Qt4U24RvU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3848.namprd12.prod.outlook.com (2603:10b6:610:16::18)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18; Fri, 5 Mar
 2021 03:13:11 +0000
Received: from CH2PR12MB3848.namprd12.prod.outlook.com
 ([fe80::454a:ad63:6fcb:dd66]) by CH2PR12MB3848.namprd12.prod.outlook.com
 ([fe80::454a:ad63:6fcb:dd66%4]) with mapi id 15.20.3912.019; Fri, 5 Mar 2021
 03:13:11 +0000
From: Jay Cornwall <jay.cornwall@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Move set_trap_handler out of dqm->ops
Date: Thu,  4 Mar 2021 21:12:54 -0600
Message-Id: <20210305031254.13597-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0136.namprd05.prod.outlook.com
 (2603:10b6:803:2c::14) To CH2PR12MB3848.namprd12.prod.outlook.com
 (2603:10b6:610:16::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jc-d.amd.com (165.204.77.1) by
 SN4PR0501CA0136.namprd05.prod.outlook.com (2603:10b6:803:2c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.14 via Frontend
 Transport; Fri, 5 Mar 2021 03:13:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb75cffe-987d-4a4e-d8f9-08d8df849b90
X-MS-TrafficTypeDiagnostic: CH2PR12MB4310:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4310A326B3D0CCA187F4669B87969@CH2PR12MB4310.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TxQVVqRSwWUVsNgmBDInwTNgLR3EO8kuUTwEzpiq683b9NqPhporl+pFF8BC1+YtDOQoFZ5dIgmC2i1Lsjd5f20lHIUuBKoB0ExU4utf1rX83UWY4cZQ2tq8LOamIULLVpz4rYTFiqUgeph0bJLX6VO9HR5YTlE32c11qt8d9b3H4tBKmwMHBLwfA8FcMuUltD77xtSVBJ+sRc/ezfZsY+eXS5L1RJn/4arAZVxVzd4P4bCcMM8totznKYy/Ogi7YAqy5M8TCZhkXXpyMKUZWetcjLOFsRVwfvaO5xxi1+cOvRm+iQ/lCkjBX95oKR6WSBRbKBwV5qBdJfB5ncDcPBDV7uAcnGAgmHcRf6QnWsmVqlstH9IQE7tiwASkDg4k373jPIU3qIQldTDaYDTqeaswau+xmIaQymR3dGW7FWeQquavIS6LVOYX7HWPSLmh+SaO4tZ/6zrrbTNVaatRUwlKyGvZkLZYVhAmdqvD3mq+fDZZZRoI+QUWJMuc8WL57ThzoO0MViZLPwcpPunFHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3848.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(346002)(136003)(366004)(44832011)(7696005)(6486002)(8676002)(478600001)(6666004)(52116002)(8936002)(956004)(2616005)(1076003)(316002)(36756003)(26005)(66476007)(66556008)(186003)(2906002)(6916009)(16526019)(5660300002)(66946007)(86362001)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qXtCHoisVLcmpPKqfntmD7j32bBplNzFvr8hS/KaPIM+nAKticJ9Nt8UGrao?=
 =?us-ascii?Q?3VqQxzmuDFaTTIE4rJ3WcjkBWmUbM348AbuPrxB7UVFD8icm/eH1hG59b55L?=
 =?us-ascii?Q?1mAR77ZE5PjYIs6iwAarkIhCl609zBhVwM7hNVx3s5RN9uc4GEKWGbjQkmSf?=
 =?us-ascii?Q?YX4YwjWssYhvqz632gBGwMYM4Md1zFTdB8Sga1li9KB9QmkAwOfbEWoflRRq?=
 =?us-ascii?Q?pqYTYRWvAljlral4rhBrRQjmfv7ACUKNCRBQuI0DTzzC3iUP/fCIDMkTJAE/?=
 =?us-ascii?Q?U/nL25TN665psIJgD71a1DS3fk9GIB+kf8GPzqbxt0g39RUN8idYVenv06Lk?=
 =?us-ascii?Q?zzTJjiS/Y3o5X4mgzLMp9xpBjDM3mbMbyenhojucv7ma6R6z2gqiGEF0ObGh?=
 =?us-ascii?Q?5v22X9MnKVmqltSVGg0790hZKIP1XPWpYlXeEIsGOyGy4n5RJJ/BEyqQiL5Q?=
 =?us-ascii?Q?P/D0YUaWU1p7wTlWW4ydmnD1BWJcHiTZ/S6zhgK1JhR3aMxS9SFsZnB4N8CL?=
 =?us-ascii?Q?dQWPKGwHGAmQmnfF1deU20wKfxK+U/gism95YKXD7fN/AV0iLyqDpCxmiSgI?=
 =?us-ascii?Q?5sHa6zOasBz48zKCv1DyxEfuhZzbc1/LacyvhuBIfd0IUgO4DSj/A2vah3nn?=
 =?us-ascii?Q?IDafIPdcK6NzGnMdXnF+KFrzlmLWrO9imrKWfbAJjMTMlsFutOeTL4bwfaPA?=
 =?us-ascii?Q?/BgBNEkFh58DVMi+uq2wT9oi0PFSSEcP7PGmxRkNSiEH/5KwCPaMZSG57Ros?=
 =?us-ascii?Q?sqLFgLUWClykOZiYFAY2TqckQZs0V5glcl/9PYE8USMnUcPTtqXWKPLq0KY+?=
 =?us-ascii?Q?cyaF54ois0esGbFQWpSZG4a3dKORzd3CigpM5qjhqK0J5kxt5nA7XpMN/i6S?=
 =?us-ascii?Q?ddf9mh5cp0fJrQWfHsn1HwcK2S90HgiD++T9EhfoB9IveFYot9V6L+5IWXK9?=
 =?us-ascii?Q?t1sSFDelcF6dCPm38cp9gY1O8sscTIGLuyE8GEDHiemflf/p92L+VY4EBewO?=
 =?us-ascii?Q?Zp727F7VjxtVLM8DcRssatIZcDcACLtxh/2iNwVj/Z7v820pdDuTpozUHQds?=
 =?us-ascii?Q?0loAE1FxbwGZXETir8ye6oLwqPfrtNuJ0aWugBHMQtuz4g6TpaAtabZPR7Wc?=
 =?us-ascii?Q?+F/GEC4dgjUrA9qRiaIFab6rqP641+4NNm6y2a39V3feoWECslbiN07w3JGM?=
 =?us-ascii?Q?/4qyvMmdRB7JwbeMMsCRaKMIcdyzSnaMD1GVqvxZ/yy8XSh2jDucvW0INfP6?=
 =?us-ascii?Q?SVa9ScKiDQzB6NBft1fDJbrlZ9begxziZtCueRBc0VjRgGBVEDO+YEoetbEd?=
 =?us-ascii?Q?eXXYq33idrzfirnMK8Xv3Y3V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb75cffe-987d-4a4e-d8f9-08d8df849b90
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3848.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 03:13:11.4831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z//XcFOc/PmzSISqUTUcY2IZ7BxLGbBFonqiGBVf+qz7ZWNUT/WYPqVCiOtaZZaa0zzTuD8aZChmr9mw+qSKFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
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
Cc: Jay Cornwall <jay.cornwall@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Trap handler is set per-process per-device and is unrelated
to queue management.

Move implementation closer to TMA setup code.

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 +----
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 22 -------------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  5 -----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 19 ++++++++++++++++
 5 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 8cc51cec988a..6802c616e10e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -556,11 +556,7 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
 		goto out;
 	}
 
-	if (dev->dqm->ops.set_trap_handler(dev->dqm,
-					&pdd->qpd,
-					args->tba_addr,
-					args->tma_addr))
-		err = -EINVAL;
+	kfd_process_set_trap_handler(&pdd->qpd, args->tba_addr, args->tma_addr);
 
 out:
 	mutex_unlock(&p->mutex);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c37e9c4b1fb4..6bb778f24441 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1596,26 +1596,6 @@ static bool set_cache_memory_policy(struct device_queue_manager *dqm,
 	return retval;
 }
 
-static int set_trap_handler(struct device_queue_manager *dqm,
-				struct qcm_process_device *qpd,
-				uint64_t tba_addr,
-				uint64_t tma_addr)
-{
-	uint64_t *tma;
-
-	if (dqm->dev->cwsr_enabled) {
-		/* Jump from CWSR trap handler to user trap */
-		tma = (uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
-		tma[0] = tba_addr;
-		tma[1] = tma_addr;
-	} else {
-		qpd->tba_addr = tba_addr;
-		qpd->tma_addr = tma_addr;
-	}
-
-	return 0;
-}
-
 static int process_termination_nocpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
@@ -1859,7 +1839,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.create_kernel_queue = create_kernel_queue_cpsch;
 		dqm->ops.destroy_kernel_queue = destroy_kernel_queue_cpsch;
 		dqm->ops.set_cache_memory_policy = set_cache_memory_policy;
-		dqm->ops.set_trap_handler = set_trap_handler;
 		dqm->ops.process_termination = process_termination_cpsch;
 		dqm->ops.evict_process_queues = evict_process_queues_cpsch;
 		dqm->ops.restore_process_queues = restore_process_queues_cpsch;
@@ -1878,7 +1857,6 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.initialize = initialize_nocpsch;
 		dqm->ops.uninitialize = uninitialize;
 		dqm->ops.set_cache_memory_policy = set_cache_memory_policy;
-		dqm->ops.set_trap_handler = set_trap_handler;
 		dqm->ops.process_termination = process_termination_nocpsch;
 		dqm->ops.evict_process_queues = evict_process_queues_nocpsch;
 		dqm->ops.restore_process_queues =
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 16262e5d93f5..aee033b1d148 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -121,11 +121,6 @@ struct device_queue_manager_ops {
 					   void __user *alternate_aperture_base,
 					   uint64_t alternate_aperture_size);
 
-	int	(*set_trap_handler)(struct device_queue_manager *dqm,
-				    struct qcm_process_device *qpd,
-				    uint64_t tba_addr,
-				    uint64_t tma_addr);
-
 	int (*process_termination)(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index e2ebd5a1d4de..8f839154bf1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -944,6 +944,10 @@ bool interrupt_is_wanted(struct kfd_dev *dev,
 /* amdkfd Apertures */
 int kfd_init_apertures(struct kfd_process *process);
 
+void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
+				  uint64_t tba_addr,
+				  uint64_t tma_addr);
+
 /* Queue Context Management */
 int init_queue(struct queue **q, const struct queue_properties *properties);
 void uninit_queue(struct queue *q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index a4d7682289bb..ff3e76450b66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1162,6 +1162,25 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	return 0;
 }
 
+void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
+				  uint64_t tba_addr,
+				  uint64_t tma_addr)
+{
+	if (qpd->cwsr_kaddr) {
+		/* KFD trap handler is bound, record as second-level TBA/TMA
+		 * in first-level TMA. First-level trap will jump to second.
+		 */
+		uint64_t *tma =
+			(uint64_t *)(qpd->cwsr_kaddr + KFD_CWSR_TMA_OFFSET);
+		tma[0] = tba_addr;
+		tma[1] = tma_addr;
+	} else {
+		/* No trap handler bound, bind as first-level TBA/TMA. */
+		qpd->tba_addr = tba_addr;
+		qpd->tma_addr = tma_addr;
+	}
+}
+
 /*
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
