Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BBCC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 19:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCF810E066;
	Mon, 25 Apr 2022 19:24:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EE2210E066
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 19:24:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh3gYTFEKAnJzVxHS+LtFEziIbCeBi2zfc47eXlwj9UuIBFYV6i9J/tJlYNRxixB98xXNcSTeE7ipH8SnTRB3t/ifod7osb82bmLjVB11u63rwq4GGr+PN4PTXT3ZoCR+RpgLnUGJFQeLTbMJiN5b2BWK0rx75iCktoZW2yBfps0PDYed3gggFlzi2j+ZQHy5fS98UE1fos5UMbGrUuHJbToYtNqGMu6a3oRWwlWZYWr8uDUM9A5ru5vLps0LL+X7VH+oaFRHvlNlT7IC5efCxZ6gPOY/nkhc1gshB9WL424CgPv9Y5OaRLwmirD/z9JUKMPTTdhMFdDGFZDT85Q8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lk5t76X8irelNoRqEohDTCnJAMo0Q21DwmyqNvYulk=;
 b=N14C9JbVnBAqGWCj0wjj8qtMVNJPW5oRh8aDEUdxKJz7BT55VDbw7nnsVRX/5yeYB/tsjm+hZfH2++CvdpFv/YeKFgznjKdnH3egHbSMitPGvEIcORVO01DRbHWibroFRhg6UV86ABIW/7lckttiMJjS1/2lPbJzgMA7DcbYdBfrdVS/u1MwW05jw3XawHVHrEH8tbNe2bzHYO/MMr/zix/cJuP+/sKJsZAO5i4pxPakc8NON5UNCATFIb024wONdDAI/mRkdy7W+6qi8Dnt1pYTKYqKA98JOUrBoDMKmXkUwLZUFsrP2JOUg3jisQ6fhs5OaITv3LbfYImJW9wZTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lk5t76X8irelNoRqEohDTCnJAMo0Q21DwmyqNvYulk=;
 b=F464qFMnWhCQXmP3Ru4QwUyWm3DzAOqZlWFaQaErzOtJbqrBA1Xq4i7ST7RSgcv03gQAEXpds5QTh10x6Iq2PNOAleuJ3YvzAEjr2QmzCojnHW9NFUQtHRtkRQJH+NYkHicX8tkE5M5OQkmN27I3FN6VyHeVz1/MIfMGlwdXxE0=
Received: from BN9PR03CA0605.namprd03.prod.outlook.com (2603:10b6:408:106::10)
 by BY5PR12MB5559.namprd12.prod.outlook.com (2603:10b6:a03:1d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Mon, 25 Apr
 2022 19:24:50 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::7c) by BN9PR03CA0605.outlook.office365.com
 (2603:10b6:408:106::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Mon, 25 Apr 2022 19:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 19:24:49 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 14:24:47 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: add dc feature mask flags for PSR allow smu and
 multi-display optimizations
Date: Mon, 25 Apr 2022 15:24:36 -0400
Message-ID: <20220425192436.778206-1-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e0a617-7632-4ee8-5ac8-08da26f14428
X-MS-TrafficTypeDiagnostic: BY5PR12MB5559:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB55599784D9CE4726591214FB8DF89@BY5PR12MB5559.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /C2UuHj3NBbgIt34DPRp9wgcRz2IeNOY0/3zqT29RXn81BhgZOvi3UHgyufwrJ25MbEIzizavb+ktihrlL7MapteHXkX4hb2xe6noXReMNMchOGSViwzDB90MDUuCwW7WK494EZ3z4yNOwVPPtXWkDbqRLSpSgTj8fCnCxSiBBLJioqEPd56O11RvTLGaU9AqqI1OuAuct2HH+hkVDA48mxOjgbslRu38HpzHLuoQZK2cOVPODcoRRpodWfVwgkeJV20LvvX4GTou5rQsOGzLtVey70ZZT/N5FjwKmSvGgVQTLb249XdB8HKTIeOOUCdw9xKnNP+ebVlTY0O7ZU5gP+jH9vlhC+PhuXdTgvcyLJKFANCiiRtWN72x7EGxPdgCgzlvaqAxk0go8O2RP+GqwFg+rnqjnq37vasVAvSl6kbj9mOWMOB353knoJEj6/AKbkgEGYcyQomZ5l7eywNZGoeEeqirIp6ErrvHwLeVQu9+kgE1h0D1CyX3pwOZS9Ll3seGh3O7vzWDMTkSzbaXpEY9H7E/DXFmUexrP1Gcpujtb/oyuG2kZE/2dLHvwo0iCWr0w72lCT5grSJuj9XOnWtA1KQqa8imxjXa1+umVWLJGid58o7tVCEc7Iu04aUIIPSpYYzNbC6uzTeQ8NoukyHFMmKhtx/7vg9JctbFAu6OCoayqjK3wYvjH4chggSMQNA9C/syvjkAjK1mNPylw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(336012)(2616005)(1076003)(47076005)(6916009)(86362001)(426003)(186003)(81166007)(6666004)(7696005)(508600001)(356005)(82310400005)(36756003)(8936002)(4744005)(4326008)(8676002)(2906002)(5660300002)(70206006)(26005)(316002)(70586007)(36860700001)(40460700003)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 19:24:49.8190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e0a617-7632-4ee8-5ac8-08da26f14428
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5559
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow for PSR SMU optimization and PSR multiple display optimization.

[How]
Add feature flags of PSR smu optimization and PSR multiple display
optimiztaion, and set them during init sequence. By default, flags
are disabled.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/include/amd_shared.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 741dae17562a..06f21e9008c6 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -234,6 +234,8 @@ enum DC_FEATURE_MASK {
 	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
 	DC_DISABLE_LTTPR_DP1_4A = (1 << 5), //0x20, disabled by default
 	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
+	DC_PSR_ALLOW_SMU_OPT = (1 << 7), //0x80, disabled by default
+	DC_PSR_ALLOW_MULTI_DISP_OPT = (1 << 8), //0x100, disabled by default
 };
 
 enum DC_DEBUG_MASK {
-- 
2.25.1

