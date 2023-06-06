Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D72FC77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 19:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D913410E254;
	Tue,  6 Jun 2023 19:05:59 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 456DC10E24F
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 19:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvpVs2YIrLFlPZ3iUyKzKhhwbAgl2ynshkPkl9Oc8p2STmJmRW7bbwDUfbKiZ/4N3xUE1SmMGk0zJou45nhEMd/hvNUH0Cp2j5DKLQgls5SeDSGlGuBMEvn/zC36dBrcEDdnSg0Ww3YWnXzlfT7TMZ9GsE4FGnZo6/PRhNLtPhoSbCJpZLHQZ/LPn2zCSB4haSez1lW6udupV7PoVYDgS92XfJKJdkHXx/ui1RaNXHxsnalkvUgzY9BdYzXOA/5GwaYOEc9npvkWZTQKEYC4/VBgQRSt/VtSEFXU4FD7knc/GgOg6bWNm43HgkTyIrDu+Xq0SWdyNjz8JBoC51rySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNJtb2eEyA22nygN0DAPbuNGLuQX49DVFJcquT4m9G8=;
 b=ZwJmd6GCcqteCZzzSum9+O83iY35FP5OK2wKVI0Fz8blwMgQ1cLCuJD1F8RZMROzlKYfLgzkErUaBwkwd54yVknvsEWE0d/u/cQRBEYXjQ6d+wMC/WtpwqJ/842b5Rf533ZWt67L9cwM+OraTr1AY384dUCzvXmYV/GlSdGJRDtefgLaWXGkOUzUQG/KPQH3vuh3hg3TpBjOPARWgI8b3W7dJbdsPT0oBQyqlgGtxNSUtbnsUbeY8qGN32VCxZiJrd/fm3UhHoL3hvK2bKDNGkVV0YTlxZMFMBtLSwblq6YFkrlLWO+Pb38WqrGYkJjieAHX12RAKdlqw82E0vYEZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNJtb2eEyA22nygN0DAPbuNGLuQX49DVFJcquT4m9G8=;
 b=dQ2cK2dG2EmdBTL2tFpG8gz5A0JwHNsiE9akcaZQrle/VazFTgudfiS+SW+90Z/6W11AXlXFWxq4inHjUl5lYn0Z+Vn5L2OtngRGR1ddKmIHTcQtp87lfnuos5kEX1tIYCGAY5EkBgx0nvmXV90aMdFz9bWs3jc5BsBRikwIHVM=
Received: from BN1PR10CA0012.namprd10.prod.outlook.com (2603:10b6:408:e0::17)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:05:53 +0000
Received: from BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::4b) by BN1PR10CA0012.outlook.office365.com
 (2603:10b6:408:e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36 via Frontend
 Transport; Tue, 6 Jun 2023 19:05:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT061.mail.protection.outlook.com (10.13.177.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.36 via Frontend Transport; Tue, 6 Jun 2023 19:05:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 6 Jun
 2023 14:05:52 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Enable translate further for GC v9.4.3
Date: Tue, 6 Jun 2023 15:05:30 -0400
Message-ID: <20230606190530.13325-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT061:EE_|BN9PR12MB5225:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dd6f79-d16b-46ae-cacf-08db66c10cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2bbTfx83SyHZ12ySxGVXXgf6LSk1G9BGu3ubOpWDenDlxJhZ5jcF8FFk885P26+j7q6GptuHKGSJ40N2ans/2MmClx+OGEBqLR8wkATb+rK1s9hBl/bN8u3nUdabC0eSyuXpadj+YkygNbH4sDGohgL3nJ6ikw+okLhHG1c2YmByM2J6E3Td0x8QsXUM9YG2nVxQgu+cMFA+Ky65u1VVhyuMH0dWDKO4bXLWTt6f32VLC3Xq1Tc211gMcHzyZ1oB40kzQ7v8dxN3G5ob4as8SWP5x1MZu2sgaYrYFtaaMlAsXODfNgcnlDVOQO3C+493IxKGxeR2xWn8GhEHmYhYDg+8P+Nwani3tymMWlYDhSpqo+eIjJGLcBI/mQo0Cbh9Qic2ZIChoMtKWcFqTHxYpuPp89XIWGZwZ8QBSUyrE4iVIJb259FMc1usEobnGSvdoE0O5vi0VbrvoMQFwASAt5z7QFCQyGGeZgKP5pgWEr17OfYR6fPXG+yyLU3Pee8+sADS9DbnMcLWTUakg2zklnkURuDDmaZEHAFrM4Izpu2aXgsi8m2lNDcgHTB2R9OULofseGQ5ZvqdMVBwYzjIo43CfYbp216XqLUNXNiXkpiVsXGs7uSJppPGiMblphYX3M/rXJbQvmnmaniXiFhuGuOVijTTm4w0PImyC3Ah1EW/u7gQX12vg9qoCleTtAsJ2WU0See9LB6ZxhhxSfm3cScGCKoBQPrnbSAvXW/K9+khVU9/kHcUGi6AxGDwCrxPdFeBAA232adHZuLMOJWu7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(82740400003)(81166007)(86362001)(40460700003)(36860700001)(4744005)(16526019)(2906002)(36756003)(186003)(40480700001)(316002)(8676002)(2616005)(5660300002)(8936002)(41300700001)(70586007)(426003)(6916009)(70206006)(6666004)(356005)(54906003)(336012)(4326008)(47076005)(478600001)(7696005)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 19:05:53.1951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dd6f79-d16b-46ae-cacf-08db66c10cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Cc: Philip Yang <Philip.Yang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To extend UTCL2 reach.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3ed286b72cae..67e669e0141c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -2107,6 +2107,7 @@ static int gmc_v9_0_sw_init(void *handle)
 		bitmap_or(adev->vmhubs_mask, adev->vmhubs_mask, &inst_mask, 32);
 
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
+		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
 	default:
 		break;
-- 
2.35.1

