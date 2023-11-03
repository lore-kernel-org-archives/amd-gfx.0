Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CFBC0032E
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9498010E9DE;
	Fri,  3 Nov 2023 13:12:20 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B419010E9CE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVuXedLlvCRzvtD1lu3a98U4BQ+riuhCaMLT7SSfaJL5apPkQbhGStIvNw2z9CxGyfMVYB79vZN9PFAaa1wH2TQT1TuphNoMKaI2pq8KPEYBovfUgSaUOHnAol3CW2wrqXM/JNQJt9h7lQMpxXg0wJi6sb9B69rZVqPtJiHHQ0C26J3Zw6UBeyJPwKPgvILYaMK/m6kGD1sLd7hnG6Q0KI5mE7t3DVw0M/EiNOB35Zkl2BNgx68NGm0QF4aRsfwKcbS3da4zAzbsArmHZe7UKQH6eTSt1HMTiO2WqSOdbma2Z6uu5CowQdIpZGT9mOVOoqizLz+D4Jb6CHFUwiF4gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2jfLLonHghvXawTgBqYo1jPO6eSRxlgBq6W1kqnmHA=;
 b=I1QHTOLvnEEXLhH9+rpzlWuEKkzbigP411EHt6J2zh+kbv34C3AJw2jPysXZk96PE14lOz/OPLJndTjGDw4/wettvXl6XhOmX/mB1BOd3Fzf/x7LHhfJquluMg0Q89Nh+bMXz9OTsPXQSW9mDoRKj3wnjZri3fl00By0pJFrnr3ZmdC8DtVxM/87Wp8D5tXIJUY7UDHOu5c89lV1shHkgZ9tGcfaRsyLD1BdFL0ciAa2TusTcuG9C95VH20KP5NikLL2eselS2wepnFoPuF9BzeuEeYbZrDh7VUuodYvM7+b7+IWheZ2VcWA4c79sJdILxXK2EDhbrg5WPkq1FA1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2jfLLonHghvXawTgBqYo1jPO6eSRxlgBq6W1kqnmHA=;
 b=mWYxue/NMGhz5rLJIpKrI6tBgtoOFNSIQnuHBS28hJrH/c03JHTpoNwN1V9juNu+oKSo/SPXr++3FgG2bG3avJdmnp2IAWXFqChRL6U1hHOIqJVTa0hblsN2Pvcq6ljnLMfIfIQ5DYvlFaigQ6eZ6wlXUOGmysP+CDoj0cmW/gw=
Received: from DS7PR03CA0113.namprd03.prod.outlook.com (2603:10b6:5:3b7::28)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Fri, 3 Nov
 2023 13:12:10 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::ba) by DS7PR03CA0113.outlook.office365.com
 (2603:10b6:5:3b7::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21 via Frontend
 Transport; Fri, 3 Nov 2023 13:12:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:12:10 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:12:09 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/24] drm/amdkfd: add pc sampling release when process release
Date: Fri, 3 Nov 2023 09:11:37 -0400
Message-ID: <20231103131139.766920-23-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 8443cb3f-4ceb-474b-9e93-08dbdc6e7d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JlXl59YveEoqkz02+uH3/r9ec6fZqtz9JOuRaEr43gmKYNZpKfMWT91tkyisnuHvb3z9EQj8rhjXYYBgJ4NmTJ8sY3FTs8jM4Le11fTfrwarEHa0gTFUKKKzez/hRdHCtOFMxDTayWcAR+w1ra2nc1x+DZYYR1pDPjLWOo51p8SwcNQG+TvIkgx0FhH/oj4CMYwKeivzkx1LkKMdNbaWRahWhmMSYAghrNiF0hxRP1RLv9HOYxzTAnnO/YVhSp/CnXsCW1h60mld5Iqn/qXSsaMAjiKPWaBK2F/ZxHj5pD6u110ePjDgsPkBtxRzDw7kYZTUW2sNiUV0WeOcUIMAvIx79dv5AWsP3JoArrI4J1GYkberJg6GI4kIoVPoaLTMp5w8Ysa1Qq5J4f156Z0B7tJy6+Yl5Hk+0vQD+OoPG0BDBY4jtj19chHIssyn9j0WpWpew4OqVuoIIGzdEu/zTOaewiqMekqOBQp/YRc70l6jeL84Yl5mPDTHMchrnfC95DQa+KPetMPNJR+KnC6ww84Yk8rTWSXa9a/E0j8U00KLA/N42V7Vu+aN0hR+uFItCHrOFVudnVKyk6LDtF7u55eM9smfaTOwJ8tGxHlutH+uABK14UpgpG3YBsDSBGMZiSdDGsPNKYFIj6LKfZwkvLuJ/vyTYSdNYeMDiIqwpFhRzYfUZjSqndsWEBiT1oHQ03fmv32XTBD2JY1+sCfqMGXw4qDPtEYBOGWRa6WcZkTANVakfl9q/C1jWVO2/oGousi92ZQW8g0Av6ml7c9/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(2616005)(1076003)(82740400003)(16526019)(426003)(336012)(54906003)(70586007)(6916009)(70206006)(316002)(4326008)(8676002)(8936002)(6666004)(7696005)(478600001)(36860700001)(83380400001)(81166007)(47076005)(356005)(41300700001)(26005)(2906002)(5660300002)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:12:10.5453 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8443cb3f-4ceb-474b-9e93-08dbdc6e7d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add pc sampling release when process release, it will force to
stop all activate sessions with this process.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 26 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c     |  3 +++
 3 files changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index 66670cdb813a..00d8d3f400a9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -274,6 +274,32 @@ static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_
 	return 0;
 }
 
+void kfd_pc_sample_release(struct kfd_process_device *pdd)
+{
+	struct pc_sampling_entry *pcs_entry;
+	struct idr *idp;
+	uint32_t id;
+
+	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+		pr_err("PC Sampling does not support sched_policy %i", sched_policy);
+		return;
+	}
+
+	/* force to release all PC sampling task for this process */
+	idp = &pdd->dev->pcs_data.hosttrap_entry.base.pc_sampling_idr;
+	mutex_lock(&pdd->dev->pcs_data.mutex);
+	idr_for_each_entry(idp, pcs_entry, id) {
+		if (pcs_entry->pdd != pdd)
+			continue;
+		mutex_unlock(&pdd->dev->pcs_data.mutex);
+		if (pcs_entry->enabled)
+			kfd_pc_sample_stop(pdd, pcs_entry);
+		kfd_pc_sample_destroy(pdd, id, pcs_entry);
+		mutex_lock(&pdd->dev->pcs_data.mutex);
+	}
+	mutex_unlock(&pdd->dev->pcs_data.mutex);
+}
+
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index cb93909e6bd3..4ea064fdaa98 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -30,6 +30,7 @@
 
 int kfd_pc_sample(struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
+void kfd_pc_sample_release(struct kfd_process_device *pdd);
 void kfd_pc_sample_handler(struct work_struct *work);
 
 #endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index d22d804f180d..54f3db7eaae2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -43,6 +43,7 @@ struct mm_struct;
 #include "kfd_svm.h"
 #include "kfd_smi_events.h"
 #include "kfd_debug.h"
+#include "kfd_pc_sampling.h"
 
 /*
  * List of struct kfd_process (field kfd_process).
@@ -1020,6 +1021,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
 				pdd->dev->id, p->pasid);
 
+		kfd_pc_sample_release(pdd);
+
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
 
-- 
2.25.1

