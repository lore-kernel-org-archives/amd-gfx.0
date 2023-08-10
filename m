Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE5CC04A94
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 03:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FD010E639;
	Fri, 11 Aug 2023 03:40:57 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6225310E637
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 03:40:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4I2IYjGvHRsttrQqMaS1xfaesvghLVXqtFktlkFPqvfRPWDvwrqVvBbfngdxYy4RL2fh7kvXI0XDu7AHK6dd6P/IpvcKQg55IrpNZz9aQ+n5iRB79Pp4aFigzItOLqEk6PDYUIgGUNcBqPY9mK5iKYxUCYlJjxy6w93S7fszARb7HORw621ToZkwR2SsGcFn+kRqSdgbEBrWQjZynjqiu8/Rrz63DWJCjh+TtG6jO6ZCHAdH19w5QMVlHFzW10SjhQaAzqTJkfjt97fZv0GZ3Ommmmsgsg40K2jofr+XI/5yIrvLhVWAz0hOLc7dzjxqaSdXVZFjaSwjytzyLHZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taqJCa5qdyrhLBdalRcinMzR7Ycxkar6SmISpSQE38w=;
 b=Nn7WNoePscCGaHMpJGBA4NvV0oMDrPAun23VWyzJSCQlBVncGLBGt9lhTcnDi2h7hHzAUeHp3VqZXXXSIhtXMnLWcwhnhBDOXNcfCyrTSrlzeBQJFiTIX3LFOxQvTBtktEFo13ADhKsTWnpXQ+jHf66vXZ4MPDkxmO4aTxfhce8UgEtTzzLYI+1vtmQLkAWIqUJkqUfR2TbhpM/gy6+RBkfcLIhfxILlpzUeC4x1P1GoCrxzHPZLvYSoox8EAMVdvod/isjhnAUZ/hUOUPofp8UZKgDsHHFXU6rwCRKY6qpQ+7EV8WXA9iy6mlb++XWko080jcaaUfStawXxL5jubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taqJCa5qdyrhLBdalRcinMzR7Ycxkar6SmISpSQE38w=;
 b=Fk7mdp9iq4LHcNuak0A4trWkWeMwh1iMVO9LWyTmhnrQWA7//Et3b4XKq6siNOk7Q7PDS2tPYUJOFDSSnDO34OZqI1/DT7zXK/TaztS4tqoOCIuQ360tvIR+WkYJXVFy8YrN5Cpp6pVHW2reYPee8JkKak8u3tglLxWeTXNlcaY=
Received: from SA1PR02CA0007.namprd02.prod.outlook.com (2603:10b6:806:2cf::18)
 by PH7PR12MB5807.namprd12.prod.outlook.com (2603:10b6:510:1d3::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 03:40:48 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::3f) by SA1PR02CA0007.outlook.office365.com
 (2603:10b6:806:2cf::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30 via Frontend
 Transport; Fri, 11 Aug 2023 03:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 03:40:48 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 22:40:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 9/9] drm/amd: Hide unsupported power attributes
Date: Thu, 10 Aug 2023 05:32:02 -0500
Message-ID: <20230810103202.141225-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810103202.141225-1-mario.limonciello@amd.com>
References: <20230810103202.141225-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: b0aaa29f-cf1c-42b9-b60d-08db9a1cc0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aNPSHNJmHPl0B8KJq0guOws7k5gGJkU0qBG/XguEtGwUsQuAjJo8VWl00lVd2b+2v87S1p23CY+wGHX6YbewZYH9He/0shZA6v7hAjFiJVLwQtM0YizlTRZOwjMRFS6WGV4ZU1bPdjuX7l0zInTV95ZN7inRM9rmPmcn8j0jh1HI8xv9vUI6MPL4/Mu878BpMErT81PhgAFY56mFIT7unT3ETq8adJBbgYBsLBCXfq8/gTHQC+JkTNsEfUoOEhMBbAWVUclyX/O6vuHQSpQIbOpLyP1stEXZxDeqWMxyfEZxQ67xUuszYdbD/yEuLfNY43rhS1yKACVzeAQHkrs+veJAxVHYM2Fv3/44lH7en16p/6vZvjKP0m2WWEgy7yNMxZTKczBZMzkiFmb6H/4xmodaVQ9z0MHrSkuNwp8gZYqfbLS6ZDEN07qCxTi2jditF6PEwl6rpl1X5KTgPEtsld2drTSHw00As8Kh+DyDEH8B/aVSFbzPh5ufk936fSTmkweBEQFPlZIxX3enGCdbz9ShA1PEiZPP4uJIeCZWos4hwfINOgksjqLT+aDDhaEJQ6gd74GeJRrCjHH7WqQq5lDaeP1lEFp0XIUHdp3AA6bnS0XHi0FoJKKtJ2rd1c98Txf0jwHAIFFsC87+5dl3qT9+Q8YZjDrRhY2ldsEXr2psFZHZRXAQNE7gVEP3r3jzqUFlXIKg/jFY1GGdQqDvV6Ids+8GVY8vttUXvMrl3e1/2ZOzOYHCVly5ZPiDEe7Hou4nA4gFo24AXX5DiMIg2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(1800799006)(186006)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(316002)(41300700001)(8676002)(44832011)(6666004)(478600001)(7696005)(1076003)(4326008)(2906002)(26005)(336012)(47076005)(16526019)(2616005)(426003)(70206006)(6916009)(5660300002)(70586007)(66899021)(40480700001)(36860700001)(40460700003)(82740400003)(81166007)(356005)(36756003)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 03:40:48.7350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0aaa29f-cf1c-42b9-b60d-08db9a1cc0db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5807
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

Some ASICS only offer one type of power attribute, so in the visible
callback check whether the attributes are supported and hide if not
supported.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 8133d968f75b9..5b1d73b00ef73 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -3179,6 +3179,7 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	struct amdgpu_device *adev = dev_get_drvdata(dev);
 	umode_t effective_mode = attr->mode;
 	uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
+	uint32_t tmp;
 
 	/* under multi-vf mode, the hwmon attributes are all not supported */
 	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
@@ -3264,6 +3265,14 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	    (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
 		return 0;
 
+	/* not all products support both average and instantaneous */
+	if (attr == &sensor_dev_attr_power1_average.dev_attr.attr &&
+	    amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (void *)&tmp) == -EOPNOTSUPP)
+		return 0;
+	if (attr == &sensor_dev_attr_power1_input.dev_attr.attr &&
+	    amdgpu_hwmon_get_sensor_generic(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER, (void *)&tmp) == -EOPNOTSUPP)
+		return 0;
+
 	/* hide max/min values if we can't both query and manage the fan */
 	if (((amdgpu_dpm_set_fan_speed_pwm(adev, U32_MAX) == -EOPNOTSUPP) &&
 	      (amdgpu_dpm_get_fan_speed_pwm(adev, NULL) == -EOPNOTSUPP) &&
-- 
2.34.1

