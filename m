Return-Path: <SRS0=U106=CU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C849C43461
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41D4422207
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2020 16:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0KiV2wrq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41D4422207
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12E136E069;
	Fri, 11 Sep 2020 16:27:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1265E6E069
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2020 16:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Anfld3jJTuLuyeYzY4Ue0Ms/fXd28zy9lBHcwOcEuLV1aFKHEL0dEJNTjDtj+WBGmgm3qj5KhX/IGq+e2JYADPdZwMmivceA6fOZtmxsw9Oes6uYmxniFroODBMc1xpAJe3N2cSN92rQCFxaNRAv1PAvimeRuw571kyvHkfwKMD/Ecj+Ra3xF86pVUlzr+alPVNnahbA59jgjkv7KWrjRJ/b5zYMMpaaabz/xOGv99D2yyyHHXUThDZYMHT4w3MTxaLWJTR6M1gh5TvK25W4Ffd+vik73DMtSqgxyxtM1sBGArLRrWTL2TOM0ARAkyE0Ur+nome945NPMDLUtIPF9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xnb6WhpLjiW9PVw/TdcpsKXAvZN9mk5p52L0tJB9hQ=;
 b=a/BQT3HYhQGufKJISkcn254OvgfYdt36qKTh27mG9Ny59kwIyEGggU2QgE+ehpsOw4KauxKqTYwLpzJuNg9f+7HDDRWzFj6tI8wfiz10ekxrgOUPQBCiZpPWoTu7+Lg6WTbmq0wYimrMJcFZ9xyMoyzWwc95hkgcnQ5xiEHFhAsVCoiFYRMeRji/Dokb+VF2zjiBoFRhRl4qm0Lll8ClceM82IxfEiUhF4t0zoDuBPuY998I+T8wTTJWx1ZCRZAZc5ofXXXTqi+Ed8Di0yQ+KIjw8kWlSiP92hNWGFrLEIXst3PtAj+xpGexh1JngBV2+zkk9FvnK6DucVKv2jFv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xnb6WhpLjiW9PVw/TdcpsKXAvZN9mk5p52L0tJB9hQ=;
 b=0KiV2wrqZyzXIejp4Llt4V7LTr6yDUfCAqX1AHcP0s64nOhTEPrzy9KdCm0adTJzDWqlFfVtBxxoSIek/H7vD9Q/5ZrPAiIfHJgpvTdUDnTbrYHiUa/Zxmp7sODtaN60YUXuz1lIixSNhvJk0QuBNLD/0wqsFL1TP15Yc7vIU6c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN6PR12MB1699.namprd12.prod.outlook.com (2603:10b6:404:ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 16:27:55 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::91c5:f91a:ee0e:1bfd%3]) with mapi id 15.20.3370.017; Fri, 11 Sep 2020
 16:27:55 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Enable SDMA utilization for Arcturus
Date: Fri, 11 Sep 2020 12:27:11 -0400
Message-Id: <20200911162711.10645-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::20) To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.15 via Frontend Transport; Fri, 11 Sep 2020 16:27:55 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 469e1035-9755-4474-4993-08d8566fa353
X-MS-TrafficTypeDiagnostic: BN6PR12MB1699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB169955F7D83C4D0BCD8F2AD3EE240@BN6PR12MB1699.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sq/mvdnmFqtu6lG3RJjDsrenN8oEPTPtB9qCN/UtVluzRQpKXi3FOaMrrUCMOLSlYNtNl9DFc3o9r11BQYBsyNr1V/UhLX4lmVvsQCKp8dwg3+ZQvZk2TYsddGEOfvPVVF/trNFFio2tY7HF5+M6ONeUx0QX9VdpQjqhIZHZ8f43DnFlofUtJyThVPLyxgJAnZxuaxb2XAnU/hB0BoGGSwdbAJO7gTMHZnu4YqS6aCPJ7YlxsiRY7px0TyAhI37vLlPnD9gBy2HqnNf/dLMdkCJCTeohkJzogvrT/TEemtU6rDzRK0GRsJTGH1OEFaZ/MaR4o7bAXLFtA7ck1RB3cw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(6486002)(6916009)(7696005)(52116002)(316002)(26005)(5660300002)(36756003)(4744005)(16526019)(1076003)(186003)(956004)(2906002)(2616005)(478600001)(44832011)(86362001)(6666004)(66556008)(66476007)(8676002)(8936002)(66946007)(83380400001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YA1ZUslMG2WWrpL9hCQErtl3dbQbvIbES5OtkXspk8P5eX0+9AyWbZYbJcwmQDak1j9e607CNuWk8q350+foSZT0dRASQlAmBqmRsWa3TSR56e2kdelCFm79P5snAv94xCo5PthdvMCmVQoZ818U4iur77MLw2WO4TFDrfs+MbZI/en9PQ1nurL3PRcxUJKugL4tgAf73iVSayfau9Vly8wxLD49MzX++cv/C1NHPK7Xro+fWXliVPWPvQJ2xCBNZsdI/c/5T8mgmAYsjBdyP2w03NPBYCr7QZJBggsBCZqO3Yf1yPvA64RK4XBjDUKdu1j51lbtX9qaHVGh8Os6VD9xzcw5+my0f60xUzD7vOcEyZQ8oEVmV7Unncwekb+nOO5cOfkKnd5TIjY4iVjbXHo/WNmTfbMBJ1A+IaUlopM1fjq7W80IRi/PaM0RCrHvTVDr0RgeOm0v59nvv/2FlhGQwZjg8BFEgYgps71mD55o1KSQ/dLn3LmplhFWOJ1qHrYrD9XSMLh/sTZ+mn8gibaRmBhJ3DGALfuGw8huhSThTB/yXMjyjj1VBIop81ZxKXCxO/4fBg3GCXve97Jteg/LNgxmC20r+aslxSXCJbitATNiLmEp6z9/CKd7U2fDeiTO+h/KJ5W9stcj4JzJEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469e1035-9755-4474-4993-08d8566fa353
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 16:27:55.6247 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w99kk21r5iNyEUGh2QvIqphQf1rQNLB4K+8VJw9Er1heGf58xSYMu8G5/JklffyUCVJFgu1w8f+bFGAcgxwt+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1699
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SDMA utilization calculations are enabled/disabled by
writing to SDMAx_PUB_DUMMY_REG2 register. Currently,
enable this only for Arcturus.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 856c50386c86..c764c27ba86d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1063,6 +1063,16 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			WREG32_SDMA(i, mmSDMA0_PHASE2_QUANTUM, phase_quantum);
 		}
 		WREG32_SDMA(i, mmSDMA0_CNTL, f32_cntl);
+
+		/*
+		 * Enable SDMA utilization. Its only supported on
+		 * Arcturus for the moment and firmware version 14
+		 * and above.
+		 */
+		if ((adev->asic_type == CHIP_ARCTURUS) &&
+			(adev->sdma.instance[i].fw_version > 13)) {
+			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
+		}
 	}
 
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
