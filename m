Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA7ACA0EFA
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF8710E1B1;
	Sat, 23 Aug 2025 07:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxzNAEii";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7575510E1B1
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tor7Zxm3mhOnTFQmgCqWJBoZ68PCsWaBxDwLIm/YMP84RLZwx23P1ax9VxILi3TfTy01nNbPupmNrMdGJsjRY2Vs303CPbUSt0K/mzQTsDaOMp8D1cKDPHSyTMJc+e2fExcE3SozF6+Bl5CRbXX/r6yXAz7E6rBiZIQgKNMziREqh8YuNniwkj/Sfb3cxr2Bkrbm+we5UeOCMM9WctoDdX0UCS6C5JjXl0739QkZG9Duh6tsEQJiZM5righ2j2C9Ugf6lJp7BVC+18aWyRgwD5CPnaTANXFvsZN5eZMJ/uHMam9vTohKg3M15gs7c+vDzXqakEOESmklwncSv/ykdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=df83QykO2Gb53F/TML7rw0TAW/NfbT3+5PRYmuWM0r8=;
 b=FTsX7jBukx22Fda7C8efWDWZBgBcD0xd94rMUDTX3pSJgAgukQvF2jdngQMQ96e9AazOA2V+WvRj5CMDPePyVaUj/+Kn7ZSJqS6Jq4dIsrUXmzBIGI/0by1s0Vfmf6Noo5+WcZIeKwlvY+oS9dkBw8dzhzuXsceRtSWuH4lTR2IhODs4W2HdT/4N90NBVyJA635LjIAy+rmN9iDcgX9oRjSiggogHKn4vzg2jzI1QIK+quC2oWRcx7i8sZzQV3zNtDPFAvkpI97oWjwe8jKECwG+kaffe3OO1mreRAa2ruVtTTZtEe6Ps8wjqWeHUQupsuggzeMdNMFGoCkhFGHTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=df83QykO2Gb53F/TML7rw0TAW/NfbT3+5PRYmuWM0r8=;
 b=NxzNAEii3buBP9zWEiGoAoaec5JuShboXvkYrfS1O7ZeomeS1SUs9nOKWwGRkzJNnAVPDEjFw9wMrN/uO7KsgM5hGj3zK09f3Nktl883pViyIckwkoQyPCxAliy7rh8AcsPUZBztCE8qPg5YBhxbiv+vE67YiRJSPsbO184aSZc=
Received: from SA1PR04CA0009.namprd04.prod.outlook.com (2603:10b6:806:2ce::25)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 07:20:37 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::34) by SA1PR04CA0009.outlook.office365.com
 (2603:10b6:806:2ce::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 07:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 1/8] drm/amdgpu/uapi: Introduce
 AMDGPU_GEM_DOMAIN_MMIO_REMAP
Date: Sat, 23 Aug 2025 12:50:09 +0530
Message-ID: <20250823072016.1272328-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4c34a3-7dab-4255-5534-08dde2158e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzNRYzVHcVgwR1NTMlVRRlIxUGZSOWhLTEJJT3FwT3JoME9JWVRlYU1IZ3Bz?=
 =?utf-8?B?QjJWbDAwRzlXMnhFMi80dXQzRFp3N3VUcXNPNDN5bjc1K01jUkVqUTZkSkdh?=
 =?utf-8?B?ZEhvWXpRUlFyVDZYMzcrNy9WMlNEdXVKbzdTSG9qNnR3Q3lCY0haTzJrWUR1?=
 =?utf-8?B?NldOM0VNbWVSYkIyM0EyVFFJdWJkajc3bVBtcmFKSnQvVi91aG9FOGgwTUVF?=
 =?utf-8?B?TjBtcGRZZmlXUy9UbFkwSEtrSHlVUWlXZXVMci9kMFVGc2JzUERlMEVqc2pr?=
 =?utf-8?B?a2FMbnVjeU1VUERlak5PcXlZOEQwY1QxRHZIUG9pWGxhSXNlOE5iTXRJa2ZT?=
 =?utf-8?B?b1k1Vm12VHhhaUxWTnNTcDV4eHl6N0V6SXFUK3JLcDVkWVYrNVM3NWI5M3Zz?=
 =?utf-8?B?akZWbVdBeExwYW9XYndrRFpZQ2NvbythS1Q5YVlFcTVqWmQ3UVBtYVl3TEpO?=
 =?utf-8?B?R3JOVnM5WitxYXp5SUJMNkhlNE9KMWxBNzJMREVGZEl4UnFrVWloSk13Y3JY?=
 =?utf-8?B?Q3hhNW9KYlMwTjVQSVRndmhVRmNlMnVocDF5USs5aFZJd1lwaXR0K0tIazJ5?=
 =?utf-8?B?V0R1OGZtSmZjT3Z6QWZBTjVhZDVsNHNlZUdEYW1kNjdUcWpMM0xJcjlzQnFk?=
 =?utf-8?B?MEpOOEF0YXNDZktnS2E0RXJuWFZDZHNqOGxyWktneFVJWHZ1RVZ1dUZlREJ6?=
 =?utf-8?B?bTNUeWtCdmZEc2dDV2tKR2NNWXU4TklWWW1sSWJiM3BqdENtNTZwYXd6cEZO?=
 =?utf-8?B?NHYrOWhJZ2N2M1ZnOFpGQ0dLTzRSeWdxdVhTa1NzUlB3clF1cjI5SnVOcERy?=
 =?utf-8?B?bW52bnRvaEFLL0ZxZTk3cVgzLzNvaHdhczkzSnViYUJhemRuTmFneXNmNDcr?=
 =?utf-8?B?WmpKRHRpd0NGbEw3YjhsM2RIRDM5QWJpUm1IRElCenNyNFdCdG1NRXlZaWhF?=
 =?utf-8?B?WGthMUl0TXUycGNsU3VLVkNFeDNMc0t5NFdUU0M5OVJ5M2xkVWRXVjhlSVNH?=
 =?utf-8?B?T1N4QVhRazhqVG1WYnZGOVM4bTFzTmRYUkwxWUVLb3hmNXdLc1kzK1VwU3lq?=
 =?utf-8?B?R1czNVRobS9kQnk4czEvTmhHamhCTUdWN3pidHFoUW9TRGZyVGUwcXFNQXZY?=
 =?utf-8?B?MlFkNlY2MllCWXJMQjNPMkFFa3JwcWN0U2tRaFpGTmpzN1Y3Q1BJTGlJZUlY?=
 =?utf-8?B?V1dzVklzUGFTSWZDMTRvZERjZGNWM1dYMmdaQi9vS09qWEo3TkpCTGE1anpl?=
 =?utf-8?B?aTZxSDVnakFoZ2FLbndJRVpZUUw0TmVjcjNrRWpxSTFhRWZvL3RVWHozZjJt?=
 =?utf-8?B?eExmZ01PWHpUOGpPNzZpdG11ellTTjdWZkczTFo1RklEbEFiamFpdzI1VXhh?=
 =?utf-8?B?MXJGbzFRRHpxMjUxL0FKL1MrSGN1U0gyT1pOWFVsZ0VlbFhXU3ZCUlBMaTVH?=
 =?utf-8?B?MTBleDRvSHBNODQ4eFhieFZzbitGc0pyOHREWXprZzE4NnRiZm5lbzAxaFY1?=
 =?utf-8?B?OFlBNUUrcmF3NCtFdEJ4bW9KdFYvemRvVnJhbGxhaFQ3a24wcmJiWURUQmlv?=
 =?utf-8?B?VlczSzJRK093ZUExNnpVV0ZjYkxBUzJlRmYxZ1g4QmtCYVZudnVEYy9iWTh5?=
 =?utf-8?B?RzRQeWVSeHFYVEZmR1daUTVZWTJxSWZYbGJiUnlmOXlCcTR5QVNTWjd4OEZw?=
 =?utf-8?B?MGRPa0VmajYxTGJ1clJ5aXFUaFErT2RRSEF1UGtvVndDTkljOW41cWl4QnI1?=
 =?utf-8?B?K1QvVlZaVUJkMmhFQzl2TzJpL3pUaGtHcFN2K2I0NUNMQWtpZ2J6STU4LzdK?=
 =?utf-8?B?MW14V1lQdXpVZEVJRDZYY1ZNWlRJMy9zVmhmRnlFVGZTRDExdFFnSHpxUlBw?=
 =?utf-8?B?a3hFektaYWx6eDdsR1lZNnFGeEp4NXBVNnoxc3prK3pYUWhLYnlZNUY1bEw4?=
 =?utf-8?B?c0dLUU5NQnd0NGkrTTBBTEtmNjJvRldjbGpLZW05aUkvWUFYWkw3VTJXMnpP?=
 =?utf-8?B?ek9SUWpPd2J4TEp1SFNHdkY4OU5sRHVmMW8ybHNvdHZYQUkrWnNCNUF4WlJC?=
 =?utf-8?Q?0Q49uG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:36.9319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4c34a3-7dab-4255-5534-08dde2158e88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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

Add a new GEM domain bit AMDGPU_GEM_DOMAIN_MMIO_REMAP to allow
userspace to request the MMIO remap (HDP flush) page via GEM_CREATE.

- include/uapi/drm/amdgpu_drm.h:
  * define AMDGPU_GEM_DOMAIN_MMIO_REMAP
  * include the bit in AMDGPU_GEM_DOMAIN_MASK

v2: Add early reject in amdgpu_gem_create_ioctl() (Alex).

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
 include/uapi/drm/amdgpu_drm.h           | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e3f65977eeee..d8cffd26455b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -464,6 +464,9 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 
 	/* always clear VRAM */
 	flags |= AMDGPU_GEM_CREATE_VRAM_CLEARED;
+	
+	if (args->in.domains & AMDGPU_GEM_DOMAIN_MMIO_REMAP)
+		return -EINVAL;
 
 	/* create a gem object to contain this object in */
 	if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index bdedbaccf776..fc44e301adbb 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -103,6 +103,8 @@ extern "C" {
  *
  * %AMDGPU_GEM_DOMAIN_DOORBELL	Doorbell. It is an MMIO region for
  * signalling user mode queues.
+ *
+ * %AMDGPU_GEM_DOMAIN_MMIO_REMAP	MMIO remap page (special mapping for HDP flushing).
  */
 #define AMDGPU_GEM_DOMAIN_CPU		0x1
 #define AMDGPU_GEM_DOMAIN_GTT		0x2
@@ -111,13 +113,15 @@ extern "C" {
 #define AMDGPU_GEM_DOMAIN_GWS		0x10
 #define AMDGPU_GEM_DOMAIN_OA		0x20
 #define AMDGPU_GEM_DOMAIN_DOORBELL	0x40
+#define AMDGPU_GEM_DOMAIN_MMIO_REMAP	0x80
 #define AMDGPU_GEM_DOMAIN_MASK		(AMDGPU_GEM_DOMAIN_CPU | \
 					 AMDGPU_GEM_DOMAIN_GTT | \
 					 AMDGPU_GEM_DOMAIN_VRAM | \
 					 AMDGPU_GEM_DOMAIN_GDS | \
 					 AMDGPU_GEM_DOMAIN_GWS | \
-					 AMDGPU_GEM_DOMAIN_OA | \
-					 AMDGPU_GEM_DOMAIN_DOORBELL)
+					 AMDGPU_GEM_DOMAIN_OA |	\
+					 AMDGPU_GEM_DOMAIN_DOORBELL | \
+					 AMDGPU_GEM_DOMAIN_MMIO_REMAP)
 
 /* Flag that CPU access will be required for the case of VRAM domain */
 #define AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED	(1 << 0)
-- 
2.34.1

