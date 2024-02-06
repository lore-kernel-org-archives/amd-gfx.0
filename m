Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1FEC48BC3
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577AF112CB2;
	Tue,  6 Feb 2024 15:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kraj8LgY";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 323B9112CA5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBx9xwx1r/b6JmAB0niCNBht9lSXEXt5/CwSPjwvqdeWAzvQudSYkyyJrCCF8xFJEjT0ZhPAp4Bxm7gdlD9v5YqTwMAy3iafjzPdYx39RTrRoviEaC/k+vl0mA0B/Qc1IOkK3c9O3ENJST5MQ+FMS8D5FJFu/utxWkiMItV4cdv8hQ884lAeO6kHVi9zeNf3J3bsfULxpFenHzBDythqd67oFNrvAYDKKmgcE5Nxnx47wXzPpk8t1LUenvO0dkmw+NF44SZ76vXiPWNUCv83rzufWq3boqDw9H1M8KNQcjO4qCbbBD3Ai5MNMriay7tYYUlwJy2HhD38MlUalw9sfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZS+lN12K9bgIMwJSSPcC0UpNYq+BlU0nAbFi6y9kjs=;
 b=lQKvpuUnzH8jUBfMaJaWa44YF4j08SsRg/408pbVTY4HCjLPS9JHxrxJJ8w0hEd2gd2XjfqLAFpIg7iGET/WBnCEYVrlz4CJmVKcJvQC8CkDh2lCWG7eZcklhUwE5F845bdD1il2r3ACYSSawFQB3uuVjeUmZRK5x5ZAsB2IyE3AuLi98EYjFpn1rYVHW54pUs7UZAPGtTtCGz4w3s1smN0kVZLtSdE8WU6lY7czKrRDU6kUR5cUNKLy91zwJcmmaWxHMsvtv7pvrmfwhThdmRIlU7CD7JPEt0e99nrJdLUa9N9pLjSUy+dE0XKhXsJCpyzfQ8V5OV3ojswRLP26JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZS+lN12K9bgIMwJSSPcC0UpNYq+BlU0nAbFi6y9kjs=;
 b=kraj8LgY8F8VOjlUOdNXQF68ftI0zAV3PVeV3lx9E+1a5eXbv/QmSIDua+lVu9EDRAdEIXhd1IEF7leoWK2bKku4ps9OsyG/jhnq6Gz9v4WtUpgTxeUJUxudJLali+CRLVAhDscN4FQyoByqa+xOf2YKfJc+UyzTeXDaBKfc8cw=
Received: from BY3PR04CA0027.namprd04.prod.outlook.com (2603:10b6:a03:217::32)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 15:59:45 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::c4) by BY3PR04CA0027.outlook.office365.com
 (2603:10b6:a03:217::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:45 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:41 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 22/24] drm/amdkfd: add pc sampling release when process
 release
Date: Tue, 6 Feb 2024 10:59:18 -0500
Message-ID: <20240206155920.3171418-23-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|SA0PR12MB4509:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0eb2ee-4404-478e-e1b2-08dc272ca379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CSt4uAoFqw78pGY7YQr0TIhtbCAtDxC8nUgxdzLmGoXUNkYQQoKqQb/tTf7/z99DQbS9ks+gdUi70CzVxY9uxQzIXKLKh64MrlzemRAGUcL4ZGpfToOVmk5q3mMIDF5frR7xTL7RupXWAhy93dAbmhev9x5QF0KWwcDLnGNYW21+g/lExOXgeBxnbRfC+M4TIi8P5FBVE6AO77nH7Ik1mujziiDdGpwDXAC9Z8NcaWD5Rlrc9ZWrbz7oChdMkrkJf8XuP++ZNHwr854g4/6/ITMQ79g4qFYSs5MgnvT3QTVsJEs/j0sMa8RW3tYgqlKAW500Mqz870g7xKcM0+2mAsdJ+IRrIZksj4HHrShXiFov3ONwKdYY89sRkrZeDQRoJ4KsxSWfszGVhQFgG65GGOLGof3XT90+Tz3PYqrwbLrXZ50BvoBp74HVmIuPHkO6+rzBt2s7OVpmLdBkSe5SFHOIEDYr1OBYjv0ZvipmxQJTU4AtNCinH1AmFCEiV7EHksOdNSxFSqfpF9Wep4q2EXCR8i+MkXoXADTQ3pRnepvRIj+giQyStxs6aRzTpW9rkJHO5F9wIQDIOLj5DqDZLvado7Fuh1UWM5jqJjOpUrABCv3eYl9nyJggown7mHEro7ZJ1o+CCYz7CV1KEBnABVMLxefswlDOcRBKNvHJH+LSntzbjLaYOTNcrq2XsanCRpxG+mb+iTTaBeTEnOuvSuoQS47yFUGU3U+0K/5qg0kBjKqWXr8LrXNJJVG5Rht9tfFNIOLxKJZADBknOIz/uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(356005)(26005)(16526019)(81166007)(41300700001)(2616005)(426003)(336012)(47076005)(83380400001)(1076003)(82740400003)(478600001)(8936002)(8676002)(36860700001)(316002)(6666004)(2906002)(6916009)(70586007)(4326008)(5660300002)(70206006)(86362001)(54906003)(7696005)(40480700001)(40460700003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:45.3235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0eb2ee-4404-478e-e1b2-08dc272ca379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
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

Add pc sampling release when process release, it will force to
stop all activate sessions with this process.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 25 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index ea9478c3738a..783844ddd82f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -337,6 +337,31 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 	return 0;
 }
 
+void kfd_pc_sample_release(struct kfd_process_device *pdd)
+{
+	struct pc_sampling_entry *pcs_entry;
+	struct idr *idp;
+	uint32_t id;
+
+	/* force to release all PC sampling task for this process */
+	idp = &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
+	do {
+		pcs_entry = NULL;
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+		idr_for_each_entry(idp, pcs_entry, id) {
+			if (pcs_entry->pdd != pdd)
+				continue;
+			break;
+		}
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		if (pcs_entry) {
+			if (pcs_entry->enabled)
+				kfd_pc_sample_stop(pdd, pcs_entry);
+			kfd_pc_sample_destroy(pdd, id, pcs_entry);
+		}
+	} while (pcs_entry);
+}
+
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index 4eeded4ea5b6..6175563ca9be 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -30,5 +30,6 @@
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
+void kfd_pc_sample_release(struct kfd_process_device *pdd);
 
 #endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4a450abf9fa9..bbad0b0848df 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_svm.h"
 #include "kfd_smi_events.h"
 #include "kfd_debug.h"
+#include "kfd_pc_sampling.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1021,6 +1022,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
 
+		kfd_pc_sample_release(pdd);
+
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-- 
2.25.1

