Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EC606A31D
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NS/CvzbQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBBD1123E1;
	Thu, 22 Oct 2026 08:21:06 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010067.outbound.protection.outlook.com [52.101.85.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC20B1123E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:21:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecScfnN25ab9jLDAJhouNjpOlmmWdtdj1tQohLD2qD7oIUVJLDYnX7KODX2+7I0/cOGy9Aez5dJ17E48igVRlzR+g3WU3LU8MWMfH9Pa8bYuS7tDj3T6QiLZ2cGrSGTRYO1h2L7UEDhZIb5e9zQTqnrc0857emfMM2v70BDC2luocoeXKYz8XDH8XZ4Brv3Pt+0C18h4WOXIWWgbXWENrqUxhsXU47m9PkyD0S89vOmCNzkLYONqfiV2DjUtdXRQQMR579eryqAIwAsCCx/QDiIQTy2XQl04PLlkLzATsGKgY5Dp1sNSxME8scrXvhl8qwhfDbPt65jxEfejRrk5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drYvUoHpMUI4/mpihEFHtl52J7Nbgn08OE1C6k+WNYs=;
 b=GrQrg9YDFJnYNgpAi0XwkIvCiV5kt4ZE8gSlcb5AyDALm5b1XDmM1akiSgjeD4ZdJB37iq7ocJ73YQShZYx0F8LkK8KWeP5uS7oIi/oe1dhCF60elyYX7ToOoLh2+vMrC+pfCxJ4sFDKddAhsB4UNEllHxC5LpvR2UTkRz7Upz7hBaCvtgi2dTlwSWGgx+zKmEvOo3GByMASFFpHyBh1NdWk6oty0W+rIr7EgWyGJudAL6yFZNrt4eNAhekQt3/CdBImlI+ggAfDOtKr2XeF2QIaSNO/rbNBZN8M9Em/w7oDVi5YvG+OTKgzRAI/JcnxxsPYFv+ybqUHDAG/BoRL0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drYvUoHpMUI4/mpihEFHtl52J7Nbgn08OE1C6k+WNYs=;
 b=NS/CvzbQH3q08iDT5CatkNW26cwmDpBkQCFXE+9s3r075OFwQoiBDHD8Srq3j088my7twVROL+YcrPIUV2pWXJ3BoQztbZdN0AMymx1t8NXj1Er3TqtfTzns+Zty1iJyhTq8gJv/fk01LPq8qcVdr3bSpJnsoIgbq0ay4MZiuCM=
Received: from BN1PR12CA0002.namprd12.prod.outlook.com (2603:10b6:408:e1::7)
 by DM6PR12MB4450.namprd12.prod.outlook.com (2603:10b6:5:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 08:20:56 +0000
Received: from BN2PEPF0000A803.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::6) by BN1PR12CA0002.outlook.office365.com
 (2603:10b6:408:e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:20:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A803.mail.protection.outlook.com (10.167.245.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:20:56 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 22 Oct
 2026 03:20:39 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 22 Oct 2026 03:20:37 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, <Mario.Novales@amd.com>, <Manu.Rastogi@amd.com>,
 <Jiongyu.Zhu@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH v2 10/15] drm/amdgpu/gfx: reset the gfx engine when a kernel
 gfx queue reset fails
Date: Thu, 22 Oct 2026 16:19:50 +0800
Message-ID: <20261022082011.331462-10-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A803:EE_|DM6PR12MB4450:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ce4444-7c98-457c-19f9-08df30156570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|11063799006|261009223027099003|261021123027099003|261021121427099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: gFSaPhPjkwbVk4BHfoFQ2cz1kw7rG2rAzcW7DXihSl1S8X1SSmlrpI2Ae1haxDiihfqUDLK2N7bVHGMlAYSp/a8NqMvGxRsMturb5idtsZi3Gh/dgRtWX5+7Ty+jvAOJe+MUVoXPB0WwJNQ05dPJvFow0oJDxAQCtZ97f86vdejJSRFjVZMd9TZ9RRxSQmlRfPc7WkF8/FGthg4aJtwxLwwKoMmZurZSQ88TQ/chMZPAfq4B/JFQ/5FkWpILDBVFL6gPIlvRs/ngZblvg3cjIse5b/wC1A8cu4TbOh0+l4mmjRWtAVP9AN/JBJAFfcic8pPrUeP7BXOBSEe17+C+3lQgitCeQbUcQg+OkRHkmc54yvEy/0OeUhB6iQHu+t0GQB7DLQ1uAJ8630ZCk+6Z8gFoxdAgTJVSGln8S/JoSiJa9D+Vxuh7OQBW2wUIkV6axMoS9f+eZKmv5OcU9HrMia590U2T2BrPNT51pDlT/asZm+0vpw6CHu3/ovUV0YNKXnkknRB0ty8f56HUF5OksENufq5pzEys0EImnU8lYjfKTaKzcUDEIV6DywEzQDoxVyPnWpPlqfyYsiqS1PyppbHQkupa8VxL0UqE9V1292XIUh+8equUu01/HpzBpJ0Uzbs5v0nHez7zRFu1Ln+SehKVS57LwsvTgvTL4dupDyP2PbVq2BAUTxnAljQr+K4m8ch3e2BzZ7EVjNM2L8/QFg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d7NPKi7sN5t1Jk4FVcqgaSgJ0JpaQiUKuSGhtlHDPnzQAi2LWpbTrz+a6X8lFlsJNZKL4ZhWMSnwc4hq144Hv222IqNHbWlVnKXzhHLEnK+FSWbZorFATElLoHq3C576A4vabDfpk6uDpPmbL0j43m93rYRHb6tBad+UJjD3k7ifCBFg2DjJuSYQUPR5UrKemY/bPc/ZfzSiWkQex7TWxtkuIcRUX5JvoUltomXvaQMQ9Zv5wJjkG1KVJwC1qXgKncLqLGva/tqw13DDgrvNZZYK8sYlu2NfBdOuVl4ewHIZsLq68OpTnhho9KrSmqm3RVoU4t6FtRucTxrVEy/jabaDCqA+IoIaW5kkHkhgqeJiZaYIrQWg2YTzYcYd3fe4WBpTKuKeT18YMdwLZBQ66TZS0wLbIUmH2HnIiCTi7MH7kgxQ648xIGmOzFRnkx0j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:20:56.3761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ce4444-7c98-457c-19f9-08df30156570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A803.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4450
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When neither the queue nor the pipe reset recovered a kernel gfx queue,
amdgpu_gfx_mes_reset_queue() now falls back to a gfx engine reset, if
the IP supports it. The pipe reset already escalates there, so the job
timeout handler doesn't change.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index fecf2c02973a..e18a9ba6d147 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2275,13 +2275,17 @@ int amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
 	if (!amdgpu_gfx_me_pipe_reset_supported(adev)) {
 		r = amdgpu_gfx_mes_reset_queue_start(ring, vmid, timedout_fence,
 						     use_mmio);
-		if (r)
-			return r;
-		return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+		if (!r)
+			r = amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	} else {
+		r = amdgpu_gfx_reset_mes_gfx(adev, ring, timedout_fence, NULL,
+					     vmid, use_mmio);
 	}
 
-	return amdgpu_gfx_reset_mes_gfx(adev, ring, timedout_fence, NULL, vmid,
-				      use_mmio);
+	if (r && ring->funcs->type == AMDGPU_RING_TYPE_GFX &&
+	    adev->gfx.funcs->reset_engine)
+		r = amdgpu_gfx_reset_gfx_engine(adev, ring, timedout_fence, NULL);
+	return r;
 }
 
 static DEVICE_ATTR(run_cleaner_shader, 0200,
-- 
2.50.1

