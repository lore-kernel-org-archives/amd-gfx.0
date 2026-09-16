Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50840C88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD70010ECD6;
	Wed, 16 Sep 2026 17:53:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sXJsSWmF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010050.outbound.protection.outlook.com [52.101.201.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF2610ECC3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgDY5AFBHwk6qXZo3HpCaY+R3bhCBAUAEmLEs4aoeCZfqtnwh5r5+7QMzJA1G6peUdnjE9cmZKef79pyKfGBe1p2oOxcbuay7Cal2dLSCF/0AakoviaSF7zPmbR+LyONi4uawWBci52jS0RDMh9K+WIBxqm5a6hAlqK5/j8qJCbWTrHsKfJUFjPmludOoJEx+HH5GX8gR/kkrRMkILaIsbvo7gOYrpZ3D1mvEy5AeYKWDFddiNXAyvKH5HdVly54MHga3VxUjyRiyqhl/YUTkRxn1BESkLz6rDC7zAr1cvjXQMxanzZUdyBlv+qjL4yQHYgkbL4hPwYQaioosbPbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9B0jlNWdj5ADkd+YAhfaTuevF8TXLqgeFyEpNT4SZs=;
 b=BbTHT/VYhVck586cbqN8XLuVsYgDZv9OYOA18llTKbP4u3T2O2dbcWf0pkzexYdErR1B8vcybCpjWHEuT+rg10YsnlsASuTtaMTogH5rBOOkqW908ZhEuDD/hgcmoZvNxZ6uMXhoMCMRA3pqj5HZqzkXeeXrJdoTD6fH/8QN1jOuWBcaX+KWI+rBlszrtO0ihz662Hk8oHTUeCmDHk6VCRviRotF7WKqxULyrN653LGwu9q4RhffeiYNH+1LeQ4zQq233UpBxpcn5sByuyPgVrJ4aXl2elENYJMBZ6ue5PpSMip8nTVlZBOtxkjqqhcBv5pahoxA/4zaVLpaUNTB2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9B0jlNWdj5ADkd+YAhfaTuevF8TXLqgeFyEpNT4SZs=;
 b=sXJsSWmFdOHCQjXP7hZREWgtl/q6lsmcAEjLUG2FqO6SsMSN1wPvrGIJqvaa8u1ndqk0K9quLQfkiUmchPPgARDgAlPrav5ryth+N1Xs5zQ3G7qAgEm1kE0xZ5exZb0zGqnFxyVmMvozbMZTQThdLfZ9sHkr7L5VHzh/SEXaJ/o=
Received: from CH2PR10CA0017.namprd10.prod.outlook.com (2603:10b6:610:4c::27)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 16 Sep
 2026 17:53:05 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::c) by CH2PR10CA0017.outlook.office365.com
 (2603:10b6:610:4c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 17:53:04 +0000
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
 2026 12:52:51 -0500
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
Subject: [PATCH 48/64] drm/amd/display: Fix KUnit IRQ warnings
Date: Wed, 16 Sep 2026 13:52:03 -0400
Message-ID: <20260916175301.368306-49-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: d76bf8ce-5b10-4217-142b-08df141b5b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: uCgqXr3jYorRxVydMw5drGWjsx6a9VKEVOujsAWx3g/x78GPZ+lwKtVjjxqCRY79R35t3ZG+sAAxSq50fz19Dra5T0/b0LjMzvdgICOkf70dr2DLWGhjuuf0wukbd8oriKhbxDKhgablmdpvp2qMJz+vFK/DDJZBYD8XWPNSEuTTKk6NDZygl9Q3kUpwDLxbMnd5KRy1ywnAxy103UCtmgaiVJ8cqxqJM6QZkJaywDb2NDf5GlRtPVFsgxt9O7MfDdnm0KHd/r4fs1SLCU+6mAy83UAqG+MbqAXoyMnzuc/XlVn0Ws/BBuCn6TKcy2kI0CnKly0nE3JlY4NpZiOhhieI3Me75Bb9taMunAK5PUsAp8tM/b9cbvEXP3YTt1JFw9ZOZUJdvSHmdwzV1nu2wkH1o9oU590zueES6m3QslPyHYVzHd+KM1Sja15kKbwuT1Kh0sz4uiZQHf6SX0SOEfTMRzwRt9gLwWR0/jFDl76Q1vS3aHL63U0E3tVtbJewFY/Km+PT+D/VOvGd0UO8FBwKbB6F0rSLnmMKp+hi7ZtSV3wEws4zKsOnxbLLus5O/w0eRLQjaIgonq+rTNFv01dprxqBM1ZlH/38fW++M50SklSDbVbjiEnTkB0z8v16RM5QPImadjE1Me5IKK7tBpG4IFGEsznfAfQPXMgw6Q0P87wnXBHGPPJ51iX47SkZICIP3pOfetQUCE6vFGTLsg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xBsacc32D+gc4u4Dx2E0mD/bL8yAkVANxKE3nDo7oyFCuzl5Jlt/ZZxeuHqrHQ3PS6wCgjZzfwkyRSSQ/9GIRizSAJAo8YtRCNr1Qyi0Zk+aEoJ2MMEwUUHs3UlWKxYfXokIE8B5HU1HJ4KVIuKxEUQXxvEwtrA2SWemcL3VGn4dMx+FLKF2yjJGr+eBGs8MQ7NNfnHw93yy/FsSbTYecKT/f7SfaKsavHdBjOwLr+suZ7V5Aby5zJCjGweNdwSy8bpxaBQTv1vEEIYf31l2Lqer4PwvcqhZxrjsyypZRZuC8hsYGJQFron+IpH48B3zA7a30Cp0px8U736EWBe4L8HbgVasE245hIkQt+eJ6fvMg10/dBX6SkxInTMD1hOvswtp11AfMC9XDnywahN7MaFSID8kJTw+wCwEn8pEipI1ggH5WJXbL6/a8qiQkzMW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:03.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76bf8ce-5b10-4217-142b-08df141b5b6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
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
IRQ tests leave vblank active when removing their fake CRTCs, causing
warnings during DRM device teardown.

[HOW]
Turn off initialized vblank before unlinking each test CRTC in the
existing cleanup action.

Assisted-by: Copilot:GPT-6-Astra
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c   | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
index 72207eb4e076..c130f0d07315 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_irq_test.c
@@ -480,6 +480,9 @@ static void dm_test_crtc_list_del(void *data)
 {
 	struct amdgpu_crtc *acrtc = data;
 
+	if (acrtc->base.dev && drm_dev_has_vblank(acrtc->base.dev))
+		drm_crtc_vblank_off(&acrtc->base);
+
 	list_del_init(&acrtc->base.head);
 }
 
-- 
2.55.0

