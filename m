Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958E9D3B9AA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 23:44:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0404910E636;
	Tue,  9 Dec 2025 23:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pSX+2dTD";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 856E710E627
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 23:44:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0s9OqCn8kDeuiODt0s2slC3fZAmBYaasRX/yoVuVFJ0QAXBD/9ZRHccfrFm4cc3oNZ2MfnF5fw9VxTUn2wYt9XvfRKE5ERKvVoorCDQOUYY1QRpXZvUDMgJH35gVfI2n7SPdHcpW/OlKYtzhS8s4QEyLTIcYNMov9LaiQnyu/JMt7XEtQk/G79LN96xysT3zaur2atFnzxMdLZN3Kw4EcF6hh8nrjmqVfVRz0JWKv2QuaVIbgpEoszb6cYOmK3GKdJ3SFePLd9OuY+GDwnPx5PFCVQhH12Pim3acDgqpcLQCJnnjBDdCRV5I1e+VtCc1lbUwDzTbXeAenpOdqTlaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wtyArNgPcmnkD2w2VYsBCM3WD2xQMbdkllZ0o9g3x/s=;
 b=G3S0hTjJNk1OxwMkvTJ3D5Nuk2XP2DQ07apl8GlC1SVHpBKdFLqme6dxUHa+N7++dDqKANcMEUejHSYbiU48cvQrVLCZYyByjuMF46alMdXrPpCZ+dyv6j09SH0edck+x5n9hvii1lSzZdXqRJQmA9wi8AQZt/F7ePpNRXd6/PDjaN9x9WBTyUPRGXaB9ZpQ4F8Dz9jIDi+w5XpAkYlQUM6HJOB/m9H3WZTW+26OP22jCKfwV1KQK7SHDovzBBDrX3cJmyCn1VNSm0SsCNu0v4b6CsSaY6PfPeAMzR8/senRAt/LAdpZR3R/S5v0RpAqyqA+mQzarPH3pe+90xUWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wtyArNgPcmnkD2w2VYsBCM3WD2xQMbdkllZ0o9g3x/s=;
 b=pSX+2dTDOzNECdfSRDHJVIwJ3CUfI40nxsuucVwYR9S0PJPMtQtG4B6rz6iGglIan6IqgNidBeq8p68Q5nA9fk5iRJ4LoaWmxHiA6TQr22/2C0uBmatA0Hoj8q+QaVuy+Ri9ssUCMDtEKRxItargBBcQ86cMyO4LPoUbCSyCJoM=
Received: from DS7PR03CA0191.namprd03.prod.outlook.com (2603:10b6:5:3b6::16)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Tue, 9 Dec
 2025 23:44:03 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::74) by DS7PR03CA0191.outlook.office365.com
 (2603:10b6:5:3b6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 23:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 23:44:03 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Dec
 2025 17:44:03 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>,
 <david.yatsin@amd.com>, <pierre-eric.pelloux-prayer@amd.com>,
 <kent.russell@amd.com>, Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH v5 2/6] drm/amdkfd: Bind MQD in GART with mtype RW
Date: Tue, 9 Dec 2025 18:43:24 -0500
Message-ID: <20251209234328.625670-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251209234328.625670-1-Philip.Yang@amd.com>
References: <20251209234328.625670-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 168b134a-ae28-4b70-77c4-08de377cd5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXpMRWRjTmpTYlJhRXphUWZqbXdxVFMyUWM0VTRmMndBSmdPdm9ObE1UeXh3?=
 =?utf-8?B?SXZoZUFNdzM1ZnRmNUgvaEkzaHBRRm1RaTdjZnhRbUN2T2x4K3ZGQTR5b05B?=
 =?utf-8?B?UWh4d3Z5cTR3a2gyZjJDWHdjNUxwbWw0Q2RoMFJwRnlHemdQNFo5VHVCdS9i?=
 =?utf-8?B?RGtodEdRaXhHRXlpbFFHaU1uRENaeG1wOFZteDIwczd3a2VzWTJ5UjB1Unpa?=
 =?utf-8?B?OTV4RWJWaUFmRzM2Y3ArbnlldlY3ekxZR1ZleTVYWVp6QnpZczJwdllrQS9G?=
 =?utf-8?B?ZmQvOWhUK2JEeGkzYmJoTkxwVWtlc2JYYVd3bVozajFRb0ZNR2RaS2dhRXds?=
 =?utf-8?B?M1hVamZKRE1GTDMzUXRjUCtSRitmaVdRUE9iWlRuWldSeWNPdzRCUVN3TDFm?=
 =?utf-8?B?NUZTbkxINTg5Q2tOSkZOOURJbFVaTjVxeEt2cjRYYjRPaS9uNXdzbnF2b09M?=
 =?utf-8?B?VE5zL0ZjNy9wUTZnT09BWkVzbGRyVXpNL2RhMFNHdXNKRlBjcXlpak0ycGxL?=
 =?utf-8?B?QnlDOW5oMERMeGU5S1ZSdjgxL3dSZTJ6NEhQN1Q3S2JjbmhTamlpL3NlSFo2?=
 =?utf-8?B?QlY0THd5dXFNM0lyQ2VUY1NJdmo3cHBXVjBmejlxNzFqYUc1Yjk2aHJpMDZZ?=
 =?utf-8?B?SWJERHVRd2tqWEN6bGwyNzBtV3g4dWhGUHhuL2dVUkNYOHJIUWFZRkNLclV4?=
 =?utf-8?B?UDZWWkJoTkxKTHdVM0hDRDM0ZmhzaTJUdU5vOHYyYkdHa3YxZEVRZmNKNmh3?=
 =?utf-8?B?NUtWamMrbHVoSWRjaVBGa292aGFydmVtSWo3dkU1Unozdmtzbm1BNXZBd3gy?=
 =?utf-8?B?SkloMGZ6ZjdEUnBrVjFaMmIvOWx1VTlXSWRURlBwSlFEd0hHaEtTVmY3UlhB?=
 =?utf-8?B?QTYwcDVOdVQ2cUtBdWlXanBKQzd4OGhlT1VFZkY0cXFJMXRacWMzVE9td1R2?=
 =?utf-8?B?dkpCRk5iSUhvWFFqU1o0ZTlMOURpTGdiOW1CekVaUHUyVlR2QmxXeGhhTndi?=
 =?utf-8?B?WlZnMnZjaWlReHN3UTdvVU9XRlJ6NTJCbVBSNGNWQkVCWUFyUzhJK21HeVFW?=
 =?utf-8?B?TjZ6YjIwWUhHNis5RzNPOVp2SU1yYmpCZVRxMHBUQWlvb3MxNjEvYTlPYXcx?=
 =?utf-8?B?cURYa1VkQmU0MVJUOUNwVVZ6OUljSjJLY0s0VXNzQ0liRWJzMEJ3dExnZTda?=
 =?utf-8?B?RjFmMDN4d29vMmt0WXZFQ2lzTlZDMlNhMUVrM29mUldPQ0dGMllyTXpZNkF4?=
 =?utf-8?B?WW85UEpBVERPU0NITjlkQW9sU0UvRWlFN1lrTWNjTDRuSGZaRS8vaStGTlhN?=
 =?utf-8?B?VEpiOTBiczhBeFA5ZmhMNHdXZFhqVnJsQllZVTVpYWs3QXpzQ0VPZHY2UDhI?=
 =?utf-8?B?RVlFdjZibE1EWWh2bTBRTnRLZ3hzMllDeWJYWHhlZlpiY09WRmNXUTRXTC9E?=
 =?utf-8?B?Yk04clB1dFBDbUVLS0Z5aTRGbW9VbEZ2L3M1akdCODJhNTgxMTFoNWY3Z3RF?=
 =?utf-8?B?N3hmc1ZpOEFTcW9JOEdNcmxVR1NydWREb2E3bklNQlFqQmhxQk1vTWZKN3Vr?=
 =?utf-8?B?RXpmNXlkK3dVMGVaV1FPc1FqZ1Z0U2lJNzkrTjA2V01EdUovZjBadXNTM2x3?=
 =?utf-8?B?aHY2eURJTjNqL1ZRUVowU05ON05sY05uUzJScHhQL0E0T0FoWGxPdHlISjh4?=
 =?utf-8?B?NlpCQmt0QlErQnFaSEVnaGtkU3pZNElHY1FBVnJmaUVZZ1ptK2dHTmxpb1Ay?=
 =?utf-8?B?c0xDNjE2WGVxRnEyMU13K3dmSEhqMXlqbmQwWHBucnZGT09jTWxyWGEzZCtR?=
 =?utf-8?B?RE4zY3hCclZSc1ptMGMvZWVwTStkMGhIUUNHOVZKKy9xck43b2w3aC9lWVMz?=
 =?utf-8?B?RGRrQmpQcm5JK0hQL3RsYVMxSWNtODNMamgzaUpHbUlYU1VCNGhHd3hWRFJ4?=
 =?utf-8?B?MFBYUXYrWTIxUkNvK0d5WHlWUlVQWnlSNC9jemlpcTlYMGVHY21IQ0ViV0Nk?=
 =?utf-8?B?YXlIVVlPYytxSzA1UXI2SDJtZ0JYZGdWcjRnanFQdzN2UHU0Wncrb3hId1ZJ?=
 =?utf-8?B?NlZCK1BIZmtmVkJsYTBGbUZLSkp4SktETlNHY0pFNWpickVLTnhaMkJxbGZB?=
 =?utf-8?Q?Cu3Q=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 23:44:03.7926 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 168b134a-ae28-4b70-77c4-08de377cd5f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328
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

