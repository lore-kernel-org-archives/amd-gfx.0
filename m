Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4DDC2D0CE
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 23:38:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C82E5206D3
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 23:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXw3862G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82E5206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE046E513;
	Fri, 24 Jan 2020 23:38:38 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5526E513
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 23:38:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6RNNPFdU4RVe7dl7wniYP7bHa+K1R25Zs6QXZ1UX9PlZVbKDosGUIMHJzqLIQF4mWG0SL/uC4EBMyljYtysw4/F1qO9zgTAyCMWr28Q1C5OxFdj6roLg6U/2YCSbsR4MuySaTHGookY4eYL0owl58fFGaaIItsHdSNXFzqLucxVMhKl5l04dpVvKIWf+4S+uA63YKrrwSYDbUb+ECogBO6LBAGs9S0KhpO4c2K5GtBZmYDvWm7APP0nyUTNfTOL8sjXn7+gEmmFoyRXsfKg6+1/PUaRA9CjpQW8fl1UDCa6X83Xh/k1nExEBtlMKXF5FPL4iblDBg8UVCUhlNkEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2Nl/fqJoFwhLVC6rwdWgehkxJGBu7UcqEzbNNg2OBI=;
 b=ATrciJu4P0CjCKsgAlh+S43CUDeqf1iDj9ghCMP55Nm2xNo6otAXsHtT4ZnRxXDPwlBeFfqmn5tSQVt6TxldgDuw6F4WkmUVLrXlZQAYrNfc38hqt0izOsbT7aUxiNv+TRCraXpkTUVT/jmqgQzkG7SFRLgD358NPp4HHyK5D0AMc9iyHuJrgQ9xSrJKn6xqEP0dDxatcb5UVvvWfE2LYsZpg0Fv8Na3WkpdUOu39w7s0s1rQPJbYh04je8NQnT/RCsSEOX6DaPHpZ5/ugnrpf0pSbANNpTDwB4z+aMz3GltfjSg3uv4Jls9OuGF/L7/xALu0LG92NQ7tIvB5teiDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2Nl/fqJoFwhLVC6rwdWgehkxJGBu7UcqEzbNNg2OBI=;
 b=KXw3862GdztfTrMEJYajlyCMgLC1AcNVVlQUrj7NVPLA5PSABQ/jTQIjSWuNKINZq0SAlMlFE3epkLD4ykWLb1Axu54/n2olg5bg8uckKqCASq4Ca11tSa0gMZ4H0R2LsvHL7PzFDdvVkA5usg7AzxHXgQsN3LQ0IfxS0gzo8W8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joseph.Greathouse@amd.com; 
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com (10.172.86.151) by
 DM5PR1201MB0233.namprd12.prod.outlook.com (10.174.106.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Fri, 24 Jan 2020 23:38:34 +0000
Received: from DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721]) by DM5PR1201MB2472.namprd12.prod.outlook.com
 ([fe80::7c50:5e2f:e0a:3721%6]) with mapi id 15.20.2644.028; Fri, 24 Jan 2020
 23:38:34 +0000
From: Joseph Greathouse <Joseph.Greathouse@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Enable DISABLE_BARRIER_WAITCNT for Arcturus
Date: Fri, 24 Jan 2020 17:37:56 -0600
Message-Id: <20200124233756.217565-1-Joseph.Greathouse@amd.com>
X-Mailer: git-send-email 2.19.1
X-ClientProxiedBy: SN1PR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:802:20::25) To DM5PR1201MB2472.namprd12.prod.outlook.com
 (2603:10b6:3:e1::23)
MIME-Version: 1.0
Received: from rocm-perf01.amd.com (165.204.78.2) by
 SN1PR12CA0054.namprd12.prod.outlook.com (2603:10b6:802:20::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18 via Frontend Transport; Fri, 24 Jan 2020 23:38:34 +0000
X-Mailer: git-send-email 2.19.1
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 310dc8b0-4ea7-4b0a-497c-08d7a126871b
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0233:|DM5PR1201MB0233:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB023356110D7F300F0041E4DAF90E0@DM5PR1201MB0233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 02929ECF07
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(199004)(189003)(6916009)(478600001)(6486002)(86362001)(316002)(66556008)(4326008)(66476007)(66946007)(6666004)(16526019)(956004)(186003)(2616005)(26005)(1076003)(36756003)(81156014)(7696005)(81166006)(8936002)(8676002)(5660300002)(52116002)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0233;
 H:DM5PR1201MB2472.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PX3C98XgLd6nJ3scqQ1cwch57QLKGY56mRgC+8kIO1sPMDTEe6zFe4zEOyUtABQjFUKsHV+NADnmZ7gjbyUHE3+IOQajvMBEJEUJlWiPbQbApUr4USoOlLc+wpHNTYAk0RVSc3FvWguDCYAmZFUvxPZDpB4xl87e3puhdAuj81qMfOBu04JSRMqyaK/ZuCzeWRv8uTpajRqHLbcZNoQO27o9GF3mv0FGXOIasdEcGcM+PjUmDd8V7uAt9g3J2pxyUPYZlS9nIbYb8R715HzBUuKRJ/npsDxE/OH0fMln5sLd3f1gZU5Nc/FpxT6MK9XoWmz34sFtIyEkTgtcs59lNZvVPJzOUf0mNEtmYb9IZJqNWWkaUUuTbAatyJJl7Nedi2ZEFaqb/rGzGjt49wybDXz4jy8NY/yEQzPuPT6J97aydbuLuJoGa2afsYTzEUcY
X-MS-Exchange-AntiSpam-MessageData: mDrVhrJa51qBx3Nd2wM2xlx7kneuewPMit+PuqdL0gFjtMsIwmKxbjdDUr2svKh3+ORc243bhBq0cc9L2KrDxe7Sp7xSS4aBZtVFQAkO8gzL+4XDwCjhk1uzwxAodnUu91Z8Sc5UjNhaT0OWuTHTvw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310dc8b0-4ea7-4b0a-497c-08d7a126871b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2020 23:38:34.5505 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zWP4VtEi13LRUZ2hFl/BGKJfSmDuWmrHvFAsxK3QwBa1L4whQvGWFqFhvoCxDRDMFw7MuYf1Cr2X0NlMKjJy8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0233
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
