Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323CCECAAD5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Sep 2022 08:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C2110E9AD;
	Thu,  8 Sep 2022 08:48:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F68F10E9AD
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Sep 2022 08:48:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=npD/AmV7VOtoH6k67pDVO7Ynh89ziakTSkLndthVFOCV4AvIy3Q/cqyA6OEyXZvLTYLqSFgOKueZIf6JEGWf5nQ6TS/FLLrIxoyNgabNJl/MGcZzPcmfJCywErSpNdhqQ3fL64YxXbZJvNzL+I8LhalWWG7d7ml6mCZmuCQSkgX6wfYfkzLZ2DuIJtGcgbUs6ZIdDEQD1dfM+yPJFIa5l3Fn1diQeJC/1Jl9YHOXQRMBX72o3PE/t97AvXvgaSvE+wfJu68qy3mh9AD3x1OgJWB7auywflDeDV5duChjhi/IagJ3F+zIE+XDeJLRQMG2r8G+qHJiOLuqXMEozwJY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ+9mft+dexi0R/cVwdt0isbKJuCxIhVUSaLDdelyHU=;
 b=n30MAozqCpcn8D1Us7CrmKaCbj/CyiV/sYfJBtl8+t4ku8zjP0b99YERuRddor8fhc3aItUYehjRIuaO5gXaXV8jxX+MCIzL3bkPZyeB4fdWiX1F4PDCr5+bfR+UWaijm5ywx2sqIsJt/O+by5EtEI5WEo+WGv9NTaMDRtJ2BSxZ6MtNtqMBlTUoVznBFpNt6J/v8ksVXBQ6ebQRAlgDi9xpdNpxMKigqfuDl6cuN3ItDceMF4Bz/cLg8b0soNIWdcguTHKm1EDQtxVpBJayzhtym++ZHGXd5CHHADdp+O17U+HLAfElrdwX3o98evoU7WwuMlxtQh6SSKQoPrDMxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ+9mft+dexi0R/cVwdt0isbKJuCxIhVUSaLDdelyHU=;
 b=JTqCPFfa1MCua4chQjR/f5cA4GLt7Zw9vfZLdukgGHLYfaN4bjRbQLUGLaOD/3jSiaoJXCLg3XxTRTpe6J+dPBrH34837HyfhgoIOJDxD72WcqawUzemwC4HaQ2VL/3d2LfqGRGPZbyWb+jVHXp8sEYXx5nVzgdC16f4lmz5RtQ=
Received: from BN1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:408:e2::12)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Thu, 8 Sep
 2022 08:48:23 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::2c) by BN1PR13CA0007.outlook.office365.com
 (2603:10b6:408:e2::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Thu, 8 Sep 2022 08:48:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 08:48:22 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 8 Sep
 2022 03:48:00 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <monk.liu@amd.com>, <Victor.Skvortsov@amd.com>,
 <haijun.chang@amd.com>, <Vignesh.Chander@amd.com>, <Gavin.Wan@amd.com>,
 <Shaoyun.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: inform PF if VF receives RAS poison interrupt
Date: Thu, 8 Sep 2022 16:47:44 +0800
Message-ID: <20220908084744.29288-1-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT031:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: dd45731c-afb6-4416-e795-08da9176e30c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VAvJUnRovnONk3S7JI1RpyzFp6AC5q75mVUZs3YfvOKsEWaa6jFijdqId2/wlLHAZSjP+k/DktChCTWFLGFLwuyTPC/ZjdSpjEgIa0FHIroa0T30pN593mPiM7S72bLQyly80r0zHPh9r4Kiqq/u38CQonCBcmmI0uqivRduxxVZLk7ADqcCOWFFakgAHrJPEyfjsI2RBO3/mun6vCqoTRCQIDYq/3hJQNZ9i7j/bU5UWmnL8ifXenkpbJ6KXvBKmHFIO3WEnzEA7LFqgcY9mGLZJjeON8/TuApTpPJtLQs3u1DAzNxG2Re2YyCUGAOArnzsiV6uiy1wFaSKX5qyB/fqPNBBn0AytsR1dG3OYDIBkSkG9VFb+dgyZ7mOgLLKI/zz1nI4DxytkBbfQqpK8RhIrjCeTjEkHXmpusDrD9Ngm2twiVC906bvo+SLCSsfB6b1FuFLnUo4lsEl5XifzxmZ3M+e4Xit6s9dKwtWgAIYs++qt3CI8s9isz2H20BQVCQqNTtfaO9eeCvQx60ieIQQbeGJnZ/XQAXRdyKikBM26b+NNB1926cMs6+IUPF3PsnPwX/ok8JHJnc5kGLKKX00GmZiQjNlwxOk3KOf7BhfI/13FNkXDY6UddUqjAdv3D/NxocGdV2Z3HuTuenvfXCbJA+tq/D4EpTmxjVD1HMaDjaa1+HEu1n61Pr7qUPXV98mPEGilEvG2RKhM02tlTu11Xfb4a4ELNNBQ4E1ZGxDcYALZreqnJOtfpnV11u1MSJpxvNjEiVK6eKSE+HhohzipOTlzaePJV8imFJlsHJQnH9gyexSuQuIg2ISWDpy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(40470700004)(36840700001)(41300700001)(1076003)(40480700001)(110136005)(356005)(6636002)(40460700003)(2616005)(81166007)(316002)(86362001)(82740400003)(16526019)(47076005)(426003)(7696005)(186003)(336012)(26005)(478600001)(8936002)(82310400005)(6666004)(36860700001)(83380400001)(70586007)(70206006)(5660300002)(8676002)(2906002)(36756003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 08:48:22.7163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd45731c-afb6-4416-e795-08da9176e30c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PF will do page retirement, reset VF and inform VF to reserve RAS bad pages.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c  | 18 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  1 +
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
index aad3c8b4c810..b603ab3bd138 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -123,12 +123,20 @@ int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
 	};
 	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &head);
 
-	ret =
-		amdgpu_umc_do_page_retirement(adev, ras_error_status, NULL, reset);
+	if (!amdgpu_sriov_vf(adev)) {
+		ret = amdgpu_umc_do_page_retirement(adev,
+				ras_error_status, NULL, reset);
 
-	if (ret == AMDGPU_RAS_SUCCESS && obj) {
-		obj->err_data.ue_count += err_data->ue_count;
-		obj->err_data.ce_count += err_data->ce_count;
+		if (ret == AMDGPU_RAS_SUCCESS && obj) {
+			obj->err_data.ue_count += err_data->ue_count;
+			obj->err_data.ce_count += err_data->ce_count;
+		}
+	} else {
+		if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
+			adev->virt.ops->ras_poison_handler(adev);
+		else
+			dev_warn(adev->dev,
+				"No ras_poison_handler interface in SRIOV!\n");
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d94c31e68a14..87de4ef60f86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -84,6 +84,7 @@ struct amdgpu_virt_ops {
 	int (*reset_gpu)(struct amdgpu_device *adev);
 	int (*wait_reset)(struct amdgpu_device *adev);
 	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
+	void (*ras_poison_handler)(struct amdgpu_device *adev);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index a2f04b249132..fd814a099066 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -405,6 +405,11 @@ static int xgpu_ai_request_init_data(struct amdgpu_device *adev)
 	return xgpu_ai_send_access_requests(adev, IDH_REQ_GPU_INIT_DATA);
 }
 
+void amdgpu_virt_ras_poison_handler(struct amdgpu_device *adev)
+{
+	xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
@@ -412,4 +417,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.wait_reset = NULL,
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
+	.ras_poison_handler = amdgpu_virt_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index fa7e13e0459e..188181b0af4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -39,6 +39,7 @@ enum idh_request {
 
 	IDH_LOG_VF_ERROR       = 200,
 	IDH_READY_TO_RESET 	= 201,
+	IDH_RAS_POISON	= 202,
 };
 
 enum idh_event {
-- 
2.35.1

