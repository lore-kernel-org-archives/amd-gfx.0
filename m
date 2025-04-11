Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6DCC369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 16:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80AC610EC1D;
	Fri, 11 Apr 2025 16:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jlbA7ezH";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A289E10EC1A
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 16:20:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoP3LZGX/wi5xT0D5d5cyQh3Em41tmBtiHAD0QjWPyrK6Mv35bQpMms59jWrQTfNrGVnxlykDzmbX96g5G+E1IhZTl/knqb6Y/N7DUjqwDaFLUP3xgDeEoc7LAou+4u7/Piqp7vNv/6na2wq8l4677qykJsRaX4ptmdIOqmegfGBtL64kSOEIS1WAcp367dCTDIg4Iz2zwS1hXNPHch+72N3YnXaBPlvmUY70xxaANNW3FIQ44lyNXaViza75jyu++eZkePu5FGdnDcxIw64ZL9XVIUGtRg90BQ338pgzlxFICfLWo5U1IX2qEJnn3G5WKFrRKIL4w+zvSY+FRvsqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfZlYmGOHTLSATfBELohaFurNXxkPBeK8uyW3r3hfv8=;
 b=gZEgrVz5Rt2lFhov7EmEBc8W7YTEVSGP0ahYTZxMoXV3AzBA8l6SLrZke00PCZMEmaGWDkKW9sASXyKgfoN27pVQaioarpRIMjN4R7+aoNIJKzTwyGsTn1H3KQIKX7AvOVq7+302rlthT85sPJEAfGes4bgc8et9/3OLDZBtGuQvDgm8W9Mf6/YLUsuhYBSJT3lz6BZttWpkWqPJB9EnCLBMdLm8aOX5EdmaFx9PScswOf7UsUkQN1PBJg/uGS6RAPS2IQHF/5UDWFuYqOv9B8RLiVS+trqrZc4irlGvY3Px698R0k94DMVchrIZg1ARhnw4SNtVu4Y0jYJ+Y9I+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfZlYmGOHTLSATfBELohaFurNXxkPBeK8uyW3r3hfv8=;
 b=jlbA7ezHrF1cFEqmYvOJ3qVpHVv1mglkF5X4+yC3+Z/r7p/0/hkgonPr5yXjgCnS1dbAfxUg1Mcys1+v/JllCzWdgjJTJOBHGQUh9VBc4+IaF06/MadXPbeFGWyIxZkzcWD59Ga/39kcTMEdkV7XKQdtZszh71p45BLaIsEL+ik=
Received: from PH7P220CA0067.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::9)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:20:03 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::6) by PH7P220CA0067.outlook.office365.com
 (2603:10b6:510:32c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 16:20:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 16:20:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 11:19:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Enhance Cleaner Shader Handling in GFX v9.0
 Architecture
Date: Fri, 11 Apr 2025 21:49:43 +0530
Message-ID: <20250411161943.3323364-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250411161943.3323364-1-srinivasan.shanmugam@amd.com>
References: <20250411161943.3323364-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d690ede-a5ea-43c7-3c14-08dd7914b678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzJLZThrLzhoejVENUdSaHhMSzRHZjJQeFZMd0ZSOFpraks0SEZqVVBBLzhZ?=
 =?utf-8?B?RE8wb3dLS0d0azVHMFZYZk1ocVJsZDdnQXdpTGtBZm1KNllFYTBnL3VyRThX?=
 =?utf-8?B?RzR5NGhIQU1MOE5MVzJuUiszdGx0Vlp3TlBnWU5uMHp2aE5jRElCR2d1WU0x?=
 =?utf-8?B?cG1oSGRUU0RPNytackRNc1hqTDIvSmIxZW1JRmFHZ3M3U1VwUmZyWmcvNUl5?=
 =?utf-8?B?b3RmQVBFWFROQmdFY1NRTGRaL3N5K1pNQVliSHFIYy80QmRJVUJGNThNY1Bv?=
 =?utf-8?B?YWhDWmFpRWdlakZlWlFiVlpVOWMrQzRiOWZwNFlvcW45dW1YRklJN1Rkdksr?=
 =?utf-8?B?eHczZVNha1FCellNUjFUVlpOMm96TWtzanErZEJiRU1nYXdaakgwcndMekgz?=
 =?utf-8?B?T2VtY01pVTVBM2wzKzlRMTVma1VEQ3A1NGMzOS9ld0dWZkkwVCtaLytmWVpI?=
 =?utf-8?B?d200c3NEcG5WVTRlRTR4QUticU1EaENkUzlpM0pJK2tFa0tIU3VjdHpnRTRx?=
 =?utf-8?B?ZGFNa0dScEZRb1lXZnYvNGdyVTdsU3JnRXY5T2J2VWdINXBrUGxiNHJxNy9y?=
 =?utf-8?B?LzcyWnQ0cC9NRnh5MFZyQU9lOEVvbEdZZzBYcXRzQTJoMjVtNzhRa3FMMnJG?=
 =?utf-8?B?a1NxYkd1UWlhUmwxT2hPU0t5SlpMeE0wUXhRSnpNbjFQU3FkSFUrYVZCUUtl?=
 =?utf-8?B?aEdaa25KNXB2ODBmTlVDdDFmdGlzdmlUeUF4QlVPNjRHeVdoN2FxbFlwNkFt?=
 =?utf-8?B?TFE0QXVnYVIwQzRBVFBYZjBkL1ZtRnZ4Tkx6b3FBb2JTS05xKy8wYnFhMUJr?=
 =?utf-8?B?SkRndzVFNTlSb29FcEVyeE5OcjF5MG5HUzhERkt1K2FkMDhPR09KOFRrMVZ3?=
 =?utf-8?B?RGV5UllSRjFoaGpSQ09IUnFoVmdrWDBlZnR4anphYy90QmN3enBneVNEWkFM?=
 =?utf-8?B?THhMNFUrLzJ4cmloYm1NMkRjUGh5TWhlenl3MmVLK1MxMWUzWE9EQVpCK2hw?=
 =?utf-8?B?NXdKYk9PYTFrbmUwYlU5RG9McVhZcllVZkhwcDk5cXk3eFdaQmZjNG9kN2Iw?=
 =?utf-8?B?ZlRNTDFPMDFWdGJ0Sm5YdmVucFlIbE9qbGlGM2dudFVyU0F5dTh2b2lRZytS?=
 =?utf-8?B?ZVhRMkdidnJHVHhYTmpxT3ZUdFlSeUUxTlpjckptVDNBM29QdjFmNFdQeDla?=
 =?utf-8?B?ZjFGeHZXRlpnR0ZxelRyZjhNeklEUUNPVDMxR0NFUFg1V2hPbkhhY3lnNlF1?=
 =?utf-8?B?endFR2Y0V2pJSURUYVc1N1cvNURmZDltSzZOcGZCeGV4TDlZVjJNanJWYjQx?=
 =?utf-8?B?MTg4K2FZNDBFbWREQkRyRnhLdWdMMmNwbUYxTEdIUXBXNzZXZnJGTTQrelF5?=
 =?utf-8?B?ajJ3WTZuUmRlOUhZdWh4bTJHMnNDNFV3d2NIVXNSNFRyaXN1MFV0bmNsWmpp?=
 =?utf-8?B?cHJmSUswZHllbDZqclk2cEt5OVFIMy9VcW8yNG8xQ2l4QXZBU2VNem1kTVgx?=
 =?utf-8?B?UXVBRDhLMTlGQjJuV2ZEamo5MnlybXpocE9aNzgzMlB2bFRUUWVYSFMyWE5C?=
 =?utf-8?B?Zzg2TVpETzdLcGJqSjI5T0NYU1A1OGkxUHM0Q2UwUUllNjNHZXFzcFo3cnNU?=
 =?utf-8?B?WElIT2g1WkppbWpUYVExVlZwb0dVWnlnbXFlU2tyK3ZHbHZCWnFoSlNMQTky?=
 =?utf-8?B?Nkc2L1N0cTBSTjN2cWhIc2xNZXNML0hvV2FNQnhTdHRGK0hIMjBpb1QxVENL?=
 =?utf-8?B?UkdjL2FnTWhsVlRyUittVTVlS1R5bjgrZFJFZm5lOE1hdk1iSnVwZzV0Q2h4?=
 =?utf-8?B?MS9tWEdISGgrTFVwd1JETldLWFpqdEdQUGl1MHBmZHZ4WC91T01SNG5uRGhB?=
 =?utf-8?B?YmdZZlJsVUJkdlUwYU1wWXZqaXJyUTZoTDV3UUdwSmdtWm5uSTlQWXhEZ2ll?=
 =?utf-8?B?Z2VIYTJQWkJTUFdwcjFKVFg1NmVVc2NmZXYzWitXam8xcC9mYnVxS2h3MFBY?=
 =?utf-8?B?K1ptRklCMzZyTWpFeFU5RGI3eFhhL3RvdzVjL3NnN3VvZ0UxVEk2L004MHlB?=
 =?utf-8?Q?S3NZn9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:20:02.3493 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d690ede-a5ea-43c7-3c14-08dd7914b678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
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

This commit modifies the gfx_v9_0_ring_emit_cleaner_shader function
to use a switch statement for cleaner shader emission based on the
specific GFX IP version.

The function now distinguishes between different IP versions, using
PACKET3_RUN_CLEANER_SHADER_9_0 for the versions 9.0.1, 9.1.0,
9.2.1, 9.2.2, 9.3.0, and 9.4.0, while retaining
PACKET3_RUN_CLEANER_SHADER for version 9.4.2.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e62c77b3934a..bfe66a0e0e71 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7387,8 +7387,27 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block *ip_block)
 
 static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
+	unsigned int ip_version = amdgpu_ip_version(adev, GC_HWIP, 0);
+
 	/* Emit the cleaner shader */
-	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	switch (ip_version) {
+	case IP_VERSION(9, 0, 1):
+	case IP_VERSION(9, 1, 0):
+	case IP_VERSION(9, 2, 1):
+	case IP_VERSION(9, 2, 2):
+	case IP_VERSION(9, 3, 0):
+	case IP_VERSION(9, 4, 0):
+		amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER_9_0, 0));
+		break;
+	case IP_VERSION(9, 4, 2):
+		amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+		break;
+	default:
+		dev_err(adev->dev, "Unknown IP version for Cleaner Shader: %u\n", ip_version);
+		break;
+	}
+
 	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
 }
 
-- 
2.34.1

