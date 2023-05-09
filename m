Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF473C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E98DC10E3F9;
	Tue,  9 May 2023 22:07:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D35810E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:07:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4AErtqjBToGOfgPSTOkimMrMr+qFhWLF5IoadTuqUHa8s4UFLehXOVBenzpXqHvnfoXE3HPFMAdvusyIjnT6W6Zl6vjkfGZhgZ4ySCF8Lofy6DzTatoksKdD8Mv6W4B2h6VIiFV4rn3eRQpZhkFuA3GMwX2svcsaZBgc3N4LkX5uJJKkBgozrSiocRZs87z3qs+AetOBZrq0M6avNBRSroDHZBo3HBk3CzQ7EdO+Oj09C+kQPZqmbM+bDXPnsO3OdIoEu/sRdGUzDitIVS/ZW0ErjmNuYZYOpBo3zLMA+c5D8zowdHWJumOVXblOMbBP9ACX8t3Ws9r8pEde0TC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XROsG5AUW00Gr5euFiCo1hl70mpaykHWiPNCLsP/+w=;
 b=JgupklpM6rtcH8nFqQWrj2p+5RI82eOr1/QB0fWYzr9UUL7HKhDJkTm3CK1s8xykEjVWG8dUjoHjQNbClm/oXEJ75wny7TYLmUcH8nDLBwYk5YGJU6+yjxQ0jUraJady9NWkN/KlfE3uvJd++6lwnmmxFrJSqfoBUbQ90fh4EHrgVW6SkfRBZ7NUUw3vR2WcfxhE2Wufu04CNYF/FCcMZrKZYcKy1MKo+AMw91eEkWwpKMBu3NrCiRqKTE0rbBZzuD/EZItc6WOvseh9qNZUfgGxW+aws7CkSsp/+zLnKM72nk9Ahytc1ZDz5Y7OczuMSExTSU5WH0GPkE+zghJjYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XROsG5AUW00Gr5euFiCo1hl70mpaykHWiPNCLsP/+w=;
 b=PdcRjkh9JoI+Hp/mGxLH0iku4ZZCK87A94oqH5fa50s7lsIwjtn3NEQ0QJqTnsfu1lX272S6AKJNHOAxpq5JQaSnmch96Z1fGtb03dEnttnIkcYgfTDMvjfGBP6yl3cIbLoTeOuaxjCq2JOE3tTsx+yxKDtwjlMQ4DqTVoUz57w=
Received: from BN0PR08CA0016.namprd08.prod.outlook.com (2603:10b6:408:142::35)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 22:07:32 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::79) by BN0PR08CA0016.outlook.office365.com
 (2603:10b6:408:142::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:07:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:07:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/12] drm/amd/pm: Notify PMFW about driver unload cases
Date: Tue, 9 May 2023 18:07:12 -0400
Message-ID: <20230509220714.475369-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220714.475369-1-alexander.deucher@amd.com>
References: <20230509220714.475369-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT039:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2f4553-9849-4e5f-80e3-08db50d9c9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9fVn/tP/0WgOJci6wur1EPWWh+LeeIkfMfxYOqzkQnhXn19bHjPnvvMSNBvN5thI+Tllf3qjhsDdLfBYfNAcf+LUOnnYWiTc7IvcD/7LDJbmeHTYkKpPvOLssP1z/VkY5+qpKlWlDRT8yueOLqyqVVS8rE+ojUhjk80DhZ58X2P0BcVpyZ+H1VT9CqCYqUSjezmVhIQFxfTfdsZ65c/luaz9YxxZK4WFxQRk+KnpvHRccyVs8QvJ7wNSvkJXTEzFoLRmbzdlnI7lAp/5uy7tmZkr25QAtMG3DPRGPvJemPJxAEpaArVDSwGjzM83FwiGyW2Cdan+QK7EPWgZcztLY+kglIt3ZId5Vy8u1epYHeKnP0fKuh0i3x6avs4dI4WDh328nXZi2sbrgk6KzDheh2LQ8t7B2uYLEb9rK8fbligfubVHjmOGyrQ+Oe1Q7LSUl+ytuB8zbpDERFOuLBgLHzUlz+Y4FDcsQz2ahS8djaYXKKYokidhpZG2yQ9bQhTUG16iPAtfh+DvixOFLBc/eR9DRYX5zXyH5GOyE7weR3pPuwksMvhSWV06jszF43Zyx3korlsOyEQ4unR8qYUlxoSJXf8jygNF/Zx+ircA+xQC3WWtW7lN3oOV5VCYofPyyDSN9x5l6cjZhudE3hTM94Szw+XrZP+oDRon80w269QsqQpC4iblam6Xmo9EEZCVmTANqKzausccK1g/Z8G+hx78A+UFPZTd4HZyyavK+w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(26005)(70586007)(82740400003)(4326008)(83380400001)(426003)(336012)(47076005)(82310400005)(41300700001)(36860700001)(5660300002)(2616005)(316002)(36756003)(8936002)(2906002)(8676002)(16526019)(356005)(81166007)(40480700001)(1076003)(186003)(70206006)(6916009)(6666004)(86362001)(7696005)(54906003)(40460700003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:07:32.5550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2f4553-9849-4e5f-80e3-08db50d9c9c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Asad Kamal <asad.kamal@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

On SMU v13.0.6 APUs, FW will need to take some actions if driver is going
to halt RLC. Notify PMFW that driver is not going to manage device so
that FW takes care of the required actions.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7474d3ffab93..6dcafd04c98d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -122,6 +122,7 @@ static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COU
 	MSG_MAP(GetMaxGfxclkFrequency,               PPSMC_MSG_GetMaxGfxDpmFreq,                0),
 	MSG_MAP(SetSoftMinGfxclk,                    PPSMC_MSG_SetSoftMinGfxClk,                0),
 	MSG_MAP(SetSoftMaxGfxClk,                    PPSMC_MSG_SetSoftMaxGfxClk,                0),
+	MSG_MAP(PrepareMp1ForUnload,                 PPSMC_MSG_PrepareForDriverUnload,          0),
 };
 
 static const struct cmn2asic_mapping smu_v13_0_6_clk_map[SMU_CLK_COUNT] = {
@@ -1385,14 +1386,34 @@ int smu_v13_0_6_register_irq_handler(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v13_0_6_notify_unload(struct smu_context *smu)
+{
+	uint32_t smu_version;
+
+	smu_cmn_get_smc_version(smu, NULL, &smu_version);
+	if (smu_version <= 0x553500)
+		return 0;
+
+	dev_dbg(smu->adev->dev, "Notify PMFW about driver unload");
+	/* Ignore return, just intimate FW that driver is not going to be there */
+	smu_cmn_send_smc_msg(smu, SMU_MSG_PrepareMp1ForUnload, NULL);
+
+	return 0;
+}
+
 static int smu_v13_0_6_system_features_control(struct smu_context *smu,
 					       bool enable)
 {
+	struct amdgpu_device *adev = smu->adev;
 	int ret;
 
-	/* Nothing to be done for APU */
-	if (smu->adev->flags & AMD_IS_APU)
+	/* On APUs, notify FW that the device is no longer driver managed */
+	if (adev->flags & AMD_IS_APU) {
+		if (!enable)
+			smu_v13_0_6_notify_unload(smu);
+
 		return 0;
+	}
 
 	ret = smu_v13_0_system_features_control(smu, enable);
 
-- 
2.40.1

