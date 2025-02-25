Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2777CC021B8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2025 06:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA42710E57F;
	Tue, 25 Feb 2025 06:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mGQUH/uE";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02AC510E579
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Feb 2025 06:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHY2Cx1506pH954rLsgDvLtqikM9hHZf8Sc3CbdwyxE34ffcD6AT+t9rqKIexTD0qYvDcjRl0ztt2/J0BKks/eQUkWJvkjq+/SepjCY6dG0D4sBA92u94HRpVxIboc/4EXStSKNErXx4TYMADElr/CcLKmmHIIJxHLrxqZDWZ+04tIrYjwNDivZ5xjW1JtUfuMpv4q2zpJpHhrNZlTlunmvMK3cEqoDQdF/CuT2m6dfZk9Y/9WIHceqRv3kNn0z1w8HMKLOQS6gAAXeWBH0mBHScvDc/u8G/5Ia6KbRV4rZA2Vn9V5SofXWATqbW4ByuivzKI3RWq98WCgf4ndjVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2e1RZP2OiEqvGFS0Er8CWHHihKHPf6eOY9LmDtVQB0=;
 b=AGGqA/ajRrivn37Xd0f9ZEBL9aWSaBM62JeIit7yXOVTKPKgEXQRpA4frW92xEdNRuQsAt3CMvY3H3rVf81JmsTy8Vp4Q1ZYsGZWO/sbBUXcJ7K+oLI3ceMAoCylop1XZ4nLf1u2qYj7pPetJIRuHUO1v+fbdsB8rHYJIZ2bR8E3eIBODOy60BSuyqUSjTjhLf1Sg9+Ts+lQox+/hFvKgN21WI52TWOLfYu/GMb1suSA2bW2oQLYbuEHSG0KNCd7CxnoYV6itxIejWqjwcdHIGsMqm+nxD4JgM9OqmBgag6X/dREn0MDGbBPvABVjOu+/EzXNeDiKQSBw1fw7qa4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2e1RZP2OiEqvGFS0Er8CWHHihKHPf6eOY9LmDtVQB0=;
 b=mGQUH/uEcAuRrz9dupUH3LO+MiaHB2D06OoUgusLTvOnE2My9A+GCL6KQPHXTR9qyVylFi7VOhAS4XvIgnDCq96CkhelNJ6J7UcN31Fid8rm729KHvd9nw9XCQjImaK9Hl44CjGDfWxztGt8BcrlSQAduiRI4dD1CI3ah2NVmTQ=
Received: from MW3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:303:2b::11)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 06:46:00 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:2b:cafe::d4) by MW3PR05CA0006.outlook.office365.com
 (2603:10b6:303:2b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.15 via Frontend Transport; Tue,
 25 Feb 2025 06:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 06:45:59 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Feb
 2025 00:45:57 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Jonathan.Kim@amd.com>
Subject: [PATCH v3 4/4] drm/amdgpu: Calculate IP specific xgmi bandwidth
Date: Tue, 25 Feb 2025 12:15:36 +0530
Message-ID: <20250225064536.118278-4-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250225064536.118278-1-lijo.lazar@amd.com>
References: <20250225064536.118278-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c089b-6778-47a1-1e1e-08dd556810b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?piuLh4/0jWgkW9/pDsHdIVpP7Es7qafPKXkXvgcWtvI7FBS1QPwpx18oofwz?=
 =?us-ascii?Q?gOr8zMcVy3Oz/S4+TGVC3ON+nkKFLEELIC6by6AC21MV3ozy2+0WYNLqQ24X?=
 =?us-ascii?Q?3F/8I9aU76eSwQc7UexmxfI5YccprmM2kioja792qrdj71qkM987remkRpBd?=
 =?us-ascii?Q?dDrMBEFEEO9yvGPD2+G4DUpRBRpsVGHRjUAy5cqwuT3ED/EzZnVCuXGnjzCA?=
 =?us-ascii?Q?Cs62SySc695GT7C8uRgh5H2iSpavleb/Lzo7LWVhOvcZZI9A/HKvbbtLHB2a?=
 =?us-ascii?Q?9zbrYrCO3TrRjRZuSdEEBZuSK8FqW3njF77Y0pJruJJZdfL7bVbE2FbDHpjH?=
 =?us-ascii?Q?Mnwhy0MkagZ+3Q1hmcAGkXQUz8KzvRq+KIpZPpQHeV1U3C7AFsfVaua9gMy3?=
 =?us-ascii?Q?UWWBMrB0rj4YxbSpyS/bNbzmWK8rV0ovQqMiFgFIyS23uc3xVQBqp4xeCwYD?=
 =?us-ascii?Q?H6I4P051Teyr5feK1cmzrBqLnqelz7RXkBT7HGQRTVMN9NBlTUltUDt/4qT8?=
 =?us-ascii?Q?5TRfYbopIwnZWYSGFAWarDBe77hL5qawUKTt+dXprA/DTl+wxMqr19MPs2qh?=
 =?us-ascii?Q?l7K/I0euxuUfxnWOo3/Sq5wxOfiKyth0lwfFiKufr7gL63RNy5E+9SszU26s?=
 =?us-ascii?Q?r5FfRLp4cpNagEOGlTo+dCpWxZluD8lh6sGDGdIj1s1vlaqCQLaDzuTOeEpn?=
 =?us-ascii?Q?OSfhMRf62c4hh31ihspTrjLRQ8OHgtLalfcAC7nhUH0s+SF3G8HdEeYUBgZX?=
 =?us-ascii?Q?8a3TEAgIDEjkQlcuW6Zffm3z0jTXr8VwELbzL/Sn1M6uDCx4YaXIhMVe7Tel?=
 =?us-ascii?Q?7sMXZ6WNIgBcDKkLZCG3FGH8lCy6xE5hdc92YOG56J6Hjuaf0+xMCsMdwYnZ?=
 =?us-ascii?Q?D0RQXp/FTs5honR6NzVkUzLTv/h8kd52MIAFAU1yqR2o2oPJJqEzAFmUN7Lg?=
 =?us-ascii?Q?znZc9DjfJq8EeLhJ2qUGmayAx4Js1WQAPL1QNc8JD6OdNglUiRhSfbJGtIqj?=
 =?us-ascii?Q?R+PixT/obX0csn0DyTzRUYxvJ3Y8ee07/t7WE0X4vHQ6W2tflzonxMtOpDL6?=
 =?us-ascii?Q?5FZmLOARm8FxIFPnbiV+huFjeFG+O88BFh/4MM9lM+afPmNhd5dtOqMRar5L?=
 =?us-ascii?Q?odr+dJRK5DrFbV9W9vdRtICDBeiqqexqDwrUp5Mg8NB4ceJ0VLrV1cy6AjpB?=
 =?us-ascii?Q?cxiet6Ms+pxaKH+JEUxBHjiAPzBatAq1nD+aNYWWnEF9qOgKFhD03wGYJXqV?=
 =?us-ascii?Q?/H2z2WKovzJWoKQ8q9kWF0klO2yhDZdxuaKMhykP1BxFKKXdjurihelf2FCp?=
 =?us-ascii?Q?aSmHWnLImcsb5IO9XvyF2tjKW25odFTODs6ErpTGwSdg/9u29ifqDSoFSKVp?=
 =?us-ascii?Q?/PMhnc8ZU95uwlVt+47qaPS2rGwbsFyvnuy8MUnCsqcV7zkehSWbJ8wi1xTl?=
 =?us-ascii?Q?LuW8imVtZCxZtW3Py9Tto1l+Ggkt1/DZIPuAGzhX4kYCMrQ4V/xxOXRNP26l?=
 =?us-ascii?Q?oQpS0Uj8IZk9DIE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 06:45:59.9984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c089b-6778-47a1-1e1e-08dd556810b2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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

Use IP version specific xgmi speed/width for bandwidth calculation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
v2:
      Move XGMI info init to early init phase (Jon)
v3:
      Rebase on top of drm/amdgpu: simplify xgmi peer info calls 

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b2e9e116be44..df7cb692d8c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2757,6 +2757,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	if (adev->gmc.xgmi.supported)
+		amdgpu_xgmi_early_init(adev);
+
 	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_GFX);
 	if (ip_block->status.valid != false)
 		amdgpu_amdkfd_device_probe(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 45566c320615..0cc42a43408e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -843,7 +843,9 @@ int amdgpu_xgmi_get_bandwidth(struct amdgpu_device *adev, struct amdgpu_device *
 {
 	bool peer_mode = bw_mode == AMDGPU_XGMI_BW_MODE_PER_PEER;
 	int unit_scale = bw_unit == AMDGPU_XGMI_BW_UNIT_MBYTES ? 1000 : 1;
-	int speed = 25, num_lanes = 16, num_links = !peer_mode ? 1 : -1;
+	int num_lanes = adev->gmc.xgmi.max_width;
+	int speed = adev->gmc.xgmi.max_speed;
+	int num_links = !peer_mode ? 1 : -1;
 
 	if (!(min_bw && max_bw))
 		return -EINVAL;
-- 
2.25.1

