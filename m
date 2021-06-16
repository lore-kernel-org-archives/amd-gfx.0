Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E1A5C48BE8
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:35:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0444610A0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 08:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0444610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C74D06E52F;
	Wed, 16 Jun 2021 08:35:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131766E52F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 08:35:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlNofTTAW+iJ48ateARgG/y145vxrEVZ4kLYGLGc846OAGSHNAGyBBg/6qXkNNlhh8q63I055Ip9UyBMSjVMfmh1JM0wLPD2nYfFj52wIWYxiXHYDAHgMRQF1pblOVuVtAPOsRZnf1tVttTnXMRtsTB8WvVyvwzUYGgt00JllaLXEKt2YDecnJVfI1pD7N4BZ3O/YnWkD9btJinnQWahExxxAIRhJXMHD5zR4rpNsb2AKXX0YCc+/KfW+5mGtVKgUWxHk0+4lGHviBqnYTLBZ0Q6Ni1t/CtK1IAGBuCS/v6RxzDlibWkNiikK7Ya1rTaFNeXDC7ZMy+E6HcEMRYONg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ue5hHhksptINn3KT1CwY4hu+vNgBHwhs7S0sM44w6s=;
 b=SX4/rGTA2PD+f4v5gwrWMujifp09QIQSrGuIopEtLSsTayNeUNLUvNJfWNw2s8+r6TDfz4FIDYe5qpWypdC3oewazBECIzPXjB7LjQi3etEt/feiyyk6l92KahO7fRiu9Gqta1JDc2cXft+SXU/PFBy37slVjk5/J5lDIgZnXb+YRYAB+u3cTy6BD1eWoRzYtnyphAwMgF3EpqM21726mYbCruglB3MTDKz47mcwK8TNIFFA8E6ZDhWgNwwaRauPy5ZZwl6/kVbyJ2T4EdIaL3z3qi/OVKIovbBrBk/L1myHJI/r4n/5aUXc5ctA/ERdNuoiWBEUbpDmHm0DXhBLyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ue5hHhksptINn3KT1CwY4hu+vNgBHwhs7S0sM44w6s=;
 b=a3iyoCJk4VQOLs8vfNQ1UGg3mTiTaKAZOv0htPC+xbNrzURcAC934hm+stEdcYwdQ5TO34Lwz2XsxXQgh/GQXATG1prULgiH7Eieebg6L/8LJfYmty1wtwJBrNzdPWxLJ0GaPQS+iP5kEsoSaRMgmy4sER/rET+LSJrFSrzJVfw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.19; Wed, 16 Jun 2021 08:35:35 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.016; Wed, 16 Jun 2021
 08:35:34 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdkfd: Walk thorugh list with dqm lock hold
Date: Wed, 16 Jun 2021 16:35:11 +0800
Message-Id: <20210616083511.2489-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616083511.2489-1-xinhui.pan@amd.com>
References: <20210616083511.2489-1-xinhui.pan@amd.com>
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK0PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:203:b0::18) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK0PR03CA0102.apcprd03.prod.outlook.com (2603:1096:203:b0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Wed, 16 Jun 2021 08:35:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e490d9f-92a8-44ae-9b25-08d930a1b5d1
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54772DF9ABA3A0C6C789AB2A870F9@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5bpA3cIkIs/UP9prhHvvbQzroepow7Qv2ERFsFBVaFIpyYB1vXx4RvYheM65wTEcyNleVmaAK7Zaq1o4FpM4Bmve/jbzbpRmM4dpGtVxzVtJYanqAVVXEjV977vntc16U7Y8zhOGhw88LqEWGlwMbYs2ImMKcI54KTzQwbhVzp5HnNdcx5wROfNVoBpTgoBF/mEbvzCqN4lh+tjK1/2jMMQGuQ9680Iq/dbb+37JT2mgOs6evu67Bm+AHm1WU36rNCnDuPkoOOV38/vdwVgUZdW2RD8KOnPcPz6vQ7iKb/fjfEPGN/rCJxABRSyx3Az1qzHOisMlgffN5YpdTu92GO7B8cFZZ8HrFE67PTFdUAAsCgrzKxk+X8tpVcgbCw4Rhuqn2oGiUGhBgIDYbAPrJHoc4eSUM6eAKtW26qeaq9MKfIcO01DKklze+9sYTxvcodXZ6DE9HpF+11BT9l9V7UObFGE4KbDyQgW9sm9TlIEzaBJYc8yhuMig1Mztzm6NmIJQBfaQN7xQXbVsaSGzRmU0rnsQj75zDlm+B/i6w7/po7az8J04DwrJDYnVumu8iZWqcyM8gsNMZtu9BWPu2Bj5kFpaMDTex/XDPI+dBbiUYBC6Dvoe19oaIquDNwIHNhZabsycFic7aQWv1Zu57xb6/TxL617oblwO5I2Vjw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(4326008)(8676002)(38350700002)(52116002)(7696005)(66946007)(5660300002)(83380400001)(86362001)(2906002)(66476007)(66556008)(478600001)(1076003)(26005)(8936002)(16526019)(186003)(316002)(6666004)(36756003)(956004)(38100700002)(6916009)(2616005)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NIUnQL3px5UP55BULPhW+3juMTxtJ+a2I3NygsFgfOHqlAaej4p8lkHl8tfR?=
 =?us-ascii?Q?h6poNnKQBn/LGAr+W0HxMK5V63zCshM/Bw01kKYuHWFwaiB4JXe9mdVRv0DI?=
 =?us-ascii?Q?HA/yWFoZFHZs+6kn5JZ7eIBnYzf29eFDZlq35tvuDhStdGY1cz76GskovJUJ?=
 =?us-ascii?Q?uvmygr1Fbzmo3Z0AcdkA8nZPa2JFW5DTR9sSGKxLZLK4Y88MT4t+2Nwp5rdS?=
 =?us-ascii?Q?l9QdQJbJi/uTRcQ8cmDt1R4pcn/2FS/qbHdegSC+a+Ui2yiBBg9lfhco9Umt?=
 =?us-ascii?Q?wXmlGcqrE/Yt8V5374pQOZOJp8AbDEGm2uK1ctRM39LTImxw09+cZ4QGDzv4?=
 =?us-ascii?Q?LocIgaoUzh/+GJck8DdIR87okF7JfKITYNMGNW6islHRgkrhiWN7GpbTRLkK?=
 =?us-ascii?Q?Bw7GMnBEubRVyecQ0dIHt+WfO8bwZaB0hVS71svbvF7OFLdQQ734NSdlMANh?=
 =?us-ascii?Q?Nsv5+Pglhl3Yo9tHpRrJZXTkaqkZM86stvW8Tk3z7DTfbirwK4joKtp3Eqqa?=
 =?us-ascii?Q?oe+uejy5CF8wB3iO7EISwIajygFLEUA897je5jPEs1DOqt2wdlbbwEDMV2FU?=
 =?us-ascii?Q?pDq1EAAK2Vlb4uAv1wdbZmVQoK+hhHaivL0uILiyN/UppWYN+jqF/vfuFcRh?=
 =?us-ascii?Q?9+TxEDAEL9ItSrJf1g3lAzpA/hpqRfiKQfYLjTws4QukNFIrljGxXun9wF3/?=
 =?us-ascii?Q?6Wmc3X6vNRy+ZT8YVy6Zi0njKVrp55ct/6QBply0auubSC+IOkHE/NgIBMMl?=
 =?us-ascii?Q?kuTh2AVUZ+6T1lmXzb0C+GpzvfWJ52hU3eSf9CcwGZJcgEccY8VkQTDbDqgr?=
 =?us-ascii?Q?PA46azy9O7N/aMhzmcccAv6Y4AboK4R5/fECvxjkghPs3IAok6R06aoP3xLN?=
 =?us-ascii?Q?59sJse19swU3BidU+u62gL/EpYpfOr3fePxqvmQQM9tOy3n8HqILD3fV0Sw8?=
 =?us-ascii?Q?90afOBFVpYPkoX6rbhKfQokhx5dn1HHGxc42PEwTloJNw3XBPOLVl5LXdkWn?=
 =?us-ascii?Q?hP+IGMPvOBUBG9u8Bi8CDZ8Py/EmS2IWGOv0SKxMnzaWm5FJd7SRIuIXs36U?=
 =?us-ascii?Q?+uG7BrIrxNGkkSsqi/F6TM+xZOBdargDvACuUxTGzoTFD5rQvZ/hU2Wyo+Bv?=
 =?us-ascii?Q?+rySaZCydCqdEm5XPE4xRcF+vd80O5TRKt9CbhpkxQI9Gfp81qaXjjaKXZ21?=
 =?us-ascii?Q?Uwb7A3r5NaWpe6A7pPszqu4EhzYxxHUfeetVKs/CbByeEJ20PI7cWg3cgiKf?=
 =?us-ascii?Q?dYpZaWma1O/XYbveeMBXjKCAEcUEoZkvgdljRc4Y3EjqZvkiGB2pcc49es0E?=
 =?us-ascii?Q?n+Fh/z2zABWT2abT0Z0prg3J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e490d9f-92a8-44ae-9b25-08d930a1b5d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 08:35:34.8882 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GgAWZbuEOuL89VHeZgru+3RxF6ByzLZ9RdzOkE+WHVPtgoIfUz+7VvRvqfrV/vNr
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

To avoid any list corruption.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c24ab8f17eb6..1f84de861ec6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1704,7 +1704,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 		struct qcm_process_device *qpd)
 {
 	int retval;
-	struct queue *q, *next;
+	struct queue *q;
 	struct kernel_queue *kq, *kq_next;
 	struct mqd_manager *mqd_mgr;
 	struct device_process_node *cur, *next_dpn;
@@ -1739,8 +1739,6 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 				qpd->mapped_gws_queue = false;
 			}
 		}
-
-		dqm->total_queue_count--;
 	}
 
 	/* Unregister process */
@@ -1772,13 +1770,19 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Lastly, free mqd resources.
 	 * Do free_mqd() after dqm_unlock to avoid circular locking.
 	 */
-	list_for_each_entry_safe(q, next, &qpd->queues_list, list) {
+	dqm_lock(dqm);
+	while (!list_empty(&qpd->queues_list)) {
+		q = list_first_entry(&qpd->queues_list, struct queue, list);
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		list_del(&q->list);
 		qpd->queue_count--;
+		dqm->total_queue_count--;
+		dqm_unlock(dqm);
 		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+		dqm_lock(dqm);
 	}
+	dqm_unlock(dqm);
 
 	return retval;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
