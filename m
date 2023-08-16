Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8340AC001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB26B10E2E6;
	Wed, 16 Aug 2023 06:19:34 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839F910E2DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnks8VboThiDR7x5yFXvGf4MPSmV1dOlsUo1c7dnwMeOQvsFvgeOCw3SRnOZbnRK+whnGE4FfEU9r9prKiJBjryuxNVh44H+HXatOrEjk4sTksSnofVBXcU/LkxdfN3Q03V9tkLmLwUVfeJu6cVD5pznxdTWQjElspzkogy9WHhZpjAW44RKT4zZn+gjvbo2S6bV2Uywnu3VgWfyoEXaSQu8hjcj49TiYc6u/4/+88KUcCqQcUL4R+GCN3JEy0V+5+zNWLKqMQteQRrjNVuFg56vzomYYr6HwOU8pWQWYpHGp540eFs0T/vZHYqzUYqwKCa4NbDm0Smo2kd3hD15og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOpi9etu64Axj2/jFwHQcxuzVkW7SO2C9fnDCYqf7ZY=;
 b=UYst/QvvmdYXZqP/t29J+5w2MfMlffOpscpWzG122I9qdwOqIw9W4IFQefdp7k9BCLt3G/M/Jo8KcW4gi1xRX1e/cxdP4+ey1CRWFXcGQNyaljYYuVZJ34Tfu0WD6xCtZHAIo9yzm58TyBYjPf2r/mvowuCMeAojFUK8qBguICw6/DxfE+4LZQQ6oUevs8UyEkbA8dmC/D3A18HpFD6ckIaKGJoXnKbwR4te7P8HZ3punWraqmcH9bDoI92wnGE+lA+qEqIONXyMrgsn3Zm3Ze5twpkSgA0Wtjh/ddWLv7xHwIH3Fqj6ebfGmtF3EBo+GV0FpPK9Qn45JesVw1DDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOpi9etu64Axj2/jFwHQcxuzVkW7SO2C9fnDCYqf7ZY=;
 b=ayxkUGV7yn19r7lMgJ9itZDDAn+NWJ0VEuaCjHcBkcrmZmDwSIA5lRZFfPZ72sP50Iq60pnt+f4tYgVhoQ06x8/7lm16s5TGh2MiB2UUm38m/mGwmtxapJq5pkYbqy83VoUeVrcTiPQabjV+moFH/9FcqzJDKWmAt/riAyLW+sI=
Received: from MW4PR03CA0268.namprd03.prod.outlook.com (2603:10b6:303:b4::33)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:19:29 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::c2) by MW4PR03CA0268.outlook.office365.com
 (2603:10b6:303:b4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 06:19:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:19:29 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:19:25 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>, Guchun Chen <guchun.chen@amd.com>,
 "Hamza Mahfooz" <hamza.mahfooz@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 1/3] drm/amd/display: Update ternary operator with min() in
 'do_aquire_global_lock'
Date: Wed, 16 Aug 2023 11:48:53 +0530
Message-ID: <20230816061855.695281-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
References: <20230816061855.695281-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SA0PR12MB4559:EE_
X-MS-Office365-Filtering-Correlation-Id: fa196387-8098-4436-b0b3-08db9e20bf9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WKhe1lCM6iQZZUOGNtSN13ab8P9UlsH5yQcPX7CuRzt13TMiPfdAK6HUSAB9g9oxqLSnvRrQiE9YYYbVM/j6Q3uTGnhG9V6j/85yGm+s4JioOJ3UV3b3GcB3wTRvsehYYivicsn/S2g+7bNNST3lhXSTPaXZCNQ1Qj5p6evrtos1vZ9jOWHV0Ov3fC5n8lBooLjHlgUV+xYRvTL3h+BE6qk/wRSOHLWrCtjZOkwmXN2+aKwsicMv7LmFFFLS8twmunlN6F56NRmT8fJxtPirg3XSFt/IX7FWWHFashehJr6XokUodOxGyiKOVinNbEd0ct62kTNXj5SgBuVjGptywG9JNHAwDbC8mOO3+zZX5xRg7jpvRLXFCpS+yKseoN2YU97WYokn0ojLdcfJGeS23PqRaOZCfC4HUi3NFhyQh06M4tNrbRHhtPBzZULVHGFBvIDQzUXVvL/bTLRDZbXOA0qfsZMpiNDN7RtNPpodVqcgMIX4rxiBgy30/BUjIeT4+c8X5z3hww6OPexKRhc4kfb0fspmcZ8pwSCT8sP4AUh3SdDc03p9Tb9K6SsEAkvAjgRvFHkW4W/hDdFQCejIpXS8ve5zSmoDwiGGAX4ur1YEfiPTD3dGS/wT4jWIlBsMfviaEOTC4Qfjb5TVNAF8vQNHs7R065MQrhTGtstx6T3Z0fxM36QspJmrx5j5K67RkE795dATfNILthL2HApJpFHATtgsaxYl8cFleLINsIZrUuIxZ3mftZjT3ab8pMRQ8Pwnwp+47MDpQEIcnvUVXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(16526019)(1076003)(336012)(426003)(26005)(110136005)(5660300002)(2616005)(83380400001)(6636002)(41300700001)(316002)(66574015)(47076005)(44832011)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:19:29.2263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa196387-8098-4436-b0b3-08db9e20bf9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following coccicheck:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:9079:12-13: WARNING opportunity for min()

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b1245b732cc9..fa36fc4dfc50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9076,7 +9076,7 @@ static int do_aquire_global_lock(struct drm_device *dev,
 		drm_crtc_commit_put(commit);
 	}
 
-	return ret < 0 ? ret : 0;
+	return min(ret, (long)0);
 }
 
 static void get_freesync_config_for_crtc(
-- 
2.25.1

