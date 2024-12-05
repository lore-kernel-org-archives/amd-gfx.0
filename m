Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBF5E77179
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Dec 2024 17:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3DAA10E3CE;
	Thu,  5 Dec 2024 17:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tkqshF7O";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA50F10E2D0
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Dec 2024 17:36:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jInDN7M009jg46jEC3sjajMC9tAxy6FRyIN9KmXNzcgRv4JcHQQeNUeLsgoBSmnulPTw+QKq/FnobJS9GyIa3Yt9v8eWqBs6V1Pen9xalqmI9pyiWUl6xvke0QiGJoJHViuEjoQFIFHt6dkqP2TZNDjP31PB/mG/kZlaqjqFeDnz98uL2iM6gOfofx1h8g+Wra4ty2jTG4+dB1HLPkHdlZUOxvSPdUliizVke4t50BEn9qz5LVghc7z+Yr+6F/wtIbkVzeqiSVrQ+a9GcZqX4Ha9Zr8K1ilScTAO9aW6xDoAVPuk1rBAM91dMQjaFfwesehtnrfjRVINAycZjfZTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvV5UUIuQ3dtMpCJpkhbS37Qwb1KOIB9ZHGn0IYhubQ=;
 b=ERUBbSaBCcfngErhdu/ZtUAIZZ6QTocVhO9PpiVBbl1JkiVe7Wr7miHEke0wkBMjxaKUhaJnkL3s/5kNJZDo3QAOno05teNmFmx9jr39EKq9gOS1JbymSnSZZbmCb1GodIMX600Al2hF6+OMLzAE924y3/Q9Tr/4FJdMRRJ/H+EY7KAaPFZ8suTlu+PKjguEltwyEZXsKoa8JXAAmqDcRycWXkw7PcBPlaL/uMiVsqRxcKUNqXswdUERDTYCGEbp0xfRTJMF0JWvHJ/qwMpnv6xFG2y68+x+qYcPBwyzyHDxhavxkYG4Ay0T4NiLHUf6A0SidAHnh/02jDyIUdUBCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvV5UUIuQ3dtMpCJpkhbS37Qwb1KOIB9ZHGn0IYhubQ=;
 b=tkqshF7O17holLdrMRHPPUD2Xd72P042jvSIx9e++wHt+6UfDH5tHfTHlkDu7N+GXfK+CIwjw5Y5JcmE1BVRFW8fyv9YRDBbGDH/GU2YF9fhZPYpH+EauW9nC7pQeD5IEyONXoAlqzuIrBqj6oeQzUOGfFMbIOw7CWcAuEex/tc=
Received: from BN9PR03CA0454.namprd03.prod.outlook.com (2603:10b6:408:139::9)
 by DS0PR12MB8767.namprd12.prod.outlook.com (2603:10b6:8:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 5 Dec
 2024 17:36:26 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:408:139:cafe::17) by BN9PR03CA0454.outlook.office365.com
 (2603:10b6:408:139::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Thu,
 5 Dec 2024 17:36:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Thu, 5 Dec 2024 17:36:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 11:36:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 03/10] drm/amdgpu: update irq sec header for vcn 5.0.0
Date: Thu, 5 Dec 2024 12:36:03 -0500
Message-ID: <20241205173610.334358-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241205173610.334358-1-alexander.deucher@amd.com>
References: <20241205173610.334358-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|DS0PR12MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 753648ff-74db-46de-efd7-08dd15535827
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MV5I4E7kB/7eRswD2r3asH7qclUp4coPF1zCUJRe2YuchBgmHP6bCqQflD+9?=
 =?us-ascii?Q?EjX694FhpPfuK82Jj9+WCOvW5rTUc8Gg3LKV1XHkM5UQJUyDICyG0R1LF7o8?=
 =?us-ascii?Q?XjK6kY8FpTkkb7UeChRPFDAsN4LI+wR7kkPXv+qZ2i7wgsMZrd/t+mZkQgvb?=
 =?us-ascii?Q?4Q2AwXufCdB0FVZ39gXryA33m7ZxPaQiRGvDYCW2pWK6i2sOkZ4E/aNxUcX/?=
 =?us-ascii?Q?BvEHnFaC8SKKy4BFq1NUbtY/zuivCnX9SXtMIE3PugfEfJ7ZaqS17JD2Cbv1?=
 =?us-ascii?Q?kAe4DIik7a2A93QiEivqXO4MFHGrgWc5VL/6Kb2hDrIEJAKakvhEMcTwElqK?=
 =?us-ascii?Q?YAOX2tInTNpo6/g21KEuw4eE45tjedVlGvvunoM6LpptA6QAdCsD2iTVOBJd?=
 =?us-ascii?Q?pUKlYq8E4D8MYG8TxRVKaf2MDDf6yIjdVKmo1epPimBgdTKlRzwQkZPmi6s3?=
 =?us-ascii?Q?7Ef2I2p2wX6uVo9f+LuuqiPgKlSCG5vrURGzdPP6MZXpqMHcPM/6+FUlGWkV?=
 =?us-ascii?Q?7PC3J/tjVyKN3aST9Nd8QshS74aPDQPgLk+gX2eUub+4D/OL3Pwbsahh4RHu?=
 =?us-ascii?Q?UysAzDGNzBixesBm/TIoug0c086tSUFVFQLxyR+So5g8L3UyH6PcCorwVw7B?=
 =?us-ascii?Q?O0nsckDn77ypZTnUddJyPQNWSQiN+j82MTB1aBFZoaWxw84RwWVLR4ee3SA8?=
 =?us-ascii?Q?4RGvUPI8W6rUIoDrCJyin6gA2lX2hrxtQKsgCOUjE5CxcRKPHpaGHRVWzGcm?=
 =?us-ascii?Q?qv0zynwL3KNEtjRzplXncr6gn+OgZLpdL1B2TFxdxKq32MgbSsV2qQthKR0j?=
 =?us-ascii?Q?tY7DOfdfW/pdSWZE7PAWPHJhOxrJEDe5f9jVyvDq+sIXmDx1tjXTzScDVd28?=
 =?us-ascii?Q?oLgyURLaEADOxypJjrVPaiEllUVNcmnGe9gOTQMOWExSF4Wqrdh7tC0I1deZ?=
 =?us-ascii?Q?EXXP/D28BgW7DfCykmDlnzsrXezZcdN/3CfOX7R+XHXk1991yf/y9QIpDZdI?=
 =?us-ascii?Q?XnJcwFYDR2PG0KYiJjRwdjn3Y096cOQVfNagMnaLp2XbAELSM6MPumtxHCoC?=
 =?us-ascii?Q?WqvxdOYW5nHNoWc78RfEy/+j+k2zESE34wmccoS4i5I8H5Tq6p38jEh96v8X?=
 =?us-ascii?Q?XP1gbs95K65aqQRrhtFVmEe9rcvaI7Bh/uEv7xHcjxgMVhSbB8RK6EYygF08?=
 =?us-ascii?Q?fqRDD3IAMEvTKp0qFAxg8zJ4eD5x88FlEySbZgBlW043yehvrbGlrB4aEx82?=
 =?us-ascii?Q?MqRsHcya5WiQe/MySfB+A9QnZJnhzuoZiM3ftfyL+WZvNQP1s4MGJYUq41TD?=
 =?us-ascii?Q?YCTlZhUnEkWpSa90ETGGy6jDwi7Zj5HrHX+lyOd/axB5zMMDVKnUUXYqAW3f?=
 =?us-ascii?Q?ClWyFj0vT4Acso8uojwqkvu9E5ovpBc0G9CAX8FmixCay3U2bGLK0frSsLF3?=
 =?us-ascii?Q?+H40LMK5C4YSPp5d9ScUnnzi5uL1ZZHK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 17:36:26.1334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753648ff-74db-46de-efd7-08dd15535827
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8767
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

No functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index f08dbe37499da..097b9ad1721fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -32,7 +32,7 @@
 
 #include "vcn/vcn_5_0_0_offset.h"
 #include "vcn/vcn_5_0_0_sh_mask.h"
-#include "ivsrcid/vcn/irqsrcs_vcn_4_0.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 #include "vcn_v5_0_0.h"
 
 #include <drm/drm_drv.h>
@@ -140,13 +140,13 @@ static int vcn_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 		/* VCN UNIFIED TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
+				VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE, &adev->vcn.inst[i].irq);
 		if (r)
 			return r;
 
 		/* VCN POISON TRAP */
 		r = amdgpu_irq_add_id(adev, amdgpu_ih_clientid_vcns[i],
-				VCN_4_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
+				VCN_5_0__SRCID_UVD_POISON, &adev->vcn.inst[i].irq);
 		if (r)
 			return r;
 
@@ -1318,10 +1318,10 @@ static int vcn_v5_0_0_process_interrupt(struct amdgpu_device *adev, struct amdgp
 	DRM_DEBUG("IH: VCN TRAP\n");
 
 	switch (entry->src_id) {
-	case VCN_4_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
+	case VCN_5_0__SRCID__UVD_ENC_GENERAL_PURPOSE:
 		amdgpu_fence_process(&adev->vcn.inst[ip_instance].ring_enc[0]);
 		break;
-	case VCN_4_0__SRCID_UVD_POISON:
+	case VCN_5_0__SRCID_UVD_POISON:
 		amdgpu_vcn_process_poison_irq(adev, source, entry);
 		break;
 	default:
-- 
2.47.0

