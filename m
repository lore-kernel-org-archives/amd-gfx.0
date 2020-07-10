Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FDBC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAE1A20720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XmZE1Qn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE1A20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67CAE6EB63;
	Fri, 10 Jul 2020 04:48:14 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C31ED6EB61
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4bCLd7nfCVEsLmaCcouo50BMm9zHZgTx++YHgjF6Q7gUKML3JEtkU5HXKPa4ZeYHEQF57gSnwsE4dwqhQOuhAJF8aIWmceOj3gvqDXaZlVY1fuOqQBqnaYfGQ8TpIIdgqBR9jN5kIT0Uljech+ashr04WqXGsoc0jo+nr1Fo4zVDqb44a91crsJ+6YhEY3b6OHB5qug6gdCt+xC2tuIiC0l1xJTV/RN4HF0KEsD97SiC7FGpqX/OJ1uMw2s2DjZeAOBQzHM5HkUnYAbXViNrSfLGTE9H5eDzA1Q6RI6a9fBuN2mvmku83QO2eQfqEbHxY9IzWSxuRPEW9x73O9Zqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze0DwdKH51IOslExT48KO83mIDJCW9MM+TqGGFhtd2s=;
 b=Ce5ZURcWaWUZ0TBDIy+fIa1WbWXglBKMZZfyf/ip2veooLP6Lc82tg+t6LcumJmE8Qe+D+nReJpUAmt5DDiQCaodSz4IttMlouFabk1mvrtpuGs/bqbnzzAJvsvy7KrWmSiWCOGJCaHVq3PfLYgEVIcAP1H0xrY8sas/AEmCNsxyKSQkNNpZ0folt5xOqoesLHozy2B6YUMVaKmnKgn40G+DQziVCUKz7g8O4FtVakJcun8mimyl202+mulKbs/NgSxuRmOUH4XYbBRpSe8+iak8WhSe/K98FheanWb8WTAWhW/eLppDTaIiT8v6ACkdLEyhRZavVksSsNv2WCgOCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze0DwdKH51IOslExT48KO83mIDJCW9MM+TqGGFhtd2s=;
 b=XmZE1Qn3VhYsemVd2gT8NWMg5l3SrTVfb3CAr+e2tZEyyGr5GtFZM1Eo4wTWaMtrF9YVkwYZgzlz9M4kr1BpJzsVZn2FPB1lNcMJukamijrvEz8TvxZp6Z9F8xN/OGkTF129z3O2BVgZR/7drBV3P3YlDTEEfk+I68Oa/AAzfY4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:11 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:11 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/16] drm/amd/powerplay: implement a common set dpm table API
 for smu V11
Date: Fri, 10 Jul 2020 12:47:32 +0800
Message-Id: <20200710044746.23538-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:10 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 43ed4532-286b-44c9-d003-08d8248c72da
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360013204C53945DD2AB23CE4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kV9HJBJMcftS5tJNuH02BU6o8zjPbu00bL6qsh4x+aMnMUmLo60/hlqy7pOBCnl9OTle/BnFqAvH5kRju3Nhh61hSDC0Yqp4GTpr0/+izG2i345Vx3tLQKG6hVKl12De/ZJW6NbnyQYFaTUbPfcnK4nXIPDi1h063mcW2JbZbQj85VHtS1KYeXe158paI2DIGjo638hzKHy3GA6+vnb0hjCr4OMBLHREDiJQvhxVyyA/WEBbFpAr3fkjLzJdisIp/6lE/lULvDVUm21br0/vjjAft3SUCdAYglB36wYdxYcEVfP6ebzP899fKKfmSZqwC87EdpqF8AuekoSQ6kcYYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NHO6rOdl0XReqPz9yQcDicn4Uw6a4KBEu8YTk0I8Ot6vcilkEmcuuR6O6bWCwHrlizEeSriKYdtAGeuBR/tBqw1lJFtJcXqCow7iUilNGyTKGHU5/H2X7n/6/YcVZQdAr7PLrGZHBHRTug8RJGQziy29t/aA2+sJmsgslOMRX9YHWm3c/sChM/yaTI8Mz0BExbr/vRnTxI7JPC0spFr/FF1dmqZpD94BTnODPzWyArXRqFajrXQLkYNnYmJYrWFtuNQV6XWd6qLDY2wvdJUBHTLAnwOM1+kJyaOJq5FQR3V46a4AQkFt5XM/IUxugiDMSUjQ7ttTjiUWwzGyOp6geLg9jHFNuWawqHw/sWggOgwNApEE5dAFuT3NUf4EpBTthxCcyIb4Li/lXGutsgKSnWFJzL5hNR3OYc1mDXAcfWxlgqLIFlkLTS9x1CBQBdwy9PMnVI7evyqbwxNk9Vqj8Zbi7/FsX8nKUPHM3ysXqJy/NvvWJ0qqsouPhHuaTb/2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ed4532-286b-44c9-d003-08d8248c72da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:11.6237 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RKzVgJ3y8Xn6bu3EeZ9TLGqRol110amlQ9nwxE65wfKK1ASx72imn0wCHcqLg/Ru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

Maximum the code sharing around smu V11.

Change-Id: Ice0a874f3f70457f1012ca566f9f784ff3e9cd94
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  4 ++
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 38 +++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 289c571d6e4e..14d6eef8cf17 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -285,6 +285,10 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
 				  enum smu_clk_type clk_type,
 				  uint32_t *value);
 
+int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
+				   enum smu_clk_type clk_type,
+				   struct smu_11_0_dpm_table *single_dpm_table);
+
 int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 				  enum smu_clk_type clk_type,
 				  uint32_t *min_value,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 03be59492af1..7206b9f76042 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1951,6 +1951,44 @@ int smu_v11_0_get_dpm_level_count(struct smu_context *smu,
 					       value);
 }
 
+int smu_v11_0_set_single_dpm_table(struct smu_context *smu,
+				   enum smu_clk_type clk_type,
+				   struct smu_11_0_dpm_table *single_dpm_table)
+{
+	int ret = 0;
+	uint32_t clk;
+	int i;
+
+	ret = smu_v11_0_get_dpm_level_count(smu,
+					    clk_type,
+					    &single_dpm_table->count);
+	if (ret) {
+		dev_err(smu->adev->dev, "[%s] failed to get dpm levels!\n", __func__);
+		return ret;
+	}
+
+	for (i = 0; i < single_dpm_table->count; i++) {
+		ret = smu_v11_0_get_dpm_freq_by_index(smu,
+						      clk_type,
+						      i,
+						      &clk);
+		if (ret) {
+			dev_err(smu->adev->dev, "[%s] failed to get dpm freq by index!\n", __func__);
+			return ret;
+		}
+
+		single_dpm_table->dpm_levels[i].value = clk;
+		single_dpm_table->dpm_levels[i].enabled = true;
+
+		if (i == 0)
+			single_dpm_table->min = clk;
+		else if (i == single_dpm_table->count - 1)
+			single_dpm_table->max = clk;
+	}
+
+	return 0;
+}
+
 int smu_v11_0_get_dpm_level_range(struct smu_context *smu,
 				  enum smu_clk_type clk_type,
 				  uint32_t *min_value,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
