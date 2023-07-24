Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A79BEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 19:49:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6604D10E348;
	Mon, 24 Jul 2023 19:49:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D2710E348
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 19:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpUpVSB0Quajvs9ipr6bbXA91u/s9GwIGWfyrfjfDKKIPcZ/jylSLVDgYvN69ZyUT4dvSLmvwEcxqZEEngRT7wL5po1s0wVWRijM6bW+Qa/6jOBXRhRAFd5oZwIBD/4Nx+CZjJZc5wWaWnloI3YBg2bWBPJ+/B6aiWuQ9w+YPXDIOQ9bg8Tp2Zv58izvcAhONGak5MhMgK0LAjngi1tFBgsmODMPOjohBN+my48nPk4FSweg3jrcl+sRm3RN4NtSbFkQyPDWTCZ8Dkhy2BWeBkSexOZxhMVXuy5JXXHGe0u4p14ineUm0kAsru1NIcAkbTqK2FnbIwsfWumJkUzcTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4cx2SOVr70OpMQGtYbOR25c3v9/Ezujwu4t2Eud0Rc=;
 b=Iq+0EliOM1cx/EZP98CmVEAwaJ2f6DlXxsSoHscJFwxxpKRvU/K0YoITQXxygL78YAE47Xr10xHWNj2CGdbgCdOs1C3lvgkcPU8+5muea4BggKiZz20FmCnILwFXtHfxK1GskdICD8XEs1iQ1wZun8qF6KBNbozcl6QDsA0RFgn0IWtXscw2bslH3MtGjQMSXxPZJdOOgPEXq3ffvyUfmctwzLheHw3QcKcoRag2/gX9y0uxuUuErK4m4TIb3DOdB7IULzZiihWqSUhrtdFDf0fQFlIWmP6AjzvqOpAAWJ4gMiiaZdgbVJ7bQphX5q0pCRQHbhiewzBlceYRhozDPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4cx2SOVr70OpMQGtYbOR25c3v9/Ezujwu4t2Eud0Rc=;
 b=23dn+rwF/lXSdHfETe2fFN5Iy8qIo6hC76b8GOoePE7T/nAM9iTPLHKnCuFbA76ux9onPpZxGdbcImNKqqCxALg9nAa2DjEZe5LdezwecJe8T2yVJs/0mu+CWPvAI8KPsIDuu9IYtk0B7KqmwMMOesJRR/uExOD3Xy6QJ6JuZSs=
Received: from DM6PR06CA0046.namprd06.prod.outlook.com (2603:10b6:5:54::23) by
 LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.32; Mon, 24 Jul 2023 19:49:48 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::14) by DM6PR06CA0046.outlook.office365.com
 (2603:10b6:5:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Mon, 24 Jul 2023 19:49:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Mon, 24 Jul 2023 19:49:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 14:49:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/discovery: enable sdma6 for SDMA 6.1.0
Date: Mon, 24 Jul 2023 15:49:30 -0400
Message-ID: <20230724194930.763966-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724194930.763966-1-alexander.deucher@amd.com>
References: <20230724194930.763966-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ed4f0d-6d35-49f2-8afb-08db8c7f234b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6z0KGoJ3WARFCnbDZy8PXwZE7E9hm7WXrxlYAoZCIyStqRQLyluLvjgEMdRtZH6tXT2hd64APSDMbwugB8KFNDt8ZRgaIKVAUnbnlffL7KC9U9LhAMQ9ZhDUzZY1Dvo32k6AJCo/6oLgNIsewvdqdemEetjHzRgCXaZX+tFjv79XhPwmaMWMpHex9ZcFg4C9Wd+qzv+Ej8OtoplL+yX2NuDCC5nrMUJYUYAlrkSQv5zdnhKi7V8fKVK7MpXHv5lbwL2TssaNwntBCyxoElXYN1vJ4uUwANcdFRCazcnAr4xL3R8Fvd4WSj7gd3YKi4R8wJQqFQhxiRnhdY1TzKPYjxyWdd8yZkk8oV4Xq+5d7UaUWRGRz5xkmIU/2npDcCgrxF8irkL1DwstUrheIJQSIeqt1gxDSuhfFt097EWlsmpyYRBiCbnUXCHt91D+EftIPR/XaT8ur4OItJz5xdHQHxGxep42Wb/vcieGCg7+1EbL/7eWKA8GCx//QnZo0joMnoPj/PviSOFEiMW0RHLW2mkdW7TzSS7zHTyUlR10xWbePp6Is3zSZeXehwIkvqYtvk9yugmp7cWl9u+zPoP9taPz+Ni+bYHx+SONs1PibnBT8JXbBgONUeDLV/SHLbzyPO2B4Hw6109riPCneEMHGAR1Xg56WvNnMgu4xtbU2Ej/G1m4SpMVYeGAfjifbhDm0VelMT/nRfqIMDJgLr84O9X3fyUQguOS5MAzUII8BuNN/H6RhngTACG7/4CkA3EL8yFtq4+dUgLZOwWZmfYZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(82310400008)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(478600001)(54906003)(336012)(16526019)(2616005)(186003)(1076003)(26005)(4744005)(2906002)(70586007)(70206006)(41300700001)(6916009)(4326008)(316002)(5660300002)(8936002)(8676002)(356005)(81166007)(82740400003)(36756003)(40460700003)(86362001)(36860700001)(426003)(83380400001)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:49:48.3164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ed4f0d-6d35-49f2-8afb-08db8c7f234b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Prike Liang <Prike.Liang@amd.com>

Add to IP discovery table.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index f2b95c38ac3d9..910eb9ffb802d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1967,6 +1967,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 0, 1):
 	case IP_VERSION(6, 0, 2):
 	case IP_VERSION(6, 0, 3):
+	case IP_VERSION(6, 1, 0):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	default:
-- 
2.41.0

