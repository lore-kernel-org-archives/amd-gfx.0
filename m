Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB9C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EC1F10F238;
	Fri, 29 Apr 2022 17:46:55 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E5D10F232
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/4meFr4ZIjcYNUSRkPGiTaZn4Mqr0e0XTZsSZultnwbAzr2GaMUhlFqhLWM/SZFTU0Kyme1H5v5dQp/7DsaR4FP0nzwMmLFRI0wWbjh5Fz3BMjBlFRsQ6t6rf+8cYlfmoBzlikOIIMlhqV2RzjSIU+4iuVsgXgGDGE4Y/+NeRXg+22Ru1WMs7o7CRAz2btN15zXPDDVwKLMHv2EJuFO+UjoeyXRX9jSGcu7CWiOaToYwcpwBbZNHYmr3vb/9n1mTdk2wCRnEFeZ5jCKS2/vjGmFh5+xR1isxaF32SoM+0+nWcKIqkPuFYMI1fXw3MV+stZ2W+jedE27MOU9wxvF1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGLYPUaG7l5Xza2dqQbb5RbTZFqAzL69Mq8rHxqf9X4=;
 b=XZz1ZL3PCg7FZ6v+nyL13T7cqfv7pZPKuIiEnbIl4zKaENbxfZIB07srVjhX8GdH4l8DcMTDsIeqs32mvZSZiVE9/d3f3/UV6dXOtqUJfSAdmUKoAzeINVG9N8pJaEOQ42ACx4hGV2CZH/izJn284T6t5VJzrZHQyqciE/QetrUTQWxC9qFNGV0Cw4Wk07go+xwh0NPUHPJDzgeAKCeV2mSthuCSqbOo1uUGJmmEbaRdkYg1xjPFxrh27bELM48Se2iM7cqv7B4hD651NclIcQ5e6D4BJmO679QpP109brvWNGC9u/Oxlny++6LINPqxF3+XvNYnq0Ps4tDQ8/8ooA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGLYPUaG7l5Xza2dqQbb5RbTZFqAzL69Mq8rHxqf9X4=;
 b=dA2cqZibjR40DcOgCp50IAL5JyZS7DxcTJkRs3B+qRfFc9zrwBmwTXs+t210DP9+dC8EgrmFO81w2mAT1D9Vxu4XlknFYBegHIlMa2Nu9FfBxQbTKX9HQoipaH8l8LRJ80j3DB/pFTDATwN1cc/dYhGUzeaczhckmvaqYr/Gedw=
Received: from DM5PR08CA0051.namprd08.prod.outlook.com (2603:10b6:4:60::40) by
 MN2PR12MB4157.namprd12.prod.outlook.com (2603:10b6:208:1db::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 17:46:45 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::12) by DM5PR08CA0051.outlook.office365.com
 (2603:10b6:4:60::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/73] drm/amdgpu/gfx10: associate mes queue id with fence v2
Date: Fri, 29 Apr 2022 13:45:23 -0400
Message-ID: <20220429174624.459475-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61f3578-58ce-45c0-9db3-08da2a083a0c
X-MS-TrafficTypeDiagnostic: MN2PR12MB4157:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4157D9405372A52DC7F78526F7FC9@MN2PR12MB4157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RObQjonLNnUFEIdQRNJV0GnutOmMCAHIZSBRvh8tPaDnTGosBN/T/PLnD4T8tDHSZSkXFkhoQpXP8aqIBpvM0pJ5sA7CQgZu248fhyEMENejd+mQ16jboweIJxBYATmUp4ZQiEu9nivzoS1wSQ5DM/iSvB3FcEc8wAjuFX59v3sfAqgghB8q5DEfmkUzAyNT1ljVSVDYSr9L7ytTQNr6bzISlIZpfv8/HFWwn79R5HWlvl0L7iP3enjz1S1BXpL1I9dABkhhCjmBER5WCIaNxZvXJ3x0Gr8/oZkfwmDP6sHumrlbOdUmCRWtzWTl5sDz5c6fzJyFYs+v/kkabCXTKj3oEcWwdhMg3J9gBWs2R/VHaEHfheTsEB+A1FM6NQ58ArTrYoqdRfhrZSGz33tGOuXnwZZyipRtxobgD42slbxuLqH5nwLBvwAqVPFMn5n1oOi/hfp6vxDtUZuvi9uZ9EF+gQ3R1ONBZjJAlrR0tHoiKCmvhiY1dz+W+V95xN2qXueKqoK/3fX13cbmwGMJspVmYuSYYGMB/uuwNb7egsxxTVIqWHC2Xls8WDeg8uNWfH1X6Qiz2X8NYfISjQB9/Uj6MAl4JgA89bKIb17IiwysdKpXSs+EmIcfVf26jbJGKIQ7dT1ZRfaWqVijMdgPNJS7gU8iJTkQZPKxJAWSpmM2KW22/oT9UPzLP9b9FgM0Hexbt21Jp1qQj15KObLzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(82310400005)(2616005)(81166007)(5660300002)(8936002)(54906003)(6916009)(4326008)(508600001)(47076005)(66574015)(336012)(86362001)(316002)(36860700001)(6666004)(426003)(40460700003)(83380400001)(356005)(2906002)(26005)(186003)(36756003)(1076003)(7696005)(8676002)(16526019)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:44.7263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61f3578-58ce-45c0-9db3-08da2a083a0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4157
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Associate mes queue id with fence, so that EOP trap handler can look up
which queue has issued the fence.

v2: move mes queue flag to amdgpu_mes_ctx.h

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c      | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
index f3e1ba1a889f..544f1aa86edf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
@@ -115,4 +115,6 @@ struct amdgpu_mes_ctx_data {
 #define AMDGPU_FENCE_MES_QUEUE_FLAG     0x1000000u
 #define AMDGPU_FENCE_MES_QUEUE_ID_MASK  (AMDGPU_FENCE_MES_QUEUE_FLAG - 1)
 
+#define AMDGPU_FENCE_MES_QUEUE_FLAG     0x1000000u
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index d06807355f5f..e6e601296097 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -8678,7 +8678,8 @@ static void gfx_v10_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
 	amdgpu_ring_write(ring, upper_32_bits(addr));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 	amdgpu_ring_write(ring, upper_32_bits(seq));
-	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, ring->is_mes_queue ?
+			 (ring->hw_queue_id | AMDGPU_FENCE_MES_QUEUE_FLAG) : 0);
 }
 
 static void gfx_v10_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
-- 
2.35.1

