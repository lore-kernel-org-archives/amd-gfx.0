Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85ABC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 21:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE2810EBAD;
	Thu, 28 Apr 2022 21:34:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DACCA10EBC6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:34:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS6WrYNpIrtTe04Es+vEIC2hC23kGKc+O0KBYpN/ctzNCfHOaBVmszUaKqHPkMWOLHlCN6WrVIaOu4DlBIyys52FeWmPyPARfprtSMcQmVCpc6BmVUg0on0uLuK+MXA/DofwxFM3DoY2CHQNApuN9ndlmVHrly2BLet+2xf/qo8zo7zUtJgrx8VTEYfl+PJ9tOCGUuOZ6qJwzmTxiqvM0KUkpEF0s0v66eyKDHigpYfbeO41GTZst/BDrpJsLlO4IVKUh5FVk68z+O/KBYAOfD1zibA4xTtYpHLS+iXmVks0ijJyf81JYYD3i/MsQNUhZIlyALaHFPB0vPSyG3Xtbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGvFjHBRnzT0+Q32yMXZvohwNHH8WuBHVr+zCd5EWuE=;
 b=YrYmO9/ydPnyFw69mY0U5I9E4qWBgU0zBaTcAH91HSJFIKmLYRs/e84uxAZF85uZjyxfTP0b1KNzr/Km/AMPP0HkKokea1j/8LTHfQX3rZQWUEZm4cCLYSclcKseE3WvZ/xIEYU6dBA68Rltv/f5NbVytX+aecScnPgNRcecIJnGH3eWgum/VvNJMFDrnzGMRY60xBuSvn9OKgKxT3meXKvw9z9ePGm0qj2Ms46yQOJSvAUK6aQrvC7Tz5QVnSvVybFmbLnwWs1lKBo/tIYamm2f4DE9eXvlPy75yjeNUb8IsZNhwuf18IBi/RqfD/hcuQy7meyjo7m5h5ijNLunmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGvFjHBRnzT0+Q32yMXZvohwNHH8WuBHVr+zCd5EWuE=;
 b=Jz7rnO7N25NMl9GLVAmlotrYgiD+0Fb5X/9sQEr01FEOj5mxFS87E918pHL8L5SXtyxPtZ+oujYCO0/sQj9ZcDzDH7ijv00BHzBmre1eXbpj8BDIZIAPDHfKFPqqBxGz4yBsm56RVG5XiPHmTVGB35JA70Z25k9Bx2N3a05080I=
Received: from MW4PR03CA0043.namprd03.prod.outlook.com (2603:10b6:303:8e::18)
 by BL0PR12MB2499.namprd12.prod.outlook.com (2603:10b6:207:43::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Thu, 28 Apr
 2022 21:34:52 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::89) by MW4PR03CA0043.outlook.office365.com
 (2603:10b6:303:8e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Thu, 28 Apr 2022 21:34:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Thu, 28 Apr 2022 21:34:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 16:34:45 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu/discovery: Enable SMU for SMU 13.0.0
Date: Thu, 28 Apr 2022 17:34:27 -0400
Message-ID: <20220428213427.700543-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428213427.700543-1-alexander.deucher@amd.com>
References: <20220428213427.700543-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe2df8b7-05ae-444c-118c-08da295eed67
X-MS-TrafficTypeDiagnostic: BL0PR12MB2499:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB24990C8E1F4637393E83F3DBF7FD9@BL0PR12MB2499.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c+6RNT99eJ4tWE3Leo0faMl28pBeneD04/GUESKik2zxRa+CS4JHso/0N9e+0OyuWiCxEtpUtfVM12Wz7u1Enug/ZZedSHOhw1fwJqol/Ic1NV5GBwHbzfrPAyA4RVfDFEC8HA+mv0zD8YGTtUiTXitrlVTWXA27f9fnDRPRV8d4DbjW2cXcktHVYSbszA14J+n5OqiLEK/ReRGQPHorosx+UfCbZZGeO8WSuVgNoq74qJ1jQgUdC8V+T80nM8vg4DxLKnj+A51hewV6YNmfl4vtsd2Wql+J511fGcLzFtZEJrCmPVZV3edzp+pm/zWKDcbQsgFsiXwy2c5OUlpUv6/EQc8TDlSMyz7oSsGOr58PSLRZiTeDQJVw5mf5iyM4d/xS8gU6eM7fuotYdHCofcZalO4IyjiAEuGFGb9Y2Tbfh3GkD0qHZtMB1wyj5otSCBcwZPkGDdFTbQ27M3qLp7fQ7/4KX1wS1BbLhG5azUzNVSyQ6grij03sKAkMq3zOpBjTMHI/IYfy3vVik4NPK8vxaRm4OW79vLWKtToct+rWYmaGyDE+zgn2AJe2M4MDlkRY7090DjxYU+ugDWjzCEbcY5QVXea+6y4kWpZxGEwgNNfgnWdv/PtaVBHdtluBovMKGq3D6QGCjNLKIzU+SgyD27cZeTvF1QLWpXnH7HJf6gg3jHG2EJ50b2wo30ulCmdzHJGQn/Ylxlk+ff742w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(186003)(6916009)(47076005)(426003)(336012)(54906003)(508600001)(316002)(356005)(4326008)(81166007)(8676002)(82310400005)(86362001)(36756003)(83380400001)(16526019)(8936002)(70206006)(1076003)(2616005)(70586007)(36860700001)(7696005)(5660300002)(2906002)(40460700003)(6666004)(4744005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 21:34:51.0934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2df8b7-05ae-444c-118c-08da295eed67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2499
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable SMU on SMU IP version 13.0.0

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 35598193dc7b..2349617efeee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1634,6 +1634,7 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 0, 1):
 		amdgpu_device_ip_block_add(adev, &smu_v12_0_ip_block);
 		break;
+	case IP_VERSION(13, 0, 0):
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 2):
 	case IP_VERSION(13, 0, 3):
-- 
2.35.1

