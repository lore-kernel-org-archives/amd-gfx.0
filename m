Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED23DC2D0DB
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF93E217F4
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZWJo9USy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF93E217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BD386EDA1;
	Tue, 21 Jan 2020 16:19:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E556EDA2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 16:19:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGq4d/0LcHwz6YRfSpZP4uF6TU/pT9TrukNyDeWLZunhG3xp95gv+FfB6StHYsKJyQK5en4Jvhs22dbFdnu63PRs6F31H6jvy0aytrsAA51VjN57Mb3wMjg5DVoIKAS3TMuaD0Tz5CL3B4AgDZd1LT+F/79ASPIqho1pmRnHzsaU2ILJNi9fX+zusN5C6UxhmkHc8D1f/FjHApLhlkZUpfMmlJAnGhTs+BlT2qKp8LIrr4qjObIgjlb0wwUIdNqzWeLgdfRtT2hJPpojMYsblDOKf3X4r/u6oDECsEbrXpqOdQa4ZPQVn/8js43ds/Z1mXEgWCX+//P/B22Z3GvS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRdyhyq+yWsoAKFtAkETdCh122agQpIL05oAOKgkrhU=;
 b=jvi2lZ+phAD3Kb4yE+01NIrqa2UcziW3VUjHyuPOMh63zaeIr6XFcDCFZYEA+045LgKRrgIumUzTyxWWkJwNeSbjwrcIjd3aXPalKdyAqx23H2Wo2Kyk7uDRQHMdDCzGe2Gv4wxKYL7GiYShQYaWSL7LaqlaoDC5uUbpcXFs7+mUOTlNqcKlnFQyKGpqTZDU3KaqLNOZxvGbOAwVYRISGCPqzgHNWcOTYyICTnwUOlzLpMLDjHwZGIJm1Jnw1Qo+rQzzannPU9Vb2mvmi7y2l0is0N4umKdmBT9l1kVo/sG2dV990cqEvI3n64HfYK5Dvbvs8truN7vvFb8dpskGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRdyhyq+yWsoAKFtAkETdCh122agQpIL05oAOKgkrhU=;
 b=ZWJo9USyqKzLiQKMFN1khgLfxY80x0cQrIpwCptr9velZmYcsDjKvqFi7f5baG32L/A2pkOVNAGaEPH1ya2DVzYVmrau3EQH+S7FMg4ej246cecOuOqboXpjW+WObIoimz8AyUhnRCeVoLvZ3ctdJ91hJRp2S5/CP/qSMckCs/A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2696.namprd12.prod.outlook.com (20.177.124.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.26; Tue, 21 Jan 2020 16:19:30 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 16:19:30 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu/vcn: use inst_idx relacing inst
Date: Tue, 21 Jan 2020 11:19:16 -0500
Message-Id: <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 16:19:29 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 012ecd52-fff3-4645-2730-08d79e8db15f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2696:|BYAPR12MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2696316E636E454EFD388131E40D0@BYAPR12MB2696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(6916009)(36756003)(86362001)(81156014)(8936002)(2906002)(81166006)(8676002)(498600001)(52116002)(6666004)(7696005)(26005)(186003)(4326008)(16526019)(66556008)(6486002)(66476007)(5660300002)(66946007)(956004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2696;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUL2Yz+P/nFQdUZgX5VoNlqj3M07ePMTNZMczRRlyEa5VJ5pQI+0j8IQ8N8VRqAFfBqfNHZmmk0uTvdX4QITodYNzSNVfXC1c6gwHAwPuxr0SDjJlsLAnwdQWo7M4qwJ9d/TXSCjcZ7uj6iGIR+Oi9zFu5PIfxcvrQlDx0zp8ba8USA7jW9arPTKp3YiJAO3s7eCYbjF2z7NPkSOafL62QJ38xQIxdUmRah4Nw3zoZRUtnWNsARQUaWkcbSa9VydA/B2UiysBHsRLnB5/O1Lcffwkvxf3+wDP5ByD8ABJy/NxVEDw8RWmTBKfjbZk7iRaRFVpq5osdctVbpvu2414DC88LBNV6gybqKtkz8TwendLIXn8JsObRBC5+CBmcKlOAoPQVw/+X5XXx0qP7OQqJV5vDCMMzyBETFYgPyXDfrVRsSDOfkyLSzAs59vWoQ1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 012ecd52-fff3-4645-2730-08d79e8db15f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 16:19:30.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cyEWKSVJ9po/KGIuBQHhNz9bio1mrg1kB89GTjoBPWMK5ePN0HZ7GQvZtK1ihvzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2696
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

Use inst_idx relacing inst in SOC15_DPG_MODE macro

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 60fe3c4..98c1893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -65,23 +65,23 @@
 /* 1 second timeout */
 #define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
-#define RREG32_SOC15_DPG_MODE(ip, inst, reg, mask, sram_sel) 				\
-	({	WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_MASK, mask); 			\
-		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_CTL, 				\
+#define RREG32_SOC15_DPG_MODE(ip, inst_idx, reg, mask, sram_sel) 			\
+	({	WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_MASK, mask); 			\
+		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_CTL, 				\
 			UVD_DPG_LMA_CTL__MASK_EN_MASK | 				\
-			((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) 	\
+			((adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg) 	\
 			<< UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT) | 			\
 			(sram_sel << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT)); 		\
-		RREG32_SOC15(ip, inst, mmUVD_DPG_LMA_DATA); 				\
+		RREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_DATA); 			\
 	})
 
-#define WREG32_SOC15_DPG_MODE(ip, inst, reg, value, mask, sram_sel) 			\
+#define WREG32_SOC15_DPG_MODE(ip, inst_idx, reg, value, mask, sram_sel) 		\
 	do { 										\
-		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_DATA, value); 			\
-		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_MASK, mask); 			\
-		WREG32_SOC15(ip, inst, mmUVD_DPG_LMA_CTL, 				\
+		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_DATA, value); 			\
+		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_MASK, mask); 			\
+		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_CTL, 				\
 			UVD_DPG_LMA_CTL__READ_WRITE_MASK | 				\
-			((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg) 	\
+			((adev->reg_offset[ip##_HWIP][inst_idx][reg##_BASE_IDX] + reg) 	\
 			<< UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT) | 			\
 			(sram_sel << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT)); 		\
 	} while (0)
@@ -111,7 +111,7 @@
 
 #define RREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, mask_en) 					\
 	({											\
-		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
+		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 					\
 			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
 			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
 			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
