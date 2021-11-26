Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57911C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 19:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1E9B6E417;
	Fri, 26 Nov 2021 19:49:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61F906E3EB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 19:49:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T5b1OBPF1bHa1e5HwzeV6Nsl1NxGq0C8aajxkHea/QVl8DmjPbyjJUSMrfHS0VyG+zuiT9EQEEalehP/Q3NjG5JfxliIat35CwLXIMe8ktaed+Belq0jZvLiE15V7RGokn5zutS/qhvCBpm6iWFrQXl4tjWsuSU+zM+/k2rCtWbPpo7FEp22UJrc8KpoztgeQ98jQR73gwqj5V76FzN1uL95o52PQAIeNTxq1kFvAKD7LICrkT+pLFi1X9AiadHwFxD+S8RwA3WtbLa7bT+ez/XfNDe38ddw/48RCNNpPg06mG7dr+/4UIj4yLAKBkEMkygkzQn70uyGJhzJHkFj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTA5Yssm4udG2fqELBzVbedr4VHf/YjmeuZrsySmxSI=;
 b=hBMZwNMVtLpIlFeeWCWdi+lNHvl8ky39OxWPM7NZ5fX21vgJ8b3cMJlixT7uLSCqubAIybjvjSaID95PGk7ZnPfjJWcrI+rZrWKkfAzuLuEusDwAcbE5p0+foS3HTufcALLjie+hEiNrCgEzh6TtfXRTKBXxr0/xmOM8j6xzucjgZRkWAdpajQ+CuZzeK3EfYB49GM79N0csAXchuP61o9p72DnP0oncWErKZ/2m6y5PxCGkjj4RUiGr37B90rva+7mzo3jKtkjEmWo8OiOoDVZCNGKnzU5SW6S56yfUy5IJs2hYKgU6DXhoYcOQPeOxqvFj7T9PHnpOnErYMlf8pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTA5Yssm4udG2fqELBzVbedr4VHf/YjmeuZrsySmxSI=;
 b=A03sPVtz2EFat2LCxb+d8pEqdr/i3x/pDmcKw6oX3ADlo39OxrHwlUjF9Q9O6AoURaV+rbeIHXXaf5/LzQJ5m4mxAMT8IP8znBUTMckuiEvfPB8phGnclOAL7meLpwJy3TZQCy9cxexqOVS0QRIdj1JdtzCqOYIuZ7WZ4CToCrQ=
Received: from BN0PR03CA0016.namprd03.prod.outlook.com (2603:10b6:408:e6::21)
 by DM6PR12MB3771.namprd12.prod.outlook.com (2603:10b6:5:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Fri, 26 Nov
 2021 19:49:33 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::9f) by BN0PR03CA0016.outlook.office365.com
 (2603:10b6:408:e6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Fri, 26 Nov 2021 19:49:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Fri, 26 Nov 2021 19:49:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 26 Nov
 2021 13:49:27 -0600
Received: from blakha.ht.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 26 Nov 2021 13:49:26 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/16] drm/amd/display: Allow DSC on supported MST branch
 devices
Date: Fri, 26 Nov 2021 14:49:08 -0500
Message-ID: <20211126194922.816835-3-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
References: <20211126194922.816835-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d175b1-7201-4027-7680-08d9b115de03
X-MS-TrafficTypeDiagnostic: DM6PR12MB3771:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3771EF2A4237ABE0CE4E385BF9639@DM6PR12MB3771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GcHMaM/E8eYzwXbERmaEeYuVX0Dn1YvbMYPCYJnaFN+Q9yTSKcDKGIDlydxLGIpKzOce727ByvERDZ2+48/90jtUfcli3kjre44Uo+jPJ3EOx3D0EL13Iq9VW2x2zmkaq0gEFA44g8+HoFWezhHg2d5B5DqT0/2/6ehQb+8P6PRPngKI+WCgKr2FzMs1nDDQDmuXHx5A6WkO1POQSLFvHriqSeuBZpn4gGqLMZCodtOTSvFQvGv2TIcslQjOZPPKoMJD94lgZBlD6rZucLKCyLoPCruq6N1QaFvvh7dsg/S4Xs3U0omUx2rxNqzjz4RvSZz9ANrVXmhBK7nkJ7Crfze1Moff2GVdO3LwUaKxKHtXioFtxzQAdSXzxxWisCADAdkuHJVqGU3en8/8qhgvEdgmpq3/M4kqh6Fz4EkuDFX9mDVkYxOM0SdjCNoTocfzHegXvPWlHlpti2XAW0RE/2SG6jNFbRWjNqydPVHPK+cEauCHb609YenlFH1330ncAXqNZE0TQfFISnjmqpp8uwYNHVfkFiehRNajZRtrRZiWlpFGnij2U696gGePDlJgQv2c+gahTzS8iOfKpM1EW5NGKobmqbSHjU00gi248sUHsvY7AC3WmLFXARReyWOYGq3dS7wqmgi/1e45d8Ts7IzIE3+voEo9moMxCKM0UbYXaMtB7dtiNrT3tJkIcsLlluB02+RD09pL2B0hxlJXvSiycXurJradR/+ppI60Xc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(70586007)(70206006)(5660300002)(6916009)(426003)(6666004)(1076003)(2906002)(316002)(81166007)(83380400001)(86362001)(82310400004)(47076005)(508600001)(8676002)(4326008)(26005)(356005)(186003)(8936002)(2616005)(36756003)(336012)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 19:49:32.6404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d175b1-7201-4027-7680-08d9b115de03
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3771
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
When trying to lightup two 4k60 non-DSC displays behind a branch device
that supports DSC we can't lightup both at once due to bandwidth
limitations - each requires 48 VCPI slots but we only have 63.

[How]
The workaround already exists in the code but is guarded by a CONFIG
that cannot be set by the user and shouldn't need to be.

Check for specific branch device IDs to device whether to enable
the workaround for multiple display scenarios.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 32a5ce09a62a..cc34a35d0bcb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -36,6 +36,8 @@
 #include "dm_helpers.h"
 
 #include "dc_link_ddc.h"
+#include "ddc_service_types.h"
+#include "dpcd_defs.h"
 
 #include "i2caux_interface.h"
 #include "dmub_cmd.h"
@@ -157,6 +159,16 @@ static const struct drm_connector_funcs dm_dp_mst_connector_funcs = {
 };
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
+static bool needs_dsc_aux_workaround(struct dc_link *link)
+{
+	if (link->dpcd_caps.branch_dev_id == DP_BRANCH_DEVICE_ID_90CC24 &&
+	    (link->dpcd_caps.dpcd_rev.raw == DPCD_REV_14 || link->dpcd_caps.dpcd_rev.raw == DPCD_REV_12) &&
+	    link->dpcd_caps.sink_count.bits.SINK_COUNT >= 2)
+		return true;
+
+	return false;
+}
+
 static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnector)
 {
 	struct dc_sink *dc_sink = aconnector->dc_sink;
@@ -166,7 +178,7 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 	u8 *dsc_branch_dec_caps = NULL;
 
 	aconnector->dsc_aux = drm_dp_mst_dsc_aux_for_port(port);
-#if defined(CONFIG_HP_HOOK_WORKAROUND)
+
 	/*
 	 * drm_dp_mst_dsc_aux_for_port() will return NULL for certain configs
 	 * because it only check the dsc/fec caps of the "port variable" and not the dock
@@ -176,10 +188,10 @@ static bool validate_dsc_caps_on_connector(struct amdgpu_dm_connector *aconnecto
 	 * Workaround: explicitly check the use case above and use the mst dock's aux as dsc_aux
 	 *
 	 */
-
-	if (!aconnector->dsc_aux && !port->parent->port_parent)
+	if (!aconnector->dsc_aux && !port->parent->port_parent &&
+	    needs_dsc_aux_workaround(aconnector->dc_link))
 		aconnector->dsc_aux = &aconnector->mst_port->dm_dp_aux.aux;
-#endif
+
 	if (!aconnector->dsc_aux)
 		return false;
 
-- 
2.25.1

