Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF80C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC35B610A0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC35B610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A1EE6E12E;
	Wed, 16 Jun 2021 08:35:35 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973DF6E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 08:35:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6VH1ovXw5B430tJbt7y2aL7QyJoMek8sGzuVMw3sIzUdVlF3J+DJIb9fCpxhhUa0zOyS8MtEnqi2LPdLsBXncX0MIPMW7cb7B/LWEFUslcwJOINCrKYLrBNnjV+RLE/jrUDu6NjYiJpBfnSol/j8ybBGIZWnVsmIPWLIXh7GelTnDQJMAemXryKyW6gmGZC4CIY+eSCJodtSOzeHBmnkdnjOqJetBmBlHNDhH9fZ9MbQnVcKecJEmBa03E7U0kcmMg3FvFbvKPXYamum4C8rNIQb+QJTw4km+rZajOwldE8aeitu1QRMPqcJjwVyWHdTOEZh7htN1Uk27T2uBCmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXMdiQlgKaI+wH0vJ2w0DludipKS1S7+JOjvayEPdV4=;
 b=lYmb8O/x/V7eEAiczlr6aA+GbqzYKJ/YAYg4FwNeeVWZvJukvOf3lP3Ngc2o0lSF7KmUDPA1jorz61ofW4wJi55z9EzdDRaSFirmnB2YdzPlbPmKj/67oON4LxmJP11OEJEC66bVbLtvofsCn9g4S4DkG3HvQDTbVUZMibE7BbK3lpRuiCImSh1vJlMbSim35IWETIvpyrzPz8Mcox9r3nLedRMESagurDWYOE4C4N265x1XwlC32+v011IEYUm61A4KXDqNQ4UCfC2PJ2o9Qcq+y/4RyYX6+yr4WDj3lV9p5EAPTYFZ8CYsIBHfX8ZcrDGE+cF+erWcauAcMUEIHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXMdiQlgKaI+wH0vJ2w0DludipKS1S7+JOjvayEPdV4=;
 b=a/StYFeqQ2yLQLOTczSwgPAp9NOFD8LG14aBKIlzx7UrAaw+qFpRXhjED0wuXr9uepDQD7cyZ5sRqhUwsn1GWxekt+Wc9cctskUCiOtsT1G7i0XqfklvaxsRh5hImtOsiuYdNO7mwqXQvEDDUjAPx8pHWAH1pw8j06WAKSHoPBQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Wed, 16 Jun 2021 08:35:32 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 08:35:32 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Fix some double free when destroy queue fails
Date: Wed, 16 Jun 2021 16:35:10 +0800
Message-Id: <20210616083511.2489-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Wed, 16 Jun 2021 08:35:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aa740fe-4499-4994-6975-08d930a1b43e
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54772E03447040247B40F314870F9@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:221;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5DQyxuBueF+mMq/2hJwHRXCxXQMuFEPekz0WLjNDUbfAr21bRH5wX3gOHlq3vXDyQxlWE5YfMHi/dnKWrPirBAgCV0BHCV+PloKGG6kmf9vCvxMCDynAEvtG59m84QpzRYjpc5zrN37Kx92f9T4zFftVESoRCHbnNCowdp9JrTpacuhHBdipgi6Y/b9unhOr+W9CMOT+RMEjy1fzIjUSu3gTgUOOZWcY2B1BCEZcIFYs6H3Bf2ZX0xEPKT5j2Mlay72OL5g3+iQLFWYD/cWaBr6Ojbb51kSv3JyP4qHtrGS79O4cqzj5s4+N8hYXTJqkejtdq2l7Ju7AAVh89WXl+YNtuT0GBpusVWPI9jz9zNHqpFSQzWQOCiDnMUfsNaxj1gBKX1/K71NL4FlyewCBtQLEca/cP8ixVs08Q135bYhQqzPtnGCDeRGCsop9dByeM6kG/Pxkhr2ch5EugBtJyg5x4F9BxS/fXsE6cmZ0X/ukH04jAPOIsHWSvotc6LiM5OhygV6Lbx0MPN8Cjf/II6stQABgkyvnovcK0hteWePcFfEb5bfuLNITvyvYn5TVFxZGXjco/Jsb4Wn4EOLrZ8yxfjiYIYhp/UwcZlfTLwc60CracM9bY/ulY7z+Jb6kznfEXjx1W3IJFFYRDS7eVNFsO1tQeNEg9BWiD3iQeyL9mIOCLKw3Cy+2Gt4MJhpo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(4326008)(8676002)(38350700002)(52116002)(7696005)(66946007)(5660300002)(83380400001)(86362001)(2906002)(66476007)(66556008)(478600001)(1076003)(26005)(8936002)(16526019)(186003)(316002)(6666004)(36756003)(956004)(38100700002)(6916009)(2616005)(6486002)(2304002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+Ehi0dr/YSJzxgLtxwQdyJzHgEtr76bhpe0CiS4suYJvxGLI3TJpnIaeGEu?=
 =?us-ascii?Q?DiXjXRGia8PRnV7pdXxnOApBfdnHaLJ08o4JR9yaa77SgVcoHrpNsnilB1Yz?=
 =?us-ascii?Q?qHC8Io36v7nQuQrMomV9+qpJ98NvrX35EZL8DQRjET+UxfStlrgIgqh3rTNX?=
 =?us-ascii?Q?2aspszumNsmec5qM83bmkxyoNqztZfYXRZiF9o0zjxm2R80oeCyVnhA90oTs?=
 =?us-ascii?Q?eDWunuH0jF2cPc3qO1npYP4d8Q/L0A6HH01d9vSkReE62wQHDagbuyLBL6Rk?=
 =?us-ascii?Q?hT4hlN8ZRvMvOm2cqEM5djMUVXg9VKjgT1WcMca+ELSd93LoxAqkilc672Vf?=
 =?us-ascii?Q?pBknIXXTkmYvslDiZ5ou0Rkorl5gz5s/IAgt17AbjYutSvfbiewoq7FanfyC?=
 =?us-ascii?Q?vH59NykLW2Ghs4p4YT69GJOj/w3En7kW/v5L7XVPfs7OfG4ngJkxMFMtGjYQ?=
 =?us-ascii?Q?bGgkHDgn3GP+jXi2QI95g5ia/b8cH1IatxJ3kQnJru2NJ9nfLn72zNfxZbv0?=
 =?us-ascii?Q?CM8gxL/pUrugSr5sXKt9+oiU4eTnWqXb4kFZZojripKQugVqfm+ZLvpEj0sI?=
 =?us-ascii?Q?jtJNpDNxo76eaQ2MrhphHUeP7uTZQis3fcmITjOCZf99A9ayEWjWUJLGdREl?=
 =?us-ascii?Q?eUkKqQAgk1RXIJjdRvE7oOCwMJBZzZAQvJqdeaxgc8QJy9b3pgFmpaUSCjKf?=
 =?us-ascii?Q?SfbVqlIwPJRLGYIl4rQjkqRtuVwV7n0nzCA8U8QTHHbWRmCTpXGCvq/w2fVL?=
 =?us-ascii?Q?sez0xtfGfrbqyakIbzZ2TcYEdEcx7hsYkR8G/p+cayHqLhWJgIyAsyHmRpu6?=
 =?us-ascii?Q?y2t2I8kpkjdMzeZETFpWyFYl2OXzL6tzpwx3dKubrZJzR/dOIkwY7lMxVuCx?=
 =?us-ascii?Q?OdAbbHHozDdgtfirNxbwBvwB17aCLbaOJCjKnynFttkTGjKh+KZaHxIMMvaF?=
 =?us-ascii?Q?ttfsWC/Vq1/1QyHfPCe/H6js6zbC9o7MQ5mUM3LXZtaqCc91drKb498gGhT+?=
 =?us-ascii?Q?n2lQaJjxotkCvIPpADPcqVXy6/drJzvSxAFyxEVHLx9oY9ox4GJ+wUR7B0gi?=
 =?us-ascii?Q?tz/TfxpWnz3I1rEBr7o68aQdq402avCa0kPF3b1DNrV+Ql7xVvN1OGu/LKc9?=
 =?us-ascii?Q?0bXlWXwmGLVDl7C8yJdCwLpCJJrm0LOZkYpvoIibnLrCfp8PMrfvIbuAc4Ie?=
 =?us-ascii?Q?YDp2BuBLeObaLRDJO3n3xNYQrLdpdeKx5qwFwDMMgN4A0zXKtnT63Hl9pRCG?=
 =?us-ascii?Q?6KjgwGjHcEYzkJ1YgnXK0gK/aT+03KPqdyGXTz1sSI3/Udj5qxG1Vt4R4J5W?=
 =?us-ascii?Q?QrKa1viqiY46hpXKa5N1nH7n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa740fe-4499-4994-6975-08d930a1b43e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 08:35:32.3633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgLrIo+E/ViM2ArY1Yqo1BRGCtSWDW5ENeuUViyIHceRkNhlSVz2eYUw77Bk6hMR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
Cc: alexander.deucher@amd.com, Felix.Kuehling@amd.com,
 xinhui pan <xinhui.pan@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some resource are freed even destroy queue fails. That will cause double
free when user-space issue another destroy_queue ioctl.

Paste some log below.

amdgpu: Can't create new usermode queue because -1 queues were already
created

refcount_t: underflow; use-after-free.
Call Trace:
 kobject_put+0xe6/0x1b0
 kfd_procfs_del_queue+0x37/0x50 [amdgpu]
 pqm_destroy_queue+0x17a/0x390 [amdgpu]
 kfd_ioctl_destroy_queue+0x57/0xc0 [amdgpu]
 kfd_ioctl+0x463/0x690 [amdgpu]

BUG kmalloc-32 (Tainted: G        W        ): Object already free
INFO: Allocated in allocate_sdma_mqd+0x30/0xb0 [amdgpu] age=4796 cpu=2
pid=2511
 __slab_alloc+0x72/0x80
 kmem_cache_alloc_trace+0x81f/0x8c0
 allocate_sdma_mqd+0x30/0xb0 [amdgpu]
 create_queue_cpsch+0xbf/0x470 [amdgpu]
 pqm_create_queue+0x28d/0x6d0 [amdgpu]
 kfd_ioctl_create_queue+0x492/0xae0 [amdgpu]
INFO: Freed in free_mqd_hiq_sdma+0x20/0x60 [amdgpu] age=2537 cpu=7
pid=2511
 kfree+0x322/0x340
 free_mqd_hiq_sdma+0x20/0x60 [amdgpu]
 destroy_queue_cpsch+0x20c/0x330 [amdgpu]
 pqm_destroy_queue+0x1a3/0x390 [amdgpu]
 kfd_ioctl_destroy_queue+0x57/0xc0 [amdgpu]

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c               | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e6366b408420..c24ab8f17eb6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1529,6 +1529,8 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 		if (retval == -ETIME)
 			qpd->reset_wavefronts = true;
+		else if (retval)
+			goto failed_try_destroy_debugged_queue;
 		if (q->properties.is_gws) {
 			dqm->gws_queue_count--;
 			qpd->mapped_gws_queue = false;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 09b98a83f670..984197e5929f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -607,11 +607,13 @@ static int kfd_procfs_add_sysfs_files(struct kfd_process *p)
 
 void kfd_procfs_del_queue(struct queue *q)
 {
-	if (!q)
+	if (!q || !kobject_get_unless_zero(&q->kobj))
 		return;
 
 	kobject_del(&q->kobj);
 	kobject_put(&q->kobj);
+	/* paired with the get above */
+	kobject_put(&q->kobj);
 }
 
 int kfd_process_create_wq(void)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 95a6c36cea4c..4fcb64bc43dd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -373,6 +373,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		dqm = pqn->kq->dev->dqm;
 		dqm->ops.destroy_kernel_queue(dqm, pqn->kq, &pdd->qpd);
 		kernel_queue_uninit(pqn->kq, false);
+		pqn->kq = NULL;
 	}
 
 	if (pqn->q) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
