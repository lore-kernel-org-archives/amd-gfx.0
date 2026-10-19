Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CB606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 20:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VyrjSTbM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19BE10EAEA;
	Mon, 19 Oct 2026 20:08:11 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFA410EAEA
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 20:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGJF98TjpEyfAAkN5UlZZP52vHUnyEOL1ACRcmdTERHvbUG877DVAcJ8+2/MUU/6OGOAqHvmhW/YRSujrWo7KseIgEzZ+HfPP3dxZuv4C5CRRwotisFiQKDTo9z8Z6rMv1ARyBOG6tO6xX8YrCsOK2KQpFplawEuvlfNipw2y3cLp0X8vQgJO0Y5a3lJ5tVdLEA6Q4yHeuioeq9Y4JPFeFGcHqz13K87p1GKItmMyyhyR0crGnUOpoKLn/0/gzYm5TDmrXDqtbaaUn9tgh4j9RE3DbwlffDA0TLAC/7FD2LrayidG6145IppI3sxotkvduHlqT9nCKdaPodiGda/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3daPyVwhAz858PqeNnj2p/Jck9LctwdJw2PRShq6Xco=;
 b=f9v6zy3hJDos4wdkpEgy8kMNZGgDw+Me44assZXXrYt2MosDQ7AE0SGfr8z7h1rGqW7yaMSbrg04vRwPYDqX1fe58qG0qnYns+k2WNap7gn4Tpivn1jgIUcVUWsoC1kp8lHhP1kPSuysrH6Xvy1Wk8h4dQbN0cNj4Ea80kn5XZCw/HpavW/LUI0ra3apH3nEI72HCfCMn5lOxaXMx3CbWkzI9vZwP0OTa4gUfB4awjH5G7+ppkDILtoHP5c74vSc8PhzUj7vXvPkHRMM/w5ykq+mUnh8EiWVF4hSGfQ2JOt8X16suVr0LaMaMABensRfPrhMKKPtgBb1b1JGhXSPiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3daPyVwhAz858PqeNnj2p/Jck9LctwdJw2PRShq6Xco=;
 b=VyrjSTbMxZ3SjjyCPPL4eIia2LZNah/HbTT1tRe2MucBx23ddwfHjktdHnHcA/ap9YNNuvvF5B9t7HzqMJMJi4AHYHnktmUTGhdNN0HTKsqkPpYEi4fi4CBkbPQKcSWMc/ktNURzcnLqcTMyRfGciUBvaFWQDDYrgMJZqGWtymA=
Received: from PH8P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::11)
 by CH3PR12MB7595.namprd12.prod.outlook.com (2603:10b6:610:14c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Mon, 19 Oct
 2026 20:07:49 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::58) by PH8P223CA0023.outlook.office365.com
 (2603:10b6:510:2db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Mon,
 19 Oct 2026 20:07:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 20:07:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 15:07:49 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 19 Oct 2026 15:07:46 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <leo.liu@amd.com>, Ruijing Dong <ruijing.dong@amd.com>, "David
 Rosca" <david.rosca@amd.com>, Boyuan Zhang <boyuan.zhang@amd.com>, "Benjamin
 Cheng" <benjamin.cheng@amd.com>
Subject: [PATCH 1/4] drm/amdgpu/jpeg_v1_0: allow type4 commands
Date: Mon, 19 Oct 2026 16:07:23 -0400
Message-ID: <20261019200726.15262-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|CH3PR12MB7595:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a01c53-7805-431d-3b32-08df2e1ca566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|6133799003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: UCj0HYlfbTTOkvL4W008gu8jnVfwTAL7d8XfxFSI+ajGWizu2pqe+Bo9HPXQhpaMW0BuA+kcoqegVlh60jDT+EsMxvxAOkRA+mudmnC6wSCctkhqBxb40inTETAqnR33ULbi2dt6iPiDGBmMuetpoQnLcBepQ6jg23e7KPfYXfuzxNZ3f6cTDX5XiW0ozTaDa1m8PeaNdYpLJsG1Te20b+/NcoI3s0Qqij2aH7HtVsYB4llunU2yaF+T70JPs+wSpAse4vPE6S0MaqcGtH21ieyze8+y6SnIDPud5HCMMdNb2X2PI++r5SvNDkVdw6u3VFyFzXNCmVE/NArm5SpMcba+fWMTdHzAud63v0gvrnvuXrdeuujBsviBN9eRkzdLyLh48Cq+K/Kes52brQKO0Or1JeUe04p59TF4RGFxSYrAoaUgzZXiMOBx4PKe/uZ8kCgHH3rH0bQStyLsn1Zo86HGcTJoDEviF7RYwmINq47F0SCfpztOU75rpPpLxbRIgBEzj0PnfjMvwuwelaQndnWUu4e2OvkAQyXM3Tm88hw17+R+Y40DL0jL7sJO1BMTeIz/nZI2W7LH1jwGKjDPXA88GVaPbL1VcSyLj8Givd8UBeV4uUe0b3jkuYI+2GEq0eHnvO3ie309ORoCo1fyXUgRrAqRYXnwBL3P+JJhPAX7qEgi8PcMe82ZpwIywhVX27/P7VSquwwStt1imdjGXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(6133799003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jk1e0Pe4BSeJJKW7akdzNk9XNGxTBA6QIy4xTPGTiSocKOv9CEHFVGAN90uddZ8dYnfeMbrPwJzzlALndUgafbYfQvCzYwfsqUerrCCzna2PtrAHTvuKq3JFoSXMmD+j8iZp5Qkb6YIUjYtZ9zMb/jaHxWnY67rpEXpv5b1pG6y89bol5Ll42Snlzx82k3V8dPlvrxtoqhJJ1qDphHp/jBK/awUlW1w4wvqAjMY1TBNVGh5zC1ObwVpbha1FF+EpZZe4eF+BIFEa01+aqHxLkZpXbctXAZdyTrox7AOvxvs9zAxi9qkxlR8HqlTam28jEJY0EwBhVFkyMNEK6oc1GCq4FWuEPRs9y/uPjf8zmSY4WMdJ6Nh5LGTFeUODULqjb8pO5MuUFT7JKIoVHDyWaCb5bdlroG6ErqDdGKDyRfX+t9orSJh6GJd6SJ7RAZyT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 20:07:47.8046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a01c53-7805-431d-3b32-08df2e1ca566
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7595
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Packet type 4 is used for conditional memory write and can be used to
allow a memory write from within the IB.

This write is done through IB_WR_VMID, which previously was set to 0 if
we do IB parsing. After programming the VMIDs correctly we can enable
packet type 4 with no issues.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index b5bb7f4d607c..81facb99d885 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -301,13 +301,14 @@ static void jpeg_v1_0_decode_ring_emit_ib(struct amdgpu_ring *ring,
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	uint32_t reg;
 
+	reg = vmid << UVD_LMI_JRBC_IB_VMID__IB_WR_VMID__SHIFT;
+	if (!ring->funcs->parse_cs)
+		reg |= (vmid << UVD_LMI_JRBC_IB_VMID__IB_RD_VMID__SHIFT);
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JRBC_IB_VMID), 0, 0, PACKETJ_TYPE0));
-	if (ring->funcs->parse_cs)
-		amdgpu_ring_write(ring, 0);
-	else
-		amdgpu_ring_write(ring, (vmid | (vmid << 4)));
+	amdgpu_ring_write(ring, reg);
 
 	amdgpu_ring_write(ring,
 		PACKETJ(SOC15_REG_OFFSET(JPEG, 0, mmUVD_LMI_JPEG_VMID), 0, 0, PACKETJ_TYPE0));
@@ -669,6 +670,9 @@ static int jpeg_v1_dec_ring_parse_cs(struct amdgpu_cs_parser *parser,
 			if (reg != JPEG_V1_REG_SOFT_RESET)
 				ret = -EINVAL;
 			break;
+		case PACKETJ_TYPE4:
+			/* Allow any wait reg */
+			break;
 		case PACKETJ_TYPE6:
 			if (ib->ptr[i] != CP_PACKETJ_NOP)
 				ret = -EINVAL;
-- 
2.56.0

