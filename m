Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCC3C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 18:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1023A10E81E;
	Fri, 16 Aug 2024 18:02:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B9V60Y46";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7E6410E818
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 18:02:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piajgRK/bmdNavAIG/5BWvVAMeCxhmIpY6KiZnxihPcRI9w2hiqIxZmCO7wpaF2trEil/7eY7VU4rzMuvJOSRAj8TnnuQClSW0mGrjIkwD42ReKhOh20KFTCnwIKvnn9fsgAdCoHCF+TPJ05F5ah3NK/p7FKyUfAIXK5q1DMzGHm4OdYT+qgttlVPR43JoMuPNEKtWcSnEj9/uXD5OSRs/lczSsYlIRdCpV4CMA9RNDSxoyGIjkwMX/BnEQuwNlaeLnK8blmgysgArNujkBLdJ8n5+e7Ulj1CEDxvUPgwJoXJu3TF1MMRa1V7n726q+G0+IoRt6DzMMFzB4iar6F9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZkGJepGKvzsnj+3fCsZYwZLm0f6yAjl4ZqUekQO+Ms=;
 b=Okg2hBWwtPlQ14SOiDJuCBjKMFG10UPxCqvxFUydhrZqNKdrjX3HPYMMIJQdLnm27XkwP8Lll5ovhzxjIHB5cP6yeyO/ylO3LZfgkvg3ESGGuwpWUgQACvqfhjwGqwzGroKAjvQebOBwrUL1YxizIgi9L/C5aswvWS6JFn/jAPUWkFzYF8VIBNiqt2dQQopjQ5sDAo8/7dFR8jvrwfiB9zQ/Nqdo7MApdzCZY0YTG+cSwd8UZwYrs1kKhhsROEXyQOb2/zmsPDK41d70R12tPY4/7cNMZj3Cd+QbT0+/1qMN4q6rF5J8q5lkUB/9QQQpAR1D7jX7ZTMCfLF4YWkBYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZkGJepGKvzsnj+3fCsZYwZLm0f6yAjl4ZqUekQO+Ms=;
 b=B9V60Y46m8+gMv8/5+lLVuFziA1Ev8NlgWveHYXssqizjpo9uZ2H/iagRglTD79Vi2Vr4ybKRQ7ZZZXDDe+pE1ypKia0w6Pg7dQq90eQai1adSh/OIhH9DlR0LUNte936NxayL90xe1t+3SYdAfmcozGjvvifnbCT4Fq5vo11uQ=
Received: from PH8PR02CA0014.namprd02.prod.outlook.com (2603:10b6:510:2d0::6)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 18:02:02 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:510:2d0:cafe::5e) by PH8PR02CA0014.outlook.office365.com
 (2603:10b6:510:2d0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Fri, 16 Aug 2024 18:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 18:02:01 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 13:02:00 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>
Subject: [PATCHv3 2/3] drm/amdkfd: Update queue unmap after VM fault with MES
Date: Fri, 16 Aug 2024 14:01:37 -0400
Message-ID: <20240816180138.1171558-2-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240816180138.1171558-1-mukul.joshi@amd.com>
References: <20240816180138.1171558-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|MW6PR12MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: de43c8f4-29d6-4177-c6e3-08dcbe1d876e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k126nd+5NDDoFn3YboJU3/GT5/h13qMkVmdUaODnpTbvIucHlPN4IRjVs359?=
 =?us-ascii?Q?ne+74CMQ07jSp/sJSDIXW6NOa+7CH3115RHJlr9pyy3P8JxFwoLdsV87P/jJ?=
 =?us-ascii?Q?jjgGQnLvJJkopgNA8NmtquFuWNoJrqam6sQWItyOY54zxQbTdPqEaDZrQMfJ?=
 =?us-ascii?Q?r6ChE49rqXFRwjUZkGDNEDQ9jCw+cYHdWWCXvITpt6bvNPbkIOI+zIZhk20W?=
 =?us-ascii?Q?eQebvunq259IH2xZDXIKUyLTVX6WJU8Xo/+d0Jf1PgwUqiXNNqsiqTgjAxOh?=
 =?us-ascii?Q?k8VC7Q283xRAVnSrhGd6kyHIt6Yq34eMAbgZPsTLoeHXsHgpXEmWxxRKavSp?=
 =?us-ascii?Q?49Bu02NaiXuq0jjpq1kxzCRbfyz+xVWHaOVjcbJufn9f9dtKbTNZr0WyPvn8?=
 =?us-ascii?Q?iHClU2t9jOD2o+m1xObuEhivzD/o5ytojmXS62KZ25kDspWFF+n+dksAQJLm?=
 =?us-ascii?Q?3C6oXZj4ZqZato04pQnKSLBWlUG1WTqr7QhbNcecqICe17/bNhb8eDGomFF4?=
 =?us-ascii?Q?Nvzv6J7moSih5OeS8qb07mRkoHD6bYzpv7Ed//hx377jhGxSrZsEwAh/D/YH?=
 =?us-ascii?Q?eYr10p9heeNDB8IkxEjpl0Qn5v1gzu2/WiuMPbyfcUBlJYqoA73UxkLkczw7?=
 =?us-ascii?Q?+p0cAdzkDNbunS6k84mcR+CMpu2SYjajkX0bAM1ecMk/zfReJWW7dKUFIBsi?=
 =?us-ascii?Q?4cuHheOS6bEebKYamLbFRrrsTZ9kvVr5ppplYjaroCuWree0kuSL/sI2ZbDX?=
 =?us-ascii?Q?Mwy5r0mbQ6SnjmjCwICXL8EbJkEKNTiboFWXaZ+z/tjBjLSbPfsNywCP0jOn?=
 =?us-ascii?Q?o7oysp6eucIi80PY+KPYDK73Tj34JisVu37gilDZkUSBPEppJXTZ/Td2/T8j?=
 =?us-ascii?Q?4OXAuBgqnDsM+bJZWZCwlQlThtS03SlRPGfU1FapF4YH1BrMpo/hS2SLWL4E?=
 =?us-ascii?Q?aIEkfkWNEq4zgukUSNpk3nA9gzUBBessetDSy9Q007fzbRFt6PFIyeN1vnCz?=
 =?us-ascii?Q?k1Uh8DMyaJqOdRUoky9WWmvoxBXSUkz7ylUdTX0CXcyPTTUfnlrFtnULULAP?=
 =?us-ascii?Q?4EPVQc7FJuZgjqojxOc5bLQaGHNGJzOYFj1KaZtETOQQTxkQq0UyP5pFvMWE?=
 =?us-ascii?Q?OvlEZ37GxMyrF9R9xzOid5OdSG156OP1KOAb4quvJdz3HxrKtMAJQcfGcnWV?=
 =?us-ascii?Q?VgdMh6/CyqbLYESpm9nNxGB3/rV4Kkm0buhF76OLvIdl2XP++UfSIzuYP0w9?=
 =?us-ascii?Q?BTqGxNuHMiH6KDqVyPtOJpmAKrQAieRphcfIJXFC4CYlFcFQWnFZ//IkriPS?=
 =?us-ascii?Q?LEOSABeSiDOvMCfSSXzLMB9CpKx2NNelTde/OVtGeNEKXwYQn2o7kNpge8uB?=
 =?us-ascii?Q?vNq0ubBm1dgXj3Gq9I/tElLL+hb7DZbLllzSuZBozz6zRXAs3N7xes/nvRFX?=
 =?us-ascii?Q?igmBf91A9GT5ftLZsmlOJJyRqs8YCXWK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 18:02:01.3874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de43c8f4-29d6-4177-c6e3-08dcbe1d876e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086
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

MEC FW expects MES to unmap all queues when a VM fault is observed
on a queue and then resumed once the affected process is terminated.
Use the MES Suspend and Resume APIs to achieve this.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
v1->v2:
- Add MES FW version check.
- Separate out the kfd_dqm_evict_pasid into another function.
- Use amdgpu_mes_suspend/amdgpu_mes_resume to suspend/resume queues.

v2->v3:
- Use down_read_trylock/up_read instead of dqm->is_hws_hang.
- Increase eviction count if the process is already evicted in
  kfd_dqm_evict_pasid_mes to make sure the process stays evicted.

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 87 ++++++++++++++++++-
 1 file changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f6e211070299..0ca933d2099c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -319,6 +319,46 @@ static int remove_all_queues_mes(struct device_queue_manager *dqm)
 	return retval;
 }
 
+static int suspend_all_queues_mes(struct device_queue_manager *dqm)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int r = 0;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return -EIO;
+
+	r = amdgpu_mes_suspend(adev);
+	up_read(&adev->reset_domain->sem);
+
+	if (r) {
+		dev_err(adev->dev, "failed to suspend gangs from MES\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		kfd_hws_hang(dqm);
+	}
+
+	return r;
+}
+
+static int resume_all_queues_mes(struct device_queue_manager *dqm)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
+	int r = 0;
+
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return -EIO;
+
+	r = amdgpu_mes_resume(adev);
+	up_read(&adev->reset_domain->sem);
+
+	if (r) {
+		dev_err(adev->dev, "failed to resume gangs from MES\n");
+		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
+		kfd_hws_hang(dqm);
+	}
+
+	return r;
+}
+
 static void increment_queue_count(struct device_queue_manager *dqm,
 				  struct qcm_process_device *qpd,
 				  struct queue *q)
@@ -2835,6 +2875,44 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 	kfree(dqm);
 }
 
+static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
+				   struct qcm_process_device *qpd)
+{
+	struct device *dev = dqm->dev->adev->dev;
+	int ret = 0;
+
+	/* Check if process is already evicted */
+	dqm_lock(dqm);
+	if (qpd->evicted) {
+		/* Increment the evicted count to make sure the
+		 * process stays evicted before its terminated.
+		 */
+		qpd->evicted++;
+		dqm_unlock(dqm);
+		goto out;
+	}
+	dqm_unlock(dqm);
+
+	ret = suspend_all_queues_mes(dqm);
+	if (ret) {
+		dev_err(dev, "Suspending all queues failed");
+		goto out;
+	}
+
+	ret = dqm->ops.evict_process_queues(dqm, qpd);
+	if (ret) {
+		dev_err(dev, "Evicting process queues failed");
+		goto out;
+	}
+
+	ret = resume_all_queues_mes(dqm);
+	if (ret)
+		dev_err(dev, "Resuming all queues failed");
+
+out:
+	return ret;
+}
+
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 {
 	struct kfd_process_device *pdd;
@@ -2845,8 +2923,13 @@ int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
 		return -EINVAL;
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
 	pdd = kfd_get_process_device_data(dqm->dev, p);
-	if (pdd)
-		ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+	if (pdd) {
+		if (dqm->dev->kfd->shared_resources.enable_mes)
+			ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
+		else
+			ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
+	}
+
 	kfd_unref_process(p);
 
 	return ret;
-- 
2.35.1

