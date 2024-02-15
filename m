Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A1EC48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 20:26:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CC8310E404;
	Thu, 15 Feb 2024 20:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dYli5o5I";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C0D10E05E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 20:26:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nN/jJvYlRYCd2RjnJ2lPCEJMVCccDaNJoXbd9I+ll8yCNYywtXj0p7VB8XqVps0D+ydkiOcqEbsRcLJ287uwGLdktila5nBge/eEKw2cR1Kz76Zeyv+VcZ+V8ujbL7ZenZDMM39fpsk8092cpmKBzU5Le4ZaU07/L7nqoOV+USgAGDozoAyYKwaWi30SP7AtGvot+ZnyYTK23OOzNZp9XiM6vrrj6Z1FaU2MnfeM1Rx5DVprY6/LfLZWPNktXu4U1O3v6cIH8gZBzzcnnHSM4YOzPP5p7DgGrC9FCm2ZrHdqFsTHUQ+gF+CsjFVhMcYPxkCzkVZClX1YMLjZIzY4wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAzEMb6iCyoIIXf82dO4wuWAjZbENcxWPmLYui8DMGQ=;
 b=Q+y+B03hUjiKoV5SJXA3vRm6HEmwTNERh55EN3qMkPXjr6DAw5PwzBW5STYmbfNG97T4zXjYx3pgKe4VWRtKJfT19yyY9HM0AbevZ7rQC25s4T6h7Lqt3aC7IAaRnFZY4mcLMBMsHPfLDmC7NbJnWlKuoOYmPtO9osONju5vS9G+ba5BzEH9i1J2IguMjMNAT7JRh4DJIaHEfBczhcDxomGml2YSTqf9T1ZPMgufw8+8sB3uKRXAhjURIvIkrg+H4izDffcSgEV56OZEJLbR9sZ5BDTLNYfwk+Ggx1YAmcILI0WJpNbh2/c2n6se+BNQWHMTnIUEz/9MaCztAf4p3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAzEMb6iCyoIIXf82dO4wuWAjZbENcxWPmLYui8DMGQ=;
 b=dYli5o5Ij5Mzi77SebuChHuA2yHWaB7znUpPa7+y6KwG4yX4h5qCzaEpbLzW44AZNlPubzWQ+F6aXgQDSUMii4pILkAQR7eUzY8cze1oicIncINlqfBtJWEotEpdFckR0CEjkTnPrr56I1AmnYcPSjCG+aRzXuxRtgVvN/s6QRQ=
Received: from CY8PR12CA0006.namprd12.prod.outlook.com (2603:10b6:930:4e::11)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.14; Thu, 15 Feb
 2024 20:26:08 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::31) by CY8PR12CA0006.outlook.office365.com
 (2603:10b6:930:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Thu, 15 Feb 2024 20:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 20:26:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 14:26:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Yifan Zhang <yifan1.zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: add tmz support for GC IP v11.5.1
Date: Thu, 15 Feb 2024 15:25:47 -0500
Message-ID: <20240215202548.415025-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240215202548.415025-1-alexander.deucher@amd.com>
References: <20240215202548.415025-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: e6b8c1c9-d5fc-4ea7-1514-08dc2e6457c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t5/QQIzTtUngJuXH/QuAfVLIfuuUEB/6YHUZ5y8igKLVttvDKV/ipPq/PbeBi1OFWN2F7ipaugeRrC/basS/DcbjHU3AZDAjccNfLhe9BMPP6TXU7ZYp4rXRABcuQp94BkKEoTdOimkLDMqy02RtdtZJ4CoDnAlfbN/OO83d0Lxb5bAW5XVo2S3KPjBI2bXM0+PIYIH5+6fy/SV/bw0gxee4BRCPb7y13mIaumxGZdQEKPn78jM7Cp4UkovKJ6Zl0Qo1IsLm8KH7xNl0J7MCxPh5JCL3ZOWiOwb9E+i5PMGjdBW7g0ZdFTqko6/ZeAqOjH86NMPvFuta+fmqbGCavQoRqXOE7LmeQI14X1hl8EwWdm5sr+T+jvvFRDsmTnRcbFgsgbKoScNMlLkn3BEqCFA1pMvKNhy1SbgCdyCQyRaj+IxS0Ff0vgCyAceYi4pefI83ePB91dsxVKrrv5currGZi/hkkY5bsxwhCsFNmLbCstb1ujJeEOIA70xsXuWq4KIdow+DpUbvPGhhQivRBkmZLPUcvrAcC1r28cgHDf67/NXLPSkvQ0ZwR/mc2G2gB6+XMNEYJcCvwjvitZkEhcYB7SONkK1reBSXBDTbzk1MzlAq8jiciGZtDhYfsLBwAW321qhAMb0MblmKSZUf5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(36860700004)(186009)(64100799003)(82310400011)(451199024)(1800799012)(40470700004)(46966006)(36756003)(86362001)(8676002)(6916009)(4326008)(82740400003)(81166007)(8936002)(70206006)(70586007)(5660300002)(4744005)(356005)(2906002)(316002)(7696005)(54906003)(1076003)(26005)(16526019)(41300700001)(426003)(2616005)(336012)(6666004)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 20:26:08.2487 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b8c1c9-d5fc-4ea7-1514-08dc2e6457c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

Add tmz support for GC 11.5.1.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d4a848c51a83..be4629cdac04 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -843,6 +843,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 3):
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
+	case IP_VERSION(11, 5, 1):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.42.0

