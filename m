Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD3AC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E366460FD8
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E366460FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51D5389C03;
	Tue, 17 Aug 2021 09:50:16 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7CE789C03
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 09:50:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFHTc++ZMv+fHoCltFgXC5oGAdvBneYF4Zp0U67vodT7B98EXX4FCML2ljhwevIu8rAPjLFRYYxbAVACnZ5gP6igH93riWctUz9bSO1L6jbpzr5U+9C1QsCuqlBt4Jfw9KeX88WVlVC4s5Mpncs5MedM39Zhs/hpM8T0NU2J1NcSgRAwJcryRVUVfTmBsjBgXCBL10AEIH8e8wbUPWRvMEl/VMlzJRqosui7/KytHleK1M725e0fipLSRgF0EbAiFet1ItMmSNzndWj5KEYujvkueV/AxDQIwm6qOH0+oLLLFfxtrtTvyfHAUR3plnqevxz0XdwFHjCKags5mlAHzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8m8XpIrFn7apnueX4r4lzDnHLvTgN3fSBjkXLHcKOk=;
 b=FiVaERLWdxbwJ901u2uVRpXmaJL8RLbNdaiiL5du1Qa0MKpj2o87Krna+bbXCbpaxPON7eBv92sSMN8uAQZxTCoWSmf8BA2hZfNU7K40NnWsZ2DMVfn9mbLMc2XWPyC48/GM+DS3QVtlEeX6w6H0XV9qsC79lze4I+DMHVQsqQoRhpTE/aAIsIYHzFYYGP0SQfhdVFdkWtUfhN4Zn3kx0QeGnvKbDZ8MGtgOdqTLn8OXVJmnE7X0zKGr+4fuxVl8zb0Zj1ZU6nAJYiMSKWBkD1iFIbBG3OZTMXtE+1fnZm1ytYEDhiIB/vDfmoqNeAJCeMRlejji9UeqYGlo9sdn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8m8XpIrFn7apnueX4r4lzDnHLvTgN3fSBjkXLHcKOk=;
 b=zT0my9hONg1b/OYt9jL+ZEv9VcbcfZ0NXrOXMxFS8vF14lOu80zcFjYnlg4gt/+xl8BoyXR/Kiz8rL8l+MNshyXKy/1gChzQx/3HwXglRZy7xeLJLmxTeEqlVk+fPjdjVjPkCgCXAKD8255diJYaC4u8vs9+MKdDkb/SucMvFYU=
Received: from DM3PR12CA0088.namprd12.prod.outlook.com (2603:10b6:0:57::32) by
 MN2PR12MB3008.namprd12.prod.outlook.com (2603:10b6:208:c8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14; Tue, 17 Aug 2021 09:50:12 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::36) by DM3PR12CA0088.outlook.office365.com
 (2603:10b6:0:57::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Tue, 17 Aug 2021 09:50:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 09:50:12 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 04:50:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 02:50:11 -0700
Received: from yubiwang-dev-linux.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Tue, 17 Aug 2021 04:50:08 -0500
From: YuBiao Wang <YuBiao.Wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Evan Quan
 <Evan.Quan@amd.com>, <horace.chen@amd.com>, Tuikov Luben
 <Luben.Tuikov@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Deucher Alexander <Alexander.Deucher@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Monk
 Liu" <Monk.Liu@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Kevin Wang
 <Kevin1.Wang@amd.com>, YuBiao Wang <YuBiao.Wang@amd.com>
Subject: [PATCH] drm/amd/amdgpu:flush ttm delayed work before cancel_sync
Date: Tue, 17 Aug 2021 17:50:05 +0800
Message-ID: <20210817095005.8536-1-YuBiao.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e61cc21b-8ade-4196-b921-08d96164686e
X-MS-TrafficTypeDiagnostic: MN2PR12MB3008:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3008E593F094C8CF519F5099E5FE9@MN2PR12MB3008.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nkjoWTHjhttD5POhcxFUIwhP0EtBXTpYoMbrI54k3vCMlCie2KYcS3tbZ0FzFB5bMksi3dj8SxdUMxZHK5NBQICMxefmEiU1ITBTl99Lv88G0hoXap/EF4+alE7kcyGRAolaBdleTNmies0P2la0YFbxIdEAXQjjo1VSRcRdqY0+yX0C3P7qfpu0CudY9U4fBNV0OZNlWhxEczqxhYsWtNY7jjG56+7yITwO+R0MXE7Jo/b7/yHcbqv5GSak6FVMGuxWmHbUGc1gkhKnrkwjwOtCJUHWDsj2ZrMhO0cDRxl0BjZyc1K5dDjLHnjhIsYVRxP3k040ggrBuKFbLx01moDR+6U3FoGA83suec6SyL24nGN4BabqvqVvgTuH0LgX/uhEeIAYDk9Yg8GnUYbtzJr4tgtJpbTtCeB7tIw6gmbU5X+nifH/7r5+KbX9cTzUM7UE5CHOfgFDned/rfecz9DRgmG8oliXYdrvyTFUoQdJYB9DJNKg/PlQVGOk25qd9eLMvTHAngEgW+pISJ+wEHu7iaNcLVrsZqzHdG3lUXApn9MzQ9Rc7x3rSfm5WaBPJvXUWVpg0lqCez/j5qb9/2trHsHNWNBYD5z1kjSDyJhtCeC+dS7Q3gbCN9KHxcao3iFQWGhFRLWPWQiLpEYimAV6i1YxK+4E2Fey4MTwQslcv2oLq/oUtyZenDcyKv4TE+VMioexylXvwkDicwzAWYZ3MZQxkf75uk0IZT0apSIbCBwlmnF1p4F/vFyc187PGVdjrVmQNJQR+h4y68pDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(316002)(86362001)(83380400001)(1076003)(36756003)(4326008)(5660300002)(7696005)(8936002)(6666004)(54906003)(36860700001)(8676002)(356005)(81166007)(2906002)(2616005)(82310400003)(336012)(26005)(6916009)(426003)(47076005)(70586007)(186003)(70206006)(34020700004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 09:50:12.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61cc21b-8ade-4196-b921-08d96164686e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3008
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

[Why]
In some cases when we unload driver, warning call trace
will show up in vram_mgr_fini which claims that LRU is not empty, caused
by the ttm bo inside delay deleted queue.

[How]
We should flush delayed work to make sure the delay deleting is done.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 4d266c40382c..0b5764aa98a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3824,8 +3824,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
 	dev_info(adev->dev, "amdgpu: finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
-	if (adev->mman.initialized)
+	if (adev->mman.initialized) {
+		flush_delayed_work(&adev->mman.bdev.wq);
 		ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
+	}
 	adev->shutdown = true;
 
 	/* make sure IB test finished before entering exclusive mode
-- 
2.25.1

