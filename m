Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20A5CDE00B
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 03:11:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F07310E2F1;
	Fri, 26 Jun 2026 03:11:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GjCnHrpr";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E831910E2F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 03:11:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMohZYigbjmikIUY8CteTtWVj2D0QsoO09TTG3dE8vC1rKC0k5impdv88Ieb7GLMIBOTjePHqRpa4guuYSBxWRYm2W7ltSgRkRQ90ySyIvEFURUijPmfciZBTiteBE/tlNqIpVA2Ull4kUdsrfsuF0uFBFEc2b+lS9Od4ftfMZEigFIpskRqPT+9SWx9MJtxIQrvgisP3VKgg9enbYkZwLuj1CDJlO8SB+/xntoS/jYEdpoYAgnHB6mxJiL5K/FK/JV+BxTqr2v67ms+82lsXoIzdedwGTFwZA4ejLZ7CBRQwbkcVR/YJ0Tm0x6/6M8F10tKcQAS/Tg3+SbLPNJ35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRlc8XUlRhrpX2+w3IzL+8EG3YZnkyyKkYhRPSkKgbU=;
 b=szhrJP3nRl37RA+vnvJLnTPrq4pS6QmdYwtFrSkUcjwpnV0xp/5zNyWkZS7m9O9yDA9IFHmmntq+8BIy2kGA8CGTUr11O/acU+B35zrpE+DjfyUoKDbB6giCjHUWIaAPdqDCky50faGtcEe8oB1rh0yvDwWXJHHyYdLACtTtCjNla2TbATBP0PFt0fSIG0/wju5UGuY0WlKNP90IAZkRxs+uQT2EHV6mhTZJnCaGg/SFk/S//LqIQGBSJDV/v5AgvvWusKf6YyvxOseyfcRhHeWkvEeukwgHJXlQjWjXwzn3ryrOgeADC8M8hN9a+ivMOXhkdiYYDCpv+gNJdgQbkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRlc8XUlRhrpX2+w3IzL+8EG3YZnkyyKkYhRPSkKgbU=;
 b=GjCnHrprG8eRtukP7fPoPxXpG8cs39/MbsqH1TKIN4gWBhR8miGeIiF6g1SmbjhtnsLLtbmsazo93hZYWGLnMyOkGdlcl6ETLCdyQnzKMRzASGJWYc6zmDI4Vv1E6FJKtoyowPpeiQ7ScThMRFmsQ8tv+MNx5oIGsubGjj2Lb9s=
Received: from CH2PR14CA0018.namprd14.prod.outlook.com (2603:10b6:610:60::28)
 by BY5PR12MB4068.namprd12.prod.outlook.com (2603:10b6:a03:203::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Fri, 26 Jun
 2026 03:11:40 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::8b) by CH2PR14CA0018.outlook.office365.com
 (2603:10b6:610:60::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Fri,
 26 Jun 2026 03:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 03:11:40 +0000
Received: from amberlin-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 22:11:39 -0500
From: Amber Lin <amber.lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Jesse.Zhang@amd.com>
CC: Amber Lin <amber.lin@amd.com>
Subject: [PATCH] drm/amdgpu: Fix false error return to non-KCQ
Date: Thu, 25 Jun 2026 23:11:14 -0400
Message-ID: <20260626031116.104290-1-amber.lin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|BY5PR12MB4068:EE_
X-MS-Office365-Filtering-Correlation-Id: b35665e5-c831-46c6-e52a-08ded330a44f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|11063799006|6133799003|3023799007|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: Ny43aePlBZ6/RtmaqIrv9b9k7FFENRWvQKGPkpGLlZGB+vBJT7e7IlG+YpPaEiB7svO00MvTsiE8oK/SJzonPaSNMPTfp3M3qAkJv7O/48x37wISEjwedKypooBfWt0phIOTZIhyjV9KWb1PZq2YIPXqE2DZninwetIHfjQct41cHaBw720Z7oiFK6xwpfTPc+Z9ibJXqbN5e+bWzWEIMylvCdxPaLgU/XZ4Q3pD62zGXOQkh8B4rVFlbgH5HkA//eXt1Xhn8BuoTcRcp6sd2Kp+foXgnTwpSYIAizQIVyuQjAGIi3xJdYV6vWJg2q0ZzyrbdQYm/wJr3W6gzcJJrp0YX3vS3EdMZmAInz967zhub/TqS9HLAASlXXajgaZUf7sFA7d9Gg4sJTyPLUkz+DDZTosm22X4gbTjxz5wDwBZ9wIU/IIsBP6fCR8aq2rAbmClo3kVb03YKrozdOAnqVrQct6peOBFfvbRMafW8IPULpwLk5MkXxwjBmKy6hSTqJPVyTnMd//a5cc/Wft5TZCXhOWanJ+2J5YluEyMXe0XNGuLWegrdymz88P5/LTXt9UAwb5Sga5JGzo+pBOp1MWiAHY+V1cpS0kGdEZW696kd+/KpXZr3QijWFybRuFKGFshcY2q4mVK8/Kqo9O0n1CrMMzjCNIek2IYo1IaQeHyApep1t8Lr4c+GUGj5Ur9/mxeReCd2dMZkhYdqbY3dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(11063799006)(6133799003)(3023799007)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xIa0jhT/dLqtwgbOJr84JIWl61FEFT4DSkW1EqGt8y9D2j/Kh556UD1D8Ta92P1KKdGzwd/g32rUedvvNTVyccOuIBSS9A6dD78XKWwQ+gGsMCon9f7tvpV7ZkGmiPN+jhoUkIQPajdq9fRYhiED4qNQjQlHDcxInjSncl5zuH3GzoFGXz98l7C7W6U74PB3j2hUArlz+U/thI9GnDnqPFcMSlW+8beITabrBLO9hmBUwbnaVAi06rEm3OVa6zAgZmL2Yv6+uk5oM6SUj+AVldTTDyQpbqLrTTU50i5Z+krm+KB0ir+Kdd8GAnDMWOncL1hTMGX6SoCc8zcBHp6f54hE0lc+R33TzmPv/08owvJ8dKdLcGxlvh1nq2Mbx7pjyf/jeYoXeiDyrdKZ9K0CwV7Q+ogj5I584OaEaz49PkDJst2sR/I628UxjJgjIYYD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 03:11:40.1237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b35665e5-c831-46c6-e52a-08ded330a44f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4068
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

amdgpu_gfx_reset_mes_compute is used to coordinate suspend_all, reset,
and resume_all between KCQ and compute user queues. When a hung queue
comes from the computer user queues and the reset is successful, the KCQ
failure after reset should be sent to KCQ only and not the compute user
queues. Compute user queues can operate after a successful reset without
a mode reset.

Fixes: 2dcf9a5a2352 ("drm/amdgpu/gfx: defer per-queue helper_end until after MES resume")
Signed-off-by: Amber Lin <amber.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 982b41606d48..52dd26dd82d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2282,6 +2282,7 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	struct mes_remove_queue_input *queue_input = (struct mes_remove_queue_input *)faulty_queue_input;
 	struct amdgpu_gfx_deferred_entry deferred_end[AMDGPU_MAX_COMPUTE_RINGS + 1];
 	int n_deferred = 0;
+	int ring_err;
 
 	guard(mutex)(&adev->gfx.mec.reset_mutex);
 	/* stop the drm schedulers for all compute queues */
@@ -2375,17 +2376,23 @@ int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
 	/* Now CP is running again — replay backed-up commands and ring
 	 * doorbells on each reset queue.
 	 */
+	ring_err = r;
 	for (i = 0; i < n_deferred; i++) {
 		int er = amdgpu_ring_reset_helper_end(deferred_end[i].ring,
 						      deferred_end[i].fence);
-		if (er && !r)
-			r = er;
+
+		if (er && !ring_err)
+			ring_err = er;
 	}
 
-	if (!r)
+	if (!ring_err)
 		amdgpu_gfx_reset_start_compute_scheds(adev, ring);
 
-	return r;
+	/* If this reset is triggered by non-KCQ, the KCQ result after resume should
+	 * not override the reset result. It can return a false reset failure to the
+	 * non-KCQ caller
+	 */
+	return ring? ring_err : r;
 }
 
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
-- 
2.43.0

