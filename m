Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC44E7719D
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ACAD10E9FF;
	Mon,  6 Jan 2025 20:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N7aagzwD";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B45510E39C
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2SY4tY7xwDs03VBeqBgzTBURTGHem01PjOQOhQGIg0kP03B0rqQBwU+l0DgaR2RfBC2bfd3cjD8pimoGlzikXU22/nZ3NuTkWVg30BN6DwNgNFG1q5pKKkLLJOW4tEZEV1ikyD957IjBAXKeRqmjo3JhKXHz4ajjksnhGxIKPnWz1h/8Q9CdrhuNxzDQBAklLfBOZLktkWZk4ggN6Gk2iXY/OfWnrH3Jo3bm+Tdpd1cof1N8UPlZf6jlQ8SSW1sG/2BvvuTZAvovtCt8tbk9l+T4pbwp141dnLLaE51Oj5MIQKsYd3cyN1hfiV7HyegUAs7hnu9jzQdcNiiKMxaow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMrhTLYGrh44lWoSsW5DIn7B38QT1PwMsuBrcE0dQ9I=;
 b=dViQVEQsngaUi3/0Z0KrYjdOLquor7SGHi90ukMs3Z3+goftVhCEIA1poFmVcs3+ky/d+rRN4GhzKc/8Ob24WHvFJGLPdt/Me117Wnd6GGFa+Dv+nK54ydNxE56LTrpoWmwP0r3xCdD1GMRANhm3+8/DwTcUzpzrzXGkXgVECRTDviwthZk8u63QDs15Jashiiqqa13bJSQldKIqRjgX0zAFxaO5ngvGUiSH5GPjfJZhxLoRDeE0chfMYF1F9e6vfxYgF+iJd3iZ3unCjU29lxFkl7klhRkI9v6wittDBA0Q6JkMl20OKHbliIS94mo2M4EzN0ZlyC2KV83sFZ8a4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMrhTLYGrh44lWoSsW5DIn7B38QT1PwMsuBrcE0dQ9I=;
 b=N7aagzwDYZUchSJU0edp0KVUt1M40qIWUjNk2QWTCDU+2Ntfc/122wxiQpQqNnxt7KO0GPnvcoTMcPkG5/5tb2azEcmU/zdvKwb02ERZZLole7crBdd/KS4Sxo+IvqwA4I1+S4rRhO0wnJxT8ephVdbb8GloSUT5rnpRtoExHUU=
Received: from CH0PR08CA0002.namprd08.prod.outlook.com (2603:10b6:610:33::7)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 20:33:29 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::ee) by CH0PR08CA0002.outlook.office365.com
 (2603:10b6:610:33::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 20:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:29 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:28 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/10] drm/amd/display/dm: add support for OEM i2c bus
Date: Mon, 6 Jan 2025 15:33:05 -0500
Message-ID: <20250106203310.3349585-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f4e8e7-f31c-4694-e8c3-08dd2e916181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?U8wYrLzKB95f9bmMA4jOgnnhHq3IQSenFuAXy7NuNeK+tfdY1xKUmWqfhVHT?=
 =?us-ascii?Q?g/wF1K4U/RjtH7qMnv5isy6B+8LMNTUpWQgvncjAAC8SB5qk3ylBgZNulYo+?=
 =?us-ascii?Q?7yWjqkizSuNl/447qRlxxdtY7YW2R/FwhVjzKeYtSmLQQqkcwbmzjXcwIDay?=
 =?us-ascii?Q?SA3LMbRX/+952Y9pWyFd5vViw+MW7Zha42dD0uqWF67oz1mv5xIR0I2hScmm?=
 =?us-ascii?Q?JLTJa/vnGLmFGbBXXQWWKFEI1dKPpUPHGn8nm3TrM1MDNzakHwgCgiA/Hj5h?=
 =?us-ascii?Q?RenUcRMN3PnY20ZdXCjTrbnW6/pjvrA/0jynev/ekRWKqLaGYQ/aROsglc/p?=
 =?us-ascii?Q?xHt7j1DDxN0fnOHryzTU5NAbI7SsvfPaTyfCKCjb+fjMKYg9oWU4f7cGq86r?=
 =?us-ascii?Q?wmp+/nshwKE8zDUfc1tJC67XrUmfESs7C8nl/E2KXI0qrlJno9yN983o8Kgl?=
 =?us-ascii?Q?3vU5HSco1CzVdesSObuLTs8+ELv0gRJfRk9NoOxNdj1BXW3eJXkYahSxHY0R?=
 =?us-ascii?Q?+Hf3c+3jzdA8eOfMMRRdAO2TApf0Vo+eS8js85g+efFztr6RPNsVKKquzUwc?=
 =?us-ascii?Q?N1AAchz3mwnWGqaJAf/oVPXIiZPauO62uyCV4gZA2rwVHiz9NcKdU+BWgd2b?=
 =?us-ascii?Q?q9JiKTfmmTl20mM1uv6XT+OMpxPOicG5tJ9yKeoWOIe4LKB4hiZoJzQkiZgH?=
 =?us-ascii?Q?N2STbidJpVp7bAgYE30xUhJttYMKbJWzIcZZve4fT6ANFZ8qAJ5123UcZgE9?=
 =?us-ascii?Q?7WeLgcwW1dEidphGLKcMhvOp+gVyLy/RYKUq6m6G41am25AN83VmTaqzd4/7?=
 =?us-ascii?Q?AFzgMdAl93bpshO4Cs3rQmszJyrTvbkWvr3ktz9l1s0+/XHY4Y7Px0CdHrl/?=
 =?us-ascii?Q?JMMPE+ZLPexYkxZW+pajH6lsMq3ruX6pjjjEmm2towQslTzdqW2BiMNQ0sDK?=
 =?us-ascii?Q?pwIcsVrGADJZvcWZzO1whHwa0rZrWbtyttk1YitNcHJgHt0gar4K5cyL5JlN?=
 =?us-ascii?Q?UUYXbJFcNAWNcmxRmrzE8HFkY66NtXj+3aQhVysppiyRKRs8BTXEmBLoeNRQ?=
 =?us-ascii?Q?G4A1Tvg4D6R8ScBfhPLhA0N9dLlKwToRo+z608woEiCS8jMm5MvHuTKafWZx?=
 =?us-ascii?Q?fr0z2v6rcp4hHqHYaqL+p3J1mtAgRBMcmAJKjFnswpI3glIIvP03e5IXWqBA?=
 =?us-ascii?Q?51v5XIELT5wcWURGjDLNK/h5sEMBJpP4RKrYt2wy45Ed+itWxiascYT6CVpq?=
 =?us-ascii?Q?5qMpNsXrKMHEwK+q8uwjWe6dY+6Vd0Y7G4RWWFlekBPtGLYjdczySuFL2wkM?=
 =?us-ascii?Q?8xWl+YIl0y9hKKXmbjAL8I8TmHzrPYc7ICmunNmehxdUXmgtGjwQY3dW6Zfr?=
 =?us-ascii?Q?DcDI9M+5AErP5T/Y2ri/k56XervdaaNG7KdBNfsuQJw1D5IWE3enyFVhK7B2?=
 =?us-ascii?Q?0oKXpKSRXAatsYGL3sv43uPG3uIN3dEM7CNmnRA8KgnAZOvPdzr6kxcRbAyG?=
 =?us-ascii?Q?zliPFFTL231716o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:29.6736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f4e8e7-f31c-4694-e8c3-08dd2e916181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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

Expose the OEM i2c bus on boards that support it.
This bus is used for OEM specific features like RGB, etc.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 35 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 ++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5c70b512e6367..d9b983bd1c2dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -177,6 +177,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev);
 static void amdgpu_dm_fini(struct amdgpu_device *adev);
 static bool is_freesync_video_mode(const struct drm_display_mode *mode, struct amdgpu_dm_connector *aconnector);
 static void reset_freesync_config_for_crtc(struct dm_crtc_state *new_crtc_state);
+static struct amdgpu_i2c_adapter *
+create_i2c(struct ddc_service *ddc_service, bool oem);
 
 static enum drm_mode_subconnector get_subconnector_type(struct dc_link *link)
 {
@@ -2840,6 +2842,33 @@ static int amdgpu_dm_smu_write_watermarks_table(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct amdgpu_i2c_adapter *oem_i2c;
+	struct ddc_service *oem_ddc_service;
+	int r;
+
+	oem_ddc_service = dc_get_oem_i2c_device(adev->dm.dc);
+	if (oem_ddc_service) {
+		oem_i2c = create_i2c(oem_ddc_service, true);
+		if (!oem_i2c) {
+			dev_info(adev->dev, "Failed to create oem i2c adapter data\n");
+			return -ENOMEM;
+		}
+
+		r = i2c_add_adapter(&oem_i2c->base);
+		if (r) {
+			dev_info(adev->dev, "Failed to register oem i2c\n");
+			kfree(oem_i2c);
+			return r;
+		}
+		dm->oem_i2c = oem_i2c;
+	}
+
+	return 0;
+}
+
 /**
  * dm_hw_init() - Initialize DC device
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
@@ -2871,6 +2900,10 @@ static int dm_hw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 	amdgpu_dm_hpd_init(adev);
 
+	r = dm_oem_i2c_hw_init(adev);
+	if (r)
+		dev_info(adev->dev, "Failed to add OEM i2c bus\n");
+
 	return 0;
 }
 
@@ -2886,6 +2919,8 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	kfree(adev->dm.oem_i2c);
+
 	amdgpu_dm_hpd_fini(adev);
 
 	amdgpu_dm_irq_fini(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index e46e1365fe910..e1479228eba61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -606,6 +606,13 @@ struct amdgpu_display_manager {
 	 * Bounding box data read from dmub during early initialization for DCN4+
 	 */
 	struct dml2_soc_bb *bb_from_dmub;
+
+	/**
+	 * @oem_i2c:
+	 *
+	 * OEM i2c bus
+	 */
+	struct amdgpu_i2c_adapter *oem_i2c;
 };
 
 enum dsc_clock_force_state {
-- 
2.47.1

