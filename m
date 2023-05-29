Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69FDC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 21:12:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3726410E2F0;
	Mon, 29 May 2023 21:12:07 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB6B10E2F0
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 21:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ii0KhFefdQaNLrUaNzf7a6f1ozpqkfNVPR8i2ch3A9z2WUuHsDvR7TTHpTwlQT1hVqfxcvtXC+w4T+7+pXMI9VdDq8k4GKDP0kmLaEABZqKZ0YRXaQZ+lXRsumEiaJMepFpqvYgagLKXWi2tXbZy/htOrQ7hHp/gmlozqM78xFmujJDxIwUHTfLeSVkXUuBKc48dCNkxqhaLQQasMF3uztBEh0BTNkwKWyntLD08Q2sTuMZmXyrUnAUvtYW/X2+UDF6DuJHuxpLkNB8UTVGcOhZ9hmDEv7l9g7SmFBJwvsbfIOT98a4JgLvqZi4qdFSCR3lqhnJ5z1kMcAKgYd4AFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AezTRfM2ewXT6gF1bUJg7fQIh5MJeMw1pAcrgueQlaU=;
 b=AgZDqKpMePY/cUBHF1VzbQfdrZz4NOoYajAVneahLd9kQYBLS4vrWC3sffHlPAQD29d9L9plqHywiptSBZEsGv/I7zbX50usjLmc8xBI2+NQKhevEQ7pTgmjNVVNdnkLdCIYKV5oeVHXSLMH2Nr03C1byqq+wV8Ay4DEN7MJEstiwNKNAT6tLT4/CXRXH3b415rSNbPQkrHSS1oHlw1o3KcBDXQseQs0E+27KArUGwxs2NVMmorNnIFDPeyy0oiKxQPIEVQdTuZQV13F8cc1zau+xlHzdRr4GPtNRAuSklOG+YvlNUreNB8I1NyaUfFKjIsycR6x0lDkBZLzLycU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AezTRfM2ewXT6gF1bUJg7fQIh5MJeMw1pAcrgueQlaU=;
 b=hbViZM7s4UNsBCU5ZQnoy7QdNDOS40DPwvgIGm9z3CNpYIi5vtTHkOKEKCb/023aY+m2fbeYCcW6rQLEh2UaOMMGrhlu1Ov9n13s/M+L3CZf3MYpSpzztvywoATLsZQNMmCcAzs6+ZOgmP6BOwylBIx/56THwQY/3aYllMcMEQU=
Received: from BN0PR04CA0011.namprd04.prod.outlook.com (2603:10b6:408:ee::16)
 by CH0PR12MB5300.namprd12.prod.outlook.com (2603:10b6:610:d7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 21:11:59 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::23) by BN0PR04CA0011.outlook.office365.com
 (2603:10b6:408:ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Mon, 29 May 2023 21:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.21 via Frontend Transport; Mon, 29 May 2023 21:11:59 +0000
Received: from alex-MS-7B09.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 29 May
 2023 16:11:58 -0500
From: Alex Sierra <alex.sierra@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Felix.Kuehling@amd.com>
Subject: [PATCH] drm/amdkfd: flag added to handle errors from svm validate and
 map
Date: Mon, 29 May 2023 16:11:43 -0500
Message-ID: <20230529211143.25265-1-alex.sierra@amd.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|CH0PR12MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: fa993db4-0ea9-4a12-c4ad-08db60895719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUfhvUiN+SAF3EkNSaztVRCkGX7mN27copJCtOQpujpQHBW44yF+YUS5RBjS7GuvMMer5SyrD5qbH9rm/J3wwD40UpQPSGAW4140X9G90JLvfQErh7c5ffUufCSRLcAXcMinzthXF2Bd+Ruh5QjjTJCcfAfd9tGTMZsd8jw8+B1oVxeRbkQsFb9FrqHJCmIm7QOTHlNHkAgDWqCvEffLMHIPaTcUTtV8Y4Nm8g9nfpVsblPLKLQwYxM28agXMwjWHeuaFdf7KoIR+bQWkTKBuVJgOioSf+2hW2e7QZGvre0EIIYjqyBkl/bVnFBMuchDMDVP6/ZcJCvYV/eFQmfdOAPBG/AoAB7NyWZabBTCoWZVuneSyVLhgrp+XHDBl3Q0qV2ckW/0nPY0ZzD2drk1hh6tt7ICMaCMr12fCpVVHxKTZwZWZi1mk2mw6f9i6m/KD8NCmuHF6Ao41UyXB00XNat/wZEOVUcaNYdGWIzDP4hYBWRXuNvSU9WDFpXKoRID38VRn5JGOm1lzkx4m0ImS1MDxDxxkuNtV/f6UKTr+vKunU1EgNt4LgXBMqyIlsjI7LY0Q+GXn0HKtJ2vzD+xnJ3sC8Ar8r1Uj4nmtIZMfEy3R9weVlTYLSHYHF7L7A0/R6gvZvVBI8yzLUKF81F2iILed9y7pNoFhjh/2dhco5e3F/qMigkjcP+FsfFfZek8FIFWm0OVgHPPK8qVsJ2oXTkX3I2pSx8eedQDSgtkiJbLr5sdXi+8wU3A3SYvyVp7aZXED/mfNmwzBz5mRDIIZONbWQkDpRIP3xbdoMxfoDQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(186003)(16526019)(15650500001)(26005)(1076003)(36860700001)(5660300002)(54906003)(478600001)(81166007)(356005)(82740400003)(8936002)(110136005)(8676002)(47076005)(2616005)(336012)(426003)(83380400001)(7696005)(86362001)(41300700001)(316002)(6666004)(36756003)(70206006)(70586007)(44832011)(82310400005)(4326008)(40460700003)(6636002)(40480700001)(36900700001)(309714004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 21:11:59.0681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa993db4-0ea9-4a12-c4ad-08db60895719
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5300
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
Cc: Alex Sierra <alex.sierra@amd.com>, Philip.Yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If a return error is raised during validation and mapping of a
prange, this flag is set. It is a rare occurrence, but it could happen
when `amdgpu_hmm_range_get_pages_done` returns true. In such cases,
the caller should retry. However, it is important to ensure that the
prange is updated correctly during the retry.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fcfde9140bce..910c0269598a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -823,7 +823,7 @@ svm_range_is_same_attrs(struct kfd_process *p, struct svm_range *prange,
 		}
 	}
 
-	return true;
+	return !prange->is_error_flag;
 }
 
 /**
@@ -1657,6 +1657,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 unreserve_out:
 	svm_range_unreserve_bos(&ctx);
 
+	prange->is_error_flag = !!r;
 	if (!r)
 		prange->validate_timestamp = ktime_get_boottime();
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 7a33b93f9df6..b716d4bf7ee0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -133,6 +133,7 @@ struct svm_range {
 	DECLARE_BITMAP(bitmap_aip, MAX_GPU_INSTANCE);
 	bool				validated_once;
 	bool				mapped_to_gpu;
+	bool				is_error_flag;
 };
 
 static inline void svm_range_lock(struct svm_range *prange)
-- 
2.32.0

