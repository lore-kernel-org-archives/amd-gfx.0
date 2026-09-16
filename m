Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E37C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49B9C10ECDF;
	Wed, 16 Sep 2026 17:53:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qsCR9ZvL";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011033.outbound.protection.outlook.com
 [40.93.194.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B58B610EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jv4OkBBJjMYHSEpKQsgaqUrmwMOxToKw6ftU263kaxhz6Rhr68sRhY2ox0+P07K9bjiQToWG5DHgPmWds5bUCYyiWNoKDdodVJN+sXSHvwmRSZNxXa6iy4pX3rZvc5VcpRu9HkVdVn/vBAVMwRfCtoiK3FcliNqH8OS7gCFraDCY8Q6AgCht77x0bDO+cEJG9xSTYhp7uIyYGvIsh0L40uGRtNNY4y4QgbsfFfgVwnDFCqYpJ0iUXNqRjcdNuaaVYGGJhyuLsxxDmHU3bJUaen5qnJGQy2QQPjJFk+8qgJOw/h5gz3K6ZCTo5cblhhWlTsTiFkO7/CxFIm/dhivMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=POnVmk/Uwr441fDUJ+E6MoqEvsYqJC4AVBqfPlkI8Fw=;
 b=Vbm83oN7U/MUpeG+M319oFdu0B2nPEf8TPtgqwTfhs8w4Gq1fFpVPrmlh3HowzRRRDTbP3DlD7W/c6aupaBUIcGfddEF79M+K1gKbTjAte28QfhmFZ/ojyv6KuJGC/fj9TIgiyafivSR1MyNhFP+xOiU5BP1TcgAW5JVQp+fw9WTalz15iH7pXWKD0Px2wCaGRbPLwtbY3yM8dJMWoB3kXUfzFce4UBkuchGAzX6H08kdxjM1l/x8mlr8RCX1PCrqBYhTB1ZBuKuH1keH0Kkq/5fsls8l8IIYvT7am5qiOiL9Qxq0fL98HKT6Cd4qorGaQvdsVK4cIF4Wsfv3R0cRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=POnVmk/Uwr441fDUJ+E6MoqEvsYqJC4AVBqfPlkI8Fw=;
 b=qsCR9ZvLEqmzeUqDxqWYgqzVjjYmAKU/LIt+QdLC0Pj3HE7cbjGaJO/KdjWTNO8fugQtBzOr3i4TNiby2YFes1nDlE5vXHjijCXluPkVRVo0gfTkjsYlR/18P57wcUugvXK0Y4Y1sT4ZsTOVSKeWNsbhqsMWySylrCr7fm8rDHo=
Received: from CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:53:03 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::7b) by CH2PR10CA0014.outlook.office365.com
 (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:53:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:03 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:49 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 46/64] drm/amd/display: Fix KUnit VRR warnings
Date: Wed, 16 Sep 2026 13:52:01 -0400
Message-ID: <20260916175301.368306-47-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: fd98feae-16fd-47c0-ec59-08df141b5b3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: r51Kaysx+e7vGpy7uC2yy/h4D+sp/AkF+TT7OwtdjRdMtB1vrS90jG+Di5Geq0YEiDiEtFsIHjZx+y1xVQI0lZ/omC3frPU2GFoS67mzzxwymE8Oxjzs/gb+9dmcbpjkpKVQIXKL+6+srTvsePEHJgidZtx5VyqF0HsEdzpGYYAwCNFACeHwty0QQyZCACBNY+EEPp/EjHIWAUTZIgzd5Hy4TYuzXt+LtWxkCJ7+6TDuuEMKPYYic4tuqE10fZ4XDJIMVEq7axzWvals++k6myqE4yUsYrB25c9vM1rYtybwkw3Af30X1BY09mXm3KnvEupKQ2+ACHkFCgSvx5zrd4h4peJ80+w89faW5pnq+FEk0TdI0amhpcfM5UYaBw+kCVU5pk11x52p46hvhf4HMAf5cZCE2flD9SYYzy/QIvO8Tn8Z1JixnO+MsmGx7uTPHjGjAMuTcwCekdJsyhvl3eWRcA4M7wvmfuWiGRu6VAlmtaYO1V8HXmeknSZdyWRCgl0Y73pE+9BS5/+TmM4+RphQwnvgM11NBeF7in8lPPB1kZ3fAH0NnCofoUZTObtK8wpbgOkDHvc9txWadULG/GLAog3PD3Hl7Zibt4TIBmTBWbXWwn3Gu2GO8pTZrpAt0f5ah3iVWWwKIplUvMMkaU9eJuRdyG3WNXlb84RZgsfYXo2QtUZExkTfqjsSjJarP+4rbgG7LesL9NicCKaorw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7yo7VgU8Kmm32RT1nINcTxTS7Lg4yhM708yu3kVZHSXtlwrOsdHXZF6kQCq8tfdqfBX+axtzYcVphqdh6iPKtFoUQ/8SS6EyYE6rhjV+pJ6JhCDlCm+O34eG9bqbxUnqTf9+5nXHlIARWpvw69h/jqhwPjYooAtj5sNTChQb1jpj1tjk/Zm8nUAwW4F8t5LTvA3tUm6LvyjExqs7nglDqHrYp7zV4g2ZBrWonRHVbmL3is78QiysPqFUNxuvQQlXuwwoUZqbGy6RNVtKi1LHsa+6fskirriHQIt6na4xUoLTFI6oZoQY6A28TTUOv05H+BkhpizMfL0qVWxmmCIFi5EO3OG1wuV6ecXQGeIxGZg4bcLzOzavaLq3HyouYcNSrUVWgF/GK2EsLFu3Tk28CUbhPP+EBRLK4iwiYAltoMyJuZvSi+pP38A/4fRn2tuv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:03.6873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd98feae-16fd-47c0-ec59-08df141b5b3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
The VRR transition test needs a discoverable CRTC and balanced vblank
teardown. Assertion failures must not leave freed CRTCs linked.

[HOW]
Supply a vblank counter callback and link the test CRTC. Register a
KUnit cleanup action to disable vblank and unlink it on every exit.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 82982553e8f3..5ad50bc31613 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -21,6 +21,23 @@
 #include "amdgpu_dm_freesync.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
 
+static u32 dm_test_freesync_vblank_counter(struct drm_crtc *crtc)
+{
+	return 0;
+}
+
+static const struct drm_crtc_funcs dm_test_freesync_crtc_funcs = {
+	.get_vblank_counter = dm_test_freesync_vblank_counter,
+};
+
+static void dm_test_freesync_crtc_cleanup(void *data)
+{
+	struct amdgpu_crtc *acrtc = data;
+
+	drm_crtc_vblank_off(&acrtc->base);
+	list_del_init(&acrtc->base.head);
+}
+
 /* Tests for amdgpu_dm_is_timing_unchanged_for_freesync() */
 
 /**
@@ -782,6 +799,11 @@ static void dm_test_handle_vrr_transition_round_trip(struct kunit *test)
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, acrtc);
 	acrtc->base.dev = &adev->ddev;
+	acrtc->base.funcs = &dm_test_freesync_crtc_funcs;
+	INIT_LIST_HEAD(&acrtc->base.head);
+	list_add_tail(&acrtc->base.head, &adev->ddev.mode_config.crtc_list);
+	KUNIT_ASSERT_EQ(test,
+			kunit_add_action_or_reset(test, dm_test_freesync_crtc_cleanup, acrtc), 0);
 	acrtc->otg_inst = -1;
 	vblank = drm_crtc_vblank_crtc(&acrtc->base);
 	adev->ddev.vblank[0].enabled = true;
-- 
2.55.0

