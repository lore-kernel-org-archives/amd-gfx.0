Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF92C00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 11:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D16FB85A6;
	Mon, 15 Aug 2022 11:09:16 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA5999E1E
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 11:08:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKdeej79wvLV669jWGoxWo+SdTpy0kRFh8jYJsQZ6V8is253+wpDu7iefAVkJe1v+SspVQwr8vUWlbhM2HLcBroxa06yLITXkdDMmiLZ1UZd1WPGaB1Yn0o0UsqHZXH9Y1c/OcFK5Rb+w+fIu77WCjyiFrwubeknhIzEQluE9gF2g6jfz5I98PZHi6itXXT/J/z8DdwlcdZeKBC5uXfDhpJPvC/drNHhLJ7y/e0ItsMAjgdgCVI+grOSJ9e5zBAGKuGiMTLz1qesqqhf1q+gpAvjcPp05Nva+UAuoJj34XxEuFbxA5v4K4CBdqCFv0Usi8oWM5J/SLFLvFxpnfUmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBkqBQCvsO1o4w96BCA8/fBld/hP7ibCSj3+pYVQ1t0=;
 b=J5CFj1MlNVHGzFGGCkO1lqyUFIOD9I5W5l9niHr/0PvGsc/HvuKlJU6eFZ8g1uZY7qm1sHCiMFZZqttNEm8EXKtyXWEM4lchgth844eTYHfRuBfuUpAQrCdlfEmJnmEr3mIt4+wHgWmE/A9nafRRsQFkON5w4QznGWTDGd0YCr+0KpgjvrWVK2CFncjCO1+Z43Pqlioxd7NMWsOH6SGHzBjFybqjJ4UpykkjCOgsJCHsnfF50q8oi5Jd5Syu6/VY1vjwFQC5rdUrP8KVXaKqWY5Tp3J7DwSblSJ25VqEhvBO5Hkh+Km6M/zSbY5BrmhK1U1AV4f6qGEi8Om7tu3mvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBkqBQCvsO1o4w96BCA8/fBld/hP7ibCSj3+pYVQ1t0=;
 b=EcsLy0JOjz2Nd9rWoggAIQfd2ie5q2HxTOILTOWg5WJDkILEGkTekMpGX1DgIbYffysLz5ls2GnXPGYXt78H+rsb4uYdCJe5qy8B6pwdCTH3EfpJHD8wfHr2fOL0YivPlnMM9jOiT3ZQWObhZog1ASp+Z8FByFTun9jxxpwyfd8=
Received: from BN9PR03CA0269.namprd03.prod.outlook.com (2603:10b6:408:ff::34)
 by MN2PR12MB4287.namprd12.prod.outlook.com (2603:10b6:208:1dd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 11:08:48 +0000
Received: from BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::a6) by BN9PR03CA0269.outlook.office365.com
 (2603:10b6:408:ff::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Mon, 15 Aug 2022 11:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT085.mail.protection.outlook.com (10.13.176.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Mon, 15 Aug 2022 11:08:47 +0000
Received: from canli.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 15 Aug
 2022 06:08:43 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amdgpu: Fix UBSAN shift-out-of-bounds for gfx v9_0
Date: Mon, 15 Aug 2022 19:08:13 +0800
Message-ID: <20220815110813.11391-1-candice.li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 189fbb33-4dd1-459a-ea76-08da7eae86ee
X-MS-TrafficTypeDiagnostic: MN2PR12MB4287:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgKk3XwGrTeYBeB2hdMpp0zSzf7c59f4m9+lMzBL2mocDCY/LIQJGdmVYYvw8y7zY/TPYbmKj/I5fM4Q4FdZi1fA/aFbXzJ2rfcmLRrt1PlwG1ufrSrKuHuvFJ9tZSwB0GhKh50nnoqru1mkztYz/oB9PBswsBq8XP5/SHnNeSennm20TiAIx5FPo3JEldEd3A9JKbFZBoT6FW1agu6jfFpET7PHB5rvkkFj9r3nWNZr/ZrRvbgdj/uQm6sfMN8ARriwaC2fMBjYRx2YWIMGcb0OZnx6efMCWNlr50a9zGzZeN34scjRkhu6xto7y3Ap/nyMp8mb/XIzkBRxblDYrddwHUTR1kLyYX+k+PNlp1obu6tfLMKe3YTYoO1WEmUPA9eYiz68j+wX7LwtGQJ81cJDpDNA8AxCmLOnkPyZbZBYzjyaGzpNbFUUKyley16mIVnuvbv6oepwouzUEo0VqZtpTZrEs69Sg5KIJflsRcdYjpzDkza5W+SnUwxlsTRMHYqasjE0pvLyxxXqVCDd7a+WU2GGDUoAe0Yd0QyytoGefXasxdM4IN9bHSPL81Mc96VLx7qlf6rHWMpefmKOM23q2ta4U0/O3f6XJe/VCM1J4Wd6yEdRwAsGhNahGv2F06n8hP88mDXNJZFSW73+ZagSDBgts9IJugPbbOT6N9pt4Dos+CYAh6mE6ApH3//zOkEe2wcYAOpDWQssgd4Ic01jv1sJ1pF6HYXiPHTwoCgVKKEi/Sm/ISXLnMpAA3BoX41qmJTQj0LRueu+/ojvFjyAR2tC2Vh/yCybf7G5Kascb9qY7w2+7kVOOrXBM3BY7Ic99dBje97LvwGvpjhUDQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(396003)(136003)(36840700001)(46966006)(40470700004)(44832011)(70586007)(478600001)(5660300002)(2906002)(70206006)(8676002)(82740400003)(81166007)(356005)(8936002)(40460700003)(86362001)(16526019)(36860700001)(7696005)(6666004)(40480700001)(36756003)(26005)(186003)(1076003)(336012)(47076005)(2616005)(41300700001)(4326008)(426003)(316002)(83380400001)(6916009)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 11:08:47.8779 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 189fbb33-4dd1-459a-ea76-08da7eae86ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4287
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
Cc: Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Check shift number to avoid doing a shift operation when the number
of bits shifted equal to or greater than number of bits in the operand.

v2: Only calculate shift number for non-zero data and fix build warning.

Signed-off-by: Candice Li <candice.li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 7f187558220e9a..c398c21d906069 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2495,6 +2495,7 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 {
 	int i, j;
 	u32 data;
+	int shift_num = 0;
 	u32 active_rbs = 0;
 	u32 rb_bitmap_width_per_sh = adev->gfx.config.max_backends_per_se /
 					adev->gfx.config.max_sh_per_se;
@@ -2504,8 +2505,11 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
 			gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
 			data = gfx_v9_0_get_rb_active_bitmap(adev);
-			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
-					       rb_bitmap_width_per_sh);
+			if (data) {
+				shift_num = MIN(((i * adev->gfx.config.max_sh_per_se + j) *
+						  rb_bitmap_width_per_sh), __builtin_clz(data));
+				active_rbs |= data << shift_num;
+			}
 		}
 	}
 	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
-- 
2.17.1

