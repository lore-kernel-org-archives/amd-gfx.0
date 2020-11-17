Return-Path: <SRS0=Y8VF=EX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1BCC5519F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 15:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3FC2463D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2020 15:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Nm4UCv3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3FC2463D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B257C89CD9;
	Tue, 17 Nov 2020 15:52:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EFBB89CD9
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2020 15:52:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OueawF59ZXEI1pyo7Pp1fyqiif8RTZ2IwuFwqpalQ09O6DJVFQFmuwr1Nt9icx9RdEm2cZ5VN++9Qg6B3yDcMcLVx7DFx9dNp842HgcxwoPC9s2/Kvjcha+FmaFFMmjfffYAlKvNO1EuCuinJnb6uG/CXRrsVf+RAhajedsN1fCcXl2jhJdY5AEhQskrxHYhVAGbZJqsWE0AfY+EhR4PNqsiJ1KFAsF1g+Hhivl7yYJbyFehSM+KG13Vx/kUw6xA/SyjNfGEZUgNqhdIElJT25ueN8TyDSuXKKugMrAzoH9CTOpQlY+74/xQHWDyYqjUxiCtvfuxOOWIj/qRkPa4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLLO8GLlfWG232/srjGOeGcYsjWpEjfmxKoWd1nmryU=;
 b=PWOD4M67ofJlcpmWNprRvrYAfECHq9ugPhqBZEaMvAJNLBZmYptU2kcBRnlWL/HXBPBuElpcOQrVXr0zE7BF1OCP/WnpwvF8e2xQZGA/ib0H5GN2nlht1C7G8KHVXwr4Who/Qci4OaV1q02TfumLazRz4AIBbQi40/7xCRcoJU2qOzTe4bI9OKV3tY+43bmQsK1delNNrc8Ru2SPYb1IRox3EksfcJKuC5QDpBKaJpUUFukI1BhmETnkZss/lL+hJcTHAuaAg3d9b04APom7VmS8TR7qCGTsjCVppisd5Srck4OD+NKExxQ6kSzYQ/rXjTDwYbyEVPLMjgBzEEWjWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLLO8GLlfWG232/srjGOeGcYsjWpEjfmxKoWd1nmryU=;
 b=Nm4UCv3+ASMxbUExDk4X1GhNFUcryJ+dz2cYMU4M97ORxA8bU/Kvn1expfh6uJQXTqDfvHwt4UGlDMySqEn0z0zyLfYUm1777JiHwlhfU4TU06wjFZqbGG5BJanFRquMYeBnSCwaw7V388KeQrneAS8AoMkqoCsdiwlJqgMNtLM=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB3781.namprd12.prod.outlook.com (2603:10b6:610:27::11)
 by CH2PR12MB5002.namprd12.prod.outlook.com (2603:10b6:610:6d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Tue, 17 Nov
 2020 15:52:06 +0000
Received: from CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa]) by CH2PR12MB3781.namprd12.prod.outlook.com
 ([fe80::9d:35d6:ff59:1cfa%4]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 15:52:05 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Harry Wentland <harry.wentland@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Aurabindo.Pillai@amd.com
Subject: [PATCH] drm/amd/display: Always get CRTC updated constant values
 inside commit tail
Date: Tue, 17 Nov 2020 10:51:21 -0500
Message-Id: <20201117155121.1522769-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [2607:fea8:56e0:6d60::c908]
X-ClientProxiedBy: CH2PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:610:53::28) To CH2PR12MB3781.namprd12.prod.outlook.com
 (2603:10b6:610:27::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::c908) by
 CH2PR17CA0018.namprd17.prod.outlook.com (2603:10b6:610:53::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.28 via Frontend Transport; Tue, 17 Nov 2020 15:52:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90075249-0738-4e39-1735-08d88b10bb99
X-MS-TrafficTypeDiagnostic: CH2PR12MB5002:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB50026984F3A8D16BF76577C898E20@CH2PR12MB5002.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9v+iwBUEgy6ATKbyttEtJDxWMdeJICHir0Up8Z5T3rSLct8yGHv+xRI/eGzJe4R6TLZRJQXSxaXwihbws0HK0DCBSlRbTSFB5dMXZTIUEhHgt5B+arefl3tH5l9lgxfwTu/W2fsbiJ0/OwqTWqtWqcd+mbO2QCHQP0tURXqFh9ybfbZN3mgyIzRSRQ8Pis7lDjkIHvDrGphBi/sDf3z7PS0dgnd4D+bTxOdVH3iYWdE32g/Ps1na+k8so3dn91ZvhFvNcOfNAk/r15iIOT7//Mb6hCqY5PTgP4B6ea7CXWR9Uvj78OFT2X9Ek+N4v0c7gFi9BDrJRL+Wer/rSpPELA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3781.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(52116002)(36756003)(6486002)(186003)(5660300002)(316002)(6506007)(16526019)(83380400001)(2616005)(15650500001)(66476007)(8676002)(478600001)(4326008)(6512007)(66556008)(6636002)(110136005)(6666004)(8936002)(86362001)(1076003)(2906002)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: r/6kEQk5WgXEQS7D+q1Bw2WT/i7nEq0iVX/sOEgz7td7cKC+PrhRo2uZaqS4IjXNUZSazBsVzGQt3ujfTp17fBB98YFwUNX4yFvM+O3Ft4eDguzLZ1iekMx/0kvT8RSX1aWSRxNMUUKRBLnNGxwFpl8D1TRjQ1W/e8N1U7hA97QZ3EYJb6fT4bSt/ifVAB4/4MwFpb08vujHbbqPOQrhNqDQuPuD3HcywquER1rT4lroqTKFN0IAZBlNfbLNPouGtb5qyzhWqacPlNuQwQUUmlPEv7w9nhSsMuGYWtmD987c9LSQ3mnVIrekpwcqQWq9n6OeOP/o5rjnlhGjXlsJ8FMOasEu7sc/u+7nMbTfvggHsWQ8CMKX5/UXJ+pRsmmshaxqo1oQV3SF7d4xRm21lo+t37sDembv5mQbkDr30JyH3MT+b2CDNAlIbQkMvnof5lMhNXUwia6///7oi7u6YaPFNGK0aFG89qa1d2QIVUxZ5nHtRxQ/wdM9CCPCpwNJfREpfboSdsHNm5Th737rZKIcPE/4pLzHOgb3f8RwmoHHL425iMwi8ZyL3i80ZywBfugmFw6RaZaKquNiQd/Afp1gLKEm/FRok1v8AMx7pVsy7l88326sZXerdXUX5Ow+klF2tQX9Gaxm0PYbCJ8bR9mrGctaNjYCu7XumxvDQX0TBrM8H2npIEkFY8kmtQxpRFHANn9T0vT/LHSl7vmdK9urdCgW6mSm8cUQTU/8qbDWoGZDblGGrrCot/SL5b5di6mdoyzTQNKTJXp2W8BAkRXtDFuT4RePum6v5PjxY2FXc8RSqg097UGBqEuBrYj3DhEqA0znjLLfTIt/yKstOU2bS+YezKUXSEk7+QxjinGzpwVpSFEeQfZaYRmEhRJW3Txjkc/EcEOBTx3kgfccm4QxxmUqpQEjnyJqp0y+I5Ra3mBHlqnqpf7NQOdVgkM9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90075249-0738-4e39-1735-08d88b10bb99
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3781.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 15:52:05.8243 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lBHxm7dwbhz6G+MioNS+LjFDJPC9plzdP01C8aV44e4l8jgfNbndoNReSghkhnnB/j8ygUXH9qpuTDRCrnigg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5002
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We recently improved our display atomic commit and tail sequence to
avoid some issues related to concurrency. One of the major changes
consisted of moving the interrupt disable and the stream release from
our atomic commit to our atomic tail (commit 6d90a208cfff
("drm/amd/display: Move disable interrupt into commit tail")) .
However, the new code introduced inside our commit tail function was
inserted right after the function
drm_atomic_helper_update_legacy_modeset_state(), which has routines for
updating internal data structs related to timestamps. As a result, in
certain conditions, the display module can reach a situation where we
update our constants and, after that, clean it. This situation generates
the following warning:

 amdgpu 0000:03:00.0: drm_WARN_ON_ONCE(drm_drv_uses_atomic_modeset(dev))
 WARNING: CPU: 6 PID: 1269 at drivers/gpu/drm/drm_vblank.c:722
 drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x32b/0x340 [drm]
 ...
 RIP:
 0010:drm_crtc_vblank_helper_get_vblank_timestamp_internal+0x32b/0x340
 [drm]
 ...
 Call Trace:
  ? dc_stream_get_vblank_counter+0x57/0x60 [amdgpu]
  drm_crtc_vblank_helper_get_vblank_timestamp+0x1c/0x20 [drm]
  drm_get_last_vbltimestamp+0xad/0xc0 [drm]
  drm_reset_vblank_timestamp+0x63/0xd0 [drm]
  drm_crtc_vblank_on+0x85/0x150 [drm]
  amdgpu_dm_atomic_commit_tail+0xaf1/0x2330 [amdgpu]
  commit_tail+0x99/0x130 [drm_kms_helper]
  drm_atomic_helper_commit+0x123/0x150 [drm_kms_helper]
  amdgpu_dm_atomic_commit+0x11/0x20 [amdgpu]
  drm_atomic_commit+0x4a/0x50 [drm]
  drm_atomic_helper_set_config+0x7c/0xc0 [drm_kms_helper]
  drm_mode_setcrtc+0x20b/0x7e0 [drm]
  ? tomoyo_path_number_perm+0x6f/0x200
  ? drm_mode_getcrtc+0x190/0x190 [drm]
  drm_ioctl_kernel+0xae/0xf0 [drm]
  drm_ioctl+0x245/0x400 [drm]
  ? drm_mode_getcrtc+0x190/0x190 [drm]
  amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
  __x64_sys_ioctl+0x91/0xc0
  do_syscall_64+0x38/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 ...

For fixing this issue we rely upon a refactor introduced on
drm_atomic_helper_update_legacy_modeset_state ("Remove the timestamping
constant update from drm_atomic_helper_update_legacy_modeset_state()")
which decouples constant values update from
drm_atomic_helper_update_legacy_modeset_state to a new helper.
Basically, this commit uses this new helper and place it right after our
release module to avoid a situation where our CRTC struct gets wrong
values.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1772adcf9f98..91f7fdeee758 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8121,7 +8121,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 	trace_amdgpu_dm_atomic_commit_tail_begin(state);
 
 	drm_atomic_helper_update_legacy_modeset_state(dev, state);
-	drm_atomic_helper_calc_timestamping_constants(state);
 
 	dm_state = dm_atomic_get_new_state(state);
 	if (dm_state && dm_state->context) {
@@ -8148,6 +8147,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		}
 	}
 
+	drm_atomic_helper_calc_timestamping_constants(state);
+
 	/* update changed items */
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
