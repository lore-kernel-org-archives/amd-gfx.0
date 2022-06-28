Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63BCC43334
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jun 2022 21:44:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4347310E822;
	Tue, 28 Jun 2022 21:44:16 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2085.outbound.protection.outlook.com [40.107.96.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F85010EAF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jun 2022 21:44:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo3kUlCGBqXqLdNAzBrG2j1XJumRq5ECzr0k+cOUJrhB4LrqROyEsbIk33vC5uZDrGPJ2AyQzmj6zgneKta43iPSGepBEtIrl4PN0k4/v/l6MsvrUQoy1O+DsScW4akrW5p1DUzfsKMiKX+QwELcha5eeyOMKRV5CPYlD0nLaoIjEuRvmyhh/4djrWchweFHWs9vICowBLytRq5OFno3nELWQpLblhSZ5lYBdlw9f721vh2LWQFNFqbgj+bcOyD25ZQJuvvT7qzavnpUNpxDK4WkXKJPgk7Ag4dXqeqcWWaZFxy74yzmeP57WJhm1BXttEtb42Il4VTPpXZA+8eXKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfFVsZXlaPe1h8MSGuSt3k3by8pYhqW6qmVujFBcfv8=;
 b=UJdm4fITis9WtdT+3eteYaXL+rI5R4oCbIlq/ncBDBMbxfbs9KexEqjwTj4jJRao5Ch5SenWvaJYwUojD2Odiba9SSYeiXj0fMnN6NizNXxQLTfbNcfwBJSzsYoBYSR6YG/LxqTg4zJ7Pb5NfuAvfXWpqTB8Za7owW3MaBGibk0rbkqCJW1UEpJ3/oYHiDO3wO2ypCD4L3O7T1bozt86kTv2xeHET19vh4AYdvWdut06mxOrotYNuMZR1Wo1VCxgaT50O8uCI8LXYvOF3YRwHqd1+P2s4Ha8N9hRFJEvFhR4clikBxZiwj5OMG4jd5n6xZoE3iM0QadbAb+wkZ0oWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfFVsZXlaPe1h8MSGuSt3k3by8pYhqW6qmVujFBcfv8=;
 b=yGU7AxLqa9v08HFAcCfXv9W9IgIMvgnsk1jfZpNSzL+dTES6RdmpDguItRty7Zf7Fi2mz0beslb2vRmmf7Pq/oXYj8w+S9adJk+4MO5lzilA7n6Tiu3MttW1DRQ7wlxvsoHavsP3RuuQ0Lg7SUl5XcKewLkUbjLy+yHymCEcySA=
Received: from DM6PR18CA0024.namprd18.prod.outlook.com (2603:10b6:5:15b::37)
 by CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 28 Jun
 2022 21:44:10 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::c7) by DM6PR18CA0024.outlook.office365.com
 (2603:10b6:5:15b::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.21 via Frontend
 Transport; Tue, 28 Jun 2022 21:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 21:44:10 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 28 Jun 2022 16:44:04 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] libhsakmt: add new flags for svm
Date: Tue, 28 Jun 2022 17:43:14 -0400
Message-ID: <20220628214315.235160-4-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628214315.235160-1-jinhuieric.huang@amd.com>
References: <20220628214315.235160-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 520622ca-0f31-435f-57e2-08da594f55d4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5348:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6V2eLAdfWDsNKExE3qioSQsc+sTDKeBjaScSrCy5W+K7Obz/4HRg9uJBz9UksWuNbqQI5YccSy1dLltBZYwAG0MNXckOkvxPANgTXK30QKrUNJHKs2ST2OaR6lnQNWNwzFkTq1hnkb2A5pYoFJ5uxKjoG/Dw5bco6LTfvTlFxk7kl9NFW6JYWQNCSgsvVGGt/p6uG70qlDgwqnOpxzdjePJssSJLyTXsKoQ8jy2X5IfrDgvmGnnu5Rf/j+skP61a+CvTnz8Dz5pkYc6zt/k2Rl8kVxd/gZbKmGCaeLNh9s9DD/3vrQ24P9MLjMEflMvEXWnHyVoh4yTT823ZkXx0e1cHxk+z2KRYMsafqahz41x25UT0nlz/67lSSZGAEUc6EfxvSma21IUqSRTuZ0dVB1xoEAZHjoBKwxrN30R9g+IJ9O8jxglso7d1xtnF58dE1qfMug9LrWOteP9QVImMoVHoLkP+WfOmr6qC7+kTeSo3iD49avFT12vWzp0MhMUK/bnihGcpnharGQ8mHrxGy6s2sUDNlujmCfpT+rfOEHsW0tyrxJdPCUcfO8KG44WkNtAdl7ZzRlBk+etgzHiUBEIURCnZKZwbN6NttZsaJYKL6fH52R/R3Z1vstPKpzcLczeBvdgdnvQGlNQwDJS6bCkp13zIdkgvhqEM6OrUprQLCNsaPaKrcFwG1plvPt5ZhVwwUV1+f8Fi0EGPmw90dPvYGCNweCCGbtvjmUdCf6Tf9vXmy38ryKeAJymXd04yq6zsuI6lwxELTqOjOwYCA2/kVu3TJl40sZnoPu3vkHo1i+HzNKlggvtdjvUVGzjZ+48vny/F3XWXNAQaCG8eQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(36840700001)(46966006)(40470700004)(4744005)(8936002)(7696005)(478600001)(81166007)(26005)(40460700003)(2906002)(5660300002)(86362001)(6666004)(36860700001)(41300700001)(356005)(82740400003)(82310400005)(426003)(47076005)(2616005)(16526019)(1076003)(186003)(40480700001)(4326008)(36756003)(8676002)(54906003)(6916009)(70586007)(70206006)(316002)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 21:44:10.2520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 520622ca-0f31-435f-57e2-08da594f55d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5348
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Philip.Yang@amd.com,
 felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to add new option for always keeping gpu mapping.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Change-Id: Iebee35e6de4d52fa29f82dd19f6bbf5640249492
---
 include/linux/kfd_ioctl.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/kfd_ioctl.h b/include/linux/kfd_ioctl.h
index 8a0ed49..5c45f58 100644
--- a/include/linux/kfd_ioctl.h
+++ b/include/linux/kfd_ioctl.h
@@ -1069,6 +1069,8 @@ struct kfd_ioctl_cross_memory_copy_args {
 #define KFD_IOCTL_SVM_FLAG_GPU_EXEC    0x00000010
 /* GPUs mostly read, may allow similar optimizations as RO, but writes fault */
 #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
+/* Keep GPU memory mapping always valid as if XNACK is disable */
+#define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
 
 /**
  * kfd_ioctl_svm_op - SVM ioctl operations
-- 
2.25.1

