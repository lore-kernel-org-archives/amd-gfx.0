Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CE0C61CE7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jun 2025 09:42:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF63F10E361;
	Wed, 11 Jun 2025 09:42:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3IavwSCp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F0710E361
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Jun 2025 09:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PhrIWI8WNvDzHG/fH/0hQwxwWXvoEPLa/d2IkH00tEIH48cv5sEcS6YiUcYecoo+Xchhp7BPBCoWxvzCKigIuxEVWGAB84pd+O8XnHbPyML/wKHGP1dztxWOkR6kmg0+EtV51JYO80tvTobI5B6p4bPBGSqxUuz/ScLvBfT1Nxg2gD6lgQsYYpIEQzSHRsAgg4GQz6veCnb9/8cCJNcELskDAR1SWN0egbzvrKpdknacQkxRO6hAO9nj5vHfwRT2e9bbbdP5iGcFCF5HTvet02265J3o/hwypY4/pKPCKPLCES0aQiFqPpLcqmMRNzLEGsmI9nMwIGtKkv8cPKHNWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHSF4JeftLNXeUrwvHkrwrUyd/k3EYIslC43/WNYKy4=;
 b=ywltv8XrlnJMl8MG6no2KoT4h/8veENr0bib1D9c4pltiyUR5RGm8GDAPQ8Vr3XIQdVqYIQU3oOjHlx8QuF6TiNvrqQsmVdYZAaOcWEU8KGU49e/1NGDuwQiF7FbXxdTJUBmEO11zzJW7npsLwOcaZbsr0J1DvLI4eDnmfvBfgyJFypNRzR6daw9Oq/Z8BPc5uA/yuq/AN/5hMbevJb1GXsGNPBaT6pZOBpR0NehBrw22qAJzRFdI9Fwi25Ulp6RucqGoPO4yayzJvVmy4SFpwt/FWKWlmtMMdzmoY6DGLJCVPjwhvl5rTbCEFElAV/MQVx1crisML2cZ97qiRK9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHSF4JeftLNXeUrwvHkrwrUyd/k3EYIslC43/WNYKy4=;
 b=3IavwSCpLzwFOTNexnxDhWMHDjatexUCRZyR4LADCYnOJO9Z7s5CeKtmvLficF174ftXgDw+VLH9oq9irLiLg9B7UkV2bHaTH1vRNnxV9ww2mPdeH8d2jRoYM/pSuIzvQDUvi2NPplYB1pMulzQDZ1NZKcmMBzcHI1jhw/S8K0o=
Received: from CH2PR18CA0023.namprd18.prod.outlook.com (2603:10b6:610:4f::33)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.42; Wed, 11 Jun
 2025 09:42:34 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::c4) by CH2PR18CA0023.outlook.office365.com
 (2603:10b6:610:4f::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.27 via Frontend Transport; Wed,
 11 Jun 2025 09:42:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Wed, 11 Jun 2025 09:42:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 04:42:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Jun
 2025 04:42:32 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 11 Jun 2025 04:42:26 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [v3 1/3] drm/amdgpu: Fix SDMA engine reset with logical instance ID
Date: Wed, 11 Jun 2025 17:42:18 +0800
Message-ID: <20250611094220.3376420-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: bc46fe26-6b47-4105-dba2-08dda8cc4a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fCsqdjSKCcAraBgQvYVxkSM8eS70TzI/pqwSNbhxBQ5LjUYbaIYdYwrZklWY?=
 =?us-ascii?Q?WYt9XVVJ6lYjvHQ2ved6H+BP0g3DhLx5RbYO+Spr7UeOnKTDv6yiJ2GrfPxy?=
 =?us-ascii?Q?/1rczttdnjwEwJd+2xDQa1WrXeAE5WiH5GL91Y3QBdIVy9Q/fpp5mafLsBbe?=
 =?us-ascii?Q?hxUEDqet4iSYMkaDJqaCNHBnr1mjHC2FPAJfZb+X7JtE7Hz8eK7Xk4uXlwPf?=
 =?us-ascii?Q?Fe9NqDOo8B84z37s24FqSqU9N8cckzRyZdbKIas6odk3LVb6phXHbPvt4rfx?=
 =?us-ascii?Q?825E7Ca3IuKsgIf06N4a6bHv4yuE4FcxPpbZsmZc5N6ZN/In/Sd2ObSEL2yV?=
 =?us-ascii?Q?oc4RabT5oFC6O92NLCLrpCW9ZnX5JzTrRbW7D1hSIASqPJPvl6zVDMtNz39n?=
 =?us-ascii?Q?XdTlmrjfX6uPLp5usZ4duWs09y9AXc/EiF/yr6AKbyHDnGkFRs6UdA72GOQI?=
 =?us-ascii?Q?pzie9NCq4potz0I7Z791zYlAxkRUfksV4BXj8aVXY2rbR2E/pkf7C7yqvrjZ?=
 =?us-ascii?Q?4+AIf66QTv/qaYnU7egcuqZ52upXXtjJrmEd0qycPUe7A+K7m4jg90AR0FJ2?=
 =?us-ascii?Q?2RgPzwxsOfNru3ynhghDgvSYiFHKfbU+S0EpnPSL9fV3H5bEuHmf8kCrbJlN?=
 =?us-ascii?Q?5FVfQQoo+TBdkrLXHTP2SBsySSBUGV02G7406lZxtkd15rsXbMKWT2jDyYka?=
 =?us-ascii?Q?WT6wNk54XvDoz1N8JbQrhlSnO2M3+N8EdKzFOwGIH1HLXa1CJgKdvUIm0rKS?=
 =?us-ascii?Q?VfQH7iOfgub5+zQiRre5tHDhSqX79FYpos7BxMN9cu6FI9/H4PyAWkx6HHVC?=
 =?us-ascii?Q?PfL4KUlTLY5+NNHwXn645067lkH11MMy5Vz1yKWDosWNCqbGx0u53RJvo7h9?=
 =?us-ascii?Q?KuyhUjy1Hx8CKJaIkPIrsDeo1r42qkJRDa6koPhzmbE4YZedbsjPmElSlhAq?=
 =?us-ascii?Q?QWdBLxUvjEukDtS31rR24Gmi8Wv+iEXwffYHcgGCun01RTs14LHlAmqT7xk8?=
 =?us-ascii?Q?mXxk7HVyN0HZPRkEmOLuEurcsFFzgwK8I6jBySHlqOtuaJ8nlPC3KEGcMhMQ?=
 =?us-ascii?Q?2LYgTv2jRXZ6Fm5KeodIsQEEm5uBloZ5d2fpEGn+M+R620CFnH0KhVrkkdDw?=
 =?us-ascii?Q?9DLUH5kEQXKygygiONAcaxLsR9Ou8zVzO7lhGrLlqPTkjeqI03SEfirJ9Ifj?=
 =?us-ascii?Q?ODpEeYyAn09lG35l8TxoDMeW/wjW5kaGIgyNR+VlD4dPGdiVKbBqSGJVsfIo?=
 =?us-ascii?Q?xv8N1txkpU/hjYEDFxRAXX+tc8GgPl5trN0r4RAQogV6+Nt4du8RAlBBhp75?=
 =?us-ascii?Q?RIfeNKfVkr24RPq424V9yusIVYuHUwMR5NGoMuB2MAXh1CdGkB8xhY+gsqB0?=
 =?us-ascii?Q?B1J1c98dekwzrTL2TiqYE+4WYk5wtfKY+dSC+xjVxAJStqbpAYmMdX3mmJwE?=
 =?us-ascii?Q?aBYhDhgVGFUA1GJ8CGhzqpNEFw09ZY3ICwz5B1iRNGw58VWYTtJYwZ3Nr80p?=
 =?us-ascii?Q?xvuWJIFb6oVXLDC4Hlyegy0ayHMhwgSOUah1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 09:42:33.3101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc46fe26-6b47-4105-dba2-08dda8cc4a87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
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

This commit makes the following improvements to SDMA engine reset handling:

1. Clarifies in the function documentation that instance_id refers to a logical ID
2. Adds conversion from logical to physical instance ID before performing reset
   using GET_INST(SDMA0, instance_id) macro
3. Improves error messaging to indicate when a logical instance reset fails
4. Adds better code organization with blank lines for readability

The change ensures proper SDMA engine reset by using the correct physical
instance ID while maintaining the logical ID interface for callers.

V2: Remove harvest_config check and convert directly to physical instance (Lijo)

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 6716ac281c49..9b54a1ece447 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -540,8 +540,10 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 	case IP_VERSION(4, 4, 2):
 	case IP_VERSION(4, 4, 4):
 	case IP_VERSION(4, 4, 5):
-		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
-		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility,
+		 * we need to convert the logical instance ID to physical instance ID before reset.
+		 */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << GET_INST(SDMA0, instance_id));
 		break;
 	case IP_VERSION(5, 0, 0):
 	case IP_VERSION(5, 0, 1):
@@ -568,7 +570,7 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
- * @instance_id: ID of the SDMA engine instance to reset
+ * @instance_id: Logical ID of the SDMA engine instance to reset
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
@@ -601,7 +603,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	/* Perform the SDMA reset for the specified instance */
 	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
-		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
+		dev_err(adev->dev, "Failed to reset SDMA logical instance %u\n", instance_id);
 		goto exit;
 	}
 
-- 
2.34.1

