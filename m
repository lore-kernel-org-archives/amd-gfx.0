Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C8DC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 06:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0985710E58C;
	Thu, 20 Mar 2025 06:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G7VGj4cS";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8409E10E58C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 06:15:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiJUIwVK8HMN8Af+hi9PirV7NePkAkeT625bzrN/guFomS1fZdbOlKaDgzkcMWpkRvrCL8iG+a0EBRyQY0XnLKFTI1JXhAcB2gIhXfbYVnjYDIxZ152tYvcbvCpEBgxUhI/2NQIjgfVriAK+Jvr1TuuzZOYN8Fzak7PWvBSnYduHZb+roZzd/TQ3z/OZ3d6qUIzYSH6t0ntSusyPMbzfVAlz3KQaq87gzS3umzJ2PAyMo5FSkoJNcLkZe45YUenoGFG5reP/lBwtqD2gdtTYk4V5sVT1c6XVPwqwWdAJNNH2denK7y/hLJAria44FqPndaxGSqN8ODao4tN9wQ+GSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jwp/ZrHOFxRGe6//QIga3/qNhAjOvWumvG/rORUlfGA=;
 b=pG7aPmjMk3Z0WiXqjL0ZXabh0WEBaYeLttG2qnF03WuJJvg8Ctkrhzfsgidr/Iw4EdvQ9eo1w0NFqut2O2Impsl2VFI2vWFzBkjHfCwBAEe3W43nGf85kX+Z0uI8KthAJQ4kcaFfgnXjRz1Idw4AGuSbs6YT7UVirEpMIB98CcoAZw9k1F81BDCdPD78pxbvlPzbKjJzOOb5ge6OmHOapq/slZYRRO7+JKQwAcIS9XkL3BMAOKJ24X3c4xQwTJvqeMZsGECoRaBJlvPSjOlH3+kFBfLpQTpEHfUEywlwUDK48lqzexkATIyNYL+lTM8JTIFdr2s9jYbWJ6SYVk0tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jwp/ZrHOFxRGe6//QIga3/qNhAjOvWumvG/rORUlfGA=;
 b=G7VGj4cSDRLh/XRZDrrlQSr3rnwJ6ncN+zxTwpHHmcR7eqTWdXoMAyK7DyFW2fzMj7L6IxeSOejIr3wbUVfCy11Qxo6u1PHLKbP6QH4dItZVNcj9RmkIjIUgCK8SZgXksPfwaz90zLhmLPNLf4oduXq0i78uRJ+le+xMynanErc=
Received: from MW4PR04CA0031.namprd04.prod.outlook.com (2603:10b6:303:6a::6)
 by MW4PR12MB7029.namprd12.prod.outlook.com (2603:10b6:303:1eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 06:14:55 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::f7) by MW4PR04CA0031.outlook.office365.com
 (2603:10b6:303:6a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 06:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 06:14:55 +0000
Received: from liuxiang-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 01:14:52 -0500
From: Xiang Liu <xiang.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <KevinYang.Wang@amd.com>, <Tao.Zhou1@amd.com>,
 <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>
Subject: [PATCH] drm/amdgpu: Decode deferred error type in gfx aca bank parser
Date: Thu, 20 Mar 2025 14:14:37 +0800
Message-ID: <20250320061437.572914-1-xiang.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW4PR12MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: af08c79a-e643-4c6b-d655-08dd677688a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V5Ha0nEQU6vg13cT4pXqqsLXYHxqn5Wvdgt6mRnJHI+H5PhhMDkBHaBhdcxs?=
 =?us-ascii?Q?c/tLFSMnEgsWed55S7du/QucKIV/o9KUOH2AqTcytoF4hYGyrYDkPq+FJzdo?=
 =?us-ascii?Q?puKi8sNGgqz7e0Y+UyA4NS5lVC9WxjPuRHu1d5in3tmFJ4nua2EpBDKyzaUm?=
 =?us-ascii?Q?Z6CuzN23A6j6fsctOYZBvZuoOSpmr/8D2HPTKTEycje/nr5KuRYykbGudh2T?=
 =?us-ascii?Q?WvKZl32QHAm4oFYSZrZzmB0GtF/bzwCLI9qVma/Qn2vl26Z8iSAOhcMuRooZ?=
 =?us-ascii?Q?Q5JXHDE9arcZtCL3uSfuLYe3UVZlAP6AU7jnIFlpHJA0aMjb+a6NxrJurVyg?=
 =?us-ascii?Q?xHWJiOrhc9jlzQoDeEepJd70skP5lzpBzY5jtiM3gVZ/p/AjkAEfrttg1Ww4?=
 =?us-ascii?Q?9pC6D6dmrEmE3/dELm401vQ6MsNh3wcm6jU6tj3tu9YLQI4FmiBFLyG9ksrX?=
 =?us-ascii?Q?PAZO3wK6NYffMJhfAz3k7gD5YENvcIG17WCqm9r0B6nWSOtYXIzgmIbeocp2?=
 =?us-ascii?Q?KrrgSKbXk8wFvMgMySY8Yi0FJloDZCb1w2i0Ue+b82JI51n7w26ooqqcehru?=
 =?us-ascii?Q?9FxDwU7NuuCrw0XSU/mq5OaD4fp1z3XBIHd7HcskOxaXxIFziis56/LCK99z?=
 =?us-ascii?Q?VegEnrWFN2/nPyIqGOqDBKFMxnhG9uBuMd8iWTxa8TcptWz5HzQqBFpFDcfs?=
 =?us-ascii?Q?QMMZYGAy/sDtuJa9UXRXZ6H/ZKrIq8bUb34Z/lJKD5wUqi/1p3qVjUgEOeE+?=
 =?us-ascii?Q?ZBLd5V7cCzp0LObDXBQQkWOpoxPDTrihjLYWDpovSM1sWyAqKrAGeMOSaZVs?=
 =?us-ascii?Q?VgF4z0LBCZCrjpvGPlf+Gmo7iP1S14mOxZiNivqKZcMWDfqyFef5oQPlviOm?=
 =?us-ascii?Q?v5wgWOl++EHgadntDDpacotEsgncmdIOxufKyCuETok7ZNgHANizTh/+snKW?=
 =?us-ascii?Q?j4eE7HMtmx9RBg5au9gmKmPtzKtQY/MBmvj5ZtqM7isyPs17GmaP4u3AU1S8?=
 =?us-ascii?Q?4K+CgnYJdQ/Od2cRN/S4UuK0qHu/0s/IqRGyLBM3D0Ixku5jA7Gicz6rWvGH?=
 =?us-ascii?Q?PlkDtXNoyqL7kSJrhAn88WZfPrZ2Me5lMTUfqcF2xeIgPDW9ZwrL54DLYEFJ?=
 =?us-ascii?Q?PpmP5hObZks4ge2dI9liCFhc1FDxIxgVIPqr7iY0fjfKczK7dVh9GGbNquQ6?=
 =?us-ascii?Q?bUZwT1XArT4+n6GBe4hzpWDP+0ZOXaFobNi4VNVzbalh9EweIuWdMB8Zcsld?=
 =?us-ascii?Q?jbysXPkmx36ioXHCxyByK3AyP1QPiCCE/1RkG+UQiady5KDVREjh5Rky/F4i?=
 =?us-ascii?Q?psBM706/qftUp/NeaUbF7v05mrSNcyX7yaTgPoHnsYlMBNY7FsXrreIt23tp?=
 =?us-ascii?Q?5EAY954wq/1/4Bcda2ywGUliGXpUExQzH40I6VX2Tzish5T6KkcIJmyAKZkH?=
 =?us-ascii?Q?jzrunhtiZTknDg0NG2Cc3u7ZopvvkVACpv9ieHSzm9Jwgslyt+B+U6F/xF+U?=
 =?us-ascii?Q?eCwJO4UUc709D4s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 06:14:55.1287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af08c79a-e643-4c6b-d655-08dd677688a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7029
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

In the case of injecting uncorrected error with background workload,
the deferred error among uncorrected errors need to be specified
by checking the deferred and poison bits of status register.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c |  3 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index ffd4c64e123c..3f45a600f547 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -541,6 +541,9 @@ static int __aca_get_error_data(struct amdgpu_device *adev, struct aca_handle *h
 	if (ret)
 		return ret;
 
+	if (type == ACA_ERROR_TYPE_UE)
+		aca_log_aca_error(handle, ACA_ERROR_TYPE_DEFERRED, err_data);
+
 	return aca_log_aca_error(handle, type, err_data);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index c0de682b7774..b21d784a7f9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -876,7 +876,7 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 				      void *data)
 {
 	struct aca_bank_info info;
-	u64 misc0;
+	u64 misc0, status;
 	u32 instlo;
 	int ret;
 
@@ -890,12 +890,15 @@ static int gfx_v9_4_3_aca_bank_parser(struct aca_handle *handle,
 	info.die_id = instlo == mmSMNAID_XCD0_MCA_SMU ? 0 : 1;
 
 	misc0 = bank->regs[ACA_REG_IDX_MISC0];
+	status = bank->regs[ACA_REG_IDX_STATUS];
 
 	switch (type) {
 	case ACA_SMU_TYPE_UE:
-		bank->aca_err_type = ACA_ERROR_TYPE_UE;
-		ret = aca_error_cache_log_bank_error(handle, &info,
-						     ACA_ERROR_TYPE_UE, 1ULL);
+		bank->aca_err_type = (ACA_REG__STATUS__POISON(status) ||
+				      ACA_REG__STATUS__DEFERRED(status)) ?
+						ACA_ERROR_TYPE_DEFERRED :
+						ACA_ERROR_TYPE_UE;
+		ret = aca_error_cache_log_bank_error(handle, &info, bank->aca_err_type, 1ULL);
 		break;
 	case ACA_SMU_TYPE_CE:
 		bank->aca_err_type = ACA_BANK_ERR_CE_DE_DECODE(bank);
-- 
2.34.1

