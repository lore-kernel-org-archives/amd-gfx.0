Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 974FCECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0655610E7E3;
	Wed, 14 Sep 2022 03:26:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B89F610E7E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqNcf36SsRWs0DiIeO5973NrmIBapUfSu1pMublxw+e4QlCerCrAbdFATQxP9lso0LnVJbmbzaGPTjI16Zh77a2bB/cXDUWxgVzBapIXSjN+MHGb+MXL5MmNESgLR5tQvlFht8FFHG6IBAZ6PuJFMpMPcnRk7tyVGplGofzRhF9DvNHiCjzTUPSKAGcXRZCszusz2boSf5phTv+9czoJckWtD1wUXe7NgJFZ6pGsYSYyP1lo2iOENz5y9b2F1k3xQso6YkrubZprVctH9rvx+jHu/zisBXDsDx15o8Nekwsn1+hB7lFJTkTeZ8cH7gjqlKnd3V5uBw8pGAHWmKg0yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lveCSPitdth3cZ21KJ8WE0CDc2C7v9EaddY3VAYHQPE=;
 b=SFMzQKnvTzh2h88pgNa19ZYKbwplMajiBnKEVf7NCQRB1VybwkIF5W4Fd5X89/JtqI+SB49PinRb5ulblUao7u12r3+SvtqXFUlrQArcI3cr38U0wJRcra9xPulxJANnMhGkEEu41brz2lCb0pjFrofFr5YqzrXkkAXzahWnO7+htSG+x7gTOtu4LkWPjvQIxXlTfckIFaApg5xjPYT6l59wmLYW0dDK0BUNpcacRPD3NJLUScH8y8QszjR2SDPSo0F+uXZY3sd+kYICaJcYmRk4NgaA8WQszpOfTY/9OxPUxsQt4xmM2izna1mkJ4vz8NCxPEHRy0ukE16tupGsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lveCSPitdth3cZ21KJ8WE0CDc2C7v9EaddY3VAYHQPE=;
 b=m41cG03gSwH0iMAuXodpY/3UJs49P2tMYXVuEgeO4OKqtWe7YKLGKmjUJ6ugVS687y3u6FDPr9znT2h4gucU4Mq1K+1SVJzjhz/NbO72WllePpmoNGBvzIwrrSrqLWcfFwEDol/xv/I6+1JZX9QvCuQqW4kfwuJIdxecgZvFmDA=
Received: from DS7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::6) by
 BY5PR12MB4227.namprd12.prod.outlook.com (2603:10b6:a03:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 03:26:35 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::1e) by DS7P222CA0010.outlook.office365.com
 (2603:10b6:8:2e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:26:35 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:26:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:26:34 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:26:25 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/47] drm/amd/display: Fix double cursor on non-video RGB MPO
Date: Wed, 14 Sep 2022 11:24:01 +0800
Message-ID: <20220914032441.1075031-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914032441.1075031-1-Wayne.Lin@amd.com>
References: <20220914032441.1075031-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|BY5PR12MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 731c94dc-593a-46c7-a0aa-08da9600ed7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JUC7HrtFzO53aQga9yoclZ156wGSrrGMrsOiZgeT8pCL2Q8BR8vbdT/rb7lAWUBMdZHrsPgZfvAr91sW3xAjDoL8mB2gcyoAACqQydac0T14tcvFjCcTFHuoTvAg4ATyQ27/SvD4Dh1q8Gxnbr2XD8sTvVx1bnRfdJ+pgzL2aGNOD7kKbtx8k5T+StckACaUObDGKNb40pNvR5qr/syxZlVF3VhqVG91lExtnrudjMtmFprQ9PwfbJE59FLfh7fb81ib73RJZOXrKYZd4vn7iN4MIxzAMQPNa/DfwxFJvtP2c7RMStooeelNUkwspIm1EdxRzdUIR50+CU5E5qE065HYiQ0pCbjjWdY4xcB57BAzUtsewrBEHROGHiktwD/LfHf3GNugu9gKLEh1z92lOWekRwHAhuPpgmSvAX0H7Ncg8mcVtsEhqXYGnvoC/7wHsL3Z5qLI2aEpDY7/rIUtYx72S9Jcotn8c2rWPQSLQ4MzjEaTJdMB/6QkclES0SoXPEH9UxJ9HVz+NnbCy3yjkrNZVIxfXX/o+2WvtGuGEXSQMJQzaBNr6VlcNRZ/Fg0UNFoTkTatCnJNAUNKKu8AVA/VtkLDQqxBZ14kyJaJSmogW4X83PIvcji2CmjfFwcoikZcQ/kTrAx34XFNM3xe/vF47nU1NMrn55vvykjaXonsLpD6A9x7uy9MD/5HlGCYhRJZC3R6X9Q4DJKT1XzBoXd7A5Ty+Cpd5pcO4frsdVUp//+Te5eqFm0sNdT2HoJMKcq7whnQt5w483orO9mDRh7kKH2TVB2Mv6by0KsZ4csUUqYMpZSJviqDMcxCOvvZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(36840700001)(46966006)(2616005)(4326008)(81166007)(478600001)(426003)(186003)(70586007)(8936002)(5660300002)(2906002)(86362001)(336012)(356005)(40480700001)(41300700001)(70206006)(7696005)(47076005)(6666004)(82310400005)(36860700001)(54906003)(8676002)(40460700003)(82740400003)(36756003)(1076003)(83380400001)(6916009)(26005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:26:35.3943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 731c94dc-593a-46c7-a0aa-08da9600ed7c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4227
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
Cc: stylon.wang@amd.com, Leo Li <sunpeng.li@amd.com>, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Li <sunpeng.li@amd.com>

[Why]

DC makes use of layer_index (zpos) when picking the HW plane to enable
HW cursor on. However, some compositors will not attach zpos information
to each DRM plane. Consequently, in amdgpu, we default layer_index to 0
and do not update it.

This causes said DC logic to enable HW cursor on all planes of the same
layer_index, which manifests as a double cursor issue if one of the
planes is scaled (and hence scaling the cursor as well).

[How]

Use DRM core helpers to calculate a normalized_zpos value for each
drm_plane_state under each crtc, within the atomic state.

This helper will first consider existing zpos values, and if
identical/unset, fallback to plane ID ordering.

The normalized_zpos is then passed to dc_plane_info during atomic check
for later use by the cursor logic.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a9f7c7da7d6..85172e1e3351 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4756,7 +4756,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 	plane_info->visible = true;
 	plane_info->stereo_format = PLANE_STEREO_FORMAT_NONE;
 
-	plane_info->layer_index = 0;
+	plane_info->layer_index = plane_state->normalized_zpos;
 
 	ret = fill_plane_color_attributes(plane_state, plane_info->format,
 					  &plane_info->color_space);
@@ -4824,7 +4824,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 	dc_plane_state->global_alpha = plane_info.global_alpha;
 	dc_plane_state->global_alpha_value = plane_info.global_alpha_value;
 	dc_plane_state->dcc = plane_info.dcc;
-	dc_plane_state->layer_index = plane_info.layer_index; // Always returns 0
+	dc_plane_state->layer_index = plane_info.layer_index;
 	dc_plane_state->flip_int_enabled = true;
 
 	/*
@@ -9481,6 +9481,14 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		}
 	}
 
+	/*
+	 * DC consults the zpos (layer_index in DC terminology) to determine the
+	 * hw plane on which to enable the hw cursor (see
+	 * `dcn10_can_pipe_disable_cursor`). By now, all modified planes are in
+	 * atomic state, so call drm helper to normalize zpos.
+	 */
+	drm_atomic_normalize_zpos(dev, state);
+
 	/* Remove exiting planes if they are modified */
 	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
 		ret = dm_update_plane_state(dc, state, plane,
-- 
2.37.3

