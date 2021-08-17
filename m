Return-Path: <SRS0=1/w8=NI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A00C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E3660720
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Aug 2021 09:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56E3660720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C49D6E123;
	Tue, 17 Aug 2021 09:17:51 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1798E6E123
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Aug 2021 09:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIAa96xlsf5GH1W053SRocndllYQTGQODNztJb4K0JiBfTeGMkVEWA4Pgr26B/g4l20Z7NNRWrtBRAQharr1ovA1FIJEglSe1VW1WwGMpYVv6jtbor1+tfDw5iJi/6B16e1KMGmijGAm49yHhbms8+mNDFNEU39BnVE8m1fEzH4jNzqTnKZG2TqpIzxS3IcbG31gDGE1jNLDy98C7ZCJwmzlolZwZyV7KXwf8UP12wIyR3NhWlw/4x5ykg8z9tvjQ0iQDMra+95IQypvMD+hx4YG+4VZFkvLsKsh+V15u6wJc0/gsHUmu1crbK79C6lEiyJgA3qXTiTkONoDoEsRTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwnt2W0t7nVh9s+e8wMUurC8LQWEBqEuPbXV9jByBNQ=;
 b=JES+ji5YDG1ei4t8iYSTNDjiKT7+ef7SiVA0Bqkvt30KxqTs0dVpuh8iRHb4oOmpGX6EixeVvJLfX3PZaIUSsjqPH3gV3ToYIh7yBCKbA3IkUJPGH2rYFayMPCAAg9HX6dYtaWWf4Pzw1/Q3BWJeADzasZ3uLtKd/9mhJG2l6j9Rz7Ncpkp2FyYasBVhKGoQ5D84J96e7eVs98+x5fB/hIN4RIa0sst912ufZxAgJ7HjYkJ1/6LfQaz1IzPJBYPgBb0spOaIf9NnBOh/KJqF6KBoqz9v0l26FsrWDdoCTCNJlJcg3/JFktaYaUgXrK9DzXz3wGF5jKJvDRm/uKNlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwnt2W0t7nVh9s+e8wMUurC8LQWEBqEuPbXV9jByBNQ=;
 b=T9mCi8HHQLzLF9PPmPEnElgEcT+6OtCjBPDXw7Mi60K9RV6pno02Q1EKuI3v1bn7leUWXXr3+W/YLbb6BwZn4RFTUdgtX+x+6QFPzkOuAywLNtKd9G5udm2jk9AB5FxB+QhSnkkF3UOLN16uJnHVLrN94/fjX2zyexjUoTevzKE=
Received: from DM5PR1101CA0013.namprd11.prod.outlook.com (2603:10b6:4:4c::23)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 09:17:48 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::c1) by DM5PR1101CA0013.outlook.office365.com
 (2603:10b6:4:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Tue, 17 Aug 2021 09:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Tue, 17 Aug 2021 09:17:48 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 04:17:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 02:17:47 -0700
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 04:17:46 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: fix KFDSVMRangeTest.PartialUnmapSysMemTest
 fails
Date: Tue, 17 Aug 2021 17:17:40 +0800
Message-ID: <20210817091740.4031348-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817091740.4031348-1-yifan1.zhang@amd.com>
References: <20210817091740.4031348-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9f83f81-355d-4f67-62f9-08d9615fe1c1
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1549AE977E0ED93501B1E5CDC1FE9@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:398;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uamybNlUhG2LS03B8s9nJbX1DmUzOx0lij8ubNsL+j3S4fl7eq8zxWtTLr/amiUknub1icXxPcEkeQ0kEeeUuXOnPvO7A277Xptmrt7oQkeABNyHXSs9rOcd5vxHq+3SpAgwSnwiQdZri1QrHoFgATzOEDFFXkEA4vdynW3QzvmSOUVzcpowz3uh/n9WOr7nwaUgE2+itl7kKUTbAnxSqXyxgEW9/8hyHkfwo5S3sf7DFn+HufbT13hia5WG+hN5n9i4cdKIrTd3H2mynYAUxzjt93/0NNXNrLYZEatr0KNy0Tv3rh3/gIXMb/PVomEpUuwpviXwRFWHo7HEQlx8T/rXYJHNq3rDDXwd8UMAbenZN5I3Tyz1J7hXMYaIkmzApO4uJ9JqC2mPs1ICtdtQn+VYzNQP/XJvMqb8e+KKNdKwemn+HQnW//qf8jOCWpL7F917AvdbeDuoia8urQp9/tA3E9uI4xbfWBEp0vjjy+F8XJUQq6Zfwil0y8BTt69wGR6b6LOFYYQNSqCtGsp0tMiDKheOv9YWwK8FFdz+zuhCQLmtvGD0mLwUtKbHvlO1Ccis5lJyRDVFlNw2N3wfmtJhu7TSXwmVy593wUBGZ/BdcVgqFLr53qBXezYLEkZTooVmkqBqwoPBbcEbaVwy24qS0BG5NsiZKZzdB3dZbnRvIUy+cO+QNeLyKxPlVo7rsk6WX2FzUx3oFxYCe4g6XfIa1GRmTh4BQq/tHJke347ip54u5sT3X89/5dgVDoyNcSmBPnB7PmuszLFxrrSCWeKSz8czxh9fEr9Y0TCZjOM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(36840700001)(46966006)(7696005)(36756003)(2616005)(6916009)(82740400003)(8676002)(186003)(26005)(47076005)(4326008)(426003)(336012)(2906002)(8936002)(70586007)(70206006)(34020700004)(81166007)(54906003)(36860700001)(82310400003)(478600001)(356005)(86362001)(316002)(6666004)(83380400001)(1076003)(5660300002)(213903007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2021 09:17:48.5901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f83f81-355d-4f67-62f9-08d9615fe1c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
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
index 3177c4a0e753..e1c4abb98b35 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1261,6 +1261,10 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		return -EINVAL;
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+	/* Flush pending deferred work to avoid racing with deferred actions
+	 * from previous memory map changes (e.g. munmap).
+	 */
+	svm_range_list_lock_and_flush_work(svms, current->mm);
 	mutex_lock(&svms->lock);
 	if (interval_tree_iter_first(&svms->objects,
 				     args->va_addr >> PAGE_SHIFT,
@@ -1271,6 +1275,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 		return -EADDRINUSE;
 	}
 	mutex_unlock(&svms->lock);
+	mmap_write_unlock(current->mm);
 #endif
 	dev = kfd_device_by_id(args->gpu_id);
 	if (!dev)
-- 
2.25.1

