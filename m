Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70C7C433E2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7492145D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 09:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RHEbymJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7492145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5276E0A8;
	Tue, 14 Jul 2020 09:10:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9606E0A8
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 09:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhAReDywRhGR66z4sFuoE/vETI2y46bRfncJ33ao1ZvGSpNZtaBo8Hk6UycsuZJv0vQ0MuGPK2VfQz+nrDVrsRtQ8joFONrDRT7SU1X6ptputbkUeqdWYmebfRgjujJoqjZh3WXXke8Ma23YGpARu7W8yaw+BJOt6Wh37vmvI/X7HyRftpchUAvmnoyJHCLVhtwBU6nLDuahJAGLntBQiRtLfnvIk/WBLsFNz+IiKsETgFhXZP9L6TJIEb8r6K8LaYI87a7jErmx/IvgIsd2X0EmC0Gnwc46VlzFktkIPho5Cdnia8wpPD4WwOn9PAJV40yE+pdvRYcyt9DvEdL/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4efK7yo2NhwUMRt8MypcSHluc50qlVxSPwSx1Gs5yo=;
 b=mj/4T0u+0NvebvF2fBx/NC0jK6y+gc7XQ0JTeS75maVwgCoiSHnHZR7x8uiMrHWmrc2m+EKcqJOUoe9PqWX+wW/BLOQTXRZ+2WBlQHuH1iWs1CSq+AlcyZrMqducObZ7dxAT9p+/4GVuwP4Up3EE0VpRxhtl9iWj5PXBr/Hvd6nJ0xEg6Xvhv4uvmk9n96QOhKc92uiH0Bk/dUr8576dWpxBzSamhpdP0qxHbL26jMTHbd4DpglxYhs26I4wvasO6uC7PdLvpV3w3/o12IoQ6CBERnhiLho7SD26Bz2JiUtRg24dY0B3U6QRpGlb1i0lNX9WuR7kjIMzH30MkH7B0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4efK7yo2NhwUMRt8MypcSHluc50qlVxSPwSx1Gs5yo=;
 b=RHEbymJBjPvd9fOpSnAqwSP7KzNXqvmsz2MJaZ5v5GEYFxGGTdyRPBvl9HrKo53Tpnx3G66EwolTfaFZ2054GuG07Bt4ekekKx4XfOKI3fE7HtVAWQnOxEqMoFA0jzW0v4CY9ztTEadiXBPlY1tC7xR1U29las5mVtN0556I19k=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21)
 by MWHPR12MB1661.namprd12.prod.outlook.com (2603:10b6:301:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.25; Tue, 14 Jul
 2020 09:10:29 +0000
Received: from MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4]) by MW2PR12MB2586.namprd12.prod.outlook.com
 ([fe80::693d:7e71:3a0d:b6d4%7]) with mapi id 15.20.3174.025; Tue, 14 Jul 2020
 09:10:28 +0000
From: Xiaojie Yuan <xiaojie.yuan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu/sdma5: fix wptr overwritten in ->get_wptr()
Date: Tue, 14 Jul 2020 17:09:59 +0800
Message-Id: <20200714090959.21777-1-xiaojie.yuan@amd.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To MW2PR12MB2586.namprd12.prod.outlook.com
 (2603:10b6:907:11::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from c0.amd.com (58.247.170.242) by
 HK2PR02CA0127.apcprd02.prod.outlook.com (2603:1096:202:16::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 09:10:27 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 16db57eb-59aa-46bc-4345-08d827d5c08f
X-MS-TrafficTypeDiagnostic: MWHPR12MB1661:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB16615231E01D2C0AC7BF434089610@MWHPR12MB1661.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/DmU4QrjYuG0uRI0oBC1p771faWlzvGs+y3E8C8bRKxHb0hK+NuBUSSsPZKXl/B7kBIyqgXuSKxQg4Z7H6uDSG4ms5FrTd8HRA7z+H7EBu0mqIOryHznWUJiYxpVj2wZie9O+9duVCZ3YTX0CxWKZxJCsCnUK6PHhXp/zBoF090nEWKNo5Hmh6LMYNwijkHgQJ2Ssj2gkk34GFI8K90r+QLHT+wof2IFPPskPxjuiu9JWSa1ToxSD0Lk72ZMjbAt35AoGW4BCiaO20P2tER639K6lwZj0oChYRPHMWdU/PbXkfIBw467nAqpr9WKBF9t8b92x7OM3ykzwv/RNNHZ8Etkhx8GRdwMXtXO/FW3DwJxXA2WoYlv3NKHusp+P4Z
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2586.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(52116002)(86362001)(6666004)(1076003)(26005)(4326008)(956004)(2616005)(54906003)(36756003)(83380400001)(186003)(16526019)(316002)(6486002)(2906002)(7696005)(44832011)(8936002)(478600001)(8676002)(6916009)(66556008)(66946007)(5660300002)(66476007)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: PlK3Zva87vXFX036wgC51tzPdTJoPdTQBeiak7DVojZ65JSNrE1w7HKIXDIWf7CcbU7n4otXVaBkut71UkODby+ATvD4u7xZi1DL0/GC3P4kjCCip12HWge0WdQTqROFZogcgLAQl+RrLi1o1ojwj+isfqS7Me2W0MGH3pLwAMgH/8oEYo8s2fndSW8ddbphRChBOefutHJ86yShmaXBYJ0FYQ8ukQJkFj3y4we6AJHUWdD5iJFYp9/+6ptEh97to5IPoHORlsoP4wxphwAHsp9q0nTq0MxFbf/sPTAI1pdgDQZkFccN3k+V/VcodX6+Vje5iB92FVgSsNhYZiwie/2vPSGSPBPpKQcFD5KIhLmOju2t5PWRJWPTBQdHJS6AnPGkelx62csVJrjp8AAsNwryclgiL5+H9VvsX8Uugy8S+z4d7cSB7BTqkvuDBnpSCRp9/BnPnCu5O1pLRANRDhaktQzEzpS+dg+uGDKn+08=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16db57eb-59aa-46bc-4345-08d827d5c08f
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB2586.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 09:10:28.7905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HoYiO64xF8C7bILGFydQMq3m9UJWn/3rmQaSxb3uXeeG9j5m7KendfsjSI/Eu/br
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1661
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
Cc: Le Ma <le.ma@amd.com>, likun.gao@amd.com,
 Xiaojie Yuan <xiaojie.yuan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

"u64 *wptr" points to the the wptr value in write back buffer and
"*wptr = (*wptr) >> 2;" results in the value being overwritten each time
when ->get_wptr() is called.

umr uses /sys/kernel/debug/dri/0/amdgpu_ring_sdma0 to get rptr/wptr and
decode ring content and it is affected by this issue.

fix and simplify the logic similar as sdma_v4_0_ring_get_wptr().

v2: fix for sdma5.2 as well

Suggested-by: Le Ma <le.ma@amd.com>
Signed-off-by: Xiaojie Yuan <xiaojie.yuan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 26 ++++++++------------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 26 ++++++++------------------
 2 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index abb0ab653b10..e2232dd12d8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -315,30 +315,20 @@ static uint64_t sdma_v5_0_ring_get_rptr(struct amdgpu_ring *ring)
 static uint64_t sdma_v5_0_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u64 *wptr = NULL;
-	uint64_t local_wptr = 0;
+	u64 wptr;
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = ((u64 *)&adev->wb.wb[ring->wptr_offs]);
-		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", *wptr);
-		*wptr = (*wptr) >> 2;
-		DRM_DEBUG("wptr/doorbell after shift == 0x%016llx\n", *wptr);
+		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
-		u32 lowbit, highbit;
-
-		wptr = &local_wptr;
-		lowbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR)) >> 2;
-		highbit = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI)) >> 2;
-
-		DRM_DEBUG("wptr [%i]high== 0x%08x low==0x%08x\n",
-				ring->me, highbit, lowbit);
-		*wptr = highbit;
-		*wptr = (*wptr) << 32;
-		*wptr |= lowbit;
+		wptr = RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
+		wptr = wptr << 32;
+		wptr |= RREG32(sdma_v5_0_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
+		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", ring->me, wptr);
 	}
 
-	return *wptr;
+	return wptr >> 2;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 1ef14b610a4f..824f3e23c3d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -262,30 +262,20 @@ static uint64_t sdma_v5_2_ring_get_rptr(struct amdgpu_ring *ring)
 static uint64_t sdma_v5_2_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u64 *wptr = NULL;
-	uint64_t local_wptr = 0;
+	u64 wptr;
 
 	if (ring->use_doorbell) {
 		/* XXX check if swapping is necessary on BE */
-		wptr = ((u64 *)&adev->wb.wb[ring->wptr_offs]);
-		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", *wptr);
-		*wptr = (*wptr) >> 2;
-		DRM_DEBUG("wptr/doorbell after shift == 0x%016llx\n", *wptr);
+		wptr = READ_ONCE(*((u64 *)&adev->wb.wb[ring->wptr_offs]));
+		DRM_DEBUG("wptr/doorbell before shift == 0x%016llx\n", wptr);
 	} else {
-		u32 lowbit, highbit;
-
-		wptr = &local_wptr;
-		lowbit = RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR)) >> 2;
-		highbit = RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI)) >> 2;
-
-		DRM_DEBUG("wptr [%i]high== 0x%08x low==0x%08x\n",
-				ring->me, highbit, lowbit);
-		*wptr = highbit;
-		*wptr = (*wptr) << 32;
-		*wptr |= lowbit;
+		wptr = RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI));
+		wptr = wptr << 32;
+		wptr |= RREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR));
+		DRM_DEBUG("wptr before shift [%i] wptr == 0x%016llx\n", ring->me, wptr);
 	}
 
-	return *wptr;
+	return wptr >> 2;
 }
 
 /**
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
