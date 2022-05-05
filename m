Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05938C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 20:08:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FE6910E705;
	Thu,  5 May 2022 20:08:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D451F10E4FB
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 20:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNLJD2eXfGtnSKd5UDPSD2DStsyMGIYj34xlGcUafEmDpksf7T89uF8pnDFg9CpX6PDckpH3zgo9w4dLWVAyBNJ5xiuFQdiltMNcXaCczD1MOj0hIsLZQcEQUY2uaGJx4kO96HimwO3nmryd64gsG2s4qImF3ABYG6JS5XOuWoT3AsJ8XDMXftyiKPhrg/kMHk02fa8+1HFo8bmQUHD9yZD+RYj36zOjn+1IaWRMTwshy55jvB6dwkPzAoNmTmQHoJG2554xMsTzkWpgdjz30VMwEAnNKzepiWylydvp8mb0MZfTlyUUI/uH3xnM8x5ICuWDxi1HCAKIyXN/PvEJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIxz5PgjdhpNGI/cG5MekXT2thmvYzOXVHYruNXPlk8=;
 b=DKfdBR6Gz72prQryjcgCz6P/1d2+yXDOOFFah7iFvamTpjLju8imA9r9+Ey0BBBluCOBeyabKrBtqXs75v5QnLKpCV4HsCj/ehP6Ghf2QeZdSwdYEadJY04rA2D5DI9iUE4XD0zC3MtFBeMnZo8vBnqr3xbWWNkzvWX8i7QT1m1lOCwr/lTlbj9i6OvS/yznnFat8fH36wYFiESjybUkPiq0Z7SIi98YqbvkIxmzRw7mKtY5MCRfUCieTRwVCrAfVH5AkcA+UdKpfOgWHh1ts/fgd7vSLNLpxZmUdsMbUx/kblM/dpj9cs8WJZj0KCRn2ay7qtD5LAOyOlazGzGBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIxz5PgjdhpNGI/cG5MekXT2thmvYzOXVHYruNXPlk8=;
 b=KC0iyi2voi1w/Zd0DtPEsgb5g9zH7I5EYfXz69xPNzVEdrtq0ueOb1EkgygD56vbIKmAHCIq7UsaYzTvLAaucgwwAbowCY6YpE8+BDKj4kG6WFVP6lamv9y/ZQS9ZC7GcgWMjT4lStd2JC7AOYPzq0XhJrxpXoYcqiZf8W4/LxU=
Received: from DM6PR06CA0065.namprd06.prod.outlook.com (2603:10b6:5:54::42) by
 DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.24; Thu, 5 May 2022 20:08:37 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::5e) by DM6PR06CA0065.outlook.office365.com
 (2603:10b6:5:54::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Thu, 5 May 2022 20:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 20:08:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 15:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: enable gfxoff control on smu_v13_0_7
Date: Thu, 5 May 2022 16:07:46 -0400
Message-ID: <20220505200750.1293725-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505200750.1293725-1-alexander.deucher@amd.com>
References: <20220505200750.1293725-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6289b26-ac4f-4b76-575c-08da2ed30a6e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5988:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5988FC5953DF438A781CDE53F7C29@DM4PR12MB5988.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hXQeJf7lc+WgjoYv79lD46GFS595DAnxeUuSiym0Xus387Bkej+KdQEaSUiVzo3lr5/yehCn2IXFu2ZpmcoY6aTZNJqHUR6pOaQFIKxdIfD1+R/LXShqp8dWz7G42L4xjlS6tBREOOSdioJaKYrvmsnAQcwgkdJJn/WOvlcGsI9oGAhD6SMS8ZFfBUZmHB+XjaebP//437Y/jjPyP6VXbOp4V6V4x6u+QEkUxc9me+QUQkXILJfGYfPjOitLO7svo2qCp/EVpQbfo3p0voFMq5p7PERc9F+LVjlfQV/gL95LpRyhQ/pIPWGAs3H5xPFuMGjZWOa4gA8AXW/NzdltayuHebYo7Kejcy9YOotAjA4ubpPLxiuRcFqqyzfgTMA2DC0Lp5kugaLdEVhXVU3PUZGdPmPoIWU96oH+x+LkUoNiB4mWpVMLo+OAGPPIKiSZ9kzRMCgV4Z0A8Yt2KjSEgadBaHacga7DFDEabRiRU7QwHNG0EC6isrzbO8chD8YbcF61n04EXkrdl50TPrEUZ8oUedqWHH6lFEQvH5BW7WzV+PYY0WBuk6kydeFUY6PjUPaZaY6oM/aQKWqBh8TtKRkxhBKu4RuzuPW+sBhZybejIDTUoTdZS6qra2BOw9SaL40JHRj6h9H/4bGq78MuxM1kRf9j0Pb3lyooZJaGWGtqG3wJfMOwga/FAn+U5tfBCrxkFZxAPnbi4wRQz/rW4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400005)(336012)(426003)(186003)(16526019)(8936002)(5660300002)(1076003)(8676002)(4326008)(2616005)(40460700003)(36860700001)(70586007)(70206006)(83380400001)(86362001)(47076005)(6916009)(316002)(7696005)(6666004)(2906002)(508600001)(54906003)(81166007)(36756003)(356005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 20:08:37.3233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6289b26-ac4f-4b76-575c-08da2ed30a6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Kenneth Feng <kenneth.feng@amd.com>

enable gfxoff control interface on smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c               | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c       | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 7c75fe51ec20..e9649ef835c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -5212,6 +5212,7 @@ static int gfx_v11_0_set_powergating_state(void *handle,
 
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(11, 0, 0):
+	case IP_VERSION(11, 0, 2):
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index d73deb3e596f..aee1741d98e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -834,6 +834,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
 	case IP_VERSION(13, 0, 1):
 	case IP_VERSION(13, 0, 3):
 	case IP_VERSION(13, 0, 5):
+	case IP_VERSION(13, 0, 7):
 	case IP_VERSION(13, 0, 8):
 		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
 			return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 92e606a72a85..8d687d5e2f80 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -113,6 +113,8 @@ static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(DramLogSetDramAddrHigh,		PPSMC_MSG_DramLogSetDramAddrHigh,      0),
 	MSG_MAP(DramLogSetDramAddrLow,		PPSMC_MSG_DramLogSetDramAddrLow,       0),
 	MSG_MAP(DramLogSetDramSize,		PPSMC_MSG_DramLogSetDramSize,          0),
+	MSG_MAP(AllowGfxOff,			PPSMC_MSG_AllowGfxOff,                 0),
+	MSG_MAP(DisallowGfxOff,			PPSMC_MSG_DisallowGfxOff,              0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_7_clk_map[SMU_CLK_COUNT] = {
@@ -1486,6 +1488,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.get_gpu_metrics = smu_v13_0_7_get_gpu_metrics,
 	.set_soft_freq_limited_range = smu_v13_0_set_soft_freq_limited_range,
 	.set_performance_level = smu_v13_0_set_performance_level,
+	.gfx_off_control = smu_v13_0_gfx_off_control,
 	.get_fan_speed_pwm = smu_v13_0_7_get_fan_speed_pwm,
 	.get_fan_speed_rpm = smu_v13_0_7_get_fan_speed_rpm,
 	.set_fan_speed_pwm = smu_v13_0_set_fan_speed_pwm,
-- 
2.35.1

