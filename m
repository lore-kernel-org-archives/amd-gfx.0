Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FA7C48BDF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 08:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E09613EC
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 08:03:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E09613EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A50889C83;
	Tue, 15 Jun 2021 08:03:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB2D89C83
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 08:03:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNW+VpPdmd1J6Mnd7DzaFJUtZQQx90d6tMsvqGpTJNfL4FqyVrR9FVxsKQF7hxyX5D0YGYWT9A6o1A2zCpRJYgP56xP/MUlL50a+nj1wfzAy2cmRcQTrv29iZD46H9/e5zAFBGHXnXTv9uFSyX10H3Fe03r5UPkJOecaY57OBovPfVTHGmR0EgU7KI+6dz5UmiMhUrMm/y4lf09YV9IhAdmWjqdrzvZ3otqzBQcHA2D/H0c7k+XRpAqQ4onMhaWNOTtmCSzT9PgE5Uw/C9LxEJqhXXFyyelz/cCxyFd6/GFAgEoT9FNhuIHQN8b2ipUngE45pDCZ87hfh3LNAcZN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA/3w7JM98xouASwv+JYln/Pd3gbrqU9Z8aFQ81FlFk=;
 b=J4uUSbP28gyOyaBAOARnhEQ1aD8YsyK8Twln3utl0QjbCHxP/ckk6jIPB8B75OSFZQhQnJHu6mNXQ7qtj3x6A/IC/jITSqFuKR29wwPfihYdzndQgV6AKtc5p6Cx4/8g3VcGYw1m/u0z6rhOzA8mI50yKmxJ9GiIX7GGyEvdxLyySUB8VmeGQ8T4LbHyoe5h9WRgklpbz1Fkvok1oPgpfhO/cTkW6PBgb6KokTzZfgfg/33X5NV7juCmJH/b1hEsC/2ziRpkjq/99L/ayax3cgXdyR/0zyiLkdOMcP+Zin7AXMVKgr99QQgq6+qpUW41MmfarggCGNFOvF1zyR5EKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA/3w7JM98xouASwv+JYln/Pd3gbrqU9Z8aFQ81FlFk=;
 b=T2Mb1LyafwJbxZyxhcP9j+p4J7NoZp0CKKAnBLu233A8Swu0ZbbCvidJRobHIZlk3Ex5oXaWQmDpRIlkLOxiETmCGQKteywO6QXim7+OUQKNDR1zdVKCYNd98XTLugajPRXRPeEqP10zW71asFYvo5UGH82C7jlFkyhicj5IV98=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5326.namprd12.prod.outlook.com (2603:10b6:5:39f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Tue, 15 Jun 2021 08:03:18 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::2091:3f28:3f68:508%6]) with mapi id 15.20.4242.016; Tue, 15 Jun 2021
 08:03:18 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: Fix a race between queue destroy and process
 termination
Date: Tue, 15 Jun 2021 16:02:33 +0800
Message-Id: <20210615080233.14596-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HKAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:203:c9::7) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HKAPR03CA0020.apcprd03.prod.outlook.com (2603:1096:203:c9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.9 via Frontend Transport; Tue, 15 Jun 2021 08:03:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d27908da-e8ce-476b-c2ae-08d92fd4092e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5326:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53264E86D487C41310BE3EA887309@DM4PR12MB5326.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:466;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2gmaTxpbzSztbkC9nxmsUhQcd76mrkuVkZLk0GQf/mgUQaOyjomqFEW/qGL4SEvfu19SufiTD5ipKINESE82tevA6yfSdKrXafJgoy8g+L3Ln4/HKWpCNEd7YORSjZ8a3kq6jwgJVVsUB44LoCGiNMEv0tJChxojG198dnkbAWYmOGTK6iN/3gkiVVwwLMuL9lzdXAGNwQ/WW8IiBOxA6RjKp7UbaQFo2Eqposq8NCzusXXlwiQXLZzuN1MT8Oq6HKBaycasdBTJkAFcVkW3DhZE2r7C5C4T4j49dn6nNwgyBUvwlXc3JKYaMesB6c3ETNLkefLels0l3/l6RFSK2Ilk6zbYTfr55kLThKrM/zmvQjC9LKpQ819h1YN4pW0Stg2bV968vG24/yuln79Vg0cWfv5uAskDtB6/3e7dgnReBF3dFGoTemeuh9cjmhC4EQj9suuBG8f99B8T2Uk9bRk+HUG8RVSJ8ssLm4HBVD9JfcEDoR2Nk4KBrLHusQacGZwc7jZCXmSyK4qKCG9JA6EXtyka1TDIGLSdyg5pzMUgTJ4ITnmxhy66mD0oo73sL/q6OVD5ccM8FucAyu74v6xgjShAStplF0Mday2PBBtMFMB3KT7kh15hgEvfpVE15ITK7HH2VVv/FB+UqbhGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(4326008)(8936002)(6486002)(186003)(16526019)(478600001)(2906002)(86362001)(6666004)(26005)(8676002)(66556008)(38100700002)(38350700002)(956004)(52116002)(36756003)(6916009)(5660300002)(83380400001)(66946007)(7696005)(316002)(2616005)(66476007)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZTPZOGpKnTgBFQLy0IJj1kXT289NK2H7fINGqrzo5x4epjFLX+nWYqe+1QTd?=
 =?us-ascii?Q?VAXxXEOrQ6TOSWREvkMhl63thvS9IhTpVXyfvsnq7cvfsj/Zj5c9DK5oyo0y?=
 =?us-ascii?Q?Na+BGvkfpP4TDjtJSoI3zIQYAgCFrp5Fp8cG7alMhQ9Ro7FWyy/MaRslwpIn?=
 =?us-ascii?Q?GtYtxA5uvzCWQlqrtQhfzS6fWlj3WJ6MnHIJu5Qr6Q4LGFcr+LCa7OvTcRx8?=
 =?us-ascii?Q?ImxaGIx4jtM3mAlPNK7YKiULhyI310LHVdXOzL5seYXrjfxeuzKg5jFJve0Y?=
 =?us-ascii?Q?fZGPCa8/PQCmNRGATxJueB1mlvpjxArsO/DyYz2h9Qxi6HVFLJkmBCidkRJw?=
 =?us-ascii?Q?m0dXzZi+xPmp++ByFrS2Ly0bL++U2ppyWjOUymqE9cqBbcVbGcTEWJFl79+3?=
 =?us-ascii?Q?aCM2R3XevsMCjdLjuohCkDxV3XTz0ADK4HI31Au9dwURxVzUFTcebine/Tcs?=
 =?us-ascii?Q?ZfY8W+jk1PYTNJ+zmRtPD+Ve5Kgu6jkB4G3dDJE0n5xWAZzWhwW7rCt8pSha?=
 =?us-ascii?Q?LQhU9n/eH1osMNajaptBsV9ASN8NML7TMMgZ1PzVSuZ/+2mHKLNzB0xnpD8q?=
 =?us-ascii?Q?d6zGZL6W3wgKzChq+99le6mNFRe5GaSZoRfJkr5a4jMWZc29iS5c4bHf8tSh?=
 =?us-ascii?Q?wUF+6zF3aeurzWduRh3Q58WA8h3GX2lp7emLNiTd1q594djASMMEsYBL6i4g?=
 =?us-ascii?Q?TiZ4w3y/iDNJsU5aNwK5o9aG01pX3+aRkGW/7wyBQuigxlyoMDmicCXT/n/c?=
 =?us-ascii?Q?8yKhA6ZePF6Qoy6rrqIMnuEcmVtrt8iMEGRT/ncswevbEEUmiRd8CPX5LyH2?=
 =?us-ascii?Q?ZcdiTcvl4ROHIchOrHKqahdASfQPzTyMgKr7me6DtuXJTvDOyJZlVsLzumBa?=
 =?us-ascii?Q?NrDvYA/G8XMRclSxKD/7GzGnhF1v3Fq7qpj8ssnDqs7u3pThkWRIVgwMEui+?=
 =?us-ascii?Q?7aBocvowAJOpJ/tt833Sqd/vSTejCtGznPUBFM1nL1N8eqJLiaiF15VFw3mg?=
 =?us-ascii?Q?bJMjX2OCrS5I3deVB4hXsgdGM7XVOkenYxJ7c4tp2feUoznh35g+MvtTdpAb?=
 =?us-ascii?Q?D6TuWIt2qV9oiZ81pQQr7zp/Ky49sAz1qZh4rYNUU+7WqT0eMpWXOdfHdmck?=
 =?us-ascii?Q?g4bfeq96EfHwQ2FyjLGPvJXlwkgXUPRLl0t3uHW2dDwxf+re7sLYmR9BxJx6?=
 =?us-ascii?Q?0CCAvj+BrkpnTzYnt4UCN1GLeTF2cyTkYMyYm4LmmI6Ebtgr6gRnLcTtv48k?=
 =?us-ascii?Q?J9tDJWrRSKgC+Bco0mKaIb0OZ4nIA5Ji4eYXQP8iLKmVMVpVyp19FOnuahd8?=
 =?us-ascii?Q?KT3+HOyfcLY38UM5LiooQwj1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d27908da-e8ce-476b-c2ae-08d92fd4092e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 08:03:18.5089 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5+Val5kXVf0hPxbJBzHNLoz0dGlaAQuAta5aooACjpq76rSJU6QNBh5yQ8bzY82
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5326
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

We call free_mqd without dqm lock hold, that causes double free of
mqd_mem_obj. Fix it by using a tmp pointer.
We need walk through the queues_list with dqm lock hold. Otherwise hit
list corruption.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c   | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e6366b408420..575c895fc241 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1484,6 +1484,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	struct mqd_manager *mqd_mgr;
 	uint64_t sdma_val = 0;
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
+	void *ptr = NULL;
 
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
@@ -1543,10 +1544,12 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	pr_debug("Total of %d queues are accountable so far\n",
 			dqm->total_queue_count);
 
+	swap(ptr, q->mqd_mem_obj);
 	dqm_unlock(dqm);
 
 	/* Do free_mqd after dqm_unlock(dqm) to avoid circular locking */
-	mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+	if (ptr)
+		mqd_mgr->free_mqd(mqd_mgr, q->mqd, ptr);
 
 	return retval;
 
@@ -1709,6 +1712,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	enum kfd_unmap_queues_filter filter =
 		KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES;
 	bool found = false;
+	void *ptr = NULL;
 
 	retval = 0;
 
@@ -1737,8 +1741,6 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 				qpd->mapped_gws_queue = false;
 			}
 		}
-
-		dqm->total_queue_count--;
 	}
 
 	/* Unregister process */
@@ -1770,13 +1772,20 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 	/* Lastly, free mqd resources.
 	 * Do free_mqd() after dqm_unlock to avoid circular locking.
 	 */
+	dqm_lock(dqm);
 	list_for_each_entry_safe(q, next, &qpd->queues_list, list) {
 		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 				q->properties.type)];
 		list_del(&q->list);
 		qpd->queue_count--;
-		mqd_mgr->free_mqd(mqd_mgr, q->mqd, q->mqd_mem_obj);
+		dqm->total_queue_count--;
+		swap(ptr, q->mqd_mem_obj);
+		dqm_unlock(dqm);
+		if (ptr)
+			mqd_mgr->free_mqd(mqd_mgr, q->mqd, ptr);
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
