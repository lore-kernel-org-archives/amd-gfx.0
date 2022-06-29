Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF1BC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 16:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB4A10E6DB;
	Wed, 29 Jun 2022 16:45:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB3110E662
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 16:45:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW09TyhrkgOcUdZ17mIOGd8L87Ig1iXNtEKA7zhZjruveOtMdNqldN4vu6cxn+A0DyExyQT+mq3GCK+g79/KGaeJMm8owRHG6SaP53LtdJriypzQJJ51/RJLplQg9rRD4LtHaRIOVriDiyCuaj16tdi6TMY5hBuVYIFRuX2hjvV0+OcYBv5qrsW0zIEbn+HbC7xb+B3pEDl0htj15DqJPjndOnYheOmjoRyM7u8xzoBYZ9Xb0/RosnSjqdVG/iOFwjVwffPfyajAyTZ1LaMaO2/COCmysXXghpTp1NxfQhg4xu/nde20C5LpFWO5mV2Ythwx/A14j9EzX9tyAHRqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEy+QiCRscuaFzsufcnMitzmb6nQBNUYlM94+W6+6VU=;
 b=lcOVlD5dSh8/sb7xWeNbW64pTf17hPEG8OfXK0BY5Xmo2PDs3YGolQ3+VNx3N00YgcM1NSvF5iCC86/d5eq2/IznTFeP7kNvvhAvQgu6EyO4TJX+euICkEfw2EJrwMgbYKZSumldAcUzOlBMPM2dA19QAwIN0gfGgukY3B4bm6G0Pogr3NmIb/mow6JjkaFXfT3pr+IiQfft/v6ew101jBzzPKDf4CxmZUyS8VRHjNZwLlhoYrG6rZyhVy7Yfr24SK6cMz+7S7iYn9UgodUssmfujgxSgGKy9nczcOuSLRc7TUVrNfCGxxtarNt+5M/tegl8YtXYsBOvEN7z2NEChw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEy+QiCRscuaFzsufcnMitzmb6nQBNUYlM94+W6+6VU=;
 b=TITiXARHXuu1Nw4eYsMd5QjeKdBqcR6LgGSsqwOmZSSntN9nu12sp8aGoEUbGeSt0vjKxZLNhthKme3liPSRuHeSTFg73NKX06LsYFeLJjo1OufDrk21iWw+lCDi2wC5s0dDz3jhCPXnHw1IKbLLfuuJrfELOslzxVXTHaWLS48=
Received: from BN9PR03CA0948.namprd03.prod.outlook.com (2603:10b6:408:108::23)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 16:45:21 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::21) by BN9PR03CA0948.outlook.office365.com
 (2603:10b6:408:108::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 16:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 16:45:21 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 11:45:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 29 Jun
 2022 11:45:19 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Wed, 29 Jun 2022 11:45:19 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <alexdeucher@gmail.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Load TA firmware for DCN321/DCN32
Date: Wed, 29 Jun 2022 12:45:18 -0400
Message-ID: <20220629164518.2449787-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ef2141-5376-4128-3b31-08da59eec1a7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4386:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGD2eNXSK0aGoZDRWzF/azzvnojz0xNhpQlietnJBLPjb92h1ld9FtV1TNPtO14DEmHMcZgW5n3/XYPbwgo9FOcyk1zavgVe3qp0qKTwWU3RF0j0vm/Y7pAAwBl9m7pPlOyYASOXSH+qBoESI+T4ETyl3VGC+YvIIpUVIw3hrA8qGXvj8hO5mlnpQZZsBP87ZrlS2H8E+IwMbXRHg9jJRBj33s/nJV6Z6EcvbFr5EqWrE31ta99MJB/38bwZNVBLlCPb3o6W/cmifM2OdmrzSOMRFw6NxyCe6ZuvKZ9JFpI9ZmCYBWsIGfo0fTipEf5at6iv88a+h5Pn0vLwSWMJ9X+gK8hSwm3rqwNOY+AymRkC3+Ln9XLAVeRZlDYxbnBHf0Wn1uFJXCh8ulNjFCj0kOGcGszG8jVYZG+S+FdJ9R3KYcR7wSyCvCi6zBE3fFHlsLDvQ/5aBWjsMPXvhEwcOzTOivzgSMhIkMDhKyW/h4Dsgex8UHFwlurp1vDYfPkL+Hp+iEwFdSC4/ZXCHn8KpDyju77cei01CCjJPTjPYS+ihovi/lFH0eobJlxGQRePLt9yT6cMX+p/1EueqpO1JQY+XoqClL93qeMV811BXnJG89FQZ+ncOjvYQQpr3xR1J4TOUvjf6WgarZYqxdUMyJ3hoWIM2b6ebURBPrepDUIvw50sCw9bJ0/JUiKcGQYKGf5MuhaTW21KpvOAVeKVa2dQtTy6B5IP8AFwY8BC90HtRfJ8+sVuRUyhpTfzkdS4pNit9e/TTmzEtNTO8InRKX47lL/s8qX3Y76XlXXaT59xAt+WTlFgS/PFu/vW1Mc0uAzuKY/TkjcYt2iWMVjxqMC+RitJ5A2fjM6D5WSdcT0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(40470700004)(46966006)(86362001)(1076003)(4326008)(44832011)(426003)(54906003)(83380400001)(478600001)(7696005)(26005)(40480700001)(356005)(8676002)(8936002)(81166007)(70586007)(36860700001)(36756003)(5660300002)(41300700001)(82740400003)(82310400005)(110136005)(47076005)(40460700003)(336012)(2906002)(316002)(186003)(70206006)(2616005)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:45:21.1616 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ef2141-5376-4128-3b31-08da59eec1a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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
Cc: aurabindo.pillai@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
TA firmware is needed to enable HDCP.

Changes in v2:

Load separate firmware for PSP 13.0.0

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
index 9e1ef81933ff..30386d34d0d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -39,7 +39,9 @@ MODULE_FIRMWARE("amdgpu/psp_13_0_5_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_8_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_0_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_13_0_7_sos.bin");
+MODULE_FIRMWARE("amdgpu/psp_13_0_7_ta.bin");
 
 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
@@ -103,6 +105,10 @@ static int psp_v13_0_init_microcode(struct psp_context *psp)
 	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 7):
 		err = psp_init_sos_microcode(psp, chip_name);
+		if (err)
+			return err;
+		/* It's not necessary to load ras ta on Guest side */
+		err = psp_init_ta_microcode(psp, chip_name);
 		if (err)
 			return err;
 		break;
-- 
2.36.1

