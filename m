Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60D3FCF45D4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 01:53:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB92110E446;
	Tue, 13 Jan 2026 01:53:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HPiSBG+j";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012071.outbound.protection.outlook.com
 [40.107.200.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1ABF10E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 01:53:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k43kU9+T6fYSXELIRZq+vLA+pCOxtYoenhAWbEgdW52Nn8+GkaQAI7FiEZNw5ykikwi7yQKGW3Fd/N5PlS4FG23V1LnXIDv0brnlSgOS+RKUIU48INTYem/e2qqOyIPYBQN441X/z+qCy1L0PUJsbYd92ElksnX8tAyPLPznlQ/cRdj8Ot/xrh4hXzZby3Hhz/sEX6XDCYqefi2jVqHFXXZf0GkLO13CEjwwAET1uQFhqg78JZb4m0OnFRWamQObRTKn5XRJCO/rfR5hh4yjKoTRcRRdnpIPcJ+Vrqzq0WjdetYxUCsnqxxUkwmDgpK+E1olRYLdK8M1Cp+ddem1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hz0SKybIvZ6EVcSK62jt0DzUhhaT/oNmC4Lvo8gcSZY=;
 b=n+c75d94GpKY1fdFdnRTRc+lHi7Wfciay9r/TXIW56NrYkuoUajk3QqGFz2BY8+IMSe69idk7HKaGpyo1Hbxvma8yFIZOSxIRkIIFa/MgCscsd47PRmtxD+EBXQevdS4EY1rJd1/Qiw6ocOzbVlaG/N1Fx4+XiTkL6hGfSsQHZR/x9lxthcymlThX2+tpp5qkyxg+PHY+vW50M1y0f+AO4fU07/Dbfv8PFyYX5mxRatZ4ddKzY2uzf1JsnprC2XbJint4eGwFune1KEdKcNiVmqdaaNJHlz5pwR71gxlRG1kLlGCcMHSVAuLhPYc0bFsYd5yQRmWo6bCxUd2zmHh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hz0SKybIvZ6EVcSK62jt0DzUhhaT/oNmC4Lvo8gcSZY=;
 b=HPiSBG+jI4OjEU78v+xpY6u3KXenjAx2J13tBGabU8KpfR3PTDORzDZJ3TcOUlUGSJRyuZXw9EgWwRQEgcp5D2HM+iVbHyuW7XGOPPhupgV7bgRgQKxDXDzki0zWpXnAY0wi/7haptQfOyYyph/wGr7WAyw9x8brb60WqdhhmX0=
Received: from MW4PR04CA0349.namprd04.prod.outlook.com (2603:10b6:303:8a::24)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 01:53:31 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::10) by MW4PR04CA0349.outlook.office365.com
 (2603:10b6:303:8a::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 01:52:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 01:53:30 +0000
Received: from harish-base-compute.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 12 Jan 2026 19:53:29 -0600
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Subject: [PATCH] drm/amdkfd: No need to suspend whole MES to evict process
Date: Mon, 12 Jan 2026 20:53:15 -0500
Message-ID: <20260113015315.517164-1-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fac02f0-3c08-4409-1714-08de52468d74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?++dIiHMg0/FVuv3smvn+rAyjBqp/2SKeBPX13XYTD4rY4ZqGmdl1k6l6FEk6?=
 =?us-ascii?Q?xUSPVVFFiVz1EmS6P+wkOmIJeTIzCEEx3VWyapMDSWwexIJ9nzIb3I2XgPxA?=
 =?us-ascii?Q?zkOlmeo5wE1/dJl4pHOGU/8+JOShn3u3EXSd/xdxn4y99VQBsjQ2Di5tiXo1?=
 =?us-ascii?Q?AnAH32L7dpx9/YUQB/AAqXI2grikWZljpHyNnZqpvneg9HQyny9IwhwSSpX9?=
 =?us-ascii?Q?Yir7mIqJcdm6pXy4VVe3DodRx7sfsGSbkn7tq9UUQ+24KB4yvDwyZ0VASxkY?=
 =?us-ascii?Q?RtQ6vh3bIdMEkDTYTPtNOQDTT4boNVU74bz+tYMt9Eq2dxp2/HXIbBgVTYjv?=
 =?us-ascii?Q?lLyM6j362DYXvU0vSk4+493mKMbxeUk00hbsfBN/MDR+83rQIiVjxxcBhgWk?=
 =?us-ascii?Q?v99AmWVH56HT7vE7g/JJynKPEQ/Nus4ljIDLZ3vV8igwSN0ctNY05ipZ5PG5?=
 =?us-ascii?Q?lcudlwHSIKERoymqHuO24m7iWwzLQ59d3jO8g2pLhQb/Kw5wG6/A0fO5iDls?=
 =?us-ascii?Q?eIbvHyxhPVjfIVMcp1PPyiJNTLI7KksKefEVNwX6iv7YH7Otqsq6dvIE5Gww?=
 =?us-ascii?Q?LPzUxsQdZBSgEfEps8Ikx1qREpANGtHYi0iza7RI587HOcN7eOnGtaQOcEc0?=
 =?us-ascii?Q?xknpPrLYPO7FMEN061i9W1sqWHDJh5MZ4ntQaIWZbtIVMnoMs6JnjIS8XMtr?=
 =?us-ascii?Q?6sYN59QTjPCoiY6c7lzLdADr1gml96t3rNCsP86ud43tYuwpLpwQwDKU2ODf?=
 =?us-ascii?Q?knoqAcr4s2+EO9MufH2XTw51t7svzOibXZQlyZx3yo2gJsl1BJTRLysjYNQc?=
 =?us-ascii?Q?I4bBwiej0w27ApU8mFnuHjPauZKdb/A5IES8A5AG5mKDGb42yTq4+i9ZjeNG?=
 =?us-ascii?Q?xbrmIPxhODet2NsagnHKf3+O7ud8r0K7zLADMIh/sOrRe4Ye5gMKDsr7Bfnt?=
 =?us-ascii?Q?qio9kmpdx8eN3TsPZUGsqZHnXQp2+TTtWLTMb/4mKS/1G1f+Zw1DF0JScHQd?=
 =?us-ascii?Q?ICakh6rAqu0s72RRSaX+cQdUIC5PaOg6q6co0xnogDptGq9Kc5p4NEJFeaKR?=
 =?us-ascii?Q?hIC459Sw4PyrZTM772WmHq8SdoqvbY69lyS0Fv0Im3LEh4toI2XYEDmjYYbf?=
 =?us-ascii?Q?w0h/fRDtEGlJhqMBnRWv+zNLB+IK3yns9XlfkDygVcMzyvZDS9FUuQC8Na/n?=
 =?us-ascii?Q?i61AwueZI/XOA1z9WP/u1LwWPAjBBDl9UNGNQV4so3fsS2IqJVryzGGcHGMu?=
 =?us-ascii?Q?CRXCQUIJAPXo28meFDxESWSZgQe5s0lqiewL2+gW5syHC3Uw55fhlm0qPLGR?=
 =?us-ascii?Q?B2wArAFJNGfzXAwJU3gwI2iuyW+qpLUDN/MQrm18A7EItRPI0o1RrsSMeCzd?=
 =?us-ascii?Q?G7SGvLFgEn1VaPMUqxqrTj/dfO2tKDnWxNydKQO+1NPVsX9IbVpk+jz8E7KS?=
 =?us-ascii?Q?3mrwoq5AFAIxdJuuRdqNzuAjoaXofTb34Xc7G5gn3v9oeIvrfgGB2L9GvYPQ?=
 =?us-ascii?Q?ojWUVzLxaVqVP0GSppccb0c3FQ/v/nMKdvASagvk1ruZLtzCIIOQ1qbFWRiK?=
 =?us-ascii?Q?PzIkzqy//8LkOfQqms4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 01:53:30.6245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fac02f0-3c08-4409-1714-08de52468d74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

Each queue of the process is individually removed and there is not need
to suspend whole mes. Suspending mes stops kernel mode queues also
causing unnecessary timeouts when running mixed work loads

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index dc4b6d19dc10..28e8c4f46f69 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1211,14 +1211,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	pr_debug_ratelimited("Evicting process pid %d queues\n",
 			    pdd->process->lead_thread->pid);
 
-	if (dqm->dev->kfd->shared_resources.enable_mes) {
+	if (dqm->dev->kfd->shared_resources.enable_mes)
 		pdd->last_evict_timestamp = get_jiffies_64();
-		retval = suspend_all_queues_mes(dqm);
-		if (retval) {
-			dev_err(dev, "Suspending all queues failed");
-			goto out;
-		}
-	}
 
 	/* Mark all queues as evicted. Deactivate all active queues on
 	 * the qpd.
@@ -1248,10 +1242,6 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 					      KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES :
 					      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0,
 					      USE_DEFAULT_GRACE_PERIOD);
-	} else {
-		retval = resume_all_queues_mes(dqm);
-		if (retval)
-			dev_err(dev, "Resuming all queues failed");
 	}
 
 out:
-- 
2.43.0

