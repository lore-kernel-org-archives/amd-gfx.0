Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB1EC25B48
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 09:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD04610E792;
	Thu, 26 Oct 2023 09:41:29 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDD510E792
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 09:41:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdalb4ilzmG5Xd8yNEH46+McZStKvhBiXkz1c6dPrKcil3L3xWhBBH+pDCWuggpFYUCQ4sq8oq4eseF4KhB/3LFxWnrNa4hK8oUe0idJsUAVJl5ZYnLohTp6qvRGvkOQucOY0hL958Bt/Kx1XbosCwl4DEMm8gzlUAedws7N7RHt3c0/4e5tGm2sPqBoZe38LMXlLyx+rb6sTLR/K6eGFLumdTDAJmRt3pGs70TMmTR1g1Xcjwox4uMQnvvTGZWCoFiCDtN8OZy1Hr1G0Zqe2om5aM8XE93q5dTr4XRyAi1zEInYXs4grHSP4s0QjO0Y0kP8aL5OBzLSATvAWlaQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLbrtOQOm7gDKmLZUJWjn9VAOebpZMWsS1AD95GDMOQ=;
 b=TR/h+v7CdY7zeq9hA3mDzByDpt1AzbRY5g/Sa5/kq1cHvu/DG4b11HRdkUwAp8ERIOlIeDb0D3RiwcA9qekdvMTs5Th6NPPbOSJq4FMK1OV9iHPuYCnJBjj6IbcjT9+Am1De/ejezDDgWvj1oRNqxprsecFvjt3WixmlUjULYfOj63ITurLgGteIKOiduDMEM10jz4LGyCsH3D737DxD8+N82V/EyBPBl40Y+lRkhqFgfX2b30rOkfd6Ttd5fFwcCksuPjSSvmLLx21C1FJWbNdJ9xwh+NWuFkEZA3iUixvbwPWXAGhed3bsA57UxH27FiqaqdWAeYGe72glKJIGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLbrtOQOm7gDKmLZUJWjn9VAOebpZMWsS1AD95GDMOQ=;
 b=JlEzbchyLamC4r0uJPXQe6MZZQfHNPXXtqtfspJHuFGRqZplY1YKvU2YVV2QUJS840fgGnjr6fYRPfRvzzmPQ3PFmY4jeyPtgmLvotK/aflNPP4BRbBj8OL0o2b6obPANBXpV3fo4yEyKmnf53ZD5MZZ93CuFzV8gajJip9QQjw=
Received: from BL1PR13CA0166.namprd13.prod.outlook.com (2603:10b6:208:2bd::21)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:41:23 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::e) by BL1PR13CA0166.outlook.office365.com
 (2603:10b6:208:2bd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8 via Frontend
 Transport; Thu, 26 Oct 2023 09:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 09:41:23 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 26 Oct 2023 04:41:22 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/soc21: add mode2 asic reset for SMU IP v14.0.0
Date: Thu, 26 Oct 2023 17:41:04 +0800
Message-ID: <20231026094104.2133426-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 43e36f71-ebce-408d-0b16-08dbd607b76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRMcmDnhYA15M56Vt5A9d/enset1fOJFw88yqYHSzua0DpFDiflARF3nW2/XFEM67/hDiqSb5CncX49mssAJsxfPi2iyk5eNIMisjA1PlRi2DZTAsoFboU4rsdvS1MHzUoWeOYcnxAPB/EJsZWfpStpjOAefWSwvuvZuvs4zHd9hTIqAMJCf9irXx9mxkQL+5+dBPbSpoM2Q6CXG4Fn1zgJd1bPkNL4hQ/c2/BflZWgPii5F7mA5bv1fQYUE9cv+y4Omx52C//QoPNKz9js1JFdRhCfLBqvDsUrx+F/nBkpqF8hHNKYt7OO53x0aQFlb51eIDx8g5w45Ho2VORxuD8wXjQd3ZgqbnwEx7qS9gWGKuuWEDC5wB7sbPCoKxSZeIkkieT265Q7WHGWbXlLDG7z4yN9RRAArn8LPpSjcLchuIb4+C54VZmjqsE40/kYDLnfkV5KwYnFGLBWERYqmeufocFxOU1T9XdsiVlrACrk3LeOV41B50SJULHbjv2jdWMo7ZwFg20kbfwc6FxSs6OGQURiLkr4hUDOk+mgv/xmtN6EqFNYh5F4WZEJlSEHByPDYqpq6+IFcK7V+cecN/I778RhdiOrW+u9OUCf2CqQZORTKw1yPZA54P4ctMz7kgRguxi3hmCy4FoSTiSYcbcm9/5vdCaIGyFcsV/FZ05Ap/mi0KcKqsG1Wo0bcNG23qqH1CeAZ0cRfQ3X8mGZXzvCdponlcu1hauaW0epHoHkgVqahuAF/oRvAuVDVBb7undNkbMy0DQfsxQZycS/avQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(16526019)(7696005)(6666004)(36860700001)(26005)(478600001)(316002)(70206006)(6916009)(70586007)(1076003)(336012)(426003)(82740400003)(86362001)(81166007)(2616005)(36756003)(356005)(8936002)(4326008)(41300700001)(8676002)(40480700001)(2906002)(2876002)(4744005)(40460700003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:41:23.3145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e36f71-ebce-408d-0b16-08dbd607b76e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
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
Cc: Jiadong Zhu <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiadong Zhu <Jiadong.Zhu@amd.com>

Set the default reset method to mode2 for SMU IP v14.0.0

Signed-off-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8c6cab641a1c..ebf99406e634 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -381,6 +381,7 @@ soc21_asic_reset_method(struct amdgpu_device *adev)
 		return AMD_RESET_METHOD_MODE1;
 	case IP_VERSION(13, 0, 4):
 	case IP_VERSION(13, 0, 11):
+	case IP_VERSION(14, 0, 0):
 		return AMD_RESET_METHOD_MODE2;
 	default:
 		if (amdgpu_dpm_is_baco_supported(adev))
-- 
2.25.1

