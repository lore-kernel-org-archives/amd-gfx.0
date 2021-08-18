Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7B2C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 03:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A336B60EFE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 03:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A336B60EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 540526E321;
	Wed, 18 Aug 2021 03:12:15 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2088.outbound.protection.outlook.com [40.107.95.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C325C6E321
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 03:12:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqOKfFt6nXLRVc0idRp1aV71XrsHhAE1TYsXz1BwdG5n/YHrXoub0vFdpDIA3YZxgudxtd1qQ11+2+tFJHPz0Gl7N3M6YrDmN60ut2l5KHcc8rnCWTKWYZfNryyFM822mFbcI+TPkzKRdfdOBnCKr+bBuYamtKkopZDxXHme1Jt0oyb+p5qqIZw2JOvnie0T9HN8/3YohEhNLrry4F+zmfI3kj3ul9Snr6Q7HJ+geQ14XfL1FrM+E+nR7GkeshHl2xkoZQShg9Bus496fCBgjbn8FKzMSf0d4p4hMxA4yHEQmK+yEQ+Ds7Jvhor9w91GeEE7WuPysbpI3FW13NVXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgdq59TloBkHK3mF65v/5dqLw1ljpqFmHVkRmGSrENY=;
 b=YHtbbNvDDWdcWMBF1tOXO81SUijYuLXOOU0PCGwEt1Fhaz4daMf48eiCf88SLVugmzvCaghOHlxUArf8mdnbQS1itAQH0uDwnmcPgSsv1KLExGA74Jdk+PDFJU/HI/pHWziDMrp5pnRS+t46atbuHvF5VgXqNXrAn8VNOUbtoDVq4Bxcoayy/faDewxuq6laLH128TbNX3Irb31W+k05xKIqTQvb8QPMQN7fpVkFKpuIR64W0+ZLprBjKfETQjQYoPtp2UCicxDlMA+yixxWHKnWVb+ww+kSYCsuhU0ue/Z2msjMEe4UI8wisARNU+P4f57Z13NMz0bQ9wqKYXk9FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgdq59TloBkHK3mF65v/5dqLw1ljpqFmHVkRmGSrENY=;
 b=I1RIvgtnvH5VyzcQggxJw9uRwzYc1fl0OVP1Iandb0qWfP7ziKgqmWk2J3DwPno/XAT05Ik14zteTi1mdMl/4utO8svPebWu6FlBJhI5U2ou6Jb1+VmnvxMewZw/WICDBodpcynmAjr7JlN4fLZiTMuA9hoZUlKKEg6d2HOByUI=
Received: from DM6PR12CA0014.namprd12.prod.outlook.com (2603:10b6:5:1c0::27)
 by SN1PR12MB2366.namprd12.prod.outlook.com (2603:10b6:802:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.19; Wed, 18 Aug
 2021 03:12:11 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::15) by DM6PR12CA0014.outlook.office365.com
 (2603:10b6:5:1c0::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend
 Transport; Wed, 18 Aug 2021 03:12:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.14 via Frontend Transport; Wed, 18 Aug 2021 03:12:11 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 22:12:10 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 17 Aug
 2021 20:12:10 -0700
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.12 via Frontend
 Transport; Tue, 17 Aug 2021 22:12:09 -0500
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH v3 1/2] drm/amdkfd: export svm_range_list_lock_and_flush_work
Date: Wed, 18 Aug 2021 11:12:01 +0800
Message-ID: <20210818031202.7025-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40e4184e-542e-4075-b133-08d961f5f885
X-MS-TrafficTypeDiagnostic: SN1PR12MB2366:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2366A2B1D34F00F41646CC31C1FF9@SN1PR12MB2366.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fQWQq7lJKPxk7E/JN0am1zHy03OLhH9KO/8OrCFCWEgP2+btjFFn5ipXNF7sF1uVGDhV2SxcVrupvjNMIkQYT6Tyj/nFL2Jvz8Mvp4i4QKiLhvID0QuZ8KufCKK7LMfgitwl8cqOsqMMcTbbW8GBKDdqbq3a7L3rbeX9Ezevb4Z+TOQtnEjqkHbm1I61XmxOTts8lalHGIzqhDPzyW1Jz+xbOf9+ZZ9A+62ObICs4n7MGlB9IMUWk0IZktzPA+LUPRZIHHKtbl9c2xAh8tU3l+H/05lS+XCm2XrOJ+xBPwNC5EN2OwrUlCMN5p34SE0kzbYt04JoUEAdYQ7OOtOKo7UNYvghycmLiwHws/kU9yk1/UjUF798HEXgiOPdkHEyYOr9X3nd5oGxu5ykQGI0mssfzEJhB9Fdu1xkUJiF5gmqu/LlJTGp4qD2P3uI862SCK5YwpzQ0A4S8Y7XPqsQlIGAjdjMDUR0ZqmzY6NU1vt2zL/vIgmOSpmWZhjJ1PFg42e+sCNoOdeP4myWQNTAm7a4ESR2pFw6qGE6EnoMYvzQtbHoSTQT5nBBUVXh+hEKLMRJT/Nv58fLQkw7hvaGgTpD9E5LDtR1xympbAESXGhUkCCKV+8jPRMOHy0FmmvSUKeJBsrXKtbjCv1l8SrHjIN2BN8OZKgmgSKJAMp2eq9LFdjicaOtnhQ1OietPs6cDkw3OPmE1C4CQ9WmmQ3oqD6LRYKPXgntqxAhf8JggZam6QNjv83dBILds3TqYPzPm3T+NNXx/FR2VRtYgjnuzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(5660300002)(70206006)(356005)(6666004)(2906002)(70586007)(36860700001)(508600001)(6916009)(81166007)(186003)(7696005)(36756003)(26005)(8676002)(4326008)(1076003)(34020700004)(83380400001)(86362001)(82310400003)(2616005)(54906003)(426003)(316002)(8936002)(47076005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2021 03:12:11.2969 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e4184e-542e-4075-b133-08d961f5f885
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2366
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

export svm_range_list_lock_and_flush_work to make other kfd parts be
able to sync svm_range_list.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index c1833acc54c7..d4a43c94bcf9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1500,7 +1500,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
  * Context: Returns with mmap write lock held, pending deferred work flushed
  *
  */
-static void
+void
 svm_range_list_lock_and_flush_work(struct svm_range_list *svms,
 				   struct mm_struct *mm)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 3fc1fd8b4fbc..e7fc5e8998aa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -188,6 +188,7 @@ void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm,
 			void *owner);
 struct kfd_process_device *
 svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
+void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
 
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
-- 
2.25.1

