Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC44C83F14
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Aug 2023 16:16:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F4E10E3D3;
	Tue, 29 Aug 2023 16:16:38 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5215A10E3D3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Aug 2023 16:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJ2wyerVsnY6B510PzI3/k+qRviNs/M72FZmcR60U1OLMjMod59I/VUNBXkEIucx9BBpmA43NGQAPF+3U88Y99GUgJOMOc0c0Pi6YBajuS+vOCayeod7L4A+d7psXumxjQUnwDoBrmECqFW2ag2wAZcRgAYgzj/bewOF8avyf+/XR4MsIh5bmS+2vZwUlYztZ/er7c/+V0mqvK7UbObV3SzAL4Ip/kaNkvpRV1p86VHWTKhLE8QewjS9G9SxHEF9Vq8spgcXbFWppUuopw9y+eh6oun3XBXK0wPZAqdei4bU4LaCpOerTtFuPJRibWD7ILx0Zt47UQTZmW4ISULBhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tILnFVk+2S4OTT1A7vS8Jj0Z0f81mYI8DjYg7h44JsQ=;
 b=AIx7IvJml3VOmTU/RU7Lb2n+M6oZOuXdk3x2o7yXDJ1eUmJ7Q6Y5E8nTzz7z03nbfRihDehO+R3AIgIxVEnxUYBjOnd1CrV6kcAzDZA+YbTxKCEgkU12etC7tNZZVwgzLz1Xe4OPVnGgjZlvuwhem/M1VxLRcVDOfBB4/QYbDslVnC6nAbEmstPpoL42o2Xu71Eg8CV7E/QXbYA4AAY+T1yrEuI2GdXDajREjZGaoXcik+dUNrL12Fk89U6tdoRgRmvpGBTKsbKGLbOQeTTpNdBA8DbAxFA8+ryhxfaYAE+wiTwScSSwJ1Q8u7LhaiVJevj+iHHtXuHFYEFB8Y+MAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tILnFVk+2S4OTT1A7vS8Jj0Z0f81mYI8DjYg7h44JsQ=;
 b=OrVIQa0CERFs9j03WBnzKRL5WLv/Hm8slRf/qIHhuUk3sAfl1WrTKZRdXD2jI3KanV1kv7Jo6uuiZ6GtnJwRYoGmVCIfWxG27NcWA6shUmAzOLV92DbdhKZY6kDgGg6rrv48Y+oMi93iePqLdNwh+lTVjimvPwecgB7M68r+jZM=
Received: from CY5PR15CA0110.namprd15.prod.outlook.com (2603:10b6:930:7::29)
 by PH7PR12MB7937.namprd12.prod.outlook.com (2603:10b6:510:270::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 16:16:33 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:7:cafe::d3) by CY5PR15CA0110.outlook.office365.com
 (2603:10b6:930:7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.18 via Frontend
 Transport; Tue, 29 Aug 2023 16:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6745.17 via Frontend Transport; Tue, 29 Aug 2023 16:16:33 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 29 Aug
 2023 11:16:32 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix unaligned 64-bit doorbell warning
Date: Tue, 29 Aug 2023 12:16:14 -0400
Message-ID: <20230829161614.93007-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|PH7PR12MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4d2629-04c5-4562-fc07-08dba8ab4fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V8HDf1lOzyzmXYW9kBqIIGh6HaFVI9SLHePrcRGNbfVu8uMuQwWAN34+IrgsaTzN1HxeKou9CUsRj+j1GzxZJOa99ZiufIwwb/hc6w6eJEWeUy5b+qTo2xA73RIPTUAAIwrgrptdkX5SfdyQ9ShFfMLqmLul2Wv704XoTO4SpGcj2II7CdMX2hxZa1n5IsH/tpc7iNNpR+doOu/+RV08Hwz4qwUmmEC1ysgMkOgZ7VQrY+ta28XXuPzlXlaU0iaw3vTWNYmq7clJn/907RRO0P9q9bYu8+uqJDRd3UdXTMmBocdDwH1CvcXFqogDTVVwdpr1uzITX7U7inzleQrpeFVwLCmG4+7v68sukbaVIPCHXTPr/l/jfoat3BzRRZbFpoAFGD1L0zVaLW7+nqcO9pUJoj6bCsxGwcY2mWlDvkWj0xfpyLEYsBj7M5yNSLn6DgXTrJEq/SZs/A31zfRBZi7nBgo2uItrIVvzOph8g9BzMGllUFCpqj8t7T5CBvh3UiUN03dL5EDaXwoyLKe9ZBSp+O4a3tljqoSej0nUfCZ8DbzyB+IWY0m6dx256WQJMjhDHEYuBcd6p0S/3U7U6O86fswRJcS4zbzAGj4jHypyy3G5n2rv7VUHyWqEdJvruP7clyaLTS8q6xR2Mfs3SzYuljf/t9T/u3tmgchCZxXQs9dVjywPdo4I5NXDg+rJGl9Q6Ix3dNfEJVRcLG5he+uJ9mUh3eZbKIzOzFdFLzLNeP3ANm+cijvNeU1YsciAcqy5jyshaODuqAu1qjBfug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(81166007)(356005)(82740400003)(8936002)(6666004)(70206006)(70586007)(478600001)(7696005)(54906003)(6916009)(316002)(41300700001)(40460700003)(26005)(16526019)(36756003)(8676002)(1076003)(44832011)(5660300002)(83380400001)(2906002)(47076005)(86362001)(2616005)(36860700001)(40480700001)(336012)(426003)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 16:16:33.1468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4d2629-04c5-4562-fc07-08dba8ab4fa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch fixes the following unaligned 64-bit doorbell
warning seen when submitting packets on HIQ on GFX v9.4.3
by making the HIQ doorbell 64-bit aligned.
The warning is seen when GPU is loaded in any mode other
than SPX mode.

[  +0.000301] ------------[ cut here ]------------
[  +0.000003] Unaligned 64-bit doorbell
[  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64+0x72/0x80 [amdgpu]
[  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80 [amdgpu]
[  +0.000004] RSP: 0018:ffffc90004287730 EFLAGS: 00010246
[  +0.000005] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[  +0.000003] RDX: 0000000000000001 RSI: ffffffff82837c71 RDI: 00000000ffffffff
[  +0.000003] RBP: ffffc90004287748 R08: 0000000000000003 R09: 0000000000000001
[  +0.000002] R10: 000000000000001a R11: ffff88a034008198 R12: ffffc900013bd004
[  +0.000003] R13: 0000000000000008 R14: ffffc900042877b0 R15: 000000000000007f
[  +0.000003] FS:  00007fa8c7b62000(0000) GS:ffff889f88400000(0000) knlGS:0000000000000000
[  +0.000004] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000003] CR2: 000056111c45aaf0 CR3: 00000001414f2002 CR4: 0000000000770ee0
[  +0.000003] PKRU: 55555554
[  +0.000002] Call Trace:
[  +0.000004]  <TASK>
[  +0.000006]  kq_submit_packet+0x45/0x50 [amdgpu]
[  +0.000524]  pm_send_set_resources+0x7f/0xc0 [amdgpu]
[  +0.000500]  set_sched_resources+0xe4/0x160 [amdgpu]
[  +0.000503]  start_cpsch+0x1c5/0x2a0 [amdgpu]
[  +0.000497]  kgd2kfd_device_init.cold+0x816/0xb42 [amdgpu]
[  +0.000743]  amdgpu_amdkfd_device_init+0x15f/0x1f0 [amdgpu]
[  +0.000602]  amdgpu_device_init.cold+0x1813/0x2176 [amdgpu]
[  +0.000684]  ? pci_bus_read_config_word+0x4a/0x80
[  +0.000012]  ? do_pci_enable_device+0xdc/0x110
[  +0.000008]  amdgpu_driver_load_kms+0x1a/0x110 [amdgpu]
[  +0.000545]  amdgpu_pci_probe+0x197/0x400 [amdgpu]

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index c2e0b79dcc6d..b1c2772c3a8d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -168,7 +168,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 			"     doorbell index    == 0x%x\n",
 		*doorbell_off, inx);
 
-	return kfd->doorbell_kernel_ptr + inx;
+	return kfd->doorbell_kernel_ptr + inx * 2;
 }
 
 void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
@@ -176,6 +176,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
 	unsigned int inx;
 
 	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
+	inx /= 2;
 
 	mutex_lock(&kfd->doorbell_mutex);
 	__clear_bit(inx, kfd->doorbell_bitmap);
-- 
2.35.1

