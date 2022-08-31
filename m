Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB36ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Aug 2022 08:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B20D010E28A;
	Wed, 31 Aug 2022 08:39:54 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E0710E287
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Aug 2022 08:39:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhngAUMypaZli5AaB4GVyeHJamK6O6QtbOruGxEpZGXthlGYnVPG0NachWn3jo/GPgT1q/4UT3oK3A8xhNbeRw6YX3oe2NOUxzkFboHYht4tQGhaWKSqOMGC+r8v7y8I+hpA3tLIgaVfPMssgVn2Xz8au0z3RmiQ1ImjpmYX4Csu7uNb7HhkJuCnT8SA6+kUcdYZLRw58paC7yp046pyPM/VBvuMOJF2xuYaNlYixWb4cteLIz6Y2xwO6xy7Ey7TP6HK4eKrP8dMS+6oSTPkuQWXegK3P2bY10yuUBdCfnIsfUCwc9UVRYje3i5tzsY0uW0ZmLxlMUvQZ0peFDbDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1aeZf3ssRImo/5ABXfRHoVHQuELlUYaTv591h59eRM=;
 b=aEkuRcpJM797+EHw4hXZQySsgOp7tU74YrZXHRhhNZVQ1vsY+Fh7XdZmR8d7WWKcGTvmfcOxqKjHT2w3j82yhRZXOf+dSZ08glHQiTEmQmPIQoxujqbRAV0xXi+JgzwlrUTQLARNE2Q5CiZq4c6GvBXtqEQvcYX5+eH73CX2C0IZjSRwTzayR2ziUgBiYS+sfB+WNjr0xBKf5OpiLKSRqKvLy+HLEnkiSQaLRSy6LpORK7nixf84UgLbypfY5gXMq8yoxSLN9sJvgJnGcNlUXGKIrO29gu5z2UXUXGDi01KgBBD/kHJ5Qjrr+xiCyS6vLWU0E9ajMW/6OgEPcM1z2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1aeZf3ssRImo/5ABXfRHoVHQuELlUYaTv591h59eRM=;
 b=CMhztd6cmQGDoH4lqG9bdyATk6RsCJjF4LUgOa+NKJmaTThLSrjUXVVAMYNCpUZvAAfJeliSKORYghqikhWWREA7Ehbh5tJRH7YAeEVcKGlrM6sr5iX9hJ1tlRMwXm5BsznLEVnQffkOxhOUSmj6CCkDz4XTvuRpL0yp30gTPII=
Received: from BN0PR04CA0085.namprd04.prod.outlook.com (2603:10b6:408:ea::30)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 08:39:43 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::f3) by BN0PR04CA0085.outlook.office365.com
 (2603:10b6:408:ea::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:39:42 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 31 Aug
 2022 03:39:39 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <monk.liu@amd.com>, <Victor.Skvortsov@amd.com>,
 <haijun.chang@amd.com>, <Vignesh.Chander@amd.com>, <Gavin.Wan@amd.com>,
 <Shaoyun.Liu@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: inform PF if VF receives RAS poison interrupt
Date: Wed, 31 Aug 2022 16:39:25 +0800
Message-ID: <20220831083925.1440-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220831083925.1440-1-tao.zhou1@amd.com>
References: <20220831083925.1440-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd45c1b4-ea27-4922-27cf-08da8b2c59ee
X-MS-TrafficTypeDiagnostic: DM6PR12MB4251:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gQkJ36Gg8lfVWVtFEkM5HMenavN54WxcJWSvoGpRkH15UmjyB5PkzR/5AlQNA/r3A5zbagmaCQ8hG0tl0s+fPBsDiCnW+FLW3agoUL3yiVpaNm2JM2Kx/vYJM/XALImdsxIF/RQshLQDhT+YolnrYfJMnRsalFlQ6Ujckoa9vU+Hhz7uaR2wmqrnzZ02sw/4r5UnsUnKDubiGdnoiop3p4KBIrC7Nc+tBaOQPGTDmcpJpsPLEirQiPcmvW8+mZttX2P54POgfXV39igknRAktcKLe6oC5jEbCWk4/4bLDGZmb23QSXDp+fyBZu6EPPR4j6dgnw/r3o/wo1TCFEr3AraYyG2dM5sGo02HgAN0dABYyBn5+kQmUXTY7PDYQ5bLHuxchs7en+RIh7mzHQ2PgQxs+2c/UKUhcBPy/e0NuKteXx1VZUFwzIuPcDUOfWdMXWbkqKTV01J/QqzNbe9UFOZ0qtKsD0dQpuEanh157a0GePI5u4UwqjvhVHU3oagBgMuw6uQG9Rd3A7wCpITdbp+UBl36qWetp5YMcUwuqxmwOi2X/qXm+b5w6HnatkImoj79gEJ7DhbpMlmSzSmc8LccbXLU1w7r/vtYQns35WlaNuXjV+lWx7KHcF42M+mPhwS/lukjxF7nv5kVA0fMwIPhgfeg8Z3t5jiTL1Ye6ZWmr/QcOL8nJq6k9ggZl7zL2Fd6jzqY7Ylme/dRGBqwSsQyLjXfos2+IgWjL10jeS9EoEelV3A6Z8pLQ+9pQPX/EatYBGsMNGBMVJsYOJhxGPUWL06yoRVCRLbfpFAv65w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(356005)(82310400005)(26005)(2906002)(426003)(83380400001)(81166007)(110136005)(316002)(6636002)(82740400003)(7696005)(47076005)(36756003)(8676002)(70206006)(70586007)(4326008)(41300700001)(86362001)(6666004)(36860700001)(5660300002)(16526019)(8936002)(1076003)(478600001)(186003)(2616005)(336012)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:39:42.9323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd45c1b4-ea27-4922-27cf-08da8b2c59ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251
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

PF will do page retirement and reset VF in SRIOV.

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
index 4534e6f70a4b..41d03ef417d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -86,6 +86,7 @@ struct amdgpu_virt_ops {
 	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1, u32 data2, u32 data3);
 	void (*ras_trigger_error)(struct amdgpu_device *adev,
 				struct ta_ras_trigger_error_input *info);
+	void (*ras_poison_handler)(struct amdgpu_device *adev);
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 3b4c5162a237..7545d7c0f524 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -428,6 +428,11 @@ void amdgpu_virt_ras_trigger_error(struct amdgpu_device *adev,
 				addr_lo, addr_hi);
 }
 
+void amdgpu_virt_ras_poison_handler(struct amdgpu_device *adev)
+{
+       xgpu_ai_send_access_requests(adev, IDH_RAS_POISON);
+}
+
 const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.req_full_gpu	= xgpu_ai_request_full_gpu_access,
 	.rel_full_gpu	= xgpu_ai_release_full_gpu_access,
@@ -436,4 +441,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops = {
 	.trans_msg = xgpu_ai_mailbox_trans_msg,
 	.req_init_data  = xgpu_ai_request_init_data,
 	.ras_trigger_error = amdgpu_virt_ras_trigger_error,
+	.ras_poison_handler = amdgpu_virt_ras_poison_handler,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
index 0841d6632328..869dff6daddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
@@ -48,6 +48,7 @@ enum idh_request {
 	IDH_LOG_VF_ERROR       = 200,
 	IDH_READY_TO_RESET 	= 201,
 	IDH_RAS_ERROR_INJECT = 202,
+	IDH_RAS_POISON		= 203,
 };
 
 enum idh_event {
-- 
2.35.1

