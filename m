Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD31CCD193
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 14:31:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 441AA10E45C;
	Mon, 20 Oct 2025 14:31:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YV+u27LF";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011066.outbound.protection.outlook.com [52.101.57.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D194C10E45C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 14:31:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcDz49u6w5igtkkIkhvdVrwkMbQDttNKjRvTeKGMQqXsoWMK4HAFoD5oCvxuxy9A4c4XBLmRXFuEotaJwCnV1j4yhpM90B383aKyYzPd3TpstMARuXrQ92OEWR3aOwrb47pY9BS/vNq5WQP2EEFX8MY9GIU9cWRkT3sVKX147y/gXInUKoz/EG2Vs8CVjPFKwrdwms0D70wN1vyET05pGnrpXUYWdqpIGotcWm2neyZsiH2PZZovxnP3ZTDNlP5G7wA4cMBkjK0uHbLGGGfPs7leKFRk/DkDAcNcCFEqnvPUNHu2aMdBqSF0+fYtLfaKPzWMNW2cu1ELIlnfrrKb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8//KQ2Qjsh2Wrdzpj7TbOcwsZv3NETeDiAVgL81g/DI=;
 b=czUrlPmognUseBVKDp9IZL1NDeYA4lAwOvcaj41lVgidHRcSLK86vVgMVLgSVtNPB46ivx20S0Vcz4glclzLr+gzVq2R5Hsd+qxhL+8v9cvfRticiwd1RwGzzYWgu62AMGAXUsHHEeQzdplZRghqJ8w+EnIQdzu9FKshfYt24d0hBLsiux33HbL0HzRekHh/6i85JR0mtrcnMgy6S0eAIDKZvjsLKwFOWAY/ZGACaGSfz//v6Ka5wZVI8hKZbA28dpsTquc9uwzSDA5HikSdgs1Va/U4omsD6FBytJ6yWhkm4kykl1u/l7AVu+KjvBRHh/uvA3K34yM86LKDzXElaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8//KQ2Qjsh2Wrdzpj7TbOcwsZv3NETeDiAVgL81g/DI=;
 b=YV+u27LFNr888M1pP7OzBBUNu99pu8tt3L2BfR7FzKDxVobzQQdNZh1LBltdEnu1dsxLMe/OVJi8bH0eg4TNYahDhqYNAdb8AMKNTQfxfoxIqwovSZcCR72DIbSxZQVnUHYmWS0ftZI7IVevYXDrbbZXuEXOCiPYHeC8gwQmiNE=
Received: from PH7P220CA0118.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::18)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 14:30:59 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::9a) by PH7P220CA0118.outlook.office365.com
 (2603:10b6:510:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 14:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 14:30:58 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 07:30:58 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v3 1/2] drm/amdkfd: Fix false positive queue buffer free
 warning
Date: Mon, 20 Oct 2025 10:30:15 -0400
Message-ID: <20251020143016.23409-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|LV3PR12MB9214:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d96cced-e7ac-4981-7736-08de0fe549ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xYtmAGYWJlPaxv/DTDkK7cYNZ4ypfSAolZ68HP07nDvkE96NDPVIZ0BKAF0u?=
 =?us-ascii?Q?/pMlBBgtS6bUiwwkknDkFxSQnvXwMF5JXq2LvsbhiNxp06jPNi4pB42sVFcY?=
 =?us-ascii?Q?xAPDrwChNLhObWReWXUOOiQSOH6Ee5TY10Jxo0IG9uuu0PLvSaq+U49s3mO8?=
 =?us-ascii?Q?Vb0m65l+3BbQlsoptH16EyPMMrFJYfPTuwiBmEY8p/UBWJ7gxaqVXhoi7rcz?=
 =?us-ascii?Q?gVq1yU48MgwsO14/g96xiFfHuvx991HOgjTIRoddh/J0UZnmMCn9P9fZuTt8?=
 =?us-ascii?Q?js+XSqiHbbuWcRKPxl4dQgTAQLVDx53y9upKahspp+PpmSReIxmyexTWlDFg?=
 =?us-ascii?Q?EJked1mNqKszMhSaCjjstSxAmV5bfmgiRpNwT3Ex0/+kdKlbMBRGgUJEs1MX?=
 =?us-ascii?Q?TZ79C31JtxOLAOyrB9z81AtVCgl8t0XzK3/cFCQmnzqI7ChPYuFHG6yMUgOK?=
 =?us-ascii?Q?JoU0H2bOSIwaEyEDd7ojlMAAQEasBJyrk1w3kRm2ltOxnKCMQLq8OhtCjVnW?=
 =?us-ascii?Q?oGwX651Rc4oCfCtvyr+BcyE3+p10hX8uGi+LTq4ZWYqojumOu1DqQ0/YsVEb?=
 =?us-ascii?Q?WYiFcSucspayTCykVf9Oxxu8JfXjK2rxqWIbgCKLSqiabxnrU8FWjfgrCcvk?=
 =?us-ascii?Q?Ctdf6Ybwq0tosQVD+tx+lQlkZCwCR6iu1CnRYufBxqQL3wikmNwNFMt5LLap?=
 =?us-ascii?Q?MF82GrNH5NG/ri0IM59LQ/bdyiaCRDm+vQl2gUcvoMxZKxqV0BqhT2J/3zbj?=
 =?us-ascii?Q?oRPduGRKf+hZqIY5wYTC/J3iHd6MvrERfJ0Ezi7WPDV6o0L7jZobp6UF0d9v?=
 =?us-ascii?Q?pxN1IVN5R+5xtiHBx4YntB396jMuiMb88kFlti+YR7QF8tpMA31xqm9pCUvC?=
 =?us-ascii?Q?SmqfDtZjcPuf8pMXMbhTfjXbmzkQlooEHMiWUAE+9UVODFFA4+U9j5nj6ilh?=
 =?us-ascii?Q?ltLXWLHvZBHoTxU0OYWSSNfkPeZVbTXjSy/73AiCe2sZhEQPldl48iRwpmeX?=
 =?us-ascii?Q?tEpIZCkYXBHWEaV2QsX3bPhWOsTBQx1N9TUJ+ostGuGlTGpL+QDaJuE/bPIb?=
 =?us-ascii?Q?GbgBTX8sElQtG4PUaPhpPmbkGGeZFWgngSPljgOACaIjetM3wXmBaHz++/vo?=
 =?us-ascii?Q?yS6yAXPU/EDTsA9CxL75QttJYAP02es21SC4Nxe1K27XJuUn7PWrtBodBzSB?=
 =?us-ascii?Q?kdofHekUstSmLIETkkrKOXuHcya9MmoX0B3Wu11Upzv1tAu1jLPxSoJM3yrY?=
 =?us-ascii?Q?ucY4OqMfHL4SLwemPz+YfqNP7Wxmd9NCr9S5eH/+R2AchvB3MJ01uAnTWUbg?=
 =?us-ascii?Q?KgG/efvMbR1+h5iRV3ZaaA3nlrHzBrkg+qo8qJrIrd8qI44hsDoj9yEJzZsV?=
 =?us-ascii?Q?eDrM0GTY/QzOb3Y0kPL/j44OO3koGiZNpk2cVe3YiinvXeqKRxJ2oGHFP/Yv?=
 =?us-ascii?Q?YmIsZUtV8gxscibwFaEcX0EOP6/cOkTRQAzK7UiQXHZxhrPCJdIqeLkRe2U3?=
 =?us-ascii?Q?cD0hF2eb8Y3rtDZT4xc74jXhIuOkBiV6GQ9LbAhhNoyPa3sWXuPZs7v4sqX0?=
 =?us-ascii?Q?Ii8b94Ji1oBsmCVXZkY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:30:58.9817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d96cced-e7ac-4981-7736-08de0fe549ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
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

Only show warning message if process mm is still alive when queue
buffer is freed.

If kfd_lookup_process_by_mm return NULL, means the process is already
exited and mm is gone, it is fine to free queue buffer.

Fixes: b049504e211e ("drm/amdkfd: Validate user queue svm memory residency")
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 4d4a47313f5b..d1b2f8525f80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2487,7 +2487,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 	bool unmap_parent;
 	uint32_t i;
 
-	if (atomic_read(&prange->queue_refcount)) {
+	p = kfd_lookup_process_by_mm(mm);
+
+	if (p && atomic_read(&prange->queue_refcount)) {
 		int r;
 
 		pr_warn("Freeing queue vital buffer 0x%lx, queue evicted\n",
@@ -2497,7 +2499,6 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
 			pr_debug("failed %d to quiesce KFD queues\n", r);
 	}
 
-	p = kfd_lookup_process_by_mm(mm);
 	if (!p)
 		return;
 	svms = &p->svms;
-- 
2.49.0

