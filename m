Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A03C6FA8E
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Mar 2023 17:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83D3810E27B;
	Thu,  2 Mar 2023 17:04:33 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B504E10E27B
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Mar 2023 17:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADWTHlBis+mUFelUoARAQA0C9ZfkOscyvRknf1d+5NA0ydsQ+TESP/TGpuT9NPgNRNkyPP+bXutPc/a5lnWXYXDj5CvZMSSb6+w8F4uKInZaRsULsFbbs6y4DQs413DfoKAXzOPMhGx/Cler0deFIGP/iQnFZRiDHnqW2D/Z/J9EDsGHe7yI7Y7tdBfoUbmIK2yg2tWH9rN8C9kUkLLD/VK8ij5fkCTHsN57B13J6V+mhnMa9YCNhwib//88Ab9+HoaYP3YkczM92oXQzX4XNa1EHMZ39ke7AUG4ejyuskklzderjQEpFi+BRwAaQfAD5RJNfSg/uQpo2mFxpbOIWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae9InGLqDkRdqUERXlP8B4cCe2vOKUiuDiHpt8Izw88=;
 b=inX7HIwwKt+SebKSgrw9++hIQOqNVDwVHovFRfeAXt/CYMkP0zOJMC5Chq1uu/Z4p9Xiq1WJyZuOaCea7SFK4qXjf3e1nBrXy4qYWEifJ5gKBTxrOJJvjF8DFMyEa91oroV8Tg15MOgOFaDg6NNAVqIjG9PRWMdWURDbiHWD/7sEQgnOMBX8adWu+3hFlX8wpbGdBJlSM2iz+VbkABKBbTKT86K9ZnPanN4nQvbUIkAgb2n1/+kHfTTeP2cPMzwcyq6p2twtSrsImis6Ogjtbv7KeOYZeTiY/llRnYm1fCRbyYtR3R/YWafHCDkENqzpfuX88vD3MOxvWYk0fok8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae9InGLqDkRdqUERXlP8B4cCe2vOKUiuDiHpt8Izw88=;
 b=zu3fBHi+g7SCXQ/in17q8fSC5z5raBNL1dYDHBbLzgPJAHXQUvGe8BFCJt8Kh4Jqsjwl4Sksv7fWs8ZCZZtKqP3ZxEgzd6XpEo4VspfzhsM8DBGmYqeTaiJrpNWZVGFbRzExHSUU7VxSIfU7mPpYqKX4lTqLRn/6fHCIai1p/ZQ=
Received: from MW4P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::30)
 by PH0PR12MB5484.namprd12.prod.outlook.com (2603:10b6:510:eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 17:04:28 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::db) by MW4P220CA0025.outlook.office365.com
 (2603:10b6:303:115::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19 via Frontend
 Transport; Thu, 2 Mar 2023 17:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.20 via Frontend Transport; Thu, 2 Mar 2023 17:04:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Mar
 2023 11:04:23 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu: init sos microcode for psp v13_0_6
Date: Thu, 2 Mar 2023 12:03:59 -0500
Message-ID: <20230302170401.20386-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302170401.20386-1-alexander.deucher@amd.com>
References: <20230302170401.20386-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT054:EE_|PH0PR12MB5484:EE_
X-MS-Office365-Filtering-Correlation-Id: f7616dd0-8cd5-44ba-3294-08db1b402eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nxVMuUjtALkFZavbfVrPKPzVn6FcGPNLoQwHYCKsGAIKlxp93dGhNSNdDe/6ERhXn0aW80xSCEodwH444JDVHlxZTe8j42rxyuqRP6bvVy3Z+MUrO264oEiwxr+FMToJ47tEJIPvUC0GE48FkzZbZIiuAK7JbjFxp++mBMec0uOXwPLd+lsz7VNht4uistvCx/Kl8lpLwpsSXOzy5S4jTJKBGDduUB3YDsK9x1Q0SREMZ8kncoDgQkmWBPJaERB73sirwBC87UxiC0NB3guTG+7AZehzxr8N5Ov3riURBLkHBI2B6dGOn0SeyOcgeUSusQiqUYZZWFg7FRq+ZuoxM66gpHEMoigOHgCzM9fG7rsyuqsJTifHb6ODxaLVnMnVoK+KbhHI89XJ2zOMeS/CVgGu8wFInrKLXZJeXT6s6yc7ko3HOES5371RTOfe4rzt/jK3wn53zIrNg0Djwv/WSoKEMmR4O6ma5tENMQFHS/8EEKdBOPRrVCrg6s3PgOzuWuCOc0/knJNSIm4Lp/Cb2HJfoDHi6hBfZGzhnHzyj0z0jraBQ3ibv7FH2KYnwJbb4iecEk4zU3rDQqCI2xd8ZqFeEHko0M9bk+1Vaio6V6Fn+vToNJxxDN4BMOECx8UtkDTYXuMRdxvSwJFl1l5upqBeymp+eq/gMUQ83u9+rJldbdoBOKfNcc+dTbgxc9LEPj35z+N64vliC7pRAEgXK7bq+p+ozFrpylctLQE7RJg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(83380400001)(36860700001)(47076005)(426003)(6666004)(36756003)(40460700003)(8936002)(478600001)(5660300002)(82740400003)(81166007)(356005)(86362001)(40480700001)(82310400005)(2616005)(186003)(16526019)(336012)(26005)(1076003)(70206006)(8676002)(7696005)(2906002)(70586007)(6916009)(4326008)(316002)(41300700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 17:04:28.0739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7616dd0-8cd5-44ba-3294-08db1b402eec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5484
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

parse psp_v13_0_6_sos.bin and initialze various
psp ucode arraies respectively

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index d62fcc77af95..ceded7eb9771 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -48,6 +48,7 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_10_sos.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_10_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_11_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_6_sos.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -87,6 +88,11 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 				return err;
 		}
 		break;
+	case IP_VERSION(13, 0, 6):
+		err = psp_init_sos_microcode(psp, ucode_prefix);
+		if (err)
+			return err;
+		break;
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
-- 
2.39.2

