Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0054C47BE0
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jan 2026 10:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59F5F10E4C6;
	Tue,  6 Jan 2026 10:14:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tg0Knrcb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E122310E4C5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jan 2026 10:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7gAHQpjDN281UP2fKmoraHtG9dmXZK4FfCLQcY6RUssgyeiEiyBcQ8lMD8ch38TOHbeVyIsyCOl9fbD3j03T98hM3p1iDN9HRnUfsr4+qQA42l6hFcx4AjYwGbbPsEndRZm/bVRzlTs0nKWaxKLxsYI0F5AAuAJSxmj+bQdImAG+Ug7kfQkKf6EBL4If5MQ4EI7tupPlhpCJaJSty1Gh9Em2Vq247+XL/1STwpui4UDH6JiuyoPM+8wRVFxilXchU6MYPFH+ZWR7pF+mmIy0DG1o49DAytgR86xHM/OcKbrzIQAj9aXjvGW/S60xRupzOhJMKb0/MlEFd7n/1rWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LChAEQnQvP97JYfmoI3EFnYHLoqA59neccdaTJftWU=;
 b=oTZxx4kwVC2YMV5gaskoSfI0sOhRUnm5OJ9u6AH8P8MEpJI6l2ciLOpXY9C4xVUIcFFkyy/YCa5d6NzO1omQJEurIdyEOSGbvxKd6rRUCcXBIuAWfAjxsYqjs6Uo3Ml98ULxfrLYlFJtQXl7yZ0vdqHlrtJKnEKZ8HxPbuRxUgnitVxyNBSuGX56QEAyYV25hDz/iw7UECM05HZEJwf5aX2Z4fiPNAh6oDS7QYEtAB6u167AqF2qO7QF8nEU3dMt5eye3mt2jfaopk7Ktqq7w9s13bLvm6jP7ySdAahvC5YLGaj2T0+0t7elQCRhfeOuDM6W/sdRs0yFJ5OaRJk2VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LChAEQnQvP97JYfmoI3EFnYHLoqA59neccdaTJftWU=;
 b=Tg0Knrcb6tTxZBA3HIKYa/mcAzzlTRNal2Qe+TlJg7LigkgcF5AQGdP/foI09eFxJB+hlEfAdisdHVUFp2BtTrYZJAYdWGhH87TNW8BV3zOol+jYCrB0wIPfRJZNVDKJ8FMzYdcSGS0HKADZNL/Rx/5ygM1osC85jKS19OwVH80=
Received: from SA1P222CA0103.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::7)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Tue, 6 Jan
 2026 10:13:54 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:3c5:cafe::e0) by SA1P222CA0103.outlook.office365.com
 (2603:10b6:806:3c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:13:53 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 6 Jan
 2026 04:13:51 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v2 08/21] drm/amd/pm: Replace without wait with async calls
Date: Tue, 6 Jan 2026 15:42:28 +0530
Message-ID: <20260106101317.3856153-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260106101317.3856153-1-lijo.lazar@amd.com>
References: <20260106101317.3856153-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f85e68-25fd-46a1-cb74-08de4d0c4baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r7Xfo+r4N6e8V5M3KFWnwfpX0kC0FkdM9QUFGjWFdpIr7xUi90AeU+MLbDcI?=
 =?us-ascii?Q?pJY25jct5UWE0idHeTaeyqS3X71+J3kKqb/va6stsv3wV8hT5wAw0qOxGZnx?=
 =?us-ascii?Q?KZBdpXN3JYJwx1czB/B6VmnZKRUsgnD8DyFAgsR6XWrHsSA0sSBKBGS6QMet?=
 =?us-ascii?Q?+KxcwMpBdbXm880TolHGGD9I0E6rB/nvzVOi5BCCH5VakW2+nxLXbmK12df+?=
 =?us-ascii?Q?7dUJy604PARTfDSP6zB4ZoTYsVbidjpprb+S/9gQhGIeEeAZ3EPCebKRWhjn?=
 =?us-ascii?Q?bC4ILkVFomUJhwfSYAi+PlvdvTVOJsuucufuTJdowqP1yAiKLZdt2m26LhAk?=
 =?us-ascii?Q?u7sH6Zjz7VokjRKwcEZD93rjn6tIev1i68K3b4L4w7CA3J2x3q7ikPJKJd4e?=
 =?us-ascii?Q?nFjvG9wXhl4Vf2jT9QwoGeRwUmn9wugwudw2EG9VFfiv68dz6ImWMzPxrfna?=
 =?us-ascii?Q?a4U8f5/RV6Y2afjvaIbdEIGAlKCOS4v7YurCin7lG4WQmJg4nxH1NbWCS/d8?=
 =?us-ascii?Q?42X6H4ue74CGm5RghT4budpHNIxbHCN9KEPX8Vi9ABXwPA/IY5UY5JJP3Huy?=
 =?us-ascii?Q?lHaJWgkLigaEZwAs8o239Gihja8tZbXjl4JuqdPdZ6osDDNiHJOPXu9FA+yl?=
 =?us-ascii?Q?HwDQMV+F2YniajUjgQhh9D7MnmAT/D037of16Z3mJpanWbcNgL7xiqO8j5Gq?=
 =?us-ascii?Q?wdrMnyMJa2oms4Z0PSGRN436pPz4T6pxKIouH6/VsK9YTOagaj97zNLXFT12?=
 =?us-ascii?Q?rUbcZsfwrXpaHtwGlDaTfjKRUie7Iq3Ndnli4ZQB4GnSqF2dJkp/Ujr1VEPb?=
 =?us-ascii?Q?rd3udBNgrmPRwWyQSbVjMknFRrBOJ3xHn4kv8SQmN2OG+Oj3Lv/wbCt3brzV?=
 =?us-ascii?Q?bEbjZpXdPO+CPDwVvoDVN5buFw1oeIXLqddNdnAhqxYR+Pfp6VkJTfdm9mBw?=
 =?us-ascii?Q?7ZvGCM3qEqREGmZr5xflr6rr/IsxDuLv1/DVYgvLqNpQxd4NIZ3js/rQNNzL?=
 =?us-ascii?Q?L+1V3wxO3j9ZwOfmpTgq0IDn0VFImE/s979spKAUbOz9Rrt1AaOE3V8P42qU?=
 =?us-ascii?Q?yZxwA/xUntScaqGK7j49BYo63WTRh0Akx3FTXCXRQAhG+WbmSsUyb9kRfomC?=
 =?us-ascii?Q?SYTBM8EnO7Ntl/RBuOeyAb5bXCiBaBBs/pmrBdcdlQ/tKtD/LFv8pU1E2iHB?=
 =?us-ascii?Q?+ocie7otDJg1ZHCb/qwa5YSxJiHDPx9bF65LAt2LqEJIViuybD6/KSKpUtrI?=
 =?us-ascii?Q?zsZiBA6zjwOHJF1nm82LF1t683i0lSd9sLvU3r7kLnt4bWwuvdmNa8hubnS2?=
 =?us-ascii?Q?htMMuOY/UpVmqRGSTxYyhI2W5w8qFLAKpPgwRgOgQYjz3KJQCPQgQBUYdWYn?=
 =?us-ascii?Q?5UbMOGLJJsZwbWa0U36E6EizN62zA1LPlFG0qi+hlG3q7hz0CNHd4b0qXJvE?=
 =?us-ascii?Q?S/HgFkwXzKieQVfgWdUNsh9ya0Pvq7i4wdFRjVpHbdq2spHWfFDCI9X0lsWb?=
 =?us-ascii?Q?ElyASa1Sx/nwPZgx58w+dUBgn+vBgVdSHesjR20VmFXEfOj97xbrUfTwfhsK?=
 =?us-ascii?Q?EoE0guL0vR1hF+a1R/w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:13:53.7283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f85e68-25fd-46a1-cb74-08de4d0c4baf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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

Use the new async locked message function instead of without_waiting
messaging function.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 ++++++++---------
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  | 16 ++++---------
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 24 ++++++++++---------
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 13 ++++++----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 24 +++++++++----------
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    | 12 ++++++----
 6 files changed, 56 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9ea6b0d1954b..087b4b6ce857 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3043,21 +3043,21 @@ static int sienna_cichlid_stb_get_data_direct(struct smu_context *smu,
 
 static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 100;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_DriverMode2Reset);
-
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
 
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_DriverMode2Reset,
+					SMU_RESET_MODE_2);
+	if (ret)
+		goto out;
 
-	ret = smu_cmn_wait_for_response(smu);
+	ret = smu_msg_wait_response(ctl, 0);
 	while (ret != 0 && timeout) {
-		ret = smu_cmn_wait_for_response(smu);
+		ret = smu_msg_wait_response(ctl, 0);
 		/* Wait a bit more time for getting ACK */
 		if (ret != 0) {
 			--timeout;
@@ -3075,11 +3075,11 @@ static int sienna_cichlid_mode2_reset(struct smu_context *smu)
 		goto out;
 	}
 
-	dev_info(smu->adev->dev, "restore config space...\n");
+	dev_info(adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index a645094b029b..fe1924289040 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2272,18 +2272,12 @@ static int vangogh_post_smu_init(struct smu_context *smu)
 
 static int vangogh_mode_reset(struct smu_context *smu, int type)
 {
-	int ret = 0, index = 0;
-
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index == -EACCES ? 0 : index;
-
-	mutex_lock(&smu->message_lock);
-
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, type);
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+	int ret;
 
-	mutex_unlock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset, type);
+	mutex_unlock(&ctl->lock);
 
 	mdelay(10);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index a3f4b25ac474..76edb54972dc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1828,26 +1828,28 @@ static int aldebaran_mode1_reset(struct smu_context *smu)
 
 static int aldebaran_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-						SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0 )
-		return -EINVAL;
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
+
 	if (smu->smc_fw_version >= 0x00441400) {
-		ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index, SMU_RESET_MODE_2);
+		ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
+						SMU_RESET_MODE_2);
+		if (ret)
+			goto out;
+
 		/* This is similar to FLR, wait till max FLR timeout */
 		msleep(100);
-		dev_dbg(smu->adev->dev, "restore config space...\n");
+		dev_dbg(adev->dev, "restore config space...\n");
 		/* Restore the config space saved during init */
 		amdgpu_device_load_pci_state(adev->pdev);
 
-		dev_dbg(smu->adev->dev, "wait for reset ack\n");
+		dev_dbg(adev->dev, "wait for reset ack\n");
 		while (ret == -ETIME && timeout)  {
-			ret = smu_cmn_wait_for_response(smu);
+			ret = smu_msg_wait_response(ctl, 0);
 			/* Wait a bit more time for getting ACK */
 			if (ret == -ETIME) {
 				--timeout;
@@ -1870,7 +1872,7 @@ static int aldebaran_mode2_reset(struct smu_context *smu)
 	if (ret == 1)
 		ret = 0;
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e5996162fd5c..b941ab24f823 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2244,18 +2244,21 @@ int smu_v13_0_baco_exit(struct smu_context *smu)
 
 int smu_v13_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	uint16_t index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
 						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_EnableGfxImu);
-	return smu_cmn_send_msg_without_waiting(smu, index,
-						ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_unlock(&ctl->lock);
+
+	return ret;
 }
 
 int smu_v13_0_od_edit_dpm_table(struct smu_context *smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a9789f3a23b0..cf011fc3bb61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2897,24 +2897,22 @@ static void smu_v13_0_6_restore_pci_config(struct smu_context *smu)
 
 static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 {
-	int ret = 0, index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
 	int timeout = 10;
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_GfxDeviceDriverReset);
-	if (index < 0)
-		return index;
-
-	mutex_lock(&smu->message_lock);
+	mutex_lock(&ctl->lock);
 
-	ret = smu_cmn_send_msg_without_waiting(smu, (uint16_t)index,
-					       SMU_RESET_MODE_2);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_GfxDeviceDriverReset,
+					SMU_RESET_MODE_2);
+	if (ret)
+		goto out;
 
 	/* Reset takes a bit longer, wait for 200ms. */
 	msleep(200);
 
-	dev_dbg(smu->adev->dev, "restore config space...\n");
+	dev_dbg(adev->dev, "restore config space...\n");
 	/* Restore the config space saved during init */
 	amdgpu_device_load_pci_state(adev->pdev);
 
@@ -2932,9 +2930,9 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	if (!(adev->flags & AMD_IS_APU))
 		smu_v13_0_6_restore_pci_config(smu);
 
-	dev_dbg(smu->adev->dev, "wait for reset ack\n");
+	dev_dbg(adev->dev, "wait for reset ack\n");
 	do {
-		ret = smu_cmn_wait_for_response(smu);
+		ret = smu_msg_wait_response(ctl, 0);
 		/* Wait a bit more time for getting ACK */
 		if (ret == -ETIME) {
 			--timeout;
@@ -2948,7 +2946,7 @@ static int smu_v13_0_6_mode2_reset(struct smu_context *smu)
 	} while (ret == -ETIME && timeout);
 
 out:
-	mutex_unlock(&smu->message_lock);
+	mutex_unlock(&ctl->lock);
 
 	if (ret)
 		dev_err(adev->dev, "failed to send mode2 reset, error code %d",
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 8f7f293de3d8..f85ba23f9d99 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1834,17 +1834,21 @@ int smu_v14_0_baco_exit(struct smu_context *smu)
 
 int smu_v14_0_set_gfx_power_up_by_imu(struct smu_context *smu)
 {
-	uint16_t index;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
 	struct amdgpu_device *adev = smu->adev;
+	int ret;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_EnableGfxImu,
 						       ENABLE_IMU_ARG_GFXOFF_ENABLE, NULL);
 	}
 
-	index = smu_cmn_to_asic_specific_index(smu, CMN2ASIC_MAPPING_MSG,
-					       SMU_MSG_EnableGfxImu);
-	return smu_cmn_send_msg_without_waiting(smu, index, ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_lock(&ctl->lock);
+	ret = smu_msg_send_async_locked(ctl, SMU_MSG_EnableGfxImu,
+					ENABLE_IMU_ARG_GFXOFF_ENABLE);
+	mutex_unlock(&ctl->lock);
+
+	return ret;
 }
 
 int smu_v14_0_set_default_dpm_tables(struct smu_context *smu)
-- 
2.49.0

