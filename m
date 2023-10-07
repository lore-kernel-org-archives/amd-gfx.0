Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68694E94139
	for <amd-gfx@archiver.kernel.org>; Sat,  7 Oct 2023 03:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B076210E06F;
	Sat,  7 Oct 2023 03:24:37 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAD210E058
 for <amd-gfx@lists.freedesktop.org>; Sat,  7 Oct 2023 03:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccKJ2Uc89MGJ4JI4qb099JyWL40jfxphOLquPpC1ko2qf6WNQ3iSUkv+DIwM4apwU9cHuxuEZx0IZTdDopy6+8Da2xfDJtjbbQL72LukxDBlxVLV6yo+Q2nzo1UIo6x0AqEdN/TjFY/A3TRbvukSidx6/FnP2sLqFKzU2IQY+ifRIFVzWi8jqnoWMOiE2eKIkRcLsNEFrJkVoMxziC9qi9V3IY6R8PzNWIo1fxoLa5s6iq2K1iy2FT3+A3CVpYHeCsLTMaMMyrzyyQUR8mS57vT4pxOTS+ZP8QBFmzkfeUYiPKXB65Qg+Bg73g8kNjqNiIUp2Yx9HbxGTDjQvvmaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qir0UAbJehKda2knMyEwh09dINXqtgV/kdoG7ZiHbsI=;
 b=T4al3gEmybkQu6itPkMdOdlgW1maemTUWHQM9zVavg1oixrdscyJufQKlPjJrqd9JzDqsHZPUhmP43uqxHESvK05lTIP2hfqNNGdrEz26CS08fnLmHIcKjmwjXAjZZ0O2qrnevHfYM4hU4OoxRDZL51/ZIa/k58KhqCbx0W3hKG6d1FBg2KoBYqsbUv5ailHex31K9HmfpwPjT2aUG/kywoFoEA1YWLOgr0QfmzBbLK70VHId/nZW7jE3IHn3eQStdHN7EewQY/SRte7GbqLk8QuZfUiUGU9n8ZBqYUpp59b7hDsutsqc+D6pKJrgCwKFj3RPxUYyYSSzZ9YwVpfxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qir0UAbJehKda2knMyEwh09dINXqtgV/kdoG7ZiHbsI=;
 b=k6NNG4RdpXU21UjtHTZ/WvoqfjYtmywON5+dAczSLZJlVC40Mo8smmLujQoMnMqMqxmYmfiTOjwB009YwhXy+MNqhA3DuxxZngL0qqm8P70chwYuRLzZ2Lshg2l6Fl1kZZnpTdMIqMw/UFx/biiHn4X8k71zkVJPV3H5S96ntm4=
Received: from DS7PR03CA0335.namprd03.prod.outlook.com (2603:10b6:8:55::34) by
 PH7PR12MB6980.namprd12.prod.outlook.com (2603:10b6:510:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Sat, 7 Oct
 2023 03:24:32 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::10) by DS7PR03CA0335.outlook.office365.com
 (2603:10b6:8:55::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Sat, 7 Oct 2023 03:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 7 Oct 2023 03:24:31 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 22:24:29 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>, Solomon Chiu <solomon.chiu@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/vpe: remove IB end boundary requirement
Date: Sat, 7 Oct 2023 11:24:14 +0800
Message-ID: <20231007032416.9557-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH7PR12MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea13020-ca39-4c02-9d70-08dbc6e4ebec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4juL20G5EuNhntLVyhx1zU2Y2W5vq9RRG3UNQQ+k3EiMuWsYBGUyt5nz2OIBb0rMGfFiV0OQb0y875LZyXs8E1uA+lQm/10piWSP7qmfgi4AQBRQXiDopc35PRd63240J3rokfx23pEB8fvc48/GxyKWVAf03nkDqiBITeJhofje4iMNDffWSYV2BViqdy8qRmCxhQBi3bGOT4zLcFmwdPZAjAKIYkS0n9ksRBQje8avhPU+6HlW4Vutacu97RJjyxkmxGUNNhZCBAe7bFe0YT3eTlCu7s1QK7tBBWFLutNQOTO0Z1RuEdnP3kSRmAnlk8Bha+BmleTN+Ftn7bJsv0sXErWLB5jOG3TzB007YZmhr1+1YTQwW225R0fW6eMFlogflOasTL2T1TIG0KS7f1gU33zkhgLAQoPjFI1k3KYQn/9v6Je0OFtvL3pX/PG5PUcyz0SydSRWTKsaunKRGe4sIprXb/EXLsN8SQgLJfa9iLyzSiRmHNEAO22TnD2RBFIQiDHPbP1PO19Hr0SDJmf39LJsE4GBpbUGIFzJELQ2x8HVwv/Vk8dcrIC2DqYe7A4elrwSNbwKxU4SmHRp9ECIrIi7VYv8izj940VCbzphLjOZIdKg8zEiPJnEGqh/Q5R9yhMy69H6afPHI9TMD3OiyeBD045ihqhgwmaR13WYpntNL1RXkzg094EqseS6kpmknTdYpuFOxcs3cm5TYGI0qk2iu3on0mldSmZi9b9zk2Hce3kH/4LcJSqmOSrfFPdx9scgWPlrPeZVL+KPCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(1800799009)(82310400011)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(7696005)(2616005)(1076003)(40460700003)(86362001)(36756003)(40480700001)(36860700001)(356005)(82740400003)(81166007)(16526019)(26005)(426003)(47076005)(83380400001)(2906002)(6666004)(478600001)(70586007)(8676002)(8936002)(70206006)(41300700001)(4326008)(316002)(6636002)(5660300002)(54906003)(110136005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 03:24:31.4959 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea13020-ca39-4c02-9d70-08dbc6e4ebec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6980
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
Cc: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove IB end boundary requirement,
VPE has no such limitions, use existing
amdgpu_ring_generic_pad_ib() instead.
This is missed in rebase.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 81e5600bd545..23966221dbec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -247,21 +247,6 @@ static void vpe_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
 		amdgpu_ring_write(ring, 0);
 }
 
-static void vpe_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
-{
-	uint32_t pad_count;
-	int i;
-
-	pad_count = (-ib->length_dw) & 0x7;
-
-	ib->ptr[ib->length_dw++] = ring->funcs->nop |
-				   VPE_CMD_NOP_HEADER_COUNT(pad_count - 1);
-
-	for (i = 0; i < pad_count - 1; i++)
-		ib->ptr[ib->length_dw++] = 0;
-
-}
-
 static uint64_t vpe_get_csa_mc_addr(struct amdgpu_ring *ring, uint32_t vmid)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -285,9 +270,6 @@ static void vpe_ring_emit_ib(struct amdgpu_ring *ring,
 	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
 	uint64_t csa_mc_addr = vpe_get_csa_mc_addr(ring, vmid);
 
-	/* IB packet must end on a 8 DW boundary */
-	vpe_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
-
 	amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_INDIRECT, 0) |
 				VPE_CMD_INDIRECT_HEADER_VMID(vmid & 0xf));
 
@@ -636,7 +618,7 @@ static const struct amdgpu_ring_funcs vpe_ring_funcs = {
 	.emit_reg_wait = vpe_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.insert_nop = vpe_ring_insert_nop,
-	.pad_ib = vpe_ring_pad_ib,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.test_ring = vpe_ring_test_ring,
 	.test_ib = vpe_ring_test_ib,
 	.init_cond_exec = vpe_ring_init_cond_exec,
-- 
2.25.1

