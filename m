Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2826C04A6A
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jul 2023 16:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D8BB10E1BE;
	Fri, 28 Jul 2023 16:41:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB2910E1A0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jul 2023 16:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibPvcBuEZWkX79fIad6CSo83VL40sVlXgbNwKdcKWUDLHjVZclDIYxah8+8KpanD3He0HWL1td3sUHXy0Bb9vQZiH9k/SOp5N1ItyUVhJjoo1zcDaz9iAyflhQ3RcZg9VJVa2UNuPM5gtFACcBa8h8+meIHx9WRGf1nP3XjlNY0Hk1Nm+NF/aWo88tEg3ZnJiYa0LL170uATV93ZGTUtIkHSav0vsPEpqp+jdBGQJIiXs4FTEQAwXYhwalEsbPYyjWafJFbjBpa7IAyAoY6jgwEEOBAy4U6nws0i0r5IaORACQnjgcFoRzK8ClfyIR5CUeoSxoucDupKfuCkFIXeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXBQKzrqSyi3fZI/TzaOdRuVBx/9oyi6crM+WiazmPs=;
 b=L9Yp0/wIia7YQ3x7BXr9ngRpjww5LhQhmV2wpLxavKr/cJ/GG272fVt1qPl5zylNX16JiGzh+PBQQNCGQovI0Sp+mPgYI8+TOPNx4z3TWRTPBjjwfymXcvvklxZNCfqjtoFnCUBOHBZkqeS/5haXOZ13rIEG4vgVYJ2KxxCFupJ6QJMZ9MCk2pD3SG9YXCfEvSADp347YsiNJeEoVb+TA9A4s5VIUWz2mSSLygfniL3vqwW8tUgZtIXmBMD6UohE3e3bqMv6MmYWMNny9+F1um1G4K3+6xY1RuT59q3JBVPFge+K4Giyjx+0Hh35O7I7WqOiTjPi2243jTrTgnSEuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXBQKzrqSyi3fZI/TzaOdRuVBx/9oyi6crM+WiazmPs=;
 b=cgkIVmk8bGQ/2MEwUCr+hFbqq6xI4DUpGPVwU8MYCKSG5TOPrYG2QMT3ITtT0sqoBFq7r3LyrYqpUXTqiSzV7Wgtr4LF8522YhNTqukCTMee4IuH/w6GxdLOvFsU0b5tZhbD9I1IlcWt0XVVhEgKIQWg5RlqEy8/gCmVMdQz8CU=
Received: from DM6PR08CA0047.namprd08.prod.outlook.com (2603:10b6:5:1e0::21)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:41:17 +0000
Received: from DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::e5) by DM6PR08CA0047.outlook.office365.com
 (2603:10b6:5:1e0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 16:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT066.mail.protection.outlook.com (10.13.173.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 16:41:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 11:41:16 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdkfd: ignore crat by default
Date: Fri, 28 Jul 2023 12:40:59 -0400
Message-ID: <20230728164102.3327956-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT066:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: f5312532-a2ef-400e-856d-08db8f89771c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDF5MDVvTWJRHYSL6Mm0j+k3mgvIHM3t0W4hYTRsOuMYlnfa2QMWmy8rUSx51eMQr5HCwRpnQcGmrniZ8PYW8cBcLk76/Q9lQI7X6nV3rDbT6LPYfwPvjBt8C1ab+4cCQ23WlAf0jpvnNCp5mv5MXTZ4JafZbxs6B49B/h79c37DlQHHTBgU4LrHzbE8ayTNQ1NDXhegIDkFIOq9nEw5Hslp7H9ASEj0hqpWiNtPuweqSj84AzSZqhJ9OgcfOTxlHBObfaVUy/BrNB+uBW42M/5jkyJ490xAjvkH9PBwWddFhfM3ucS5+MvtABCD2n+/yW3O20ViWlwrZ8sqr0XZfwWdx+97ExEvHc0NIAZ9dvNiXkQ6lb+zspBaLOAl8dccH7zy2wZIP7nRRiOvq9f5wMD3vy73pmp4BdECbEv1ZMhF7QG53XQknN5Y0TAPjxAhw7CBa/FKzMQZb9vqPzGyirMUH/w4sLjJ4c6VaOk98GgtT0vRKec8dE22qRKDFQv/tX9iBuv9FwRAdLM1flKMbzQTp3JDKyk/CNMXzs7UBar5UomHTIq4nZJdN/blNpQyY3sURgVxugzHpXSQZaPvqFrYaVOtkXUKaDlEm6aaMouNsY8qNf01cOxO4nEPxaC1df2p95sLzuTeFzE0p4OLvZoZSZVNtCrYpnrjEr8ns2N2q6y/7p0PJYcADuaKzioCTMzINx01ZZRYhdS18FAu/JuO6OZlzm+fPn7y7TgB7mnLrtqUr1O639x9M2F/5wrlBUcv3TcTG2YqkBBC6qWGeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(82310400008)(36840700001)(40470700004)(46966006)(83380400001)(26005)(36860700001)(16526019)(1076003)(8936002)(2616005)(47076005)(8676002)(186003)(5660300002)(86362001)(336012)(426003)(41300700001)(40460700003)(6666004)(81166007)(478600001)(2906002)(356005)(7696005)(36756003)(82740400003)(4744005)(316002)(40480700001)(6916009)(70586007)(4326008)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:41:17.3769 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5312532-a2ef-400e-856d-08db8f89771c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are dropping the IOMMUv2 path, so no need to enable this.
It's often buggy on consumer platforms anyway.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 49f40d9f16e86..f5a6f562e2a80 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1543,11 +1543,7 @@ static bool kfd_ignore_crat(void)
 	if (ignore_crat)
 		return true;
 
-#ifndef KFD_SUPPORT_IOMMU_V2
 	ret = true;
-#else
-	ret = false;
-#endif
 
 	return ret;
 }
-- 
2.41.0

