Return-Path: <SRS0=YZDW=DB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7145AC4363D
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50AF23600
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2020 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OLA9T7FJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50AF23600
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C746E1B6;
	Thu, 24 Sep 2020 10:22:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9856E1B6
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2020 10:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AhGbo83tFdSe1JdjUz5//H9AhOTwxIkN0qfA0MTIRgi+koTMWew64Vq6ZjhDsrBtzodzX3NK8MOtMwRc2OImIE8COFQpCOOb6ABY8LyA87GD5KJw2vwWWzWAn8mgnre7cqrmRMq5tujX6iGZGHPu+hKJxLF9o09MSSdo2OmO+Yzuey40/4a+GZ+fZPYl8g29RUEO+qj5BGtJvwRzEwUdtLubmW8EAL4LEcwpWBpLQ7WozgnwC5m8N3N20KhYRtcTbix47DVmUwRz+Gq8XbheITcYuvzKDqZCET+zS88UJsG4VJzhKVqkLIWEXgUzsB2/9gRQ4NopYwDR7Ki4s1KgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+/PRHFjmPC+8N7YQ3ga0U3WhSk3T1Vlg+2f+vaHUKQ=;
 b=goSsbc1ip7VpOzH/DWE/Ris8Lp8/27Zyvq3u/7TDUln/BFiVrjM82LTb8muWw0CXXKteE6BlvV7bxnAvUsNIHjOYR1IKGGpBEZst3egjfR/MjiGupqoFJ9+z4AmO7yPEPR8pD2UtD78zVt3rsnxvYxfxN81iJi8HpIMm4kOz9bevN68mGT61flSDitfMx4LvqPlkPCyy0f+n+t3GCIsDtWUxFZ82W0/npkmT18UFuZaTF7cpL5AUVzUpC6YCreYlNBDc7Ii7lcfN1lyapLKvkVUZ25a7nyr1t2woPZXUdv1cqcVG0mRr3xYcAwy6THT7xx00uT9uBOVwdVMowvT5eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+/PRHFjmPC+8N7YQ3ga0U3WhSk3T1Vlg+2f+vaHUKQ=;
 b=OLA9T7FJDu+tdL9qlDRvoOTr9UL831iinRjwsAbyO538pI6lus1vKCPvk6WgZL3Jx1WLNBt+HUCs80LZVyrY5geQZUOL6q28cYOiPvlntpEk2w6OuVY19NmOninbSsCRKu33JD1PgHx/+wIMP0Yn/gW78LcNcQFd+kK2opMzzK4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2501.namprd12.prod.outlook.com (2603:10b6:903:d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 10:22:26 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::ad96:acee:5c1c:d92c%4]) with mapi id 15.20.3412.022; Thu, 24 Sep 2020
 10:22:26 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Dennis.Li@amd.com,
 Tao.Zhou1@amd.com, John.Clements@amd.com, alexander.deucher@amd.com,
 lijo.lazar@amd.com
Subject: [PATCH] drm/amdgpu: fix ras calltrace problem by sysfs_update_group
Date: Thu, 24 Sep 2020 18:21:55 +0800
Message-Id: <20200924102155.27046-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR03CA0051.apcprd03.prod.outlook.com
 (2603:1096:202:17::21) To CY4PR12MB1287.namprd12.prod.outlook.com
 (2603:10b6:903:40::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK2PR03CA0051.apcprd03.prod.outlook.com (2603:1096:202:17::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.13 via Frontend Transport; Thu, 24 Sep 2020 10:22:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dac4c180-3c19-4c07-193f-08d86073bb93
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2501:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2501F4A1E54DDDD77B024153F1390@CY4PR1201MB2501.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iVppPaNLr9ZSJkQEAfdCqZw6deSHhpnuLHW6WqeK+7jBDQ5e+25lK/3obqMZ36eHoYHQhBKp5Q1nQiv2cS7uDYFgc2ea3gitNz6p921GvBtwHEWV1Tc0fTv3ZBMNbdmoUz0i8v2jx4614vl3tLyrvaouxoAkkjSCKpxf4O6Fz3SXlxU0N+kj8sDBzOYXuS6DbNV/d03ahfesA62XZ/NQVoxzKxR/GROUtqYON9DKR9rVPNPQsDGABV4ajRdLMEld1lZj5eUzOsyXRWGY8Djaee/WeNJbOPhiLIQ7QvFSGwvwvwxA7OxtzY61QYkPbs2Je+aO+vJ2aqV3yiHDas1DQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(8676002)(86362001)(83380400001)(5660300002)(2906002)(8936002)(6666004)(66946007)(1076003)(66476007)(66556008)(16526019)(4326008)(36756003)(52116002)(6636002)(7696005)(6486002)(26005)(186003)(956004)(45080400002)(478600001)(316002)(2616005)(44832011);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: h80ZofG5S5wKmZaVDSAw+mZU5J5GG0E6Cxa/tjUsos+d04Nl1GhZiU58/2mMrKmGnxS+evmZGGVhzNgumwCbErMfvuGnLt2a0aVsHV9nadyNwa/fg6Hn1jKWnMr35L8c5f8QuKSvMeb7kqxrESUamvClCM76LbWENx8DXUmpwIEyTStRtnDDpOCHX3InXUJ0zLertBX5/x+2AoPeoeMA86NgdOHzxMO2yo2+pyuCKtI2fKAkAuq/pXBjvnGuSqy4eYqy5bjifT4VpTEGOSlNruCoopePqkdSa9l9PQkz+3CaPg7NwRjIcDiNS7W2//WGQeN0Aa7dOFZMs2hx5XWL0MZIe0mVopYZmWWFn0Pt+tF76Arq8ERcOpHRSrzox4W7ynH3+C6aqPxl8vWSj4MrSLf2mxhS/oxDnT6XH0UEBd5rtpbJu8t2brzuwW4TG0eYYjGfH1oQ/k387tqJxmTxAqpajMqmB0mnnqo8eTk3EPgu7VjKCIv1BBg6eYGazXOUSzbqiXyQsSLuzcyW5n+ZqD7mMvMJlm+H7aGAA00T9upzPFyJ7YO2MMxvamjiuGlbRzlB6oU9N5Z+DodMjdDCBVYo0ut/XNKHoPYvEB7QwjPmetdG0Q3bkpdJeUe2pOuKDdYfkHaLR7hR14M07qaS7g==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac4c180-3c19-4c07-193f-08d86073bb93
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 10:22:25.9709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rl4gBAV1V1lUSQeZ/e/STuDIqFxnq4DYEUQOTiHiQQo2bOsvGVUtaXYO7Nlz4O8qCLUFPLGwWNlXG49exvappA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2501
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sysfs_update_group brings below calltrace problem with kernel 3.10
on RHEL7.9. The cause is the bug of sysfs_update_group on kernel 3.10,
which always fail on one named group, as next calling internal_create_group
will try to create one new sysfs dir unconditionally, so system
complains one duplicate creation.

The patch is to merge the sysfs setup together by calling sysfs_create_group
once, though the nodes would vary on top of different configurations.

[    6.531591] WARNING: CPU: 52 PID: 638 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x64/0x80
[    6.531592] sysfs: cannot create duplicate filename '/devices/pci0000:20/0000:20:03.1/0000:21:00.0/0000:22:00.0/0000:23:00.0/ras'
[    6.531593] Modules linked in: amdgpu(OE+) amd_iommu_v2 amd_sched(OE) amdttm(OE) amdkcl(OE) drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ahci drm libahci igb libata crct10dif_pclmul crct10dif_common crc32c_intel ptp nvme atlantic pps_core dca drm_panel_orientation_quirks nvme_core i2c_algo_bit sdhci_acpi iosf_mbi sdhci mmc_core dm_mirror dm_region_hash dm_log dm_mod fuse
[    6.531606] CPU: 52 PID: 638 Comm: systemd-udevd Tainted: G           OE  ------------   3.10.0-1152.el7.x86_64 #1
[    6.531609] Hardware name: Gigabyte Technology Co., Ltd. TRX40 AORUS MASTER/TRX40 AORUS MASTER, BIOS F5c 03/05/2020
[    6.531610] Call Trace:
[    6.531615]  [<ffffffff9b18133a>] dump_stack+0x19/0x1b
[    6.531618]  [<ffffffff9aa9b228>] __warn+0xd8/0x100
[    6.531619]  [<ffffffff9aa9b2af>] warn_slowpath_fmt+0x5f/0x80
[    6.531621]  [<ffffffff9acd8e48>] ? kernfs_path+0x48/0x60
[    6.531622]  [<ffffffff9acdbb54>] sysfs_warn_dup+0x64/0x80
[    6.531624]  [<ffffffff9acdc6ba>] internal_create_group+0x23a/0x250
[    6.531625]  [<ffffffff9acdc706>] sysfs_update_group+0x16/0x20
[    6.531660]  [<ffffffffc067fb67>] amdgpu_ras_init+0x1e7/0x240 [amdgpu]
   6.531691]  [<ffffffffc063dc7c>] amdgpu_device_init+0xf9c/0x1cb0 [amdgpu]
[    6.531694]  [<ffffffff9abe5608>] ? kmalloc_order+0x18/0x40
[    6.531698]  [<ffffffff9ac24326>] ? kmalloc_order_trace+0x26/0xa0
[    6.531726]  [<ffffffffc0642b1a>] amdgpu_driver_load_kms+0x5a/0x330 [amdgpu]
[    6.531753]  [<ffffffffc063a832>] amdgpu_pci_probe+0x172/0x280 [amdgpu]
[    6.531757]  [<ffffffff9add653a>] local_pci_probe+0x4a/0xb0
[    6.531760]  [<ffffffff9add7c89>] pci_device_probe+0x109/0x160
[    6.531762]  [<ffffffff9aebb0e5>] driver_probe_device+0xc5/0x3e0
[    6.531764]  [<ffffffff9aebb4e3>] __driver_attach+0x93/0xa0
[    6.531765]  [<ffffffff9aebb450>] ? __device_attach+0x50/0x50
[    6.531766]  [<ffffffff9aeb8c85>] bus_for_each_dev+0x75/0xc0
[    6.531767]  [<ffffffff9aebaa5e>] driver_attach+0x1e/0x20
[    6.531769]  [<ffffffff9aeba500>] bus_add_driver+0x200/0x2d0
[    6.531770]  [<ffffffff9aebbb74>] driver_register+0x64/0xf0
[    6.531771]  [<ffffffff9add74c5>] __pci_register_driver+0xa5/0xc0
[    6.531774]  [<ffffffffc0bd5000>] ? 0xffffffffc0bd4fff
[    6.531806]  [<ffffffffc0bd50a4>] amdgpu_init+0xa4/0xb0 [amdgpu]
[    6.531809]  [<ffffffff9aa0210a>] do_one_initcall+0xba/0x240
[    6.531812]  [<ffffffff9ab1e45a>] load_module+0x271a/0x2bb0
[    6.531815]  [<ffffffff9adb41c0>] ? ddebug_proc_write+0x100/0x100
[    6.531817]  [<ffffffff9ab1e9df>] SyS_init_module+0xef/0x140
[    6.531821]  [<ffffffff9b193f92>] system_call_fastpath+0x25/0x2a
[    6.531822] ---[ end trace e2d035c822a91de6 ]---

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 87 +++++++++----------------
 1 file changed, 31 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e5ea14774c0c..6c57521b21fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1027,58 +1027,6 @@ static ssize_t amdgpu_ras_sysfs_features_read(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "feature mask: 0x%x\n", con->features);
 }
 
-static void amdgpu_ras_sysfs_add_bad_page_node(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct attribute_group group;
-	struct bin_attribute *bin_attrs[] = {
-		&con->badpages_attr,
-		NULL,
-	};
-
-	con->badpages_attr = (struct bin_attribute) {
-		.attr = {
-			.name = "gpu_vram_bad_pages",
-			.mode = S_IRUGO,
-		},
-		.size = 0,
-		.private = NULL,
-		.read = amdgpu_ras_sysfs_badpages_read,
-	};
-
-	group.name = RAS_FS_NAME;
-	group.bin_attrs = bin_attrs;
-
-	sysfs_bin_attr_init(bin_attrs[0]);
-
-	sysfs_update_group(&adev->dev->kobj, &group);
-}
-
-static int amdgpu_ras_sysfs_create_feature_node(struct amdgpu_device *adev)
-{
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-	struct attribute *attrs[] = {
-		&con->features_attr.attr,
-		NULL
-	};
-	struct attribute_group group = {
-		.name = RAS_FS_NAME,
-		.attrs = attrs,
-	};
-
-	con->features_attr = (struct device_attribute) {
-		.attr = {
-			.name = "features",
-			.mode = S_IRUGO,
-		},
-			.show = amdgpu_ras_sysfs_features_read,
-	};
-
-	sysfs_attr_init(attrs[0]);
-
-	return sysfs_create_group(&adev->dev->kobj, &group);
-}
-
 static void amdgpu_ras_sysfs_remove_bad_page_node(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
@@ -1300,13 +1248,40 @@ static void amdgpu_ras_debugfs_remove_all(struct amdgpu_device *adev)
 /* debugfs end */
 
 /* ras fs */
-
+static BIN_ATTR(gpu_vram_bad_pages, S_IRUGO,
+		amdgpu_ras_sysfs_badpages_read, NULL, 0);
+static DEVICE_ATTR(features, S_IRUGO,
+		amdgpu_ras_sysfs_features_read, NULL);
 static int amdgpu_ras_fs_init(struct amdgpu_device *adev)
 {
-	amdgpu_ras_sysfs_create_feature_node(adev);
+	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
+	struct attribute_group group = {
+		.name = RAS_FS_NAME,
+	};
+	struct attribute *attrs[] = {
+		&con->features_attr.attr,
+		NULL
+	};
+	struct bin_attribute *bin_attrs[] = {
+		NULL,
+		NULL,
+	};
 
-	if (amdgpu_bad_page_threshold != 0)
-		amdgpu_ras_sysfs_add_bad_page_node(adev);
+	/* add features entry */
+	con->features_attr = dev_attr_features;
+	group.attrs = attrs;
+	sysfs_attr_init(attrs[0]);
+
+	if (amdgpu_bad_page_threshold != 0) {
+		/* add bad_page_features entry */
+		bin_attr_gpu_vram_bad_pages.private = NULL;
+		con->badpages_attr = bin_attr_gpu_vram_bad_pages;
+		bin_attrs[0] = &con->badpages_attr;
+		group.bin_attrs = bin_attrs;
+		sysfs_bin_attr_init(bin_attrs[0]);
+	}
+
+	sysfs_create_group(&adev->dev->kobj, &group);
 
 	return 0;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
