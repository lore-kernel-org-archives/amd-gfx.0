Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BE0C77B7A
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 19:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 408EB10E0A5;
	Mon, 29 May 2023 19:22:23 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CB8110E0A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 19:22:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DioEZk7Uw6pH6w8FZm6rxGw0I5kECvACOfm8d8MmuqaiikTrPVb76khKPdmyo87Ca2TPgKlyvs3UVfVpAyDxVledlIm9Kwk9itLPaCdfw8aRuz45eyreHnrz9X4iSkrwJNOJIm6EUt9t2BHlAnK/iydu1/MzMmwf/nutAv169k572F3Z9PCdX8EoqPf9C9om2jCY1688cPYqHnF8iAdWmQ9k4l7mkLOW7mcroDK3TPZr+RflM3a4vDOGaqc/tFXLfq3G017pSCCy7QiDcPavizDRPEXkdxdfyEFkggb8KNC2yokZDL3tXWMnNopITpe9BMf4n6nmzuG8m8qrq9dqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEvEfw8F86FO0aYTDw5i7izVSPW6wFGMunKtBElUlKA=;
 b=DXsoLkVJJc4rhZzfAyBs7n/cZJygrVYBw0R/LGejTgA4WBbYR+LvPh0U9PcCB6WF8sbMh8ApoIYjKmqkYZDod2Zadj48AUkTDBTK9qjLSQI64JUbKhkIKR40E5jV1P8PfRnBQksMCdoSzy79G7QBVRMSoni8B0da54niwaeV/wfULbEcDDIVbITJsmZahGQ9bf/hsOE/QWmGiV5cgDg/fzLbi3Y7rUJoXzN0DnpcMId+tsXTz7YtKyFBbe9HDvRak3x2a546uv41uI0UPOHXy6A01Zu6j9SeQoX0gm3WXvy6jEZnVjtdKtJ37hVN04aaqHoeFLB7d4QdekYMrO0usg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEvEfw8F86FO0aYTDw5i7izVSPW6wFGMunKtBElUlKA=;
 b=cx2GNfRAX3RJOc0fSWjxTUx2mh0bfmu2K3/DlmElytuR3CheCX6EVQzvrum0LdzS6BhqYCJzNXIOAEn23K/LusPIlGVurXpP4inrz4hNX/RYvudQmfCbo4+y299JYTWaxEkeKLs7yIGQ48qI16YXTqmeflQQQ+lFjWmfSiBdmf0=
Received: from BYAPR06CA0004.namprd06.prod.outlook.com (2603:10b6:a03:d4::17)
 by SA3PR12MB9226.namprd12.prod.outlook.com (2603:10b6:806:396::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Mon, 29 May
 2023 19:22:18 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:d4:cafe::bd) by BYAPR06CA0004.outlook.office365.com
 (2603:10b6:a03:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 19:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 19:22:17 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 14:22:15 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix create_dmamap_sg_bo kdoc warnings
Date: Tue, 30 May 2023 00:52:01 +0530
Message-ID: <20230529192201.2133174-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT093:EE_|SA3PR12MB9226:EE_
X-MS-Office365-Filtering-Correlation-Id: 2916eba3-6065-4499-d0a2-08db607a046d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nHZMIF6R+gti3mOARaUhxt6NvDgcHcLSJEQbgSwEIfIr1Y5+Nz1eaBRDww6Bplq89Xwyfy7eODmbXsfBqPCftGUC1KLMlJIvn5zktFtM66VKxk7dKiXllgUuzBWnLv7s9cwkKrsyyjYyk7YtTtgNFwKRbdZJ/L4h/yMONodKWVRiTEY4KmZENnZ3uXXTyrv7OXAyoAd+AQMd9KPhOWtfe2+sXnA0aBngImEMC8FQ7kG0v1i+tTuz2zzf8Lw1ffR+Xp3YwSfZL5KPGRIk2ictY70DPAxibR6dwqWZw4ixml6c/0xYOlK5lrnAGEXLYz0ttBY9784hwYvOQQVJd6EGGtEwLDgm0TlDN/feCNPQogo4VSzsAJJ7fYBm9KMTGZ7ZJxNJE4NJv8lVp5iQvi5miWGxzsw2iRYZQ4HvRR7k2VIqQ/sZcurVXFe8Jn7OYhFM4gK4vEkiHvyV/GQWIoj9+5lP97OBLBueNxHiN6GgUK/eBiRqSENvLws3mmbB6VdxKX+Phu5RuvuTKx73UGZjsYuiil9DfJbIftNRKI/EMKQvL45o6MX1u9vd4dbAtPk7xmDemCwzMgWTN6QJNdX9EpwRu+EG3uf3sKqpewdYWUHgxcfDWbGTF6FoBjXdV1Up/Ui8Fxf++r5ss0jOa2F3bvJbBQLH2L4zhzydHv9F02Lpfsnfp6FXFadSalfBwklzEYXUkvkEePjR5g+5mzWI9ktWJsWXIM0u6Joji/Ctq7YMxbQ0Q3o3VH5n+AdXnj/VmrCBKOkB45FlMVgau2TaTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(316002)(6666004)(82740400003)(356005)(81166007)(6636002)(4326008)(16526019)(86362001)(2906002)(82310400005)(8936002)(8676002)(7696005)(2616005)(70586007)(70206006)(110136005)(36756003)(54906003)(44832011)(1076003)(26005)(83380400001)(478600001)(336012)(426003)(66574015)(47076005)(40480700001)(5660300002)(186003)(40460700003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 19:22:17.8858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2916eba3-6065-4499-d0a2-08db607a046d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9226
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

Fix the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:292: warning: Cannot understand  * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information

Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2:
 - Fix "@create_dmamap_sg_bo:" format (Felix)

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index cd5d7a39ad0c..e73cbe126286 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -292,8 +292,9 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo)
 }
 
 /**
- * @create_dmamap_sg_bo: Creates a amdgpu_bo object to reflect information
+ * create_dmamap_sg_bo() - Creates a amdgpu_bo object to reflect information
  * about USERPTR or DOOREBELL or MMIO BO.
+ *
  * @adev: Device for which dmamap BO is being created
  * @mem: BO of peer device that is being DMA mapped. Provides parameters
  *	 in building the dmamap BO
-- 
2.25.1

