Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54748C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 14:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C89ED10E6CA;
	Fri, 10 Dec 2021 14:29:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2086.outbound.protection.outlook.com [40.107.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C532C10E6CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 14:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bb0ag/Ii/yE+SkWnT0krcoX6xgB2j/ko9PJllY7KMSDz2d9NNtZ2XwbcBuqYOEc1Y5dp2Mv+jRdBQ/Rtrd2MTl2w+0mbB2hZVIEpPhUy7+Ytv/B1sxyeVqMdVFUyqJoCPdcBNyo9SfBGiBTISg3yPxktNHRy43P+s7csmsZzqcoDU5dJ2ZeJIs8pVKtrCMwzqp04HnxqF9pCQuek5GY/jFF+5houhqaNKS8VBUlsGzoCDeQGRVcuKw3Ec9Huciz2CKKhmNCAYj9zSOm2Bt9y6JJxv6gp4rSARqxhYdnF89e+asMfie+5IAlnBF4LRxBEOfKzAVPeL98a4gbGOYB47g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wrdr+QxVaLf1eUYtekIzaW8SKdVrxb0K6fniMMg7s1o=;
 b=jkpj+45qhi5IuZdUijI8BFZYCz1oD/GgbCKPfXbQKomv+XUbe2H7fcjugYe1xHQSdodRate7rvnbb71B9WtoHmio6Nx0UxrNLqXE4ErmX7BXMMLtJjkqg/uAOzl4AghD4fBJ8ziszWo72It5vmXovkIXnWphueXlDC6FJQChTpMtCA2mOB+OZtXaE2l4t6z4O7Yh8Snfzirg3jv/5wQX1wN9f/N4LjbM8BMSKJGMxkwMfD3LQcV8lnVJ5Y89PzAL2zJ4RmOdQBAygJtYaEDMYqnpVmb3fGP/Gj/XNchrMu06wUCedgcNEB30cw55b2lbIXDyMfuQ8RKyI25vNJP8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wrdr+QxVaLf1eUYtekIzaW8SKdVrxb0K6fniMMg7s1o=;
 b=btrD4527QZY563QsMOUbiSjSdZpTUawRolU5TtjX92Do0hOYlEuDVTHgcNAkQo21fjjUpyWurgm7bdhpslYKLopVaPQn3PVUs24ABFc8EXkK7V33SvkRFwpYxysAasOSKLLmPEDmpg36FJUMClhnrEe3bpTYQjZFCE13wEZM4qE=
Received: from MW4PR04CA0282.namprd04.prod.outlook.com (2603:10b6:303:89::17)
 by DM6PR12MB3803.namprd12.prod.outlook.com (2603:10b6:5:1ce::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22; Fri, 10 Dec
 2021 14:29:01 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::99) by MW4PR04CA0282.outlook.office365.com
 (2603:10b6:303:89::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21 via Frontend
 Transport; Fri, 10 Dec 2021 14:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Fri, 10 Dec 2021 14:29:01 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 10 Dec
 2021 08:29:00 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix reading SMU FW version from
 amdgpu_firmware_info on YC
Date: Fri, 10 Dec 2021 08:28:48 -0600
Message-ID: <20211210142848.7784-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9577ac4-3067-4e22-877c-08d9bbe9690a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3803:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38038B7237880BA49DFB60FAE2719@DM6PR12MB3803.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrLLedQP/e+nlIjx4msALk8pjZrlP+GxfsokaVpbD1yR6eDNrDJmmMf0nT4BmaFIiXenitysYzWJ+GuWaTUTa9pXZOXl//UaZgzoY+E2tbr+moSDXvPKyft3BBLjcn818xp9GZqBcFDZjsqUmjTlx/PqydzRKP6pNcvi6I8hgC/QibiwGT56F6IipGNs8b0GMPpb3zVOBSY2d0rTGv3TOWQn8Mly8N0qrM8JpetltOrK3kWicqIYTyrnvgmphWx78lQtW412tkj0FaOzlwixctF1ORJgR9BuSo1/k/HD3i/VpBi3KD5FA2LCv2G0431JcxQ4FYQnT+Oc2ZqWjY1i3yYZqek/7EZjItKe4yWcElHNJ8GKxtF8xX6DGgjbcndkUttzx/QNiBRbz2D3mf9NKxAyGQ1CEg714B6BBiswN7WPstv26QwVB5+tRat1WjFrm8jK5dWGrlnb0xYDPTKJPAYbEDcV/+v+18KSA0y2MOz5za2STHi42YJuThrgyO385bRT15YM6r/+p7qpqQOoHE8CKQPzNfoinvuIe8nRSvJ2NKmXOi9Bn7BSRxsj+zOXVzW5PTdqP/4QfqMhlIxZQM5p3cx4m3GfgnWUDYYu+FNdeB9tA5gWsc+0J9RK97I5mFxhZ0Y3R+DAi+M7qnWEp2f8Z8H644R6FHZum8FzMpmceua05uFIwmKha72j/9+sAu53wYbIpcc6aynV+KxYSVnyR/LywkPmpGjrQvgpvzTg4HqJKemS5b3rPAJ6g9HiVfxKnajQtBIZu7NfLIi0VccoqxVICpJewxkZwn0tS0o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(70586007)(70206006)(7696005)(336012)(4326008)(26005)(2906002)(6666004)(1076003)(36756003)(426003)(186003)(16526019)(2616005)(47076005)(8936002)(5660300002)(356005)(86362001)(82310400004)(40460700001)(6916009)(8676002)(36860700001)(508600001)(81166007)(44832011)(4744005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 14:29:01.1721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9577ac4-3067-4e22-877c-08d9bbe9690a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3803
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This value does not get cached into adev->pm.fw_version during
startup for smu13 like it does for other SMU like smu10.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 55421ea622fb..85dbd6a7efa9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -226,6 +226,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 
 	dev_info(smu->adev->dev, "smu fw reported version = 0x%08x (%d.%d.%d)\n",
 			 smu_version, smu_major, smu_minor, smu_debug);
+	if (!smu->adev->pm.fw_version)
+		smu->adev->pm.fw_version = smu_version;
 
 	/*
 	 * 1. if_version mismatch is not critical as our fw is designed
-- 
2.25.1

