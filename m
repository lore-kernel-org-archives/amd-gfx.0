Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230E2C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Dec 2021 17:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA50FEB3E0;
	Tue,  7 Dec 2021 17:32:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30308EB35C
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Dec 2021 17:32:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMNVgEL8NAS3JkGw27hLE08IgcJApt6bBMNT+EVhLkSnmt/bdSEpygjWtm3X+X06a9FhKQzT4tHA6g8U/IlfarJSGMdhWP6EsLn6siXdZFwmkLMLpm3eL02VFXHqg/J8b6oz8qGszz7gYFjjFhJvCW1RNNjO2L1wqbjgi0ZRkruKVafKp+perSb0N2zkCgZD0/ZK+8m8ln30ez/pTYAyVmOKNYqCfXHoH1KDlHVQ1YYr3/w6BJTI+YZEgrj4+nqWENKQtOvjE9Kimpfek4ksh5mt896bsXPfpH92NC0VX5lkQ6iDqseXvwLa+pgd35sG1Gjw+Y9TJbBDjuOTCweH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNj3JJ9tM7OhvIaMqPhsDHv0BVO0E3/szeaTJpluqpM=;
 b=dsQ/SgwVSqfymHXz0fEGUimQTkyhBVbikZaDmyewfN2hCaBONvtXfAt+v2GJDnOxRgI/YHXKMg2qD35iEKwoXp+8rTfMFVkTDe+ewhxfWzNG/vGp6T7vPGSwppU6vjTf8gDcB/Otbn5VImbJz6f+8U9QwYNDGjYydDcIS3rxL1Grkami5GRgdSR89EWnUIDH6YAaGTtJZhmGlcuD2uCYz1FPsMZpkZrL/Fg7tcu0cp5ojHpuqXKLW8pNJ8T61KY1A+LJD1XPFeRoWjx3uoAbN8zh3ek8P7/BUdZsA3/KlvTrjk3nvT50sSG4CLR4HlrI9V/oMQNCnoVwElx6T3Gb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNj3JJ9tM7OhvIaMqPhsDHv0BVO0E3/szeaTJpluqpM=;
 b=Cc6BogoB8q0kSIiJ3Qy2eRkPo7z+Odnb7xlewQ4cp2RzQ93Bej4s+gMdhCSjhUx8pcB8bchlLfyIDrpiqEktVun3Rxg74SDsnDWtjSqxkMTLSRfMugKYh0c+T46HOLFlAoVAq2K/FzLbaMTAWmzQ83zX9jmGgediYPA931Mz1rQ=
Received: from MWHPR1701CA0016.namprd17.prod.outlook.com
 (2603:10b6:301:14::26) by BYAPR12MB3397.namprd12.prod.outlook.com
 (2603:10b6:a03:db::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 17:32:50 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:14:cafe::86) by MWHPR1701CA0016.outlook.office365.com
 (2603:10b6:301:14::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Tue, 7 Dec 2021 17:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 17:32:50 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 11:32:47 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 7 Dec
 2021 09:32:46 -0800
Received: from elite-desk-aura.lan (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Dec 2021 11:32:46 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add feature flags to disable LTTPR
Date: Tue, 7 Dec 2021 12:32:46 -0500
Message-ID: <20211207173246.1554377-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb9f344d-bf54-4613-68a9-08d9b9a79781
X-MS-TrafficTypeDiagnostic: BYAPR12MB3397:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33979D3ABEFB834761D6D7A48B6E9@BYAPR12MB3397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PhXV/O5tuglH63uPkOsKdYMWufa/e5nYslAD32lMw34q4mNn+Xr+5ZCGPjdUlKmXj+jwrCsQ7L6i1Pma46Xc9NbNisYQgvMypGEA5xoZpQ6f2jc9eSIQB7McsHUYV4VmfrPaCFDxn3aixS00PtfRbQ9x8EZyn4rPEvh4mCV7EUCa1rbAPuGxZbgC9mS7HRAovJ2NiQbr/KXMgEP+l1af5VHoWhMpISDdGIkt8GBpoYjGlIpb/OW0ikQCFbk5Mmg1XpLjkun9Hc/7JVEdpE0X3rw1OhDMkcs+lgXbUSeS31/iu1dXFZnIaZKK5OOaxIsjl14tffhvJeCybpm/qar4UR4xvFk3s/0285TJP5CvHY5Oj6MhBl/Gy2+gkkg22/ut6No5VnqPKXXhGlWEQXMRWpsz6iVVRcHCz9UjRZLisUrWq9VMqipgBx/K4L1I4cu+TdTaf2+/0Yv9OgqXVpnjNbejO2/4ewvL2oY4fErlV9IthfmZhcuLr0JLZV6m64BtzKL/63WxQbfz9jk2KkfOp3USkgHf6kmKx+2B2DE4vRp/G+GuaZZtaWmDcfWEZgEGJr94jkOp3fB1U9DRUc9pS9ChqPMzndat3kDfyqugrUrg1eTeWIuSm3KcARg20Hw50KjsKhIcrdCxMrtkoKRN23NZIuiO+/tyKvcXs6wfNbmQMqQm1IDH5OGkRqrJfCmKe5O7Jv3G+vY3UBJy/6MaNPTJzT3ncgzecB6cur7AL74MXZaHszdTFJH3vgvgSaUPp834Ij7BnL6ZlNKIxd2T+8+MTBG5ag9rPuSMs9Z6fALL3TlsuhBkY61p0vCSh/aFADWbijyXxWkUwfzIZO/DrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(336012)(5660300002)(316002)(1076003)(70586007)(82310400004)(40460700001)(36860700001)(426003)(70206006)(54906003)(2616005)(8936002)(81166007)(508600001)(86362001)(8676002)(6916009)(47076005)(26005)(356005)(186003)(83380400001)(2906002)(36756003)(44832011)(4326008)(117716001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 17:32:50.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9f344d-bf54-4613-68a9-08d9b9a79781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3397
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
Cc: alexander.deucher@amd.com, jerry.zuo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Allow for disabling non transparent mode of LTTPR for running tests.

[How]
Add a feature flag and set them during init sequence. The flags are
already being used in DC.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++++
 drivers/gpu/drm/amd/include/amd_shared.h          | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d25e5be77dea..9433b9a660e2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1453,6 +1453,13 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	if (amdgpu_dc_feature_mask & DC_EDP_NO_POWER_SEQUENCING)
 		init_data.flags.edp_no_power_sequencing = true;
 
+#ifdef CONFIG_DRM_AMD_DC_DCN
+	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP1_4A)
+		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP1_4A = true;
+	if (amdgpu_dc_feature_mask & DC_DISABLE_LTTPR_DP2_0)
+		init_data.flags.allow_lttpr_non_transparent_mode.bits.DP2_0 = true;
+#endif
+
 	init_data.flags.power_down_display_on_boot = true;
 
 	if (check_seamless_boot_capability(adev)) {
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 4b9e68a79f06..3c72208b4754 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -231,6 +231,10 @@ enum DC_FEATURE_MASK {
 	DC_DISABLE_FRACTIONAL_PWM_MASK = (1 << 2), //0x4, disabled by default
 	DC_PSR_MASK = (1 << 3), //0x8, disabled by default for dcn < 3.1
 	DC_EDP_NO_POWER_SEQUENCING = (1 << 4), //0x10, disabled by default
+#ifdef CONFIG_DRM_AMD_DC_DCN
+	DC_DISABLE_LTTPR_DP1_4A = (1 << 5), //0x20, disabled by default
+	DC_DISABLE_LTTPR_DP2_0 = (1 << 6), //0x40, disabled by default
+#endif
 };
 
 enum DC_DEBUG_MASK {
-- 
2.30.2

