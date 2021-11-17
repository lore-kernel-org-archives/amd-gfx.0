Return-Path: <SRS0=qNnc=QE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF1DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 15:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 423BB61BE2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Nov 2021 15:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 423BB61BE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDEF06E979;
	Wed, 17 Nov 2021 15:22:21 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EDE76E979
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Nov 2021 15:22:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmkxntjDDnPdYRnVFlK72NlwYMivKFTA4lcyK/S2mDsPIomKO0+Qhc7PfUOFR7jDfmRNg47kA9kCBjpU/5oWIGRd4HrTouoD6X6N1X2z1F7V5dJIM8t0Y/cEarhdYquZzGIDs+6jZldS9KD6Ulcy50NMDanWahu0DxVDzl45OT66Pbax1BYEUgFl7hpD5pbktUjBHavP+IQ3vjYMozKhW+JA3PQeYiabPR+HoSozJ8GTS8278YPSvS8GZ+lYivb1x2AA3T3WRDa8BTFBzuShKgjVp6onzxy4xh39idb+TKM60ZKtllClxT2/8cr1LRSEEu5+beNx2OhF6/EvxMDEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gxsc9WmojDtX344GQAOs04teqcMA1BHlfYEuJhe/YC0=;
 b=FrkolhcWRki0w+4jdUsGqLniSNLZfG3+eGvHtqa13Ct5pgW7AyO10pIJ5mE3HKoUBqslfzfgShMV0bMJG6Dl9w+V8jysO6tc7piIL/jt3ZnhEnFa1XeYXGJQSNH26wJB2dNbSAd+JM2+Hy0CMhdHFtnsVcQoePPwKPI+bLGJgTheD1UqDyfHq2zP1ggBDBWXQc/EEu7IXw/u+TuVgsd4eZMJ3ckEvj9G/mg+4vbHNRzIojBWNO1QQIAnNTR6wS1SEs9OTy2SuyUtmZfcYNLgS0fEzVFS+AWOxKwajGu+T3H5G+fE57Ht6y4k+1mKzMf8WIaoNN0g11EzIvxzE5Mqdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gxsc9WmojDtX344GQAOs04teqcMA1BHlfYEuJhe/YC0=;
 b=3D5uYj+TRA4NWPUwbP79ISI90IHZYQy0x91W+Q3+O7SQ1McxQGlT4Gcogo4by2XQNu6FtdO/OXm+VCBiZr0V+d51EckoOccB7sG9ivNYkRq1Rvgcmr01h6JB4Gz72iYPkYtbWDjGiaGmE/CvUOjHWuKXKTTzHh8PLl4sPE7RkUg=
Received: from MWHPR17CA0069.namprd17.prod.outlook.com (2603:10b6:300:93::31)
 by BN9PR12MB5322.namprd12.prod.outlook.com (2603:10b6:408:103::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 17 Nov
 2021 15:22:17 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::e2) by MWHPR17CA0069.outlook.office365.com
 (2603:10b6:300:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Wed, 17 Nov 2021 15:22:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Wed, 17 Nov 2021 15:22:16 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 09:22:15 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 17 Nov
 2021 09:22:15 -0600
Received: from roma-lnx-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 17 Nov 2021 09:22:14 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Sunpeng.Li@amd.com>, <samuel@cavoj.net>
Subject: [PATCH] drm/amd/display: Fix OLED brightness control on eDP
Date: Wed, 17 Nov 2021 10:22:10 -0500
Message-ID: <1637162530-23015-1-git-send-email-Roman.Li@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cf9aa2d-b455-4740-7769-08d9a9de0a2f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5322:
X-Microsoft-Antispam-PRVS: <BN9PR12MB532299105C17EBFAD3F65B06899A9@BN9PR12MB5322.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:274;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eFJyTnbNSXBLJpJz4yoDGON3Iv7p1LivS7HYkIEFsOixcohHM5+cl99EgFBffq53azx5d1TkN/ee7CtLul6NWHahyOkwrUhYXqkdUQYfLBaW5LkZ5ox0iQ3kZQLmxL7TG6mEWL4lgOyrmbVct9kJf4lKgXflMHBz6aJlYvNkOunSnVHnzX5D60PeU3PVvw1QJmq/a95xtKF/s3lfrsrJdXCW3/BDk/MyP76IoCCIXGtv30xq4sx8m7a65ZSkM9tD7cocdVrv7hMnsDZ9Pr9rVJc6uY0H5DAG41DU+51ubB4gO2smLKs2r8k54dKYyNXTGpYT5BZ4z0CFgLwBcytC1DPZHk2v0TKHoGoE9b4w+pelDUgPbsuN77frF2vnI3eFOfMaUc9fMLsZan2PZCbplA3TwNVgN8tZoW6yNTI8fVMRxozN2Cm/Gs7TYi0YGo9PE7+jC2F1mwo2rp2VTm8pU3T0VQO99Q5jxNNsRXeIgeOmfXA+uU3e3pHYMoO41AwVvsM8oNuJeGHHZDqvkxMX7ob1G+rhbhtxhLXGH78PcxTCfuGSd621NXQEiazfGvk6e2yj3zTd+cxMXU/XFFStDp6HpbbdlqfRFjOXP0b19oIEkRxncfyrp1MXx6EsqdaGoTk3Q3Z8xFWVH3URfcS3u2YtKgaKEgTHri1sua4t6g6YYExOz7SFu5MrPWmdJl/k5vUD5PJ6RUr3rgGpzuEW6FFBucbegTScH6lL7hzBLulmZCaX7ciB4Suzxxl4YJRUBOxagAx34EOv96CC4Zj7hXH55Up/jO8xbK5SSvF1GhpFRD+LwFt9eP5BKkEm+XrD6xcpydPzGQ4tatWave+ARw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(316002)(2876002)(36860700001)(2906002)(7696005)(86362001)(110136005)(966005)(82310400003)(508600001)(26005)(4326008)(5660300002)(336012)(426003)(2616005)(36756003)(70206006)(8936002)(6666004)(356005)(186003)(8676002)(47076005)(81166007)(70586007)(83380400001)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 15:22:16.6713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf9aa2d-b455-4740-7769-08d9a9de0a2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5322
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
Cc: Roman Li <Roman.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

[Why]
After commit ("drm/amd/display: add support for multiple backlights")
number of eDPs is defined while registering backlight device.
However the panel's extended caps get updated once before register call.
That leads to regression with extended caps like oled brightness control.

[How]
Update connector ext caps after register_backlight_device

Fixes: b1c61212d8dc ("drm/amd/display: add support for multiple backlights")
Link: https://www.reddit.com/r/AMDLaptops/comments/qst0fm/after_updating_to_linux_515_my_brightness/

Signed-off-by: Roman Li <Roman.Li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 26fcc89..44c9994 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4243,7 +4243,8 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		} else if (dc_link_detect(link, DETECT_REASON_BOOT)) {
 			amdgpu_dm_update_connector_after_detect(aconnector);
 			register_backlight_device(dm, link);
-
+			if (dm->num_of_edps)
+				update_connector_ext_caps(aconnector);
 			if (psr_feature_enabled)
 				amdgpu_dm_set_psr_caps(link);
 		}
-- 
2.7.4

