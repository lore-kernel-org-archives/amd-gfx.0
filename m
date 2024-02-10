Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB6FEC4829B
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Feb 2024 01:50:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6E610EEB9;
	Sat, 10 Feb 2024 01:50:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SBzYG1RA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D6F10EEB9
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Feb 2024 01:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSAxNaF2uKgV+gTFmlZc32CvqojoxTg8Ek9JuZpEdfrIJ7ldFjG7TIt3HcwGMIg17km96XxO+LVJgVTeXMkK0g3K+2eHkuNeFCZN2JBmvnkT81O09BdKHrXUS2DLVUGMYGOkcUPnazp+CxIYyYXqr/WCZ9YENsNhmgrKxsPlXlWSdIdW5eqUS6yBvNT8d0k2gq5KEBQYVOPaSMLfqwywX0bU3AIHpkN9HvBTNifzBDke1vtVXCHJ6LTdobYsKHc6qRiU3dIgTEeoSIrT3n+S3Fm4JhzUq2W3pM085+6zc6J+AtgbAVr5mUVQ3ryAnoMWWQ4CXEfyyf0TZm41xT2RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUuyHD8qt8Qg3GcBak5dkLNPOsj4ZXZJTJLp9/bvMBk=;
 b=V3UCqrQy8fjud48emao+Lbnmv2d3RiZyZp9tjL1Z54iT7g6K7xEAcKXhnFWlc75CPgleEOHkTpHKS9iqE7iilDZjAXUGIwAMXGpPfFNl4gnAnjHHadOZ6NnRHR/xREcdHwjVkUYuyZcSplKc7kinzmVXBhUHgwOMuSWQIHCnY5zrL64DH5KG/B/JZ41rqR44dDV+QIJJYneWfnFI0JsvR42Yz1jW2ckL1e1duNjlhsySdKWEMYC1TQm54/5AXln6kQIjnVaKky7NMbpTUIsoo2o8QHXy8xZPG5GPVqiGzd59BAtbMrYq22zjcbiJAXTHuHh8xrUT49uLG8bjRYwJSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUuyHD8qt8Qg3GcBak5dkLNPOsj4ZXZJTJLp9/bvMBk=;
 b=SBzYG1RAhu9caz6zEsKQ/InHYgoQ8IDTn9A8bmXv81OhYehclRn/CkFdMaTuM0KI5tOkhxDrQ+IlXi4yL4FbwlKdkErBwWn8EGcKhG4k9LwPdipzUVUDrkbpHn0v1ZMbFFg5usLA5EiDq9MOzX/gxquLr2llwR+rFdud7JPcXKI=
Received: from CH5PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:1f1::9)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Sat, 10 Feb
 2024 01:50:08 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::5b) by CH5PR03CA0012.outlook.office365.com
 (2603:10b6:610:1f1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Sat, 10 Feb 2024 01:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 01:50:08 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 19:50:04 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Joseph.Greathouse@amd.com>, Rajneesh Bhardwaj
 <rajneesh.bhardwaj@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2
 onwards
Date: Fri, 9 Feb 2024 20:49:50 -0500
Message-ID: <20240210014951.73159-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce4ecc5-7b59-41ff-79f8-08dc29da9c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O8EIwlYfH1R494Huv0wt61YBLuM0pulYQtb5ZkVNcyCu1V3p+4EuRU7zYKzvb4oL+7cJgTriD/aL+0rQX/8Ug7rmFgEHlxDLJGcZsnOMbW0t6V3Luo+MAUc9oh9s34M/100C8quT9kzK3KCmEwjuWooFxWcBF/j+ZtuXdJK1cL8IQJW/HNJFuiPM7cwG7xDcKN5O9bbP8uP5WIYR69HyfHmi6A2+QiISIqPStPaMZsybgChcPdLli6ZnnD9rC7idL7QLHNs8ulohCCIeha8FBOSUr/JwVgJvVr7uVfFgaBidVJUP8RCEY89pRDpFEI0wzWsn+MiZk1a0V0kRRrRnxHGibhcXwp479jjOn5wVPR9Xe4FmHUmJ6cFqOHdaBtj+7vgZJNrz7t4ueXVD8EfZrUMB35rKxMsumZqOGlj2Tg9kSMphvQHwMtwiPxj88XczZl76tBz5vnUATw4PAWtkQvZD7BBll6wpHtywl+c9tY1Y9HThQblJ+UN0Um2pvehvs2fWFkDo7PL8stFL02h4wpNdKsBk5zTFib1+z/W377kDUV0EdW5nBrI8JdaWodmvb6QKq8jbSHPmDKa9yhwOhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(86362001)(81166007)(356005)(82740400003)(41300700001)(2906002)(336012)(26005)(2616005)(15650500001)(16526019)(1076003)(316002)(6916009)(426003)(83380400001)(7696005)(966005)(478600001)(6666004)(5660300002)(36756003)(8676002)(8936002)(4326008)(70206006)(70586007)(54906003)(44832011);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 01:50:08.4221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce4ecc5-7b59-41ff-79f8-08dc29da9c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541
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
index 677281c0793e..65b504813576 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -532,6 +532,7 @@ struct queue_properties {
 enum mqd_update_flag {
 	UPDATE_FLAG_DBG_WA_ENABLE = 1,
 	UPDATE_FLAG_DBG_WA_DISABLE = 2,
+	UPDATE_FLAG_IS_GWS = 3, /* quirk for gfx9 IP */
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

