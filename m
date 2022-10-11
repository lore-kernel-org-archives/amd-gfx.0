Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70FDC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 18:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66E0610E47C;
	Tue, 11 Oct 2022 18:12:07 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D550610E47C
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 18:11:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNWB79yCCWQbWaJWyRBvA/OWyqlUbraDW9oiOtplcMK2XHcUyLcna1yHGyknLhbVJnVSvzRuopmMib4bVuIF2vFg+jgtRKvkegMsQNE5xy3pCjI6tfJQ4PRetJBrhgKn9FWmBC1g/oqSBglxueQcA3HWIWNOOcoFsmpfpzElv5oiWsutX+kjH2djFFKwgegGweVZa2AXYwjFvm+qu4VBbbxDnKgEO4AcOOHP9cOv7nOCAvi+45ajeklrqQTu8opMgaSpBUWJfcK8nNS0Sw26+J9PY3Zr4BPJoZB2BMi1jRB7hqpiL2CK7NBPu4NfRvNJICHB6jGxOKk0FNeGT8W5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPo0A7IyAPjE8pMeT9HyFwI8FZpeSbnLYUD6Z2hX9GQ=;
 b=eekP866g5s5qWJf5J8ZCwhfPOK+4cO6NiPyHrhbjJDwn+Xn8swvLWK3LVIVoe505ady46tA6jtf9bLPzBpM/0pDhtm4yJ34QD5CakCr6+qHlCfhTjFVeqOQaVYhdfe+c6PtW7Fsjorh9mhWQOONE/xYlbcDaOTYtuNqI4u8J/EAyBvlRyDgnoBxObxiwRM3bOXmr7DnzTedh4ShmrkceumG7xpT6KXN7jPb/lyWDnRmQuL1sg2TaPINoxTy3ZFw2Z6XQrk2Vz6bJAPLjDml1ex0ltFrrDsM+QfRpG9iwkjwxh7WizATa3GXXlZduMDF1GilY8mp8aB6EKFfG29FLDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPo0A7IyAPjE8pMeT9HyFwI8FZpeSbnLYUD6Z2hX9GQ=;
 b=FTZHb0yjOV7UZaxWviUB3hklM91MhOtqULP0osm6dlHA97r4ZjYmV4RN3vhZACiI3CmO99cGOtZOjKyjF52vE1PPMM4gXQQeTsbE7uUIglIcmkYRrF6t4wyzx0Cunt6mEpmEdujXhBQD0jXHz+Il0DMUjR4o+fZkDiDW4PFjpPM=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Tue, 11 Oct
 2022 18:11:54 +0000
Received: from BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::d5) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21 via Frontend
 Transport; Tue, 11 Oct 2022 18:11:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT097.mail.protection.outlook.com (10.13.176.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 18:11:53 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 13:11:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/display: Move dc_state copy in commit_tail after
 dc_commit_state
Date: Tue, 11 Oct 2022 14:11:40 -0400
Message-ID: <20221011181140.94595-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
References: <20221011181140.94595-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT097:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a8d32b-c60f-4a15-6392-08daabb413bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CdI3BvZFmD34nzYSjJnGK1HXFQyBWpR7r6S0/KVr8TuDHZ79LbS6M5/+RYGA3l2yz8X9KCzPlHtB4SBHwle4el1mA2gsKHT9zcVLGxVHrzEZdwJL1Uey7f7K+/n154/e0BDEvRqIJvKVT6uTAN5zxMbYRRhWBfcXQkTzQ8w3LN2pdBEq3bfxMwJnmeX5IPTV8BVT46snXwtMQwzdA0l+B+2W4t13nD39tjrj0YhUIKl0MRAvQ1BC3u64rhVT5MlR+om+AFB8Z20LkyVQYNC21H9QXZSztf6ZPA/QDocu0mZvflnPKmD1zLm+NWSZjfcLNDxifjSo0ZQuLfoSqZ+goIF4vmYlYy+XIAFiMay/kmaj4MZqWfMb0eJicuzksNrMY1YcOVyRScyR2acjTNv50Q+VTiwnQJ7Xxs4o9JtPsNphwG6SE9zlJK0fvM1FHTrrbn4SIOmvw2IxAgLrO6mipBREkN8xtTf3Jfl3hGDsRqJBjSu6dV/CYFn6h3nCvKMnthqr1prc26dqch1D+GsReiSbkCzbLsYdhCd85Wp088+Tx0xfXEDkJkYb4S/n5zV0XpVetC1FkvRRuB43lddc0ExYTDgk/zpNGx6FO4iNcEfWAQ/ZatF98A8sBIbRGTHXDB3qNfdIdIT7gxfbNvDMZnS30OXvKYNjeFZUigsrfjFvsxYcUOsrRVN/JJIpDA/6+HyqHUCGP8btFV7IjiGetS2XiWXOZCjsq239ZJOMF2jkw/0qCuAT7y2U3kOAWQDWn4zh8Zj0aLJEXYuCYCGV94qY1omQdctA4AvIDnxDwlQoWOmbJfA5wbtVCOVkkTuQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(41300700001)(6916009)(70206006)(478600001)(2616005)(1076003)(26005)(8936002)(186003)(6666004)(2906002)(36860700001)(36756003)(54906003)(316002)(86362001)(81166007)(82740400003)(5660300002)(40460700003)(16526019)(70586007)(7696005)(356005)(83380400001)(82310400005)(47076005)(4326008)(426003)(336012)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 18:11:53.9519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a8d32b-c60f-4a15-6392-08daabb413bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
With the new commit sequence, we do not want the state to be copied before
the call to dc_commit_state() since this leaks the phantom streams into
new state.

Fix this by doing the dc state copy right after the dc_commit_state()
call.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 63f076a46260..17a9108f8186 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7999,15 +7999,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
 
 	dm_state = dm_atomic_get_new_state(state);
-	if (dm_state && dm_state->context) {
+	if (dm_state && dm_state->context)
 		dc_state = dm_state->context;
-	} else {
-		/* No state changes, retain current state. */
-		dc_state_temp = dc_create_state(dm->dc);
-		ASSERT(dc_state_temp);
-		dc_state = dc_state_temp;
-		dc_resource_state_copy_construct_current(dm->dc, dc_state);
-	}
 
 	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
 				       new_crtc_state, i) {
@@ -8127,6 +8120,14 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		mutex_unlock(&dm->dc_lock);
 	}
 
+	if (dc_state == NULL) {
+		/* No state changes, retain current state. */
+		dc_state_temp = dc_create_state(dm->dc);
+		ASSERT(dc_state_temp);
+		dc_state = dc_state_temp;
+		dc_resource_state_copy_construct_current(dm->dc, dc_state);
+	}
+
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 
-- 
2.35.1

