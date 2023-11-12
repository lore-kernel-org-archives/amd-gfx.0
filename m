Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28090C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 04:26:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17EA310E2EC;
	Sun, 12 Nov 2023 04:26:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583F010E111
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 04:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS9gmTGRr6v4rmpneSFPLy+GuhIcCIec4maJKKc+isVRVF5vM79D2nvP8AjINFBwiZwbKT0pt8UPw5SvHVyaFdW/b0JdIhnBykJJEqtvf6R5iWJ8izqVPD7Fcgtosu7B6jCjZ09lccY+vfHISkgHnafOzTxVTQMiOEwdgpwCtqpcopY66KMYEXfUjJCLk/amjvFS+CKacr5xcOetKgvqvhxspiXHFfwQ3JXzWpdXQeRmvCO4lmEkk2R8YP8RC+YoG+nbSi0OwMwOr8yp+pzhAyPkYRLsiypveN/dUklsVDQGjou58MPsoMpuYq/f8mefs8+mWL04gEnO0KWlJ05BkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eDGS4CBhyzlC/yDA0iua0txhB+R9V1E9I8oiTG4IGA=;
 b=NJlw9C+IaYMoRj2A6VOxg+snW8N88HDVxJU10etT9/1VZeC6HuMpoDPG6kzXinYeUmFLGhSkyK/xkLKdxjSQ6g49Kn07MiG45Ul8UX1LLnx9M2UB8+KsUAEUKhK/NRAcl5DrPJx11AUzQaGSPVmvQczGEIEvMi6Vsw70CGzM7McygorFWk7PSOYXStauVS59ZbYu+Me04OyTy3pZ+njE06QJUL+bZ89YU9ySkcujWDEu9idKESShQjxf76NeZa1ADqke9YTuuafGCvi1kpcuSCPdf3i/Lp6uYogw63IdGQIuSo+RtLHIkN93Iz0UYjwpXyBnUjr8CSTmbfUPX3ScZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eDGS4CBhyzlC/yDA0iua0txhB+R9V1E9I8oiTG4IGA=;
 b=PlJmRzzp6XpSAwQIJQBRJwSaM8UDFiaJpinklekN93FV9pOtWyBouqw/uyOLluXWuIZ49Z17LLnz4BoGUY/lgEltgq/U3nJa3oDLSgGpcjaKlY+Xx8mtGrx8CP2bV+R2cJ8+opMRv70rDhdrPV3rBm0A9A/0XO3z+tBs9SYg45k=
Received: from DS7PR06CA0027.namprd06.prod.outlook.com (2603:10b6:8:54::6) by
 LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.26; Sun, 12 Nov
 2023 04:26:29 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::49) by DS7PR06CA0027.outlook.office365.com
 (2603:10b6:8:54::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.28 via Frontend
 Transport; Sun, 12 Nov 2023 04:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Sun, 12 Nov 2023 04:26:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 11 Nov 2023 22:26:19 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Address member 'ring' not described in 'amdgpu_
 vce, uvd_entity_init()'
Date: Sun, 12 Nov 2023 09:55:59 +0530
Message-ID: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 10cc3386-71d1-441e-2172-08dbe3378a86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +m4Ihka8f9VP1+mf5zW4qZbVAIVUhG4ohBNliexSjCQr9KLLtd/wrjgb8Ut30tchLUay6j/vWLNi0H+UhydkwAQsb4rUes9Ck2YPh57u9lblCVvr/nxJGYXlzc3As3UGH6jwbXcHJQXEb18vPDyinH5hsC0MogaTe3qQo0nBTNb0vtI4cQSBYsEZzTd1aQ6uHACo7MqQiVpuRaV++l6N4eYVUtwvGqn0jJTNQ/lJlx7A1Xu5QM3B8zwzOxrPL9bFZcPOqdcoBP/1KwexrlzXOvFPhDv59RzZl/kdixgKc42r0QtXQRPaedy8wK7dHPPHfObeYfHRG9zTQz2i7o0XbPE3iXG9vrERYi7RdcLm0X/vzlCYgUrH2QmOIqy7NChkdFjxrTGy+wgKSq4EfXnY9rBXyuyAqPyuHv+7DunRs97HHab47Ia4ZSbVtDggop1x19pAS3PR/Ac1Cl4i7SDkGUzGbJraWfgXZFQhi2ckEeFtEljU/PQEwQZZ2gpOmNTrIcX2xkOWE0B7/r73gkpFnuF/v2PynKPQsLJ88JoqwVB8dnNn57sq6sO/qKHTfRmHMZ6E6XJelLvXnF/HhYQa20TwAs2xPa4LDCZbxfZyoD2yI7/W652I9IyUmYuFrGwARShqpJV8n7V12SF8gBfHsnwbo1xWpzRDwvkXhgNkIMUtwABHmqeg1lQxmjJRT8V8XxcveZBp1i/eUzLOWJ4qdZIp4kiZUfK9GBE4eMkuPd5HXgQ8DDDuZLHRc2GI13dIiiEAV7x6LofMhWfZLXxGYUNp4AE5z7YvjrZSbqVcFLCLbVs5LsyZIF5QTOvIXprp
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(64100799003)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(16526019)(336012)(426003)(1076003)(26005)(66574015)(7696005)(6666004)(2616005)(36860700001)(83380400001)(47076005)(44832011)(5660300002)(4326008)(8936002)(8676002)(2906002)(41300700001)(478600001)(316002)(6636002)(110136005)(54906003)(70206006)(70586007)(36756003)(86362001)(82740400003)(356005)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2023 04:26:21.3246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cc3386-71d1-441e-2172-08dbe3378a86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following:

drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:237: warning: Function parameter or member 'ring' not described in 'amdgpu_vce_entity_init'
drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:405: warning: Function parameter or member 'ring' not described in 'amdgpu_uvd_entity_init'

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 65949cc7abb9..354317c9e47a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -398,6 +398,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
  * amdgpu_uvd_entity_init - init entity
  *
  * @adev: amdgpu_device pointer
+ * @ring: UVD scheduling entity on ring
  *
  * Initialize the entity used for handle management in the kernel driver.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 0954447f689d..578c5c90448f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -230,6 +230,7 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
  * amdgpu_vce_entity_init - init entity
  *
  * @adev: amdgpu_device pointer
+ * @ring: VCE scheduling entity on ring
  *
  * Initialize the entity used for handle management in the kernel driver.
  */
-- 
2.34.1

