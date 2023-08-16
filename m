Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45125C04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 18:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CB9F10E39F;
	Wed, 16 Aug 2023 18:08:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F62910E39F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 18:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwlwppliroCFymorKgY0qBrmt/Iuwei6MF4sZiKFlJGC0gdLTkkNUld+pIKZmDR7F4U8ju1huMdtetgfuR9aIwyv5tCWpSvXMrPMHGyJPMIifMKKSTDDmKsblr/GdBQZY0Jrnex/H2Qo5c2c096GrdcavCbS0M2SVv0f3y4TvLiRrIO4GmaC1kUYgZPvmaWGelw8Cy9VdgJecuulRZzwaYq1wmRta7dvMP8JdZDoYzYkZWWSbtr3GNxcf2iXwY53YpXwTWzRPd70V79HTQEKBjmPMloeZacYELyi8WNQEymEBE0cFcyUd+eQRBlYuNU4ac7vrqLNbiR+bBJeeYlGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VNC0GgoNql8WCwfpGxkx4nN3jyjrPNvpjH697F3ZL8=;
 b=ixsfJ+iWYyuWFIUVtIJR2Tb/UwQON1HQjoQ5Ow1b5jzEVf1ziyDsNHNSnxT15eEyC0qj6H9zCiLbakpH2+E2Zt0QqzupUgVHxUt/bugIQufc+idowfbos50ruEBMLZJiT5umU2KTMZPeF0Ypx9CfvGc6IDwLqxnHGFg3D7R9eIQsHG0WTjZcZ8C1ZvK3CrnBt+SVP5ewppZJLw5LhCJBnceH7gSZ9sWTfzRwNMcCdqUiSr9bVeinHfv1q66Vit3GX469B+fIZxq/DR2uXoBmS6YnGwxnEOXPoghvt72LqpRO8Sa14OYG48TWDS23EOVHKZ4HX4uVmOJFMNYZEIwjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VNC0GgoNql8WCwfpGxkx4nN3jyjrPNvpjH697F3ZL8=;
 b=GPZMYdHWNsdyNExYcmkUYu+vB1M9i/XZfkxyq7Tg6n36JSWg1J13paG8Ju9M9lPHGHNFz+XMTIu8wslP5HeElHr5giefTObKsGbBn1TpaIn7Vqjd6Co07d9DMiVKdpjqrgP76WVy3V67UeVLzJgFngAReW558pIWTDnOPYfTn9o=
Received: from CY5PR19CA0038.namprd19.prod.outlook.com (2603:10b6:930:1a::16)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 18:07:57 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:1a:cafe::3e) by CY5PR19CA0038.outlook.office365.com
 (2603:10b6:930:1a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 18:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 18:07:56 +0000
Received: from navi32bu-james.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 13:07:55 -0500
From: Bokun Zhang <bokun.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3] drm/amdgpu/pm: Add notification for no DC support
Date: Wed, 16 Aug 2023 14:07:13 -0400
Message-ID: <20230816180712.102887-1-bokun.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <BYAPR12MB46147963E0CF9E1FC699CB079715A@BYAPR12MB4614.namprd12.prod.outlook.com>
References: <BYAPR12MB46147963E0CF9E1FC699CB079715A@BYAPR12MB4614.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f63ee90-ae2e-4f16-2233-08db9e83b7e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: emWSjZB3s5X5fzeTA+WCjHkENmIddZGisposfO3GuiwQADuObEAUcTxA0EenTM4oREhEYxVR20UY6KM0rA081oBDcNkCsRJdUhS++1dJL9/xT39KVIoiKElMtB1wehBycBlNHCLQz+EH5YQLFNVlFbFb4/FRM11eFsEvz3IPNrwUxgCYXa+U+BR0HcNQrZFfEzO5DxULl5ASeSQpBlpdxw2L5pH75XDwtMf5RSUVdxTbOZJRmWGcvvHLiHKm3v/UbCwCoOk5cevXxh0JV2D2LvT/tZ5M8ApzvjyeNkk4PRNcMUUttwpvU/nw3qKrOl1ZF19B6X9DQNKCfPjfbm5X/sfvfZjcMe7Yu3VrbTMEfFkUdZZM67cLxbTq7VkqUciOyDyRY3u3iUOdImBF6/zQgcR+/YCDC88Qa4Pp/1ZuCNWcOHPocTvIgWWqJ55yL56wpxTJKf0Rn/ZibksIIobmOjU/UZCHapNcce+rXBNzXeVmfXJC9Z1ld6Zhp1WuyP7fFVYTNd31KxHrHe1jK33Jc1K+TBuKZDp/LZ/Qm0vEt/kcPTlw214ucuH+UrtGVK3oWS2zYhASPS0lcDZAGS61YW60bql6n0P5LtRCO9qZ5JkoaGzJprw0FduM/wLbE4elrG5Uk/VQMoAHHk9jllvoyUjU26kGRxfTD7PoebQX++5d5XzEpPCUfqWtsacLOurPJPWNkU/oylTnHx+EV8WtvjMYq2EgXy3z4RNyK8SlQWkudootgCXx6ntQyuPGMYQxSzGGpcT0KrwIaSr4zQnkmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199024)(1800799009)(186009)(82310400011)(40470700004)(36840700001)(46966006)(316002)(356005)(82740400003)(54906003)(6916009)(81166007)(70586007)(70206006)(41300700001)(36860700001)(5660300002)(44832011)(47076005)(8676002)(4326008)(8936002)(2906002)(40460700003)(15650500001)(83380400001)(26005)(16526019)(40480700001)(478600001)(426003)(336012)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 18:07:56.4852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f63ee90-ae2e-4f16-2233-08db9e83b7e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
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
Cc: Bokun Zhang <bokun.zhang@amd.com>, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- There is a DPM issue where if DC is not present,
  FCLK will stay at low level.
  We need to send a SMU message to configure the DPM

- Reuse smu_v13_0_notify_display_change() for this purpose

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h          |  5 +----
 .../drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h   |  5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h           |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c         | 10 ++++------
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  2 ++
 5 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 6e2069dcb6b9..a719ad9f7bd0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -1043,10 +1043,7 @@ struct pptable_funcs {
 						   enum smu_feature_mask mask);
 
 	/**
-	 * @notify_display_change: Enable fast memory clock switching.
-	 *
-	 * Allows for fine grained memory clock switching but has more stringent
-	 * timing requirements.
+	 * @notify_display_change: General interface call to let SMU know about DC change
 	 */
 	int (*notify_display_change)(struct smu_context *smu);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
index 10cff75b44d5..e2ee855c7748 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_0_ppsmc.h
@@ -138,7 +138,10 @@
 #define PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel 0x4A
 #define PPSMC_MSG_SetPriorityDeltaGain           0x4B
 #define PPSMC_MSG_AllowIHHostInterrupt           0x4C
-#define PPSMC_Message_Count                      0x4D
+
+#define PPSMC_MSG_DALNotPresent                  0x4E
+
+#define PPSMC_Message_Count                      0x4F
 
 //Debug Dump Message
 #define DEBUGSMC_MSG_TestMessage                    0x1
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 297b70b9388f..f71fc99447f2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -245,7 +245,8 @@
 	__SMU_DUMMY_MAP(AllowGpo),	\
 	__SMU_DUMMY_MAP(Mode2Reset),	\
 	__SMU_DUMMY_MAP(RequestI2cTransaction), \
-	__SMU_DUMMY_MAP(GetMetricsTable),
+	__SMU_DUMMY_MAP(GetMetricsTable), \
+	__SMU_DUMMY_MAP(DALNotPresent),
 
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	SMU_MSG_##type
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 895cda8e6934..4b8842fc9574 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -838,12 +838,10 @@ int smu_v13_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
-	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
-	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
-		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
+	if (!amdgpu_device_has_dc_support(smu->adev))
+	{
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_DALNotPresent, NULL);
+	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 48b03524a52d..d75f500b50ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -160,6 +160,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(AllowGpo,			PPSMC_MSG_SetGpoAllow,           0),
 	MSG_MAP(AllowIHHostInterrupt,		PPSMC_MSG_AllowIHHostInterrupt,       0),
 	MSG_MAP(ReenableAcDcInterrupt,		PPSMC_MSG_ReenableAcDcInterrupt,       0),
+	MSG_MAP(DALNotPresent,		PPSMC_MSG_DALNotPresent,       0),
 };
 
 static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
@@ -2680,6 +2681,7 @@ static const struct pptable_funcs smu_v13_0_0_ppt_funcs = {
 	.send_hbm_bad_channel_flag = smu_v13_0_0_send_bad_mem_channel_flag,
 	.gpo_control = smu_v13_0_gpo_control,
 	.get_ecc_info = smu_v13_0_0_get_ecc_info,
+	.notify_display_change = smu_v13_0_notify_display_change,
 };
 
 void smu_v13_0_0_set_ppt_funcs(struct smu_context *smu)
-- 
2.25.1

