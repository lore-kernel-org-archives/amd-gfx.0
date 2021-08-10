Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8C7C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 04:43:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CF5560E78
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 04:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5CF5560E78
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC83899AB;
	Tue, 10 Aug 2021 04:43:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88261898F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 04:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMo0662C6zR8wo2+78JPafbhECwhzAlp1jRE/p7ro58dSWayVMfVt5BeBxbK9rhkL+x1eHXmZOM2uRuPukyjd8w+5oukg/XIt3mtewcqQx44k2O0ROFd90Tt8wepVaSZiikttuQpF/5e76b5oc+x5+wLiP7qZ0wvcE1Y5G/3S7YafNZeQRryIcNEidmAsEkPWM5bfURDgATQkYGOf4zuQ6SKIWcXeQdy9KRxgsEipHYhFIWnFG/ZWY4s3nl1vxmmLN3lqQ8FjtosUzWJjHFUVhQSj3D82G65yl/kNoHziymYKk8YGXx9mVa6ANYHMrmWgovK3K6oUcgBgL5fRvl19A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URwJdp5DubuVN2RxcOdUo2uNcI010CjL85dmUHOKBCA=;
 b=P/XE8CmsegLRZqnGuOmkz8K8lovtHPJFZQMg0PnNaGrXIhMalhWnu0QGI+VMBNLvC4bSs0W06ZRHuoSjZP92ZP86Gh+ybJOGTcZEiBWnx2A/P+wI5OSlQB4oSdRD7SDMVQZXwYfLwagXu6KnNRb3hpxvUDgxeYFr+4NV3AHMx8j9T8UzbQ3Tt72jsEfrKHnqI8h4Vs0SATAfEnWE5tutJpU5T2Lo2xzJTe6igkyD7eF7k/pcKwPWsMYyY04JLKqFhlThEIiezkT/+BvTQ37PlX9oSGLEzgXiKJIHrFYT5WyS4EKyuN9Xq7t7WNZMXhTvoq1IcGFOV7HLn4iqlZ4caA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URwJdp5DubuVN2RxcOdUo2uNcI010CjL85dmUHOKBCA=;
 b=s7XujSd1fV4CHn79eqCPiRXgx402jM3oNw9KzLbvrLcZnyluiSomF1OyucHtA93KguDG3m/cUNLW/P7AI01JGj74AGCR8/DttvxEImqc0WlxcFllpySr9ymv0wZ+7S0MyZoon2lmMviXn+hfEa+XtOsjpURusAx1sQ/jmDK46hM=
Received: from DM5PR17CA0066.namprd17.prod.outlook.com (2603:10b6:3:13f::28)
 by MN2PR12MB3760.namprd12.prod.outlook.com (2603:10b6:208:158::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Tue, 10 Aug
 2021 04:43:15 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::a1) by DM5PR17CA0066.outlook.office365.com
 (2603:10b6:3:13f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend
 Transport; Tue, 10 Aug 2021 04:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 04:43:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 23:43:14 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 9 Aug
 2021 23:43:14 -0500
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Mon, 9 Aug 2021 23:43:13 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH] drm/amdkfd: fix random KFDSVMRangeTest.SetGetAttributesTest
 test failure
Date: Tue, 10 Aug 2021 12:43:10 +0800
Message-ID: <20210810044310.3805858-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8bcc04f8-8c80-4e6b-762e-08d95bb95dc2
X-MS-TrafficTypeDiagnostic: MN2PR12MB3760:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37605AC658E1DBC166E5D76FC1F79@MN2PR12MB3760.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h/6I0MquYXifyftpMr5sOQfdZ0oqsfADK4F9nXNDP76U/kxUWCeNsL0zAfaZ5ndF3WYl/ZruGKB8FUd0RiKINgIjr5tEGixroobj6k8DTh+nCm7eLe/BD9xvLqWGg3z0EaeTz9iU4R6F+t0E1tMnCiI2btrzzLCIK2j9pXe1y29mkr3+nitWYMv1wloPDqR+cqDoRLMmzWinClSG8FlkLeEa3CYllD5RBu1MBoHCumw6YEJ7fgBkshvvVqMBpkQQ1WEIXrjkb7Wb990RMP+Te7sBEc46chOHGDlxYYC9tEoYwVrxW+ZHc+b7UfHq7aBie+PlhEcZSMt+uSaVnPn8vm068xSy5MPH8ztFCc3eH1hKR+CPeUxoySMfhhtlrgWpeJ4UasdRqF7maBa2FnbBDhkUhZJLCO0NyJdf72gAIDwMwEB9DoU02RMuU0fQEWsxuo7DLD3EXiaOEvrIvORCFqFJXp00cVJ2VNdFxgd6NSbsQJA864XLBIW/cuIdrZgADFYswVN8lsEhu4zVLu+iUrlKyfXXMwkXpHqY0ba4odJLMVf9SNqJhoIzT9XGfGNbxyBrEgCnkPfX4kgQXgrNb7QW45lNezpcNKyzwlT6ndPPBsxDdp4yjMT1Feu9hoPC5FFeDPC7CqpJ7VcwP6rLNJ4bgSMrNKDAVbpONMdQt3NdjRYPidfprMNBhlEulZx3j7atICFgzWFR16+YLUzCwfnbZmkJxR5dt5eXk/Xn9jSHxAqHjPe1A8+BndvpL8K8+QlMTh8P1eK+oFO2OB3w7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(82310400003)(1076003)(7696005)(36756003)(2906002)(47076005)(8676002)(336012)(8936002)(508600001)(356005)(26005)(36860700001)(186003)(83380400001)(6916009)(316002)(426003)(54906003)(4326008)(2616005)(81166007)(5660300002)(34020700004)(86362001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 04:43:14.8759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bcc04f8-8c80-4e6b-762e-08d95bb95dc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3760
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

KFDSVMRangeTest.SetGetAttributesTest randomly fails in stress test.

Note: Google Test filter = KFDSVMRangeTest.*
[==========] Running 18 tests from 1 test case.
[----------] Global test environment set-up.
[----------] 18 tests from KFDSVMRangeTest
[ RUN      ] KFDSVMRangeTest.BasicSystemMemTest
[       OK ] KFDSVMRangeTest.BasicSystemMemTest (30 ms)
[ RUN      ] KFDSVMRangeTest.SetGetAttributesTest
[          ] Get default atrributes
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:154: Failure
Value of: expectedDefaultResults[i]
  Actual: 4294967295
Expected: outputAttributes[i].value
Which is: 0
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:154: Failure
Value of: expectedDefaultResults[i]
  Actual: 4294967295
Expected: outputAttributes[i].value
Which is: 0
/home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:152: Failure
Value of: expectedDefaultResults[i]
  Actual: 4
Expected: outputAttributes[i].type
Which is: 2
[          ] Setting/Getting atrributes
[  FAILED  ]

the root cause is that svm work queue has not finished when svm_range_get_attr is called, thus
some garbage svm interval tree data make svm_range_get_attr get wrong result. Flush work queue before
iterate svm interval tree.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f811a3a24cd2..192e9401bed5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3072,6 +3072,9 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
 	pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", &p->svms, start,
 		 start + size - 1, nattr);
 
+	/* flush pending deferred work */
+	flush_work(&p->svms.deferred_list_work);
+
 	mmap_read_lock(mm);
 	r = svm_range_is_valid(p, start, size);
 	mmap_read_unlock(mm);
-- 
2.25.1

