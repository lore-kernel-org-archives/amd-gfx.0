Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003C5C4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 23:40:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BD010F579;
	Sat, 13 Apr 2024 23:40:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1wuPCMX/";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C994D10F515
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 23:40:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=felAO8BZpi4EPwu87BerTAkSGqjBH/lkyeYDHELDUD6wyRcm8wr9U3BxIYEsGbsEBjsyVLjktKEGOYvjYBFj/Y+PFJouTwhMSi0i2uP9u2b6f1Vho5my7T1GmtppYOaFuSlFOo3PTZvmnGH3/Un4JdK0GOYBnSzN3e/rpQj/OqSq+Y33O2G6W/bHdSXPJEe2jOPsssEfMhbeAdTMcKjQEbu8qOoj0Q+3iMtVR9UBkJcwj4ALalgJmh6SzRqAov3yUtlU6HbCYr7NMdVPON//k/0DCV+Nd8UApH+O/Fxl+HE6jVtvQcSVbnJsj58qpyMfAQV/MzcjD6VU4QpJ8i/X5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SnVCuMDWViSvg+4JxQ+Lezd/2+DL1aiCMGagM7vgYK8=;
 b=E7ps7baW+0NWkd1+R7Og83UvCzzop+SNA9qd64KdGSDaw5EEzD/74gp3nJa8iRZysgqZ8FtytafaF66oOOPEEPTYEPUOskswuZVncQH48JtJds+cXNzwCPqNa2YhAR4m9Crjb88QbNCpTv09ixhvNvDWTQ1F4UH9P8Zk9zII4rIaN6S8WwDFr2QsfMgF6BtJLbfR+AV3MUXvLyLul5Gl+AfMoTg0f8CUhdJbl2Evly/epuRhkGtjqQm/kRXImInCNrdrGLFnzOthjw4mhPyb1+d23CaQaA2udh0afEZjW6E+kIzyr/7vKCkU+j3U5kFjDUxKOvlCt9YzQRGEdRZ8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnVCuMDWViSvg+4JxQ+Lezd/2+DL1aiCMGagM7vgYK8=;
 b=1wuPCMX/f5SS87sYvGZnEHLt8NhRD8wZyJrI/fVdOjCY6GGRP5b8jpoKqyffc8mlSjnNcx9W96sbo7peMgO5bQ5MkuFN9bYRfZlWCs1E1qSwQzviypsREgc4WlvdEgvkaTOGBh6R9mhsWcXZDfIlfUb5WiLP4LIyB/P850bsI5Y=
Received: from BY5PR04CA0030.namprd04.prod.outlook.com (2603:10b6:a03:1d0::40)
 by SJ1PR12MB6242.namprd12.prod.outlook.com (2603:10b6:a03:457::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Sat, 13 Apr
 2024 23:40:24 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2f) by BY5PR04CA0030.outlook.office365.com
 (2603:10b6:a03:1d0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 23:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 23:40:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Apr
 2024 18:40:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Kenneth Feng <kenneth.feng@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amd/swsmu: support smu block discovery for smu v14
Date: Sat, 13 Apr 2024 19:39:45 -0400
Message-ID: <20240413233945.4002886-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413233945.4002886-1-alexander.deucher@amd.com>
References: <20240413233945.4002886-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ1PR12MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: 06880509-2fd0-46d5-6e61-08dc5c13177d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUBllclhWgtkZ4u9ffsjsUXmA/AvS5YVP4ExtMk9dGgeNAz+0+6R+T5YgC2s7QbK4DTk4lACp/K6f05XzNojIQQX/6xF+xBHbHnPHisJepqU65C/jWDNU8UXg6DZ+BMuD3qPLYVgk7kntWUnOIVDWsboyOuvgoMZsJIo/d7CTUgONt95HqSx1Y05nClz+8117ZPyCwMfaVxHuciQPzKF5DJn6+PHAINkZ7RlYHybwzaFQ4xvvgNUGMtcJORRfatWtW4AJujptCBJAsQbtbqIfB+g9YSsKMRUOgaDyQrp1LpfXwsVq1g+DEfx1OTZBvsrUWU8Tp411g+8RTooatcXPN6xaHHMU+hzTXhDNuk6uABkeM62Pqz8nkGMRgV6KcIqUUCeMj4bqNRRaUyBCyIBIUNTClpaFhOW3RZu6M/B1UcP50JtDU2kjUkBdw0ceLDunRE61sZAnVyv7lLYyZsqEU8GASN2M2XKiiwDm+/NxwVTYMMU8/MLYjl0Iti+0KTlJj6D16RSr1bKh7Eo5FF6TNOqtGZ75fk8cQJzpsYsbMl9cWkujzqkkOBEu50FGxsOexuzLfd3W7PDjeaxP6Es9BlTtl6mqlBaEUHKv+QEq7auJXDlK5WjqZVAgCT4hd1yjtNj/VYM5RBXfq5XTBLMVniThUGyuDM5/PwqON+D2ugQaAzbppdLaWFuWNqel6GFgerRPqeU2i1So8TpAbUvHTOKhyvbbI2N3heujhRL6yXd5rooznWzBmw+vcR6z7qf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:40:24.6904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06880509-2fd0-46d5-6e61-08dc5c13177d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6242
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

From: Kenneth Feng <kenneth.feng@amd.com>

Support for smu ip block add for SMU v14.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 07c5fca061780..31964db7159fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1906,6 +1906,8 @@ static int amdgpu_discovery_set_smu_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case IP_VERSION(14, 0, 0):
 	case IP_VERSION(14, 0, 1):
+	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
 		amdgpu_device_ip_block_add(adev, &smu_v14_0_ip_block);
 		break;
 	default:
-- 
2.44.0

