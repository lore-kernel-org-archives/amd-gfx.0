Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3951EE14A0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 15:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 693EE10E69A;
	Wed,  6 Sep 2023 15:39:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E15910E69A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 15:39:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOU+XowwWHodlUl2/2XXGamZHsIvM7iZhTcmVJ1GUF//gF91MpH17UZxIXrf5e6wz3cOmbR48VQkG6A8ypLVUHxdV+F7nMc1OzxxApmeF0fQDRRc+e7FY99KZL7HcENLp0T4eZmXUMgAuOOeCyJREUz4bHmFHE3waoZB5AOMASxZS26XBkgH26/URwufTN8Vr8aftsALL8DYFwQW7yYMPzm8X3bnoUNbyKkDjZs5hp+4Mi3WfAELXJ9z/YZa0ETFMJHVHJnkUn/85NM69jVCLsdN9QEV0PEjzsPv5WwiyByUbReoKINEXYfi7+hg/SgP79Ws478mWWQeaa5NJ10avA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zr9PjeMRgwFAiOjvmmPlZiI2BG/xNPdvViJ9/C2welQ=;
 b=YkOyk3JyxxqJewL+QnmxOiyTi1OInvFJqizh2yB0BFyHA6dbObeDpQjNKhIVQflrFBkf80ddlqLQ98hTmYxUZEVS9hSPsHFGirvWjM6nnYeZlrNlBeK5r9T2tbVSuvwXD+vzIm0dIXSaEnNocSkfk/sqUAtqb7tsh/U1RL8xQuPJdRVzKoFcvQjJJRStUU4+UDazrIn5mUgCYGzjhvq0AqRHafXuJYoYNy7d1ROxu7VuInT9Q3UVBpUk/0F8aiadDHv7FS3bMd9ZEYXdYAQXb1bsK2WImax/2YrOpdwyhnyGmDOtXWjNZNrahvoMc8YivGQBF9BErOI3GY5N24YXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zr9PjeMRgwFAiOjvmmPlZiI2BG/xNPdvViJ9/C2welQ=;
 b=gV8QVAPItfYVyevdbex8MiT0pC41SZyO/OD8k+l2Ex3ep2vUR2n1G8D+5mceGu5JIVVeV8EKSMgLqY0VeOAQ1Sf5PQtjuefEl2kXiN4A/0ftJfsHJ4MOL/aZz/a0nEeVAokG4SiN5uA5Fz6MZ0bQOwdA53ooNrehLAd8+KVhxjI=
Received: from CY8PR11CA0035.namprd11.prod.outlook.com (2603:10b6:930:4a::21)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:39:25 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::a2) by CY8PR11CA0035.outlook.office365.com
 (2603:10b6:930:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 15:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:39:25 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 10:39:24 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv3] drm/amdkfd: Fix unaligned 64-bit doorbell warning
Date: Wed, 6 Sep 2023 11:39:07 -0400
Message-ID: <20230906153907.216159-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|BN9PR12MB5051:EE_
X-MS-Office365-Filtering-Correlation-Id: f01de84e-597f-44ba-462a-08dbaeef7305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8Bh34VROl09lRuxbFcDSU11snECv05liV9qCBOBfWXhy/WDiRyBjBBKvklQijDJkJxQy27JyX1FZlGHnqRZx6bXy7azRsX6VfKM3hxymw2fxYvlL3W9iDC6prt+miR+/cy1fvOUnsOPXDwzD2AEQOxavYZjfXmLss12VxRmpns6U5vlmK/s629PkwGvndpRnHBsw0IxxBU9KBK+430MZ0uPgeDi17Htv23brmrf+FJOyGEC6LzeVMYeXPJR/L/0PqO0oe13+Xk+ot1CgYerXHNq7AtSECeZnh83d56+xVG46WTAcf/ej+Mp8tLNMqWyZk2g47J4aFJaWUFGhaKlVGnT3nl7bS1RraSaisb0VGf/oHd2OaigUAGqPyNjjwXtW56m0iP19/wul7S9jRKebSNW19jkOtIIWw+ILf6nayPXifxW+pYhk1EbRUyIqEYV7iRYgyFbZlvWeGyICtGOtT+YlpkwSJ8l3N33LLi7Ywh1+8tVH2hefwDt4oFeZWbCrbyoRQ5wXgpFNQXewDge6DhR2+jXjsPbpErEJW1F1nFWT5BfaLcnSxoxJm6cokljZf4hUtSx+70qEBH3nGuoaOFs8lYsmaGpAb7PRsaWtIX4+YaxUlG6FwNzJnnUCQ6lTe4DT64lknuKsXAjYg4B6j3RxA3eBuUafneprA6vf+upiaoBQpyzRvDSOGO7S4b82zQFVR5oimjucmblPLU31ty5A95CWnWz6JR+ZYmA8nxV6e+Xv/d/4uSUbAgGf8QzLyJnCIIsrSjF5e+6UPJOEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(186009)(1800799009)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(81166007)(2906002)(40460700003)(83380400001)(40480700001)(54906003)(70206006)(36756003)(70586007)(8676002)(41300700001)(316002)(6916009)(4326008)(5660300002)(8936002)(44832011)(2616005)(426003)(1076003)(86362001)(478600001)(336012)(26005)(7696005)(16526019)(82740400003)(6666004)(36860700001)(356005)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:39:25.2261 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f01de84e-597f-44ba-462a-08dbaeef7305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
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
[  +0.000030] WARNING: /amdkfd/kfd_doorbell.c:339 write_kernel_doorbell64+0x72/0x80
[  +0.000003] RIP: 0010:write_kernel_doorbell64+0x72/0x80
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

Fixes: cfeaeb3c0ce7 ("drm/amdgpu: use doorbell mgr for kfd kernel doorbells")
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Update the logic to make it work with both 32 bit
  64 bit doorbells.
- Add the Fixed tag
v2->v3:
- Revert to the original change to align it with whats done in
  amdgpu_doorbell_index_on_bar.

 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index c2e0b79dcc6d..7b38537c7c99 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -162,6 +162,7 @@ void __iomem *kfd_get_kernel_doorbell(struct kfd_dev *kfd,
 		return NULL;
 
 	*doorbell_off = amdgpu_doorbell_index_on_bar(kfd->adev, kfd->doorbells, inx);
+	inx *= 2;
 
 	pr_debug("Get kernel queue doorbell\n"
 			"     doorbell offset   == 0x%08X\n"
@@ -176,6 +177,7 @@ void kfd_release_kernel_doorbell(struct kfd_dev *kfd, u32 __iomem *db_addr)
 	unsigned int inx;
 
 	inx = (unsigned int)(db_addr - kfd->doorbell_kernel_ptr);
+	inx /= 2;
 
 	mutex_lock(&kfd->doorbell_mutex);
 	__clear_bit(inx, kfd->doorbell_bitmap);
-- 
2.35.1

