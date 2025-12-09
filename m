Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDFED3B7E2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 01:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800C510E45F;
	Tue,  9 Dec 2025 01:26:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PZgKXxW1";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013034.outbound.protection.outlook.com
 [40.93.196.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB4E10E45E
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 01:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JSNsKjjrqE+NpnHsZS6Bz8BKh7bIkZxutdRZGfzS+pyr9UgsVC4BRZNY/mMKN9uHHd6mWSUWtWkGiFc/KBjy9kMGlYMbCFuaF2rrelkAOk0SW5RzhDPEVo0OB2kukRhFdEWXI1jKVv01XZPV54cVlZC+EvtZntafrwo5PtxFA3VCPMVmkgEAMx8v7sHbj7LhZUl5IizsFg2rnAhJRdu84CIb40tETb3bEPS3yDUCtZXbhmn518HCG7O0dcV1CmY2lsVbXQvtyHrQQjG8QLQgpHp1//B+rStiikaoAbcr2TEJxYXckFHwswz7633orAEmCX74N+DVSi4BGkDJfSKifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtyArNgPcmnkD2w2VYsBCM3WD2xQMbdkllZ0o9g3x/s=;
 b=J/HvhWECDreKVWlGkCKV+hHPU7fjgzkZOCXHF3BVNhAucotBfL5k/eAGnusGuxnW4A2hooe/D53EeJLVyYC0YH3QDyL8ZO/zQaa6RJTcEpFiueqP8NQfePoEM5ZOYyvbfpBGtzk7p8T0ChQASRRwGiAcEQAZmrLWGzg91lbDHPdPkswn/3nGKhQ6iaP+zIfC794WH+SGXVWjN1Uwc88w3mcFyFZQkdVBCK03fg7XP+Cwor0T+4S0fcm+3NqPOi1vbiPuCfwZZJV4phcnHadBe+tcxtZBacapdNslddF8bxnw2vFXaLeFbqALSG4H1nWXkfHuo0sCK3oRZOOor4xuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtyArNgPcmnkD2w2VYsBCM3WD2xQMbdkllZ0o9g3x/s=;
 b=PZgKXxW1y3XOxfrzCcGSUcy+L4bhmL47+h8GeSoMhDidNk2aBHYGZp0+n07g5cabNaEuMKn9HNVJEF3mZNE6fOl9oZC7kqkldB1RKIxQ6y6GGPSm2DQsOPAAoU9WSExTBUbPdXWWzlpBWcO2CEh9VToxGzHGN1MlzUwhUDSEkC0=
Received: from DM6PR04CA0017.namprd04.prod.outlook.com (2603:10b6:5:334::22)
 by CH3PR12MB9028.namprd12.prod.outlook.com (2603:10b6:610:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 01:26:13 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:334:cafe::86) by DM6PR04CA0017.outlook.office365.com
 (2603:10b6:5:334::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 01:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 01:26:12 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Dec
 2025 19:26:06 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH v4 2/6] drm/amdkfd: Bind MQD in GART with mtype RW
Date: Mon, 8 Dec 2025 20:25:33 -0500
Message-ID: <20251209012538.3882774-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209012538.3882774-1-Philip.Yang@amd.com>
References: <20251209012538.3882774-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH3PR12MB9028:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d85945-3477-4f9d-7c52-08de36c1f0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yi8rdXhUeDJzZitjRENSaFVwRjhYcC8wU1JQM282VGpRbmp5cUw4dUVhRGIy?=
 =?utf-8?B?dHpleFJyejFuUEtQMkhFQkdtYTVqSUxNYlRGSm5ZckZUcWZTL2tNc0twRlhx?=
 =?utf-8?B?MEZNd2RBUTFQNUd6d2FyQzdzcm1Da3J6ditlVkU2TERvbzd4VDBpRGRNRXR3?=
 =?utf-8?B?c3FxSWVZYk5tcEo3blV5QUFuSFNib3c4NGlURlBjZWJVYWNudUlpeWt5TDlJ?=
 =?utf-8?B?QkZ1NlkzT3RORzA2V1JWQ1BRUDBTdG15TEZQYXBlOUE3Yi9hY1hUUTNWa1F2?=
 =?utf-8?B?UVZCY1FDSGFFWWprMWZZK0FuMHBMRTYwdHEwODhhWTVic3NZOS9HSGlIbDJr?=
 =?utf-8?B?NHA0RnZ4K2prQUZJSzNlWEtMdXMxZnNLK2xRbytQR3Yrd0xBY1dNYzAwU0hM?=
 =?utf-8?B?MFJ2Wk9aamV1dk1lRFF6dk44MGVlRVlNakFFc2VuaktOOWc4WWkxb2ZaaHlP?=
 =?utf-8?B?eDZNdWZackQwaUVqdXpEZm4vVmE3TC9QUUhCUjdHbWkzVnVTSjRtTUFEMC8y?=
 =?utf-8?B?ekI4cHFPUkZZRWhLT3Z6RUVkdis2WWxxWGVXT1pyK2dIS2h2SDBLd2FFQ3Ny?=
 =?utf-8?B?L1FjQVFhMm9PZmNEeVFhNVV0cUdzczNqTW9QWklqbjF6a3djNVNhTXdEeUhl?=
 =?utf-8?B?NDJLaDJOTXlPK1ZReGZrZk03UGl3ZHZrUGlpanNBcTFOLytXNkp6NUVMS2NJ?=
 =?utf-8?B?ZkFxcTJyNGNTTks0ZUdvRDE4NzhuZHRsdldPbGhSRUt0MGJIK3VHVjRaNHpi?=
 =?utf-8?B?WmF6VERWaGM4WDA1QjFqQ0p1dXVhcGdMTk5HSlM0bmw3Q3NaVE8vNzM3S3FT?=
 =?utf-8?B?Vkx6b1g3UmllMmZlRElaem1lK1Z0bHFHVHZwMm5BVkJ2d3phSUFyYjljT0JW?=
 =?utf-8?B?Wkc2L0I4b1pNVWpDTFE0ZEE4TlB2SE5hVGt1Z3doR0hzZVlGeGVFRGwwM1lw?=
 =?utf-8?B?YjRmN1VKU2ZxSlJDN2thMURvTjZMUUtMcm94L3ovaENrc1R1SWs5WjlWSURp?=
 =?utf-8?B?NTlLNWhGd0NnN2lNZllSRGFJK0hHWXlEZmdVbTJxQ0ZwR2hlY2Z0cFBPektq?=
 =?utf-8?B?RmZ6OE1GRWY4bm5ybDZtQ3lqYmJmUy9KY09vT1JMSytmL0xiM2lqT1NHRkxH?=
 =?utf-8?B?bzMwUmV5c2gwb2c3UWtwd0Nka2JLRC9VdTNnQXhjazFYOU5FT04xM1hsVzdE?=
 =?utf-8?B?dlVhQXg5Qy9lL2kyNFRUcVNXcmxYMDZkem5hZ3RlQmxJWmdPTGJVUVNVZWVK?=
 =?utf-8?B?RC8raitNQUJuZWt0cGpXMEhUZlRIc3FpNjloMHNXZjcrcDhndHk1ZHdYbDZM?=
 =?utf-8?B?eXc3SjhiSUhvSldBeDdrOFZQT2NLZE1xQmJVcWl0UWFGYTlEdVFVUGh0ZzhG?=
 =?utf-8?B?MUp5Vlo2d1ltTkJ5SCtYSXJXYmdHdDhJQ1llK2RKRmlpUW1PZUZHU0w3dmtn?=
 =?utf-8?B?VzZ6SVVidXlzQTJicG9LZGRCMWNnOWVqaGdzM0NDVjZ3aDRNWnJXaHU3Z05R?=
 =?utf-8?B?WGlOODJ4cE5TRkI5UVc5ZUcxcE8wcWdpVDVnVUZjY2NaTzhZSmVpdDZmT25u?=
 =?utf-8?B?dVdHa0NWVlhQald1bWZuVlhmRWV4dDlGTS9hWU9GdXdDaGRTdHFVWk1GYks1?=
 =?utf-8?B?d2ljQ3JPNVJaUEN4dXFwek1Ic2FGbzFVeEV3VzdtSHY5MXMvVXZhdGVIaDNq?=
 =?utf-8?B?UDMwWUU2SnQ0b1dOU1BhZ3NwcTBMcG5hL01ZYy81VE9ycDFyeHBDc25FazZ5?=
 =?utf-8?B?aEZuM1BhSGdkUjRuakJxNGh3a3B4Z0hFVE53bTc4Y1lvcFFtS0JtRWhxaW5U?=
 =?utf-8?B?VzdPcnRtTE5LZHl6VENxV0dKbDhkTHAyaFBNL3N1NEVuU2hDL1k4YVlablpq?=
 =?utf-8?B?Wi8rYXNMWXdKeFBhMnFCZDlQOFlhQ3NNUzR1VVN5cllCSTJFNTFSTzZ6YmFn?=
 =?utf-8?B?aitRZUtla0F5eStYK3Vnb0toeXhMZVNXNktnUlgwNXR1OVZLcTVLT3IxOXVy?=
 =?utf-8?B?UHZhOGU1MTJhQ2RYaVNGOG1WWW1mZkR4SEdCaThiSDBVNldLVlFMOHFTWkNq?=
 =?utf-8?B?VEFza1c4YlR6b2JGYi9UVE16M0dyc2lyTG1Yb3RGVmZVN3grdG8xblFBT0lZ?=
 =?utf-8?Q?R1fo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 01:26:12.9897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d85945-3477-4f9d-7c52-08de36c1f0d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9028
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

For gfx version >= 9.4.3, bind MQD in GART with mtype RW to enable
caching, to reduce queue switch latency.

Remove the redundant mtype definition in amdgpu_vm.h.

Call amdgpu_gmc_get_vm_pte with AMDGPU_VM_MTYPE_ to get ASIC specific
mtype.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 3 ---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f83d140b6ae..4f8bc7f35cdc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -853,7 +853,12 @@ static void amdgpu_ttm_gart_bind_gfx9_mqd(struct amdgpu_device *adev,
 	int num_xcc = max(1U, adev->gfx.num_xcc_per_xcp);
 	uint64_t page_idx, pages_per_xcc;
 	int i;
-	uint64_t ctrl_flags = AMDGPU_PTE_MTYPE_VG10(flags, AMDGPU_MTYPE_NC);
+	uint64_t ctrl_flags = flags;
+
+	amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_NC, &ctrl_flags);
+
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(9, 4, 3))
+		amdgpu_gmc_get_vm_pte(adev, NULL, NULL, AMDGPU_VM_MTYPE_RW, &flags);
 
 	pages_per_xcc = total_pages;
 	do_div(pages_per_xcc, num_xcc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 139642eacdd0..e34c8f854b2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -100,9 +100,6 @@ struct amdgpu_bo_vm;
 	(((uint64_t)(flags) & (~AMDGPU_PTE_MTYPE_VG10_MASK)) |	\
 	  AMDGPU_PTE_MTYPE_VG10_SHIFT(mtype))
 
-#define AMDGPU_MTYPE_NC 0
-#define AMDGPU_MTYPE_CC 2
-
 #define AMDGPU_PTE_DEFAULT_ATC  (AMDGPU_PTE_SYSTEM      \
                                 | AMDGPU_PTE_SNOOPED    \
                                 | AMDGPU_PTE_EXECUTABLE \
-- 
2.50.1

