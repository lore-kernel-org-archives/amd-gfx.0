Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE079C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 19:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7D710ED07;
	Thu,  5 May 2022 19:42:07 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2088.outbound.protection.outlook.com [40.107.212.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DFB10ED07
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 19:42:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCdrJ1Dg5MjUefENs41NRYujB9DJGFI4H8a954ymIFJfMYBjY1rFKdMcZbdCn61jQmVOcOZSsqLiS/w9R177NxYM9Hn5ME5xolv3XF8Q6nxU71BsLbXWeYh582JpIVPM9g64/tr7+we5JUQ3r984W6nskVJa7dLVPUESnhSFFqFwfEBlFjduo8CC/bdYssnIiHUKIK4vjonOJPcq81l8n9hMV/FLCianq0/tkiPq2LcD1shDGqJjtPjNoD2DmQq3Jjq6oxa5DRsnSnyRdOwAmOAA7tePhrhEvlI62O+9vpXWdBadQ7ArPM0YavZr5UjnTngMax16dtckCpGdepPIWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G2oJVhkT1f+Da/Z0z58FpioDRvlAW4RoKsyv3PYMYk=;
 b=TnYO/zAVZT6RaNQER9EPOxRET5G4MW9jMQTJk3glUsm7+gFer7P91cIsFP5XSZP6zb0h99rsRJzFwW0YWRGO2C0i7MdGNjktyiLSh8rL97+OC4qAD6tWYLmJpFoSWgF/1Y9HG3yaLFNxkPbNAW3P51pSi1eXEcuOOUzca8dLg5yeuq73+gzjjVPD54LhMF0k0f2Ihd4xih+bK3P5V9FKfXMy4l3w1lKvmd8kKZHyF6VlmND2o+Xz0UuHq3GBHLzTvIaQyQukW0WAPwgvxmpn+4+BcaMus+6f1AnwWM9l5k0QEqpezG/oZPk2TZJeIROsqsLhBHsGOdD/P6RjX0tipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G2oJVhkT1f+Da/Z0z58FpioDRvlAW4RoKsyv3PYMYk=;
 b=XsqiwKfCC9qqAcRVzS6h7r+qdLAb7WSLG1oz/BsEmybYVVAammjGsgvFUQ4x8FjI3pTEY5XoqsPO7L1so0PbEp1c8l3kbOJY+7zRbcNOkEgVqfGC6IxQivYXb4zBtcNZ5ALi1ecKHpLwIP19O6YS9G5TlF0Hm4lZR1ego+oAcn8=
Received: from MW4PR04CA0195.namprd04.prod.outlook.com (2603:10b6:303:86::20)
 by BYAPR12MB2839.namprd12.prod.outlook.com (2603:10b6:a03:72::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Thu, 5 May
 2022 19:42:01 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::c9) by MW4PR04CA0195.outlook.office365.com
 (2603:10b6:303:86::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 19:42:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 19:42:00 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 14:41:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 14:41:59 -0500
Received: from sriov-MILEVA-7.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 5 May 2022 14:41:58 -0500
From: Danijel Slivka <danijel.slivka@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] amdgpu/pm: Disable managing power profiles on SRIOV for
 Sienna Cichlid
Date: Thu, 5 May 2022 21:41:38 +0200
Message-ID: <20220505194138.3462916-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0223bc99-7712-418f-91bc-08da2ecf52c8
X-MS-TrafficTypeDiagnostic: BYAPR12MB2839:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2839BF4A625C454BB595AC1398C29@BYAPR12MB2839.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qpaGxpCv61BnnaR9q5wIv4t8jvN6fLLm//DMgjsGRMUMyBe8uU7lhVPa5UhOH/SysG+CNm++7uik6avRJQeqN9tVAVMUXXb8HXCZI8wW6cIcC0QX35J5tyH4ieW25Fh1LpREI4oSWapRGTgwCXriafxb39OVgVxEOeTlENv7JXzs9rRSDdKQZt5hP4HZD1bssGkEb5dzxzA3zlpZ7FRfOvvfgPJx9oAJ9Fhwo9QlbQmHpJQFPFNNftywEH00yTFgwbM6UEQKCI5WHuKp/VDZ3atERvpTHiqPVBe0TP7Gw0BDXN9wA37wxH//ATPkPAPexzmt4XeXMLgT3eanVGfHzI7qKFzOJGjiyS8R/aAzBYJZlsP0PARpzMmZzu6YmKqKZYhY3NVcJsJ3noNqU7EGaUWDXNDabbRR9trORo/29wLiR4cIbRITFWvp1Cc++gjgrMvtHB9wG8bif5fmHEXFxl9iJeUHHjylyG9tajQsJfLulxflMFErbxaNhDcnYeq3s2JstbHTmLqdKRPq7xLNUgWSApz+B20ihIg1l/9sXlv8qBXXvVVZY7C5aKMTS+nqFJFnQNk/IWNPqg1LHUNlB416E9yH2VBT0uZD6jrXHnEyezRX8yLhW0rQUwrPQzf2hMqsl7zRC2hLtVQR1mty6WkxmKdIfl1mltcjKNjuEmzBfen57bI3KcHQr7uKMtremIZsTpWn49j+BdmL2T5qg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2616005)(6916009)(86362001)(36860700001)(508600001)(7696005)(26005)(186003)(1076003)(83380400001)(336012)(426003)(70206006)(70586007)(36756003)(47076005)(4326008)(8676002)(44832011)(2906002)(82310400005)(40460700003)(5660300002)(8936002)(356005)(6666004)(316002)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 19:42:00.6612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0223bc99-7712-418f-91bc-08da2ecf52c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2839
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
Cc: Danijel Slivka <danijel.slivka@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 70a0aad05426..e96216ab9a39 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2025,6 +2025,8 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 	} else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
 		if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+		else if (gc_ver == IP_VERSION(10, 3, 0) && amdgpu_sriov_vf(adev))
+			*states = ATTR_STATE_UNSUPPORTED;
 	}
 
 	switch (gc_ver) {
@@ -2038,6 +2040,12 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			dev_attr->store = NULL;
 		}
 		break;
+	case IP_VERSION(10, 3, 0):
+		if (DEVICE_ATTR_IS(power_dpm_force_performance_level)) {
+			dev_attr->attr.mode &= ~S_IWUGO;
+			dev_attr->store = NULL;
+		}
+		break;
 	default:
 		break;
 	}
-- 
2.25.1

