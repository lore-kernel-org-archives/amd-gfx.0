Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFB3C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  3 May 2022 20:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C51010F37B;
	Tue,  3 May 2022 20:29:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32E2F10EE60
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 May 2022 20:29:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UckpSw6n5TifWUTVs/ASJDJrGhVy6lWkc2gvb3kMVZFyW+8EldDv4pueNd2idNM1PWSmb68ab4iPTtWz8eZxr3Q6DvnrSso3lUBtxAkSfUPadtBcqC4o60+v6XGIbTIPUA+WJPvbrb2nkOlis7V6v4DAG+cLJbKQxIeBm/Qz/EhNvi0AtdwBaHC9V0RdMeC42gxiTD375CMh6t7KyWlmv1OtwCtCK7qywT7dSosPKlhQDGbANe2NvSctFses3sx6+Ag3f2cnA7NelxnnCYxpF5cGH1wRF/f2l7MM4fG5XH1QsB105SvoXRXsz4hfiQo6ysaLC/dspk8mJzlLZqZuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKUndxxLY4zHYs8Acfe8RtoPp/sh7ilRwn1sshsO6Ng=;
 b=ApkhiMq1d+4PMP+/BUU7ByeXcQhWQ1MTuA7G3Ji9AtunykZrGs86JuOLQpDmUn7GCc7oqbCLAmEazBItYXBJn8EoLasDjdCDqr66mwLir2ah0wGbSvRdNhWlEGWOGFugRVXM2NqWleG80aUwOBeIGaTQm6yV+RidChGCGnd63dJsCnLVJAY4fG3jOWoeKGCh0IVpRsHcXGvHRm4kJpXaTIVGa+r4zi8ImhLw27+4ffKdgk1pJL/aHvZAjpWIjn4Eujj8g4iDfQU9nNR0JSncIjSx0kulPeDF7M0UQ8ZfI6RBrL3uB9QOH7O4jn2cIV4Hmce6dEOIm02F0WvQL1bHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKUndxxLY4zHYs8Acfe8RtoPp/sh7ilRwn1sshsO6Ng=;
 b=RtOJPOr6mlnMmRiiUPzi1yNBg72dSr9U/XcUT8IBi2+/oMNYpNJNrVXNjynZGDHI3mu2I+kE5KYkvWzdze9tJzMDK3K8uMuFTURgmsa1rMUWFQ3aiVogGLBZRbZiP9vt4DNgejhU/OP6K4rgMpHhhzeyLn5DbFGQZDSNtKy7QkI=
Received: from DM6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:333::14)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 20:29:34 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::f5) by DM6PR03CA0081.outlook.office365.com
 (2603:10b6:5:333::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Tue, 3 May 2022 20:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 20:29:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 3 May
 2022 15:29:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: add sdma 6.0.2 firware support
Date: Tue, 3 May 2022 16:29:01 -0400
Message-ID: <20220503202912.1211009-14-alexander.deucher@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: b7b12587-a13d-44bf-ca19-08da2d43a276
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5662:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5662FF234F5F05FE6F68C93AF7C09@SJ0PR12MB5662.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMIU61J1kpPxSTNicLhERQwZu9RzzedHv6aDSARRgnxrllISrPH/WSvxuRti2WSEXeg3s88HstSaS/SJb16oNS1x1e86KVrNgZOGlqX/vs+uoGPyd8uEm4XRsYIs+gYSexZKZ9LNA2oATGPHwAkt9LiXyWL5gLlZwtl+Szj3E9GjhK1pNi+JaPXlX3PmVW2gXNanc8XdEKuN9fPOYEycAxz5At11BszLdQuEpLmflV2U4KLrnwm8KRIS5dDH8eTqRS8+FxSbmg1tZzFYQnAuhUFMenInOC2W/D8t/CR/hXcHkrn52JeCSFN0/cegJU9tKQrLzmNmp2JtrPjKG+zkWsN6cPHFMe9w2pHgL5/KRTl1zAVGSkGhglkRbrjYWnX92MnjmENkZ2b48Uq+EfZ7TIx+eDWQOMlv/D+bQWC7mH6ZSLq38SyC/bOKn9ylSH0mCUMnbJc9IofGvzebYU1mbHlUnXf6BAq6IYRVZUyDz4WzOFt9W3WH4qodbB2VaonfDbEGmMHtx53sQXogqXCEBtFxqnziT+w7toDz3WOJXOLaVe/jlm2zAS6gTjVK1SLO7j0/Wzte75EFHYQ55DaBl1/vlpMy9MSOCImJyVCARfX0YzTCdH68mWcmGMhCcWWmp90//RbZ6tjzEVto0h5HrUPXF+hiFKiP+9gufiTmbI1H5l9QE828KwWDeYjFoA0tb92Gp1cWYjYninl4SqiwcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(1076003)(186003)(54906003)(8676002)(70206006)(6916009)(426003)(47076005)(40460700003)(336012)(36860700001)(86362001)(2906002)(4744005)(316002)(16526019)(4326008)(2616005)(8936002)(356005)(5660300002)(36756003)(70586007)(7696005)(26005)(81166007)(6666004)(82310400005)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 20:29:33.7005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b12587-a13d-44bf-ca19-08da2d43a276
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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

define sdma 6.0.2 firmware.

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Flora Cui <flora.cui@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index d1f2d804f928..7650c1e530a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -45,6 +45,7 @@
 #include "v11_structs.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_6_0_0.bin");
+MODULE_FIRMWARE("amdgpu/sdma_6_0_2.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA0_HYP_DEC_REG_START 0x5880
-- 
2.35.1

