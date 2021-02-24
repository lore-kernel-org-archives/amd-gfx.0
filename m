Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D241FC433E9
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9569564E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9569564E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 154626EBA6;
	Wed, 24 Feb 2021 22:22:38 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770089.outbound.protection.outlook.com [40.107.77.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 714626EB9A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMVh/ygAvmX2FlAYcYZFDJSRtPnAwDydnF6+VsKZb2++e8Jcct4bE1y8i48QPVPPg59JFCxhoT1050B4j7DvBN0TyEpSChCET6W+N/1xyHhMYXZf2rEVgqfkwQRYwqDIOgfylvf24SUHFKLOxTTODojbzr06o2pcecCfqiV8rS2un4pMUzjbEpYQ4AAJ4NZlOc5iBbvPEd7SuXUgRU7tVa+YQp1ETnR3RLmheIoCOHfoE8juj0H4La6S6E5/7tPGTpa4CBLp6U6eexrQj1kaBMQgQwaqh680SsuK1Ty06FVjBsTi4SsymcytdbOmzFzdBxTnHNCZ0z0WhCU+QSxFkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhMgYtmllkc9ugMR6IKXCie0o/onl7L/g/Imj3L/G/0=;
 b=b9Z2ZSb7ElGk5jZbq78BlKNcSXTBouy1m1On3zio0rcFPtnBxwka44YMz9EIglpi+/eqtqAzqq5afdEzv97csXxcSYBISY6fbyuLLQMrfEQ943LpETAurp2WD3Q0jG4xW9EEfa5WUFwwOGlaeZTp3dStgR4DR2igWaXQSJDfmCooJnNNf+kn+75sWVLbojd8YzwfYvSuT3uwvxNVXB31ybeiMBln/MBmui6n/lIYaQfhuTX22Wh/IOWkhLUN+JDd7KssqnuizRIVzkO/PvT2rQLTDNaxKkeiT9nn34zPjiHuEfBDA10U6qzDiRb+Tl6jPddL2kx8+PLq7xjPGmkRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhMgYtmllkc9ugMR6IKXCie0o/onl7L/g/Imj3L/G/0=;
 b=Atfb7RNX6UTocWpX3ndnpVSI9cW1P4WQxCXuNK4PGrzFFQMApXEutQV6y4ayTTbXJnnmd16J7OQ9OQAcM0hORuEcWrcXSR6OEHxnjPx8dqJiRO8IyCSdC9MEG2Fh/PT8IQrQp8qxzOjAtR1kGPHXIoJ+8C6KwHjObN9WBaj4deA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3807.namprd12.prod.outlook.com (2603:10b6:208:16c::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 22:22:35 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:35 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 145/159] drm/amdkfd: Check HIQ's MQD for queue preemption
 status
Date: Wed, 24 Feb 2021 17:18:45 -0500
Message-Id: <20210224221859.3068810-138-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:21:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 993307d8-622c-419f-1235-08d8d9127720
X-MS-TrafficTypeDiagnostic: MN2PR12MB3807:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3807C91D1421F1DA3F297FBEF79F9@MN2PR12MB3807.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: actQ9Yp2IXQ6TAEwLSG8AAHj34noJZn/WJKYXI0A84JsIL14e9SFMlFYC9/rykU1d5teNuRGp7PLBwQw2ZiJcStcZWYKDOHwDdnll5Z5NAt33gvxu31ffJlQHAfx0qJsnjttgJjSu22YLyEbATPkEBcLw+ev25GNc+PChH7adNZG5UjyqvQEYI8Gz1cc/VCuvjZV+voa8B4LerBzl0h5dB5ZNxVBY9ZJlmsPB6bsqsUxIxaz9wEEafVcLpakbHedK4J0ceaBNf/HgjWlxBSdZAFmIkOwZpqi6N4xgupMEedIr6QkPuXMJ34eOfXeRu7mB3KiMXCb7kS4GniyxMEqfpbawwbG3QsfpjMMVCT2YAa0oLXDjFeJwGWWLr2J7lh0DU4uF0HLhUYvR0KVbJpxEin3mLuyZUaS2Y0vFIoZQ7fPueemx6gPcetSLXDCxt3/FXtJIfCwkydcc4jl4HQX342H3IJSVrbQjTJ9LPU+oDU1oggieGySY/+ARvHji/POnXce42xXKjj3UeEB0I7R8p31TPk+TsCHyC/VaAqnK/BzMsBFDJiyW/ZiJ4CzlX3uML4AFSWGVxRyBAKGcIlpyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(366004)(346002)(396003)(54906003)(478600001)(4326008)(86362001)(83380400001)(16526019)(2616005)(186003)(36756003)(66476007)(1076003)(6506007)(6666004)(66946007)(69590400012)(6916009)(8936002)(6486002)(6512007)(52116002)(5660300002)(956004)(316002)(2906002)(26005)(66556008)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G3FdqP6pLQFTwJk5xB34boX4Ja1Co+YFh8sEhYm9SusAXk7xgDlzThrHkfTd?=
 =?us-ascii?Q?A/d2vGkaeTeFW60Xki94Rg7AxOgyX0ySFj0LUyCwx05j66z6LobICpGb5YfK?=
 =?us-ascii?Q?0Hn4kG69Cu2bRVfTUTic9ZPUyX1+Advgs8P/ttLorBxo5AgihEh1p5GiqPe2?=
 =?us-ascii?Q?1gW4CXn7rg3vpqzwugGIjXFX7LQvIcdqTfuCs59dUfaJMMIsOo7egrm6sSaM?=
 =?us-ascii?Q?vyrVH7/bu5QVjGeQKn67/RtDeo1vmR4XqPgfDmRIkaof0mOQgdWtHp5M7C8i?=
 =?us-ascii?Q?RqK2UnDPZRMoej9gT6VWOgLt5K4t+TfsEjD2SclEuGJ3pSt7ETdDBx/EYOpN?=
 =?us-ascii?Q?xtXBeMN9mOPmpJpbvK4/g+oZdB2/j8BSqmFUm7pf2CGYCpXqI20jU7gdaU2B?=
 =?us-ascii?Q?vLZOFOglw/xTcp/d0QhFiARdLnUGaKzLOND8NuX5+rqsIqscmA006dMtgTQO?=
 =?us-ascii?Q?TO5/ZFFRbUxl6OeDYxLrrH+RtchuSb/ZdQnDEL2C5gZ6r7LRbZfuWE3rzDDP?=
 =?us-ascii?Q?dJjWEsCSQoRCVHq12rVD2TjrvpLQ7rxr2WscL/lDzJmKjXUoAcovu577TzDX?=
 =?us-ascii?Q?BNE4SOJC5qx34cpNyEYa+P2VFbX+9gjNFQPXMDUkJVJOaxGvf9k1HKS2fa/H?=
 =?us-ascii?Q?qvvg682EL+717xDVjPfMJroTO2D2T9UF0ye26/3Z9kcjehsUyDC4k5cMj3CO?=
 =?us-ascii?Q?K6FdTXDVPcvg6EzBpBtX+/l1iBmEsiPRqH2e5FCgX6qiB6ngo88cwSSMXguA?=
 =?us-ascii?Q?UyY17QJ5cfkrqJWndrJxiidmu1KFFLQv2tiA4CR60Lli/32ZnpoKO3AmuxuK?=
 =?us-ascii?Q?Z49g17GYPq2W8UOZQLN2/T+iYJdMQHLXda98CTGnd/scb7E95kQ7f8bNx7FS?=
 =?us-ascii?Q?f0GLrBEfeIGgVZYmYt0hrPOKoJ4d3zIHDedLx4XJ+7chWub0osbc82dsS06f?=
 =?us-ascii?Q?k5CjUStayvIZ8zPgO8jxv8LrvSgJaTQtnsCWK/JHzH4ZDRWWYOdaAdtlu1r1?=
 =?us-ascii?Q?ocQumbn4OF4vyqkBUaqfdCwCcXYHByuybraeZpq9cy6R3nhaJEOr56Wi5UPb?=
 =?us-ascii?Q?EUMKxzGIWvejxpjpC47YTD9SgXFjXdmtL1umBFHisL0qO82rIcoHTR++9+2W?=
 =?us-ascii?Q?ASGnDq0JqHxZ4o3OqdPz1BiynB1pSiQsew2lbwcJaA/ZD2rx3MxJeijBErCY?=
 =?us-ascii?Q?ezIYCSJSRy37oVyPokm0Qj/tilyLPvC7n7YzFR9tbZnWagBULN0eWBvYBAqd?=
 =?us-ascii?Q?AIYjuz14i32JeMAjx7u5YpERtYpj1EegS3BcpGj6gpZvhUHnxYbc/fIxXRRB?=
 =?us-ascii?Q?O9vRAYZQLcPBOKOX7c5UAFuZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993307d8-622c-419f-1235-08d8d9127720
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:21:00.6304 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6KkBVAE9cr1cXljaIM0o3tmJPVv9SNo86UaclcnNpz2Ot48eduLWxhTwcb9Nrvgo/E8ZvX1EdPNTRaebpDQjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3807
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Jay Cornwall <Jay.Cornwall@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

MEC firmware can silently fail the queue preemption request
without time out. In this case, HIQ's MQD's queue_doorbell_id
will be set. Check this field to see whether last queue preemption
was successful or not.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Suggested-by: Jay Cornwall <Jay.Cornwall@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 17 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  1 +
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  8 +++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  8 +++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  8 +++++
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  8 +++++
 drivers/gpu/drm/amd/include/vi_structs.h      | 32 +++++++++----------
 7 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a0daf0ebbe78..eade05080ad1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1393,6 +1393,7 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 				uint32_t filter_param)
 {
 	int retval = 0;
+	struct mqd_manager *mqd_mgr;
 
 	if (!dqm->sched_running)
 		return 0;
@@ -1424,6 +1425,22 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 		return retval;
 	}
 
+	/* In the current MEC firmware implementation, if compute queue
+	 * doesn't response to the preemption request in time, HIQ will
+	 * abandon the unmap request without returning any timeout error
+	 * to driver. Instead, MEC firmware will log the doorbell of the
+	 * unresponding compute queue to HIQ.MQD.queue_doorbell_id fields.
+	 * To make sure the queue unmap was successful, driver need to
+	 * check those fields
+	 */
+	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
+	if (mqd_mgr->read_doorbell_id(dqm->packets.priv_queue->queue->mqd)) {
+		pr_err("HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
+		while (halt_if_hws_hang)
+			schedule();
+		return -ETIME;
+	}
+
 	pm_release_ib(&dqm->packets);
 	dqm->active_runlist = false;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index fbdb16418847..b5e2ea7550d4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -101,6 +101,7 @@ struct mqd_manager {
 #if defined(CONFIG_DEBUG_FS)
 	int	(*debugfs_show_mqd)(struct seq_file *m, void *data);
 #endif
+	uint32_t (*read_doorbell_id)(void *mqd);
 
 	struct mutex	mqd_mutex;
 	struct kfd_dev	*dev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 19f0fe547c57..064914e1e8d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -226,6 +226,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	__update_mqd(mm, mqd, q, 1);
 }
 
+static uint32_t read_doorbell_id(void *mqd)
+{
+	struct cik_mqd *m = (struct cik_mqd *)mqd;
+
+	return m->queue_doorbell_id0;
+}
+
 static void update_mqd_hawaii(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q)
 {
@@ -398,6 +405,7 @@ struct mqd_manager *mqd_manager_init_cik(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
+		mqd->read_doorbell_id = read_doorbell_id;
 		break;
 	case KFD_MQD_TYPE_DIQ:
 		mqd->allocate_mqd = allocate_mqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 18e08d82d978..c7fb59ca597f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -224,6 +224,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
+static uint32_t read_doorbell_id(void *mqd)
+{
+	struct v10_compute_mqd *m = (struct v10_compute_mqd *)mqd;
+
+	return m->queue_doorbell_id0;
+}
+
 static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 		       enum kfd_preempt_type type,
 		       unsigned int timeout, uint32_t pipe_id,
@@ -425,6 +432,7 @@ struct mqd_manager *mqd_manager_init_v10(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
+		mqd->read_doorbell_id = read_doorbell_id;
 		pr_debug("%s@%i\n", __func__, __LINE__);
 		break;
 	case KFD_MQD_TYPE_DIQ:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 3b6f5963180d..7f4e102ff4bd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -276,6 +276,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 }
 
 
+static uint32_t read_doorbell_id(void *mqd)
+{
+	struct v9_mqd *m = (struct v9_mqd *)mqd;
+
+	return m->queue_doorbell_id0;
+}
+
 static int destroy_mqd(struct mqd_manager *mm, void *mqd,
 			enum kfd_preempt_type type,
 			unsigned int timeout, uint32_t pipe_id,
@@ -477,6 +484,7 @@ struct mqd_manager *mqd_manager_init_v9(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
+		mqd->read_doorbell_id = read_doorbell_id;
 		break;
 	case KFD_MQD_TYPE_DIQ:
 		mqd->allocate_mqd = allocate_mqd;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 31799e5f3b3c..33dbd22d290f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -243,6 +243,13 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	__update_mqd(mm, mqd, q, MTYPE_CC, 1);
 }
 
+static uint32_t read_doorbell_id(void *mqd)
+{
+	struct vi_mqd *m = (struct vi_mqd *)mqd;
+
+	return m->queue_doorbell_id0;
+}
+
 static void update_mqd_tonga(struct mqd_manager *mm, void *mqd,
 			struct queue_properties *q)
 {
@@ -446,6 +453,7 @@ struct mqd_manager *mqd_manager_init_vi(enum KFD_MQD_TYPE type,
 #if defined(CONFIG_DEBUG_FS)
 		mqd->debugfs_show_mqd = debugfs_show_mqd;
 #endif
+		mqd->read_doorbell_id = read_doorbell_id;
 		break;
 	case KFD_MQD_TYPE_DIQ:
 		mqd->allocate_mqd = allocate_mqd;
diff --git a/drivers/gpu/drm/amd/include/vi_structs.h b/drivers/gpu/drm/amd/include/vi_structs.h
index c17613287cd0..50ebf885fa7c 100644
--- a/drivers/gpu/drm/amd/include/vi_structs.h
+++ b/drivers/gpu/drm/amd/include/vi_structs.h
@@ -397,22 +397,22 @@ struct vi_mqd {
 	uint32_t reserved60;
 	uint32_t reserved61;
 	uint32_t reserved62;
-	uint32_t reserved63;
-	uint32_t reserved64;
-	uint32_t reserved65;
-	uint32_t reserved66;
-	uint32_t reserved67;
-	uint32_t reserved68;
-	uint32_t reserved69;
-	uint32_t reserved70;
-	uint32_t reserved71;
-	uint32_t reserved72;
-	uint32_t reserved73;
-	uint32_t reserved74;
-	uint32_t reserved75;
-	uint32_t reserved76;
-	uint32_t reserved77;
-	uint32_t reserved78;
+	uint32_t queue_doorbell_id0;
+	uint32_t queue_doorbell_id1;
+	uint32_t queue_doorbell_id2;
+	uint32_t queue_doorbell_id3;
+	uint32_t queue_doorbell_id4;
+	uint32_t queue_doorbell_id5;
+	uint32_t queue_doorbell_id6;
+	uint32_t queue_doorbell_id7;
+	uint32_t queue_doorbell_id8;
+	uint32_t queue_doorbell_id9;
+	uint32_t queue_doorbell_id10;
+	uint32_t queue_doorbell_id11;
+	uint32_t queue_doorbell_id12;
+	uint32_t queue_doorbell_id13;
+	uint32_t queue_doorbell_id14;
+	uint32_t queue_doorbell_id15;
 	uint32_t reserved_t[256];
 };
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
