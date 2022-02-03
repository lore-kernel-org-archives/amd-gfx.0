Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF962C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Feb 2022 18:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95C2D10E6F7;
	Thu,  3 Feb 2022 18:59:11 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DF6010E1AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Feb 2022 18:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6yLpBi4qeLUpOtf/JIhwBPlmlTGV1U62q2k9MHtwYZT3fl3Z5ZVHOJkvpCu20mvUhTE2vzMrtt7yrYHpdjygA+Zyce32JRW+Tlj2eUjjZWxkf8C1U3m83xdVuIV8dQEw3Bc8x7IjaMdQVvmguP17P95tEgP4mpYhyKP/IWn7YcpUhgXtCCqv2tEstJdtr5M+qjHb1EmiMG5O57fbP/df81VLgSMkfi1OfIdsARhZTUIiMCgfGOkUOV95ZYyS8/y+wnQPTj/ntLyk6fU124fUUU8N2IOtVBUYO/sty/4whAAnThNLYT/P+bJRM5uYG04NeHmJw+itzVtIAa5bkCdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvAg4HQhdErkTd/5ChsUrW7n/To5cErMfnoz7Cn428o=;
 b=CgVfOY/gT7WPPmueFaJakAxiB58g7cIWxL078Sy1xbACvjx8smJHIGm7Nd4VU9DOqRQ7Qty7aqnBYlK181wr3q+AmnYEaE7N4U2K0Ns5Ic6gdvlG5URzVp5ugTnAbmsUljtdyc6+vvR/+OKgP1+2c/Nq+p9xbsK3OVwSGT0U0X290AErr/36U8yDQaM2jdyYSwcmNAdu2X8Ffsjd7/RglhFZtpxtG6QdEoZLvOMO9jx6IJJcZeRxK/rPC5RX3kZYswRsedkIJmcX8xcxiFmkJwwlIRNGqEHcYdh0dZnTYTTxhE94yntHCfszTS6hBpxMixwB33HRppVv3kkkLmV3LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvAg4HQhdErkTd/5ChsUrW7n/To5cErMfnoz7Cn428o=;
 b=fdPsdXEu53aQYwIW5jGGM5J3X7Y7tUFzb4HzoFPqW6dKUx1C9ReDgp0VgcBDSM20MjT1kwQn+yFRMfvZJxhanQE84CQrn+BAOFRvkNzJQlwaq4ufyNGffC9abxwRrDlhM07i861f5BD1SvcSsBvE7N9FemWX5Aw03A1860zYgdY=
Received: from MW4PR04CA0258.namprd04.prod.outlook.com (2603:10b6:303:88::23)
 by DM5PR12MB1307.namprd12.prod.outlook.com (2603:10b6:3:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 18:59:07 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::8e) by MW4PR04CA0258.outlook.office365.com
 (2603:10b6:303:88::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Thu, 3 Feb 2022 18:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 18:59:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 12:59:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: move dpcs_3_0_3 headers from dcn to dpcs
Date: Thu, 3 Feb 2022 13:58:47 -0500
Message-ID: <20220203185847.1473998-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203185847.1473998-1-alexander.deucher@amd.com>
References: <20220203185847.1473998-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11be2bc8-46f1-4982-b69c-08d9e7474175
X-MS-TrafficTypeDiagnostic: DM5PR12MB1307:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1307D244BF12DDB9E5EFA1FDF7289@DM5PR12MB1307.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:497;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YpJlprpI3mp3hgq/OIZVHLrEcUkQJEB64gWocvFm82rmQCqKot+V0/YAo0XaxcqGgPuJm7QtYCZtwDA/ViEtH8pgYtCnCbt/nLhdgAe0xWefYLZqyNbn7t75VqtzGO4HPnwbC+vOJlgJUt2qHGwm+RbLaMf1khgJqZEb5LrBTLbBoiYHQBMPpSF+VGOJ0OWW3B+3M1/4Q4eyVqZ4nn82aFFcgSPjNlQ5BPekvbtLrsbYTfGbzoaLaS0GTBB4U/ryKKmTOO7yi3JVJBrXg7Dmf5fQxDB0BL0xZ2gR/nGP/24YDNzaNIXp22cMj7y8PihmGyrFY1adumf7kRZEhbHLntZOhUXPn62SVZgsrrp4aGAAvnXPWVcBDzukuFlGy/RD/ayGBaH9edvzPHj2uf4bEW1i7xt2ICp1+e9cMrxDQ2tP2x2WrTrCFIdJSJD9/BHUQHSrenXFf17byb8H+7YWnWNjZ23zQgODzAJhhYhDpgrELzqnyCWM05UfJHowE8RJ6AL7ZhrrbHZLHlR8g7WT2vFwmtJrUr3qMwYb4gwkaelyrZEel+4wgz+1crUd7OEFqC+VNnts83kuk0CtB2IbwkQJs3PllI2oa+BJOUBOxZ6k8Jyxf2u//uWMp+6npMKqGuQaS/xkkLramTA3e+DS2iY8KdpTrSFHdhu6dZEFPt1+vc6QcpvlMylcUBCHniDh8NENjDJ6WvK0e3Unk21E/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(8676002)(82310400004)(186003)(4326008)(356005)(8936002)(70206006)(2906002)(70586007)(336012)(2616005)(6666004)(7696005)(426003)(1076003)(83380400001)(16526019)(81166007)(508600001)(36860700001)(6916009)(316002)(47076005)(36756003)(5660300002)(40460700003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 18:59:07.4688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11be2bc8-46f1-4982-b69c-08d9e7474175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1307
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To align with other headers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c       | 4 ++--
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h    | 0
 .../amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_offset.h (100%)
 rename drivers/gpu/drm/amd/include/asic_reg/{dcn => dpcs}/dpcs_3_0_3_sh_mask.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 2de687f64cf6..36649716e991 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -48,8 +48,8 @@
 #include "sienna_cichlid_ip_offset.h"
 #include "dcn/dcn_3_0_3_offset.h"
 #include "dcn/dcn_3_0_3_sh_mask.h"
-#include "dcn/dpcs_3_0_3_offset.h"
-#include "dcn/dpcs_3_0_3_sh_mask.h"
+#include "dpcs/dpcs_3_0_3_offset.h"
+#include "dpcs/dpcs_3_0_3_sh_mask.h"
 #include "nbio/nbio_2_3_offset.h"
 
 #define DC_LOGGER_INIT(logger)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_offset.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_offset.h
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
similarity index 100%
rename from drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_3_sh_mask.h
rename to drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_3_0_3_sh_mask.h
-- 
2.34.1

