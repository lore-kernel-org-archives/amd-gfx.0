Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCA0C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 04:15:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E0ED10E413;
	Mon, 22 Jan 2024 04:15:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8C810E415
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 04:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NKvATYuuJwa3lcDO2Qb013i/hi7cc3LYXon60E00MGywFY3TA0g/4HazICfDM7vPNYd6thP3xHY+Q2HCT53kfzwkqIon8BFfmppYazTtFRyPI2bVivxzfTGS9BQ4DPH60pEMcrwPzLKkTGRsEHH0d4JutombcyhzZFnG/An3OVHhxFm2S3kyKRorrcje7re7dOpFY3vdsTPigS5hnWu7yLChBVO8nkg27T3N03qxJRiD1GuN113idjHwbSH2MOOVn0AqS/awKAdVZy1S3F329Typic405B6PuaY3TVgMYzccpFYOJqZGyBwJD/4a+LKdJn0lsASxsIid0QaypO+uOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=936mBKbZGmTZu6dozFE9b7eMFXR6eqk5IP79ek3l/m4=;
 b=VHbBe/45Q0jHEk0p4p1J7EmtLNOlDasJmDO8BoggbEEBYZOLtLng+xpLU5fCdg7ImpwAHJiCn+4UoyjsrIVBZePPYmDPaU5+Jv8W+toqqPDG9lQtEncsWjXD4fQMlrYichQtUWQ1oYNtALDgoIDA3s0DfI+4TUmVyqn9gbbHvphyxwp2b5fIY6zboyiM4RuafSkQr8SjFA5DgCdYdfTKhQUel979Bj996Kc5JpnA3xJAEpEQVq3byVUuIdrSld+G0R9uoJAvaooRdd4flyJeVdRzEP4fcsGlF213G8rLqiqlZbFzV0ZzRqjbvG/nSnHvJVkp7pNb2owK41bWB9bpZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=936mBKbZGmTZu6dozFE9b7eMFXR6eqk5IP79ek3l/m4=;
 b=Foo/Ufcnkmksyfaw1chR43gTwHWdEgs3h7jcnt1LaiWgprDq2j5ExIZjhpDJ/CWwJPKMOqL7AJ6DQlpbrf5GW4yuPwB/JcRnKrrxbt7eEsmyTpANh+eqnXnf/KpnHBrLXmihjHeRNuuHdrQnT9B7+cAGrnBomU4dyywXsdoaE/Q=
Received: from MN2PR20CA0016.namprd20.prod.outlook.com (2603:10b6:208:e8::29)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 04:14:55 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::58) by MN2PR20CA0016.outlook.office365.com
 (2603:10b6:208:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 04:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 04:14:54 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 21 Jan 2024 22:14:52 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Address kdoc for eDP Panel Replay feature in
 'amdgpu_dm_crtc_set_panel_sr_feature()'
Date: Mon, 22 Jan 2024 09:44:30 +0530
Message-ID: <20240122041430.1049238-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a201e8-eaf0-4bbb-4980-08dc1b00b036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpjhTAExaXQxJWIKaNg6aczpq7/iHVr0JPGmO3fCtcJKgKXuDC+TGgXXgY+rgj93qnSL7AGJReUbNTgThcjQ1+Wot905JgH/XhH3o8sX516MQMYdkx1hvzyKh2dYQU8bxgz4REDSfbZ7zxoYH2owXW+UEVE7G20BfbpgTsjML6gt+L+t2nwTT/30azKdOPTrq8Dxy5MJGsJrwIfNFW6BcG9YeCcE78Q3Rk4XMfZx1nKqI1n0cEO/HcL++hvecHsYDYDmRiiq0tDKxi304ZJOFKWpivt5eV6yMypXzxmHf+YWJVs5JzcUFGVtjDPhS7hNJmHlo6dm4fs1f+djyDy1uS9zM6C24POG1yjI8JFEvXFhGrwWJ8/Q9gv9BkkWC9IvRCn2vI2Kc0fqQxrj3diIwDwimTwnJ5zG8P953a1Djru061wjUV2YQQBS0rK4AFpgz9jRHrDeB3RoNXF5gROmVXv482K1VUD9vlxniiivEnn48EKziJHwOJZFGNB64L5cNkoy6MxNcUqum7qAeSr/N7kZ/vyAz4Enk+/11hm1loLdQJMGe/hoyK1uopf1GqKV0cgx5yFkUdWtAal9m1+4LEFqoKTnbo8K0AiM+YlAmPZnzeMnpjUmJWX/GMkIIAgMmEWCm/m2K0COsRojQokCBXYo7azkB7gv9OqriMGZRQdM7K+eDRpUjOISLrkF05mEOSbBT4ap3NXSolax1S1EJ9K5qo0FLLJ6UJE+fFTz3jxjhSKuU2ZUSgfr+LJFo/Lf0PdSknIzTUI5gjDgAaEUhGa6mCroQrEHFAVQ7J3SDFPwg1IQqsX9s4C8lMn8y7A/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(16526019)(47076005)(1076003)(426003)(26005)(2616005)(336012)(356005)(82740400003)(81166007)(2906002)(41300700001)(70206006)(70586007)(5660300002)(54906003)(316002)(44832011)(6636002)(4326008)(7696005)(8676002)(8936002)(6666004)(110136005)(478600001)(36756003)(86362001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 04:14:54.9596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a201e8-eaf0-4bbb-4980-08dc1b00b036
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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
Cc: Sun peng Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_crtc.c:100: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * The DRM vblank counter enable/disable action is used as the trigger
   to enable

Cc: Sun peng Li <sunpeng.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index f64c5ffed234..690b007805f6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -97,8 +97,9 @@ bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state)
 }
 
 /**
- * The DRM vblank counter enable/disable action is used as the trigger to enable
- * or disable various panel self-refresh features:
+ * amdgpu_dm_crtc_set_panel_sr_feature() - The DRM vblank counter
+ * enable/disable action is used as the trigger to enable or disable various
+ * panel self-refresh features:
  *
  * Panel Replay and PSR SU
  * - Enable when:
@@ -111,6 +112,12 @@ bool amdgpu_dm_crtc_vrr_active(struct dm_crtc_state *dm_state)
  * PSR1
  * - Enable condition same as above
  * - Disable when vblank counter is enabled
+ *
+ * @vblank_work: is a pointer to a struct vblank_control_work object.
+ * @vblank_enabled: indicates whether the DRM vblank counter is currently
+ *                  enabled (true) or disabled (false).
+ * @allow_sr_entry: represents whether entry into the self-refresh mode is
+ *                  allowed (true) or not allowed (false).
  */
 static void amdgpu_dm_crtc_set_panel_sr_feature(
 	struct vblank_control_work *vblank_work,
-- 
2.34.1

