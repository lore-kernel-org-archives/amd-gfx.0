Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F32DC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F9E10F4EC;
	Wed, 27 Apr 2022 15:13:06 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D6710F50D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:13:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZcdYITqUwjWSXJN2CYGHDx17DZjhac+aiqkI8MoUuvqAjD1r+Ex1WBk3fPkKbu6NIDI6AMI1futYPGmYGJD9P3Y5KhP4/VKPhSG5WslGeZgC10e1CsBkuTES3QRKbwZKFq7P48h/rVotwbS6cCg/E16t81XLm683BsTUam+nGcf+SnGxuhluibguIs324mnEzzeoCRQ0c1s7bSoyzDGIo/6t09a+RTKgw3GvgVkLQlGRFRZXQG5QFmZGIrunhE3ClFOl37NuB7a5f9oxyvQa3hn2/AMlHmmfoNU0ugMNTDL/ZGU8n5yaKiHTot2+HUNxdJX6lWnLLC1rfW5WmlRWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9d3SpzhxIBKs5PfWkF9BJKgj6l+jpe9exyJh6Nk3OOI=;
 b=ObfUuVOY61UTkwfua+R+67fxUhZWMVmo47EoEfCSlpUfbr0p9uFXpn+GL29Xq1sy6pO/H855oI70EnxSHkcTvQdsZE7dmu85S8nk20CaMMpzS0MP98awjTebuXDsz99AIFyQVr3/FHRViFVjYXDhru8+Nc8/foLowIH3htrM7fZQ1Y6lwF3t9E2c9FhYZN3XnFBdEb6DpbVkhS6Tgd/S7MnSsia8wvw6wzNw+Jyi2NQWKAM4zcfKlokwIg45Nqe/IBh1ybckAr7R8KiIX4eRgLrvwoSTefGz4mv6M3QVMqi5iz+fOxDF+WBRkeDXL1rlXB3zgrhRmMKc7vYgmSrvnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9d3SpzhxIBKs5PfWkF9BJKgj6l+jpe9exyJh6Nk3OOI=;
 b=eEWkDOfJHYeue49nKgywnJyc01Uef7FXeVWknsMAmzEmbnAwmGBZR628Rz+qDYOsG04Yt93Gew2qzC1zhI4InGphuBBNOJEBU09p0goBgLSw+zKKUo9VnauUP14zlBjPMDLfCZcNku0vvIkZ5C43jSn+kYMvzPAb/OZEF17ugGw=
Received: from MW4P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::20)
 by MWHPR1201MB0255.namprd12.prod.outlook.com (2603:10b6:301:4f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 15:13:01 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::ff) by MW4P221CA0015.outlook.office365.com
 (2603:10b6:303:8b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 27 Apr 2022 15:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:13:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:12:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add soc21 common Support
Date: Wed, 27 Apr 2022 11:12:47 -0400
Message-ID: <20220427151247.3104799-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32537ca0-d333-435c-48d6-08da28606bac
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0255:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB025590046CA4471E04552BB6F7FA9@MWHPR1201MB0255.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jjsNjx2TKY6XzAB89wsFNDFpNcB5Zg6qCT+FKNUILdR7+5+ogh4++vLF0Jo0qIEyZaYZpjubzUQqdIBokLPeiVCZ4VDcc7ZsbYeNoGGvSZV1mww9fcau7mzdAfPdhTnmww1EUe1KmjDiVSm33VgWK1E1x4CL+KS2uQ8ZgOQpWSxGwL5g6bsLxtrritsbSkfQ/8DjXA/LU4lqTibzvMaK8K7Et/XRitOkL9KfxKEGvpCHALGZS1c1QvSDgVcEKSnm3OgOF2EXycgH0tAnTsG9psnes0M9/cYZPoJbpZeWo6axadcpaGpARRCH+nA4Gc+eMa+NMlSYoL1YnLpR2lFgGTbv+2xZUGCtzA11Nujk4xLuHoYOV61uG1LO6yiyT9508mFztAapaA6FBPoOTjMk/7gae67rGLIhKyMqSES7lj9IN9A8n4TWkcH9FVGUGYMZASI4uuXOArlJ1pBgHbcOHiU5yTIvWNQ9lIGpKUp64cqRvZUN4Gr408RR6hGpxNytrzh/hdjIaip6vbTxTOuU9qA7UvirJt3b12tN9gMpVjCInHkzz4igJBULqjw8/Jj47JgkQfzvvM6wbnAIyboEiNvqj/hksnGiAP4ml8MCIzQwmoa8mNfdXv1K4PJ0LPXuyV6Pepgmx03jYb1XVlbNB4wiLUP//+fmz5Ov6ryer48o2iKyKDED4iRj78JZEKoed4ChHULvugW3MJowMvJMpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(508600001)(316002)(6666004)(4326008)(47076005)(8676002)(356005)(40460700003)(86362001)(70586007)(81166007)(70206006)(6916009)(54906003)(336012)(426003)(5660300002)(7696005)(2906002)(36756003)(82310400005)(83380400001)(26005)(186003)(16526019)(8936002)(1076003)(2616005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:13:01.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32537ca0-d333-435c-48d6-08da28606bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0255
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

Enable soc21 common support on asics where it is present.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0c359ad9fd63..8a2cc1c36f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -53,6 +53,7 @@
 #include "nbio_v7_2.h"
 #include "hdp_v5_0.h"
 #include "nv.h"
+#include "soc21.h"
 #include "navi10_ih.h"
 #include "gfx_v10_0.h"
 #include "sdma_v5_0.h"
@@ -1467,6 +1468,9 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(10, 3, 7):
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
 		break;
+	case IP_VERSION(11, 0, 0):
+		amdgpu_device_ip_block_add(adev, &soc21_common_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add common ip block(GC_HWIP:0x%x)\n",
-- 
2.35.1

