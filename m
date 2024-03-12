Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EDDC54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 13:47:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8989710EB68;
	Tue, 12 Mar 2024 13:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LGY0ZaMg";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7F610EB68
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 13:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCP+R4ul15OneW0s2xGl3yecKazMjuf/lE+U1iV40lSk1oCToA7vZz26/9oYzmq487e1DCYuvL3Upr7F/LKvVrTo5CffPy36zUv6hMpgjPdIc8qvseUJiMnoMVbBs01Cucf2ueUZY0hTO1/FBfDohfJIbDSUy8rRn7qDHtqEvwcaEUZwxW13n2MaV3Q9aCImVPQbbGpoIYkdP56QKFuVRAjWnh9g5s92dP2JpuCu/sdDGp4kxz4gCpRsZrxVUhHYyFqXdiykJQDRGmVkNMUAwJhncrZgqbsv/nlGlJJaK/s7xyCzsGjqZotGRtxAoHraKGNlOtry/sL85PTureqQUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWjrqN/XXxsf6zJIuqWCE/VbYzbhEatvdOnrfDX1eDY=;
 b=gPF7mAo26tPmsPbWpYMYmWszCu2ED26EXYFaBNu3/6uVDbszbsXifzXbHBVBk09k4sfwNvS9aqpQj71ulTcZ9wdHpnfKuUAETZkUf/wk3IiVSI8pdhcB9vSI3lvZv4Wa5GOIIe9W9yEHKgD82nrppWtlwGlCfDZtlZTciOZdVta5JA2gfcN2emrZH3sTdcz4ByDw87z384D63ZO4INm48/zE1yU/oeD6MFB7pURDSKVVoKDbg6nrlRJxvsENfrFemcR1ckoIBCKtwA4ACPSXO7UvgSqIUBlsHkqXlsguocsnasRfupCwyWnttxdwenEyGr5o+nr3qdnT2DW5fadNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bWjrqN/XXxsf6zJIuqWCE/VbYzbhEatvdOnrfDX1eDY=;
 b=LGY0ZaMgrsq3ixsFHngeAxnHuXP1a6417VC6Pmm+YSrkTjhQezIlTCq/G76TK66Erf2wojJEwlb2FCOagkRm5i+zbK9O9040oZ3PGgB8Jl0m+qy9iXqTft8rCEEGlaoDtjPv1Vi8+YnPRDoeMQnwMlAvAiu1bxPj9cMEgQSR4DM=
Received: from BL1PR13CA0194.namprd13.prod.outlook.com (2603:10b6:208:2be::19)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 13:47:32 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2be:cafe::25) by BL1PR13CA0194.outlook.office365.com
 (2603:10b6:208:2be::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17 via Frontend
 Transport; Tue, 12 Mar 2024 13:47:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 13:47:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 08:47:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 08:47:30 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 08:47:29 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Get min/max vfreq from display_info
Date: Tue, 12 Mar 2024 09:47:28 -0400
Message-ID: <20240312134728.14046-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 1caf3cbf-ca6f-4a28-0cd1-08dc429af764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJxh4lyTfx0LMwWE25d9rfEGer0jUwo6Ve7XgGvi+yuTW9+lFA+P2kysqmvayNeis4a67gXmuKw93VM7thk6TSm7wJEmarhiVML5TiQa3/prB5UVoxXmXcTvHecQsmbewTKiMtLPFQtQY0Pz6yXtBm1ceQWxC5NIjzIoOiZb4PwkE3OkfVQb4uLCcEjqe6x4H9NbmGpiAw5jPfRTkgiLCcflXDtbPxQnI2Dr0OiiwNa+sYnFMbxg4hBe7QDMPsK6EDqpaU4a8SQTiyVfYFdD8GW8qR3tOZb/VS2SDdHpRpP2fWOwn4ZMhCpujAXIrzG+6e8nEgpV3r9OywftwZgFHl0oFN+H2k8MjgXgyWArW/ZJv/Lij+2YDwsGTsbzm9OfL2iyYGWsjEF+cInwmdRWShMvcg+VtQfTAD20IgvoK1NWMBl5JpmoS6DtNsPTcX/n/4tBeIE0bUb05SwARfidrFBOIpDtQ/nNMhLisliwQKmx8SUP5VEVpSGcdekok3Y70HebbqPdFUkC4qVgn1u4TSAN8gTKZgY3xg2Qkpuqf53PqSkB9dzo1a+MRC2ufTc/QAm7jhY99OlEe6Bc5UqMQaJLP9uTmIFNMrKSHzQtQDmiKahEqzn+bSoXbTxtxTDgo8XNDAw0tt2XNB8EgP8YntyMKY5scr3GbQm0E9Xh3IryzqTFQp1MATDkFGT2AWotEVN32Gi5QJB4dbxTQWVFHm8W5qKKud3tA+tyXCDWu/ZQvKpuve/8GpfTCEfCCUJ6
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 13:47:32.2225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1caf3cbf-ca6f-4a28-0cd1-08dc429af764
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
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

We need the min/max vfreq on the amdgpu_dm_connector in order to
program VRR.

Fixes: db3e4f1cbb84 ("drm/amd/display: Use freesync when `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found")
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b1ca0aee0b30..cffb2655177c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11278,12 +11278,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 
 		if (is_dp_capable_without_timing_msa(adev->dm.dc,
 						     amdgpu_dm_connector)) {
-			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ)
+			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
 				freesync_capable = true;
-			else
+				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
+				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
+			} else {
 				edid_check_required = edid->version > 1 ||
 						      (edid->version == 1 &&
 						       edid->revision > 1);
+			}
 		}
 
 		if (edid_check_required) {
-- 
2.44.0

