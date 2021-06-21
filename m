Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDD0C49EA4
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17E6A6102A
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 17:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17E6A6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AFE46E226;
	Mon, 21 Jun 2021 17:12:47 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093446E21D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 17:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZi/NYdwYgNLUmcs/3c3H9kVsdY+kxZiYl35EmWZuAMygh8gdcISRISHJUXmicLF6529KWv5SmfcgQjO+7/y17JoxCkay/f+ZpEFd3MjpRZZXXM3oCRVheXn4n7KDyG10ZnbT2FM7B26c0keKCWuyFOHk2SXmAHOPQ3yXpnasZwNsnGp0OQ857OU4ILqAimWC69/kU5/Ct6mR0DDGIaW/Eh16dOKiFcutrnjCP87Fe3bAf4cFS7Vqy+zmqeHO2QD5jNzYS+XA/8a6ejqSoSSzMDbnpRCkfi7KzzSMeGt0kNm41KyqG5ACoji38cxw6xBJWrmY8hGSN43/djjCBWgzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWnKeBMKzOHWjN1J9jBzF7XS8cZOJuh0/eC/fdr+yac=;
 b=NbRwII//VW/NXcZqa/E7TB3fFNsDbFKTDgm0Fdc/ovxBBvj3YuTLockxYRPf61EHQOzZa5OOIJQCVNfVH2pBE5BTKC8Ztqthyf6JlMoQYsWwjt734ibQSTdJYddr4SqmF4Iol98mKVMxzROoigdwG4jK5kL12dev9hfEhDchjFvJd2T2UqUxWqwfo0RCCLOSCsOMZXj+2O0MuxBR5Kf/3e7psJQ6Kxm1h/y5fqRbR+SmIWBb3XzCBSiUWD6RL3FOQ+ydty1JXdSzNrzgPGnr6TKw0oZ7NulL/q8Vx/OfzBV5oJrqikj2l/vLSWbNeGgr1SO3xOIBIDZeNSvKGErjjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWnKeBMKzOHWjN1J9jBzF7XS8cZOJuh0/eC/fdr+yac=;
 b=m4dCTdUKLQ+OQcO0q1K486MAPZ8Gcm7l8FgW7mDXfiMH4c4ZzeN8rB4CphygJ51cjx/Ird+Fi35jvYlicex642ExUXBCX9bgV8ypgZg237OW8dxQZjyC7g3JTpc2/XWRNul/H5XbvFaK/CIECNYCrqKOCIsHu+DwYCVw3pozNkQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3865.namprd12.prod.outlook.com (2603:10b6:5:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 17:12:42 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 17:12:42 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/43] drm/amdgpu: add I2C_CLASS_HWMON to SMU i2c buses
Date: Mon, 21 Jun 2021 13:11:47 -0400
Message-Id: <20210621171221.5720-10-luben.tuikov@amd.com>
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
 15.20.4242.15 via Frontend Transport; Mon, 21 Jun 2021 17:12:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32d00395-dbf3-4b8e-1974-08d934d7c6d0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3865246CA5E93F9524B897E0990A9@DM6PR12MB3865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7eh4fVxuNsMhPUJZ+4HK7FxtsPK2wlBc737IVjUt0/5PIVJhxsPyhPoMmaIYfOtYHo66Bv0WdqmPJ6mdTlRREKVuhsqFshhMkvz+mdbauLVOcKfGbUtQ6pXQCR/vuQ3RgzvtGvcV4J11W/2E13B6TjEVMZwt/i/t+Obpt6m2gacajHMHLFFwXp1AcvHWpuGDyhsJnjECC0IPyc9r90QHOHgBbhQb+tFHugvtuqr1B/b5QhQzemHacNQ2GTw9hgEld9f+SBW/S2QL8uy1z6W7IBLvoN3LARNYxeRuTLNIjSBy56TvOEnB6D+4CC8l8cVP5o+PJE13U4cOmVxiEzK+quhVnB715jh2O02XNx6EBFKyZ6kHTtE0Rd3X3G2dC9wgYYSXaR5446LSTA0+KEf3baKNub9Z5bN+AXGuwhbGjbfYzqF8An7LGIdXiIRVxaUZ1RKjc9yk/3jXwm6JgGq2K54KlH4Of9/MkCR5SX97MoiMbmlL5p1yhylEcU3tLgBRj+KRzWWvt2AE4iLcpKv1J1fYnC4H4mwdknCTb7FklebYDqsbeEWLD9C85TO9J9l4dpA9C3Shk0ZXHlAjpWzOO3RSKPlF5HlZsMw8lxUytzjJ2H5KPcgV0JA+fh3/pREDvr8bFi9aS+i8Mplg7+tXhJzL9OJ5HU3haCYyikk8R81x6wA0sv1keMMT5Z9MDj9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(478600001)(44832011)(54906003)(52116002)(316002)(66556008)(6916009)(66476007)(66946007)(8676002)(2906002)(5660300002)(956004)(26005)(6512007)(83380400001)(1076003)(8936002)(38100700002)(38350700002)(186003)(6486002)(2616005)(16526019)(55236004)(36756003)(86362001)(6506007)(4326008)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hfmf904n0zy4NUqLh8ST1cpAh6EPm0ppz88mdzTGUk0WXxIwR7K1Fh/R3QtZ?=
 =?us-ascii?Q?V5dAW5IO63cIdJLfBDY4bM8xXfTnd8N21Cgf4m6W37K+ZFN3/82nb+zIjtXH?=
 =?us-ascii?Q?fvjGZeURnhH/pD0cNDrf2wfqLMg353ntKg4wfx/W1PUYjGEUGo36ry50lIQy?=
 =?us-ascii?Q?oNuNrNOxWHxodZPcyQFMfXd6Lf6je0KdLR5MeMtSx34ySgDjR9BXHyGXN5ND?=
 =?us-ascii?Q?Dz9dAQ9oZos30i8KMnzDKk19e75qvHBg/CfAg0TWdU6pa1sxsFj5Oum7rH4F?=
 =?us-ascii?Q?8WgH3Lw9vtpyZZJqfe4qqhMXZhwRPqs3tT1ypCBmuV1vldWlXEFBiVW2AyLI?=
 =?us-ascii?Q?0c7iW7roKqD9pnxkCoF2PnlxVQKL4uxoaxEO4arZS26SQvj8im7FQIiJnhoj?=
 =?us-ascii?Q?f5vbjGGy6rf6q5bP1QYgsmVn7IpL3krsvv10f3a2mWRZAntqhcCxAFOU2/lp?=
 =?us-ascii?Q?Bx9edIAkJooX3Xo1lH5ifeGi68kCgdRTmlR88HZIwi918PgbwQm2KT9+y1Q6?=
 =?us-ascii?Q?KAb+2mv4omqyFvKuwDUHfFI3EPPga2AvudshqFqoktq+iyC8v7OGiwz9SpRK?=
 =?us-ascii?Q?Y2oes+lXCTTrf05XsraBCK9ztVJnsl6+wxhnYYkvqjhJqvBpVIfi3lXXPWWt?=
 =?us-ascii?Q?Xb6uQGZpvy9A0u0gFU9C3D8e9CscL0jD4ZojTixCTv/Nfxn0zN4sCQ7GrvCQ?=
 =?us-ascii?Q?IHxRhJy/jdnK3wNui9oBAe5I6NB+ycEX5R0DtUYi1O+9Q8ba0mPu1J3Sf+j7?=
 =?us-ascii?Q?Ag7Pd6WmnL5FukQai7fk3Z5DlmCdXPCImC87kYjND5cGCcsiZ1sjY+6JdDe/?=
 =?us-ascii?Q?3VDtXJH+AMmDtcpCGZ6/osGI10eH9dGSgtJthkaR72SiPe2ajRF2gBgagP6d?=
 =?us-ascii?Q?WoZ4WnAg/3OcDkmasfODlf5BCgLlCpsnNL8ZADdMf+Alxuy30l7V0mZc69mb?=
 =?us-ascii?Q?Y98BKCOhCTd2bPQXHNJcCLFok8ezfLB23OWhGUC6QDe/Cr1hEZYeacgx362z?=
 =?us-ascii?Q?6v3ERfxUBnhu2iLlW7u+DZ/8RkBJfkt3xFSupG+XW1p5asQ8U6noPl8/N5xW?=
 =?us-ascii?Q?WRiM5rZX+ryhbn/HpO14exQcQaFZ/maS04WWkLYYtZnJql+efRkrS220bb5T?=
 =?us-ascii?Q?IsFcxei6S13G9UXXCD8decbt9zXdQe0SDzd4u03IQvRWqNfRWZ0Po/ucrMCr?=
 =?us-ascii?Q?MvJ12+3gj2gOysxX+W9IA3KpQC2GMFNYMDoXwFMBkohnFVYPmP+8639iN6up?=
 =?us-ascii?Q?b2a9V6m1XLBtxlVoApU+As9f7BNyyRP7vMHCBFLQ5sD50n9squl8wcjtOS5B?=
 =?us-ascii?Q?dZJF7SEBzlSmItsTQbY+PxXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d00395-dbf3-4b8e-1974-08d934d7c6d0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 17:12:40.8954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kRM8v4tZB0O2S15XO0GY3Dd+9gVhXaDbextIAS5aBXpdbmzXmmSTeoxN/6/oo95o
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

Not sure that this really matters that much, but these could
have various other hwmon chips on them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c              | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
index 1d8f6d5180e099..3a164d93c90293 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
@@ -665,7 +665,7 @@ int smu_v11_0_i2c_control_init(struct i2c_adapter *control)
 
 	mutex_init(&adev->pm.smu_i2c_mutex);
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD;
+	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &smu_v11_0_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index a6447822deb09f..404afc9979c69b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2033,7 +2033,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD;
+	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index e02db86ced6108..3303830afac7d0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2832,7 +2832,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD;
+	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index b4aa489e4a431a..1d06641ad87890 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3539,7 +3539,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD;
+	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &sienna_cichlid_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
