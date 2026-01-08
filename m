Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05AF8D1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D3DF10E679;
	Thu,  8 Jan 2026 04:49:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zRpsD1NY";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010063.outbound.protection.outlook.com
 [40.93.198.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EFA10E67D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6WMdqHwMx/ezhGy/OxfxAyyenYHM4zQ74WoAxYV+yf5afaYJvJgvqxxH8TznOkBFQC0Fy1l/wxCkxsFFE9JLOF25u8mfWu5adkpwI1ZE8YymBWpqqoVrE7YqUVvn2sgcup6FgM9Gf+0W90E9jmviDNkJy3+0YUq1I1kQRd4V6xwkO51gncivWhsO/G/Y//8A4sMFKn9wl6hBmSTRbv7jBSo/Y4XDjNhYLRF5aMAg6frDO3ZAXVEs7SWVHieuG6fPIQURthw4ZEkYEsSJLvXCSqtDs5guM5l4zGjsFuMVhnvl/uL6DMf1G3FkilzwlgWSZDJr0D7dRsoC92AUshzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0BcX+2PFwHCP2QIttamxIur+g5B5TUmm2AehLOXI0o=;
 b=bOTzmEgwyeQ5dZpl60l7atxYaZVOehkvBtxyjZ2ZNNcEqoiI5NaGGjx0XSUVE6cOM7no5XFUmHlx7QNV5wAQr7QbgkjYdP8FzyKPZVToNkhpH0Bmp526tRdthZ9WZMiRv4HeKyGnVXiy+7vYFOU2qiRoj7fUL/g8N0vwau4feuCWh1R591WX9UkPT6PwtfURBncEVEXK60eEvOlIb1DH5wQxzDzX5SHJxcwuPv0D1dLtcUMQrBSANGtXJ6qNweGqhndCzhe3DQ7c0q+EX+DJNvTHTPGOF+jLFnnhQtplb0PTYBb8D3lHH19aCE9XP3wjCBCAIcJ53R/DUISoj5k6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0BcX+2PFwHCP2QIttamxIur+g5B5TUmm2AehLOXI0o=;
 b=zRpsD1NYELHV0Z+fbfaLZbYuSgews76lv734N7BRzURpuNbeA1KFHHVL6XJureALdZuSa2Gbn1pF6WYTQvzgqwEgnfet3F7stR+6WD9gxIOgvgVRfa5ixu3W03YhXO9rUvd1TBlwKngD1UEHYxv4RZzheAPagmaNB5SxMfNUF3o=
Received: from CH0PR03CA0303.namprd03.prod.outlook.com (2603:10b6:610:118::16)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:49:24 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::a9) by CH0PR03CA0303.outlook.office365.com
 (2603:10b6:610:118::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:23 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:21 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 05/24] drm/amd/pm: Add message control for SMUv14
Date: Thu, 8 Jan 2026 10:17:21 +0530
Message-ID: <20260108044839.4084279-6-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: b33ec718-3c3c-4fa6-91e0-08de4e714b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cj/dbxCzsJtGnWQeHdFTjfhzRtdo8u9hWk+Ydqo5hfqEDSLV3tmFoHdQhr2E?=
 =?us-ascii?Q?pvj42M+HpQtNxj8G+6FWv+tSMA/VdEGZKkOgNoz4TaljWU7aHWv7ehZFw38H?=
 =?us-ascii?Q?7wdkTWt+fGUWnQFhUsEZyRk2wTpDYM7lENafNo4CfyRUB4rywM0aIPIrfnfc?=
 =?us-ascii?Q?fmQYYYgeeapjw68iEcVlpF+P2UzG6/aLYTZzzomLG254VBckJMwjUQeooN1v?=
 =?us-ascii?Q?DPs45CJBbmyZ/JBTbWQapiY1eQAZpbIkCC/1xyweEYlNn6EzVe+AMR2U6Kjs?=
 =?us-ascii?Q?ccAMHoFoBVH7rJ4UmqLj5jeP2xBAS+IBlNc9gXaJrRzHQ9GroaHDxIC+5bGO?=
 =?us-ascii?Q?GcnavakJxdHlTiNlhhbX7Vf3L0NuvStCjHZsjZrzN9D97vI5HW2MKTIwYbd0?=
 =?us-ascii?Q?TZ2OsH5ziYPCDJ/CtXKc6WiSA4XFNE4DpzRNQV+WhkcjUxm3HL+rdcJuue+2?=
 =?us-ascii?Q?sEzx1WG1HxpjZggaiN4Y8Dxig1Xl2hYGSHbaJ5tNkYP2FN3IxpNi1v0LLcl4?=
 =?us-ascii?Q?fLXActRNdrrEq74Gjy60IVTwdndHzg8DBCci2hocHBwhpXINj9XW+7j8NFp9?=
 =?us-ascii?Q?6lWdPsjzANTVPZyQBnyk/6FMTCdi8Bts6dKEz4ra5DKf91Hlt/md7bpWhuGW?=
 =?us-ascii?Q?h+xhR9ixRVqKZ2OmkuUNCNFvo5CvnEudLzTqlBAhlzGMR7TyqTaCaZbRxG8n?=
 =?us-ascii?Q?lTC4w474DdSmvXW/rubm6wb07dkW2R5xH7QOg6dHNWqK5w9YZI4SppTYeXna?=
 =?us-ascii?Q?zCnY4A7NFXn17qE4xRg2ydKqP6xsmVDRzylg7Cas/I4pjn9gQmyIsU1apOth?=
 =?us-ascii?Q?7xcbMmOW40N8S52JheJZySAHi5eOhywHcB8frcx51qaqSvyWMetpiQ1noSKX?=
 =?us-ascii?Q?woeOtkzQ7YTwCXdvgnpTVHG4+IsisKIQoteZfVs2Oq5qfT2x/B+tsv9ogOMD?=
 =?us-ascii?Q?+3gNzkAgo9ZWMSwAMR7oCeG7t+ayGarMcBkOIELCf3C4cHizemwX38VCOqfC?=
 =?us-ascii?Q?aA3fWsm4lVJ+2tfY1zz6927GEdHP38E20wWsnai06szfH+cCs99bui+i4/RZ?=
 =?us-ascii?Q?VUB0wCKQBHwPzaiB0H7b52x+unpunl4ti+RHCipKbzn+9xBavwMeO26IMhHc?=
 =?us-ascii?Q?sVCY9FhdZU8+yuAB41VJ5avzVQ9Fy1LPy6gpNt4BfYYD5zxE59n1ZUHZPC08?=
 =?us-ascii?Q?PAVbYlGbmRwxcSZRMPi6LoEOwdLMSvDGDrcJ9uzCcc34T3yLeh2QvYkv2fJ8?=
 =?us-ascii?Q?b5lixUXZMAywq+mocQiWRQ39zNVQBF57eGXtwHk8heYGLGVUIyyB2ToaQyfO?=
 =?us-ascii?Q?zI9mqi1/YlgDG/cNBYAI1TDWf1TC3qD1ueNx0AgHmGIxaqmEQ+GT968sIewf?=
 =?us-ascii?Q?hi42zZMTT1iOQkm+0rGbbOU5W0Ie8ChNyw92gD9VMt6cfo/pvBeDS1qzutPF?=
 =?us-ascii?Q?y804KlFTTInFA9zmUVAmA3QG3k4FyRLl1Bs8guPHl83wY1ZR5hRmeN2jkaIr?=
 =?us-ascii?Q?u3hEX3AZL5/iOaAqx9BoqaaqOO/yUHouJAfxYs9nIezkRA+uEjXBQEfe5bTJ?=
 =?us-ascii?Q?jM4ZqBlV54Ob6Vl0ONI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:23.6789 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33ec718-3c3c-4fa6-91e0-08de4e714b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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

Initialize smu message control in SMUv14 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c    | 17 +++++++++++++++++
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c    | 17 +++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index ba895ca4f3e6..9c15fccac2b8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1740,6 +1740,22 @@ static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 }
 
+static void smu_v14_0_0_init_msg_ctl(struct smu_context *smu)
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
+	ctl->message_map = smu_v14_0_0_message_map;
+}
+
 void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 {
 
@@ -1750,4 +1766,5 @@ void smu_v14_0_0_set_ppt_funcs(struct smu_context *smu)
 	smu->is_apu = true;
 
 	smu_v14_0_0_set_smu_mailbox_registers(smu);
+	smu_v14_0_0_init_msg_ctl(smu);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index b1fee26d989a..5bf10555effd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2120,6 +2120,22 @@ static void smu_v14_0_2_set_smu_mailbox_registers(struct smu_context *smu)
 	smu->debug_resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_54);
 }
 
+static void smu_v14_0_2_init_msg_ctl(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	struct smu_msg_ctl *ctl = &smu->msg_ctl;
+
+	ctl->smu = smu;
+	mutex_init(&ctl->lock);
+	ctl->config.msg_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_66);
+	ctl->config.resp_reg = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_90);
+	ctl->config.arg_regs[0] = SOC15_REG_OFFSET(MP1, 0, regMP1_SMN_C2PMSG_82);
+	ctl->config.num_arg_regs = 1;
+	ctl->ops = &smu_msg_v1_ops;
+	ctl->default_timeout = adev->usec_timeout * 20;
+	ctl->message_map = smu_v14_0_2_message_map;
+}
+
 static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					   void **table)
 {
@@ -2866,4 +2882,5 @@ void smu_v14_0_2_set_ppt_funcs(struct smu_context *smu)
 	smu->pwr_src_map = smu_v14_0_2_pwr_src_map;
 	smu->workload_map = smu_v14_0_2_workload_map;
 	smu_v14_0_2_set_smu_mailbox_registers(smu);
+	smu_v14_0_2_init_msg_ctl(smu);
 }
-- 
2.49.0

