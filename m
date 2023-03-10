Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AA5C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 09:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 400A110E9A3;
	Fri, 10 Mar 2023 09:32:07 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130CF10E9A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 09:32:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vl0bPkAfEZfzNzqifJAI+C3GHZVv+m1gUxCl2HuQrqjWpbbmcbXoRKdblDlxlKxUQqYix8nq/uN5GAQof5G6h9AjHD5qCpqAQkPQbA1rzInLfZ3XxSWn19n7OAMPo8uXxKBBACKThq/n+sZtJhN0EfFL5kPKHHFrzQmqJkLKRZS3sXP68Y++COgAXDjAypDg9r1pLuzYY4Gi9XS5QZxQoSC8kv72aeQJqQKlA4iu16jcVRzIpPJskenwiiJd4EyaLwPv0ksOL2OwjxYNqE0USg+Se7w9ryYiybJFy9XSavUaa3SyhtC3zeP0wJFAAt2laa45bPWlAyvB+EyF0a29fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3ggbtYQ8qQKl87v04CU0Bq56OjjYz3miNrpU+dOIA8=;
 b=dKs+Em6wLXz5S0LkbxXbX8QvFEf596EW3SvDdI9iLrw0jbXlgeZNajvn3KR2Y8gg7fcz6Kh9r7tJHgIFrIPh7U/sNE3EkENn3twE1W9fE/m4Jv9aAFZnd0W1UREYlPvUzOr3jV9YKLxVQzm4ja2Tj88de+lyWJortRqoD53fnxx9YI6u03ZjDYk704BYFtP1zd+wFVbAXytX3YpdjmMJmSLxkeL5kVKER6zzYLHbcwTHIfWRDFnLyLD8hfTgeFSzwJ+2vDdmRcu9rbXGiVGbQYJxWz8eqaqATYNRoRZ9lQ/CefE2lJw2tQ1VnwcCOvrmKrV1D+cS56wcwHmsz2XdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3ggbtYQ8qQKl87v04CU0Bq56OjjYz3miNrpU+dOIA8=;
 b=CFvEcyJXm2oS8hCFHAxSGvd1xV/SAs23kr7NwS8VgLCViElbhCpTzBhZ5W3rD2fYMBogC6ZOa140wIczL7MZAjcuKOfl3dvP8vbKzEmnJwudKFpOWpSyaulL+G2tok9jHs5G3i5ebgCYr+1FlgkOJtm6v1eQqWsZtPBIeRKz3r8=
Received: from CY5PR16CA0017.namprd16.prod.outlook.com (2603:10b6:930:10::6)
 by SN7PR12MB6816.namprd12.prod.outlook.com (2603:10b6:806:264::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:31:58 +0000
Received: from CY4PEPF0000C97D.namprd02.prod.outlook.com
 (2603:10b6:930:10:cafe::4e) by CY5PR16CA0017.outlook.office365.com
 (2603:10b6:930:10::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:31:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97D.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:31:58 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:31:52 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/19] drm/amd/display: Add DSC Support for Synaptics Cascaded
 MST Hub
Date: Fri, 10 Mar 2023 04:31:00 -0500
Message-ID: <20230310093117.3030-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093117.3030-1-qingqing.zhuo@amd.com>
References: <20230310093117.3030-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97D:EE_|SN7PR12MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 09852750-7d5a-4cd9-6577-08db214a4bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dYfVhGJP5ZhvRhwsAA4FvQDEAqlHfvSpkbOP/eMRw1OxjlDJt5k0VgaKS966MsapEtem1Srn3fnxjpxk65tZIJSz2yTrWi1zh5N0FJYZzu+Ab9JFQ2w2FZgXk0L4+lB9K0d/YKZAIWNJ0jFRFRX53zqPnJtQ00nGYsDtUP7A6aX3ik4C8mOfbd+5aj1RLoWuF+42PS1AwcIiSpM/irfdULjnRVL1EPHyoYKOAw8pTHX/TDVTG5w64PaKB2VaEejTsppPtjcxiVlqEYMVlGM5wW6zx4estpvDhz1e27mEu2+y8nOw5313QkwE2KVMlutS9tiJBHu0ya4327KRY5aU+jeaUOpUziAc/ZrooxacP29f+1q85+HrdWuMUqxIzPnGPkcuQ9FpNTBIGtfOJ56twjGsw/0CRjIDAlHO2NIdi/f4VinzkAUdyBNNM4ASy7xcGqAUer6EYkrfMDRlx6077mLQh3rPHF2uzGUho1SFkGVoJwFj0pWMYYtQ5xgfVU0kF0kCzwtZCgOUZHdggAqX5zBgovZ9dI/4c4JSJTJRe3edqmJy+G4T8GD0w0xEXf56z+MtM9Z1myBhL7ZAhFpuwYqf8HjwvaOErk94K0eK7GhnO72566GAeXk3y1QM+Xl/FVRbuqCZyeo4M/OWEYrYiG8JzSxXSFrcumEJHuHWr2bf683R3htws4Gio16/pQwaCg98Rjq9Bf8U7I8czPR6/ktMZkyz78bme0qhSpxGS2g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(356005)(40460700003)(40480700001)(36756003)(82310400005)(86362001)(478600001)(426003)(47076005)(70586007)(8676002)(16526019)(70206006)(54906003)(186003)(336012)(316002)(6666004)(26005)(1076003)(2906002)(6916009)(44832011)(83380400001)(2616005)(82740400003)(81166007)(36860700001)(8936002)(4326008)(41300700001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:31:58.3545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09852750-7d5a-4cd9-6577-08db214a4bb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6816
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Traditional synaptics hub has one MST branch device without virtual dpcd.
Synaptics cascaded hub has two chained MST branch devices. DSC decoding
is performed via root MST branch device, instead of the second MST branch
device.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   | 12 ++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 4b9b5e4050fc..9241d48e9d98 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -208,6 +208,21 @@ bool needs_dsc_aux_workaround(struct dc_link *link)
 	return false;
 }
 
+bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port)
+{
+	u8 branch_vendor_data[4] = { 0 }; // Vendor data 0x50C ~ 0x50F
+
+	if (drm_dp_dpcd_read(port->mgr->aux, DP_BRANCH_VENDOR_SPECIFIC_START, &branch_vendor_data, 4) == 4) {
+		if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
+				IS_SYNAPTICS_CASCADED_PANAMERA(link->dpcd_caps.branch_dev_name, branch_vendor_data)) {
+			DRM_INFO("Synaptics Cascaded MST hub\n");
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink *dc_sink = aconnector->dc_sink;
@@ -231,6 +246,10 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 	    needs_dsc_aux_workaround(aconnector->dc_link))
 		aconnector->dsc_aux = &aconnector->mst_root->dm_dp_aux.aux;
 
+	/* synaptics cascaded MST hub case */
+	if (!aconnector->dsc_aux && is_synaptics_cascaded_panamera(aconnector->dc_link, port))
+		aconnector->dsc_aux = port->mgr->aux;
+
 	if (!aconnector->dsc_aux)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index 97fd70df531b..0b5750202e73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -34,6 +34,18 @@
 #define SYNAPTICS_RC_OFFSET        0x4BC
 #define SYNAPTICS_RC_DATA          0x4C0
 
+#define DP_BRANCH_VENDOR_SPECIFIC_START 0x50C
+
+/**
+ * Panamera MST Hub detection
+ * Offset DPCD 050Eh == 0x5A indicates cascaded MST hub case
+ * Check from beginning of branch device vendor specific field (050Ch)
+ */
+#define IS_SYNAPTICS_PANAMERA(branchDevName) (((int)branchDevName[4] & 0xF0) == 0x50 ? 1 : 0)
+#define BRANCH_HW_REVISION_PANAMERA_A2 0x10
+#define SYNAPTICS_CASCADED_HUB_ID  0x5A
+#define IS_SYNAPTICS_CASCADED_PANAMERA(devName, data) ((IS_SYNAPTICS_PANAMERA(devName) && ((int)data[2] == SYNAPTICS_CASCADED_HUB_ID)) ? 1 : 0)
+
 struct amdgpu_display_manager;
 struct amdgpu_dm_connector;
 
-- 
2.34.1

