Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F8EC4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5567261375
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 21:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5567261375
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E81146EC56;
	Tue,  8 Jun 2021 21:41:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC7016EC57
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jun 2021 21:41:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNgOBHgjkPs99x+vpjx3DJPR+lXgLpqzpFe8LnCpmJVFi6X2iF1gtL5/SBeC6CW9rrSyoukVMvn1Lx1BAb3++DwiDYkzGYzhWi6wrPqw0NeR4EM7JqrDg5iB7mY0m6fPWzFVaoqID6j3WGdGcbdAH6cuk888WHTZ961PX1rEWyjTLWVoohe2nGgpJv2QeTdDhNdu/St70PoFl17RKfvAS1dcvr1pQokGYXH2cS98gK/mmFn7vq7zOIwc1rhzLtPA5Mtmxmd3ndfEkVcRH9vL1PKXto5khoH+0QGERLD5DT1W/iC0ir607PIJ5/dVAtKyrnApApwQQZjQjNlFotcaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0iKPM9AuoGhkUrnOd/0KVKl/P9Jw1hxsEtoo5j+H9Y=;
 b=HfUM3WaD9ImQS2bjFsOyBRCldfUhm5+7xo3pP5RLrqRM0tygIG+sUa5nyqmfizW1NV/qdMZjglORxoQeoAGL1bRP08EvbxRGfa71u5PaHuBJjw6XgmW8wom6cPqnKu658bfBiTk2ij/xMdaQHz+dlLovLgYJIswqU6QFtWWux9m1e+hruJH/TYoPV3M9C0vN51ohHcHuLhc+ERaa6zbpq/YCJJT2y9D8Eni8TvClFJiIMidbv2KV9AyZCshHjhSBC/jlTMrh9Pd47iGgUP+LRmnrgzLFYw7NyqdUs4C+7bmnRz2az0GIqh7qm+WacQi5wnG+cvCJUNkfG44ScXlaoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K0iKPM9AuoGhkUrnOd/0KVKl/P9Jw1hxsEtoo5j+H9Y=;
 b=m3uW46lueCRFEWq9EWYb/m8UfSfXWPRa49Y/nbYn6z11vl/QRNn4MHfYrq6S/CU1GYse2aKZ3aRH8rNBg07mMP1gR2a2KrjbgAX70VBXYzi/3N69ee5qMi7jhLT386EVoD+MvHvzev+1DtC+SXM/tC3vg6sYOIT4e9qOPa9TnVQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM5PR12MB4678.namprd12.prod.outlook.com (2603:10b6:4:a9::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.26; Tue, 8 Jun
 2021 21:41:10 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:41:10 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 33/40] drm/amd/pm: Fix a bug in i2c_xfer
Date: Tue,  8 Jun 2021 17:39:47 -0400
Message-Id: <20210608213954.5517-34-luben.tuikov@amd.com>
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
 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:40:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a9fd27d-43ab-4fef-abb8-08d92ac6104f
X-MS-TrafficTypeDiagnostic: DM5PR12MB4678:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB4678F23A3563B36C3D70DABC99379@DM5PR12MB4678.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1XjBLy/lKjk49SY5EzffPIB3GFbI6h9A27Gao7wHcUK4k7cVp/582v59t+oz/jAkIppsm0CQRjGr1IVDMV0D2rBBdg+eNp/bVHHmYY7WBiupnM0sNY6zK5kcuD0XelzgSRwindmMfsS+2hF1Wq2z5ik0iKfB4tVb1dHpkggCGe5HBCB8ueRN2xQjsVzJ04O41CLVhFcr4LnhJ3XSfq5rv+HIuZCqs4llnIZh7pLg5oaL06P8RsJ/PMAPXaX3UZWHXP+dPx/6j4etlW1zZnvauhuHzMt/omi36gHgZv6tiou1Bw8fVd4YjCIa8rH1NdX3JTZGIY2vTihbdesIwWRtGfwgltcVxyauhuex3jYYmTywMjVKMDQiYdjHcHQQDfID1s5+NDGmFbUmLuVCqwIqbYbC1FlxBOcX+3JRtPOxO4o3F4H9cOfPpmBaWRozYuRYyem9ZkoHntL+wpTJBqyQ6OnS2OJAji7Q9+hf6bIZHM9Vb5Zk/uqaXCtIkZmbEA9xwBuo2BVimtAPyDhzqq1gtLAk/+aMw/vGAhlsGS7LddmTxMTlXPC1gaBH0mwTAy95nomdfVzV8FJliLJPMRDU4RhjKzaDjNo2eBec5Fp6w/vd8AVWr3utozAfQnEgvccrofW9jDPkCvXWVh9fOze8tdxvXBK+6RIqBt6TLzY6BN6enB4bkmqq9wLeYhi6kRVY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(39860400002)(366004)(376002)(346002)(2906002)(26005)(6916009)(55236004)(16526019)(8676002)(316002)(66556008)(6486002)(52116002)(66946007)(66476007)(86362001)(83380400001)(1076003)(38100700002)(8936002)(2616005)(478600001)(956004)(36756003)(54906003)(4326008)(186003)(5660300002)(44832011)(6506007)(6512007)(38350700002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vjfi376OH5Ej1cmPUBB+ec2UcjEtg7F8HpBdzrtfoHF6gBNohL7C6SWMvx10?=
 =?us-ascii?Q?uwDaysxagFDs8582hLFHf5EIrINeH1BVKYiTsx5cBe5mGMXP2LP7gRMy4Y06?=
 =?us-ascii?Q?pxtzmnbaKIejVvYCX5wSoxITakXQkV69pH8wksZQU7pC0luqIKjRqsb1F+oT?=
 =?us-ascii?Q?UxfpP2HiQ6ufdl3GWp7IDBKzIAk9ghpfS/xvMTMVTcBbrU+xe/QWnC2RcFAV?=
 =?us-ascii?Q?4CzVJY6QBZK4jYsSWJJX6TfS3mku9Y1GSb4CdR426/eilU0hkyc+TlZKbbBE?=
 =?us-ascii?Q?a6EqyrRMEv3uPcdh68VdqbjF2otJ09XAntnuUFFhXPbQRsaagwMecWQdhmt5?=
 =?us-ascii?Q?12Dx5Baa+BILw5TtCPRw827ydTiI+Z5Di71kxHbEz3TtNGZdp56GhFSrW+pr?=
 =?us-ascii?Q?678yNbgIrbAu97VMjv79b+RXLg6dYH84MIi3LPq6Jy8q+ovJN4aEuHnL/E++?=
 =?us-ascii?Q?D7w/tSyPKbBjnGzQc4ow6mCDpk7G5m2fdobfT5+bTOloxca0CXtLt60VKtX1?=
 =?us-ascii?Q?pIHKTfj1lZSAYbtx8fsybygXw4O4z31U7BtKMtuTcMjVKmRG/pBmJe9+OGJ6?=
 =?us-ascii?Q?Mz0D0/lOeAjYn68F636iHn00qacsAk8Wq+kO1OOg0VD1ngmPzr/q7Ewxi5xV?=
 =?us-ascii?Q?eOmnb+wzfWx1pN76PjRfeW91LlwQbrnLPY3toOfrnJ1KF4gHXZ06zATYlLHv?=
 =?us-ascii?Q?3GJVBaTUIEpwD+ce3vpSVb7nekuStNvPuHOMSUhk2LU4OcxJP7VkL4P7xZqB?=
 =?us-ascii?Q?bzsRNuzZZe7u9kFUTeZbI2axOB49KZ6twEYkCy/yCxbqTcp94N/9knyuSFm5?=
 =?us-ascii?Q?lBEYZMzBvAmSJXToXzqGETP0CmbezhEg5Y1jqb2zMJChsE95ChrJKXo08dNu?=
 =?us-ascii?Q?0O/k0Pmsz3IdOsiqZO75R2FrsvOZiUZN8TgrRry/k0SmMpmH9H9jH7REGK7T?=
 =?us-ascii?Q?WknAoUWlwE+EBuPE5v3gX3f7bEZqULCWpYgeKdtEj1WFD8k6o6ehY2saq9iC?=
 =?us-ascii?Q?a7ZTafekL+092KnXg4dDwYxpb6XTGix5LsZBYRncKho+D1VpOKLPfLnTOf9c?=
 =?us-ascii?Q?KSj6cYXF6QvTURAQx3hW3mVw8LzGk764Nr1avPClvtPvq7U5VurWBiGwgitq?=
 =?us-ascii?Q?NHQ09VUrbiXLoFbh+yuGMpXCAJDOQS4Ufjbt2K55KBcEx4KQ+qwVhPX2x8+B?=
 =?us-ascii?Q?PxvilFMMm99hWDIrPnLUm9ONxPQo+rfhy1lQLqctJ87873sa+eI062MytGFy?=
 =?us-ascii?Q?/Fv533HD/Tl7iwwwSlix9N58RZ341HKXYhqsoXJgjwz+6ZR7CIJNEpbVXr1+?=
 =?us-ascii?Q?D28TOn1SQRQYrh6iYBLIi4QM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9fd27d-43ab-4fef-abb8-08d92ac6104f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:40:41.6323 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHdGlmBW0CXPwgXfgoUz+Ic0eBL0Z7hcGAnzjJySzJ2bRGYeyp/n7emfyG+7giMA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB4678
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

"req" is now a pointer , i.e. it is no longer
allocated on the stack, thus taking its reference
and passing that is a bug.

This commit fixes this bug.

Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 0db79a5236e1f1..7d9a2946806f58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1957,7 +1957,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
 		}
 	}
 	mutex_lock(&adev->smu.mutex);
-	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
 	mutex_unlock(&adev->smu.mutex);
 	if (r)
 		goto fail;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 2acf54967c6ab1..0568cbfb023459 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2752,7 +2752,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
 		}
 	}
 	mutex_lock(&adev->smu.mutex);
-	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
 	mutex_unlock(&adev->smu.mutex);
 	if (r)
 		goto fail;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 44ca3b3f83f4d9..091b3339faadb9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3440,7 +3440,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
 		}
 	}
 	mutex_lock(&adev->smu.mutex);
-	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
+	r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
 	mutex_unlock(&adev->smu.mutex);
 	if (r)
 		goto fail;
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
