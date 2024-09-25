Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2650CF9C7B
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 15:00:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34CD10E84F;
	Wed, 25 Sep 2024 15:00:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cyug50GA";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD2B410EA2C
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 15:00:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9hqf9JyRLQfQgzTyrmoG4qUPKQE2wzuFc2hyv+6VYwiKyVIGNoZep6i6vylWUNMnGUYmTQhB/hXncyVgG+t6jZ4yNwCRO1ZfRB10as3V6qIcSMbv1XwE8IBpQbyEoOUMzY9DfAz1og1mfcxFQlo1VEPTZVJau0Z1RotJuUozEvkC+saL10CViObenWSMwmbI5YBYo1gpOBYyD0ev77WcKSH2rFbGnq2/p9PqCjJwB1QWhm0XW1ijTibVDH8g0lmEsF4fl08uGAYCYBEbM9ZXiXsWhWS/OkDscrbD0n7yRa/Lrnsim7hkHSwhJY2IQFvQty89vAZAzBQv/fEfureYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xjgso59s5aOEaMFrXZTrC1nlZMh6o1EGea//DTvPB3c=;
 b=VEXSlM8Rjlfd0ehpLel0EMbxRmxyzyJELuFL9uHafxm1ps3XbGuhUAGAEyGDiB6tSrIVNtBkso2+B1gg0X1Gc8nlCxiG5PJax0y4wQK8dA8Rcgj2TzWGblxtBrn0kUFhnI3ZS/LLMK5j9wayGQ1PFURR9+sVIR7EQjidMdVTL1o6iWw/AD4ELodOhVpuPPGhwewlz4Krdou8iIC72bYsCDYnzXbeTqmObm0RS6aWXz0vFAtwwIZnstljZhiO/SP3tCcyf6KCw4kVMuIcYG8S41jKxG58kE9+pjnDQya+pGj2FeTrL/jp+7g5gdP+ktWzwj61KgBXG5r2+/aAZreD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xjgso59s5aOEaMFrXZTrC1nlZMh6o1EGea//DTvPB3c=;
 b=cyug50GAR10oPJ9IQGKfZOUC+Yl0YoVNyrE3q/3CR+BSwLVHQEsCKfOQCwmKisFE5adGDs79BObAPus8D+eGaoT3GZaQx5eo+ojl2FZeZ6abvUCHufZAHS/dElDFduQofQgWBXGSHAqLS4rahaIizFDwn+vI4axGTeVbeCHt5rQ=
Received: from DS7PR05CA0065.namprd05.prod.outlook.com (2603:10b6:8:57::10) by
 CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.23; Wed, 25 Sep 2024 15:00:05 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:57:cafe::f0) by DS7PR05CA0065.outlook.office365.com
 (2603:10b6:8:57::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.8 via Frontend
 Transport; Wed, 25 Sep 2024 15:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 15:00:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 10:00:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ramesh Errabolu <Ramesh.Errabolu@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: Fix kdoc entry for 'get_wave_count()' function
 parameters
Date: Wed, 25 Sep 2024 20:29:48 +0530
Message-ID: <20240925145948.3329234-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CH2PR12MB4071:EE_
X-MS-Office365-Filtering-Correlation-Id: b21c350a-9d7b-4dc8-73a1-08dcdd72bd79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OG1PMnlGODlXSmsvbTdWUFVSVlVFNUszVjlJcmk0amJJZGkxY3I5UllxR3I3?=
 =?utf-8?B?V0FONUh3V29jWDZ2T1VnU2htR0VqUWdTbmdkTDhxcVY1VXFoQ21Cay82YWxo?=
 =?utf-8?B?Q05MOHZuVWVaa3VWOEJ3a0N0Uk1XMndieFBPU0VIZW05Y3ErYVhQS2JmdDZO?=
 =?utf-8?B?bkxxRVlUUG9aOEx3bEZoTHg4cmttQm5xQit3c2YrbjBHbjJPeHB1b1FJZFVY?=
 =?utf-8?B?MXBGd0hKb280UTBVWXhpVjF5WWFzQ0pyTnRFOTZpY0MwdVNCYmNaU3J2UkZP?=
 =?utf-8?B?ZTdmL3hRMEE1SitxZEhzTjU2T0lPTVlCNlA2NC9TYnd3Y1doYXNHS2JxZlBn?=
 =?utf-8?B?citiQ05mS0pMdzRIT3pmQUo1OXdDRzl4M29mZTE4UjhZam1QVTRrRCtDbVBO?=
 =?utf-8?B?ZUwreVF2RWFnODdrL0RGQTVGcW5jNlh0b0x6dE41UnYyajE1MjA2R1BpNCs2?=
 =?utf-8?B?S0tLMzJtOUFkSm5JbWFQTkNKUUVaUjNCRzRPbGt6cEh1d1VHZ1FxRmR6WXJX?=
 =?utf-8?B?NFkrVzZRQUMxRW9MY056L3BVaEFZeVZUZFJUaFhUYnlFT2tUTXR0Q0NzYlhs?=
 =?utf-8?B?U1ZxQjVYanpnbnhYanpWbm1odUlBNCtpbkhHRlpyQXBzbkVWVXZ4eW9LcHoy?=
 =?utf-8?B?c29qWm5JY2lsc3FSeUpZTjljRlVNdmhvdmFmOVlvcVpQVWc1OFVWVUVJZCtR?=
 =?utf-8?B?WGhsc0ZUdmZWbElEOHM2ZzNhb0p6blR3dDQ2U3daLzJyaDJEcjkrWHd2Z2du?=
 =?utf-8?B?TFFnMzUyaUdwbHhyRlBDbjc1N0xubmpuNEs4Ukdod2xRaVkrQmlSUGc5dWZl?=
 =?utf-8?B?WnFHa0tmL3NNN3JWQ0p6ZFdvMDVpMTVKMDkyY3dtZGVCODJoekFKa0tpclV5?=
 =?utf-8?B?eTF1eTJpOXRrSWl1YVhEQ3VLdjRhMTlyU0txK3BoWFBXMGFxNmJqRXBlbkNt?=
 =?utf-8?B?cFI0V1BUSGxPOVU0SzFlYnY4TEdHWXk2am82WEVaRTh0aUYxcTZwSndWdjhi?=
 =?utf-8?B?SHh2TlNGdGFoczVoUENvdEc2SHRPSDZPQ1JZMU1EWU81Z01CUWZpekM3SHZT?=
 =?utf-8?B?Nm9EcnZlK0J4VU5sRXErQ0oxWEJpUG03VWFIVmhDZ01PWEdxaGdYNUVqVVlD?=
 =?utf-8?B?TFljWWJtNVE1V1RVTlMvUmZpTmFwbkt2NStrdWNDZVZDR3c3dlZkQkIvak8x?=
 =?utf-8?B?WkRyaFhyak9TNmdNZktkYlRlYWxpVkpxTk82NitGUlFLOWp5TlpJTlRlUmJP?=
 =?utf-8?B?OC9FWE5OWWYyZTR2dytMdkJxTzBuTk9SL0lENVB5Z1o0eGlibWZUR2V5bnNJ?=
 =?utf-8?B?UzRIL1NhSDNHbSs0blRoTFR3RlhBdHlKWVR1Y3IwMTNJd0IySU5vZ2hBT2h2?=
 =?utf-8?B?SFJiMGtVNjlzRTRIQ00vSGtsdzV6Wk9tYkZRTWhqamZtTC96MXBxa0JXL2p3?=
 =?utf-8?B?SFlhOXZZeVMxeEcxb3BtZkFMek90YVhkNGc0SzZmTEE4dWoySmNvN2JYVmEw?=
 =?utf-8?B?ek9GRDhPdGRkMTVnL0ZscmM0TTc0Wk5aVGQ5VEcyWkt0dnZPUzd1WnNtYytX?=
 =?utf-8?B?Q2pkbi8wcTByb2dObE92OE1iN2JIbE03Z2xlWjJZdjMxQTRNbzgrQ0hrcnJD?=
 =?utf-8?B?L3IvS280VzRMWG1GaVp0V0ZUc1hINDRvY0k3OHpVZERzaHZCOG1NUU50M3dM?=
 =?utf-8?B?QnhWci9ncmw0d3RqU0lvRGhZOWdpNUNSRHdySjh0V3c3clFiVFZ1bExBdDdi?=
 =?utf-8?B?RUNLbnc4N0g1aHczcmF1a1NsZURTNnUxNXFJNzFaa2l0OEJMcWhITUNPY2lQ?=
 =?utf-8?B?dUlib3FiYXNDeE1UbG13WU1XYjA2RGRWZFdWTmo4bjlzYmtWVWJpQUJaYmtu?=
 =?utf-8?B?dUhpYUg1SnVlL3lHQnlCMWhHT3RRTXZpSTJMUFRQUUNydDBWSHJ6U29XTStX?=
 =?utf-8?Q?T1k0lKE71v6vULnPyqiQP6TAAYptPTBI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 15:00:05.3850 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21c350a-9d7b-4dc8-73a1-08dcdd72bd79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071
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

Update kdoc entries to reflect the function's parameters. The descriptor
for the 'queue_cnt' parameter has been added, and the incorrect mentions
of 'wave_cnt' and 'vmid', which are not parameters but local variables,
have been removed.

Fixes the below with gcc W=1:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:954: warning: Function parameter or struct member 'queue_cnt' not described in 'get_wave_count'
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:954: warning: Excess function parameter 'wave_cnt' description in 'get_wave_count'
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:954: warning: Excess function parameter 'vmid' description in 'get_wave_count'

Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Cc: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 3bc0cbf45bc5..5dbb042d10e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -944,9 +944,7 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
  *
  * @adev: Handle of device whose registers are to be read
  * @queue_idx: Index of queue in the queue-map bit-field
- * @wave_cnt: Output parameter updated with number of waves in flight
- * @vmid: Output parameter updated with VMID of queue whose wave count
- *        is being collected
+ * @queue_cnt: Stores the count of active waves and usage data
  * @inst: xcc's instance number on a multi-XCC setup
  */
 static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
-- 
2.34.1

