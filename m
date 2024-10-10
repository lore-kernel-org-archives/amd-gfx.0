Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1010CFC5E4
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 16:17:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 942EC10E97D;
	Thu, 10 Oct 2024 16:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UoB5GLlk";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2065.outbound.protection.outlook.com [40.107.102.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2052710E97D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 16:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcSVi2g49wMadz55t6p9pJ/uQ6+M6cvHDFDLBe3fX3aJ5nq/GRdCi97bHLclRiXlsvfntT+Ox5HUIoD3flM2dimHhZcSAXqjdHNaOa5AaDW2qnP8MahVwK1gK5qCWeGYwBHEJ2pFtwehShW3ryN0ls40f59EIGpXNOvbxKbmGoIY/fFAr8hEZwog8uncGcxh0VEUmyslCvrmsdYNgIeGeG9UkWijXUTO1MeIsb5l0eM1U+fil9IDfJ0wF6VZuR7u1YeSDghUKQ28Vd9SRqMvzL2sgji6/IuK0c6Ff3d5J5FCENW+D+Q54SXSd39VLb4/a6VDoe0eA+0XKMArQe765A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6rXKREDGXA5RPBdsx9muTax9VSY1uZJ+V7mI7Kgj00=;
 b=eD1nt0gEQpnsPKrfXJGcnBm9OzhRCXoUXhT3nKRQNrOUpdINSdM53O8hcZtfzVAXg8G9bPSLje5V7ik5SMncEXVPNZdNlGUlb4ocYogTawa+xSQotFTU/Xr6A8RDNAytAv60kKAhl86sRmEG25AQN/9IJI24GuRKje9zwtvtLkiAw5uVzRKAnUPQnwydF8aQxsxQJPYAFWA876Ng9Jezjjw0MOF7TRbsPKi/7ZTD5U8JxfjTTCYlgXqXjpYcpyR3MZG7b6b7HajWoidUeQ4Hzc17n1V60RmLLnMlt5mgIhmNjwkPIEawrsZvIuaHDf5yFZIGPkiam9dyveaulZ9n3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6rXKREDGXA5RPBdsx9muTax9VSY1uZJ+V7mI7Kgj00=;
 b=UoB5GLlksH9WZAEQ3ZygCFHVgxf1zuUN2i8TgHaZxsBn3VZoikNmbsDMUIS0eLPrXeguW46OfZNOk8RLGiXiIM2d1JEvU/oNu/b+/CgaCtfQn+zNcfkaD126twyUtYKJFdq8hdzuK6D4syWe4Ujm7b4NcatTrEO1CvzqMJPLe1I=
Received: from IA1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::6)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 16:17:47 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::47) by IA1P220CA0009.outlook.office365.com
 (2603:10b6:208:461::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.20 via Frontend
 Transport; Thu, 10 Oct 2024 16:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 16:17:46 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 11:17:46 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <jack.gui@amd.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: pause autosuspend when creating pdd
Date: Thu, 10 Oct 2024 12:17:30 -0400
Message-ID: <20241010161730.13416-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010161730.13416-1-Yunxiang.Li@amd.com>
References: <20241010151831.10859-1-Yunxiang.Li@amd.com>
 <20241010161730.13416-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 417a9ab5-043e-43f4-9fdf-08dce9471430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YIU3G5/mDRiMyn+t8WRBdGJvYGoh6k8kqBt3QI+Xstcj4Jd17/IlaGX1qGzk?=
 =?us-ascii?Q?zGIh7Hda1MxCHxbLgl9bZkmbtXCf+/25hC0nhCktKYWUlIaqS/Xno8Rm8CZ+?=
 =?us-ascii?Q?sNrFlEZOKgKhwB2qxy1CaSi2lNtq2daFmSv7dveKtI+mv3KxbV41zO9zirqw?=
 =?us-ascii?Q?p3doKMOqPq9VlPdBMIZiyV7Cjvi6WNpIORRz1b1A4BfSYcbeGJl0/32lnf5/?=
 =?us-ascii?Q?I+HKFpIFVJLr6SWYTHuS8q1bIqJK5jj3puCsK943OdHmzoPcOjbONgtHQb7e?=
 =?us-ascii?Q?iZphbtBx7BVmLiFAhLILqnDR6ln4h5k1j4uAAXIujQzno+eu3SlSjxdJZthT?=
 =?us-ascii?Q?BQcWNbrLmCarxCDfcbMZbzQPLU6zjzfaFWqRLrfPlzFrmgB4ZEoX0OWycsLE?=
 =?us-ascii?Q?XwJqrIS0M4JjRyWLAxEhB2LRDGMzog6knSgOvCHVF68n/UJfNrlVYUFwIppq?=
 =?us-ascii?Q?0ceTqwj5z8wzIQ9qpcKeX9yFnbkmZeri+Ami+k0IPBe+wFgnh53E82TuLFkz?=
 =?us-ascii?Q?GmmKLD+6pQj2c1aKPfAUkiAPerFRRf3LZeB7Df6NWU9ZrvFYqNZvoyI0ndTf?=
 =?us-ascii?Q?gx6glkd2gungn6ScLmiHXbB66/XeHXFAIOc9G8xRbzurI/O6LfsFlIFIbXB3?=
 =?us-ascii?Q?qkorWdYI/gpMZvCOmdMt59l6rrNYfYhcBHKxRS97rWR4MMUX24hmA5ubJv+x?=
 =?us-ascii?Q?wB5Vm8Llzc3giWzxUAnkkZvjgJeiZpw4N6MrgRjETDC60glWqa9w6aDBIzvL?=
 =?us-ascii?Q?tYGRJ5A74zm/f0s+8Ls16cC8VTqmP1EEU/GJyQnLRe6z7Bguo/Xl4tT7+hSY?=
 =?us-ascii?Q?v/0ZtEytl81QbeJFZUXYFIrfiWqYY4+1WOjhSE/AnLOoQJSpsSOb4+0stoim?=
 =?us-ascii?Q?xrUB7nwdleX1QX8s/p9ewSMBlffbPf3kCd1qJhz22Pz7EdYXD5nGBytLcaS+?=
 =?us-ascii?Q?nNGcpYNq5CZILSqARGw6bkMxxHaf2GpN+b3a1XKkxEVZ0wzzAwp7dwM2AMjJ?=
 =?us-ascii?Q?CZ93h6vnklXRIL8eC47BMjYfpC12HMH5tp44zOXrtQZxnkqqNQLSh0ag3jth?=
 =?us-ascii?Q?L+MB+X7BwF1gZY04P0q6enNFkXaK2XSWMXb26RwKcihQs1cvmanx6uCusY8f?=
 =?us-ascii?Q?osqcXekWTlUIMbAAJSSF9AvXbWyZ2gznUTneDCjsEUVtC5B2WSH6rCsxNYuP?=
 =?us-ascii?Q?dwoh3WDBpA2S/rzGC2gj6lzLalIc62bRdxyVLKwQVo2weDdeKqFHXBuF3Air?=
 =?us-ascii?Q?mHMrm3JImYw/B+iL04X91ERahL8Socr/TYol2nWtEHJIB40s8CpCz5DP3P2p?=
 =?us-ascii?Q?nOaoNHB4gpIJtXu8zU/qsNEEps/QYcPTr4WJCmj/Kr9NkaimDnFhVg7GdUlq?=
 =?us-ascii?Q?YMTj9uiEyQ06+s3rkX2bE4NK8A50?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 16:17:46.9667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 417a9ab5-043e-43f4-9fdf-08dce9471430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
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

When using MES creating a pdd will require talking to the GPU to setup
the relevant context. The code here forgot to wake up the GPU in case it
was in suspend, this causes KVM to EFAULT for passthrough GPU for
example.

Also, change the other place where we pause suspend to use the cleaner
pm_runtime_resume_and_get helper.

Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")
Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---

It is unclear to me if kfd_process_destroy_pdds also have this problem,
or is freeing gtt mem guaranteed to succeed even with the GPU in
suspend.

 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c9ce95bc3ec8e..c3d510f1dabfa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1633,12 +1633,19 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	atomic64_set(&pdd->evict_duration_counter, 0);
 
 	if (dev->kfd->shared_resources.enable_mes) {
+		retval = pm_runtime_resume_and_get(bdev);
+		if (retval < 0) {
+			pr_err("failed to stop autosuspend\n");
+			goto err_free_pdd;
+		}
 		retval = amdgpu_amdkfd_alloc_gtt_mem(adev,
 						AMDGPU_MES_PROC_CTX_SIZE,
 						&pdd->proc_ctx_bo,
 						&pdd->proc_ctx_gpu_addr,
 						&pdd->proc_ctx_cpu_ptr,
 						false);
+		pm_runtime_mark_last_busy(bdev);
+		pm_runtime_put_autosuspend(bdev);
 		if (retval) {
 			dev_err(bdev,
 				"failed to allocate process context bo\n");
@@ -1768,11 +1775,9 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_node *dev,
 	 * pdd is destroyed.
 	 */
 	if (!pdd->runtime_inuse) {
-		err = pm_runtime_get_sync(bdev);
-		if (err < 0) {
-			pm_runtime_put_autosuspend(adev_to_drm(dev->adev)->dev);
+		err = pm_runtime_resume_and_get(bdev);
+		if (err < 0)
 			return ERR_PTR(err);
-		}
 	}
 
 	/*
-- 
2.34.1

