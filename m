Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD03D3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCF2C10E67F;
	Wed, 10 Dec 2025 07:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zimXkAr5";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC1D910E67E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=miYj8ZKRikcG3vQItX+XvrGyfraPOuQ9IN2VEpz85s+i+BByGRHZ2aKz6kuFIKnZvMCYq/LpB2ZND3Raw2FRt7keOEPln1bNaZDgLoFTvy0B0ZCBqX6YdsAyy1wA+TVntUR7CT7OHZzW15vfez3senJtYxblQgzM082VEL9DkjMsvboWQw4C/TiYUOoMcAk443u9lzKP8in/73j1qyAUZrtmBvcUKALZTjHpir4WciXCF+iwQ48JpMfQ5lw516OKo7nlyCmLpBK1NI203Q6MMEYfuJxHaq0AceKOiYFZgFMn6c3Ku9k9s+miqyp1XxD5s9m5Acz4Qi3XAtVuD1Ocqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMY+xWKFu5lAzDqQ1O1O4lk7TXXJsM+hMSDBANrTM2s=;
 b=zFjDdNlV6RagTjkB6dqVSvgzteR03yNyLSTuu5RboqBy0CotYZT8zA4konFeYGP4hHbYypmQACxxkM2C8w1b6PUFqntxl6vV/0IYydcqlJ3f1lhVMLuq+vmjEYYi9hg/V0lxQ8gkka//GsgNrEgujL5kCkdhwRlU59wRdl5nKx+70DM7M+DRZMgp8kvS89CbVP7F9uFTTKBs6p/m8ObNdHw63oHUxDmjsUkJuQ7Xdf9s1J4HFzaOZKo4OdsBKiKW9lxdm4IUDHx8Z/hn2qyZavwE9HxqU2jZnHlHPmAak+JCOtDWYvUe1+G1r6NhbY3QTivEGUzMqslX6FSXbGj3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMY+xWKFu5lAzDqQ1O1O4lk7TXXJsM+hMSDBANrTM2s=;
 b=zimXkAr5OfRw8GNUjJIJcjo5NNEiZdu221Qc3r/SQAxtyBdjXWpMYWot0JgK8VECXQHulFRp1d1JAmeK+UBvSkxqY3uG5BumO+X7+MER5RwauBLNstpRXJR0K/Wqnd6qNVwi99pZoHspFRCdymUKKY0VvH0F6lxsB5K13neTRUY=
Received: from SA9PR13CA0055.namprd13.prod.outlook.com (2603:10b6:806:22::30)
 by CH8PR12MB9838.namprd12.prod.outlook.com (2603:10b6:610:270::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:14:33 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::77) by SA9PR13CA0055.outlook.office365.com
 (2603:10b6:806:22::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.5 via Frontend Transport; Wed,
 10 Dec 2025 07:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:33 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Add pde3 table invalidation request for GFX 12.1.0
Date: Wed, 10 Dec 2025 02:14:02 -0500
Message-ID: <20251210071415.19983-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH8PR12MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3f398c-b51e-4211-ed2b-08de37bbc4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXV1WlVkOVFwQytSOE45WEhIOWdCTSs1cTZVRjE5YVh5SjJxZzZKdk4vSTRD?=
 =?utf-8?B?dkdvYk1nekV5SGRlQjNabEp6aE9TUjBqVG40V2hQbGc3NHJBSGFTeVJ0ZXNS?=
 =?utf-8?B?OWt5aEtWYnlIRzBNYjdaaDFBUllEY2p0WSt3RVhQS0pGNXpUaUo1M2lReGhI?=
 =?utf-8?B?bW1JZ2ROWmFhQTVkaVFSL1Bnb0pZempjcjQ3eTNZaFAxalgyUUhLYU4zWTAv?=
 =?utf-8?B?UkVpN2dsQXhjcmtaeVJBSkhoTTBKRHZ0Ly9nMjhSU08zMGpaajllQ3RZNno5?=
 =?utf-8?B?T2RJZW80TlBoRFlGTzQ3OGZYL3I3OHZGUEVacGpkNis1bTJvWGVvWGhyZ2xD?=
 =?utf-8?B?MXB3akUrYkRwWEE5MmUyWW51UmsxMFV0M0xPcFcyOFJFdHpWMjE3TlFzQUcr?=
 =?utf-8?B?Nm1kQnZoVWZIMm5oSFAvaVA0QjhoZEhHSk5LU3B1SmZKNWRrNG5TSnVpMTNG?=
 =?utf-8?B?N3RDOHdEaWlvRnRVQkM0Z1QrUFpRRnpUWk9IQjhiSE1MeVVSSXpwRjlMYU1l?=
 =?utf-8?B?eitPVWRONFVpRkhYZkM3VjBqbnpocmIyWlVpYTRkSGZoa2JjZ2p0NE11clNE?=
 =?utf-8?B?a3kyY3ZYeTBYSzNseFBlVnNsRWpLNXB2eTJjcDFsdkErb09JQkErSzBpdzM5?=
 =?utf-8?B?aWMvaUtEQVdRZ05FMnMyaTlSWG5TYW5UTFRvUXZjOHNkMmhwUFJWdTFxS3N0?=
 =?utf-8?B?WkloNVdWU2toQXhzR1ZUc3AwWU92MVROVXQ0ekNhVWZyUnU1eE8rc3E4MWpy?=
 =?utf-8?B?Z0IreWYyeWU5emVXaStha0dyWkZKRyt5WUhDOEpPdnJaZnJsL25KZkpjOGtU?=
 =?utf-8?B?ajVKVlJvMjJVemp6YWxCbk0zZDdqSmJLbythTTlCeDBjQU1tZ2ZUc3NYUXox?=
 =?utf-8?B?VTRFT1VDWjIyNkUwa1J2UVNqNGg5Q25kWEE0WWJabnRzUmpGSXJtb0EwSE9W?=
 =?utf-8?B?S280ZG9teWIwRnJtYTVKby9nWDJZclVLcWY3VlM1aDFtL0NNNTd3ZmFVeDI2?=
 =?utf-8?B?Z2NRUmN4VTFXMFY4R1RHRG1aR1AwWUt6cVRUd3RIZTByYldSL2NscWh5dWdp?=
 =?utf-8?B?RktyMWhGcm1GS0R4N0prVkNqZVR6RmNYWmVJNThmSHJHYlR5MHZQMDk0NUtX?=
 =?utf-8?B?dW5RdFVubVV4QWV4aEEvRmpIOVo1QXI0YWFjSE9LMkYrVDU1QW0yaC8raVdK?=
 =?utf-8?B?cGdIWTFHNWlVMm5EU05kaG14TVVTL3ZHTHpUV2RTQ2ZPV1JFcFhuMlZqSm9O?=
 =?utf-8?B?c0EwSzBDeFd5VTgzRmpnWlp4Zm0xRkZpbGxCQjFUMHNXRllMV1V2UHhjSFM5?=
 =?utf-8?B?aURvTFpaK21wekZPMWFqOFMvQnZhSmJLckJTUUNYOWdqTG84R0hqODNNOHdE?=
 =?utf-8?B?UjFZLzAwL1ppTXFvSGkzMVBlZmx6TVQ4R1A1SytibTJNM2NtbGZVaHNmWnBW?=
 =?utf-8?B?T2IxbmhKaysrUjlsLzlVOXNaeXdwYjFxbXg5TExmYng2YzI2bDJlSVFkUkhG?=
 =?utf-8?B?blEvdnptUHBmTXBjSXFxeXpCQnZ4bWw4NEQ1bmZ4bVljSmZCNis4OUU3YThF?=
 =?utf-8?B?K1lObWpJZlhWelcrSnFnR0ZiM01pOFJyakVMWWhtM2Zhb2MxeHZVZTBWTm1v?=
 =?utf-8?B?alcrOW5Sd3ZCV0JsUkQ4c2Z6eGtUY0IyQWtSUkk3TjJkbzU0amU3Qk5qc3FL?=
 =?utf-8?B?WmJKME1MVDA2WGZSNEFvbm1JUEk5aDJiMENnS0owN0wvMG1lMWtWS2ZiUTJz?=
 =?utf-8?B?K044aitGOTNuMFUwM1VqNmlicnJuZHV2S1Fva3BIc0I2cUE5cHUyZElQd0Jp?=
 =?utf-8?B?NXh1dG51clN0WU1TYTd6bnd5UEN2eVlvSE0xOGRETzhGdW56Z0xHZEVSNFd4?=
 =?utf-8?B?ZWkyWEV5VXNQWFk1TjJXNDJCTWw5UVlJUlk3MEZnalhKckxZSkZnVVZVTVF4?=
 =?utf-8?B?TSt0WEhzVGNNaHduNzRCYVNwNnE3Wm1KNU9rVHpvRkZUak1uS1RJRVkzZThI?=
 =?utf-8?B?T0oyRUg3RkpOTHRETEVodnA5YkJ0SzljK0JvczVEeStqdC9Xc3p5RFI0a2pI?=
 =?utf-8?B?dUNHNlZLUlhwQXZ2dUE0MW5RUnRDdEo2ZFZzMnMrT2xkQ2UweU9UNzlqczBh?=
 =?utf-8?Q?28M4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:33.1340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3f398c-b51e-4211-ed2b-08de37bbc4b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9838
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

From: Philip Yang <Philip.Yang@amd.com>

Set pde3 invalidation request bit during tlb flush for up to 5 level
page table.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index ab002f327f763..8f1819d15bc61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -668,6 +668,8 @@ static uint32_t gfxhub_v12_1_get_invalidate_req(unsigned int vmid,
 			    INVALIDATE_L2_PDE1, 1);
 	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
 			    INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
+			    INVALIDATE_L2_PDE3, 1);
 	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
 			    INVALIDATE_L1_PTES, 1);
 	req = REG_SET_FIELD(req, GCVM_INVALIDATE_ENG0_REQ,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 75f7df7db5b66..7e917eb47a8c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -658,6 +658,7 @@ static uint32_t mmhub_v4_2_0_get_invalidate_req(unsigned int vmid,
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE3, 1);
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
 	req = REG_SET_FIELD(req, MMVM_INVALIDATE_ENG0_REQ,
 			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
-- 
2.52.0

