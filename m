Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D854AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  2 May 2022 19:04:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AACA10EB7E;
	Mon,  2 May 2022 19:04:04 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B60410EB9D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 May 2022 19:04:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZSJzZJv8wR6ZUsCeckkK8Qd4uDz3UR9FN4uPus+lU5e09dK3nFfahvO2WpEuk1+z8+EVjsfeFGKmAiaMLcWs0iWdPx/UxnexgDxkb+sI5wwI6cBrMQKcYHtNxDmSVRSZ0EBr4VZskdVDhHmH30gen87JuONtsQDF3ijuwJqVvttfczkxWqJP9oo/9pzjzyXOZqIZmOnehtb7cBr5yeAYOTaaH3E3gt4ILQ7FRF3h/CZPNTtaDQwv6uNNIZ3k29e2N+2/70e8Q3VdyOf73sgYoxoTb6aEgoBqsrbSHzYF18roZWLnazxYjBNuQYjUhOOE8ILyyJCZfRgWPk86Uib8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MJ2V4+RkPl24PiCr3jjSKjQoztFfHHyBmZqRHfP2pU=;
 b=YtDvH89HtpkU3fQ+3c8L2Y3bFD7b+Y+3DpCjw2gC1hA6qeAAb3VSEOgTXeeAwRaAE6h+oD4ixbcRtTj/+Xwc/3EpzDDYeZZv5pq8iXZMZg0cT291LbKMio4aHOXwx8IdEmEj88A7W/e9q9rsFKVp+3h69B+ro0SOiElaQd2thOFbkqhqAenwclcOqm6b+zifKnKCcNaUGf5mmJfCvJVnH44W1RWt/KJjDE6W6dbxuaVqgVzmo6zV7V5BMRxQfcVKAekrI9c6mZhSNIlSiOJR/XuU/eHAIWdseBJ543TjC3FDnlw2Jfnfpd0Mh0l+t+Q0lzrA/KxJs0Zm0tFSktef9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MJ2V4+RkPl24PiCr3jjSKjQoztFfHHyBmZqRHfP2pU=;
 b=zXST4tFqOlKSO4c5F7T9ZnHIZpUCOjeV7hArO8Kq7yN227ufA34x2U88ILFpZYbJYfIpFpSK6aVdMpiNUmrynjxXTfPyfGK5YjVjiAqDiVfd4fGV6eiYcRzDG4wpZcRTf5OWsmKdoHZLLY7QtvnngwPB/GVxZGhamMXPSJWrLLQ=
Received: from MW4PR04CA0105.namprd04.prod.outlook.com (2603:10b6:303:83::20)
 by MWHPR12MB1358.namprd12.prod.outlook.com (2603:10b6:300:d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 2 May
 2022 19:04:00 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::66) by MW4PR04CA0105.outlook.office365.com
 (2603:10b6:303:83::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 2 May 2022 19:04:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Mon, 2 May 2022 19:03:59 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 14:03:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add SDMA v6_0 ip block
Date: Mon, 2 May 2022 15:03:43 -0400
Message-ID: <20220502190343.783897-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502190343.783897-1-alexander.deucher@amd.com>
References: <20220502190343.783897-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da7d0377-118a-4779-f85b-08da2c6e8414
X-MS-TrafficTypeDiagnostic: MWHPR12MB1358:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1358BC854507EE8C301998A1F7C19@MWHPR12MB1358.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9daM3JazIXZzYnvRfKFFQ4LIIGVCJqe/s6vFsj2F4lpwoi2mpoknxc/RlKVkMdfrxY5nb2TQo9IE4Aovw0bKmdT8zWncNL+qTliAkPxJlv0igqkokn6qvXAJywQQEJ/nahfcyTDgRy9w+vQ+Wx1+7rDlR4cU9oJZQQMJaPnyCWCXjeW3mXtDYHAANI4vAeh0qniaiprQ+GFwbXms6IRVf4EZnFmwS2pJkyr8XDMbKPQkLda+vAnOlKsvOAydslNE+AYzk03nh9OTtHEGbgPiAWNkZpAkqjgsME9hRdC6/N77LIw5T4LFouvrAGRnW0903cg0SKms/aB2awExYYOhEGH8ahQgqSPoul3Pc67oL3v2NqGTRqoWfupHK2gYPnDwV/XRmMwzBcpYixfizr/YB8JbfNNFm2DHJ0Nd0JX8xEWHSj5cWOkVE98fbjN38XshzvYpxTPolcUuySkmnF8WV+4MtSkOepb+VXo+X1jPeO+g8gl1qx+Rtf9S8K0NZDT32VBT0trku1YU1CoYmf+NWPKQZUjzzhxUTEOo8wnAKmIIbLVb0BGlyWacw5kULC4tYqY+XxEkvKdE9TuLohdCWaHcZL+FhereqO76KVlLHmhqYmh3Vtair8q8KJzh0btNMdviM0BfCNh8vMjbNIG6mkoWcK/V4+zYoXsHSsSrw0fH0i2oSpcd0tMKhiU/27mPyWhXRtYlhVKfU6+PvvwPhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2906002)(316002)(356005)(40460700003)(81166007)(26005)(7696005)(86362001)(6666004)(47076005)(426003)(336012)(2616005)(54906003)(5660300002)(83380400001)(82310400005)(186003)(1076003)(6916009)(8936002)(508600001)(16526019)(36860700001)(4326008)(8676002)(36756003)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 19:03:59.8463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da7d0377-118a-4779-f85b-08da2c6e8414
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1358
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add SDMA v6 ip block for asics which support it.

Signed-off-by: Stanley Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 0edb7c8f3b05..aa5f31ad8bc7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -63,6 +63,7 @@
 #include "gfx_v11_0.h"
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
+#include "sdma_v6_0.h"
 #include "vcn_v2_0.h"
 #include "jpeg_v2_0.h"
 #include "vcn_v3_0.h"
@@ -1775,6 +1776,9 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 7):
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
+	case IP_VERSION(6, 0, 0):
+		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev,
 			"Failed to add sdma ip block(SDMA0_HWIP:0x%x)\n",
-- 
2.35.1

