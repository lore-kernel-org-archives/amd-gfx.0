Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BFBC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:38:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE3410E3F7;
	Wed, 17 May 2023 11:38:55 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CAB510E3F3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:38:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/pw4Rhag52jtaIEEpO1tLNbgT13lONoGX8D7OnqX+rsz+D0+Xd+BYMRpjQU9di9NrA1BX1esKpeBAizH0f7lGOfB/aQ3U27aEMsWcXz3RlT4BqJ0zMSMGNftN24JZm1EMQ//JIgskPdgYrcWd72ppCbWyDu/lzaaBCm5qAeRoTN2RA1k1pFXKuNBqsf0cZonkThUlQ69up3R0/KIG3nwvZH6KegENZjYb5KxuX6Yf4SCCqhV7eswf9M8+zNDU9U0Q3TaWgAI3jW+g3qZHmwcRH5QNoiy6KT7jBk5B0Jyj9CmNv/dMsDFjZmISJ+ccs4gBiolh3jvUK5ZcEv4fiKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSPq2Ix4dPR3Eo4gB+IIjXQSyXhoDaEBDBJLoHzRejs=;
 b=iL5dWLjntcIQJ6fZ0u0XKfTL3gv0Aq13YiKbD+4UCpVM/yMeLy/povEah7ZUUuzqB3NLAi9UXV4azhXLxGRPVhIp3ghzjdsm6vIXoqkTblCUpajtiltO4Rb815cUn8HA9+kP1w+CFPfOEVZsmgXc4qTIrhlmrrWhceo93PzMdeJbGpKxQTHMyWnOR619SdMS0V8YdEDGbTPO2F+SAtxEe0uVZx3ddYldIcWBb/uTba2J0ILoTiahHLoI3tT9pit8KOwYYz31yKrpiAfdT9ud3e7nDQCJke/De40wPm0KsWVyGBi3IKx9QpmWLZKyWoEBs7gtiz/G6ZYWji2qj9bBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSPq2Ix4dPR3Eo4gB+IIjXQSyXhoDaEBDBJLoHzRejs=;
 b=4lztEAEpTAhAdUOlbrZIfC0zx87ZCnuh8WYNdXayeserpGId3yVLpVD/UlsT+f9HdVXuCUYFiGnK5B8+VPE+eGSdVZirREvV/QAZRtY/OTqXut5pfjVOAEMjUjrlJYXmT/tujlPiUKCmj22RwLUen7eFn+jbL9znAizEUVhHLQc=
Received: from MW4PR04CA0116.namprd04.prod.outlook.com (2603:10b6:303:83::31)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Wed, 17 May
 2023 11:38:50 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::32) by MW4PR04CA0116.outlook.office365.com
 (2603:10b6:303:83::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33 via Frontend
 Transport; Wed, 17 May 2023 11:38:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:38:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:38:48 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:38:48 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:38:38 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/18] drm/amd/display: Fix warning in disabling vblank irq
Date: Wed, 17 May 2023 19:37:10 +0800
Message-ID: <20230517113723.1757259-6-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT008:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: 5afc52e8-4b7c-40f1-eeb6-08db56cb4881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PbkydnvycdwwH3FcH4nbQRoTYfSX/TgUapzFKaFXBRYaOL/MzoCJYAO3b8Ad+ZmNe9a6fX6QGL4D2cfMYSG5FvpGteIWQ48ctBXqluRW/Lurw8QXfnZOxpFUIb7BANfiBDlkS7gfnDRMZQDY3TP1yE1eQNkyCUeHI9XnK48s7YgwSnY2g56du7UfPL5wx/XWddZIAGcoz/HaUUWOz66NigxifN3+zMtzioUA5cb8WOne6AePWqziChZjP3tCvvSkK6gwvIsyHDZP+Ai8rdcFmeI+V/L743EkgBeVFb7Uwk/QVWUddn8s8vdvFIXD15kQhxkdTliv0QFLPBIf2NHvGstFkEbkwZiFmdQCa2gbfy7MANzQM5pd5JUDq0C4FXubKXHSJ9f3YgBlWN9WHnNMnPRWg3jLF7LHG25xbc8Y4HVGtFKFgHURtjEMJ7Ld1JEhTrNftUWj4MBPdNSWy1TRKx+FWU8NN34JPc4Gu0vdXMFYJUy1o5nYzL2ZcRt1lo2yC19xDic9j/yuTZlOHzRIoyK7ZE40U9IdfLy5+KwRIzAEWe5AjD+EljJ4RLmFYiSUQx0++HdCs45qhiCr5biYd5ljRvXV8FMSpEMQQycGhdBqLLREW+6TQgQPl2ogISCTZiymnTey21lbNCv35098pO2wkhog08rt382NXQwMqLMfIh37XXSq+BdiYd9S8cSNNFRQR0AqyFHGYvSoec7pFn2qYgxSUmL04WGqrrXNVBkgkbzddjxUe/FwmlOqYIE6KM9MT58in9jfyye+7d3AgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(40470700004)(36840700001)(46966006)(86362001)(54906003)(40460700003)(478600001)(36756003)(186003)(40480700001)(26005)(82310400005)(1076003)(7696005)(6916009)(4326008)(336012)(82740400003)(426003)(356005)(8676002)(70586007)(70206006)(81166007)(47076005)(8936002)(83380400001)(6666004)(36860700001)(41300700001)(316002)(2616005)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:38:49.6475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5afc52e8-4b7c-40f1-eeb6-08db56cb4881
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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
Cc: stylon.wang@amd.com, Alan Liu <haoping.liu@amd.com>, Tom
 Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alan Liu <haoping.liu@amd.com>

[Why]
During gpu-reset, we toggle vblank irq by calling dc_interrupt_set()
instead of amdgpu_irq_get/put() because we don't want to change the irq
source's refcount. However, we see the warning when vblank irq is enabled
by dc_interrupt_set() during gpu-reset but disabled by amdgpu_irq_put()
after gpu-reset.

[How]
Only in dm_gpureset_toggle_interrupts() we toggle vblank interrupts by
calling dc_interrupt_set(). Apart from this we call dm_set_vblank()
which uses amdgpu_irq_get/put() to operate vblank irq.

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alan Liu <haoping.liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 21 ++++++++++++-------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++-----------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 45b778631430..b8e0fc189002 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2474,20 +2474,25 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		if (acrtc && state->stream_status[i].plane_count != 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
-			DRM_DEBUG_VBL("crtc %d - vupdate irq %sabling: r=%d\n",
-				      acrtc->crtc_id, enable ? "en" : "dis", rc);
 			if (rc)
 				DRM_WARN("Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
 
 			if (enable) {
-				rc = amdgpu_dm_crtc_enable_vblank(&acrtc->base);
-				if (rc)
-					DRM_WARN("Failed to enable vblank interrupts\n");
-			} else {
-				amdgpu_dm_crtc_disable_vblank(&acrtc->base);
-			}
+				if (amdgpu_dm_crtc_vrr_active(to_dm_crtc_state(acrtc->base.state)))
+					rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, true);
+			} else
+				rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
 
+			if (rc)
+				DRM_WARN("Failed to %sable vupdate interrupt\n", enable ? "en" : "dis");
+
+			irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
+			/* During gpu-reset we disable and then enable vblank irq, so
+			 * don't use amdgpu_irq_get/put() to avoid refcount change.
+			 */
+			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
+				DRM_WARN("Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e3762e806617..440fc0869a34 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -146,7 +146,6 @@ static void vblank_control_worker(struct work_struct *work)
 
 static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 {
-	enum dc_irq_source irq_source;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct amdgpu_device *adev = drm_to_adev(crtc->dev);
 	struct dm_crtc_state *acrtc_state = to_dm_crtc_state(crtc->state);
@@ -169,18 +168,9 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
 	if (rc)
 		return rc;
 
-	if (amdgpu_in_reset(adev)) {
-		irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
-		/* During gpu-reset we disable and then enable vblank irq, so
-		 * don't use amdgpu_irq_get/put() to avoid refcount change.
-		 */
-		if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
-			rc = -EBUSY;
-	} else {
-		rc = (enable)
-			? amdgpu_irq_get(adev, &adev->crtc_irq, acrtc->crtc_id)
-			: amdgpu_irq_put(adev, &adev->crtc_irq, acrtc->crtc_id);
-	}
+	rc = (enable)
+		? amdgpu_irq_get(adev, &adev->crtc_irq, acrtc->crtc_id)
+		: amdgpu_irq_put(adev, &adev->crtc_irq, acrtc->crtc_id);
 
 	if (rc)
 		return rc;
-- 
2.25.1

