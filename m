Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D178C54E94
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Jan 2023 00:34:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 207A210E3B9;
	Thu, 26 Jan 2023 00:34:32 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA7B310E3B9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Jan 2023 00:34:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QkzsaWddhdA87/ruGY+lZANzCWVFKqezA0N6F4G3ckjfqs7zQ68W490ELYfH9T+7TbFAdJAFlmcJq4MVm6pdnIXiiF0hYGjgDuf/cOR/EartW8fptYxRFXjWK8sjzxvlK/C+cOqPCp+aLpwbJD7bCNtoN8DEZhm7FexDW+v48b4I7paJqKvAs102Ul83jwHeKlfH2S1djVnQ1jtdfyg579ShG2SnMfD32nLttl2TBNIK2rvYE3DwdJ+nLwLftVEIODUzGTl+ArKP1UkhGJsg7wwBmIFyZKVFz6INXGeaYMZwtFtjs1/JP7pxYD7RyuVDYcYDwofVdzt5888H86aYyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFNBKQ4Ce2KwUkoL/Z7yCh6mXKjPYQsfANPUkpMXNY0=;
 b=CHT4F5OiVNkC2VSgaScqnuxoEWP+gVWWNVm6kd7H2lYnUB8pQTzW2JXLNuBppNx1f5NRXQfy5PHn1RCupOpwP2LsCtvQyo8JDcr5PAJetORWKfoFb/CcQNNH2Ut+bDrwpwksy2cG012PcOXv4ve737ageNsXb8h5FG6hbggS4lao5Q7OzXQSKjoCp+D5djUVV30nY1ERIW5RpLA+7/uANVqxJQA67J4AO4vqce8rrbJ3GHSEeyANqd98fLzWHDDb9+HL0QBUM/0vXX1Sqrx3RNnWRj7hZxDE9UosNF1uU8zkqIAKXjD4SyqlNKUOPsWTjCRCs0DJS7ZXTwSBQsj0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFNBKQ4Ce2KwUkoL/Z7yCh6mXKjPYQsfANPUkpMXNY0=;
 b=R8kOp7uF9vYn4gA+FafmTxvh+tBGCTaTEbjSQMszmxWW+LiAi7L2PubBd3Z8P6NXNU0O346DfnBFSOBLkuTGXvePQFSeZp+pcxqQuZQhYhA9zJp9YYLyoOHe+XJa8ObKYtQJkPLBdWtPEyjkXPxFoJ+XDC40dmMCQbdcexYJ8CY=
Received: from DS7PR06CA0022.namprd06.prod.outlook.com (2603:10b6:8:2a::10) by
 SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 00:34:26 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::33) by DS7PR06CA0022.outlook.office365.com
 (2603:10b6:8:2a::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33 via Frontend
 Transport; Thu, 26 Jan 2023 00:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 26 Jan 2023 00:34:25 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 25 Jan
 2023 18:34:23 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: Add Debug Log for MST and PCON
Date: Wed, 25 Jan 2023 17:32:18 -0700
Message-ID: <20230126003230.4178466-5-alex.hung@amd.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230126003230.4178466-1-alex.hung@amd.com>
References: <20230126003230.4178466-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT005:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ade0bc6-9920-48aa-1282-08daff3513fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpNiRPh3LKKGclT96/eCMLXhjKXO6pqg/8EE8MTDnNvJh686NS8xuXD3Ykv8uacmqCxFEK/dEUBOHqV1EAw7pk4uNGR/wZuVDPAnMXZxliw+Yr+l1yZxWipDKSkaG07ro+QVv8oEXMobYYgijBoJxxXNAYwVkPq9v5llDHc6FKnyx5lfEZDXuOFazZMgRvzEME5vHktXsgmylxfLZqfScRsh4NlEnBGn1FvGy10Z7Wc+8t6SrEZPkrrhdhUOZEZsdXoXk56fOKg5VPuXLKjJIGL2ltYMU+rhD4BS540UnLHnMNEYdBHu3KgURaW+DUtWnYQf8NVHh8u8hOfQWRm7n4fMvCz7ySgl2hQ8A/F+VyWr+z4dNGckqmnjgboOhmS3fo7VnzupEwT5/UKanhzkjiSLceNNTbVGSWFMY3Bx4NgEjtDDEyggF++KJ2nXdTrWfPIKI53ejXqU0+5RqdIkh7L4fAlKBJqTbimULDxodfprZrBBshht186iz93HlCQ5ABu+B44BlEIOPjTnqDz3t1dqzk9aw6gqcqW00kijYSCqXZdSDP67y1tcrVXPLdHpP3sDC3SNmRD5gfhfJ90KaubebJ7U/+rKNRskQ2BG2dDExv4QXiYF3dIMZEPHI+VOI6MSTJd3tVYGu575DSb3kjkSH2N5Gq6vIXZaWCeJmWaxRNi4a4UJIHv6y++JaOmfo1Lp5dUmCuaNc25A6SaT2pwAxk6110HTNUyzEleVCx4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(6916009)(36756003)(70206006)(36860700001)(8676002)(316002)(26005)(86362001)(2906002)(70586007)(186003)(54906003)(40480700001)(4326008)(7696005)(6666004)(83380400001)(2616005)(356005)(478600001)(81166007)(336012)(5660300002)(1076003)(41300700001)(47076005)(8936002)(426003)(40460700003)(44832011)(82740400003)(16526019)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 00:34:25.9201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ade0bc6-9920-48aa-1282-08daff3513fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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
 Aurabindo.Pillai@amd.com, Hersen Wu <Hersenxs.Wu@amd.com>, wayne.lin@amd.com,
 Alex Hung <alex.hung@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

Add log for MST/PCON specific use case:
1. If DP1.2 hub where gives reduced link bw and no dsc support.
2. If less than 4-lane configuration where gives reduced bw.
3. If FRL PCON enabled for asic.
4. Track MST sink count.

Reviewed-by: Hersen Wu <Hersenxs.Wu@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c    | 12 +++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 ++++++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 763bc92385da..ceeab2cd8569 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1622,6 +1622,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	/* TODO: Remove after DP2 receiver gets proper support of Cable ID feature */
 	adev->dm.dc->debug.ignore_cable_id = true;
 
+	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
+		DRM_INFO("DP-HDMI FRL PCON supported\n");
+
 	r = dm_dmub_hw_init(adev);
 	if (r) {
 		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 5c733d445fe9..c6794196a11d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -403,6 +403,7 @@ bool dm_helpers_dp_mst_start_top_mgr(
 		bool boot)
 {
 	struct amdgpu_dm_connector *aconnector = link->priv;
+	int ret;
 
 	if (!aconnector) {
 		DRM_ERROR("Failed to find connector for link!");
@@ -418,7 +419,16 @@ bool dm_helpers_dp_mst_start_top_mgr(
 	DRM_INFO("DM_MST: starting TM on aconnector: %p [id: %d]\n",
 			aconnector, aconnector->base.base.id);
 
-	return (drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true) == 0);
+	ret = drm_dp_mst_topology_mgr_set_mst(&aconnector->mst_mgr, true);
+	if (ret < 0) {
+		DRM_ERROR("DM_MST: Failed to set the device into MST mode!");
+		return false;
+	}
+
+	DRM_INFO("DM_MST: DP%x, %d-lane link detected\n", aconnector->mst_mgr.dpcd[0],
+		aconnector->mst_mgr.dpcd[2] & DP_MAX_LANE_COUNT_MASK);
+
+	return true;
 }
 
 bool dm_helpers_dp_mst_stop_top_mgr(
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0bff2cc20b02..33f53cae939d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -177,6 +177,9 @@ amdgpu_dm_mst_connector_early_unregister(struct drm_connector *connector)
 		if (dc_link->sink_count)
 			dc_link_remove_remote_sink(dc_link, dc_sink);
 
+		DC_LOG_MST("DM_MST: remove remote sink 0x%p, %d remaining\n",
+			dc_sink, dc_link->sink_count);
+
 		dc_sink_release(dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
@@ -308,6 +311,9 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 					return 0;
 				}
 
+				DC_LOG_MST("DM_MST: add remote sink 0x%p, %d remaining\n",
+					dc_sink, aconnector->dc_link->sink_count);
+
 				dc_sink->priv = aconnector;
 				aconnector->dc_sink = dc_sink;
 			}
@@ -341,6 +347,9 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
 			return 0;
 		}
 
+		DC_LOG_MST("DM_MST: add remote sink 0x%p, %d remaining\n",
+			dc_sink, aconnector->dc_link->sink_count);
+
 		dc_sink->priv = aconnector;
 		/* dc_link_add_remote_sink returns a new reference */
 		aconnector->dc_sink = dc_sink;
@@ -458,6 +467,9 @@ dm_dp_mst_detect(struct drm_connector *connector,
 		if (aconnector->dc_link->sink_count)
 			dc_link_remove_remote_sink(aconnector->dc_link, aconnector->dc_sink);
 
+		DC_LOG_MST("DM_MST: remove remote sink 0x%p, %d remaining\n",
+			aconnector->dc_link, aconnector->dc_link->sink_count);
+
 		dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
 		aconnector->edid = NULL;
-- 
2.39.1

