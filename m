Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89632C55178
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0AA2224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TOBC9EpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0AA2224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1C66EDC1;
	Wed, 21 Oct 2020 14:23:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD7C6EDBE
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bK6yBVFtItX2n5PY0W4ZkUXKV5v16RJzgAQMSdYgrbSdodE5ueo3HErvZPdpwxDRdi43uu/TDzmjteD7dHmsdL1P3FHCITChdTes6MSEtw7SJkrEqrUyZZw/y4zJII+n2HSF6wUbEqhvVwFMMp69m0ML3iQWcpb/XLXDsnPPASe/dO5Pt6em3nEPCIAmrxIB5RaX/LeqMnIS+RL7e5MF+63nIUXHfhxNn8yOp8eanUxICsiwxFytQxhJuosuwZYHeV8AEbiGIaJcZY2gyYBOmT+81buCKrhO5mMhuq/Wch1+jBvGiU4uTUyTFMyFUWYFZ34b8DulfMnhg1IBo1Z2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUN7lzFf4XARSw+VSUvR9PdeBe8s1WmQIuuBDIRhMqU=;
 b=WJGDeY0mgCWdUi/7UeG9uqmKgGTXaxfharXx/SO+D5Y11FBTIeBJ4pzjiiIgPu47s4RGFNKPVRYcKK+JE3LdkOpwYQJ+wqgqpU/W0d5myxPp6n6et+aaXzRJCExhUEfDjg2MCEZZRsgw5byY6KoD7oA7eSSb/9h7Kj4Oi9dRcM2Rox7fHAQlMYMGNLirHaaMAwWEDLFKmf8p4MJaSc8JKm6vyHZ2fUWn+UW/5LAFlqW3hbn9DPsfTz7Y+7A8gk/1trF4/wCmpf21zjOsFaWv+XVZVCDka2DkITNnaq5YNkxvXNzNnLMi1kh4qzDK13BNbjsiZMHIHb3K3nHegMzEZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUN7lzFf4XARSw+VSUvR9PdeBe8s1WmQIuuBDIRhMqU=;
 b=TOBC9EpQHYe0oCUtg1UqJSPY0r+LZZCoaQEx8B/WLoEC0u3ho2PQdCyz92CPXctd1YrTjtZn2aBPTEX1e6/lGOxdnnpZcdDaM9DPpS/XP4KXvyogCA3Ru6pLC2FGuKtMr57nYQ6E7R3EnfUoo6XUpCv6MsLyI/c6xmfHaRICEeQ=
Received: from DM5PR15CA0034.namprd15.prod.outlook.com (2603:10b6:4:4b::20) by
 BY5PR12MB3971.namprd12.prod.outlook.com (2603:10b6:a03:1a5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 14:23:09 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::ec) by DM5PR15CA0034.outlook.office365.com
 (2603:10b6:4:4b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:08 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:07 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:02 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/33] drm/amd/display: Reverting "Add connector to the state
 if DSC debugfs is set"
Date: Wed, 21 Oct 2020 10:22:29 -0400
Message-ID: <20201021142257.190969-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b37e6fce-894b-49e5-3a3d-08d875ccd55b
X-MS-TrafficTypeDiagnostic: BY5PR12MB3971:
X-Microsoft-Antispam-PRVS: <BY5PR12MB397176B7B4A741C320AE0E848B1C0@BY5PR12MB3971.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXC/wpEL5KpOW3jylLWYMM7LjgzSDYltVN0uA/LcchIUYqbiWr1LhvqBeLDS9eDCtw1sBwvs8ETApTPNU2YV/TuRHdvsCop0tUtPhriso8yaaHAG1qAm3mMjD10zRoFHCvGytFK65qh/wu2vRgPjuaQoC9eL0hTZHTLrVg9qlcGxFQSbjHbwknbdzGWt+lpkWY5tnvd/DgoojDvB7qq7aeCIZD1FfESB/BcJyRlCvPTp0iZF4YTX9OWOAZMgdSzysBAsYt7dJDkxK05bA8MrQyzK0zhmD/NLOhdy/LgsNo5M9EkUmYOkhgbA4cGaoAWYwEf5UlWu4arkWhMGkS/zAwldjdMBQu9LsyzhoLPEpJYtYNxpHk6HoGghJpH9xRw5L0E4xsbBiSE9crVjIIgAiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(7696005)(54906003)(5660300002)(86362001)(356005)(81166007)(336012)(8676002)(8936002)(6666004)(478600001)(4326008)(83380400001)(36756003)(1076003)(2616005)(82310400003)(2906002)(186003)(70586007)(26005)(6916009)(82740400003)(426003)(47076004)(316002)(44832011)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:08.5229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b37e6fce-894b-49e5-3a3d-08d875ccd55b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3971
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

This reverts commit 39edb76689b8c9e41b1b9e2557da4897a405221b.

Reason for revert: Patch introduces performance issues and might
cause memory consistency problems with multiple connectors.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 -------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 71ecd963759e..71d21cf09f4e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -856,45 +856,6 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device *adev,
-							   struct drm_atomic_state *state)
-{
-	struct drm_connector *connector;
-	struct drm_crtc *crtc;
-	struct amdgpu_dm_connector *amdgpu_dm_connector;
-	struct drm_connector_state *conn_state;
-	struct dm_crtc_state *acrtc_state;
-	struct drm_crtc_state *crtc_state;
-	struct dc_stream_state *stream;
-	struct drm_device *dev = adev_to_drm(adev);
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-
-		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
-		conn_state = connector->state;
-
-		if (!(conn_state && conn_state->crtc))
-			continue;
-
-		crtc = conn_state->crtc;
-		acrtc_state = to_dm_crtc_state(crtc->state);
-
-		if (!(acrtc_state && acrtc_state->stream))
-			continue;
-
-		stream = acrtc_state->stream;
-
-		if (amdgpu_dm_connector->dsc_settings.dsc_force_enable ||
-		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_v ||
-		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_h ||
-		    amdgpu_dm_connector->dsc_settings.dsc_bits_per_pixel) {
-			conn_state = drm_atomic_get_connector_state(state, connector);
-			crtc_state = drm_atomic_get_crtc_state(state, crtc);
-			crtc_state->mode_changed = true;
-		}
-	}
-}
-
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
 {
 	uint64_t pt_base;
@@ -948,7 +909,6 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 
 }
 
-
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -8759,8 +8719,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	int ret, i;
 	bool lock_and_validation_needed = false;
 
-	amdgpu_check_debugfs_connector_property_change(adev, state);
-
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret)
 		goto fail;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
