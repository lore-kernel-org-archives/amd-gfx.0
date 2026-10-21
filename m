Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8486606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dIaW9BYO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8193E10F96E;
	Wed, 21 Oct 2026 06:28:23 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8845F10F96C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:28:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A5vvCxOaSNLiyF3RDE0pufMPm5FS9jMiaqsKcJ4ef3L1p+GDFq95dxqKKsQulEvuTNeTXVrEM0SC57as+kSxw/9xM9FJOU4IRXzY7cgSzgHw0ijkQsoRrT3xJjrreiwnJqp9hJyCRK8/dhFoAqKtVfHz+E709W5KuQVheE5L0AYTFRgRn41eDP3B7EjWN66fscnGrM9hfG6qm7Ytp+dDs3TZkNrabDAaCpf4xQHodog2YJ4iz7e+5o63bgzJRQh8Mtzfy6cAGWtg9qOLuqR+gaNoBh5xST/gLblYvkqwKn9UduiZ75UxAfTE6kwVj+TN+H7CSnasThBRKVvU6U09Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLZ+jjUxHQ7t8tVYFri6uQzwDsnX0pFdBnhhMsvRgUA=;
 b=OnLCR2g20l7fdzXKK72xRR2SkQ71xyd7iELz5CB+13tnG0Dk03OLIs/gjNfRhe0Eo0126NrMaHS0FjF1EXrZovnkiw1cKVDqjbRd/+k9s63mtXmncGD1LAgRAuD3+IPuks7rnzDVWbW/BCx5HDyaUPuwIUvhzNxcOTFMScCdlhefDvkV5WxJEbmuUHcqk1PMYrAKpP5w5vjiTjswNGd8emGjpyCm7ia6w8F2RLNDizSdDfDPpHWApVt8p/mJfOJIq7G2mptNcN3JBBYkbkKcqoB2MtXE8rKUCLuletBW/leJGG0bQvW40ver14oq92zQ/8k3ITCOYREzkFDlHwYcIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLZ+jjUxHQ7t8tVYFri6uQzwDsnX0pFdBnhhMsvRgUA=;
 b=dIaW9BYOxqmKWXsx4fFJ1hzKAOxR3XgKUAbGTu4abKyfeMP3L5N5mPWzaUsnZdFBTfGcX/62MZSpgQW7YJI4kW17zaZLg/wLaHPlgmRetUZuexkZBeDH7shl/unqf7ubevyZeEhhb+AhmXFjshqLD6mcM0lxjGoCPUp7LUcVCJo=
Received: from SJ0PR03CA0356.namprd03.prod.outlook.com (2603:10b6:a03:39c::31)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:28:10 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::94) by SJ0PR03CA0356.outlook.office365.com
 (2603:10b6:a03:39c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:28:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:28:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:28:07 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:28:04 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 44/49] drm/amd/display: Use kzalloc_obj in tests
Date: Wed, 21 Oct 2026 14:22:50 +0800
Message-ID: <20261021062519.674697-45-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e682ea3-679d-4b4c-85ee-08df2f3c79fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|261009223027099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: fbIEKWcUAMBtt6iYAYCQbaeTWXWy/mXW+FV8dZoYJiK+nw05KreKCIAgm/FpWumt6hURKMAEZhtWXuMegwxhHpvwcEdlYtFwuqQdEhR4n1Rye5UZkHDJT0f1QTZrIX2WVCMU3pmTF1/LNRWf63UZC3tdExeRb8SeQoW628sHoy/Rs37ETigiuhUNga564aLIPMpNY8nHoMwv1LtiVGvyjTGyJMfAtfNW6eltOSwxZXt3/GSs1zvvem+jvcqOn4xuFbLgTUVWluUEsOwEte9ERHvZV1+Yzb7/fXAPo8mEC8u3e7KNW1g0a99qg+TvMAUhw/ZPHMQEF8NvmKDCKu2R/t/Q7COl53NOnfBLbOoBkM6hBxpK/KsYUJL9N7btJGk0cC8gMTUn6qTp4gDAc7Usq+K5cWjMK4xS0ueoMgylHzT0+tMaulCoGU26U6uw6ER70X8DtFd4dqYQzEsFbWNXIOIbnxYucXQiCj/A0kUoNlL9rKu5bRAh8IeGZ9/z53h4T6H6waR8FoFRzZmgxgilQBir+QVXDN3oepzflO4g2Y1xyENAOGsFolEPNF3ry/mB11Y5OMJGNjc+TrRB3P/lX+qp25i0eJVs3lfoE1Z/+Y4BkgxRTquF79VwaBSPxc0NFG68djYVAAC+GBwLZeLBPsSZHv9nQdKv1TmAndCIDxetfJDkai45iq7n3qYb2CFXmZxLPfc8QX8N76h0j+8nCA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(261009223027099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ko2c2R5zyWU74nrywQJDjle594YYEqEpK2FnM41nHhLAuhahMlLk1+iwFosekvPbtHT399L51LoTW8gFaZ9m5tg0eUKqMRU77kvYjDIPh44366sg/v4OK8vMQfG3vv/9iZhqeUOA+jplj+hn8Q7CtmcmGEemwnFXfOwVsNVnfKQ8+Cs0AYRReWp0eAFemXAUcL+9tfC+G0x5Qz5RM+GSls7XD7XHXdnhu4oVe4prHz0J+qBUPsjcD6Dz636S1kRIm0hlC2y23Ts+75+xE7c36JvuUjX+oDATe/NzyNredSinSDzdYpGTPP1lhMPfHzDljOfA+F4ZXJ6LZFzRTdgdbWN5MiZN4ZGpo9yUmLbNSoOpqNFbZ4KWcxV54my4gGr38Xhc2QxBGI6EkI4EzFLWuzKbv3rFk3KJavbr6HCdki7cH4DaMyCVcOYZaDpOSBhD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:28:10.0037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e682ea3-679d-4b4c-85ee-08df2f3c79fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alex Hung <alex.hung@amd.com>

[WHY]
dm_test_sink_create() in the irq test and the SRM buffers in the hdcp
test still use open-coded kzalloc() sizes, unlike the rest of these
files which use the typed kzalloc_obj() helpers.

[HOW]
Switch the sink to kzalloc_obj() and the 16-byte SRM buffers to
kzalloc_objs().

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c | 4 ++--
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
index cfdcc44581b1..5af6ae47bb21 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_hdcp_test.c
@@ -1352,9 +1352,9 @@ static void dm_test_hdcp_destroy_frees_and_removes_sysfs(struct kunit *test)
 	INIT_DELAYED_WORK(&work->watchdog_timer_dwork, dummy_work_fn);
 	INIT_DELAYED_WORK(&work->property_validate_dwork, dummy_work_fn);
 
-	work->srm = kzalloc(16, GFP_KERNEL);
+	work->srm = kzalloc_objs(*work->srm, 16);
 	KUNIT_ASSERT_NOT_NULL(test, work->srm);
-	work->srm_temp = kzalloc(16, GFP_KERNEL);
+	work->srm_temp = kzalloc_objs(*work->srm_temp, 16);
 	KUNIT_ASSERT_NOT_NULL(test, work->srm_temp);
 
 	kobj = setup_destroy_sysfs(test, work);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index f15eb14f64bf..b29aef2ae16c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -144,7 +144,7 @@ static ssize_t dm_test_aux_transfer_fail(struct drm_dp_aux *aux,
  */
 static struct dc_sink *dm_test_sink_create(struct dc_link *link)
 {
-	struct dc_sink *sink = kzalloc(sizeof(*sink), GFP_KERNEL);
+	struct dc_sink *sink = kzalloc_obj(*sink, GFP_KERNEL);
 
 	if (!sink)
 		return NULL;
-- 
2.43.0

