Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA1C433E9
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:07:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C4A64E06
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 09:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C4A64E06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8463E6E4CD;
	Mon,  1 Feb 2021 09:07:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 145796E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 09:07:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EChX7C/8iXl6MWdTusMfeChTYeeOoS+avoqwTSbz+sapZW1G6u+4KDCKqGJFfzJAc7m3HMf4sytnU2o1WV5tLeZM/gOUugdidMa9Sd8MGTdjXMt5YJx+7ms4ZASBCOw1fZXR9oZD+fosDpyO/Z7BxdiG2akN2b7Q0xX5wGcQTsNvjjNwk4i5NgU38kUhmaNnME9hZ8IzHmZDF2jEYEM5aKEsiT7Wh40wqbwypUTf4z+ELBBF3xPD50TijmRVLpJA/wcpBp467OGCCSh1YRInhtQkZmqKhT8vNwK5d6IZWEFakZNXiX7tw2Yh5MG3PyXwJDcFHKP9szMZKN7FWlA90w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Uo+Wd8PyIaSVF0O140pTfaEUhJFGt/uqTcFTcfuB8=;
 b=avKdEpeAvfTGo3ao50KOa0S8UshxVkARnv7eJep3NLMtW0UoTXnlfRQQTb3wIzwtjzITJ0yUzjJBLTid598wSyQNXgzAC35DA2EED17KKGL0j4ZfRjrErJ3+vypDQ3wdobHmzOmTEHbktysNa9Xn49KrKmDemObwARMVm7Q7eRLNbF8MTzOdKnb/lGyJZ/yUTwHPQTqCcE1ahQZPbjgH8cGvECkYwAMAoe9oABhCk9IM/bTOhxfMzspidT9LcBVKyNuaXS3pi9/1Q/oVYDS4BsjhXRkeJM6nqmuOhmUD0wmBdRWc2udhxHBztecUiESqaWF5SH3lfsgi9gkkveCaPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Uo+Wd8PyIaSVF0O140pTfaEUhJFGt/uqTcFTcfuB8=;
 b=Qp/9Oxma6AVO/CYiJydfQMvjafZ+YeucVX5/XFKjnwe6o3Q03BYxqQoRIwBBttWWay4GctG8gUjC/S/4yC04C1ItWv1h8yya2ykmyfZxFoeKkWCEVlhqaWZffdVUMgXfg9ptXIR05F7pJdGSXI5Mnx4eEYLh2zD07jl/6SD6wRg=
Received: from CO2PR04CA0079.namprd04.prod.outlook.com (2603:10b6:102:1::47)
 by MN2PR12MB2927.namprd12.prod.outlook.com (2603:10b6:208:103::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 1 Feb
 2021 09:07:12 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::58) by CO2PR04CA0079.outlook.office365.com
 (2603:10b6:102:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Mon, 1 Feb 2021 09:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Mon, 1 Feb 2021 09:07:10 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Feb 2021
 03:07:07 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 1 Feb 2021
 03:07:07 -0600
Received: from gc-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Mon, 1 Feb 2021 03:07:06 -0600
From: chen gong <curry.gong@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/gfx10: update register offsets for VGH in the
 gfx_v10_0_setup_grbm_cam_remapping function
Date: Mon, 1 Feb 2021 17:07:03 +0800
Message-ID: <1612170423-13733-1-git-send-email-curry.gong@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9975ee19-20d1-46e2-31ce-08d8c690c203
X-MS-TrafficTypeDiagnostic: MN2PR12MB2927:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2927048532A2981CAE9A3BE69DB69@MN2PR12MB2927.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeGbmAEDP+mZVuoqiE64M6JLjVFUBoTIHmXG0YDwpY8qzm+Lgprbv5ZEtFBD59eR5ywxrUvj+x2kqsHqrFwYcK7nqZ2YCvKfq4l1Zl+F1MkFtBsdbTxnaOC9dZo4PgJ2eWs3u/H3D5KSiAOG9yqVtctKHskUAvMwfy5rPXhlVaQ+r9ffaFrmX9n2K0RbVtMcSQKI4DvggzBZikZhF3re4gAqKtRlWpQ7D/CdWSQ/uBFX1U1DL2wKF18xqaiT5t7M5ChBNp7No7iXWV+0HqAXuzfnFdiSfeItPh3267yDxvZ6KfLXJRfmZHeDJ5sSZ8SGK6vE+x8S2Y4KmU53sev+0XsTQAi2D4NR8XQsxxpegNgaWKqRtSQkcdNyfTJtl5WU4wMxjNBZ+kgtSTPfJ4v11aLWaVYA8cHHtuK85/au16JelR1Fnz/+e8ady36w+6HvT4BoqPj2CZfjEqvuAHptUZJ5PNWEO/BWW5FFjz5n1FD7vLx6t8Jjkg9du+oleSyp7S57XHCV3Bk1M1Xi/H2cVSD+kqU+2Zn5tB+mOsR8TVy9caSPftTIXqlelHpOrDsRLJ64lkAKjPiJ+l7Po1wx1dhmB6KZXks+BrbkTk137gQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(2616005)(81166007)(6916009)(82310400003)(7696005)(70586007)(86362001)(186003)(2906002)(336012)(47076005)(83380400001)(6666004)(8676002)(4326008)(36756003)(8936002)(70206006)(5660300002)(26005)(316002)(478600001)(356005)(82740400003)(426003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 09:07:10.3585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9975ee19-20d1-46e2-31ce-08d8c690c203
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2927
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
Cc: chen gong <curry.gong@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: chen gong <curry.gong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 024460b..d7e9a18 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7031,9 +7031,63 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
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
