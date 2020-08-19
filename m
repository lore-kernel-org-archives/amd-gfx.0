Return-Path: <SRS0=7tPq=B5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE5AC433E1
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1732A2076E
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Aug 2020 14:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1732A2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD3D6E14B;
	Wed, 19 Aug 2020 14:28:46 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750075.outbound.protection.outlook.com [40.107.75.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E3E6E14B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Aug 2020 14:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmUbykzHR87/frGVDxjykX6uJT/FqBYXLCdmwvl0yTIB7XLVmzrXbbZt79ca7zpFz4mGSMqnwroVi/lN6JnWJRWZTuJ38jiXELazg1HqLxugs0stYCUlw+CbJMjAgtuHa13fgyg5JIRfenunMnEBYK8wHmpvzgTnXRfBEaKh+77vzMp7JRpiVuFX2XOEa5/OXc0waUanG83yC7u1YDZTcJuqfvumdEAey9FtHQ6KlTgAeKSOCSdroc3lZWbq8G+G3cGXO5mzGzuaTGF7Z/PQI5Zhk68QXvCMuvBe/G+NradRa7v90G6aLnbq4Ma6JRPCOlb8P4CXImY+mLLoQ6AaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrieoywIuWh99aFs3Mf2pSvXa2OffDJZmJL4+//wpbQ=;
 b=Y1f+N+G+8/bjvtfYDH9gcmbphjNnRBMMSbcvlMg9L/fFzab2S3hvv5OiGskKeKLWXBHQYpA057PP25cgDztpHd4gSFmYSorns0FM46ZkY+kMLOMo5Y69KMvU5zR+zIvQyUGDqaKQikzjL0ZXd35dFA8gRyiLzZ/I3C2kIAd0juU0429Q+uD1UEl5ayl18OJvEb/sLYr8QQzkgwks0uoySse0elWNN4koeElZI7gycuV/KbuGyI8jltK0PhjckuUNHvweZ1LLo7iHHVqfNkhqNf9jKAxkw5dT4Pg6cZhP7XGpKv0l31CKTXpCmWgKdyY4jKslsbs9WvnUc8vDC37LTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrieoywIuWh99aFs3Mf2pSvXa2OffDJZmJL4+//wpbQ=;
 b=Q+mm6lr2vAOXcFDjWt4RLbXLxVaIdRoNf9hBNY49ewmFCg+ongFCGX2t7pnFCTFHbpo9sLRt9upDIYCqq4dUccxpFqdZHaQg/3I4TtN7hWAv2z2lCm5eE6DvAxqXGtR/Fi1KoR7HqQAi7LPYgrigf8SvlBfch6l9QvWUqPaEO7g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3774.namprd12.prod.outlook.com (2603:10b6:208:16a::13)
 by BL0PR12MB2514.namprd12.prod.outlook.com (2603:10b6:207:43::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 14:28:38 +0000
Received: from MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285]) by MN2PR12MB3774.namprd12.prod.outlook.com
 ([fe80::9cd:9d82:d316:9285%4]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 14:28:38 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remap hdp coherency registers for vi on carrizo
Date: Wed, 19 Aug 2020 22:28:16 +0800
Message-Id: <20200819142816.215812-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-ClientProxiedBy: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To MN2PR12MB3774.namprd12.prod.outlook.com
 (2603:10b6:208:16a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.242) by
 HK2PR03CA0052.apcprd03.prod.outlook.com (2603:1096:202:17::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.10 via Frontend Transport; Wed, 19 Aug 2020 14:28:36 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b583aeda-875a-473b-62a9-08d8444c29a7
X-MS-TrafficTypeDiagnostic: BL0PR12MB2514:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB251469A4ED229C02C87F3589EC5D0@BL0PR12MB2514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NJYcolNoOzMdDe6f+tWVDFIrXV81yIahOXJyCrjXqYbLBG3j1N9/jdeVyr3yjteRhECtgU94uTXfAw3BwOt+imsaTG6l9W9g3K+uzIjoZDEtgCd6TVuR0uK3atzUW9qZZv+fMBHsZiYyjo2QZSxVA+D16eVAtONzZ+BAt7W5/OsdmietLAO+rVVre5VhheZdTGjfmkdfDRFZwnkPpNrVJ0LLlBUdfgU7dLV4zSI8uobwLELiNtiH6hr9gan2JGI1F5yTXtgpOwrWQyHo89e4IC9DxUBxTaLm5q28v7SjD8op3sTna3FEwM2kSJfrkSwv0ZzKzyqQDR6Z2eIUv7qukg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3774.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(5660300002)(4326008)(86362001)(6666004)(6486002)(8936002)(956004)(2906002)(66556008)(26005)(66476007)(66946007)(2616005)(7696005)(52116002)(83380400001)(186003)(8676002)(316002)(36756003)(16526019)(6916009)(478600001)(1076003)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: JQVs5CU4UnrgHhXTnhzuHhn/oXCrBfroI/rwN1u0m5AIydaEOV13hKJqpbnEkDi0jd7LRA0ySkconWuVUCyOHM0g1LpSvL04LEgTrghp3c11Sm/mJIQJ1xvhZpncVCuZaRO+vhKbM1N0dFllKzSEvEkXobwjTngDUNHHcuHII09kTcotpWPrsj22wnctBdNOXaWMouRFa6JSFeAZpk+1/u0faW10oDZSfLdIHTFmXexeLUdLrnPneUqC69fQWSnnDBDKQoRyvSen4YmSjg9qXdWZbdbCAghYs7eMiEzfHi19bIB5LCiWlNsixdkpnSUQZw0NtrZxpgPjU/7WPhjW643x6btL6Wde3LsAVZ3e7a/W7FqhJJZnrcRCQA4P+mqvHxDRBuW5d1DQWzDG/I8Wnu4LksLJ5OZ2iyniF4ZW7oTdCzvIS2KA2VIouFA4QMIYBvVLyDbyR8a16jO3KtFgF4jGyENILdj75Ya6FlFRvv59FkPM/EsYKV1+W9/Zd3ZW7bmNxk6iv2uRfUK5Yc25Ka31iLYEYs5TCDsIKMDx/Y8LObB+qy0uxyE5jdUPb6WXCbzaKr0XDL9nMFJW2Zh2lAXahdau+C09J8/vct0YUpltzyc0HR0G/dBD3q6QBRyHvPs1MCC/7fv9XkSzSs6Dvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b583aeda-875a-473b-62a9-08d8444c29a7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3774.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 14:28:38.3152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EE0XruH5hrq57B/V6SBrV0sL8U1dEsnK9kEfAN7KS5oRzwbhFBCt2J3cNy3eNoWWTGzcdrZt5GFEYR8cv2ulSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2514
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
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Carrzio also needs remap HDP_MEM_COHERENCY_FLUSH_CNTL and
HDP_REG_COHERENCY_FLUSH_CNTL to the empty page in mmio space. Then user
mode is able to do flush hdp as well. It will used for force dgpu path
on carrizo.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index af8986a55354..a540fe7cffc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -78,6 +78,7 @@
 #include "dce_virtual.h"
 #include "mxgpu_vi.h"
 #include "amdgpu_dm.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 /*
  * Indirect registers accessor
@@ -944,10 +945,10 @@ static uint32_t vi_get_rev_id(struct amdgpu_device *adev)
 static void vi_flush_hdp(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 {
 	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
-		RREG32(mmHDP_MEM_COHERENCY_FLUSH_CNTL);
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 1);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
 	} else {
-		amdgpu_ring_emit_wreg(ring, mmHDP_MEM_COHERENCY_FLUSH_CNTL, 1);
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 1);
 	}
 }
 
@@ -1085,8 +1086,11 @@ static const struct amdgpu_asic_funcs vi_asic_funcs =
 
 static int vi_common_early_init(void *handle)
 {
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+	adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
 	if (adev->flags & AMD_IS_APU) {
 		adev->smc_rreg = &cz_smc_rreg;
 		adev->smc_wreg = &cz_smc_wreg;
@@ -1332,6 +1336,12 @@ static int vi_common_sw_fini(void *handle)
 	return 0;
 }
 
+static void vi_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32(mmREMAP_HDP_MEM_FLUSH_CNTL, adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32(mmREMAP_HDP_REG_FLUSH_CNTL, adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
 static int vi_common_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -1342,6 +1352,8 @@ static int vi_common_hw_init(void *handle)
 	vi_pcie_gen3_enable(adev);
 	/* enable aspm */
 	vi_program_aspm(adev);
+	/* remap hdp registers */
+	vi_remap_hdp_registers(adev);
 	/* enable the doorbell aperture */
 	vi_enable_doorbell_aperture(adev, true);
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
