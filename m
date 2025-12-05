Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0BCD374A6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A58F310EBC0;
	Fri,  5 Dec 2025 21:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3VPLE2yN";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010039.outbound.protection.outlook.com
 [52.101.193.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90AC910EBBF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/8lT2mKhzj5d3ZyCZR5I0lSjzDG/H1aYikW8yjMrh4HgIzSH3Bldji8W0h9DSMH1IHjNBO0k/nkhjbj1nL6jYnMPFEulrCpaMLXLnP1TjgmhCaHMqYhImiOoHqnWML33PosTybotY9S6/QxCar1d1qad9kMGmpu/ADIhtOWpsQfZ/AlCKVBtcqKIOaxaATi88csXE9d6d2hD/wXx5HkbVnGv7ugjOc9yOpfe2Cf11v3wg6nZ19u/Xi7dGUippJTpeMTAfvSF2n5JwRI2ocRCEd69N695vbV20YjhEfIivTeowUVi6u66tUt3hvPqBHcEbV3UxmR1/JOphZF+zRzJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pNSHd1M4IAEKLoktKKPk6UTDcn1Vpo8aEkbhGFrvjU=;
 b=bD4HpOu0qRknUiDuIAE60T+jPVWd8+mbqWOtKjSuxRnL6wQguVLANwsY0295pwYBO3XyH/taHNnkuRCZMwNg4Hl1EfcBpYPJl7NMpnhgGYC2uocYhLJN6d63QQ+2+Hhpj/b3B3WTJZEtVYFS2TvRYIqD1sqejeaMeSQVK/W3liWa1NssCewZ3/TE1UDy8Bxt00+FRL2XZUl1rxXejQZnWIFm7gU+323DvBOgGP3EISu1fE3IH0+gA33IdCaKCAsuPsGUbzmBkG+Fg1rR/+cdSlKlNr5XtUrrYUlkM61FFbDvqfZqrC24M3BBJFqhgsp5A+hmFbLeDk4XiZFX6kXt2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pNSHd1M4IAEKLoktKKPk6UTDcn1Vpo8aEkbhGFrvjU=;
 b=3VPLE2yNA5ve8LPwuVEhUmhTa7zYHc3cA344w1vmI8nQNYz4oTlNCkhtKnaCCL2psrq7L1A5Ob/3Zv63OGMtaM2PPO2vwweb3u967ZHETzwCMkYPoUpwJb88a9yhlG4/KM6kAh22/hnbSRAF32WVwUKT5/medq98MMKaxLfdWTs=
Received: from DM6PR03CA0010.namprd03.prod.outlook.com (2603:10b6:5:40::23) by
 PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Fri, 5 Dec 2025 21:49:42 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::b4) by DM6PR03CA0010.outlook.office365.com
 (2603:10b6:5:40::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:41 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Harish Kasiviswanathan
 <harish.kasiviswanathan@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: disable shader message vgpr deallocation on gc
 12.1
Date: Fri, 5 Dec 2025 16:49:15 -0500
Message-ID: <20251205214926.146844-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a29c531-9c5a-41dc-b042-08de34483244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FPO8DRB41wcq5a5CBL2dg7UzXAPun0lMOhomlKpvSWh7nvm26QJrhaX8qL+b?=
 =?us-ascii?Q?vaGWToktgL0nQE8NyqeVQJ6lOfvmPcGzqgS0B8jOOzWPdNVXfMe2yVeCHU+k?=
 =?us-ascii?Q?6OZ1eS9uK8OiSG4IkySYfcnWOMYnOYmX5OaRh3d1o67VMk1rIIOStkuBek7I?=
 =?us-ascii?Q?xzm/WLYhpRMtr2CEMPot/qN6t3pj5Ym0EPxMEytFKze6x+1XXRZ9MGIHS/Zd?=
 =?us-ascii?Q?UV3V3xRR+i3esInqzCyAqvFdt6hbd3tAuG7f+SNqfGkf6xbwmuhfR231Qu7c?=
 =?us-ascii?Q?HddbVCb11AD7ys9rI8iJ8nqD498KMDXP2KHu2kbPp7oniBFuCrPHCOYvxa0M?=
 =?us-ascii?Q?yUBVR8qtbkFKuK12ILvkC+6luocBKB5sTnvv293CsXi5Nfi8b9zg49TAL8yi?=
 =?us-ascii?Q?px6FwyEmrrFgxGJNHk+FgHABlQ+QxzWBRWi+lseHEpcHzaaVnrRDSf3wHIRP?=
 =?us-ascii?Q?nYbqkbxVsj30/0MVyBVg8y2Nu38v8byiEBeMXjvM8fcvAE8liaxqTCKojYPl?=
 =?us-ascii?Q?GXNxmv3+lVN0xR9/LoTl8yb11x5EUwDNh9Vxn32n46vYqv+6UFvON5dTAj7l?=
 =?us-ascii?Q?YL85O20bTMJZ10Bkx83grs48JBwNRXol6q0xeV7gMDPgnrErCwVS4rwAGDuj?=
 =?us-ascii?Q?/6Sz79m6retJAyIUIltifTNAL8JmgSOArWKz/szPVN0EgFVNA/n0pwmlOBad?=
 =?us-ascii?Q?J0zHw562H6zVT1ZLebdz+IwGew3/z7aH/Z7ID26RwGAScBfxpH3OLqBa3qHi?=
 =?us-ascii?Q?prK2kFA5XxgPcH0tv1bhpRNbYp16dMkQme8jk/jmNkATKIHZm/obcKpT+0xq?=
 =?us-ascii?Q?Y5mRthzGIlSNYfdkniyC+Fvxq7ZO8d++hK0FZxtwEXFCTk0NM4sf//5Z1unx?=
 =?us-ascii?Q?tncfS8B1aNtneUYCY1ZmPq6/nGajuj0csGdM2HEnMkuTCn7JT/cOyrcvgFCk?=
 =?us-ascii?Q?7wkKDIHIrFjc9KP5YIhyfGFS0SZ/vtV7tM4+AzFktUaoQ3YuBlmJ3NPeIe9C?=
 =?us-ascii?Q?Vq3xBsuTsCN4npcw+PqVrkkWWVRGb3yQNPndlPrgrljFYUpcgGtTfDhL2JNR?=
 =?us-ascii?Q?6+khky7PiNlsJNkEKix7uBfZnoHzaLdkOnyyJ24i3fxHJlUfDQ8wZpvo2DJw?=
 =?us-ascii?Q?aRp/GWUxnUxiN0258Pt5hEJXIUsBnzd8POeWQNPSnq1FHZRX5V9ncv1330JV?=
 =?us-ascii?Q?Bf0PRMhZ92bIWvFttSWmq8U6piVb3rfJllzIZJwomsyNVvTrY/WdNZ/+HwQp?=
 =?us-ascii?Q?f1QSpeCGseOXiRF0Oqmy7xgoEpTXUglfmLXJPwaLO+T+Pgz1XvD9ZODDf119?=
 =?us-ascii?Q?oEUqC7l/OMB36tourimKs4Ky8ljGhfODtBn2fbjh+H0a5JlNkjisNTJh44tl?=
 =?us-ascii?Q?nxY2vkRh3j8r0LRUa+RJACpGlue8g6rE3xnMHbgEf6XHrCJhTfAVEcjYusdx?=
 =?us-ascii?Q?uKvuGY5glwPYgxBiJpmQ6mRhOEoMs4bpvoUwuZWxDftadhVK9th89bKCRgcQ?=
 =?us-ascii?Q?xQflDRpnQqf2/+7eezNJud5K8DEwmVQXmTuFTTSfmxLqv5jJQclHD1z/K2En?=
 =?us-ascii?Q?sI5Dw6LOmp4x37XlOrQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:41.8051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a29c531-9c5a-41dc-b042-08de34483244
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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

From: Jonathan Kim <jonathan.kim@amd.com>

Shader messages to deallocate VGPRs prior to shader end can prevent
the trap handler from saving context, making debugging and core dumps
unreliable.

VGPR deallocations for performance gain is negligible.
GC 12.1 will NOP shader VGPR deallocation messages via HW
settings on driver boot.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Acked-by: Harish Kasiviswanathan <harish.kasiviswanathan@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 447395d36a3eb..2ef0fce100676 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1362,6 +1362,11 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL);
 		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
 		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSPI_GDBG_PER_VMID_CNTL, data);
+
+		/* Disable VGPR deallocation instruction for each KFD vmid. */
+		data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regSQ_DEBUG);
+		data = REG_SET_FIELD(data, SQ_DEBUG, DISABLE_VGPR_DEALLOC, 1);
+		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regSQ_DEBUG, data);
 	}
 	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, GET_INST(GC, xcc_id));
 	mutex_unlock(&adev->srbm_mutex);
-- 
2.51.1

