Return-Path: <SRS0=HJvn=3R=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BBCC33CB7
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B798214AF
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jan 2020 01:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ln6ohPTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B798214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDFE96EC48;
	Tue, 28 Jan 2020 01:30:08 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6BF6EC48
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jan 2020 01:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=az4l288R0Pl9nd9PfPekhJBfNjOKb+PQOSaVDJOsOXbrAkcFagYhaNfkLdGHbQq4UyKO9Tly6vlw6pZH0qee3nUqnqaFJ0DtsnE/CHJ+D0GDecZoDJKbq7Jrw+3QtfOqE5hYedXIV5D9xFyeMPVHuPvYm0MHM25GgIqlyXjC9ZJ5pkKBiikS8Fs7ubal/VGWptS6TZS6JlCLNj+nxEc8reA4TtEprvf+ZIfB2PmtvG+Kia/X9LUZ0CpJMC0njV5kRssKaIVGIQ5VRKLGQ7ICTndnlmMCVyW/1+atP6yafhFKPd4G/9/kX+P2/BIfm0AaE0e15MSAyY+1QjRMkqGoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bduymp4XVxFaMfv0drZr7WZlWlapLznRPzZKCA4jM5k=;
 b=dMME1XuvrQtbd6HA291FPpOJxqkmQfkdkMDALbbMWghRtWzH3r7Ei7Cd/h45/ZLluSFpe096xg55UW2K2U3COkQgsJ7SQmzkmN9oGl7a9L2APfCSwlAcmbYEr+NCUal66VZo6RcdXf+wqI1CluvdwCBhDqiPzk7WV327YB9mott2cE7srfKxq51Eo6UhwMJQGkG5gKdlfI706HdhkEuL19mbO9zvFsVbsrWiQlHu0ycpxPIuAles4Zb9m1+WlCBA5e5lI3NQUQSa6/XSwzpBtgKjj0LTWs9OVtbaVY46ulesaDM0NTvO7g7ZZ2/0Ky/Kdk1LF3ixH/MYwZ0qnASGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bduymp4XVxFaMfv0drZr7WZlWlapLznRPzZKCA4jM5k=;
 b=Ln6ohPTl2QnCUXAUmZgyvv6Jt2/aVfQRne3EBDdFQ8YVhi2PoPo2sPXSMM8KtGAl/bp5YnLRP07VCGAdRMa7SVrf+aj0t74xni+VRdnkfdWAhGRVtK/Q9R8n2qizFHxClwlxhUSUwnzKPoSC9DPRrllUcej4zcoZG+kbDXCQRDE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rajneesh.Bhardwaj@amd.com; 
Received: from SN1PR12MB2366.namprd12.prod.outlook.com (52.132.194.147) by
 SN1PR12MB2592.namprd12.prod.outlook.com (52.132.194.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Tue, 28 Jan 2020 01:30:06 +0000
Received: from SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80]) by SN1PR12MB2366.namprd12.prod.outlook.com
 ([fe80::596e:6046:7bf6:9a80%7]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:30:06 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [Patch v1 3/5] drm/amdkfd: Introduce debugfs option to disable baco
Date: Mon, 27 Jan 2020 20:29:21 -0500
Message-Id: <20200128012923.25536-4-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
References: <20200128012923.25536-1-rajneesh.bhardwaj@amd.com>
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To SN1PR12MB2366.namprd12.prod.outlook.com
 (2603:10b6:802:25::19)
MIME-Version: 1.0
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::46) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.21 via Frontend Transport; Tue, 28 Jan 2020 01:30:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8ca61259-f7aa-4a29-dd1e-08d7a3919afa
X-MS-TrafficTypeDiagnostic: SN1PR12MB2592:|SN1PR12MB2592:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB25921DA921B7AE829A9DA116FE0A0@SN1PR12MB2592.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:597;
X-Forefront-PRVS: 029651C7A1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(199004)(189003)(7696005)(52116002)(66946007)(4326008)(478600001)(6486002)(8936002)(44832011)(2906002)(5660300002)(6666004)(956004)(2616005)(26005)(36756003)(86362001)(81166006)(16526019)(1076003)(6916009)(66556008)(81156014)(8676002)(186003)(316002)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN1PR12MB2592;
 H:SN1PR12MB2366.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N/yMEn79KxHEzuMwYvlbWSiJ5WMl9qev/F7lx04MGoBRvSk7J1Tw7+gQewTL9zBWgZ9qY7f6A5sKSkkyPH38UFylLnljM6cDJWUmsa3f+nJJr2djSYAGWuSRImgST6lv93J1Bbr4gDmaXX7aVlRR6UcRcgqHTQN30Wi6tJIqs8AbMqKgvPpi3fDddZkHDkDvglIIDRaNFvwPruHlvUBBpBJ1nco77r88jgDWfIH5bHd9OXOFdYcqxgcFu34V3mmaVjaOjdxQQIpDV/CJDQUpnCo3pJGkfPDHUQZB54xqfsH+9od02ICldUg1zMjr19Sp0NPyc8RhQlT87dqXl6uZwmO4oqeKdtFIjbIIjvgxXxEWucP8JquXen+YQudUG1GzcQq8qUs1nYc/8Lw3PN5ktBJJFXjQsTNZwpdu74NuayJVhNnV81gAzP2SxLbcRinY
X-MS-Exchange-AntiSpam-MessageData: MUkc54QJfvOe7yJwyN2F8NtsLNMagCxsXW+b+/hkYKXGruTvkb8SFtru5z9wooCMOjVxq+sDbFzfJhIMzfi8EphJIRVNCp9p0w9dtIsvmb3U6Kz1C8uuA90j6BjZGTcPf28ZdoglsiYiJpg33axegA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca61259-f7aa-4a29-dd1e-08d7a3919afa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 01:30:06.3261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RweKlRP9Jn0p5jShAr5kUl7iY9p7G7Jt443JWdqxVMtx0rRwOH3RgGHpKCH4z/BjCnG2trHQ/r9j2OxRgE8IMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2592
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

When BACO is enabled by default, sometimes it can cause additional
trouble to debug KFD issues. This debugfs override allows to temporarily
disable BACO for debug purpose without having to reboot the machine.

However, in some cases one suspend-resume cycle might be needed if
the device is already runtime suspended.

e.g

sudo rtcwake -m < mem or freeze > -s 15

or

by triggering autosuspend event from user space, by doing something
like:

echo 6000 > /sys/bus/pci/devices/0000\:03\:00.0/power/autosuspend_delay_ms

    Usage:

echo 0 > /sys/kernel/debug/kfd/enable_baco and run
cat /sys/kernel/debug/kfd/baco_status to verify whether BACO is
enabled or disabled by kfd driver.

It should be noted that while enabling baco again via kfd override, we
must do the following steps:

1. echo 0 > /sys/kernel/debug/kfd/enable_baco
2. sudo rtcwake -m < mem > -s 15

In this case, we need GPU to be fully reset which is done by BIOS. This
is not possible in case of S2idle i.e. freeze so we must use mem for
sleep.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c   | 27 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 47b0f2957d1f..0fa898d30207 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -34,6 +34,7 @@
 #include "amdgpu_vm.h"
 
 extern uint64_t amdgpu_amdkfd_total_mem_size;
+extern bool kfd_enable_baco;
 
 struct amdgpu_device;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2c64d2a83d61..d9e5eac182d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3259,6 +3259,9 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 		return -ENODEV;
 	}
 
+	if (!kfd_enable_baco)
+		return -EBUSY;
+
 	adev = dev->dev_private;
 
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 511712c2e382..c6f6ff2ff603 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -26,6 +26,7 @@
 #include "kfd_priv.h"
 
 static struct dentry *debugfs_root;
+bool kfd_enable_baco = true;
 
 static int kfd_debugfs_open(struct inode *inode, struct file *file)
 {
@@ -83,6 +84,28 @@ static const struct file_operations kfd_debugfs_hang_hws_fops = {
 	.release = single_release,
 };
 
+static int baco_sts_set(void *data, u64 val)
+{
+	if (!val)
+		kfd_enable_baco = false;
+	else
+		kfd_enable_baco = true;
+
+	return 0;
+}
+DEFINE_SIMPLE_ATTRIBUTE(fops_baco_enable, NULL, baco_sts_set, "%lld\n");
+
+static int baco_sts_show(struct seq_file *s, void *unused)
+{
+	if (kfd_enable_baco)
+		seq_puts(s, "Baco is Enabled\n");
+	else
+		seq_puts(s, "Baco is Disabled\n");
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(baco_sts);
+
 void kfd_debugfs_init(void)
 {
 	debugfs_root = debugfs_create_dir("kfd", NULL);
@@ -95,6 +118,10 @@ void kfd_debugfs_init(void)
 			    kfd_debugfs_rls_by_device, &kfd_debugfs_fops);
 	debugfs_create_file("hang_hws", S_IFREG | 0200, debugfs_root,
 			    NULL, &kfd_debugfs_hang_hws_fops);
+	debugfs_create_file("enable_baco", 0644, debugfs_root, NULL,
+			    &fops_baco_enable);
+	debugfs_create_file("baco_status", 0444, debugfs_root, NULL,
+			    &baco_sts_fops);
 }
 
 void kfd_debugfs_fini(void)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
