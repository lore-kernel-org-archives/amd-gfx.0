Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40DCEC61D92
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 02:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B43910E5D0;
	Wed, 22 Nov 2023 02:51:59 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF64610E2EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 02:51:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=At7syYSY4ftHBsNHd7V/8XXWWG1zvxVwkmkRUCIkQR+62AZ7saqUbuJ7jBTITxt6rb29WROXGMF0NOMFW9pFFp2ZdVtFjsxlB60vl9bRL5fchXMFF1lL6nLQOoUSr9b6aA9DR77Nxm3LwSGrwuJxBdKzr2Isoe5YtjQUYcwjNETLammvbPoxkJJeBDioNHp72DUmfh/9A7oUhmor94tt7I8HIsRc0qvxK4Pcs4yPzxdruX5nC2ErDSZj+HBcKJggEXDi9hhXf8ApAZ7JNqCk2TCz8f8ylty/DnIVYXe2wbFP7yvnd0tZMPR4h7VqQfeAFqp/Azr1TtfoCBbRkJlSKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRi8ce3uFF6SzLzbwvlDCPE+ZaETa8TqR8PHFRABvso=;
 b=n6xgrnpxeFVEvrL58mF96RZm5T5J+p61IvzGOmA0v7nXDJOkFVMyD1bmXgOnAx3/DqwPahOdTYosQRxzbMzn6I3woWPEyjCZ40WAYLC+35hVRQQw1YpapgM3g1yjqIU3HiAHGRaVgz2wVK/g/5N0EvfCVHZJxKnwvJBAK3UCFPGVFVQFEjU2RPuOdAUtiJ9Ovy8LCeP0/RgOLlguqEM+fmOIrynKq+MnE1u9JMCW5bip7ozpl0lCtv+P3dSNDT4qD5o5UX/ql/kwvMYlYKBX2Ogp+F2kcSvuzWiYSUkdHBQxy3Gykb2X/3kfZbBaPv9QCEhxrkuVxu0o3r/xq1GJLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRi8ce3uFF6SzLzbwvlDCPE+ZaETa8TqR8PHFRABvso=;
 b=MLpEXaNXWKVC77KsIgoS6F0CKByW+DRD9BhzT2C9/Cg4pgUts/GKP5wBxf3zc1wFidNh8nzjuD2u9V/Fw9+hGnz0v5p6hRgZqXqQ4KIHjKNGN86/2uIndEuT95/BP39mTB3DaZClyztxQz09U/+mCrEU3pddYi/sTdFtlftPK9U=
Received: from CY8PR12CA0046.namprd12.prod.outlook.com (2603:10b6:930:49::24)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 02:51:53 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:930:49:cafe::67) by CY8PR12CA0046.outlook.office365.com
 (2603:10b6:930:49::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18 via Frontend
 Transport; Wed, 22 Nov 2023 02:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Wed, 22 Nov 2023 02:51:53 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 21 Nov
 2023 20:51:50 -0600
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: fix memory overflow in the IB test
Date: Wed, 22 Nov 2023 10:47:43 +0800
Message-ID: <20231122024743.707236-1-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|DS7PR12MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f15b8f6-69df-419b-b932-08dbeb05fba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vcApb797uJIcJRJJ3LbL1um42zG+Ao2CBgoJhDZnhivWblH/A6JGJ7cLdtvobTlkBbx7fJPApH100onIGsgU2b24eEIyx36SoUCkgLXvokjcsKKcuXIlYA71ZWq/y6uPq7gh0gGCJp070SewB3h5mD4xY5DIrJvMFvjPK3Hqw4hpgwrVPTVcIimItOGqhvL3n8y5DhYcGJoBl+UziOFFLKNmyz2up600sgtxS6nX/Cb8IMn/Hq+7FZlS5UlHBNKAbCjaynhoUT/YT4PQ3IzyqAIcjNmv6s/hsMzxh7ElhMQugjoLDLp21kqe1Y2A/LHEkCDb1D/IOW4sr2mrZREK4K8EVY6FWQLtcfl+hgHJfXXgz+qCcYt0qnFKKxHAMbaVjbBIHKXKqzeuy/rcJCdySuDmIH3DA75VhogU6sUrXD0Y10TiWRow6Mwz8yNrATf8zqnoZ9KR/uDugXhTGnzzj4JeesjaYtC79znZMUJWd1wCl7PwAMrhUXF3XQz5YBFmRnPLigW47RPL8aqc62hGb80KUiQuSY8N5gfuzZd/8/m3F82YF0TknMuM4jrq13h8SVyAWQH/5ETCvdKk0RlmSVbJBAuo1QE84HWVtgNB/hNAy/wbeYKc+V2y7wh219x8BRqTO178fYuCzbgJPy9okEDBWqveyApHGhgtJGdtsJGSuvWDdD7pZqxM1mqRwwchYmxkJNX9aPvcqTrMllHkZyFCiLRztx3H/eEMkJLAG0YJK6gOhQOmvmKlaaQryrXSrz9c+hdtNTChT9nN7v4PIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799012)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(336012)(82740400003)(426003)(83380400001)(478600001)(6666004)(7696005)(26005)(1076003)(40480700001)(16526019)(2616005)(8936002)(6916009)(8676002)(316002)(70206006)(4326008)(54906003)(70586007)(36860700001)(47076005)(5660300002)(356005)(81166007)(2906002)(40460700003)(41300700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 02:51:53.1007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f15b8f6-69df-419b-b932-08dbeb05fba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
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
Cc: Tim Huang <Tim.Huang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix a memory overflow issue in the gfx IB test
for some ASICs. At least 20 bytes are needed for
the IB test packet.

v2: correct code indentation errors. (Christian)

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 0c6133cc5e57..f281eecaeeec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -419,7 +419,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 		adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 		cpu_ptr = &adev->wb.wb[index];
 
-		r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
+		r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 		if (r) {
 			DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
 			goto err1;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 885ebd703260..1943beb135c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -883,8 +883,8 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index e3ff6e46f3f7..69c500910746 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1039,8 +1039,8 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
-					AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 40d06d32bb74..4a09cc0d8ce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -297,8 +297,8 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	gpu_addr = adev->wb.gpu_addr + (index * 4);
 	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
 	memset(&ib, 0, sizeof(ib));
-	r = amdgpu_ib_get(adev, NULL, 16,
-			  AMDGPU_IB_POOL_DIRECT, &ib);
+
+	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r)
 		goto err1;
 
-- 
2.39.2

