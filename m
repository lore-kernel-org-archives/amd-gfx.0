Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A31C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF1661444
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF1661444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6076EC77;
	Wed, 12 May 2021 17:31:40 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B503D6EC71
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTxDGX/hd1sfkB6xywbwVH6JwSiguqzdJTjpguRbp0CxFCx53cSCIKSLDZ8/SOtdFO/7Vg7xZDizx8VV033HCae8l0JqUGbLq9ck0Vyz8Urj4ixdjOV0+jEBx9vvz3ATJKiEI+DS2XGO0MMA8VUTJjF+x1TKLSGoC50ymRqaqRW2RfZHMXbkbSCeTySx5PXIA8eDSbKNZKVyMLcaO30F/zOcGP+fRHwVwW/nLKmQRcTARLTyvnuSI9/3ITfmMi+jr53VyIr6C/n9lxP3z4xSQ2Qn6fZR0ymMuHTyrkJfZXpRr2C6y9RKs2OvoQKO7zlqy52HPoKtSewm8jFbYiTipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTXy3XbHnpw1JctSzzyP5OzjRP4CTtHYtGyFIwWZh84=;
 b=EyDuZ6i0LGhQNOMPzBq8uPkxKSilDwKofPebxRhdat/7pjGIm8VBDEsUWRGKJUjiIbXN18LdtWi7APRo5XNrTeHTtUd2mo/y0mEQL2NO20lehkBQcPGRVWQXoDuy1qjJAuJUPZsqn6dgboH5pcpYPiO4a241fTyosFpcf0nu7Ilqe/6/TEqYjLgv/0IHMy1ueNilmPuSTyE6ZVKs4BS937qs2OUKe4tfv633u4ur17eo4oZ1aLzPQArEs0WX0RC6dgnrQe/y4AcAG1h7sm5AUR5BJvA6aeXsjoZ0LlkS8Cdqg0w6JRhm+MzyzudpITHKD5/ozsRKXszYqNe1XYYufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTXy3XbHnpw1JctSzzyP5OzjRP4CTtHYtGyFIwWZh84=;
 b=kBPHGTP7rkxPh2DipjLFBzLlJi/0uNGgzZ8RfDz412Uf9O8DezLIzl49veuI6YOEbL8Uc2+kf6xEGPFe0W3piP4VGjCqqVhzVMrRQbhKQhYwKCqQmABkfH7C9kqkwEzvOWBBjytAYy9oRq9RCr2d9JocvtjQ6EIqVAk4yCYPKjc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2340.namprd12.prod.outlook.com (2603:10b6:207:4d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 17:31:33 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:33 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 28/49] drm/amd/pm: use macro to get pptable members
Date: Wed, 12 May 2021 13:30:33 -0400
Message-Id: <20210512173053.2347842-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb06ada-0c99-40c9-c87b-08d9156bc81f
X-MS-TrafficTypeDiagnostic: BL0PR12MB2340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2340E0425E97163B2F2B0579F7529@BL0PR12MB2340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:234;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +bARbyOT0VwbpHg30umpjxezpFbVj6n6PoVIfGNUL2mgFo7jd6MSjwkSu9AHoMm27tIueAnxhTwtGbPpS7tpL6UNWulCYnhoCB+469dJDvQj5it9cnlstw8MPuJhsohvC1n410JZOy5WZ1uHGKwBqFB/kieaBEetVZqDbkE1zX3tudsZ/Iucbw9kqFhx0E/CUWPRgY2Gknz6SjIcUcjcSg77p+mf68dxcUbwgL94YqmIFJluer9cXaEbTs7p0NU4zRMRRb6XzECGuMkf+yRQT7sYsEuPYGzcM9mCXU8C4W1d96v+fwi6PMiPkJAJEnQk6pdSrJ9faPzeFTGKqsRLPbwI04wWD0MJosjtO0k7AozMO9Ua4UfToalnxrsWQZmEfj+KLIpeuTtXEOSC/XYeJVcCwL2zJGfoKKDMW548+t2yJ++SZQVb6h+MosFCLXFa4HENDladoBFLhKSJdYbqcQBqA6t79YxPrHg8AdKPMJ9CBr7GO6I0xjmrhcjkl6S7Z7ScjayVVTuO+4O6ucraB0zsIcKnbU4QA5XobaB9vCrtJyqv62kyXYBbAYDRDg5EQcBo3fjLOriEFaHySN5rbVfcLahhQfth97WVYA49rycpLjtQyjHbOQ7ABLnd3Y1Q+QOt36PqbUyQuj40zifYRCM9LWb/ZCIhsdHHw9ImwvoSS04wznEy9Z9BAjP3Rl/qRYDQYpMypNIJAfFStF/ODEXiIPSniB3tfVe757I3Ax8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(366004)(396003)(136003)(376002)(6506007)(26005)(38350700002)(66476007)(38100700002)(86362001)(4326008)(316002)(478600001)(2906002)(8676002)(52116002)(66946007)(66556008)(36756003)(5660300002)(54906003)(6916009)(2616005)(956004)(30864003)(6486002)(8936002)(16526019)(1076003)(83380400001)(6512007)(186003)(19627235002)(69590400013)(559001)(579004)(44824005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fIpMEV7lajSuVtpgHVZN4SsmVI2YkqoG1/1dlwHYSH7HDoncq/9sJJN2oslY?=
 =?us-ascii?Q?oJZw2jIwD51JQXzedh/+WI404Ri/mjJYVDX8eAPH3s7zlgAEU5pmCvVtIsXL?=
 =?us-ascii?Q?Zx+PjgPlA2EO7fGr1JROkLhtHOrG/SWIagtn4LUYpllqUjuiYLy6EoOf/xrd?=
 =?us-ascii?Q?2jhxgHIuJtqf4i6TjNSM4wRhMT8HLYA1rLaEY7kDtLzGiaYgO5wBTs47NPTL?=
 =?us-ascii?Q?J7YnMhn7JxKCLN2I5BSwVtgi/mxS0iiXKP2MQSGCVSSmbszZJ51eAX+1Jysm?=
 =?us-ascii?Q?tIVs0MVkNeWNSsXADNbHdQLaiw/AcJPFa2QxLYXRbm+Y/2/VGTXXt7I8vOZ/?=
 =?us-ascii?Q?CBD3C9N1wKG4MEUoKsmoO7WfXZG31J6Ypunubd+6Ylo9F0dX4hVhc/FuQidZ?=
 =?us-ascii?Q?n4a/CoxN5qln0yiAy+9po4alAMl48f/aXiZwxG4iIMVWTopl7oEce0YuxC1i?=
 =?us-ascii?Q?W8vHIBY3+eRf0+22nsRLTPJO0nEWsqirvhxurTwV85T6s1hNV/Wl3ckWfyEv?=
 =?us-ascii?Q?/3IPYKuy9EWQOZLnyLxDQuk7tOo6tRt92h7D9iafL2o1csGyzodSn2sC1bJg?=
 =?us-ascii?Q?7pg2rFHufL81daAy7KIp4QLCXaAd/7LtCwIU5qGiNkCtOlUOorX204kyqpJF?=
 =?us-ascii?Q?+Bx7f/E8YcjcoXbz0QJc2HT1T8VpBqXWs3DqueXn7yqIK9qWGmNw0wNmUoZE?=
 =?us-ascii?Q?EVOzPWT0rBUya9nx1ejFBPFu35fi0W4lG0iM8op+OEuVv7F/x6Q54+LaH8N/?=
 =?us-ascii?Q?exN1tHYFvBwgOSKxnBSebtdrXizzzRPFadYDF9Q9f2GD6C7BCQzCcmAS25zS?=
 =?us-ascii?Q?cQFESsUyN98aNIamQz9mHfXnAu46YzOmaB5mKVIJ/5BzVVvbDgamgnR+ea/s?=
 =?us-ascii?Q?FEguCY5JlZAPk/5SKXQ/DNBhO2x9Nf6ZPpWZ6lKh/WnF1u1x2tV5D1D/Q9V4?=
 =?us-ascii?Q?f6NVj7/r1ZZ1zcYObHKOQmM6lwf+XU9lHXZ3W5R6lrOgO3ZvafXBdOKgxxH2?=
 =?us-ascii?Q?/dLeAlIxf4/y+xomUsXXow7On9npRUhPh0yPunXptzmFCkZnSctuihOfCDlo?=
 =?us-ascii?Q?zJG1NXKMqyZhmj32Qi/pwEr6k+l53YAVY011na8UYNiw6L4fhAo5KxFQS+W4?=
 =?us-ascii?Q?1gUeUCz6qA58FQCIfp7gGjVpDrCUBAy2keMrAX9K3mF/0vChD91iEqBLfqS5?=
 =?us-ascii?Q?ouHpl6a0y/M+5w6BwBUHZ5XNBqdC/8pzVrCS8OCORH2TOJTW3vX3+cItadHc?=
 =?us-ascii?Q?Ik5/QeS6LkCEOZLRfzWtf+hI1F7004HlH5Bin3ScRCyA9fzSns9NlseFXPi3?=
 =?us-ascii?Q?XHivgnrtEGzODmBlzdTutw6O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb06ada-0c99-40c9-c87b-08d9156bc81f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:31.6908 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OURYm3SqOn6UhJ1b0wvXzL2SLw+6h7sQhlW4WX0Uj3RJofe9gtA+AAl2Tge5psItglzFgdouAtW54LAyR7GyXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2340
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Use macro to get the pptable members for different pptable structures.

v2: abstract the table operations especially get the table members
	to simplify cover the two different pptable structures.
v3: move pptable operations related structures and functions into ppt.c
v4: use macro to simplify the operation to get pptable members
v5: fix parameter reference error and add dump pptable support for
beige_goby

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Evan Quan <Evan.Quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 799 ++++++++++++++++--
 1 file changed, 731 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index d2fd44b903ca..91dcca649a15 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -73,6 +73,21 @@
 
 #define SMU_11_0_7_GFX_BUSY_THRESHOLD 15
 
+#define GET_PPTABLE_MEMBER(field, member) do {\
+	if (smu->adev->asic_type == CHIP_BEIGE_GOBY)\
+		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_beige_goby_t, field));\
+	else\
+		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_t, field));\
+} while(0)
+
+static int get_table_size(struct smu_context *smu)
+{
+	if (smu->adev->asic_type == CHIP_BEIGE_GOBY)
+		return sizeof(PPTable_beige_goby_t);
+	else
+		return sizeof(PPTable_t);
+}
+
 static struct cmn2asic_msg_mapping sienna_cichlid_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -336,10 +351,9 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
 
 static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 {
-	struct smu_table_context *table_context = &smu->smu_table;
-	PPTable_t *smc_pptable = table_context->driver_pptable;
 	struct atom_smc_dpm_info_v4_9 *smc_dpm_table;
 	int index, ret;
+	I2cControllerConfig_t *table_member;
 
 	index = get_index_into_master_table(atom_master_list_of_data_tables_v2_1,
 					    smc_dpm_info);
@@ -348,9 +362,9 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
 				      (uint8_t **)&smc_dpm_table);
 	if (ret)
 		return ret;
-
-	memcpy(smc_pptable->I2cControllers, smc_dpm_table->I2cControllers,
-	       sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
+	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
+	memcpy(table_member, smc_dpm_table->I2cControllers,
+			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
 	
 	return 0;
 }
@@ -360,9 +374,11 @@ static int sienna_cichlid_store_powerplay_table(struct smu_context *smu)
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		table_context->power_play_table;
+	int table_size;
 
+	table_size = get_table_size(smu);
 	memcpy(table_context->driver_pptable, &powerplay_table->smc_pptable,
-	       sizeof(PPTable_t));
+	       table_size);
 
 	return 0;
 }
@@ -394,9 +410,11 @@ static int sienna_cichlid_tables_init(struct smu_context *smu)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
 	struct smu_table *tables = smu_table->tables;
+	int table_size;
 
-	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, sizeof(PPTable_t),
-		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+	table_size = get_table_size(smu);
+	SMU_TABLE_INIT(tables, SMU_TABLE_PPTABLE, table_size,
+			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetricsExternal_t),
@@ -572,13 +590,14 @@ static int sienna_cichlid_init_smc_tables(struct smu_context *smu)
 static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	PPTable_t *driver_ppt = smu->smu_table.driver_pptable;
 	struct smu_11_0_dpm_table *dpm_table;
 	struct amdgpu_device *adev = smu->adev;
 	int ret = 0;
+	DpmDescriptor_t *table_member;
 
 	/* socclk dpm table setup */
 	dpm_table = &dpm_context->dpm_tables.soc_table;
+	GET_PPTABLE_MEMBER(DpmDescriptor, &table_member);
 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
 		ret = smu_v11_0_set_single_dpm_table(smu,
 						     SMU_SOCCLK,
@@ -586,7 +605,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete;
+			!table_member[PPCLK_SOCCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.socclk / 100;
@@ -604,7 +623,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete;
+			!table_member[PPCLK_GFXCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.gfxclk / 100;
@@ -622,7 +641,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete;
+			!table_member[PPCLK_UCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.uclk / 100;
@@ -640,7 +659,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete;
+			!table_member[PPCLK_FCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.fclk / 100;
@@ -658,7 +677,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_VCLK_0].SnapToDiscrete;
+			!table_member[PPCLK_VCLK_0].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.vclk / 100;
@@ -677,7 +696,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 			if (ret)
 				return ret;
 			dpm_table->is_fine_grained =
-				!driver_ppt->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete;
+				!table_member[PPCLK_VCLK_1].SnapToDiscrete;
 		} else {
 			dpm_table->count = 1;
 			dpm_table->dpm_levels[0].value =
@@ -697,7 +716,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_DCLK_0].SnapToDiscrete;
+			!table_member[PPCLK_DCLK_0].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dclk / 100;
@@ -716,7 +735,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 			if (ret)
 				return ret;
 			dpm_table->is_fine_grained =
-				!driver_ppt->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete;
+				!table_member[PPCLK_DCLK_1].SnapToDiscrete;
 		} else {
 			dpm_table->count = 1;
 			dpm_table->dpm_levels[0].value =
@@ -736,7 +755,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_DCEFCLK].SnapToDiscrete;
+			!table_member[PPCLK_DCEFCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
@@ -754,7 +773,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_PIXCLK].SnapToDiscrete;
+			!table_member[PPCLK_PIXCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
@@ -772,7 +791,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_DISPCLK].SnapToDiscrete;
+			!table_member[PPCLK_DISPCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
@@ -790,7 +809,7 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 		if (ret)
 			return ret;
 		dpm_table->is_fine_grained =
-			!driver_ppt->DpmDescriptor[PPCLK_PHYCLK].SnapToDiscrete;
+			!table_member[PPCLK_PHYCLK].SnapToDiscrete;
 	} else {
 		dpm_table->count = 1;
 		dpm_table->dpm_levels[0].value = smu->smu_table.boot_values.dcefclk / 100;
@@ -911,14 +930,15 @@ static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 
 static bool sienna_cichlid_is_support_fine_grained_dpm(struct smu_context *smu, enum smu_clk_type clk_type)
 {
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	DpmDescriptor_t *dpm_desc = NULL;
+	DpmDescriptor_t *table_member;
 	uint32_t clk_index = 0;
 
+	GET_PPTABLE_MEMBER(DpmDescriptor, &table_member);
 	clk_index = smu_cmn_to_asic_specific_index(smu,
 						   CMN2ASIC_MAPPING_CLK,
 						   clk_type);
-	dpm_desc = &pptable->DpmDescriptor[clk_index];
+	dpm_desc = &table_member[clk_index];
 
 	/* 0 - Fine grained DPM, 1 - Discrete DPM */
 	return dpm_desc->SnapToDiscrete == 0;
@@ -947,7 +967,8 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_11_0_dpm_context *dpm_context = smu_dpm->dpm_context;
-	PPTable_t *pptable = (PPTable_t *)table_context->driver_pptable;
+	uint16_t *table_member;
+
 	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
@@ -1016,6 +1037,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
+		GET_PPTABLE_MEMBER(LclkFreq, &table_member);
 		for (i = 0; i < NUM_LINK_LEVELS; i++)
 			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(dpm_context->dpm_tables.pcie_table.pcie_gen[i] == 0) ? "2.5GT/s," :
@@ -1028,7 +1050,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 4) ? "x8" :
 					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 5) ? "x12" :
 					(dpm_context->dpm_tables.pcie_table.pcie_lane[i] == 6) ? "x16" : "",
-					pptable->LclkFreq[i],
+					table_member[i],
 					(gen_speed == dpm_context->dpm_tables.pcie_table.pcie_gen[i]) &&
 					(lane_width == dpm_context->dpm_tables.pcie_table.pcie_lane[i]) ?
 					"*" : "");
@@ -1275,9 +1297,10 @@ static int sienna_cichlid_get_fan_speed_percent(struct smu_context *smu,
 
 static int sienna_cichlid_get_fan_parameters(struct smu_context *smu)
 {
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	uint16_t *table_member;
 
-	smu->fan_max_rpm = pptable->FanMaximumRpm;
+	GET_PPTABLE_MEMBER(FanMaximumRpm, &table_member);
+	smu->fan_max_rpm = *table_member;
 
 	return 0;
 }
@@ -1568,8 +1591,7 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 				 void *data, uint32_t *size)
 {
 	int ret = 0;
-	struct smu_table_context *table_context = &smu->smu_table;
-	PPTable_t *pptable = table_context->driver_pptable;
+	uint16_t *temp;
 
 	if(!data || !size)
 		return -EINVAL;
@@ -1577,7 +1599,8 @@ static int sienna_cichlid_read_sensor(struct smu_context *smu,
 	mutex_lock(&smu->sensor_lock);
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_MAX_FAN_RPM:
-		*(uint32_t *)data = pptable->FanMaximumRpm;
+		GET_PPTABLE_MEMBER(FanMaximumRpm, &temp);
+		*(uint16_t *)data = *temp;
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_MEM_LOAD:
@@ -1645,14 +1668,16 @@ static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t
 	uint16_t *dpm_levels = NULL;
 	uint16_t i = 0;
 	struct smu_table_context *table_context = &smu->smu_table;
-	PPTable_t *driver_ppt = NULL;
+	DpmDescriptor_t *table_member1;
+	uint16_t *table_member2;
 
 	if (!clocks_in_khz || !num_states || !table_context->driver_pptable)
 		return -EINVAL;
 
-	driver_ppt = table_context->driver_pptable;
-	num_discrete_levels = driver_ppt->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels;
-	dpm_levels = driver_ppt->FreqTableUclk;
+	GET_PPTABLE_MEMBER(DpmDescriptor, &table_member1);
+	num_discrete_levels = table_member1[PPCLK_UCLK].NumDiscreteLevels;
+	GET_PPTABLE_MEMBER(FreqTableUclk, &table_member2);
+	dpm_levels = table_member2;
 
 	if (num_discrete_levels == 0 || dpm_levels == NULL)
 		return -EINVAL;
@@ -1674,25 +1699,29 @@ static int sienna_cichlid_get_thermal_temperature_range(struct smu_context *smu,
 	struct smu_table_context *table_context = &smu->smu_table;
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 				table_context->power_play_table;
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
+	uint16_t *table_member;
+	uint16_t temp_edge, temp_hotspot, temp_mem;
 
 	if (!range)
 		return -EINVAL;
 
 	memcpy(range, &smu11_thermal_policy[0], sizeof(struct smu_temperature_range));
 
-	range->max = pptable->TemperatureLimit[TEMP_EDGE] *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->edge_emergency_max = (pptable->TemperatureLimit[TEMP_EDGE] + CTF_OFFSET_EDGE) *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->hotspot_crit_max = pptable->TemperatureLimit[TEMP_HOTSPOT] *
-		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->hotspot_emergency_max = (pptable->TemperatureLimit[TEMP_HOTSPOT] + CTF_OFFSET_HOTSPOT) *
+	GET_PPTABLE_MEMBER(TemperatureLimit, &table_member);
+	temp_edge = table_member[TEMP_EDGE];
+	temp_hotspot = table_member[TEMP_HOTSPOT];
+	temp_mem = table_member[TEMP_MEM];
+
+	range->max = temp_edge * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->edge_emergency_max = (temp_edge + CTF_OFFSET_EDGE) *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->mem_crit_max = pptable->TemperatureLimit[TEMP_MEM] *
+	range->hotspot_crit_max = temp_hotspot * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->hotspot_emergency_max = (temp_hotspot + CTF_OFFSET_HOTSPOT) *
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
-	range->mem_emergency_max = (pptable->TemperatureLimit[TEMP_MEM] + CTF_OFFSET_MEM)*
+	range->mem_crit_max = temp_mem * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+	range->mem_emergency_max = (temp_mem + CTF_OFFSET_MEM)*
 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+
 	range->software_shutdown_temp = powerplay_table->software_shutdown_temp;
 
 	return 0;
@@ -1726,17 +1755,14 @@ static int sienna_cichlid_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_7_powerplay_table *powerplay_table =
 		(struct smu_11_0_7_powerplay_table *)smu->smu_table.power_play_table;
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	uint32_t power_limit, od_percent;
+	uint16_t *table_member;
+
+	GET_PPTABLE_MEMBER(SocketPowerLimitAc, &table_member);
 
 	if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
-		/* the last hope to figure out the ppt limit */
-		if (!pptable) {
-			dev_err(smu->adev->dev, "Cannot get PPT limit due to pptable missing!");
-			return -EINVAL;
-		}
 		power_limit =
-			pptable->SocketPowerLimitAc[PPT_THROTTLER_PPT0];
+			table_member[PPT_THROTTLER_PPT0];
 	}
 	smu->current_power_limit = smu->default_power_limit = power_limit;
 
@@ -1758,36 +1784,39 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					 uint32_t pcie_width_cap)
 {
 	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	PPTable_t *pptable = smu->smu_table.driver_pptable;
+
 	uint32_t smu_pcie_arg;
+	uint8_t *table_member1, *table_member2;
 	int ret, i;
 
+	GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
+	GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2);
+
 	/* lclk dpm table setup */
 	for (i = 0; i < MAX_PCIE_CONF; i++) {
-		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pptable->PcieGenSpeed[i];
-		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pptable->PcieLaneCount[i];
+		dpm_context->dpm_tables.pcie_table.pcie_gen[i] = table_member1[i];
+		dpm_context->dpm_tables.pcie_table.pcie_lane[i] = table_member2[i];
 	}
 
 	for (i = 0; i < NUM_LINK_LEVELS; i++) {
 		smu_pcie_arg = (i << 16) |
-			((pptable->PcieGenSpeed[i] <= pcie_gen_cap) ?
-					(pptable->PcieGenSpeed[i] << 8) :
-					(pcie_gen_cap << 8)) |
-			((pptable->PcieLaneCount[i] <= pcie_width_cap) ?
-					pptable->PcieLaneCount[i] :
-					pcie_width_cap);
+			((table_member1[i] <= pcie_gen_cap) ?
+			 (table_member1[i] << 8) :
+			 (pcie_gen_cap << 8)) |
+			((table_member2[i] <= pcie_width_cap) ?
+			 table_member2[i] :
+			 pcie_width_cap);
 
 		ret = smu_cmn_send_smc_msg_with_param(smu,
-					  SMU_MSG_OverridePcieParameters,
-					  smu_pcie_arg,
-					  NULL);
-
+				SMU_MSG_OverridePcieParameters,
+				smu_pcie_arg,
+				NULL);
 		if (ret)
 			return ret;
 
-		if (pptable->PcieGenSpeed[i] > pcie_gen_cap)
+		if (table_member1[i] > pcie_gen_cap)
 			dpm_context->dpm_tables.pcie_table.pcie_gen[i] = pcie_gen_cap;
-		if (pptable->PcieLaneCount[i] > pcie_width_cap)
+		if (table_member2[i] > pcie_width_cap)
 			dpm_context->dpm_tables.pcie_table.pcie_lane[i] = pcie_width_cap;
 	}
 
@@ -2086,10 +2115,10 @@ static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu)
 	return val != 0x0;
 }
 
-static void sienna_cichlid_dump_pptable(struct smu_context *smu)
+static void beige_goby_dump_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
-	PPTable_t *pptable = table_context->driver_pptable;
+	PPTable_beige_goby_t *pptable = table_context->driver_pptable;
 	int i;
 
 	dev_info(smu->adev->dev, "Dumped PPTable:\n");
@@ -2134,6 +2163,640 @@ static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 	dev_info(smu->adev->dev, "MinVoltageUlvGfx = 0x%x\n", pptable->MinVoltageUlvGfx);
 	dev_info(smu->adev->dev, "MinVoltageUlvSoc = 0x%x\n", pptable->MinVoltageUlvSoc);
 
+	dev_info(smu->adev->dev, "SocLIVmin = 0x%x\n", pptable->SocLIVmin);
+
+	dev_info(smu->adev->dev, "GceaLinkMgrIdleThreshold = 0x%x\n", pptable->GceaLinkMgrIdleThreshold);
+
+	dev_info(smu->adev->dev, "MinVoltageGfx = 0x%x\n", pptable->MinVoltageGfx);
+	dev_info(smu->adev->dev, "MinVoltageSoc = 0x%x\n", pptable->MinVoltageSoc);
+	dev_info(smu->adev->dev, "MaxVoltageGfx = 0x%x\n", pptable->MaxVoltageGfx);
+	dev_info(smu->adev->dev, "MaxVoltageSoc = 0x%x\n", pptable->MaxVoltageSoc);
+
+	dev_info(smu->adev->dev, "LoadLineResistanceGfx = 0x%x\n", pptable->LoadLineResistanceGfx);
+	dev_info(smu->adev->dev, "LoadLineResistanceSoc = 0x%x\n", pptable->LoadLineResistanceSoc);
+
+	dev_info(smu->adev->dev, "VDDGFX_TVmin = 0x%x\n", pptable->VDDGFX_TVmin);
+	dev_info(smu->adev->dev, "VDDSOC_TVmin = 0x%x\n", pptable->VDDSOC_TVmin);
+	dev_info(smu->adev->dev, "VDDGFX_Vmin_HiTemp = 0x%x\n", pptable->VDDGFX_Vmin_HiTemp);
+	dev_info(smu->adev->dev, "VDDGFX_Vmin_LoTemp = 0x%x\n", pptable->VDDGFX_Vmin_LoTemp);
+	dev_info(smu->adev->dev, "VDDSOC_Vmin_HiTemp = 0x%x\n", pptable->VDDSOC_Vmin_HiTemp);
+	dev_info(smu->adev->dev, "VDDSOC_Vmin_LoTemp = 0x%x\n", pptable->VDDSOC_Vmin_LoTemp);
+	dev_info(smu->adev->dev, "VDDGFX_TVminHystersis = 0x%x\n", pptable->VDDGFX_TVminHystersis);
+	dev_info(smu->adev->dev, "VDDSOC_TVminHystersis = 0x%x\n", pptable->VDDSOC_TVminHystersis);
+
+	dev_info(smu->adev->dev, "[PPCLK_GFXCLK]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_GFXCLK].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].Padding,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].SsFmin,
+			pptable->DpmDescriptor[PPCLK_GFXCLK].Padding16);
+
+	dev_info(smu->adev->dev, "[PPCLK_SOCCLK]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_SOCCLK].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].Padding,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].SsFmin,
+			pptable->DpmDescriptor[PPCLK_SOCCLK].Padding16);
+
+	dev_info(smu->adev->dev, "[PPCLK_UCLK]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_UCLK].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_UCLK].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_UCLK].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_UCLK].Padding,
+			pptable->DpmDescriptor[PPCLK_UCLK].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_UCLK].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_UCLK].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_UCLK].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_UCLK].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_UCLK].SsFmin,
+			pptable->DpmDescriptor[PPCLK_UCLK].Padding16);
+
+	dev_info(smu->adev->dev, "[PPCLK_FCLK]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_FCLK].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_FCLK].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_FCLK].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_FCLK].Padding,
+			pptable->DpmDescriptor[PPCLK_FCLK].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_FCLK].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_FCLK].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_FCLK].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_FCLK].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_FCLK].SsFmin,
+			pptable->DpmDescriptor[PPCLK_FCLK].Padding16);
+
+	dev_info(smu->adev->dev, "[PPCLK_DCLK_0]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_DCLK_0].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].Padding,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].SsFmin,
+			pptable->DpmDescriptor[PPCLK_DCLK_0].Padding16);
+
+	dev_info(smu->adev->dev, "[PPCLK_VCLK_0]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_VCLK_0].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].Padding,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].SsFmin,
+			pptable->DpmDescriptor[PPCLK_VCLK_0].Padding16);
+
+	dev_info(smu->adev->dev, "[PPCLK_DCLK_1]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_DCLK_1].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].Padding,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].SsFmin,
+			pptable->DpmDescriptor[PPCLK_DCLK_1].Padding16);
+
+	dev_info(smu->adev->dev, "[PPCLK_VCLK_1]\n"
+			"  .VoltageMode          = 0x%02x\n"
+			"  .SnapToDiscrete       = 0x%02x\n"
+			"  .NumDiscreteLevels    = 0x%02x\n"
+			"  .padding              = 0x%02x\n"
+			"  .ConversionToAvfsClk{m = 0x%08x b = 0x%08x}\n"
+			"  .SsCurve            {a = 0x%08x b = 0x%08x c = 0x%08x}\n"
+			"  .SsFmin               = 0x%04x\n"
+			"  .Padding_16           = 0x%04x\n",
+			pptable->DpmDescriptor[PPCLK_VCLK_1].VoltageMode,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].SnapToDiscrete,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].NumDiscreteLevels,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].Padding,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].ConversionToAvfsClk.m,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].ConversionToAvfsClk.b,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].SsCurve.a,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].SsCurve.b,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].SsCurve.c,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].SsFmin,
+			pptable->DpmDescriptor[PPCLK_VCLK_1].Padding16);
+
+	dev_info(smu->adev->dev, "FreqTableGfx\n");
+	for (i = 0; i < NUM_GFXCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableGfx[i]);
+
+	dev_info(smu->adev->dev, "FreqTableVclk\n");
+	for (i = 0; i < NUM_VCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableVclk[i]);
+
+	dev_info(smu->adev->dev, "FreqTableDclk\n");
+	for (i = 0; i < NUM_DCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableDclk[i]);
+
+	dev_info(smu->adev->dev, "FreqTableSocclk\n");
+	for (i = 0; i < NUM_SOCCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableSocclk[i]);
+
+	dev_info(smu->adev->dev, "FreqTableUclk\n");
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableUclk[i]);
+
+	dev_info(smu->adev->dev, "FreqTableFclk\n");
+	for (i = 0; i < NUM_FCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%02d] = 0x%x\n", i, pptable->FreqTableFclk[i]);
+
+	dev_info(smu->adev->dev, "DcModeMaxFreq\n");
+	dev_info(smu->adev->dev, "  .PPCLK_GFXCLK = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_GFXCLK]);
+	dev_info(smu->adev->dev, "  .PPCLK_SOCCLK = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_SOCCLK]);
+	dev_info(smu->adev->dev, "  .PPCLK_UCLK   = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_UCLK]);
+	dev_info(smu->adev->dev, "  .PPCLK_FCLK   = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_FCLK]);
+	dev_info(smu->adev->dev, "  .PPCLK_DCLK_0 = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_DCLK_0]);
+	dev_info(smu->adev->dev, "  .PPCLK_VCLK_0 = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_VCLK_0]);
+	dev_info(smu->adev->dev, "  .PPCLK_DCLK_1 = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_DCLK_1]);
+	dev_info(smu->adev->dev, "  .PPCLK_VCLK_1 = 0x%x\n", pptable->DcModeMaxFreq[PPCLK_VCLK_1]);
+
+	dev_info(smu->adev->dev, "FreqTableUclkDiv\n");
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->FreqTableUclkDiv[i]);
+
+	dev_info(smu->adev->dev, "FclkBoostFreq = 0x%x\n", pptable->FclkBoostFreq);
+	dev_info(smu->adev->dev, "FclkParamPadding = 0x%x\n", pptable->FclkParamPadding);
+
+	dev_info(smu->adev->dev, "Mp0clkFreq\n");
+	for (i = 0; i < NUM_MP0CLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->Mp0clkFreq[i]);
+
+	dev_info(smu->adev->dev, "Mp0DpmVoltage\n");
+	for (i = 0; i < NUM_MP0CLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->Mp0DpmVoltage[i]);
+
+	dev_info(smu->adev->dev, "MemVddciVoltage\n");
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->MemVddciVoltage[i]);
+
+	dev_info(smu->adev->dev, "MemMvddVoltage\n");
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->MemMvddVoltage[i]);
+
+	dev_info(smu->adev->dev, "GfxclkFgfxoffEntry = 0x%x\n", pptable->GfxclkFgfxoffEntry);
+	dev_info(smu->adev->dev, "GfxclkFinit = 0x%x\n", pptable->GfxclkFinit);
+	dev_info(smu->adev->dev, "GfxclkFidle = 0x%x\n", pptable->GfxclkFidle);
+	dev_info(smu->adev->dev, "GfxclkSource = 0x%x\n", pptable->GfxclkSource);
+	dev_info(smu->adev->dev, "GfxclkPadding = 0x%x\n", pptable->GfxclkPadding);
+
+	dev_info(smu->adev->dev, "GfxGpoSubFeatureMask = 0x%x\n", pptable->GfxGpoSubFeatureMask);
+
+	dev_info(smu->adev->dev, "GfxGpoEnabledWorkPolicyMask = 0x%x\n", pptable->GfxGpoEnabledWorkPolicyMask);
+	dev_info(smu->adev->dev, "GfxGpoDisabledWorkPolicyMask = 0x%x\n", pptable->GfxGpoDisabledWorkPolicyMask);
+	dev_info(smu->adev->dev, "GfxGpoPadding[0] = 0x%x\n", pptable->GfxGpoPadding[0]);
+	dev_info(smu->adev->dev, "GfxGpoVotingAllow = 0x%x\n", pptable->GfxGpoVotingAllow);
+	dev_info(smu->adev->dev, "GfxGpoPadding32[0] = 0x%x\n", pptable->GfxGpoPadding32[0]);
+	dev_info(smu->adev->dev, "GfxGpoPadding32[1] = 0x%x\n", pptable->GfxGpoPadding32[1]);
+	dev_info(smu->adev->dev, "GfxGpoPadding32[2] = 0x%x\n", pptable->GfxGpoPadding32[2]);
+	dev_info(smu->adev->dev, "GfxGpoPadding32[3] = 0x%x\n", pptable->GfxGpoPadding32[3]);
+	dev_info(smu->adev->dev, "GfxDcsFopt = 0x%x\n", pptable->GfxDcsFopt);
+	dev_info(smu->adev->dev, "GfxDcsFclkFopt = 0x%x\n", pptable->GfxDcsFclkFopt);
+	dev_info(smu->adev->dev, "GfxDcsUclkFopt = 0x%x\n", pptable->GfxDcsUclkFopt);
+
+	dev_info(smu->adev->dev, "DcsGfxOffVoltage = 0x%x\n", pptable->DcsGfxOffVoltage);
+	dev_info(smu->adev->dev, "DcsMinGfxOffTime = 0x%x\n", pptable->DcsMinGfxOffTime);
+	dev_info(smu->adev->dev, "DcsMaxGfxOffTime = 0x%x\n", pptable->DcsMaxGfxOffTime);
+	dev_info(smu->adev->dev, "DcsMinCreditAccum = 0x%x\n", pptable->DcsMinCreditAccum);
+	dev_info(smu->adev->dev, "DcsExitHysteresis = 0x%x\n", pptable->DcsExitHysteresis);
+	dev_info(smu->adev->dev, "DcsTimeout = 0x%x\n", pptable->DcsTimeout);
+
+	dev_info(smu->adev->dev, "DcsParamPadding[0] = 0x%x\n", pptable->DcsParamPadding[0]);
+	dev_info(smu->adev->dev, "DcsParamPadding[1] = 0x%x\n", pptable->DcsParamPadding[1]);
+	dev_info(smu->adev->dev, "DcsParamPadding[2] = 0x%x\n", pptable->DcsParamPadding[2]);
+	dev_info(smu->adev->dev, "DcsParamPadding[3] = 0x%x\n", pptable->DcsParamPadding[3]);
+	dev_info(smu->adev->dev, "DcsParamPadding[4] = 0x%x\n", pptable->DcsParamPadding[4]);
+
+	dev_info(smu->adev->dev, "FlopsPerByteTable\n");
+	for (i = 0; i < RLC_PACE_TABLE_NUM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->FlopsPerByteTable[i]);
+
+	dev_info(smu->adev->dev, "LowestUclkReservedForUlv = 0x%x\n", pptable->LowestUclkReservedForUlv);
+	dev_info(smu->adev->dev, "vddingMem[0] = 0x%x\n", pptable->PaddingMem[0]);
+	dev_info(smu->adev->dev, "vddingMem[1] = 0x%x\n", pptable->PaddingMem[1]);
+	dev_info(smu->adev->dev, "vddingMem[2] = 0x%x\n", pptable->PaddingMem[2]);
+
+	dev_info(smu->adev->dev, "UclkDpmPstates\n");
+	for (i = 0; i < NUM_UCLK_DPM_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->UclkDpmPstates[i]);
+
+	dev_info(smu->adev->dev, "UclkDpmSrcFreqRange\n");
+	dev_info(smu->adev->dev, "  .Fmin = 0x%x\n",
+		pptable->UclkDpmSrcFreqRange.Fmin);
+	dev_info(smu->adev->dev, "  .Fmax = 0x%x\n",
+		pptable->UclkDpmSrcFreqRange.Fmax);
+	dev_info(smu->adev->dev, "UclkDpmTargFreqRange\n");
+	dev_info(smu->adev->dev, "  .Fmin = 0x%x\n",
+		pptable->UclkDpmTargFreqRange.Fmin);
+	dev_info(smu->adev->dev, "  .Fmax = 0x%x\n",
+		pptable->UclkDpmTargFreqRange.Fmax);
+	dev_info(smu->adev->dev, "UclkDpmMidstepFreq = 0x%x\n", pptable->UclkDpmMidstepFreq);
+	dev_info(smu->adev->dev, "UclkMidstepPadding = 0x%x\n", pptable->UclkMidstepPadding);
+
+	dev_info(smu->adev->dev, "PcieGenSpeed\n");
+	for (i = 0; i < NUM_LINK_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->PcieGenSpeed[i]);
+
+	dev_info(smu->adev->dev, "PcieLaneCount\n");
+	for (i = 0; i < NUM_LINK_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->PcieLaneCount[i]);
+
+	dev_info(smu->adev->dev, "LclkFreq\n");
+	for (i = 0; i < NUM_LINK_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->LclkFreq[i]);
+
+	dev_info(smu->adev->dev, "FanStopTemp = 0x%x\n", pptable->FanStopTemp);
+	dev_info(smu->adev->dev, "FanStartTemp = 0x%x\n", pptable->FanStartTemp);
+
+	dev_info(smu->adev->dev, "FanGain\n");
+	for (i = 0; i < TEMP_COUNT; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->FanGain[i]);
+
+	dev_info(smu->adev->dev, "FanPwmMin = 0x%x\n", pptable->FanPwmMin);
+	dev_info(smu->adev->dev, "FanAcousticLimitRpm = 0x%x\n", pptable->FanAcousticLimitRpm);
+	dev_info(smu->adev->dev, "FanThrottlingRpm = 0x%x\n", pptable->FanThrottlingRpm);
+	dev_info(smu->adev->dev, "FanMaximumRpm = 0x%x\n", pptable->FanMaximumRpm);
+	dev_info(smu->adev->dev, "MGpuFanBoostLimitRpm = 0x%x\n", pptable->MGpuFanBoostLimitRpm);
+	dev_info(smu->adev->dev, "FanTargetTemperature = 0x%x\n", pptable->FanTargetTemperature);
+	dev_info(smu->adev->dev, "FanTargetGfxclk = 0x%x\n", pptable->FanTargetGfxclk);
+	dev_info(smu->adev->dev, "FanPadding16 = 0x%x\n", pptable->FanPadding16);
+	dev_info(smu->adev->dev, "FanTempInputSelect = 0x%x\n", pptable->FanTempInputSelect);
+	dev_info(smu->adev->dev, "FanPadding = 0x%x\n", pptable->FanPadding);
+	dev_info(smu->adev->dev, "FanZeroRpmEnable = 0x%x\n", pptable->FanZeroRpmEnable);
+	dev_info(smu->adev->dev, "FanTachEdgePerRev = 0x%x\n", pptable->FanTachEdgePerRev);
+
+	dev_info(smu->adev->dev, "FuzzyFan_ErrorSetDelta = 0x%x\n", pptable->FuzzyFan_ErrorSetDelta);
+	dev_info(smu->adev->dev, "FuzzyFan_ErrorRateSetDelta = 0x%x\n", pptable->FuzzyFan_ErrorRateSetDelta);
+	dev_info(smu->adev->dev, "FuzzyFan_PwmSetDelta = 0x%x\n", pptable->FuzzyFan_PwmSetDelta);
+	dev_info(smu->adev->dev, "FuzzyFan_Reserved = 0x%x\n", pptable->FuzzyFan_Reserved);
+
+	dev_info(smu->adev->dev, "OverrideAvfsGb[AVFS_VOLTAGE_GFX] = 0x%x\n", pptable->OverrideAvfsGb[AVFS_VOLTAGE_GFX]);
+	dev_info(smu->adev->dev, "OverrideAvfsGb[AVFS_VOLTAGE_SOC] = 0x%x\n", pptable->OverrideAvfsGb[AVFS_VOLTAGE_SOC]);
+	dev_info(smu->adev->dev, "dBtcGbGfxDfllModelSelect = 0x%x\n", pptable->dBtcGbGfxDfllModelSelect);
+	dev_info(smu->adev->dev, "Padding8_Avfs = 0x%x\n", pptable->Padding8_Avfs);
+
+	dev_info(smu->adev->dev, "qAvfsGb[AVFS_VOLTAGE_GFX]{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->qAvfsGb[AVFS_VOLTAGE_GFX].a,
+			pptable->qAvfsGb[AVFS_VOLTAGE_GFX].b,
+			pptable->qAvfsGb[AVFS_VOLTAGE_GFX].c);
+	dev_info(smu->adev->dev, "qAvfsGb[AVFS_VOLTAGE_SOC]{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->qAvfsGb[AVFS_VOLTAGE_SOC].a,
+			pptable->qAvfsGb[AVFS_VOLTAGE_SOC].b,
+			pptable->qAvfsGb[AVFS_VOLTAGE_SOC].c);
+	dev_info(smu->adev->dev, "dBtcGbGfxPll{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->dBtcGbGfxPll.a,
+			pptable->dBtcGbGfxPll.b,
+			pptable->dBtcGbGfxPll.c);
+	dev_info(smu->adev->dev, "dBtcGbGfxAfll{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->dBtcGbGfxDfll.a,
+			pptable->dBtcGbGfxDfll.b,
+			pptable->dBtcGbGfxDfll.c);
+	dev_info(smu->adev->dev, "dBtcGbSoc{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->dBtcGbSoc.a,
+			pptable->dBtcGbSoc.b,
+			pptable->dBtcGbSoc.c);
+	dev_info(smu->adev->dev, "qAgingGb[AVFS_VOLTAGE_GFX]{m = 0x%x b = 0x%x}\n",
+			pptable->qAgingGb[AVFS_VOLTAGE_GFX].m,
+			pptable->qAgingGb[AVFS_VOLTAGE_GFX].b);
+	dev_info(smu->adev->dev, "qAgingGb[AVFS_VOLTAGE_SOC]{m = 0x%x b = 0x%x}\n",
+			pptable->qAgingGb[AVFS_VOLTAGE_SOC].m,
+			pptable->qAgingGb[AVFS_VOLTAGE_SOC].b);
+
+	dev_info(smu->adev->dev, "PiecewiseLinearDroopIntGfxDfll\n");
+	for (i = 0; i < NUM_PIECE_WISE_LINEAR_DROOP_MODEL_VF_POINTS; i++) {
+		dev_info(smu->adev->dev, "		Fset[%d] = 0x%x\n",
+			i, pptable->PiecewiseLinearDroopIntGfxDfll.Fset[i]);
+		dev_info(smu->adev->dev, "		Vdroop[%d] = 0x%x\n",
+			i, pptable->PiecewiseLinearDroopIntGfxDfll.Vdroop[i]);
+	}
+
+	dev_info(smu->adev->dev, "qStaticVoltageOffset[AVFS_VOLTAGE_GFX]{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->qStaticVoltageOffset[AVFS_VOLTAGE_GFX].a,
+			pptable->qStaticVoltageOffset[AVFS_VOLTAGE_GFX].b,
+			pptable->qStaticVoltageOffset[AVFS_VOLTAGE_GFX].c);
+	dev_info(smu->adev->dev, "qStaticVoltageOffset[AVFS_VOLTAGE_SOC]{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->qStaticVoltageOffset[AVFS_VOLTAGE_SOC].a,
+			pptable->qStaticVoltageOffset[AVFS_VOLTAGE_SOC].b,
+			pptable->qStaticVoltageOffset[AVFS_VOLTAGE_SOC].c);
+
+	dev_info(smu->adev->dev, "DcTol[AVFS_VOLTAGE_GFX] = 0x%x\n", pptable->DcTol[AVFS_VOLTAGE_GFX]);
+	dev_info(smu->adev->dev, "DcTol[AVFS_VOLTAGE_SOC] = 0x%x\n", pptable->DcTol[AVFS_VOLTAGE_SOC]);
+
+	dev_info(smu->adev->dev, "DcBtcEnabled[AVFS_VOLTAGE_GFX] = 0x%x\n", pptable->DcBtcEnabled[AVFS_VOLTAGE_GFX]);
+	dev_info(smu->adev->dev, "DcBtcEnabled[AVFS_VOLTAGE_SOC] = 0x%x\n", pptable->DcBtcEnabled[AVFS_VOLTAGE_SOC]);
+	dev_info(smu->adev->dev, "Padding8_GfxBtc[0] = 0x%x\n", pptable->Padding8_GfxBtc[0]);
+	dev_info(smu->adev->dev, "Padding8_GfxBtc[1] = 0x%x\n", pptable->Padding8_GfxBtc[1]);
+
+	dev_info(smu->adev->dev, "DcBtcMin[AVFS_VOLTAGE_GFX] = 0x%x\n", pptable->DcBtcMin[AVFS_VOLTAGE_GFX]);
+	dev_info(smu->adev->dev, "DcBtcMin[AVFS_VOLTAGE_SOC] = 0x%x\n", pptable->DcBtcMin[AVFS_VOLTAGE_SOC]);
+	dev_info(smu->adev->dev, "DcBtcMax[AVFS_VOLTAGE_GFX] = 0x%x\n", pptable->DcBtcMax[AVFS_VOLTAGE_GFX]);
+	dev_info(smu->adev->dev, "DcBtcMax[AVFS_VOLTAGE_SOC] = 0x%x\n", pptable->DcBtcMax[AVFS_VOLTAGE_SOC]);
+
+	dev_info(smu->adev->dev, "DcBtcGb[AVFS_VOLTAGE_GFX] = 0x%x\n", pptable->DcBtcGb[AVFS_VOLTAGE_GFX]);
+	dev_info(smu->adev->dev, "DcBtcGb[AVFS_VOLTAGE_SOC] = 0x%x\n", pptable->DcBtcGb[AVFS_VOLTAGE_SOC]);
+
+	dev_info(smu->adev->dev, "XgmiDpmPstates\n");
+	for (i = 0; i < NUM_XGMI_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->XgmiDpmPstates[i]);
+	dev_info(smu->adev->dev, "XgmiDpmSpare[0] = 0x%02x\n", pptable->XgmiDpmSpare[0]);
+	dev_info(smu->adev->dev, "XgmiDpmSpare[1] = 0x%02x\n", pptable->XgmiDpmSpare[1]);
+
+	dev_info(smu->adev->dev, "DebugOverrides = 0x%x\n", pptable->DebugOverrides);
+	dev_info(smu->adev->dev, "ReservedEquation0{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->ReservedEquation0.a,
+			pptable->ReservedEquation0.b,
+			pptable->ReservedEquation0.c);
+	dev_info(smu->adev->dev, "ReservedEquation1{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->ReservedEquation1.a,
+			pptable->ReservedEquation1.b,
+			pptable->ReservedEquation1.c);
+	dev_info(smu->adev->dev, "ReservedEquation2{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->ReservedEquation2.a,
+			pptable->ReservedEquation2.b,
+			pptable->ReservedEquation2.c);
+	dev_info(smu->adev->dev, "ReservedEquation3{a = 0x%x b = 0x%x c = 0x%x}\n",
+			pptable->ReservedEquation3.a,
+			pptable->ReservedEquation3.b,
+			pptable->ReservedEquation3.c);
+
+	dev_info(smu->adev->dev, "SkuReserved[0] = 0x%x\n", pptable->SkuReserved[0]);
+	dev_info(smu->adev->dev, "SkuReserved[1] = 0x%x\n", pptable->SkuReserved[1]);
+	dev_info(smu->adev->dev, "SkuReserved[2] = 0x%x\n", pptable->SkuReserved[2]);
+	dev_info(smu->adev->dev, "SkuReserved[3] = 0x%x\n", pptable->SkuReserved[3]);
+	dev_info(smu->adev->dev, "SkuReserved[4] = 0x%x\n", pptable->SkuReserved[4]);
+	dev_info(smu->adev->dev, "SkuReserved[5] = 0x%x\n", pptable->SkuReserved[5]);
+	dev_info(smu->adev->dev, "SkuReserved[6] = 0x%x\n", pptable->SkuReserved[6]);
+	dev_info(smu->adev->dev, "SkuReserved[7] = 0x%x\n", pptable->SkuReserved[7]);
+
+	dev_info(smu->adev->dev, "GamingClk[0] = 0x%x\n", pptable->GamingClk[0]);
+	dev_info(smu->adev->dev, "GamingClk[1] = 0x%x\n", pptable->GamingClk[1]);
+	dev_info(smu->adev->dev, "GamingClk[2] = 0x%x\n", pptable->GamingClk[2]);
+	dev_info(smu->adev->dev, "GamingClk[3] = 0x%x\n", pptable->GamingClk[3]);
+	dev_info(smu->adev->dev, "GamingClk[4] = 0x%x\n", pptable->GamingClk[4]);
+	dev_info(smu->adev->dev, "GamingClk[5] = 0x%x\n", pptable->GamingClk[5]);
+
+	for (i = 0; i < NUM_I2C_CONTROLLERS; i++) {
+		dev_info(smu->adev->dev, "I2cControllers[%d]:\n", i);
+		dev_info(smu->adev->dev, "                   .Enabled = 0x%x\n",
+				pptable->I2cControllers[i].Enabled);
+		dev_info(smu->adev->dev, "                   .Speed = 0x%x\n",
+				pptable->I2cControllers[i].Speed);
+		dev_info(smu->adev->dev, "                   .SlaveAddress = 0x%x\n",
+				pptable->I2cControllers[i].SlaveAddress);
+		dev_info(smu->adev->dev, "                   .ControllerPort = 0x%x\n",
+				pptable->I2cControllers[i].ControllerPort);
+		dev_info(smu->adev->dev, "                   .ControllerName = 0x%x\n",
+				pptable->I2cControllers[i].ControllerName);
+		dev_info(smu->adev->dev, "                   .ThermalThrottler = 0x%x\n",
+				pptable->I2cControllers[i].ThermalThrotter);
+		dev_info(smu->adev->dev, "                   .I2cProtocol = 0x%x\n",
+				pptable->I2cControllers[i].I2cProtocol);
+		dev_info(smu->adev->dev, "                   .PaddingConfig = 0x%x\n",
+				pptable->I2cControllers[i].PaddingConfig);
+	}
+
+	dev_info(smu->adev->dev, "GpioScl = 0x%x\n", pptable->GpioScl);
+	dev_info(smu->adev->dev, "GpioSda = 0x%x\n", pptable->GpioSda);
+	dev_info(smu->adev->dev, "FchUsbPdSlaveAddr = 0x%x\n", pptable->FchUsbPdSlaveAddr);
+	dev_info(smu->adev->dev, "I2cSpare[0] = 0x%x\n", pptable->I2cSpare[0]);
+
+	dev_info(smu->adev->dev, "Board Parameters:\n");
+	dev_info(smu->adev->dev, "VddGfxVrMapping = 0x%x\n", pptable->VddGfxVrMapping);
+	dev_info(smu->adev->dev, "VddSocVrMapping = 0x%x\n", pptable->VddSocVrMapping);
+	dev_info(smu->adev->dev, "VddMem0VrMapping = 0x%x\n", pptable->VddMem0VrMapping);
+	dev_info(smu->adev->dev, "VddMem1VrMapping = 0x%x\n", pptable->VddMem1VrMapping);
+	dev_info(smu->adev->dev, "GfxUlvPhaseSheddingMask = 0x%x\n", pptable->GfxUlvPhaseSheddingMask);
+	dev_info(smu->adev->dev, "SocUlvPhaseSheddingMask = 0x%x\n", pptable->SocUlvPhaseSheddingMask);
+	dev_info(smu->adev->dev, "VddciUlvPhaseSheddingMask = 0x%x\n", pptable->VddciUlvPhaseSheddingMask);
+	dev_info(smu->adev->dev, "MvddUlvPhaseSheddingMask = 0x%x\n", pptable->MvddUlvPhaseSheddingMask);
+
+	dev_info(smu->adev->dev, "GfxMaxCurrent = 0x%x\n", pptable->GfxMaxCurrent);
+	dev_info(smu->adev->dev, "GfxOffset = 0x%x\n", pptable->GfxOffset);
+	dev_info(smu->adev->dev, "Padding_TelemetryGfx = 0x%x\n", pptable->Padding_TelemetryGfx);
+
+	dev_info(smu->adev->dev, "SocMaxCurrent = 0x%x\n", pptable->SocMaxCurrent);
+	dev_info(smu->adev->dev, "SocOffset = 0x%x\n", pptable->SocOffset);
+	dev_info(smu->adev->dev, "Padding_TelemetrySoc = 0x%x\n", pptable->Padding_TelemetrySoc);
+
+	dev_info(smu->adev->dev, "Mem0MaxCurrent = 0x%x\n", pptable->Mem0MaxCurrent);
+	dev_info(smu->adev->dev, "Mem0Offset = 0x%x\n", pptable->Mem0Offset);
+	dev_info(smu->adev->dev, "Padding_TelemetryMem0 = 0x%x\n", pptable->Padding_TelemetryMem0);
+
+	dev_info(smu->adev->dev, "Mem1MaxCurrent = 0x%x\n", pptable->Mem1MaxCurrent);
+	dev_info(smu->adev->dev, "Mem1Offset = 0x%x\n", pptable->Mem1Offset);
+	dev_info(smu->adev->dev, "Padding_TelemetryMem1 = 0x%x\n", pptable->Padding_TelemetryMem1);
+
+	dev_info(smu->adev->dev, "MvddRatio = 0x%x\n", pptable->MvddRatio);
+
+	dev_info(smu->adev->dev, "AcDcGpio = 0x%x\n", pptable->AcDcGpio);
+	dev_info(smu->adev->dev, "AcDcPolarity = 0x%x\n", pptable->AcDcPolarity);
+	dev_info(smu->adev->dev, "VR0HotGpio = 0x%x\n", pptable->VR0HotGpio);
+	dev_info(smu->adev->dev, "VR0HotPolarity = 0x%x\n", pptable->VR0HotPolarity);
+	dev_info(smu->adev->dev, "VR1HotGpio = 0x%x\n", pptable->VR1HotGpio);
+	dev_info(smu->adev->dev, "VR1HotPolarity = 0x%x\n", pptable->VR1HotPolarity);
+	dev_info(smu->adev->dev, "GthrGpio = 0x%x\n", pptable->GthrGpio);
+	dev_info(smu->adev->dev, "GthrPolarity = 0x%x\n", pptable->GthrPolarity);
+	dev_info(smu->adev->dev, "LedPin0 = 0x%x\n", pptable->LedPin0);
+	dev_info(smu->adev->dev, "LedPin1 = 0x%x\n", pptable->LedPin1);
+	dev_info(smu->adev->dev, "LedPin2 = 0x%x\n", pptable->LedPin2);
+	dev_info(smu->adev->dev, "LedEnableMask = 0x%x\n", pptable->LedEnableMask);
+	dev_info(smu->adev->dev, "LedPcie = 0x%x\n", pptable->LedPcie);
+	dev_info(smu->adev->dev, "LedError = 0x%x\n", pptable->LedError);
+	dev_info(smu->adev->dev, "LedSpare1[0] = 0x%x\n", pptable->LedSpare1[0]);
+	dev_info(smu->adev->dev, "LedSpare1[1] = 0x%x\n", pptable->LedSpare1[1]);
+
+	dev_info(smu->adev->dev, "PllGfxclkSpreadEnabled = 0x%x\n", pptable->PllGfxclkSpreadEnabled);
+	dev_info(smu->adev->dev, "PllGfxclkSpreadPercent = 0x%x\n", pptable->PllGfxclkSpreadPercent);
+	dev_info(smu->adev->dev, "PllGfxclkSpreadFreq = 0x%x\n",    pptable->PllGfxclkSpreadFreq);
+
+	dev_info(smu->adev->dev, "DfllGfxclkSpreadEnabled = 0x%x\n", pptable->DfllGfxclkSpreadEnabled);
+	dev_info(smu->adev->dev, "DfllGfxclkSpreadPercent = 0x%x\n", pptable->DfllGfxclkSpreadPercent);
+	dev_info(smu->adev->dev, "DfllGfxclkSpreadFreq = 0x%x\n",    pptable->DfllGfxclkSpreadFreq);
+
+	dev_info(smu->adev->dev, "UclkSpreadPadding = 0x%x\n", pptable->UclkSpreadPadding);
+	dev_info(smu->adev->dev, "UclkSpreadFreq = 0x%x\n", pptable->UclkSpreadFreq);
+
+	dev_info(smu->adev->dev, "FclkSpreadEnabled = 0x%x\n", pptable->FclkSpreadEnabled);
+	dev_info(smu->adev->dev, "FclkSpreadPercent = 0x%x\n", pptable->FclkSpreadPercent);
+	dev_info(smu->adev->dev, "FclkSpreadFreq = 0x%x\n", pptable->FclkSpreadFreq);
+
+	dev_info(smu->adev->dev, "MemoryChannelEnabled = 0x%x\n", pptable->MemoryChannelEnabled);
+	dev_info(smu->adev->dev, "DramBitWidth = 0x%x\n", pptable->DramBitWidth);
+	dev_info(smu->adev->dev, "PaddingMem1[0] = 0x%x\n", pptable->PaddingMem1[0]);
+	dev_info(smu->adev->dev, "PaddingMem1[1] = 0x%x\n", pptable->PaddingMem1[1]);
+	dev_info(smu->adev->dev, "PaddingMem1[2] = 0x%x\n", pptable->PaddingMem1[2]);
+
+	dev_info(smu->adev->dev, "TotalBoardPower = 0x%x\n", pptable->TotalBoardPower);
+	dev_info(smu->adev->dev, "BoardPowerPadding = 0x%x\n", pptable->BoardPowerPadding);
+
+	dev_info(smu->adev->dev, "XgmiLinkSpeed\n");
+	for (i = 0; i < NUM_XGMI_PSTATE_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->XgmiLinkSpeed[i]);
+	dev_info(smu->adev->dev, "XgmiLinkWidth\n");
+	for (i = 0; i < NUM_XGMI_PSTATE_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->XgmiLinkWidth[i]);
+	dev_info(smu->adev->dev, "XgmiFclkFreq\n");
+	for (i = 0; i < NUM_XGMI_PSTATE_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->XgmiFclkFreq[i]);
+	dev_info(smu->adev->dev, "XgmiSocVoltage\n");
+	for (i = 0; i < NUM_XGMI_PSTATE_LEVELS; i++)
+		dev_info(smu->adev->dev, "  .[%d] = 0x%x\n", i, pptable->XgmiSocVoltage[i]);
+
+	dev_info(smu->adev->dev, "HsrEnabled = 0x%x\n", pptable->HsrEnabled);
+	dev_info(smu->adev->dev, "VddqOffEnabled = 0x%x\n", pptable->VddqOffEnabled);
+	dev_info(smu->adev->dev, "PaddingUmcFlags[0] = 0x%x\n", pptable->PaddingUmcFlags[0]);
+	dev_info(smu->adev->dev, "PaddingUmcFlags[1] = 0x%x\n", pptable->PaddingUmcFlags[1]);
+
+	dev_info(smu->adev->dev, "BoardReserved[0] = 0x%x\n", pptable->BoardReserved[0]);
+	dev_info(smu->adev->dev, "BoardReserved[1] = 0x%x\n", pptable->BoardReserved[1]);
+	dev_info(smu->adev->dev, "BoardReserved[2] = 0x%x\n", pptable->BoardReserved[2]);
+	dev_info(smu->adev->dev, "BoardReserved[3] = 0x%x\n", pptable->BoardReserved[3]);
+	dev_info(smu->adev->dev, "BoardReserved[4] = 0x%x\n", pptable->BoardReserved[4]);
+	dev_info(smu->adev->dev, "BoardReserved[5] = 0x%x\n", pptable->BoardReserved[5]);
+	dev_info(smu->adev->dev, "BoardReserved[6] = 0x%x\n", pptable->BoardReserved[6]);
+	dev_info(smu->adev->dev, "BoardReserved[7] = 0x%x\n", pptable->BoardReserved[7]);
+	dev_info(smu->adev->dev, "BoardReserved[8] = 0x%x\n", pptable->BoardReserved[8]);
+	dev_info(smu->adev->dev, "BoardReserved[9] = 0x%x\n", pptable->BoardReserved[9]);
+	dev_info(smu->adev->dev, "BoardReserved[10] = 0x%x\n", pptable->BoardReserved[10]);
+
+	dev_info(smu->adev->dev, "MmHubPadding[0] = 0x%x\n", pptable->MmHubPadding[0]);
+	dev_info(smu->adev->dev, "MmHubPadding[1] = 0x%x\n", pptable->MmHubPadding[1]);
+	dev_info(smu->adev->dev, "MmHubPadding[2] = 0x%x\n", pptable->MmHubPadding[2]);
+	dev_info(smu->adev->dev, "MmHubPadding[3] = 0x%x\n", pptable->MmHubPadding[3]);
+	dev_info(smu->adev->dev, "MmHubPadding[4] = 0x%x\n", pptable->MmHubPadding[4]);
+	dev_info(smu->adev->dev, "MmHubPadding[5] = 0x%x\n", pptable->MmHubPadding[5]);
+	dev_info(smu->adev->dev, "MmHubPadding[6] = 0x%x\n", pptable->MmHubPadding[6]);
+	dev_info(smu->adev->dev, "MmHubPadding[7] = 0x%x\n", pptable->MmHubPadding[7]);
+}
+
+static void sienna_cichlid_dump_pptable(struct smu_context *smu)
+{
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	int i;
+
+	if (smu->adev->asic_type == CHIP_BEIGE_GOBY) {
+		beige_goby_dump_pptable(smu);
+		return;
+	}
+
+	dev_info(smu->adev->dev, "Dumped PPTable:\n");
+
+	dev_info(smu->adev->dev, "Version = 0x%08x\n", pptable->Version);
+	dev_info(smu->adev->dev, "FeaturesToRun[0] = 0x%08x\n", pptable->FeaturesToRun[0]);
+	dev_info(smu->adev->dev, "FeaturesToRun[1] = 0x%08x\n", pptable->FeaturesToRun[1]);
+
+	for (i = 0; i < PPT_THROTTLER_COUNT; i++) {
+		dev_info(smu->adev->dev, "SocketPowerLimitAc[%d] = 0x%x\n", i, pptable->SocketPowerLimitAc[i]);
+		dev_info(smu->adev->dev, "SocketPowerLimitAcTau[%d] = 0x%x\n", i, pptable->SocketPowerLimitAcTau[i]);
+		dev_info(smu->adev->dev, "SocketPowerLimitDc[%d] = 0x%x\n", i, pptable->SocketPowerLimitDc[i]);
+		dev_info(smu->adev->dev, "SocketPowerLimitDcTau[%d] = 0x%x\n", i, pptable->SocketPowerLimitDcTau[i]);
+	}
+
+	for (i = 0; i < TDC_THROTTLER_COUNT; i++) {
+		dev_info(smu->adev->dev, "TdcLimit[%d] = 0x%x\n", i, pptable->TdcLimit[i]);
+		dev_info(smu->adev->dev, "TdcLimitTau[%d] = 0x%x\n", i, pptable->TdcLimitTau[i]);
+	}
+
+	for (i = 0; i < TEMP_COUNT; i++) {
+		dev_info(smu->adev->dev, "TemperatureLimit[%d] = 0x%x\n", i, pptable->TemperatureLimit[i]);
+	}
+
+	dev_info(smu->adev->dev, "FitLimit = 0x%x\n", pptable->FitLimit);
+	dev_info(smu->adev->dev, "TotalPowerConfig = 0x%x\n", pptable->TotalPowerConfig);
+	dev_info(smu->adev->dev, "TotalPowerPadding[0] = 0x%x\n", pptable->TotalPowerPadding[0]);
+	dev_info(smu->adev->dev, "TotalPowerPadding[1] = 0x%x\n", pptable->TotalPowerPadding[1]);
+	dev_info(smu->adev->dev, "TotalPowerPadding[2] = 0x%x\n", pptable->TotalPowerPadding[2]);
+
+	dev_info(smu->adev->dev, "ApccPlusResidencyLimit = 0x%x\n", pptable->ApccPlusResidencyLimit);
+	for (i = 0; i < NUM_SMNCLK_DPM_LEVELS; i++) {
+		dev_info(smu->adev->dev, "SmnclkDpmFreq[%d] = 0x%x\n", i, pptable->SmnclkDpmFreq[i]);
+		dev_info(smu->adev->dev, "SmnclkDpmVoltage[%d] = 0x%x\n", i, pptable->SmnclkDpmVoltage[i]);
+	}
+	dev_info(smu->adev->dev, "ThrottlerControlMask = 0x%x\n", pptable->ThrottlerControlMask);
+
+	dev_info(smu->adev->dev, "FwDStateMask = 0x%x\n", pptable->FwDStateMask);
+
+	dev_info(smu->adev->dev, "UlvVoltageOffsetSoc = 0x%x\n", pptable->UlvVoltageOffsetSoc);
+	dev_info(smu->adev->dev, "UlvVoltageOffsetGfx = 0x%x\n", pptable->UlvVoltageOffsetGfx);
+	dev_info(smu->adev->dev, "MinVoltageUlvGfx = 0x%x\n", pptable->MinVoltageUlvGfx);
+	dev_info(smu->adev->dev, "MinVoltageUlvSoc = 0x%x\n", pptable->MinVoltageUlvSoc);
+
 	dev_info(smu->adev->dev, "SocLIVmin = 0x%x\n", pptable->SocLIVmin);
 	dev_info(smu->adev->dev, "PaddingLIVmin = 0x%x\n", pptable->PaddingLIVmin);
 
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
