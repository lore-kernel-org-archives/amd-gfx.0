Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9BEC4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23B6A610E5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B6A610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B3B6E5B9;
	Tue,  8 Jun 2021 21:40:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB156E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:40:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggEfjWkvcjBRkHcdjtaV8Ths61rjKRjF++XlwdKx6aJIEX/JFGKOUMGtL+qGiwaj29WGMudQodr+e1RZPMI92gH0iF93fdY9I986yAX2CGscma4SOrVysU3R12tYokPEcvZwlKlHCktC6XA+3PyuQMUzGTel7DwtziYRezF6oJ575nHC3JSueac5iwzXGo+TbDL35DKoLwCyAvVQt1NAT24P464yRC1hHBfFk6r1SfOaedJdPIxLcxFKL13EZC+EPoiwOlpZppKjUHUc0Ll6Nq1Be4EXIbbwiN53hOVHnAGsEyW/bO0euyZGU6QAdtYyz0/SXPbkIwBIAvDofH7dRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6TpvlrfiAwYftxl9jKeUafOYusCMLxmMRW29DQeXSc=;
 b=Dx6+BLSuPWESGpY/YHMLMnk9PM5aGKgmF9CIw8TXkD9ymsS1d9JedpC3loO52ffQ1HPjTWBdQHtJPRbXmx4d7CqdYygY1R2+qvQqdhvByILXaKq1hQC5vi57nv524JIk2DTFq916pG2I2Q3GT8Ohbg7ExZ4EGpOEMok22a0nvVeJBpPrylFzATKswJsjXiSzeBv5/VamLd2IsLMdDcjzR98CI5BTmNSQwPmrBqlguE/DpvNCmWZ0en8pualCGfUNRF6lvCQ8+dE30ffQ8ewS2AD0KgXYelKi2IPWwtfj4n7BVZMRNKxjcfKQnBC8Ie2aMC1wxV9xD0r6ERe2DlzkvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6TpvlrfiAwYftxl9jKeUafOYusCMLxmMRW29DQeXSc=;
 b=Bu4it6VgfZKLVw/jFce9qfeogF23AHFaH0zk49mWTpAZakHmQ3y7P/VQI6xPvPBdB9UFUR/uXZh5PKdptDUDCUyJ1LL01P00QIKbqzfZc16ikxncPWhBNRlUF/g0481bCs6Fk8qcNz2J9skhYLgZHldohzKNX42RfU+BwyUG9eA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4355.namprd12.prod.outlook.com (2603:10b6:5:2a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Tue, 8 Jun
 2021 21:40:19 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:40:19 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/40] drm/amdgpu: add I2C_CLASS_HWMON to SMU i2c buses
Date: Tue,  8 Jun 2021 17:39:23 -0400
Message-Id: <20210608213954.5517-10-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30e2ec54-46f2-4f69-aa37-08d92ac6030e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43552F1DB7D2C360953A820199379@DM6PR12MB4355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TRsfxwtw8RGyG0rJKmsGeSRhF9vKd0ZBg8at38mMzrosuf2uvJOtMNW1TspgUW4GbGRnVsFggl99ZJON43WS7qdIEKS9mmB0ruoPD/b1Tj6JDyuFpz62+9sXOZn3TBShe8JoQmw5prxyWPueHdpyepJa1ahn1JozZQiKIkJW4q8za0h/sDTONaxxjctVkCXs6Y8zhydagh5x/FFJuAKIB/jQLNvAa6mehmR0FBOCyLd42T7wZHeZH0Wihtb0uMJODsw/lj56/d7kvX0SxttPl98Rm2Ud52rWsh2+1MBOkk6y2OSTb+NODwoaWy0k3vJtGoLaeNIQrvvZ36gcFRGErG0f1L8OGgcFlyVEFy0mwLA+OXRHriCXcO6TKlBvNtXtLvbROCW5EIMhh6w+TIXNZV54JdRfH5T0egLajk65uutUuDlJl1wrcyIZKFPgQNak1aVvQswzTuRAWiZz6p3XrkgrQl+goJWz4RqkifWK1m2JevZCytdY1DL5/0gPIJwTqXWROcETHwshMDTk0PgpFyQMCg1poWe2uR9LBh15crXPpNnIymXUdyga/q0AS5IO5eT2OsFf0cPW30hxND+uFyjfIEdvZyd+b5lTD+9fg708G85YwTc8MYo1eOlstVvtd1oak5PlHAS5SO9UD8IRf45d+rSa5TbMckgmv2vc44Cj1oM8FfyPl0n0sEXLtQ3H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(376002)(39850400004)(346002)(44832011)(6512007)(66556008)(66476007)(5660300002)(38100700002)(956004)(38350700002)(6506007)(478600001)(66946007)(8936002)(36756003)(55236004)(2906002)(16526019)(6916009)(186003)(54906003)(86362001)(316002)(6666004)(6486002)(83380400001)(4326008)(26005)(8676002)(2616005)(52116002)(1076003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7w+iJR3UblJBxS04WRfU6fOa6n9oMdEEj1uDfceq1v7dc8kjP/Q1LjP6XmSB?=
 =?us-ascii?Q?uI+TclU4lXFJiZU54Kg5BMdX7xePb/xfVk8MNpV3YLs+Yxtd0QkL5RN2JIYK?=
 =?us-ascii?Q?RLXuGZpoZLg1sx/ErTXMU5w13rfu4n8lPE7JINWQDSYzuudoyuTNLcy1+uA4?=
 =?us-ascii?Q?us4wn+QLhQws2zjiPTe5Rd9sgyCw1Se75nCViochOPXaJb4fediBOgGKwcaw?=
 =?us-ascii?Q?0axNk2mVodfi0Qa0XwIYIlrXMM8FVf7F2h422thg9jkV7qf7Z9HAsAx7iDE1?=
 =?us-ascii?Q?g8xTGGZUryBGgpJRMbdddqT5XCbrMSPiYylgmqIEvnjhHUOXAmJWd/laXZkg?=
 =?us-ascii?Q?PRs1AaFpYPw+BBId/dyQ4jJXG3nYbCFvIb1klIMPbPw/dGBvbP0RBe+NNbBl?=
 =?us-ascii?Q?HLGt9xYr1zw2Pr7ABSMRf0gPVdZ3ofBZQFDGCF+ePhSIKQpnAImMS3ybfAw3?=
 =?us-ascii?Q?8qQGTUFfFp1/otF1FDGkPUj+nasdRGJanrmqvDNEexX5YuGRcDtu7MbvSgQf?=
 =?us-ascii?Q?rXMRRinFyySRQwMmhLS1s36UG7/HyQGXshcqak49LeWokYcYx8gQFaL1QSGt?=
 =?us-ascii?Q?2C+JYF+rSsGtBUmiV1Z15WyPb1IMeX1o46KNA0PVL90Evoaj9dugoRJ1KUSf?=
 =?us-ascii?Q?Vp3iOYGd5YbMyx5VKzE2DeMnU7rajFa3WfECtrZV81A6whojeWUw0ldZwcaS?=
 =?us-ascii?Q?S3752hW5QxoFLMkOfT9ntVN8XqMwvpYorbmBXERy2qrFBxfZDb/kyKbZ0YNE?=
 =?us-ascii?Q?AIO8CV983kce0kfVA7hVlTjsq9Ic5Di2hcXFSggYOFTJaA9KCOpJHJbx/knD?=
 =?us-ascii?Q?oT6aLYrhTj+xS2j/IXzwO6gqLypPcplf1gscEBYyo2/CLd3qA7kqMqobjHUF?=
 =?us-ascii?Q?Hy/CDO8hEy9GikgujccbvbcyfeKiLnZbiOEMGEM3V/xFWgMlXO2fZj67sYzT?=
 =?us-ascii?Q?GhzFPAx6uA1iPUigqzQK3vLdfpmW3fYA19lV49urUKWWDBRvUX4psX/Q7/Ru?=
 =?us-ascii?Q?PepzUnOUxG6HxS4PBkexKzvYiZEd7TdtviezgklZGXlDPTx4KZixpEUYWxUO?=
 =?us-ascii?Q?uXa9kSNZD3bJz5cpuS24H7irRTcDzQ7tASMkiMd962xQi9NWNnH7UN/yMrmI?=
 =?us-ascii?Q?QFAtlKWyswImOrrrRYy6cjAWm215L/+IUc/zlY3A6guiXfseZ4+cW8pT8lJd?=
 =?us-ascii?Q?6N23K/B1ysjkF2e6pg3mTNW8y402dfxMArHMBzUAPSNjYHhQx5psfW4Ybqcw?=
 =?us-ascii?Q?afbqBNyMdXlYjR2847t6kGXykwrs21zUFxjoS6R5wwEjhGw52zdobyx8meBH?=
 =?us-ascii?Q?UO5pgh9DxbWfr7uhkyjwGF/z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e2ec54-46f2-4f69-aa37-08d92ac6030e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:19.4328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFhxqj8w1wOq+64CUWrvYqtBQ0Yjd9ucLH4Q42ZxX9EqHGV5s3y+gJqc5i8jxVt+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4355
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
index e1f7607302ba6c..a8249ee354572c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2003,7 +2003,7 @@ static int arcturus_i2c_control_init(struct smu_context *smu, struct i2c_adapter
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD;
+	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &arcturus_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 6bb8b4d631a254..644b4821220ede 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2798,7 +2798,7 @@ static int navi10_i2c_control_init(struct smu_context *smu, struct i2c_adapter *
 	int res;
 
 	control->owner = THIS_MODULE;
-	control->class = I2C_CLASS_SPD;
+	control->class = I2C_CLASS_SPD | I2C_CLASS_HWMON;
 	control->dev.parent = &adev->pdev->dev;
 	control->algo = &navi10_i2c_algo;
 	snprintf(control->name, sizeof(control->name), "AMDGPU SMU");
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 499e1309d0f796..10eb7d6f48fcac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3486,7 +3486,7 @@ static int sienna_cichlid_i2c_control_init(struct smu_context *smu, struct i2c_a
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
