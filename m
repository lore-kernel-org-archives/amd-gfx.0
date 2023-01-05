Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC26DC4708D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jan 2023 03:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C3610E62D;
	Thu,  5 Jan 2023 03:23:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D5A10E62F
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jan 2023 03:23:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAkfbUr2TB88jnwfKYEpgOXPncoZ+5XXIqg8DkLQHvyCB7NSxuU4lfZhZG+zHqQyFl/X9vQjurlbMyKkroRUUSfaxH/2zw+VhLbJXUoB4InbUxoxOPC+8UEP52P7CO42edaNwmCvQUQGqe1sjvrfmJAXPwSN11qJHHfdJHOCLjWcqdeWewF8dxPVfdJiEqKWN9VIZ2gwWnHTQsYRbArxvKWW0T2ynbw1PnfyO+OJJMLlKwagNSnDmxdu+xhIfq8/YjoMfF8Je8tydrnIydFP+MFBI8cjQiHehP1ykFGvWpoqakU2XFRHWh3jpj5xsUhWzKdLHjAQRgtY4KVPVyujBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuT2W9RRTiZ0K4jbWBYlzXfekAhsJgWOs0DxFahk/XA=;
 b=K14djxGIbbDGHD06ZF9LIxxOoKYnlmv5ev+WAeGVYqDVHOr2H8T0SwzE5f/5c7H7eh40F3TVVbT5dUrrVjF8MrS2BiNABEs7VCfBitP4zO2XJ+Q7FutR0u++7nn1J3FqiX4cF0xhjcewdYLyKMGhSSJHjLlxow2nwwMiAZ5IF5l6ttaUvj9JFUV8021keuQITAXChYXZQif38/oYM292L8V8KL6+hHx4Lrj2MijMsMjMqMpWjylvmixF0wOwpuWmIBktTuM3HUfiTM8ijsx3S8scPHTWaRnzK7RnInM7XT5KKIE6PnVBjwANwwfiPtEMsQXoqo5tIFybgpWO9OXZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SuT2W9RRTiZ0K4jbWBYlzXfekAhsJgWOs0DxFahk/XA=;
 b=kZYtK3DnjipvTOypXVMpl+lDRcj6LJsobJF2W1XyWxJQQlH90Tgsng0Cg7JCtUbRkfxn8+bdi7aFIQm00uEiFi7ucS6Tpy6argIhAYuBU60Tl5mFS4aSqrxZVaJCOlcDg2VEplNziP3wQs7uWgIIKJ7ILU7aKjfsoJGoU/1EOAw=
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 03:23:32 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::76) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14 via Frontend
 Transport; Thu, 5 Jan 2023 03:23:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5966.18 via Frontend Transport; Thu, 5 Jan 2023 03:23:31 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 4 Jan
 2023 21:23:27 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 8/8] drm/amd/pm: drop the support for manual fan speed setting
 on SMU13.0.7
Date: Thu, 5 Jan 2023 11:22:59 +0800
Message-ID: <20230105032259.2032789-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230105032259.2032789-1-evan.quan@amd.com>
References: <20230105032259.2032789-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c03fba5-9f0a-4b59-abe9-08daeecc38af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u4EvpToNBDX/q/00W7tv7Zw7OzAXWt1bZsBw9sH3bLt3RfA0cMpwohDzl+ZGLzF3hAW8LsW51Kflc3lRQ/MXfqzOMEzIehG99AyUVMYSbwISIAThQoBCiMVLJCh1yb5a3MkhD3P+IREVCw/yrQ//JJGqG7PCOfCqm222S6NXJiIqgQeCOTVwc9ACWuLV2SFbf+kjFXYem2XJYZwBUv5rJgNFBo5cEQdXuELo2SnPjPV0ptgWMr/5rbhyu+ynYgZd74uEpUUVaOdPebfzMCFOdb7o3h5DwV2oRiN7sCq+7E2TNN/o1/95Tf7ebW0hICaHFBT+wygWq4SlHmxrqBpgAaTzopOr0j25W3w1qBxNL3zOoEm3S/JB+dBYW5/agArTIQpJVZJ+425UHdQKBst8VowEhjoF+1FWGYcRUIy7pE/hzGQ728h11YBXaGfSYw/LIbBq+XPw3JRymDFurjCSIa59ih/SqiH4utvow5+iNy+zMO/HioiH8TMfuPqrBtyo5tR0Pz5c0CYspxXv999n2DXv8VaNAxqvwGEwADxoDvFaeDsyUT3jKikRbZKBUoAYh3Oi8LS0Le34HHkSfblfGLaUrUg7LdGZu8Z5J7P19spceEHbRWOlIfV+baKLDVuN8SZqtYdZXpoymslyebFGoV3kXc4+yaz4x0fKNGGjY62lvpf/uFeBicWuQ4e6Yhz1Fokm/88om4HJwB/W9ixkMw2RBVetsCbSXMLthnTJcIvAanRLhxaAUpMUs4WKHdBC6VElSMwYOmqAVnYVHLnHT8xUgSim4sQrviyI4mbG2YA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(44832011)(356005)(8936002)(47076005)(5660300002)(2906002)(426003)(36860700001)(41300700001)(86362001)(82310400005)(40480700001)(82740400003)(40460700003)(36756003)(7696005)(54906003)(186003)(81166007)(26005)(6916009)(16526019)(6666004)(316002)(478600001)(8676002)(2616005)(4326008)(70206006)(1076003)(336012)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 03:23:31.7653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c03fba5-9f0a-4b59-abe9-08daeecc38af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Due to lack of support from PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I8439e72b95ad2fdf8cfdf1edc4d9c8af58109dc3
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3608540f2034..c7fa203ec7e8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1736,4 +1736,9 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 					      BIT_ULL(AMD_SYSFS_IF_PP_DPM_DCEFCLK_BIT) |
 					      BIT_ULL(AMD_SYSFS_IF_PP_SCLK_OD_BIT) |
 					      BIT_ULL(AMD_SYSFS_IF_PP_MCLK_OD_BIT));
+	/* Drop the support for manual fan speed(RPM and PWM) setting */
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_ENABLE_BIT] &= ~S_IWUSR;
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_PWM1_BIT] &= ~S_IWUSR;
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_ENABLE_BIT] &= ~S_IWUSR;
+	smu->adev->pm.hwmon_if_attr_mode[AMD_HWMON_IF_FAN1_TARGET_BIT] &= ~S_IWUSR;
 }
-- 
2.34.1

