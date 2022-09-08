Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEA6C38145
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 14:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8939C10EB12;
	Thu,  8 Sep 2022 14:08:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CC510EB12
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 14:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ak7itqGzjAQ7gqXsXRV9wWH5GhlfZF2Q2hlw9DMT8IVpzkM/YXeu7aunYMQ/Dq1Nsk54h8TfE+BYf0Dxm7mkF8GQwanVsnn96eY5r15t46VntzcoaMTfcDNHp7GLoVAnorNVuYHgukKnqs9s3ElHDpy+ENuLM8GJ0UHiS5Iv4V0aPo+HhzAqyBLf+EHWxLac/TzJrcdiba0/1CYNElF20urtxpig44bue3/Hw+/saNFouAN+PDvrT08s2nIqBjuwlenR6POCXXJCGdslLnhNyYCtqsaMmFgHSJ34vXGVXAp4AKySi36qIhLCEYL4zw7n4DbJJ8mIQNOgHWbVOEat1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZ79Xy/VSceWYHXE38xWtr8un7a7pm1IJn1vnaYVyjE=;
 b=KjSylDaH2Nkwua+95ria78Qybg6Pp/WqKc8RHZne1Kr+/NOO7fFcTvHsM4j22Hb+pJ6CONLHWTtsHE4ui04qsfMUjCCaFs7+uiA3rPTZrIsRilhaFJOAfyVef5CobN8kK9lgkj/06h6ed4j3haGRiGcKZ+cs8GWWc1cE+KKAKjYUzLsVu0hgB4C6sdRgW5yJjf3XTn2AvIYP6shkadaJgxCV+5WlThfKqfFEgbWX45MsKShsobENTSFaTz0m23te8GrioqCEpNBpnZ++t3iVremTmpd496w5AU0hQKk8eJhc9ctmvvn98cKbd7BJbGKk7Fxk3YLxwH7KmqdWApdoSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZ79Xy/VSceWYHXE38xWtr8un7a7pm1IJn1vnaYVyjE=;
 b=XGx7zg4nevYi0o57xkiu03W4f1He2qw/AmKAyjd2cNKW2WdFAT3PbynOI8dckzXiTotpn9fYBV7bYMV9K2kxxYZepW79FHf2aPDSh34pmpQYwppEA/qUuaKbhY1idaAzSQmZ3/w9IsE1J2tNTQ34XAKGlHh/057F82eh8mRn/b8=
Received: from DS7PR03CA0227.namprd03.prod.outlook.com (2603:10b6:5:3ba::22)
 by BY5PR12MB4114.namprd12.prod.outlook.com (2603:10b6:a03:20c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Thu, 8 Sep
 2022 14:08:17 +0000
Received: from DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::26) by DS7PR03CA0227.outlook.office365.com
 (2603:10b6:5:3ba::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 14:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT045.mail.protection.outlook.com (10.13.173.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 14:08:16 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 09:08:15 -0500
From: Tom St Denis <tom.stdenis@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/amdgpu: update GC 10.3.0 pwrdec
Date: Thu, 8 Sep 2022 10:08:06 -0400
Message-ID: <20220908140806.931436-1-tom.stdenis@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT045:EE_|BY5PR12MB4114:EE_
X-MS-Office365-Filtering-Correlation-Id: cf508d0f-0081-474e-83c5-08da91a393b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUOY5Gmy/Rt44NEfEcqD9r4waXgmLbWA9REGCr3x0A6m1O6LE/JkqxZB//KISubXwwu7Ut0pAMEk329lEhTaP3X+56kRy/RVQyrz+H7kTddd/dOCwRzsJB0SESjBAhsp/OFDrUhTyi0R5DuHGwq4698rac0xw/PM3hvqPdWSyQyWuCXuZXD/n2d1x0DrUb5MBSnzBfEx2+WYEdBJSmXibsG4s8H6rYugjbuVYvpcLFujL9riDclXvucKuMISIG+wq9cS6kDM4BvWEuBIRsiOAhYx74bOgsOH3YH6cPOWCuJBsBz4YGie5chIPJHvJ1xr5p9OIfYp1w50GTusDlLydmacAFjesfYP4PbJudHdCBpnnutTQV1Icfaga4VpJlGsJqkwlkogWJSGvs46FBFtYO3D6mASIfOeFqyjoU9WSwAFZshUZPWKGwSZZ5b4AI/4fBTJEGHUXdxYXAVWKEtqaM+/IBen2Tl2Ekp03iwN5sGAlzMusqGXwfJR4E48DPkox0RZV71EEs0ZwsuGKSONmkwvFoz7bQHbt0u+pFrbugxIahtQqBiheV/llPEvQDwqDyqKgL4AH7b+4ki1dfedSAANDePuYp3iDOoEOa3ut+7iobP3uJTTb34uD7wku1WFkvo1GsyVGOXH8n4Kkgzl3Jgi+RPtXdjJqvhYT9s3rXvaPLLYZaO14hnkj6bX8V8CJjHN2GMV0TBXKPLtod8OqVJoxFj6ooMTCvTbNeo3uAWJFwR9gKllaAdOA+20AFIHT+Hn7GaylHh1dnO+gFrfstz8n8WhLPpaXvsA3oqe0NElICACtMDYQm4MGoaMQzy/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(36840700001)(40470700004)(46966006)(82740400003)(36756003)(8676002)(4326008)(316002)(70206006)(70586007)(356005)(36860700001)(86362001)(81166007)(83380400001)(2616005)(186003)(41300700001)(26005)(426003)(6666004)(478600001)(6916009)(40480700001)(40460700003)(82310400005)(1076003)(16526019)(336012)(47076005)(8936002)(2906002)(30864003)(5660300002)(36900700001)(559001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 14:08:16.9096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf508d0f-0081-474e-83c5-08da91a393b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4114
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
Cc: Tom St Denis <tom.stdenis@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The 10.3 GC headers were missing most of the pwrdec block.
This patch adds the registers and bits present in the 10.1 header
but based on the contents of the 10.3 specs.

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
---
 .../include/asic_reg/gc/gc_10_3_0_offset.h    |  100 ++
 .../include/asic_reg/gc/gc_10_3_0_sh_mask.h   | 1459 ++++++++++++++++-
 2 files changed, 1558 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
index 1115dfc6ae1f..3973110f149c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_offset.h
@@ -9800,18 +9800,118 @@
 
 // addressBlock: gc_pwrdec
 // base address: 0x3c000
+#define mmCGTS_RD_CTRL_REG                                                                             0x5004
+#define mmCGTS_RD_CTRL_REG_BASE_IDX                                                                    1
+#define mmCGTS_RD_REG                                                                                  0x5005
+#define mmCGTS_RD_REG_BASE_IDX                                                                         1
 #define mmCGTS_TCC_DISABLE                                                                             0x5006
 #define mmCGTS_TCC_DISABLE_BASE_IDX                                                                    1
 #define mmCGTS_USER_TCC_DISABLE                                                                        0x5007
 #define mmCGTS_USER_TCC_DISABLE_BASE_IDX                                                               1
+#define mmCGTS_STATUS_REG                                                                              0x5008
+#define mmCGTS_STATUS_REG_BASE_IDX                                                                     1
+#define mmCGTT_SPI_CGTSSM_CLK_CTRL                                                                     0x5009
+#define mmCGTT_SPI_CGTSSM_CLK_CTRL_BASE_IDX                                                            1
+#define mmCGTT_SPI_PS_CLK_CTRL                                                                         0x507d
+#define mmCGTT_SPI_PS_CLK_CTRL_BASE_IDX                                                                1
+#define mmCGTT_SPIS_CLK_CTRL                                                                           0x507e
+#define mmCGTT_SPIS_CLK_CTRL_BASE_IDX                                                                  1
+#define mmCGTT_SPI_CLK_CTRL                                                                            0x5080
+#define mmCGTT_SPI_CLK_CTRL_BASE_IDX                                                                   1
+#define mmCGTT_PC_CLK_CTRL                                                                             0x5081
+#define mmCGTT_PC_CLK_CTRL_BASE_IDX                                                                    1
+#define mmCGTT_BCI_CLK_CTRL                                                                            0x5082
+#define mmCGTT_BCI_CLK_CTRL_BASE_IDX                                                                   1
+#define mmCGTT_VGT_CLK_CTRL                                                                            0x5084
+#define mmCGTT_VGT_CLK_CTRL_BASE_IDX                                                                   1
+#define mmCGTT_IA_CLK_CTRL                                                                             0x5085
+#define mmCGTT_IA_CLK_CTRL_BASE_IDX                                                                    1
+#define mmCGTT_WD_CLK_CTRL                                                                             0x5086
+#define mmCGTT_WD_CLK_CTRL_BASE_IDX                                                                    1
+#define mmCGTT_GS_NGG_CLK_CTRL                                                                         0x5087
+#define mmCGTT_GS_NGG_CLK_CTRL_BASE_IDX                                                                1
+#define mmCGTT_PA_CLK_CTRL                                                                             0x5088
+#define mmCGTT_PA_CLK_CTRL_BASE_IDX                                                                    1
+#define mmCGTT_SC_CLK_CTRL0                                                                            0x5089
+#define mmCGTT_SC_CLK_CTRL0_BASE_IDX                                                                   1
+#define mmCGTT_SC_CLK_CTRL1                                                                            0x508a
+#define mmCGTT_SC_CLK_CTRL1_BASE_IDX                                                                   1
+#define mmCGTT_SC_CLK_CTRL2                                                                            0x508b
+#define mmCGTT_SC_CLK_CTRL2_BASE_IDX                                                                   1
+#define mmCGTT_SQ_CLK_CTRL                                                                             0x508c
+#define mmCGTT_SQ_CLK_CTRL_BASE_IDX                                                                    1
+#define mmCGTT_SQG_CLK_CTRL                                                                            0x508d
+#define mmCGTT_SQG_CLK_CTRL_BASE_IDX                                                                   1
 #define mmSQ_ALU_CLK_CTRL                                                                              0x508e
 #define mmSQ_ALU_CLK_CTRL_BASE_IDX                                                                     1
 #define mmSQ_TEX_CLK_CTRL                                                                              0x508f
 #define mmSQ_TEX_CLK_CTRL_BASE_IDX                                                                     1
 #define mmSQ_LDS_CLK_CTRL                                                                              0x5090
 #define mmSQ_LDS_CLK_CTRL_BASE_IDX                                                                     1
+#define mmCGTT_SX_CLK_CTRL0                                                                            0x5094
+#define mmCGTT_SX_CLK_CTRL0_BASE_IDX                                                                   1
+#define mmCGTT_SX_CLK_CTRL1                                                                            0x5095
+#define mmCGTT_SX_CLK_CTRL1_BASE_IDX                                                                   1
+#define mmCGTT_SX_CLK_CTRL2                                                                            0x5096
+#define mmCGTT_SX_CLK_CTRL2_BASE_IDX                                                                   1
+#define mmCGTT_SX_CLK_CTRL3                                                                            0x5097
+#define mmCGTT_SX_CLK_CTRL3_BASE_IDX                                                                   1
+#define mmCGTT_SX_CLK_CTRL4                                                                            0x5098
+#define mmCGTT_SX_CLK_CTRL4_BASE_IDX                                                                   1
+#define mmTD_CGTT_CTRL                                                                                 0x509c
+#define mmTD_CGTT_CTRL_BASE_IDX                                                                        1
+#define mmTA_CGTT_CTRL                                                                                 0x509d
+#define mmTA_CGTT_CTRL_BASE_IDX                                                                        1
+#define mmCGTT_TCPI_CLK_CTRL                                                                           0x5109
+#define mmCGTT_TCPI_CLK_CTRL_BASE_IDX                                                                  1
+#define mmCGTT_GDS_CLK_CTRL                                                                            0x50a0
+#define mmCGTT_GDS_CLK_CTRL_BASE_IDX                                                                   1
+#define mmDB_CGTT_CLK_CTRL_0                                                                           0x50a4
+#define mmDB_CGTT_CLK_CTRL_0_BASE_IDX                                                                  1
+#define mmCB_CGTT_SCLK_CTRL                                                                            0x50a8
+#define mmCB_CGTT_SCLK_CTRL_BASE_IDX                                                                   1
+#define mmGL2C_CGTT_SCLK_CTRL                                                                          0x50fc
+#define mmGL2C_CGTT_SCLK_CTRL_BASE_IDX                                                                 1
+#define mmGL2A_CGTT_SCLK_CTRL                                                                          0x50ac
+#define mmGL2A_CGTT_SCLK_CTRL_BASE_IDX                                                                 1
+#define mmGL2A_CGTT_SCLK_CTRL_1                                                                        0x50ad
+#define mmGL2A_CGTT_SCLK_CTRL_1_BASE_IDX                                                               1
+#define mmCGTT_CP_CLK_CTRL                                                                             0x50b0
+#define mmCGTT_CP_CLK_CTRL_BASE_IDX                                                                    1
+#define mmCGTT_CPF_CLK_CTRL                                                                            0x50b1
+#define mmCGTT_CPF_CLK_CTRL_BASE_IDX                                                                   1
+#define mmCGTT_CPC_CLK_CTRL                                                                            0x50b2
+#define mmCGTT_CPC_CLK_CTRL_BASE_IDX                                                                   1
+#define mmCGTT_RLC_CLK_CTRL                                                                            0x50b5
+#define mmCGTT_RLC_CLK_CTRL_BASE_IDX                                                                   1
 #define mmRLC_GFX_RM_CNTL                                                                              0x50b6
 #define mmRLC_GFX_RM_CNTL_BASE_IDX                                                                     1
+#define mmRMI_CGTT_SCLK_CTRL                                                                           0x50c0
+#define mmRMI_CGTT_SCLK_CTRL_BASE_IDX                                                                  1
+#define mmCGTT_TCPF_CLK_CTRL                                                                           0x5111
+#define mmCGTT_TCPF_CLK_CTRL_BASE_IDX                                                                  1
+#define mmGCR_CGTT_SCLK_CTRL                                                                           0x50c2
+#define mmGCR_CGTT_SCLK_CTRL_BASE_IDX                                                                  1
+#define mmUTCL1_CGTT_CLK_CTRL                                                                          0x50c3
+#define mmUTCL1_CGTT_CLK_CTRL_BASE_IDX                                                                 1
+#define mmGCEA_CGTT_CLK_CTRL                                                                           0x50c4
+#define mmGCEA_CGTT_CLK_CTRL_BASE_IDX                                                                  1
+#define mmSE_CAC_CGTT_CLK_CTRL                                                                         0x50d0
+#define mmSE_CAC_CGTT_CLK_CTRL_BASE_IDX                                                                1
+#define mmGC_CAC_CGTT_CLK_CTRL                                                                         0x50d8
+#define mmGC_CAC_CGTT_CLK_CTRL_BASE_IDX                                                                1
+#define mmGRBM_CGTT_CLK_CNTL                                                                           0x50e0
+#define mmGRBM_CGTT_CLK_CNTL_BASE_IDX                                                                  1
+#define mmGUS_CGTT_CLK_CTRL                                                                            0x50f4
+#define mmGUS_CGTT_CLK_CTRL_BASE_IDX                                                                   1
+#define mmCGTT_PH_CLK_CTRL0                                                                            0x50f8
+#define mmCGTT_PH_CLK_CTRL0_BASE_IDX                                                                   1
+#define mmCGTT_PH_CLK_CTRL1                                                                            0x50f9
+#define mmCGTT_PH_CLK_CTRL1_BASE_IDX                                                                   1
+#define mmCGTT_PH_CLK_CTRL2                                                                            0x50fa
+#define mmCGTT_PH_CLK_CTRL2_BASE_IDX                                                                   1
+#define mmCGTT_PH_CLK_CTRL3                                                                            0x50fb
+#define mmCGTT_PH_CLK_CTRL3_BASE_IDX                                                                   1
 
 
 // addressBlock: gc_hypdec
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
index 83faa276523f..d4e8ff22ecb8 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_10_3_0_sh_mask.h
@@ -34547,6 +34547,14 @@
 
 
 // addressBlock: gc_pwrdec
+//CGTS_RD_CTRL_REG
+#define CGTS_RD_CTRL_REG__ROW_MUX_SEL__SHIFT                                                                  0x0
+#define CGTS_RD_CTRL_REG__REG_MUX_SEL__SHIFT                                                                  0x4
+#define CGTS_RD_CTRL_REG__ROW_MUX_SEL_MASK                                                                    0x0000000FL
+#define CGTS_RD_CTRL_REG__REG_MUX_SEL_MASK                                                                    0x000000F0L
+//CGTS_RD_REG
+#define CGTS_RD_REG__READ_DATA__SHIFT                                                                         0x0
+#define CGTS_RD_REG__READ_DATA_MASK                                                                           0xFFFFFFFFL
 //CGTS_TCC_DISABLE
 #define CGTS_TCC_DISABLE__HI_TCC_DISABLE__SHIFT                                                               0x8
 #define CGTS_TCC_DISABLE__TCC_DISABLE__SHIFT                                                                  0x10
@@ -34557,6 +34565,485 @@
 #define CGTS_USER_TCC_DISABLE__TCC_DISABLE__SHIFT                                                             0x10
 #define CGTS_USER_TCC_DISABLE__HI_TCC_DISABLE_MASK                                                            0x0000FF00L
 #define CGTS_USER_TCC_DISABLE__TCC_DISABLE_MASK                                                               0xFFFF0000L
+//CGTS_STATUS_REG
+#define CGTS_STATUS_REG__SA0_QUAD0_MGCG_ENABLED__SHIFT                                                        0x0
+#define CGTS_STATUS_REG__SA0_QUAD0_CG_STATUS__SHIFT                                                           0x1
+#define CGTS_STATUS_REG__SA1_QUAD0_MGCG_ENABLED__SHIFT                                                        0x8
+#define CGTS_STATUS_REG__SA1_QUAD0_CG_STATUS__SHIFT                                                           0x9
+#define CGTS_STATUS_REG__SA0_QUAD0_MGCG_ENABLED_MASK                                                          0x00000001L
+#define CGTS_STATUS_REG__SA0_QUAD0_CG_STATUS_MASK                                                             0x00000006L
+#define CGTS_STATUS_REG__SA1_QUAD0_MGCG_ENABLED_MASK                                                          0x00000100L
+#define CGTS_STATUS_REG__SA1_QUAD0_CG_STATUS_MASK                                                             0x00000600L
+//CGTT_SPI_CGTSSM_CLK_CTRL
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP3_OVERRIDE__SHIFT                                                        0x1b
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP2_OVERRIDE__SHIFT                                                        0x1c
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP1_OVERRIDE__SHIFT                                                        0x1d
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP0_OVERRIDE__SHIFT                                                        0x1e
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP3_OVERRIDE_MASK                                                          0x08000000L
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP2_OVERRIDE_MASK                                                          0x10000000L
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP1_OVERRIDE_MASK                                                          0x20000000L
+#define CGTT_SPI_CGTSSM_CLK_CTRL__GRP0_OVERRIDE_MASK                                                          0x40000000L
+//CGTT_SPI_PS_CLK_CTRL
+#define CGTT_SPI_PS_CLK_CTRL__ON_DELAY__SHIFT                                                                 0x0
+#define CGTT_SPI_PS_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                           0x4
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                     0x10
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                     0x11
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                     0x12
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                     0x13
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                     0x14
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                     0x15
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                     0x16
+#define CGTT_SPI_PS_CLK_CTRL__GRP6_OVERRIDE__SHIFT                                                            0x18
+#define CGTT_SPI_PS_CLK_CTRL__GRP5_OVERRIDE__SHIFT                                                            0x19
+#define CGTT_SPI_PS_CLK_CTRL__GRP4_OVERRIDE__SHIFT                                                            0x1a
+#define CGTT_SPI_PS_CLK_CTRL__GRP3_OVERRIDE__SHIFT                                                            0x1b
+#define CGTT_SPI_PS_CLK_CTRL__GRP2_OVERRIDE__SHIFT                                                            0x1c
+#define CGTT_SPI_PS_CLK_CTRL__GRP1_OVERRIDE__SHIFT                                                            0x1d
+#define CGTT_SPI_PS_CLK_CTRL__GRP0_OVERRIDE__SHIFT                                                            0x1e
+#define CGTT_SPI_PS_CLK_CTRL__REG_OVERRIDE__SHIFT                                                             0x1f
+#define CGTT_SPI_PS_CLK_CTRL__ON_DELAY_MASK                                                                   0x0000000FL
+#define CGTT_SPI_PS_CLK_CTRL__OFF_HYSTERESIS_MASK                                                             0x00000FF0L
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                       0x00010000L
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                       0x00020000L
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                       0x00040000L
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                       0x00080000L
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                       0x00100000L
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                       0x00200000L
+#define CGTT_SPI_PS_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                       0x00400000L
+#define CGTT_SPI_PS_CLK_CTRL__GRP6_OVERRIDE_MASK                                                              0x01000000L
+#define CGTT_SPI_PS_CLK_CTRL__GRP5_OVERRIDE_MASK                                                              0x02000000L
+#define CGTT_SPI_PS_CLK_CTRL__GRP4_OVERRIDE_MASK                                                              0x04000000L
+#define CGTT_SPI_PS_CLK_CTRL__GRP3_OVERRIDE_MASK                                                              0x08000000L
+#define CGTT_SPI_PS_CLK_CTRL__GRP2_OVERRIDE_MASK                                                              0x10000000L
+#define CGTT_SPI_PS_CLK_CTRL__GRP1_OVERRIDE_MASK                                                              0x20000000L
+#define CGTT_SPI_PS_CLK_CTRL__GRP0_OVERRIDE_MASK                                                              0x40000000L
+#define CGTT_SPI_PS_CLK_CTRL__REG_OVERRIDE_MASK                                                               0x80000000L
+//CGTT_SPIS_CLK_CTRL
+#define CGTT_SPIS_CLK_CTRL__ON_DELAY__SHIFT                                                                   0x0
+#define CGTT_SPIS_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                       0x10
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                       0x11
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                       0x12
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                       0x13
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                       0x14
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                       0x15
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                       0x16
+#define CGTT_SPIS_CLK_CTRL__GRP6_OVERRIDE__SHIFT                                                              0x18
+#define CGTT_SPIS_CLK_CTRL__GRP5_OVERRIDE__SHIFT                                                              0x19
+#define CGTT_SPIS_CLK_CTRL__GRP4_OVERRIDE__SHIFT                                                              0x1a
+#define CGTT_SPIS_CLK_CTRL__GRP3_OVERRIDE__SHIFT                                                              0x1b
+#define CGTT_SPIS_CLK_CTRL__GRP2_OVERRIDE__SHIFT                                                              0x1c
+#define CGTT_SPIS_CLK_CTRL__GRP1_OVERRIDE__SHIFT                                                              0x1d
+#define CGTT_SPIS_CLK_CTRL__GRP0_OVERRIDE__SHIFT                                                              0x1e
+#define CGTT_SPIS_CLK_CTRL__REG_OVERRIDE__SHIFT                                                               0x1f
+#define CGTT_SPIS_CLK_CTRL__ON_DELAY_MASK                                                                     0x0000000FL
+#define CGTT_SPIS_CLK_CTRL__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                         0x00010000L
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                         0x00020000L
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                         0x00040000L
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                         0x00080000L
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                         0x00100000L
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                         0x00200000L
+#define CGTT_SPIS_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                         0x00400000L
+#define CGTT_SPIS_CLK_CTRL__GRP6_OVERRIDE_MASK                                                                0x01000000L
+#define CGTT_SPIS_CLK_CTRL__GRP5_OVERRIDE_MASK                                                                0x02000000L
+#define CGTT_SPIS_CLK_CTRL__GRP4_OVERRIDE_MASK                                                                0x04000000L
+#define CGTT_SPIS_CLK_CTRL__GRP3_OVERRIDE_MASK                                                                0x08000000L
+#define CGTT_SPIS_CLK_CTRL__GRP2_OVERRIDE_MASK                                                                0x10000000L
+#define CGTT_SPIS_CLK_CTRL__GRP1_OVERRIDE_MASK                                                                0x20000000L
+#define CGTT_SPIS_CLK_CTRL__GRP0_OVERRIDE_MASK                                                                0x40000000L
+#define CGTT_SPIS_CLK_CTRL__REG_OVERRIDE_MASK                                                                 0x80000000L
+//CGTT_SPI_CLK_CTRL
+#define CGTT_SPI_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SPI_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x10
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x11
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x12
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x13
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x14
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x15
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x16
+#define CGTT_SPI_CLK_CTRL__GRP6_OVERRIDE__SHIFT                                                               0x18
+#define CGTT_SPI_CLK_CTRL__GRP5_OVERRIDE__SHIFT                                                               0x19
+#define CGTT_SPI_CLK_CTRL__GRP4_OVERRIDE__SHIFT                                                               0x1a
+#define CGTT_SPI_CLK_CTRL__GRP3_OVERRIDE__SHIFT                                                               0x1b
+#define CGTT_SPI_CLK_CTRL__GRP2_OVERRIDE__SHIFT                                                               0x1c
+#define CGTT_SPI_CLK_CTRL__GRP1_OVERRIDE__SHIFT                                                               0x1d
+#define CGTT_SPI_CLK_CTRL__GRP0_OVERRIDE__SHIFT                                                               0x1e
+#define CGTT_SPI_CLK_CTRL__REG_OVERRIDE__SHIFT                                                                0x1f
+#define CGTT_SPI_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SPI_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00010000L
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00020000L
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00040000L
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00080000L
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00100000L
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00200000L
+#define CGTT_SPI_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00400000L
+#define CGTT_SPI_CLK_CTRL__GRP6_OVERRIDE_MASK                                                                 0x01000000L
+#define CGTT_SPI_CLK_CTRL__GRP5_OVERRIDE_MASK                                                                 0x02000000L
+#define CGTT_SPI_CLK_CTRL__GRP4_OVERRIDE_MASK                                                                 0x04000000L
+#define CGTT_SPI_CLK_CTRL__GRP3_OVERRIDE_MASK                                                                 0x08000000L
+#define CGTT_SPI_CLK_CTRL__GRP2_OVERRIDE_MASK                                                                 0x10000000L
+#define CGTT_SPI_CLK_CTRL__GRP1_OVERRIDE_MASK                                                                 0x20000000L
+#define CGTT_SPI_CLK_CTRL__GRP0_OVERRIDE_MASK                                                                 0x40000000L
+#define CGTT_SPI_CLK_CTRL__REG_OVERRIDE_MASK                                                                  0x80000000L
+//CGTT_PC_CLK_CTRL
+#define CGTT_PC_CLK_CTRL__ON_DELAY__SHIFT                                                                     0x0
+#define CGTT_PC_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                               0x4
+#define CGTT_PC_CLK_CTRL__PC_RAM_FGCG_OVERRIDE__SHIFT                                                         0x11
+#define CGTT_PC_CLK_CTRL__PC_WRITE_CLK_EN_OVERRIDE__SHIFT                                                     0xd
+#define CGTT_PC_CLK_CTRL__PC_READ_CLK_EN_OVERRIDE__SHIFT                                                      0xe
+#define CGTT_PC_CLK_CTRL__CORE3_OVERRIDE__SHIFT                                                               0x1b
+#define CGTT_PC_CLK_CTRL__CORE2_OVERRIDE__SHIFT                                                               0x1c
+#define CGTT_PC_CLK_CTRL__CORE1_OVERRIDE__SHIFT                                                               0x1d
+#define CGTT_PC_CLK_CTRL__CORE0_OVERRIDE__SHIFT                                                               0x1e
+#define CGTT_PC_CLK_CTRL__ON_DELAY_MASK                                                                       0x0000000FL
+#define CGTT_PC_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                 0x00000FF0L
+#define CGTT_PC_CLK_CTRL__PC_RAM_FGCG_OVERRIDE_MASK                                                           0x00020000L
+#define CGTT_PC_CLK_CTRL__PC_WRITE_CLK_EN_OVERRIDE_MASK                                                       0x00002000L
+#define CGTT_PC_CLK_CTRL__PC_READ_CLK_EN_OVERRIDE_MASK                                                        0x00004000L
+#define CGTT_PC_CLK_CTRL__CORE3_OVERRIDE_MASK                                                                 0x08000000L
+#define CGTT_PC_CLK_CTRL__CORE2_OVERRIDE_MASK                                                                 0x10000000L
+#define CGTT_PC_CLK_CTRL__CORE1_OVERRIDE_MASK                                                                 0x20000000L
+#define CGTT_PC_CLK_CTRL__CORE0_OVERRIDE_MASK                                                                 0x40000000L
+//CGTT_BCI_CLK_CTRL
+#define CGTT_BCI_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_BCI_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_BCI_CLK_CTRL__RESERVED__SHIFT                                                                    0xc
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_BCI_CLK_CTRL__CORE6_OVERRIDE__SHIFT                                                              0x18
+#define CGTT_BCI_CLK_CTRL__CORE5_OVERRIDE__SHIFT                                                              0x19
+#define CGTT_BCI_CLK_CTRL__CORE4_OVERRIDE__SHIFT                                                              0x1a
+#define CGTT_BCI_CLK_CTRL__CORE3_OVERRIDE__SHIFT                                                              0x1b
+#define CGTT_BCI_CLK_CTRL__CORE2_OVERRIDE__SHIFT                                                              0x1c
+#define CGTT_BCI_CLK_CTRL__CORE1_OVERRIDE__SHIFT                                                              0x1d
+#define CGTT_BCI_CLK_CTRL__CORE0_OVERRIDE__SHIFT                                                              0x1e
+#define CGTT_BCI_CLK_CTRL__REG_OVERRIDE__SHIFT                                                                0x1f
+#define CGTT_BCI_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_BCI_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_BCI_CLK_CTRL__RESERVED_MASK                                                                      0x0000F000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_BCI_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_BCI_CLK_CTRL__CORE6_OVERRIDE_MASK                                                                0x01000000L
+#define CGTT_BCI_CLK_CTRL__CORE5_OVERRIDE_MASK                                                                0x02000000L
+#define CGTT_BCI_CLK_CTRL__CORE4_OVERRIDE_MASK                                                                0x04000000L
+#define CGTT_BCI_CLK_CTRL__CORE3_OVERRIDE_MASK                                                                0x08000000L
+#define CGTT_BCI_CLK_CTRL__CORE2_OVERRIDE_MASK                                                                0x10000000L
+#define CGTT_BCI_CLK_CTRL__CORE1_OVERRIDE_MASK                                                                0x20000000L
+#define CGTT_BCI_CLK_CTRL__CORE0_OVERRIDE_MASK                                                                0x40000000L
+#define CGTT_BCI_CLK_CTRL__REG_OVERRIDE_MASK                                                                  0x80000000L
+//CGTT_VGT_CLK_CTRL
+#define CGTT_VGT_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_VGT_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_VGT_CLK_CTRL__PERF_ENABLE__SHIFT                                                                 0xf
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_VGT_CLK_CTRL__TESS_OVERRIDE__SHIFT                                                               0x1c
+#define CGTT_VGT_CLK_CTRL__CORE_OVERRIDE__SHIFT                                                               0x1d
+#define CGTT_VGT_CLK_CTRL__REG_OVERRIDE__SHIFT                                                                0x1f
+#define CGTT_VGT_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_VGT_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_VGT_CLK_CTRL__PERF_ENABLE_MASK                                                                   0x00008000L
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_VGT_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_VGT_CLK_CTRL__TESS_OVERRIDE_MASK                                                                 0x10000000L
+#define CGTT_VGT_CLK_CTRL__CORE_OVERRIDE_MASK                                                                 0x20000000L
+#define CGTT_VGT_CLK_CTRL__REG_OVERRIDE_MASK                                                                  0x80000000L
+//CGTT_IA_CLK_CTRL
+#define CGTT_IA_CLK_CTRL__ON_DELAY__SHIFT                                                                     0x0
+#define CGTT_IA_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                               0x4
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                         0x10
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                         0x11
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                         0x12
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                         0x13
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                         0x14
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                         0x15
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                         0x16
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                         0x17
+#define CGTT_IA_CLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                               0x18
+#define CGTT_IA_CLK_CTRL__PERF_ENABLE__SHIFT                                                                  0x19
+#define CGTT_IA_CLK_CTRL__CORE_OVERRIDE__SHIFT                                                                0x1e
+#define CGTT_IA_CLK_CTRL__REG_OVERRIDE__SHIFT                                                                 0x1f
+#define CGTT_IA_CLK_CTRL__ON_DELAY_MASK                                                                       0x0000000FL
+#define CGTT_IA_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                 0x00000FF0L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                           0x00010000L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                           0x00020000L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                           0x00040000L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                           0x00080000L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                           0x00100000L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                           0x00200000L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                           0x00400000L
+#define CGTT_IA_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                           0x00800000L
+#define CGTT_IA_CLK_CTRL__SOFT_OVERRIDE7_MASK                                                                 0x01000000L
+#define CGTT_IA_CLK_CTRL__PERF_ENABLE_MASK                                                                    0x02000000L
+#define CGTT_IA_CLK_CTRL__CORE_OVERRIDE_MASK                                                                  0x40000000L
+#define CGTT_IA_CLK_CTRL__REG_OVERRIDE_MASK                                                                   0x80000000L
+//CGTT_WD_CLK_CTRL
+#define CGTT_WD_CLK_CTRL__ON_DELAY__SHIFT                                                                     0x0
+#define CGTT_WD_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                               0x4
+#define CGTT_WD_CLK_CTRL__PERF_ENABLE__SHIFT                                                                  0xf
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                         0x11
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                         0x12
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                         0x13
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                         0x14
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                         0x15
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                         0x16
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                         0x17
+#define CGTT_WD_CLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                               0x18
+#define CGTT_WD_CLK_CTRL__CORE_OVERRIDE__SHIFT                                                                0x1d
+#define CGTT_WD_CLK_CTRL__RBIU_INPUT_OVERRIDE__SHIFT                                                          0x1e
+#define CGTT_WD_CLK_CTRL__REG_OVERRIDE__SHIFT                                                                 0x1f
+#define CGTT_WD_CLK_CTRL__ON_DELAY_MASK                                                                       0x0000000FL
+#define CGTT_WD_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                 0x00000FF0L
+#define CGTT_WD_CLK_CTRL__PERF_ENABLE_MASK                                                                    0x00008000L
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                           0x00020000L
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                           0x00040000L
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                           0x00080000L
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                           0x00100000L
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                           0x00200000L
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                           0x00400000L
+#define CGTT_WD_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                           0x00800000L
+#define CGTT_WD_CLK_CTRL__SOFT_OVERRIDE7_MASK                                                                 0x01000000L
+#define CGTT_WD_CLK_CTRL__CORE_OVERRIDE_MASK                                                                  0x20000000L
+#define CGTT_WD_CLK_CTRL__RBIU_INPUT_OVERRIDE_MASK                                                            0x40000000L
+#define CGTT_WD_CLK_CTRL__REG_OVERRIDE_MASK                                                                   0x80000000L
+//CGTT_GS_NGG_CLK_CTRL
+#define CGTT_GS_NGG_CLK_CTRL__ON_DELAY__SHIFT                                                                 0x0
+#define CGTT_GS_NGG_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                           0x4
+#define CGTT_GS_NGG_CLK_CTRL__PERF_ENABLE__SHIFT                                                              0xf
+#define CGTT_GS_NGG_CLK_CTRL__DBG_ENABLE__SHIFT                                                               0x10
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                     0x11
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                     0x12
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                     0x13
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                     0x14
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                     0x15
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                     0x16
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                     0x17
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                           0x18
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                           0x19
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                           0x1a
+#define CGTT_GS_NGG_CLK_CTRL__PRIMGEN_OVERRIDE__SHIFT                                                         0x1c
+#define CGTT_GS_NGG_CLK_CTRL__GS1_OVERRIDE__SHIFT                                                             0x1d
+#define CGTT_GS_NGG_CLK_CTRL__GS0_OVERRIDE__SHIFT                                                             0x1e
+#define CGTT_GS_NGG_CLK_CTRL__REG_OVERRIDE__SHIFT                                                             0x1f
+#define CGTT_GS_NGG_CLK_CTRL__ON_DELAY_MASK                                                                   0x0000000FL
+#define CGTT_GS_NGG_CLK_CTRL__OFF_HYSTERESIS_MASK                                                             0x00000FF0L
+#define CGTT_GS_NGG_CLK_CTRL__PERF_ENABLE_MASK                                                                0x00008000L
+#define CGTT_GS_NGG_CLK_CTRL__DBG_ENABLE_MASK                                                                 0x00010000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                       0x00020000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                       0x00040000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                       0x00080000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                       0x00100000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                       0x00200000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                       0x00400000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                       0x00800000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_OVERRIDE7_MASK                                                             0x01000000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_OVERRIDE6_MASK                                                             0x02000000L
+#define CGTT_GS_NGG_CLK_CTRL__SOFT_OVERRIDE5_MASK                                                             0x04000000L
+#define CGTT_GS_NGG_CLK_CTRL__PRIMGEN_OVERRIDE_MASK                                                           0x10000000L
+#define CGTT_GS_NGG_CLK_CTRL__GS1_OVERRIDE_MASK                                                               0x20000000L
+#define CGTT_GS_NGG_CLK_CTRL__GS0_OVERRIDE_MASK                                                               0x40000000L
+#define CGTT_GS_NGG_CLK_CTRL__REG_OVERRIDE_MASK                                                               0x80000000L
+//CGTT_PA_CLK_CTRL
+#define CGTT_PA_CLK_CTRL__ON_DELAY__SHIFT                                                                     0x0
+#define CGTT_PA_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                               0x4
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                         0x10
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                         0x11
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                         0x12
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                         0x13
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                         0x14
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                         0x15
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                         0x16
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                               0x18
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                               0x19
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                               0x1a
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                               0x1b
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                               0x1c
+#define CGTT_PA_CLK_CTRL__SU_CLK_OVERRIDE__SHIFT                                                              0x1d
+#define CGTT_PA_CLK_CTRL__CL_CLK_OVERRIDE__SHIFT                                                              0x1e
+#define CGTT_PA_CLK_CTRL__REG_CLK_OVERRIDE__SHIFT                                                             0x1f
+#define CGTT_PA_CLK_CTRL__ON_DELAY_MASK                                                                       0x0000000FL
+#define CGTT_PA_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                 0x00000FF0L
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                           0x00010000L
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                           0x00020000L
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                           0x00040000L
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                           0x00080000L
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                           0x00100000L
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                           0x00200000L
+#define CGTT_PA_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                           0x00400000L
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE7_MASK                                                                 0x01000000L
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE6_MASK                                                                 0x02000000L
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE5_MASK                                                                 0x04000000L
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE4_MASK                                                                 0x08000000L
+#define CGTT_PA_CLK_CTRL__SOFT_OVERRIDE3_MASK                                                                 0x10000000L
+#define CGTT_PA_CLK_CTRL__SU_CLK_OVERRIDE_MASK                                                                0x20000000L
+#define CGTT_PA_CLK_CTRL__CL_CLK_OVERRIDE_MASK                                                                0x40000000L
+#define CGTT_PA_CLK_CTRL__REG_CLK_OVERRIDE_MASK                                                               0x80000000L
+//CGTT_SC_CLK_CTRL0
+#define CGTT_SC_CLK_CTRL0__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SC_CLK_CTRL0__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SC_CLK_CTRL0__PFF_ZFF_MEM_CLK_STALL_OVERRIDE__SHIFT                                              0x10
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x11
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x12
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x13
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x14
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x15
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x16
+#define CGTT_SC_CLK_CTRL0__REG_CLK_STALL_OVERRIDE__SHIFT                                                      0x17
+#define CGTT_SC_CLK_CTRL0__PFF_ZFF_MEM_CLK_OVERRIDE__SHIFT                                                    0x18
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE5__SHIFT                                                              0x19
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE4__SHIFT                                                              0x1a
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE3__SHIFT                                                              0x1b
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE2__SHIFT                                                              0x1c
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE1__SHIFT                                                              0x1d
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE0__SHIFT                                                              0x1e
+#define CGTT_SC_CLK_CTRL0__REG_CLK_OVERRIDE__SHIFT                                                            0x1f
+#define CGTT_SC_CLK_CTRL0__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SC_CLK_CTRL0__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SC_CLK_CTRL0__PFF_ZFF_MEM_CLK_STALL_OVERRIDE_MASK                                                0x00010000L
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE5_MASK                                                          0x00020000L
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE4_MASK                                                          0x00040000L
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE3_MASK                                                          0x00080000L
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE2_MASK                                                          0x00100000L
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE1_MASK                                                          0x00200000L
+#define CGTT_SC_CLK_CTRL0__SOFT_STALL_OVERRIDE0_MASK                                                          0x00400000L
+#define CGTT_SC_CLK_CTRL0__REG_CLK_STALL_OVERRIDE_MASK                                                        0x00800000L
+#define CGTT_SC_CLK_CTRL0__PFF_ZFF_MEM_CLK_OVERRIDE_MASK                                                      0x01000000L
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE5_MASK                                                                0x02000000L
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE4_MASK                                                                0x04000000L
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE3_MASK                                                                0x08000000L
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE2_MASK                                                                0x10000000L
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE1_MASK                                                                0x20000000L
+#define CGTT_SC_CLK_CTRL0__SOFT_OVERRIDE0_MASK                                                                0x40000000L
+#define CGTT_SC_CLK_CTRL0__REG_CLK_OVERRIDE_MASK                                                              0x80000000L
+//CGTT_SC_CLK_CTRL1
+#define CGTT_SC_CLK_CTRL1__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SC_CLK_CTRL1__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_STALL_OVERRIDE0__SHIFT                                             0x10
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_STALL_OVERRIDE__SHIFT                                              0x11
+#define CGTT_SC_CLK_CTRL1__PBB_SCISSOR_CLK_STALL_OVERRIDE__SHIFT                                              0x12
+#define CGTT_SC_CLK_CTRL1__OTHER_SPECIAL_SC_REG_CLK_STALL_OVERRIDE__SHIFT                                     0x13
+#define CGTT_SC_CLK_CTRL1__SCREEN_EXT_REG_CLK_STALL_OVERRIDE__SHIFT                                           0x14
+#define CGTT_SC_CLK_CTRL1__VPORT_REG_MEM_CLK_STALL_OVERRIDE__SHIFT                                            0x15
+#define CGTT_SC_CLK_CTRL1__PBB_CLK_STALL_OVERRIDE__SHIFT                                                      0x16
+#define CGTT_SC_CLK_CTRL1__PBB_WARP_CLK_STALL_OVERRIDE__SHIFT                                                 0x17
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_OVERRIDE0__SHIFT                                                   0x18
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_OVERRIDE__SHIFT                                                    0x19
+#define CGTT_SC_CLK_CTRL1__PBB_SCISSOR_CLK_OVERRIDE__SHIFT                                                    0x1a
+#define CGTT_SC_CLK_CTRL1__OTHER_SPECIAL_SC_REG_CLK_OVERRIDE__SHIFT                                           0x1b
+#define CGTT_SC_CLK_CTRL1__SCREEN_EXT_REG_CLK_OVERRIDE__SHIFT                                                 0x1c
+#define CGTT_SC_CLK_CTRL1__VPORT_REG_MEM_CLK_OVERRIDE__SHIFT                                                  0x1d
+#define CGTT_SC_CLK_CTRL1__PBB_CLK_OVERRIDE__SHIFT                                                            0x1e
+#define CGTT_SC_CLK_CTRL1__PBB_WARP_CLK_OVERRIDE__SHIFT                                                       0x1f
+#define CGTT_SC_CLK_CTRL1__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SC_CLK_CTRL1__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_STALL_OVERRIDE0_MASK                                               0x00010000L
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_STALL_OVERRIDE_MASK                                                0x00020000L
+#define CGTT_SC_CLK_CTRL1__PBB_SCISSOR_CLK_STALL_OVERRIDE_MASK                                                0x00040000L
+#define CGTT_SC_CLK_CTRL1__OTHER_SPECIAL_SC_REG_CLK_STALL_OVERRIDE_MASK                                       0x00080000L
+#define CGTT_SC_CLK_CTRL1__SCREEN_EXT_REG_CLK_STALL_OVERRIDE_MASK                                             0x00100000L
+#define CGTT_SC_CLK_CTRL1__VPORT_REG_MEM_CLK_STALL_OVERRIDE_MASK                                              0x00200000L
+#define CGTT_SC_CLK_CTRL1__PBB_CLK_STALL_OVERRIDE_MASK                                                        0x00400000L
+#define CGTT_SC_CLK_CTRL1__PBB_WARP_CLK_STALL_OVERRIDE_MASK                                                   0x00800000L
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_OVERRIDE0_MASK                                                     0x01000000L
+#define CGTT_SC_CLK_CTRL1__PBB_BINNING_CLK_OVERRIDE_MASK                                                      0x02000000L
+#define CGTT_SC_CLK_CTRL1__PBB_SCISSOR_CLK_OVERRIDE_MASK                                                      0x04000000L
+#define CGTT_SC_CLK_CTRL1__OTHER_SPECIAL_SC_REG_CLK_OVERRIDE_MASK                                             0x08000000L
+#define CGTT_SC_CLK_CTRL1__SCREEN_EXT_REG_CLK_OVERRIDE_MASK                                                   0x10000000L
+#define CGTT_SC_CLK_CTRL1__VPORT_REG_MEM_CLK_OVERRIDE_MASK                                                    0x20000000L
+#define CGTT_SC_CLK_CTRL1__PBB_CLK_OVERRIDE_MASK                                                              0x40000000L
+#define CGTT_SC_CLK_CTRL1__PBB_WARP_CLK_OVERRIDE_MASK                                                         0x80000000L
+//CGTT_SC_CLK_CTRL2
+#define CGTT_SC_CLK_CTRL2__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SC_CLK_CTRL2__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SC_CLK_CTRL2__DBR_CLK_OVERRIDE__SHIFT                                                            0x1a
+#define CGTT_SC_CLK_CTRL2__SCF_SCB_INTF_CLK_OVERRIDE__SHIFT                                                   0x1b
+#define CGTT_SC_CLK_CTRL2__SC_PKR_INTF_CLK_OVERRIDE__SHIFT                                                    0x1c
+#define CGTT_SC_CLK_CTRL2__SC_DB_INTF_CLK_OVERRIDE__SHIFT                                                     0x1d
+#define CGTT_SC_CLK_CTRL2__PA_SC_INTF_CLK_OVERRIDE__SHIFT                                                     0x1e
+#define CGTT_SC_CLK_CTRL2__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SC_CLK_CTRL2__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SC_CLK_CTRL2__DBR_CLK_OVERRIDE_MASK                                                              0x04000000L
+#define CGTT_SC_CLK_CTRL2__SCF_SCB_INTF_CLK_OVERRIDE_MASK                                                     0x08000000L
+#define CGTT_SC_CLK_CTRL2__SC_PKR_INTF_CLK_OVERRIDE_MASK                                                      0x10000000L
+#define CGTT_SC_CLK_CTRL2__SC_DB_INTF_CLK_OVERRIDE_MASK                                                       0x20000000L
+#define CGTT_SC_CLK_CTRL2__PA_SC_INTF_CLK_OVERRIDE_MASK                                                       0x40000000L
+//CGTT_SQ_CLK_CTRL
+#define CGTT_SQ_CLK_CTRL__ON_DELAY__SHIFT                                                                     0x0
+#define CGTT_SQ_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                               0x4
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                         0x10
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                         0x11
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                         0x12
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                         0x13
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                         0x14
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                         0x15
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                         0x16
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                         0x17
+#define CGTT_SQ_CLK_CTRL__CORE_OVERRIDE__SHIFT                                                                0x1e
+#define CGTT_SQ_CLK_CTRL__REG_OVERRIDE__SHIFT                                                                 0x1f
+#define CGTT_SQ_CLK_CTRL__ON_DELAY_MASK                                                                       0x0000000FL
+#define CGTT_SQ_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                 0x00000FF0L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                           0x00010000L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                           0x00020000L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                           0x00040000L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                           0x00080000L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                           0x00100000L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                           0x00200000L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                           0x00400000L
+#define CGTT_SQ_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                           0x00800000L
+#define CGTT_SQ_CLK_CTRL__CORE_OVERRIDE_MASK                                                                  0x40000000L
+#define CGTT_SQ_CLK_CTRL__REG_OVERRIDE_MASK                                                                   0x80000000L
+//CGTT_SQG_CLK_CTRL
+#define CGTT_SQG_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SQG_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_SQG_CLK_CTRL__TTRACE_OVERRIDE__SHIFT                                                             0x1c
+#define CGTT_SQG_CLK_CTRL__PERFMON_OVERRIDE__SHIFT                                                            0x1d
+#define CGTT_SQG_CLK_CTRL__CORE_OVERRIDE__SHIFT                                                               0x1e
+#define CGTT_SQG_CLK_CTRL__REG_OVERRIDE__SHIFT                                                                0x1f
+#define CGTT_SQG_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SQG_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_SQG_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_SQG_CLK_CTRL__TTRACE_OVERRIDE_MASK                                                               0x10000000L
+#define CGTT_SQG_CLK_CTRL__PERFMON_OVERRIDE_MASK                                                              0x20000000L
+#define CGTT_SQG_CLK_CTRL__CORE_OVERRIDE_MASK                                                                 0x40000000L
+#define CGTT_SQG_CLK_CTRL__REG_OVERRIDE_MASK                                                                  0x80000000L
 //SQ_ALU_CLK_CTRL
 #define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA0__SHIFT                                                              0x0
 #define SQ_ALU_CLK_CTRL__FORCE_WGP_ON_SA1__SHIFT                                                              0x10
@@ -34572,12 +35059,982 @@
 #define SQ_LDS_CLK_CTRL__FORCE_WGP_ON_SA1__SHIFT                                                              0x10
 #define SQ_LDS_CLK_CTRL__FORCE_WGP_ON_SA0_MASK                                                                0x0000FFFFL
 #define SQ_LDS_CLK_CTRL__FORCE_WGP_ON_SA1_MASK                                                                0xFFFF0000L
+//CGTT_SX_CLK_CTRL0
+#define CGTT_SX_CLK_CTRL0__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SX_CLK_CTRL0__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SX_CLK_CTRL0__RESERVED__SHIFT                                                                    0xc
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE7__SHIFT                                                              0x18
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE0__SHIFT                                                              0x1f
+#define CGTT_SX_CLK_CTRL0__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SX_CLK_CTRL0__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SX_CLK_CTRL0__RESERVED_MASK                                                                      0x0000F000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_SX_CLK_CTRL0__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE7_MASK                                                                0x01000000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+#define CGTT_SX_CLK_CTRL0__SOFT_OVERRIDE0_MASK                                                                0x80000000L
+//CGTT_SX_CLK_CTRL1
+#define CGTT_SX_CLK_CTRL1__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SX_CLK_CTRL1__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SX_CLK_CTRL1__RESERVED__SHIFT                                                                    0xc
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE0__SHIFT                                                              0x1f
+#define CGTT_SX_CLK_CTRL1__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SX_CLK_CTRL1__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SX_CLK_CTRL1__RESERVED_MASK                                                                      0x0000F000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_SX_CLK_CTRL1__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+#define CGTT_SX_CLK_CTRL1__SOFT_OVERRIDE0_MASK                                                                0x80000000L
+//CGTT_SX_CLK_CTRL2
+#define CGTT_SX_CLK_CTRL2__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SX_CLK_CTRL2__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SX_CLK_CTRL2__RESERVED__SHIFT                                                                    0xd
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE0__SHIFT                                                              0x1f
+#define CGTT_SX_CLK_CTRL2__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SX_CLK_CTRL2__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SX_CLK_CTRL2__RESERVED_MASK                                                                      0x0000E000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_SX_CLK_CTRL2__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+#define CGTT_SX_CLK_CTRL2__SOFT_OVERRIDE0_MASK                                                                0x80000000L
+//CGTT_SX_CLK_CTRL3
+#define CGTT_SX_CLK_CTRL3__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SX_CLK_CTRL3__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SX_CLK_CTRL3__RESERVED__SHIFT                                                                    0xd
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE0__SHIFT                                                              0x1f
+#define CGTT_SX_CLK_CTRL3__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SX_CLK_CTRL3__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SX_CLK_CTRL3__RESERVED_MASK                                                                      0x0000E000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_SX_CLK_CTRL3__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+#define CGTT_SX_CLK_CTRL3__SOFT_OVERRIDE0_MASK                                                                0x80000000L
+//CGTT_SX_CLK_CTRL4
+#define CGTT_SX_CLK_CTRL4__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_SX_CLK_CTRL4__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_SX_CLK_CTRL4__RESERVED__SHIFT                                                                    0xc
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE0__SHIFT                                                              0x1f
+#define CGTT_SX_CLK_CTRL4__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_SX_CLK_CTRL4__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_SX_CLK_CTRL4__RESERVED_MASK                                                                      0x0000F000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_SX_CLK_CTRL4__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+#define CGTT_SX_CLK_CTRL4__SOFT_OVERRIDE0_MASK                                                                0x80000000L
+//TD_CGTT_CTRL
+#define TD_CGTT_CTRL__ON_DELAY__SHIFT                                                                         0x0
+#define TD_CGTT_CTRL__OFF_HYSTERESIS__SHIFT                                                                   0x4
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                             0x10
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                             0x11
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                             0x12
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                             0x13
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                             0x14
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                             0x15
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                             0x16
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                             0x17
+#define TD_CGTT_CTRL__SOFT_OVERRIDE7__SHIFT                                                                   0x18
+#define TD_CGTT_CTRL__SOFT_OVERRIDE6__SHIFT                                                                   0x19
+#define TD_CGTT_CTRL__SOFT_OVERRIDE5__SHIFT                                                                   0x1a
+#define TD_CGTT_CTRL__SOFT_OVERRIDE4__SHIFT                                                                   0x1b
+#define TD_CGTT_CTRL__SOFT_OVERRIDE3__SHIFT                                                                   0x1c
+#define TD_CGTT_CTRL__SOFT_OVERRIDE2__SHIFT                                                                   0x1d
+#define TD_CGTT_CTRL__SOFT_OVERRIDE1__SHIFT                                                                   0x1e
+#define TD_CGTT_CTRL__SOFT_OVERRIDE0__SHIFT                                                                   0x1f
+#define TD_CGTT_CTRL__ON_DELAY_MASK                                                                           0x0000000FL
+#define TD_CGTT_CTRL__OFF_HYSTERESIS_MASK                                                                     0x00000FF0L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                               0x00010000L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                               0x00020000L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                               0x00040000L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                               0x00080000L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                               0x00100000L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                               0x00200000L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                               0x00400000L
+#define TD_CGTT_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                               0x00800000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE7_MASK                                                                     0x01000000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE6_MASK                                                                     0x02000000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE5_MASK                                                                     0x04000000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE4_MASK                                                                     0x08000000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE3_MASK                                                                     0x10000000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE2_MASK                                                                     0x20000000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE1_MASK                                                                     0x40000000L
+#define TD_CGTT_CTRL__SOFT_OVERRIDE0_MASK                                                                     0x80000000L
+//TA_CGTT_CTRL
+#define TA_CGTT_CTRL__ON_DELAY__SHIFT                                                                         0x0
+#define TA_CGTT_CTRL__OFF_HYSTERESIS__SHIFT                                                                   0x4
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                             0x10
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                             0x11
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                             0x12
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                             0x13
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                             0x14
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                             0x15
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                             0x16
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                             0x17
+#define TA_CGTT_CTRL__SOFT_OVERRIDE7__SHIFT                                                                   0x18
+#define TA_CGTT_CTRL__SOFT_OVERRIDE6__SHIFT                                                                   0x19
+#define TA_CGTT_CTRL__SOFT_OVERRIDE5__SHIFT                                                                   0x1a
+#define TA_CGTT_CTRL__SOFT_OVERRIDE4__SHIFT                                                                   0x1b
+#define TA_CGTT_CTRL__SOFT_OVERRIDE3__SHIFT                                                                   0x1c
+#define TA_CGTT_CTRL__SOFT_OVERRIDE2__SHIFT                                                                   0x1d
+#define TA_CGTT_CTRL__SOFT_OVERRIDE1__SHIFT                                                                   0x1e
+#define TA_CGTT_CTRL__SOFT_OVERRIDE0__SHIFT                                                                   0x1f
+#define TA_CGTT_CTRL__ON_DELAY_MASK                                                                           0x0000000FL
+#define TA_CGTT_CTRL__OFF_HYSTERESIS_MASK                                                                     0x00000FF0L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                               0x00010000L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                               0x00020000L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                               0x00040000L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                               0x00080000L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                               0x00100000L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                               0x00200000L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                               0x00400000L
+#define TA_CGTT_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                               0x00800000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE7_MASK                                                                     0x01000000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE6_MASK                                                                     0x02000000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE5_MASK                                                                     0x04000000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE4_MASK                                                                     0x08000000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE3_MASK                                                                     0x10000000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE2_MASK                                                                     0x20000000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE1_MASK                                                                     0x40000000L
+#define TA_CGTT_CTRL__SOFT_OVERRIDE0_MASK                                                                     0x80000000L
+//CGTT_TCPI_CLK_CTRL
+#define CGTT_TCPI_CLK_CTRL__ON_DELAY__SHIFT                                                                   0x0
+#define CGTT_TCPI_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define CGTT_TCPI_CLK_CTRL__SPARE__SHIFT                                                                      0xc
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                       0xf
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                       0x10
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                       0x11
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                       0x12
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                       0x13
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                       0x14
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                       0x15
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                       0x16
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                             0x17
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                             0x18
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                             0x19
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                             0x1a
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                             0x1b
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                             0x1c
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                             0x1d
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                             0x1e
+#define CGTT_TCPI_CLK_CTRL__ON_DELAY_MASK                                                                     0x0000000FL
+#define CGTT_TCPI_CLK_CTRL__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define CGTT_TCPI_CLK_CTRL__SPARE_MASK                                                                        0x00007000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                         0x00008000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                         0x00010000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                         0x00020000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                         0x00040000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                         0x00080000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                         0x00100000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                         0x00200000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                         0x00400000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE7_MASK                                                               0x00800000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE6_MASK                                                               0x01000000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE5_MASK                                                               0x02000000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE4_MASK                                                               0x04000000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE3_MASK                                                               0x08000000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE2_MASK                                                               0x10000000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE1_MASK                                                               0x20000000L
+#define CGTT_TCPI_CLK_CTRL__SOFT_OVERRIDE0_MASK                                                               0x40000000L
+//CGTT_GDS_CLK_CTRL
+#define CGTT_GDS_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_GDS_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_GDS_CLK_CTRL__UNUSED__SHIFT                                                                      0xc
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                              0x18
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                              0x1f
+#define CGTT_GDS_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_GDS_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_GDS_CLK_CTRL__UNUSED_MASK                                                                        0x0000F000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_GDS_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE7_MASK                                                                0x01000000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+#define CGTT_GDS_CLK_CTRL__SOFT_OVERRIDE0_MASK                                                                0x80000000L
+//DB_CGTT_CLK_CTRL_0
+#define DB_CGTT_CLK_CTRL_0__ON_DELAY__SHIFT                                                                   0x0
+#define DB_CGTT_CLK_CTRL_0__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define DB_CGTT_CLK_CTRL_0__RESERVED__SHIFT                                                                   0xc
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE7__SHIFT                                                       0x10
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE6__SHIFT                                                       0x11
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE5__SHIFT                                                       0x12
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE4__SHIFT                                                       0x13
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE3__SHIFT                                                       0x14
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE2__SHIFT                                                       0x15
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE1__SHIFT                                                       0x16
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE0__SHIFT                                                       0x17
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE7__SHIFT                                                             0x18
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE6__SHIFT                                                             0x19
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE5__SHIFT                                                             0x1a
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE4__SHIFT                                                             0x1b
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE3__SHIFT                                                             0x1c
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE2__SHIFT                                                             0x1d
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE1__SHIFT                                                             0x1e
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE0__SHIFT                                                             0x1f
+#define DB_CGTT_CLK_CTRL_0__ON_DELAY_MASK                                                                     0x0000000FL
+#define DB_CGTT_CLK_CTRL_0__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define DB_CGTT_CLK_CTRL_0__RESERVED_MASK                                                                     0x0000F000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE7_MASK                                                         0x00010000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE6_MASK                                                         0x00020000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE5_MASK                                                         0x00040000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE4_MASK                                                         0x00080000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE3_MASK                                                         0x00100000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE2_MASK                                                         0x00200000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE1_MASK                                                         0x00400000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_STALL_OVERRIDE0_MASK                                                         0x00800000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE7_MASK                                                               0x01000000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE6_MASK                                                               0x02000000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE5_MASK                                                               0x04000000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE4_MASK                                                               0x08000000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE3_MASK                                                               0x10000000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE2_MASK                                                               0x20000000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE1_MASK                                                               0x40000000L
+#define DB_CGTT_CLK_CTRL_0__SOFT_OVERRIDE0_MASK                                                               0x80000000L
+//CB_CGTT_SCLK_CTRL
+#define CB_CGTT_SCLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CB_CGTT_SCLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                              0x18
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                              0x1f
+#define CB_CGTT_SCLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CB_CGTT_SCLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CB_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE7_MASK                                                                0x01000000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+#define CB_CGTT_SCLK_CTRL__SOFT_OVERRIDE0_MASK                                                                0x80000000L
+//GL2C_CGTT_SCLK_CTRL
+#define GL2C_CGTT_SCLK_CTRL__ON_DELAY__SHIFT                                                                  0x0
+#define GL2C_CGTT_SCLK_CTRL__OFF_HYSTERESIS__SHIFT                                                            0x4
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                      0x10
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                      0x11
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                      0x12
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                      0x13
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                      0x14
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                      0x15
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                      0x16
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                      0x17
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                            0x18
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                            0x19
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                            0x1a
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                            0x1b
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                            0x1c
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                            0x1d
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                            0x1e
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                            0x1f
+#define GL2C_CGTT_SCLK_CTRL__ON_DELAY_MASK                                                                    0x0000000FL
+#define GL2C_CGTT_SCLK_CTRL__OFF_HYSTERESIS_MASK                                                              0x00000FF0L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                        0x00010000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                        0x00020000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                        0x00040000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                        0x00080000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                        0x00100000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                        0x00200000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                        0x00400000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                        0x00800000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE7_MASK                                                              0x01000000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE6_MASK                                                              0x02000000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE5_MASK                                                              0x04000000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE4_MASK                                                              0x08000000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE3_MASK                                                              0x10000000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE2_MASK                                                              0x20000000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE1_MASK                                                              0x40000000L
+#define GL2C_CGTT_SCLK_CTRL__SOFT_OVERRIDE0_MASK                                                              0x80000000L
+//GL2A_CGTT_SCLK_CTRL
+#define GL2A_CGTT_SCLK_CTRL__ON_DELAY__SHIFT                                                                  0x0
+#define GL2A_CGTT_SCLK_CTRL__OFF_HYSTERESIS__SHIFT                                                            0x4
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                      0x10
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                      0x11
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                      0x12
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                      0x13
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                      0x14
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                      0x15
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                      0x16
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                      0x17
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                            0x18
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                            0x19
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                            0x1a
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                            0x1b
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                            0x1c
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                            0x1d
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                            0x1e
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                            0x1f
+#define GL2A_CGTT_SCLK_CTRL__ON_DELAY_MASK                                                                    0x0000000FL
+#define GL2A_CGTT_SCLK_CTRL__OFF_HYSTERESIS_MASK                                                              0x00000FF0L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                        0x00010000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                        0x00020000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                        0x00040000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                        0x00080000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                        0x00100000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                        0x00200000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                        0x00400000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                        0x00800000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE7_MASK                                                              0x01000000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE6_MASK                                                              0x02000000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE5_MASK                                                              0x04000000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE4_MASK                                                              0x08000000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE3_MASK                                                              0x10000000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE2_MASK                                                              0x20000000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE1_MASK                                                              0x40000000L
+#define GL2A_CGTT_SCLK_CTRL__SOFT_OVERRIDE0_MASK                                                              0x80000000L
+//GL2A_CGTT_SCLK_CTRL_1
+#define GL2A_CGTT_SCLK_CTRL_1__ON_DELAY__SHIFT                                                                0x0
+#define GL2A_CGTT_SCLK_CTRL_1__OFF_HYSTERESIS__SHIFT                                                          0x4
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE7__SHIFT                                                    0x10
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE6__SHIFT                                                    0x11
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE5__SHIFT                                                    0x12
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE4__SHIFT                                                    0x13
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE3__SHIFT                                                    0x14
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE2__SHIFT                                                    0x15
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE1__SHIFT                                                    0x16
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE0__SHIFT                                                    0x17
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE7__SHIFT                                                          0x18
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE6__SHIFT                                                          0x19
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE5__SHIFT                                                          0x1a
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE4__SHIFT                                                          0x1b
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE3__SHIFT                                                          0x1c
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE2__SHIFT                                                          0x1d
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE1__SHIFT                                                          0x1e
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE0__SHIFT                                                          0x1f
+#define GL2A_CGTT_SCLK_CTRL_1__ON_DELAY_MASK                                                                  0x0000000FL
+#define GL2A_CGTT_SCLK_CTRL_1__OFF_HYSTERESIS_MASK                                                            0x00000FF0L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE7_MASK                                                      0x00010000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE6_MASK                                                      0x00020000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE5_MASK                                                      0x00040000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE4_MASK                                                      0x00080000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE3_MASK                                                      0x00100000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE2_MASK                                                      0x00200000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE1_MASK                                                      0x00400000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_STALL_OVERRIDE0_MASK                                                      0x00800000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE7_MASK                                                            0x01000000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE6_MASK                                                            0x02000000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE5_MASK                                                            0x04000000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE4_MASK                                                            0x08000000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE3_MASK                                                            0x10000000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE2_MASK                                                            0x20000000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE1_MASK                                                            0x40000000L
+#define GL2A_CGTT_SCLK_CTRL_1__SOFT_OVERRIDE0_MASK                                                            0x80000000L
+//CGTT_CP_CLK_CTRL
+#define CGTT_CP_CLK_CTRL__ON_DELAY__SHIFT                                                                     0x0
+#define CGTT_CP_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                               0x4
+#define CGTT_CP_CLK_CTRL__MGLS_OVERRIDE__SHIFT                                                                0xf
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                         0x10
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                         0x11
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                         0x12
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                         0x13
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                         0x14
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                         0x15
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                         0x16
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                         0x17
+#define CGTT_CP_CLK_CTRL__SOFT_OVERRIDE_PERFMON__SHIFT                                                        0x1d
+#define CGTT_CP_CLK_CTRL__SOFT_OVERRIDE_DYN__SHIFT                                                            0x1e
+#define CGTT_CP_CLK_CTRL__SOFT_OVERRIDE_REG__SHIFT                                                            0x1f
+#define CGTT_CP_CLK_CTRL__ON_DELAY_MASK                                                                       0x0000000FL
+#define CGTT_CP_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                 0x00000FF0L
+#define CGTT_CP_CLK_CTRL__MGLS_OVERRIDE_MASK                                                                  0x00008000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                           0x00010000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                           0x00020000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                           0x00040000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                           0x00080000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                           0x00100000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                           0x00200000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                           0x00400000L
+#define CGTT_CP_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                           0x00800000L
+#define CGTT_CP_CLK_CTRL__SOFT_OVERRIDE_PERFMON_MASK                                                          0x20000000L
+#define CGTT_CP_CLK_CTRL__SOFT_OVERRIDE_DYN_MASK                                                              0x40000000L
+#define CGTT_CP_CLK_CTRL__SOFT_OVERRIDE_REG_MASK                                                              0x80000000L
+//CGTT_CPF_CLK_CTRL
+#define CGTT_CPF_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_CPF_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_CPF_CLK_CTRL__MGLS_OVERRIDE__SHIFT                                                               0xf
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_PERFMON__SHIFT                                                       0x1a
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_PRT__SHIFT                                                           0x1b
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_CMP__SHIFT                                                           0x1c
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_GFX__SHIFT                                                           0x1d
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_DYN__SHIFT                                                           0x1e
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_REG__SHIFT                                                           0x1f
+#define CGTT_CPF_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_CPF_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_CPF_CLK_CTRL__MGLS_OVERRIDE_MASK                                                                 0x00008000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_CPF_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_PERFMON_MASK                                                         0x04000000L
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_PRT_MASK                                                             0x08000000L
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_CMP_MASK                                                             0x10000000L
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_GFX_MASK                                                             0x20000000L
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_DYN_MASK                                                             0x40000000L
+#define CGTT_CPF_CLK_CTRL__SOFT_OVERRIDE_REG_MASK                                                             0x80000000L
+//CGTT_CPC_CLK_CTRL
+#define CGTT_CPC_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_CPC_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_CPC_CLK_CTRL__MGLS_OVERRIDE__SHIFT                                                               0xf
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_CPC_CLK_CTRL__SOFT_OVERRIDE_PERFMON__SHIFT                                                       0x1d
+#define CGTT_CPC_CLK_CTRL__SOFT_OVERRIDE_DYN__SHIFT                                                           0x1e
+#define CGTT_CPC_CLK_CTRL__SOFT_OVERRIDE_REG__SHIFT                                                           0x1f
+#define CGTT_CPC_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_CPC_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_CPC_CLK_CTRL__MGLS_OVERRIDE_MASK                                                                 0x00008000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_CPC_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_CPC_CLK_CTRL__SOFT_OVERRIDE_PERFMON_MASK                                                         0x20000000L
+#define CGTT_CPC_CLK_CTRL__SOFT_OVERRIDE_DYN_MASK                                                             0x40000000L
+#define CGTT_CPC_CLK_CTRL__SOFT_OVERRIDE_REG_MASK                                                             0x80000000L
+//CGTT_RLC_CLK_CTRL
+#define CGTT_RLC_CLK_CTRL__RESERVED__SHIFT                                                                    0x0
+#define CGTT_RLC_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                        0x17
+#define CGTT_RLC_CLK_CTRL__SOFT_OVERRIDE_DYN__SHIFT                                                           0x1e
+#define CGTT_RLC_CLK_CTRL__SOFT_OVERRIDE_REG__SHIFT                                                           0x1f
+#define CGTT_RLC_CLK_CTRL__RESERVED_MASK                                                                      0x0000000FL
+#define CGTT_RLC_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_RLC_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                          0x00800000L
+#define CGTT_RLC_CLK_CTRL__SOFT_OVERRIDE_DYN_MASK                                                             0x40000000L
+#define CGTT_RLC_CLK_CTRL__SOFT_OVERRIDE_REG_MASK                                                             0x80000000L
 //RLC_GFX_RM_CNTL
 #define RLC_GFX_RM_CNTL__RLC_GFX_RM_VALID__SHIFT                                                              0x0
 #define RLC_GFX_RM_CNTL__RESERVED__SHIFT                                                                      0x1
 #define RLC_GFX_RM_CNTL__RLC_GFX_RM_VALID_MASK                                                                0x00000001L
 #define RLC_GFX_RM_CNTL__RESERVED_MASK                                                                        0xFFFFFFFEL
-
+//RMI_CGTT_SCLK_CTRL
+#define RMI_CGTT_SCLK_CTRL__ON_DELAY__SHIFT                                                                   0x0
+#define RMI_CGTT_SCLK_CTRL__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                       0x10
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                       0x11
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                       0x12
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                       0x13
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                       0x14
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                       0x15
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                       0x16
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                       0x17
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                             0x19
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                             0x1a
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                             0x1b
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                             0x1c
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                             0x1d
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                             0x1e
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                             0x1f
+#define RMI_CGTT_SCLK_CTRL__ON_DELAY_MASK                                                                     0x0000000FL
+#define RMI_CGTT_SCLK_CTRL__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                         0x00010000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                         0x00020000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                         0x00040000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                         0x00080000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                         0x00100000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                         0x00200000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                         0x00400000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                         0x00800000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE6_MASK                                                               0x02000000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE5_MASK                                                               0x04000000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE4_MASK                                                               0x08000000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE3_MASK                                                               0x10000000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE2_MASK                                                               0x20000000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE1_MASK                                                               0x40000000L
+#define RMI_CGTT_SCLK_CTRL__SOFT_OVERRIDE0_MASK                                                               0x80000000L
+//CGTT_TCPF_CLK_CTRL
+#define CGTT_TCPF_CLK_CTRL__ON_DELAY__SHIFT                                                                   0x0
+#define CGTT_TCPF_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define CGTT_TCPF_CLK_CTRL__SPARE__SHIFT                                                                      0xc
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                       0xf
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                       0x10
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                       0x11
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                       0x12
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                       0x13
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                       0x14
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                       0x15
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                       0x16
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE7__SHIFT                                                             0x17
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                             0x18
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                             0x19
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                             0x1a
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                             0x1b
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                             0x1c
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                             0x1d
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                             0x1e
+#define CGTT_TCPF_CLK_CTRL__ON_DELAY_MASK                                                                     0x0000000FL
+#define CGTT_TCPF_CLK_CTRL__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define CGTT_TCPF_CLK_CTRL__SPARE_MASK                                                                        0x00007000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                         0x00008000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                         0x00010000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                         0x00020000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                         0x00040000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                         0x00080000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                         0x00100000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                         0x00200000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                         0x00400000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE7_MASK                                                               0x00800000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE6_MASK                                                               0x01000000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE5_MASK                                                               0x02000000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE4_MASK                                                               0x04000000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE3_MASK                                                               0x08000000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE2_MASK                                                               0x10000000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE1_MASK                                                               0x20000000L
+#define CGTT_TCPF_CLK_CTRL__SOFT_OVERRIDE0_MASK                                                               0x40000000L
+//GCR_CGTT_SCLK_CTRL
+#define GCR_CGTT_SCLK_CTRL__ON_DELAY__SHIFT                                                                   0x0
+#define GCR_CGTT_SCLK_CTRL__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                       0x10
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                       0x11
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                       0x12
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                       0x13
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                       0x14
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                       0x15
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                       0x16
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                       0x17
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                             0x19
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                             0x1a
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                             0x1b
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                             0x1c
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                             0x1d
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                             0x1e
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                             0x1f
+#define GCR_CGTT_SCLK_CTRL__ON_DELAY_MASK                                                                     0x0000000FL
+#define GCR_CGTT_SCLK_CTRL__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                         0x00010000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                         0x00020000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                         0x00040000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                         0x00080000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                         0x00100000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                         0x00200000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                         0x00400000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                         0x00800000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE6_MASK                                                               0x02000000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE5_MASK                                                               0x04000000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE4_MASK                                                               0x08000000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE3_MASK                                                               0x10000000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE2_MASK                                                               0x20000000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE1_MASK                                                               0x40000000L
+#define GCR_CGTT_SCLK_CTRL__SOFT_OVERRIDE0_MASK                                                               0x80000000L
+//UTCL1_CGTT_CLK_CTRL
+#define UTCL1_CGTT_CLK_CTRL__ON_DELAY__SHIFT                                                                  0x0
+#define UTCL1_CGTT_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                            0x4
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE7__SHIFT                                                      0x10
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE6__SHIFT                                                      0x11
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE5__SHIFT                                                      0x12
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE4__SHIFT                                                      0x13
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE3__SHIFT                                                      0x14
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE2__SHIFT                                                      0x15
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE1__SHIFT                                                      0x16
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE0__SHIFT                                                      0x17
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE6__SHIFT                                                            0x19
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE5__SHIFT                                                            0x1a
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE4__SHIFT                                                            0x1b
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE3__SHIFT                                                            0x1c
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE2__SHIFT                                                            0x1d
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE1__SHIFT                                                            0x1e
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE0__SHIFT                                                            0x1f
+#define UTCL1_CGTT_CLK_CTRL__ON_DELAY_MASK                                                                    0x0000000FL
+#define UTCL1_CGTT_CLK_CTRL__OFF_HYSTERESIS_MASK                                                              0x00000FF0L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE7_MASK                                                        0x00010000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE6_MASK                                                        0x00020000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE5_MASK                                                        0x00040000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE4_MASK                                                        0x00080000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE3_MASK                                                        0x00100000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE2_MASK                                                        0x00200000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE1_MASK                                                        0x00400000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE0_MASK                                                        0x00800000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE6_MASK                                                              0x02000000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE5_MASK                                                              0x04000000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE4_MASK                                                              0x08000000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE3_MASK                                                              0x10000000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE2_MASK                                                              0x20000000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE1_MASK                                                              0x40000000L
+#define UTCL1_CGTT_CLK_CTRL__SOFT_OVERRIDE0_MASK                                                              0x80000000L
+//GCEA_CGTT_CLK_CTRL
+#define GCEA_CGTT_CLK_CTRL__ON_DELAY__SHIFT                                                                   0x0
+#define GCEA_CGTT_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define GCEA_CGTT_CLK_CTRL__SPARE0__SHIFT                                                                     0xc
+#define GCEA_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_WRITE__SHIFT                                                  0x14
+#define GCEA_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_READ__SHIFT                                                   0x15
+#define GCEA_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_RETURN__SHIFT                                                 0x16
+#define GCEA_CGTT_CLK_CTRL__SPARE1__SHIFT                                                                     0x17
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_WRITE__SHIFT                                                        0x1c
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_READ__SHIFT                                                         0x1d
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_RETURN__SHIFT                                                       0x1e
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_REGISTER__SHIFT                                                     0x1f
+#define GCEA_CGTT_CLK_CTRL__ON_DELAY_MASK                                                                     0x0000000FL
+#define GCEA_CGTT_CLK_CTRL__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define GCEA_CGTT_CLK_CTRL__SPARE0_MASK                                                                       0x000FF000L
+#define GCEA_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_WRITE_MASK                                                    0x00100000L
+#define GCEA_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_READ_MASK                                                     0x00200000L
+#define GCEA_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_RETURN_MASK                                                   0x00400000L
+#define GCEA_CGTT_CLK_CTRL__SPARE1_MASK                                                                       0x0F800000L
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_WRITE_MASK                                                          0x10000000L
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_READ_MASK                                                           0x20000000L
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_RETURN_MASK                                                         0x40000000L
+#define GCEA_CGTT_CLK_CTRL__SOFT_OVERRIDE_REGISTER_MASK                                                       0x80000000L
+//SE_CAC_CGTT_CLK_CTRL
+#define SE_CAC_CGTT_CLK_CTRL__ON_DELAY__SHIFT                                                                 0x0
+#define SE_CAC_CGTT_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                           0x4
+#define SE_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_DYN__SHIFT                                                        0x1e
+#define SE_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_REG__SHIFT                                                        0x1f
+#define SE_CAC_CGTT_CLK_CTRL__ON_DELAY_MASK                                                                   0x0000000FL
+#define SE_CAC_CGTT_CLK_CTRL__OFF_HYSTERESIS_MASK                                                             0x00000FF0L
+#define SE_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_DYN_MASK                                                          0x40000000L
+#define SE_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_REG_MASK                                                          0x80000000L
+//GC_CAC_CGTT_CLK_CTRL
+#define GC_CAC_CGTT_CLK_CTRL__ON_DELAY__SHIFT                                                                 0x0
+#define GC_CAC_CGTT_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                           0x4
+#define GC_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_DYN__SHIFT                                                        0x1e
+#define GC_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_REG__SHIFT                                                        0x1f
+#define GC_CAC_CGTT_CLK_CTRL__ON_DELAY_MASK                                                                   0x0000000FL
+#define GC_CAC_CGTT_CLK_CTRL__OFF_HYSTERESIS_MASK                                                             0x00000FF0L
+#define GC_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_DYN_MASK                                                          0x40000000L
+#define GC_CAC_CGTT_CLK_CTRL__SOFT_OVERRIDE_REG_MASK                                                          0x80000000L
+//GRBM_CGTT_CLK_CNTL
+#define GRBM_CGTT_CLK_CNTL__ON_DELAY__SHIFT                                                                   0x0
+#define GRBM_CGTT_CLK_CNTL__OFF_HYSTERESIS__SHIFT                                                             0x4
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE7__SHIFT                                                       0x10
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE6__SHIFT                                                       0x11
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE5__SHIFT                                                       0x12
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE4__SHIFT                                                       0x13
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE3__SHIFT                                                       0x14
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE2__SHIFT                                                       0x15
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE1__SHIFT                                                       0x16
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE0__SHIFT                                                       0x17
+#define GRBM_CGTT_CLK_CNTL__SOFT_OVERRIDE_DYN__SHIFT                                                          0x1e
+#define GRBM_CGTT_CLK_CNTL__ON_DELAY_MASK                                                                     0x0000000FL
+#define GRBM_CGTT_CLK_CNTL__OFF_HYSTERESIS_MASK                                                               0x00000FF0L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE7_MASK                                                         0x00010000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE6_MASK                                                         0x00020000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE5_MASK                                                         0x00040000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE4_MASK                                                         0x00080000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE3_MASK                                                         0x00100000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE2_MASK                                                         0x00200000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE1_MASK                                                         0x00400000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_STALL_OVERRIDE0_MASK                                                         0x00800000L
+#define GRBM_CGTT_CLK_CNTL__SOFT_OVERRIDE_DYN_MASK                                                            0x40000000L
+//GUS_CGTT_CLK_CTRL
+#define GUS_CGTT_CLK_CTRL__ON_DELAY__SHIFT                                                                    0x0
+#define GUS_CGTT_CLK_CTRL__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define GUS_CGTT_CLK_CTRL__SPARE0__SHIFT                                                                      0xc
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_DRAM__SHIFT                                                    0x13
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_WRITE__SHIFT                                                   0x14
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_READ__SHIFT                                                    0x15
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_RETURN__SHIFT                                                  0x16
+#define GUS_CGTT_CLK_CTRL__SPARE1__SHIFT                                                                      0x17
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_DRAM__SHIFT                                                          0x1b
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_WRITE__SHIFT                                                         0x1c
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_READ__SHIFT                                                          0x1d
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_RETURN__SHIFT                                                        0x1e
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_REGISTER__SHIFT                                                      0x1f
+#define GUS_CGTT_CLK_CTRL__ON_DELAY_MASK                                                                      0x0000000FL
+#define GUS_CGTT_CLK_CTRL__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define GUS_CGTT_CLK_CTRL__SPARE0_MASK                                                                        0x0007F000L
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_DRAM_MASK                                                      0x00080000L
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_WRITE_MASK                                                     0x00100000L
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_READ_MASK                                                      0x00200000L
+#define GUS_CGTT_CLK_CTRL__SOFT_STALL_OVERRIDE_RETURN_MASK                                                    0x00400000L
+#define GUS_CGTT_CLK_CTRL__SPARE1_MASK                                                                        0x07800000L
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_DRAM_MASK                                                            0x08000000L
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_WRITE_MASK                                                           0x10000000L
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_READ_MASK                                                            0x20000000L
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_RETURN_MASK                                                          0x40000000L
+#define GUS_CGTT_CLK_CTRL__SOFT_OVERRIDE_REGISTER_MASK                                                        0x80000000L
+//CGTT_PH_CLK_CTRL0
+#define CGTT_PH_CLK_CTRL0__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_PH_CLK_CTRL0__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE7__SHIFT                                                        0x10
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE6__SHIFT                                                        0x11
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE5__SHIFT                                                        0x12
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE4__SHIFT                                                        0x13
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE3__SHIFT                                                        0x14
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE2__SHIFT                                                        0x15
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE1__SHIFT                                                        0x16
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE7__SHIFT                                                              0x18
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_PH_CLK_CTRL0__PERFMON_CLK_OVERRIDE__SHIFT                                                        0x1e
+#define CGTT_PH_CLK_CTRL0__REG_CLK_OVERRIDE__SHIFT                                                            0x1f
+#define CGTT_PH_CLK_CTRL0__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_PH_CLK_CTRL0__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE7_MASK                                                          0x00010000L
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE6_MASK                                                          0x00020000L
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE5_MASK                                                          0x00040000L
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE4_MASK                                                          0x00080000L
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE3_MASK                                                          0x00100000L
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE2_MASK                                                          0x00200000L
+#define CGTT_PH_CLK_CTRL0__SOFT_STALL_OVERRIDE1_MASK                                                          0x00400000L
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE7_MASK                                                                0x01000000L
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_PH_CLK_CTRL0__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_PH_CLK_CTRL0__PERFMON_CLK_OVERRIDE_MASK                                                          0x40000000L
+#define CGTT_PH_CLK_CTRL0__REG_CLK_OVERRIDE_MASK                                                              0x80000000L
+//CGTT_PH_CLK_CTRL1
+#define CGTT_PH_CLK_CTRL1__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_PH_CLK_CTRL1__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE7__SHIFT                                                              0x18
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_PH_CLK_CTRL1__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_PH_CLK_CTRL1__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE7_MASK                                                                0x01000000L
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_PH_CLK_CTRL1__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+//CGTT_PH_CLK_CTRL2
+#define CGTT_PH_CLK_CTRL2__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_PH_CLK_CTRL2__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE7__SHIFT                                                              0x18
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_PH_CLK_CTRL2__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_PH_CLK_CTRL2__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE7_MASK                                                                0x01000000L
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_PH_CLK_CTRL2__SOFT_OVERRIDE1_MASK                                                                0x40000000L
+//CGTT_PH_CLK_CTRL3
+#define CGTT_PH_CLK_CTRL3__ON_DELAY__SHIFT                                                                    0x0
+#define CGTT_PH_CLK_CTRL3__OFF_HYSTERESIS__SHIFT                                                              0x4
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE7__SHIFT                                                              0x18
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE6__SHIFT                                                              0x19
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE5__SHIFT                                                              0x1a
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE4__SHIFT                                                              0x1b
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE3__SHIFT                                                              0x1c
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE2__SHIFT                                                              0x1d
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE1__SHIFT                                                              0x1e
+#define CGTT_PH_CLK_CTRL3__ON_DELAY_MASK                                                                      0x0000000FL
+#define CGTT_PH_CLK_CTRL3__OFF_HYSTERESIS_MASK                                                                0x00000FF0L
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE7_MASK                                                                0x01000000L
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE6_MASK                                                                0x02000000L
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE5_MASK                                                                0x04000000L
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE4_MASK                                                                0x08000000L
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE3_MASK                                                                0x10000000L
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE2_MASK                                                                0x20000000L
+#define CGTT_PH_CLK_CTRL3__SOFT_OVERRIDE1_MASK                                                                0x40000000L
 
 // addressBlock: gc_hypdec
 //CP_HYP_PFP_UCODE_ADDR
-- 
2.34.1

