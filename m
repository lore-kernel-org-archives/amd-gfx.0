Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37025C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C186B10E6E0;
	Fri,  3 Mar 2023 15:51:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C331210E6E0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:51:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klOqAiRRYC7Rhg+Lw1L050dMfNXURdUyk4uMHAWm7ANbsllT+MuQAgDKCNi+57MSSOc5S7gsnUoKNeo/i3EE1UOd+m0FrY3ipBl5pOQ4rYw0lnHPXPFVuhA4OcF8toIck4MorYS2pX6h4JIRm0IxpF7xgPmFFQGV3QfVA4COdVoZQUA9WYGua7YKnAxsuVmiSc3JJKjrLT+Ll948ns9H0wECOZswrZto3JqCSTDQuFkPhQfRj/eeqaGa7EBSuzGb2eP7pNkpxXOqwpq+KnqLA3/wzE0zHX6Weef+uxTpZ0TzIwmIE6f4i9jY9L3w+vfnAG/ZFzCUoAPD/dTz4jxtCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mpgw7HkOFWshoRFQsGPJQMIXPCs6Ux0HAokWUkDEgKQ=;
 b=L8/acTMMfq3DKm00yztzBSOUlW5abHz5kB8kixWEN4IxYA/yaiAMY168ZOqG7+v3Tj5JgzwkIHEZblk6A9R5ngIQfc3dumibl9Z2JXZvVxwFG5WHlt4KaCDXHXeYRVMP7zwnaXQKp0LN7B1S+rxambc29lRM/3KzP8LJNzbLxpNdyDuhAqTpXgnaTD6eh25YJBtNNKQgl+S3e10j7OtdCtlJJyfyQ7+xlURB8viEcyHHdbELKgNyCakiPIYT4waYFoyx11qzejJCyG4xDyn+E3Ocn+EsgJNE7mXTbb3pWk0YNeLcwfmrBJFwEwGDkXjaKD+KnyuQE34TtwsogJMJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mpgw7HkOFWshoRFQsGPJQMIXPCs6Ux0HAokWUkDEgKQ=;
 b=wcoalYSOOaZoWQfbZhoNHonmleeZDHQOqIEoGboVQLGfQfkd6zugoshL85jfhqCHpYxTEH/+7H5Xi7YPgpLQPdWhs0ZjqliE2wdEYW/8WbrMRpiHwb4PH5xbrmX3UV+HWvHuNR/7hHYXVyYQzpgYfHBqOBb3bJ7J5aVopIp83kM=
Received: from DS7PR03CA0321.namprd03.prod.outlook.com (2603:10b6:8:2b::6) by
 MN2PR12MB4254.namprd12.prod.outlook.com (2603:10b6:208:1d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 15:51:10 +0000
Received: from DS1PEPF0000E635.namprd02.prod.outlook.com
 (2603:10b6:8:2b:cafe::6c) by DS7PR03CA0321.outlook.office365.com
 (2603:10b6:8:2b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:51:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E635.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:51:09 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:50:55 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/33] drm/amd/display: Pass the right info to
 drm_dp_remove_payload
Date: Fri, 3 Mar 2023 10:40:13 -0500
Message-ID: <20230303154022.2667-25-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E635:EE_|MN2PR12MB4254:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c014da7-f3ee-49e5-e52b-08db1bff1bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pg4VhWvUwIFPcUYLN6TV2JPaSCXbMsqtja6pXbvqW31SREeVjJ1MgggWtfajroP8nMJ/ZA1eQyeybDtPWpgBCBE6UZAuR6IMfUHBdHAZCKDNDTTjbIQnTxh+RACGx30cwq7FkqsZZrEhK9sySxYmvH579UgAQNTb2WnMP62ttwhHw68pfoQqB0DppvqRC8PiBA4t/5m4donn8Lvm7H1aOYaFhQ8KveZr2hh+8W2OcIf0Clvsj1NUrqsAxpkI2duNYHIWF92kek66r7bbJQfoluLUCe7SAT+xgUzZ5ax3HWxGM4cks4NaFYWm1h4vBeqmkpTKR9GKpmqlNP2uwHAlMhs5BgTddwEOcwXxnWSNnJVZivwrABbHqKJSCM5m8uee4H47gHJ0OktLInamsSKxkKtqbFNVHZ4EHXQNvhDg5Mj5zIpE/XR43WYBnwjG6bdHNSOdHjq+kryMV0gruPW4kvmLzXB/EZ0dFA6D/PnHV0pWk0QNBNi1b4RXgOw1xejcGt7gLvy8Go1jZ2KayhTnTOO3cUQSsdAPLsmH2AZSK1e4YZV6cboljiU/GPFNzJ2mib/EoIm7Dtj4u7C8Z3O6xuLDoIWrvGZFxr+5pfN/jLmZtFJ89wFsrmgj4KoKkDZ1KrRWWhZLi3kMsiWjdXptyzyydG7Lz0tUzWViXSgAW5zwxLVPUzbvhYo6jnPw07XESAIi7Lve8YNMk1s/H8XKUBfhdinUszfxlGvj5xsCNwE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(426003)(36860700001)(6666004)(47076005)(36756003)(40460700003)(478600001)(8936002)(82740400003)(81166007)(86362001)(82310400005)(356005)(40480700001)(5660300002)(44832011)(186003)(2616005)(16526019)(336012)(1076003)(26005)(8676002)(2906002)(6916009)(54906003)(70586007)(70206006)(316002)(41300700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:51:09.8906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c014da7-f3ee-49e5-e52b-08db1bff1bc6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4254
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
 solomon.chiu@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>, Aurabindo.Pillai@amd.com,
 Wayne Lin <Wayne.Lin@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why & How]
drm_dp_remove_payload() interface was changed. Correct amdgpu dm code
to pass the right parameter to the drm helper function.

Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 57 ++++++++++++++++---
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 1be04c613deb..8d598b322e5b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -177,6 +177,40 @@ void dm_helpers_dp_update_branch_info(
 	const struct dc_link *link)
 {}
 
+static void dm_helpers_construct_old_payload(
+			struct dc_link *link,
+			int pbn_per_slot,
+			struct drm_dp_mst_atomic_payload *new_payload,
+			struct drm_dp_mst_atomic_payload *old_payload)
+{
+	struct link_mst_stream_allocation_table current_link_table =
+									link->mst_stream_alloc_table;
+	struct link_mst_stream_allocation *dc_alloc;
+	int i;
+
+	*old_payload = *new_payload;
+
+	/* Set correct time_slots/PBN of old payload.
+	 * other fields (delete & dsc_enabled) in
+	 * struct drm_dp_mst_atomic_payload are don't care fields
+	 * while calling drm_dp_remove_payload()
+	 */
+	for (i = 0; i < current_link_table.stream_count; i++) {
+		dc_alloc =
+			&current_link_table.stream_allocations[i];
+
+		if (dc_alloc->vcp_id == new_payload->vcpi) {
+			old_payload->time_slots = dc_alloc->slot_count;
+			old_payload->pbn = dc_alloc->slot_count * pbn_per_slot;
+			break;
+		}
+	}
+
+	/* make sure there is an old payload*/
+	ASSERT(i != current_link_table.stream_count);
+
+}
+
 /*
  * Writes payload allocation table in immediate downstream device.
  */
@@ -188,7 +222,7 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_dp_mst_topology_state *mst_state;
-	struct drm_dp_mst_atomic_payload *payload;
+	struct drm_dp_mst_atomic_payload *target_payload, *new_payload, old_payload;
 	struct drm_dp_mst_topology_mgr *mst_mgr;
 
 	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
@@ -204,17 +238,26 @@ bool dm_helpers_dp_mst_write_payload_allocation_table(
 	mst_state = to_drm_dp_mst_topology_state(mst_mgr->base.state);
 
 	/* It's OK for this to fail */
-	payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
-	if (enable)
-		drm_dp_add_payload_part1(mst_mgr, mst_state, payload);
-	else
-		drm_dp_remove_payload(mst_mgr, mst_state, payload, payload);
+	new_payload = drm_atomic_get_mst_payload_state(mst_state, aconnector->mst_output_port);
+
+	if (enable) {
+		target_payload = new_payload;
+
+		drm_dp_add_payload_part1(mst_mgr, mst_state, new_payload);
+	} else {
+		/* construct old payload by VCPI*/
+		dm_helpers_construct_old_payload(stream->link, mst_state->pbn_div,
+						new_payload, &old_payload);
+		target_payload = &old_payload;
+
+		drm_dp_remove_payload(mst_mgr, mst_state, &old_payload, new_payload);
+	}
 
 	/* mst_mgr->->payloads are VC payload notify MST branch using DPCD or
 	 * AUX message. The sequence is slot 1-63 allocated sequence for each
 	 * stream. AMD ASIC stream slot allocation should follow the same
 	 * sequence. copy DRM MST allocation to dc */
-	fill_dc_mst_payload_table_from_drm(stream->link, enable, payload, proposed_table);
+	fill_dc_mst_payload_table_from_drm(stream->link, enable, target_payload, proposed_table);
 
 	return true;
 }
-- 
2.34.1

