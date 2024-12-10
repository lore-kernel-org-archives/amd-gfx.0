Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB733E7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 07:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C59010E800;
	Tue, 10 Dec 2024 07:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5l1XzNAf";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BA810E800
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 07:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G14MmMXQJgHWO11EUkw7b68gt6uqV49cnndCI4MtrYb66H2Vf9C1FC2eN4rWhiVlNmBCXrBk2gW5wb4GduAuYDNfbdya2pOoQ9ysZMfWUSx5/wiFQp9Nk1s0GFXQMdkHqNKjQAto7Y+PH4fxflWXA6wLcYF6s87M1kJ5RpVpYydfqsvik3vM3EU3/5QtG1A3/DJDHDvusu4fQfweuHWdZEe7ZYEoG98YnoN1GjptXXdjBzHrtf7LdGIbqkq6BSBIfAtpOeH18DDVNH4CN42FX72JeHupXbgo9psdy8gc0uKeReY2rvuRjWJlUoXSis7MqSr41eR0C33oC9zA0VRZNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvEs8VvExQ9bqNEgaRAqTu6AZVbmD5k23hYimpy6uLY=;
 b=XjnzrnSUIdgZpYFwJNn1Hl/LXlOJhXtqhYzPziPPeOtlKX3xfpK/6zQzKnGyBG1AXaUutyFuyiC39UPR42DhcYsfsMWWizpNHciV3zPJmfNSZNdwGHojqptjvUAxM3bBWX8aa6EGsvvFMTvu/+aLeFZa1N12t35FfKcAzK2J9eXTliCOtB6rv7ahqDCIaRKmR2rKs+rpnIqV1aOP/9RXSbAco4CzQuq069jt+ExwFYWxZWYEN5Q4Wntkg6x7oXLxMQpq7hLMBRfPI8Zg6K6LWsaMab3RdY1lO8jbIhWtktfNwvn9qdcZvSTon1MAUHT8m4OvyfwcaBslig3I01Zz1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvEs8VvExQ9bqNEgaRAqTu6AZVbmD5k23hYimpy6uLY=;
 b=5l1XzNAfHmnRA/MGxkQ5gqUWtdPJLUHq41/psleW/1BhMnVzIsPnsP8syfTb3DtuJy0PBLeweOgQFgQa4ZFJ8KzLCpCaHSgOjk62SODgov2y7uC+SuubNiC7zF2OXcwfOXaNWV9gae8YcVDkxEXZMMnVnSDxdK2kFgy0Z6Ds47k=
Received: from BN0PR07CA0014.namprd07.prod.outlook.com (2603:10b6:408:141::7)
 by SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 07:54:21 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::7c) by BN0PR07CA0014.outlook.office365.com
 (2603:10b6:408:141::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.20 via Frontend Transport; Tue,
 10 Dec 2024 07:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 07:54:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:54:20 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:54:20 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 10 Dec 2024 01:54:18 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 5/7 v2] drm/amdgpu/sdma7: Add queue reset sysfs for sdmav7
Date: Tue, 10 Dec 2024 15:54:18 +0800
Message-ID: <20241210075418.2183348-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 1979511c-89ea-49f4-76b7-08dd18efdb8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QRFJPXORtVvP1EQTJWHt5Xo4/tF+6PO7VnpkRAXxY1R7+vKPi5dBTdwoY0UI?=
 =?us-ascii?Q?qSmN14r/SAlj72lmys8P5Gc3ql07F8buysvp9veIuqV1/qj73ezH67aqDxIO?=
 =?us-ascii?Q?iWiAe4ffjb22qkkcAoNl2wxNhT205IvQ++SYh7AX5dU97+7wDi8XQzdufRnq?=
 =?us-ascii?Q?3PFvZ/bNVZvcZHer/TaLnRaTporRapytlvG9hCr1ZlwMB3E4Bx4w4+nGh4N4?=
 =?us-ascii?Q?dP6yCD9JveJFSxZatqbTY4RdjKjCXJFnB/Q+OJW3USs66i8qiJBlH6L9JH1m?=
 =?us-ascii?Q?UluefBTUeuZdEEFcq1RlOD4T1PwYdMSyEFsCd1m5T9ojug8qApU4eOxy1CYL?=
 =?us-ascii?Q?r5dKeFhrGPbGoQGSvwwDr2Xc6w9A9rE4cBEpFaK4URgiveFSW9adnCyJuqCH?=
 =?us-ascii?Q?vkyUT7FYEfLikzdF0UOG3JIS1cK4FswxBhbsxSQNRDirU2TxkTvsAlNIki4K?=
 =?us-ascii?Q?EQykYgdiEj9J8lVRLc1QHJgJ2gX5XMDsAUsbbw1jXgO38Mlbqwz799u4B7Ur?=
 =?us-ascii?Q?HxAoBzYGrUGf04eZa4gKdgW4VUTPQhNSmxBgi7N5Jvjoci1X5QjD6g6AxKwb?=
 =?us-ascii?Q?sIEsNofYBx8todbMYL6s4c8FG6s+qSpjqERCNU/R4ydF6lNbU9cj3Ht3KV/o?=
 =?us-ascii?Q?3eaEjkbvLKOccb9a4ozeRXMG4hSV+J8ech+80U6irtyZwbu6kjpcMGDFMyFo?=
 =?us-ascii?Q?b1f/zAF1aQgcWqfOOaxH7fwovgyEQPrDqxHcy1Vzz84qPIlKlrsqKuyBqWOd?=
 =?us-ascii?Q?ksgozcdF2N3vg7OGlaifDif9ggwLql6KyjD5jnG6JQsbAz+GPf2FAnNfkHxK?=
 =?us-ascii?Q?A1uGM+uArSEcxTrARF/REpA5ly54QigGB9yRr6sWGoJIJxbIL+kR2WnOYKXN?=
 =?us-ascii?Q?Zfc+Q5vMNo4nlMyauWK8seYib/R1uj5eK8THW3wVDkIt6ilnnY+VVAounXRW?=
 =?us-ascii?Q?gH6k5rXqiuCM4na+uuIK2c5/8ppK70r/GAStgeTxLD+LC5KdOklOYYNKtnhG?=
 =?us-ascii?Q?1fYYXtRC06xdD8pzpM30sqC8bKaloXqapDDraVeSEC6Gc1kyJdB9XsPV/4nC?=
 =?us-ascii?Q?QPu6X5cA2R2hXwACaBB2cLQIFJ0MwroncO8mbhP8R/xpzmv5BBe/S+MyQ0WN?=
 =?us-ascii?Q?uw1NUB77WKSnwM3lthgOyQJ/k7XaWutEhycVm1a4373bt251vEMf2dtH4IbW?=
 =?us-ascii?Q?ZODhtEwwwiWahte3d3L5dQkjpzZXFV0hiO15dKEdh+9Cbf3/V6wHfulE/S0m?=
 =?us-ascii?Q?S4pHpda9lTc83pOsGmuIgAFNqQLOyUpyzfFo+gr+iMbeGfn6Py4Jv94lihh6?=
 =?us-ascii?Q?vkocy1QnbxdjBXgZeWr0oft6y32E73x+oIgQMj9C0O6XkjPg0FqkKMUWXBuN?=
 =?us-ascii?Q?puCkHEidlmNIIoav6dpY4Wj3bYYLhQr9QYiIc9jsyAFRJ2cHTYRItRSFu9UF?=
 =?us-ascii?Q?q8tOfqg+4Ygr7bwwKEAI5SxsqGEe26El?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:54:21.5297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1979511c-89ea-49f4-76b7-08dd18efdb8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855
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

sdmv7 queue reset already supports by mmio, add its sys file.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 627e0173b64d..8e69b84e0165 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1368,6 +1368,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->sdma.supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+	adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1378,7 +1381,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 #endif
-
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 
 	return r;
 }
@@ -1391,6 +1396,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-- 
2.25.1

