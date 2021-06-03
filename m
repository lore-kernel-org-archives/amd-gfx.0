Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4390DC47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09A9A61008
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 04:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A9A61008
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44506F39D;
	Thu,  3 Jun 2021 04:56:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DFA6F39F
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 04:56:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiM87i1zV8nqkAMfyq4XFrvpgQAZYMCgW63XQNw4rM5sz1oZj0z5WHB6JTrOKnhsWa97Qk4xV5AaRP5uiB06fakfcMiwPSM+aEECGRnDd5TJc4k/Xn1ONogkV+njfmJzXmdrov4g5hkO4zyFORfxQbzdCiiwFoaVM/6Ib5kujwdjM1Va6Gk32KbqM7vJ0q0b30XSN+dJyODTBaJQVI9cJHe4+AYtFi2SqkQXCxMe2GV3JDOQ8FEiTxEZqNzjyVs1McDDL5+JUF2Na6mnYWQyoTNOHiP/Qy2Fre7gd41oyy554r5cTwnYbh6/oCHm82eHMTFO6TXBBuZqDzlPP9wW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkKhcY68JnQxOtdPaoVJ/5ahWRwh5tSwi8TQ/sS9pSg=;
 b=FfzHVjPZ63GMNHa9nabH827G/lLYdZzRXNffub2FAVFsEzkWs77I0T4exrP7J1VXKBiY+zEAjvWpoPRWECqhjca8NEoiknFb3qCoC9YGDdy6dpSAtKFRLPwG2X8gKmIdimhi2OA2OTZp6l01Ni4WvZ5lXU9dvZeq5ZQEqIPTV/tzasuD5FvrbdIlAtzq2oMZvunZLWMLymguV/XKtliTrMFlJqhb/NLlHYdK84HlFKS8MRPhDDu906Q1gvvBvyDgSDd75K5bGSzH5kx/Qr7kBshrSIkcwvP8qyucx69WYJkEfrcR+RT4FAd1gKeN+EIO44SsYtw9ejm/fzK4sAGvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkKhcY68JnQxOtdPaoVJ/5ahWRwh5tSwi8TQ/sS9pSg=;
 b=SoxeavwjS1vQlQQb6p9ObvztgzwtPnqZYkmSPJqGdJDtpSSXU56OT5CM/7/2nS/iAS2qwalrMkjWWptR+HZcTc6AU16GvrB8kNnSG9f269KJmJEJTM9UsYOb03GaGDxaQ4+jxKeGNBizY82jq0md4iR7MaAXdHHWxxkBA+RE2qc=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by MWHPR12MB1629.namprd12.prod.outlook.com (2603:10b6:301:3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 04:56:39 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::dc) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Thu, 3 Jun 2021 04:56:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 04:56:39 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 2 Jun 2021
 23:56:36 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd/pm: correct the dpm features disablement for
 Navi1x
Date: Thu, 3 Jun 2021 12:56:03 +0800
Message-ID: <20210603045603.977998-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210603045603.977998-1-evan.quan@amd.com>
References: <20210603045603.977998-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cfcca9f-420b-42a5-a6ff-08d9264bf900
X-MS-TrafficTypeDiagnostic: MWHPR12MB1629:
X-Microsoft-Antispam-PRVS: <MWHPR12MB162930E2268A89C19AEAF78DE43C9@MWHPR12MB1629.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XQrjC9DHtLv74IBwH6+Q11w4Ic7BTPaDmUsGoBjFVZzF81Uv4DwWq7ew3s0WPxHgbqHxrjCCqEAkL7Yy8jQKXtaqwTmO4j1iQz59kTtgfSwCjHriYdWwNR48J/JVSryf7PpZ4O3OOgI/U4PZ77fOQ9+dVIr+god0YRDJVafJdfbnpoSoUayws7OmkN5/s8/EuEPeqmH1iXv1IWDScVjfpD1Z25tQQr/GxrLCg867c37W3X/r881PKinEBfRuxg12YQXi5iO2ULUcs902eTvBLO9UAPtzHDXnQM3SsagEoKnksMOEoafUqbucMiQiTQfbhWWeAKmeAz77tub7+pjEl5iGV/mupJM52ktogjjp9kk2lQc8ZQ6InaWPGiL6pJ8m0r6K+Sgasx/gqtNE//lNGOC/fsZcaiuUhSCCmRGHrdoa1H0lc7EGJ4bZtGZEw9ogSDSN1+MAT8rhNtGV/CLa3QQ1FuDg1t8Hynv5TbeUu4pmjbKA85rLFlZtP7COovUvgwer7I2cklc9FK3FaypIkvNL7KWXHbuRGUMq4/2DsxSBPGs9kunIs5RMwL0KItjL24nxnXgymI/TYCBa9Cl12nlTgGRiAnhVaXcbJx5Wb0wPnkZFm4BHqtunVE4PSpPvWirzhNffnYERI6Ke4oOBbYsHQMv6fiNizmbIPZWiAKkYh2okoUrpvCImW/csCwc4J4VtwjUWJmcrdW4Wk0AFIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(478600001)(356005)(83380400001)(5660300002)(81166007)(316002)(82740400003)(426003)(2616005)(54906003)(6666004)(70586007)(44832011)(26005)(186003)(16526019)(70206006)(336012)(7696005)(1076003)(47076005)(86362001)(36756003)(8676002)(6916009)(4326008)(2906002)(36860700001)(8936002)(82310400003)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 04:56:39.1173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cfcca9f-420b-42a5-a6ff-08d9264bf900
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1629
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For BACO scenario, PMFW will handle the dpm features disablement
and interaction with RLC properly. Driver involvement is unnecessary
and error prone.

Change-Id: I19363fc08568be4b7d3f2ec6eba21ccf8fff6c37
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fd7b1b8edeb7..e3e309bb086d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1393,7 +1393,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	 * For Sienna_Cichlid, PMFW will handle the features disablement properly
 	 * on BACO in. Driver involvement is unnecessary.
 	 */
-	if ((adev->asic_type == CHIP_SIENNA_CICHLID) &&
+	if (((adev->asic_type == CHIP_SIENNA_CICHLID) ||
+	     ((adev->asic_type >= CHIP_NAVI10) && (adev->asic_type <= CHIP_NAVI12))) &&
 	     use_baco) {
 		smu_reset_cached_dpm_feature_status(smu);
 		return 0;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
