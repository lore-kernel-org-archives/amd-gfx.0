Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD16C3ABAA
	for <amd-gfx@archiver.kernel.org>; Fri,  2 May 2025 19:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 619B910E8C3;
	Fri,  2 May 2025 19:49:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kbYBJTD8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D9210E1C7
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 May 2025 19:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkStAEYU5xm7r43YJ+NqRYH0KUtrrNnw6KS20QHJWv9fJ2R54MpCX5LXgult3gUHsruIGThERjecaZFcLyEIbpu7vg2SVHK7iBfmy3+lVsG99PDVX3iSCYRxtDUdQ/Zc4Y8Af+9F6amvWCfXNsR4kfY/dMV4fFascMwD5u4RxkP3Y6ZhwgT1iICt1hXkHLg3Idn6u6ZChGXYtfGdsWBrw8ifnaWnlYE1vYnkMuU1gUzFplxuRRFvAqitby5njbA83EnubkdeeYVqOAV/UY6DtXktnstVOWb+UBV5ineHFiJzOFudyuwIJk7S+DAeulEqz4sQKpfD5jbyGXj76nUcjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTp3IwoGtpf8N7no4AkFnoAiejm3WDuL73gWSeVfg+I=;
 b=LMSJAkOjQ48YW+uzCtxSZLtwGiB3Fz4gA2FU+KVqPFLXpUHK17W78g2n5jHcDROR/e+Jf2Ug6LzZrQkPvY85dKLQuSXnxjhH32JYwzmDXIYkZiV337jbTzkuz5hiaGWB7IOAmI9ZAPFop5fgShlj/amDq1n9Tp1GZ1lmlPcDDY/LdeU/MBD1RgYEAc4LmBk4bTcbVg+d0TlnVQeyeacHoCGgQwp02HVA4mciJYDgBS8QYaYG7razh+TO/iX2RPfI6jE3vLAj2yj9RTPGapOqNvkXF44d4Z62ffTepUk+0ZMp5E8hcskYTp0RUnK/HBmi1V/NUqtWZawkT+R0UO4TyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTp3IwoGtpf8N7no4AkFnoAiejm3WDuL73gWSeVfg+I=;
 b=kbYBJTD80Z03TZeAs6JflGs/gJzhhfRPwweLKFzlU9K9DYm9cVQUH0qSlTJu07Up5XGKME4HaWQMFsIo+MGzLHaNS88rkPoRYBOmluptCfik3m7NE3apJEZqZZEf5HiMe2S4E5qeml8xtovytLMa5aNnbmzvZMLRmL+Fk4yq26U=
Received: from MW4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:303:16d::35)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.37; Fri, 2 May
 2025 19:49:34 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:303:16d:cafe::9e) by MW4PR02CA0012.outlook.office365.com
 (2603:10b6:303:16d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 19:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 19:49:32 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 May 2025 14:49:31 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: change error to warning message for SDMA queues
 creation
Date: Fri, 2 May 2025 15:49:18 -0400
Message-ID: <20250502194918.214212-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b9e19d-2d60-41e2-dbcc-08dd89b2759e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jtVbNVt6aKEIKSGyBr6LM3qMcKv4+UQIKpP5ywzTwFxW8UZLIAxDQCL1XOc5?=
 =?us-ascii?Q?xwbJl66Brb6E/nJKLXWoNnvi6bgDPCrtnUuOCrEuX3vnOm8RsjkkNxizWaqf?=
 =?us-ascii?Q?i16C+UPGsam2hqB2lvrq6XKRCXRevEFi1Kek6YitcwLDfieHIBafh0vcswgO?=
 =?us-ascii?Q?AMfmDD2rXJak0oD76Lm6g3Ume+Xxbx1rY+DnDdNZtuU0jgbPUU0sgWAQTX6t?=
 =?us-ascii?Q?ERRt8jlD3CAtsZggQjqQ41phrnlOwVTbqbo5LVgI5pxVIZ5eBIPpbGAuTL/i?=
 =?us-ascii?Q?ZNurwvfNbE5VU0/bTNigzVU2owDNA1srW6NeVbygWSDpemcblsfrYMqGJrpN?=
 =?us-ascii?Q?9pBDEUDjKDU3PjsTMtWcF50/vtThsK/nMlPMYsSI47fwLJ7SGbKjfNrL4boO?=
 =?us-ascii?Q?vla0otQ3ojbryOQ1JjoRjMu+C3qExcSM3rWz9qHkZDT+TNwCCKgwKGyjsdxO?=
 =?us-ascii?Q?VCiBASDlFtzcQFerugMA4FMi28+72liULhNqXIoNXCR+Au091JEE4eyBdTLe?=
 =?us-ascii?Q?yLidfcq/2kMrb2++RiPyEI+RBfZAgfor0YmTQpo8dsB7na09n4K8gahIgbg9?=
 =?us-ascii?Q?FR4TCiYxHqOBWWf5uiOGqnuCfTnGXxh1xvhubO18/Df2LhB6DVXlzDt/2+69?=
 =?us-ascii?Q?Ush99YRcGg/YMhryZrRXbLKtrlImn1kV70md0aiMVeQv1TkJziM9Dwa6Do2u?=
 =?us-ascii?Q?VaRGarjrcDOJb9/tDjQHdDpcYU+y5U96QBNMkkIipR2QMYtMZyB02qgLEcuI?=
 =?us-ascii?Q?XLpk+z1HEoV2NiFpjDkd/N8Hnt9W2kdr4Y+zUmrR5VnLZQzInp6QtBGgrXIq?=
 =?us-ascii?Q?44mgepKhrYW2ZcYTD/PWSEpz4WjzvlXL8R40yVKw3pX5RYxK0ocK26wDk0pJ?=
 =?us-ascii?Q?NvUKTZDaZUKCYzO51H6tS3qP+U+FGxONRHtae4uFcLkcGsyoudll4Wlc3ymL?=
 =?us-ascii?Q?pr7E/3Ujo2t2IZpn4/jyGwXrT0NTcAiAAJNwUO5TahdJmPoBBrIdDF9FY6uh?=
 =?us-ascii?Q?jlpZooYzTYis1QiPcprrRwHSPtJk/y9rsd7B85nqblPqlx6f8bJCyj56OLmX?=
 =?us-ascii?Q?63CC3IIeYyvfB/Q36oRQMdEiVODWmka1ZwWWgyE3n/KEIFF8Qn35AbZYpeg5?=
 =?us-ascii?Q?OGyFXm3ELuDnLj2QqpKTxFkcgeKS0kWEL1AGnT6tho8ZUrj8j2poiutJ2V47?=
 =?us-ascii?Q?GxPvgE9CX6FoZ9KGtfph3D+l2w0iDJ5kjyxvp4FGJ04xRKV8Ep+Q3p384i8D?=
 =?us-ascii?Q?QCNcWIoVqlRUS8J778jXyoA0Vp0vAGMVvhkAitz24pEqc8GJ0o/5P1UFoxgN?=
 =?us-ascii?Q?Nxj0/a8caTaOndrrVQkpEQIHGWsRH10KqVRC3P9A6GP8GGiQDYF/mWZv6+6p?=
 =?us-ascii?Q?+SNuvvpCca2W0WbchNRPO9j9S48H7rCSae/Hy3v5ScQk0o23CcLiBJzJz0zq?=
 =?us-ascii?Q?XJuvcmESEh3qrdfYLc8vlkXGpjvRSAb4JCC0Rto+21NYDTJN4drEUuTqb+6h?=
 =?us-ascii?Q?YOOk2/0W+Q8CGGbH0wgjr7p0bjlt3AWN1MTa?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 19:49:32.5571 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b9e19d-2d60-41e2-dbcc-08dd89b2759e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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

SDMA doesn't support oversubsciption, it is the user matter to create
queues over HW limit, but not supposed to be a KFD error.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 14 ++++++++------
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 11 +++++++++--
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c610e172a2b8..76359c6a3f3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1576,8 +1576,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 	int bit;
 
 	if (q->properties.type == KFD_QUEUE_TYPE_SDMA) {
-		if (bitmap_empty(dqm->sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
-			dev_err(dev, "No more SDMA queue to allocate\n");
+		if (bitmap_empty(dqm->sdma_bitmap, get_num_sdma_queues(dqm))) {
+			dev_warn(dev, "No more SDMA queue to allocate (%d total queues)\n",
+				 get_num_sdma_queues(dqm));
 			return -ENOMEM;
 		}
 
@@ -1602,8 +1603,9 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		q->properties.sdma_queue_id = q->sdma_id /
 				kfd_get_num_sdma_engines(dqm->dev);
 	} else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI) {
-		if (bitmap_empty(dqm->xgmi_sdma_bitmap, KFD_MAX_SDMA_QUEUES)) {
-			dev_err(dev, "No more XGMI SDMA queue to allocate\n");
+		if (bitmap_empty(dqm->xgmi_sdma_bitmap, get_num_xgmi_sdma_queues(dqm))) {
+			dev_warn(dev, "No more XGMI SDMA queue to allocate (%d total queues)\n",
+				 get_num_xgmi_sdma_queues(dqm));
 			return -ENOMEM;
 		}
 		if (restore_sdma_id) {
@@ -1662,8 +1664,8 @@ static int allocate_sdma_queue(struct device_queue_manager *dqm,
 		}
 
 		if (!free_bit_found) {
-			dev_err(dev, "No more SDMA queue to allocate for target ID %i\n",
-				q->properties.sdma_engine_id);
+			dev_warn(dev, "No more SDMA queue to allocate for target ID %i (%d total queues)\n",
+				 q->properties.sdma_engine_id, num_queues);
 			return -ENOMEM;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 7eb370b68159..6d5fa57d4a23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -451,8 +451,15 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	}
 
 	if (retval != 0) {
-		pr_err("process pid %d DQM create queue type %d failed. ret %d\n",
-			pqm->process->lead_thread->pid, type, retval);
+		if ((type == KFD_QUEUE_TYPE_SDMA ||
+		    type == KFD_QUEUE_TYPE_SDMA_XGMI ||
+		    type == KFD_QUEUE_TYPE_SDMA_BY_ENG_ID) &&
+		    retval == -ENOMEM)
+			pr_warn("process pid %d DQM create queue type %d failed. ret %d\n",
+				pqm->process->lead_thread->pid, type, retval);
+		else
+			pr_err("process pid %d DQM create queue type %d failed. ret %d\n",
+				pqm->process->lead_thread->pid, type, retval);
 		goto err_create_queue;
 	}
 
-- 
2.34.1

