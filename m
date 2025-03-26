Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E065C36008
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 07:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B1710E00F;
	Wed, 26 Mar 2025 07:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kldmmlq6";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B976F10E00F
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 07:54:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsYgBdkXgP8WDhWvROf1Rdzg/aalCSVFNhYdzbCkfXqJJ0v/uwwT7OKVSEfhRFYAfCSMFab7M/lyVWUN/DQbC6QFvnxV7FK8nRcfuCWEzudhjidLgc2WHhxkj+Xq4Q/MFb5J7xBelKnxv+BunpMG9SpsPYj6fSvrB6FPebjHQ0I1Ml8ROUUTEPP+ZTCICRJ4qkbOVijN6NEFv30zM8kX1kDabl/jntgg6P6iKteIzzh4XW2PLoywVPlb5+YGxrcT5IrhIu1+3IFKRTwQ2fyJeNcLDfhgum7kAZT8HZZ10okHcK/C5+TxPOlnwWKatQ/hBHsvl5nalrLeSKd8ECQVeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpyFPnEnhvACX7X87iY2oTHV8YxY9xo1Hy3eE4ePcKw=;
 b=QWKaeB/s58hNwmi5QXXWf8yKELs3qGIx/a5RdXGLoHyrCtNaj29lurV58j+BQ+fK1qrW142+g+QUKoYKVC8c+17YBVy3Kxg3Vy6bSP5TeFc8QNqUl+ZcHKsSHIeGIqDxt1HRLP4PfzKKGzlAOfWv90N2JLcKW62DcO+ex+STdPXiYwb4UC1EIw/SUsRSvkQnqJ2cEdgCX+pirHc3RrbP5NubtuEI15wnvgswHfbS6CaajVqZzU0UqhFK+sQEmjb1UmekLYxcVa6+7xF0B/qO8xd09BRvrQaicmqRs1uWdfiSmVwy05hY3YKAVJeYZNyA49mb9SP/hLV24PpY/BqUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpyFPnEnhvACX7X87iY2oTHV8YxY9xo1Hy3eE4ePcKw=;
 b=Kldmmlq6bB5Ju6NDnb5bwaMYTvOMl5XIe9LmCtm4CljolPup9w+R+y6fz5a4miusL+5kPsIaI+GpCCywg/tAIbMUWSI9vLC48rJCSS8YDPEkxz/bKLR7/7/m9b/4/6+tUW+tvZvKASQL3Heton9TD2S7AY7H+FlR/VOD+nB28wE=
Received: from MW4PR03CA0030.namprd03.prod.outlook.com (2603:10b6:303:8f::35)
 by PH0PR12MB7888.namprd12.prod.outlook.com (2603:10b6:510:28b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 07:54:13 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::81) by MW4PR03CA0030.outlook.office365.com
 (2603:10b6:303:8f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Wed,
 26 Mar 2025 07:54:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 07:54:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Mar 2025 02:54:10 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Mario Sopena-Novales <mario.novales@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Add Cleaner Shader Support for GFX10.3.x
 GPUs
Date: Wed, 26 Mar 2025 13:23:44 +0530
Message-ID: <20250326075344.2656188-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|PH0PR12MB7888:EE_
X-MS-Office365-Filtering-Correlation-Id: dde2344a-2dc1-4d92-524b-08dd6c3b6601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L09CQ3FEZjJxNThPVzRUY0NHWkVlYjJkMlh5V1NYbW9zdFB3cTJOTGFZUFRT?=
 =?utf-8?B?bXhmakVkSWhFdGdCaUFRVC9TWGhhTlV0V0Z5WUh1SisvWmNpZWM1TzNPay9E?=
 =?utf-8?B?MjlSSk0wU2RaMUhTNm00Y3lLTDV4OVN4RnBOZzNuY2ZhbHNGOFNJS0duSkJD?=
 =?utf-8?B?M0RnZjVZcmZwVkllK240T05TaWU2QUtpVFRyL3gvY0RSM3lYSERwOWJ6bUdz?=
 =?utf-8?B?K3N4ejE2RVJHbkM3UGtFdExoYlNVajczSFdDcjlnaHlpNXhrODJDZVNmcUg1?=
 =?utf-8?B?WFBENGxXL3R2NEJwenFXYnM2bXBKakg1RXRwbWJ2WGl1YU5Ub3RrYjIvZ04w?=
 =?utf-8?B?STVGUlR6YStBbjJuT3ZyckdFMXRJckJleGVVbUR5ZURBRStVZjlBcDdUMXdF?=
 =?utf-8?B?K2ZlSlJBV1h1K2Qxa3c0THBqSTZUQWhRNnFSMisrbW9SUVdJdkc0clkzMi9E?=
 =?utf-8?B?OGNSUzlpUWRpQ0t5Y2JiNWRmRHRxSWx0dmZDU0ZOcXZnLzZuS2hkQUQ5a2F4?=
 =?utf-8?B?blE0RUY2TjRyYllxcVhFSGppMlNYbmlnTDkwUmRQdVRsQ0ZkYkpGREtwdWJq?=
 =?utf-8?B?Y1crODBsSHJPTE1PWVFLSVZoeWJDdVc0MGNwNThkcktLbXZTeCtSbkt5cXl4?=
 =?utf-8?B?VXRUV2puZWFNWlZWRFdNdVhKaDZ0NkNNaGNUa0k5WTEvWXNvZFUvMnMrUmpq?=
 =?utf-8?B?SitlZEdERkNhSUpaZ0I2OTVHRmZTYmgyVHJ2QWQwdmRhTGttUTFLMTBBcHRF?=
 =?utf-8?B?eTM3aHZkUU0xKzkxZUlXMEdkTlEwRjRXdEhKWXNtdXhYTUgvdDUxcndnbFhQ?=
 =?utf-8?B?STFwcHZ0T0V5ZjdCS2R0N0lnNVVBeXYxN1NSY0lSRnBBZDczK2ppM09tTmdJ?=
 =?utf-8?B?TGtVNTFmYXhqZ2NwYVhCaUlMR3RoNWhKRkhXSFQ2R0psNDkrdWx1SDd1VFl3?=
 =?utf-8?B?Yyt6ZXdacnVPUkZpdC9CTmkrUk4xaVN2ZC9EdDhHYXBPQTBwbndzRHEzdmtH?=
 =?utf-8?B?QVZtUlFiZzFYNy9qTVRHMmx2RHBHQWN1dWdjNGExUkdpUzlNSi9mRVE3WWNJ?=
 =?utf-8?B?WW5Pd0dML254NWR0OHhkTUU5RTBXbDBPRmlPUjhrYi9mbUV0b2l0ckFwbGpa?=
 =?utf-8?B?QkQ5UUFDZ25QWXRoMGhmVTl2ZTJzc2w5YUhZZWUwd3IwN1pNdHZvWEg3ampI?=
 =?utf-8?B?aW5oZ0dzTGFBZFV4bW5INGl0RWNNTTAyWUJheWttbFFFbnA1cklzTFErTy9z?=
 =?utf-8?B?emtuNlhhczN3ajg3ZjdqYmtsODBzRkc3S0phRy9TR00wU1Zwd3Z6ZzIxRGdo?=
 =?utf-8?B?dHk0a3RkTEgrOStRNWdWM0tQM1hJcWNiaEMreXJ3ZU8zajlCNzd4SllNTDQ5?=
 =?utf-8?B?cGtBQVYrNGRnUUJjVFBSU3MxaTFLWjlaSjZLSFN0NnhkS2gxOHhrUC9iQ2pu?=
 =?utf-8?B?MXJsWmxYSWNyM09iZ1FXbFNCc0lHSnkrZE10NWpFN0NzOVNKQkRsdU1LMFhx?=
 =?utf-8?B?eFZGMkZWb0pPcE10YThseER5a1AxUHBvMEcydXFmOU9yWVBiYWJtZUJlb05Z?=
 =?utf-8?B?a1VYWGhnVzBlajIvZjlMQldRYXE5MkY3Q3VvVTZPcExhUmhrTU5oT2xkTGZy?=
 =?utf-8?B?NEV2UGo3UlMrK24vWG9TcGNKZVNnRkZDVDluYWx5S0wrY0l1aVRKWVVKVjJl?=
 =?utf-8?B?UlhLdC9idm5wWlJvVHU1NTNQTjU0MG9nNGZBQjZpMzMxcDFjalVpUUJJaGcy?=
 =?utf-8?B?ZDU1VUdqaHBXZ0NKWkxFSTExWXBsbTBBR3NJc0F6VTN5NHpJL0JqRDdGREZB?=
 =?utf-8?B?VzYwY216K01sNENaeFNVd21nc2JkN253YVJ0QmhZaDRKZTBpRmFkT1k2bE1m?=
 =?utf-8?B?US8yRDFZWk11QUhzYWxKT3VBeHRuUWdLSlZGclJwNUJIeU5BeGhUK2tyWi9Y?=
 =?utf-8?B?K1oyeWJDbG4vUmhza3F1YnN5T1Y1ZVNkTzNWQmM2dEl2bkJFTityTzdVS1Rl?=
 =?utf-8?Q?UECsWJ6QQVLW1zpOyizVI/LcF3prro=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 07:54:12.5305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde2344a-2dc1-4d92-524b-08dd6c3b6601
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7888
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

Enable the cleaner shader for other GFX10.3.x series of GPUs to provide
data isolation between GPU workloads. The cleaner shader is responsible
for clearing the Local Data Store (LDS), Vector General Purpose
Registers (VGPRs), and Scalar General Purpose Registers (SGPRs), which
helps prevent data leakage and ensures accurate computation results.

This update extends cleaner shader support to GFX10.3.x GPUs, previously
available for GFX10.3.0. It enhances security by clearing GPU memory
between processes and maintains a consistent GPU state across KGD and
KFD workloads.

Cc: Mario Sopena-Novales <mario.novales@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6d514efb0a6d..1010d78e4628 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4810,7 +4810,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 		break;
 	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 1):
 	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(10, 3, 4):
 	case IP_VERSION(10, 3, 5):
 		adev->gfx.cleaner_shader_ptr = gfx_10_3_0_cleaner_shader_hex;
@@ -4826,6 +4828,34 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 		break;
+	case IP_VERSION(10, 3, 6):
+		adev->gfx.cleaner_shader_ptr = gfx_10_3_0_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_10_3_0_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version >= 14 &&
+		    adev->gfx.pfp_fw_version >= 17 &&
+		    adev->gfx.mec_fw_version >= 24) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
+	case IP_VERSION(10, 3, 7):
+		adev->gfx.cleaner_shader_ptr = gfx_10_3_0_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_10_3_0_cleaner_shader_hex);
+		if (adev->gfx.me_fw_version >= 4 &&
+		    adev->gfx.pfp_fw_version >= 9 &&
+		    adev->gfx.mec_fw_version >= 12) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
-- 
2.34.1

