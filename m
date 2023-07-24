Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB673C0015E
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 14:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6E110E32A;
	Mon, 24 Jul 2023 14:41:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D82810E32A
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 14:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUZ+hM7dvvUjP7OOzGAEPSjdZ89Fgoag0a2mMsLloKfuFwdyEc4wdtFNprKlrRV3rKRQoyUk0o9GJB52+krrPcT2Svx6ENCmxzMIXrCoeHvO70az+D7gREhcIqIOgz7Q4SWDMxJDiTzfUpmQXk4Z0CnWVY+BOgMhvfvgL8U4NJkvrs58X7/z6zNnlw8BwNUXajqNl035PTYMIc+I5p3963zrKp4koCNS/l6tL3DlLKLNAi1yFzLyXDMYTyNVnjHqGLL391W+oNbzaUDgPhMdaYP3Hep8HToG0nhhGROcGF1b58/hF9ZxKNoaPC+ZLqekb+eAE8cjs40YNPZH9KUYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLWk6Rupq3TcX2+3O9U49vU8nfLVjb6SH5SuePuZjtU=;
 b=TaHQvIEgKwLUh/UHY4CwRoaF9Bw/SAUUQ1V5uLTYDduMEfNGkD5Sae4WLoc2EGqbUpIL0gs32pofSOwBivPUp3zX3nu59/YivOJAroNLyvD3gPVRFJocLuJMTfmo9afj3rzsHhkwVQTX9/+lm0huHn5xiAGAykUugHeKBJv7XqUqw7sNamaqiG1vOEvo73fccuzB50l1k1hC+wEHWA/JiQpM73mopDaYL9VgEezQLTHDOHa4AT4R4S8v4xtkYHd7+G32w3ZujKL6OHOfwy5eywpc8lawArYYBWLJ/U+REVaQjgFBEZcjHDDSNmTEdoS7oaVQkhneRF94BXyHo3QiNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLWk6Rupq3TcX2+3O9U49vU8nfLVjb6SH5SuePuZjtU=;
 b=HXpMv1z2j1CQDsLrKbWTDKj7o5nJhCCPNlRvQ7MS2CQMVjoAn4zhc2fqJEAxi5fxanPwSqtJmUCDI9FY0FxEd8PtJLFfRwMKhON6liQpIhxzVDToPt3RvOVbSOROCzQ4RiNGgdPuiUf3liajVG5sjcJIO8uGW3aJgDu1yMJUHWk=
Received: from DM5PR07CA0063.namprd07.prod.outlook.com (2603:10b6:4:ad::28) by
 SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Mon, 24 Jul
 2023 14:41:25 +0000
Received: from DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::85) by DM5PR07CA0063.outlook.office365.com
 (2603:10b6:4:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 14:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT040.mail.protection.outlook.com (10.13.173.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.44 via Frontend Transport; Mon, 24 Jul 2023 14:41:25 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 09:41:24 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Fix unused variable 'domain' in
 'amdgpu_bo_print_info'
Date: Mon, 24 Jul 2023 20:10:47 +0530
Message-ID: <20230724144047.2166580-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT040:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 9577e673-19e9-47e0-5e46-08db8c540ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHq1k5kD+L/jk/vGx4VR7eFPRujekl419t9ahQKTx5nidgt0BI+In6PRdEUPUb90w3oD/CmPExX/A+MGdbk4CgokJPHdCv48qOnswmzPcWi95nL8TT+bxJOtiHGVScMu/S7c2SooxXM9nLNcNvEBITxaQ6DE56jmye2a4b5Cx/2cjSaFa+4WWnI46CqsQaXghi8kh0i9JDfsDXJWZGUDIFwTWJPPxwtBuY1xNQhRV4r1cA5zm4NVNeVC1UbzJVhhyQ+CXL4BrZeAQd8XJ2i69dwx7lcx0dglOQezq4onx8pi7tc5izF4+cr/s1igKdF8oru9U6g5ecw3T1viDzHLmBomENsDgnty2AWhKmlXRgFMc/65DnN8cGmyjf/z8cKljeqrUMzZrHToQiYgzUZl+L7MyasskM0Kf0j7SnzrNgZyCHRyAPlo73dcA1sluy4nxfpOSwyOLIGYJIFarQSzn+o+p/epjx8T69+qOxoM4WDC9L4HV4maImAoE74xd2y0y0lRwH5VZ0cxWiiGfrnNkCHCewJMX9XjVMKKpZK09eK6RFqAMEh/VhJmM4H/gakj2OT/EWvDLrxP9MaoX1Hk1p81Bwub2OT6dDTbTvCilubsGLQLP7zwWIijghf+Cn3cY3NsEDfypCwfF/lVaAfNfS8J9+8j3mlynzJkf4cFB0G8DR1Cm3ngBIWS9LKut8mUxszP9bh42XchZ9jAW0Utm2owLmaGtOGlGfk6M+Qw6v7+ylbYUj/SjbBdTwfK9tR5ilPmvYg5tESqwg/b2Bykvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(478600001)(86362001)(83380400001)(1076003)(40480700001)(186003)(26005)(336012)(41300700001)(4744005)(110136005)(54906003)(316002)(8936002)(7696005)(356005)(426003)(2906002)(40460700003)(4326008)(44832011)(36860700001)(8676002)(70206006)(81166007)(36756003)(6666004)(6636002)(2616005)(70586007)(16526019)(47076005)(66574015)(5660300002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:41:25.6100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9577e673-19e9-47e0-5e46-08db8c540ed7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

drivers/gpu/drm/amd/amdgpu/amdgpu_object.c: In function ‘amdgpu_bo_print_info’:
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1581:15: warning: unused variable ‘domain’ [-Wunused-variable]
 1581 |  unsigned int domain;
      |               ^~~~~~

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 5ac7544cc068..3f98174fb764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1578,7 +1578,6 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 {
 	struct dma_buf_attachment *attachment;
 	struct dma_buf *dma_buf;
-	unsigned int domain;
 	const char *placement;
 	unsigned int pin_count;
 	u64 size;
-- 
2.25.1

