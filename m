Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214D0C48BF6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 08:45:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F4A810E324;
	Thu, 29 Feb 2024 08:45:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lWB3ALVo";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FA1410E324
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 08:45:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEJX2bAIA9mS3TccncwWHTtcvgFKZI0QpkcjrNeGY3nFdoBRxNJv5SH8K367GMzy9/hKE79z/syqqs1ne+ZikVAMLHVNmpe0OeMZulfIvUyAl+06Pp7ztOeaEFD+B2VLMiGmFngKqhxMBE0nLjIZAs0c0UOGA7vGfFHy4AoLHq/3sFWuXWjQ2yEAKgmyafIbO22NCkEYWTDa0dTZ9FDhvDyWx1C35LEZpn5vquUxDRfKuLqRxmU1bciY3ZleSS1fO0ej63OpwsT9fcS4ii+JQaQOc7o+FOI3WfYYFo+jTnwzdlgoPLpDaZPTWW2FYnMrruCA6byBoPwdLA/dNcrwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrncD4soAQHl9KkwLY+VFnKbqxtivhyNUR9EOt51Xq4=;
 b=SlzBd/fr7VsgqZ39wInL+kpTOWui8XTX414VJ7t6BmbktWlqwSTeUJ7sUgfyIV9nMsP3OFKu812r6jd2uojLkP4DBVfO8CYE3r5lpiBRI2me9XuMNH5QrjYWwjL6aYJCrRrMzGLcBAOLgjC5gE5uorJMM2AD+2HJ04+xFfhiKfrNbn0YkxibI8ruGWN/lfEfy8GiuOuooBlezzQYDXgYdDYTUhWp91DH7/5p4ATFnBTJsFHtcvGJ+zicZ31yqh02GMkf5unhkxF9tgUC2rtUKQnwxUi1NmkjfPDX6YnUIDKWbp4Cfkh24dTA/75XPRRQkCtfM8DmMbj9CNJRgKrB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrncD4soAQHl9KkwLY+VFnKbqxtivhyNUR9EOt51Xq4=;
 b=lWB3ALVou4RAx+dau99HUisK6W/imeQxKmGcBx+H8BeNCqgUNzx+7FqtGpoSe03Ai79c3Wqli/Xhh+S5OWoaIaoZLl57XNTyk/v9OyFoejyNv48h0W2pGs2BVCoilD/SMKaLeRgrYgwyyfPiKxxkF3/1Ad78W8LYPHizPs/J6Rs=
Received: from BN9PR03CA0223.namprd03.prod.outlook.com (2603:10b6:408:f8::18)
 by CH3PR12MB7689.namprd12.prod.outlook.com (2603:10b6:610:14d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 08:45:27 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f8:cafe::e2) by BN9PR03CA0223.outlook.office365.com
 (2603:10b6:408:f8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Thu, 29 Feb 2024 08:45:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 08:45:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 02:45:26 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 29 Feb
 2024 02:45:26 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 29 Feb 2024 02:45:19 -0600
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>, Jonathan Kim
 <jonathan.kim@amd.com>, <Yifan1.Zhang@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdkfd: fix shift out of bounds about gpu debug
Date: Thu, 29 Feb 2024 16:45:13 +0800
Message-ID: <20240229084513.86529-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|CH3PR12MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b78a228-feab-4daa-40b4-08dc3902c6c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gShaOeiUGz7S3APF0cqIyTr1CVA0Mx7DRcxQhqhmJWmvi6eiGIfnNbWnMahnCIR500qqHzIMR8kp5meGbTaq7JRruJUgBnyObltkze48YZ2Es5GHfti9Ozfke4BYahJ24yovwlSB97QQRMtMzsJvif24A7VEwZD1J/A2PRVhnAIMCGl0H/Ci9rfQFxowMNl2FU577EIpKiYPLeT4PaRDb2j/1TVftDPGXp78wY363u8KQe2o0m/vrSB3TXScvSRy2S+RaTn2lA5BBR4MHuzEEL3w5v8MKYgV1xkLUc6VSEMN1eVPbJPRJcBju/s3ErvcEXBTQ/6eGj/ro4F8RKgn7rg6XH91MweVP1zITzT0Sb20iUjDBCKVAA8uLj5qC+8mH84gsP/FofRUTgpNpMwcsAp8NRb7NRKAg+6AN6SMkVxxLpgBfIJMpu6dVHZUA/jDWj3eP8VREZ7A+29oAOcPfL5/qjErD+prZRredr32ncwua5Mo3xgLbQmh0VrI64rWqCxJFpZ2hs5hyrogC2wr9kceXTH/CnP+wrMz7ySDDVCqROZj6heN42eey9tm/4gJQ/DS36cN3vDFMdY03FIU/sBSDQvfBiZ9r/DGK60BO2sHTHcaKZJ7YxCtRfHc1gorPbTU2dMJbWox38jcJNprj4I8c2hSZJiz+0U3z9labhnzZLHuXQh18J0/hvkqMG2QBT/a+5c7in+X6PasC+6uBq7SDMq7dlz7nFR7pmYP2xA44JzMr8h+KwQQWhsBV0AR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 08:45:26.7094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b78a228-feab-4daa-40b4-08dc3902c6c9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7689
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

 the issue is :
[  388.151802] UBSAN: shift-out-of-bounds in drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_int_process_v10.c:346:5
[  388.151807] shift exponent 4294967295 is too large for 64-bit type 'long long unsigned int'
[  388.151812] CPU: 6 PID: 347 Comm: kworker/6:1H Tainted: G            E      6.7.0+ #1
[  388.151814] Hardware name: AMD Splinter/Splinter-GNR, BIOS WS54117N_140 01/16/2024
[  388.151816] Workqueue: KFD IH interrupt_wq [amdgpu]
[  388.152084] Call Trace:
[  388.152086]  <TASK>
[  388.152089]  dump_stack_lvl+0x4c/0x70
[  388.152096]  dump_stack+0x14/0x20
[  388.152098]  ubsan_epilogue+0x9/0x40
[  388.152101]  __ubsan_handle_shift_out_of_bounds+0x113/0x170
[  388.152103]  ? vprintk+0x40/0x70
[  388.152106]  ? swsusp_check+0x131/0x190
[  388.152110]  event_interrupt_wq_v10.cold+0x16/0x1e [amdgpu]
[  388.152411]  ? raw_spin_rq_unlock+0x14/0x40
[  388.152415]  ? finish_task_switch+0x85/0x2a0
[  388.152417]  ? kfifo_copy_out+0x5f/0x70
[  388.152420]  interrupt_wq+0xb2/0x120 [amdgpu]
[  388.152642]  ? interrupt_wq+0xb2/0x120 [amdgpu]
[  388.152728]  process_scheduled_works+0x9a/0x3a0
[  388.152731]  ? __pfx_worker_thread+0x10/0x10
[  388.152732]  worker_thread+0x15f/0x2d0
[  388.152733]  ? __pfx_worker_thread+0x10/0x10
[  388.152734]  kthread+0xfb/0x130
[  388.152735]  ? __pfx_kthread+0x10/0x10
[  388.152736]  ret_from_fork+0x3d/0x60
[  388.152738]  ? __pfx_kthread+0x10/0x10
[  388.152739]  ret_from_fork_asm+0x1b/0x30
[  388.152742]  </TASK>

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 include/uapi/linux/kfd_ioctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 9ce46edc62a5..3d5867df17e8 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -887,7 +887,7 @@ enum kfd_dbg_trap_exception_code {
 };
 
 /* Mask generated by ecode in kfd_dbg_trap_exception_code */
-#define KFD_EC_MASK(ecode)	(1ULL << (ecode - 1))
+#define KFD_EC_MASK(ecode)	(ecode ? (1ULL << (ecode - 1)) : 0ULL)
 
 /* Masks for exception code type checks below */
 #define KFD_EC_MASK_QUEUE	(KFD_EC_MASK(EC_QUEUE_WAVE_ABORT) |	\
-- 
2.25.1

