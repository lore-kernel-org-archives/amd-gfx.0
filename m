Return-Path: <SRS0=oLN9=GA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E425DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94752207CC
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Dec 2020 09:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94752207CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5962E89A8B;
	Mon, 28 Dec 2020 09:19:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C9E89A8C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Dec 2020 09:18:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kvpp4bMJhGjE8ZI6zLuY+oJi5RKDhUBdAhiHt6Cd5aPR/iC2WfyQZnJTqd1Fsu/ivHE/LdFSvqh98MZ8vKlExSFNzF7h7BUjl6rKT9YaQRdBJ7+x5Tf+NfQeexHs8mr/jKN6Bs1l6SsYjrUbS6jDgAkJDihryTqDEGNjPUvy+BAzVEQ29uFoy5E1Tn4eIXKaFINnj9g69iwoTW8vnIYjQ79xlZ4cRzBCLTrA+7umCovc6TFBX+B2VN9bl2qANa0wMEIOouz/+sEJLvsg71iBCBM+XMablQWm9O7yYWYz0GGTNo9e7J14reS7sF4ZoClF5F8ONY7fJ7QwH4X5Ghq/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnbO3q6QAWV1GKEIqh4K+/he0vF3o0aSHq27oDK08ho=;
 b=mxOzlZOsBM7j+uw7biJKDVuSfk7rnZkgPdhrYnw89+kpATEL9k+MxsvoS+j4VPYIMXwEAsE41syb6lwmhuHdvCdxl1VjALrUPOFhtRRtzKOWk1jUBhqR2YyHNSauvFoIPtZFjOoJvU3bmjkwMw5e3QdVt4mf4KuSpN+L7UOblDz0mA7JkE1BSHv5TLM0mHnKU0zMJqkeZS7lQfDMqOOAZsl+lj5hkuMr/xo0KriGeEXIen8v5LKoQS91//w/64xsaTCuGUoHCF7/oVujwv7cFKLFADdSQ+BXpFN+NkL4UfXG0Ma0+S58kO56+jyAk2dQH3nlyIvr4rLjH3V6bmNOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnbO3q6QAWV1GKEIqh4K+/he0vF3o0aSHq27oDK08ho=;
 b=1vHXqjbSUEIYLuyA1n8K9XFeSRW4X+TyYIMBWARQpL/EttRanCAb/CFFoQDDfN2ZptIMXXhwQCxhubSfXx6M3INXjBe9gmtxhElT3aJkeox0YNGEDjYcz5ofjRaIBOephY8eCzrWhaBcC+oOOh3MZYuBHsrB+4Xm3HwnCEqwNU8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Mon, 28 Dec
 2020 09:18:58 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::38a7:197b:75f0:6030%12]) with mapi id 15.20.3700.031; Mon, 28 Dec
 2020 09:18:58 +0000
From: Likun Gao <likun.gao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/5] drm/amdgpu: remove redundant logic related HDP
Date: Mon, 28 Dec 2020 17:18:34 +0800
Message-Id: <20201228091834.3240927-5-likun.gao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201228091834.3240927-1-likun.gao@amd.com>
References: <20201228091834.3240927-1-likun.gao@amd.com>
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR0302CA0020.apcprd03.prod.outlook.com
 (2603:1096:202::30) To MWHPR12MB1854.namprd12.prod.outlook.com
 (2603:10b6:300:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lnx-glk.amd.com (180.167.199.189) by
 HK2PR0302CA0020.apcprd03.prod.outlook.com (2603:1096:202::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.12 via Frontend Transport; Mon, 28 Dec 2020 09:18:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fb873d71-89b7-4066-e2e9-08d8ab119b89
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45080EE2FA2AE2E4C0302D9BEFD90@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFVYHnij7ssUGs6LmRM7WoYCqnx6pHZmzpSKKR11vugAJS9tS3T86fwRwytG7g8Y8CHn0Hi8msCUZOpprXE7PxOHKKHCs0Un/p5uE6vuePs5GTDmq0eYgZhFNp3CfIG6RGJl/lFVRzX3I8bd2C/L3azWgI3Rt9ra6iDrz7/OGxqqNVqEv7/nXZSAQIcqhIFpT5/rOsbIjwjomUCvfqafNvCYNptmrVzSqnc9puHxIxNEq8SuiXJc8pG0N6H0HyZMFEVlPmK+1d/F3myZwX0WOX/N3g/OKzj8BHmSm1cJg+oP2Utm45Eghjw7f7rFnf0mfEMDdedaPqIl/zsAvOIZrq4tVGpVEeXnerRpE0xb9ru4xy9ijTjqteMOP8Qfo7cb63SSbZQfK3FqxLc6hl1L9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(16526019)(66946007)(316002)(2616005)(956004)(478600001)(86362001)(83380400001)(44832011)(4326008)(6666004)(8936002)(8676002)(52116002)(36756003)(1076003)(7696005)(6486002)(5660300002)(26005)(54906003)(2906002)(186003)(66556008)(66476007)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?uImWakXH1viHjNHUYgsz3EdKiy06bQuVFIHWhcVQd7CFWXlKNXHeNcsV/HTi?=
 =?us-ascii?Q?kD3xDTqyLdGHvzVmzBj09MX6PsU7QotOHy5dp0KYYuyLKr3+SvivkTqPfFyK?=
 =?us-ascii?Q?ZCoRS4z+rZbrdYxjWaitDznZzJHsyXyUCi2/nyYV38jVYi1WJJo7so9290RM?=
 =?us-ascii?Q?dT2QEp2T2pQQg5eekogIuNcVSHaMZLMxjcmAp4pqRzKaueP9gOc8j/l3eHsf?=
 =?us-ascii?Q?yfCHYni9PV8os1dz7RLX2AHLO0hfNIVKyfrQNigygZ59Motx3QRn5CxW6hGS?=
 =?us-ascii?Q?auwizNxFrlclxf3+uzeReSW17kesQzdS3FH5jnsjxe+FU86awwrM35OiJvPt?=
 =?us-ascii?Q?+FbL9yIIFrKjk3wv8ww7osMNKAz78XQinkObxFXGU8ISLQRQzUR7q2Ff3sS/?=
 =?us-ascii?Q?ejrMKKxEz/pAbpzvfJGxh4tu/TnqOozCkHln4LZP9m24Lg8MEYyZzaJ56G6G?=
 =?us-ascii?Q?Pf5xudz9MO5SZyzhZM8s7GLSUenLrxb2hDzLi1aQD0sh1vdzKaX54ctuQiOD?=
 =?us-ascii?Q?qLfAKpAU9L06z1XaySBJvw39G4mLl6Um5+GvYa09ioq3gIP/LRyp5Va3EMTw?=
 =?us-ascii?Q?2aC6dB2/nvIiFoJY6EsskTtvUgSIVYismkaRjfCYearjDxeTbvv6a7dfp2dU?=
 =?us-ascii?Q?xqoSOU5R84x8EonlaHROTvyuDnwRX80NzuzHD03k8fb39xKW9yvDnU8wrBy4?=
 =?us-ascii?Q?uJaOckfxyeli79uaCvLYgS6xz4TVlzPkNeY96/9yMpYjQWiLE4eFGiWWOwpY?=
 =?us-ascii?Q?vgx6r+EFOfnlPVbtKBb1H+AhA4hUW45C72JK8mfjLvbd2cqRN9to9sOnno4C?=
 =?us-ascii?Q?I8WVgo++0QOqlQCiVVyUB6I4VvvXrKcswSevoTE8K/aLLblU0LAqwAtkJ5Zk?=
 =?us-ascii?Q?CUZ6YLa2ri1uURdQK0vACSwXUU6LjQK1/E2CxGk4UuQJl3hLxpaMMQsOHj3T?=
 =?us-ascii?Q?KrpA8ZHVjulu5FlPr9rMnxZlDrstH7JKj2M15vKAIJr72Uo86dY5AQ9wH+Si?=
 =?us-ascii?Q?btvH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2020 09:18:58.3414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: fb873d71-89b7-4066-e2e9-08d8ab119b89
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Q+LHRl3a3ejdfUcoEfW9EGLASYuMn0cwHyPBXn1C+Gm4K61DmzALud3rqCOuZvz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Remove hdp_flush function from amdgpu_nbio struct as it have been unfied
into hdp struct.
Remove the include about hdp register which was not used.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Change-Id: I7b1ce7424a97efe82ccb6ce63505e724530715ac
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 -
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c   | 10 ----------
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c   | 13 -------------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c   | 10 ----------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c   | 10 ----------
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   | 10 ----------
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  1 -
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  1 -
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  1 -
 11 files changed, 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index e62cc0e1a5ad..4ba0024aedf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -57,7 +57,6 @@ struct amdgpu_nbio_funcs {
 	u32 (*get_pcie_port_data_offset)(struct amdgpu_device *adev);
 	u32 (*get_rev_id)(struct amdgpu_device *adev);
 	void (*mc_access_enable)(struct amdgpu_device *adev, bool enable);
-	void (*hdp_flush)(struct amdgpu_device *adev, struct amdgpu_ring *ring);
 	u32 (*get_memsize)(struct amdgpu_device *adev);
 	void (*sdma_doorbell_range)(struct amdgpu_device *adev, int instance,
 			bool use_doorbell, int doorbell_index, int doorbell_size);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5f4805e4d04a..a896e3d0fcf8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -38,7 +38,6 @@
 #include "gc/gc_9_0_sh_mask.h"
 
 #include "vega10_enum.h"
-#include "hdp/hdp_4_0_offset.h"
 
 #include "soc15_common.h"
 #include "clearstate_gfx9.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index b5c3db16c2b0..b860f1c7b5b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -80,15 +80,6 @@ static void nbio_v2_3_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v2_3_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v2_3_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
@@ -366,7 +357,6 @@ const struct amdgpu_nbio_funcs nbio_v2_3_funcs = {
 	.get_pcie_data_offset = nbio_v2_3_get_pcie_data_offset,
 	.get_rev_id = nbio_v2_3_get_rev_id,
 	.mc_access_enable = nbio_v2_3_mc_access_enable,
-	.hdp_flush = nbio_v2_3_hdp_flush,
 	.get_memsize = nbio_v2_3_get_memsize,
 	.sdma_doorbell_range = nbio_v2_3_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v2_3_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index d2f1fe55d388..8427f10712ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -50,18 +50,6 @@ static void nbio_v6_1_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v6_1_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_SOC15_NO_KIQ(NBIO, 0,
-				    mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL,
-				    0);
-	else
-		amdgpu_ring_emit_wreg(ring, SOC15_REG_OFFSET(
-			NBIO, 0, mmBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL), 0);
-}
-
 static u32 nbio_v6_1_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_PF_0_0_RCC_CONFIG_MEMSIZE);
@@ -266,7 +254,6 @@ const struct amdgpu_nbio_funcs nbio_v6_1_funcs = {
 	.get_pcie_data_offset = nbio_v6_1_get_pcie_data_offset,
 	.get_rev_id = nbio_v6_1_get_rev_id,
 	.mc_access_enable = nbio_v6_1_mc_access_enable,
-	.hdp_flush = nbio_v6_1_hdp_flush,
 	.get_memsize = nbio_v6_1_get_memsize,
 	.sdma_doorbell_range = nbio_v6_1_sdma_doorbell_range,
 	.enable_doorbell_aperture = nbio_v6_1_enable_doorbell_aperture,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
index ae685813c419..3c00666a13e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -60,15 +60,6 @@ static void nbio_v7_0_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v7_0_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_0_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE);
@@ -292,7 +283,6 @@ const struct amdgpu_nbio_funcs nbio_v7_0_funcs = {
 	.get_pcie_data_offset = nbio_v7_0_get_pcie_data_offset,
 	.get_rev_id = nbio_v7_0_get_rev_id,
 	.mc_access_enable = nbio_v7_0_mc_access_enable,
-	.hdp_flush = nbio_v7_0_hdp_flush,
 	.get_memsize = nbio_v7_0_get_memsize,
 	.sdma_doorbell_range = nbio_v7_0_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_0_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index aa36022670f9..598ce0e93627 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -56,15 +56,6 @@ static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
 }
 
-static void nbio_v7_2_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
@@ -325,7 +316,6 @@ const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
 	.get_pcie_port_data_offset = nbio_v7_2_get_pcie_port_data_offset,
 	.get_rev_id = nbio_v7_2_get_rev_id,
 	.mc_access_enable = nbio_v7_2_mc_access_enable,
-	.hdp_flush = nbio_v7_2_hdp_flush,
 	.get_memsize = nbio_v7_2_get_memsize,
 	.sdma_doorbell_range = nbio_v7_2_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_2_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index eadc9526d33f..4bc1d1434065 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -82,15 +82,6 @@ static void nbio_v7_4_mc_access_enable(struct amdgpu_device *adev, bool enable)
 		WREG32_SOC15(NBIO, 0, mmBIF_FB_EN, 0);
 }
 
-static void nbio_v7_4_hdp_flush(struct amdgpu_device *adev,
-				struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg)
-		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-	else
-		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
-}
-
 static u32 nbio_v7_4_get_memsize(struct amdgpu_device *adev)
 {
 	return RREG32_SOC15(NBIO, 0, mmRCC_CONFIG_MEMSIZE);
@@ -541,7 +532,6 @@ const struct amdgpu_nbio_funcs nbio_v7_4_funcs = {
 	.get_pcie_data_offset = nbio_v7_4_get_pcie_data_offset,
 	.get_rev_id = nbio_v7_4_get_rev_id,
 	.mc_access_enable = nbio_v7_4_mc_access_enable,
-	.hdp_flush = nbio_v7_4_hdp_flush,
 	.get_memsize = nbio_v7_4_get_memsize,
 	.sdma_doorbell_range = nbio_v7_4_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v7_4_vcn_doorbell_range,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index ce56e93c6886..c8c22c1d1e65 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -46,7 +46,6 @@
 #include "sdma6/sdma6_4_2_2_sh_mask.h"
 #include "sdma7/sdma7_4_2_2_offset.h"
 #include "sdma7/sdma7_4_2_2_sh_mask.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "sdma0/sdma0_4_1_default.h"
 
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index b208b81005bb..d345e324837d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -32,7 +32,6 @@
 
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
-#include "hdp/hdp_5_0_0_offset.h"
 #include "ivsrcid/sdma0/irqsrcs_sdma0_5_0.h"
 #include "ivsrcid/sdma1/irqsrcs_sdma1_5_0.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 312ecf6d24a0..7cd67cb2ac5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -36,7 +36,6 @@
 #include "vce/vce_4_0_default.h"
 #include "vce/vce_4_0_sh_mask.h"
 #include "nbif/nbif_6_1_offset.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "mmhub/mmhub_1_0_offset.h"
 #include "mmhub/mmhub_1_0_sh_mask.h"
 #include "ivsrcid/uvd/irqsrcs_uvd_7_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index c734e31a9e65..6117931fa8d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -32,7 +32,6 @@
 
 #include "vcn/vcn_1_0_offset.h"
 #include "vcn/vcn_1_0_sh_mask.h"
-#include "hdp/hdp_4_0_offset.h"
 #include "mmhub/mmhub_9_1_offset.h"
 #include "mmhub/mmhub_9_1_sh_mask.h"
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
