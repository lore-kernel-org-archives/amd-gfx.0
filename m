Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299CBC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 03:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B4010F5F0;
	Wed, 24 Jan 2024 03:39:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A657510F5F0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 03:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LypRYKI+EPwGIc937LC6EZFKFe6ozh49ynwP8sqdT1G/MBrvQq60OZTAji2YCKndzUyUg0sIbvKRcBlfcc96Jhb5V9+QZ2URg8xdbZS3LgdcR7tyj3WzoscONIdYKJUtgPFUCbt1kJlgupEdssf04YUDTAFgwKW+OtIpxZZbakWZzGDJLMSOOi5XMX8ippaWz+tL0mdY0LWoEQkJ5pFXLHP6RyU14DnN188xPi5v1dVYbJlgQD8HQ2hMT4bOtvbQH49oBpWOGDHYgsQ/QYxnkfe9GNjN+21AqwuVoFQUTeo6FuW3tM6nLCMPDYPOkrqSVPp0EQhA06VL87TbIeeYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1d4Y7UrgCJb9UgMmgzkecdfxGnuwmW6qFqsTeo8MnYc=;
 b=irdO1Aeo432rUYSztXO5Pa1Vts77C4jk/fxJqwqQSt9IaDSnS1DmHtdbvO0TGx5su+BaeeYiRN7ExPhMXUkQltE07g6N/1MD+lJBxXqGFaNnj4JLPVGeIly32FljpCHqpqLCP6J9WkbdPjE05T7unrk0gdz/035BBnxK1NT3Sh0KEzIfrjPmtqZDbUMSZ49UmDns/eM7pRyrswFyx7cQrEqcwYPppirkzprNuOfBE31SYn4UZftRlVXMRPyoMzZFH5Xc+lr+KLC+O7l0xKXvgsN0k6WYkb/S81WemusZSbJFxqE7n8k0CQ3eqO4/lqcynzStIZFy14brulL41fi4gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1d4Y7UrgCJb9UgMmgzkecdfxGnuwmW6qFqsTeo8MnYc=;
 b=paq3UYcSawKMEzpcZbFrrUyez/2aQEL0xZ3v4YpJfHTrnDyJIuQ4SOU9QK5WP8Og59CjQRKNUMSOy4mErGZBV21Pcs6Z851eH33XV8RGtRfK9gC09BLkHzSogf4aodXpNxqmHs++MablBqglrM8GUCXPTZfC3f8Rckgq6CGv+XY=
Received: from SN6PR08CA0020.namprd08.prod.outlook.com (2603:10b6:805:66::33)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 03:39:30 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:805:66:cafe::93) by SN6PR08CA0020.outlook.office365.com
 (2603:10b6:805:66::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Wed, 24 Jan 2024 03:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 24 Jan 2024 03:39:29 +0000
Received: from thomas-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 23 Jan
 2024 21:39:27 -0600
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix driver uninstallation problem
Date: Wed, 24 Jan 2024 11:39:00 +0800
Message-ID: <20240124033900.2410167-1-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: c5901a2a-6b0c-435e-19c7-08dc1c8e1259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r6Gd5LI9o0RDv/W1f1rN2AYUV1bYm7L/qIGxlb6amdm1jD2XFNH4T6WYu6o17TADOpAXWTxmKFZxLP2vMVmAHKl1oit63htji8Bejb11zQvIRZoM/JYVshq5tHB+nwbM3ENcc2KXy108cMF9GNrMHRqwl/uRsin1BG3qWOllO5K1Sitj7h8ux9iTG9Bd9ujj4t4n2jaOUc1V6fYhF7hvROwNO45QWl05LlC3qovChDqd9n6uMxgqBk7jzAdCxTyp5jyl+cg+XnsZUxNQcqndLuXBQXsVKbWDJchUQf8cMaRaf1W1+m0jVOv3EHt5T5GzUs5Dyxt9161S/tqmFxnWV+2QTJtvIdBlsNuPETq4OQqLSrfYlBuxThev1kclv3irdA5u6SrDY4sCh2Km2W9+W9NvtQr5RHLtkT+0C/SoYObhHSxfxpJuOhcud47rrNVtslW/BnuTUOsVhLUWErFVs+/tCNdYjMxB2WPb3R9XONRVCMpGYpyozlh+ihrSB1bggCdZj/gvsTPFXGBB10CBfgmZKAKNd+7W9Xws5E/kASWdBa6A1CI8BOAEj8p2QkfSkCgjAAdL7GmQHsHR8fzIacxJhjGTLhUS67HSn6t34HcEelv2MIdB0uMss3zoUclTNZmW3iy/3pE9iZnrkOcbeKd88q8o7qdU5U4DxtouwpVG0Dpie56VtYeontB5epvd8ozfqh6WpIKsScnN4i9B8hbEq8FtS5VJo5VG3Vtkiho6j9R2iq+n9LGBmxvEBL0qLbWxJL+91epsv5Rt+CiCKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(16526019)(36860700001)(47076005)(83380400001)(4326008)(8676002)(8936002)(478600001)(41300700001)(86362001)(40460700003)(40480700001)(36756003)(336012)(426003)(1076003)(2616005)(26005)(70206006)(2906002)(70586007)(54906003)(5660300002)(6916009)(316002)(6666004)(82740400003)(356005)(7696005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 03:39:29.7905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5901a2a-6b0c-435e-19c7-08dc1c8e1259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922
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
Cc: KevinYang.Wang@amd.com, Tao.Zhou1@amd.com,
 YiPeng Chai <YiPeng.Chai@amd.com>, Stanley.Yang@amd.com, yipechai@amd.com,
 Candice.Li@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The following is the error message:
[  484.495995] task:rmmod           state:D stack:    0 pid: 2195 ppid:  2194 flags:0x00004002
[  484.496000] Call Trace:
[  484.496002]  <TASK>
[  484.496007]  __schedule+0xaf8/0x1870
[  484.496015]  ? update_load_avg+0x74/0x7b0
[  484.496021]  schedule+0x58/0xc0
[  484.496022]  schedule_timeout+0x276/0x480
[  484.496024]  ? ttwu_do_activate+0x9f/0x570
[  484.496028]  wait_for_completion+0x8b/0x130
[  484.496030]  kthread_stop+0x71/0x1a0
[  484.496037]  amdgpu_ras_pre_fini+0x5b/0xe0 [amdgpu]
[  484.496202]  amdgpu_device_fini_hw+0x165/0x4fc [amdgpu]
[  484.496406]  ? blocking_notifier_chain_unregister+0x56/0xb0
[  484.496409]  amdgpu_driver_unload_kms+0x51/0x60 [amdgpu]
[  484.496522]  amdgpu_pci_remove+0x3b/0x70 [amdgpu]
[  484.496627]  pci_device_remove+0x39/0xa0
[  484.496631]  device_remove+0x46/0x70
[  484.496634]  device_release_driver_internal+0xcd/0x140
[  484.496636]  driver_detach+0x4a/0x90
[  484.496638]  bus_remove_driver+0x6c/0xf0
[  484.496641]  driver_unregister+0x31/0x70
[  484.496643]  pci_unregister_driver+0x40/0x90
[  484.496647]  amdgpu_exit+0x15/0x22b [amdgpu]
[  484.496849]  __x64_sys_delete_module+0x14a/0x260
[  484.496853]  ? syscall_exit_to_user_mode+0x26/0x40
[  484.496856]  ? __x64_sys_close+0x12/0x40
[  484.496860]  do_syscall_64+0x5c/0x80
[  484.496861]  ? __x64_sys_read+0x1a/0x20
[  484.496863]  ? do_syscall_64+0x69/0x80
[  484.496864]  ? syscall_exit_to_user_mode+0x26/0x40
[  484.496866]  ? do_syscall_64+0x69/0x80
[  484.496866]  ? exc_page_fault+0x87/0x170
[  484.496868]  ? asm_exc_page_fault+0x8/0x30
[  484.496871]  entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 8c1cb3ec2762..768a98f4bd22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2674,7 +2674,11 @@ static int amdgpu_ras_page_retirement_thread(void *param)
 	while (!kthread_should_stop()) {
 
 		wait_event_interruptible(con->page_retirement_wq,
-				atomic_read(&con->page_retirement_req_cnt));
+				atomic_read(&con->page_retirement_req_cnt) ||
+				kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
 
 		dev_info(adev->dev, "Start processing page retirement. request:%d\n",
 			atomic_read(&con->page_retirement_req_cnt));
-- 
2.34.1

