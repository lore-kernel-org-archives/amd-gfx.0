Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495B6C77B62
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 19:43:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9348E10E2D7;
	Thu, 30 Mar 2023 19:43:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2068.outbound.protection.outlook.com [40.107.96.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36E8E10EFED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 19:42:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz7z48GmNiiGCl8Nqz3LxvhSIL748+26DK07DWeotokZyOe+pj3QhnH67fgX/erE3QtOU0DGu5nbjunlpDDx+hoNMaHUFxTWOg4TwJDwsb0v+7MNBm2lEp+CuMTaFsxgH4z1Oqvk+POU906VEiMrDYqxPlQhu9WvRpy8XzSkdo9+eH7DNT7xTw0GuvbpBW2D5dYTKwKGsWzjDLw0HZZMwf+VAwOcXiaoBLXQCe641mkaS1ZFE8PYbGHm2v3KMzF0vva4b1F8nIJtlHtBtYVqGJXbGhRJyMxIf8EnLJG74n2AQy6Qc5NmPxv0UngM9e9682RE30aVwl7FkoUn7XRJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUvGeuejXf76BahxB3xVX1g+KY0jsMP/HNoXjtpfLoo=;
 b=GV0BN1b2hKnk32gpOCrxZN1raX7zna3G0b5titRW+RzwRJpTUolyY52i3Ayp7WalHNR+5JIXc6c45FY4MkI8AQMAoGm36Ut6XAdR/dKhdL3GzzhpeKX6qJkYYrAk3rMgqUHVyWmif3KxE8CZCKIEyIjB5/0im8/2FlW5S/6wYZeCHDtV8xaY0525Ttt+m8OB4VhEoDqsNwra/GMYTfJvhmQ4l2FUAw/yd8kEczmz80irECkix7f65LeC7ujwtxw+4Cx7YQXvIAJOy+v5ONHbY82jwhS1ziaw+g9wkDlvGpZsUEhQhkWJoxC4bRmpm1735vmsqZrfyw/aHz0ZnssxHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUvGeuejXf76BahxB3xVX1g+KY0jsMP/HNoXjtpfLoo=;
 b=xhYH/N2P/KO28G6aIQwFsvnpC+15dqZlX9BS0KznfbzLmOxhz0lNfkZr3ZXPu17N6otIVyp+4j8Da/mJPf/QIoQdRlR1GwxDVaVdmCN2r50zAVIvXX1ltLfavBHzNL/HiwD1B1i/JUo0z7mMnWuFueHnRcVMh+/FBMwEl3WSXlQ=
Received: from DM6PR08CA0025.namprd08.prod.outlook.com (2603:10b6:5:80::38) by
 IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 19:42:55 +0000
Received: from DS1PEPF0000E63B.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::8) by DM6PR08CA0025.outlook.office365.com
 (2603:10b6:5:80::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 19:42:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E63B.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 19:42:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 30 Mar
 2023 14:42:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/23] drm/amdgpu: Fix semaphore release
Date: Thu, 30 Mar 2023 15:42:24 -0400
Message-ID: <20230330194234.1135527-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330194234.1135527-1-alexander.deucher@amd.com>
References: <20230330194234.1135527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E63B:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 90662ea9-b018-4e4e-e8bb-08db3156f4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F+atcHuX0tFViu5VkfRMYaHGffirSN+2abu4An7atB0TRQII+lo6/QVCqlEhCZMGU91D2efoChQUgGxCvr8+Zx2AenWOFueoC8ARbccBhrfjQkbcK5j3C8wvL4mwHzLigDzhCRVIR3HPhEZ6ptPyPtD7yvaqS1aZfdokKzTLAviJe/ATLyCn/t+/EWtNVm7f+Qdeh3n3tIrDT+Yim7CW6+131/13lCguG1+JPNTWIvy23FFSyvUk+iAsGm9iL4VRe6Q3H2Q6t80oBpn3AyOHcy4A1IgrZKopk/ojgiXtkVwE5T4X4IGGTARzPYFfaZW6nU/M1eBNs0gwjvVKwXSQlaZ7wherxwjs/L6nlT3GV7+pzvS488UhLUoNZsSO7qKXvkGL4EiYJ6iTygw+Bo/c/Dvy3KxI88E6lDUrh1+GpGxUKiOX/f8g64KSD1sZMGNfZzwNadMUvM9306Ijof2G+jbWodszxj2GNfQ5r7ZN1xhFHgEHKa3GH49MuSs/1Z2CgbBmPYFHtGmkAZ7884jbyaFYcr3sNfDH9w6uwYdFwrrz1VfCIn1ipunOGuBPZybARP4XsXIsWNtST9QysEHKLv5/IP94LDrMWjGM3MDXUIkAmA0h8d9C4Eeqz8Mb9uzQ5hBt69BAkeO/VSTFcEEbG3AI5aYuTUuVAA4N8nMp24zYdTSx/NxmFzAScJ3YRs2jYkvwuGJ0fjhospn6sl6HsisUD49g32idhUAnK77itrQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(7696005)(70586007)(1076003)(6666004)(6916009)(26005)(316002)(54906003)(478600001)(16526019)(47076005)(36860700001)(336012)(83380400001)(70206006)(426003)(8676002)(186003)(2616005)(41300700001)(8936002)(2906002)(4326008)(5660300002)(356005)(81166007)(82740400003)(40460700003)(86362001)(40480700001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 19:42:54.8300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90662ea9-b018-4e4e-e8bb-08db3156f4ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E63B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use the right register for semaphore release during invalidation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 5050735cba5f..d9ad6aabd48d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -897,9 +897,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
-- 
2.39.2

