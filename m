Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A047C369B2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282C210EC47;
	Fri, 11 Apr 2025 17:40:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2OjCuefJ";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC20510EC46
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:40:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqGnKtVYBT2vHKbCgstL8r83Npha2WV8LCb+AnJ1qGGRlXIudWG9tTqe/QAgzLPURZ84CXQB5E3pBQVuTvjY03rG/cwqHPOC11lkx6WHtK1SQt++RrJ6Lr9WjeNU61R2yPE7o3RdWpCowGS+pmDMhTdvNP30gizRBbw3Ak1/CY7kSN65+Dejp4hLvzczallBRtwxeb6k/IYflkOqcmCwmfImWUyueDfR5rX5K102MWeYanEp6FP5yrtF33HU5KxcAgD0OwbnpjONpGNa7dsVYq0W03S34dgrQwL8QzvA81cYB+DH+CulZwYxsPCeLPuYRKlN3/1aqw6hu0ri6KtMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoVLGSrJN1C/waUlZm0UiDyfzeLQZ+Y4e9jt2qnpsQk=;
 b=g/RmTD15MR6aeIjWF9TdrpMp7+LjQvYFzWN4FnfDD2VLKo3H60xd2uwKbDiAG/29QrEfv03r8dn3mdIW7L6j7+rGbEUVJe4J/SkVqcSVgqvgG5d6KJG0Ace6WJbvdO5d39L5g4YKZLKMQrV005Irmq/rWQmi8s4PJwoR5jmln2H0OctOYIGV4H/yCUw/bA0r3NZ/lMe1JH8Ftnu8v3wPYxsZ1Iy5J1zsW492uOxPnOwDR3Zfp/F4Y/mlzmIh5IIMbbdVTU2RfCgNMaMnAuFWWPHETPPO7LhgWyqWjwCfydTvtrIe7m8n+GBltcHXjrBltrxWKg67ANojyWkI35PyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoVLGSrJN1C/waUlZm0UiDyfzeLQZ+Y4e9jt2qnpsQk=;
 b=2OjCuefJHSVwQNb4Jf20khKoVFzn3IUwGec6a/u3uri8N7oLJ8w5dZdNlbzOqxdE+nzsUMxyjnzx8jgg8+rkzZuHBOtJMvGcvQRaepnsr6WL5XElhoXVyUDHBm50u13blJef12p1fVwBWx1aAoo/NHRzWjvhUPv7KcaWES5iRR8=
Received: from PH7P220CA0086.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::15)
 by CY8PR12MB7753.namprd12.prod.outlook.com (2603:10b6:930:93::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 17:40:06 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::c1) by PH7P220CA0086.outlook.office365.com
 (2603:10b6:510:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.26 via Frontend Transport; Fri,
 11 Apr 2025 17:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 11 Apr 2025 17:40:05 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 11 Apr 2025 12:40:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2 0/2] Cleaner Shader Management for GFX v9.0 Architecture
Date: Fri, 11 Apr 2025 23:09:40 +0530
Message-ID: <20250411173942.3324241-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|CY8PR12MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: 518a54bc-3d35-416f-c465-08dd791fe530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW5RdHRWWnR5YjYyS0lhbkVKMkZGbHRHOGs2NlVNM1RrNlBDRkprRHNXRUhW?=
 =?utf-8?B?N0tNMEpHVFRxbUZBN2EzNnNMd0lCd3A3WktaVGpOZk5keUdxOHd5ZVJieHVQ?=
 =?utf-8?B?VHoyRnEzblIyckRYRVRpNzl2UVBzN3JZZnZ3Tm1rTzdkUjVhcS96L3ZGOXU0?=
 =?utf-8?B?Z0JodS9BNlRVYXFpU1RFVHFnTnpaRld6bFhRWmdYOTJjRUVLdmNzcHhPcU5x?=
 =?utf-8?B?aDhNeWpCdjRnYm1GNnpDSk5nbzlkYkRmZ0xuZTZXSDZpclRRdExHTnlVSXNM?=
 =?utf-8?B?cUJqQVJGQ0g0RDZybWNuZG5DRzBkUS9oMDhUU2dRbDdES0N3bHordDhtN3RS?=
 =?utf-8?B?NFNhSnJ2MllIRFlIQmFWcUxHaXMrSDBaME42ZVdxNG5ZUmxNYkxFU1hRdDlZ?=
 =?utf-8?B?cFFROUVJOEhCMzZLK1FzTGYzeU9jMnMvRkk4UnN1Nmo4SzBaY2cwR1NNc0ZL?=
 =?utf-8?B?K3pIdzRBdTlya1NMRk4vWCtuN0JCM0FkK2VRSDdZNldNc1RHTnNwNHI1ZVpC?=
 =?utf-8?B?ZmwxQnhGNkpwWkpzSGV3U0pkUHBuRUhwVmh1QTFPbWxhVGYzVkZZbFIzNjEx?=
 =?utf-8?B?Wkk2MURhNXZ4THp1bXV6T1NKNVFKNDZYdlI4L2JkcWg0Q2hjZjF2c1JGbnV0?=
 =?utf-8?B?S2JKZHFleHBBM2pPeUppa0NWU091enArL2d1TUNBZUVzUWhRZkJjcCtPelRE?=
 =?utf-8?B?UWN6cDVpemxHVjN4bzZYOXorRTBrazR5M3E5T2hUM1BGZEpjb2laQVhNM0dP?=
 =?utf-8?B?Znc4d3M0VTJDYUFzbzBLUTVvU1RzdGJQVWJRbkdnZitqcUNyY1FWRzJPMUti?=
 =?utf-8?B?YlRRMmRvTjgramMwRU1QTDB6R2RMbmp6RW13YWo2dXp5NUJ6c2s2MzJldDE5?=
 =?utf-8?B?ZDZndUJhMjJxMmtGemlyZ2FRbGloVXIxaFJMYk5jQUVNYmtVeXFMZkFzQit5?=
 =?utf-8?B?NE5oc1htdWZBL091WG9iT3VwVVhma2J6bnZ3YmVUcllCbDRRclIvSlhORWNL?=
 =?utf-8?B?QW1FMlZSMnBVdEhFUmpuc2FXOTNPcStPSTNkUUVKNk42MjZOQjhiK0FuOVE1?=
 =?utf-8?B?M3pVTm9UVytKT1haaEVraE1nMW9FSjQxRXE4Rkp1VGxRUlBKdzkxN3FuRHNY?=
 =?utf-8?B?VjgwM2RjdEtlNTRCQ3hmWEJGajJBdmtJaDQra1NYVUJEZmVad0MzZVVSYVpB?=
 =?utf-8?B?eVl4THNZNjMrOURRNzYxVVlGNDhINmlDcjh3SU1KR2FJSys4Tm1ETXFDdnUy?=
 =?utf-8?B?ZnlJMEFVNDE0Vno0Sk9BTnB0NGlMbFIzR3FvekdSYkcxNCtPM0M0aFpLTEJH?=
 =?utf-8?B?K2lhNThKNndjclJIZHB4RWdOQWEwbHBVeEVXM1lDaTFscUVwS2lodFkvaisx?=
 =?utf-8?B?YkZRcjhFdDhpcUhuZXhFRFJadno5S1JaNzlVamw5NkNmQk1hK1p5VlRZYTV4?=
 =?utf-8?B?NEZhSzd1VFF3dzVUY2xaU1N6OTJCWDVZOHJYWTBCVWRKVVRESzF0Q0RxV0ly?=
 =?utf-8?B?bUFNU2s4bHl3REZBSStaZ3VjWTFuZFNzS1ZaelhZZlhhVkhsdkROSUtaQmx2?=
 =?utf-8?B?ZTZ6czNWRUw5L0ZEak85dTNlazhVNnlKVThpMUFCeWVCcC83enZqbm1wWE4x?=
 =?utf-8?B?MUpHN1ZxWXpZNFRZZHRyOWpQN1R2dWJjc0hvNVRhMFY3aDhTSDN3SysvSlk0?=
 =?utf-8?B?aUw1Zmt0YnNOZmw1c3d1VDYzcWcwaDU3ZXZsdEViS3JhMUVaNDVkQ2FNR0ov?=
 =?utf-8?B?cGtOaVVsSnhBMUdES01RN3YxTlFWTzVWZUk2bG00cmNILzFKSDFua1Nvay8x?=
 =?utf-8?B?YzMvTy85UFhQYWVMZm84WGl1aTVKMTN1eHlSZFFFRyt4U3NuYjVvSDJ3M3Vk?=
 =?utf-8?B?K3hlNUFldWxHSktic3c4RDZhckFrMnNGN0FTTjhiSVk3TlJKTmlSbnVaVnVW?=
 =?utf-8?B?dk53eXZLbGZaZ1I0T3NoKzhoTnMvcVoweWg1OXdHN3haVyt1VXlkb3VXb2o5?=
 =?utf-8?B?N0FreWFlaEJRc29tMDBFVUh6Um5CaEp5WTNzdTFBTHFINnFNVzBTNUhqT0F4?=
 =?utf-8?Q?zeKmH2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 17:40:05.1353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518a54bc-3d35-416f-c465-08dd791fe530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7753
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

v2: Simplified logic in second patch (Alex).

Srinivasan Shanmugam (2):
  drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER_9_0 for Cleaner Shader
    execution
  drm/amdgpu: Enhance Cleaner Shader Handling in GFX v9.0 Architecture
    v2

 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/soc15d.h   | 5 +++++
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.34.1

