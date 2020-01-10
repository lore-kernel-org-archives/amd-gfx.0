Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFC9C282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1E62082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wGUKGZo7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1E62082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FBD6EA2D;
	Fri, 10 Jan 2020 14:47:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63346EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8HWAacgK4ofd5Xeq2/xGC1F9qdwa2aA/SLcM/AeZ0n6sPIPw0L6UfJXw2X0uLi+i+UP9w+5waJEi1nBCyS8XW9RJ2GgCWP5BkVKMj4MCvb3PMr3VJguRO5uudxrsBYUeV2+CPcEYZGomiL3NbhX0UGLQioH9FyS3sNnHv45FaDBFExn5EybvIYG2PGOXPj3JCvC/txfnef6OeYXUMeEDIfuD6iWHbRUBAMOFoUx4bffjm7fFHyGfKFfsDXVTEVY1YTGHoQfJTLT/+iMBokh5XxNSYVu4MPMY48KcFTeplFf1ciVVHqwIYlMhdvmmbNmMTCVv6MSbdk9isUmp5sNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zjj4d3QD1/WwZUDgxZEt59AxLXgZo2f+N5JGC4BbrA=;
 b=c0AidfulCfgqPhyAbO87H6jQBHXBohWPQdCzR0GCkT1bhs3aG7korxGyDNaZXyblvkz1s6ETpvfdhuyuVy/iIPlrYwXPOKivxsLzhjzysxKVzBLQQn5ysS+0uBXiZzFvd/uVDaFbmjoRKETAo5SydeZkbJwzAPTTtm04KRx65qnTFVVWMMfsopX+jcEWC6lGpcSpGZob9bxQF8tHxn9ib4Y6XGiLMyF32rrpiauoDO4TzjxmTu6vqwVWqBL38rOe2QGel9y+DocjsX2paItBcbycg8vZ5iMktGxtvn2AOsPhFYGM/NFAtQDE+fCJPdJobrHCnClgJwg5S/1JM9A2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Zjj4d3QD1/WwZUDgxZEt59AxLXgZo2f+N5JGC4BbrA=;
 b=wGUKGZo7NV3SbzYQRFsGTr91SKYfCCF8UqfBXfdrSkCxmg1rEhfC/QAxNJystHEVu74TQvXjZF91R18bLmKRro0/po4GVwQNwylJhTD8P4UjHgn95kxupDiZNqL9Gfy65HTRbV9yvC07QOOO9ikkfkHVuV7s3R0pS3CLaduLfb0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:22 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:22 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/43] drm/amd/display: Clear state after exiting fixed active
 VRR state
Date: Fri, 10 Jan 2020 09:46:14 -0500
Message-Id: <20200110144655.55845-3-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
References: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:21 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d667dfb-e61a-4210-9a71-08d795dc0008
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524A47E631E63D3D4A85DF998380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(54906003)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INxK/0HxBS/5YBd10AlVw8rglTF3QKHeBpBcE3FAmQ5I8ih5YcgXkSmsf8EaV4ErVb2PbJXOCHQAZj9vJsfjLgVghKu6NjWdiStJ+s4/mjLwT6au6s/xhY1e9H3TiIJTZYMJ1o+CWGJM0PrWxLKWCH+P6tB2d0kpgGE9/7FfEny8sgUfbnfDx9tbXbMuYgQys6YSfBcnnIIatOf+5rfq9ErDbwo4Lc7yY3N9k2GVpf3V+T9v4C7jYIvD1TAqETs3YmxhXwTYa3deJTY7FXpCQkjJd7r83tbEaqFBRQOtGGoB1+oBKds86KSrzsLkOkxJQim/EvvX+2a3ope3R/b+DVRF6NB/tHwpJL4dv2/CvKWR3CiXhm9zo2SW8vgvY42tTABxv+ldDve+j0iKNxs/iejTtP1vfs9JjsshzJAtVUEqrkURySnMtNKg/9MpUMvH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d667dfb-e61a-4210-9a71-08d795dc0008
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:22.3511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJ1/tpMH60FY+j0eLk0ffYHcqPn2W86ENVdaP31lOBF5GJFkiXGK9uErxOWriYRCG8rgowfTBVxlafMS3TAi8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 Amanda Liu <amanda.liu@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Amanda Liu <amanda.liu@amd.com>

[why]
Upon exiting a fixed active VRR state, the state isn't cleared. This
leads to the variable VRR range to be calculated incorrectly.

[how]
Set fixed active state to false when updating vrr params

Signed-off-by: Amanda Liu <amanda.liu@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index fa57885503d4..832bc9b3b7d8 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -812,6 +812,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 			2 * in_out_vrr->min_refresh_in_uhz)
 		in_out_vrr->btr.btr_enabled = false;
 
+	in_out_vrr->fixed.fixed_active = false;
 	in_out_vrr->btr.btr_active = false;
 	in_out_vrr->btr.inserted_duration_in_us = 0;
 	in_out_vrr->btr.frames_to_insert = 0;
@@ -832,6 +833,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		in_out_vrr->adjust.v_total_max = stream->timing.v_total;
 	} else if (in_out_vrr->state == VRR_STATE_ACTIVE_VARIABLE &&
 			refresh_range >= MIN_REFRESH_RANGE_IN_US) {
+
 		in_out_vrr->adjust.v_total_min =
 			calc_v_total_from_refresh(stream,
 				in_out_vrr->max_refresh_in_uhz);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
