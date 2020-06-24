Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9277C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B22DC2080C
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 20:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OW4f5u3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B22DC2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717D46E833;
	Wed, 24 Jun 2020 20:32:00 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C3526E82A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 20:31:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STG6hSsPXyyFIbm9y4nTMmgnKBI09ItOO4JUeGZ4numYJtYoE15bjG2+W/4Nj900jI52kGJtU5By/KdhzFENZGL0Yc5nQC4lYPrmESElMXRF9bcLjIJJGPX4MQyi44QUke+9iw1F4P6rCVwdWiJcuwnlierOTkac94ceGkhlBTczOAmWv9EXhT7Wj0aHl/aaWxKZA5kBOY1BaA/L5Rsuwf3xook2QkqVQXDvQQVc/5W4tyTYipspV1kXhe9mkfa0cFghScIKlExt5xMGULz1Rh6D/8eROrFssBwNhilSkjMry1nrS+nipJBjedjDRObyz25KomMc2iHNnLmlu19b4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPtPMDdp/Lq1ObYGfX15H3LYpS/b+mFdtOrutIjtWFw=;
 b=CvImivD90+cm5HViiGkXcsbvFwxKCtOV0Zy0M+JIlDxC5nsuPoJtXPaGJcu81J4WO+lQSmKymWybmAzsSOSEnwah2pctRKqWti59AOhhADcFd0+KpBpE0oyHj/C/FXVaqi8rPl/6ZLTYIcXXRkL9MLtQ9JhZ791UQ5IrdtB9mcJ54EbwOM74aJq9MIjkAXGdMXdo1t9Kiv1HTbGLf8KMpl3ZMISRcXwP5zBxOz5/bWXqVA92cUplmcjglF4NZ6Okeah9T2tyr4f/RlQg6AclJsfZUd3oMLQiSWo+DHRmuXDDxbBgGFzIjmdKY9l38ovrwbMXVzAhMhRhTWEEQPfhOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPtPMDdp/Lq1ObYGfX15H3LYpS/b+mFdtOrutIjtWFw=;
 b=OW4f5u3aiyD49S+qsEsRTp4NAxp16s/dMLlsMRADM52uP435HJVOz3mgTWgnVvJ6n6eSwhRvYIVrOWHNsPeaw1D8cvp2Sj/Qgmk/zJ24YBC15kvghqVkIuc9CTFMtQYGazpEVXJDQ3gnLOdCvomnzmgf2uTrBh9R9d6Njd7LLzg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2422.namprd12.prod.outlook.com (2603:10b6:4:b9::27) by
 DM5PR1201MB0172.namprd12.prod.outlook.com (2603:10b6:4:51::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 24 Jun 2020 20:31:55 +0000
Received: from DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee]) by DM5PR12MB2422.namprd12.prod.outlook.com
 ([fe80::2107:be9e:d79b:34ee%3]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 20:31:55 +0000
From: Alex Jivin <alex.jivin@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: SI support for UVD and VCE power managment
Date: Wed, 24 Jun 2020 16:31:37 -0400
Message-Id: <20200624203137.14377-3-alex.jivin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624203137.14377-1-alex.jivin@amd.com>
References: <20200624203137.14377-1-alex.jivin@amd.com>
X-ClientProxiedBy: BN6PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:404:121::20) To DM5PR12MB2422.namprd12.prod.outlook.com
 (2603:10b6:4:b9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alejivin-ThinkPad-T495.amd.com (165.204.84.11) by
 BN6PR18CA0010.namprd18.prod.outlook.com (2603:10b6:404:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Wed, 24 Jun 2020 20:31:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50c7fcf8-3ace-4979-569f-08d8187da26c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0172:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01724490F2BB2B657D17261B91950@DM5PR1201MB0172.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-Forefront-PRVS: 0444EB1997
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JkIz+HrZGiGMECFaXQGSTNxP4rufVGhMb9lG86ka3qaULszOGIVjeEYcvmBIH80Oow2wlD0ky7ZRRSjcQonHdw5d7JGl/4iSgTlDEUgLoKaGrvkDcAF/uHQsHF2ti3oiqYxgPtic++lcUHvo44huvzqbU0NcWUCiypYr5+jfh+zJ4kMQ5u0rcqtcefvjvT2pOAQF/Aa+EYO9RaxblYzKkloX5jJbI/YEKZPxRTipfdAtkOJfipotlKXubi9MynJnDNEVkxWkiVx3XlT7pm75lmeyeyaHTSI+3MAqbBVO34jdOrenTG7u/Lb8Jw4mqkyqzua5ro/fFI4DZhMXER6IbYDueqqMqiSGI+xkcYrWxDhfOsMiNf/BeInonKJ+lgVN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2422.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(8936002)(86362001)(36756003)(8676002)(5660300002)(16526019)(186003)(2906002)(26005)(1076003)(6916009)(44832011)(956004)(6666004)(66946007)(66556008)(2616005)(66476007)(83380400001)(4326008)(478600001)(52116002)(6486002)(7696005)(316002)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0v4UhUJhlY7IcbkVt22qYUHqcyWWa/Sr7fl16s8sdK+j2Aea7wpTu2BT0OXCdziWMab3/Vux1dSW1E6/ChbkXx45TNf+opIt6+95hRvv64tliyzPVvXkRWqDW+3dGaeY1PEZnLg4H/0i28/ELD/sTX+YrRH44PToAgx0VAs437umlPSbdlYAUTKWEfqooPLLawt/3BZEfjYUGfPlTt4ZRR//vSl2W09bDwhDvW3kf9/Yq24W4Mgr64csvhn5ieXsK1cfAvNQSnhZBA/DX+Fi7yGnIFGMu0hsU1SwmBeYSf8mlrQ9ykwCZvHu5FCgIo01rc8HaDU8IrOiwkOjdbCyuhoy+bFCShM0/5df/qpCARivtAGxajZXuR5cpbGm6znhuzkyNov3QIaWk28QJaV860gursvBR4SAfyvKQj7WoM24OMQqWsVv5VLA7RYGOLS7+mt3e1Y+mdz5yh8Pd9a+QuKj4vnfyHoTNdyy8L9NFY9a/zBgAC8ANOvsmWrz4WKe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c7fcf8-3ace-4979-569f-08d8187da26c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2020 20:31:54.9651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZpxLNSb0rHzBWARmuonyiw6VXqFtKW/9LMfpPriwdvZXlH25BwtKGvI8F55CphOhEg4KGGwIARb4qkb/rJi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0172
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Port functionality from the Radeon driver to support
UVD and VCE power management.

Signed-off-by: Alex Jivin <alex.jivin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 67 +++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/si_dpm.c    | 19 ++++++++
 2 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 347b06d3c140..26c8e39a78bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -3558,21 +3558,36 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
-	if (ret)
-		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
-
-	/* enable/disable Low Memory PState for UVD (4k videos) */
-	if (adev->asic_type == CHIP_STONEY &&
-		adev->uvd.decode_image_width >= WIDTH_4K) {
-		struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		if (enable) {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.uvd_active = true;
+			adev->pm.dpm.state = POWER_STATE_TYPE_INTERNAL_UVD;
+			mutex_unlock(&adev->pm.mutex);
+		} else {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.uvd_active = false;
+			mutex_unlock(&adev->pm.mutex);
+		}
 
-		if (hwmgr && hwmgr->hwmgr_func &&
-		    hwmgr->hwmgr_func->update_nbdpm_pstate)
-			hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
-							       !enable,
-							       true);
+		amdgpu_pm_compute_clocks(adev);
+	} else {
+		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_UVD, !enable);
+		if (ret)
+			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+				  enable ? "enable" : "disable", ret);
+
+		/* enable/disable Low Memory PState for UVD (4k videos) */
+		if (adev->asic_type == CHIP_STONEY &&
+			adev->uvd.decode_image_width >= WIDTH_4K) {
+			struct pp_hwmgr *hwmgr = adev->powerplay.pp_handle;
+
+			if (hwmgr && hwmgr->hwmgr_func &&
+			    hwmgr->hwmgr_func->update_nbdpm_pstate)
+				hwmgr->hwmgr_func->update_nbdpm_pstate(hwmgr,
+								       !enable,
+								       true);
+		}
 	}
 }
 
@@ -3580,10 +3595,26 @@ void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
 {
 	int ret = 0;
 
-	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
-	if (ret)
-		DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
-			  enable ? "enable" : "disable", ret);
+	if (adev->family == AMDGPU_FAMILY_SI) {
+		if (enable) {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.vce_active = true;
+			/* XXX select vce level based on ring/task */
+			adev->pm.dpm.vce_level = AMD_VCE_LEVEL_AC_ALL;
+			mutex_unlock(&adev->pm.mutex);
+		} else {
+			mutex_lock(&adev->pm.mutex);
+			adev->pm.dpm.vce_active = false;
+			mutex_unlock(&adev->pm.mutex);
+		}
+
+		amdgpu_pm_compute_clocks(adev);
+	} else {
+		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCE, !enable);
+		if (ret)
+			DRM_ERROR("Dpm %s vce failed, ret = %d. \n",
+				  enable ? "enable" : "disable", ret);
+	}
 }
 
 void amdgpu_pm_print_power_states(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index c00ba4b23c9a..ea914b256ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -6953,6 +6953,24 @@ static int si_power_control_set_level(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void si_set_vce_clock(struct amdgpu_device *adev,
+			     struct amdgpu_ps *new_rps,
+			     struct amdgpu_ps *old_rps)
+{
+	if ((old_rps->evclk != new_rps->evclk) ||
+	    (old_rps->ecclk != new_rps->ecclk)) {
+		/* Turn the clocks on when encoding, off otherwise */
+		if (new_rps->evclk || new_rps->ecclk) {
+			/* Place holder for future VCE1.0 porting to amdgpu
+			vce_v1_0_enable_mgcg(adev, false, false);*/
+		} else {
+			/* Place holder for future VCE1.0 porting to amdgpu
+			vce_v1_0_enable_mgcg(adev, true, false);
+			amdgpu_asic_set_vce_clocks(adev, new_rps->evclk, new_rps->ecclk);*/
+		}
+	}
+}
+
 static int si_dpm_set_power_state(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
@@ -7029,6 +7047,7 @@ static int si_dpm_set_power_state(void *handle)
 		return ret;
 	}
 	ni_set_uvd_clock_after_set_eng_clock(adev, new_ps, old_ps);
+	si_set_vce_clock(adev, new_ps, old_ps);
 	if (eg_pi->pcie_performance_request)
 		si_notify_link_speed_change_after_state_change(adev, new_ps, old_ps);
 	ret = si_set_power_state_conditionally_enable_ulv(adev, new_ps);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
