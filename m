Return-Path: <SRS0=/bSq=5R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E55C43331
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 22:00:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F94120719
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2020 22:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3Z2gOAe9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F94120719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3A956E9AD;
	Wed,  1 Apr 2020 22:00:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 291BC6E9AD
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2020 22:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn+SoWsf41jH0NeHOlPJONorq9+Kphy1mKo5avxSdMI6k6A3Bx540z/h/Y4KzWqAcNqU1MceD9xu+9m68vkrto2LzE5CO1LbvQQN5Yc9cQdrlbzbfykB+Ri0D4aVyqOrCj4gB1fYz+sY59Qoagn+uvuPTlk5YpBhtINHf/NTy1u5U9pmLJ+jlHrJtU4WZoapVQVvAKlx8B6AyGDR5K1MmBBIHHk7ygzFe3+x4P08fpn8k+aUuFbs/pO8ZsIolFAxKmaBJAbCgmOmQNxkkXT9zlGVHbTYUnURTiyHqDXI/m1TdJvoT6kRvFPddfGNoVn7CflKFO83s5lV0oMq3UUOrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POUO3/V05p1b3XfMC61M5QIstuA6OapcBtZmLl+cXbg=;
 b=R1op3b1GnLyNGF9YhsiQLmI7susTLd36dzGHOSlYMHhWz+343SRbyqdGyF/p/XtSmgyzNkipc+E3wagnBJd/CAmJ39UYZxVhB0sSBmyxpWBCwiWaYmeyIurho0JdPov7YIAQsbF/1fV+eHsmPyAxq0KLiZ7sH5hmdFlElhJiNXpeQ4LmVKytjNaU2U5VFPTpUoFhWSOdzUqzJ72qv1KPQJ9YVIOssZjC26lzNdEyhktMZmv4yLBlAWrXk8I3yOh8sS0WurFHq+zeCp7hsgpp1mrdnmuXPBUY7Wnv9K+OtAyvu06l/3UAe4eh2ew4qY/LOYo/DmQBJHuIPPcXu+GFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POUO3/V05p1b3XfMC61M5QIstuA6OapcBtZmLl+cXbg=;
 b=3Z2gOAe9bSCYBxh9KoLIB80L4nKw0GPwXwVVHhyUYrSQ4oZvyaU4VaVzvNUG7+hjFS6MBHYqbbbaJSFkpk0Eh71pDtlQqZLl6W5RxyHoIMcSYWLeaaQRRK9eZ6lhq17Rf3H0JefOIDeAGu7iwxkUzMH5mxj9jX/+s0FaVPOEli4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Wed, 1 Apr
 2020 22:00:47 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2856.019; Wed, 1 Apr 2020
 22:00:47 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] amdgpu/drm: remove psp access on navi10 for sriov
Date: Wed,  1 Apr 2020 17:00:13 -0500
Message-Id: <20200401220013.11048-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM5PR04CA0056.namprd04.prod.outlook.com
 (2603:10b6:3:ef::18) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR04CA0056.namprd04.prod.outlook.com (2603:10b6:3:ef::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.15 via Frontend Transport; Wed, 1 Apr 2020 22:00:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4817ac7-3689-4aaa-697e-08d7d6882209
X-MS-TrafficTypeDiagnostic: SA0PR12MB4478:|SA0PR12MB4478:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB44786264F9B2AECCD051DC9BFDC90@SA0PR12MB4478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 03607C04F0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4576.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(6916009)(1076003)(2616005)(16526019)(6666004)(4326008)(36756003)(66476007)(5660300002)(6486002)(186003)(956004)(66556008)(66946007)(8676002)(81166006)(52116002)(44832011)(81156014)(316002)(2906002)(26005)(7696005)(86362001)(478600001)(8936002)(309714004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xAICAHOevNWE8lVgiWpYM1ekl4Kqus1yKJL1FLRCy8UIJIZw7FORgjJz0kTJc90NXZ2MKVCbANx7j4AYbTYevJmqAWRje8Is+sZ69cTXGNsmIgjXAKLvlCSk/Smz6iXA+YbmM9AAUDOFheSRyugDIBkcvnrCZpV/uJ5gdxJ3UvEnK28P0nIwIw1fzDwZTpfnxajl3gFpY++Ir0CpG2WDvMxy9FNrmZ91uI5ZfN1bCkYaA3qusuASaccbGBPlTjBg37AZ2FT2e3HL05bit+i4YZxDTYLfWtaK6ArQkExeN+4gV0zeri+CsbKJs37MXLzhwELfoeFHilGeINR9EsCUaQjhvCUzAAby4WHXVRnZFNy9hM8ZdNTQDJ4PVdUk+2r+Fz9uJTFb5nUai+8h77aZE5Fkvslz5nTBa78x4LSuDvcVzHKC83lkcydUQWyyBRts+VbTZlmVNFUpol/cFuOO3/os8HPSHpKzfcgsL5c/TTAlAGfRXADn0AB5eM7xGsD
X-MS-Exchange-AntiSpam-MessageData: uEdrqv5NiGywpqlrPoXEbbpkPwBzAhMwRCWPZ5dQMfEALR/ARCJiZcy9KNmJD8ugyNLTMT4KUEI930peMRW5b1EnFiKkp42C+UF+cHhKWvmmVBlxwX8Y+s2ydxo9N7dhJepJcRuE+9/0YvqwpjSXlg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4817ac7-3689-4aaa-697e-08d7d6882209
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2020 22:00:47.4478 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msqXR7uaVdCtl7bJN8veiIdOWqNqAaEB2CHQWfvMh+E8bszUXlbAWCs5gylT1nWvPV6RggNO2tElQuZxC5wTsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Navi ASICs don't require to access through PSP to osssys registers.
This on SR-IOV configuration.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 6fca5206833d..f97857ed3c7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -49,7 +49,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
-	if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
 			return;
@@ -64,7 +64,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
 						ih_rb_cntl)) {
 				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
@@ -80,7 +80,7 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
 						ih_rb_cntl)) {
 				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
@@ -106,7 +106,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
-	if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
 			return;
@@ -125,7 +125,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
 						ih_rb_cntl)) {
 				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
@@ -145,7 +145,7 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 0);
-		if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
 						ih_rb_cntl)) {
 				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
@@ -253,7 +253,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
-	if (amdgpu_sriov_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 		if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL, ih_rb_cntl)) {
 			DRM_ERROR("PSP program IH_RB_CNTL failed!\n");
 			return -ETIMEDOUT;
@@ -300,7 +300,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 					   WPTR_OVERFLOW_ENABLE, 0);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
 					   RB_FULL_DRAIN_ENABLE, 1);
-		if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING1,
 						ih_rb_cntl)) {
 				DRM_ERROR("program IH_RB_CNTL_RING1 failed!\n");
@@ -326,7 +326,7 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
 		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
 
-		if (amdgpu_sriov_vf(adev)) {
+		if (amdgpu_sriov_vf(adev) && adev->asic_type < CHIP_NAVI10) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
 						ih_rb_cntl)) {
 				DRM_ERROR("program IH_RB_CNTL_RING2 failed!\n");
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
