Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BA6C83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 22:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E4810E2E3;
	Wed, 16 Jul 2025 22:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="We2ET1Nt";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E145110E2E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 22:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4tXNfdZ9CTjCwMs2b5H+7na/XWt8udQWyBUVdLf7lx2WNEP4DPzPL+TcL4LtCSy2Cy5f7rwVhBo3sMeDmAa0/C0dCf9Tqvw5RVrNpGWFWMdyJrqAuaxIhe6X+pq5SJ6EfMo6gzoE8NQifqUR+a+G87LT+AyXjVBJBli/KDAMZNqGvPgw6GjIndarRrwgoy2ZfkuFsi6cDhIU9P1L/Gd6h6Dz2I+TmzuY/cJS44GBEOVJ+8LmZCS0jTjtVQCW/cxbGKiptcFCxL1LUQp2uXPZy3mZCwHurliJCwxON99eVkq5eMsedTF14rmhsYNLqrL44nk9NSz6crFcJMNX5IYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEGc+286M1OXqomCezduDIk9OYTymP2/qX5pqbT7AFA=;
 b=YbWPEPtdv8o6Jjir/wzzPXQTWEywJIIbZUfCL9IbpY3BwSKuCUPh8/7c1VI9zMSIRMbsdT56o67HrbinwhZj87IIR+1ob97hLSS3UPorWF2PHIfhgOm+fYfsBrML3xb7+gSp14wAAAbtgytvtlRAUPWq032ic/8NMEFjf2Eyj7d/kFswOXjbC+e908lOBRMXQRG3vbicdNtR7CGtnek369Pz8KHDIdrArZL9lYRsXYObgSLVF3wgwMbA4fx6+XR9WdzFYSritMz8PIAp8grwTgn8yMEKRvpAYu8HDsHbkBE2CYM8lGnyXu8pscYj0DykjYjdmRtn3mMcAEz+GXOGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEGc+286M1OXqomCezduDIk9OYTymP2/qX5pqbT7AFA=;
 b=We2ET1Nt/JJWy1Jw2pcx3ogwWZUY/8XW72VHexb71vtcdDCFD58Kg01xs1S9CH5SFI4wy+lgjj+L0KUv7gHFcLo7Yhlf9D/BKs6XaBUN83Gztc91VnpY+2iASk7rODuf5nkXEIxz+pOl6fx5n06Ku6JBRKkjfz1wWzKURBPo1UE=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 22:01:32 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::77) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 22:01:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 22:01:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 17:01:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: track whether a queue is a kernel queue in
 amdgpu_mqd_prop
Date: Wed, 16 Jul 2025 18:01:13 -0400
Message-ID: <20250716220115.3872837-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e07bf1d-76a0-407f-cb25-08ddc4b45350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bklQbE9qM1YwSjVuaG1FbzlDSkxtWE5XYXZWSThQN093UzRXT2ZKb3BjS1ds?=
 =?utf-8?B?Uk1MRDJzUTYzQ2VCQkRHcHlobklLRDRIN1lkaW0wcW5iNENQTE1WekZxOSs1?=
 =?utf-8?B?anlRVDh4dGFzMUNRL01aZmN0N2xXVllSSzU3VTBYSzNoOHZzMjR1N0xPTHA1?=
 =?utf-8?B?MFBLL1dndHNXRGRWbmFxUGlUdkRXR0k1TTRlRW9DSVFmTjc2R0lTVmlwbkMz?=
 =?utf-8?B?Y2UwbVBhSHB3S0tETkdWR2Z1K1UycFE2SHptWHpaaEJpKzVETHg0VVVibEVk?=
 =?utf-8?B?MHlCNmJJSkN4eCtkeTNzZHFzM1MrYnhjN3BrZitaK1BVcGNXeWlBRlJIcnla?=
 =?utf-8?B?c0lhOFc3TElRdU45ekVIazU4Y005UHVKdnNiK01PemFMb0VSRkExS2tVcDhs?=
 =?utf-8?B?N2dXMkVmU0pDRjFHeXJlblJWb2dac0xScEtDKy94QVIyVDNvTGlFbUpab1li?=
 =?utf-8?B?cVg4WWFPNS9XeVlOTjFlRmtrVkpMOTlwV2ZMNTZYOHJXdE05NGYxWkVvSlcy?=
 =?utf-8?B?WGJTU2I1MnhIVkFBVjEyYXpFQy9tc01aV0xNVnp1NWUyVDRVSDZBZENRU0pK?=
 =?utf-8?B?T2hiN3dpR3U3RlE5QjdnU3dWQlBpSUR6L01IRHl1amVyMFV4Q29wNkVoQkRi?=
 =?utf-8?B?eVdQaUxpeml0U1RIaktpcUJlYmx0UXFUbjJXK1dJVTc5b1FlQ1k2TjB3N2g1?=
 =?utf-8?B?NjV3NEhCSTlSTjVsYlM2NUhSYks1Vi96RUhNTEZEdEJucFFlT0NhZjhkTEZn?=
 =?utf-8?B?SVV1cEtaMjMyUk4yYUJoMlhWNEw2Y1NXekZzSU9zWVNxQUhiQi9qYUJ6Q3hi?=
 =?utf-8?B?ZlJsbWtVSW5UcjJPakRIbFAwR3RmVVBUR3JGVzY4c1p3QXVscWo4aFdCanMx?=
 =?utf-8?B?RmJhNlpqNExpZU5LVk1DTXJ1cDgrNW4rbGJMWTV2d1JKOWo3MitiRituMkl2?=
 =?utf-8?B?RkFJdVRFNXZqOTJQU3ZaSnRqNlhJandYcElLSWtjQzFzdlJ3MjNxc2VBVjRX?=
 =?utf-8?B?Vk02Z1NqR3FhNmtWeFVPaXBpeHMvQk5mZG5jVjd6UWQ0V0ZPTWFMWFA4Tmw4?=
 =?utf-8?B?RVh5K0lBbEI4N21KSDJpQlk5M0VqeU5CL1JBT1B3VVJxTVNTc2IxWkZ6RUln?=
 =?utf-8?B?cGRLT1lxVGN2Q2ZBOGR6TnZPR0RoS0RwcDlOeDIxTGM5bUNEYkZtMmVDWUZC?=
 =?utf-8?B?ZmpJejl0RUdzSzVXYW5vOGJ0WkNzN0NHNGZJT0pzRm1vTnNDTDRNZlg0ejVH?=
 =?utf-8?B?Z0VxNy9ITmJIdjBlYnZvbzc4SkhpYjcyUm1teWhKUXVIU05HVDg3bmNWMmZv?=
 =?utf-8?B?cldkN2Qzd00zY0thTFFWVVYxbmlCUGlUS2VkRjJjUkZZOWFPbGs3ZVFEYzMw?=
 =?utf-8?B?UVdrWjNnUW9hUW5LTW9pTzYwK2ZlVzdUZHluajlkd1RyRit3bkV5T0NQY2dj?=
 =?utf-8?B?UEJRNWRzdWxncWkzNWtQcUh0cm03bzdJalZoWkpjLy92ZWJZaWJGd3VlaXF5?=
 =?utf-8?B?Sm1NVFRGR2Z2ZU5XTVR4RGFIdC9WQUVPMDRmalhxSjY0N0s5U09WNkQrWFpl?=
 =?utf-8?B?UmlRMEx4eVJRUnpScFNzaVY0cVdocFJFZmdON1dNemZSQnpTNm9iU3pPNElq?=
 =?utf-8?B?VE1FSTlHc3lNSTFhaDEvdkFaVUhqSTJvaklHclZQMm1NTnlFUWVqMHNxZzRu?=
 =?utf-8?B?ZmZFVDNhTndJWVNPMjM2cElmSnJxYW1lUGVlWVQ0Snd6amNYK2VBOTVia2hr?=
 =?utf-8?B?SVJaQnJUajNRUU11MndCNkEzV1pOT29CV09FUkNGdDJCaUIxMDIzeUxIb3ln?=
 =?utf-8?B?TUZQVVNGVmdzYlBDSVdDSmpaZWpnSElQc2pzU2g0WjdkWG9aK0ZlZVZrdDFU?=
 =?utf-8?B?aWRaMVBzNDhQSFkwN2NORTV6QUthZnNCRmZFTXA0d0s4MkVzMFlFY3FDTGRi?=
 =?utf-8?B?Tm43NUxLSGIwanY4S2FjVUFiWXE1cmRnU3JaT3MwTll4Z3pmOEhVN09mVGJL?=
 =?utf-8?B?Z20zdVkyODhnaVpTdnVudGxra1RJdnhFVzFwSGlrT3hXK1lKUVJmZXdsUE9L?=
 =?utf-8?Q?8Xxd2E?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 22:01:32.7008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e07bf1d-76a0-407f-cb25-08ddc4b45350
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967
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

Used to to set the MQD appropriately for each queue type.
Kernel queues have have additional privileges.

Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a1737556a77eb..ef3af170dda4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -883,6 +883,7 @@ struct amdgpu_mqd_prop {
 	uint64_t csa_addr;
 	uint64_t fence_address;
 	bool tmz_queue;
+	bool kernel_queue;
 };
 
 struct amdgpu_mqd {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index acac646a4e4e9..617dc009a2550 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -719,6 +719,8 @@ static void amdgpu_ring_to_mqd_prop(struct amdgpu_ring *ring,
 	prop->eop_gpu_addr = ring->eop_gpu_addr;
 	prop->use_doorbell = ring->use_doorbell;
 	prop->doorbell_index = ring->doorbell_index;
+	/* kernel queues are privileged */
+	prop->kernel_queue = true;
 
 	/* map_queues packet doesn't need activate the queue,
 	 * so only kiq need set this field.
-- 
2.50.1

