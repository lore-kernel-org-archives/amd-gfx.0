Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45C6CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Aug 2025 01:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C92C10E83E;
	Thu, 21 Aug 2025 01:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i3L5VKCc";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C11510E83E
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Aug 2025 01:42:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWMhLbYGFb1z02DUMRcCJQjAbrpSjfwVpoOgbF1IVw4YozmZMIkyl80z1/n9Qde9sFXVtNrb3tSTFAkTJr0yeCYrrPhQ/nMB6Eu2TOrpS7Q19cpvR/QdD/N9J+1FiuWQ9orzb/nP/US96Y3zOdpBlUTFUy3JQOTAahv6vdh9nG0E5cAgxqpjWHd4sSPrXYjowy5R3+r8ihxjGZ3Welc/CJfwLtjk3sA4St/v85LiFtdJMlt//TGOOqNcRjmFyulvL086TX1V+fXL84gT1566Icshh66uhxHztcxf6OINqrdFvlZPAIpOze9CoDC0XP3O7991Lyv0Yq2mMINLgQJCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=XhQOLk4HtPiw3F/COdbQryq8peYmqmHYImbbdw44aoMN9nyZmo+KxsL1zRSL2Capw3W4/PIozNTiDoer3qpozwmQ9DBlZsIDH13CNEcrUnFd1MziiMZzdLUmOnm9toXegOSenJA4NAHLp6BnJbHtq1bQtXREG+pmGBfw+isqa35urtVioxeKQAYhOE9AzSOlt8gCP/PbG8YDuMHxZqXC/YlgSTHValTCsD3RhbBanreGkNGbmcYAcq0jxwKHC2+QmGrDs66a6pCiihtRfhlp8FwqH9MIR3A48ksvVbK4mu+puvyb/hOomxrobknIXiutFSJ4MGwmvswm6GB1qV1YDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/V5/pMeu1Uv5JmKufrRU7/BhvtRuLEfxzjo8UUtxMs=;
 b=i3L5VKCcEionpu7Ei9QkO8KKodA5hnobuU8efxjdtP8IV6xR09zHsa+xv9tzlDNxfSnzEM8tH/sM98NjY0jLq1B+xNLjfZUDnpQp6nbYvLbynF4HfLCdBlrdUynv9QNSQEhfOC5xPIom9DOyITM0A4Cfew50dw1Vp0YpTKQYMfI=
Received: from MN2PR13CA0003.namprd13.prod.outlook.com (2603:10b6:208:160::16)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 01:42:16 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::e2) by MN2PR13CA0003.outlook.office365.com
 (2603:10b6:208:160::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.6 via Frontend Transport; Thu,
 21 Aug 2025 01:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 01:42:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 20:42:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 18:42:08 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 20:42:01 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [v9 07/11] drm/amdgpu: add user queue reset source
Date: Thu, 21 Aug 2025 09:36:09 +0800
Message-ID: <20250821014115.566598-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250821014115.566598-1-Jesse.Zhang@amd.com>
References: <20250821014115.566598-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c90e51-be7d-4e1f-856b-08dde053f531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?elRhcFNGbyt4bngxcHp0Z3V2TjJ6dk8rL1Iyd1hyOTcyTThqSEdEbEs2NjR1?=
 =?utf-8?B?aUVQVTJvN0JRdmVUQzllem1QcDBtYy95cW5tbW5oNlgxZjMrT1NxMkNzUkk1?=
 =?utf-8?B?aWZITU8zNlI0blM3Q1R3YkVJQTBwSC9vV0lkM3ZHT1J6cUEzbTFxd2J3TFFM?=
 =?utf-8?B?SWg0a1B3aXUxbExHc2tEUFVXT1B3dklwRnhOcGNhektaZXFzZ0Q2UzJHKzY4?=
 =?utf-8?B?WHM4aXZ6K0IzemEvd3NOT0lQSThpaUlkdDdGOFRNOGNoSERJTVgxeGJOWi9p?=
 =?utf-8?B?dGRCSUQ3ZGgzRTdtRXY5Y1pVNkhyb0ZiTmg3THlpU1BMNnFPM1dBQnlCTEww?=
 =?utf-8?B?Ukx5aWJRczlqUmY5Vk9GZzRyMjZuMWk5b0Z4ZWlaOVZ1clR5OUd6T3N3ZS9O?=
 =?utf-8?B?RjQ4aWxONUg3VWg2RkV6SnRKS2s3RmF6MzJubVcxZDlST2NhUVFEN045bW5J?=
 =?utf-8?B?c0JySTJBcnhzZ0tZcWtiZ01Vd1prVVhZZ0tZMmVoQ0NPa1dNRFJ3L1pXWWRv?=
 =?utf-8?B?QUIvcHVCZW15L3hLZy9NdDF4aGNDR0Z4ak41b2xCdEptY0lLT201SjhuWEVl?=
 =?utf-8?B?MTFPSCtwTVhlQTRPc0R0NCtlYzVDamxxYVRXR0ZEWTk4cmFtb0lXNGpVcllj?=
 =?utf-8?B?QzZRUFA1MHYvTCtCdCtIaUlEOFJiLzlSUzNlVHFodWFmalpRMFdIWk5BV0dV?=
 =?utf-8?B?cXR3cVVOUHdNWGlFMzVLc0twOHlRcDRvek5CZDN2ZExRZVQ4Si9DZDZqNndQ?=
 =?utf-8?B?TmV6OVY3L3dtQWxFeE03VmROeUs4M1p1QnNyRUs4anI3NHFIM3JQR3VwdFhB?=
 =?utf-8?B?MG9YY3lVS3B1aEoyVUdKRWVteWttdjBhZTgwY2l2eVRjOFB2NkxXTlYwQkJp?=
 =?utf-8?B?TVFWeXY5TjYzSTJkU3ZtK1ppTzBkUGZsSTZ3RENIaC82MEQwdFI3WnlJbGtN?=
 =?utf-8?B?R0FEbTh0SEFNTUh4N2QyZDNqdzQxS3ZUWHcxeTdrUFhxZ1o3ZzZZTnZzSE5P?=
 =?utf-8?B?aFFCWnNFT2pxMlVpSXVtb1ZYNC9lK3RxYk15Sk85eG84dGVxSDBRVjNDTGI2?=
 =?utf-8?B?VDAxbDJZSVZNTE4zQ1ZxK01XZ2d3V0gwb1ZWL2huM29RQStmcmc3dUxoR1BG?=
 =?utf-8?B?TThnemRtMVNkc01BZW1jdmhyRitxQjQ1YWVnVVVxSXBnVlZVT0VCTlVqaEx6?=
 =?utf-8?B?TGNBbFFBb2s1L1dHVlVjcEVoeHFPTVc4Y1pnd0RnUUkxNDZoQi9WN1VzV0Qz?=
 =?utf-8?B?aVVQQytWQkFUaGFrZkRFaWx2UGp1M0c0TUR3SUhOcjB2bGhjcGRlZndZYktJ?=
 =?utf-8?B?cEZHSUlzNHN4bE9pN3lXZ3dTbndQWWZXRzNZU1YwRGxqVFQ1QWNvVGs2K01C?=
 =?utf-8?B?bm5sSzBQeldjMkkxUHM2VjRLVE5vb3RDR2ZmMGZ0SmVXcTdzTyt3UzBPMEdK?=
 =?utf-8?B?cVd6WTRZTEtLZCswQ3hOMDUrdDJwbWp0ME5EaHJlcWFQa0c2T1NXKy8za1ZW?=
 =?utf-8?B?dUZxRHJFWmdDRndoSWw2d3JtRXp6dTlmMUNibUd5a28rLy9MZ1BiL3VFMG1m?=
 =?utf-8?B?bUxKMzZpWUc2VGZVaTJRa0hkVnUzL3daYjU4OWlMVnhVeVk4UGY4aHR0L3ds?=
 =?utf-8?B?eko3RUFvMTlvTk45SmRycThvSjdMOHBycTJESTdudzc2TkJ2RGpCcFJiYWJq?=
 =?utf-8?B?WWFLTWltYUJlWis1Ti9XZXpNQXhjbWtsOHd3aXByQng5ajhZaDQ5TWNZbWNW?=
 =?utf-8?B?NmlIWGNZRUl6MDR6NlNtVmpnZUpoNTRuUGJlKy93WG9ZL1ZSb2VZcnhqaUZU?=
 =?utf-8?B?TGpTS2R3aXhEUUszZjBvdWpkVzBqaGNUSllhMWNGMFhpSklLTWV3bnEzUnA1?=
 =?utf-8?B?L0ZoaU1CcjU0Y2pPUVBuQ3BiQ3dEeFhOL1JRSDNCQzJVUTZRbXA4SmRPZ25Y?=
 =?utf-8?B?c1BXTEI4SzlLWkVKMkRUaVMxYTk4Y0R2SlI4WEhRUXJVOGxlMXpIbmFZdHBI?=
 =?utf-8?B?MXlrQ2xwNlRJM1lQcWxZZ0R0L3ZxMDhVSFNjUXl6NmpuNjJ1elYwelVDR3Rr?=
 =?utf-8?Q?EEvl3+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 01:42:15.6622 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c90e51-be7d-4e1f-856b-08dde053f531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
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

From: Alex Deucher <alexander.deucher@amd.com>

Track resets from user queues.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index dabfbdf6f1ce..28c4ad62f50e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -340,6 +340,9 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 	case AMDGPU_RESET_SRC_USER:
 		strscpy(buf, "user trigger", len);
 		break;
+	case AMDGPU_RESET_SRC_USERQ:
+		strscpy(buf, "user queue trigger", len);
+		break;
 	default:
 		strscpy(buf, "unknown", len);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 4d9b9701139b..ebcea44dd743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -43,6 +43,7 @@ enum AMDGPU_RESET_SRCS {
 	AMDGPU_RESET_SRC_MES,
 	AMDGPU_RESET_SRC_HWS,
 	AMDGPU_RESET_SRC_USER,
+	AMDGPU_RESET_SRC_USERQ,
 };
 
 struct amdgpu_reset_context {
-- 
2.49.0

