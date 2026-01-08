Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADE6D148A0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A0EE10E67B;
	Thu,  8 Jan 2026 04:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t0FYWXbP";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011009.outbound.protection.outlook.com
 [40.93.194.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FCBC10E678
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCTxq0zrLU4sTFGvPPQdezyXaQkBiHmG16wzW7HfSor6uY+Qww+LXaScm/8g3wn56tR99jqcTEMPqBHHphCwXji9kcvm/+lYrzbfvq1CW9TKNVC+9d5tVkF1gUbqwsRxACCNBg7uf/nL8/gdkB8mGEKeHvYjyPENU2SxZOxXvgsveTx7H6pOqkFz2Jp+4NERwHUcVvHmTjnppqFbjb+B458R7X7SMLs+vflA9FJph9i2F2xLIdvSDKKkFBbA5tJtoENO9NGZxP4pmSIPRvcyfDZslimdkZ8W/xs60ZK47nWeg0bAYQLUlEiF6xTcUOPNNSCoIyYL3B+PzgExtkyivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEmblDVj5sO7ZnusVYKhjG0fiAxl+kiHLqDKYBZBzWM=;
 b=DkAIYUgRgfg6UDEk2DxbehOej0EEvI4G2EOxHhh/8mYl0Veoo+gpdkKjD72uWIsc32YuxyHr9u3uBh0AAPpBYiLqM/7+0MNr/vFIFQ1onKGSA2irYP7xicZYSgj7PctPcGRHHxUd8Mo9/93m5E/3VJypf7ZMmQQcI3Pjb+OZGf+8pwiAv1+8227SfNlPUKkt+hRMerGzOtZguiw+Sa8qKz+8qNfYgAsR6Ny8jQn8574Sxj9M5EGUhWuDXpxS/3z+0+Oy0Zoqo9U0PpfeU+2yJSWYuQDdFm345m/5lu9VDW6rPKiz+P3JS0NZK4NcJFM6c+1uitpVgPmiKidWXudXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEmblDVj5sO7ZnusVYKhjG0fiAxl+kiHLqDKYBZBzWM=;
 b=t0FYWXbP+vdJsnQCD3NB5q0IZZ4YG78z26jOD40yzP0qG9QHqQwO0bdVE3ZfYb0hl+FDYmFj/4cdWZVUNzMnfLv7rb5S7jIXE9HCgb5Fcc1yzT4RUMRenWe+ZE7bmENHdqbMwpmcZ8of6HMYBSxsaV5wjvC0qo0lXdvOERVn3EM=
Received: from CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::27)
 by LV9PR12MB9832.namprd12.prod.outlook.com (2603:10b6:408:2f3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:19 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::95) by CH5P221CA0002.outlook.office365.com
 (2603:10b6:610:1f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:18 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:16 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 03/24] drm/amd/pm: Add message control for SMUv12
Date: Thu, 8 Jan 2026 10:17:19 +0530
Message-ID: <20260108044839.4084279-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|LV9PR12MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: bc9e8d93-7198-4fff-fa5a-08de4e714894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AclUdfEMA+ULCRp33ancDHkRtO/NVk+fUC+bCI0vMESuna3Tb3X2ducMgsun?=
 =?us-ascii?Q?+CSSD0ZyWbYbN1n3ER3Ay5lr/r0dza53sAOmoVqBS+/pzHPcJooEkDCrIv+q?=
 =?us-ascii?Q?HKS0tIfor8epOUSRTwexMjOzr1qvIr6C20wo6ihDo/iTwlSz6ZJmPy8DjN/6?=
 =?us-ascii?Q?nfWXRwLL/f7HYrvqvY2NFoaq3QvKPkEg3pK6rpRJJ8PaUKSMspreut19yZAH?=
 =?us-ascii?Q?8dTF8hE0+NGWWkcDO+1G7pKzhi4ueuHIZDIp7rxbRQMorrUnEuvtisVC0cRx?=
 =?us-ascii?Q?TLNd5wOUH6BA3+q3/owSgU/mF16U5qgStjKhGkmhcRw6aMwnZXCvO8bUt18f?=
 =?us-ascii?Q?d2TCM1QiET+D4phG9/OUmqRKNuzbwRN+SPgDfC3mZjdTxXC5zNqzC1zhqAw0?=
 =?us-ascii?Q?6WGtoe8U+Jwu9zO51xnEhHKl+TO5mYB030ZNlbOwykK8SrPSgYgCXxUabrMT?=
 =?us-ascii?Q?jv3XvdO8ePHnkeZhiFRd95IzPTEMEiThqW1kKZFKAQ7oMfGqvGJbMjxSt4cp?=
 =?us-ascii?Q?Vy0a6tYqZs68Vby0IIdkw9KkNbOstYkic81wR8FFZK9IxBy2yPsaRvpW6Qvo?=
 =?us-ascii?Q?VxM2rL0YG2Z3FZyZNAcfp0omWhPokw1igNm1nIGL9a32QZPUZnTk9pOJ/+PZ?=
 =?us-ascii?Q?SBdfqGWMXaIozcR4ix3QSuwsq9kyg8D/zcMQuPhgulmJXfCUetKSoF1FBo8K?=
 =?us-ascii?Q?UunzGBTyzQr3jisX4D2cWklxyPeOidSopNql8h/O3JonjMPUrqfCT9tEMmb/?=
 =?us-ascii?Q?xFCz7j1XgFKCVsgVv536GesHdo0RvphReLdL0Xtj3H+bbo8f281LXmv1dbTK?=
 =?us-ascii?Q?hb7mGwsQBHlYmXDESqB/S8d7LheLitDDBiVSCuPPWBJYQOrLyyQ9mfFnuvNB?=
 =?us-ascii?Q?ASgzp/bgZQRi9WDUknQ4RGiQaJyq2JbQ08Fz5JMb9LUNHOevAbxj9uT3W80/?=
 =?us-ascii?Q?N8QO+rx19jvTNd1f4SwLBxYb9P8vPXaFc+VX30JV69n8o8OX5r7EBD4PRqia?=
 =?us-ascii?Q?7taHaVC3tJRA6X2t+Wg+/geoCILagOyALnq+SGq+dlp8Q/E0eKJ4DNX6fGHp?=
 =?us-ascii?Q?SPGQgFxlJ/KuvtI6UXz1vQZr83N9fzUqiHQYuFRK0fo8kl8Fxr4Bc+R6liym?=
 =?us-ascii?Q?/Nc5/Nu9Qv2cloFdHTT4a+ezlbFO+wCmbIP2TcSe0wrT4px8xQxdqxtokYyq?=
 =?us-ascii?Q?+38nzyYTROKVGRhvU49qGqumsAGMjDc3aDfiMxkjqQBWbCt7f1ZzEX05LR+2?=
 =?us-ascii?Q?GY0+wJp4MAbfZgd+U/Cc9Wu1Yhw13vyP2/0ojmeiywLgFiX8LWFbjVIZjTLB?=
 =?us-ascii?Q?Wc73kRKWhpa6ViMEwidt2sHe30Ki3UXLefsIyRO67n1YR9secKAQs5uDZw3b?=
 =?us-ascii?Q?QAVJQ0vo/izwGkyAYvaGXX1e1cE8ugIyD5KgPCwvEG8g7RIzKU32nuGkZJHU?=
 =?us-ascii?Q?VMXqMCZv8OTfXDR023MMv9LrYcnVIXyOzRgX3oPz36rKUmLbEQmOfIrJ/M26?=
 =?us-ascii?Q?++4GctavBnyECPyl8fAjIksu9RuGSN7Kchk0WkFuPs+Vjkt0X1RM4a2PD7pi?=
 =?us-ascii?Q?uIxZ4ahLn/DG6pigWzg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:18.8394 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9e8d93-7198-4fff-fa5a-08de4e714894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9832
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

Initialize smu message control in SMUv12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h    |  3 +++
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c  | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
index 0886d8cffbd0..fd3937b08662 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v12_0.h
@@ -62,5 +62,8 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
 int smu_v12_0_get_vbios_bootup_values(struct smu_context *smu);
 
+void smu_v12_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index c72ddef3fce5..7e41991f140e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -1507,4 +1507,5 @@ void renoir_set_ppt_funcs(struct smu_context *smu)
 	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
 	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	smu_v12_0_init_msg_ctl(smu, renoir_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index 942bc3b0f700..2c20624caca4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -405,3 +405,20 @@ int smu_v12_0_get_vbios_bootup_values(struct smu_context *smu)
 
 	return 0;
 }
+
+void smu_v12_0_init_msg_ctl(struct smu_context *smu,
+			    const struct cmn2asic_msg_mapping *message_map)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = message_map;
+}
-- 
2.49.0

