Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEEEC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 10:42:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3480619B8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 10:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3480619B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C6EA6EB53;
	Thu, 25 Mar 2021 10:42:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 100E06EB53
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 10:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQcguQXEP8JUs08bC8wsxyEPopUGZ2EGf1TBGTtCiQjxtwnuP1KnXiWlK6GPhQe+gFOZxEtPaDXIBDG5trcA9jRD8lx5GdR+Wojuu79JuUGnJWS4taHDRNuc3YPhWwmB5vxh4ZOoIKhEBJZaIXcpErkcsZnQhsnIOYyg4+HdTTEyiukf7a/eZLHYxoggmkKKC9ThgTZdmWIp/3cuf7Je4ZuNr44oWscuqHxVBIvGUpvf68SsMqeUJIe5qAVu4VR2onuq4SVF3MiuqcriKgrGkQFQxZCkwKNBfitb1BUxBaB+25VBnMS4+ZJQGvorv5tHWHf2HJ+8txhSucJ3ptZgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab3QfX4zvie/QgliontuF2P8QBXOJbAGa5rzh6HX2YU=;
 b=kQBxkLzxFezZb+8K+YtIqbi4VRWMP8gUSS/NwCGNoXGMdZZf5LKGql9Zd+xFJDYINJjYuXUyBO6lFBbBcrHVyRsXL/acdrUtGeVSJRytx/DyZ+RQwOl3CZj8qo2fO0MTPYuXjAEf/Rsy47pu1rPLmh47mF6BbpYL9l5fgv0Mr6WyZZY6t6v+bumBQzc9luhVc+euJYIA+hYbWVICNwRQigrb6/4UDZsF/jmJdniXxDuQGTrFoKYr6AKxhYaE2BOvvst3VNyIxiclVlzGCCERFhJL/KrwTr+14tHBvjwOZZ989+8Ww5/gNcfrWIms2qGeEOZz/h+2h+o8f2OAXyil8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ab3QfX4zvie/QgliontuF2P8QBXOJbAGa5rzh6HX2YU=;
 b=fJbEDf8tYyXi4UZe5cnmWXk1XNzyM1f/f8Z6E5TUJdj3+gcwfAeo2LvQxejh8b7dHDBPcY9QFZEBelo4u6REtIxnVTSRX1RMnHD71wqLLtNtHUahB2t6gL+7geZlF5J9u89LvPwy0wZi1eegfGD8sx2G9D/0ireb7jcLoaGi0Q8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25; Thu, 25 Mar 2021 10:42:40 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 10:42:40 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/pm: unify the interface for power gating
Date: Thu, 25 Mar 2021 18:42:19 +0800
Message-Id: <20210325104220.26987-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:202:2e::15) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (180.167.199.189) by
 HK2PR06CA0003.apcprd06.prod.outlook.com (2603:1096:202:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.25 via Frontend Transport; Thu, 25 Mar 2021 10:42:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a95a0179-f8fd-481e-844f-08d8ef7ab672
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435FEBBB3DC438518BCD22BE4629@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KuDbBZkLcqOPc95+OSbN/txHYzK94Q/kbouc2AyHPRFm+hmkkndAD2j8oHtEK1nJBloRG/5+j0pkpX9OqVQN9Na28UrTDfyzKFWXA1WZEVN+g73N1IyUNVTyC9ZQcHMP73hztjIyvjHbzEy+F35Guzr9gEvWX9Q8Zl2+EfBYuJwYc3wt80nsLShiuKY2uCvOIe3M5RD0LLVmDbvT9W2i3u12x3dkFHObD5vYp7Ev49dx7oZ8Qt5x1yA8LIao22hLNB+Lcn7Lwgfqh36QjCKUeYkciyd3JOkfNKcbOyp+JMl2LcOLtd2tohy7VDz/2Lr58V31YSaxqvJHtEYbxYX6M6BmnbHRsRfce+I1opnPls74Eyzo5SZ9hl6uiy8kjX0oaoYB+FxAbr4GpJmuLRJp0z2Q+TtbcMcqWYXm/eFkl8pU37/ACgEWmpHZagvI9M//Cs3D/8O1/G6hWpWnVrPzaIcqGTDC1aWAmfqS66bpPFQYWGzIMT7B4ilLvwNDXSXLBAUNg0LZmUE9HJk+tASHvrhCOjQZmELWozA39dfjJj33GIY+0tJGJW8qYxqs7IzkbFcoU/mLVdYI4hMHz6g83aVzZC2vbYzwmrlkIFR4f6l4XacHtxatgPc6Z033mgamfbh7CHtC3SV0T5wsrg7GyHnxeirNeOI+kNAwUr90Rpg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(7696005)(316002)(44832011)(186003)(16526019)(52116002)(38100700001)(478600001)(83380400001)(26005)(86362001)(36756003)(6916009)(5660300002)(8936002)(6486002)(8676002)(2906002)(66946007)(4326008)(2616005)(956004)(6666004)(1076003)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UZUF9fam8HqTJntM5yfVmRuSqfAO9aVipZ5EffQjh4vQMyN0jgw0Mz8n5bYX?=
 =?us-ascii?Q?TJomn7oOyIg2zYnFq2Z38wyGU/rUFgGlezSBKNaKmG3oUkzM+mLhkLuD3Cp6?=
 =?us-ascii?Q?aipOJ6zSlgTD2GjTMuhHHkWdKj+DrZTSUCxpIiMsTscYUHMI6FhCKqXFnGav?=
 =?us-ascii?Q?R7dnNni6AefPI7mXT+6NIEW8WdMkKRfxF5h0H1asF5n2TAlnxxdS2dmWD/uh?=
 =?us-ascii?Q?Wt9BBceMQL5UAk679QzY5/7aGZz0PZ0NDgX6WHzb4gmz/qkdeGHDl9CqOVWY?=
 =?us-ascii?Q?1UAN8XgquHoG6JvyBliAn/whH7Z8n6ZiCYQW6j3qFXPtmmbS3Cc1iGfyS9Mv?=
 =?us-ascii?Q?M9Rb29/Mr4wEvSqnrqagKShIKH+rrjJlPGbKabJ0bl2rYAOuAaR4uRcPEmyz?=
 =?us-ascii?Q?/7Sukh2njGTFoDpO9a8pXh1XuC8kOeu49HE/Ffova6c/cc69pcNar1MAMSIf?=
 =?us-ascii?Q?UzJnuDdeIYZoI24xJ1gZEZM5MRGyT4wukyQxod402cFGrb9NiS9pUfBz1W2K?=
 =?us-ascii?Q?OmeKxZB4eIizFcOkIi8vl0VSzCHFX+fNes2HsdfMS0XVZVeCKmRi0jQhGUxC?=
 =?us-ascii?Q?1KktNvkhidWRH2zopebGTP5Jq4snfN0JqLIh4+x9dEhl1HZ8XszaJUEKlDmI?=
 =?us-ascii?Q?+ArA41c1XoUqtZKa3oa1or+Q/b68W2agowPrznlhNsMZXyD91UPyBSxBAmzf?=
 =?us-ascii?Q?V0c46LEFR73cZ2rdUweQwMLodEPTMeejXRByXG+YeSnujCUtN/D2ryMrTjm6?=
 =?us-ascii?Q?PyF0SwfAF2A3GeJLaIYzHHz8VCn6ep93CZeMhWgZp5oivQ8XDK1bcpIbyfHt?=
 =?us-ascii?Q?rnqpFbSin/MloWAiRQT2hC1hRXWcPZsf+a2p6ykn+ANm7+o5bC233MdObC7D?=
 =?us-ascii?Q?sJhIid5tzf8d/TsJyKRCGOx53rb4IQuUuiXCombFuCQn6U5LxFGREFS7tj65?=
 =?us-ascii?Q?C8H3SXRUiUPMNV3V7Gc1riBJxH21V/owMo7AjIEygFW/P2Z72+mBQ1/dd2d6?=
 =?us-ascii?Q?x2VyUStia/u1aTGyDFGd+t/15ZR06Q5g5NVkS5LYJet2Chajri7vQjgNXXTk?=
 =?us-ascii?Q?uzooI6QDpg7QpQ+04yYRIzAl6ToBTp4F9UUoDGItVuOzVXyutnaKvKnXQ8S0?=
 =?us-ascii?Q?uVKsPuxBUg9UNAI7NsPkoHEh27d61R4COkI79wVKqfohTzxXMryOz2QIlW15?=
 =?us-ascii?Q?AJ7UChAp5W+WJLdz/MsQG1Uxksw0IUP5XAZVBzmkAOoyfm0GlQCNEpMINjyX?=
 =?us-ascii?Q?9aCu84nZ7uYx2xJYRyR0wuTng7nUEHaxBS7Eyuw0qxYCHJvd5RWpRMKauXxX?=
 =?us-ascii?Q?Go+Pi3WgGjsQ/Q0M0DE0GmVK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95a0179-f8fd-481e-844f-08d8ef7ab672
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 10:42:40.1490 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1VToUPTSSsS7uVN0vLD9Lv/34RXvZAi+yVHJ2GLB47RN4tcNryNS88Yd5y+gq6S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4435
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
Cc: Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need to have special handling for swSMU supported ASICs.

Change-Id: I7292c1064c3a1c75dc9f91d7c5318eab4f407241
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c       | 9 ---------
 drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h   | 3 ---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 6 +++---
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 464fc04fb334..03581d5b1836 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -927,7 +927,6 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 {
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	bool swsmu = is_support_sw_smu(adev);
 
 	switch (block_type) {
 	case AMD_IP_BLOCK_TYPE_UVD:
@@ -968,15 +967,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev, uint32_t block
 	case AMD_IP_BLOCK_TYPE_GFX:
 	case AMD_IP_BLOCK_TYPE_VCN:
 	case AMD_IP_BLOCK_TYPE_SDMA:
-		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
-			ret = (pp_funcs->set_powergating_by_smu(
-				(adev)->powerplay.pp_handle, block_type, gate));
-		}
-		break;
 	case AMD_IP_BLOCK_TYPE_JPEG:
-		if (swsmu)
-			ret = smu_dpm_set_power_gate(&adev->smu, block_type, gate);
-		break;
 	case AMD_IP_BLOCK_TYPE_GMC:
 	case AMD_IP_BLOCK_TYPE_ACP:
 		if (pp_funcs && pp_funcs->set_powergating_by_smu) {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
index 4684eca7b37b..059d2c4e4c7f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_smu.h
@@ -1305,9 +1305,6 @@ bool is_support_sw_smu(struct amdgpu_device *adev);
 bool is_support_cclk_dpm(struct amdgpu_device *adev);
 int smu_write_watermarks_table(struct smu_context *smu);
 
-/* smu to display interface */
-extern int smu_dpm_set_power_gate(void *handle, uint32_t block_type, bool gate);
-
 int smu_get_dpm_freq_range(struct smu_context *smu, enum smu_clk_type clk_type,
 			   uint32_t *min, uint32_t *max);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index e136f071b4f2..0d1372d440ed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -268,9 +268,9 @@ static int smu_dpm_set_jpeg_enable(struct smu_context *smu,
  *    Under this case, the smu->mutex lock protection is already enforced on
  *    the parent API smu_force_performance_level of the call path.
  */
-int smu_dpm_set_power_gate(void *handle,
-			   uint32_t block_type,
-			   bool gate)
+static int smu_dpm_set_power_gate(void *handle,
+				  uint32_t block_type,
+				  bool gate)
 {
 	struct smu_context *smu = handle;
 	int ret = 0;
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
