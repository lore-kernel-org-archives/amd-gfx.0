Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBEBC77B71
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A18D10EFB4;
	Thu, 30 Mar 2023 19:18:25 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7175210E051
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:18:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/h5Uy2UfUOlKt95GIAulowDVufeeaiERa1bu4D1QfIgyBqpl5GCQDHitTpqB42quIFx0iOXtvhdl48OUg3F8gBc5Vc7ZAthVJIGm4wQxkbsfO+9Nm+jDEDN8N3Lh9XMchm9kG4CYdAIP9r1MPN0x1Mg0FXR4D27XHdx+HT6aCQpgV/W9LADxfvx7cfet78pRb/2lzIp3dSY0AGRp2JcFZVgCZ1BRUZniI7G9nJ2abIspy+hrEeTajdHHa181Cg36e7gPQMi0Jyrros79VW48aItbRRam0efbFs3xZU5owq974lJMtiJqVaVv8us4YsOk+NLeiFZYbLsM/8g/2oRzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4Odm3pAFqe67RR2ilAFVFYhO6AEg7ZvS7j7o2/6VCQ=;
 b=d+8GfaqT7nV6DnMf7OQTK0l9/PR5Krr1bTfuR7Mb0dPjUMblbXZGyNeZeAmK5QmiBE/CIZqTcY3QIorCiMUg3whY3z6Tlk8VxPaw8vR/0278yJiRMAzYKoyORO2RdDcz32hFP9zeW837AkuFlnI8QD0n/sjOpo5tCn1yLd5370iMaBcFb+tULFf5kodHBaWjJyq2OxBj3ZPF/Soabt6FxeiLEUS2Cw2wbishGFAfnLlvFsSA8euGkhP9R6tuDF2nWbR1LKTebMvPbNuoZa54wXVG0lJAyVXttzJN7A6+sH/aaVIxIeBjp21UTdGrnOK/r/gkx4+MG+L8x2QUt4l51A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4Odm3pAFqe67RR2ilAFVFYhO6AEg7ZvS7j7o2/6VCQ=;
 b=rX09iHnz81y+I+s7NPPXDCAz32h1FXi4DhK7kLmfykBnHXYN5xqp1StCcgsl3DtDs3hq1tkjK2+wUCA4iGFQLKnUbm9Y/0zPxyeBmZi9h0ey2Nl5/Le2fS4JZ9mQ46AgNsF2rQmjLKXWjVNXh85LwtRDYssvOhpWLbUm787gcMk=
Received: from BN9P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::33)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:130::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 19:18:06 +0000
Received: from BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::c7) by BN9P223CA0028.outlook.office365.com
 (2603:10b6:408:10b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 19:18:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT073.mail.protection.outlook.com (10.13.177.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 19:18:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:18:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amdgpu: don't require a job for cond_exec and shadow
Date: Thu, 30 Mar 2023 15:17:43 -0400
Message-ID: <20230330191750.1134210-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330191750.1134210-1-alexander.deucher@amd.com>
References: <20230330191750.1134210-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT073:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dfd309-63a1-4691-799f-08db31537dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39yT7CyjVPggqNHy73Sn1fzxvFIGt4+xDFmbSEyzsYlJaUlXdUAzAu/GH682Rkb4QhlsFr5dV+mbNlQMrwy8zL5jgg74SQ9ujCAQDefQ4Yz8XGxzUf86LBMnAAzuipyhrUkQTMzP9fViNsAohE6/7jD9KnIkSrzVyoTN8bg/VPrvGZdrtF5Pu/54w3aLoGKAG6vvgB33UAhVz8BYfv3N8BBNhY6USEcWmCCyAfx3F8DOKH1bDoTsXie9083TR+5JjE0HDKspTtCYGV1/6Rvh6o3eyKSQZWlqygdEnlQlt3nS70gqsbgNJUDTZNEzR1b/FvH0AqNtCvoIUpYGF1/ttbg3sRow1TygsMYbPvnZfKgQ0kFzYDCsZVuXKaEFPQTh1BkmVpgLmaW1Zcnf3asLdNpQ1J7par2Y3/rWroH1KuSqK4nyO3TMAODwVD8DgE2l1KH7931Fh478aCGMXLm+YqX4VkFECbJ5ywO7kaRw4++/8UE8fh02Mn1LqhrLKVQHxF84tQVnUE6PeKik2PQAseYb5DfxKc+92f7d4Vv2zw0kklT4QH2554szQ4O8luRXDud1eCoVGjsL0qQ8JCYaq5dnDSXGKXT2xP8E6ouB+exszs7Zyhx2XafbVWT0fvYvAN/kXuWR8tMTKK5P86AL0YuUR0StpmXAi57f6rtzb3RTT+NXtjv7HFWclJCfNF1IIaCpjXNTlRUwt/dpdHqTFewSmFW43QZKhZxCLYqcWok=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(2906002)(40460700003)(8936002)(82740400003)(356005)(41300700001)(81166007)(5660300002)(86362001)(36756003)(82310400005)(40480700001)(54906003)(316002)(336012)(426003)(47076005)(7696005)(478600001)(36860700001)(26005)(70586007)(70206006)(4326008)(6916009)(8676002)(6666004)(2616005)(83380400001)(1076003)(16526019)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:18:06.5973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dfd309-63a1-4691-799f-08db31537dd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT073.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to reset the shadow state every time we submit an
IB and there needs to be a COND_EXEC packet after the
SET_Q_PREEMPTION_MODE packet for it to work properly, so
we should emit both of these packets regardless of whether
there is a job present or not.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 9bee630eb0c9..7f4c198ac483 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -223,11 +223,11 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	amdgpu_ring_ib_begin(ring);
 
-	if (job && ring->funcs->emit_gfx_shadow)
+	if (ring->funcs->emit_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
 					    init_shadow, vmid);
 
-	if (job && ring->funcs->init_cond_exec)
+	if (ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
 	amdgpu_device_flush_hdp(adev, ring);
-- 
2.39.2

