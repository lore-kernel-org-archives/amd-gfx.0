Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFCEC47083
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39D67613BF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 14:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D67613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8DCD6E419;
	Wed,  2 Jun 2021 14:09:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E99F26E419
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 14:09:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLVlUzG4PlAGZ/gnwGjtQQoBXVr7VNq7pUbF3FyCJtTxm7c4jArTCN291zLPu4cG/y0hUdwpGm5EBRAGfqtNcjqMKbWlwXMtm43XCSEFNhghRCxzw+LaziotSG+hH4GOSO9Cpb+Hm9mvUbNHXj49fS2qpQoFQCWTQodMlFc3hHeUAeQw2jsIISdgnAHbEvwpyceEbBlLxbykcps200zJdsDJuHjcEKDXWIlrmKgjShK8hFoexNEoSziYOjMRMSj2bd3ROQva4eM5yVs4+C6RH368P1fEVaa65Pib9Mq7N9QZqPtMp7QP5rXlYvbVaSbUm9NmRQ2qlsKCzkjE4RpFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty/HgKjJaOiWm3zpsAe9X5XNYuJd4LMBij7C22edrfU=;
 b=G1YOl0I/G9DwTf2LZazlMb7jcB4oc14nW1dnb5UpB6NEsIFoxy+yVAsp4EC9u2xu09ONWtTA9LXXiuD2yoKcS2jn+vVfooIaDz+3xTK6ajP4T3pGCrxsn/Q7LJWmdA8nDLVHV8AHTQSKixp9le23G4kuPTMjJ1ZR8alOnrGC7gXgkg3SNKVhT29mPkgPmdJt1CdRL0avCgBifDuIZOOGqlva3UxdXp7mvBxw9Geaq0kduJVlEV8eyOW2cnBptzBmUgJTFs93w5KJOs2U2Prv4h33Ymxcc1Ai4Eyrly99WURpga8MMjEjjaA8qpxBdaIjzapcyZt9ltRq3oP0+43+Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty/HgKjJaOiWm3zpsAe9X5XNYuJd4LMBij7C22edrfU=;
 b=vyXmgnGOm3FDk4qW/K+R3ML3oHLTI2mU8ltrL9OKdnh3pBOxcoq+p1KolSW93zmHYWs05sJXa+l1D3Z7jkMf8R/hNei6DRpuRLiXmmZjmzIdmiRck9f0WAzHPSRoSdFb8kmU2haqKm36uBeSk7gcPhadrPIaYm/MskkC8S1tp5o=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4675.namprd12.prod.outlook.com (2603:10b6:207:35::26)
 by BL0PR12MB2468.namprd12.prod.outlook.com (2603:10b6:207:44::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22; Wed, 2 Jun
 2021 14:09:41 +0000
Received: from BL0PR12MB4675.namprd12.prod.outlook.com
 ([fe80::1094:c67b:db8d:f319]) by BL0PR12MB4675.namprd12.prod.outlook.com
 ([fe80::1094:c67b:db8d:f319%6]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 14:09:41 +0000
From: Changfeng <Changfeng.Zhu@amd.com>
To: Ray.Huang@amd.com, amd-gfx@freedesktop.org, Nirmoy.Das@amd.com,
 Christian.Koenig@amd.com
Subject: [PATCH] drm/amdgpu: switch kzalloc to kvmalloc in amdgpu_bo_create
Date: Wed,  2 Jun 2021 22:09:16 +0800
Message-Id: <20210602140916.6220-1-Changfeng.Zhu@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR02CA0220.apcprd02.prod.outlook.com
 (2603:1096:201:20::32) To BL0PR12MB4675.namprd12.prod.outlook.com
 (2603:10b6:207:35::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from changfeng-pc.amd.com (165.204.134.244) by
 HK2PR02CA0220.apcprd02.prod.outlook.com (2603:1096:201:20::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Wed, 2 Jun 2021 14:09:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2a1e28f-8b83-4fac-2708-08d925d01068
X-MS-TrafficTypeDiagnostic: BL0PR12MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB246842B10FF5F4F209A88D2DFD3D9@BL0PR12MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EFx9rleBobj94optUtRBK1hvey3scOlUgOKmjUx4pC8utk3iAFxWgqVoPPujH08kFSyaGBwQL17w8qlhpZYLbxdrVzznCyXCvbYENRnWoAehtkwdo9DUecWAxMHWnagV6Nie7UCXOUrNLy5kkdjPIZW0VVhpksaHSOgA9u/QgYLztZvEZ7y4DaIAMAunrt/n5vtN8py7Qnn2VZiccTjdOCmvN7Ow0I4Ccg6M/rRaK7p3EVdHzVyev7JsGvoHg4JMm0JNw58RMhLFhyJrcO4V6S5oJjKufjG6G7vEl7agBvdtq8XQXXj2+IBHShBf///AZqElQHqDovFdLDLcIGP2+DdNGDEzEvSuTW20r1qwLLZ+CFxQGYFwem+nEKIkhz5vn9cF2rpzgylmR1lDGTrDVZHo2XXJoUpMCfdCFayOnah3jLCYtQex2b5PkPR1TVkQFGOGd0dW1p4yqlUbGlJ1htRp5EQTxBbNNHgF/3/6lWI/37BKnROQQWAavuAJR7LPGE7YylShOrV0ZDh01ryANHACGocQqsl8oezNgBIDgor27j/0bLLzbqrbR9ItP7HnyvMkKHWiGMxIUx66udW1XpiQ5KtJpOc1uyFJjhC1gYSmo0Z6cTe5A5XVqHam3xtuDvMoCH0sgiui7tWtp6UGK7LBQvQLkhTpaOvnhqGE4XvxCTbf/0XD1K8dH5jFr7as
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4675.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(38100700002)(38350700002)(6636002)(2906002)(66556008)(66476007)(6486002)(186003)(86362001)(36756003)(6666004)(4326008)(8676002)(8936002)(5660300002)(16526019)(52116002)(956004)(2616005)(26005)(66946007)(83380400001)(478600001)(316002)(1076003)(7696005)(16060500005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Elh77MpWRsFfOfsv5snSVIaUZuOzJwdPHgtSgMn4kBWCMJ7BnWi6sHU+2CFF?=
 =?us-ascii?Q?bNAXaz6Hf2QtQ9wUBfiUxT0RsM5VXYWcnfM5wUvzmya8J5tYAkQMLlcCmwNf?=
 =?us-ascii?Q?T8NbVEVK3H7bClvpIGSprIXtpYyFKpEAAdns56S/pr/W7gJSJeB0dUELmML8?=
 =?us-ascii?Q?j3FlVhtHHoa5bMqP6G8F8x59fD4BcjCPEahPWuCh8sXHx8TCJcuG4HiX30vb?=
 =?us-ascii?Q?53foUFPq2oxM9bLg+dMuzyEtoigsUjEzdfo/u1KfCYq+TyQE4A4pRX8I8U1z?=
 =?us-ascii?Q?59RIc97bKVI32Z5SxctCkcXakL+CGnQsLFMiR4/Ae6tycACvoDaI52UO1FrY?=
 =?us-ascii?Q?q6UWfBV2jiMspmaxa7X2W2s0EGDfVJCOfyl+dUJrwsejxAxRlVJ9aoCS24OD?=
 =?us-ascii?Q?3OScuYM1LTMAS8o0J0u8N0f8UfjmJZFb5j75BWOTaGzPAE5DgOlX7w3mY7+4?=
 =?us-ascii?Q?CYCj0boqn0ykpBllnGyEwPeq5k/ubgzTiesJ25HToC3kDNqnWaVa1yo5ofjj?=
 =?us-ascii?Q?nt0RDS/pJuleAIQmhC4PNctnYZmrU8XtTnuuCvvLAm4RXJLMG7I8i/IPDzHV?=
 =?us-ascii?Q?BWtJbhuU+w0xDlQHoWpkxJVHPMhwvq+F1Zc/iWuIka6xkaQVr58GrT+UWCNC?=
 =?us-ascii?Q?qLyyVYLua+BZfKcXW8yR1ro7zjH1v769dfekfqvG7ybL+npXtxu7gZON3unk?=
 =?us-ascii?Q?rsnHamIhIwqt1Mc/bBiNr8EGo8yz+5mfgfOyoWFNg5Mz64zP9QGM2aA+h5ps?=
 =?us-ascii?Q?ehUST0YmWl8kByQspxZVKL+PyKQecxLbmgJZpT/j7S9dJYF9BJiPC0pYaxoX?=
 =?us-ascii?Q?7AkYC1HLIYGmdeWJnmBxLepRmYmz060We1L3Cho2OjnVZMHKBue+NQnDza3f?=
 =?us-ascii?Q?pK4Q1OUhfVv81wj9qfrg82DDojTV9MeNLZK39YUbWs+JXH/pI2SKYNiASOeT?=
 =?us-ascii?Q?eTNCLbddEs/1uvaeSmzrk048Lomr1xgRyNk1EhqHqkt8ib6/SOnnjq7+PT+8?=
 =?us-ascii?Q?NtTcs1M8Zt/r9Bq8W+cLgiCwLf3rTFB8md0W4bFP4Ul2rOdBZB7iVqmm14OK?=
 =?us-ascii?Q?SJFNCYgXFmHDtwm5K4Mu33pBv00AY0whIWeVvrQK5pXc9jjO0idfaPx9bDE9?=
 =?us-ascii?Q?DenEvxANUtxQCtNDoP03OdJg5Y5rRFI/T3/UjhDB9MYgbNIleZ4ku7VVMoBW?=
 =?us-ascii?Q?hT7v64awPYF7lW7RQYm3UkMboScXYlfZKs+/jkOZ6vB0EFg4XdZfLDijpETd?=
 =?us-ascii?Q?cNTLJgN2RKfcTc6pyvVwwEr0u6Z14LSDSqiu/pmA5UMi4cYQGt5hN5Nhs9bw?=
 =?us-ascii?Q?zf/f2xEDDIhr2sY3UZyAMXLN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a1e28f-8b83-4fac-2708-08d925d01068
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4675.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:09:41.0511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMPXvS4VcOA/Otatu6tl6SXuoG9iZWi4btgWl4SuNxmRuKrGpOjM7EOjzWNfECFFCy7KU1eJy+UuLhfPSDNowQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2468
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
Cc: changzhu <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: changzhu <Changfeng.Zhu@amd.com>

From: Changfeng <Changfeng.Zhu@amd.com>

It will cause error when alloc memory larger than 128KB in
amdgpu_bo_create->kzalloc. So it needs to switch kzalloc to kvmalloc.

Call Trace:
   alloc_pages_current+0x6a/0xe0
   kmalloc_order+0x32/0xb0
   kmalloc_order_trace+0x1e/0x80
   __kmalloc+0x249/0x2d0
   amdgpu_bo_create+0x102/0x500 [amdgpu]
   ? xas_create+0x264/0x3e0
   amdgpu_bo_create_vm+0x32/0x60 [amdgpu]
   amdgpu_vm_pt_create+0xf5/0x260 [amdgpu]
   amdgpu_vm_init+0x1fd/0x4d0 [amdgpu]

Change-Id: If4082b0f7ba4fcd566af759e010840bc1a779747
Signed-off-by: Changfeng <Changfeng.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 15cee49f11e2..e5f62ca047a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -100,7 +100,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 		kfree(ubo->metadata);
 	}
 
-	kfree(bo);
+	kvfree(bo);
 }
 
 /**
@@ -565,7 +565,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo));
 
 	*bo_ptr = NULL;
-	bo = kzalloc(bp->bo_ptr_size, GFP_KERNEL);
+	bo = kvmalloc(bp->bo_ptr_size, GFP_KERNEL | __GFP_ZERO);
 	if (bo == NULL)
 		return -ENOMEM;
 	drm_gem_private_object_init(adev_to_drm(adev), &bo->tbo.base, size);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
