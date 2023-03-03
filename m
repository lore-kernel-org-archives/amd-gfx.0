Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B6DC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 360FE10E6E7;
	Fri,  3 Mar 2023 15:52:11 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A62C10E6E9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X75y4ee41aJxY+46uuUJK0kCPFCrTOBHLiLui7pJOIstZ97qWlLWfDkx2lPO2Kx8IPQ0C25RPBuPxD3jSEASBExvLG6zApwUgThdnsk0QTXDu9pCE98jU4xl8sJxfi0fNdG1HvjJMqGPcLRrGqQkSbDC0ZxkwpVSw340GhpjOHjlHmHIuCPzcEqarC8RtJ5+jYsqKaqDYtaFd4n4SVAdNacHorhv9xRt9+QrwXkr1dd4SrangHQV7AsoGD/G5Bbs+EZ/uiSxECRt7PliKSg7Y4fARJCtS4jD5Y205nlN8jo4QBMTORwsVBE4DhT131LpTYMXkzJfgpVRVlSXh3698Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jt5pIJHo0/Wbk9UvFrA+Wwu0GCf3Adi5Zv1ZfgqVojo=;
 b=OPqb0PdNr68NYP+XSVLGi7YMmBhHoT53yVp+5LZ5c/5/0Tl7s1bFtPQimfRnzOlDfQpNAd6xiRuRJHfqmASLGW/XD1T2GNjGMAm3T8Sf3QkzuJjNhMfFQMOW0e4iX1PlhgDm55eGWBh8yKadVGWh92znXr3IOtHwIRTES6cCLFpjkeONaZcckSXF5WFwGb3wv9WRCyOfFaK5cxImEJHSOIueyxgOwN23+Ilf2sT/+50S3USe86unw0v7rwqHnicbUOiqdGt+J7J+6BC8DJnahS59T2UL0hXkYrrzs7nyszPROf3YVBubl97z3G2R4mCLOcGy4p+Ice5ml0MTkzTxBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jt5pIJHo0/Wbk9UvFrA+Wwu0GCf3Adi5Zv1ZfgqVojo=;
 b=IJVGQvKkTLbX/Vhe81VifRP9/v7lujawy6lRljTSJ89791KsvJ6P7rmPRagFCLVh8vTf/oMR61AaYanO3knjaW3vqyJU7HNZN9C5ruHqsTci5GkKUtaO0BpdCZUsuIcAWwGRPAHl8JD2UvbzfOwj4vVW9BlwTsMrGt+oCYHOYJ8=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Fri, 3 Mar
 2023 15:52:04 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:8:56:cafe::51) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10 via Frontend
 Transport; Fri, 3 Mar 2023 15:52:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Fri, 3 Mar 2023 15:52:04 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:51:53 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 30/33] drm/amd/display: Use DC_LOG_DC in the trasform pixel
 function
Date: Fri, 3 Mar 2023 10:40:19 -0500
Message-ID: <20230303154022.2667-31-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|BL0PR12MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: d765fab1-de6d-41f8-a206-08db1bff3c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nwqMO3PvA9lU1OghzDVRnjtQIucwmCnu1QyP9C/mHXwjlXvbbriJgUuwfzeFcz/lpVLyUPqybDTCAI0mfTpBg0zN/xaaYjjI4PEI67osL5d16Y02r5ycMILYL46Zu/MpPh/qhnGWQciCcoujoYu4oT/uUkDCprG5Hf2Z8X6uPV/znGSIs91pR7E4GZusIe+yD4VDavHKR+82gQzJCoMkHJP3VtEIPRTiTGcInod8ZWHUUkMlIzpklIgRlCNjmivBxl/FdAaivh29qwnKaxE1LklTKaZ0i8SyBtLGUZIPCPGW4hcasOOh90KzrxJok9cyDsHgPofrAerk3iffr8icKxJErC07RZ9BH5dEHLxbSVSsV++kek6h2X1nsSUy9UASiowL23P2/kexW/7og7u3PomG5xlDa+xp4Tf9PhApPnvKORAAogBqICLNbyuoXNjYY/8iC+wooEw1xYxD/6TYQaHhH7XWXffZSU2s9/1dxRN+sW20Hh/iboiJAkJe/mRkDzEMZqGHhNrDPtkJdkKFNkJVvJrDVcHsGGiyj1C8DfFZsUu6E99zTFWpxrKl1U7x3BO9JrDuL+8Qt359KB04xlXD176jZPg9887V7QI7vr3u1UK6os2u8fEYiGcEoxKot7beWzlB9uKzE0gUrI52660S2DtpzLBtQIIGAWTx3jE6wAOOGQNoEfsHxpAmJalaJXZnTrO8ClooAVopbgr9xiiKullELNpaUA/lL5tA4M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(36756003)(82310400005)(16526019)(26005)(4326008)(41300700001)(1076003)(40480700001)(6916009)(5660300002)(336012)(2616005)(186003)(8936002)(8676002)(316002)(40460700003)(70586007)(54906003)(478600001)(6666004)(70206006)(81166007)(82740400003)(356005)(426003)(44832011)(47076005)(2906002)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:52:04.6048 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d765fab1-de6d-41f8-a206-08db1bff3c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why & How]
DC now uses a new commit sequence which is more robust since it
addresses cases where we need to reorganize pipes based on planes and
other parameters. As a result, this new commit sequence reset the DC
state by cleaning plane states and re-creating them accordingly with the
need. For this reason, the dce_transform_set_pixel_storage_depth can be
invoked after a plane state is destroyed and before its re-creation. In
this situation and on DCE devices, DC will hit a condition that will
trigger a dmesg log that looks like this:

Console: switching to colour frame buffer device 240x67
------------[ cut here ]------------
[..]
Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 5603 07/28/2020
RIP: 0010:dce_transform_set_pixel_storage_depth+0x3f8/0x480 [amdgpu]
[..]
RSP: 0018:ffffc9000202b850 EFLAGS: 00010293
RAX: ffffffffa081d100 RBX: ffff888110790000 RCX: 000000000000000c
RDX: ffff888100bedbf8 RSI: 0000000000001a50 RDI: ffff88810463c900
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000007
R10: 0000000000000001 R11: 0000000000000f00 R12: ffff88810f500010
R13: ffff888100bedbf8 R14: ffff88810f515688 R15: 0000000000000000
FS:  00007ff0159249c0(0000) GS:ffff88840e940000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff01528e550 CR3: 0000000002a10000 CR4: 00000000003506e0
Call Trace:
 <TASK>
 ? dm_write_reg_func+0x21/0x80 [amdgpu 340dadd3f7c8cf4be11cf0bdc850245e99abe0e8]
 dc_stream_set_dither_option+0xfb/0x130 [amdgpu 340dadd3f7c8cf4be11cf0bdc850245e99abe0e8]
 amdgpu_dm_crtc_configure_crc_source+0x10b/0x190 [amdgpu 340dadd3f7c8cf4be11cf0bdc850245e99abe0e8]
 amdgpu_dm_atomic_commit_tail+0x20a8/0x2a90 [amdgpu 340dadd3f7c8cf4be11cf0bdc850245e99abe0e8]
 ? free_unref_page_commit+0x98/0x170
 ? free_unref_page+0xcc/0x150
 commit_tail+0x94/0x120
 drm_atomic_helper_commit+0x10f/0x140
 drm_atomic_commit+0x94/0xc0
 ? drm_plane_get_damage_clips.cold+0x1c/0x1c
 drm_client_modeset_commit_atomic+0x203/0x250
 drm_client_modeset_commit_locked+0x56/0x150
 drm_client_modeset_commit+0x21/0x40
 drm_fb_helper_lastclose+0x42/0x70
 amdgpu_driver_lastclose_kms+0xa/0x10 [amdgpu 340dadd3f7c8cf4be11cf0bdc850245e99abe0e8]
 drm_release+0xda/0x110
 __fput+0x89/0x240
 task_work_run+0x5c/0x90
 do_exit+0x333/0xae0
 do_group_exit+0x2d/0x90
 __x64_sys_exit_group+0x14/0x20
 do_syscall_64+0x5b/0x80
 ? exit_to_user_mode_prepare+0x1e/0x140
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7ff016ceaca1
Code: Unable to access opcode bytes at RIP 0x7ff016ceac77.
RSP: 002b:00007ffe7a2357e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ff016e15a00 RCX: 00007ff016ceaca1
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffff78 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff016e15a00
R13: 0000000000000000 R14: 00007ff016e1aee8 R15: 00007ff016e1af00
 </TASK>

Since this issue only happens in a transition state on DC, this commit
replace BREAK_TO_DEBUGGER with DC_LOG_DC.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index d9fd4ec60588..670d5ab9d998 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -1009,7 +1009,7 @@ static void dce_transform_set_pixel_storage_depth(
 		color_depth = COLOR_DEPTH_101010;
 		pixel_depth = 0;
 		expan_mode  = 1;
-		BREAK_TO_DEBUGGER();
+		DC_LOG_DC("The pixel depth %d is not valid, set COLOR_DEPTH_101010 instead.", depth);
 		break;
 	}
 
@@ -1023,8 +1023,7 @@ static void dce_transform_set_pixel_storage_depth(
 	if (!(xfm_dce->lb_pixel_depth_supported & depth)) {
 		/*we should use unsupported capabilities
 		 *  unless it is required by w/a*/
-		DC_LOG_WARNING("%s: Capability not supported",
-			__func__);
+		DC_LOG_DC("%s: Capability not supported", __func__);
 	}
 }
 
-- 
2.34.1

