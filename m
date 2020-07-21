Return-Path: <SRS0=9beK=BA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A06C433E5
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0536A20714
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2020 10:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DHMIyqjr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0536A20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B322E6E4C5;
	Tue, 21 Jul 2020 10:29:43 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3271B6E4B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2020 10:29:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbUkRdLG1YB3pVVFClBJtWJDiPaUNMhHsnDsbbJtlxQJFbikSsyZ10Kq3DpuGm43N1ldjyHCXX2YExd4NMs9sYRoGh12OF1ApLroZ5OuHD3IqDYWg+o17SVleZXFPpD5FoCXMeman7rlOM3reSZj6HkHUXkaMd3ccpdPbDsW5nQHX1QzOGSnwVKFrjShmEn2u+wiaAciY0cT10sC+1z+/unvxL07S7ypwoLzuOworF0/M7m8F5cLtUhFTBU86YV19nARUuz7ScHDak1ALHHhLXB4AlxgfoJX26AmLbi5QW9L1Yb8qd1B4JMwO215q1QQZdvGE9tzbWSeA0y8XAeN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2NoLgT8TL8fyFkCHLruD/Retu/N2TVcjRsB6n9Nbkw=;
 b=UoC80qHumlXbifc5/mQyFjLoX3gp14sCSBhd6BXxhFUrbNfysumqY3NeSC06ZBR3PZ9PmJ1YNwHwMTxb0vFOv0qxEZsLpUnABVPhTTWv/NgGp1i+Rz5EOcQvJQo3Xi0PIZR6clrULK2x2pxdc1ycL6K8eEWcsk6WbPwMlVYXrdJOj29zg1HfJ4iTkqH0oal9zyFTbXyaTyvFSk4bmRIwfvezAmE3fT+XDyjjaBQhQYdmaNAO4O2AA7Zg91f216Sl/54OCyoH0w7wvMv64K0HOBkazqxDQuThYF/7CaHq0BiITnmhm8y8mO4bDPje2YIeUuo8gCs8yLjYqLZj9MH8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2NoLgT8TL8fyFkCHLruD/Retu/N2TVcjRsB6n9Nbkw=;
 b=DHMIyqjr6olXXif67AdkbDoXHbzeFeq+b6b/6IyMNwNboCrCYJ2iZMtmIjpIo/md+9g4pDXuefwpgrrHf+/fcH7x/t7PuIf4h0ml9YuMU02HqqOV7XVIvgSaB5HBTGGjBf3A+xdvp4etI9XxOquqBfBuqFnNEqZu06KeLrixqoc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 10:29:40 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3216.020; Tue, 21 Jul 2020
 10:29:40 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu: add vmhub funcs helper
Date: Tue, 21 Jul 2020 18:29:17 +0800
Message-Id: <1595327359-120379-4-git-send-email-ray.huang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
References: <1595327359-120379-1-git-send-email-ray.huang@amd.com>
X-ClientProxiedBy: HKAPR04CA0008.apcprd04.prod.outlook.com
 (2603:1096:203:d0::18) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-intel.amd.com (58.247.170.245) by
 HKAPR04CA0008.apcprd04.prod.outlook.com (2603:1096:203:d0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3195.18 via Frontend Transport; Tue, 21 Jul 2020 10:29:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 059ff263-7107-42de-f47f-08d82d60f97d
X-MS-TrafficTypeDiagnostic: MN2PR12MB4144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4144A207C246490A6247263AEC780@MN2PR12MB4144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RE/dtp9zXrZUQixLuzchnaSPBAfQaUhmDFxIpj0GiCfdeS9++lnbviknBuijl+guodCBPIXymlsbssKcX7EabxoDG2PZ/LFJfd18/z1j1jVW1gbya8EusLp7BMJN5m3gJYL+DBmbd4t7HE4j5/r8nb5pxW4dNeJ6ZiPHtVPy8lrKaSx1JpCdrsw6iC/23oarGAs2SeVKDKTInCvIKiz6JrgdOpoUn6GbZI3lloBiiym5AGyizvwPoctEZnPT21UqHwrKtsxIunVATbJmbu9gM6GXogh2A+uv/F/FM8zutOBQm0GAz5yWhrJdKOxlsv0mPeTd7fal/cIfz4E2VXsHWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(956004)(2616005)(7696005)(26005)(478600001)(16526019)(186003)(4326008)(52116002)(19627235002)(6486002)(6666004)(2906002)(66476007)(66556008)(36756003)(83380400001)(5660300002)(86362001)(66946007)(8676002)(6916009)(8936002)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zJRikeYbDHXgcCwaAiKleSKFtMgUu9MLwIV54pohZW5GRZ4dseJZGhal23OO7p4kmkC8ZxGw22snB3Ga/5vGnjczNbmT+oV0DXaKTTuYFztTX+3i9UcnE5rmzCCj5W3O/HGezEJ7/CLf+PKOPQqM2nF4WYa/iUJi3tQkZcyIQf01Kfj1Z++YH7kGZA9ZSLbKyel4DCykRou9TtxsjAdTkrVQp/HDzFLVTQ7AZQCaTnxdQPHGPv/UXEBUjpjY07WTbeMWhAPzBIsnqXybLBAfkND8lsPUYddMD+KCQSQGD0mi/Nnm/AcYbSiz34fbnBwPOYiGFdhM5LHBYFzPWYGS5ScvrdsZ0igQlyYSPLU7o0anZ5E5zrDGnXQ4WAFo9MpIFb71T+y8IhP4gYLZNa06Bv4C8aqFETGqdhBU6dahVui9OGU05R0l4piLQMdxUK8+R4mcaRwbgkXuUGjW6GQzTVBWegVxVXiaJGMIBFDFpas6wVbk9O5oSVUrfTA2SDAO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 059ff263-7107-42de-f47f-08d82d60f97d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2020 10:29:40.4243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vkTGO4i8X7DwKh8MObQ3QTn42KFwbl3A0p3aVmiJJAmMSy4pDPxJplK0VJS6841AjUbAYOZkx57soqT2uaX/Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
Cc: Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch is to introduce vmhub funcs helper to add following callback
(print_l2_protection_fault_status). Each GC/MMHUB register specific programming
should be in gfxhub/mmhub level.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 34 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 34 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 25 ++---------------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 34 ++++++++++++++++++++++++++++++++
 5 files changed, 111 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 1785a0e..bbecd87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -74,6 +74,11 @@ struct amdgpu_gmc_fault {
 /*
  * VMHUB structures, functions & helpers
  */
+struct amdgpu_vmhub_funcs {
+	void (*print_l2_protection_fault_status)(struct amdgpu_device *adev,
+						 uint32_t status);
+};
+
 struct amdgpu_vmhub {
 	uint32_t	ctx0_ptb_addr_lo32;
 	uint32_t	ctx0_ptb_addr_hi32;
@@ -94,6 +99,8 @@ struct amdgpu_vmhub {
 	uint32_t	eng_addr_distance; /* include LO32/HI32 */
 
 	uint32_t	vm_cntx_cntl_vm_fault;
+
+	const struct amdgpu_vmhub_funcs *vmhub_funcs;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 993185f..14268ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -31,6 +31,33 @@
 
 #include "soc15_common.h"
 
+static void
+gfxhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	dev_err(adev->dev,
+		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
+		status);
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
+}
+
 u64 gfxhub_v2_0_get_fb_location(struct amdgpu_device *adev)
 {
 	u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
@@ -360,6 +387,10 @@ void gfxhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static const struct amdgpu_vmhub_funcs gfxhub_v2_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v2_0_print_l2_protection_fault_status,
+};
+
 void gfxhub_v2_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
@@ -398,4 +429,7 @@ void gfxhub_v2_0_init(struct amdgpu_device *adev)
 		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
+
+	if (hub->vmhub_funcs == NULL)
+		hub->vmhub_funcs = &gfxhub_v2_0_vmhub_funcs;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 07cae64..45fbce7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -31,6 +31,33 @@
 
 #include "soc15_common.h"
 
+static void
+gfxhub_v2_1_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	dev_err(adev->dev,
+		"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
+		status);
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, CID));
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%lx\n",
+		REG_GET_FIELD(status,
+		GCVM_L2_PROTECTION_FAULT_STATUS, RW));
+}
+
 u64 gfxhub_v2_1_get_fb_location(struct amdgpu_device *adev)
 {
 	u64 base = RREG32_SOC15(GC, 0, mmGCMC_VM_FB_LOCATION_BASE);
@@ -359,6 +386,10 @@ void gfxhub_v2_1_set_fault_enable_default(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static const struct amdgpu_vmhub_funcs gfxhub_v2_1_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v2_1_print_l2_protection_fault_status,
+};
+
 void gfxhub_v2_1_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
@@ -397,6 +428,9 @@ void gfxhub_v2_1_init(struct amdgpu_device *adev)
 		GCVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
+
+	if (hub->vmhub_funcs == NULL)
+		hub->vmhub_funcs = &gfxhub_v2_1_vmhub_funcs;
 }
 
 int gfxhub_v2_1_get_xgmi_info(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e6c8526..8f35e13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -121,29 +121,8 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 			task_info.task_name, task_info.pid);
 		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
 			addr, entry->client_id);
-		if (!amdgpu_sriov_vf(adev)) {
-			dev_err(adev->dev,
-				"GCVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
-				status);
-			dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
-				REG_GET_FIELD(status,
-				GCVM_L2_PROTECTION_FAULT_STATUS, CID));
-			dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
-				REG_GET_FIELD(status,
-				GCVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
-			dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
-				REG_GET_FIELD(status,
-				GCVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
-			dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
-				REG_GET_FIELD(status,
-				GCVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
-			dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
-				REG_GET_FIELD(status,
-				GCVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
-			dev_err(adev->dev, "\t RW: 0x%lx\n",
-				REG_GET_FIELD(status,
-				GCVM_L2_PROTECTION_FAULT_STATUS, RW));
-		}
+		if (!amdgpu_sriov_vf(adev))
+			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 48134b9..fb634c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -36,6 +36,33 @@
 #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid                       0x0070
 #define mmDAGB0_CNTL_MISC2_Sienna_Cichlid_BASE_IDX              0
 
+static void
+mmhub_v2_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	dev_err(adev->dev,
+		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
+		status);
+	dev_err(adev->dev, "\t Faulty UTCL2 client ID: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, CID));
+	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, MORE_FAULTS));
+	dev_err(adev->dev, "\t WALKER_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, WALKER_ERROR));
+	dev_err(adev->dev, "\t PERMISSION_FAULTS: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, PERMISSION_FAULTS));
+	dev_err(adev->dev, "\t MAPPING_ERROR: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, MAPPING_ERROR));
+	dev_err(adev->dev, "\t RW: 0x%lx\n",
+		REG_GET_FIELD(status,
+		MMVM_L2_PROTECTION_FAULT_STATUS, RW));
+}
+
 void mmhub_v2_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
 				uint64_t page_table_base)
 {
@@ -351,6 +378,10 @@ void mmhub_v2_0_set_fault_enable_default(struct amdgpu_device *adev, bool value)
 	WREG32_SOC15(MMHUB, 0, mmMMVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static const struct amdgpu_vmhub_funcs mmhub_v2_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v2_0_print_l2_protection_fault_status,
+};
+
 void mmhub_v2_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB_0];
@@ -389,6 +420,9 @@ void mmhub_v2_0_init(struct amdgpu_device *adev)
 		MMVM_CONTEXT1_CNTL__READ_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		MMVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
+
+	if (hub->vmhub_funcs == NULL)
+		hub->vmhub_funcs = &mmhub_v2_0_vmhub_funcs;
 }
 
 static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
