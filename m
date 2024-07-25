Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643D4C3DA70
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 23:25:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13A3510E34A;
	Thu, 25 Jul 2024 23:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OjID4G0i";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C112510E34A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 23:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ka9k3NdGliPtbHAbJquZspLIQZ5ziw1wlmx/LWXK+GrojquAZryEA/UaD41MOwsgfgjjrUHjPKh4ojL+nrR2MwcFbBDs3L/E5IJ7nz8OnOC6Ro8XEim3OxP+wDnt/rwAPrSwIQIu8MQ0SI96YsBXhnoN3xp4IMRuHgHM8iUiUM1THFuklu7a6/OI2P1ucJ1/xJNHNn12yLEtiecJuOIel6vmIB+IxgcVegM1wi2+PLzKBFwV9RWDeD/MYw9qbTVLWpV7J2U/pStTcYdoG3YsRbo6zbgJ8QuDC58wyZ9kFg5nindvqRgM3aEcmsMwZ2eSfClY36e8crJf0bwziafq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CU43hzmPczvb8xxllZt8rMagsFzWn+WbVy/PDp5zfDI=;
 b=U7+av4GhMKNBuOX6i78nDeao/k68MVdu1zspExpD0wttMgnvRErWm8vdN9avrLEDoFrssMIeqME6x8QJrvDiQmALxT3dYgvVU0ZkTx6hTWhIjo/+uCFLAJa+YkvmBnwnyh8SLvvGMGPv0GG8np3b8s/Keg7gU+CI8aB8SZ9X+JyUdQoXeKYjBtZ6zcdntAYkWfPjTXHRknerdYgEsYmPlfyGHhoZd8h2NCW1glUrALSoPYWHVjP30W2eFbr648Xi/ZDE0gAtiMbz5nGbcfHKgJtyKlu6W+TCxkCob211bJG2xgRtQ4fyUxLBV4yLjn3Pyt0y6St3TmrIi0//NRS/5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CU43hzmPczvb8xxllZt8rMagsFzWn+WbVy/PDp5zfDI=;
 b=OjID4G0iYaY3NEAszwQA9Q1XHWNGpjJEpBceGh+fQYr3bxuz/+J/yThbJkQI5n2CufjROYFJLhibpiEzKTMkAWX0gD2RhkuX08hq7s/ck0ktIlLCXVBtzy1OS+/baeCkglXk2qp+DYxroQOnDZb60NBsh68I02A5PaExXsIm7YA=
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by DM6PR12MB4370.namprd12.prod.outlook.com (2603:10b6:5:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 23:25:35 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:1e7:cafe::bd) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 23:25:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.11 via Frontend Transport; Thu, 25 Jul 2024 23:25:34 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 18:25:33 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, "kernel test
 robot" <lkp@intel.com>
Subject: [PATCH] drm/amdkfd: Fix compile error if HMM support not enabled
Date: Thu, 25 Jul 2024 19:25:04 -0400
Message-ID: <20240725232504.15982-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|DM6PR12MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 1640e8f5-bc0c-48a3-e090-08dcad0115c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MWB6yMO0vB6DNUEgP/cI83L5wMzkSQZHJarfEIw49eV9rajaDQcvDkIhUfHO?=
 =?us-ascii?Q?S6h7NcW1cbYINi655cgE6hgCPuy+U/sbpS/8TlWjWSfvQgD1b3L7rpLwERGg?=
 =?us-ascii?Q?evt+bT/la95QjbrtqoSB+b+LXVU1onR83LZa6SuENCzjJVSgB37xovg5k3CP?=
 =?us-ascii?Q?2MVXg5XrHZlWdMbQIajSZ/5ayI3WVABSwgSA9IOhbDhE9baJ5zNEadewjXTO?=
 =?us-ascii?Q?AfnZ5GXwpTdZQcc17ccBrpY3NvgOYgkjl+7gQMnTvaxEqvS9BK3VR6UFR2Dh?=
 =?us-ascii?Q?V32E5K7XOMtfHdkpi32sHY8ROCr79el1EARWivq6CPoz85/hi+Gv94XSllMv?=
 =?us-ascii?Q?cbSHMSGj3ONK9Cjc7iKQGkrtU+iSdZFFhb+is2h+llk6an5E4f8ULjSy/G4W?=
 =?us-ascii?Q?1QUGq+8deFk/x/iHo1djnqwcauN6bD0la8YNpTzPApLAqL4IxQoNp9KjN2pw?=
 =?us-ascii?Q?EFahUoBWoIwMDC+2JbqblGD1MGGC2STH+YsZfsj1YeDuAkjtyjeuIQiBsPvU?=
 =?us-ascii?Q?DpuMU2+hL9jaIGqBNWMQ8lmQoZ8UGP8aKaL+l0zMCnqOXuAgyTI0jjj5iHpM?=
 =?us-ascii?Q?40c+HCRtdlBqbA7Kh7GU5JhNfmoOWtlne44o5PfxYso4xtaH3dppi3jbNrC6?=
 =?us-ascii?Q?SaSa6gkjuSNQ2lJqBHGqVDBAuFU7iMeNVeXEh4QWjPrww0c9oNFT/ssIprp0?=
 =?us-ascii?Q?dqUoNaQSg3h4JGEgbkf7DtLeBPd1jc1k0g61Cu9dkZjwuHxtg2plC2wOV6JA?=
 =?us-ascii?Q?WXJF2q46kkx19+wFk9xhANaDoaforbr7gQAWMf4uh+nEU1VYgEX/T/skg62w?=
 =?us-ascii?Q?ZMlyr44Uzxj4y+cYtHFeZfh2ZMr2Lt6vtgQ2RwP8Q9TRa2mt6J6USekrbrxo?=
 =?us-ascii?Q?KWxxWr3FMpQP2pWsbMz0lyv6Inqix0BhH9ddJqh1WY2F7q2HW+DXw/iijf+x?=
 =?us-ascii?Q?S7gBL03JJJ3Vrk1T63dM+0PFt9v77bgVA5e3zhDyrVoTWf4uoksVhfqK+68N?=
 =?us-ascii?Q?QnynKvKsPPN6T+nyk9gTXqxertT6V0kPFIyx/8U479X92ddhNcaIwxI8V812?=
 =?us-ascii?Q?81KPYzA8zVMB4cI9LiMnw1y9PuuSf8QMeFgJNcRgiBaJ2R4UWFZ6AcTgZrbx?=
 =?us-ascii?Q?RkXvakX5ma+X2qZ10xvam/t903yaq2oe/sOWMB2ynF9qfFFa8IeXEorM8n0b?=
 =?us-ascii?Q?A9O1HqzT43rjjPhyqQ8s+xit0ULA489Ee+/zKyEZEWxABAGbizy7h1+XUFPB?=
 =?us-ascii?Q?XEn3n/PcNxYVDWS775EDAt6ODqtjVfVWAutRUGeLb/nrtjajdbz9tHcG9D4a?=
 =?us-ascii?Q?f8Ah04k+itKMCnIfwWwb2aSzI5lwwUKJ8v14r8+mY8L3B2vpLLpyFag+dr4d?=
 =?us-ascii?Q?spyjBa7gKZpelLMCf4DhwvH1vDzKKlHgA4yj7oMBlQEuPbK8Lg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 23:25:34.8646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1640e8f5-bc0c-48a3-e090-08dcad0115c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4370
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

Fixes the below if kernel config not enable HMM support

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:107:26: error:
implicit declaration of function 'svm_range_from_addr'

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:107:24: error:
assignment to 'struct svm_range *' from 'int' makes pointer from integer
without a cast [-Wint-conversion]

>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_queue.c:111:28: error:
invalid use of undefined type 'struct svm_range'

Fixes: de165b53c93f ("drm/amdkfd: Validate user queue svm memory residency")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407252127.zvnxaKRA-lkp@intel.com/
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 9807e8adf77d..64c292f0ba1b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -85,6 +85,8 @@ void uninit_queue(struct queue *q)
 	kfree(q);
 }
 
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+
 static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
 {
 	struct kfd_process *p = pdd->process;
@@ -178,6 +180,18 @@ static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u
 
 	mutex_unlock(&p->svms.lock);
 }
+#else
+
+static int kfd_queue_buffer_svm_get(struct kfd_process_device *pdd, u64 addr, u64 size)
+{
+	return -EINVAL;
+}
+
+static void kfd_queue_buffer_svm_put(struct kfd_process_device *pdd, u64 addr, u64 size)
+{
+}
+
+#endif
 
 int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_bo **pbo,
 			 u64 expected_size)
-- 
2.43.2

