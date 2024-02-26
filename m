Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81530C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 22:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7A0410E5E3;
	Mon, 26 Feb 2024 22:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vdmmjwWC";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2089.outbound.protection.outlook.com [40.107.96.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A2710E5E3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 22:47:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U876Z1yGqneaaeHcmGl+q/OVaN0J+dkPkMSqp+0GQLatxFSOc0E4TxWAdXIOapaG4CAKmvgVCjg2R1pE3zFWh9xXrLHkJ0DsYqd4GHS86uyUEgyVgEdgx05vq+Mey4GkjM2dTOtmcxOSOfro9Ylw9TcOE+yTQKE4170oq1xGhOA/RLr4NLSsC3VG97kCRSVYuD549MtKPjFUwL5zseE6DNu9Y3fzCLDai6bDcbtQoVZI0B8rCGpcV09qPyV7Y8qT54awmxk+XwzDYejosrc5oI2mvSXIfzKu53SaDWMYl0FYIytBVepDmY6K9LQafPcagAYbuSs86ZCIkxohEWBz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cob5HlNbqz4Fqk8gNOOkV+RzRDDYcYTezfuwh0wDKAo=;
 b=L5g16NW+7lK0cIguX7Ncoh3lij2pM62HaWCN8aNiX2ox4xgvYvx1zqScNxOTVw/3tMrHhacoliWNh0DcfNSgTyvj7zltRDCXpA8WF+2uPskjlEvrJeqVxeCVFcOyTTMZAlXGokTkqhKEwF+CzqiWLjn/8IbMRg+cxjxYC4OZJ5OOtSf2KSr9w3/ReNhqNi6jE3mYuOhy2UyUBbAc2eVkxraROhgQbfkfZM65oz+ZHYaeSyC4xXCECFGzEMCv69GaA54cj79py3RL9abPPaEr5C1aDi2SHwQvWRhhakPJc6LhlaOPsOCUjEt+Z0mo3a09nDaWrZXBOoSMxLlyUQ0lIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cob5HlNbqz4Fqk8gNOOkV+RzRDDYcYTezfuwh0wDKAo=;
 b=vdmmjwWCJ3bxmhuHlqzJ4aVmJF83x8L0Oa9MO3YLj1eJ7dKulGCGJP6TKScyjyNP6NHAX/rIZnYKc8hqFgUep0Whhw93hhbYt7LlHwocxsj2cqUn/h8Vl0gKHMitQe5MKcD3vpt6NNX8gkK2egiGlavUtiVRwq2hm2IySPt9kOU=
Received: from MN2PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:d4::30)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.31; Mon, 26 Feb
 2024 22:47:28 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:d4:cafe::ed) by MN2PR04CA0017.outlook.office365.com
 (2603:10b6:208:d4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Mon, 26 Feb 2024 22:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Mon, 26 Feb 2024 22:47:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 26 Feb
 2024 16:47:26 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] Revert "drm/amd/pm: resolve reboot exception for si oland"
Date: Mon, 26 Feb 2024 17:47:03 -0500
Message-ID: <20240226224703.1254537-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: ec48e230-e542-4053-c46e-08dc371ce8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y/vdcMQXH2jPg1HFi0E4OmDQEK9IAiHBurfIW4K2Bp2dUZfJl4CRFZXenZqMXn0QryGIkHSEqH7v10bHHsigIxlsfIoykssSMP+dDv6oQTWQJBdkiQc/HJeSiCiOBevubLhCfNV9Ayen3VxSdCu6Sm5cwmJhgHoZiDM8KGz9aBN1VCwSP7PKZVb3MQt0ZTQxffQl8z7zsQdI7EYw8HiDOwSSAuzRT9LtKTvx5awtAOIdIeqqJC0kdAna7ZDBgBpx/pkZ4NzOremQ6mRQkxSgRCnMQHKXXh79fK1UVPHWvoH5Vcw4sx1Wn8eV0fASpz2nQA3kCasQlZ1Ebag9+CPs0Rs6AmROzwXnZBQHeppVLdXnoP4XrzdIx/qLxETZJvYy0j5wJJv1YHE95CskGt4laV7oOr5WgiTtUj9oayP6cNO4mqi5FScN5L11Tx2nMFM9MPoezfr6ajPP+ZgdtWjicfeKjx2sjY4YS2UnYcFCAnhmD7z+Z8QVic+1T8Pf9VJ+R1IvFgZ4Ah482TCjf08up0tpuA1eYf4kA4Fuywq8Ufghdlcae5SfBTpRBuURKMsbzRgCrpwF+AHhiVNyNyh+V99XuZCJuB2iBX8JFhabwArmPr/OjRC4LqCu0bbSDfkIPROiJC7Tg61XHANMl5PaNo7uE4Yx0qjmgH4Cz7H4nWVT6CxfN74R+8wRtzzqJTsWMWBCfiDglB4orFcyFxfWK73C5c+iTDUTVqevKeQpe2g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 22:47:28.1547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec48e230-e542-4053-c46e-08dc371ce8ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
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

This reverts commit e490d60a2f76bff636c68ce4fe34c1b6c34bbd86.

This causes hangs on SI when DC is enabled and errors on driver
reboot and power off cycles.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3216
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2755
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index e145d53a794ba..a586e0b7c47d1 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -6927,6 +6927,23 @@ static int si_dpm_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+static int si_set_temperature_range(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = si_thermal_enable_alert(adev, false);
+	if (ret)
+		return ret;
+	ret = si_thermal_set_temperature_range(adev, R600_TEMP_RANGE_MIN, R600_TEMP_RANGE_MAX);
+	if (ret)
+		return ret;
+	ret = si_thermal_enable_alert(adev, true);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 static void si_dpm_disable(struct amdgpu_device *adev)
 {
 	struct rv7xx_power_info *pi = rv770_get_pi(adev);
@@ -7610,6 +7627,18 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
 
 static int si_dpm_late_init(void *handle)
 {
+	int ret;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!adev->pm.dpm_enabled)
+		return 0;
+
+	ret = si_set_temperature_range(adev);
+	if (ret)
+		return ret;
+#if 0 //TODO ?
+	si_dpm_powergate_uvd(adev, true);
+#endif
 	return 0;
 }
 
-- 
2.43.2

