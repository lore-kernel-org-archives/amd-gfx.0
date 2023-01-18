Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874BCC32793
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 14:26:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2789610E754;
	Wed, 18 Jan 2023 14:26:58 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE1F210E754
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 14:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nE5ZTwpuYjFlwG2SxVGzUVYcDhBKnadU03HJJKchfw6FW9NGbmc2LUPp1xK+6n2jkon10E/LVAmFAA3lvYl3cmdh/u9GT2Axfoay/UUoklAlMx1VEljR2tWr+fZNUMTTGT/r+1Q5H+50zpOO/5ktH/HHj9EZwob1LQXGaUHGJp4UbqiLaIGkkLCGrRn7p/Em2YdQ8tcOiD5w8uV7Os0k0M1o0hrcvg+oB8g4ZCkq8oKdnkhOYXmQ6M/7hVmiLJPSaAQrTcEE2Murp7Awq9GZbrgtg07Edy6+oHNr5HUnBpeU6yotRnywZ07FxuKKR4eXpFYii1VVbBFQLgXoO/rz8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YsXNskUJ2nDChn0Oj3LalTzNcjUHROtY9wcWBuokBQ4=;
 b=GkvJK3RoMdXyOkp/MgC6l9lMQfjmDDJw1GRmmkFZJ6nn1YpbdeDtuhW8w7rSmErswhDuuGrFL96QTZndjTguh1wQULae5O31n1YhbNea3IsRZaixO0smju1V3klfVDb1s7qH//PVfAKe2vZCKI97PbMXrwrZzxNaVNu36SyWS1KtQ4l0DemCJQSpl6iikVeRrdy4a8eFXjrO3Rsl99FRVm6/P9OHX6v5PwyCL0W3J0ndS4iRdCV97PWBSdrQD7k+zAYPU2h7FCj9PEusl+CiHbgIzDpE4Mt24JCOJZLb+GcmZJmLsiXqBx526/7PGcp7Wf/XvJjHiksQi7qtyIk11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YsXNskUJ2nDChn0Oj3LalTzNcjUHROtY9wcWBuokBQ4=;
 b=oDlZceRBm5OrD8ffccCl60o1a5kq1ZLwbVYhACS/AKhxgKCcyY4yh6U0jVIcADPQS77YFQk72Ah7ExNE7X5fAW081mU5zOF5EAE0QJa5bD8+K/cMc3WVoEQaHeJw992pk78WHjCc482ipz6ICeXIg2QJjvM9Rt8GNEQKOi/0laE=
Received: from BN9PR03CA0576.namprd03.prod.outlook.com (2603:10b6:408:10d::11)
 by DM6PR12MB4339.namprd12.prod.outlook.com (2603:10b6:5:2af::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 14:26:52 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::14) by BN9PR03CA0576.outlook.office365.com
 (2603:10b6:408:10d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 14:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Wed, 18 Jan 2023 14:26:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 08:26:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: disable S/G display on DCN 3.1.4
Date: Wed, 18 Jan 2023 09:26:11 -0500
Message-ID: <20230118142611.1780725-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118142611.1780725-1-alexander.deucher@amd.com>
References: <20230118142611.1780725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT005:EE_|DM6PR12MB4339:EE_
X-MS-Office365-Filtering-Correlation-Id: c26e5a05-91aa-4b64-1772-08daf9600b43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /S83Hp4kTY2cqUNVygmrpN2oemPpsRMRtQ6bMAoERmNABh3nody8kJbXlHGIoQh1pYShN76RDex0i4aMw2HQHjU0TlrY0xRoJ86DiUtw4YUxk9slTJsyH4Mn2p+bgIIbQAW4GWD7FDrk9ebE7oh/cDqu0uH1lAOh68KbBGIm2B288cR0OvrpO7Gy9ylp5uWdJNSIHQVj9ERGwPMt/8CxStY0vpC1+ACWcE6iMa5Fya+PVnOprGPr4heHT6cxDSQGYaqagjYidfB6jXmuoTuGSrPMZT7aKIkA3Zj7KIy+XUuZ83EhUVOmqdOXRk1YhtSugVJQ/BumaNUMjHgZMuIxLfMY93uETJlld8umWr0NGIurAzKqDxFB8scnIYhCHEfP0HQVfSMO73rxmV5q2njbxOPUT0t+o0J9XmeijYyl+YE/oXI3l3J7mk5McVAKmvp+OjXRhccilvsI2I+0A9HzBJ9IY95d9H1Qyn3IhesMIsv/WBnDWhzSm/+9AgdtAkoJDDohGy1gEM9hN6FXnEJ5c/anjGa09IFpIxCQnjLFn06089tPvSh8uTJh7mOiGwWz4vmehHpOe4AovGptPGJd7KKZZhU7qps7tejjsK8xIgR2rXLwpDepq02m8182U/RKSB6Zsvc02NWkyQdFlK5A/vk9HIa2sWIJANr6OMJIZItQpjEuQ66n76SXVDflbcMIvKyfCkjzrIleEdYBLW4lc2Vp1bR8JZWH0g3s1XvpAlg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(4744005)(478600001)(26005)(186003)(16526019)(2616005)(6666004)(54906003)(1076003)(336012)(8676002)(6916009)(4326008)(70206006)(70586007)(47076005)(83380400001)(426003)(316002)(41300700001)(5660300002)(8936002)(2906002)(36860700001)(40460700003)(356005)(40480700001)(7696005)(82740400003)(86362001)(36756003)(81166007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 14:26:52.7000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c26e5a05-91aa-4b64-1772-08daf9600b43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4339
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
Cc: Alex Deucher <alexander.deucher@amd.com>, yifan1.zhang@amd.com,
 roman.li@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Causes flickering or white screens in some configurations.
Disable it for now until we can fix the issue.

Cc: roman.li@amd.com
Cc: yifan1.zhang@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7167a7b63f8c..b8ae51345668 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1502,7 +1502,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 0, 1):
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
-		case IP_VERSION(3, 1, 4):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
 			break;
-- 
2.39.0

