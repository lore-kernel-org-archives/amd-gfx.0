Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 498A8C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F5A21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qNtEXyfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F5A21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 760B46E932;
	Thu, 10 Sep 2020 13:48:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACC8C6E932
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:48:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kjhi8iy619FWhDIL0vm4Wdk1J45BZywvrZEraA2DFdKxBKgz7iih3i0nCW2RmCnGAhQ8hhL9StKGbrr9KVTdchJc6aeeQtkPKUr2cfVfRruDN82HhZAc3sTZIOu1f5/3C3dVWlkVxoJgqcpianeyuIf3WIu2Je/c39U1YOJvmZd7dhwDMxWaoR7zvKpCrQn4/kg/mxkb8IB314s+PRkYUVIVcElrWdxVhjw+NjhThMvxTSlCCfl/dqJVfIhyRzJK4mqkUZG3xXIQCx4OnX+6+2pSjENRjXorHnO/Z0TMI4zLKyXhnDGYRqD/LnI7l0xLN0HHdyHSxxS7Z9QHCYUlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5HAvtoMCyEIZ1P04T9v51kXd/9mfiVnkUAmBaal4Z0=;
 b=ZG0qpkK9wdagxNC2o/Z3v0SoWVhSOq+9PKhna253SYU4ao2qvErhVPQmRR6OIh9lz1KIXDAaqcFAHNCzar8QT6PS6+x3FouhzvuEVYzi94nQPARLYVx/0Pj/3xOQOOw0gR1dTLfjecRLxlspHS4+3LduBdKsbup6nL4CYUosxqouXuKodbbPaDr7OjyBPGu3zTeIxRMnkbwzialUgDG/7Y2KHDNP0vsvWdvG8YZPjOiU8HUFs9+v+wqCIS/sOF4lekdzp22MaxX0UZkb6xvBMEOgqt5hqKp6c0jVTiTiyuOUCgiKAO9B/hAWrdgW4gIHlsB3Fx3QllWPC9rFm7sMLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5HAvtoMCyEIZ1P04T9v51kXd/9mfiVnkUAmBaal4Z0=;
 b=qNtEXyfUeL7WFase19tegX4PonGnRnWqzjBmlEC5u6pfRZiPzbJgO+el29KjW6TGDPjttPOwDkdR/cspyVC4uhLZKYbXT6pt9r4nst4Fv8VrfyFybcCWs9YyOCW4l8VzH0INu5hK6n5IzsnF+eclKzrnBMDM0tZhj0twpALswXU=
Received: from DM5PR06CA0094.namprd06.prod.outlook.com (2603:10b6:3:4::32) by
 DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 10 Sep 2020 13:48:14 +0000
Received: from DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::d0) by DM5PR06CA0094.outlook.office365.com
 (2603:10b6:3:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT008.mail.protection.outlook.com (10.13.172.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:48:14 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:13 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:48:13 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:48:07 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 35/42] drm/amd/display: Add connector to the state if DSC
 debugfs is set
Date: Thu, 10 Sep 2020 09:47:16 -0400
Message-ID: <20200910134723.27410-36-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910134723.27410-1-aurabindo.pillai@amd.com>
References: <20200910134723.27410-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea9505d-dc74-4a6f-7826-08d855902a1e
X-MS-TrafficTypeDiagnostic: DM6PR12MB3435:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34357C121FDF5C599C85FF4B8B270@DM6PR12MB3435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62+yn8ahVYDlBTChycykO3KDrOVRikHN46o2HZ4ysUVmnlM9dTzSq0oX05RFFGlxa/oY/fILHTAZOkeQmdZdWsTkPOXWmdk8C6FywPZT3/g7HpYQ7qncqxmPRGBNtxw+CUnomEnuxcxhcYSUbaKNjg39Oy7pZOGwWxFtv8Gx2i5pmrvY7eMukWZ3KigSxuI7dRt1EUTYAfuLslZpjfKaBnwGqF6LPJWRXJ9r5Dhi47hiEtDRLyzsGQT2GrEPMZfWJlcoSuXxwkqsSmJ9zV1h2GSf3VdwpbEEe9GWOEQQho1hlGPh1RFCdGQjj8InzCZsVjavPYuRX4jO+FHsnRG4FZnF3dzfQDbRTVTULb0YtYcEIt2dC04OCLabGbJzZpT/x6Rlivfc/7+6q0VQyN8lzGNagM8l9Gqn5xb+JdHTs9WHjPdiFesmANoGspoMXuXA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(46966005)(426003)(356005)(6666004)(81166007)(336012)(44832011)(70206006)(86362001)(36756003)(2616005)(70586007)(6916009)(8676002)(1076003)(8936002)(7696005)(478600001)(186003)(4326008)(47076004)(26005)(2906002)(83380400001)(5660300002)(82310400003)(54906003)(316002)(82740400003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:48:14.2377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea9505d-dc74-4a6f-7826-08d855902a1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3435
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
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eryk Brol <eryk.brol@amd.com>

[why]
We want to trigger atomic check on connector, which DSC debugfs
properties have changed.

[how]
Add a helper function that iterates through all active connectors
and add them to the state if DSC debugfs parameters have changed.

Signed-off-by: Eryk Brol <eryk.brol@amd.com>
Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 11afdb28eeda..ba18c7b0cc7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -842,6 +842,45 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void amdgpu_check_debugfs_connector_property_change(struct amdgpu_device *adev,
+							   struct drm_atomic_state *state)
+{
+	struct drm_connector *connector;
+	struct drm_crtc *crtc;
+	struct amdgpu_dm_connector *amdgpu_dm_connector;
+	struct drm_connector_state *conn_state;
+	struct dm_crtc_state *acrtc_state;
+	struct drm_crtc_state *crtc_state;
+	struct dc_stream_state *stream;
+	struct drm_device *dev = adev_to_drm(adev);
+
+	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
+
+		amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
+		conn_state = connector->state;
+
+		if (!(conn_state && conn_state->crtc))
+			continue;
+
+		crtc = conn_state->crtc;
+		acrtc_state = to_dm_crtc_state(crtc->state);
+
+		if (!(acrtc_state && acrtc_state->stream))
+			continue;
+
+		stream = acrtc_state->stream;
+
+		if (amdgpu_dm_connector->dsc_settings.dsc_force_enable ||
+		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_v ||
+		    amdgpu_dm_connector->dsc_settings.dsc_num_slices_h ||
+		    amdgpu_dm_connector->dsc_settings.dsc_bits_per_pixel) {
+			conn_state = drm_atomic_get_connector_state(state, connector);
+			crtc_state = drm_atomic_get_crtc_state(state, crtc);
+			crtc_state->mode_changed = true;
+		}
+	}
+}
+
 static int amdgpu_dm_init(struct amdgpu_device *adev)
 {
 	struct dc_init_data init_data;
@@ -8609,6 +8648,8 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	int ret, i;
 	bool lock_and_validation_needed = false;
 
+	amdgpu_check_debugfs_connector_property_change(adev, state);
+
 	ret = drm_atomic_helper_check_modeset(dev, state);
 	if (ret)
 		goto fail;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
