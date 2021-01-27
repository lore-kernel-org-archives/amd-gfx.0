Return-Path: <SRS0=2QJd=G6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17150C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 07:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4CD920729
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Jan 2021 07:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4CD920729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB4F6E1BC;
	Wed, 27 Jan 2021 07:22:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 782906E1BC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Jan 2021 07:22:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNKTCRa+pbn980FwwIZRw/E8AQ+h4CK8plnxmEPjuVEQs/vYNHLW1xAF3HGT8ZmpgcZGzpNBL+8Yg0R/SmpW0ua6WAYh+n36IM7l+cGTG0dgcLGBQ8v9zvuJ+K7l6Gz2GsURFcCo9cNiVWlRX3Rz9ajHqXOYuHED/fgoJCdPUVyYPjaxoWbvcG/oNxTL5aDTv2v7bVWI9cV2cVNoZxIVAuC2wk0heieasg1w32FoRb2S3Flm1ij53VBu5XXPAa2MZfkxELnK9FvxOYE4g5oQiK3nee0KF64/7+be630a73iJ8sgsKDie2LDY9rpCMpZxDrVbF7gpYGgHHN2AOpqjkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/re28iSjt+cqLsTAI5eg3uVA9PNdQe4Ga8jlyQ+yqE=;
 b=jxssk+1Vtq9PUcHSoXwnfq9BlrufdAyZtCuz/KN0vL9/i7wqddt6iREHN3BL4uhS0Sy6E2bPx7aQ0mWH6ZiTjiDvgaQOF6XtiP7CtWUXLqNqvfocJA9YJQR7OigB5feUqsisoJoraQzB7S5zfy/nZ3dkaRgMIS07i0AG4hVdvssxd0ooq2WrgvsGfQ6ODrUOUrWqWGKmu9K1oDLsflTPPYFElmNi/LLaCTziJUprtxh3RMD6PzfD6rSSIIozizDBQuVB4/3Z7r9wA8TJXXfGT8aB/HSAN+0C/k0HbdcuUPW5VY6sg0Q4CMVciOd3iPhs+sXdn6I8HJo4Kq7T+7Y0pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/re28iSjt+cqLsTAI5eg3uVA9PNdQe4Ga8jlyQ+yqE=;
 b=hLkW1gaQGnjwrSucx/gfwkFtCA9SVEviUm+6LGpbHpJ05RwCbhJOdywbzUr8aXAVmfHcX2yWlaVhbPJiynTxrs4POwFPnrpM8fQhWgnGnS8VHij2geyk7cgOsZXnT/jyzT53yiNc5V3w81OJMcp6Tw86AMQDyZK3n12Q+u9d/ZU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR1201MB0054.namprd12.prod.outlook.com
 (2603:10b6:910:1a::21) by CY4PR12MB1768.namprd12.prod.outlook.com
 (2603:10b6:903:11c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 07:22:04 +0000
Received: from CY4PR1201MB0054.namprd12.prod.outlook.com
 ([fe80::558a:f3cb:c8a3:8ebb]) by CY4PR1201MB0054.namprd12.prod.outlook.com
 ([fe80::558a:f3cb:c8a3:8ebb%6]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 07:22:04 +0000
From: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5] drm/amd/pm: store and reinstate swsmu user power
 configurations
Date: Wed, 27 Jan 2021 12:54:32 +0530
Message-Id: <20210127072432.11559-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::21) To CY4PR1201MB0054.namprd12.prod.outlook.com
 (2603:10b6:910:1a::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from arun-desktop.amd.com (165.204.156.251) by
 MAXPR0101CA0011.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Wed, 27 Jan 2021 07:22:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e333eec-982e-4977-d1fd-08d8c2943efb
X-MS-TrafficTypeDiagnostic: CY4PR12MB1768:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1768085C0A85979223EEED79E4BB9@CY4PR12MB1768.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2hl4RdUaMQPaEkHj3DeoN2Pv7vwKHtBFhM3rSGMI4AZHv99hzVMA0Qr9dfvx7GGF5ZxEqKK+fWaHgj17qzxnnR93Ld/bTA7VPcTwauMCkL+MVV1SAnRU/OTbjfWkUgbkmRJaKpIm8GnNclA3cI+C05cfwTlWW38V3RnM6aJNzq6/pUJIhBp5l3m58ltNCNkcingq/pH0Sa9mno/5HaMi2dMquG4Of9nylZmDdELj8F9p6fQra2atoHhz0qHDIvV19izzbQ1gajUtW25L0ne+MMculX86Kku9+8/NU+B3eqUAJG3BX+D4YQZvKsKsOVo0QzKmI3O0zUSLMqXrmjFW7oqEkjKoFvwt9TS7uLKGQxCQqpw3dtWuE4Oh8DMNYND31Sm/snQff1EdL/7wfkQsvkpvxVLCJux4ON4XYRohS8zTGb+QgOKPh/BOF6Y1gups8cn4Qli/H/MNS1as/1uCp/SeuoElLFYbrlJ9yZFAfauL3oYHUCdM2J70qDUAXq+56NmITj+3MuB9HBDHygcQQ4W4lGvaPhghvR7ys0M3rHaxpO8jPHvut+fi0fSH0mqfMUOOjKUUQumfZoAXal4LfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR1201MB0054.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(36756003)(16526019)(86362001)(8936002)(186003)(316002)(66946007)(7696005)(66556008)(52116002)(4326008)(66476007)(26005)(6916009)(2616005)(478600001)(6666004)(956004)(2906002)(6486002)(83380400001)(8676002)(5660300002)(1076003)(405565002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1VHT402e0P9D7DXGt7/m2Jw7gYUuGru/xnIMOdXDvLgKCp+oYx2D4gHF0V2P?=
 =?us-ascii?Q?Qgo0Qc98ckc4URy47GPFNVnay9G5hPZO4hwRxXoDDWWxsFW0a2XUAX+UvlPs?=
 =?us-ascii?Q?OG5tP8o4dcFdjn7s/8UxZqLoDr2VCcpZhd1GV9fL2FA6bUkcgKvkJSS5tjfz?=
 =?us-ascii?Q?sec7In/LWeWU8oLwEwoKPH2tQQUQaoQkP/GyeS+pyj3uqsOcX8S8YnSeGap2?=
 =?us-ascii?Q?voIUmeEYI/GYFpJiblEtD0a/t1x1KEoUkr84OIqzSCNjr9o7Q32r6PwjHjKi?=
 =?us-ascii?Q?oONURxU5n1kF1qFEVurru3OTNbIoZ01SKOBEzu32mJblBnsNbKDW6JSrzdNS?=
 =?us-ascii?Q?FkU28o+t6uLIqZey5WqiApnb6mtJvfQKVi+gS/Aqh1cW5K/DtQmwqeXSVkqm?=
 =?us-ascii?Q?uX+8mm7niu9zHonkMvMe3e5u6kfiq7qdfmMv5z6NBPqq6d6YQtj40ylKAgDZ?=
 =?us-ascii?Q?D8ErK8Tmcl0UXvycZfJRhRckPjH2eWuc0uWrFI9suSHjcFb0k31Xv1nDL3a1?=
 =?us-ascii?Q?tuV4fAUEnJVDe6E1MR9h5ltrffcsieGs5n7hS/q8yQNkf6cP505uHNq6LViU?=
 =?us-ascii?Q?DNtlflooBfKx5nVgrw9CkJUTmuoa2MGxVHpugHDDfvmIdcyKs3V6udJ8xK92?=
 =?us-ascii?Q?t2ntU5oVnXt/q2RrQ1ddxLB7b0JQvFd5vY2KIc90tdQMqhdc3meMB5aNMb6p?=
 =?us-ascii?Q?ffftjNeUujW5rYSqYEE/NJBSYDDhbEnkrCIcZsj3gPS5SRNEVpdsIRwPT4kX?=
 =?us-ascii?Q?WQAkK0KyF9ivgLUcRU+610CpbiHWI5HNF8HvBFcpqe1eK9Jq2uP8XgCfbupH?=
 =?us-ascii?Q?IYousGKJzekDW/Zm3FQhE0miSD3B1qVszVR2SmyHu8DooXoiRL3I1TXQlXlO?=
 =?us-ascii?Q?2SN38vC2yCgzA54lORaYia7KLJsofl+4lr3FjhNbvv7GMdy7mc/T4x4Dxcnc?=
 =?us-ascii?Q?LfWfi9EpbjTboHEm9xdpwaW+SfdcvvZxOCdzHwMn0fjb9ydIBZgvMX5pbC0L?=
 =?us-ascii?Q?IQ/3oiUuUSGMM9WxfpvYHIB6FisfcJW3to1iqXqqioVI1yx4TV0zVgU0h6WV?=
 =?us-ascii?Q?J7CROlgb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e333eec-982e-4977-d1fd-08d8c2943efb
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB0054.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 07:22:04.5462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLeduAj2wBgitms5st3N93IoOpexOUWHKhqEOv6IC9AjgfquAOUQkQfFjRJDqF80xnC6xQMv3j09/HBFwU2YpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1768
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
Cc: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

store swsmu user power configurations which include
power limit, clock frequencies, fan speed and fan mode
on suspend and reinstate on resume.

V2: Addressed Lijo's review comments
     added a function to set clock interdependencies
     add check on fan control mode to reapply fan speed

V3: Addressed review comments from Alex
     moved store logic and reinstate function call into swSMU

V4: added a logic to keep off storing configurations in suspend

V5: Addressed review comments from Lijo
     add a restore flag
     give restore priority to mclk comparing fclk and socclk

Signed-off-by: Arunpravin <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   |  15 +++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 148 +++++++++++++++++++++-
 2 files changed, 159 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index a087e00382e6..631a36a75ae3 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -33,6 +33,8 @@
 #define SMU_TEMPERATURE_UNITS_PER_CENTIGRADES	1000
 #define SMU_FW_NAME_LEN			0x24
 
+#define SMU_DPM_USER_PROFILE_RESTORE (1 << 0)
+
 struct smu_hw_power_state {
 	unsigned int magic;
 };
@@ -168,6 +170,17 @@ enum smu_memory_pool_size
     SMU_MEMORY_POOL_SIZE_2_GB   = 0x80000000,
 };
 
+struct smu_user_dpm_profile {
+	uint32_t fan_mode;
+	uint32_t power_limit;
+	uint32_t fan_speed_rpm;
+	uint32_t flags;
+
+	/* user clock state information */
+	uint32_t clk_mask[SMU_CLK_COUNT];
+	uint32_t clk_dependency;
+};
+
 #define SMU_TABLE_INIT(tables, table_id, s, a, d)	\
 	do {						\
 		tables[table_id].size = s;		\
@@ -473,6 +486,8 @@ struct smu_context
 	uint32_t cpu_actual_soft_max_freq;
 	uint32_t cpu_core_id_select;
 	uint16_t cpu_core_num;
+
+	struct smu_user_dpm_profile user_dpm_profile;
 };
 
 struct i2c_adapter;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 7fe61ad3ed10..f958b02f9317 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -266,6 +266,119 @@ int smu_dpm_set_power_gate(struct smu_context *smu, uint32_t block_type,
 	return ret;
 }
 
+/**
+ * smu_set_user_clk_dependencies - set user profile clock dependencies
+ *
+ * @smu:	smu_context pointer
+ * @clk:	enum smu_clk_type type
+ *
+ * Enable/Disable the clock dependency for the @clk type.
+ */
+static void smu_set_user_clk_dependencies(struct smu_context *smu, enum smu_clk_type clk)
+{
+	if (smu->adev->in_suspend)
+		return;
+
+	/*
+	 * mclk, fclk and socclk are interdependent
+	 * on each other
+	 */
+	if (clk == SMU_MCLK) {
+		/* reset clock dependency */
+		smu->user_dpm_profile.clk_dependency = 0;
+		/* set mclk dependent clocks(fclk and socclk) */
+		smu->user_dpm_profile.clk_dependency = BIT(SMU_FCLK) | BIT(SMU_SOCCLK);
+	} else if (clk == SMU_FCLK) {
+		/* give priority to mclk, if mclk dependent clocks are set */
+		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
+			return;
+
+		/* reset clock dependency */
+		smu->user_dpm_profile.clk_dependency = 0;
+		/* set fclk dependent clocks(mclk and socclk) */
+		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_SOCCLK);
+	} else if (clk == SMU_SOCCLK) {
+		/* give priority to mclk, if mclk dependent clocks are set */
+		if (smu->user_dpm_profile.clk_dependency == (BIT(SMU_FCLK) | BIT(SMU_SOCCLK)))
+			return;
+
+		/* reset clock dependency */
+		smu->user_dpm_profile.clk_dependency = 0;
+		/* set socclk dependent clocks(mclk and fclk) */
+		smu->user_dpm_profile.clk_dependency = BIT(SMU_MCLK) | BIT(SMU_FCLK);
+	} else
+		/* add clk dependencies here, if any */
+		return;
+}
+
+/**
+ * smu_restore_dpm_user_profile - reinstate user dpm profile
+ *
+ * @smu:	smu_context pointer
+ *
+ * Restore the saved user power configurations include power limit,
+ * clock frequencies, fan control mode and fan speed.
+ */
+static void smu_restore_dpm_user_profile(struct smu_context *smu)
+{
+	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
+	int ret = 0;
+
+	if (!smu->adev->in_suspend)
+		return;
+
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+		return;
+
+	/* Enable restore flag */
+	smu->user_dpm_profile.flags = SMU_DPM_USER_PROFILE_RESTORE;
+
+	/* set the user dpm power limit */
+	if (smu->user_dpm_profile.power_limit) {
+		ret = smu_set_power_limit(smu, smu->user_dpm_profile.power_limit);
+		if (ret)
+			dev_err(smu->adev->dev, "Failed to set power limit value\n");
+	}
+
+	/* set the user dpm clock configurations */
+	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL) {
+		enum smu_clk_type clk_type;
+
+		for (clk_type = 0; clk_type < SMU_CLK_COUNT; clk_type++) {
+			/*
+			 * Iterate over smu clk type and force the saved user clk
+			 * configs, skip if clock dependency is enabled
+			 */
+			if (!(smu->user_dpm_profile.clk_dependency & BIT(clk_type)) &&
+					smu->user_dpm_profile.clk_mask[clk_type]) {
+				ret = smu_force_clk_levels(smu, clk_type,
+						smu->user_dpm_profile.clk_mask[clk_type]);
+				if (ret)
+					dev_err(smu->adev->dev, "Failed to set clock type = %d\n",
+							clk_type);
+			}
+		}
+	}
+
+	/* set the user dpm fan configurations */
+	if (smu->user_dpm_profile.fan_mode == AMD_FAN_CTRL_MANUAL) {
+		ret = smu_set_fan_control_mode(smu, smu->user_dpm_profile.fan_mode);
+		if (ret) {
+			dev_err(smu->adev->dev, "Failed to set manual fan control mode\n");
+			return;
+		}
+
+		if (!ret && smu->user_dpm_profile.fan_speed_rpm) {
+			ret = smu_set_fan_speed_rpm(smu, smu->user_dpm_profile.fan_speed_rpm);
+			if (ret)
+				dev_err(smu->adev->dev, "Failed to set manual fan speed\n");
+		}
+	}
+
+	/* Disable restore flag */
+	smu->user_dpm_profile.flags &= ~SMU_DPM_USER_PROFILE_RESTORE;
+}
+
 int smu_get_power_num_states(struct smu_context *smu,
 			     struct pp_states_info *state_info)
 {
@@ -529,6 +642,8 @@ static int smu_late_init(void *handle)
 			AMD_PP_TASK_COMPLETE_INIT,
 			false);
 
+	smu_restore_dpm_user_profile(smu);
+
 	return 0;
 }
 
@@ -1622,6 +1737,12 @@ int smu_force_performance_level(struct smu_context *smu, enum amd_dpm_forced_lev
 
 	mutex_unlock(&smu->mutex);
 
+	/* reset user dpm clock state */
+	if (!ret && smu_dpm_ctx->dpm_level != AMD_DPM_FORCED_LEVEL_MANUAL) {
+		memset(smu->user_dpm_profile.clk_mask, 0, sizeof(smu->user_dpm_profile.clk_mask));
+		smu->user_dpm_profile.clk_dependency = 0;
+	}
+
 	return ret;
 }
 
@@ -1656,8 +1777,13 @@ int smu_force_clk_levels(struct smu_context *smu,
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels)
+	if (smu->ppt_funcs && smu->ppt_funcs->force_clk_levels) {
 		ret = smu->ppt_funcs->force_clk_levels(smu, clk_type, mask);
+		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE) {
+			smu->user_dpm_profile.clk_mask[clk_type] = mask;
+			smu_set_user_clk_dependencies(smu, clk_type);
+		}
+	}
 
 	mutex_unlock(&smu->mutex);
 
@@ -1906,8 +2032,11 @@ int smu_set_fan_speed_rpm(struct smu_context *smu, uint32_t speed)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_speed_rpm)
+	if (smu->ppt_funcs->set_fan_speed_rpm) {
 		ret = smu->ppt_funcs->set_fan_speed_rpm(smu, speed);
+		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+			smu->user_dpm_profile.fan_speed_rpm = speed;
+	}
 
 	mutex_unlock(&smu->mutex);
 
@@ -1949,8 +2078,11 @@ int smu_set_power_limit(struct smu_context *smu, uint32_t limit)
 	if (!limit)
 		limit = smu->current_power_limit;
 
-	if (smu->ppt_funcs->set_power_limit)
+	if (smu->ppt_funcs->set_power_limit) {
 		ret = smu->ppt_funcs->set_power_limit(smu, limit);
+		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+			smu->user_dpm_profile.power_limit = limit;
+	}
 
 out:
 	mutex_unlock(&smu->mutex);
@@ -2127,11 +2259,19 @@ int smu_set_fan_control_mode(struct smu_context *smu, int value)
 
 	mutex_lock(&smu->mutex);
 
-	if (smu->ppt_funcs->set_fan_control_mode)
+	if (smu->ppt_funcs->set_fan_control_mode) {
 		ret = smu->ppt_funcs->set_fan_control_mode(smu, value);
+		if (!ret && smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+			smu->user_dpm_profile.fan_mode = value;
+	}
 
 	mutex_unlock(&smu->mutex);
 
+	/* reset user dpm fan speed */
+	if (!ret && value != AMD_FAN_CTRL_MANUAL &&
+			smu->user_dpm_profile.flags != SMU_DPM_USER_PROFILE_RESTORE)
+		smu->user_dpm_profile.fan_speed_rpm = 0;
+
 	return ret;
 }
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
