Return-Path: <SRS0=/TO6=LI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33271C49361
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0460B61002
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0460B61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A756E108;
	Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115866E0F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jun 2021 17:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4ge9fremeK+A/4pl3OfS0lEzNWXf9hhSnwXfQHooIgVzKsDHtzL938X396CNwGL3dXSXIn0pdVKLq5sGLtEghfqRWHNeYw2m6PEZZvnQi6P99jzSB06uG7SkLNVNQsRCnemVV9a3J7InKOZ/Oak0seVmFJ0/ZRf47VzJbSQj6QM8ew2cEbYaKR/sZAx4idBik0v0ZHqPg760H21lptY4f+DKAfcPDLWqUS9n0yy3iyFReruTKBs+Ijd59t8/g5/6IW2dSY/qdhI57kHBSZfz53LGQbyU/j0yjcDGcIf1Mmz0uZa4KMtg3jZ6Znc9EUomCM+mZwY26ttWBUmO/UkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfkN7x5lfxxK5HcugFzh634f8/G4kuRivJ0TRqFZOJA=;
 b=cmizieIImjzYNyImE6Ss1gkFy/TXaQoSAOBF6IHk6RKV2McmbX2EwDSh/Wi+qDvP9UmaQPK8b6MYZTNppx3poCHNpXxjsfLRuJUPl/kdYO7DjTs3NmkViXsrL3s09e7Ice7PbjgOsTzc6CtvhAK3pfEHzeq6ojrzmwdLVTWvJMUJSj3gKQKpdKp9maCfG8yMGC9FCeekE2wASVRPQkMXMLkRGIFY14n/v1+oIQl5q6xW+drP1rKY+0Q6OLRUmnJsndSde9HHYewGxhUdvmCf95kkm9wzgaTxNtzjnoUejhn5z8ZW/hOc1xQvxZEVkMcQ7omXOZQ7Ao1pHeygKoaeZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfkN7x5lfxxK5HcugFzh634f8/G4kuRivJ0TRqFZOJA=;
 b=urFxqn5JSO/Mzal/ftRndPMrv36uYhm5yFE0VQ3pNTXDY7vSNYTlEXrc4OnJLs6A9UAE7nKF2fxlxvjvKaSrhxwd6kxv8Pnu3FfkjGX03r3IScyeRXu3X9vkGK5QN4nyRFDfSKGWhZxLQ9fTKtGt5An7DMKFJZKnVkMI6+a+kqA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4748.namprd12.prod.outlook.com (2603:10b6:5:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Mon, 14 Jun
 2021 17:46:53 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.025; Mon, 14 Jun 2021
 17:46:53 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/40] drm/amdgpu: add I2C_CLASS_HWMON to SMU i2c buses
Date: Mon, 14 Jun 2021 13:46:01 -0400
Message-Id: <20210614174632.20818-10-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210614174632.20818-1-luben.tuikov@amd.com>
References: <20210614174632.20818-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::32) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Mon, 14 Jun 2021 17:46:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 478f057a-3832-4ab7-e471-08d92f5c6584
X-MS-TrafficTypeDiagnostic: DM6PR12MB4748:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB47483791125658E18380F70599319@DM6PR12MB4748.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uzcEvZVhTK54c4BGG1Hn1OBK6cJ6GiIuGCn86A8rg9uiVgX58AA6loN+IuJb8iX+MJJXE3vs7+8ym0ecZ9r7/XSvLtGpYtroDD35m6NWvx/hCJhfEB18M2teIX85xe42XLDDOCOi4TySiF1vy2g+fadO+Qn+S6m+FFApTOg9uJjJYQUUOw74tZqX3mNJa2xj7Kowf1ZL6Jzc3Fy908LTvauCK05gdv5cuh65BLnvZHvAZfe5xgbljG78mWfTpaf79Dvq9bqYhoZxdExi0u5pPpRoI0itchFM38HwMw9DFP6oGh79jWoIxrEqfT8YYaGGU3HaiKxLOU/rP1c04R5qvTW9OCchk7y27wRWb95AKMOFhWbiyvyf7Iq2Jz8k79DDiv+8HqkLRGwsGppcgFSjZiZSXOJL/9iKO/g3IdRdWNvoLSoGPtstNp0U0pkzfzlCOA2vLVybmFX202mh0zHHvFVplzJP7E8osKuR/OJ9P2H7d3MiqssATTp3e26S/MUFgIlGfQGvWweQecHO9/RbDFRe4mO3n4CgujWyKN3cNiLauEO9eFJOB6WNpigQ4e0jjzvseLKIJF9HeKsUc9MTfPN5viHBq5HvmcXHHjUeB07h5iOaS+RdzhlWdYFLd9b0gdt0W3dR/xCMX1qebO1Iru5h6jPZqRiFTq1xMhUrzeXs/HwZmyz3bkqtHjee5/r+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(1076003)(26005)(6512007)(16526019)(186003)(4326008)(6666004)(38100700002)(8676002)(54906003)(2616005)(956004)(2906002)(8936002)(66946007)(6916009)(38350700002)(478600001)(83380400001)(6506007)(5660300002)(52116002)(44832011)(86362001)(55236004)(6486002)(66476007)(66556008)(36756003)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CXaD9OnjEVMySsVT8BufBI8E3r0k5t6G/yDFxk5SHzlHGQYKHJ/84p2vB0o3?=
 =?us-ascii?Q?zgoZi3WaTrxL/HmyEGNaOcz931S5U4hJq1vCKpI1Qcesb5dMlV3y/xtTb+bF?=
 =?us-ascii?Q?c08PTpTBbHK/h7evmKQ73pXeM7zpLS+Ws4PnOcXX+E0kQcXBhf3eoB/zOYLg?=
 =?us-ascii?Q?uZTmrfLsMhcTIsQMHBFKdJEVMaNWIP40c4qpelIh5I9h0JaTYVDgpXw177II?=
 =?us-ascii?Q?3XWz2pHQ+V9/6RobGPAZr+uGbJ6AsdWOaefJtw+7DreS25/Pxw/CUK9oyMXj?=
 =?us-ascii?Q?ZVEgKvzAVDKERm5MI5AOO+1e2og+6QIPWyJoYM5VKSFlZhBWltaUe6YTGhxG?=
 =?us-ascii?Q?5ywpQP5IQ4YZa8zv+U7H1Oji2f/a4UL0QVKMM5RcpuhTDuqXzOg/+kZ9FsrR?=
 =?us-ascii?Q?Yw54yEUtbnkxt73umo8YbdERqMACbNhsACCwpbpiFApMHpUdJTNihdaLAZAR?=
 =?us-ascii?Q?wCotrxHAhpghRSXIVo82Nfst6vRlTTf88wX7z2YGYSd/LZBjNUzWv/K1Ks9O?=
 =?us-ascii?Q?6L/tv0+/V0uft9y28XvG0GgccxJ5oS4zo6xhTjADPI3C3S8KH3f3lUtbxZmZ?=
 =?us-ascii?Q?APzxmUTkXiynwbRiUyFGiM+F+NTz+uktdfO3B1VNIP8hQAKOK8mcy6ZxRZgo?=
 =?us-ascii?Q?hsFltjUQQi9COGcJZ6Y1GawPtRZvqRx8dHG52wjvHdWq190s9BhEnm55pBNI?=
 =?us-ascii?Q?2+jWhRVjpIkZI1uGFWAKxJqEPOTDMWfQ2stPuK9SI18J0HC5T3kIbQA0xtAm?=
 =?us-ascii?Q?X/AxuC4QOd0/uZLxRabMwXM9G1HgA5VnH11n303yAeH3hQL3oK+cZzh6XV0v?=
 =?us-ascii?Q?w6IEGO4te0MAhKJeDTiEOehwME5b1OZsgyMwFBNlgvbsdCYm2toG8N2qM7vp?=
 =?us-ascii?Q?49htxnJygHXMlwp4Gg1arYi1Huo4ECq55bzWnjkMmvk+3vb8ExamfNPBtOLr?=
 =?us-ascii?Q?A/m+1dD2/EY4X5VE+yBWexkJSWjQWQk3db5sLhVAFiEikCWWnRc14Jyp7c4m?=
 =?us-ascii?Q?f6RUpsPmwTvTpVoxTEZedK6/sBiYaoW/tk2N2Etbgseh00F2YzWnL7DKur/9?=
 =?us-ascii?Q?zsbFVLb3Aj+3ev44+XZdxqAWTHIeQIqbW15vstcGWjlrlunWza/7fpIvDX/c?=
 =?us-ascii?Q?c1QdRha6yvurjiBCi617cF71XP6VEROs3Lh2qLejPQMc8Eob0/wYa8WFPR3z?=
 =?us-ascii?Q?9XA2BdYlmpUf81JC7Vqq4FV8nLYojOQJTfd7MujDA1i9T29AMP6UjSYNp5z5?=
 =?us-ascii?Q?C1XVGCAPbzbjbTTW83NZ+tMhLLuzWyIvAazbBCKpOGdOlD5gnN/uQDfB06Sv?=
 =?us-ascii?Q?XndU1Pg49s0JbnjVumyC8HOO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478f057a-3832-4ab7-e471-08d92f5c6584
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2021 17:46:53.7759 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2/kPViGmR3nU6XbooXASKWzPBpWQnKOI+acpURaRTqiTTnzU1lWxAmE72uv1Myf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4748
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
index f426f488c02561..d3efe897ebbb2f 100644
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
