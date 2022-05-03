Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2C5C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E49310F38B;
	Tue,  3 May 2022 20:29:39 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F199510EE60
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xb+7yQVGA9pjfNCTaPr0tuk7UUIEQkTm+C5JljpOYbc/IKfztmv6uXbJ3+8/Syp/cMGVub63gIG1PC4qLHglkKrN6jdfHQaNuLHUy/LtiRGqN6EICho1wyTeiMMvTVzHYUlzYgJIPP8oxYfS+UuFtvPUAuVKhG40TSHBOzgLDstrbiEwhfbdzUPWRLzyIe+dNI9Z9+eok9Nu+6AsZCTnKWFC8pCvdCJ9WvBO2q/4eN2hx24W+Y3JrMifgLUA7pmoQroWkTaz3oh91LC9A1GFfs15n6EBEp+KPkDZiiL3FcBi5p4FyEnBEZQ9VTQe6z+BidQUK6wcx0alyhaUrRDJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3IeJ5WRowyN9ZiJZ+m9on2cu6KY+U3BeQKHnEMWZP0=;
 b=neh2hPOnmajXM5N9Y5OyrFfcpMK2StTXoMwYRgmZNAi2p3/tHLKVWo6h50XAAo4k5Fd0PPce65cTcdMJnKg7zqRyHbLR0Vkgael8FThEC33RnYTzY4ucfm2eLMop0WDdfMiEKhM5O31GZwEhpt3vADsU4382aiO8JhHuv4PJL1FCQ91OjNNoVc7zn1llB6EwRXHG+rjAFuDNyMARhjQl5HkO3n5pJxmGWf416GgMcZwlkQ3oFawEVIJjK95nA6IZiqWjSU2yFJAoPW8sLStDewoZTRmw2vOEkmwGJblJ/ocgRDecGurLiuovnh5mXx50k101gdy3Dz5UewMi1kgkEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3IeJ5WRowyN9ZiJZ+m9on2cu6KY+U3BeQKHnEMWZP0=;
 b=Gw3Sm3lnBC3Hz4fz9MlCq6KtVbRJvnnMXXTOV9ss3uz+x05HUkrdOvc/Oz3vTVtwYtZpukgueTOT6OP+ujovhticf0eBRn5ddwBoxy38GCJHup2DH0jHgVxWnBTZUvIY5tSq7X7JFGQaBmJ8ybIOtDRuEDU0FoNqhOknPrEFgJY=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:29:34 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::89) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Tue, 3 May 2022 20:29:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:29:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/discovery: add sdma6 support for SDMA 6.0.2
Date: Tue, 3 May 2022 16:29:03 -0400
Message-ID: <20220503202912.1211009-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503202912.1211009-1-alexander.deucher@amd.com>
References: <20220503202912.1211009-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ef4b859-950c-47d2-3913-08da2d43a2e9
X-MS-TrafficTypeDiagnostic: BY5PR12MB4306:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB43062674199022A60772AA11F7C09@BY5PR12MB4306.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hc8nmNBMUxq/gnlF4WCPOSqBWgKHog8IIc5WX6bvfhmi3lGKCnnCBE3znclneTvuacgFID/IN7plfgYCVWOU5YLSaic1ivKDak0RSjrcoY3xOCWA6o1U4QJlj68q7LcehhTFxUZb4nFhYjP3faeTet4RqKaj8fEQHRWzaRlA/RZI5XayuoQejAiENnn+ioe2x5YfWtk4CvPiRVLw5Lwxzk/pjL/17gP6vg5oW4vLEPQerJ1kncxHtLYbBWN2OOq6SGRmnkX1h01xpeTXawy/sFykrauIwbKrGOrmnzsoqIDZ1mOfpkeNc1z8NqA/9AUmuUnauk6wTVT5HVyCPf1ppu4tMFzxrnP/2r3jMPvGGFXqMB9ybgEIK2/NtVY/j6+Ugxw5MLjnUu742qDgRUuXPVNWHpGkkquWvVY+vqOY88tcCuGXZfM5T84oZ64Z9QE9BRNe05yf0Vqda6emTaqGRySnS8C/U4uCa7uNxJuuEGg0+Z2YTDBRfgv3oltfyRy6LA3KHJZF9H94uQPKvKKZIqtfgXW9bbaYznVkdw2Ngy7QtJ0e2djDPbNKbZF8j6QKVliayPE2TVSWlKdGdt7/fYXIgnZIE9cLq/+oHTvrOIMIGTzzehvNBJGkFZURLO6GNzuVacfcVgr1pTfUoAen3bm9/6bg69/iKxteZUblwcw/erYW8e1E6vyPxpzfw4Bd7pf5bovAkKL7u1yyrWCRDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(4326008)(336012)(186003)(36860700001)(426003)(16526019)(47076005)(82310400005)(26005)(8676002)(1076003)(70206006)(2616005)(5660300002)(86362001)(40460700003)(4744005)(81166007)(8936002)(356005)(2906002)(83380400001)(6666004)(36756003)(508600001)(6916009)(54906003)(316002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:34.4505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef4b859-950c-47d2-3913-08da2d43a2e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Flora Cui <flora.cui@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Flora Cui <flora.cui@amd.com>

Enable sdma6 support.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index abd2a6f96ad5..903d75aec75c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -1784,6 +1784,7 @@ static int amdgpu_discovery_set_sdma_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
 		amdgpu_device_ip_block_add(adev, &sdma_v6_0_ip_block);
 		break;
 	default:
-- 
2.35.1

