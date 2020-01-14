Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93305C33CB2
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71D1924673
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RaKQ1gEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D1924673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48AD6E440;
	Tue, 14 Jan 2020 17:58:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A937D6E43C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/+RWWEZqHbvNOht+z0UgJ6KRZf25mNTUI6iAV8D62IjODKiTrN2qca1DIADhpapt00TDY79hyfhzeHmyKpJDO+2Cr0vb8V9HPtiVurlD0AQMJxbu3Brcuv91Y+kXdd3NjR6D4ZBHjF1QwscvypOPlzV6AIXmGIuz8Bx9YZGvThP6H6rx0taybUVVGfM7cLOQ0f8y0Lq04H/4sO7L7Nc1K2QzeQkoo0cYAgDQCfzQmNN5xikeD+TZ0FwLv8NsSt3kuaJoU8tskqdsMsJPK/KBh/xim2h3hZmt7zR3Dk8BOWConT1lL0nbogrXlT1ZnmKOm40mamfw+4hxo188RO2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKLj6NDVPi6bWvFB0cO/x5/KeTUa21v1cXLgOCEOzuY=;
 b=U/Udp6Z6uQn+xoC3KAeVEP6kI9Bh5HRP8E7iUpLV3NzXhFCC3bZcA81h9xFx7kvoys+Sg8EVhrtwFaPlc62o1g2xUw4BXSL36ir6r13sBKx2u3Fr2WyxanfxKTmCcZpGGMMJ1g8CS2GvoSI9/F+SELZUit6dDW8/F4fcUm7x+/9sWFbC39xzT9n29UW+jxQs80Ezb6HRqd2JDUFSHxOeMfJZecBAymc3+nbODsIOc1H8HAs2aWFNi+DTHBpj3jFV35E1ZrC6FKR+RNMOqhgRyP3DBTQJisLrOqHTwPJO1bZDmKqcfRktLXlzeUQweplhFydmPnTwdGjVSEixG29NTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKLj6NDVPi6bWvFB0cO/x5/KeTUa21v1cXLgOCEOzuY=;
 b=RaKQ1gEmzlVNU4Hjuzw3crFgOoS+IzG6haZxOdwHmgIiXL+D6lpmaW7xCSanmXrZNL7Ixw0ZGzTEn8W4YEkRoC3s3otcFDCxQr17wdjthjUNOmZs09+5hTkx0SiSaP28psK1NR+uIJjEwtqkufAPEWMBVuUzayQJSiap3uTgVQ0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2677.namprd12.prod.outlook.com (20.176.255.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Tue, 14 Jan 2020 17:58:32 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 17:58:31 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdgpu/vcn2.5: add direct SRAM read and write
Date: Tue, 14 Jan 2020 12:58:18 -0500
Message-Id: <1579024702-27996-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 17:58:31 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a93aadbb-34ea-49f6-b036-08d7991b5e12
X-MS-TrafficTypeDiagnostic: BYAPR12MB2677:|BYAPR12MB2677:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB26775984079E4540D347BF75E4340@BYAPR12MB2677.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(136003)(39860400002)(346002)(366004)(396003)(199004)(189003)(6486002)(86362001)(81156014)(81166006)(4326008)(8676002)(316002)(5660300002)(8936002)(478600001)(2616005)(36756003)(66556008)(66946007)(66476007)(6666004)(2906002)(7696005)(52116002)(16526019)(186003)(26005)(6916009)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2677;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3HzogUNKfOhjfzhUstowT8ewTjWuOEtnoNlcYKJBRBL+l4L7LCnET2KlQ/bhoG5FHTRFI2w5cXEqQ+wmkDva6vfEtw0ymGDFx8033Qq5eGkQrLquZBsOv1YVRBWw6Rfwp5oUM94NBd5s9ENf1Uy0La3VbKplm+pAYqGP3CUQH16ch+EGjtZ15wbCSfFkemCQ9tz9vjaVNiN6Sit133aiQZYV7A0x47q07zms8AeuBEJmSztY5u5ZgQZVAvHaKqB9OH7nwSY5ofd7ZpJRp6kAsrEd6QYcQJ6h8kR5oUbtQclEa0HksZGMjs6VJdK4mIt2UKhhvLorp1ymQcu31OOD4byRtwRL+QG1J5YUCrJfgTV2TeWUggco2MaP+w6M/n0LjGwJCE/H3ZgqXB/pyHuIKKT4zG6uOhGi5CMY40H7T+7MyA7awE/aoruvcwzI08BB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93aadbb-34ea-49f6-b036-08d7991b5e12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 17:58:31.8853 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KP9rbJuzD3Q5boSRoR+6gAUVYnYG+ycWvI4LOCRf5ntVPR3T5Hv9bFWGDg8oH4Gv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2677
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

Add direct SRAM read and write MACRO for vcn2.5

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 26c6623..d3d75ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -127,6 +127,24 @@
 		} 										\
 	} while (0)
 
+#define RREG32_SOC15_DPG_MODE_2_5(inst_idx, offset, mask_en) 						\
+	({											\
+		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
+			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
+			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
+			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
+		RREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA);					\
+	})
+
+#define WREG32_SOC15_DPG_MODE_2_5(inst_idx, offset, value, mask_en, indirect)				\
+	do {											\
+		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA, value);			\
+		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 				\
+			(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |			\
+			 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |			\
+			 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));		\
+	} while (0)
+
 enum engine_status_constants {
 	UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON = 0x2AAAA0,
 	UVD_PGFSM_STATUS__UVDM_UVDU_PWR_ON_2_0 = 0xAAAA0,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
