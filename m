Return-Path: <SRS0=8n1M=EW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3952BC5519F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 14:51:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C79204EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2020 14:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sEaoliaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C79204EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13FD889C08;
	Mon, 16 Nov 2020 14:51:45 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680086.outbound.protection.outlook.com [40.107.68.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A391A89C08
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2020 14:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEfMupmP8wfaBsloC5mqVlSKFoiKoEXfnqeAgExR9f+e+ZPcGSkLZHFwpCyWU+ysjl1wbM2+XWOBpIbHDQOtOCsNXSpih8HLD7fl6GhQYNyTb7DKDo8Uj4nnAK4oGpTBroTP43xuEIgBIMmsiMtzzerymNUZZUbxABoiQXycsWYh0l7Kde/AKsE5FH0T799AuHg7MAJCuIuQoUULLJRwiVXopo3Or2NZ61AZ8uiMMIXOGFP186qNu34xEM1BUKpF7OzLFZ898HGjcYSaBTT8c8BaMjmtjPFUMHYnTRyfpg1j0gKUjuv6S1XCjq3RMQW/6pQRdGW62ZIulHk64BPYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM6Zpydsg3E4CXxHreQV5gTgc6zfh7E53ZdaH8KDBTY=;
 b=gQiJMObiUMoDdYnlXn/q8Xmmy0JO5YEYUxlKydlY1C/4VGeB4RFN66yiHhmDhftNw/KbWd5lc1LL2oL8kVsoi7BDj3HldDCLir4cN0NBLJD4J76EH32vWZz6M8c+5u0LnnN/TH4x3JqgsuAXZQdBCQ79QgJ9VgYMZEWt+pffcyZoUBWtAJ9thSU9Xf+V0VzikXwa2bB15OiQZecdru1MuJDx3z7tGDA59tW9PVo9NTCQ/jtdeLaSP5QIv09SP8cLi/K88lwWCTFoaC+pia4PomYzodgbpOhlru+pnzpnsc0ewa3UcZFCltz2oDGAJzz8/7AQSwCK24ZztjyT8YdCvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM6Zpydsg3E4CXxHreQV5gTgc6zfh7E53ZdaH8KDBTY=;
 b=sEaoliaqQYUAPImaHuLd9g2cOacrd1kLowWJw2F7RAOrEeCimuG60n8jJE2EX7hCJaWdo7PjcetVHlES4i72X1Jj8nh3zru9rNoHkJckMJL3a4+tzgtsaHYcyclDe1A5UTAvZ3rOYV4ga0qUbImN0/qHUtCeF/3HQ/TQ7AWEHPo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28; Mon, 16 Nov 2020 14:51:39 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::214c:5fb0:3572:853d%8]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 14:51:39 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Kevin Wang <kevin1.wang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: make gfxhub_v1_0 callback functions to be static
Date: Mon, 16 Nov 2020 22:51:19 +0800
Message-Id: <20201116145119.13483-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR04CA0066.apcprd04.prod.outlook.com
 (2603:1096:202:14::34) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (58.247.170.242) by
 HK2PR04CA0066.apcprd04.prod.outlook.com (2603:1096:202:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25 via Frontend Transport; Mon, 16 Nov 2020 14:51:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 854c0729-b3e2-4144-cbc1-08d88a3f1fbc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4353CD357D9F523D6D47CF0DFCE30@DM6PR12MB4353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w/IazLyZ/sdK/WwHy8M4AwzJjjQ0K/frNYeZMuSMVROZpzm9zYKhAsFL5Vcjlc+TXZqXh3wZFHQo6HjB0DJ+LpVuUZwjkgJ2FoZnG0ZlpE70SGWvktRdSgFaf+unPMf8NooqnZ3AJsvubOlQ92QDDG6Cts4DK29hJ8PgPAXqmHq4Gnjcwg5MXmgLmEWQRlYgV5T0Ei5+Y6QHJ444sVfmShKx6VxszIaF879u1yvM71NVjpPJcvZsHjqGluTHMcNfmJbYI1qQiwIXD7oRUnV/iqGt1eZW7dgcXp3PfO6hkUxjVLoAUw4f04W00bIMFvXH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(26005)(7696005)(6636002)(316002)(956004)(52116002)(110136005)(2616005)(8936002)(478600001)(186003)(16526019)(66476007)(5660300002)(66556008)(6486002)(83380400001)(4326008)(66946007)(1076003)(36756003)(2906002)(86362001)(8676002)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: sQ5iO/ILcysg2w5vlw6VcgbJE7GbpWXsVkMkckqlJcdCPEwVQf2Li8gR1Rfqk+65nH+JZFrrJqdQ0FaeNv/Yj5qhv/UV/Gmx98ag4LJHQyXIMtvvN+gdH19fbHEDFEUNHkSH6WSzV+yyoTq4TgbQTZEOhiciZ+H2JeNtpkVnA7YymYwuNo8wgHQJ7r9JFsGsjUG5+ufRMp8z5IYe2/C0izHY+4Pp4lopDdGfPP6E9o2k36akNhxERCxGL7Q0xuxZu5kE92/TKAotIUDFjoKSE4SNANjCst6a4miTVcS1+pnVhg1HdKwoEcmJPXdDde9JJA0Saf8KxE0E/Mpx30ffIAEac81cXZ8dXgDu1LjVvbabhCeZeQlNKlTUHyKsayeOa2V/Onp6gt0znyp+bT+/IleJqjKQm1WDTmoQkHcALxVRJf0uRio8j+YCzeBytThSxI0UMY61fmgtikF3gaj6m24IplqAs5aZW2YNGlI+9nz6bPxeiCTxmj8Ls9hzj9sO3M+ABkMb8X1iPeOLIJz+zBLNTdf/erCAnx1igBImSvjnl8o32AZiSuNPYNvsGLe1O4S03lY5i4a9sQvnmBV03FWiWD01DGW3nF+DvJiNGmp8pKFMrn2RqOC7A+AoIrzB4PQXqWxrtNsAzPSoaILD5MxRgxFX084rShytO/l/KIX0VwdhZNtWSqhKti13vGeVVAK2T7QCp1ZmF7AZRPrDXc52stP9qqCaC48fidiNDG444pB57GjNVhSuLs4FQY5dUbDVf1a8wOo2ThXMBXG3qG7bWnydx1nspPCxu3lc4v4YCee0hX/1q3NZFD48pXmBm5iQwpFJCNJ9BFtoom9agyGW7w/M7O5OtvGUFfnSQd9qUURPx89Y925jHDhPDnvx47DJnBYFGkXkD8WittzHqA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 854c0729-b3e2-4144-cbc1-08d88a3f1fbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 14:51:39.6021 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLOBMZPdtbs0i1sGE21Z9pLVOhgP4oPB+ENg7f+kYP5ST4Xyq+UGHvKhvd30bOqpjWith1hkpFfDa0gCiKqZ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Those functions should be invoked through gfxhub.funcs
pointer.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 17 +++++++++--------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h | 10 +---------
 2 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index d83577b..6ddd53b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -31,13 +31,14 @@
 
 #include "soc15_common.h"
 
-u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev)
+static u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev)
 {
 	return (u64)RREG32_SOC15(GC, 0, mmMC_VM_FB_OFFSET) << 24;
 }
 
-void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base)
+static void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev,
+					 uint32_t vmid,
+					 uint64_t page_table_base)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 
@@ -275,7 +276,7 @@ static void gfxhub_v1_0_program_invalidation(struct amdgpu_device *adev)
 	}
 }
 
-int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
+static int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 {
 	if (amdgpu_sriov_vf(adev) && adev->asic_type != CHIP_ARCTURUS) {
 		/*
@@ -305,7 +306,7 @@ int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
-void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
+static void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 	u32 tmp;
@@ -336,8 +337,8 @@ void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev)
  * @adev: amdgpu_device pointer
  * @value: true redirects VM faults to the default page
  */
-void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
-					  bool value)
+static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
+						 bool value)
 {
 	u32 tmp;
 	tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL);
@@ -374,7 +375,7 @@ void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
-void gfxhub_v1_0_init(struct amdgpu_device *adev)
+static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB_0];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
index 0c46672..3174bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.h
@@ -24,14 +24,6 @@
 #ifndef __GFXHUB_V1_0_H__
 #define __GFXHUB_V1_0_H__
 
-int gfxhub_v1_0_gart_enable(struct amdgpu_device *adev);
-void gfxhub_v1_0_gart_disable(struct amdgpu_device *adev);
-void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
-					  bool value);
-void gfxhub_v1_0_init(struct amdgpu_device *adev);
-u64 gfxhub_v1_0_get_mc_fb_offset(struct amdgpu_device *adev);
-void gfxhub_v1_0_setup_vm_pt_regs(struct amdgpu_device *adev, uint32_t vmid,
-				uint64_t page_table_base);
-
 extern const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs;
+
 #endif
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
