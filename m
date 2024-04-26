Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13AB4C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 03:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02D111A9DC;
	Fri, 26 Apr 2024 03:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1Sc2o35A";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2082.outbound.protection.outlook.com [40.107.237.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B72011A9DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 03:59:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ju1xHEpY9/qJ+qiTWxALrvCfXUjEPxr4Ir/dwVF+TI1IPw4+AB0T9sxlnD6lgsuiOXyNPSJPFTpJG7jr0oLndMg3B5mNKu5flSrv2lwEJDAqiO4nEY4hTYrPzk/IPzV0ZcdajGmt3XYzwKLdNONA+6/Ejzjod40QtKBCGJfk9nhOTwf6iGf78S8yOSRqL5859VAeaQ/7tCvMACmfcy7DxX8pfBs7fkwsxk6zJ3gNiCtmD0bPEjKHNLrRlucZg8gDtaRElERjUrrL8jUhpsKO2fb+UcPCC9jpxuU0HaS7Yn0ny+moXqs7TfWH3shXeH2D7nnuRAO2pG3xu1nWgtUzDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNhMQTtl4J9k7K86DczfsI49kttXCHFoGzK1u/ICO4M=;
 b=gE82CqjaB8aO0vUOcABK+y57yr/1NR4Jot5XkD8K4I/IJgQ0nRTUSuFK9XPfeukY/SpYukH2koNqB2m+v2Xe2yGbbLjVQTPENb8BOtySbuwDR69fic1V5sERbUIjLD4ZFpJKKECs9yM83LgGOQYMBcky+z6y/7qdGWfSR+NEb4hKCzcp3YIvW55bJN6zGGpbqnlbnwsg4OkDju6H+N8cor+V3sMUBHtsWUEc8ObWBA1InhpX58LQBl54egTz6jVWzE81dqBY61F+aJPfImnmUywzFInzXhmrgb3iHrFU5K7WlvuHW6S5sgUa5M4EIF6Gv8AvXcllgrXHjBe5ACJ84A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNhMQTtl4J9k7K86DczfsI49kttXCHFoGzK1u/ICO4M=;
 b=1Sc2o35Ac6EQtr39an7wa4HeO0fJrGV5/JCVX4sijF1flkLzL8iSUqitnbJwiUYW9jKqg8pXMaEqk06pL2ewwu+XgtAuPWogpPrAoULicx3k6aVlUgND0MZq/0v36IosHMXmD2+7WLYdSSRUUTrOliM1krRLrfdSdBFSNLlCmbE=
Received: from BN9PR03CA0485.namprd03.prod.outlook.com (2603:10b6:408:130::10)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.22; Fri, 26 Apr 2024 03:59:04 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:130:cafe::9c) by BN9PR03CA0485.outlook.office365.com
 (2603:10b6:408:130::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.33 via Frontend
 Transport; Fri, 26 Apr 2024 03:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Fri, 26 Apr 2024 03:59:03 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 25 Apr
 2024 22:59:01 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, <felix.kuehling@amd.com>, <emily.deng@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>
Subject: [PATCH v3 2/4] drm/amdgpu: Add reset_context flag for host FLR
Date: Thu, 25 Apr 2024 23:57:40 -0400
Message-ID: <20240426035742.90560-2-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426035742.90560-1-Yunxiang.Li@amd.com>
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 79bd60c4-9bfd-4130-8e60-08dc65a53653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400014|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mpzTvxxJlZps+Z1WIVJZo9h4de8nOfMEJOqCSJAY9HXip/V5oZR9zVr6q/jN?=
 =?us-ascii?Q?Zj2yq16T+9JCxF80SlTcwb97yHJ8ISLMEQB1SLEhYkBuQHdN55/2iJ87B0B2?=
 =?us-ascii?Q?/KYFN/008Sxch4Rs8e5O9bJdKqtygxPTYSSLWqTA+Lv5Fq9guyARJr1Hk2qf?=
 =?us-ascii?Q?sJUEzqicCWkjk/mxahVpceVxDYpDG3fWn3qRwtoVVG/DsycvITBEGSmj/xVM?=
 =?us-ascii?Q?4eS0VwvMEd1deAqXOskJd9L7ziOUjuqVBsqR9zLklHmT56ViZ4OUO7xkJrik?=
 =?us-ascii?Q?Rx3j2SLGg0S3kAcOsJTaBlmkX6YBXzv255CjMCQhSnpyXVGSP2M48xdPikJB?=
 =?us-ascii?Q?IX9Ml2Q7z65IvGyVXoFhKKkx3Iepl1ZEg8INUmIC4O4SGXww4qyHaqjTg8MB?=
 =?us-ascii?Q?EvRgzoFpo35qrUFhIOdn9+Lbol3g/nh2HXrR09a8DODVG7TVZzL8nFwgcbJu?=
 =?us-ascii?Q?rm3IdvX2q28ZzW8o0BIj3hyVk/R3CuG4XruJLqWy5994UovN76+rYXAVDUMK?=
 =?us-ascii?Q?cMEQnNuKFGUnVrkpVZMZpBZrGNp3AVlQXhX3siaXpQKsmjLCGE+zCX4WVzvL?=
 =?us-ascii?Q?fRI/mzqyuqcJ66RX8nnZslEirRRm8sxIK3RT+ZKz+MsbOQhTmvGrZ237ZLJO?=
 =?us-ascii?Q?z3vp/udjXHpoe9rWZMaZ6BYiUxiSH5piaL4n3qeW+7IlrszY3mFaQ3uequNS?=
 =?us-ascii?Q?7C1joiPuKPTDTGhFvBU+n3zgFfCBdbbEzhRTBJvCFvObvlUWPaiLLlSvI7Em?=
 =?us-ascii?Q?1oUtJ499cxTEByk36AzuzA/YD9Gf0R1bIyQOuiwlE284mK6uhnGP7NY0k14C?=
 =?us-ascii?Q?sYVqMs4nkXPgYsg21zFwJwzPo8Lctyl0Xda4v0ttnxN8gLoNClsk9dOvwr0h?=
 =?us-ascii?Q?pyTEiTPmuoaPn2nqDMZbBVAcjpCeW4CKZ3O/d6kTf1Ofp6u6zpKqK0U4h2HS?=
 =?us-ascii?Q?upc21RNTRXN/D7fozY+t4idUMkzt6w7/zcxcKax18v4RIEHlGBHZ0YzELjZd?=
 =?us-ascii?Q?i6I/V8xgggkCQR8AzI0lez8xK4/Itq3azpPwKGm9HTUTUT9KOGyztCpRCMM6?=
 =?us-ascii?Q?vCPUBRsAlIxQNL1dvoLzzm0RqsSxxGCuJzhhiM7Gu5Tpn4Za8HQMKgOpIgd8?=
 =?us-ascii?Q?lT9RxIdXtDalwO1kCQ2ZqRg+oHuaYftZ0dEC6yzqQuOBJ134PtVvpTc6nH8w?=
 =?us-ascii?Q?vQcIepmZrb0n+zfNBNloC3dp5xRZ4GWMFotTuiFS8UttpEBng2BuA63XCvII?=
 =?us-ascii?Q?RoD9fBAXR7RF71L0GFhVM356DSkXi4XXSMAd2Ke23tAcQqxqL1M3O9qObEHQ?=
 =?us-ascii?Q?cORxeT30xxowjcP0drITofX1zX843SqAycrTALBLWlH+X1LbOH9zCsOh36co?=
 =?us-ascii?Q?ExPeQq8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 03:59:03.4753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79bd60c4-9bfd-4130-8e60-08dc65a53653
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

There are other reset sources that pass NULL as the job pointer, such as
amdgpu_amdkfd_reset_work. Therefore, using the job pointer to check if
the FLR comes from the host does not work.

Add a flag in reset_context to explicitly mark host triggered reset, and
set this flag when we receive host reset notification.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
v2: fix typo
v3: pass reset_context directly

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 1 +
 5 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8befd10bf007..1fd9637daafc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5055,13 +5055,13 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
  * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
  *
  * @adev: amdgpu_device pointer
- * @from_hypervisor: request from hypervisor
+ * @reset_context: amdgpu reset context pointer
  *
  * do VF FLR and reinitialize Asic
  * return 0 means succeeded otherwise failed
  */
 static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
-				     bool from_hypervisor)
+				     struct amdgpu_reset_context *reset_context)
 {
 	int r;
 	struct amdgpu_hive_info *hive = NULL;
@@ -5070,7 +5070,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 retry:
 	amdgpu_amdkfd_pre_reset(adev);
 
-	if (from_hypervisor)
+	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
 		r = amdgpu_virt_request_full_gpu(adev, true);
 	else
 		r = amdgpu_virt_reset_gpu(adev);
@@ -5826,7 +5826,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	/* Actual ASIC resets if needed.*/
 	/* Host driver will handle XGMI hive reset for SRIOV */
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_device_reset_sriov(adev, job ? false : true);
+		r = amdgpu_device_reset_sriov(adev, reset_context);
 		if (r)
 			adev->asic_reset_res = r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index b11d190ece53..5a9cc043b858 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -33,6 +33,7 @@ enum AMDGPU_RESET_FLAGS {
 	AMDGPU_NEED_FULL_RESET = 0,
 	AMDGPU_SKIP_HW_RESET = 1,
 	AMDGPU_SKIP_COREDUMP = 2,
+	AMDGPU_HOST_FLR = 3,
 };
 
 struct amdgpu_reset_context {
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index c5ba9c4757a8..f4c47492e0cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -292,6 +292,7 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index fa9d1b02f391..14cc7910e5cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -328,6 +328,7 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 14a065516ae4..78cd07744ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -529,6 +529,7 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 		reset_context.method = AMD_RESET_METHOD_NONE;
 		reset_context.reset_req_dev = adev;
 		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		set_bit(AMDGPU_HOST_FLR, &reset_context.flags);
 
 		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
 	}
-- 
2.34.1

