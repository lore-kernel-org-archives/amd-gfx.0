Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07531E95A67
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Oct 2023 10:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6488910E0BD;
	Sun,  8 Oct 2023 10:06:55 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDDA10E0BD
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Oct 2023 10:06:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSgZNCHWmOpZe9DL7NxH7JangVrS/FB+tQ2A6MKNmCE7E7NjF74UC0/aOfwKBahCpSuZRBTByvzbOTdfyYjmlAXq6reC1+r6iYffNqJhWG0OZGbQw5MxRGqLcdnwK5s6AkOkucTvAMySpMjNdb5iCFAUvd0DNTgK0PvpBSHXs18Ovz9/YxEWOZwhvKwj6l5X6CNkuvSHwUAZE1UwMVVyu0HAJYvfbyXBfg8sSf/SYah7T6GFiNXBAGgqvUgOjhiDedNjBKCY8HZoErcgX7zYDEwV/kEHApKz+KG1b6x9mqHotMLehu7guI6GLdt+//0KNja9Si1FCWbZUOT5mP7FBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JyaO1255F+9wTqmgPfemAVyk0IVaDAUzJ6M6Cd6NnoA=;
 b=IimbimVoAylZVhls63EiJBjWVxTDasjbDdbnzQ1ltihb/1DmwH8r9fX5rOOa1LjZ7khRQAu+m3K+fRZVGHjI9KTnh7z7ql7d9mX4pBrwMPoymdy900nlFGehc4FSguiaCBmRCgLqgW/siJjWK6/pYJA/NfeHU0gbPERfJ1ysTk1cCP7EKdLNeUwZL05PgELnIV9k2wkJo+h77Yt5NVB0zOVUPDURYR02vZfr7ZpzlIlMioxK6aMBrTr6Su/UgsnjtlcwqJ3bl8JJoZ2I/O0SNTPwgq3XHwmRTx2q9F1XnNtAiZqc8wQ8sg/mrI0U4cj3iMmezAa0lFbIDl56jg5yHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JyaO1255F+9wTqmgPfemAVyk0IVaDAUzJ6M6Cd6NnoA=;
 b=o7LrAkXLBa2gsqGjRs3pNxYFZGSmqFThvK4FmqXDUeR5nto6+j9hjaOFyPcFdAfbHq2RtOxzfL9dsVtxffsmw2jkdZrGEbK6yfwPyImFtX69MyNp/V0T03SHLcnbqSl83Fgaf1U5YK2BPV8sseSp7XO3wMI3Ms5KGvbCnFpXXqY=
Received: from SJ0PR03CA0374.namprd03.prod.outlook.com (2603:10b6:a03:3a1::19)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 10:06:51 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::bf) by SJ0PR03CA0374.outlook.office365.com
 (2603:10b6:a03:3a1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Sun, 8 Oct 2023 10:06:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.2 via Frontend Transport; Sun, 8 Oct 2023 10:06:50 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 05:06:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 8 Oct
 2023 03:06:49 -0700
Received: from fc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sun, 8 Oct 2023 05:06:48 -0500
From: Feifei Xu <Feifei.Xu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu:Check gfx poweron when skip flush_gpu_tlb
Date: Sun, 8 Oct 2023 18:06:42 +0800
Message-ID: <20231008100642.1915677-1-Feifei.Xu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: a398dbde-e298-417e-8e6c-08dbc7e64a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GB9yxHawqCqYMIZAb7JniG8HoUDGrkj5Vep7vTf3LcVVIiu1/ysLHmLiXHbyHk01mAPgg3k+bA69Jlxevq+zwTZZW2O114uuAxf/CF6DSL6HlvSe2rZD9NoQiV0KT0dw6xY2Odt29m9uy53V8Qh6qso+02jmUFlL/cTdsfautFGzoQoDRvxuKFxq99rQrDk6vWhuMSYuRSvXaD2LBYcYurHfAZhTxQ69IQmWJEEGbSXViuR3pzCP55+YTcfZMc2fUIRN5Bi1N0EXK4ljkueswWwpwd9c1hyI8357uhv5DlykcrCIYzi0x7EeZbOJvmsXYIVfBf8xP1Yg32G4Uac7A4ulMpg5u3W9yW9zJ91s65nx9Jb081USbUGnlr/+RG0L0GhFVCvqwo5a0PosLU39Kdo9ARaNRMUUs5YkXGxPzAvtuOxil7V2dwdl8pIixbu6t4t6rzwa6Z6RqWTxlxqQ0305933cmNkV+Wk1PRmIdkFEga6THV17XYyliaRtzKJm/nZVeclAbDSMVBwlwha38GhpPhKqZ8jhMH1CVDczJcTmY/qcdaovkdZQd9F2p57FjEUx/d0X4JVrL3SP1hNwOtCd1XnqK0jrRgHDlvdcfX5oVFTb/+ry7TGjiOD7dxw8If2EFbpEw4cTVW3rT9XzqHw/ZbvNzemuEwgNqQg+Am3w/SdzyLF6+xqror8kbF5Odmd+8TDtoAh9vKXgfSHc3wsTc8r55lnMHct9znI0gYBvGWrieaoTuHB7dNk1x/++vigM/5LhPBG6H30ojDqhsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(1800799009)(186009)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(83380400001)(1076003)(2616005)(336012)(426003)(26005)(47076005)(36860700001)(54906003)(70206006)(70586007)(316002)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(7696005)(6666004)(2906002)(478600001)(82740400003)(36756003)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 10:06:50.7355 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a398dbde-e298-417e-8e6c-08dbc7e64a7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, feifxu@amd.com, christian.koenig@amd.com,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fix the gpu recovery failed on GFX11 with gfxhub pagefault,
flush gpu tlb after reset on GFX11.
Gfxhub tlb flush need check if adev->gfx.is_poweron set.

Fixes: d0c860f33553 ("drm/amdgpu: rework lock handling for flush_tlb v2")

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2f9bb86edd71..048d32edee88 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -611,8 +611,9 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		/*
 		 * A GPU reset should flush all TLBs anyway, so no need to do
 		 * this while one is ongoing.
+		 * For GFX11, gfxhub flush check if adev->gfx.is_poweron is set.
 		 */
-		if (!down_read_trylock(&adev->reset_domain->sem))
+		if (!down_read_trylock(&adev->reset_domain->sem) && !adev->gfx.is_poweron)
 			return;
 
 		if (adev->gmc.flush_tlb_needs_extra_type_2)
-- 
2.34.1

