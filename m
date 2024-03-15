Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF21C54E58
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Mar 2024 06:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0CEB10F95D;
	Fri, 15 Mar 2024 06:32:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JKMSCuul";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8CF810F95D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Mar 2024 06:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHrIDNaloTVyFJWWrhM38LucfxzUy91pVIRW4Rs7MQU0osC7B7by5kXD6y7Vs1MPc+Ap2NxcV1Z/5JfMPwquDNRKboRdqj3R29OJk63sckbdruwtOl8LKzW5F3/NJlVCtp7cpeCwbQLlcFh8wOrfYnpHXiB1DbbuPGBCUeiMehmcFsQ1GQ5z93dbrNcXtS7Q/211Ylb251keGwiaV+9y/jYwRmDXSkI7NpLn1c9yLDbSWQKatk+EkFrbvb/6D5bVjAe3XRUG0hBpO9Qh1DdkjPp+IZrI3vwERfZMbid8DaRFd2iA2ujdfwSUd9TjXCgXfDP6ySe7rRUmzhriMVsvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G18vkhMF9gOdRe1/+228O42gHrjkwFMEizs24lHGlXg=;
 b=lY5sD5n8QlNNSjFpyy206ADOvTbz+uhNRZjDqoI6883CpmWwTPUE8PxJv49JSjK+dcxl6pMyLxO1xD9UdsXjfKB92/GEgIFnPORcuxZBTgATQDISyKUV2PmzF0CJA2P9UZyxTSGrvhC96PE/YGqkl8G7rsRc6yrESs2fhDoXH1XnsGeOPwPQ+ykxHrMaXvvZyElJBPvyhyECeaTy7nMK7mM5ikDK71e/5T+lh42dhv0k+qBNwI/GRJG5apXpWOp4C5VzjJ4YlhAjuxJ9wLXnYsp667DKsC0m0lLDlDYhBqKVq4koa4mmMHXdGp6JjrHMtRO0jcG3SAwhM82n4Rqwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G18vkhMF9gOdRe1/+228O42gHrjkwFMEizs24lHGlXg=;
 b=JKMSCuulIhFj1EBQ8BKGOTOweZPKYdJA2M9BmnYFn4J+YL0KLSGHXYLnxhKAkH22MgNnF/9jBDK4Y6MIIk5w4cJsVPGQmx4PXjKIPow11lsom66Wd+WxzVr4wdWi8MKrFmYDIReFfbE+q8U0EidAeSQTuCoRbERLshGkOaEn4Kk=
Received: from MN2PR20CA0001.namprd20.prod.outlook.com (2603:10b6:208:e8::14)
 by PH7PR12MB5806.namprd12.prod.outlook.com (2603:10b6:510:1d2::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 15 Mar
 2024 06:32:06 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::5a) by MN2PR20CA0001.outlook.office365.com
 (2603:10b6:208:e8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Fri, 15 Mar 2024 06:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 06:32:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 01:32:02 -0500
Received: from primary-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 15 Mar 2024 01:32:00 -0500
From: Lin.Cao <lincao12@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <haijun.chang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, <zhenguo.yin@amd.com>, <lincao12@amd.com>
Subject: [PATCH] drm/amd/pm set pp_dpm_*clk as read only for SRIOV one VF mode
Date: Fri, 15 Mar 2024 14:31:58 +0800
Message-ID: <20240315063158.18105-1-lincao12@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lincao12@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|PH7PR12MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: fa87765e-87a6-4481-c458-08dc44b9a27a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1TOxkzlUXbtH7Y7HlL2SdgQj8/cGZiw+vt6RoxeeNreBoCAuusDJTmPompO6d9EWiJdhWvgHX6OyEkFlF4phNvIdTDyiKSMJZFPD106oe4faHw4M9Edv8CUsJpHx6/FeqcEpVERcNW7G0hmbUHYMzTbZEnKlUrsouRTTenputPaTsrzNgD/eX3cITXCmXZfJ8MrwclBNaF1n26sipTgwp4FugLnM3juZBxpIvIQPOJrSGEffkhtw6Khm7I7ysapWPQ3SHB5UJIY32/wKGFSs5lGG9iggp4J52S6GHYZ66/oIrc2j24w5uBRyFk3cJbnFMKmruGORJNlEuivxvesuz0gcRFhyXumZfcmsAS4teNtsB8MSi39d6QQA+UtOxLTcSAYn1LSTQTvG7pXKIqIgCSTScRPqtvQYgUGzS1cFYf1K0BlV45LPLR3V7im3thJA8rGFo0ymroNULXoKihIIKiwwOVfEKOgSCl38hT3/d8oZP+O9owKH274NbfzyO4NkcF4sF1olUdK699xJGseOkJ+lQz/spgX80kqeztqIlZc/pVplytUr3gyoLcWNWyFmLYuztjSgijhf1AtRWGnNNOgtdYDbYsZYsZGdoVmOWF0QQ/v7owOZoRO232H3xTSD8/gP0rH15jtRXlRtqzZcwf/8fA5K9lPCXXbAZxrEB50y+TbrIKn94G+lXzcKyB8cHgU7wc1MXeELT+7qSTY/uPGiVjXMRExOkyIjuGSKU0eUMISgSdKEQtY7u7sEipu4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 06:32:06.4892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa87765e-87a6-4481-c458-08dc44b9a27a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5806
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

pp_dpm_*clk should be set as read only for SRIOV one VF mode, remove
S_IWUGO flag and _store function of these debugfs in one VF mode.

Signed-off-by: Lin.Cao <lincao12@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index efc631bddf4a..2883a1d873ab 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2367,7 +2367,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	}
 
 	/* setting should not be allowed from VF if not in one VF mode */
-	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev)) {
+	if (amdgpu_sriov_vf(adev) && (!amdgpu_sriov_is_pp_one_vf(adev) ||
+		DEVICE_ATTR_IS(pp_dpm_sclk) ||
+		DEVICE_ATTR_IS(pp_dpm_mclk) ||
+		DEVICE_ATTR_IS(pp_dpm_socclk) ||
+		DEVICE_ATTR_IS(pp_dpm_fclk) ||
+		DEVICE_ATTR_IS(pp_dpm_vclk) ||
+		DEVICE_ATTR_IS(pp_dpm_vclk1) ||
+		DEVICE_ATTR_IS(pp_dpm_dclk) ||
+		DEVICE_ATTR_IS(pp_dpm_dclk1))) {
 		dev_attr->attr.mode &= ~S_IWUGO;
 		dev_attr->store = NULL;
 	}
-- 
2.25.1

