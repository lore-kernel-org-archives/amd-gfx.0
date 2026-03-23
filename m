Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F9DFC72A8
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 112A010E30D;
	Mon, 23 Mar 2026 06:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dsdj4PE+";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E690D10E30D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:56:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKyO5XvPxK/5izkrDdIz9G+Qhj7eH4pyizvUU54mzcwH1Jtxz9FRuLIpTGzISIUuzwFw2gXx/wbZWxZ+X5eN9k/b/cRppyHVu4VXhVZuWfYrhWfwjuwQtDip/vCjzyetQeAtkUIzD/u8nVYTyV5oGImXGz16MSd9KsosnsT2PTituugg+3qWCYvufeO5xE3G4v6WH6FNyBj3czt6BgtOka2dee7pfgOgVwycXyfcQyM3bdNB2dvDrDGkAsmUjIvcbiMat4XVkMAoQkeiGlBrrINbRW2MErwundHdraRHFH1ELyShv0gMvaiZr1q+kKhQLndkOCnRe0nQzsldm9aEDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oc5V/xew2ee9ztzQsm+iTapWSixudOTWZ6P7HoQWnZc=;
 b=Vo0fS487FMP8PCQDFrKEbI4fULHoqNZqf4TU5v6EcGzakztDtLxFysqm7sX5hyfWJuJCkFLq9wfYLPSC21/YaHvKQBZIMtTOX7v4owHCWC3Tm7Lfr+SdCUInjXPepOy+b2DfHKzNsx+LBojalXLZiP8lsXIPPtfqRSYoUecPDCa7tw4BOfrTDiwJCGrI0HKc6p/quau+iz9jaqt8RTy/2nvEo/SzHiUow7RfVI0x5+8pIGn1NPaDhUyFcXB29NwtN8z9DalH8QF+8v6+aJXNqzZUD3YOSdDgH2OPG9Tumpw48ECf+kEovL+Yqn9ZT+UmQlizS57jibObIbusYbGFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc5V/xew2ee9ztzQsm+iTapWSixudOTWZ6P7HoQWnZc=;
 b=Dsdj4PE+//FsU0y4TwQTKj+fePk1Sau8n0EgDIgLDFXFhKSJKH359Z5ZxPbJk46qb5wAmc3iMo5Xiv7Ke8PvuT+AsaCQByRuoFFuczBLWHGTsAlA3ZEHXagy9rU1Hfc0eIFyEGG4Y9C5QvaWBP/9uRtXoPsG6SJe24xBEKHJEtI=
Received: from BN9PR03CA0184.namprd03.prod.outlook.com (2603:10b6:408:f9::9)
 by BY5PR12MB4292.namprd12.prod.outlook.com (2603:10b6:a03:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 06:56:30 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::ca) by BN9PR03CA0184.outlook.office365.com
 (2603:10b6:408:f9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Mon,
 23 Mar 2026 06:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 06:56:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 23 Mar
 2026 01:56:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Mar
 2026 01:56:28 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Mar 2026 01:56:22 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <lijo.lazar@amd.com>, Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH v3] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
Date: Mon, 23 Mar 2026 14:56:02 +0800
Message-ID: <20260323065621.554621-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|BY5PR12MB4292:EE_
X-MS-Office365-Filtering-Correlation-Id: 65579c61-2310-496e-577a-08de88a94f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: DanK/J8aawwTuT4aNW2yH4khEejP+dMJFJEe8NVSpT44A3DfIMG9r44pA5dkDZQ/vgmNYUL2p8GHJy5BCgZrnWdyA5GSjxW5Jv1TBXeqdt17XuAEYSC2MDxEaYvoJOng0xcVKJS6YXI8bOA+1vVLZjWB7Lyt6Nt5KH3nkA3lyrzeVkhoyqd2UpOFCen3yKdch34atvz4kXGKRCM1EhWmyCNghVjyZulm8rzixt1IZhuIpKdR/zEY34ZPSjY1gSPm2Lh55yi0orH9TUJe01+eTqrIGg2iuuBR0BUaxBfWj8DBdw2haiZPb1d2B+sH16eODyfwf1wsv9W0FYvOvtpWkypurKxIkg9eGlHtphVipjuksupX0/srEQB5x5zH9vHTZQNiH9PxzIvaZi+C3HfFKwj4YDqzbnolXpPvf3ZuEsz66g5ZfkD0Pb1FjIqaUgMv6Jm8GgMwrbFYhCUcaZKUTf8X4AWbOgrZ1DcP2oukjpUi65spaAe4G8rNN7iAbJrY7Z5iFYCmaEh+AXcJasTpHI8AX9Vg1mKgDnIYc/38GVgHUaoey+AHAMX8LGiCBr1XgzkMdNYyvjOqyyG8dJbHJutjXlMnAeKcUIhNaOVFBXe4MhAHygQo4X8o67mYVKXXezKcRjZAHEd/D2w31ReM/RLf74MKYIoAXJj7Ic2XyR1dFULyJZmohJ4ghfgGOBpQJlXpo+89nFApfhIuZDK5tgfbkaWUhwtmYHPlC687tHXHoioNvHIoPcueS7UT6Z8tnYXcrbM8GgFE7d9x4XPt2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JlKhxGSQoLmXFwGt3RwR8KaQqUHRN2pyzwDlA80du+1zBl4LA7/8Ohw+V07ZI9stDnfpgqVK4NjT16m7X9lQFEeF/RLBUe3DUjyYYv3OVYaYEV7zh+AulHtgphSpEcQju5/+ppHFwieOLCAsN5rl7Sd8P1xDrmUXgS2OGBo9iAo06iGR5NafdjFk1TqesCQO8wJLvOdz3pJ/eVQXdCiy0KDHVNI6TQSrr5sf0yV5zc40EkiqsM0Tj6WsYVTMUn1FCt302csSkATp2xP1AV9Ko4cVv28Dg55HA4ZfcHRdHML1sHXFLEklnqvdxR/Am0zlTnX9r2Fv810aGIrqSmUcQYps/kc1MpprfOvLo3e4ziUSTwBGuf7M8R2Cef4gVhQmbYA5RmzdRbofN1Vsig1PTlA1XUch+YUBC8Dgau2wnCJ9sQIj6RcLmdGGiSsExIhj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:56:29.6502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65579c61-2310-496e-577a-08de88a94f72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4292
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

During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
paths this pointer can be NULL, causing a kernel page fault from the deferred
coredump workqueue.

Fix by checking ctx before printing VBIOS fields:

if ctx is valid, print full VBIOS information as before;
otherwise print a fallback line:
vbios info       : unavailable (atom_context is NULL).
This prevents NULL-dereference crashes while preserving coredump output.

Observed page fault log:
[  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
[  667.941517] amdgpu 0002:01:00.0: Dumping IP State
[  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
[  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
[  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
[  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
[  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
[  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
[  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
[  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
[  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
[  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
[  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
[  668.008035] PKRU: 55555554
[  668.008040] Call Trace:
[  668.008045]  <TASK>
[  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/card16/device/devcoredump/data
[  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
[  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
[  668.031950] amdgpu 0003:01:00.0: Dumping IP State
[  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
[  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
[  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
[  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
[  668.095863]  process_scheduled_works+0xa6/0x420
[  668.095880]  worker_thread+0x12a/0x270
[  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/card24/device/devcoredump/data
[  668.107441]  kthread+0x10d/0x230
[  668.107451]  ? __pfx_worker_thread+0x10/0x10
[  668.107458]  ? __pfx_kthread+0x10/0x10
[  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
[  668.118630]  ret_from_fork+0x17c/0x1f0
[  668.118640]  ? __pfx_kthread+0x10/0x10
[  668.118647]  ret_from_fork_asm+0x1a/0x30

v2: add check !adev->bios and chang the log  (Lijo)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index bbb5afd67b49..29078c08f264 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
 		   adev->vpe.feature_version, adev->vpe.fw_version);
 
-	drm_printf(p, "\nVBIOS Information\n");
-	drm_printf(p, "vbios name       : %s\n", ctx->name);
-	drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
-	drm_printf(p, "vbios version    : %d\n", ctx->version);
-	drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
-	drm_printf(p, "vbios date       : %s\n", ctx->date);
+	if (ctx) {
+		drm_printf(p, "\nVBIOS Information\n");
+		drm_printf(p, "vbios name       : %s\n", ctx->name);
+		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
+		drm_printf(p, "vbios version    : %d\n", ctx->version);
+		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
+		drm_printf(p, "vbios date       : %s\n", ctx->date);
+	} else if (adev->bios) {
+		drm_printf(p, "\nVBIOS Information: NA\n");
+	}
 }
 
 static ssize_t
-- 
2.49.0

