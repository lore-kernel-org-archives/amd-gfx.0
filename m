Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E19CC2D0CE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 23:45:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355B6206D4
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 23:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="LoKYIDF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355B6206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE436E053;
	Fri, 24 Jan 2020 23:45:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771906E053
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 23:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhEi9lbx6IdGcv3p5UVHliRp0+td/93QVVBsKrSSMpyWT/5j37k4lcec6xgJ/BOZ6mPVrI/JF/zcC4M7+ALnGHpT5trR85f3AUU+gGSA6o1yLz//hWqly8NcK38I3dUoAff/jC3wR+T0snF79ha+6e5sOKdTXYena2yvw+hFXr3HXlWyTIWb7lOrhSQOUVLEIi+N/Ed6QDt5Ty/Q7AH87R/AA/4pZwRHGRzvLalVMgNeK2WknSCAgx2VUMMmoiUVXrQaUCMkXOgIS9FSGwxK8nFlXldYoKix319oWxNomPtfwLBxXvtoqRXCy3lbX10giqsdZ/EdPApZN1wDeXhO9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ17X4xaF/g87dN+pDLE/2jkXu1KvkwFHRAG4Y50iHM=;
 b=LaTLb2g4UrKKCBAtHtWpkyk5qli52twBe3J+fISCwyFmkf3BzYDKELjOnooB4e76K8MU6s7KBbpZay0Vq/zywdhCwpn/53SQqunlRL0K8wchDpBL9MWbykqvNVem8ezodpeJdwh/UuIVAyaFhtn4lsihfnDn+xSbv0ohp//gPM51/br+WHfQ+2r2jjOxril5YGbYtsMlu6BhCf0a4lPClVDHF+/at7qUIOWt9XPrKGqo4WSLNA2RxHrI6NmLmg/WOAGDpaJ8t+VLGECB0BZaMR7/tcoUQdIljTfzdL9mqlNw0QSfgupCB/xItid3XazoIUUohU4g7DtEjT/INAoD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ17X4xaF/g87dN+pDLE/2jkXu1KvkwFHRAG4Y50iHM=;
 b=LoKYIDF43lTfA8kv5ZnC2h+UPGJ20D5wV4lV0DhwP0Mjt9Mjpqjp/VQYWTsvq9HsXHfl/6gmsn5v0Kj+3HZqtpHVLqH/Ndtj/WYWaPdMi30QLhODKlR/kTz2BEdswyiKQ/8nPAcUVNu9il/xqczZpzezXrVU5ctrNB1rzJD7W3o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151) by
 DM5PR1201MB2520.namprd12.prod.outlook.com (10.172.90.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 24 Jan 2020 23:45:24 +0000
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721]) by DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 23:45:23 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: Enable DISABLE_BARRIER_WAITCNT for Arcturus
Date: Fri, 24 Jan 2020 17:45:12 -0600
Message-Id: <20200124234512.217961-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200124233756.217565-1-Joseph.Greathouse@amd.com>
References: <20200124233756.217565-1-Joseph.Greathouse@amd.com>
X-ClientProxiedBy: SN4PR0601CA0006.namprd06.prod.outlook.com
 (2603:10b6:803:2f::16) To DM5PR1201MB2472.namprd12.prod.outlook.com
 (2603:10b6:3:e1::23)
MIME-Version: 1.0
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN4PR0601CA0006.namprd06.prod.outlook.com (2603:10b6:803:2f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Fri, 24 Jan 2020 23:45:23 +0000
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d09084c-7e62-40b7-7312-08d7a1277afa
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2520:|DM5PR1201MB2520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB25202121D630BEF7A380F439F90E0@DM5PR1201MB2520.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(199004)(189003)(5660300002)(6916009)(8936002)(8676002)(81156014)(81166006)(186003)(86362001)(6486002)(4326008)(1076003)(26005)(36756003)(7696005)(52116002)(6666004)(2906002)(16526019)(66476007)(2616005)(66556008)(956004)(478600001)(66946007)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB2520;
 H:DM5PR1201MB2472.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKF2Mka4eWxfLUIUnDhoCEbhedeRy+izmyco0biNaWQUmnU7p1acKz8QBD45Rcko78Dem/3bQbf6IvHbVqhv2Wz3wX0aX74YvrYuB/yf/GiZS9URcpVQrS5ROWsWQD7mp1Hw6K6eVtgF8ewDtj0/gLDCo6L+U6Mw3AywXDS+a2A/vuqi74G4V+LGKdJxWN6nHzGVqqbQSrEknHxkOEp3GncSXljMtIiMQMWPVH5oQMvt81iKcLuXG84DKVEQlJKqzm9Eit77yUG+f8u4Yn3VuUoBEwOOIzQunzheBlSj6ypAPkeHTm27CKVu9R//lgpMcgw/y8yroiyz9FOBs+ptymlWcXdBtIpWnQ74Bx8EIEQSSMDt0/GY3OOuG0cdgmaiaGldCuNy7cyIEW8z5n/vP3PFR+5MDgddNA3L9jM7TJLC3pH0qJZ+v3AgmKMSB3lI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d09084c-7e62-40b7-7312-08d7a1277afa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 23:45:23.7893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIoafuCZ10yCMqmnNkFczuVoYLXh54Do9QhgBPUvNJ5RqryZwTmFrUBTCby5wvlrPexBl+tPnmbwxbraG26AlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2520
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
Cc: Joseph Greathouse <Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In previous gfx9 parts, S_BARRIER shader instructions are implicitly
S_WAITCNT 0 instructions as well. This setting turns off that
mechanism in Arcturus and beyond. With this, shaders must follow
the ISA guide insofar as putting in explicit S_WAITCNT operations
even after an S_BARRIER.

v2: Fix patch title to list component

Change-Id: I4f80d6bc0c795b62e1f71bbd09d063b7f75249fd
Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c           | 17 +++++++++++++++++
 .../amd/include/asic_reg/gc/gc_9_0_sh_mask.h    |  6 ++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 67ea6a9e13d9..ddde19f9d601 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2441,6 +2441,22 @@ static void gfx_v9_0_init_gds_vmid(struct amdgpu_device *adev)
 	}
 }
 
+static void gfx_v9_0_init_sq_config(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	switch (adev->asic_type) {
+	case CHIP_ARCTURUS:
+		tmp = RREG32_SOC15(GC, 0, mmSQ_CONFIG);
+		tmp = REG_SET_FIELD(tmp, SQ_CONFIG,
+					DISABLE_BARRIER_WAITCNT, 1);
+		WREG32_SOC15(GC, 0, mmSQ_CONFIG, tmp);
+		break;
+	default:
+		break;
+	};
+}
+
 static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 {
 	u32 tmp;
@@ -2486,6 +2502,7 @@ static void gfx_v9_0_constants_init(struct amdgpu_device *adev)
 
 	gfx_v9_0_init_compute_vmid(adev);
 	gfx_v9_0_init_gds_vmid(adev);
+	gfx_v9_0_init_sq_config(adev);
 }
 
 static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
index c9e3f6d849a8..ea316d8dcb37 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
@@ -2060,7 +2060,8 @@
 
 // addressBlock: gc_sqdec
 //SQ_CONFIG
-#define SQ_CONFIG__UNUSED__SHIFT                                                                              0x0
+#define SQ_CONFIG__DISABLE_BARRIER_WAITCNT__SHIFT                                                             0x0
+#define SQ_CONFIG__UNUSED__SHIFT                                                                              0x1
 #define SQ_CONFIG__OVERRIDE_ALU_BUSY__SHIFT                                                                   0x7
 #define SQ_CONFIG__DEBUG_EN__SHIFT                                                                            0x8
 #define SQ_CONFIG__DEBUG_SINGLE_MEMOP__SHIFT                                                                  0x9
@@ -2079,7 +2080,8 @@
 #define SQ_CONFIG__DISABLE_SP_REDUNDANT_THREAD_GATING__SHIFT                                                  0x1d
 #define SQ_CONFIG__DISABLE_FLAT_SOFT_CLAUSE__SHIFT                                                            0x1e
 #define SQ_CONFIG__DISABLE_MIMG_SOFT_CLAUSE__SHIFT                                                            0x1f
-#define SQ_CONFIG__UNUSED_MASK                                                                                0x0000007FL
+#define SQ_CONFIG__DISABLE_BARRIER_WAITCNT_MASK                                                               0x00000001L
+#define SQ_CONFIG__UNUSED_MASK                                                                                0x0000007EL
 #define SQ_CONFIG__OVERRIDE_ALU_BUSY_MASK                                                                     0x00000080L
 #define SQ_CONFIG__DEBUG_EN_MASK                                                                              0x00000100L
 #define SQ_CONFIG__DEBUG_SINGLE_MEMOP_MASK                                                                    0x00000200L
-- 
2.19.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
