Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE85C47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A2661C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A2661C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73BA66ED72;
	Wed,  2 Jun 2021 16:49:42 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29DCA6ED65
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xp3tjn/NfdicBB3gxRm6oI4S+kSrcl79/ry/00p1fGtp9iyqNo6ExfjA0DmI4AZA16jTy6GllvvWZMIwwX5Qmg7Rker6gLU/QGH9UoA/KmHpsL06ReX6dIapi7nsMAm7syotE4oEQUQObbaZ4LFZI53w4O8tRifaPTZMNt972vvHiSmMAK04lo5GkWfGWAvxoW9snmEcg4y2ZxEWxt+K7uU/usEfWUY+20yL45F0301CRhjxzkt7hWzPuQOIGmwZSELAIjRRunba1bRV47tQVVuOCc7lXBe/gqa7phNuFAf0PMS7VNC8O4zreCb6u4Yn/W2r3seGbpeNbnCB1YEAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I5DAFZFN6p70TH9exBFyUyGnugFGrdRmiai7oVAOP8=;
 b=PnYFe+6ooXo6+nYyPR12DdKpQ92E/SYWQKJO07EqefqKOGQ1sthTWoG/v0XYm4dcAbYB6wIzYy7qd8tDYVYP/9K+052p/zWxOTGQ+Q0200c3F+g1vp/Ib5kBF59XWw5W4OSTPhlNnECQGkYH5yjn9KNAFEo8gUdH94IdGvb6SJ2S7k2kC878AYDLBWgIEAJ+rx7eMvg4Boh3QzugcPApjG4EfU5XkCSuyy30OyKkekSiK+xcp/XXMrtDgydm1PjHAJc1vVu7kvHlmVe3jp1pV+0dw73MSBRjEHhesReiWpaSHhZWM+TuX5JulTl/URr+LgMCldh2XBsn4UAW78nAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I5DAFZFN6p70TH9exBFyUyGnugFGrdRmiai7oVAOP8=;
 b=GGBERoWfi8J+B0xcC1zR2laIqaWXJvdJ3y68mXpxauhIkafMn8xtuL8YZTRi7lX6pqm+M9O2RWnRxLX7W2gIEs7osgLwBggj8TBLw1MVFvQU43xx/ji2JrdMTApzgbQd65q60wRbYR6M9o78zN4ZBnGjtU/Zq6pp/vuVJCz3CDw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:37 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:37 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/89] drm/amdgpu: support nbio_7_2_1 for yellow carp
Date: Wed,  2 Jun 2021 12:47:53 -0400
Message-Id: <20210602164908.2848791-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9420b8f-7467-4ab5-5b46-08d925e66883
X-MS-TrafficTypeDiagnostic: MN2PR12MB4077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB407798264AC3300786291950F73D9@MN2PR12MB4077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33G39BY/3Eg0QbnJVjgJ13l4jMLBUgv1I6RWXKvB+1ETzHPmI7Z2gY03fzp77lTJex4XZ7t4O82WV7XGRCoHknBJRfImydKFIF5VKxKFFYfSTqW09kLgvOmcl8JReafQGrz6txYoQ1MyQvitgBqixSLjLZAj/G8uDARHBvWZ7sf6592gRvB0WYAepWegjCAO2GmmaEhWQY7C69kJN2Sw1XLFpik7ou6SgYYUub2UP0S6/qmQzvI2MhP8eeeawYYgk0b6DqFpPnf9kEQA8qAQwx2N2wMG2fQZRQ5hFZAXsDXrk0+ZRtV+ILbqyMN8SHUH6KVLjCqMz7sOjGyPQooTMknnSYsRHyiDTSygFXxLtSG7ALM36DI9IU6gmzrPuVWXWgfBk4VXpdtYULQjoKb3UsDKMVcY9EOQtbosPBqOda99n6UTXLoxF0UKYAQedEC+qF+RKGZ1q5l/zohDq7/jQ6BoZyxSP9UER8zgkDxI2XyIJGm4nSwTzx0IAmkeQkzMp/+du1MF1RrczQyVDVhBP1X49RaTYkjfOhWDc5uK7omZjuIqkGOdJQvOVSiGc+gO/j6s6s0mdzrCvTXnpN0SvWJt1xJp0Ki44eCOWwwd73rFdY2G22Jj9RPEhqzx+HCmtCso9iVPnow2xWcCAtz2aEEX+jzkSLWJDIOKf1W68juEL2tqkGzWj3fLBfvmLyA/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(8676002)(54906003)(4326008)(5660300002)(8936002)(6666004)(478600001)(316002)(83380400001)(16526019)(1076003)(6506007)(956004)(2616005)(52116002)(66946007)(26005)(66476007)(66556008)(2906002)(6916009)(38100700002)(38350700002)(36756003)(86362001)(6512007)(186003)(6486002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+LHIghDaD5cu8Hp93/tDNkDSNvzH+g5mFm/PW0K3O2bn9wt7RHN5RYZ1JzaQ?=
 =?us-ascii?Q?io0m7/aljmF3o+MuELNnfDREeLRTJGk236ICS9Khvp4Mtdgxc9/2QntFIwPN?=
 =?us-ascii?Q?AnI036atF0Cd2hPhDiA5EOEW2RDqkHBF79agSQVmqCbkFcYjMgTrsjBSpAmo?=
 =?us-ascii?Q?MHoCzDJjRkTZ2R2pQZ3A48/6DRPgrA/0shMaDH6lkMJY0inqa28Buq6VkW1D?=
 =?us-ascii?Q?mLZazEQFLmojT1nyGKnBsfYDpogoWha1UCHdodO/Mdky8ZpdFxbD5DGPOXr8?=
 =?us-ascii?Q?zE31TIledmcji3MkfMLg9OworTuVT7f5q/XaD6YBwBFwBdjzDNuiMehIuAiE?=
 =?us-ascii?Q?k4WbzJUMTsylg6E408Gsn8HXm76WW78NirxxW0BECHXwhJwZpBQvXMdvL+rL?=
 =?us-ascii?Q?3qw8euwmAhAHEC+cAayOsyZyOu42smolj7nnpeNhJ07XS8h01SCDrSVqpZEJ?=
 =?us-ascii?Q?dw3hO9mSFK87EMJVvIXaKGv+sMRTIF62XbQYMD/Uzzb//0kRkDZVTaWqMfNT?=
 =?us-ascii?Q?8+02uFeqvJAIM59zG5mh6YWRqCfNFJQYWQKQdW3aeOf1QFFXzc01OelcKOAg?=
 =?us-ascii?Q?jxJRTaLIA16Jzv9fWG3dTigO5CKtjHp3EuoldoFizdjQkX2DufL9J8tQ2pXQ?=
 =?us-ascii?Q?O0N2BmCvtcGlPQ2mmTD3vRXkEy2+wO2MBFqsT9ubxZ79Vu0dwL5WVDizTDzo?=
 =?us-ascii?Q?nZRvvgdt/mrg7jkflanWU17VzbtRypGwO9bHg6g8EJoCwppYfUZWxwKLROI9?=
 =?us-ascii?Q?AU5xT0LuynuyAT7iqQmRAizLUTa1+iYI1+K3RXE9vcbVpd8Kh7xl53JSrtVn?=
 =?us-ascii?Q?6V5pIlDxJcnyQZCCVOmMFMBdRczFBuUFIaMMndW8Ycq6fcrByI+s4sX8JA+1?=
 =?us-ascii?Q?eHxe46wuITlO71xajyGUKy6S9e87mNc4jVtkJUxUSqbi13i3ykaZ24pZ66lN?=
 =?us-ascii?Q?ARlNnUoJERGCBQzENx/sttaSfoUTa7BIlzsayfSVAZQrXQx892APHyZ3YhFC?=
 =?us-ascii?Q?o//ScXfxBMP0GwkXvmJCTVAcsx4RVOPPACPItO9MeRCFhnTfYlJUv68G4HKv?=
 =?us-ascii?Q?TysFf6D0ysRp+8RpwRU5W3rFw1p4vdXddiMq49yBllXOlJc6hkscdzfdZf+w?=
 =?us-ascii?Q?dyi8mQoYJG8wBrPO+uyXG+whZfJQ75uF4bGVYDXwcID8IIb2G61uMPKLyQmI?=
 =?us-ascii?Q?/Vw64bv/3qD9mfkuJ61gnAfr2KGZXFG6EFU8sNvA9luTlQ8b402mb7AryOsm?=
 =?us-ascii?Q?YtbcdkksYvtPJGAgN3RA+2NfNzOgUpruhSM4XRCxQaeMzjb7F/U2aGDImVtq?=
 =?us-ascii?Q?+KJk9IxGwodhkiUOYvIeilOq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9420b8f-7467-4ab5-5b46-08d925e66883
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:37.8130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ElBo50E+HT2/Rgt4ghVh4t9vozKnEz+T9WhynVtj3EoMzcFhDZGCddXNy7Z8jUxJlZWQzCArV+mRaJmLEqroZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

This patch adds nbio_7_2_1 support yellow carp.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 142 ++++++++++++++++++-------
 1 file changed, 104 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 598ce0e93627..8f2a315e7c73 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -28,6 +28,25 @@
 #include "nbio/nbio_7_2_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_YC				0x0015
+#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_YC_BASE_IDX		2
+#define regBIF_BX0_BIF_FB_EN_YC								0x0100
+#define regBIF_BX0_BIF_FB_EN_YC_BASE_IDX					2
+#define regBIF1_PCIE_MST_CTRL_3								0x4601c6
+#define regBIF1_PCIE_MST_CTRL_3_BASE_IDX					5
+#define BIF1_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_MODE__SHIFT \
+			0x1b
+#define BIF1_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV__SHIFT \
+			0x1c
+#define BIF1_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_MODE_MASK \
+			0x08000000L
+#define BIF1_PCIE_MST_CTRL_3__CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV_MASK \
+			0x30000000L
+#define regBIF1_PCIE_TX_POWER_CTRL_1						0x460187
+#define regBIF1_PCIE_TX_POWER_CTRL_1_BASE_IDX				5
+#define BIF1_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK		0x00000001L
+#define BIF1_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK	0x00000008L
+
 static void nbio_v7_2_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -38,7 +57,12 @@ static void nbio_v7_2_remap_hdp_registers(struct amdgpu_device *adev)
 
 static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
 {
-	u32 tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+	u32 tmp;
+
+	if (adev->asic_type == CHIP_YELLOW_CARP)
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_YC);
+	else
+		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
@@ -49,11 +73,19 @@ static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
 static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
 {
 	if (enable)
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
-			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
-			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+		if (adev->asic_type == CHIP_YELLOW_CARP)
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC,
+				BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+				BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+		else
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+				BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+				BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
 	else
-		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+		if (adev->asic_type == CHIP_YELLOW_CARP)
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN_YC, 0);
+		else
+			WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
 }
 
 static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)
@@ -92,13 +124,13 @@ static void nbio_v7_2_vcn_doorbell_range(struct amdgpu_device *adev, bool use_do
 
 	if (use_doorbell) {
 		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC0_BIF_VCN0_DOORBELL_RANGE, OFFSET,
-					       doorbell_index);
+							GDC0_BIF_VCN0_DOORBELL_RANGE, OFFSET,
+							doorbell_index);
 		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 8);
+							GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 8);
 	} else {
 		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 0);
+							GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 0);
 	}
 
 	WREG32_PCIE_PORT(reg, doorbell_range);
@@ -123,22 +155,22 @@ static void nbio_v7_2_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 
 	if (enable) {
 		tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
-				    DOORBELL_SELFRING_GPA_APER_EN, 1) |
-		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
-				    DOORBELL_SELFRING_GPA_APER_MODE, 1) |
-		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
-				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+				DOORBELL_SELFRING_GPA_APER_EN, 1) |
+			REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+			REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0,
-			     regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			lower_32_bits(adev->doorbell.base));
 		WREG32_SOC15(NBIO, 0,
-			     regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			upper_32_bits(adev->doorbell.base));
 	}
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
-		     tmp);
+		tmp);
 }
 
 
@@ -218,19 +250,42 @@ static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev
 {
 	uint32_t def, data;
 
-	def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
-	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS)) {
-		data |= (PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
-			 PCIE_CNTL2__MST_MEM_LS_EN_MASK |
-			 PCIE_CNTL2__REPLAY_MEM_LS_EN_MASK);
+	if (adev->asic_type == CHIP_YELLOW_CARP) {
+		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+			data |= PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+		else
+			data &= ~PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+
+		if (def != data)
+			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
+
+		data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_TX_POWER_CTRL_1));
+		def = data;
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+			data |= (BIF1_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
+				BIF1_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
+		else
+			data &= ~(BIF1_PCIE_TX_POWER_CTRL_1__MST_MEM_LS_EN_MASK |
+				BIF1_PCIE_TX_POWER_CTRL_1__REPLAY_MEM_LS_EN_MASK);
+
+		if (def != data)
+			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_TX_POWER_CTRL_1),
+				data);
 	} else {
-		data &= ~(PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
-			  PCIE_CNTL2__MST_MEM_LS_EN_MASK |
-			  PCIE_CNTL2__REPLAY_MEM_LS_EN_MASK);
+		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
+		if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS))
+			data |= (PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
+				 PCIE_CNTL2__MST_MEM_LS_EN_MASK |
+				 PCIE_CNTL2__REPLAY_MEM_LS_EN_MASK);
+		else
+			data &= ~(PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
+				  PCIE_CNTL2__MST_MEM_LS_EN_MASK |
+				  PCIE_CNTL2__REPLAY_MEM_LS_EN_MASK);
+
+		if (def != data)
+			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
 	}
-
-	if (def != data)
-		WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
 }
 
 static void nbio_v7_2_get_clockgating_state(struct amdgpu_device *adev,
@@ -297,14 +352,25 @@ const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg = {
 static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
 {
 	uint32_t def, data;
-
-	def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
-	data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL, CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
-	data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL, CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
-
-	if (def != data)
-		WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL),
-				 data);
+	if (adev->asic_type == CHIP_YELLOW_CARP) {
+		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3));
+		data = REG_SET_FIELD(data, BIF1_PCIE_MST_CTRL_3,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+		data = REG_SET_FIELD(data, BIF1_PCIE_MST_CTRL_3,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+
+		if (def != data)
+			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regBIF1_PCIE_MST_CTRL_3), data);
+	} else {
+		def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
+		data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+		data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL,
+			CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+
+		if (def != data)
+			WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL), data);
+	}
 }
 
 const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
