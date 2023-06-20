Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62680EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 03:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E68D510E07F;
	Tue, 20 Jun 2023 03:45:46 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5972810E07F
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 03:45:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQZGbA9AfN6tVGDt47ybBpYXs2aJ6IGTP4xoXPCOyeMeNXWZntcTKxlzc2vBSx8WfHbZUq0qmmIwPgSHk0e1TImUpYsEd/NtHSeHmzb4ZtEg1Ia9iSfQUhAxF2IF8mVEncT2t5Ri6Amj70UpUfh9qpafX0q1O+/Sze9l2f0Rjb4x4nVDJIWfX0GYEtf/ahWJ/kDscx+ArktUZh9Vy1kuiUEMM5BlIs9oeNL9ZE9bJ04KFMO6I51MBAnxqzg4dcO/WepXQpKoRtMd+p5mNUH9ktvDpp2bAvrFBDDjT5xoseNLTMDuSrhGXqQ22HLyF/2sUsLH6UJ6XH9x7loPK8glnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IC6BZoghhQPQol4Avy0T16WVyR0ZT4peWhLm8bcOa18=;
 b=lXFm5Z4hi02MmYd9trsgrHous9dYED1wzT1mhvxo0SuYNKhC0FCQNb/8KitZV5JURhEjZLw8zRKeEi6dKyJL0OhKbvmumS/Xma9Mu7c91eMIJ1rZ4dz/UMDX028frG/IrYM5sOByRQxjCL6RC3UOu9hC/PParOSEAlH2zmFxiFYFByiUYXoiwN/vLW7EuXCtcM+BsHOIZ/yHXplLGU3jZXKSPvOJAxQRusU43S/4pmXEJiLuqPZvta/zJ5fZODt3QmloSYTiD+MI7Ix66dv+4ukoaTC2fTb3VOMqYvS4v33KBekKjUTuj9Yiq4NZ6mavnOVierBx2/ODQ/hTfuSVXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC6BZoghhQPQol4Avy0T16WVyR0ZT4peWhLm8bcOa18=;
 b=VeGrpBs10ClFfd+O+L63VsUEscvuc9+KzCkbNeyJwTLmEz3F7ukDY7LxJwJ96OC/r8Ik+/lS1pYENCaKuxTysKwGCrikYDB/1+PiH4/lk9bQzCm8K4mEk5ClNFkklAr06fYP5LcYCFfQIk3gc+hSUp6RXZ4ClneITHYE+paRg/0=
Received: from BN8PR15CA0009.namprd15.prod.outlook.com (2603:10b6:408:c0::22)
 by IA0PR12MB8931.namprd12.prod.outlook.com (2603:10b6:208:48a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 03:45:43 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::88) by BN8PR15CA0009.outlook.office365.com
 (2603:10b6:408:c0::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 03:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 03:45:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 22:45:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 22:45:42 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via
 Frontend Transport; Mon, 19 Jun 2023 22:45:41 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: add abnormal fan detection for smu 13.0.0
Date: Tue, 20 Jun 2023 11:45:37 +0800
Message-ID: <20230620034537.1495445-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|IA0PR12MB8931:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c65fce8-02b1-4f3c-bed9-08db7140d29a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ozQT22R9EaiDwUv0UVcNz/dkHUL74glFAJKHszGg2RqNDxx6PhYaI2c5CDB1Wcp4fo5UvBimSKIqkm86iMtI51W6LVAxSseoK6lGevy7MOJ10Y/2GVxWXg1bTbDfP3Bj0Cvjm24VAYNO2ckmTOE2z9tgX1BdtSNHF0+p9P3kBrK5NL8r79Y/hetfC+ahIMp31pHAnNRsUcJyA8lh//tFBy5G4jC6xHmaThJ5zTBS/8iVlNvgZDC24BCBl8NzCUfoH7FLQQLMSLQ8fHeTkfStiAbfmlYZCrey5B7pBZdF2hC4kA0XfDtiMTOa/AzN3l4G9oQk0JrLdLFJAuWKwSdY6L19OB2dzO94WyRUVe5ItbiSJ/U/4C3mUa7MSJ7AK2s99H3G7rE5ONORSqc7SoxOYgvQ8Nko5KfXz7Prcq0bJavqAouRl3Xtt7I9rTPf7ENVvnsHAtOqY3jyN1Xq7Plmg0czQM2pZ29TqbZzwRqiCC6tbb5SdXlziFXIhBlFKyC0v7s13Rg0qPGCDP/sFWCGOGtQ+PE8WbB9MjjdS61aI/iexRrKRVdv0KnZqNWMeZ1wVT9oAiwl+aFArssfFWFL18YYbSB50zx5jwD4XWTmIzAYrVAL+xmQSqu2HYObfIiBDaT5EzJRqE8g7CfFl+rixHhC/dEV1muWJDnJAwAOFjiqN8SVxpFdOvyjCtWoKEJ6szSRTLiYe4zVcML5elRoYmpK+QeQnXKYpMpwEYvDp3wqckhaIOIzijB88b7PFy5OjeVw5qKsEpSxeHfQmMCshA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(44832011)(336012)(47076005)(426003)(86362001)(83380400001)(41300700001)(8936002)(8676002)(5660300002)(6916009)(316002)(70206006)(70586007)(36860700001)(2616005)(82740400003)(81166007)(356005)(26005)(40460700003)(1076003)(40480700001)(6666004)(186003)(478600001)(7696005)(4326008)(2906002)(4744005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 03:45:42.7790 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c65fce8-02b1-4f3c-bed9-08db7140d29a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8931
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add abnormal fan detection for smu 13.0.0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index a6083957ae51..124287cbbff8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1710,6 +1710,7 @@ static int smu_v13_0_0_get_thermal_temperature_range(struct smu_context *smu,
 	range->mem_emergency_max = (pptable->SkuTable.TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
+	range->software_shutdown_temp_offset = pptable->SkuTable.FanAbnormalTempLimitOffset;
 
 	return 0;
 }
-- 
2.34.1

