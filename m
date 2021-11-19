Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54092C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F90461283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F90461283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66B4B6E41A;
	Fri, 19 Nov 2021 19:44:03 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FA96E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAO8t93DH8FV9nSgLXFHjiawTF4zIY8NgZxISv6lxy9KWTZzS8GRlCYxGS562h6yNIxIoB9yoc4urvZe/slLpnXRnC/8wQvrsdr/34C8slCVG+YkVU1+yetQ6+2JaGRJ5Usx+AtPUKe1gBracCEEZENJpbnPtntd1IO58yGJ1G6eUk1dtyVKf+078YNmc6Cnbhgbzk4qEzVGwuwLhnmb4AbcYRNVmH7BP2TE6OG0Ut04Sul7Kpm+Sxm6WESor9u+b7sWH82Ex+duFcrRfHgKQTld8JZHvjibY+wwGricZ7Kbqo/oimQYAH41NwVlq2C/rIAWS9kYAJEvc4yrcM6tNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7meSIgP3oPjRSHlMsywGhkvGLLe2ukENqeib3Yj/YbU=;
 b=k1SLURGjcetrpyyg4vT70fR9GMsSLNQzRLzGqBD+1QbQO/FM1CsT7JjPG/GdMjQjIE0Py9sslQS1xxR0io2N86zRpd3tEvpqkDGbwBsoooPejnLhgWaC/MZkaXSMnMnJTpmwQVAaMEV6iuB+eqkXyODM1d3+qVri/c78+Wf02DpDwjHouHI/gyiXy19XDykV5RfbZfyRE6WoXSskt/gyL+mz81QUBQGkp7kDPCxQ+R8gk7eS9vgN8hmkjAjR+RN5uCCXhS5MaMC9FKX8UE0VbzqGlirQIhDOuwZpdKc5NENY+t1gwHRV+UGjykcFMc2G5g03pF0+7UypeZxnlTyNug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7meSIgP3oPjRSHlMsywGhkvGLLe2ukENqeib3Yj/YbU=;
 b=C0h4uZ8MRQdZtutXAKcu2wNi6h6lgikJdmyJ953E5xIpaqhkHyJZ0uklSgef4Obx1YiV8LapN/ioWxj2xVTjSubwUx/jnue/96ThnAPCgPl7fdDdTUQGfjkXnNE284I2snB6aGIKX1k8W2/kFxBwJWPh0OyrNYNdOFKyHszjJto=
Received: from MW4PR03CA0289.namprd03.prod.outlook.com (2603:10b6:303:b5::24)
 by BL0PR12MB2547.namprd12.prod.outlook.com (2603:10b6:207:3e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Fri, 19 Nov
 2021 19:43:58 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::cf) by MW4PR03CA0289.outlook.office365.com
 (2603:10b6:303:b5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Fri, 19 Nov 2021 19:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:43:57 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:55 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/16] drm/amd/display: Reset link encoder assignments for GPU
 reset
Date: Fri, 19 Nov 2021 14:43:30 -0500
Message-ID: <20211119194339.97573-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73c4c418-d000-4ea2-60d6-08d9ab94eda3
X-MS-TrafficTypeDiagnostic: BL0PR12MB2547:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2547E697BBD745851FA3A161FB9C9@BL0PR12MB2547.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nbj/mzcn9imoBPWfrfpD6b6ZOHqw1PVMN1bDvJvbXQKI7m8ZFVqSxRWcDrfUUuUTYgJ8zDgWn08wOez21+USZkR2MCbJ+92lDOzfgQAoXyd4cowtHTJalVscgTlypfw5WfQ53oj/EY1jTBYBPqW0bJMsLrDC9y8oZMcwLmLJfVayrl1dewLkl6JG73mFHTJ0808xCyz/dlRYRpQtBNpQapEwm5SCVBihl1P5+SWv2jawphfDO0zw5PNUYtsipnrUyc/Ao4mkL5heCO2wodWjaquEuVdYsXWW92q5i759+GxlEu6/Vi7uP1Z5rSLAM38LVRJzkxw7DGIMkzMm6cI1FmOHnGuuIpMtN6Y7iS0d75LRBbJUNTLHHI8LcTUM8hbHUQoymjMoiyYYnM1eLwnkYOYSr00xvRDyLsxy/Ztncfbmz1rC6XFr7YTlUZWJM6JancdkgJ4JV00Yn+jWdT7LDys+qArRJJO+Kq3fJebX7QOwDsWvUGTFNgzKVTgabZO7oy9N1tAZSsR5SjSZqHjN+fWOb2hmG2gUo24uXlqQItpvsTbC9VyYKIkKEsdjMoeB/qEFnz5s6eaYqmtewc1fDNgHWkJkmv4BY1tpnNUrIaL0H5IrJ10q8Svye8zumfhYmD98taD3ab8M5xtuivvmVERYIqH9XgyqzJFnemhSw8SLdlI0bLtIzJY+y/9OYI4uAyF2eyMwVddfox5oH/DhMKwuhI1jY9ETBS0oqY+eAPE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(70586007)(336012)(356005)(70206006)(5660300002)(1076003)(6916009)(426003)(82310400003)(81166007)(47076005)(6666004)(508600001)(2906002)(16526019)(4326008)(8676002)(26005)(54906003)(316002)(36756003)(36860700001)(186003)(8936002)(86362001)(44832011)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:43:57.8473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c4c418-d000-4ea2-60d6-08d9ab94eda3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2547
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
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
A warning appears in the log on GPU reset for
link_enc_cfg_link_encs_assign for the following condition:

ASSERT(state->res_ctx.link_enc_cfg_ctx.link_enc_assignments[i].valid == false);

This is not expected behavior and may result in link encoders being
incorrectly assigned.

[How]
The dc->current_state is backed up into dm->cached_dc_state before
we commit 0 streams.

DC will clear link encoder assignments on the real state but the
changes won't propagate over to the copy we made before the
0 streams commit.

DC expects that link encoder assignments are *not* valid
when committing a state, so as a workaround it needs to be cleared
before passing it back into DC.

Fixes: 1a80a0d88ac5 ("drm/amd/display: Fix dynamic encoder reassignment")

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8411445e9c43..bfa63a4737eb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2560,6 +2560,20 @@ static int dm_resume(void *handle)
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
 
+		/*
+		 * The dc->current_state is backed up into dm->cached_dc_state
+		 * before we commit 0 streams.
+		 *
+		 * DC will clear link encoder assignments on the real state
+		 * but the changes won't propagate over to the copy we made
+		 * before the 0 streams commit.
+		 *
+		 * DC expects that link encoder assignments are *not* valid
+		 * when committing a state, so as a workaround it needs to be
+		 * cleared here.
+		 */
+		link_enc_cfg_init(dm->dc, dc_state);
+
 		amdgpu_dm_outbox_init(adev);
 
 		r = dm_dmub_hw_init(adev);
-- 
2.25.1

