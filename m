Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7F9FA3741
	for <amd-gfx@archiver.kernel.org>; Sat, 29 Oct 2022 00:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 296D210E90B;
	Sat, 29 Oct 2022 00:27:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80BF210E90B
 for <amd-gfx@lists.freedesktop.org>; Sat, 29 Oct 2022 00:26:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdTCX2ciHbbDZBKYSRfHQDaGTXxs/ttLvl/qIokIow0apBB0pyGBp/YnIoLFtQPvfOkAEe7Uwo618HfEvN3XMyFJPNyX7l95LVnMDFzSfv1pLO6lSAPdLDJUvIl3rsDG1Q4eTLeVa35nnk+mvct/IyXTWYOz9Ag7D9cXMtEQXTRMNa7U//7wDiQaid6jpkYYhqv0xfOovJAMXLjOK7r5bCNoFzR6SNyoJx34GpaTnne/r3RhFeDy0nBe4HtMOBu89orkankPVhOVqR7k3t1c7L2RYH/rR46XpnSw1bDhCJ6CwD8RVtsOp8vR7WkhmMCROD2Nesz0vS38hguJGKixVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmXVfiLRI0KZaRwD593dXG74G4BxX7X362Jih0a1B9A=;
 b=Z8DTc8QqK42+aw8iF8l/vKT83WHOA8UFw+9KbN5ibMBKkIv5jDXGX2F2NjCEWEaks2POEmQjP2ybmD59QpmXDteCBGPBdSImWG8xpkQqX7F0qIpGYKfwGSCiGDJFU20ZMH81XN4KN9Gmj1mIxexKaTbx9lVXE2tE/Wt02yh1PKFhM6FmXto2XJVXN6rCObLnRCCClto84Z/NLLmGonhyj1+38uDiiTI8t7Oa2o1Byc/x1DskTux4owi/7L/kWxxQoMWPmV6XbmcZUGqKcEQMezCM4t+DXpqi4O8u7ljHIcUL0X+6wAXcKkN0yHVY9jcCuRSa2xB+9NbCsatpKJFcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kmXVfiLRI0KZaRwD593dXG74G4BxX7X362Jih0a1B9A=;
 b=gRRkkMRHzKPA4cqT7MfwvFBO6bz0WHBrzZpAj3kR5e/02ZfvJoiqXcMeUqSnouw2NV5R4HFr4VdJycaSRhx6PkHmmIRLHV26LVbzP+umMc/KGd/HhsneKx0tboXxThaCy94RkVVClVsrRgBE3tKX3WBOE2yyXpYzS4Ll8rxmpZE=
Received: from BN9PR03CA0481.namprd03.prod.outlook.com (2603:10b6:408:130::6)
 by PH7PR12MB5976.namprd12.prod.outlook.com (2603:10b6:510:1db::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Sat, 29 Oct
 2022 00:26:54 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::f3) by BN9PR03CA0481.outlook.office365.com
 (2603:10b6:408:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Sat, 29 Oct 2022 00:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Sat, 29 Oct 2022 00:26:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 19:26:53 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 19:26:52 -0500
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31
 via Frontend Transport; Fri, 28 Oct 2022 19:26:52 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Remove skiping userptr buffer mapping when mmu
 notifier marks it as invalid
Date: Fri, 28 Oct 2022 19:26:32 -0500
Message-ID: <20221029002632.729783-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|PH7PR12MB5976:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b16de4-8fab-4d1f-3085-08dab944478d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pOtsJPIT3n0N1S45gSEaatWtAWnN8Q7nKsqqrxNqN6nXKyMpbLlbH0cV/wcJR0WiSqjyj3qHmAouKHSrw+UkXiF0eFB7jM3gdtzRF9yEW9FGLrZcUeBl3ohe4LEOtrWFRTfvSM7fZcviZx7SKBvaN0aSkXGyl8Av3TSOGoO1+ej62NDvOiQ00yCtzzkDPBsPDBLzVX5RLzeJGU75/WiIFlfmZuSfuAbIqDU6HDAHNgnbbDmmyST31K7Dwn6XDZvguE14I8mA/Gi3H+gMdyVnyzb3NjcJtmCrSKZV6ALV4eqleeCgrsRGQru57GzbNsSkYExVf2LKtfkft9T0ELtVVsXxCmsF/gZcFPkFbnMJEQykeYdLZICMqoXTJZWxEBmhGQzRjkzIvyQ1CY/PyK4W5YoR8xLOh3UwiN83DAiBDNb7kVEfAUh2/6FdZCb/JNiVrP3fgtni08vRjin8X/QUo01iLcWAP5kdQKpMe3prFdYeylL+dh1+aHNrQPQZ5quLcS+av+0Fz0wSvt9QjPxNyUNisOjXhIAoY9b2n5uwir4gd72UDtJvSzWdPkfIMc8KKnj80aE8i0hFys4GiZXfu3yZCN/x2rD2VIS1Q9sTXuhb2it9MX7LLvxx/KBSKQLPzbo9tVcz85Pr3WfVU9XxxNRoWoQDvs2Ok4DqEY9EQ1OJfpKiUO73+/CHMs7jPrQCxbaGOHm82S37IjiEXpEtJ0mLw93N/ahFg08bR0bUNHqUeRhZqM6QIuC7AvQYUjHNRMnwTNFrsLpKwK6FQ8zqiebrO/lsg1BYDd3WGYmx2+nwkbEMJMxgdMh/zBjSBMmo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82310400005)(40460700003)(41300700001)(82740400003)(54906003)(6916009)(47076005)(40480700001)(356005)(316002)(8936002)(81166007)(8676002)(5660300002)(4326008)(70206006)(70586007)(86362001)(26005)(2906002)(83380400001)(426003)(6666004)(36860700001)(7696005)(2616005)(336012)(478600001)(186003)(36756003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2022 00:26:53.5227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b16de4-8fab-4d1f-3085-08dab944478d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5976
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
Cc: xiaogang.chen@amd.com, Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

mmu notifier does not always hold mm->sem during call back. That causes a race condition
between kfd userprt buffer mapping and mmu notifier which leds to gpu shadder or SDMA access
userptr buffer before it has been mapped to gpu VM. Always map userptr buffer to avoid that
though it may make some userprt buffers mapped two times.

Suggested-by:  Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index da9d475d7ef2..ba72a910d0d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1907,16 +1907,6 @@ int amdgpu_amdkfd_gpuvm_map_memory_to_gpu(
 	 */
 	mutex_lock(&mem->process_info->lock);
 
-	/* Lock mmap-sem. If we find an invalid userptr BO, we can be
-	 * sure that the MMU notifier is no longer running
-	 * concurrently and the queues are actually stopped
-	 */
-	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm)) {
-		mmap_write_lock(current->mm);
-		is_invalid_userptr = atomic_read(&mem->invalid);
-		mmap_write_unlock(current->mm);
-	}
-
 	mutex_lock(&mem->lock);
 
 	domain = mem->domain;
-- 
2.25.1

