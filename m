Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF8EC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B25DF10FB66;
	Fri, 17 Jun 2022 19:56:24 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5198110F702
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:56:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itjAZ0RhDCtCncNS87P/9G32RHyut5OuDIBgcHauP4IgkRBsGisy5mqUKgrOw44hnvzB9p6xarG497GR0MMViYx3/OATXl5hy7PsbqPgH8RTa93qwwIH7Q5raeNJVEqa/cr6EOqyZ4RGIwOQW1+CHQfDPdjRLFUGDw6zK70u9EZ/TuLOofgM/21nGbHM3/8qWK2rTKts5/jhfe0ADJTPT7uiDgDffeYk+eamFUPm+5sCjx86oodpccOynJLmYw/2sTeiqW/wOJmxh2jMz/XgZgij1UKJEe8QVTjX32LjOgcBCPmPLprmfabtHUcEOhj1Q7gGgbyYrKUVktQxczNG/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeyMuJ2ehFw//Nh1/vW227UaCaN/xy0gia81Eg5Iw34=;
 b=hOtXSKRgDt5dKrZwC2oKuzg7/IYn58vK9xgwnXgTGOjy+IKYQoW9KUudb8XIxBJM0KSuUTsO9l4YMyY49dfD7Svr1a4zchM7XNKno1fNeUJQaOmokhVbP1oOHs5SLViYmLhzPGsJMVW8+7TWkwhfh5MXTo+NOLa2lYhkkgttX2EvmtzdaIolMcdFOcfCMNXZHkde9mYPTCxIpapVo7ei3bgKClXJLHHtS0fgFUHBAiNrTSE6HNYtS9y6NF7/mi16Eg9OUk65cGvm7n7nRzLafTSEjNdIrQxsPRf4F30qbcZhHNO/DUxt/vi6UTAhFqvTmQCcrN6j4cBUDDhkZo+erg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeyMuJ2ehFw//Nh1/vW227UaCaN/xy0gia81Eg5Iw34=;
 b=fMTkcfVPolkY8XMEfopPM5220ecuQkVU7VxJafjjl6/UHy/9vQ7/Wv+bZZzxrXnAKnm1dv0dArKoP65TuKnAwxv8ifEUgCEn9CDLLOIrjb4cwkbBKsbgip0BAAYbqjOm556toY4xi5saeWc1k+uYkLbRy8yn1TBZIDE+2c1vHEw=
Received: from MWHPR18CA0049.namprd18.prod.outlook.com (2603:10b6:300:39::11)
 by BY5PR12MB4966.namprd12.prod.outlook.com (2603:10b6:a03:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Fri, 17 Jun
 2022 19:56:21 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::a5) by MWHPR18CA0049.outlook.office365.com
 (2603:10b6:300:39::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.17 via Frontend
 Transport; Fri, 17 Jun 2022 19:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 19:56:21 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 17 Jun
 2022 14:56:20 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amdkfd: Free queue after unmap queue success
Date: Fri, 17 Jun 2022 15:55:28 -0400
Message-ID: <20220617195528.20894-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220617195528.20894-1-Philip.Yang@amd.com>
References: <20220617195528.20894-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7de0c09a-66fc-46ef-7545-08da509b73b6
X-MS-TrafficTypeDiagnostic: BY5PR12MB4966:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB49661377C8FCD9CCE74AF64BE6AF9@BY5PR12MB4966.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZyrKst5ObDOnXoo0UehshQhShWKbwfeN3H67eBNEAXdaUTSIn32NLP7Jt0FIWfznzdObAGLVZm84Ums7nXx7SaBJwcFS4uzYYlp/KQyumvkGqiLvYuat1TfUpZsJAgiZazvdV5AtUmhSyVqkyCXCL54TWL71ZMikTtvxHMSrcKOZ4oTAQ4lCvutYntRw29czjs5I+PoOnwOAW4qKJdpKW+Q5t3ISGplTTbvCrXTL5B32/8akmWLkK/Sswf+DiN/Tj5PRqDVMA6gj86kPHxWDVHWtVRocBnE0FoFRThvW+7U9C8m+PxbyvTrcdDqfPttc4tmMjdtBAYDRXkHHn/5FuFHl/9X2kI+WWmXG4WyejcrgHcfCGyEI6qeofozmHFOKWy9SlpZt/6YoekWmWgKjxYQqBVmsRUjVgxlkUAm1vzC3d0o4ZuAvGX+PnUKrRJKpTNusrRllcSoQsGpd3dcNCEwvtkCxpFK+uoEd8a/+szigVGDW4kNVAHotmNuLehULGBJMPggTgWYw5ViwHyv0Wb7Tbdx9AhpT6q20f81RWV2meXHNfuXcrY67YlYDV38Pn9Cg5Y6ORVAEgeH3Jvpw9kZ9e3eYUQ7ZYGqbZrnvn3Zr6v6u1rpBePZS90Xa0OI3CNgDGR2Jmq2gVhUb0H3xtmEMGM9LMVGbAKEy1odjGox6Kx3VydXffD4nyA/gb0SMacEIw9QtbPDW8DW6wsMDDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(16526019)(40460700003)(5660300002)(498600001)(8936002)(70586007)(336012)(2906002)(81166007)(356005)(2616005)(1076003)(186003)(6916009)(26005)(316002)(54906003)(8676002)(70206006)(4326008)(82310400005)(83380400001)(36860700001)(47076005)(426003)(86362001)(36756003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 19:56:21.5962 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7de0c09a-66fc-46ef-7545-08da509b73b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4966
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
Cc: Philip Yang <Philip.Yang@amd.com>, Graham.Sider@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After queue unmap or remove from MES successfully, free queue sysfs
entries, doorbell and remove from queue list. Otherwise, application may
destroy queue again, cause below kernel warning or crash backtrace.

For outstanding queues, either application forget to destroy or failed
to destroy, kfd_process_notifier_release will remove queue sysfs
entries, kfd_process_wq_release will free queue doorbell.

v2: decrement_queue_count for MES queue

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 7 PID: 3053 at lib/refcount.c:28
  Call Trace:
   kobject_put+0xd6/0x1a0
   kfd_procfs_del_queue+0x27/0x30 [amdgpu]
   pqm_destroy_queue+0xeb/0x240 [amdgpu]
   kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
   kfd_ioctl+0x27d/0x500 [amdgpu]
   do_syscall_64+0x35/0x80

 WARNING: CPU: 2 PID: 3053 at drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:400
  Call Trace:
   deallocate_doorbell.isra.0+0x39/0x40 [amdgpu]
   destroy_queue_cpsch+0xb3/0x270 [amdgpu]
   pqm_destroy_queue+0x108/0x240 [amdgpu]
   kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
   kfd_ioctl+0x27d/0x500 [amdgpu]

 general protection fault, probably for non-canonical address
0xdead000000000108:
 Call Trace:
  pqm_destroy_queue+0xf0/0x200 [amdgpu]
  kfd_ioctl_destroy_queue+0x2f/0x60 [amdgpu]
  kfd_ioctl+0x19b/0x600 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 +++++++++++--------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 21aeb05b17db..213246a5b4e4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1872,6 +1872,22 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	}
 
+	if (q->properties.is_active) {
+		if (!dqm->dev->shared_resources.enable_mes) {
+			retval = execute_queues_cpsch(dqm,
+						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+			if (retval == -ETIME)
+				qpd->reset_wavefronts = true;
+		} else {
+			retval = remove_queue_mes(dqm, q, qpd);
+		}
+
+		if (retval)
+			goto failed_unmap_queue;
+
+		decrement_queue_count(dqm, qpd, q);
+	}
+
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
@@ -1885,17 +1901,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	list_del(&q->list);
 	qpd->queue_count--;
-	if (q->properties.is_active) {
-		if (!dqm->dev->shared_resources.enable_mes) {
-			decrement_queue_count(dqm, qpd, q);
-			retval = execute_queues_cpsch(dqm,
-						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
-			if (retval == -ETIME)
-				qpd->reset_wavefronts = true;
-		} else {
-			retval = remove_queue_mes(dqm, q, qpd);
-		}
-	}
 
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
@@ -1912,6 +1917,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	return retval;
 
+failed_unmap_queue:
 failed_try_destroy_debugged_queue:
 
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index dc00484ff484..99f2a6412201 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -419,7 +419,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
-		kfd_procfs_del_queue(pqn->q);
 		dqm = pqn->q->device->dqm;
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
 		if (retval) {
@@ -439,6 +438,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		if (dev->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(dev->adev,
 						   pqn->q->gang_ctx_bo);
+		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 	}
 
-- 
2.35.1

