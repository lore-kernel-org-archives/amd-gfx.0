Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C7EC2B9F4
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 12:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08BE361059
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 12:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08BE361059
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFBBD89C1F;
	Thu, 17 Jun 2021 12:03:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35DF089C1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 12:03:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgDbHa/WrzmFxK8J17kwWTT2y1IkspJrKq+bLcPFwiNu7UFkNlHkS930o2NvU8L4qApBlVBjII6HFlmP3A3az+sn4xu1Hjz10kb3BrIpIYWzjVDHALfxy3WPYdO+vzWM0sqqFamFeZ22ggominUOfohCS2SpjWFsXHCCtNEL8qoeUEDznYwa7nWhSTYtaHHWOc+lbmoIE7HKTUq2x+Y1Z3uSIKxUurc2o7+yQkOaIOa4Wx4hJrvZDXAOiXA5UrCcBY4h3S26ff5dAtYS0i2+srxOmIC6Z0kKTrMGoR51hC0RNPvsnKO6XUJMWCAv4aZh3IJfBSptOab5CXOD9XuIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nunFTehGAwqNLEHjuGHi2Xkq7N5Xg3zYhN+Eyzt5i1k=;
 b=lXqH/1n7536sYF+agGXVyfj0XmMj1kM+/LFNDtfiA3y4AYeCNKen259EzDNwz4KmJjNy2r7oLTnOxjOcQ4kv4DbEU9VPjDD9kGt1O+t3xOScqbe3zF0lgBQPcidZq8FaPU9ahLXjxf36cAKVyLj/oZkXtgZL6h1XISTlXoXZMSlxqkfoWoxlYbjypQeXoDXEG94rCyp+YvdswNCi5pjj8ug/QYeP1yW/7MzcFkGdWwim5dDmXX3xg6p8XIRXam0DdIGmQFY3k+nT9nuQ1CcsF90khBLFYt2Z6o9kLfCdsm4aq0r5SWvEvlqxp4OjlwLct1ZL77hSA0DvWvYA83bhXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nunFTehGAwqNLEHjuGHi2Xkq7N5Xg3zYhN+Eyzt5i1k=;
 b=iuC0kj6+1QT7q08N/KTQmMYLYVHLNv+QT5xh5Lba6LX97g+1nEEkYEu1WxPNb0dX80czxSlH3r6vBNp8HRRS0nCb/BgwDoQig4mA73aKEc47WgrzWS4omi3zrO4wd5FJZsrTxKJZoSYd02RN9C0SJpigIa67ymUtw7RFRza09js=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15; Thu, 17 Jun 2021 12:03:25 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 12:03:25 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdkfd: Walk through list with dqm lock hold
Date: Thu, 17 Jun 2021 20:02:46 +0800
Message-Id: <20210617120246.1730-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617120246.1730-1-xinhui.pan@amd.com>
References: <20210617120246.1730-1-xinhui.pan@amd.com>
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK2PR0302CA0018.apcprd03.prod.outlook.com (2603:1096:202::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 12:03:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4adb954-25db-431a-88aa-08d93187e90c
X-MS-TrafficTypeDiagnostic: DM8PR12MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5446BE125B73D9E8493D21BF870E9@DM8PR12MB5446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIxFgrdYK7FUz25n6KlNNZh4RBIkwmXAQVgugMJqW3VrifSvZgAzI7ObT9qDTKGS7xuDvFgZ4YXE5EZYLcL7dRsae4DAqnL6wg5UXk2cXmF1pEtdxYyKgJ8zFPhR8mBYRDf1/C8Iflm5FALu/p27g+mXnO1vVkF0nbtILE6iG5hqUBgHff2EBMlBag6NXkz6XrVg3JL/jFpg2ay+wFutisXXO8qmOsaAzAoclxK2F1ftZP8LhtE/V8dJJ1j9CjvTbXX3qCPfNmCDCAmcYK4GCeFn0598xq9K6mHvffngBYNV2jKvrkAkr0HSZ6gIktjzqUjgFUlZ8GV0VOD5KSms3JsJnRA/XnH5fjnGxrxnxTPzShk4Kdn7iO/K1wBY9l2pMQMdcEHoR19mm3Ghc2jIxVeWFC8+8QwqAQgnkWL4vU0oYot6vUemiRW/5sFwDGk0OnDVyuJwZtrA70jzet409eMgfOfWw5CToDaGx/ozEi9NY/t+P3VlweCSpAXxknuUXrs+IlrnNMx00UzfhRLbYU9IvB4e7r4iO3MvAiCW5ClT+YHEVOJ87yyPk6rBR3d9mLtRZfQGS0/BuLDWp5CNPA8E+14daCCHdJPiH9uqNG5easQy1bGBo+1LEpEC88GLtQDkOYyMh7jr/QfkgIzusNolt7cIB50RhFJwhhgfEVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(478600001)(186003)(7696005)(16526019)(5660300002)(26005)(38100700002)(316002)(1076003)(52116002)(8936002)(66476007)(66946007)(66556008)(36756003)(2906002)(6916009)(6486002)(86362001)(2616005)(956004)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Ey0Nob4AD6R7U3mVRublD1SpHzS6kLChRFl5edIAZRIqHwQBqKwWCS2PicB?=
 =?us-ascii?Q?9N8ktOSOMvmBEPStMNDGrS5EPkjQ+n8d3bJ8+Tn1e5YYuJCNp0iUnTPymbKQ?=
 =?us-ascii?Q?NN9oMwCndZyVr5F481Kmo76ZFnh6m/QCbtJnxHqh9eJbYK4VdIffBYqLyWm+?=
 =?us-ascii?Q?ISQ7VjdYVtkW+EGG2Et7F/hlbLiQ6jHPLuqkH4KwuTqiubiNLtuqigO+i5le?=
 =?us-ascii?Q?j6GabzT8LmOgZApgEjiZ5ptDUT76hw0aKKo/eCQj/iJBF1hBEtp6lcv7Puz/?=
 =?us-ascii?Q?q7u5mxs1WsDriyALQnFZtIR774g8uRSKKnxm1QihH4f7AJqA2gIaDDfn6Q10?=
 =?us-ascii?Q?QuhMposAXI1yFLwUH+iRtcHRQXmozbSweUzKxy0Cmj0wF1sPRo2DxJXB6o2F?=
 =?us-ascii?Q?+8JuZb1uP++SfCi04Inj35XSPE6XsdDoUpA1Yu1P6NLQJ1KkNdJqSP49LkhC?=
 =?us-ascii?Q?2P5X/xw3tQuHaPLhbaDCKY4YUcZPsuc5pYsaO7BPuYkXQAhuFtqqJJUv1ioo?=
 =?us-ascii?Q?9TBKkaWVEzmojvHo9SL8TvaiA+O2rVEU6/9HMLg4Uwozftsosa1CZo8a98Sc?=
 =?us-ascii?Q?BD1ZtvabytJmKUSO6+DIC7HwL92FPKP0FOyyc4QEIa5iQ1topzsh9Q7mkHEX?=
 =?us-ascii?Q?Z+vjGhR93nYqHvUwOwvnOKL4FN4altgF/t2KQlKQuygZv/Q64BKf08/YwMyq?=
 =?us-ascii?Q?xYofQaomHOwGCiLj1cqZpYTo2UhvaNohPITza0QAQeUHD3S8MMR0GG17eNSy?=
 =?us-ascii?Q?MHcI7sKwtONe7Z5ISIvf7X81z80R3A5gh3Ec5hkdgt1aDTsav9JeyCvJ6Hst?=
 =?us-ascii?Q?xn3sjNBZA/IdJP1JCNtVg9EMfPjgN5VSvDj7J8U8AEeheGeY8Ti0jN0Gedg+?=
 =?us-ascii?Q?PpWzYaoGojtqIvwaq6c1mFvi962iRlzhp/Q2cmGzA88GjonL7THy3krDUBtc?=
 =?us-ascii?Q?ALHqEgLGBilQjcg+KsRtiB2mwcOlch44EnoDxL/B0tt3ExX/kvoQQhv2Ezu9?=
 =?us-ascii?Q?dQARk7dsIROf5ZR5pujhwZkbxkqeyQBZR7/2YXIFAyIsQJJleXJaJgnJTf2X?=
 =?us-ascii?Q?xU3KryKT0cC3yiMJx+8vqaeJYyuzQd5IKhVEL+YtcsjYxq+3AStTdMN30cew?=
 =?us-ascii?Q?yurM7tzb1LaWXz8krlnwIRY5iPZDg+ovE51mKB/fgGHcZdfYKvH+zFoHSwk6?=
 =?us-ascii?Q?+1DCUlHVhtsq4W97tCIEEbv3b/qRBppCb0xKs2s/fIKHlZGywxc8vi6DEQwj?=
 =?us-ascii?Q?YkJOO8oE0xEwntDyh8zre+88H+CfUewNtVWnpWANGnrueP8NN5U5qhwKIT9l?=
 =?us-ascii?Q?R3UL0jBaYxqO4gf5eMDFgzev?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4adb954-25db-431a-88aa-08d93187e90c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 12:03:25.1149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLPWyTX7llgCAYmjRZFzufSIZooyHYWCBEDp+1gbYDVm0bP1uNO2Vv8uuux7EA+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
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

To avoid any list corruption.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 63a9a19a3987..d62374746c93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1722,7 +1722,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
 	int retval;
-	struct queue *q, *next;
+	struct queue *q;
 	struct kernel_queue *kq, *kq_next;
 	struct mqd_manager *mqd_mgr;
 	struct device_process_node *cur, *next_dpn;
@@ -1779,24 +1779,26 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		qpd->reset_wavefronts = false;
 	}
 
-	dqm_unlock(dqm);
-
-	/* Outside the DQM lock because under the DQM lock we can't do
-	 * reclaim or take other locks that others hold while reclaiming.
-	 */
-	if (found)
-		kfd_dec_compute_active(dqm->dev);
-
 	/* Lastly, free mqd resources.
 	 * Do free_mqd() after dqm_unlock to avoid circular locking.
 	 */
-	list_for_each_entry_safe(q, next, &qpd->queues_list, list) {
+	while (!list_empty(&qpd->queues_list)) {
+		q = list_first_entry(&qpd->queues_list, struct queue, list);
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		list_del(&q->list);
 		qpd->queue_count--;
+		dqm_unlock(dqm);
 		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+		dqm_lock(dqm);
 	}
+	dqm_unlock(dqm);
+
+	/* Outside the DQM lock because under the DQM lock we can't do
+	 * reclaim or take other locks that others hold while reclaiming.
+	 */
+	if (found)
+		kfd_dec_compute_active(dqm->dev);
 
 	return retval;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
