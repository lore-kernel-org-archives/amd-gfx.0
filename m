Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BCAC433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:51:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 506C210F505;
	Tue,  3 May 2022 20:51:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2905D10F4BA
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPVlSRV7Af3qXGB8mW902gMy59Dsp5ILHm/IIfSIYRe0jDKzkLKnhZRnNS/J4cAoWdB0c6kTndTMW/R7/4fJwuc214luG+CrQQxPPUGF2Ligfa8JKysi4JMwNLxW3o4EVWXrBRBvdjMaVsG1m80m8AXYxddRI3aT+VM7PhznJwggl6qZRBpnOA4Lsa1jiSS728PMYhJ1Dkq9AU+PTBVAhVtDhB6WPWVVBEnPYVh5o8Mcs4tCAAkFPw6bPdB2fCkrAISa+pTUsUifal1ws1hAOJPtdjwUMVN/XcQ2/1KtCLsPhDh7pNJgtdtNZSqzVZ3Y1nPkta3fvkqXfunw3JaAQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol21wb/2WlibD3OlH7mcONoCRA4MF5HfnGAKYXvh2FQ=;
 b=XPD9LcJNyPZZAoMroqLhevUI2KOigzsJezc7daupMVtQwBYKBleicst7sFeU1utLbs91nosViOKZQGlF4yig9i5gJNbFHFu9Wb+R9M0FGQOanQfYhqX7do4oH2/HzerFOLc2WR1YvfTV4Q1Zpf6fAuyf6vFA4EfLBqsloKiY2bYNjK95boj7Kwu9RiytpNWwVemXS/6qul60yfCxTajiUr0paMtpYbTTl5QhZJo2gpvmfKh4V5KlF4YRb6sc1NnW+bEpWUynxINWj9h07nP05fpW5h56pPef3ZOl/VjNrfTiGTixtiKNls8wNnik86a33GVoMNQbXM0Oytq51LZcqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ol21wb/2WlibD3OlH7mcONoCRA4MF5HfnGAKYXvh2FQ=;
 b=zZkhNxLI+RftAYyxxiMSmhEf8s4gQQIVNUldO31MorMro5Tck5izkWutuvAUr4NVLSHVQeMpAHnhadSqiBIStkX4pzkRYnkR1OQEwcgCyOyS/2oqjGzog+qt40sVDp8ozRF8SNqXBIxfzpFZz5IbSdk2H50wJtqz4Yw6GsZ0N+Q=
Received: from DM6PR08CA0042.namprd08.prod.outlook.com (2603:10b6:5:1e0::16)
 by DM6PR12MB4619.namprd12.prod.outlook.com (2603:10b6:5:7c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:51:28 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::68) by DM6PR08CA0042.outlook.office365.com
 (2603:10b6:5:1e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:51:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:51:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:51:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add sdma support for sdma 6.0.1
Date: Tue, 3 May 2022 16:51:02 -0400
Message-ID: <20220503205112.1285958-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503205112.1285958-1-alexander.deucher@amd.com>
References: <20220503205112.1285958-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45177713-7016-4b99-e507-08da2d46b20a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4619:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4619B7F02AD205962832564FF7C09@DM6PR12MB4619.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aS9TxYjij6kcQOkkcEF+8RL7XiDU4AoMLk6Y6FSrL6xEQIyZMwborJdUS5vsSBGHXdqHzXuGLQHDOLm4XS25MT7G2XeJdVPr/DmC0nYzORXDdHlE+iNGK//hUC8ZGlSccJN05pkStfJTKgfv6QlamCs6D+uk5wx996Ke5AUnL4ig6DSq56penXVplZaM2lfC+59JO41CEgj0nG95RiEHIDjAFu+QflweVe0IskZORdzuSARSyiHSsKdiXJTyB7HcdpAUEumo05Ui3wwuwwfKGHxkpRIqQp+iHSBGCoEPI7FZ6MLH6ZI6NBPVROxu65vpQO19lZj5DDm67PbXk36EKuNT+6hSWwmzOI90Z2ne6ceAy05w2rDE3Wz4arj10UbESFRHsXDITQmtq9k27HhKbF9FLAMjeHeH1SRbFZNz9QEwvYmfYLSjfrWnnNsWzzXInzSvXof3/AhTSQGlkzJ+cHFnUjiSHdhT+xL7S/VTdq+6xPRIckxwcn8Rnl5mN0xuciJnx6nSPsazOepjC22ezudZ0rTUR+TUuqZUM65PToEnibGZ7PPowpBtbrweGi1OTBEpHSvPoaUz9YgB/jeXuXZiFmpT8sAz6zp7I1Bdhd92YzffcC7gHP8LclY4GXXR+sX2WsMUsDtfyh4pN5bd5mfHiDpUMsZJ8/FBhkwmMKTZ4ZB4fFdSMGLN+G3MRieyPCRGRv/jnOS8IZY8Xk9nQA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(26005)(1076003)(336012)(356005)(81166007)(36756003)(2616005)(6666004)(508600001)(426003)(186003)(7696005)(54906003)(40460700003)(36860700001)(47076005)(16526019)(8676002)(70586007)(4326008)(70206006)(2906002)(86362001)(5660300002)(8936002)(4744005)(6916009)(316002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:51:28.3428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45177713-7016-4b99-e507-08da2d46b20a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4619
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add sdma 6.0.1 support to sdma6 implementation.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 7650c1e530a3..6cc6a81a7d73 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -45,6 +45,7 @@
 #include "v11_structs.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_0_1.bin");
 MODULE_FIRMWARE("amdgpu/sdma_6_0_2.bin");
 
 #define SDMA1_REG_OFFSET 0x600
-- 
2.35.1

