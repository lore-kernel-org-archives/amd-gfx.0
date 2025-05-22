Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D131AC54EDA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 May 2025 21:56:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 577AB10E769;
	Thu, 22 May 2025 21:56:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l7EjQvVo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D2A610E192
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 May 2025 21:56:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=woY0boFlNiTzifcctFZqFXrPT1VfPIDJCJZKSvWaQezJ5TeIv9hclljB1azqlBmv5rAR26s6ES+tfRI8JOoPRJ1obGMVssmUQtdhMlXO1NQDRgVGuD1DTTDy3XWD765OvCwdTq5QToqUzhGPaD3trvkt0YeS6bSRiqvgLz4xgkmr/nswj1k4haoJ73K+Q+MpEV4LQ8oYak4DV4X0TFNRBmkPdSJnpFXo1LaACaUYBCw6HlQmR6/52ZoDwCic5QVuBbdW9xdG1SzE7Hgwx5h6zqK2eFdp/fuIoMzHzX7Bj+59VoTFFw4zqo0IaLz1eNXBLz1XfyBBXY3lxbkclpKwEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JQEAiquWthojVSmdGGktjaELRF5/LoBtTu2zpxVYKM=;
 b=Q9VXZ+BatMk0syQx8RQWpgiYwq6LOxzspYfkdD0OMZfAXgFBSzM3eUvrCEmrNYAvqW4UWNEeJ9/RKrID/baQGWUm3rCgJG2fCuDBt6Vnx7kyyZBUahnx2Bh0Y0wVpE6ViMRu/NiZ7IyVpOYiNrandNNQXys/fRXfgRMVZl6lOYDUrAvQ2zXZD1hUnVdCaS6w57RHttFDOUqn6WO2dLPDEX7GrHwlDO6Q3SBEIT4xB7x2j/9Zyw6yBayvns0FO3VSEX8TFE6747OXlhgNtTPvDPTylbgq4DtTIPgITHP7eXJXH/CeFI1WbVspoVm4Z09vEGqTLB4wLeT+EeGpWymuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JQEAiquWthojVSmdGGktjaELRF5/LoBtTu2zpxVYKM=;
 b=l7EjQvVoXYOVAhcVsVkEeu922BS4YAS0kmEBI3/CAmCX+ECKMfwpOE/p86b9kRSEbG02lWqz5o8b9q0Fnhj/byC9JTTP6NZCsGqEUzHJLUXQ0RAVz6+FH3+Zby1jLgFOvoykrTndaGDlYdQ+hZ8YPnSCjtQUnbjqrHAQPuDMM3g=
Received: from MN0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:208:530::8)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 22 May
 2025 21:56:13 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::57) by MN0PR02CA0010.outlook.office365.com
 (2603:10b6:208:530::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 22 May 2025 21:56:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 22 May 2025 21:56:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 May
 2025 16:56:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH V2 00/10] Reset improvements for GC10+
Date: Thu, 22 May 2025 17:55:49 -0400
Message-ID: <20250522215559.14677-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e02a334-7b9e-4916-3983-08dd997b7825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUZCV01EZ09KOW1LeVl6MGdmdDBNREZUekFPOGtydzExQWNHWTVHN09Nd3J1?=
 =?utf-8?B?L1RCNXFQQ0QyTlFsSjdhVmEzTXdaM0RMeFlGQ1c2MWZUSFFpekpMN3gxanBR?=
 =?utf-8?B?Mi9RV0VueU9lK0dnUzByckx6QzJuVkFYenRUakJsYTRIT2wwZ3ltQW4rSUgz?=
 =?utf-8?B?cmdNQkw3dDlOanR2aGYxWXF2SlhPZEFyODN4cWtIdyt3cEhyZWU5UkxDS1FF?=
 =?utf-8?B?Yzd1NVlscUVhdU9xWUJQQnRLTmNHZTNJVmhFUDNQTjN2bHNJU0M0TjdhbTZL?=
 =?utf-8?B?NjVJZFREZ0RmU3doTHRPWHlMTkUvK3lBTUsxRDd1Z3k1cWIrOXNTT3YrTERo?=
 =?utf-8?B?MmlNb0VzU2JLczhJeFpDZkNqUkdmNWxVbVBJUWRoZVlaQ2dreUx1VWhxa1da?=
 =?utf-8?B?WUdJVUt0WnNKdDZrYTZPQUVMMGppbU1KWmhRK0E2dE1KTlplVWkvSTljVGJN?=
 =?utf-8?B?NXNjZnQ4ZUl5K3UvUEl3MlVzR081YnJGSjVhc3lJRDNuOEJoM2NwYy85MFZz?=
 =?utf-8?B?cEFZRndQTkd3UlFGd2lBOFdmUlpMSXRaVVJaWXF6WGw4alRUcVNTS3B4cGpK?=
 =?utf-8?B?OWU2VjZmeGhYN1B4NlJZU3RnZHBITEdwSzd4U3IvMk1pV2NZd2FTbnl0U1Qz?=
 =?utf-8?B?TWdpQ2N0S3ZMaGVKYm9DcE5TZFNVOEphK2pHenFMREU3OGwwVkU3K0FBODVN?=
 =?utf-8?B?QjRVeHEwNHdvdS9mL3Z2NEt2ZXZDR29FWjY5ckYycEVJZTdUeDhjRzNJYkFW?=
 =?utf-8?B?d25zZ0xXOWlHRlBrU0dKT2h2MkM4VWx1d2FSY0x4WWVxdTEwMkZPbzZjUmxZ?=
 =?utf-8?B?dHJSQTB5eElHcnBSalVHRFI3dEhKcGdtNGdzYmMvMjVzSXpSQWNLQTRPNXh2?=
 =?utf-8?B?TVIrMHdpZTBTK1YxZUdRREpqQ1NYVHpSOXNDcS9iUmNlMnc0N2dRSWE0TE1t?=
 =?utf-8?B?cmZJeldmd0cvTVNyaFhsMm9QZDRneDZPcXRKZ0s2ajZacjZjTWNwL2c4Q3Vp?=
 =?utf-8?B?R2tlUVhncE92R1ZaSUZ2VEtxWmtPYUd6WDFuVW12UDRYLy8wUHRTYldGMUJy?=
 =?utf-8?B?MjJWWlpXbFJVMHpUQ2ZqcDFrN2ttcStlRzFpUWk4dnFTbmxaZG94UmVaWnc5?=
 =?utf-8?B?QkYxU3BoNTJ0WGhqU0tRUFNDbkcwWTBRbGtNZzAyNXFwR2ZVSmw5dDQ2Mkdk?=
 =?utf-8?B?VFBUK3U1UnE2a1daaEd6Z3RxZDlTOVEvRURPMGc0OVBvWmY4cTRFamRDNEVD?=
 =?utf-8?B?VG42S0ZOTHNTQ2JjRENkcSs5RVBFeHhQS21lRi9jMHAwZUtnQXhyY1c2S0Nn?=
 =?utf-8?B?bnpLZ3JJYlQwTlZDSUxnNnBObzNBT0JZcVQzbG9zT21qWkd5L3hxRU44QXNi?=
 =?utf-8?B?TmUzVFVTWDJlUkxHM2RFdDVHbXQxd0ozYWpXakdXVE9vUzlTcUgwbFpIU1lK?=
 =?utf-8?B?aG4wQThkR1BTZW4rSVNGZDZzZk5Kek1hNlY5MitOMVdVYWFmbmhvdTI4em44?=
 =?utf-8?B?elFEamE3M3ovVmI0dHUwS25IS202QTlIUThjcVdsTmM5QUlmcVI1TXBBY1ZO?=
 =?utf-8?B?YnR5WnRLd0k3MTdkUVN2ek9PMWZWOFdMeFdwcFlXQzF2Vll3NXlvQkxLb2NJ?=
 =?utf-8?B?ZldOd01iWHhiaGpsNDkrQjkvMWJTN250L2tGRlNsZVZDMmwyOSt4d0Y5b0Rw?=
 =?utf-8?B?aVltZEd6S0xLRnhneFlFbjZLcnorYmxkY3JhR0h6TlpkQW96Z25VUFlBQXU0?=
 =?utf-8?B?Ulp6TFV0a0RWRzgwL3dSK0pIQVVhNG5SWmpGZEt6T1pDY0JzU2VvRG1nNVh2?=
 =?utf-8?B?T3Jka0tUaER6ZGF5eUR1WFFaVTRaanBQdEF0ZjE5OWk4cXZ1STV6UWUrL29J?=
 =?utf-8?B?OHdOZzhtcCtWcEZoQWJqOFVJay9DQkFpOFhFbFBPbFVsaHlwNkJKYUptak56?=
 =?utf-8?B?Z2xYVGNhSFBuM2o1TGtoWG54Vk9ibUtMczZZZlYyd1RoM0VOYU8wakxET05Q?=
 =?utf-8?B?NitObVJITVNxeG9DY0VhR1h5VjkyUnRnU1JYRWx3R1NYSXZ5VGY4a2FDK1B1?=
 =?utf-8?Q?uBo5QD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 21:56:13.1791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e02a334-7b9e-4916-3983-08dd997b7825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158
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

This set improves per queue reset support for GC10+.
This uses vmid resets for GFX.  GFX resets all state
associated with a vmid and then continues where it
left off.  Since once the IB uses the vmid, only
the IB is reset and execution continues after the IB.
Tested on GC 10 and 11 chips with a game running and
then running hang tests.  The game pauses when the
hang happens, then continues after the queue reset.

I tried this same approach and GC8 and 9, but it
was not as reliable as soft recovery.  I also compared
this to Christian's reset patches, but I was not
able to make them work as reliably as this series.

Alex Deucher (9):
  Revert "drm/amd/amdgpu: add pipe1 hardware support"
  drm/amdgpu: add AMDGPU_QUEUE_RESET_TIMEOUT
  drm/amdgpu: set the exec flag on the IB fence
  drm/amdgpu/gfx11: adjust ring reset sequences
  drm/amdgpu/gfx11: drop soft recovery
  drm/amdgpu/gfx12: adjust ring reset sequences
  drm/amdgpu/gfx12: drop soft recovery
  drm/amdgpu/gfx10: adjust ring reset sequences
  drm/amdgpu/gfx10: drop soft recovery

Christian König (1):
  drm/amdgpu: rework queue reset scheduler interaction

 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 41 ++++++++-----------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 35 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  | 35 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/nvd.h        |  1 +
 7 files changed, 50 insertions(+), 92 deletions(-)

-- 
2.49.0

