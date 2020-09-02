Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D19AC433E6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 05:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD23A20709
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 05:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="z0JJgoSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD23A20709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B76F6E0DC;
	Wed,  2 Sep 2020 05:02:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E14B6E0DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 05:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh8zmXupseOEljI7YpHc3EVWpDmbgg0abQMUbJag/AZsIjj1cAYZwRwEpSfD0uI1k2GCr6VB6KN5i22i+5BNVwLC8YU4nsuhrEkGBs9Sq1x83mpfXEhdkEJXs5pwk4/mk+fjgOxLvWVIORUQidy+Axi0SP+Amf1nY75vlA5/IQynNfe/ATnjSnSQgPLyFlRqQacLVUDPFDMJwVOr1j885Ghyy7RSFB0untZh6yw4J7S1aC10FBCAyrJEno+oG8HQ1o7LYCECeK7bSH1386wfXo6fJ8bOvXxbjCdvoqG7uI/nV36wYJwtQo3g6SWyQS2WB433i0dmlZS6L/yHSmS5vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCKo//ve7Dpsf4ZC9WqTmLByCYJr3PDj0CdYtgz1xrU=;
 b=VIUzqt39KVnvHvYQMplA3dzYOKtdmCuofoz6+VHMZG5RO7xv2xxzvPl/MrDTNU64PGjlFBWtIVEONlVwtAWEfcWi/KN2GSXzeZXno4GAUuWrI4eZVLOvBpXtiAaxHoTHsfnLtPYmRikoLo5GjH+DS39PtI2KdsFp7jttR9ooh8k2Mhk6l4iKzZNLn2NAotE2+PAVp0+OXvbM9BWrydHJtkaNXtqxNIp37BGIpHsYsjHdsSTGZGWhbFwAZWMNMwUTjf6lJpbNQHxEreW4gi2YCPQf1MzD71+UoQZhvS7ig7gXW3t4AwaEOnArwkg1O2g0sMcPdJzTSygvLrod2rcYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCKo//ve7Dpsf4ZC9WqTmLByCYJr3PDj0CdYtgz1xrU=;
 b=z0JJgoSDmjOa9okiJAHod2avnX6ZGR6jhGyls2rQXxWz4/1MmihUiE8j5vMEJnJcUZ9umROjqn9Jn1GZvWkp5kiGnd25yYqCk+xbcpAp9mCbO9F+jVPpWrp+awwtBn4PP3cKoPtsGsMXr/MtfgDAWJRB7jRVIfZrSh+C8pbt4HU=
Received: from CO2PR04CA0153.namprd04.prod.outlook.com (2603:10b6:104::31) by
 MN2PR12MB3950.namprd12.prod.outlook.com (2603:10b6:208:16d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 05:02:38 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::c8) by CO2PR04CA0153.outlook.office365.com
 (2603:10b6:104::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Wed, 2 Sep 2020 05:02:38 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3326.19 via Frontend Transport; Wed, 2 Sep 2020 05:02:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 00:02:37 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 2 Sep 2020
 00:02:36 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 2 Sep 2020 00:02:35 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2] drm/kfd: fix a system crash issue during GPU recovery
Date: Wed, 2 Sep 2020 13:02:26 +0800
Message-ID: <20200902050226.7968-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac055341-7854-4a53-67a0-08d84efd69cb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3950:
X-Microsoft-Antispam-PRVS: <MN2PR12MB39505384910E07F7F3D4B3C1ED2F0@MN2PR12MB3950.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 568bSEpCDCBb80MdjGHebYwT9z2W3RXc+KI7GPwdmkglr4MNSs00igERzOEM3+xuRPOdTKbH6f9mduVfaBXmPhqai5JYHr+xt+Qhcyf4aOmz0ESk+BLujk5brMW8UH2Ixli9B6TbAuoUvmU53BZaIrJPrS3Cmbih/ZJeYtdR9xcknP7vXAHomvczBGmHfgT7MT+ric1Quo1d5+0ENHpOFa0JN3d6WpoHnR1GbhjJgmiWto5T66o0pfOxbLOFxSJds73Q7/M7gP18DQx1WZSdM6TtIY/6xbEiLEdxVriaiA+PAp6eA8QXAE9gF0FcbACnb1b9NxfK7S1g3B7KwA4NZtW4zPEKE+edqtlAs6keA5TC04ouDh2ly1Lt/Mc2k3v5hEsfTm4ydXJknkIulGBo5hBcoD8LI+AAg9T55qC8ERM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966005)(186003)(8676002)(356005)(7696005)(47076004)(26005)(336012)(110136005)(316002)(82310400003)(5660300002)(81166007)(70206006)(478600001)(2616005)(426003)(1076003)(86362001)(82740400003)(83380400001)(70586007)(6636002)(6666004)(4326008)(36756003)(8936002)(2906002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2020 05:02:37.9986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac055341-7854-4a53-67a0-08d84efd69cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3950
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The crash log as the below:

[Thu Aug 20 23:18:14 2020] general protection fault: 0000 [#1] SMP NOPTI
[Thu Aug 20 23:18:14 2020] CPU: 152 PID: 1837 Comm: kworker/152:1 Tainted: G           OE     5.4.0-42-generic #46~18.04.1-Ubuntu
[Thu Aug 20 23:18:14 2020] Hardware name: GIGABYTE G482-Z53-YF/MZ52-G40-00, BIOS R12 05/13/2020
[Thu Aug 20 23:18:14 2020] Workqueue: events amdgpu_ras_do_recovery [amdgpu]
[Thu Aug 20 23:18:14 2020] RIP: 0010:evict_process_queues_cpsch+0xc9/0x130 [amdgpu]
[Thu Aug 20 23:18:14 2020] Code: 49 8d 4d 10 48 39 c8 75 21 eb 44 83 fa 03 74 36 80 78 72 00 74 0c 83 ab 68 01 00 00 01 41 c6 45 41 00 48 8b 00 48 39 c8 74 25 <80> 78 70 00 c6 40 6d 01 74 ee 8b 50 28 c6 40 70 00 83 ab 60 01 00
[Thu Aug 20 23:18:14 2020] RSP: 0018:ffffb29b52f6fc90 EFLAGS: 00010213
[Thu Aug 20 23:18:14 2020] RAX: 1c884edb0a118914 RBX: ffff8a0d45ff3c00 RCX: ffff8a2d83e41038
[Thu Aug 20 23:18:14 2020] RDX: 0000000000000000 RSI: 0000000000000082 RDI: ffff8a0e2e4178c0
[Thu Aug 20 23:18:14 2020] RBP: ffffb29b52f6fcb0 R08: 0000000000001b64 R09: 0000000000000004
[Thu Aug 20 23:18:14 2020] R10: ffffb29b52f6fb78 R11: 0000000000000001 R12: ffff8a0d45ff3d28
[Thu Aug 20 23:18:14 2020] R13: ffff8a2d83e41028 R14: 0000000000000000 R15: 0000000000000000
[Thu Aug 20 23:18:14 2020] FS:  0000000000000000(0000) GS:ffff8a0e2e400000(0000) knlGS:0000000000000000
[Thu Aug 20 23:18:14 2020] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Thu Aug 20 23:18:14 2020] CR2: 000055c783c0e6a8 CR3: 00000034a1284000 CR4: 0000000000340ee0
[Thu Aug 20 23:18:14 2020] Call Trace:
[Thu Aug 20 23:18:14 2020]  kfd_process_evict_queues+0x43/0xd0 [amdgpu]
[Thu Aug 20 23:18:14 2020]  kfd_suspend_all_processes+0x60/0xf0 [amdgpu]
[Thu Aug 20 23:18:14 2020]  kgd2kfd_suspend.part.7+0x43/0x50 [amdgpu]
[Thu Aug 20 23:18:14 2020]  kgd2kfd_pre_reset+0x46/0x60 [amdgpu]
[Thu Aug 20 23:18:14 2020]  amdgpu_amdkfd_pre_reset+0x1a/0x20 [amdgpu]
[Thu Aug 20 23:18:14 2020]  amdgpu_device_gpu_recover+0x377/0xf90 [amdgpu]
[Thu Aug 20 23:18:14 2020]  ? amdgpu_ras_error_query+0x1b8/0x2a0 [amdgpu]
[Thu Aug 20 23:18:14 2020]  amdgpu_ras_do_recovery+0x159/0x190 [amdgpu]
[Thu Aug 20 23:18:14 2020]  process_one_work+0x20f/0x400
[Thu Aug 20 23:18:14 2020]  worker_thread+0x34/0x410

When GPU hang, user process will fail to create a compute queue whose
struct object will be freed later, but driver wrongly add this queue to
queue list of the proccess. And then kfd_process_evict_queues will
access a freed memory, which cause a system crash.

v2:
The failure to execute_queues should probably not be reported to
the caller of create_queue, because the queue was already created.
Therefore change to ignore the return value from execute_queues.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 560adc57a050..069ba4be1e8f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1302,7 +1302,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
 	if (q->properties.is_active) {
 		increment_queue_count(dqm, q->properties.type);
 
-		retval = execute_queues_cpsch(dqm,
+		execute_queues_cpsch(dqm,
 				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	}
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
