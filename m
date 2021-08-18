Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B48C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 03:12:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E48160EFE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 03:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5E48160EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F836E323;
	Wed, 18 Aug 2021 03:12:27 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2053.outbound.protection.outlook.com [40.107.212.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDC56E323
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 03:12:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjoGfaPM+1be9kII2QYk+s20E9Q95FWbWhQ97sKRYxnFkWLvYSkyd1I/WUepS+2mn/QhBipkkD0VZFvRT6UyEXsVVWehe6Ntc7XGn+zjEy3Dm4FDeOKXdORWI0rrOkTfxjoVXgjVNRCQ6bhuqjEge9MMaDHZdzcpifDvCDsU9aoCb6b0hvY5DP7VedtFJuHR1SSpAg4A9taJysfcDCz1ByjSVh7VpXJ7yHpLCZuAHwrSZnwfDdBVxTlIM9D0iTqVBVytB7USo4rj7GCFlSjH21PCT6U1sBxIHCY7K8OMTXt9G3uQuSZJftSJlPo9bHBCfb0J1XrRGvSAFoIFgK7ZfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF6EqmbNEdKBPU/0nkRorVM6ZUEUdAqGA7F2eUqi9Q4=;
 b=aYG5UxihsFGnF8P+WZjNtR0jZSX6o4v14j+RZU29Gi0rO5pBTSL8VzTzujfEfsF7OUCZQHGJqu7RulQ2Bmth2fg7Qdxfa4Wb9jSvymZSpof6mVtcNDkcMAbxhx84JK3sJMFy7hTtPnpY11m7l+rr3xyQW++jcnMm4SiGJ1INNiY2tUZYdAT/iG/vlWk+IkrzHnDBhIrSQ64GSI6JoHlZtdN+aXxruJMjD3cVnVA91Ji5Xr7d9L2OADu6+no7+QLiOis74CeO5fuy4CXr4VoKXyktCTOPK41u5G9fepC89kjDNhA+WaSbqSmqUTGSv/jcvTwfwzHA/B8SCk3aLhF2qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KF6EqmbNEdKBPU/0nkRorVM6ZUEUdAqGA7F2eUqi9Q4=;
 b=crB3HTop7NTdhITM6ciJEk6+9ihMkjT17SxevMHOvqyttgVDrDtwLfX3h6v/d3WWGQBpq9ruozNLXnHZFfn0L6z4SoNG/e9yzzoGi/KBL2uHA5JCSjWaAdmvhWYQcrdEdpg3q8meotuqZNc/EkPkLvjAz6g2WsjXSY6UBzyf9bs=
Received: from MWHPR1201CA0007.namprd12.prod.outlook.com
 (2603:10b6:301:4a::17) by CH2PR12MB4859.namprd12.prod.outlook.com
 (2603:10b6:610:62::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 18 Aug
 2021 03:12:24 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:4a:cafe::d4) by MWHPR1201CA0007.outlook.office365.com
 (2603:10b6:301:4a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 03:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 18 Aug 2021 03:12:24 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 22:12:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 20:12:23 -0700
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 22:12:22 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: fix KFDSVMRangeTest.PartialUnmapSysMemTest
 fails
Date: Wed, 18 Aug 2021 11:12:02 +0800
Message-ID: <20210818031202.7025-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818031202.7025-1-yifan1.zhang@amd.com>
References: <20210818031202.7025-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f112fbe4-23c4-4e89-d953-08d961f60045
X-MS-TrafficTypeDiagnostic: CH2PR12MB4859:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4859F048DB58DB35037548F7C1FF9@CH2PR12MB4859.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VP1h5OhxOQIuwYA9AFuXzdZJmDPZSOQMtFJuKwMoebZmdxk+7rBQzMtEK7jBBXmOz1fdhgZr9UZLVlcC6hQFW6KzdqcE0XTFqOL70xy7qhBggaLOzU+h3c4InDTVLvyuBvKKQMdFXJZVACRQ4VcaTlU+RRc1BUMWPVwTe4Dfcfr7cUFRJAeQKjaCWcJlmdB0T/v8wKUarkP4dycyh6U0EiA+TnvsKiJ8XRXH+v9Q4/D8np0+qOsjzQiF3Doy7RthGnK5KENaxlKjWhdS+uLCke2mBGI+1+zbmVjZVWbt3excTFd0goWn+FmdfwNFY5EYyjItx6PsMW0KzBL7R8kQue9vxYlsBk1cixVXxBqIZnMBNZZjBPHBfTAv+z77qty2y0v7aRoYjyABt7FaWsC2jeepfNQgWA60VID9np0zmYPu/aecXiE3HlbWn8Qppj6qsIuktrtL5fXK/rIN7aDMdzK9NMf3BF3vsCRhPUcMpkjr/zSvonUFVZGLznfMMne0RhN7EnklKii8+Q97G2lLRWBOiZfNJGADNI4ZxysegbWAALTwGHI1ZPBP9372tu27NXilyEGCCgpwCibCz76iB+tFT4TKDcli09yX4o3QhDHXRXkB6B9/oHZqg6KJtAjAza5w1s4BEUQsQn/WF45UJWDLeoqEMflwtFZu766x8N30ERqdT4CidbWLAnoJgOyLYqqnsCfEUqw1s5eT1b24gHYbbIEOrhN8MBYEGgZppa65PmMyabk1cdt1P0ySd2L3X6XGnlHKZIw3h4go4SJp5+3qvfvCyPP+WhPxEBjIOcs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(54906003)(508600001)(70206006)(70586007)(36860700001)(6916009)(316002)(8676002)(1076003)(4326008)(5660300002)(8936002)(186003)(6666004)(83380400001)(82310400003)(81166007)(356005)(336012)(86362001)(7696005)(426003)(2906002)(36756003)(26005)(34020700004)(2616005)(213903007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 03:12:24.2403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f112fbe4-23c4-4e89-d953-08d961f60045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4859
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

[ RUN      ] KFDSVMRangeTest.PartialUnmapSysMemTest
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:245: Failure
Value of: (hsaKmtAllocMemory(m_Node, m_Size, m_Flags, &m_pBuf))
  Actual: 1
Expected: HSAKMT_STATUS_SUCCESS
Which is: 0
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:248: Failure
Value of: (hsaKmtMapMemoryToGPUNodes(m_pBuf, m_Size, __null, mapFlags, 1, &m_Node))
  Actual: 1
Expected: HSAKMT_STATUS_SUCCESS
Which is: 0
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDTestUtil.cpp:306: Failure
Expected: ((void *)__null) != (ptr), actual: NULL vs NULL
Segmentation fault (core dumped)
[          ] Profile: Full Test
[          ] HW capabilities: 0x9

kernel log:

[  102.029150]  ret_from_fork+0x22/0x30
[  102.029158] ---[ end trace 15c34e782714f9a3 ]---
[ 3613.603598] amdgpu: Address: 0x7f7149ccc000 already allocated by SVM
[ 3613.610620] show_signal_msg: 27 callbacks suppressed

These is race with deferred actions from previous memory map
changes (e.g. munmap).Flush pending deffered work to avoid such case.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 3177c4a0e753..4de907f3e66a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1261,7 +1261,12 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		return -EINVAL;
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+	/* Flush pending deferred work to avoid racing with deferred actions
+	 * from previous memory map changes (e.g. munmap).
+	 */
+	svm_range_list_lock_and_flush_work(svms, current->mm);
 	mutex_lock(&svms->lock);
+	mmap_write_unlock(current->mm);
 	if (interval_tree_iter_first(&svms->objects,
 				     args->va_addr >> PAGE_SHIFT,
 				     (args->va_addr + args->size - 1) >> PAGE_SHIFT)) {
-- 
2.25.1

