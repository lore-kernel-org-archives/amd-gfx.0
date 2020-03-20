Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D1CC4332E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8AA720714
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 00:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="18RRIO60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AA720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DAF06EAB2;
	Fri, 20 Mar 2020 00:23:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37F616EAB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 00:23:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4CoZTF9u257hhV2r/pwUBPQKhh5zpota0Gf4GFpFmsw2umcfUZ7F5Ek2LWidDXWFOIhLXjPjqH3NRA4ZpkVvLpBFII0ywwMR4rt7nefHqMKWbK140YNxRlZFBVcX1xCR5C2vF+lB71ATtQqxUOQwiT20A4r/ZmbfmsqPxNJtl4iqEO5oO9GuXGkrDaCNrkifMojMjZecQy3adTJPjh+soxSvwuDssZMw36ldJ8pawgwEkVXy3KjyNX5TdWa35lJMgaVSbmM7wl4XxpxlCfweywPUF0odiBvnTCkZhoNMTVILua+WBBmA0I3Z9SwTP4HYqFik8hbhhI+1yE7vDUX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5BGNF/UvZt1SQQ3UoVv15SoX5v0Ai31kRb1W+ycs6Q=;
 b=E12F+LwHgQAtzWT/RI/n2wRRPJKJPPQTeumO5DWPmGlMZ9kxYlT03rNTinSACOFMOMu+mjInrz29Jma5sjOZM8H0oTAKmJ+vYs/qGU6QjyF3UR4/X8RDQ8Lx7Z1sEPT1ROhYr42hdZP8Xzwlgu11tl1kKHaY5JBDZj2x47a3UtHwRZJOZRgPb024Br/J9OLZ3Kx8VB6G3Ol4YinevTxoLJIl1jgQAWkJv0o+fTVXasq3Do1jLRxfK9RYXdqcNLXDLXiaIdZoaO0iBsvlIG1GdIwowekP30tLpvMT2EGiPlBY/Mh1BrPj9bZDDNvwaiJs0fPbJZCg3NRHx4ukLMipew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5BGNF/UvZt1SQQ3UoVv15SoX5v0Ai31kRb1W+ycs6Q=;
 b=18RRIO60l7NO6iROThKKBpXG6jYpECmRnOCpBfsR5YjhK8OxP6pNpsM+1xCjQF0fyqR9AuzTmiHPL8sG9l7tl3ogBcyYF8JFBPm2FJfIExgOlWyvIxSoAkxFJgKI2R/updwKfWtrW/qThHaZawby64rZhKU6sdRhc/nXXo0M06g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4365.namprd12.prod.outlook.com (2603:10b6:806:96::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18; Fri, 20 Mar
 2020 00:23:54 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Fri, 20 Mar 2020
 00:23:54 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu: replace rd/wr IH ring registers using
 mmIH_RING_REG macro
Date: Thu, 19 Mar 2020 19:22:44 -0500
Message-Id: <20200320002245.14932-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320002245.14932-1-alex.sierra@amd.com>
References: <20200320002245.14932-1-alex.sierra@amd.com>
X-ClientProxiedBy: DM3PR12CA0130.namprd12.prod.outlook.com
 (2603:10b6:0:51::26) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM3PR12CA0130.namprd12.prod.outlook.com (2603:10b6:0:51::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Fri, 20 Mar 2020 00:23:39 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fbc41af-982f-4037-09ce-08d7cc64f050
X-MS-TrafficTypeDiagnostic: SA0PR12MB4365:|SA0PR12MB4365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43653F852C49C807827D3CF2FDF50@SA0PR12MB4365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-Forefront-PRVS: 03484C0ABF
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(6916009)(30864003)(66556008)(86362001)(36756003)(6666004)(81156014)(7696005)(66476007)(6486002)(1076003)(478600001)(52116002)(44832011)(5660300002)(66946007)(8676002)(4326008)(956004)(8936002)(186003)(16526019)(2616005)(81166006)(316002)(26005)(2906002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4365;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xZYyB3/VPTeO8qIucdI0bXYvVcjek3Rt31Dvfbso7vK9yZxSlBzYiA/cLixzewIDjpdJYF3jxM0bkWTTqAYodO9MEoRNqMJ3pYTQFd2LGCh2KFltwT/jrzdZ+QxuTzNirdC6wE946fJ9HyO4fZv5uXskMt5qmkKEaHxWzznloOax06BODrMl8d6cNPb7ooolXjwDKQ5YZryiLCjjxJwQnX5uagWYBWLFggKYz3LiiCy9SuZ3KGRAU8vFCjae1R2vDop98h4oK9vu4ysz8lBmoCIV5VELkY4qNIFIvYULac5Pq4Phw9UiMe2FS+39OwPCkyhSjXAkVMPQkX7Cshl0PgW27x72E+Py7sxlh6alOokHolDQdxsutIdi8f/pUzIF/jr+JHjmRDCP0yiPP+eUYqRtj1pvU32Ap2YXVHpULsHTYcjlcRo2PtT2DSbjxoVhsAfSsQEQYTS/fEtG4meGPPJJbz8V0fafKErVGIIGoOAsvuo/Ux/yqt73l5kE2Vr
X-MS-Exchange-AntiSpam-MessageData: vm9SI8CzfQPTmWY0MuiM6ljnCxc2LYtr6v82jd/XxFOFO8IZMBfhqDlLq+N8SacaRwEWOsbFk/SUKB4dY5S92QADN8DUq8mplfQgnartJm2zg/xXbGDjdIY/SMmQ59tJFAFlpVqdFzlBMNgB2Gfqjw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbc41af-982f-4037-09ce-08d7cc64f050
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2020 00:23:39.9943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie1KhngB9lV96veNOVDS/MnGIqzYtZIscvSPqW6gxNzDe3euv3j1MPIxO6Jrh1EF/XjzdK0l3CqvyuiSp+MbZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4365
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

[Why]
Replace the way reads and writes are done to the IH ring registers at the vega10_ih.
This is due to different IH ring registers offset between Vega10 and Arcturus.

[How]
mmIH_RING_REG macro is used to calculate the register address first. Then RREG32 and WREG32 macros
are used to directly write/read into the register.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 121 +++++++++++++------------
 1 file changed, 61 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 5bd9bc37fadf..8d41b4c27205 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -51,7 +51,7 @@ static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
  */
 static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 {
-	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
+	u32 ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL, RING0));
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 1);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
@@ -61,12 +61,12 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 			return;
 		}
 	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+		WREG32(mmIH_RING_REG(RB_CNTL, RING0), ih_rb_cntl);
 	}
 	adev->irq.ih.enabled = true;
 
 	if (adev->irq.ih1.ring_size) {
-		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL_RING1, RING1));
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev)) {
@@ -76,13 +76,13 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 				return;
 			}
 		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+			WREG32(mmIH_RING_REG(RB_CNTL_RING1, RING1), ih_rb_cntl);
 		}
 		adev->irq.ih1.enabled = true;
 	}
 
 	if (adev->irq.ih2.ring_size) {
-		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL_RING2, RING2));
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 1);
 		if (amdgpu_sriov_vf(adev)) {
@@ -92,7 +92,7 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 				return;
 			}
 		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+			WREG32(mmIH_RING_REG(RB_CNTL_RING2, RING2), ih_rb_cntl);
 		}
 		adev->irq.ih2.enabled = true;
 	}
@@ -107,7 +107,7 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
  */
 static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
 {
-	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
+	u32 ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL, RING0));
 
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RB_ENABLE, 0);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 0);
@@ -117,17 +117,17 @@ static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
 			return;
 		}
 	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+		WREG32(mmIH_RING_REG(RB_CNTL, RING0), ih_rb_cntl);
 	}
 
 	/* set rptr, wptr to 0 */
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
+	WREG32(mmIH_RING_REG(RB_RPTR, RING0), 0);
+	WREG32(mmIH_RING_REG(RB_WPTR, RING0), 0);
 	adev->irq.ih.enabled = false;
 	adev->irq.ih.rptr = 0;
 
 	if (adev->irq.ih1.ring_size) {
-		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL_RING1, RING1));
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
 					   RB_ENABLE, 0);
 		if (amdgpu_sriov_vf(adev)) {
@@ -137,17 +137,17 @@ static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
 				return;
 			}
 		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+			WREG32(mmIH_RING_REG(RB_CNTL_RING1, RING1), ih_rb_cntl);
 		}
 		/* set rptr, wptr to 0 */
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
+		WREG32(mmIH_RING_REG(RB_RPTR_RING1, RING1), 0);
+		WREG32(mmIH_RING_REG(RB_WPTR_RING1, RING1), 0);
 		adev->irq.ih1.enabled = false;
 		adev->irq.ih1.rptr = 0;
 	}
 
 	if (adev->irq.ih2.ring_size) {
-		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL_RING2, RING2));
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
 					   RB_ENABLE, 0);
 		if (amdgpu_sriov_vf(adev)) {
@@ -157,12 +157,12 @@ static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
 				return;
 			}
 		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+			WREG32(mmIH_RING_REG(RB_CNTL_RING2, RING2), ih_rb_cntl);
 		}
 
 		/* set rptr, wptr to 0 */
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
+		WREG32(mmIH_RING_REG(RB_RPTR_RING2, RING2), 0);
+		WREG32(mmIH_RING_REG(RB_WPTR_RING2, RING2), 0);
 		adev->irq.ih2.enabled = false;
 		adev->irq.ih2.rptr = 0;
 	}
@@ -235,10 +235,10 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 
 	ih = &adev->irq.ih;
 	/* Ring Buffer base. [39:8] of 40-bit address of the beginning of the ring buffer*/
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE, ih->gpu_addr >> 8);
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) & 0xff);
+	WREG32(mmIH_RING_REG(RB_BASE, RING0), ih->gpu_addr >> 8);
+	WREG32(mmIH_RING_REG(RB_BASE_HI, RING0), (ih->gpu_addr >> 40) & 0xff);
 
-	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
+	ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL, RING0));
 	ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
@@ -248,7 +248,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 			return -ETIMEDOUT;
 		}
 	} else {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
+		WREG32(mmIH_RING_REG(RB_CNTL, RING0), ih_rb_cntl);
 	}
 
 	if ((adev->asic_type == CHIP_ARCTURUS &&
@@ -266,25 +266,25 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	}
 
 	/* set the writeback address whether it's enabled or not */
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_LO,
-		     lower_32_bits(ih->wptr_addr));
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_ADDR_HI,
-		     upper_32_bits(ih->wptr_addr) & 0xFFFF);
+	WREG32(mmIH_RING_REG(RB_WPTR_ADDR_LO, RING0),
+			lower_32_bits(ih->wptr_addr));
+	WREG32(mmIH_RING_REG(RB_WPTR_ADDR_HI, RING0),
+			upper_32_bits(ih->wptr_addr) & 0xFFFF);
 
 	/* set rptr, wptr to 0 */
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
-	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
+	WREG32(mmIH_RING_REG(RB_RPTR, RING0), 0);
+	WREG32(mmIH_RING_REG(RB_WPTR, RING0), 0);
 
-	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR,
-		     vega10_ih_doorbell_rptr(ih));
+	WREG32(mmIH_RING_REG(DOORBELL_RPTR, RING0),
+			vega10_ih_doorbell_rptr(ih));
 
 	ih = &adev->irq.ih1;
 	if (ih->ring_size) {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING1, ih->gpu_addr >> 8);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING1,
-			     (ih->gpu_addr >> 40) & 0xff);
+		WREG32(mmIH_RING_REG(RB_BASE_RING1, RING1), ih->gpu_addr >> 8);
+		WREG32(mmIH_RING_REG(RB_BASE_HI_RING1, RING1),
+				(ih->gpu_addr >> 40) & 0xff);
 
-		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL_RING1, RING1));
 		ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
 					   WPTR_OVERFLOW_ENABLE, 0);
@@ -297,24 +297,24 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 				return -ETIMEDOUT;
 			}
 		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+			WREG32(mmIH_RING_REG(RB_CNTL_RING1, RING1), ih_rb_cntl);
 		}
 
 		/* set rptr, wptr to 0 */
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
+		WREG32(mmIH_RING_REG(RB_RPTR_RING1, RING1), 0);
+		WREG32(mmIH_RING_REG(RB_WPTR_RING1, RING1), 0);
 
-		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING1,
-			     vega10_ih_doorbell_rptr(ih));
+		WREG32(mmIH_RING_REG(DOORBELL_RPTR_RING1, RING1),
+				vega10_ih_doorbell_rptr(ih));
 	}
 
 	ih = &adev->irq.ih2;
 	if (ih->ring_size) {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING2, ih->gpu_addr >> 8);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING2,
-			     (ih->gpu_addr >> 40) & 0xff);
+		WREG32(mmIH_RING_REG(RB_BASE_RING2, RING2), ih->gpu_addr >> 8);
+		WREG32(mmIH_RING_REG(RB_BASE_HI_RING2, RING2),
+				(ih->gpu_addr >> 40) & 0xff);
 
-		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = RREG32(mmIH_RING_REG(RB_CNTL_RING2, RING2));
 		ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
 
 		if (amdgpu_sriov_vf(adev)) {
@@ -324,15 +324,16 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 				return -ETIMEDOUT;
 			}
 		} else {
-			WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+			WREG32(mmIH_RING_REG(RB_CNTL_RING2, RING2), ih_rb_cntl);
 		}
 
 		/* set rptr, wptr to 0 */
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
+		WREG32(mmIH_RING_REG(RB_RPTR_RING2, RING2), 0);
+		WREG32(mmIH_RING_REG(RB_WPTR_RING2, RING2), 0);
+
+		WREG32(mmIH_RING_REG(DOORBELL_RPTR_RING2, RING2),
+				vega10_ih_doorbell_rptr(ih));
 
-		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING2,
-			     vega10_ih_doorbell_rptr(ih));
 	}
 
 	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
@@ -390,11 +391,11 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	/* Double check that the overflow wasn't already cleared. */
 
 	if (ih == &adev->irq.ih)
-		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);
+		reg = mmIH_RING_REG(RB_WPTR, RING0);
 	else if (ih == &adev->irq.ih1)
-		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING1);
+		reg = mmIH_RING_REG(RB_WPTR_RING1, RING1);
 	else if (ih == &adev->irq.ih2)
-		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING2);
+		reg = mmIH_RING_REG(RB_WPTR_RING2, RING2);
 	else
 		BUG();
 
@@ -415,11 +416,11 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	ih->rptr = tmp;
 
 	if (ih == &adev->irq.ih)
-		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);
+		reg = mmIH_RING_REG(RB_CNTL, RING0);
 	else if (ih == &adev->irq.ih1)
-		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		reg = mmIH_RING_REG(RB_CNTL_RING1, RING1);
 	else if (ih == &adev->irq.ih2)
-		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		reg = mmIH_RING_REG(RB_CNTL_RING2, RING2);
 	else
 		BUG();
 
@@ -488,11 +489,11 @@ static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
 	uint32_t i = 0;
 
 	if (ih == &adev->irq.ih)
-		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR);
+		reg_rptr = mmIH_RING_REG(RB_RPTR, RING0);
 	else if (ih == &adev->irq.ih1)
-		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING1);
+		reg_rptr = mmIH_RING_REG(RB_RPTR_RING1, RING1);
 	else if (ih == &adev->irq.ih2)
-		reg_rptr = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_RPTR_RING2);
+		reg_rptr = mmIH_RING_REG(RB_RPTR_RING2, RING2);
 	else
 		return;
 
@@ -524,11 +525,11 @@ static void vega10_ih_set_rptr(struct amdgpu_device *adev,
 		if (amdgpu_sriov_vf(adev))
 			vega10_ih_irq_rearm(adev, ih);
 	} else if (ih == &adev->irq.ih) {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
+		WREG32(mmIH_RING_REG(RB_RPTR, RING0), ih->rptr);
 	} else if (ih == &adev->irq.ih1) {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, ih->rptr);
+		WREG32(mmIH_RING_REG(RB_RPTR_RING1, RING1), ih->rptr);
 	} else if (ih == &adev->irq.ih2) {
-		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, ih->rptr);
+		WREG32(mmIH_RING_REG(RB_RPTR_RING2, RING2), ih->rptr);
 	}
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
