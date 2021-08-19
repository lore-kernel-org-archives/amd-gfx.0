Return-Path: <SRS0=nAtJ=NK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72314C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 03:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260B2610F7
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Aug 2021 03:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 260B2610F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC17C6E93E;
	Thu, 19 Aug 2021 03:09:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C8316E93E
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Aug 2021 03:09:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLt0ITVjRd9KL1mM4NCMiaohTjlFOe5mIDAoPYjXEDHmV9FKByYGRrHWnqzQtrUjxejgzmmaf7qszb9A2hHyhdLvwL+H1MLDJuV8j8ioYRgcdO9/Jc2y8G3R3G82tUQ2/McUfJJgAjzL6Qyi2Ca+oD9eKk6lsfN5p91bfKzRpQQ17AJaIelwlHwWkzJxrXrGuJUh9DnObEZBKeV7hIGO/gpfFLPZdc77WZvxoYxrePMwtToXpIBpnL4w7mfbIDw5a1twec6eztH7ttUDyBzQtJXGLjXP/jIZrLtJyrvo2Sle4JoylAUhEy9hGficQuhhbVsesDXC/rbc1xqMBUbgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmHbHlxjLDTKH98/wVE4z4T/CgWpU6o0xGY/vYOBHjA=;
 b=L/dDylNFmf5KAK5pAID8l/jtO5iQSsQOfWPNTy/Zb0MpUx+q1iorrU0EuBaK8KdDCHUPokqmJUJ11UWGsuGihcKexeCtw29qNsLtAJekX1sETXP350Cdnu0sfz9V4vBrg7UFYD+unFDT2/75j3BBMPZGHw0DUt2zc3akX6P88e8arymTCp8XnaKF71mMJa3d9zyMSVhqwnTOyakrPF1caifHbYTRKz0NW7/+3hNLQ6DWsM4hPmjYJeF5Ungoe9xtxSVLQWUmZZcp3KhYru0lX9yX6BSVaSNw5Wxy7+Y+yLcb7ZK3kcBT6Fi99pnNqTGl5MUMavCGbnVDG9Mfh27h2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JmHbHlxjLDTKH98/wVE4z4T/CgWpU6o0xGY/vYOBHjA=;
 b=hxlmUENE4Lvj/Vj421ODxejDD04jrAnDl7CHGxSESqCRBWb/W0rS6hCzu/tZXzsLjBAY4H+KB8yduoK6VFsZP9kxJckFf14mHOf7yzxacmA+r1stUbeuPcaVxpSNMZpJc0Pl4qv0vhWhwEATkyIc4mlqxQkUT327jc6cjak03bQ=
Received: from MW4PR04CA0295.namprd04.prod.outlook.com (2603:10b6:303:89::30)
 by BY5PR12MB4967.namprd12.prod.outlook.com (2603:10b6:a03:1de::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Thu, 19 Aug
 2021 03:09:19 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::66) by MW4PR04CA0295.outlook.office365.com
 (2603:10b6:303:89::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Thu, 19 Aug 2021 03:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4436.19 via Frontend Transport; Thu, 19 Aug 2021 03:09:18 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 18 Aug
 2021 22:09:15 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Guchun.Chen@amd.com>, <Lijo.Lazar@amd.com>, 
 Evan Quan <evan.quan@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [PATCH] drm/amdgpu: add missing cleanups for Polaris12 UVD/VCE on
 suspend
Date: Thu, 19 Aug 2021 11:08:59 +0800
Message-ID: <20210819030859.1470753-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25c9f452-a0cc-4543-199a-08d962bebc42
X-MS-TrafficTypeDiagnostic: BY5PR12MB4967:
X-Microsoft-Antispam-PRVS: <BY5PR12MB49679EC4BC7BB22EEF05456CE4C09@BY5PR12MB4967.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G+XQ37wTuKPxe2GE7a3EPh9AK6M7PaKyTJPnOc0UGhO5RWRSB80s5rAD3G/cfpjBq5yBsAPdVjyhkJqFokvRqYyAprSZS5DRg9zLtqaag2nigcVZmaBBZDlOVgYOqFSU4TZ+frMuF0h+jayTAw8zDD0gQWux8gE/RGVsZGx83IkCoIiZUU+4K7M2FXaAEhCnq8HsGgfLOWc7BjPd0K8SfFkVYU9uOc05oUp9O9a18IRYDbEFp0nR80A0igkH63FnFVmN15uRIn2ts8FW9v34V/gR93ZsokVJVgncxEAwvmhHwSg3kn2835nyoGcgD3ii4g3QLstIpeTT443fzbCT38dFtph/uN9lzQ9JbUG2Swq85MzPhSOLw8af77AVD8O5cCtVHDPbeWcPSa/DHp6X+PLnNKzzM9H2GOsfapxYzkpPGip1uyjHTv9rXhuvtXj8G+ymqgsmJly5rlow7FXCEoECvxkcSZeJvgX9OwYAcA4ODMgUwSLR83GXQFYbX03MOY0pGZRJ0nLCneFZWfcTp0YbbrrZ9phD6tNdgvAY8mkFnRNKebMhBIDQThX2VfTmW0A+2WcZdeLi5VOTlAIK3Si1P7Kubyfgljp8wHsjBtyikDEB92RlMSzeWaTMFmuXZBZFt/dYtJ44SbO2TBoi91r9K802mJoMlKYVyHOJZbsWtPiaxN4oqoiLWSXJXuHLwNgfoXZ7gwB9uH2B2MKLC04OmSD4irisbii/uT/tbW3wQYlk5A+7uraDM2DUsl0DxBLViq08fiSZIw1uN9wqqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(54906003)(5660300002)(6916009)(316002)(186003)(70586007)(82740400003)(15650500001)(26005)(70206006)(86362001)(2906002)(36756003)(36860700001)(83380400001)(81166007)(8676002)(16526019)(356005)(478600001)(34020700004)(7696005)(82310400003)(2616005)(8936002)(336012)(47076005)(6666004)(44832011)(1076003)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2021 03:09:18.9743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25c9f452-a0cc-4543-199a-08d962bebc42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4967
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Perform proper cleanups on UVD/VCE suspend: powergate enablement,
clockgating enablement and dpm disablement. This can fix some hangs
observed on suspending when UVD/VCE still using(e.g. issue
"pm-suspend" when video is still playing).

Change-Id: I36f39d9731e0a9638b52d5d92558b0ee9c23a9ed
Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 23 +++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 4eebf973a065..d0fc6ec18c29 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -554,6 +554,30 @@ static int uvd_v6_0_suspend(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->uvd.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_uvd(adev, false);
+	} else {
+		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
+		/* shutdown the UVD block */
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_UVD,
+						       AMD_CG_STATE_GATE);
+	}
+
 	r = uvd_v6_0_hw_fini(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index 6d9108fa22e0..a594ade5d30a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -503,6 +503,29 @@ static int vce_v3_0_suspend(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+	}
+
 	r = vce_v3_0_hw_fini(adev);
 	if (r)
 		return r;
-- 
2.29.0

