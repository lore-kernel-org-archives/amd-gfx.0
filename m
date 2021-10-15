Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5112FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A1D6108B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 00:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06A1D6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6237A6ECB0;
	Fri, 15 Oct 2021 00:51:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1FE86ECB0
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 00:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeQctHw40tR9SoqhHa7wGnmOsTKLYR+ULYvsdqQ9qTy+ZCkcV2Y1b0lyF48EfWsofuIEYrJK81xnUvl3L06tQA892iCYBBPfMmjhEwuWTch6FGps3G+YIL50Q6/ipltVavVndK0W85K7mqEloVWBOXHmqnH1u6OtNMXFvPZ5wzPqv+2cCkH/Y8rbd0HUXadMPRHZj6cl7+AzqpS/L79whR7RJIGbFZFcrljAFn6NKGecT8cjMF08Zt33Q68NnG/l9RMbVR+FQMMaf20+A3RHyAMh1OWYoeCw6qKMq4Z32iQy6ghsgPWUyRYZN1XqZkVjMeqna5Q1D9D2ix4k6oD7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PG9FP/9WIMMuUxp0AdkrS/cvyFmCLnKtEvL8o7NQe2A=;
 b=cbr3411gKQAKxGVvR+H2yJC1oRkpvc0mUj5qVsroepOJBJnq6IFDAyKpstXj9f485eNyQqacr8Z22d8VhFS/MCCnUtfKNcJrquohFOup5Lm3rtF8W644xUmAlDrm5MKQRubmHz31wR8wkuphbuNNpP4LyaDt/uattu5+kP4QkLyAIEroEfjrNgrivIxOVCsiwgQjWYe8zA6kPfAlvukDj5wBJV1DcSNKB/EKEC0y5zSksKMTqFLHt4uU7oB4549jJCAMB3OXq4uyuZpxRXcIXkgrPjrFfbMbteBo1UZPRGx4sTgTwZ3FnOtggPag+ro8P57QjD8wGGwcqsmWiQer2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PG9FP/9WIMMuUxp0AdkrS/cvyFmCLnKtEvL8o7NQe2A=;
 b=YS36zMqKaraK8M2yYPKowO/uc6o8GG9h0EC42Fgo9q9EB0wyCSHZNyBQ4Zkgk/1GRiKpPRWFWXT77dtJu8m7Qx/5HGmefRrzed5UL7uYAznquLbjLMKUWtkFOv0dlhBK0ClEc7oIPpNHLQYqSuWluSom9XVvXv3czOGB5o1rQpI=
Received: from MW4PR03CA0281.namprd03.prod.outlook.com (2603:10b6:303:b5::16)
 by MN2PR12MB3744.namprd12.prod.outlook.com (2603:10b6:208:166::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 15 Oct
 2021 00:51:07 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::40) by MW4PR03CA0281.outlook.office365.com
 (2603:10b6:303:b5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Fri, 15 Oct 2021 00:51:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 00:51:06 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 19:51:04 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Luben Tuikov <luben.tuikov@amd.com>
Subject: [PATCH 0/5] 0 MHz is not a valid current frequency (v3)
Date: Thu, 14 Oct 2021 20:50:41 -0400
Message-ID: <20211015005046.43486-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.33.1.558.g2bd2f258f4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd56d8da-b5d8-462d-cede-08d98f75df2f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3744:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3744A148A54F34041EF1AD1899B99@MN2PR12MB3744.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cVe514y4ymKhB15xQk3PEodhfDo3TmaPoyHYC6koetGzCdtNuudAKyY+Yc1XfXzeIxy5o4iefbjC1rqTvuaBOHY/7nWEUxXVspscXXnm8+R23fM6uA99iWToKzy0HtxI8Z14i4hJr7f68NQdH2GXH1oSpU8BHHXbb45dmp1x9LPc5HlJf8uy746/cwfLnMzbv2FOVLrH88e09uM3T/myDeHHngAcYkp7naZfOJA29DQaUQNZPEMEXSOcpy2hThu2s5ZCTqdNpLVbFyvvCyy+MyppsZz8MaTeqaTjkugAj+BBOSECmrutUMNMURgtPSFmsRLxMTT3+96CEkgaXdK+49hVG0kZgtouhXCujFRUf7GWc4yme3Lx0Owt85UQhw5gCWpnYgMI/8iwwTvEX2vXQm8RwtGEXxqKHoR7N+iQYo4hdSTH6siTWR8pk2bW/NVIQRL5ybuSTNdQdM4xccyE/QyRgVN81cg/XS+ODA0YoXL+ytMJmjU0N6/LD/w9ebTKL+sB+obFysyYZOtSyfPbKVYEZ8YN4dj+EYmMGfQNVC0+QDqycyjadhKosXcw/iXzAD4nMh1HkpmQTRbgPOxj19U1Zbnh5WxD6OlWdREVGGLfubw38drmjX9J4d3QZDQ7LL4996ydr+O5sZMBH034k/x+wDgCxtNOnne2HBNKWPywMxrg+if+8Wqd2u8r5KCJykFqFgS+wScjQxEQBxtzfoffScGJ5zh6A2Dfxh37dxY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2616005)(86362001)(6916009)(7696005)(70206006)(4326008)(426003)(1076003)(81166007)(26005)(316002)(2906002)(82310400003)(70586007)(336012)(186003)(44832011)(16526019)(8936002)(36756003)(508600001)(83380400001)(356005)(5660300002)(8676002)(36860700001)(47076005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 00:51:06.6344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd56d8da-b5d8-462d-cede-08d98f75df2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3744
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

Some ASICs support low-power functionality for the whole ASIC or just
an IP block. When in such low-power mode, some sysfs interfaces would
report a frequency of 0, e.g.,

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 500Mhz 
1: 0Mhz *
2: 2200Mhz 
$_

An operating frequency of 0 MHz doesn't make sense, and this interface
is designed to report only operating clock frequencies, i.e. non-zero,
and possibly the current one.

When in this low-power state, round to the smallest
operating frequency, for this interface, as follows,

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 500Mhz *
1: 2200Mhz 
$_

v2: Fix description to reflect change in patch 1--add an 's'.
v3: Don't tag a current if current is 0.

Luben Tuikov (5):
  drm/amd/pm: Slight function rename (v2)
  drm/amd/pm: Rename cur_value to curr_value
  drm/amd/pm: Rename freq_values --> freq_value
  dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency (v2)
  dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency (v2)

 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 57 ++++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 74 ++++++++++++-------
 2 files changed, 83 insertions(+), 48 deletions(-)


base-commit: b81c53cdbe1482b1f4013ba7a41bca2174cde109
-- 
2.33.1.558.g2bd2f258f4

