Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819CEC3DA7F
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 18:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F46210E194;
	Fri,  2 Aug 2024 18:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+7cfdaz";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB4E710E194
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 18:39:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaUg38F11H32R4cX3XS2LeJp/yi3UVdCy/dqThzsrKH/AJPja8jvkoc0RDl8jbrohGDeQnVg/sGU157S+n03r7DY4C33VwuUAcqZidDlvO1+poCApR3O8ucQfAnzfSGZssFAO8D4gUbh32Q47RBeIvaGWKBXNesevvq8JmnNtwHo6T580kCT5nNo6Wj53IRMQNJZ64hAFhENeFr5aKgtT5kuMXFgFXFYrBt4qiKpZUtMAF7F0ScyHZDbom/AiKyiTDG5SWnCq1FpU/ZeC0aFGjsQJZHuOwor0mjFP2SatOFOI7rBTgjTIJT7zgnI2UiLGmYLNG8rQT3c/pm1IpiERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIlBeG7qQpbjWpGdma1RBuQQePBbbxT6PGWbzQ+cNG8=;
 b=oXhHu/CTXbeItNe1XC+GvytdYXQwAroV0Q8CUpjyzmFgkiPbLYVCPY/+giDtLWlxmEnPwZutzy+kjOVgrDnkyRkGJEq2y/zFPLfDhCaEhLKNqEnWczIVUmIKrLY8cIO1NIbEuWs4OQaRXtFxKjf3HMbQW8/Mc9EFNMOCT4RP+/PvV+LPqhOjHBQRZEJ/ml+OrU8tKGshwosfRvotDjsjqnWC8DIuuHovUnr+H1vKtq51S5fEDk40VQiK5Trba5gT1cuh+Bgb3Sqbtrny6R583AC6G149BvXh2lx26LvzkbkKvqa4G//WH11hwcFaWETjHRS038URqCJINPhK9WzdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIlBeG7qQpbjWpGdma1RBuQQePBbbxT6PGWbzQ+cNG8=;
 b=h+7cfdazsRpkb2WcJxNryuoO11cHwPj9K6KaRekQa5fWUXfA32H936mkaHFajlanAPMS6xIe44mgtHl1oS8QnDwotLM31KRmNhcC+CikzFhXMBaITFjYzSytW6rbr5H9ELQxyWw+s1wbBexcnoLpHYdsEzgqeoi3Rh3u+LrqYJQ=
Received: from CH0PR03CA0185.namprd03.prod.outlook.com (2603:10b6:610:e4::10)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 18:39:26 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::1a) by CH0PR03CA0185.outlook.office365.com
 (2603:10b6:610:e4::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23 via Frontend
 Transport; Fri, 2 Aug 2024 18:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 2 Aug 2024 18:39:26 +0000
Received: from mkmvskvorts01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 2 Aug
 2024 13:39:25 -0500
From: Victor Skvortsov <victor.skvortsov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Victor Skvortsov <victor.skvortsov@amd.com>, Lazar Lijo
 <Lijo.Lazar@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: abort KIQ waits when there is a pending reset
Date: Fri, 2 Aug 2024 14:39:11 -0400
Message-ID: <20240802183911.322102-1-victor.skvortsov@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bab9024-dcf4-46a8-7f52-08dcb3226f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wq2CALSgs/8pGZvhzsJE9mn7s5oL1l/cr7Vx4oSmLgAjPIbYMLZz/Ax8xGGV?=
 =?us-ascii?Q?gyKPaqoe2g3VqCMi17SMRyDqpx4Jy6VVYWsi5H6SR2SnnbE9mTSplJ+89tyY?=
 =?us-ascii?Q?V/piWsv5yYP19+8oqkV8/rxH5Z4nxJapPUnqMllKM2YflN6vj+XIicfwliEH?=
 =?us-ascii?Q?USzqs1xQ3RJnUTpIJ4kJQwgCn6y2ouwa/k+6cf8ope1LKj7InYIXpK40PAsB?=
 =?us-ascii?Q?+WOlsUt5M2fZijy+3CP16/HgRyyh6mosf4c5OiqVdFQ1KYCDKYzCz2YnMp2P?=
 =?us-ascii?Q?XtYExSyPLYWa923emw48sjCUDLl5bIMqNdL1RpHgBi5hRFfoBxCmoOH28gBs?=
 =?us-ascii?Q?dXpzbH272Bc+gTU4K4Zm8gddAmbarW/Bo8gr4dhrCGGvn/6zeifSyl6Rti/x?=
 =?us-ascii?Q?+xnIInpm1Y5ehrlR5Pdl9/aEPuj/uqjYK7RX75Kyrw/Nz2ALv3XA0wqkb66G?=
 =?us-ascii?Q?SQfwcCfY23qhlOuz/RzSqoIB06MZT6DeNJbdAdu8c+XKFZ2BiOxKo+S4HNIf?=
 =?us-ascii?Q?Gq9SYFxvn67HDHQoI0yCQXGNgJLHUgtgAwJzMsK1cr5qhOgTvrqJs+vLRRN9?=
 =?us-ascii?Q?j5IRG6wmSrS2bVzXI4vaXew3IT2bwLuGY2Z4NYF9WZvkWkVmuenU1ZT+LAej?=
 =?us-ascii?Q?0Sm/xHC/8imIJBsItolSvr3W1t5KzLI9Nm/58wuWapb02Ok/hoIy1ECWrFq3?=
 =?us-ascii?Q?UeRlcfi9Bs/U3Mv3zT3Z/iHc6n6b/EN0I2JMCCiJ8rDN77gcYKpUvDJqQrfO?=
 =?us-ascii?Q?nmbehXwuQ+5+n6jQHcz6zYjwodcTiqWKaAxrhdH+Y2I2vIx2vXrs5QtGtU4H?=
 =?us-ascii?Q?Kqa1a7CrSnj0NsPsRdsrTDYW+CzYb6KleR8Qd3tcRRlWfXG3KkOzQ+UG9rYd?=
 =?us-ascii?Q?ihRMqgpVPSywCOejw8SvcSEYUGSC9dqS1ANiPA+TpSIKQtree2ybqbhWQcTL?=
 =?us-ascii?Q?Am4mLY0+qxkPfeUgZeqvqYRUBqvt9rCHlQju9yfYR65yAR8FUOWpgtrsai+w?=
 =?us-ascii?Q?dOHx/f5eDx4uguP6r6VJJ1jBZXMKRV2lOcMdunKT0QnUGpsjkk7bae8z1LJa?=
 =?us-ascii?Q?eDBHvsLPa8VwKqoUH3vuvJV51K+98cQQDq8o4oxgvqqQpHYpEQT5r5jaCiSy?=
 =?us-ascii?Q?SyGOefC0SaGvoBNQdlTNuxwf4xUbhj5pV+1htqp/Z8KycA0gzf02rPE4Qya4?=
 =?us-ascii?Q?Fg9IhZhP+vJ8KkmyteDa5+mWpbWIXkICGsReMcdSw/2abWP7jIXUjxWOh6yC?=
 =?us-ascii?Q?r3J6yiX9EFbvIrQYDmh7pDDDKnVSoUaCtY1wY1y2NPdUo+gqmQ4PwLf4OwVf?=
 =?us-ascii?Q?J88FdzVNHQSSxo8FBcSqe98unJiZWFejTJM3yX8/vOvguLW7MLzB+fExAeym?=
 =?us-ascii?Q?Yt+qbNGlgdoPslDxR7SgpWNrMg+S3X+sYxWRaNkhDRoo35Hq9WdboG+6NbsI?=
 =?us-ascii?Q?Owjmz6KSHilaIGCSYWw7lRqle3wRI4Ow?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 18:39:26.1814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bab9024-dcf4-46a8-7f52-08dcb3226f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

Stop waiting for the KIQ to return back when there is a reset pending.
It's quite likely that the KIQ will never response.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c   | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c02659025656..8962be257942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -785,7 +785,8 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct amdgpu_device *adev,
 		goto failed_kiq;
 
 	might_sleep();
-	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY) {
+	while (r < 1 && cnt++ < MAX_KIQ_REG_TRY&&
+		!amdgpu_reset_pending(adev->reset_domain)) {
 
 		msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
 		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4ae581f3fcb5..f33a4e0ffba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -136,6 +136,11 @@ static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
 	return queue_work(domain->wq, work);
 }
 
+static inline bool amdgpu_reset_pending(struct amdgpu_reset_domain *domain) {
+	lockdep_assert_held(&domain->sem);
+	return rwsem_is_contended(&domain->sem);
+}
+
 void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
-- 
2.34.1

