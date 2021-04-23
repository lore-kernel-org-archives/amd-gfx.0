Return-Path: <SRS0=d4Si=JU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F77C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3797F61175
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Apr 2021 11:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3797F61175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D326EB74;
	Fri, 23 Apr 2021 11:18:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBD46EB74
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Apr 2021 11:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ace5VPwcAHEJdK4AT3pdRIKP/Q8GVJfKoyq3BYbPqQv7wpnoqKA65SkRGMBQyWIWCKz7OP6IKNECId1sFliwmYaOOfMradhkSBltJwVeBQdLlnJE3pOCDhLZXOT9edpHmFDl23WuF/+OSUGfOcKurAd8FJFGhoEePs9O+AgU0Re3rXQmgroxKBJKdiK/1oaqXNR1+zFlN4s1Dzu3jbBtRfaW5AUSs7YWQSJThgMk2UvkslZ+GJoJKYWdMlGdBUEuxP88vIKn/FiBAuM1WsyoEZ1he4RsE6ULpaL3QGvqxWLtkuly9XqQkrvToKJwzHcHWjkNwMTIOWvE3/raMJeqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=hz259TPJf+Qqcg9mXWAtK+1ztR1jLbjPJiEySjSk14LrqKquws5dZKg1fGpP98cil2hi9iG3J7zPVcwhfNW6R076hWEUHNL2caMyj/XmXmd5qmfCzmhAbJx34njhRjCeLuooQHmrhomg/yg34uLPuz4+TUh4aSremXKrf7YqDczBOzFXUpUlz6o+WhjKsfmy8G0aGwpnYRzgDJ7aL5ZwUUIMHfaxDhjBJ2HbzctSL5VQYs0rKGEPOfA9rPeYozUBJhthM6llwRW4j4OJ4xxIgLDLrcxWMYdok6N1MEa1U67CoWDeA1cMA05EAPEALEftZlyQCqPb99REboA2hkr3IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=WYs3Sj5XbFU6DWCFXbCUJdJ0Brz1KZLDHCq57Afiz+pFS9UQPFolfjyr/6IisWJG6RAeMQCunjOw5ygFy6hxAzHcZq/4LqHwNeKdnZgs3bG6YPNyiRhQuq4GXL/6sxbFdbb7jucGhjTxl4LaznHqYd66mEQx4hheBBceIjAiP70=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Fri, 23 Apr
 2021 11:17:59 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Fri, 23 Apr 2021
 11:17:59 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/6] drm/amdgpu: expose amdgpu_bo_create_shadow()
Date: Fri, 23 Apr 2021 13:17:25 +0200
Message-Id: <20210423111730.2345-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [93.229.34.71]
X-ClientProxiedBy: PR3P189CA0049.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (93.229.34.71) by
 PR3P189CA0049.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22 via Frontend Transport; Fri, 23 Apr 2021 11:17:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01a6af92-620d-4d70-fca2-08d9064973ae
X-MS-TrafficTypeDiagnostic: CY4PR12MB1462:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1462780380F95247BE92C5D88B459@CY4PR12MB1462.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: werVf8EwFx7BZCMnXQ5fFrEeodUiIvDqHMihsdaXMZqto6cX4Xo0wuP7ivfo8IOVQcQwp5gsV/qF7esToiUS9EqRFeeqWTwXmzj1pCpHcXYgUxxsBuFZ6I3KfBd/v+v9yHpEsn8S4WIdARf6yN5xUNV/DW3lqpwy1zyGcVXT23WtDHTzm9glLodQjCr5sC2Cs9t5sV5bwR7r9TqfDIgwhsZZ0z0IL7eaLCEcn4pxwwZO+jpTYgPiW6NFJdEkXsWtASawtYBUAkxSPQ5rbuVPV8YyzWjMcjMGuXFk/J/0crpNhJhIamvOvOX03wMtt3n+Ee9eCDn6V5E7PwFA2qZmgR6FcHT0VEijtuhrgXHdms8A56Ghlegs3gJBNWQDLb0TxGyTJuj9iPmB8dGydnK0boJl819i+nMhzmdKTD3DBAYks1vu4QO9cQkpJpjmU508eD+SXypyUEKlaxpzxYCAbd97SZ41kHkKrixqf7tLVzDuMzmNNmk6EpQn19DpYTWhUgtU2oOi3gVXlOZBCDDA7zeINaoeHu6JFdFCTrlRwlADF2xyGwrn74zyp6xAftgXiBHeeKvnva1aIwAzeFbuk0OXqibWvcDdkGd0mSEmpMHf86ENe72K7nFnT8y+D55SI6lxpowk808sD0+RvO8bzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(478600001)(52116002)(38100700002)(16526019)(316002)(37006003)(38350700002)(186003)(6512007)(26005)(6486002)(86362001)(8936002)(6506007)(6666004)(1076003)(8676002)(4326008)(2906002)(6636002)(5660300002)(956004)(66946007)(2616005)(36756003)(83380400001)(44832011)(34206002)(66476007)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?snkxLwHUH9DS3eKy3uJYzCKDA/WKFP/iueIYogQXHBR3bJ7HVo4AqavPpcaL?=
 =?us-ascii?Q?8cPgmsGUBr3VlhgE96JyY99q8gL8xdjyO6XdQWbm6Xs2odvnTun/gu1y0n3t?=
 =?us-ascii?Q?wsMJqv19LzNEejbAuuc6bRxuNIHeScP0YJW85xaIFMs3s3vA7duUIDt4u+ta?=
 =?us-ascii?Q?op4SRjCOHOWzp4ABcNaG4Lw3xZiPUc7q0h3DK0vcQFsAF6KxevpRO6Hdnw0w?=
 =?us-ascii?Q?qO3NOf/+WhBX208E+7I4DqwAMK8HUi6QvlWMZpon6XRE3j1wt7LjMHLyCnpB?=
 =?us-ascii?Q?Vj7Eq5+JuCRaEr/jBuUl8GGaISSGS+jiE7sAaCr//ebGoO7GmCt/g3URLmYd?=
 =?us-ascii?Q?K25nlvPFhlYBgGitE+GnI0F+n52MnSNFCsjl/f3wgj252FO6Jqecd4q2YIM9?=
 =?us-ascii?Q?RGem7xd7exYKbDqWsRvrsY/arpAnbASiGt4xONo7MsE3G5NIvYzU2UEuBmSt?=
 =?us-ascii?Q?KnIhh5JpNHxO/3aN6KEyi7xpQS+XbYHMJ+N8iKmIcRU2kMYoPTR6P2A4nKST?=
 =?us-ascii?Q?MXeRvYoEM2nHSczs8gRfrxQRdAh8ZxgQzN3HQoclMOqHtQGI6yggWlwk06I7?=
 =?us-ascii?Q?Yt42Epd1NviqcbzLNmatc/7PcpHfL/QBzmYO1fwX6dT9lEPGu96qv/jkftUj?=
 =?us-ascii?Q?Wtey7ULcC2DCiaQRtMAtXsiJiclseqiIaKSpi2dn1AsGkjhvStZ/B7Iiv1jd?=
 =?us-ascii?Q?sxvYuZ4kax12rn/ku+LFKPjG8SeLmszclrLfIUEXHmpcmOdgnIBnBhKM2+0r?=
 =?us-ascii?Q?1qX1iM9OoBv+WKZP7dawzjBYiXGIZiZLRdSBMkBbMTFsA2VgFCeUCvEIVLlT?=
 =?us-ascii?Q?Cv774NXFO41UkxOPchV3Qhl9xg4XOeGM0vC0JRJaKOgCxfkTNA+UuZMf9/Po?=
 =?us-ascii?Q?5Ov6shxY5TYNuNk+lcgzOLfdMd8HOJWuUEWbo2/gQGrEv4rLdAvzK8m81ze2?=
 =?us-ascii?Q?YXy2rwCgAIRH5wDwaBdFRRHRkZqR4I1cT23gbQK8VXyByb4FmiU6OKliZyZo?=
 =?us-ascii?Q?NHsmFUKBM7Xu+pgrF0upMVoj7eeMMm8NJW2LikytFzVAUHjIJELmoiBi+ZB8?=
 =?us-ascii?Q?WFhmDlmjArd01FLYtp67to9kf7xeWJkKjlk7RP57EE0tR3LuUn/YNxDPB2iu?=
 =?us-ascii?Q?kDJHbvUXBzwTBbcGn7NAF9wINDjN/xRnpaGg8Go3g2E+m8e0aWKKM9MIOso6?=
 =?us-ascii?Q?IkuJnS/BQlTFM/Z9MzzPkbMl6CsvFkkf41NOP7QRq4PDR0OfCsQjbn8YXieM?=
 =?us-ascii?Q?qrloSFIWG8wNkxWGvoI7lNZ6hd28yG7j7OTTQAr8oHHq+CM6+ZBbszZHbg5y?=
 =?us-ascii?Q?EsC5mY2/bMChcOpHdHMkd1Aw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a6af92-620d-4d70-fca2-08d9064973ae
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 11:17:59.4842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSJoKtGrKgD5fdOW7tJxywKLwmqHMwrYX2FO7aomw6SbL8VGgkZENvftVFTdhZ37qw4OwKCEbtq1gIvTWGbH9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Exposed amdgpu_bo_create_shadow() will be needed
for amdgpu_vm handling.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1345f7eba011..9cdeb20fb6cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -625,9 +625,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-				   unsigned long size,
-				   struct amdgpu_bo *bo)
+int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
+			    unsigned long size,
+			    struct amdgpu_bo *bo)
 {
 	struct amdgpu_bo_param bp;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 973c88bdf37b..e0ec48d6a3fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -271,6 +271,9 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_user **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
+int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
+			    unsigned long size,
+			    struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
