Return-Path: <SRS0=NRDG=IQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93211C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B4A64E38
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Mar 2021 07:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B4A64E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11F36E895;
	Thu, 18 Mar 2021 07:23:53 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760054.outbound.protection.outlook.com [40.107.76.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088C96E88D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Mar 2021 07:23:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4tIhax1F7CkdtAIv1+c/u3pTsVlsL5Kd/dOx2m4/3DG+nRGaxOw35n/nH3JHje9TZ9vmKR6YVn3jlj7k9RVO+VEDDE/pg2ng0shBXFD+WzeTEGtptcxFhWcHktC4ePdMTTctbam4MB0Hwi+mPE2B9O1tTjaqWIYxuBV9pFcObLcCvsCWd6RgPpFtVDVv3l3wh5d4cG2tscA4Ov1WQYdV8ok7wJ8vOpmiypRKQVpWE4rNICNdT2N8kZK2G2PGXlDQOKTjfrcY4OrA/PjGBOauh44OF4KeMhbbJ3l8p1GLllXreFaVOfzMIZwMA9+4aH42YbhDh8WXtv7jKWeN2GDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71mQjHGs8DPr0nHvU59Y7kDGqnLNGa6QQSwNgWs4jHI=;
 b=V7WofFW9Zh5ntHSoGx0N4p2IO/GM8ohmkc1UjzZTnqxYQ+rNTUnsbz5uEC1lQJ5hNIjtSU1Gb1oz4mtoKkcvvB9rPJsNqPiQ4S66FIUiiSZVQqu/Y49DtFgwjnprPy8YMJVLjlUDSbrGItQgqghrr5cK80SrmMwXurQkgGfXWVmnR1v+po1ZG92rlF34SUJQK8IQ5MFKzUJlXoHGQR0Xy8ljQBScEpSj2dp5CU0hXw9kRmBIxj/y4Smu6UZ5KsB0ROehaUgTdrTMrpBBZdUeRSIDNK1f2VX3iAfp0FkKBrLxWwD/WAH5RpbiwZ0Ag7us5ZyqwWifd9AXunJPpXbnQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71mQjHGs8DPr0nHvU59Y7kDGqnLNGa6QQSwNgWs4jHI=;
 b=RZWmc1yBRcvXZAqu8L5IOybAYu/OT66WXVESdC8r66dBcnxTMTzx+G46pg7T+NRHBUGa9Oz2DM83zHpG9yfJFou7nxkobLjwcztoC2zkJ9ZB/kLxM/439EHAflXRyVC/N/tESdDwlLHSaJIKAJ/RXhgN6dBoLg91tViHkjpJL60=
Received: from BN9PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:fa::28)
 by BN6PR12MB1921.namprd12.prod.outlook.com (2603:10b6:404:fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 07:23:50 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fa:cafe::cc) by BN9PR03CA0023.outlook.office365.com
 (2603:10b6:408:fa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 07:23:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 07:23:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 18 Mar
 2021 02:23:49 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2 via Frontend
 Transport; Thu, 18 Mar 2021 02:23:47 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
Date: Thu, 18 Mar 2021 15:23:35 +0800
Message-ID: <20210318072339.28736-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 63a5500c-5a48-4932-630c-08d8e9dec6ff
X-MS-TrafficTypeDiagnostic: BN6PR12MB1921:
X-Microsoft-Antispam-PRVS: <BN6PR12MB192113864A43ED40756233F4ED699@BN6PR12MB1921.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ryMV6akws0phUDJj2UJv5UjrHxPnBsEqe1gYFtm/ijca2cubwilpy0Is7v1Eo/IeMrodp9R3BEScdwdJotFxWXKfIirvS4lKRnf3c356eCVhVKKzgmrFVnD6vQTMSYcwDLlNRfYd9qwNLsdnu0Ip9bH2RU+FVbl6JWDHpxz0wmU1ZbeszRU8ny0IGDsAUz5d6SJULLswJQuJv7U+PUELDaFaO19eQKJ4VNW6MyPxNJxw4RdBnI56l3M1ieEi9U9NXrCFgiprWtwjxSvR8S+1L/Rf+U5w3O0L4AjevE+KCTnOya59/jPinXkT8/8dZb0/0uKqqGRCj20TqL9qdyO9rj9RhrD/xyofySJOuYHYmPtbzYqHI677Nu/qyxKuu7zJIH6OU0QEcBVuo3vfR+GdKVNr/9fRLW1wseEv0yQEo6Zqc0hWO2k9ttiqT63Pz8cNASUEXqgZrjmEtQF9JaR7FtxfeZfoXdy4JjgdTKoxA+ob0ueT6zW2WAGlGQU4/9xZKPIi5JS48JOb91NsfkxdjunSEzRiOm+c68SnpkOph/z8n7s9MHWEuGdkhVkf/WK3g5l2ulvFB5DxOU5C8BMElmIJCUWHPuV6VJwfOj9TWDcrXayG2I8xKtbDeAKgMNUN7inZCCWmhLn/kG5htTzif5W3Q4giL1PVSZuzfuETWFeavtngVawuCFQNOuYEfm6YkkPzsDr17LpLgkXbkNYa8g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36840700001)(46966006)(83380400001)(7696005)(82740400003)(81166007)(70206006)(2616005)(70586007)(2906002)(47076005)(4326008)(356005)(6666004)(36756003)(1076003)(5660300002)(336012)(8676002)(8936002)(426003)(6636002)(478600001)(316002)(26005)(186003)(36860700001)(82310400003)(110136005)(86362001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 07:23:50.2673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a5500c-5a48-4932-630c-08d8e9dec6ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1921
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

We have defined two variables in_gpu_reset and reset_sem in adev object. The atomic type variable in_gpu_reset is used to avoid recovery thread reenter and make lower functions return more earlier when recovery start, but couldn't block recovery thread when it access hardware. The r/w semaphore reset_sem is used to solve these synchronization issues between recovery thread and other threads.

The original solution locked registers' access in lower functions, which will introduce following issues:

1) many lower functions are used in both recovery thread and others. Firstly we must harvest these functions, it is easy to miss someones. Secondly these functions need select which lock (read lock or write lock) will be used, according to the thread it is running in. If the thread context isn't considered, the added lock will easily introduce deadlock. Besides that, in most time, developer easily forget to add locks for new functions.

2) performance drop. More lower functions are more frequently called.

3) easily introduce false positive lockdep complaint, because write lock has big range in recovery thread, but low level functions will hold read lock may be protected by other locks in other threads.

Therefore the new solution will try to add lock protection for ioctls of kfd. Its goal is that there are no threads except for recovery thread or its children (for xgmi) to access hardware when doing GPU reset and resume. So refine recovery thread as the following:

Step 0: atomic_cmpxchg(&adev->in_gpu_reset, 0, 1)
   1). if failed, it means system had a recovery thread running, current thread exit directly;
   2). if success, enter recovery thread;

Step 1: cancel all delay works, stop drm schedule, complete all unreceived fences and so on. It try to stop or pause other threads.

Step 2: call down_write(&adev->reset_sem) to hold write lock, which will block recovery thread until other threads release read locks.

Step 3: normally, there is only recovery threads running to access hardware, it is safe to do gpu reset now.

Step 4: do post gpu reset, such as call all ips' resume functions;

Step 5: atomic set adev->in_gpu_reset as 0, wake up other threads and release write lock. Recovery thread exit normally.

Other threads call the amdgpu_read_lock to synchronize with recovery thread. If it finds that in_gpu_reset is 1, it should release read lock if it has holden one, and then blocks itself to wait for recovery finished event. If thread successfully hold read lock and in_gpu_reset is 0, it continues. It will exit normally or be stopped by recovery thread in step 1.

Dennis Li (4):
  drm/amdgpu: remove reset lock from low level functions
  drm/amdgpu: refine the GPU recovery sequence
  drm/amdgpu: instead of using down/up_read directly
  drm/amdkfd: add reset lock protection for kfd entry functions

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  14 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 173 +++++++++++++-----
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |   8 -
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |   4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |   9 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c         |   5 +-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c         |   5 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 172 ++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |   4 +
 .../amd/amdkfd/kfd_process_queue_manager.c    |  17 ++
 12 files changed, 345 insertions(+), 75 deletions(-)

-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
