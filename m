Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D14CED240
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Nov 2025 03:53:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56F5D10E1BB;
	Tue, 18 Nov 2025 03:53:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Lbzh2TeG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013023.outbound.protection.outlook.com
 [40.93.201.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCF810E1BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Nov 2025 03:53:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NwOupQwjXivSLZamb9hF7XLlk3XiCAukHuDKo/Ihf6h2hnnyL3YDtwZcX2yZyVaBLOYM7uEjypqhurfL3TUHh37S2j4FCDMRiex5n3rDf0QvvuoH6PxojrFtDE5VGdwTQc6dIqh2gonx7ILWxST8CALCtXrD0vf/jwsW+TBjrVIMB1Czy44dnnkXsDnNjwDGKWflQJ4cSujZeaFJFsLKSCycW8fvwfB0MQ6trPq553eLa4Um5f0ccFrNlsWgFFElT0zk+/kE0aYxSAGQq2Ir3a2c+lA1D2ypccXVA61Jjkm1P2sY/P/gO95pa/UwtY33AjRDxbkP6Z5sL4JBp98AfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=444If/nFuZHkat/ecJeagoDNui/PojDFuAcu61NyVqc=;
 b=OdYqhdH7tTURuHMlfzz4Ilg83lxCxU3w8HBYbH+wQ2fv3omYeIM4tjsbjYd0r3N0+bimVy9vFluMa/ugIzM1+G9Dpd/ppElG2K6F4PP0tCsmHB9zaUB6uWZdVMKv7R/hdOzAsO4XrPctJZw5vKSRSdnsQPtCE9FePo6GRbtnK7McuZiOS0SeBK0OOtWy0JLs+MrathBLgPyx4BryFVhJjDxuw+4gEkRzzkn84DMd2ng9ci+Ho/s7HqrZiAv52NExOnidkn+WdS5ekt60Oktygi5eHeB3MhfYWAaMifW1qGusCipAFRkZEIII0FbbihKgzscse2avARxjxl7QbRbZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=444If/nFuZHkat/ecJeagoDNui/PojDFuAcu61NyVqc=;
 b=Lbzh2TeGDb9lSmHMHPCpRWx9NjYSICyiV6qCvjtnkSFRmGcgd/dXrM/oKbBoOAr032cQ0Of0q2aYbDvL6xkfRXNX2DLPPQVzCBqTt5rP6IpAvz5QSQ2DOHb2efCAJjUqlYNzZgJ/6f4Bcuve4IQ3GiBkVJyYALfTdDKrkuq9ieM=
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 03:52:56 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:54:cafe::28) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 03:52:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Tue, 18 Nov 2025 03:52:55 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 19:52:53 -0800
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <horace.chen@amd.com>, chong li
 <chongli2@amd.com>
Subject: [PATCH v2] drm/amdgpu: in sriov multiple vf mode,
 2 seconds timeout is not enough for sdma job
Date: Tue, 18 Nov 2025 11:52:40 +0800
Message-ID: <20251118035240.3457330-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|MN2PR12MB4456:EE_
X-MS-Office365-Filtering-Correlation-Id: ed9a30bf-2d8a-4154-e5a3-08de2655f4f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xoAl6i+DOlO3awJv1TDsk16NOjQAIZFM9glBlQNmvk3WVd70QoaA+O4tsM/b?=
 =?us-ascii?Q?iVIvnCFBi6jQqaYmAoMmD9QwF0finNDIHFRZKPInqTcXNjFE0KzVBH2cNJ7x?=
 =?us-ascii?Q?EJLMzvVWxg72NwkF565fifBOTaNrRccguHRE1G5XqUoOYeMGEEapMQhvN8oK?=
 =?us-ascii?Q?aAtwZhdsckmv11U8mxIdpy3Nsn/tW4cGBkjmLFrmtAcOzeI4TSRjt7KaGs+R?=
 =?us-ascii?Q?eVFYZFv+cTcmLeehxJq2O+FHP6UOt2FFFjLvyS07QAtD2Gl/exjUOp+t8eiG?=
 =?us-ascii?Q?D+9s0vPbnWBa9WApe490HuGvADXVWUaqKeB8r6Ahvb3L3jYpPcRJbnXOA4cs?=
 =?us-ascii?Q?rFC+sY0a9nTbZODAsz9r79dRXste8ajM65L8qBN+hdAGrKV2DWyv7UxTmrrO?=
 =?us-ascii?Q?+FI2cpTcA29s1O0pka5bJDTTzkhPN0//4+QiNaXMZv2JHaLCjAu3S+LDiBNm?=
 =?us-ascii?Q?iZFiSQnqx6zEf91xf+HrtQ/p0xzly/FB+7jDxZ/dSSlEJBY00nGKeab5M90j?=
 =?us-ascii?Q?I7anYDNejVFRMCRGW4k9LYHdLQg2pFm1F/a96yT42dNW7civoHvFsQsEH7FN?=
 =?us-ascii?Q?4CVSJ++9gz8cQKGfGA4BQPsgpRjr9+Ax36vuGz2b8xoQM9XwU3Bk7pI012cP?=
 =?us-ascii?Q?mETtrDsEUvw1NMyPDKluWPEGf6/w6Ykvrx/d30BA0teaZeEuDMJFBb/6BG1U?=
 =?us-ascii?Q?rbO8DFoC2MZWpcFU7j3z2Ep6QX6tlO2TIb3XFNgrfSsXG+HWXxthfnr3ow36?=
 =?us-ascii?Q?otWt+qZXtVz0b+4zqE5qvofwMtr5pfBRfe/CY8Rtihh7xKeMyZ1KI5zaKJa2?=
 =?us-ascii?Q?vJoeTAnJzTSWi6MedaPDH0CrlGDoJaeBM6jCQMkDu/+TMc4moXD42THuI9Dm?=
 =?us-ascii?Q?KvmvDwNAy/FoKJWW2hJx6+Axf+0Q2hCxdOEf1Ykh0GQSD/SA4ERhYtN+cft1?=
 =?us-ascii?Q?HxP6baDpNrUJttwg70KJ1QIhveEC1GUIMvO7aqDb0V/FWzCTGEcIwzeF3tfs?=
 =?us-ascii?Q?w9Y94DLwIcwB/aunhYZui744LMd9JBYpcLn66gSgcX5D5wpbffLcHZ1SBl5l?=
 =?us-ascii?Q?n35whPC2yzFbqXexclGENvqmuUqEI/l5rAfTAjuaRydggx6k3JBVSrNTGaQO?=
 =?us-ascii?Q?Rlv3g5kLTVVM9qevu5K9mktEppD8Tp41a3Yj8asiAKbCydp+Q00yb+ECOkus?=
 =?us-ascii?Q?1dGEPH6QN9+RXyxmjc46BPDswdJfRvtjl4CE8IA4d+oQ0kVPM71tCOZXr3Cp?=
 =?us-ascii?Q?UeMOBRFj4lPXE2LACDGr09WCjhwT956sXruKYuuAX+/MoJpnYwaGWEjIhtZb?=
 =?us-ascii?Q?vl+EksIF9Q2Lcrnn7xISMhhuFp8xNoZ1+sDartcIgqpEjrthscIIimN7k8US?=
 =?us-ascii?Q?9sKAbq7skABiWHFB/1F7uOLj+SdSt7CZ48CE5BKOfPkEQy7lxIJFA8gnXaCm?=
 =?us-ascii?Q?zuQAbSoKyOCMDwBudT/DrVx1BEt5+xfnHusxh8u0BkzO1dEhkvN7yrtVUXn8?=
 =?us-ascii?Q?4BVl2MeA3KzowHgO/RK22YuSAuGli7SBeoNTsZKIETg9ZlA2AtLqWaDHmUrU?=
 =?us-ascii?Q?O3+GURisSb1i7thSxNY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 03:52:55.5949 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed9a30bf-2d8a-4154-e5a3-08de2655f4f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
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

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 69c29f47212d..4e821de10eaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4341,10 +4341,15 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	int index = 0;
 	long timeout;
 	int ret = 0;
+	long timeout_default;
 
-	/* By default timeout for all queues is 2 sec */
+	if (amdgpu_sriov_vf(adev))
+		timeout_default = msecs_to_jiffies(10000);
+	else
+		timeout_default = msecs_to_jiffies(2000);
+	/* By default timeout for all queues is 10 sec in sriov, 2 sec in non-sriov*/
 	adev->gfx_timeout = adev->compute_timeout = adev->sdma_timeout =
-		adev->video_timeout = msecs_to_jiffies(2000);
+		adev->video_timeout = timeout_default;
 
 	if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f508c1a9fa2c..bcfc56c87a11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -358,10 +358,10 @@ module_param_named(svm_default_granularity, amdgpu_svm_default_granularity, uint
  * [GFX,Compute,SDMA,Video] to set individual timeouts.
  * Negative values mean infinity.
  *
- * By default(with no lockup_timeout settings), the timeout for all queues is 2000.
+ * By default(with no lockup_timeout settings), the timeout for all queues is 10000 in sriov, 2000 in non-sriov.
  */
 MODULE_PARM_DESC(lockup_timeout,
-		 "GPU lockup timeout in ms (default: 2000. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
+		 "GPU lockup timeout in ms (default: 10000 in sriov, 2000 in non-sriov. 0: keep default value. negative: infinity timeout), format: [single value for all] or [GFX,Compute,SDMA,Video].");
 module_param_string(lockup_timeout, amdgpu_lockup_timeout,
 		    sizeof(amdgpu_lockup_timeout), 0444);
 
-- 
2.48.1

