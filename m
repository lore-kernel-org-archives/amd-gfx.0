Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8D5CD1292
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 03:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B85A10ED9F;
	Thu, 11 Apr 2024 03:30:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gbPWBTRa";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97C710EE0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 03:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Llk/PXSc9uu77BrvGkDiaR6IRJ9jdv9/VNJHMiPr7JsqgnGuLuticlNT15jdgWUDSqYzPi9ZQS3HiwU3+n7Ohs9r6VfDa70ytXsL6jBiPPKRgDysvd6pXmHA4usYo7f+cAl1+EpavCFwI4Na361WzdC9Cj7tpni17SEru8x8IoL+7y8oAKeTB+HGrjegFBwI/NJtHRp9FTbfzkduXXPfK/o5Qw4N/qqcJ+w16nsBPx9ujtTqSBHtRKc+CNJxssU5gKXYeUxWX/tqACSUnpdesUIhSshwLuahHCug6NYjGN2AxpOuRFWW/lvW4qfN5rebl5MpOUhcnX3OmPL0zdlv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5PStxdHqghi6JTg0YwPlVlgsfM7Bd3SnTZzshvhNpQ=;
 b=eIZOQD4w69YKVDl67WaBj0HnqyQI6+8Dv3pgbAR00a8u/QRIqZBhBswJV58qh2MFNJfaEpwWRxZ3brPrag8MB8jaqK2cF3hKkgAV+DXoWf9w8q2zsb0UQHC81u7t45Q0hbOiH70FtwYy4JtGexuQK5c+by0Ct6+Ny6cdyC7Ea0VAUO2m7k7jTaE0lgPFacpomRQVrojB6IQGKAgOFS+JcQ4LEEwTXvNNTe4Wfs+THkCg9ofDDs8QEZKVI+2IDynnvqFPRY/STLMgTfW8TrcDGOzpc2xaLeklrF9MiatZncn+RZtkrsZUdcqLtmpMUf1bTaJnuorbQp2o+ToJ0tDIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5PStxdHqghi6JTg0YwPlVlgsfM7Bd3SnTZzshvhNpQ=;
 b=gbPWBTRa90DPBtr7FfEDgsC78U8pRo4vjgcXw/V7SYSbR7D60jBunLes266BSennmW2yQizo3LIXZiKNvYXC18jM24D9rqWa7wRPoWGOSM77wSHvpcV9lsINq7faD113Fs+LEYhVOAFjGGNgLv5ZjUe8KhqOaaTn6nGXyj4Np1Q=
Received: from CH2PR05CA0058.namprd05.prod.outlook.com (2603:10b6:610:38::35)
 by PH8PR12MB6676.namprd12.prod.outlook.com (2603:10b6:510:1c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 03:29:54 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::13) by CH2PR05CA0058.outlook.office365.com
 (2603:10b6:610:38::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Thu, 11 Apr 2024 03:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 03:29:53 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 22:29:51 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>, xinhui pan
 <xinhui.pan@amd.com>, Vlad Stolyarov <hexed@google.com>
Subject: [PATCH] drm/amdgpu: validate the parameters of
 amdgpu_vm_bo_clear_mappings
Date: Thu, 11 Apr 2024 11:28:44 +0800
Message-ID: <20240411032844.41839-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|PH8PR12MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4d9fb0-c744-4a89-a9b8-08dc59d7a744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWRoP/jOmjiJoG8EMHTCGht5vNyADgjk6N4O/mVM2l9FE9jTHpYx9x+x9R5DhDa2cE370dYiFDhkLke7BCNmIq9w9Hx5dH/k6JWLQcIC1yT0JUy8IjVqEIul+2CuzN5PeWlPkJPOw4ag+54S3pZFgjn6HBeul9zMMjKGbdtRmmk64XuGFwKR09DN7iuEcaA+TXJfu+pb3ac1ZFrByjS6BWLA10B3T6M9QHM7P6TnusS5sEuGuOeX3KdpLCKW6cijS/vHvNuP7l34skEVbDhjiqBH4ZMV5aW93oZXPGrrxj/4A9snFc7wBiDWggeop0if0iJ6X0iCTojc+Uo34UOjPDJnI44bQw+x8Eh9wJoPRK7n/TkNEqcR7vmE21/aKJ3Df+z/7pLv6q0N2mzkXP1gu8cPax3ofNmtTjtZkC/rOUdX7rb6ExgTG7keiAJtL9dGSVvsDghHU/LuR/CgesryTgEYDp5qBJvrS5oI2XWU3CWhUHIUlHwIvwAhpVBCWlkPsGppZWEWtzD+AIQ12rxGW6vl6boVi7fQXQlExfesM1190xQHZxQBtHhKM0TsmQ7qjE68zSwzUnXq6tNvQ0OFwusLvJGulybZVw5c676M+/bfnOHne1kGFUyQgabRJSqmt1EQA+3mE3qXCFz0btgXu0LkKISnxeYPgSusDM3OqHOAKE+PNT428gTmZ9mlCUaeZARzzo6Gfu5oAmQbRa/nIq2ikNdcNw4us5lhWMbZOZ2H2LTi0sLrqYD0g+1fXNtd
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 03:29:53.8278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4d9fb0-c744-4a89-a9b8-08dc59d7a744
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6676
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

Ensure there is no address overlapping.

Reported-by: Vlad Stolyarov <hexed@google.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8af3f0fd3073..f1315a854192 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1852,6 +1852,12 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	LIST_HEAD(removed);
 	uint64_t eaddr;
 
+	/* validate the parameters */
+	if (saddr & ~PAGE_MASK || size & ~PAGE_MASK)
+		return -EINVAL;
+	if (saddr + size <= saddr)
+		return -EINVAL;
+
 	eaddr = saddr + size - 1;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 	eaddr /= AMDGPU_GPU_PAGE_SIZE;
-- 
2.34.1

