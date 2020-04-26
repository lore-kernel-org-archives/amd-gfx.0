Return-Path: <SRS0=pLrr=6K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05341C55191
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 09:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4602071C
	for <amd-gfx@archiver.kernel.org>; Sun, 26 Apr 2020 09:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pjBOQJTU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4602071C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 859776E41D;
	Sun, 26 Apr 2020 09:17:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E9566E29B
 for <amd-gfx@lists.freedesktop.org>; Sun, 26 Apr 2020 09:17:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCsXm3Lr7oTd6W7y6g7W9OFrBXEOf+WMljPocT+yQcut9cuvmCe8qTnIg1Dt8ryeGHjD6aJjWOLWZsRuHfV4Z0CyYhL6T/qkxxSdDp8vaRe08zUQEPszzaF8qCJg0KOqTNQ25RD3q6qMe2YzIVpmT4P0bmgsKaY1G7osgZqN/o1TByeHmCn869Lndp0QdkVgtrmTcU9Phvbol/ccZcxxtWiuMuH2aIiah/oqJo82E55/HQLCtbL/Ng+mg1wbLQfZZLU7eTWx+//kehUb1s8hgpgg6zlR/gkBHHJWTIuxRN7ZF2FRBJb0fy/SX8DY8E16YxxlZTLnV+YBJMdAJRxFAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7SF/u86y784k/g/8nhrLzblxYxxGrob1C93GJZrVoU=;
 b=f6QMPvigtWfkpFFPKR7XZoyZh4Kzc1jJqh6OQ82o6Zb3IhTzKnhWNGElD5W2u/4iiJy1qUNLMGTbEAN+5VGt5Ih8DvZ8LucYZwAcb2p2ILg0kwuowx1Jw3Y+NNSLSj1GOWBO5klMJBk6yjbnuPZ++rOGC7PZhoUv5gXakWNhoqEPVbhi4aGmEzmPJiQBv83EE4ZFL8kd7eqQ0EswdUFNOpk+2p7R80N63mI+A84iybtlRglGM5c8eVei/vT1QqTCDMRJ/1ZzXVEPqcPmn05u+3QI+PSQz6MRENntOFYbBtxuJA5aUUhrLhMegAPsp53Hp7eUX1T3iLu1pNJd/Rve5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7SF/u86y784k/g/8nhrLzblxYxxGrob1C93GJZrVoU=;
 b=pjBOQJTUikgSo+on64VT2F5/c9xGdmWHFcZsxPVkNvm3gVjGgyHXt8tMS7P2um7Fmxxbyl5Un20NpsefY6tdftBfhgiFSNqYO7NokpEFagnNRFMJk0LIVzMejw3lMQ945OwRvZtXjFfusfK4rSkACS9z0A3wyoi+2fn8e4i7uKc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Guchun.Chen@amd.com; 
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (10.168.168.136) by
 CY4PR12MB1941.namprd12.prod.outlook.com (10.175.59.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2937.22; Sun, 26 Apr 2020 09:17:14 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::a8f9:dd91:3039:d3dc%8]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 09:17:14 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, alexander.deucher@amd.com
Subject: [PATCH 2/2] drm/amdgpu: decouple EccErrCnt query and clear operation.
Date: Sun, 26 Apr 2020 17:16:44 +0800
Message-Id: <20200426091644.26776-3-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200426091644.26776-1-guchun.chen@amd.com>
References: <20200426091644.26776-1-guchun.chen@amd.com>
X-ClientProxiedBy: HK2PR0401CA0009.apcprd04.prod.outlook.com
 (2603:1096:202:2::19) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR0401CA0009.apcprd04.prod.outlook.com (2603:1096:202:2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Sun, 26 Apr 2020 09:17:12 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c993871-0a98-4c11-cf22-08d7e9c29bf3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1941:|CY4PR12MB1941:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB19412520F453E9D003D9BC19F1AE0@CY4PR12MB1941.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(8676002)(66946007)(6486002)(26005)(81156014)(86362001)(8936002)(7696005)(52116002)(6666004)(36756003)(316002)(1076003)(478600001)(2616005)(44832011)(186003)(4326008)(66476007)(66556008)(2906002)(6636002)(956004)(16526019)(5660300002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIpdzpo+Cl6YPNTKNyca6SfZmC+7n8Uu95V+QS17gLa5IFY2uMuR7uFT3iY1nGwT52+PbI1jHqAgwzYiWJig/9of0rlD6beHlfVDDbf+DvJUhIAg3sfh99oa/sTKgPQbKBrGf54gyWR5a/mddzmLgdfgqP8jYAXtNqtC/1yvb2BFgipF4bbG+KTp0hhCAQRKIAi82nVeuozqlJkG1+FirL+gLS5X+UyvnpILnmA8N/1fDQ+Y5caznsoqYMy1qRqs/nZP0k8OGphkLlEJJPMqxf1s8O758LO8YbFPE8szgLlBeRabL9hyn9UQoT+peRmfTS/LYB6RDpHF24iHtHRtjMPpCAVwlWLLUp5L2oxcsmrbzQQz2VK0n/QrhroUpWMtWpaVjtXmjhWybpEnZ+sUBYPyJs9QrEvGMXLafULM6zld7uXHIHetsXD/zYYl9IaM
X-MS-Exchange-AntiSpam-MessageData: Rdwog0QdASINosBidvIAWpcf3jk0AqrVkKg02S8s5wVZ8DvrItHm9R61Xy1iIOxD09ztDm7r+tPaQJiB3SkpX/p0PfYMp1QvR/gDGQHCmg0fYyLYQZjpE4VHPAksHWX9G1gmyTjPPm+O2gqG33tT6S+GOCA6C+UrGQ1C7sYqBUtjldidtCdabOEz6XUkYqS0N3pE0Cv6V4pRaME+o5vcRnBas03z8DH4raHERex9HVyZgyjZzrdwqBHe4rhHOvODpsd3wwKXyb8QJx7OIpgXUSad6gjHY+0M+cIrEAzXrpOnc0H9eIbNzGc/JaYXPDReLLTsI74a+W12+ceXnPWhb0RTJpqjpl0fIVGP+OjDgDslUcqZCJd8hKCaMADg4aS+k7KABnps/kyDbZHtUeR3qNeCF0wyeEujV/kQtIJQk3B7IixPcjMR1AhqgCvug3+5fC5aokFfwk/8pmVc5qL6BtWSwvTqa7wPsDLy5qmeD6chlREDSqKjnD1W+WXQn51xgn67cB0juABhGhS3dkawlSQFMlyOzTq3KOd55iyOgRiKr0EIUefRc7mLT51F13hIsXAvKRy4zTo/kLnS/RcmGznn9EMoi4xpKjv2bsNZdYDWeMypGztwklLuPLQrPScO+TSWZzxKbFLTOiCtEIkgGrKc6992Ryatg0XHHNoaoqXrIjSjm152ipo0lKOTL7msUH8J9hVbKsWNcklW3lsU7RarTtoc3ElVrO7gjgnRF+RhVIqxGLFMjz59tk2FeD6kZf1aL0i6A5vs+Zg8k+salC1ahT0jKD59a03b7Snu9ZU=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c993871-0a98-4c11-cf22-08d7e9c29bf3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 09:17:14.7637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i+tqeiHtvHD0MqSmkxyIwg6X4rxJ4Zqfi/zrlijwEVkodhi4WO7Yn+DmhlqtJyb629PlOJRRc7GWiIdvfNKzJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1941
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
Cc: Candice.Li@amd.com, Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to hardware bug that when RSMU UMC index is disabled,
clear EccErrCnt at the first UMC instance will clean up all other
EccErrCnt registes from other instances at the same time. This
will break the correctable error count log in EccErrCnt register
once querying it. So decouple both to make error count query workable.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 83 +++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
index 6d767970b2cf..fa889eeb3a17 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -104,6 +104,81 @@ static inline uint32_t get_umc_6_reg_offset(struct amdgpu_device *adev,
 	return adev->umc.channel_offs*ch_inst + UMC_6_INST_DIST*umc_inst;
 }
 
+static void umc_v6_1_clear_error_count_per_channel(struct amdgpu_device *adev,
+					uint32_t umc_reg_offset)
+{
+	uint32_t ecc_err_cnt_addr;
+	uint32_t ecc_err_cnt_sel, ecc_err_cnt_sel_addr;
+
+	if (adev->asic_type == CHIP_ARCTURUS) {
+		/* UMC 6_1_2 registers */
+		ecc_err_cnt_sel_addr =
+			SOC15_REG_OFFSET(UMC, 0,
+					mmUMCCH0_0_EccErrCntSel_ARCT);
+		ecc_err_cnt_addr =
+			SOC15_REG_OFFSET(UMC, 0,
+					mmUMCCH0_0_EccErrCnt_ARCT);
+	} else {
+		/* UMC 6_1_1 registers */
+		ecc_err_cnt_sel_addr =
+			SOC15_REG_OFFSET(UMC, 0,
+					mmUMCCH0_0_EccErrCntSel);
+		ecc_err_cnt_addr =
+			SOC15_REG_OFFSET(UMC, 0,
+					mmUMCCH0_0_EccErrCnt);
+	}
+
+	/* select the lower chip */
+	ecc_err_cnt_sel = RREG32_PCIE((ecc_err_cnt_sel_addr +
+					umc_reg_offset) * 4);
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel,
+					UMCCH0_0_EccErrCntSel,
+					EccErrCntCsSel, 0);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,
+			ecc_err_cnt_sel);
+
+	/* clear lower chip error count */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
+			UMC_V6_1_CE_CNT_INIT);
+
+	/* select the higher chip */
+	ecc_err_cnt_sel = RREG32_PCIE((ecc_err_cnt_sel_addr +
+					umc_reg_offset) * 4);
+	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel,
+					UMCCH0_0_EccErrCntSel,
+					EccErrCntCsSel, 1);
+	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4,
+			ecc_err_cnt_sel);
+
+	/* clear higher chip error count */
+	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4,
+			UMC_V6_1_CE_CNT_INIT);
+}
+
+static void umc_v6_1_clear_error_count(struct amdgpu_device *adev)
+{
+	uint32_t umc_inst        = 0;
+	uint32_t ch_inst         = 0;
+	uint32_t umc_reg_offset  = 0;
+	uint32_t rsmu_umc_index_state =
+				umc_v6_1_get_umc_index_mode_state(adev);
+
+	if (rsmu_umc_index_state)
+		umc_v6_1_disable_umc_index_mode(adev);
+
+	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
+		umc_reg_offset = get_umc_6_reg_offset(adev,
+						umc_inst,
+						ch_inst);
+
+		umc_v6_1_clear_error_count_per_channel(adev,
+						umc_reg_offset);
+	}
+
+	if (rsmu_umc_index_state)
+		umc_v6_1_enable_umc_index_mode(adev);
+}
+
 static void umc_v6_1_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint32_t umc_reg_offset,
 						   unsigned long *error_count)
@@ -136,23 +211,21 @@ static void umc_v6_1_query_correctable_error_count(struct amdgpu_device *adev,
 	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel, UMCCH0_0_EccErrCntSel,
 					EccErrCntCsSel, 0);
 	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4, ecc_err_cnt_sel);
+
 	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
 	*error_count +=
 		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_EccErrCnt, EccErrCnt) -
 		 UMC_V6_1_CE_CNT_INIT);
-	/* clear the lower chip err count */
-	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4, UMC_V6_1_CE_CNT_INIT);
 
 	/* select the higher chip and check the err counter */
 	ecc_err_cnt_sel = REG_SET_FIELD(ecc_err_cnt_sel, UMCCH0_0_EccErrCntSel,
 					EccErrCntCsSel, 1);
 	WREG32_PCIE((ecc_err_cnt_sel_addr + umc_reg_offset) * 4, ecc_err_cnt_sel);
+
 	ecc_err_cnt = RREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4);
 	*error_count +=
 		(REG_GET_FIELD(ecc_err_cnt, UMCCH0_0_EccErrCnt, EccErrCnt) -
 		 UMC_V6_1_CE_CNT_INIT);
-	/* clear the higher chip err count */
-	WREG32_PCIE((ecc_err_cnt_addr + umc_reg_offset) * 4, UMC_V6_1_CE_CNT_INIT);
 
 	/* check for SRAM correctable error
 	  MCUMC_STATUS is a 64 bit register */
@@ -228,6 +301,8 @@ static void umc_v6_1_query_ras_error_count(struct amdgpu_device *adev,
 
 	if (rsmu_umc_index_state)
 		umc_v6_1_enable_umc_index_mode(adev);
+
+	umc_v6_1_clear_error_count(adev);
 }
 
 static void umc_v6_1_query_error_address(struct amdgpu_device *adev,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
