Return-Path: <SRS0=BBBq=HF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F83C433DB
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:30:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0280664F68
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Feb 2021 08:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0280664F68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8964A6EA0F;
	Wed,  3 Feb 2021 08:30:42 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770051.outbound.protection.outlook.com [40.107.77.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348636EA0F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Feb 2021 08:30:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBM2hDM6hrqcTmiuQGe6GD8A0W0/Y07wdX3ptGSs1lBp2ctlq5lRlu6ReE8d0FX39z28KOY+zmn8U7osiTQ2/fUkafVALxklHmtDVVZDB5D0M2QrgWGs5eOT0UJkHu611iXgsUm6gg/VjIJEuR8ytpMy2cCXX3ZO1QMPJqvgdEUa9vb6N28Pj00nilwfkQLIddoyWVduao5xjx9FETwuheB6QNao03U+GPPUSRRYVQgu6QqDDDwMJSyWw6BinCik9WuKa4KHv6mbojtogRv9VInNygt7pIO+FaDp1EmV0A5EaVWhzGAAyywAORODfwd4NlXvIh683VTZiTF2DPDRHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek9h0xM0I+CmAjTuHn41HBdrR1jp6sQ0feIqR8qBLGA=;
 b=UJ+fRZ7IFjfwQqEEOK3bRcrNbpf/shDWTOeKecDXbRQBI8fTJd9jTiTpes7Cea6Bh8bIHV8kVjwqMobputCQ2kdaWmd78/JwAir1wKcoWsNXO0R5ZIpJmcOBb2nu9LnlKHj4Wto6sexK3HQUMenV2m9+DMcqsN5vMjFaarGbcStWoG4ErktZagwixbzHaQJ/HMyfmUTwFrd9xDPWhRkWc6uJW7XSwM7C+pk7swODWNqCT5lmSg3XybdD9KSXMHUrAg4jBYpQf0DaYgjWmtKVIRPb0cF+C8vqlhEOEk6xDTIHY22CpGElAQ8OBxjZ0oaTeJrcRt0BpaGVikMlB6X0Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek9h0xM0I+CmAjTuHn41HBdrR1jp6sQ0feIqR8qBLGA=;
 b=ZAnNUHHSyliA5c4XJ/ZH4Yor3nLdTE0Nn5m9rCNI7cmM3tXFwlWUvSKY+WP96XK+cjT8X4DcTXQx2QUb2rh2bx68ybiv3KYD4M42DQ09Q9D5czt8UldGj9AW3B1qbRVcJBSgRMyCwzMS9z46Rk5nQeET53JYts5jDRjR22gTWzo=
Received: from DM5PR21CA0043.namprd21.prod.outlook.com (2603:10b6:3:ed::29) by
 DM5PR12MB1369.namprd12.prod.outlook.com (2603:10b6:3:6f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Wed, 3 Feb 2021 08:30:38 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::a9) by DM5PR21CA0043.outlook.office365.com
 (2603:10b6:3:ed::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.2 via Frontend
 Transport; Wed, 3 Feb 2021 08:30:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Wed, 3 Feb 2021 08:30:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Feb 2021
 02:30:36 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Feb 2021
 02:30:35 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 3 Feb 2021 02:30:34 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: update register offsets for VGH in the
 gfx_v10_0_setup_grbm_cam_remapping function
Date: Wed, 3 Feb 2021 16:30:30 +0800
Message-ID: <1612341030-13679-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad40cff-c488-4f96-33d9-08d8c81dfb6e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1369:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1369B546F3954DEE09502B3F9DB49@DM5PR12MB1369.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c54N90i6PNhKZ1/91pJA+JiUoDoxrKq4W7Ia/lPwRvqMxEiiv0jptIlzEACZSNS6asuZSRxJp/eXYTc9GKG99Nv7d9+vFIe1v5en1ZY7NYjTCDda4ja3NPAEuVNrnxxXs9/4fPYlnVNiTO/Ny+uU5EjHDmFPt1wSZh6CIYPx8Vr24DJ9FXNzGXOcPTSAt2h5cmywIJWC+cuZ5lJDc7uwubsyWR8rv8oi+NqYUMF7JHX8QPGFrPGv7HcB4LMzMp52sEYiKrNeGeJQNST3xaegj80qzoHRkaQTlPoCDKVJ8rVrZ6m0X2DtlILjYpWYpQ/TZloUcVMXWro4kW/rq8P8xkAnFoiYd394dDddDG/WvvoWPvZZhkRVtEEc97Aoi05aM2UrO1tgTh+xMihqEQE60HDyEvvoRsEo/0DJycVO0cf4itDB7M58tEMuFqL7ufUBn5BigrI6NHOx6BN5hn0W8UwYBZtSXJrGqh3Tr2claWjzP9wRr4gl2x/nXNylkU9upzk5S7Cdyi48TRL/EAtK1vTavsRe4+T2JCiP7JZvLYo1wwa2hkxEUuCCYUumilPyI+84GIW7IpAXQOgGPEiDEdX6DmUsjA9zs3IxpO8U2SGUddr27vKqL+2Ea0CgKuu5eZpSDlY3C/4e0eT0lRYytyfgw8mb6B3gJoOKeEvVSMCpzxapxBPrn2T8HWQHflkx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36840700001)(46966006)(356005)(83380400001)(316002)(6666004)(81166007)(2906002)(86362001)(5660300002)(70206006)(70586007)(36756003)(186003)(6916009)(478600001)(82740400003)(26005)(2616005)(336012)(4326008)(426003)(54906003)(7696005)(82310400003)(47076005)(8936002)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 08:30:36.9835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad40cff-c488-4f96-33d9-08d8c81dfb6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1369
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
Cc: Alexander.Deucher@amd.com, chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For Vangogh, the offset values of some GC registers used in the
gfx_v10_0_setup_grbm_cam_remapping() function are not the same as those
of Sienna_Cichlid, so cannot be reused.

Although gfx_v10_0_setup_grbm_cam_remapping() is not called now for
Vangogh, it is necessary to implement this patch in case we enable this
code in the future.

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 8ac2af2..a9ce2a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7029,9 +7029,63 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
 
 	switch (adev->asic_type) {
+	case CHIP_VANGOGH:
+		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_Vangogh) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_Vangogh) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_Vangogh) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_Vangogh) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_Vangogh) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_Vangogh) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
+		data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_Vangogh) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		break;
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
-	case CHIP_VANGOGH:
 	case CHIP_DIMGREY_CAVEFISH:
 		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
 		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
