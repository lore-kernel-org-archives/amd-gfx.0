Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4BE9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:47:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6967410F431;
	Tue,  3 May 2022 20:47:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C189A10F431
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ara6nQgjup1kDCgM7jH/HnR1jdgMCeN9lfbFL8DIaib8ZfMnhMFACXdSmt04lzojMsHaC8sYL7y3Q32YfooNlVBcOXDcvlOjzZor00P8BOYFXMNexpVcNkSYp+++o0tfgTEp6ZFXinCS/qcXSat40N698WA4cy9ebqJQhHas3Xpr3Diq7Y6jUPcEL5aLx1K1+PHBgq+ZCkgLs/qhMEaxtKnyL4zHDgM9Jt7h3GQOSlXcKxG69WRuDIn3lwp8R6X/xHhTo+dJxZ49GD6og6KMFbKG+/PKPE+9GiOPkdFSMAMl/0jmjYe+b1a2JZWl66CCJZr3lEQNBoJuN0iCMMnYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKU55iOTiwa2rFkbJk65xq3KPBe5HGD2BItWuhQ9TyI=;
 b=h44QShMelPKunZX6LmXOTNykq5jt5tsHlC8yHpebQ0XZ2mvfke/BZmG5ph+DM2hNduWO/huTqLVjcTDhBRvm9nxty1GYfreXWyogGJjZUuKUcDRrBLqIaMvPzJMOProdSXhb8FmNuKYuQyrrbGC5RI3ObUPgLyRpYkg9SUe0tf82+CIil6xbAJZema9DvdZCnK42iMinQvDtUJvUd9w1J0yM2XDUA9eyWCswWEcRil3836dK4EVr4TL0OPeZ0xCEQmXLglf4kJRmr67Noaps9Am0UmEOvis8nm/JJ33oBs+lWVPvAQ7erhlxLChmOA01RumfcgaILVu97J9n9M9faQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKU55iOTiwa2rFkbJk65xq3KPBe5HGD2BItWuhQ9TyI=;
 b=Bu3+7PGERz5j97oHZneQlebLzfUbje8pAV/KkUYw1QO635BH0/W8WpxEm6fdplaOUYYQXePb5mEOW9iN8tkgC+DD0fCfaGHeXIF4ocL1gqHfhqX+htK/Gl3q9PhhCgy0ZX96ZqNvF2LYeku/o2TIsnfFyczdySAtJhwvJlN4lyc=
Received: from DS7PR03CA0136.namprd03.prod.outlook.com (2603:10b6:5:3b4::21)
 by BN6PR12MB1505.namprd12.prod.outlook.com (2603:10b6:405:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Tue, 3 May
 2022 20:47:05 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::99) by DS7PR03CA0136.outlook.office365.com
 (2603:10b6:5:3b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 20:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:47:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:46:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu/discovery: add HDP v5.2.1 into the IP
 discovery list
Date: Tue, 3 May 2022 16:46:45 -0400
Message-ID: <20220503204645.1266993-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503204645.1266993-1-alexander.deucher@amd.com>
References: <20220503204645.1266993-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1efeebf1-dfce-4080-6859-08da2d461515
X-MS-TrafficTypeDiagnostic: BN6PR12MB1505:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1505FE76EE2FD6E94EA43842F7C09@BN6PR12MB1505.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xM0Su/uPSnJ4pl5MJRpjCTKD+UrLKp68RzPCEgpZkn3i7dP85L1gvyIQts7+tUdKnZa/WSs+arh+vP+3fot8/mV9zsNUxnbblmb7URAaHGKsgg7f+t2U4a6p50Jv3uKK9UAqjgKyNYFHzaEBGqgzUzAj2Gs7TLLsI3lDAIvCigk2vn5Bi5bJmNEiR2VabYqRpxalO3gPBiKQA4FIZuwT3gbMJty6w5B9gJbQnowS4S+sN/RjNkmrQql77NDm5+2HizBt81kKk2PcP+TuURG019G9HWNH0T7oQ2S5Bd8ARF5iw/koNTLUpOZNjzTuYTi7n28EHFdNiX0MgrQ7SYvVPTuIW6xwxsl7NBn4L2N+g6EqM8vh53YWoNQuiVzqiguDTGtcll/mhE2tI5m8yPEgfTCvPEjHplkjR5d/oHt0NO4twy051NvPSV4VwnSapxIgcv7zn/TUzgLU1sZ7Qh8fuNY43JkDocBtURp/a+VcQXBANR2dMtlNZaorfA/11O6K+IjaXu4l3OzlFObDyBcHhyjZAYARgEU4oPDal5OL+5+DVtvImPg53cM2q5Up59TLa8eHoIBfypszq0rCuKPekHa27o7gS+crVaSNbgKzPH+g4EBg/twCbfls5SnAsCQreRvGdqhUmFrFW/09BdSf/W8Mia2wDpnFX2TgHi1pyJfi9p/y7ohi025BQmBMqdVniQ0qDPSik9imtj86Nx1YVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(26005)(6666004)(5660300002)(356005)(54906003)(2906002)(7696005)(6916009)(8936002)(36756003)(2616005)(1076003)(336012)(426003)(47076005)(83380400001)(16526019)(186003)(82310400005)(508600001)(36860700001)(70206006)(70586007)(81166007)(86362001)(316002)(4326008)(8676002)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:47:05.0094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1efeebf1-dfce-4080-6859-08da2d461515
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1505
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
 Xiaojian Du <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaojian Du <Xiaojian.Du@amd.com>

This patch is to add HDP v5.2.1 in the IP discovery list.

Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 2188b9277a6d..50cf5c27f3b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -55,6 +55,7 @@
 #include "nbio_v7_2.h"
 #include "nbio_v7_7.h"
 #include "hdp_v5_0.h"
+#include "hdp_v5_2.h"
 #include "hdp_v6_0.h"
 #include "nv.h"
 #include "soc21.h"
@@ -2228,6 +2229,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(5, 2, 0):
 		adev->hdp.funcs = &hdp_v5_0_funcs;
 		break;
+	case IP_VERSION(5, 2, 1):
+		adev->hdp.funcs = &hdp_v5_2_funcs;
+		break;
 	case IP_VERSION(6, 0, 0):
 	case IP_VERSION(6, 0, 1):
 		adev->hdp.funcs = &hdp_v6_0_funcs;
-- 
2.35.1

