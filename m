Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F75C7EE22
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1D710E3DA;
	Tue,  9 May 2023 22:06:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A887F10E3EF
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:06:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXQfpT21tI6BwUsw2bbBsXkfrMmFKacP4QUX5u5aPvuJKlcnGy6GxQEqbf3uYUf8bSEYoNTveK3w32RPi/uf1BCNres9DES8JvpofOgwHm/styYw8itEkgLS7e5DVx9wDmg3wS4e9Q63lyqVveWQ5M/oH446rinWIDw/xz3aH/no0peOy1lUj1U+TyyYGtG8/uQsVVOUeoi1+1b8BWrr+aGVTFwG+keUsfgiLKJPlJj0lHed5wvAkcKdw05Bk3omWS4hbGbfIbw+iHzB4yryVdlQ++mowOMKo00jxRbDLXY/keT/8pKz4A07eJbCoPTcYlpMoXAkNB58lRLzAQL6Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkTep6+HVQNjoA7hefsWyJO61ahncLNimhHDuYdLHE4=;
 b=gz4vP/+RemaGUZNERp0LsgCNA2dIQrUW5MZ7fVAB60EvdDk8WvoQKglL7wzRn6NDWcFeqjqPVpUDaZcEO9SYNP4zZz4jcETp9k/U5C4KG2kZjUHJK65yB4mKvCYVIVpHWkP5bsr/p35BfJ0h4aYycYHz/Tvc8R6rMHa/RBsE83lPNaLo9ha7j1At2eM7GzGRxKE+sVo2Je+Dj+6wSDdGbDLlCJURDuTOfIUAz4nRSuz9N7C/dqm3Fx8wndfOicxRlFNQz5hl/1qt1D/4seFcMIMnRUlUPun+uMakjWeBfkfR/KJCqAA69ITUD9MSQLkCMzgpYODQjPCG/sAegWFgUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkTep6+HVQNjoA7hefsWyJO61ahncLNimhHDuYdLHE4=;
 b=3SGLstcS+QjASJjD9k0vryzBiPBi3h062M2nxZznbFwf8BXXy3O2tYT2He46IACPk+FPIH0Vpi3Ei76uLc3OFG+5UVIks9phL34ColrWhjbYkIvbwu8F1wlJukqMJe+Uk1m/o0eDWSqZJ4hHyg0EwzzpkG+jqQ2k3jcAyH48gwY=
Received: from BN9PR03CA0261.namprd03.prod.outlook.com (2603:10b6:408:ff::26)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:06:00 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::ee) by BN9PR03CA0261.outlook.office365.com
 (2603:10b6:408:ff::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:06:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:05:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Increase Max GPU instance to 64
Date: Tue, 9 May 2023 18:05:42 -0400
Message-ID: <20230509220545.474998-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220545.474998-1-alexander.deucher@amd.com>
References: <20230509220545.474998-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aceecac-d957-4cc9-66cb-08db50d992aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rb0ZEFUQPQM2pEJPlDe3KC+3afuYNNClYi8Q8xgpivIYgKN7CNpHmaTweA4IOF5Ui3ZfILRndqX4LX94XbFkQs/bFYh+LDWu3H5jMblCRhjIexEEGeGdxoPGUgL/APSA1u4ROk0Q1mxiwG2KBBxnHmUWWkbePRSOYsdIE0vEkBlhzmb4gpMIdrBTT3igQpFkRWKDH05yYlc+DX8WgqH9JhbZe1ztSWTPXYCa5I8NU5Yr6HocI9JkwvyBJezTndawzlOXyR7hcyjtvwMThfXLE3M5Z/649KEocjXrS96Km7KW8TmnQ5g8xghACQqWZkq0smu5GiSp/0Eq+XJKkpcbdxemf+znJrro0/xCzvsdPMyj769M0EV1NoCl8eQBmtJHOdzQlqfyvjFTV5dj/p1nlg/rzcqaq2K5LlH5eAk2dowqgINcRTbt0hk2TWMFn3JElDoJcPp1VkSg304vrt/rPhBN8lOCy8hMBZUFHzSg8CrivHsYqWMGqz7mHCHj8d8dVeAInTmOvuTI39ETD//aFpz+sV/O/xxeDldt42ew1A5SfknlHfWxyvyGEZamRv5Fb9TfJl/VjAxXiL5M0lLwKPtkYGEMq5BigWsy0pPedU8/PxXDmippiKQaQMEwJM0MuZr4P8tHzzaAY/OJknzVsGhSaem+9jpcC26cXxntDEov7+3auoIZp905S48zOYxalV3ZpAMVsaP1zBiQDeu0ibl5Bs1XjSnR5l3ZPQOPjgg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(36860700001)(36756003)(40460700003)(6916009)(2906002)(4744005)(70206006)(5660300002)(40480700001)(316002)(8936002)(86362001)(8676002)(4326008)(356005)(70586007)(81166007)(41300700001)(82740400003)(426003)(47076005)(336012)(83380400001)(186003)(16526019)(1076003)(26005)(6666004)(2616005)(478600001)(7696005)(82310400005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:06:00.1354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aceecac-d957-4cc9-66cb-08db50d992aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Increase Max GPU instances to 64 to handle multi-socket
system with GFX 9.4.3 asic.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 85812d72ae7c..743fc5f137b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -109,7 +109,7 @@
 #include "amdgpu_mca.h"
 #include "amdgpu_ras.h"
 
-#define MAX_GPU_INSTANCE		16
+#define MAX_GPU_INSTANCE		64
 
 struct amdgpu_gpu_instance
 {
-- 
2.40.1

