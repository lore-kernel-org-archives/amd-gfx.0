Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B25C4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF03361375
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF03361375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D21B6EC50;
	Tue,  8 Jun 2021 21:40:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C8EF6EC50
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6Bhcb1enNRcxQJSlHSGrp1Q5UZJJy2IjsMQdgT9ze8JlgYpwIYymQs31zMQQJ3lixUZFu09lsWmNqZrOzr+NuVwi7U/DXmFEGPISTMZk5bPu4ePGGxLnmyIoEqVPUJJ8hsQOWQoiI9eozNVComQQ8YLJzIUEofRFwC3wyYXt9fQLKp0zQ+qL0nCiEeV8P+5L3zc1rAHqcwHisf7fxQ0MsuTO7LM/zeNo261N7IL60snuRtfgNewlRRM75Ylacid/d1v02M1cepCCVScCow3GcLORtuXmThPGF8kCXrIBRNIWP1iGhO64yDTc4CzMXFJWf8OLc7Cm71zErKvyGAzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fokVM2mjTPfaojFV1OPlYIIBDURR8rYzzmj8imkDzl8=;
 b=hXxE4mkIUrVAFWVDiDZySfKFlW5z1hOweJikw/MrnDI87TXcTQWK3KPjAQUsQBe4xky3G5PNF2XvRwXtqB+ODB3QfWddP1IByoOoFwcZbIzrVcOSwGeTB/1NZL396MJ+dKtHm2TtbP5VKMjnSVGwnRMFykbczfXpuR6xhDkndZ5/70DKXzYtFGHNflOLIJ3206i9cor86e2nqfpqGvVkMSMMbbC42bm0BawOLxd1cvfkE6fgWJoTHbJ8ShnDjIfynxGvEnABbmhi4lefd26+TqiGSih7xee5C5BTwAuu/fsBsQymxyEmRwWXHpZoADq9DEIL2ts/bASudc4/tCtTIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fokVM2mjTPfaojFV1OPlYIIBDURR8rYzzmj8imkDzl8=;
 b=oEtK7zGMrtcjL45plii3UeFKcDJkoe1xEDho+2NG7CtqncLpidzu9i1LoJdhwFvSpsTulhMFhnj+QkmOowdobD0DX0X/5eRkWtYMiQfEMIhxpWvXGqfZ/uI7+k3fs1stBB864z8cmbVvcgCfcmxwdMvvP63GXkVtr4oK+97B+IU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4435.namprd12.prod.outlook.com (2603:10b6:5:2a6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:33 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:33 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/40] drm/amdgpu: I2C class is HWMON
Date: Tue,  8 Jun 2021 17:39:38 -0400
Message-Id: <20210608213954.5517-25-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210608213954.5517-1-luben.tuikov@amd.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::42) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTBPR01CA0029.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb9b2bde-d538-44b4-c0bd-08d92ac60b5d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4435E9C7AFC88A18CA2EE07D99379@DM6PR12MB4435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kAdAXcInBt5LcUv03InhU2kyMwY1tS8+3hSfmo1/xLm+gCTc53Q/UR9IYpq7N829CP2jNknp3Y/mxAa8QSWdOld7EPQ1H6kmy2Wtxq6/BRoB3MLeRNkVviTRyAHcbf5feCs7xuoiIV74PrTHXMsPG4HQGd6GRqEQ/6SRWeyMf7o1HpcOniASDMVLIikD8ZDfjEMDwVfZ+6qXceYfx+6YoIAo9pk/zFbwJJYvjhK2bMdkwxiiqgLP30hpn8N9fUyMYZLSgfEHfJpBQzIeEWyBOWIeAMyd7l4+4YgxCzzDiD7zrGDbns9yMmCuDWa/Zi8IKt+ulVow80JeslWkMECOlOjSsnlFP147zO/VbCwJ2zjcq720/XE1GpYMpNSswrz3WCE9ydiQIQmBc6T1JsU8Jjkfxvh0vFC7N9QF/+pknGm7SA7Yr/ImyMEbajK3fPHlV2MxWMu9jd/SG82+Fsu0FJ82pwGMyxQzavM9w4ds8vSAarK3AX5oUJ3SBjXqDX1J2c5Q+DEGjbeB5+HSDmuz1gcza6b2Sa4kKZUha+kuev7VuAfTajG9/qOgNA9LAF0hVMgGGElQmUnjAbLmI2eise86vYzTJdkRcBXs/SNwf5qbO094QdHQCqqHvBsaRXXYZ9Po1ek8g69BAsoCd56bG1vK+2xBo9CmL66fqSjg8T6uVvIagyTs3SrWb/0z18eM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6916009)(8676002)(6506007)(6512007)(36756003)(6486002)(66476007)(38100700002)(38350700002)(26005)(16526019)(1076003)(8936002)(2906002)(54906003)(316002)(4326008)(66946007)(186003)(5660300002)(66556008)(83380400001)(52116002)(2616005)(956004)(55236004)(44832011)(86362001)(478600001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fXhQ1wzGF1sqiLT4nhjvOYI0T610yTf68UvEzKneSE0RQ1GxcHXEpmesHlGo?=
 =?us-ascii?Q?aEgz+QpV+npP1Gz5mFrYyqMAEXSJXTQYHTBcp69LUEViZIFhl6j5Txb9PIUB?=
 =?us-ascii?Q?qbveCMhKtSrgxWu/KNXzcPK+mcvbwARndcOTLHZtHCqe8SdOM6odFPitekPd?=
 =?us-ascii?Q?DB+61TnEUNohEwMU3HruqRIMkTAGmHDPwTXnJlRuAcNgQh3UmcO+7LvCoh1+?=
 =?us-ascii?Q?YC7uLXfONi8h7SpIGwVN2xHY/UqbZkBxH9hR49TeEyl5rWUP2NBpiQlb4fRS?=
 =?us-ascii?Q?KzbTke6AbOC9FcH2L5LAfrsWs8SCP3pbfC+QFuWW4sZbbg0fnzfGNeTvv92j?=
 =?us-ascii?Q?TGadrhMPkKcCakF7gtMVIp9M12fN50i8tq3F/ZLRx73WkUhQkLkRhFEhAsWQ?=
 =?us-ascii?Q?/ughlrfPkDZl/wAH7eiRhkrjoOCHDMNRM7GIYTgcahviOJ8fReusgvyp9xtB?=
 =?us-ascii?Q?U6Ro1Z9dESBRWunVc5qjcXpGbQ/xFH8QfJpwoEYKo9+03xA1s1EEh5EXgfyq?=
 =?us-ascii?Q?VpcBqOQhx+BhHHL54Z/bcFpxGTrxOH/8hJl7nVmBtBMRCQe6EDk06V5Ns/oL?=
 =?us-ascii?Q?jjNvW2mPfsHRnVFu92NDOePjosWvbTPzCwluio7q0gHNB3zNzQ/PGxzPqRcb?=
 =?us-ascii?Q?iMCgXvXqWcfqiMbTWHMXL109JVOijZxs3MKknL4XMroAw8fThVejDQ6pp4zq?=
 =?us-ascii?Q?Zu5uUkxPTo1XAkW+/3Prmw0lxZ+8UqPpAbb8PUIVUoCTuF+7asIa8uVqSIG5?=
 =?us-ascii?Q?6g/LrTq0t4cgv/omweq8N+vEwI06tUrecMS/KYWMhVBG8SLP/j4KJZ/b7K2X?=
 =?us-ascii?Q?+vmYnXI3Y16It+aD9uiz/1wSXSTK+dzC32BtCoZP6Qgep0vezEFuG8ympssv?=
 =?us-ascii?Q?5tGgbnyUooANSEB7kk37r5hiJOWSG7LhZve1T9nw4+KGFP4AsHnIVAE9/V3v?=
 =?us-ascii?Q?qDuSDuknCIM6TiKL70URVlSxZhU7Dnh0NdwM/LQpLK5r9K95FCk1v+r30EQu?=
 =?us-ascii?Q?Mxu930k+bv2GH+S7YvTJrbx+ONkArd2JVijIEtx/HMHYZwYI+DdYtbpNGPPt?=
 =?us-ascii?Q?+ZeFeCULv5lvOuAVPzpftA6ar3kceK9qp4XwHc9QSMVimm+4HV3GusE7wkmf?=
 =?us-ascii?Q?o8QA9peVivUvxCihgw98694ZMAedcZpeuRC7rRsBJA6DSAQro7WwxmSwnQGH?=
 =?us-ascii?Q?iagliM4OdeKIp7L8xG644yxuPf1UrgsbjhdCpOIm9wHYqUOrd8fkdcCkyEjg?=
 =?us-ascii?Q?FWPQzLUotb7GF2jtBfEZGaJKqlMw4VbNfkA65aDuLw7Gy8VWvsuPc2IGPW4a?=
 =?us-ascii?Q?gKpAgPjVpRdT4H2KzMO9h3sb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9b2bde-d538-44b4-c0bd-08d92ac60b5d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:33.3569 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tfd4dZ7zGeCRt9fAfS9ga9oVxn764Qo6xDMArVuqpHAu3jCrWdaMqC5ABGyaGJJ8
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Set the auto-discoverable class of I2C bus to
HWMON. Remove SPD.

Cc: Jean Delvare <jdelvare@suse.de>
Cc: Alexander Deucher <Alexander.Deucher@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc: Lijo Lazar <Lijo.Lazar@amd.com>
Cc: Stanley Yang <Stanley.Yang@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c              | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index b8d6d308fb06a0..e403ba556e5590 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -667,7 +667,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 
 	mutex_init(&adev->pm.smu_i2c_mutex);
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &smu_v11_0_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index c2d6d7c8129593..974740ac72fded 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2016,7 +2016,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
 	control->quirks = &arcturus_i2c_control_quirks;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 56000463f64e45..8ab06fa87edb04 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2810,7 +2810,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 86804f3b0a951b..91614ae186f7f5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3498,7 +3498,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &sienna_cichlid_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
