Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04818C433E1
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 09:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00042074D
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 09:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0IwLTBxT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00042074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BEEF6E5A2;
	Thu, 13 Aug 2020 09:08:44 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E84896E5A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 09:08:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHzGc8+SmF4v4x4fvQ+0TNgzyrT73ROS5VwdjFuJbG4y5WfqDDmge239+B9lZMHMGIjQJ0TyIgoUbx4wPXefKNFrT1pa+kQR0g5MAXI62kacja8Uv+fnzqJyBDS/7D1MFalz6ueGsx7aYhQrJKJtZjy7UhPIFaxbeDPCanWDNmaONTiSwWrw5j+Cy5eKw+qYCev2edOfWD2guhHe8vsuwOWk9yjDMA1vL2ncaBy9AMSLcsSgn4HMWHsPYwnZ/uO3beNeL4MRpV/WC8VH8KKHhK/ZuTJx5bVF47qG8JIUZDy0KYWCm5aIbsH8lTOL4k0VYzjxao/nXOLV/M4NxalRwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUVAVuSeMrW7VOHGepbb0oiPxC1AQ+/vDXLd7hz/MqU=;
 b=fhsA3pnGhnhTb0IUEFadsmtKyNaMGzhbavoaMwjICNxcj22RC3eekbafyrzcDmQdiUvETtXOSj0o32EZEgah5hKSWIZApPchoangn4y9Oaznp+yOoDjwGADWNfRxUHLSPnwVv21IT5az46V5jTFtBc7yikznbqSNdJAIqY1AQ7YsAwPS4rDhgfo8SWDrzpLzj10zZaqjgycEG8PGufU4KEjFofwWQmOIu65NPoSniBPKTwVxdILWj1H900aXILTjGHHjcwaQJiSlWmQdn1UPaJsj6MsiKJRUlqVI2G93KN95BkZ78VlJY8Ugkb8V4vKmDqKSE9K9nMCNuhzaKzcaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUVAVuSeMrW7VOHGepbb0oiPxC1AQ+/vDXLd7hz/MqU=;
 b=0IwLTBxTV30N1SAofy4vGusua2uEUHArad7exaDxemLZLtVKkDNWZyMbZ+AheaKagsrXFx2aMMxhXaNLaDQAmxGx6SRQTOOjesv0BIRpfyV/UZgK01V9+Iy5zb7Qp3t1XmR83w60wfDmGf+yz+j0IleR32nFr8HfCDze9DlCooQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Thu, 13 Aug 2020 09:08:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Thu, 13 Aug 2020
 09:08:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: optimize
 amdgpu_dpm_set_clockgating_by_smu() implementation
Date: Thu, 13 Aug 2020 17:08:16 +0800
Message-Id: <20200813090819.32115-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
X-ClientProxiedBy: HK0PR01CA0062.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::26) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK0PR01CA0062.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend
 Transport; Thu, 13 Aug 2020 09:08:38 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ae03c2f-de4e-4360-54b7-08d83f687822
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2358F4C5695E9B8EFA403A12E4430@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXg+xvCGC+nlZxFm3NNp/VN1w9ujIfyppTKM6GkXso17zh4wkYzh02IiteptteYezhv/qhuAD2MUqf6nHNaXdcH+zxfSCYiACn8QLjEXdUDI3SVBzqrUgO2IGM/LC+0IbO49bYNOGuAk5kLCWvfCmEjAZHNj1YvkQgNiV6JldcSLF4THaXpxKLS61wnFpqKrG8xkU5RrKbLLI//pLqSCaawXX5EV9lOG1LmPOqFlG7wBr8K/Z8g8JptrwnJV+cxmM90HFJ+/8/VvGZGKLtXCY7n4jub8DOiYgSMzSU4gsWh4/zhmiob5l9CXs+HX78hLcbSoK2504u36MSRzYlw7DA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(396003)(366004)(5660300002)(66946007)(6916009)(4326008)(66476007)(66556008)(2616005)(16526019)(86362001)(2906002)(956004)(7696005)(6486002)(186003)(44832011)(52116002)(1076003)(83380400001)(8676002)(8936002)(316002)(478600001)(26005)(6666004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: bf9J0d/vwMhrHANwrloFAhKfw1cHhgq8sekxVTxw1h3ZLrgF6qoHrTZsmc+xuQTNsTDYPWcu04FTaUZEZXZaeZUB+uVfymjErH+3/kfCH8xizBMjeYl2bmNFzI9KAH1UN8ez9uyce/uFeQ1VW+KPu7NkjeU1jfjvNQ/QX/ClvRnVXYa9Dpcmt7FSeZ6zPTiDRvupNKpNnUeqZuXf+46Mas3rKvGVUNwqy5WdSRwVtLUoyjzZGyapKwF1SDDm/91WaGsGyPvnZ24yIq1ZMtdoyiqeUSi1xQtDKLFBh6PUj9ERIjKY/+9J8V+ZWgrUa0xr0A6sv53r+VTPmJAiGkG2UcmGlt21J5oCHoOY0ILSdy8uWaQ56Caxr4XkrGfSPP2H09CGczxt2bhhYa5iXdd0tWON5EWYvL1TGLM5Vv0GIIX4zutd5LMJM+XLmBtTU4ef94yu5w+g72E11YhfNbas+2RIX+9xUKWZtciIF2nFRiJMIUMWU4f8GCuvRQNLMZBF1/gl4X+3oYW5saRPz50pXSCTi1AwqIgdYiEqCw1KC7N1xgCsvq/S4suZWEqoZGjPhsR0YhzXU+0jAx/BxLkhaX/KHBJ7PGhVDEtX+icVKBqYaWfwxT4gvaCE0JNCISa+Kt2DQ+5BmNlmZOQWjdr5kA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae03c2f-de4e-4360-54b7-08d83f687822
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 09:08:40.2566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6f0V1yr8r634PG7sAfqqznINyTXcNnFsLROjRdZ2um9ezVQkNy5g2meiVt41nZea
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Cover the implementation details from outside(of power part).

Change-Id: I8220c0c220b5dffa1024cffe35d79d721ba3ab2b
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h |  7 +++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   | 21 +++++++--------------
 drivers/gpu/drm/amd/amdgpu/vi.c         | 21 +++++++--------------
 4 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
index d9ebb567c0df..2aa6f53fcae7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.c
@@ -1232,3 +1232,18 @@ int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev)
 
 	return ret;
 }
+
+int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
+				      uint32_t msg_id)
+{
+	void *pp_handle = adev->powerplay.pp_handle;
+	const struct amd_pm_funcs *pp_funcs =
+			adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (pp_funcs && pp_funcs->set_clockgating_by_smu)
+		ret = pp_funcs->set_clockgating_by_smu(pp_handle,
+						       msg_id);
+
+	return ret;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
index cc16b5a3ac44..672b73ad08c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
@@ -341,10 +341,6 @@ enum amdgpu_pcie_gen {
 		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
 			(adev)->powerplay.pp_handle, request))
 
-#define amdgpu_dpm_set_clockgating_by_smu(adev, msg_id) \
-		((adev)->powerplay.pp_funcs->set_clockgating_by_smu(\
-			(adev)->powerplay.pp_handle, msg_id))
-
 #define amdgpu_dpm_get_power_profile_mode(adev, buf) \
 		((adev)->powerplay.pp_funcs->get_power_profile_mode(\
 			(adev)->powerplay.pp_handle, buf))
@@ -546,4 +542,7 @@ int amdgpu_dpm_allow_xgmi_power_down(struct amdgpu_device *adev, bool en);
 
 int amdgpu_dpm_enable_mgpu_fan_boost(struct amdgpu_device *adev);
 
+int amdgpu_dpm_set_clockgating_by_smu(struct amdgpu_device *adev,
+				      uint32_t msg_id);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 7df567a6656d..d8d4ae124d13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5880,8 +5880,7 @@ static int gfx_v8_0_tonga_update_gfx_clock_gating(struct amdgpu_device *adev,
 				PP_BLOCK_GFX_CG,
 				pp_support_state,
 				pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & (AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_MGLS)) {
@@ -5902,8 +5901,7 @@ static int gfx_v8_0_tonga_update_gfx_clock_gating(struct amdgpu_device *adev,
 				PP_BLOCK_GFX_MG,
 				pp_support_state,
 				pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	return 0;
@@ -5932,8 +5930,7 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
 				PP_BLOCK_GFX_CG,
 				pp_support_state,
 				pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & (AMD_CG_SUPPORT_GFX_3D_CGCG | AMD_CG_SUPPORT_GFX_3D_CGLS)) {
@@ -5952,8 +5949,7 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
 				PP_BLOCK_GFX_3D,
 				pp_support_state,
 				pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & (AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_MGLS)) {
@@ -5974,8 +5970,7 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
 				PP_BLOCK_GFX_MG,
 				pp_support_state,
 				pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_RLC_LS) {
@@ -5990,8 +5985,7 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
 				PP_BLOCK_GFX_RLC,
 				pp_support_state,
 				pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CP_LS) {
@@ -6005,8 +5999,7 @@ static int gfx_v8_0_polaris_update_gfx_clock_gating(struct amdgpu_device *adev,
 			PP_BLOCK_GFX_CP,
 			pp_support_state,
 			pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index f6f2ed0830b1..b4e4a7a19d19 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1507,8 +1507,7 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 			       PP_BLOCK_SYS_MC,
 			       pp_support_state,
 			       pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & (AMD_CG_SUPPORT_SDMA_LS | AMD_CG_SUPPORT_SDMA_MGCG)) {
@@ -1526,8 +1525,7 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 			       PP_BLOCK_SYS_SDMA,
 			       pp_support_state,
 			       pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_MGCG)) {
@@ -1545,8 +1543,7 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 			       PP_BLOCK_SYS_HDP,
 			       pp_support_state,
 			       pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 
@@ -1560,8 +1557,7 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 			       PP_BLOCK_SYS_BIF,
 			       PP_STATE_SUPPORT_LS,
 			        pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 	if (adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG) {
 		if (state == AMD_CG_STATE_UNGATE)
@@ -1573,8 +1569,7 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 			       PP_BLOCK_SYS_BIF,
 			       PP_STATE_SUPPORT_CG,
 			       pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_DRM_LS) {
@@ -1588,8 +1583,7 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 			       PP_BLOCK_SYS_DRM,
 			       PP_STATE_SUPPORT_LS,
 			       pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 
 	if (adev->cg_flags & AMD_CG_SUPPORT_ROM_MGCG) {
@@ -1603,8 +1597,7 @@ static int vi_common_set_clockgating_state_by_smu(void *handle,
 			       PP_BLOCK_SYS_ROM,
 			       PP_STATE_SUPPORT_CG,
 			       pp_state);
-		if (adev->powerplay.pp_funcs->set_clockgating_by_smu)
-			amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
+		amdgpu_dpm_set_clockgating_by_smu(adev, msg_id);
 	}
 	return 0;
 }
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
