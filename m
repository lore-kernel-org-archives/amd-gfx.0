Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D367C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A976509A
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 20:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A976509A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3D156EC42;
	Fri,  5 Mar 2021 20:04:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB3F46EC48
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 20:04:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaEePJUkGs0WaIMiYiP0v/6sLR91h2ssSKrUNiVG8nT7JVEetEE6tMlGiAHWY4VE7B6IbjoF5hjIBoQXU99QwS+ixizXbDDmZf4FTAEPXSLHHVkm7T1xAoRLeq8Y2uq1NeWu1Z92KrLzCh6AJFgwYS0F5WW4d3wOHmhIM04z/vnTLbTcL8Vf5QgS8Suee8sTRG/u4XcLOZPplZ1duaXSXZVNwx1a9xIHoPUQwJ3VpGhckRsWmFKzpy1k0OVNR1GtQUjSrmMTkpx3vG2cSpfAf4qc7oCocKfCeshv67uf3RahYOhZjEm3O5eypQoPU4odt93Wf9LkYAWBqvxnBJ/OIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P63nuTWk010O/JaSdfBxgUORs3K5OjgHaCBOlutl+/s=;
 b=dS9HeblRhMoVVhQoc587TWOq0R7HadCqZ5tBNXmdWBCZymt8RDW8ObndfeZ4hXLsIrgcVgbq59r6EQM5qkCTNGywKFUmH+zIEOjj9GPONtcK3zlO/T8DXF8MMEtzV0cM2q7AjVu4LY0VDhBNyYGogJcKgGs7LNPGBPcDWC8TUXHo2v0jCT2aZlP5fYr//hfEwdBzvUyCz21zngPQl1xC9zdebQQf2HIThjoWqDAjX/jYqtbxYWwBpGoUfIx2fBL6DYDrWYEzhABkE4e7fRVtqP7fQTLrny8ivX/6Fn0xhsaU3biJkxFhCi1fuQFZUn7dTXyOu2687wuIGnX+4YG/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P63nuTWk010O/JaSdfBxgUORs3K5OjgHaCBOlutl+/s=;
 b=Fif5RkNZ2s2NoVe544WJn0DhsSt/F4MW1l9Y5DB1gQ3Fiwoo/X15HSiYSozdTIWBWMBlrRc0qqm9Qufb+jV8KqTbKc2DQ7goTI2df5Aa/tU5LobyYA0qjncJ/h+LKPXBt+MNgu4iRV/ivriBctl4MzDEa9p3aJAv25f46wTnFOs=
Received: from DM6PR07CA0067.namprd07.prod.outlook.com (2603:10b6:5:74::44) by
 CY4PR1201MB2487.namprd12.prod.outlook.com (2603:10b6:903:d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 20:04:38 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::ee) by DM6PR07CA0067.outlook.office365.com
 (2603:10b6:5:74::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 20:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB02.amd.com;
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 20:04:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:36 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 5 Mar 2021
 14:04:36 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 5 Mar 2021 14:04:25 -0600
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amd/display: Fix warning
Date: Fri, 5 Mar 2021 15:02:55 -0500
Message-ID: <20210305200301.17696-9-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305200301.17696-1-eryk.brol@amd.com>
References: <20210305200301.17696-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4c8dc8-03b8-4cab-092b-08d8e011e75e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2487:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2487C7391F300CB379581009E5969@CY4PR1201MB2487.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I3RDUicbXPXX2lI69VfuFv917t9TQZvQTDOGEjldm83l+81kDvubG1lxu+isDXAFFrMZ2EwQhynP998tM17DHZquVcKSYIqqepf/zLXrU0kFJFB1fGZzm2rSqJmjv+O/HgK/A/5ZJp8aODBkQfsgWtW4OijJ2qJnN2RKpk/PGtpeDL3lLdfNfzj4FQTh073xmJsK3bksQ9HKaNykzELZbqsIVDxTv86fk5/O2RFuxNQqeVIzJFxGJTgDQv1XyoYFCYMn1EVn0uKUiad3qOanzjmEPjIXWvVz8skeGqCuAGJlUCUT2Ye/4zNsCLYLA+eeHjqXhKP6ekdsUhthE1JtYkvNNt1gcuy84l0JJfzo7tHkzSQPvXTfl6QzkMhnq5iBq5GQDN8H4iJBPLnOYD55QJ72gDEcaQOBCGORalyQCpsYzU6gPFAW8Mq70UOhztb0Oe1pz0ndfQ5DkgsANjnWJKnBkmXotiFFf1jtPD0KKxuZ7DxxrgYKoHmmAdmONqldntPiHSvsPV0CSJl2Vk3cpHCAbxUqb2jkxLzueztmXKkq/fX+1hbIa83zFlppxFoZYLkPIv2CawKIAKuwodDQjE+Ilgl2tEIKhc9pgGsrAuDCqluRdeqBj1gPfPhP6Uz78T34NQkOy06Z8uzg2iEyHiixTrbNyPk6pVq1qhg4lOoeqiAQlsYW7vuoLSgKOgsn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(46966006)(36840700001)(83380400001)(186003)(26005)(356005)(316002)(54906003)(6916009)(86362001)(82310400003)(44832011)(6666004)(36860700001)(2906002)(81166007)(47076005)(82740400003)(478600001)(70586007)(1076003)(36756003)(8936002)(4326008)(426003)(2616005)(5660300002)(70206006)(336012)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 20:04:37.2631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4c8dc8-03b8-4cab-092b-08d8e011e75e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2487
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
- Wrong scope for ifdef
- Missing struct description

[How]
Move ifdef and add comment

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 11 +++++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7f2ece5b4db0..1bd9a235e406 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -966,11 +966,12 @@ static void event_mall_stutter(struct work_struct *work)
 	else
 		dm->active_vblank_irq_count--;
 
-
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	dc_allow_idle_optimizations(
 		dm->dc, dm->active_vblank_irq_count == 0 ? true : false);
 
 	DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
+#endif
 
 
 	mutex_unlock(&dm->dc_lock);
@@ -5615,8 +5616,8 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
-	struct amdgpu_display_manager *dm = &adev->dm;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+	struct amdgpu_display_manager *dm = &adev->dm;
 	unsigned long flags;
 #endif
 	int rc = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 5cafa8078d5a..a7768ee07c92 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -245,12 +245,12 @@ struct amdgpu_display_manager {
 	 */
 	struct mutex audio_lock;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/**
-	 * @vblank_work_lock:
+	 * @vblank_lock:
 	 *
 	 * Guards access to deferred vblank work state.
 	 */
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	spinlock_t vblank_lock;
 #endif
 
@@ -333,6 +333,11 @@ struct amdgpu_display_manager {
 #endif
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+	/**
+	 * @vblank_workqueue:
+	 *
+	 * amdgpu workqueue during vblank
+	 */
 	struct vblank_workqueue *vblank_workqueue;
 #endif
 
@@ -351,12 +356,14 @@ struct amdgpu_display_manager {
 	 */
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	/**
 	 * @active_vblank_irq_count:
 	 *
 	 * number of currently active vblank irqs
 	 */
 	uint32_t active_vblank_irq_count;
+#endif
 
 	/**
 	 * @mst_encoders:
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
