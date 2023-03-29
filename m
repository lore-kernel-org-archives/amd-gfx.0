Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52D3C74A5B
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5018D10EC41;
	Wed, 29 Mar 2023 20:15:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82F6210EC39
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSv+WUrT5tJV00JH7c03U+mh5SCL7ogPbDZ2fCBYPzKEF8IFIWmSpJ+vNnQ3x2O0vFd+zWYLu2AAbuLxVzDuALsCQtYflcR1EFqnFIO4mEZfWUvxdi8w6mDZDEil7qNRqtXbS0qCUhqQhm3bDSP99TFkedv64o2R70ZH7K2VI1MpLhkdb+2OIwCjTB7r8CQQxuWbcKctvZjj2907Wr/c2+Q++btFA42+1IzCf5TjFyTQMslV/iGjd4Eo1nCILdN4F2c5Nhf9jI498EZhopSQY4euBsD4OOu9wJXuFU7hAQZi546CWvyQQqK7moRErvn0eSVpnZG7fLPooZ1ablIelg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFqmwPVG1pp6BphKxJTwTJygAlxAheAFwB9R9bxLTNk=;
 b=Qy88jpyKSOn8oLPfOxX+Dg5beEZNBcx/en5VZ3UOiMQDFAqXVx1rcCal6qWiLABNgvWyQPV7Q23CGcozZiRuRiFWmmTdqOpI2FdG+wKJeapyd5rzYu9Cx/8hnOXz12b1N0erGat2lfODQjMB5GpG03q65/DoFlJtEJBfrS3aTeVh5yQay+em6SAOUpucKCLlA2JS4mdfG1kPJ6avAMQyu4YnZ3h391Ykgv7P+j63Ujy1GwgAm15LdHrDwNIMxmdNtOiwtUWa3FEhNBoJOt+TI/ViW4HEG54ujmjDaVUo9nUnNVAbADKQermaU9gsjAn1vSK2w95+Lx6XQsfhjvyJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFqmwPVG1pp6BphKxJTwTJygAlxAheAFwB9R9bxLTNk=;
 b=vZKRBtcskEq5DpTUZRxgBK+V6dOzLQSSyfbgjfEwOIh837Aez4ylttiHSh5E9lTceGEPrRUO5q5MgmwuklnO1oCSjMUKP3NWCuJmBRAoApHhYlOiV33Ar7hchqOYBQwgjKtRIf3lwu3tZkQ/d9nVoNEjO27U1Z7hy5HbSmLBQUg=
Received: from MW2PR2101CA0015.namprd21.prod.outlook.com (2603:10b6:302:1::28)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:14:52 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::63) by MW2PR2101CA0015.outlook.office365.com
 (2603:10b6:302:1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amdgpu: Fix programming of initial XCP mode
Date: Wed, 29 Mar 2023 16:14:25 -0400
Message-ID: <20230329201426.1982669-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 11948e6b-2216-4106-8cb8-08db3092411f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dEu7Iri54TyojTJ9ywjZkKFPL+HA6b5pcT+idu6AXFWk1hWaEbz1i64GRbvaLbWcdSff5clf1gRtvsFFXyOfgLqYM/2QdJ2sD8GBWbTGDyynYYKqC5jTFCujf0Lg+xf2ntn4YJn2ZDbeCRby2gpvl4Q/O5WyWHD/Nqa1mK/1nFJpuIUwRRWeFo7UKqAS6MHto959oATw76LJnRKnLgo9/jad8js93h4gj1FKf61XPaJjzcc2hy+g0rW9HW9HpTVUUcq4zg1M68TrBICKLLPDZ1b5Obv8OVuPGFTp9MSwOK5gfLZEzstFMOyYtLG8SjLQB/x3lzPY/mh4id0QMEiWQa6WSuXxL2Ar8NsbRefcVpDxrQocj0WWbHLpUXezqYXwz1S24mnJbkPgcsv3zZiLEZ+zDMwghFweSA7WSZvnJiowVxM074VgIjpOoIssVYfxxWZIdeAbFEe0EpDPyxhFnk8zBvUZ7l/Fhp5yJ9rchRSCTbEJqA6MKB8br2Ea/bg/jrSq5AerqkicL2lZz/XzzhVRXbZy4E8e0j3NQr30BhJYOLxsPevvDHVoY13uSdJ9lcB8ev7tGUGV10r4OfeWFxP04Uk8kNavgsR33z6plRrLsdEXWrj1OqNlMfc6l861Vv4sBN+/KGSBMK8LJtq4heHMonKD5iZsJl2JsJdv9LIgEAf/BHXWYXw5FLdgfW/gy5OzSokCBjLssT9tMZSYAZ2LmCTTpHkDBGToAjnvk8Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(26005)(1076003)(478600001)(6916009)(316002)(54906003)(47076005)(16526019)(36860700001)(186003)(426003)(70206006)(70586007)(336012)(8676002)(83380400001)(2616005)(4326008)(41300700001)(356005)(5660300002)(2906002)(82740400003)(40460700003)(81166007)(8936002)(40480700001)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:51.7439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11948e6b-2216-4106-8cb8-08db3092411f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

On initialization set the partition mode correctly to SPX (default) or
any other user specified partition mode. Use switch_compute_partition
API so that all settings are initialized correctly.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 28 ++++++-------------------
 1 file changed, 6 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a2534ffc677e..c80d0c2954e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1897,6 +1897,11 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 				return r;
 		}
 
+		if (adev->gfx.partition_mode ==
+		    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
+			gfx_v9_4_3_switch_compute_partition(
+				adev, amdgpu_user_partt_mode);
+
 		/* set the virtual and physical id based on partition_mode */
 		gfx_v9_4_3_program_xcc_id(adev, i);
 
@@ -2118,28 +2123,7 @@ static int gfx_v9_4_3_early_init(void *handle)
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	adev->gfx.partition_mode = amdgpu_user_partt_mode;
-	/* calculate the num_xcc_in_xcp for the partition mode*/
-	switch (amdgpu_user_partt_mode) {
-	case AMDGPU_SPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = num_xcc;
-		break;
-	case AMDGPU_DPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = num_xcc / 2;
-		break;
-	case AMDGPU_TPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = num_xcc / 3;
-		break;
-	case AMDGPU_QPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = num_xcc / 4;
-		break;
-	case AMDGPU_CPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = 1;
-		break;
-	default:
-		adev->gfx.num_xcc_per_xcp = num_xcc;
-		break;
-	}
+	adev->gfx.partition_mode = AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE;
 
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
-- 
2.39.2

