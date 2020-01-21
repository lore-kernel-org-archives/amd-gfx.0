Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7E1C33CAF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 21:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4DC921734
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 21:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XQ9j8kZi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DC921734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A506E29A;
	Tue, 21 Jan 2020 21:39:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F5C6E297
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 21:39:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FW0pgonS3RQsXhswyE+eXxVEdeiWR7NVgHjsJBsUcXbrLNtRJmx8V2zu+H9gf6YQt64YjuMYqzT454TPzLmbk49i6bgX07BtBWatdiVb/aN3IjH+9f6Zaq7FePzE6a/l+fl6ELpn9GCdIodLiH7uz0CqIsW/U37q6mtfWSOjsrrRJuNYn2KZe26ONV5WIv8yTzusWNGXFWTtDbQAPV4fzBGObfi95Mds7rXqyjpV3sQNuOHgfMgov4qppFaol4UoZsyTqmUB4Ahww4FZwCY4GApm05BvE0XQ15+FC+bUBRv5d3cCQBcQbexk4Y8xdA1cmStpoT2IYvuJ5i0SnxDisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siUIIL4XFBp5XWRHAwMktcOql5H4uHQyB8hN8mr2rVY=;
 b=bNDIYh/+U12NcsKyIptJwjjBZDM16vZ0te2RzCgmnpZMNgy4vyO7+GHXO5bedX/64iL1Nhu1pgqwAjS53xgn4jTNrB8csS/tZNNdrhwnjrihsMN9tseXpXeXBpIJgT2rurnXUkAxP5mHeD81OCIisJaSCgLpNhfhjNTsZFSlvMDrFJmi7CKTICZnoq9Vmg+0juVt+819R0IRZ6NeEp66W6DA99fCXRlWNbDedf3MxsnuJEJMjbM23eBKWX8yv9SPHtBuJd0Xd7aaw/OKJkAn8Eh/1lv1wtfKV7QrltS5oBlZovPbiE/DYNCJCJD1Ovu9Ot1XhO5tqiQePXMuT3r8nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siUIIL4XFBp5XWRHAwMktcOql5H4uHQyB8hN8mr2rVY=;
 b=XQ9j8kZigQIbVSKMMxTopRiU+/0DmyhNR1YUjffCF9xSI16dxBcfNsdSJ/IZFvSqCfww3Po6d4sXqhuq6wIdbH2t1rMB9ZhooVTg8W9FOMVV36uj5881gjQK9MTZL2oTaZq0fajRGN/qbxmIwAY4mQUYHhGkm05bNilQ37kWpEo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3094.namprd12.prod.outlook.com (20.178.54.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.21; Tue, 21 Jan 2020 21:39:39 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 21:39:39 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 5/5] drm/amdgpu/vcn: use inst_idx relacing inst
Date: Tue, 21 Jan 2020 16:39:31 -0500
Message-Id: <1579642771-8907-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579642771-8907-1-git-send-email-James.Zhu@amd.com>
References: <1579623556-30941-4-git-send-email-James.Zhu@amd.com>
 <1579642771-8907-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::37) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 21:39:38 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 03d08891-e1b6-4ecc-29eb-08d79eba6ae0
X-MS-TrafficTypeDiagnostic: BYAPR12MB3094:|BYAPR12MB3094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB30947420A4D0BDD3CAFDE743E40D0@BYAPR12MB3094.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(52116002)(7696005)(5660300002)(36756003)(86362001)(4326008)(316002)(66556008)(66476007)(6666004)(26005)(6486002)(478600001)(81156014)(81166006)(66946007)(8936002)(8676002)(186003)(16526019)(2616005)(2906002)(6916009)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3094;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bnaWLzpGkiOJq4bcyOYiishUy9lSepTdFAG7icUVdVpCsS3UdTb1aY1zjUEbUYY+XxUXbYeieZxJXBtfsqwQ3ptAbhnwf4I3tvLKnkh203JChUFR1c+Rt+Qdobzu2ubT003uCwU689YmAyCDUcYWd09aG2FWmc35BIGMnujKfkoPJ3wHT2cfLZG1JwDQQ1qMucSbxdzafPfq28ZMDiz/FYBXuJbBkZ/GYQpDvuq9isdk9QL4GzFIxGZ8kbc7PU0kRyA/YYO8EiQTZSoVP4Xb0N3f96xnKxSO5k7H2UQ3Qg/GGa0n0cGpCMCXqTd7uQeRO7SXypDx/UwWowkdD1Me52gy4yjXfHO1DjnVPemk3CAID9lH9xGVpZQOced52dNB43TxdOCe5MVg7QE51GdRraw3urGW1RH226BKzVgEErEuFfOVyjWk2B/YdrPQsOev
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d08891-e1b6-4ecc-29eb-08d79eba6ae0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 21:39:39.2584 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQ9kiCXBIV7KMHLxfAHRBbVK3di3jlGL2y6vTK/gO44QgeoDaOrue2cc/oK7iAD6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3094
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

Use inst_idx relacing inst in SOC15_DPG_MODE macro to avoid confusion.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index ff4f4f7..98c1893 100644
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
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
