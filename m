Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A77C33CB6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DE124673
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OCbUWGGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DE124673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE6866E447;
	Tue, 14 Jan 2020 17:58:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF956E446
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:58:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YLjjZ+fmrmWWuqvJ1Fp6gvQmw8V7GXkRtC3/KB5VmEXL5Zcdk+IkAeuV5Odj2dW4JSZuTToSghUpxTcdH1guRTlVKLL0/6gpZCilNuQK69h7DOdbi1Iw/wsX17VK/DG+BH1smWaBxwt/RqNYo6/nJsWPtUtxMB1g9M2XNR40WX1lMPq5sMPieJ0weN6Uu6/V82NAJxda3EYW7pIfsJidF/YGmqhpZ31MVz2XMPuVOTPtGuDxer4mVwutME7tElzoau7cL2X6TS93ZOZ4okJAaMbJqVWtDZ4m4vLgI3qMoBd8MivvVIf3ZZfNso4XCq4Kgp5OqJBBAOuH7uFk70jnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6WK/QZZh4ogwdxLheO4TN31tUROYnv2uaBg4Vc9veQ=;
 b=fL0r6Nz2oA+DPWJapDDFCB6H1gXaCKlQ+g5UKMjG+VMcSnEfTa2QcdyT1wVctxM9+m4t2lOl2YQlG/PObZlOXFrJi+/asu3yVOQUGfRW8eKJLZBGoPDFn3QVNw4wUUFKgW5/XJGHMOAye4yz9nngKuo0vbHkghSLACpSHX6TVTIsd6EbOP55cv9qjAiOdJoW656JMZN+f02M6qyKb8AUHq9Nv5a98gZRI7PSNcCUGrmnvwdXtUsHERPeumXoX+QyqWNkpDXOhXrom69AMz+bPzDwgrdLoys/x63Xx0YpEg2Y6G3KjpkcHHAEUYD49ZhxTTeLIv8woDjcqVP21/d7eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6WK/QZZh4ogwdxLheO4TN31tUROYnv2uaBg4Vc9veQ=;
 b=OCbUWGGb2mx0mihmzCI83poKgrGogvPm0MZh1cBGFxSwv7OP3X7I42Y5Tmex+PZhKpQVMAE2Sg2Y8rg97h5uB6FV87YLOTtWiNCjPug1bdPC0BMh4g8z0DPHguZ1O71eRgU0ou4gRlixMHf0K5qxODNFYc97su0F5RZTD+A+szk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3109.namprd12.prod.outlook.com (20.178.54.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 17:58:33 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 17:58:33 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/6] drm/amdgpu/vcn: support multiple-instance dpg sram mode
Date: Tue, 14 Jan 2020 12:58:21 -0500
Message-Id: <1579024702-27996-6-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 17:58:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dda2845d-1541-498b-1699-08d7991b5f28
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:|BYAPR12MB3109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB310972CDA56280A7B38D4A79E4340@BYAPR12MB3109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(6486002)(26005)(81166006)(186003)(956004)(2616005)(6666004)(6916009)(7696005)(52116002)(16526019)(66476007)(66946007)(66556008)(4326008)(8936002)(36756003)(2906002)(478600001)(5660300002)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3109;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xt/V7HiLw/R3ytAmQ6C9YaVeNk1EIAff89T9mOSyrhq53tEVyurONM4iffX60d14O9jXTs+NLXo//WC9qfu6i2hIWnV04dFImjUKRoj9F7QwrwkquNJHm0EciqhfSQJXvuoRXthT+PbzCgE/ntTKFAJ9qAjO8YNoSC1DPV10hcHXED+PQCgLlB4bgrEAQ4gRk8E2FZRaX225G6looOgNRoIfCdFMEC+JDvkzFPz6zj3jkxKi4LERWuoLFkFjTPuEWHjJGffRisIXbX+NrSBBnMaH+zEwK6F1q87e7QkbuPdon1WSkcOqVxwKZ4TaD0+eAqNYeZKyB0SO0V8gqIM64Nmfa20IKj3mdK+2O23IfqdkxLjEfslvv0mAacxX2HsoXGzspmhbcg/WIzOSzemWFyb0DZuHwwFYwSV/S9qgaw8HLi4k5dj5ieDR+NmZ7++o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda2845d-1541-498b-1699-08d7991b5f28
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 17:58:33.6963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKOaBk5b0KWg4Ll37R6VC1HCx8TN2oWyLQholefV470z1l4pvZoai5hoGW7Y4svv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3109
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add multiple-instance dpg sram mode support for vcn2.5

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 +++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  8 ++++----
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 99df693..ca62d99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -165,15 +165,15 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
 			return r;
 		}
-	}
 
-	if (adev->vcn.indirect_sram) {
-		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-			    AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.dpg_sram_bo,
-			    &adev->vcn.dpg_sram_gpu_addr, &adev->vcn.dpg_sram_cpu_addr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate DPG bo\n", r);
-			return r;
+		if (adev->vcn.indirect_sram) {
+			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].dpg_sram_bo,
+					&adev->vcn.inst[i].dpg_sram_gpu_addr, &adev->vcn.inst[i].dpg_sram_cpu_addr);
+			if (r) {
+				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
+				return r;
+			}
 		}
 	}
 
@@ -186,15 +186,14 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (adev->vcn.indirect_sram) {
-		amdgpu_bo_free_kernel(&adev->vcn.dpg_sram_bo,
-				      &adev->vcn.dpg_sram_gpu_addr,
-				      (void **)&adev->vcn.dpg_sram_cpu_addr);
-	}
-
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
+		if (adev->vcn.indirect_sram) {
+			amdgpu_bo_free_kernel(&adev->vcn.inst[i].dpg_sram_bo,
+						  &adev->vcn.inst[i].dpg_sram_gpu_addr,
+						  (void **)&adev->vcn.inst[i].dpg_sram_cpu_addr);
+		}
 		kvfree(adev->vcn.inst[j].saved_bo);
 
 		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index d3d75ec..34ff75c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -122,8 +122,8 @@
 				 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT | 			\
 				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT)); 		\
 		} else { 									\
-			*adev->vcn.dpg_sram_curr_addr++ = offset; 				\
-			*adev->vcn.dpg_sram_curr_addr++ = value; 				\
+			*adev->vcn.inst->dpg_sram_curr_addr++ = offset; 				\
+			*adev->vcn.inst->dpg_sram_curr_addr++ = value; 				\
 		} 										\
 	} while (0)
 
@@ -191,6 +191,10 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
 	struct amdgpu_irq_src	irq;
 	struct amdgpu_vcn_reg	external;
+	struct amdgpu_bo	*dpg_sram_bo;
+	void			*dpg_sram_cpu_addr;
+	uint64_t		dpg_sram_gpu_addr;
+	uint32_t		*dpg_sram_curr_addr;
 };
 
 struct amdgpu_vcn {
@@ -202,10 +206,6 @@ struct amdgpu_vcn {
 	struct dpg_pause_state pause_state;
 
 	bool			indirect_sram;
-	struct amdgpu_bo	*dpg_sram_bo;
-	void			*dpg_sram_cpu_addr;
-	uint64_t		dpg_sram_gpu_addr;
-	uint32_t		*dpg_sram_curr_addr;
 
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index dcdc7ad..553710f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -759,7 +759,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
 
 	if (indirect)
-		adev->vcn.dpg_sram_curr_addr = (uint32_t*)adev->vcn.dpg_sram_cpu_addr;
+		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst->dpg_sram_cpu_addr;
 
 	/* enable clock gating */
 	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
@@ -833,9 +833,9 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.dpg_sram_cpu_addr));
+		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
+				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
+					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
 
 	/* force RBC into idle state */
 	rb_bufsz = order_base_2(ring->ring_size);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
