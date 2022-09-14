Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45309ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 03:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4C3110E802;
	Wed, 14 Sep 2022 03:50:20 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2ED710E800
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 03:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCMIrwfREMLlFM01oqhObHfrpkOOMAwdWMBgb6wcE12nT97JDS0S8JEQn6eSWHWEg8qs9838UemWk6EBkCI2s5z/ioeggwRyEoHa248HhkKKsRe60mVXecBD0eU9cCQDov9jqOWk5RnaOOrnJSCh5AiZzZzwj72CkXtUlUK812zmedwhG8PA/a1I+DNmXQwgfxXP+jclFxEkdj8o24nZf8TQIiKX1++rMfnHPbMBGICjrd2oJkDHk+K0vE0v16S6VcRB9vQm9gY32jDO8dWWBW6UC2xuhIWHTMtuHsTSq16xpUESX3y9IcWW7upuMEibuZNdO6ysnDW5/2MTHdgGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lveCSPitdth3cZ21KJ8WE0CDc2C7v9EaddY3VAYHQPE=;
 b=bnN7Z1aOxuivqQOHTDsmtjVEmMSVkhIT+TxKgFtyNb5wJLAP39wLdSA4iXF8Q0JMlKF3qcI3VFjpUkyz+NRIDHWiPSOQy4jiZMToQNFgR/suy5KHHI4qU+pMQwFtOkfWxGaLLWTLkJwq+tbGpruV1ZN4LKZC0WzsAy3u410E3m+R164iAUTdqvMvC2DVsg/l1FdvJe5mNG9qbywd9Hofvc5J9/TPZ8zhlvRKyml4pnc8H7sCKF9NNCa71jj/ClORcBY7015YflZfwIQUeTjXcdiUKL8MJErkslUsQ/mQTHgZeNFAjQ7jQAyXKKcI1eJo6J4TJFs9TnXgQJKt+9rVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lveCSPitdth3cZ21KJ8WE0CDc2C7v9EaddY3VAYHQPE=;
 b=B4JS4NN4JOX44FFYEBFFivb1/iZUY3m+3vreGRXmVmAurT1TZQvV5KByVg9zha1hlaIe9VRqudMiSWZpDhopuEg41RbSlsbd3jp9OB774qQ0I5nv4VdwO5WhRaK/sK9oE+gNg9fn9bLT8Xvs4OdIX1BAZQiVbHUmvExgLTq8k0E=
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by BL1PR12MB5079.namprd12.prod.outlook.com (2603:10b6:208:31a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 03:50:08 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::40) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 03:50:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 03:50:08 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:50:03 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 20:49:33 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 13 Sep 2022 22:49:25 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 07/47] drm/amd/display: Fix double cursor on non-video RGB
 MPO
Date: Wed, 14 Sep 2022 11:47:28 +0800
Message-ID: <20220914034808.1093521-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914034808.1093521-1-Wayne.Lin@amd.com>
References: <20220914034808.1093521-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT064:EE_|BL1PR12MB5079:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e3b1583-97ed-4e4b-b214-08da960437e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: clGshFum26hn5Pw4jrDQ2CoDN1RfLlkMLfzxwn/P0/LjP16lUumenYJqUhoLnmKrvPz9L1tfHaIJ8Rt7UOmZHFtVg18z31pLqc/dIseLjGilHcZ0zQsv5tQPeSE4z//S1AyJRW2oftJHRzjcFah5zVIkSrF7cqKWdHy3xqotY2Hva5xYy4fY2IOTFj9Lkju8/UuCGHsFDAom5LUzm1Ri8euOLV2dm1UTt3QEIFoS9+M1B4Wo8OtA2dcMc98Y91NPYQFB3h0szF7DSONpn4vO5ccnvSTX+rVVUC7ba/lkC9PK6wTNv457cgXSadmjDUADSsHjvQFZQzBZtoIIOIL+mwATYD4Fqh0f5cbsospFeiHZEn+F0R9xXzYAnZyTUXTPKc3aCK887fH8yi1crpDL8b3VqWGte0ikQNuMh2dBvQfCJZ/HbyH/a0HHURUrcsO4j0YRcqg9Hcgd6CJjcw4uYuyV0Of+bSm6qEGCDSZ18Kd1jul7aPl3mo3lhhJrCa9h83gvfPHT/W4NcO2b5o0gVmRebWulZlv6zmqbjMJUi1GUs0OfKlM1erY3INhV4zsEyhEHRQ5r9eBxshUo83ORbC0P6eF3f8d6gT51vevF0aQHXmoBWzC2S68J0/2hQXZa99h2bHir4w1RJxBkdeeFwpKCCnXJBoPi4kojcMQmlvMYjl5dZzf6tLvy3sPqgUrjPmz32ptSMl7Hx7Hh4osIVMc10QBtc0mYXL5sY9HDQeAsJ1nbiJA9jBtJXkcxgMaEanNulYv7bfLEH5oWSVrnNV0hIvh0ltGlJJKKN8gh/wn2ry2XEF+NyYIG7CK5JANY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(36860700001)(40460700003)(36756003)(356005)(82310400005)(81166007)(86362001)(40480700001)(82740400003)(41300700001)(70586007)(70206006)(8936002)(4326008)(8676002)(26005)(5660300002)(7696005)(478600001)(54906003)(6916009)(83380400001)(2906002)(47076005)(426003)(316002)(2616005)(336012)(1076003)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 03:50:08.7597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3b1583-97ed-4e4b-b214-08da960437e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5079
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

