Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D86C6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 13:27:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E3210EAF2;
	Fri, 23 Sep 2022 13:27:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743B510E990
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 13:27:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SjdHoQtV8n92WFW5ggWIkdVn6IjxCdWgrVN0seIBqPe0hQ7yZ7YZjFSBH9F6TIrmNOHKLenne9TflsFg04rqYO8EYKmxD1651R4w/bxZCKDDw/c2/TtGHbT1xAaQBxMftTi1Q3yYlGp7i13ulj5vaeE6bEjqt8ENEJLUQc1uUwWTGWCbb4OvhbzUiEIGXhy+y1gzbcORALVONFUViu4KpLJsbTczEhgK1lR0cc+Q2h2d7c2fOAYQ5aumdaOlOCb+lckI/wVHLn6BF12CTAa3swKsu2XGx+H2orX6BjKp1WGuuAHBFnH7DULfZ8PwaZx35OGxiP0EJcIMTDzd/UNaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drN4VqvTzjc+ztfdQRIUUFU/bG8PRkw81/wEpEpzdGw=;
 b=UFo7MuzsQx9+Bdjc94XBbY2zM+BLoJY78NWsHG+1ahs6NqnEEiBpQcpnQc63Yy5FKKjvyS0IpLbtacZu/3ewZLja4OvWOBAwBz4C1swJksn7s4uDa0G3BdrW9z9nhhbgpqChQtt16w941fu65SGhaiFjUGmnfWym44deza6SAC1bgM5l6fOr70tpEzPoDj2v0Jn9kRnFuSp6u5IMaNkg+/0fC9AvkCX+p9zcJpNA6+DdThY0Ro9LQz0PLSHcgr23xab4iNWlrUCsP0w5t5r/hWs3Rtgor/vGd1jTaX+S1mXXp9EVd78X5nvGh8gcY3zCLH5iq5Nt1CpxmzgbfkWQ8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drN4VqvTzjc+ztfdQRIUUFU/bG8PRkw81/wEpEpzdGw=;
 b=K8EmRCTaexDF+P15z3kC7uGqjKc+CqePXAKs+BVaGD9Kq8q1COWvxEGZDVRQSx76DVB6KNAJmrFFMrQfVX+WBrRbZVMw+1XSU+VNbc5HOWUyTQFyb2zUW83XFoZ6te0gsAeXteVM75S3wMvlvDKS3kiOE8cnXYSJpC83+FHnW98=
Received: from MW2PR2101CA0005.namprd21.prod.outlook.com (2603:10b6:302:1::18)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Fri, 23 Sep
 2022 13:27:40 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::9a) by MW2PR2101CA0005.outlook.office365.com
 (2603:10b6:302:1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9 via Frontend
 Transport; Fri, 23 Sep 2022 13:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Fri, 23 Sep 2022 13:27:39 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 23 Sep 2022 08:27:38 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove fence_process in count_emitted
Date: Fri, 23 Sep 2022 21:27:24 +0800
Message-ID: <20220923132724.1260802-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|CH2PR12MB4295:EE_
X-MS-Office365-Filtering-Correlation-Id: e443adf5-8b51-43ce-e93f-08da9d676354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: caJcd7NbGufJlShAgT8j6n1dk5IHpk31BwP6iAKV2LYg+bOsXjW6BDMyiZtPfTb94jkVPJvUQSznVFOZxxSARB06W9La/Xh+usZanK7AD1S1CiGwHRx/Py/asQLUJby1cBd8U9cPnsUGO3p5hJsXTKio9MoWCUSJ4raEOgbgmuxzVEIFJm7arIkedG+e8e3jfW1nPu0o2+ynZ1a/oQKLQZJ3m9cd5qalKs0+6odVKMkaIPprGI/sVYpRUSntG9p2svBmBenZjDB07tdq9LjggDdj5s+vXwXm58+IERz2pX3kjH3jJH12Fu59clK3r5EOLDzWiP3w8tSDA1o/EyemdQMpLhxd3W+7k4D9lx8LTKE3EVn9FtrnkURl8Ei/RVYtpxDW2N3RbP952X5BQiYS3siHPg1zbXvE/ZmXzHeWGKkbjIOallSo7bf581nCt1nZd17eRRS9z8AIOldhwtTm3RzG8lSsZxKpmIWoKY9vePqwe0ImrMTsjguLxmBd18mjVDYQX1LheCXFkjTblPsCgpTZlw3LwWKVYyFzhC7d43pzY7fog0SKZW1lPz4JJZdXQAdue5mWPYB9pb87RuARE0jXmgTAvoa/IVVPeS9+aQpVb844wRL3wJe/cOX+VkClPsqQT9C0nk8Hk7/4lj9oqxjIoJJeCazGO6iksQ+PtQoNQO7mNMKB0bl3fK9W0kTLpEOiEOABahfQy7l83st3cLeZZLxVfK1dVf88LL1odi8EfOXlHWDiQ39+D/liILwYgzIsr43yYbZ+rFwbJj4skT8iZjnG4DivVp7zIyW0BG2l13Cw86uz6I+91HZRPkNO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(36840700001)(40470700004)(46966006)(70206006)(316002)(6916009)(2906002)(478600001)(5660300002)(4326008)(4744005)(26005)(41300700001)(6666004)(8676002)(7696005)(36756003)(8936002)(16526019)(2876002)(186003)(83380400001)(70586007)(2616005)(47076005)(40480700001)(336012)(40460700003)(426003)(1076003)(86362001)(82310400005)(36860700001)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 13:27:39.8173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e443adf5-8b51-43ce-e93f-08da9d676354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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
Cc: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

The function amdgpu_fence_count_emitted used in work_hander should not call
amdgpu_fence_process which must be used in irq handler.

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index d16c8c1f72db..790f7bfdc654 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -394,7 +394,6 @@ unsigned amdgpu_fence_count_emitted(struct amdgpu_ring *ring)
 	/* We are not protected by ring lock when reading the last sequence
 	 * but it's ok to report slightly wrong fence count here.
 	 */
-	amdgpu_fence_process(ring);
 	emitted = 0x100000000ull;
 	emitted -= atomic_read(&ring->fence_drv.last_seq);
 	emitted += READ_ONCE(ring->fence_drv.sync_seq);
-- 
2.25.1

