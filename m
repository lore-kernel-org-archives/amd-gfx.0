Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF49C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 09:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDF164F5F
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 09:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDF164F5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF5206EB25;
	Fri,  5 Mar 2021 09:10:39 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F876EB25
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 09:10:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7RWeaaOl2trPDzEWl1Re5+rI2+puduZ858GxBU5mIkugoyGafTFx65raBiZluJUxygMzWHHM7lGURJzj1UnK4GnEY4LGGLozeJRUGfR0m/qUGkhcR5qsOJon1fDmOtzs3gv1KvOVznf8vhQqCZdJEYmaQHhGDqGcilmuO038zcwsLgCcavQqZUayqsUn/iOeZzTbnYkcQjA3RHSo9kmyXHlMNc0S38uiC13gmErRRlbLSbN41evt83TS/m1gkcLcu5sW0XYKqAOByuc3yXD29F3tPgPQltyLjBrRTnCR6w21er9Pklkl8jYz2tw6YCk6mLJBX8wpSoLXk+1zON+SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk4d+supPZUtKOvo/9TECeFF75xgPmsuZS85Tq5Zfe0=;
 b=XijOfeIU5WVFmLHAtSb53XfbQKYof0MZ+kndTFUawMCyWJPyi3yukLXTPusdZwxO1gQt+iEB/JiVQ2s65zUTSkMloVrvhL3b+Vq7+pcOEO+XlxMJ/+sjgcJ6CstDy/vkw2EUj1dQXGyDpt0EIFmLa1x/uzOhVyIvym1CuxICpJJ/S5GW6dol1dLi9YdB3tjpunJY6DsxU5hJZs1HRYLtEjB8A2wqf5RGraHs/I6Wazj0MFob7iVeaYdg9ALylIcT881bRkyK/K/vfrZMXRmS6BQsonYcC5V7AkGqv8AHAkc6HQJfiZPDG3Q28dAJ1N2r/RiO6/H2qj/hRtP2hPOPqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uk4d+supPZUtKOvo/9TECeFF75xgPmsuZS85Tq5Zfe0=;
 b=wM86cFRR2LX/1OL/qwzznWzzCf2guRczQVi2gAaj2RS8bj+PbNI6KVEY0znuBeTv2MoXupRH8W82oq6OObMh5UdQsQi9auWfAgXcedwRykWASvOpJvIwmJb/0IGYnnPVQHu70qdBLmnaQlKUnLHOlY5tBzgOoI0AJPN7a0fS5wY=
Received: from BN8PR15CA0042.namprd15.prod.outlook.com (2603:10b6:408:80::19)
 by DM6PR12MB3979.namprd12.prod.outlook.com (2603:10b6:5:1cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 09:10:36 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::f) by BN8PR15CA0042.outlook.office365.com
 (2603:10b6:408:80::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 09:10:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 09:10:34 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 03:10:10 -0600
Received: from fiona-codemachine.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Fri, 5 Mar 2021 03:10:09 -0600
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: remove ECO_BITS programing on gmc9
Date: Fri, 5 Mar 2021 17:10:06 +0800
Message-ID: <20210305091006.65628-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d7d1532-f29d-45c9-65b9-08d8dfb68914
X-MS-TrafficTypeDiagnostic: DM6PR12MB3979:
X-Microsoft-Antispam-PRVS: <DM6PR12MB39795FFC6851B91E50EFBCB5FE969@DM6PR12MB3979.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q9FKpEkyQSDdMWhAJLoDgUWUE1UiQGEHbDMyvHi4BPu2iLCO9n43EqIHc4toaGizksuSNz4+brCcn82O9xwImVT+diH3xKMRsrPECrW2CZ9RmgdCiZzUfpcLfhsYQLALrckcRpEBCJa/84InK/TvG3ewhtg8ZdcP21qMy95tjhajbntHwAHb6xRcXAobCc2shO00tUkAl1FBKPjlkGf019AqXxF3T5oAPWwmlSYyTo20p8t6EQ2r95tuzQsxgzTZQMlGJE8G89ZqowbyUqGQ+EBwqbZwPouTEpsRVlEdM2bdxRS7Pg6bvxkx2V25h6xPEdHHOYfEm6ysogV9kstR37k+2ABHKAgJEzKGN8o6RNZQlufP08H5NXLH+uu/xma5C93CbZLis+pjy/v45Dr3p/gGmDqSP8NngBz456hlaZ7vFtRzIxye2MR7zUvetJqQujaiUVu9zTGS5JXhwd0l3YpkSYaN4CINeeO51HZMx9cwuzgyRvNBejYbt7WVH5IRh+m6h/bvvfOKPnI4+skofLOpWD6dYih+OavWnwIc5DZ72NqFOkNjpcaZoBzpHtwx5b+GVbO6AARsRBL8uewPk4OpLKZEgRo+/QoA1RTi2cxpWzn2TKfRULBQDAB6xdxTbJSFjTmmGqTtdv1pUiCDIOzY1Uv23GXqR3LcT7Nv3JmDZWos+mvq5MOTS4+XVpG/Y/pdm3xhkYSk8Q7tJ1xrXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(70586007)(70206006)(478600001)(2616005)(186003)(8936002)(1076003)(4326008)(36860700001)(8676002)(47076005)(6916009)(316002)(7696005)(82310400003)(54906003)(86362001)(336012)(36756003)(426003)(81166007)(82740400003)(26005)(5660300002)(356005)(2906002)(6666004)(83380400001)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 09:10:34.8793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7d1532-f29d-45c9-65b9-08d8dfb68914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3979
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
Cc: Amber.Lin@amd.com, Feifei Xu <Feifei.Xu@amd.com>, Hawking.Zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the ECO_BITS programing in driver on gfxhub1.0,
mmhub1_x and mmhub_9.4.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 2 --
 4 files changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 0ab498d93e48..0cf993797df8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -186,7 +186,6 @@ static void gfxhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 0145d4d201cf..37b985317012 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -164,7 +164,6 @@ static void mmhub_v1_0_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 816ff110a074..9099162553a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -189,7 +189,6 @@ static void mmhub_v1_7_init_tlb_regs(struct amdgpu_device *adev)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, MC_VM_MX_L1_TLB_CNTL, ATC_EN, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 65fb88d391d3..d68f3cd2d40d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -219,8 +219,6 @@ static void mmhub_v9_4_init_tlb_regs(struct amdgpu_device *adev, int hubid)
 			    ENABLE_ADVANCED_DRIVER_MODEL, 1);
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
 			    SYSTEM_APERTURE_UNMAPPED_ACCESS, 0);
-	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
-			    ECO_BITS, 0);
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
 			    MTYPE, MTYPE_UC);/* XXX for emulation. */
 	tmp = REG_SET_FIELD(tmp, VMSHAREDVC0_MC_VM_MX_L1_TLB_CNTL,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
