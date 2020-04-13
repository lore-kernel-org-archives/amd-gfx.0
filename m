Return-Path: <SRS0=ysjs=55=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80507C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3FC20731
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2020 18:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nvxti2zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3FC20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B569C6E10B;
	Mon, 13 Apr 2020 18:20:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E33246E10B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2020 18:20:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBKrDftWqldIKv3XLdCwq4cJkgos2/QfCPb0FpDqgaYUPTFI24Z6CVRzpVycXmOFcJP/Kpivl0TmejtpSRH7ZW3gQ7EmjfdTv6lKdME3cMqSBT5Jb7aQ/XcXlj1owtpeTjnYphsvMT9GUGlIupnYRVnUVlQdKLDJAYq2ekFeCwPdHDh+7IT1QxL04YweHkbsgSeYnpD4wV1aMFQPsa57tWXloxqhfhIV8h9UCwUYnVeRN5an2GzQksvqb9zTRrqjBTP2oEdKGOqfvx08QYtlzqs2ZJ9npqMBcir24360RgWOW6wD1joX/bQ5T6uHEgsCdxpMBBfU6aWCDJt04bJQ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jLHV44oYiN/rqnyK6L9K2w8RP+FiJ8LU4giPQ9fWJQ=;
 b=keMqwRAeB3BZFCR2Ep9GYM39JNBMAJza7XVti/2QVdnyaRjNg9DVm7VFzbPQ6QA42NZvrws9AnLos61hiu+AfWv7H1fn5e/Cbk0NrhpFpw/xDgPl4C5PdZfEddDhORixlOjUXZlMZ6BTuav4tdseIFsHOgZ5Fe1/6NpgIphxZCBA3kAfaNTeVrXOfQrMCmZylSFSnBF7DQ6C7YldHvlI1dY4pWuOM2NCNlKFl+qL6QoYjGgkeHFWmpzlufQtCl89llWnCWzS+Sv43xgfwauWY4vJlqvckHVcqk47gP0jJXAaVhmpsW1455LEa0fp0hHrnEPRh3JChghKkMIt/uTA+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jLHV44oYiN/rqnyK6L9K2w8RP+FiJ8LU4giPQ9fWJQ=;
 b=nvxti2zSOnNKrPfaWu6PVwhifCGBUIgeoF2zvQurc4MSvsy3gZ5QY6MkM7GZ0s1bU08YWeyusFAUx/QPraDpKyIoekEwpN+hZ/pzHX2r43MZ7rhQsN0DcOuIXiVSsAOekpX1PdLh5yhnQ9H6wsNSy+NFQtegl/lM0Tki+Y+YAW0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4042.namprd12.prod.outlook.com (2603:10b6:5:215::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Mon, 13 Apr
 2020 18:20:35 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::f8bd:4765:eb5b:a7a5%2]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 18:20:35 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Date: Mon, 13 Apr 2020 14:20:26 -0400
Message-Id: <20200413182026.2561-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::20) To DM6PR12MB3721.namprd12.prod.outlook.com
 (2603:10b6:5:1c2::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from krussell.amd.com (165.204.55.251) by
 YTOPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend
 Transport; Mon, 13 Apr 2020 18:20:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 433712e3-9801-4578-920e-08d7dfd75c38
X-MS-TrafficTypeDiagnostic: DM6PR12MB4042:|DM6PR12MB4042:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4042BCE31F70BC60202CD39A85DD0@DM6PR12MB4042.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(66556008)(66946007)(66476007)(44832011)(5660300002)(1076003)(6916009)(186003)(16526019)(956004)(2616005)(52116002)(7696005)(26005)(6666004)(2906002)(316002)(4326008)(86362001)(6486002)(478600001)(36756003)(81156014)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pYmKjyBio5c5Dyn7MmByfd7GV0eS/++4ORZyTOxxqeQHV8ZXyf4rYDJZYWLt9RGZ1h/mJYl9sCwyMBhHHbxzH96thNWp225pWE9ZFJssHZAqiJ5DEAx4uZCrUo8xLPFrJU1gO/BziUKluEBoyLwjPF+RJR1MEXxbYKZaYp5nQfGBwDYWNM/FrmKO+Lan66FumqUh96IqdY0BWcoJcvt7BezuDI5o1RGWZSiYj8at67Pl4WEtdS8CNNcRnIE8Up4azfbfWqgYIftNeW/BgzmZYj24+e+vqPXUUW14Vf6P+GbUPkzgFpIsYRQBzwq88iXBKmze9TOAfd2UGoXfbh4tv3/0G7IsBNwe8+KFVxD1OhJAXO3C+bLUGdKxRpzZmy/iCGQxCqz/QDEHrLj156ufgmuFBRtMVfygTFLRti2l+wazAjqlPQy9BTSs0Fgq1as
X-MS-Exchange-AntiSpam-MessageData: BdMt1yEhgduMOrCnLw07FvbL86v09ERwAGWh8ytWyCQHz/vlIssRct7AjsBWfS7Yw0kmKTeqrGd3xOowjZMmKqPx53iVPBcaSdzOd9+ner1mSKdDP1UqHmrfvlEszqya5i8DR7zlC/UwMBaDejstug==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 433712e3-9801-4578-920e-08d7dfd75c38
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 18:20:35.6477 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teL2jZ2yrUbQNBnU80Qh1OfNA72V1vNW3vXnhTtomnhL1Pzp9x9M8iRmp/WonVnDj4jxjyztrhBwVIl8mEXOAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4042
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
The original patch causes a RAS event and subsequent kernel hard-hang
when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
Arcturus

dmesg output at hang time:
[drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
amdgpu 0000:67:00.0: GPU reset begin!
Evicting PASID 0x8000 queues
Started evicting pasid 0x8000
qcm fence wait loop timeout expired
The cp might be in an unrecoverable state due to an unsuccessful queues preemption
Failed to evict process queues
Failed to suspend process 0x8000
Finished evicting pasid 0x8000
Started restoring pasid 0x8000
Finished restoring pasid 0x8000
[drm] UVD VCPU state may lost due to RAS ERREVENT_ATHUB_INTERRUPT
amdgpu: [powerplay] Failed to send message 0x26, response 0x0
amdgpu: [powerplay] Failed to set soft min gfxclk !
amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
amdgpu: [powerplay] Failed to send message 0x7, response 0x0
amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu features!
amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu features!
amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
[drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP block <powerplay> failed -5

Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index cf5d6e585634..a3f997f84020 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 	uint32_t hi = ~0;
 	uint64_t last;
 
-
-#ifdef CONFIG_64BIT
-	last = min(pos + size, adev->gmc.visible_vram_size);
-	if (last > pos) {
-		void __iomem *addr = adev->mman.aper_base_kaddr + pos;
-		size_t count = last - pos;
-
-		if (write) {
-			memcpy_toio(addr, buf, count);
-			mb();
-			amdgpu_asic_flush_hdp(adev, NULL);
-		} else {
-			amdgpu_asic_invalidate_hdp(adev, NULL);
-			mb();
-			memcpy_fromio(buf, addr, count);
-		}
-
-		if (count == size)
-			return;
-
-		pos += count;
-		buf += count / 4;
-		size -= count;
-	}
-#endif
-
 	spin_lock_irqsave(&adev->mmio_idx_lock, flags);
 	for (last = pos + size; pos < last; pos += 4) {
 		uint32_t tmp = pos >> 31;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
