Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08002D41D74
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 09:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8032D10E254;
	Mon, 15 Dec 2025 09:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QqVCcHYV";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17A1910E254
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 09:57:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvTooj237A4zikdjafdirQdywrsZp6D3JyAncs0Wn8Y+9g1M4hzsvw+nTeNp52j3xzyNs5/KnA4RDdNzxaSo4JJ8ezXeFsK6rrVuYnfxp2w9uy+TTGjR51BZn+qUMipwhSNw6XEy4ofyOgVlgBEzmyp6PxlXzdK+vPtyEvQORF13BOkAaEOCmPEaxwJotAe1f5Qr5xN9RBvQFpqyEwnIqI8Acb1NnsmGkLQex55E3M5R3XbXFzgBLEysfcKNFRrVVctGSExkZ1qAe1owI/Uhu/HyKAbnwbKOWh/rjdKcr/fT6VR6M2g3B9enXTAC2x+oKpsP5wQiWDgOX3xWzOL73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUY7Uv2psPyxw5VNLxQZpxV6Um9/T6RMsUIu2D6p5wo=;
 b=MQKYOQXTV9bNOe75LNGDt2LnrUyL7d+g8q6bjRA9SSD05oOubdyTA2RRAyvlLspHReUUHeTd82y0HQMh+9vPuEdrySLXQLJ8wHlTSv1oFWdA3OY1iWgBRuVLZ0pS+P6nMeejBEPuhSB9oSSB8BgVei9iMZgRXTZAyvN606Fc+LJBTpcfHziMb4CUWxMaoC5sFBMAdyXI2xWnKcPHs82JTH1ncaUL9P4kYUL+OUDqEncQsm/by7osD498Vp4k7kbsMNIjI57RNoIJmJdBuA2eskWRVya/MfybemozNd92/jfY6rXqwpU4+OLpJvTzPz/fOvAIUttB6IxCnXL1pOHq4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUY7Uv2psPyxw5VNLxQZpxV6Um9/T6RMsUIu2D6p5wo=;
 b=QqVCcHYVrbsGmvTbXSdHcEEUNxvP1CGoT4FcCpHiwYKq0BoBYGN/43udHonzgSNq383LIggCm56COIs+VVjDC0itfueg3Yl6emQ4sBXjdP5JilHo0/FywVpIHguXQsff1l16p+7KJmFhsTf/Yqn4k9vA/93sbok5iX1+zL/u7DQ=
Received: from MN2PR06CA0026.namprd06.prod.outlook.com (2603:10b6:208:23d::31)
 by SJ2PR12MB9086.namprd12.prod.outlook.com (2603:10b6:a03:55f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 09:57:47 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::b4) by MN2PR06CA0026.outlook.office365.com
 (2603:10b6:208:23d::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 09:57:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 09:57:46 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 03:57:45 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: fix wrong pcie parameter on navi1x
Date: Mon, 15 Dec 2025 17:57:34 +0800
Message-ID: <20251215095735.977069-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|SJ2PR12MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: c06e5131-2313-4458-a665-08de3bc0663f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FEQo8k8S8Af9liMLQoocvDueCY3HZvUQnbr+iJxzBYcRM9dWWemkJcbZiB3S?=
 =?us-ascii?Q?NHD3GJNeqh/eAhYAX1lxa2JpNH9AR6FDyXcaqDqSOgDIDnkMGWs0uhSuZmMp?=
 =?us-ascii?Q?XgRMOQ+EShMlyKh16MSX4m5J/LKwMOIRj7TVv1VXPFA5bPQ2CQ5b0IbYg1Kl?=
 =?us-ascii?Q?R+QI2PRhDNqDit+0mT5+Hyp/FaMtpiKJxXvPxAyPMCTB82JH8B7vSk1zkBUN?=
 =?us-ascii?Q?uXE40QjcoZTSj3vKkemgUbTXaQRCObSmzXzzUR+LcKMOLJtVy13S4e6JDIe0?=
 =?us-ascii?Q?/UMSDRBShxepvvFQOpKU4i+6cEC9BU22Rz9PtVoT3iYwoE+9LYMlcDttNs84?=
 =?us-ascii?Q?c9q5l4ANY/4IS6lT/A0wZVxhI54TUjS3PtbTdXIEXXK/eqN/Wf8e6e+cRr/k?=
 =?us-ascii?Q?DB6K0zMIhCZISVKDGqCzLD71TzDDjC/YnV8Ffp+51UdxrATVGYOWFTH7+Nu1?=
 =?us-ascii?Q?s1q01UV05ZneMMPyWZLxqqDxgchOmDlIMoofNtopxMdnVrtmqj+tcewE4jLw?=
 =?us-ascii?Q?tOMLB4opk0Jr7BTuyeazvs0HUhS0hZsa8NCT1YUaxIDKI6Jva+TgtAvJGSUb?=
 =?us-ascii?Q?MfO8QskpP2hTv0NOv5wZs/4Zr8ggiuDFxLEqNSUjX3Q+szhLeU2q9MnBjlnS?=
 =?us-ascii?Q?tc0eZrHiRQDTAFm/3LhjFjMpBPQcDg7ZakBx8QsVII1Dkq2THfFtrdHEeG0f?=
 =?us-ascii?Q?qcX8BBWVr394YzadvLwz52HBfR0oAzJKBlpe+IocRwg/qIKXVGo101Jtsl0o?=
 =?us-ascii?Q?V8+SFz3oXNLmQDEnnjNWtWSDbaZ5WDwcZU9rig6/LU1dWjo7LrInMv0/qFwP?=
 =?us-ascii?Q?+A8AUF8eIXrbPYjgPi1ICwBekUvqmNKJCWFeELQ830LdQFul5QAVV7DOb/Zy?=
 =?us-ascii?Q?dxe7O2A2fI6YiEYhbBnG7E3fIJj085ctZVHr/zgfXGAZNa5NbPmZG/F7NKa4?=
 =?us-ascii?Q?/joRYXFtFz9HMsfFI4y/OfuWRgK6gFOnxvqXwyaz3/Oa74rUmz6rBPEEpR65?=
 =?us-ascii?Q?QUTHlmBKDV64KnUuA5uHbPbcNHEDf84Ct8JMqPR2puiEmy/RDl6Lwucfbd1q?=
 =?us-ascii?Q?jXeS213rGp9BmJERa2wwAdPgSLBjZhbkfhF3P8NVZrRBKLGCfrD3nvSbKJ1B?=
 =?us-ascii?Q?WlWRSNH8oTqD3Bj4YNum5efDWASTnvO8qJObdEtIxbRdr0d3L8cOaQurS7Ta?=
 =?us-ascii?Q?s6ukRmqg+zsMOc9QienaBNbNRRdDNAFTtN6zL0q17lZl9eo5/zFRhi2xjrA3?=
 =?us-ascii?Q?YCwYXqoBW5CQMgR9dTV/lm7QDaOmLFaSd4UNecUQuNGY3fFm/pHep6CkVfwf?=
 =?us-ascii?Q?H4/lCNLVMrgS4rdp/uFstL5MF9Py3ff5oyu4AheRNMOV9W8+ZJWBHZ+g6cHD?=
 =?us-ascii?Q?rOL+BkbmvZv40DoAURfvq1Av5KzmmFJujG3JV303REwA7jZUiBI7mq+77gbx?=
 =?us-ascii?Q?t1Mk2C+BXZoTVMC8SZin+dvL7g2NAnxAqN/1aVnZqEajPMXqzcBpEPYXM0re?=
 =?us-ascii?Q?bdEShZlodTF/nIvN56i7Q3E0K8CH/qeFJ03dJqZL/85nt93vhhn/xHRns4Q1?=
 =?us-ascii?Q?txInRSF41BpHY4IbBOc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 09:57:46.7969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06e5131-2313-4458-a665-08de3bc0663f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9086
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

fix wrong pcie dpm parameter on navi1x

Fixes: 1a18607c07bb ("drm/amd/pm: override pcie dpm parameters only if it is necessary")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Co-developed-by: Kenneth Feng <kenneth.feng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 882830770b79..0c26fe6fb949 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2216,8 +2216,8 @@ static int navi10_update_pcie_parameters(struct smu_context *smu,
 									pptable->PcieLaneCount[i] > pcie_width_cap ?
 									pcie_width_cap : pptable->PcieLaneCount[i];
 			smu_pcie_arg = i << 16;
-			smu_pcie_arg |= pcie_gen_cap << 8;
-			smu_pcie_arg |= pcie_width_cap;
+			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_gen[i] << 8;
+			smu_pcie_arg |= dpm_context->dpm_tables.pcie_table.pcie_lane[i];
 			ret = smu_cmn_send_smc_msg_with_param(smu,
 							SMU_MSG_OverridePcieParameters,
 							smu_pcie_arg,
-- 
2.34.1

