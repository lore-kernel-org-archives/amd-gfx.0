Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F7CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7BF62072D
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YstNBLeJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7BF62072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B7716E1BD;
	Mon, 24 Aug 2020 08:04:25 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 248C56E1BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 08:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYPCCjnra1Q+RZmZHid/fQwWEyyVFsQJT/pjZuwIjb3V/YZuhUasKJnNYlRMmR1kZc5Ot19KtP899JGXo2/BLfprEda7lKg9N2SjEHLT9PLJ9MinGhh0eImUzm7bRzX1uiIfMAohF/fqiedRPjkgnqIfwW69YF19nOlM/xqsaPitPiamcWiz/WuaiO+vyY+3xsIJUR8yGDb4GkX+1yESFsag/xLsJP3eSESBzkY0kbuDduWjzaEyx3deSt5xU9+PcXSSVr+cjd4oH04hysNFzmz1a5FyV50iOiA8e55gjFQ4zg4yDsTYmZ7aMe4v6li5WaY9YpTUpEA0h7uiJkxmLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaGdttdOQf7kpuLtPUvEiem2MP31B7gggAzkdp+jidI=;
 b=UbzyqFY+kZM41HgyvXl06BL3Aga7tcysS4Kn/qst76RSU6TnL05/HXaxMBckkxxfA9CgMWb9DC0UKUSnqX2SG9PLIUJR3G9/U4LIk10iUZ3O+lDP5sQjn79LX7AT0xvdUouDnKzoFHKKv6Z4uVxWz+1fmd2wncNHa/+n0kD/gJnX7cfpV15v5Pniw8A/iHnqW0bnui9VgOCMmB5KA73eqMRX18J0GotYiNjWahhOLdzih1xRsd+zfcmimwTFdzxtyzY1k6ZBM8FhTtczfrVWnVv41rxHXlnFkQZcovn8+jWVewnqjX/8BcNJI63Ndn1Zday3x/5H8EpSPOE6KkkSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaGdttdOQf7kpuLtPUvEiem2MP31B7gggAzkdp+jidI=;
 b=YstNBLeJDMjWBns8E0nqQ080C1y+f6kbPHla75+mqx7+rRUMoPKM3EVsL9kWLUJk8PJuk5PCLX/9A43gfSYWIpspCSA7L9NSRNYrZvMK4fCj2szZkbARbfoKbXWa3kR9JV1Cco42KpyKOLybvcGCdaE60BlIWFjLzxSDOhsRZjI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2891.namprd12.prod.outlook.com (2603:10b6:5:188::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Mon, 24 Aug 2020 08:04:18 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::bcb1:de80:f60c:8118%5]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 08:04:18 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amd/pm: drop unnecessary table existence and dpm
 enablement check
Date: Mon, 24 Aug 2020 16:03:49 +0800
Message-Id: <20200824080350.32504-3-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824080350.32504-1-evan.quan@amd.com>
References: <20200824080350.32504-1-evan.quan@amd.com>
X-ClientProxiedBy: HK0PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:203:b0::19) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by
 HK0PR03CA0103.apcprd03.prod.outlook.com (2603:1096:203:b0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 08:04:16 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30d71445-dd05-4eaa-7896-08d848044cbc
X-MS-TrafficTypeDiagnostic: DM6PR12MB2891:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB28917C493DABC5BBCE8E16E7E4560@DM6PR12MB2891.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/vS+tAeDSNCviDepFQ7FbF94YXIkRenzK7b44zNot/b5kyK0gnA3z0ecDCIkAq9c9/HmSU4Z1wVOzWvSYov4kR7QTN0LZcEdU0gN4DqgIXKg+LSeUBPc0/GoJcaPWuVkEqJAhWy11sLrM1qz8xgDHgRRtQx7cHadYVVb8yaMLehmfuhnn28MyDNpVCQ+Vg+4bgOaGIiEC/y2d5VHDJ+adnsJgNh3VfnrJooRKnXQXJSiaEVJWzBz6ZGXyu3iaDYa2moSw+HNONOK+hdK8akZVSlNi7i2GR4yTAY5cyka1/DjkhLr2kMR9BmbQinHZkpQJ9ecWVH+2cZ7OIEFT4OjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(52116002)(1076003)(5660300002)(44832011)(26005)(8936002)(186003)(36756003)(8676002)(66556008)(66476007)(956004)(86362001)(6486002)(478600001)(2906002)(83380400001)(4326008)(2616005)(316002)(16576012)(66946007)(6916009)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: AlfEraqLGoUs9kmsRIHSog6hgXDgScdJd1Vo/JMQ0e3zy93ghXb7TDvznDf84lH8n0y6JqmAQYR9GF9PeQ+3drV09ugQpb6OXe+Nu7QSCAv/MLugBxz/cE5LSbklwLlzAmUpJeC9NPfrF4GooL2XH2Y1xNsSvI/5ZXsMQGzWEzF9ewVSEaBRMjziblhVedzs6NySih4HKeuEKNhZXUvhglWthFKj3Xpj7Ya194CnCcMpcaPqMO6JbgjgpTOykvSATyos/jwTrTJI1Ps8vZCLp8K/RkeIZ6b6TzmIl71sODVWvo8UUP2OxYxPWpOkqJ0jBQzK4GlhwqhG3/C3gW/5jV5voskoSWO49Gg1ropT4AueYwDILvaqdPUAIQPM6y8eqUKdXNU2IsznXWCh4v6hfPw2L5c3YxCWN38VhvdktLPkHlB9zA3/TNymxZDKll9qA9aSZpt6Cr3/5YIZs3I1tTaugrKqEh3smSGp6u/4GJ5IQ0FmA1yO4AbpG1XRfc5/sP4Wc4+8RmdECqfCvY1jEA2X1k/ydxhdypS3yA0o17/zkjpSb+NquLfDal8+nPKeqIUdsBRKegbOrO4iId2qerBOosSVn52GUDeiuKTTtSBWvcQJ6S0tmmvAa93EQ40cNXJ3RBOJyiyngLWlKZoubA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d71445-dd05-4eaa-7896-08d848044cbc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 08:04:17.9962 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cshpcwOjh2N2M8xZohWWFQpitPt75YIwRA8d/i8jeGa7p9jKIKq/ngaobDfw8zf1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2891
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Either this was already performed in parent API. Or the table is
confirmed to exist.

Change-Id: Ie6778a5035749221e0f9d5ad977a0e56392771dd
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h       |  1 -
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 16 ----------------
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    | 19 ++++---------------
 drivers/gpu/drm/amd/pm/swsmu/smu_internal.h   |  1 +
 4 files changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 4c5c041af4ee..1888776deccb 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -701,7 +701,6 @@ int smu_set_fan_speed_percent(struct smu_context *smu, uint32_t speed);
 int smu_get_fan_speed_rpm(struct smu_context *smu, uint32_t *speed);
 
 int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk);
-int smu_set_active_display_count(struct smu_context *smu, uint32_t count);
 
 int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b7cad8ef6153..8a42d976a930 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -572,9 +572,6 @@ static int smu_fini_fb_allocations(struct smu_context *smu)
 	struct smu_table *tables = smu_table->tables;
 	struct smu_table *driver_table = &(smu_table->driver_table);
 
-	if (!tables)
-		return 0;
-
 	if (tables[SMU_TABLE_PMSTATUSLOG].mc_address)
 		amdgpu_bo_free_kernel(&tables[SMU_TABLE_PMSTATUSLOG].bo,
 				      &tables[SMU_TABLE_PMSTATUSLOG].mc_address,
@@ -2252,19 +2249,6 @@ int smu_set_deep_sleep_dcefclk(struct smu_context *smu, int clk)
 	return ret;
 }
 
-int smu_set_active_display_count(struct smu_context *smu, uint32_t count)
-{
-	int ret = 0;
-
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
-		return -EOPNOTSUPP;
-
-	if (smu->ppt_funcs->set_active_display_count)
-		ret = smu->ppt_funcs->set_active_display_count(smu, count);
-
-	return ret;
-}
-
 int smu_get_clock_by_type(struct smu_context *smu,
 			  enum amd_pp_clock_type type,
 			  struct amd_pp_clocks *clocks)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 005673bedc2f..a83b3635df40 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -453,9 +453,6 @@ int smu_v11_0_init_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (smu_power->power_context || smu_power->power_context_size != 0)
-		return -EINVAL;
-
 	smu_power->power_context = kzalloc(sizeof(struct smu_11_0_dpm_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
@@ -469,9 +466,6 @@ int smu_v11_0_fini_power(struct smu_context *smu)
 {
 	struct smu_power_context *smu_power = &smu->smu_power;
 
-	if (!smu_power->power_context || smu_power->power_context_size == 0)
-		return -EINVAL;
-
 	kfree(smu_power->power_context);
 	smu_power->power_context = NULL;
 	smu_power->power_context_size = 0;
@@ -700,18 +694,16 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 
 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
-	int ret = 0;
 	struct amdgpu_device *adev = smu->adev;
 
 	/* Navy_Flounder do not support to change display num currently */
 	if (adev->asic_type == CHIP_NAVY_FLOUNDER)
 		return 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
-	ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays, count, NULL);
-	return ret;
+	return smu_cmn_send_smc_msg_with_param(smu,
+					       SMU_MSG_NumOfDisplays,
+					       count,
+					       NULL);
 }
 
 
@@ -773,9 +765,6 @@ int smu_v11_0_notify_display_change(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if (!smu->pm_enabled)
-		return ret;
-
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_UCLK_BIT) &&
 	    smu->adev->gmc.vram_type == AMDGPU_VRAM_TYPE_HBM)
 		ret = smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetUclkFastSwitch, 1, NULL);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
index c88f8fab1bae..5c8bb7314675 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_internal.h
@@ -42,6 +42,7 @@
 #define smu_check_fw_version(smu)					smu_ppt_funcs(check_fw_version, 0, smu)
 #define smu_write_pptable(smu)						smu_ppt_funcs(write_pptable, 0, smu)
 #define smu_set_min_dcef_deep_sleep(smu, clk)				smu_ppt_funcs(set_min_dcef_deep_sleep, 0, smu, clk)
+#define smu_set_active_display_count(smu, count)			smu_ppt_funcs(set_active_display_count, 0, smu, count)
 #define smu_set_driver_table_location(smu)				smu_ppt_funcs(set_driver_table_location, 0, smu)
 #define smu_set_tool_table_location(smu)				smu_ppt_funcs(set_tool_table_location, 0, smu)
 #define smu_notify_memory_pool_location(smu)				smu_ppt_funcs(notify_memory_pool_location, 0, smu)
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
