Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ADB4C02193
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 02:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31E1C10E9FF;
	Fri, 31 Jan 2025 02:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DRCJR+Yl";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B24DA10E154
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 02:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fC1BrLU8GbwmVKmRaZ3m9msxXbnGMSbgp7zpx0px3G46jublIgNw5aB9sU6JjVgfQg5rxwH3BthZ8Z8e4Ad9LV2C/sp3d7mwIWBcXhzLd3Sp08ruSuBcFKBeZ3yi3lvT3qCI877hQRRcBK8mLLGKjIoyof2wzG/BxDP3Pfaq48qvIPeUMWvCnkVJt61JNFI/QliffSJoDc+vedenf4jrCN8zNN0KKjRB7luia53EP21s29u5/LdB3WKtpZ2GCIIpXc6PBcP7eMXr27fv9suluJIFngbSeF/lmSpeULJrvYUSj2tM2OSL6vjU286Nwd1IIyLZLc9K3aWhsWa33LXJfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwt4sCkjUAGvgOzFexsMzqBEZFHBJf6WMec/BQiXqLI=;
 b=KwXRwo+lqc8bEubSijckHoRi59t7YYbA3fn5Y36bbzOWNXdhKcNwstCG14NGZIC7v46Yv0DL/NqrijEU6TK6wihCnU4tQTypLOgE/+geVk82pGmKNiY4OO7KxT8nCnFa59TGCsB8hbvD+q9hOGxQtKtVTivmGt8B9xWFnwULp3EhRxyLUMjalme9KBrq7ZYNs27egvNbkZGmk5SS+bWo4pm+4j1ZjXy09Rqx//lfCZyV1qr+qh4w9g1B5mCB5mI8oCpfyWzfuUhLMfx2EOe6AD3gnwbnvI2pT6i/BES43XcgjMyB7zs6r0LDrtoIn3EWs2IhHLypmxoJQAJI6liNrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwt4sCkjUAGvgOzFexsMzqBEZFHBJf6WMec/BQiXqLI=;
 b=DRCJR+Yl04b3NiNEov3MuFoey1grWp031hJyRj7VKUMDPjkCwBgsKUKhaWDfEh4BSGAMB94BDUqkv0elaIt0Of+1j9BA5v4hi2RGjVqtDq8MVQBh98Eb4YgLAka3n4Qf52K6+vZzP37wpW4U3D7qAnM4IQPZzRdDvATNlDNRwy8=
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.20; Fri, 31 Jan 2025 02:32:22 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::b1) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.18 via Frontend Transport; Fri,
 31 Jan 2025 02:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 02:32:21 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 30 Jan
 2025 20:32:18 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?B=C5=82a=C5=BCej=20Szczygie=C5=82?= <mumei6102@gmail.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx9: use amdgpu_gfx_off_ctrl_immediate() for
 PG
Date: Thu, 30 Jan 2025 21:31:52 -0500
Message-ID: <20250131023152.1188183-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131023152.1188183-1-alexander.deucher@amd.com>
References: <20250131023152.1188183-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: 87c4b807-b904-4de1-d6bb-08dd419f7db2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek9YRzUvLzdveUd3bHhadWQ2bXVvTUpqZkI2aGpWcVRFeEwvb0w4a2lOc1J6?=
 =?utf-8?B?Wm1EeHkrclNSU1BMRUJwY0Nub3poeUpiLzJMcm1ZcE5VOWxnRHoxWWhEL3Ew?=
 =?utf-8?B?anFEc0hWblg0WXNRdWYzVEZMakFRNEdqOWNDNDJXYStJRFhoeE9CQzNWbW1k?=
 =?utf-8?B?cHhxMHp1dHNIMmFwakdTMjcxUjNSQ0o2QnVZR1BlVFhROTlJMElLcFdyWFJm?=
 =?utf-8?B?RXM4dCszUkdqcGp6anNSdDhRK0xmTm91Zm5IckM2SzJ4dTBETU5YQ0ZSYWNT?=
 =?utf-8?B?Snc5MFhJKzczYXNMQ3RRaVdrNHE2QnNZeUZoYTBUNnZ0ZXBEeFhmMGlPakJy?=
 =?utf-8?B?VFdDWHJDKzVITVBuNnlYenRqU3E0Qnkzd2drVlZxNmMrTllSbzdZeUNhUDNE?=
 =?utf-8?B?QVl0d3VVT0x4L29tUHJZTC9YbHgyK3Y3NDlya1FvWmRGelA5aWlSc3haUGJP?=
 =?utf-8?B?MTJMU1pJYWVaQlJOVkg0czVWQmdRemgrNktkV0Q2WGFPRTJGYTByY2lFMFV0?=
 =?utf-8?B?MzdHNmk1bVFnSUhUUThIYUYvRFZwMXJYYndWMVFoRFBLT0kvejZJdVkwNWZw?=
 =?utf-8?B?UjVLcEc1aDlXbXUzU3NSZGRSN1VVQ2k0RUFHQ3RFbXlEWUhZTDFxTko0allJ?=
 =?utf-8?B?eWdLUURPNTJJV2VhQVNTZTFIZDdPWWlENmpNbjFScjhCS2NQSWJaSGQ3T2R5?=
 =?utf-8?B?eUsyU3dYT3lHNjdFOGg2TW5DMzR6NDBVOSt1OTU3d3c2NEd2L04wYk92VUFO?=
 =?utf-8?B?QzR2MnZKcVJIei8yTDVHOHVwVkZsQjF0TXlyd0RtWnNEU3hyOHlBbmtsZzRR?=
 =?utf-8?B?cGJhdHIvcHluanIrWmM5QldCdjczMkc0MW9aSy8wak9SZ04zWkFldkJXdXNC?=
 =?utf-8?B?ZWo4dEpNYWlXTVM2ZXZjM0tsTlhxaXE1dUh2OXM2SzNUZW5GZER4eGNLRUtt?=
 =?utf-8?B?b2JqN2lCcWNWcHdGVzBHQWZXMlJtb0FXRXkrUUJoUE11ZmdSMTZwSnV5eGUy?=
 =?utf-8?B?cmFMRDRSclFmMndQeGpwck1BQ1ZJeXNEdHk1V0szVkMyL1pXeXg1TWNnV2lN?=
 =?utf-8?B?UHh6Q2lOZlBLcGd1NDJjblhPeWxjTmxkKzRQQ3hoUHAzU1hIVXNLaDIxVkJP?=
 =?utf-8?B?cFcyU3BmT0VvekVJU1lKaGx4UWtnajRkci9pZCttWlRrTXduWFQrSzhYSzdM?=
 =?utf-8?B?QXBMQmVGdTZWSTV4Y2NaVEZZTldoT1NHVlc2dlE0ZEhkYURndnZBdm5oK2Vv?=
 =?utf-8?B?VXBHaVdSVnNQUTR2TTkwSm9GUDlMQnIycXRIdGlRc2lYUmsvRkNTNEtLQ2pr?=
 =?utf-8?B?czk4dzJPNkZUMTJFWEx1b3ZyNExJL3VVWnduN3JLYmQyb3k2YlJCU3NBdlg4?=
 =?utf-8?B?WGFHcUJFUVZCM2daYnFvb09rQTc2TUVFdUptWGpRMENkTWtaczlOeUt2cFB2?=
 =?utf-8?B?ai8rd1VSeUZLbGxsN3lWSXdiakVxMHVpeUlQY2FwZ3hoS2pUVUdEL2NSQ2s3?=
 =?utf-8?B?d0FVUlBtaGY5RTVETEZ1ODRwZVhncjZrRm81TW5zZnNWRUJxbFh6OTJyb0lM?=
 =?utf-8?B?MmkvN0hmeWhGZkVpZzZOUW9PVnlKQzVocFNwc2paOVZnUEE1KzBUNXhma2ZP?=
 =?utf-8?B?L1o4UnJsZlFaQlBQS3l4a1U4MmxFRmNOeDMvaUVnS1VYVWJVdXV1WU9TZ2gz?=
 =?utf-8?B?V01Yc0FhY3ZrNmtwcE1qOUk0K3MwbzJjcFVsNEpWWHJXVVRHNDlnRmNuN1pP?=
 =?utf-8?B?QUszNk15ZHF6RHBvUnFiNUk5aytBQ1UvTUIrc3BZR1hWcU16N3Z2aDlrb09C?=
 =?utf-8?B?Rkl5cGhDSklJYkdieUsrRS9KZi9oUG9SS1VOaDM3TGNqUUF5bXAzUGpuL2Nk?=
 =?utf-8?B?OVpkR01XTDF2cUN1aW1BK0g4Z1VCNVQ3dXc3MkJKTjluTENKa29rWEMvbUln?=
 =?utf-8?Q?/mjwfIs2Vjk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 02:32:21.9862 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c4b807-b904-4de1-d6bb-08dd419f7db2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
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

Use amdgpu_gfx_off_ctrl_immediate() when powergating.
There's no need for the delay in gfx off allow.  The
powergating is dynamically disabled/enabled as for
RV/PCO on compute queues and allowing gfx off again as
soon the job is submitted improves power savings.

Suggested-by: Błażej Szczygieł <mumei6102@gmail.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3861
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 058f55f1e3fcb..6dbaa4a881d8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -5244,7 +5244,7 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 	case IP_VERSION(9, 1, 0):
 	case IP_VERSION(9, 3, 0):
 		if (!enable)
-			amdgpu_gfx_off_ctrl(adev, false);
+			amdgpu_gfx_off_ctrl_immediate(adev, false);
 
 		if (adev->pg_flags & AMD_PG_SUPPORT_RLC_SMU_HS) {
 			gfx_v9_0_enable_sck_slow_down_on_power_up(adev, true);
@@ -5266,10 +5266,10 @@ static int gfx_v9_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 		gfx_v9_0_update_gfx_mg_power_gating(adev, enable);
 
 		if (enable)
-			amdgpu_gfx_off_ctrl(adev, true);
+			amdgpu_gfx_off_ctrl_immediate(adev, true);
 		break;
 	case IP_VERSION(9, 2, 1):
-		amdgpu_gfx_off_ctrl(adev, enable);
+		amdgpu_gfx_off_ctrl_immediate(adev, enable);
 		break;
 	default:
 		break;
-- 
2.48.1

