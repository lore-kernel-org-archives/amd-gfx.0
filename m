Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824E8C5B572
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 15:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5F110ECC0;
	Tue, 11 Aug 2026 15:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NR87Bh2g";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011070.outbound.protection.outlook.com
 [40.93.194.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D343010ECC4
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 15:51:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEWrLlxSvZoBj27LKw1go+1bos7xgzDejfSX6ptJCkwwJMZ8MbmKMA70v9AgT2rV6PYPoB4LzuzUOL21BDoxzaZ+CSVw5z6uQvNz0yc1AYeFKG7ZThYgF2EZ8E8VMh6u5jQQ4GczZNxNdGzIJ+Ok0VbWgaUIqlKB6nj28oZMuK1j4Gq9fx4EKh2Ty9LH+dE/nyF3OF6eBXEEQEh3O/yg9qCQIA8A64otPGCfZ0wpTJ+7MdqwArWQzF57xcBsFqECeuBGjjIeD2xVQ5V5FGxLQLyjvhB/XQIprirbRINqzfuMnU57DGi+i0NxOM8DNQk1toNKfsVterTHGqxJR1ZBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qkXc5PJ5JibQ8e7+60NPz4uBjuUCl+mu58fvMM/OxY=;
 b=LR10oy7HwqMTRE1kFBgN8qCY+Jl6W8Fv/VjlqFTf6eKk2pH0gAXhT56otUEOzEPn1K0P6Ub8MkSwgPFJ8Scw4mhUbf846m+8EnGSekLKaFtNTUXOHigexbX1ANjXU5DWsp0NmT2v8oP6TVbh3gWjGsocWGYjJ3yCIloMtNxIXyGiHjIMJBFlYv6m1885Na0f6hwQXsucHQlxn6Yueeu4f0xsMHi5p+DLHvh28db/HmG/2YRdAytBYzd+0MG5dT8Me1nk6FkVA30OL0+ms673KW26iG4rfdVvcsNrF54sJyaUY/WQVfaSruhY+EzDfE6k1+vdDc2rOuL0mOnwn1kZjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qkXc5PJ5JibQ8e7+60NPz4uBjuUCl+mu58fvMM/OxY=;
 b=NR87Bh2gwdY0Mf3K+CjlfrG+sTFJ8mGYo8U11NmbHGl9aowQaDP/97zwpesd31uXEgUxBBqHT/uuR5sRWaslDod5L05RU9rDxypcEfzk3MZKcU5lG3uiQL1W6cJqa5h4lby0niHKdqHozyk3p2qCYAVVNJjYIEDax+rpIdCGkyE=
Received: from CH0PR03CA0379.namprd03.prod.outlook.com (2603:10b6:610:119::6)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 15:51:31 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::68) by CH0PR03CA0379.outlook.office365.com
 (2603:10b6:610:119::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.11 via Frontend Transport; Tue,
 11 Aug 2026 15:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 15:51:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:30 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 11 Aug
 2026 10:51:30 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via
 Frontend Transport; Tue, 11 Aug 2026 10:51:22 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 22/24] drm/amd/display: set base.enable in cursor mode tests
Date: Tue, 11 Aug 2026 05:28:56 +0800
Message-ID: <20260810213010.1703162-23-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810213010.1703162-1-PingLei.Lin@amd.com>
References: <20260810213010.1703162-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 35c0081a-16d9-44bb-8dac-08def7c069ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|22082099003|18002099003|56012099006|11063799006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: OI2SnBlxpNYOMfAoAjWyrJ4x7REUwsr+oIAq9Di20m5EUFWFCifWpwvNP4/Q/4xqFgvUINdgx0W5KH7ExFVYvvbdGh3jkdfmrC8fmFuiDYuMLQrHHFckwzsm+UrXSxFTV6mmD33vMoeN8qV4TvOGQ0MjNJcz0RIBdOBpo1ZOxS69AY5QUasfMK4ez4OVz292PnZ/jpDoYeKe6apGtkpjZR3PcqAu6KLHmShRfWB/+1i9k4MtNNlhghYDTqQGHNI6LmP+AyvU2TTXxBerColz/8oyYUzH9te1pAFvAe2Mkryjekvj1ehGFO7UVbvTQM7zKDfpV0JQ3mFLK747ERIPXNrn2siyRJL8TrSBWgaUPujgI3jq2frnZpCpW1KBHWTCx5OGLgS9HjwIfYJzEGDSRQQFngV9/V0xv7WHfqxn8LJZbMbALA9Sz8djjZfc9zGGDIudnGumY0SKgJC8difKd3ev1F2N3Q9XR4oj+JAHBaztSylgoSSF1RO32aM2sb722vZ/WvQJiN+DI0pnGDXdI1mbhgF3uPe6ygwRPxSnMXDc6mShVYv9vh90r/q05h/4Uojt/ZCQTmhVuQmb5aU08hmVPoNjFlEgTlsBCdRlvrnpcwEfqlks+XbPCp3abezkBmnDjwz40Xph023AedgKanCBWlqo+qM77mGK22YLstza2qemKaKXmdaECa+oU9+fLxBrb7WY1HJfzmmuKeFP1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: njvhPseFm0nXK6sgBOoNkHhpgMVuHpAupzOBQ416zvlXKlJ+YF9Lf3uPD+iCpEVVABl76/4BIho/mKyPHppYCDxRQeoVrlBoMq+8gZiteEiRwkz/luCrgSoWmFyNciTzYrRSCepeE6LShL46T9qW222v08COEDC4Df4ndiC8/EBd1MzwXzKh6bg2OlHKtQKLVvSCT4LdsFGkc0KjzHxpV4ig4P+F0t7MCkaGJrrC4VBgW8sczqD34M+hqmx7B2ykjiy6lZ2q1prXVf6IyoJXZiAM5/jdeV3V8abUsMko5SjiIYnCP8RjePRzCwpjoZkd+b435ebtVSxfi8MKQTl3syKJKTTl7s0TpEI9fBR1UubncYDxOE9+q5k3bLEMnZ0aqxcw7U3yQ+01M9e/i7u0A4PbFsyufA0KlPvaR5+jzWsUequTer+bt2S7X05A9F58
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 15:51:31.2239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c0081a-16d9-44bb-8dac-08def7c069ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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

From: Tom Chung <chiahsuan.chung@amd.com>

[why]
The CRTC state in the amdgpu_dm_crtc_get_cursor_mode() tests is
zero-initialised, so base.enable is false in all of them. Nothing in the
function reads it today, so they pass, but they are not describing the
case they mean to describe: each one is meant to exercise an enabled CRTC
driving real planes.

[how]
Set base.enable in the shared fixture, and in the no_change test which
builds its own CRTC state instead of using the fixture. No functional
change, since the function does not look at base.enable yet.

Reviewed-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index f085eb1a616d..9e76dfa887ea 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -147,6 +147,7 @@ static struct dm_cursor_mode_fixture dm_test_alloc_cursor_mode_fixture(struct ku
 	fixture.state->planes[1].old_state = fixture.old_primary_state;
 	fixture.state->planes[1].new_state = fixture.primary_state;
 	fixture.dm_crtc_state->base.crtc = fixture.crtc;
+	fixture.dm_crtc_state->base.enable = true;
 	fixture.dm_crtc_state->base.plane_mask = drm_plane_mask(fixture.cursor) |
 						 drm_plane_mask(fixture.primary);
 	fixture.dm_crtc_state->base.zpos_changed = true;
@@ -535,6 +536,7 @@ static void dm_test_crtc_get_cursor_mode_no_change(struct kunit *test)
 	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
 	state->dev = &adev->ddev;
+	dm_crtc_state->base.enable = true;
 	dm_crtc_state->cursor_mode = DM_CURSOR_OVERLAY_MODE;
 
 	ret = amdgpu_dm_crtc_get_cursor_mode(adev, state, dm_crtc_state, &cursor_mode);
-- 
2.43.0

