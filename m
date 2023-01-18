Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D77C38159
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jan 2023 14:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266D510E752;
	Wed, 18 Jan 2023 14:26:39 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9278410E752
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jan 2023 14:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EornkPpvfpI2SqlxlVhndIme6IEu5DdS+MVq5EBHZs0WWJkeQMcTLR4OvSD7q74arT+jdv9YF52TWuHIigR5xODvj9/bxCW3llN3ijDcesDl1lkGMFgmMI4DDcIDCna0/htmbIueMZoaG5drdOWiCr1sWKdOJJbKV8kpR9+5fRIfu/IOvjDaVT1FeTr7XTD/PDji0hFVKNlGVLygk7dOkr7mvLtW9eNU6XwJR2ZquJL0EMrik4zvzvumwpD/hszeOucKRAjjmkYV7ZXSMCzfweyiI5Gw6Opxv+iJ2kHICIn45xQqM3AldfhahR50XmJwTvFh/JFduAKyAdeWxBrV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TcP+0uZbA4T5bfBuje757LtmEXyAYP9+E95NsHqFewE=;
 b=m7YB6vKIxZwI0Wki9huVM6KAvRllHqXYOjVXyRO/ytRcE6eAIG3gNkux1Pe6GuESr1KuN/DMYhozZAnIFCaGZsNKiD5OlPYr4qSsooFrrIUd0tllbM6V9tHuOd4aU1nGiIr57iHuftMhS9GLoY7vYkJaYDlJ9XTBih/QM0KqOXZD4KQR5XDJWOGP4wyFEgoLEFJ0Uc9kYGWwX/kgaUd/0zTv7E3EVagntasPQuhtBK9sq+5iSWUE0QcKPDF7AVzhI6MuRbWsSMeN0j7DuM0uhrT8JcZD69FPN5dXTSHZNJs1QkVFF9O7FkXSw1O5/ByrwmlnouZ7p/kHFy16IU24sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TcP+0uZbA4T5bfBuje757LtmEXyAYP9+E95NsHqFewE=;
 b=MYC5pKaLHF0nEJgC1GGLcyzx5HYfgE//3OevJIQoErhcX5isk3uukLR8JwgCMyc0HXpHno7R/CGNE9f68cPGawm+UqLmG8kODhtoSG7iUMboqKyDlfoktGNRLmkG7/114/xPmulP5Q+mvORa0icYo7+jQyJFtOCQqkoMenrUxjA=
Received: from BN8PR12CA0035.namprd12.prod.outlook.com (2603:10b6:408:60::48)
 by PH8PR12MB6963.namprd12.prod.outlook.com (2603:10b6:510:1be::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 14:26:35 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::29) by BN8PR12CA0035.outlook.office365.com
 (2603:10b6:408:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 14:26:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 14:26:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 18 Jan
 2023 08:26:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/display: disable S/G display on DCN 3.1.5
Date: Wed, 18 Jan 2023 09:26:10 -0500
Message-ID: <20230118142611.1780725-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|PH8PR12MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ed9d53-a6b1-4c4f-a00f-08daf960005c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: odianre7m5MjlTz+ne8iB7z2p9zA5bRjjvIp0eJFiZM9K2o3JimEaykYSPM8AjiZZI66BEUThFXDRCs24ycAd8TgtR8UT7MVQFMM+rdZmhPbSLjql/PKeKPPmhv4wH7Xdcl285uishQXn+5jnU04hm3btPohT0X/hC7Y0OaXcADV+++pbpoYXEvdWnGZR7kdfinw8kIyoVmH0B+mRNKS0Hy794XU8a+e7JtgJxUwXxUW85u1ksx6+H7nOH5wZD7gxMcfw1Vp/qCu0R6iDYOaVnPUEs+LWin3j11RbahbbT4IhR8/+nJxlsLYDJ4T3twpM6IXFDgc0CEIpMdsCewv9JmUM45oMY3UOEk2hAkfX/54o6h1AidCDKBk82dc4aLqoNei3Bsai3EtFneD7LE5Ad8fo+qb08e7NzAQrDcRgmY6PUE1CSaywA02MOEttq2KSIITnev17JrdR4PuDDObXqSQp/s8k5M1/gNxAS2k7dz6LYWjFTPPytrtGpWMWZmS5Tr2ZevbUYMhcumEeQa9XJ4HqzpFKXuINAIWM+1dhl9vhptCTUJkdUkjffNDEsspw+XNcG7GwyIL/qhCN+tRse4ykgkyEmJlzRDOTTeEqYiGs2wWr3/MxsHKUBaWGMTlVgJnQDKUfxH9TwfOi9/7dDN253dWMMmpOytPh7Wa5Q9dkrX0ev/k82wFedWwKqVq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(81166007)(36860700001)(356005)(86362001)(8936002)(5660300002)(70586007)(2906002)(4744005)(70206006)(40480700001)(4326008)(8676002)(6916009)(41300700001)(82310400005)(16526019)(40460700003)(2616005)(1076003)(186003)(336012)(26005)(83380400001)(47076005)(426003)(316002)(6666004)(54906003)(7696005)(966005)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 14:26:34.3499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ed9d53-a6b1-4c4f-a00f-08daf960005c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6963
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

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
Cc: roman.li@amd.com
Cc: yifan1.zhang@amd.com
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 500d3d9b59d2..7167a7b63f8c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1503,7 +1503,6 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		case IP_VERSION(3, 1, 2):
 		case IP_VERSION(3, 1, 3):
 		case IP_VERSION(3, 1, 4):
-		case IP_VERSION(3, 1, 5):
 		case IP_VERSION(3, 1, 6):
 			init_data.flags.gpu_vm_support = true;
 			break;
-- 
2.39.0

