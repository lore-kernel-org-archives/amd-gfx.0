Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF21C38BF9
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71655218AC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zr2m2QNN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71655218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC6A66E99A;
	Mon, 24 Feb 2020 22:19:02 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AFC66E994
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 22:19:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VO3BD1ugZKU4l2cUejpZXzTc8JoKPzF+J62PRryWqIjJMGDbizDzSpWlj+8FqtsI6l57vIagxDQXNJbE8LuGZqPjEEJ5aHwcEnAHL3s+xJE/URPb9pzaza8IeI5VI2Cc7uA7bcbyQs1H92GuIsyZjYR2ZHgmRZlt3amcRlnGOZsEYtqRPbDNakYijfpf3NTQCKBWhHR1FFmi2Yf8JAxBorNixgQFs/BTQABbXp2MNe/F77ooes6RqiVl3+QkNiRXGNDHsrzCOrE7ohx8o7Xtc/gDtRiUycXAqdUxiZkmPziWcurhJieCptX7Fui1wqGAR0B4TebgzTNZLqeu3aaUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oGLj7nRCPbP9IQ9+U3fggg3iv49fdkbdhLf7T0PR24=;
 b=ahjBp8CC270TAn/M2qZzEWbw33mcOWW94Ni39FidMi2GRK3dkdKU/ws1nl+P68AwEgpiUnIp0/k1Qp8IHJUYJ2IYGqYb2W9KxbvfmIxsykM04Q+/+4GJwWFqyCdmf8KjsCj+pyExLRucUTjUz2hGGxc0FHLLtZgZ1EgVFFDHy6B0VtxEa5a7CboNGtT/9ctCAOikSJV04/OWWPoWtOZhMxc+rsqpCVQ1rPbWMBDj0uzba3U/oc0dFHADrU1lm/eWkgwbx1g4QMTx1ctAV8+z879txqz36JJQ/vII7lzl6ivpWA7fmhwRcuNaxdmdMaBIhn2gzJKuJkcM23drV2m+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7oGLj7nRCPbP9IQ9+U3fggg3iv49fdkbdhLf7T0PR24=;
 b=zr2m2QNNlQidGut4UPH/YKGP0r7UavMoYQ4N0WzDQmmrkF2kfPKyT7WACEitX27bjGAlLoDEQsfnIIo6ltxumRnrDVs/52cKCh8T8pfsCTM5y1CXyHfTmi2RFE2XG3ngtIlEN4KRuV8ngls6kUQUU14/1cdrdQR6aVZRpyRZBho=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3749.namprd12.prod.outlook.com (2603:10b6:610:2a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 22:18:59 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 22:18:59 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdkfd: Delete unnecessary unmap queue package
 submissions
Date: Mon, 24 Feb 2020 17:18:42 -0500
Message-Id: <20200224221842.14110-6-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224221842.14110-1-Yong.Zhao@amd.com>
References: <20200224221842.14110-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 22:18:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b44359a0-1378-47da-4d87-08d7b9778b71
X-MS-TrafficTypeDiagnostic: CH2PR12MB3749:|CH2PR12MB3749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3749A6ABDF3D1F26D6735247F0EC0@CH2PR12MB3749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(36756003)(52116002)(2906002)(5660300002)(86362001)(7696005)(66556008)(66476007)(66946007)(4326008)(6666004)(478600001)(8676002)(81156014)(1076003)(81166006)(26005)(6486002)(316002)(8936002)(186003)(6916009)(16526019)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3749;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDzAXxExs1EdvjVs1/jfAnU03FhnQGPZuiAyjvCoeCsDQKMgXkwdm+km7TLARWNm92kwDjrgPds3bTkUycTrPuMvzbNwp7nJi9yjSV4X/SrtOHQiOzrE/OP8aiEme7UzuFxohg9yQG5rrDV+A1FwM6SIJ0QkOmYsVPIJuz0iIvSqlHVdiXYovgSplvZq/OzehyMfme32x+3iJHbjNeX9wxoT08jhDQKwru+za65clmpRC+iLnxGJ1ob3Ntrz+oyXE9LcsAD77OBc0R8dKNfJQ0xXtfHjUVHyE0Tx+iy2UxaYPeTKLt0JeAr8HAZFwhC3raR/syHDTcjRTjn1pJHlN3emsaKOVnOYQa3DMRdH2kBNiZZtfnsW8jy8MIFMa9Iqibj4xr5mkU4uURJaKTJLWvsC6zem9YPODxOH/sJYkfvihYPylVUNVjc6CSVpsZ31
X-MS-Exchange-AntiSpam-MessageData: 79ChQgW0wpMBm5SmHRFmqQ/zr3rR1Sk6uUCRFOYZ9DiHeON9kpXQv0QWAI7wzTuuUJC0TQpqBIJ+/QYZMmKRXaWO45BPPAvuVvmOJBwD3Sv1qHsSEGstNQeue9pqSV2O6XqbnWIaI1oyljn7VAyiIA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44359a0-1378-47da-4d87-08d7b9778b71
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 22:18:58.9898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+eLNMBkDTuzfOZCUX0K8urn1OeUBADtjE9yAcDZpObCYRLCc/AGEwNEycR3Lsb6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3749
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

The previous SDMA queue counting was wrong. In addition, after confirming
with MEC firmware team, we understands that only one unmap queue package,
instead of one unmap queue package for CP and each SDMA engine, is needed,
which results in much simpler driver code.

Change-Id: I84fd2f7e63d6b7f664580b425a78d3e995ce9abc
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 79 ++++++-------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 -
 .../amd/amdkfd/kfd_process_queue_manager.c    | 16 ++--
 3 files changed, 29 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 958275db3f55..692abfd2088a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -109,6 +109,11 @@ static unsigned int get_num_xgmi_sdma_engines(struct device_queue_manager *dqm)
 	return dqm->dev->device_info->num_xgmi_sdma_engines;
 }
 
+static unsigned int get_num_all_sdma_engines(struct device_queue_manager *dqm)
+{
+	return get_num_sdma_engines(dqm) + get_num_xgmi_sdma_engines(dqm);
+}
+
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm)
 {
 	return dqm->dev->device_info->num_sdma_engines
@@ -375,11 +380,6 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
 	if (q->properties.is_active)
 		increment_queue_count(dqm, q->properties.type);
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
-
 	/*
 	 * Unconditionally increment this counter, regardless of the queue's
 	 * type or whether the queue is active.
@@ -460,15 +460,13 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
-	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE) {
+	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE)
 		deallocate_hqd(dqm, q);
-	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		dqm->sdma_queue_count--;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 		deallocate_sdma_queue(dqm, q);
-	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		dqm->xgmi_sdma_queue_count--;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		deallocate_sdma_queue(dqm, q);
-	} else {
+	else {
 		pr_debug("q->properties.type %d is invalid\n",
 				q->properties.type);
 		return -EINVAL;
@@ -915,8 +913,6 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->next_pipe_to_allocate = 0;
 	dqm->active_cp_queue_count = 0;
-	dqm->sdma_queue_count = 0;
-	dqm->xgmi_sdma_queue_count = 0;
 
 	for (pipe = 0; pipe < get_pipes_per_mec(dqm); pipe++) {
 		int pipe_offset = pipe * get_queues_per_pipe(dqm);
@@ -981,8 +977,11 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 	int bit;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		if (dqm->sdma_bitmap == 0)
+		if (dqm->sdma_bitmap == 0) {
+			pr_err("No more SDMA queue to allocate\n");
 			return -ENOMEM;
+		}
+
 		bit = __ffs64(dqm->sdma_bitmap);
 		dqm->sdma_bitmap &= ~(1ULL << bit);
 		q->sdma_id = bit;
@@ -991,8 +990,10 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		q->properties.sdma_queue_id = q->sdma_id /
 				get_num_sdma_engines(dqm);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		if (dqm->xgmi_sdma_bitmap == 0)
+		if (dqm->xgmi_sdma_bitmap == 0) {
+			pr_err("No more XGMI SDMA queue to allocate\n");
 			return -ENOMEM;
+		}
 		bit = __ffs64(dqm->xgmi_sdma_bitmap);
 		dqm->xgmi_sdma_bitmap &= ~(1ULL << bit);
 		q->sdma_id = bit;
@@ -1081,8 +1082,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 	INIT_LIST_HEAD(&dqm->queues);
 	dqm->active_queue_count = dqm->processes_count = 0;
 	dqm->active_cp_queue_count = 0;
-	dqm->sdma_queue_count = 0;
-	dqm->xgmi_sdma_queue_count = 0;
+
 	dqm->active_runlist = false;
 	dqm->sdma_bitmap = ~0ULL >> (64 - get_num_sdma_queues(dqm));
 	dqm->xgmi_sdma_bitmap = ~0ULL >> (64 - get_num_xgmi_sdma_queues(dqm));
@@ -1254,11 +1254,6 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	list_add(&q->list, &qpd->queues_list);
 	qpd->queue_count++;
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
-		dqm->sdma_queue_count++;
-	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
-		dqm->xgmi_sdma_queue_count++;
-
 	if (q->properties.is_active) {
 		increment_queue_count(dqm, q->properties.type);
 
@@ -1315,20 +1310,6 @@ int amdkfd_fence_wait_timeout(unsigned int *fence_addr,
 	return 0;
 }
 
-static int unmap_sdma_queues(struct device_queue_manager *dqm)
-{
-	int i, retval = 0;
-
-	for (i = 0; i < dqm->dev->device_info->num_sdma_engines +
-		dqm->dev->device_info->num_xgmi_sdma_engines; i++) {
-		retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_SDMA,
-			KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0, false, i);
-		if (retval)
-			return retval;
-	}
-	return retval;
-}
-
 /* dqm->lock mutex has to be locked before calling this function */
 static int map_queues_cpsch(struct device_queue_manager *dqm)
 {
@@ -1366,12 +1347,6 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (!dqm->active_runlist)
 		return retval;
 
-	pr_debug("Before destroying queues, sdma queue count is : %u, xgmi sdma queue count is : %u\n",
-		dqm->sdma_queue_count, dqm->xgmi_sdma_queue_count);
-
-	if (dqm->sdma_queue_count > 0 || dqm->xgmi_sdma_queue_count)
-		unmap_sdma_queues(dqm);
-
 	retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPUTE,
 			filter, filter_param, false, 0);
 	if (retval)
@@ -1444,13 +1419,10 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	deallocate_doorbell(qpd, q);
 
-	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		dqm->sdma_queue_count--;
+	if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 		deallocate_sdma_queue(dqm, q);
-	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		dqm->xgmi_sdma_queue_count--;
+	else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 		deallocate_sdma_queue(dqm, q);
-	}
 
 	list_del(&q->list);
 	qpd->queue_count--;
@@ -1673,13 +1645,10 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
 
 	/* Clear all user mode queues */
 	list_for_each_entry(q, &qpd->queues_list, list) {
-		if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-			dqm->sdma_queue_count--;
+		if (q->properties.type == KFD_QUEUE_TYPE_SDMA)
 			deallocate_sdma_queue(dqm, q);
-		} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-			dqm->xgmi_sdma_queue_count--;
+		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
 			deallocate_sdma_queue(dqm, q);
-		}
 
 		if (q->properties.is_active)
 			decrement_queue_count(dqm, q->properties.type);
@@ -1759,8 +1728,7 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	struct kfd_dev *dev = dqm->dev;
 	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
 	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
-		(dev->device_info->num_sdma_engines +
-		dev->device_info->num_xgmi_sdma_engines) *
+		get_num_all_sdma_engines(dqm) *
 		dev->device_info->num_sdma_queues_per_engine +
 		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
 
@@ -2012,8 +1980,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 		}
 	}
 
-	for (pipe = 0; pipe < get_num_sdma_engines(dqm) +
-			get_num_xgmi_sdma_engines(dqm); pipe++) {
+	for (pipe = 0; pipe < get_num_all_sdma_engines(dqm); pipe++) {
 		for (queue = 0;
 		     queue < dqm->dev->device_info->num_sdma_queues_per_engine;
 		     queue++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 05e0afc04cd9..50d919f814e9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -182,8 +182,6 @@ struct device_queue_manager {
 	unsigned int		processes_count;
 	unsigned int		active_queue_count;
 	unsigned int		active_cp_queue_count;
-	unsigned int		sdma_queue_count;
-	unsigned int		xgmi_sdma_queue_count;
 	unsigned int		total_queue_count;
 	unsigned int		next_pipe_to_allocate;
 	unsigned int		*allocated_queues;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 3bfa5c8d9654..eb1635ac8988 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -241,16 +241,12 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	switch (type) {
 	case KFD_QUEUE_TYPE_SDMA:
 	case KFD_QUEUE_TYPE_SDMA_XGMI:
-		if ((type == KFD_QUEUE_TYPE_SDMA && dev->dqm->sdma_queue_count
-			>= get_num_sdma_queues(dev->dqm)) ||
-			(type == KFD_QUEUE_TYPE_SDMA_XGMI &&
-			dev->dqm->xgmi_sdma_queue_count
-			>= get_num_xgmi_sdma_queues(dev->dqm))) {
-			pr_debug("Over-subscription is not allowed for SDMA.\n");
-			retval = -EPERM;
-			goto err_create_queue;
-		}
-
+		/* SDMA queues are always allocated statically no matter
+		 * which scheduler mode is used. We also do not need to
+		 * check whether a SDMA queue can be allocated here, because
+		 * allocate_sdma_queue() in create_queue() has the
+		 * corresponding check logic.
+		 */
 		retval = init_user_queue(pqm, dev, &q, properties, f, *qid);
 		if (retval != 0)
 			goto err_create_queue;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
