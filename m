Return-Path: <SRS0=hpB+=NE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F17C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9828F60FBF
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Aug 2021 06:35:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9828F60FBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C5656E51A;
	Fri, 13 Aug 2021 06:35:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C87976E51A
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Aug 2021 06:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bdVzwtFvleJI9zkvs9k8muZzp0EUgEMyRWmNaMykYeg1vHUCPUGDzLWUKr+oF7Mkj0ypr9uw2HO/4uaDiFFgk6/H4d9G+2fEdke7sIBOODcEqIxrGMcLkePTAhnzKNQFKu9HC83yG0ZEo7F58XuoW9xS+bEs0JydBfpJFg+2gxYBTMHpIyCptgPm40LFt5baUSXO40Dcz3bmFSWYHz7PkgCzvB+a1+txjgvWVx+cfby7+MliVJMERyI6s/eYu7f/qWq7L8sl6l7wr8FiCTURmHNC9H/rz5J3DkWqwhI8WDI/rOzzDomlcb21SiO8brCch8QXrHWJz4/Mqdi/a3Dr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=102qZHThffTsx33AlKBWcn2+EhZijFEXFFNw+vOJqUM=;
 b=HL8nJ0o0/5xb69FfppYLdgIx4fhAAGM4EafYwOnueC/aQpKFj0i3YbaaWqnqPwKqTfH6kzTJAMXPRcZuzu+lzwCGbtpH0V7UfIl+/oPOJowIj37XEqSRoG94l0XswgO+VsIS4RT9lcDIULxhoVzuM+Krc1Xk20a3ZjNhxM9js8mMkbngD2lW/5vWsJu2DUcFwC2IlDr7pwIG3gkCpgWASEFTBhqU8iEfgNgtzBe3MOXEajNKXDRxchuOd4v7rF9dIW9DR+mtV4W0R0AXiX+dUUiRoWXjndjywWeG47V07u1ohaBZjM98A66foPpT7E99ind0YfGty3CpVsG3bZ92yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=102qZHThffTsx33AlKBWcn2+EhZijFEXFFNw+vOJqUM=;
 b=1PapfWZ3HAfTQMHarg/uJ0l1o+eJxIVTzohpMqGsdR0uhiq0nkbvMfBNsQZml5tSFdLi1PUbhqkrnTfAYayTt9QRd7Xp+DkCu9sqLrH+bLVufh1O/B9LG8UQLnpj/UZPdUTFbsFp4V3RllEhIDcTiVkVhFJ3TwhdxpjP5nY+7mo=
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by CH2PR12MB4970.namprd12.prod.outlook.com (2603:10b6:610:67::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 06:35:46 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::15) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Fri, 13 Aug 2021 06:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Fri, 13 Aug 2021 06:35:46 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 13 Aug
 2021 01:35:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 12 Aug
 2021 23:35:45 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Fri, 13 Aug 2021 01:35:42 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <bindu.r@amd.com>,
 <Anson.Jacob@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Roman Li <Roman.Li@amd.com>, Wayne Lin <wayne.lin@amd.com>
Subject: [PATCH 5/7] drm/amd/display: Guard vblank wq flush with DCN guards
Date: Fri, 13 Aug 2021 14:35:00 +0800
Message-ID: <20210813063502.3106309-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210813063502.3106309-1-Wayne.Lin@amd.com>
References: <20210813063502.3106309-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b093faad-23f8-45a2-78c0-08d95e24952a
X-MS-TrafficTypeDiagnostic: CH2PR12MB4970:
X-Microsoft-Antispam-PRVS: <CH2PR12MB49704F088FB6AA9556A726A1FCFA9@CH2PR12MB4970.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:339;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y2p/5jrbu3WeMnxq7mF2KKQPhbwMOkL1fpvhhgJvZ5MKwxtTOe0XjpAZcqTW88gwI/kUWcpFamOXmpqQnfa1DJIE1OAFgP+kC3MZrrmZeeRx3mUNkC0KFpnwuywu2ap172RIxzZkKTY5VsP6T48Gkvf+7eclRDWsFB3hXm1Ta1eqn+z3mX37SVTF/O4NLrHNFeY0thEMPKMv9uNM1x6B6kFp18alHVrjUZdsREyrN4xfvbuNm3ZUzo6pPM0wuVvuU2hLfrjE8/V3FFaNPp9pjYitnjk4S9pDAEGKAhxCV8A+iNc7eC7vbOY/v3WYwaOeDRMQ8q2aa9UGkAURguNKoqbhBgOTjf6L98xtRwc6ureRp0UQIC/kSKHDr2y3P41IrFI8ypoBK9SkQc5savZxPHBYlyu5vZ+BuxNpfnHOiz4R8ErsWkvoLXa9DQOYWjv/SqJ+vAkAu4PQHlHHyofbdU6SsWrut9/OmA7z9LqgML0eVSv9CjIb0p5IjONBQFktmUni5P9DNbPzYTA8iraYmCKdtTmHXbiomq0rbNUsx2Zb2Fh8Y/vIw5vag823cHZwSolo6tR8MEz4wl+l+5nUkE2JEMCngj6eSSMofVTo9oDUJFA1L970xx3be3f/NdX6i1+qmVny72zNfXQN8PjWdPOo6ojIc5wTzhzIyf0x4eTdRWuBPaZkENwnSq3EMGV5nFr8jM4UZsyUvuRas86QSxpQn1COe1QEq7mDiHOhwJj0l4JKhDHSYa5nwChAugfTOpGeRO4IybKMlBZ1Cq7YWw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(2616005)(26005)(34020700004)(70206006)(70586007)(508600001)(82310400003)(426003)(336012)(54906003)(1076003)(8676002)(8936002)(6666004)(36756003)(186003)(6916009)(2906002)(7696005)(47076005)(5660300002)(81166007)(86362001)(316002)(4326008)(83380400001)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 06:35:46.3628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b093faad-23f8-45a2-78c0-08d95e24952a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4970
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

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Compilation of the workqueue fails if not building with the DCN config
option set.

[How]
Guard calls to the flush with the DCN config option to fix the build.

Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cebd663b6708..816723691d51 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8643,11 +8643,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	/* Update the planes if changed or disable if we don't have any. */
 	if ((planes_count || acrtc_state->active_planes == 0) &&
 		acrtc_state->stream) {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 		/*
 		 * If PSR or idle optimizations are enabled then flush out
 		 * any pending work before hardware programming.
 		 */
 		flush_workqueue(dm->vblank_control_workqueue);
+#endif
 
 		bundle->stream_update.stream = acrtc_state->stream;
 		if (new_pcrtc_state->mode_changed) {
@@ -8980,7 +8982,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	if (dc_state) {
 		/* if there mode set or reset, disable eDP PSR */
 		if (mode_set_reset_required) {
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 			flush_workqueue(dm->vblank_control_workqueue);
+#endif
 			amdgpu_dm_psr_disable_all(dm);
 		}
 
-- 
2.25.1

