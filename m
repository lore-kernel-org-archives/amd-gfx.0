Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD05CC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 10:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865A010E8D9;
	Thu,  1 Aug 2024 10:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BtJf1/uG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FEF210E8D9
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 10:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVXxjdTc5qm/BBFKw0G9BVXDGbi3oBHpVoTDqhhf3epHY+QyI43CMPu5jVgD9N7XbFD76B23BWiV9ztFaTHH8PByYPDVKx6WPbBEpL+WMfwpxolKSJYvb0MiVcTLSx2KfUFuyqeBnAD7z3QHZ3/5TOfVUBCPlL0twHgR3h/+MQgESP6y39vuuQG12OtsB+6znuYMUtkBCkHPJk8F/XWjT7gY7wUbLmLZHESykw8SzNfavC3Wxrz+CtKpvuBBdaZiJHWexPq4P7LX8OUBwZRGxHWv/+/1BUkehvEGFYUrKYKlETdV76nbimxyuGWqHOraj5/eYBqkB+GURl1F6Vbtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqUy8Rp9HmJPtuoZg19Fwbo1LjTOtjQ+hnBFyWklj+c=;
 b=Cw9JURHQH7yjxTS4AQ1aYMy+bE7M+Znizns+jGUSeef7afN0JveqJCzK0SRq1IErwo6itsK8cmeHkgYbLsMj/zRhQyL5S2w3+kyWKNBlIvJ6YnWkbupefPUKd1REfxaemnRDnvwQdLXyLDlEjmcEjF/dAknhThc1hg8fCuwKo0TZFOHyJOcbFw8Wl+MbrI+4y+k5BPGXM5hDpbiuKBF/QkLL7E9+mNUQTaNn/w42Qgs12dQbWYoca0KucTnxLg6L/7lCtPgO0wbiDfkUFrH5KCYETVR3XSkX63WvygXFAEpQ0QkbdvCct2Y8Oi7Irx7CjooP8iGH59QteyjlyHpIZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqUy8Rp9HmJPtuoZg19Fwbo1LjTOtjQ+hnBFyWklj+c=;
 b=BtJf1/uGeorc0j9fXQc0kLMhkNuQweOvptKCV2YBmSdh11CVuUsz22e7iCRwkvJMvHeEhE3kh77XmHm6SYWIbZMhpuJqycWiJzK2tYGv/J7hCXUs9uQxsZZ8IPDlwtcSSx3LKWsGC3LnnV/s+SVVKTJPVcViR1TDEBGrejBj6Yo=
Received: from BLAPR03CA0170.namprd03.prod.outlook.com (2603:10b6:208:32f::17)
 by MN6PR12MB8491.namprd12.prod.outlook.com (2603:10b6:208:46f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 10:00:06 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::21) by BLAPR03CA0170.outlook.office365.com
 (2603:10b6:208:32f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 10:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 10:00:06 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 05:00:01 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: create function to check RAS RMA status
Date: Thu, 1 Aug 2024 17:59:51 +0800
Message-ID: <20240801095953.35625-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|MN6PR12MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: 850e9f89-6164-45d9-378b-08dcb210b861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8bTni3LfDZ2nOfiM+yulqO72DU2oWfuD8LDjo3X3AcbjLClliQY3SIH05LgC?=
 =?us-ascii?Q?b6vTJtXf9i3X3VTSkCUF+doIBQHEOt6WvbVHQQqfqTs3HZYkZXtMu9fvDsLn?=
 =?us-ascii?Q?dOHoKOrcPBoooHvThiRq6uKnyRDtONKpu1zBYVAi4+RVX4cqICV9yI4y4/It?=
 =?us-ascii?Q?ORHgCEUYMAadwswsEJ2a+kYFrEWLdpTLELsRYF596H+XRYwZwmGHaFKig/s8?=
 =?us-ascii?Q?xefKqVEoVteirORVQfk5VGg5m64o1yYqMQZ2eLGd8VNhW3F9csKZ/lWrPDtL?=
 =?us-ascii?Q?Ucp5m+XBZXVQiuU+iSZUiRV/5y1qzDXSEUPNAEY3JBLFWuGQ8MpKNSZI0tQQ?=
 =?us-ascii?Q?nEKANPDU3p5gjFWTpBMUSju6gsE8NARhYcvOWGP09aDEwykh3WNIZwrEFOPk?=
 =?us-ascii?Q?PSaRe+DRXaVihJCMHnYrQUmBbNO7rNj3ES6Kw7tUzv0c4vpH94BnbCPuB2wZ?=
 =?us-ascii?Q?cwhfw/xwNaNUGwDUUaTmu9rHhGOpcJBXNIOQ6fwEesNfP4VUuI86rfr6n7sT?=
 =?us-ascii?Q?OgpHHf2qYQRct/gK73HuRw6105HrxsL+GuY2N0V+9IouSPUKx7ryekuTUF3F?=
 =?us-ascii?Q?kelJn3Qgdh/F3GPIBQpGOpVM8N2tdkR0BLhZhda59AH7M7LB4zju+YY3XpkW?=
 =?us-ascii?Q?aJqeYjUBzxJQF+MggfjYlg1lBmWAFJ4rsMRxjJ5LwmXSpaihnNFyBggUFG+g?=
 =?us-ascii?Q?8zKFYhM8Pwa9+I45JRTnlqFz1jjRY4ca4egsEUhvyAnKyY2N8yqUB9T122zb?=
 =?us-ascii?Q?tGC+k671fpiGRARCImitYSY5XvuMYNQuUuFzTLDEGqjR6hMWKT8x+iKAfOKn?=
 =?us-ascii?Q?Dk6HVlcj7tPojq58xK6HayYowiugSiEgibjZKOyERyCHOuC2jIdPm06pxY/C?=
 =?us-ascii?Q?cU8CAiIHfzxEUWWYSSiOG7O+yXmRm46aV7H+EhkcLY8ugHTOCItf0WN5T4st?=
 =?us-ascii?Q?lT7FeR9IST9lc73oSn1Y99PUgwo7/El+ECGAxWkIH60ekQ5AjzLEOw0sE0OD?=
 =?us-ascii?Q?7+KowTcaU5Ftsr8Y2rFdYW76Wi9b7gnUHu9RxvbLnxsyh1c3ZPVmlqtMyGTg?=
 =?us-ascii?Q?9qjJaYPmvGn1J88+hkJKsSJZUgMPVB/2gWOYnVe3Keeb/B0kw78f5LENS5fc?=
 =?us-ascii?Q?osFFnzhMm2oWZNrLUt4AyuICqFg9sIgQqmUiyS9LMSm9dPRCSAtPrneaSwf9?=
 =?us-ascii?Q?QWju80aaahHDIh8qN5rZN1xSvh6bYA4Q+OZONQalOOF2TTehMpmD7JaTaxnM?=
 =?us-ascii?Q?a5zTGrG8m89HA0V1VWBBl0doszgU0NVVaQDRIi4OrR9LHvRnDDtIcTaE+Vls?=
 =?us-ascii?Q?dDBiakCucCd5lRjyjjbz9jaG7brSIXVo0laB6raS4N8w9ZAyocDrxpFNJ+QZ?=
 =?us-ascii?Q?LlrpsmyO4qd4UfaP/eEokl9rAdq+qZBAXNoaI1kdbsykIwOvUsTcuMfvOePC?=
 =?us-ascii?Q?BZ8Fko6YgybsBWWyBfqWfIEpkiUDuFV0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 10:00:06.1742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850e9f89-6164-45d9-378b-08dcb210b861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8491
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

In the convenience of calling it globally.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 22 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c |  2 +-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 12ab48f26bd5..0941518f04c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2153,7 +2153,7 @@ static void amdgpu_ras_interrupt_poison_consumption_handler(struct ras_manager *
 	/* gpu reset is fallback for failed and default cases.
 	 * For RMA case, amdgpu_umc_poison_handler will handle gpu reset.
 	 */
-	if (poison_stat && !con->is_rma) {
+	if (poison_stat && !amdgpu_ras_is_rma(adev)) {
 		event_id = amdgpu_ras_acquire_event_id(adev, type);
 		RAS_EVENT_LOG(adev, event_id,
 			      "GPU reset for %s RAS poison consumption is issued!\n",
@@ -2951,7 +2951,7 @@ static void amdgpu_ras_do_page_retirement(struct work_struct *work)
 
 	amdgpu_ras_error_data_fini(&err_data);
 
-	if (err_cnt && con->is_rma)
+	if (err_cnt && amdgpu_ras_is_rma(adev))
 		amdgpu_ras_reset_gpu(adev);
 
 	amdgpu_ras_schedule_retirement_dwork(con,
@@ -3053,7 +3053,7 @@ static int amdgpu_ras_poison_consumption_handler(struct amdgpu_device *adev,
 	}
 
 	/* for RMA, amdgpu_ras_poison_creation_handler will trigger gpu reset */
-	if (reset_flags && !con->is_rma) {
+	if (reset_flags && !amdgpu_ras_is_rma(adev)) {
 		if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET)
 			reset = AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 		else if (reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET)
@@ -3202,7 +3202,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	 * This calling fails when is_rma is true or
 	 * ret != 0.
 	 */
-	if (con->is_rma || ret)
+	if (amdgpu_ras_is_rma(adev) || ret)
 		goto free;
 
 	if (con->eeprom_control.ras_num_recs) {
@@ -3254,7 +3254,7 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	 * Except error threshold exceeding case, other failure cases in this
 	 * function would not fail amdgpu driver init.
 	 */
-	if (!con->is_rma)
+	if (!amdgpu_ras_is_rma(adev))
 		ret = 0;
 	else
 		ret = -EINVAL;
@@ -4301,7 +4301,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 
 	/* mode1 is the only selection for RMA status */
-	if (ras->is_rma) {
+	if (amdgpu_ras_is_rma(adev)) {
 		ras->gpu_reset_flags = 0;
 		ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE1_RESET;
 	}
@@ -4835,3 +4835,13 @@ void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 
 	va_end(args);
 }
+
+bool amdgpu_ras_is_rma(struct amdgpu_device *adev)
+{
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+
+	if (!con)
+		return false;
+
+	return con->is_rma;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 7ddd13d5c06b..25a19760f098 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -972,4 +972,5 @@ __printf(3, 4)
 void amdgpu_ras_event_log_print(struct amdgpu_device *adev, u64 event_id,
 				const char *fmt, ...);
 
+bool amdgpu_ras_is_rma(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index 32be258d81e1..9e70a7b3aa64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -196,7 +196,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
 	amdgpu_umc_handle_bad_pages(adev, ras_error_status);
 
 	if ((err_data->ue_count || err_data->de_count) &&
-	    (reset || (con && con->is_rma))) {
+	    (reset || amdgpu_ras_is_rma(adev))) {
 		con->gpu_reset_flags |= reset;
 		amdgpu_ras_reset_gpu(adev);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
index 9cd221ed240c..999bb3cc88b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0_3.c
@@ -97,7 +97,7 @@ static int gfx_v11_0_3_poison_consumption_handler(struct amdgpu_device *adev,
 			ras->gpu_reset_flags |= AMDGPU_RAS_GPU_RESET_MODE2_RESET;
 		}
 
-		if (con && !con->is_rma)
+		if (con && !amdgpu_ras_is_rma(adev))
 			amdgpu_ras_reset_gpu(adev);
 	}
 
-- 
2.34.1

