Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F30C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB8AF208B8
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 20:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kKTu4BB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB8AF208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3939E6EA61;
	Fri, 19 Jun 2020 20:12:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 696666EA0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 20:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJs/qWPnMek485SdcIWUB7nZZm6u04k60wq7g8RmFH2WltGTaL4Ltg1ctoRy4AsBCErGE7a1AuDdABNcDsPTzqIrd8CiB+CebMBjz+04SWkiIZd7DuW08WCBD3W4t58zvdguelyI37CObafWTCfEhn64l8jg0x0pdTOs5kCmpi4h5qo8qNBDYn4Q5NRhBPAtpY8jI5RHIhvZhSEijRLjutIls305S3WTarwZwVbAaiw76XAASoIAg2HiIxfcxK4sM2+i/mxtDjPAty8PUYy8BotrAByODfU8DSZuhNeaN1xy4+8PjP/hLFcRWiWMKTHJRlQYOJ3wWrWdzh0a12sMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6osFvVw4eVJLVhlPza6uc+UVrOV/nIOxLLBmLrHWiSs=;
 b=NKnpwttg47t0yZfFzSn+WDNijAF2kv3sudYUVYziQPSRrMgH03CtSrOMN7PosgyHQOfxlCTzHmknfUFrflPXGLFLdBWwqpYQg+Sju19DCmAExi0Y2/X+fO4dub36rx7x+7G3gd/7HQM+0/EvH3BsgmISPUzSKq4tTXF9N/DnFaJYukmjWpHM4YthFoO2k5bxrcKR+G3fxZcP6tH7trHT31sM+J8Pf6GKtEcTSDK5zxQLSOo2PkWbyFmiBbwnwUe8vLvCRTtafmcHCquhrsPmvFB9Xe8zDY8FDu0x9wzlvZDvJqkQSvD89iKsthOcuIyqO7fgGly5znp5HFP1mJveYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6osFvVw4eVJLVhlPza6uc+UVrOV/nIOxLLBmLrHWiSs=;
 b=kKTu4BB1OQYi8fnE3QKJYfnh0aZn7d7UwvQDZccRDpHneYvW34AaSoG6Af14jyX347PiTzkpNGxWyCaRccMuRYX/o29rLzGyMQy0raR8zQTryJ3pc8/alBzOVNmcsWUwQc0Zp4jXkzAcT8L7GJXi7XGAv8r3NnW6BNfegx/j8rE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4198.namprd12.prod.outlook.com (2603:10b6:610:7e::23)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Fri, 19 Jun
 2020 20:12:50 +0000
Received: from CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580]) by CH2PR12MB4198.namprd12.prod.outlook.com
 ([fe80::812c:cc72:6d14:9580%8]) with mapi id 15.20.3109.021; Fri, 19 Jun 2020
 20:12:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/30] drm/amd/display: Fix calculation of virtual channel
 payload
Date: Fri, 19 Jun 2020 16:11:55 -0400
Message-Id: <20200619201222.2916504-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
References: <20200619201222.2916504-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::37) To CH2PR12MB4198.namprd12.prod.outlook.com
 (2603:10b6:610:7e::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:f5c::9) by
 YTXPR0101CA0024.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22 via Frontend Transport; Fri, 19 Jun 2020 20:12:49 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [2607:fea8:56a0:f5c::9]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 83d4c639-c442-4e19-baad-08d8148d23fc
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3717B35A5B4399C5B6C6735798980@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0439571D1D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QABdrHjb7Z+KSxyrEH13FowZmieT925i5efBx6Zo8Al3G3AvR/uhvIrT+EPYDtfpvevgVCK6GzDnJ4ROvqsFKRdBf3mey7N51Uy1mGBVboy9FmEdx0Uw8wmaX19RYcC3axXX0axE40dmYDxHzy72eoEztquuA1xfYXENBYi3SfiBJbUQVX4xpVRmd53idpPkrrVQ+MF8ikv30rDJEXQHJ/MkATmhv+TfycA1iHIcB0egaYVoZLCgBHOFXyqsw7LNFmA/B9RnKreS2Og35GAqV85SJi16IKwBbaSsLql6egUMcD3Q2jFpFttjbZTtbHRvSe3sWA1PLmxfIeGjBTwUsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4198.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(5660300002)(66476007)(16526019)(86362001)(6916009)(83380400001)(478600001)(66556008)(66946007)(8676002)(6512007)(1076003)(6666004)(6506007)(4326008)(52116002)(8936002)(2906002)(316002)(6486002)(36756003)(186003)(2616005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YZX7k+uEhLoTJ6K0ypFA90DyOtIRYuD0r6ILXmcpQkYpG+S2wUO0q/T1sAhkvnK9vSEfdMYmt2touk+8LdrWllHgklSh70ADY+vbCvsL5WdOn0ToMUjNGS2A0VrhNiKwAaKIOj3SWSF6q2RNP0dsELJy7cMLJdMO6hjXZ2pmghqk5ZMv1rCEJtmW837qhyQsk8TyIEZjS+A3PS7ZqgT36kAnutTKJqLg3VQ9OVF+FvczCePwUUmCdUKci17oW+M1Gui2A1/n8/2h18LYSHH+72V+8v1WgfyWtd6kUXZ/HeM+oiyJQxrhLCrJrpyK9DMgDIViiScXuutABU65N1Bvqe6ItxkTYrJqCu0In/qcyQTCsiFtsuKIQojKFh2mGEAt2+D3u+MyCP518wTInKc6CAC6AC0S6Ml5JugxUtQlzmHpVD1+/Mz9LKXT5COnnLCeYbknNIjM7XFu1+k1dtd0qjhJB7nXiTBEDYS5Rya5C+oY4kf2ENoigDunKZv0nnpJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d4c639-c442-4e19-baad-08d8148d23fc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2020 20:12:50.1466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NFJ0d6PboSKAWRDplX/OGjcwZ8RoDr8svHl/RWDBT6ISbHRZkx4TYhPW/GoWO4WBhucjlkZtMnPyh/AzDTym3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
The calculation of virtual channel payload would not take link settings
in account. As we calculate VCPI slots needed both PBN for stream and
also PBN per time slot.  Before we would use generic PBN per time slot,
which would not change with link settings causing wrong Payload
allocation.

[how]
Provide PBN per time slot for each Virtual channel payload calculation.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 19 +++++++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9ab0d8521576..6be4913a0239 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5538,7 +5538,7 @@ static int dm_encoder_helper_atomic_check(struct drm_encoder *encoder,
 									   mst_mgr,
 									   mst_port,
 									   dm_new_connector_state->pbn,
-									   0);
+									   dm_mst_get_pbn_divider(aconnector->dc_link));
 	if (dm_new_connector_state->vcpi_slots < 0) {
 		DRM_DEBUG_ATOMIC("failed finding vcpi slots: %d\n", (int)dm_new_connector_state->vcpi_slots);
 		return dm_new_connector_state->vcpi_slots;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 69056660672d..6b98d420f9e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -543,6 +543,8 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 	int link_timeslots_used;
 	int fair_pbn_alloc;
 
+	pbn_per_timeslot = dm_mst_get_pbn_divider(dc_link);
+
 	for (i = 0; i < count; i++) {
 		if (vars[i].dsc_enabled) {
 			initial_slack[i] = kbps_to_peak_pbn(params[i].bw_range.max_kbps) - vars[i].pbn;
@@ -554,9 +556,6 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 		}
 	}
 
-	pbn_per_timeslot = dc_link_bandwidth_kbps(dc_link,
-			dc_link_get_link_cap(dc_link)) / (8 * 1000 * 54);
-
 	while (remaining_to_increase) {
 		next_index = -1;
 		min_initial_slack = -1;
@@ -585,7 +584,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 							  params[next_index].port->mgr,
 							  params[next_index].port,
 							  vars[next_index].pbn,
-							  dm_mst_get_pbn_divider(dc_link)) < 0)
+							  pbn_per_timeslot) < 0)
 				return;
 			if (!drm_dp_mst_atomic_check(state)) {
 				vars[next_index].bpp_x16 = bpp_x16_from_pbn(params[next_index], vars[next_index].pbn);
@@ -595,7 +594,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 								  params[next_index].port->mgr,
 								  params[next_index].port,
 								  vars[next_index].pbn,
-								  dm_mst_get_pbn_divider(dc_link)) < 0)
+								  pbn_per_timeslot) < 0)
 					return;
 			}
 		} else {
@@ -604,7 +603,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 							  params[next_index].port->mgr,
 							  params[next_index].port,
 							  vars[next_index].pbn,
-							  dm_mst_get_pbn_divider(dc_link)) < 0)
+							  pbn_per_timeslot) < 0)
 				return;
 			if (!drm_dp_mst_atomic_check(state)) {
 				vars[next_index].bpp_x16 = params[next_index].bw_range.max_target_bpp_x16;
@@ -614,7 +613,7 @@ static void increase_dsc_bpp(struct drm_atomic_state *state,
 								  params[next_index].port->mgr,
 								  params[next_index].port,
 								  vars[next_index].pbn,
-								  dm_mst_get_pbn_divider(dc_link)) < 0)
+								  pbn_per_timeslot) < 0)
 					return;
 			}
 		}
@@ -668,7 +667,7 @@ static void try_disable_dsc(struct drm_atomic_state *state,
 						  params[next_index].port->mgr,
 						  params[next_index].port,
 						  vars[next_index].pbn,
-						  0) < 0)
+						  dm_mst_get_pbn_divider(dc_link)) < 0)
 			return;
 
 		if (!drm_dp_mst_atomic_check(state)) {
@@ -739,7 +738,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 						 params[i].port->mgr,
 						 params[i].port,
 						 vars[i].pbn,
-						 0) < 0)
+						 dm_mst_get_pbn_divider(dc_link)) < 0)
 			return false;
 	}
 	if (!drm_dp_mst_atomic_check(state)) {
@@ -767,7 +766,7 @@ static bool compute_mst_dsc_configs_for_link(struct drm_atomic_state *state,
 							  params[i].port->mgr,
 							  params[i].port,
 							  vars[i].pbn,
-							  0) < 0)
+							  dm_mst_get_pbn_divider(dc_link)) < 0)
 				return false;
 		}
 	}
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
