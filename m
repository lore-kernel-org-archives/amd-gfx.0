Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF90C48BE5
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E1646054E
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:13:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1646054E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B6F6E245;
	Mon, 21 Jun 2021 17:13:11 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DC66E24D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BF1Xo37uHGq4UkCasquvoeAdrKOBUsMKsT2j2j4pBnAXTmMDYIj0eTp82Nb9cvoTMCzAmMWV6aywDRrDQX0L1I9lqje1z7N+oSRBlB3uotkOuf2CFhF0uMwIHTKVWQJuoGMrc1DXPVq608s44DFvo69CeU3wRot4yGmaESWrrjAZC0nt+zwAkqo9RV00hGLG6S/vOYpCNDenhFs7wo8Nac2CLuGbL/tFcQD5rYWksxFphPqhdx/eqhxlobhTsDsOh9WwxBDZ3WnZstKV3945JoOE/EvZhBMXpAZsldhaRuKT5cmvC9+6PXmNONBenaUBwkuYaAoPJ1aX4ywZh1VBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWpGVOPnv1804t5FOmacVgQlzzJWAXIU0HZIm6mbX0M=;
 b=drKjCDsVceXg80+sj/ldkZb9AI3WmCmkP9gVgfnCOZV/25ZaXdWvtcCaKl3mFzTeeX3ercm0R02m/Czp2Sq5rxNd8II9c88Y0wQyDutvLUmVHHzMptMBbQ6dJWZ88Iq7hakOOUh6QHJ8fVkClS6v7cqbDEWAJMcr9MOBKd7XzNfvy4uCzzH2RCconFBzYsAKp0n+gNMT/0TzYgT6jFEkJ+WCNMrw8/W1euQxQhm4Z7DwOqX9rEU+tq4ajesFj6oC7spOB/cwAC2FxVZ8c3auEn7cd2gpYyRWwP+FWHTc984CFurCqKW0nWNFJM9goOh54ahd3Blv1KVn0BaOQN7ptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWpGVOPnv1804t5FOmacVgQlzzJWAXIU0HZIm6mbX0M=;
 b=GyH7eN4z8CWRKAg0zSgfVwJ7L3O65tOu67PZt060Pzh1vMzw/aSpSyZrkAxNrBKHTvJTJmpNpUoGu1dqen8RdezllYJQynpE4ojapy+q0gsp4OCh0ropkoaqGSc3RfxZQ01gL6SmnvEvEf1hKISSb1lmbpoxfu6XbLT4xTKe5zc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:54 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:54 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 24/43] drm/amdgpu: I2C class is HWMON
Date: Mon, 21 Jun 2021 13:12:02 -0400
Message-Id: <20210621171221.5720-25-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621171221.5720-1-luben.tuikov@amd.com>
References: <20210621171221.5720-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::23) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0054.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d220875d-6a98-4675-e354-08d934d7cec6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38656188CE4792FA6587A31C990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bm3CFcvhUGJ3/Nooiw+ma4MIVMk3kfbgMR627aZshTTqjhbYS9zza+q2cp0PfIpy2C83yy7TlA4GgULR7ILEJcsGRtsLtWBFIvO7dEz/aiop7UIApuyBrGo0iHEjFtbvhRiP1/9btAMg9ZqCiJLBW6kRpcKl9jVH21WDsQ1AG34bwxvcIlotO3Da3glnjp0OVIpD+JwKcMZQf8byuLWMnqTnqwZC6LLqAKVKXUeRNbIfhNkbfGxqsNVCZ9QSK4/97rxsVeMbCCRzgNHpwBC4U+7cLO+NeW4eGloSp2tmk9/DIzM9ptncrRFSLL5Mdeznuvux8O7hBhe+XzZMaHq3mxW2myhaWaVzytwXnL3bWWmTqsw0NritCG18KnMeDz5+zz1MF4pbxDyRnTvMpiniMcRMvuNPYkFFlJOz6+OxmC/vCFVu4s/RehL6BvnFq4EYiO1Jpc89Y3qzAbV9DkWfUX5MKfvBMDVwcJ7XUkYSyPfqoKZ74en3ZPgb1KMSVC+F6X25nnucTdrkD5dbPlB8ZPYK0s6XnFqf5+GYI1RFw8+CuDBsUBn9KC/XF0rDbhfA5sdZXaL3NLczqKJNFpKbDX6UXxfnYS8AUi+04AnOH4CAO68jc0AyzDsjQlj3Go0SxIiP+k76qx4RlUEthFgCbu4MeEuUlSw97Ag3ZcEZXBEa7TMDNJcjZESPCN5y6BJu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(6666004)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W+N+bovVVFRRjgCsVr5e7bdx8dWheJMmk5Tt04qEoghBbzokWrod+mB2xdnO?=
 =?us-ascii?Q?F1MGq25dg4uN5i0rdiGho4vxQAieokfj3+NNScXuCP1I1fFn9T48ZwriOhY3?=
 =?us-ascii?Q?EFk3XkxfX5E2xIRkfNOECG4ADP3dXQdCZEauiq+OR73sthqvjnGvawGjckea?=
 =?us-ascii?Q?CK9T1LJNaH4lYhLddCgSU3HSu30jWmnoLYSXmApMCXBnR+MDoWsKURfQ0D6T?=
 =?us-ascii?Q?vZ53H8CbScKJDw/eRtyOCf//lq8u+I9yknp44MYLRleyO/APeIIZL5adYnhd?=
 =?us-ascii?Q?qNmR/Z580mjDgUDuvGjagUGTzo4hGHAIzPtcNEzXsN39m0Jqw9aIebX+nW7A?=
 =?us-ascii?Q?NumYZPUGbm2ucEWi9ZzZa4p4GCLyLJNK6E5+zH6IuIU7cHnMHuxUTy/cp/09?=
 =?us-ascii?Q?ulrt175NYoeRJ+/sPoS7JnhoblW7Ddc1cdXsrNEpElDf/u0/pK+HeByDHJf8?=
 =?us-ascii?Q?EQFWvEirj7tn5p8T5hC+J0JHDvjoQHoc3VmzMlgaXNsBoambiEgxeFWDPUp5?=
 =?us-ascii?Q?U1Ml3BQxJTBWG6PdDlA6ge/Xe0NXBlSsqgyP6K8LOUkiM4PjqRlL0rJgSdjd?=
 =?us-ascii?Q?+xFqEm3PKFOsV3tThHaNMXjlFjZpPFGkmhUTJKTO0kW7W4s9J0YMxQZyVXEv?=
 =?us-ascii?Q?T/IM08/AnPw3Wt5Bjn6XYKjEnC3xEQftiYFP4i2DjOBB7JYkmq7IDbw6thQ0?=
 =?us-ascii?Q?q+1TV/GLu34PmN/qB/1TKtopnQ600Y+QniLCBnByebpAL2Gm6uqaotCxR6mD?=
 =?us-ascii?Q?4qpfjYL1rW610Sw8satqfqaMTvwZTKE64Y5K+zjYSOZ65nrkbGy/d+ex3M2m?=
 =?us-ascii?Q?Zp13tlzKrihsIJLgCcm4GVzGdT8SaxwHfbYwPEKNXsP8NBFIGiMYrlnbcgeI?=
 =?us-ascii?Q?MSv9CPPUhXidB2eUVcigWHinQEQAPae5Z4zPz808TmnA3vNUMf0gXNQeqodD?=
 =?us-ascii?Q?JpaeeCLqLmkHIOcvF81yFRUUMPQ7ZsDAF9L70MUDgk8tkxPoCM+bb7E+f6xA?=
 =?us-ascii?Q?AOYW0wf5itFfGOpyvNmhpo9dz2upMKdUKLMXFPklujaHnbzm7J7AaH7fRGOt?=
 =?us-ascii?Q?buLSD6eGintT4eUjvtUnwWM8Ni3VjwAlllSvEZp0Rnz/Tm2E34zrFxEwfvgM?=
 =?us-ascii?Q?vSC2a9+3+xqoFl1PO1+0n5gAtPiUuHRwuaqWsVJZDKudxAVaqd3auv5QDfcZ?=
 =?us-ascii?Q?9QDfSGJYg5H8VDHA/iLE0ycnhCwUyMwijf7ZTh278JOW3YLWwOHcSeREaB0l?=
 =?us-ascii?Q?SDoBQJq5cXNRQMYYcs+TQyRwKtDEmMXwF88StR0dwlxACJH/ENfJjx5+j9JN?=
 =?us-ascii?Q?gYyiK5bNanG8tFomg70+7/lG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d220875d-6a98-4675-e354-08d934d7cec6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:54.2399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgY0Op8nhqZMgaScPDrfQ0NrXG+A876cK7g181vyVRFMPebuuO3Vn104IgZ5Xn/A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3865
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
Reviewed-by: Alexander Deucher <Alexander.Deucher@amd.com>
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
index 33210119a28ec1..9fccdd2d3e73ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2046,7 +2046,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
 	control->quirks = &arcturus_i2c_control_quirks;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c9519a1a5ca633..5cecb4be57c554 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2844,7 +2844,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
+	control->class = I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 9a14103cf9729f..2444e13c4901b3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3551,7 +3551,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
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
