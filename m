Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA6AC7EE2E
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Feb 2023 16:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBA010E130;
	Sun, 26 Feb 2023 16:55:23 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF92B10E128
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Feb 2023 16:55:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9jYb92E7XMwcv94pLC+NLlNROyK/FbqmyKxGonSnvSDHGUZnHmes4ur7Dpoop0R0X+XmBqvjRo2gmlZ61PrP2zL1VTDmUmSH90XTk9WB/5ozuTYDkJyGylmNvOw+G/QJyLVP2DJQTVL6y8tExiRgpP06DuNWxmgR85kkvEqgtcYwJxe4COi/eiBE04tf4ybSS1EvYHPEl0g7WDBLVtQyq7kG5yriENDRqFQwsFB3uAiW3TJ4lObWDs2G9B0n+81NHhVHo4g9RpCgq/2dhPDRee8rBWWota3Pu05IpkjbjRKkZaBFyKQU7tRn6CGKRT9Pe+iJn+rWfePC3RW9OzVKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQED49HghwnVT2P5i6NrDUJnGVf30i/2AWDqsLK6Luk=;
 b=exHhokfjcQBfAuA6G0cR1OObTTIjKqRsJdeO+YH/dODHJQYxoiAIhtO631cwKhus6nXWqzGlZ/b44GKawBCSfnasBykUPeNsnPFVF+JeEH7RfSerUlziWKBjoBptxk5eBViNpZqNcJ24MuQwJj3eI9kOcEOZVBzRP73057BPcVoCEM12NXua2oAVT/VjSgVChO6YDzcw7DNXkclVB8sOgtXPKA9G7RUBfL4UD17N+qNXtiOiBZnUe1vt9yBlfhZyHRODNsjqsrkYNpIp4ihwKXFXZ1jJ5kpi4oa33myjkWlgnQfi945oCwAJcore6xWjMmFjyStg40977Hfizhxplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQED49HghwnVT2P5i6NrDUJnGVf30i/2AWDqsLK6Luk=;
 b=kWvBAhjT6tiA7L79Vm4hrkzLALIjmM91pG4xfqObJVOTvgad8/X3KYF6EHqy1Hx4lPxsM9pJnGUxOThC/keMi2KM/jLOPPIs1bajK4cDyz7MWOraOjAWafejB9Sj5mySYVoWc/w7gqphPc2Uj9UWK3t2B+1hBQxwyWNhxRBD6PI=
Received: from BN8PR15CA0015.namprd15.prod.outlook.com (2603:10b6:408:c0::28)
 by SJ0PR12MB6831.namprd12.prod.outlook.com (2603:10b6:a03:47d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.25; Sun, 26 Feb
 2023 16:55:18 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::e1) by BN8PR15CA0015.outlook.office365.com
 (2603:10b6:408:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27 via Frontend
 Transport; Sun, 26 Feb 2023 16:55:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.15 via Frontend Transport; Sun, 26 Feb 2023 16:55:16 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 26 Feb 2023 10:55:14 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/6] drm/amdgpu: Add mqd support for the fence address
Date: Sun, 26 Feb 2023 08:54:32 -0800
Message-ID: <20230226165435.41641-4-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
References: <20230226165435.41641-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SJ0PR12MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc1a8a3-b0ac-48a8-f790-08db181a3c98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I/ea8SmAourVDNgtKMhhn87kv9653ot9qf0pQRFpEzJWCAMja251knJk5ue8EtOBr2gGdvzR6EyM2LUZF3nq1vffBSQcvQITMT4JkmhM3t42UfM6aUpW7+/Us7YNhiw2uhcrTWpzuZqe8X5l/ue9D/Zug4rO073G+yznD/c+uPH7Tpf/iRv40cFxao5vwfPUcwuVIfqHINCHMD04HgC7bRTmLd88sO8ttDnHTurzzbT2PhkkbQlHSR16gRnUSkzMKE9X8LmH3/viCA8v6h5/1Nh9vPPFyes/FE0nB6k9aYD63ikF1NbpOSoyc9bl0+oRTiv6Hosn0JacTDEHWm1QD56CQHRZgZPscOtRq+MrW2VWEE7oASd/1DDls85DzbwWZA7y5aIgwt+R3GgUhM7bhP0zZoZ9zgpo1zLr6F/90YawR4EcrNF42GTvX6MVtVGbBvMGIyrbkzos8ETFGIc+M3lagr7Zieldy73Ra8Zq+FEiXfwWr/C7hHDZYmJAb0LerC90KKzUnempAk3hrJU9LHKtKQIZB/0oHORzYp9NFC0z2Csl5s81mA8/KAkae62z0JUh+ZyjHH6V1w/o2gH4kvTRCoDOsgH89363XkM8jFjwRVHEvVZTdc2FhM9+xEYYO0JMOmq4p+M9ax5oDC7nzFVRVBpi84+aCsDSnMNIqGkoRNXQiTiKv9FHwtY1Eb2ZwWyhg0Tv0taIAKZRzPBmDiHBM1OjS7Ev9UFY0JK5a9s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(40470700004)(36840700001)(46966006)(83380400001)(316002)(82310400005)(36756003)(54906003)(86362001)(40460700003)(16526019)(2906002)(5660300002)(36860700001)(4326008)(6916009)(8936002)(70586007)(8676002)(41300700001)(70206006)(1076003)(47076005)(66574015)(426003)(478600001)(2616005)(26005)(186003)(6666004)(40480700001)(336012)(7696005)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 16:55:16.7462 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc1a8a3-b0ac-48a8-f790-08db181a3c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6831
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Add a field in struct v11_gfx_mqd for userqueue
  fence address.

- Assign fence gpu VA address to the userqueue mqd
  fence address fields.

v2: Remove the mask and replace with lower_32_bits (Christian)

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c | 3 +++
 drivers/gpu/drm/amd/include/v11_structs.h                 | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
index d2e5a42e1f75..b8943e6aea22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue_mqd_gfx_v11.c
@@ -83,6 +83,9 @@ amdgpu_userq_gfx_v11_mqd_create(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_u
     mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
     mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
 
+    mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+    mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+
     /* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
     rb_bufsz = order_base_2(queue->queue_size / 4) - 1;
     tmp = RREG32_SOC15(GC, 0, regCP_GFX_HQD_CNTL);
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index f8008270f813..797ce6a1e56e 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -535,8 +535,8 @@ struct v11_gfx_mqd {
 	uint32_t reserved_507; // offset: 507  (0x1FB)
 	uint32_t reserved_508; // offset: 508  (0x1FC)
 	uint32_t reserved_509; // offset: 509  (0x1FD)
-	uint32_t reserved_510; // offset: 510  (0x1FE)
-	uint32_t reserved_511; // offset: 511  (0x1FF)
+	uint32_t fenceaddress_lo; // offset: 510  (0x1FE)
+	uint32_t fenceaddress_hi; // offset: 511  (0x1FF)
 };
 
 struct v11_sdma_mqd {
-- 
2.25.1

