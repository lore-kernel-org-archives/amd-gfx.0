Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A05C87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EBB10E522;
	Mon,  4 Aug 2025 14:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVIJ09QJ";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E13010E52F
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:18:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qul4i/zndsfIsXE7vwHWN0PpPehDFxpeMcaeFd0rVt6tbuSTnlmw/I21ffuftWLB8cAiW3iZXYXV5FywZGcDcZoku7PtwEV1Dt2Cgz1MuvrDAwspGmPClX3m1FixmZu/0OvA0eed7CuWCL0gVws5NKO6VFrDkGwEBKRpnvWF/axANN7c136pD2XmqmG4cPMo1kPJVLjfo+sAv3aufxuDbUaVlN8btDbSwXZu9ujmWJr2MPqJAwao41NzYzasjkF0HFaBFEBPADiAH1MExCA7CrRlTaxaHUbahMzsd6QQds6hK2trMutxqRoBijYFiGOVjyRVPyq0MR7wos/5SGGqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQhh2JqPWxsoNmZKtcF/IOUozhFzWR7hWAKLwCjsMMI=;
 b=kaJi3HP1kBpmSecuYPaso71QmkdGJzmziyroCWbF018lE01v52cb+FVOsBI+QJB7p+lXv/1S0u9ChJY9zkaydsLLf0QvZl80PE6p3ieI2a9gfmyM40HFO2XysCNgDaHEpASDE4922U/1OQ3Ga6SfcaVwJ7xWE3t5nqqJMyPQ8cAhClvBpqxiSJttQPNMS2rMxrLtMdiXvq/7cK9h8757sj5vS6aQr7wr5Uk1WWm6bdlv0sAuq1Kx1dAOoFVRvmXcB/XNGheez7fIuYjbMmJRwDHosN5RRMNujOI3rbVHOwexlB3oRjxQ/3+cVhdVsfCfCtAOqGCwq5YyCgHW7ZiuEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQhh2JqPWxsoNmZKtcF/IOUozhFzWR7hWAKLwCjsMMI=;
 b=nVIJ09QJhPVGzVTsR9WhfY8A9DHeyMusTzt5dyJ1F94YNnT52Bm6i5nGs+nRC/rNLP8/0AmLjbkbwQIh8HGy4qeTouLjmCoSbFqs0HZlTbPQS8SQCFIdDIpCJoGmgUQpdEAOp0OMCu16ghekjLPUNGi+1a+OQ8p7lm/m7UHutpI=
Received: from BN9PR03CA0433.namprd03.prod.outlook.com (2603:10b6:408:113::18)
 by DM6PR12MB4137.namprd12.prod.outlook.com (2603:10b6:5:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 14:18:23 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::20) by BN9PR03CA0433.outlook.office365.com
 (2603:10b6:408:113::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.20 via Frontend Transport; Mon,
 4 Aug 2025 14:18:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 14:18:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 09:18:20 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v3 6/6] drm/amd/pm: Enable temperature metrics caps
Date: Mon, 4 Aug 2025 22:17:57 +0800
Message-ID: <20250804141757.643501-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804141757.643501-1-asad.kamal@amd.com>
References: <20250804141757.643501-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|DM6PR12MB4137:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ee8f171-6e1e-4ff0-36e2-08ddd361c4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ht2XGOX6ybqKJjC9ngsfpWCKz6uhbrB16TQaOu32NtThrU8mL4bjfTXKP9DX?=
 =?us-ascii?Q?9zkrmP6CxOy+VGXPoRQD0hJ54ugFUWDtB8fxAIkASC3//izx5fvditkZmEju?=
 =?us-ascii?Q?i3BrOvK9m9PpkuJJPekKjSnxsq2hWrcjF86KFPBF01BCNULvMqOz/CrVdhWC?=
 =?us-ascii?Q?+aQKktRPbROmlce+Go2nDL+sEnKW47Ed5kJZ3N0sCEo3D85BFZZEz+WaxNOs?=
 =?us-ascii?Q?wkHZjNdgY6/PeEm/pjJbL6zem0fhuWwyVe4T8LlzdEXH2wnecB3FyLy7+QI7?=
 =?us-ascii?Q?9EV6nI5SFeSV9eii7Pb9WU0HmgodiYnOA1YCr8aCBctvdUqjQgI/ynmPwh5G?=
 =?us-ascii?Q?KvhgokznBRr/V79nLH6Mrse34qrE4k3ch5LvXV/wwyIgwmGZRac3kOpIl7mR?=
 =?us-ascii?Q?JdKiT/orMA3F1zb110eXXA6v5ZV0wtTqyd3bV6CBwYBZtMI9Irgx4eUvPgPW?=
 =?us-ascii?Q?C41fEUWDGHCOj+qgS0RKN315yUKdZK/3cflNzaGjBEIZBT5ndKPQk3v0Nu0J?=
 =?us-ascii?Q?4RxH+ua6pXRyuZPKqvthWFZk1JH4G1hFORPQdn5wveidOXGbJ/9ebb8Y7dI+?=
 =?us-ascii?Q?p84nnuRJCCQfdzGfJ16ZuaPMM9CmSCOC9EzWIrvollQdx0LNGsnO5kFDqa9q?=
 =?us-ascii?Q?3jH8WYixdlub3hW/SD3ACEH1UeSXuMP7JumkwmdLYLaCa1GxJdveSydIz2sT?=
 =?us-ascii?Q?hCveak26GRM7aGUwHwGHqx9WKtUu/EkvDyqqsxGylffBBjspSFJB8/rxFcan?=
 =?us-ascii?Q?1FZ83uT5t4WjHHDxrq0Yndr+AIVxgeCHt3tziolt8Pk2YmcEUfMiWPVRXLqv?=
 =?us-ascii?Q?oERq2UCZlsafTt2tPeG/yJxU154FFwtcKIHMXbcoLqqW8Klj3VJNIXFvxrVQ?=
 =?us-ascii?Q?uiercBIe5hFctwedLRdA8s0DryzmmGspkxhd+RFN3uwF4AOV0wpHaQikL1Qv?=
 =?us-ascii?Q?gqLe77gCjsukgLZI/65tWiSR4LHvFdkxPCfydaz+D2ZMw/bXG8c2eaZBnDV3?=
 =?us-ascii?Q?Sag69AtOLT3CCYSssLDAplooYofPuu+v00hYi30TZ0eUcmPpOFsFbqCEAbYR?=
 =?us-ascii?Q?dwkljV0zCjumMPezM3tKgquxs9RfbIyGXWRntXSBWD/NYshYu91Jw3KZoTLp?=
 =?us-ascii?Q?pTS4vsai3CXdPW7w6j1Au5Qy93feTabhKt7QTVmaI0XtQR3hwk8DzOpbVcYA?=
 =?us-ascii?Q?6YbVVJ7wMa7OTvFQNd6SjUdxqTZh/ixPVz7YQSR2z/VyGxQWvYTCbYZ2yLus?=
 =?us-ascii?Q?MCIe60VA99hAojJpPgpBbetasUZZ1kwU35byQF1DlABCm2iIowtmfw7CMb9u?=
 =?us-ascii?Q?jD4eVRv58r+YGPXc+1FIgpVaczA4Efyy5TJxz2+OJdwTWQeSu4YdoN6wM+ya?=
 =?us-ascii?Q?s7VkKRRMkEUzYLhp08Lyh2JZFtXv3m0nDPZZoH34QcGtlli5nnN8MtDfO0+f?=
 =?us-ascii?Q?0cq7Y5J+t+iBtJdY++f8rLxlIqlm/aEfLDIGSA4Pjg9aHH8BtwxgQa6GtiCf?=
 =?us-ascii?Q?O9WbP03DoRXlWkwOV6XToQB8aujEHNAcpsdm?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:18:22.6330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee8f171-6e1e-4ff0-36e2-08ddd361c4fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4137
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

Enable temperature metrics caps for smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index c777c0e4ea11..d6b49d958938 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -350,6 +350,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
 		smu_v13_0_6_cap_set(smu, SMU_CAP(PLDM_VERSION));
 	}
+
+	if (fw_ver >= 0x04560700) {
+		if (!amdgpu_sriov_vf(smu->adev))
+			smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_METRICS));
+	}
 }
 
 static void smu_v13_0_6_init_caps(struct smu_context *smu)
-- 
2.46.0

