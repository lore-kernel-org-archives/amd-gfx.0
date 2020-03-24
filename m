Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC11AC54EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA952077D
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 21:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="a9CHyTyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA952077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3ED6E0CC;
	Tue, 24 Mar 2020 21:58:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 086BB6E0CC
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 21:58:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXDm0JvjW+LXVHbk/r2IJ0JYloz36YFtZMIIbuq6l7L41f5KZVWpqVQ1dUiH0MshqkrP3CjClgGji4cVNy44v5l2N7iM6QoXxYariUWnP5ORvKOaJ/xjz31Z4vwO4yBdSaezUJL2dTQ9rdv4efEbP+jduX79lKffg8t2oFdGb69GVUzbi9P6aNLjAURxPuIST2X4z/DRg6vZApqAeUVLkMbAiOL1MRxKhXUslJs8GbI8+KZKxkZ53L190N0n3GRO24AcCv/rubRMwVJv7sP3QtJpEKpmuXcadkbCYP7r1hZsJOEvZw7NBVHpFIVOEXe95YjifePdsfvXEyLAf91hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rAOWl0abRSqYOPnWnAijwVhlJJ6HwO31KgZJqNO05c=;
 b=SBMpSeXGGAXOOr1FAVTMgpeq40aiZfTAAWz/BCxpdvghlmX05oAOupY8cBX1Xnv7XiP4lDJxvdEi/HXqSJtNJg0IBckJjP1M8yMovJbd710c5FKMnX+MK16mIDFzcC2H8Hl5aRZfFpSvrdNJV7KF/wffTBBT1nqQRWBTgqgyqArDE+cU36uBNpB0gjIAPBPgzn472zFMWEJN4xn3xN5Ouo3qT68upzPwWmagEi1L61l+PCdmGXapHEx4nIdO/WIikLPD6T5nx3OH5cexEI9AweIB1S9UxxDA7fgh4wfl/OXPY3pZbDdVQ3DwBJLTQE1Z4m0NwolO/bj3Zln/hzeUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rAOWl0abRSqYOPnWnAijwVhlJJ6HwO31KgZJqNO05c=;
 b=a9CHyTytI0BeOB4W7+iCuQZteZj/52iGopj2W5Pfy+BZ0FTSfrb5TadA5oN/aBjbBRwZcuFS1oDd3Tt/0U4vAzxpmWuHIHcDhPVRu/C2BkBH8JHWboNH80w8KApEEVM8MzOAzjgK6a55uCWd8fVfsiWtPzw2oVVd3Y1puT3i9Cw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4383.namprd12.prod.outlook.com (2603:10b6:806:94::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.20; Tue, 24 Mar
 2020 21:58:04 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 21:58:04 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: enable IH ring 1 and ring 2 for navi
Date: Tue, 24 Mar 2020 16:57:46 -0500
Message-Id: <20200324215749.29169-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: DM5PR1401CA0011.namprd14.prod.outlook.com
 (2603:10b6:4:4a::21) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 DM5PR1401CA0011.namprd14.prod.outlook.com (2603:10b6:4:4a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 21:58:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fd723a0d-b894-48bd-60dc-08d7d03e6dd5
X-MS-TrafficTypeDiagnostic: SA0PR12MB4383:|SA0PR12MB4383:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB438360035080A5036E6AC320FDF10@SA0PR12MB4383.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(8676002)(16526019)(52116002)(186003)(81156014)(86362001)(66556008)(26005)(7696005)(316002)(8936002)(66476007)(81166006)(66946007)(44832011)(6486002)(478600001)(2906002)(956004)(36756003)(6916009)(5660300002)(4326008)(2616005)(6666004)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4383;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p8R5s8iLe1GudF5xqCNyHCjEsVYa5KOgdHeP7aCWcW9VE/ivgriZLnr80zbIGy8xrDctxiHC+oBSXD3JErJC1NQA+O7xn0kbWp4jUWHAvPl5CsqlRfPFapJxNlDUss+LfzBN2ec9Vkmq5GMIXexKXvcq6cy8m+aIC62iXLmVAOxKg/ReGc6Htfm8IWba1MCJl2K/YUKx2yNnCeACqyt/5PF4gUulHZWRqjfpfzUB9czPZJL6PsT8HM04BJOOCj8P4A7k5k1PjqmElDO2qRVJ6O1muBa2WN1x3dhYF3++FgFAtVM2i1bwK+PVdTOR1dlolh5mSlVfBVyRR1XJ3CP71JU6njhdL6DHKs6q/G1UgIxHXyFchC0RlKFxCqgOWAkT0SiHBI3npKAPd+5+22ZeDcL8fJ524dKXRJ/r5dxs2tUU7zE2M+bFGjfFdMQ3iMZn
X-MS-Exchange-AntiSpam-MessageData: At4TMHvpjSKQBFvPu22EMjC6NtD8obqVeF+7pjKuwsO4lsmNwcHtKtvKtXosU+PqBH/HWg63S/sDUvr9Oe2eGc/mgA5NHl5GZ4O0gglm0pXA1qmyMybd/H3ugWsWtZvepTBl3SzucYrtgJGL/6Ln7w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd723a0d-b894-48bd-60dc-08d7d03e6dd5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 21:58:04.7784 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cTXf5JRQrblivhifZ2F+2IxorRbPt3kcyChU+IOxjTUga5aQP0NmwMDZQyrbgfGeM6Bc+rv59zRMSQtcpkNNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4383
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

Support added into IH to enable ring1 and ring2 for navi10_ih.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 205 +++++++++++++++++++++++--
 1 file changed, 189 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index e08245a446fc..0c0ba572d7a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -51,6 +51,22 @@ static void navi10_ih_enable_interrupts(struct amdgpu_device *adev)
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, ENABLE_INTR, 1);
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL, ih_rb_cntl);
 	adev->irq.ih.enabled = true;
+
+	if (adev->irq.ih1.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_ENABLE, 1);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		adev->irq.ih1.enabled = true;
+	}
+
+	if (adev->irq.ih2.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_ENABLE, 1);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		adev->irq.ih2.enabled = true;
+	}
 }
 
 /**
@@ -72,6 +88,31 @@ static void navi10_ih_disable_interrupts(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
 	adev->irq.ih.enabled = false;
 	adev->irq.ih.rptr = 0;
+
+	if (adev->irq.ih1.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING1,
+					   RB_ENABLE, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
+		adev->irq.ih1.enabled = false;
+		adev->irq.ih1.rptr = 0;
+	}
+
+	if (adev->irq.ih2.ring_size) {
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL_RING2,
+					   RB_ENABLE, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
+		adev->irq.ih2.enabled = false;
+		adev->irq.ih2.rptr = 0;
+	}
+
 }
 
 static uint32_t navi10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl)
@@ -97,6 +138,25 @@ static uint32_t navi10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl
 	return ih_rb_cntl;
 }
 
+static uint32_t navi10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
+{
+	u32 ih_doorbell_rtpr = 0;
+
+	if (ih->use_doorbell) {
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR, OFFSET,
+						 ih->doorbell_index);
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR,
+						 ENABLE, 1);
+	} else {
+		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
+						 IH_DOORBELL_RPTR,
+						 ENABLE, 0);
+	}
+	return ih_doorbell_rtpr;
+}
+
 /**
  * navi10_ih_irq_init - init and enable the interrupt ring
  *
@@ -111,7 +171,7 @@ static uint32_t navi10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl
 static int navi10_ih_irq_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ih_ring *ih = &adev->irq.ih;
-	u32 ih_rb_cntl, ih_doorbell_rtpr, ih_chicken;
+	u32 ih_rb_cntl, ih_chicken;
 	u32 tmp;
 
 	/* disable irqs */
@@ -149,22 +209,52 @@ static int navi10_ih_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR, 0);
 
-	ih_doorbell_rtpr = RREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR);
-	if (ih->use_doorbell) {
-		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
-						 IH_DOORBELL_RPTR, OFFSET,
-						 ih->doorbell_index);
-		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
-						 IH_DOORBELL_RPTR, ENABLE, 1);
-	} else {
-		ih_doorbell_rtpr = REG_SET_FIELD(ih_doorbell_rtpr,
-						 IH_DOORBELL_RPTR, ENABLE, 0);
-	}
-	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR, ih_doorbell_rtpr);
+	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR,
+			navi10_ih_doorbell_rptr(ih));
 
 	adev->nbio.funcs->ih_doorbell_range(adev, ih->use_doorbell,
 					    ih->doorbell_index);
 
+	ih = &adev->irq.ih1;
+	if (ih->ring_size) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING1, ih->gpu_addr >> 8);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING1,
+			     (ih->gpu_addr >> 40) & 0xff);
+
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+					   WPTR_OVERFLOW_ENABLE, 0);
+		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
+					   RB_FULL_DRAIN_ENABLE, 1);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1, ih_rb_cntl);
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING1, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
+
+		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING1,
+				navi10_ih_doorbell_rptr(ih));
+	}
+
+	ih = &adev->irq.ih2;
+	if (ih->ring_size) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_RING2, ih->gpu_addr >> 8);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI_RING2,
+			     (ih->gpu_addr >> 40) & 0xff);
+
+		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+		ih_rb_cntl = navi10_ih_rb_cntl(ih, ih_rb_cntl);
+
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2, ih_rb_cntl);
+		/* set rptr, wptr to 0 */
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_WPTR_RING2, 0);
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
+
+		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING2,
+			     navi10_ih_doorbell_rptr(ih));
+	}
+
+
 	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
 	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
 			    CLIENT18_IS_STORM_CLIENT, 1);
@@ -217,7 +307,15 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
 
-	reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);
+	if (ih == &adev->irq.ih)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);
+	else if (ih == &adev->irq.ih1)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING2);
+	else
+		BUG();
+
 	wptr = RREG32_NO_KIQ(reg);
 	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
 		goto out;
@@ -233,7 +331,15 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 		 wptr, ih->rptr, tmp);
 	ih->rptr = tmp;
 
-	reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);
+	if (ih == &adev->irq.ih)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);
+	else if (ih == &adev->irq.ih1)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+	else if (ih == &adev->irq.ih2)
+		reg = SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+	else
+		BUG();
+
 	tmp = RREG32_NO_KIQ(reg);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(reg, tmp);
@@ -333,8 +439,52 @@ static void navi10_ih_set_rptr(struct amdgpu_device *adev,
 
 		if (amdgpu_sriov_vf(adev))
 			navi10_ih_irq_rearm(adev, ih);
-	} else
+	} else if (ih == &adev->irq.ih) {
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
+	} else if (ih == &adev->irq.ih1) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, ih->rptr);
+	} else if (ih == &adev->irq.ih2) {
+		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, ih->rptr);
+	}
+}
+
+/**
+ * navi10_ih_self_irq - dispatch work for ring 1 and 2
+ *
+ * @adev: amdgpu_device pointer
+ * @source: irq source
+ * @entry: IV with WPTR update
+ *
+ * Update the WPTR from the IV and schedule work to handle the entries.
+ */
+static int navi10_ih_self_irq(struct amdgpu_device *adev,
+			      struct amdgpu_irq_src *source,
+			      struct amdgpu_iv_entry *entry)
+{
+	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
+
+	switch (entry->ring_id) {
+	case 1:
+		*adev->irq.ih1.wptr_cpu = wptr;
+		schedule_work(&adev->irq.ih1_work);
+		break;
+	case 2:
+		*adev->irq.ih2.wptr_cpu = wptr;
+		schedule_work(&adev->irq.ih2_work);
+		break;
+	default: break;
+	}
+	return 0;
+}
+
+static const struct amdgpu_irq_src_funcs navi10_ih_self_irq_funcs = {
+	.process = navi10_ih_self_irq,
+};
+
+static void navi10_ih_set_self_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->irq.self_irq.num_types = 0;
+	adev->irq.self_irq.funcs = &navi10_ih_self_irq_funcs;
 }
 
 static int navi10_ih_early_init(void *handle)
@@ -342,6 +492,7 @@ static int navi10_ih_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	navi10_ih_set_interrupt_funcs(adev);
+	navi10_ih_set_self_irq_funcs(adev);
 	return 0;
 }
 
@@ -351,6 +502,12 @@ static int navi10_ih_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	bool use_bus_addr;
 
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_IH, 0,
+				&adev->irq.self_irq);
+
+	if (r)
+		return r;
+
 	/* use gpu virtual address for ih ring
 	 * until ih_checken is programmed to allow
 	 * use bus address for ih ring by psp bl */
@@ -363,6 +520,20 @@ static int navi10_ih_sw_init(void *handle)
 	adev->irq.ih.use_doorbell = true;
 	adev->irq.ih.doorbell_index = adev->doorbell_index.ih << 1;
 
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih1, PAGE_SIZE, true);
+	if (r)
+		return r;
+
+	adev->irq.ih1.use_doorbell = true;
+	adev->irq.ih1.doorbell_index = (adev->doorbell_index.ih + 1) << 1;
+
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih2, PAGE_SIZE, true);
+	if (r)
+		return r;
+
+	adev->irq.ih2.use_doorbell = true;
+	adev->irq.ih2.doorbell_index = (adev->doorbell_index.ih + 2) << 1;
+
 	r = amdgpu_irq_init(adev);
 
 	return r;
@@ -373,6 +544,8 @@ static int navi10_ih_sw_fini(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	amdgpu_irq_fini(adev);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih2);
+	amdgpu_ih_ring_fini(adev, &adev->irq.ih1);
 	amdgpu_ih_ring_fini(adev, &adev->irq.ih);
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
