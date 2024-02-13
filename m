Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB06AC48260
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 21:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE8810E8D9;
	Tue, 13 Feb 2024 21:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O6v/m85B";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3631B10E8D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Feb 2024 21:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJ08yDTOVtWLcbiQO7Fs0zncLjbxBNijpuHSz3546NoConLGXsCZARAXcJPSCm9sKGDfhuvB7ls1QDhLMrcQ42sqn1opEG1WIPU3fOiZlZ380OND5YEZNfyVoszEL7PUTbgUQv/bKx99HrSV7gvjkRV0zkfzudXHCaudqv8WKHKN6bk1qnJcI3YXWR5Dod2YJ/ckzc9jwHJOu54KAmsVo3YpJ7f7XEWuuAlmOmOHncxOi3nKfOwpwh+KltepqzotzANK0KYUxJKCq6+fwycw3zVDPinlYRcM+HCQ/jYvUqrb7TGDP+5bTZ8RXFl/oOpMg6Mc39riBo+pGnRjqT8TZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akewYoKvwrHhu1DsOU66tH4AeHjXF9fMi+4gjqmCf+0=;
 b=bPCjMblGzz1Pko89P3v9Ijh/O9CO9qFR5KVliExIK3rdghTIJ2ALhPtM/FCHywubjbel7OLlaDfaQwjUVYi9/7mp6qs/GBLIm/URHQyBJibQ/7TXQdtCqktO9n9U47Doo9ulYrpztImAXRdiI9VgcdpGyRT50tPqiSYxk0g7rdSgDUOcwrV7xBsPOBEfTiARTwckzmnXFxM83Z/VQG6baEIQmJKeZaSYks7wmBPBuvfI8lyxSc3VgnpEIYf1p7W4XnI7I9alnxGwdBk9Z/R3P6HSDRnAGxkLSIDuBXF0KdlhS8LXWdIcL6tVOSIh8rsbxCfKHdstjrC0zSv1iO7tRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akewYoKvwrHhu1DsOU66tH4AeHjXF9fMi+4gjqmCf+0=;
 b=O6v/m85BRg6KEFzRVt/ziB01sNXzR6WuOVipo+zilR82EQHRs6Dvu8aHjeDH/SQb6mTHsSINOirSZO8NAW3E1EgjiGXPKRJcISPfVBrA0FkaTe1+isaRPNcdRx3gtVVRq8L1WjK/O2To+QjiZMS8WyjIChRfkRRrOElJWkC3ZHM=
Received: from PR1P264CA0101.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::9)
 by SA0PR12MB4544.namprd12.prod.outlook.com (2603:10b6:806:70::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 21:39:53 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10a6:102:2cf:cafe::c1) by PR1P264CA0101.outlook.office365.com
 (2603:10a6:102:2cf::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Tue, 13 Feb 2024 21:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Tue, 13 Feb 2024 21:39:51 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 13 Feb
 2024 15:39:50 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Joseph.Greathouse@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [Patch v2 1/2] drm/amdkfd: update SIMD distribution algo for GFXIP
 9.4.2 onwards
Date: Tue, 13 Feb 2024 16:39:33 -0500
Message-ID: <20240213213934.1086279-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA0PR12MB4544:EE_
X-MS-Office365-Filtering-Correlation-Id: 25c6cda0-debb-4e53-41c4-08dc2cdc4f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5rzIJGomFzT9Hcu08AxsI6eGhtih1+4PhAH3pIluzlWiAVa3+ugPRUkkFrx42ztwgHaKg5rJVJhpLtYKwDCfAvdxtD6h+YaysXhPYm3LIvtnGl8EMdyNfp8NHkcgWZSgethtFjFOrXEi7GRcbnW7YM/ZAuNbrRfH+/g5VIdfgA1/447Er3lxAfTe+zfYEzeAsu2rAoZvEhebwzlK86MeTYIOS5Wig/JlwQGNt5pi7I3luWhIaWiyhErRfCj+iHOwCX3j/ASfG6QPJQ5Px93e95RykCcmn9pk0QpaZdgPXyxfg2fT0V65uJhldwbwQxHCz/DdNIc9BIEzUQaJB4uPTxuMx4Uc/LIe+GyfRO1NjCFD4jcsVY960zlzYbq3qVtvg4bHQjG8H1NXqijHzjIIui/cA60ISeUKUM/vwZyirNBLqgshk8FVA5U6R3wPKvn5PGbKJlfsyL4U2p1FPi3dFWaqaQY8RkfVTea+717gw5fmMGHbRzVRkJ3DCaxrSM+//yGJPY6jjJ0nh8oRua2dIu9qnn0BDLVQ+yF8zzGJd+X/86Vv3O0TPLMHc93ZGfgvh0q06p2BKGrXCSq1mjEaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39850400004)(346002)(396003)(136003)(376002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(46966006)(36840700001)(40470700004)(70586007)(316002)(54906003)(70206006)(6916009)(6666004)(15650500001)(2906002)(41300700001)(5660300002)(8676002)(4326008)(8936002)(44832011)(478600001)(1076003)(7696005)(81166007)(966005)(36756003)(83380400001)(2616005)(82740400003)(16526019)(86362001)(26005)(426003)(336012)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:39:51.7128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c6cda0-debb-4e53-41c4-08dc2cdc4f81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4544
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In certain cooperative group dispatch scenarios the default SPI resource
allocation may cause reduced per-CU workgroup occupancy. Set
COMPUTE_RESOURCE_LIMITS.FORCE_SIMD_DIST=1 to mitigate soft hang
scenarions.

Suggested-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
* Change the enum bitfield to 4 to avoid ORing condition of previous
  member flags.
* Incorporate review feedback from Felix from
  https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg102840.html
  and split one of the suggested gfx11 changes as a seperate patch.


 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c        | 9 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                  | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 4 +++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index 42d881809dc7..697b6d530d12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -303,6 +303,15 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 		update_cu_mask(mm, mqd, minfo, 0);
 	set_priority(m, q);
 
+	if (minfo && KFD_GC_VERSION(mm->dev) >= IP_VERSION(9, 4, 2)) {
+		if (minfo->update_flag & UPDATE_FLAG_IS_GWS)
+			m->compute_resource_limits |=
+				COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
+		else
+			m->compute_resource_limits &=
+				~COMPUTE_RESOURCE_LIMITS__FORCE_SIMD_DIST_MASK;
+	}
+
 	q->is_active = QUEUE_IS_ACTIVE(*q);
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 677281c0793e..80320b8603fc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -532,6 +532,7 @@ struct queue_properties {
 enum mqd_update_flag {
 	UPDATE_FLAG_DBG_WA_ENABLE = 1,
 	UPDATE_FLAG_DBG_WA_DISABLE = 2,
+	UPDATE_FLAG_IS_GWS = 4, /* quirk for gfx9 IP */
 };
 
 struct mqd_update_info {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 43eff221eae5..4858112f9a53 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -95,6 +95,7 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 			void *gws)
 {
+	struct mqd_update_info minfo = {0};
 	struct kfd_node *dev = NULL;
 	struct process_queue_node *pqn;
 	struct kfd_process_device *pdd;
@@ -146,9 +147,10 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 	}
 
 	pdd->qpd.num_gws = gws ? dev->adev->gds.gws_size : 0;
+	minfo.update_flag = gws ? UPDATE_FLAG_IS_GWS : 0;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
-							pqn->q, NULL);
+							pqn->q, &minfo);
 }
 
 void kfd_process_dequeue_from_all_devices(struct kfd_process *p)
-- 
2.34.1

