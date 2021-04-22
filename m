Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2F7C433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6D3613F6
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6D3613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 387B16E2A3;
	Thu, 22 Apr 2021 12:36:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52E046E2A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 12:36:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2Ter7nAxISfKA9PNGtR4Eg77D7LbSgRNfAiEC6pWTj+2SjisBDmV1ONet/vi+ogNFR3WJo+mJ1pytPITYhS3QJVynRUGO6kpuxNZC+KPkLxwVty4bANouNLl1yhroSNEOQJyQ2abDrzT7CmkxrLjsb0XxerG559SfpMjbBe5u//4f1S1hpJIpTeWW4d8eA+4yA7pkFuH91WjjpiegMwWuMrAPxdocmLHQvM+hhwMv2ye5rH8AlUFhXhtusaOZSoR4tN0kN0W7enwlI2GllLkZ1MlypE0tyhdwHAqwBrV4EaUi6B7R7aMba3Zk53mQo/JAg8YshtwDa5z0VyJSjV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=KndgGc25GEzN+VaOu3zFPFuB/ydnqhf9W1JH0Pn0PrSZEsoIdVn4iYUOjZxd3eNdH0X2hqVFxkPURjmT1Mxu2lZZ2cZ90VjmoaEdwTSpt274EzAUX3QGVDOMp8SwtRMThYLGGU6rVJywwmTEmcNJjp2rQIpcckvBdxvcmqLikVBRhjZd4U45sYj9EosfFpA20I6/GQfKPQLo16G2YzBuxH2KLFkc0oX+uBJJh0z6uNVG/Bv56FnBlENDKeMRPR/piX2rhdK/Dj7GROj61aydfQ7w4eUXr+T54NFKEu6wv9FydCUa5Gd4Asyh/gecBPIpmhLlcgNRnAIW0SIZICdEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=PTYxsLBHoy5va6bqH4DlC9BQL/JfWXCXRB4YhdQzqKbm8MDRMzyajLUTcBhrtdivRjsD7i274/xHGkxzyTbfx3Zy1yasDh40i7dxl6kRPjy7XQsQf0UABllt+urFM3tk9s7rZ8fSsvOQnynaf40mzxO21qKfpPkaDDCeBiflkc4=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 12:36:13 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 12:36:13 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/5] drm/amdgpu: expose amdgpu_bo_create_shadow()
Date: Thu, 22 Apr 2021 14:35:41 +0200
Message-Id: <20210422123545.2389-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 AM8P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 12:36:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be186bb-eab6-4648-b6c5-08d9058b3731
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB023167155E03016BFB1C1D898B469@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xajwldj6CkEp42pXX6un/6pfymlEChJ/+k901IebbaTwWA8s56Xg2IRBMKpHmnZ4Sz0imScj8pEBeL6lj8K6KSBJvUoybfeurXUAaN4ahpNwR0gnnbGrQfRURIz2uag4SXD/PiBFOWw7fYpGTPyXgzrpLxHGeysZMkMxX4p4rQMUqVT12OgNHBvFun/VhRgpO9bxXTybAPZbrHAC6ObS0YT8Nk6Ma0KiIt9GxpHenorOBV7UypWLU+wRrou2ElQlv6uVkdbAMKOoopvMCFSwofRZa7ogUTh/BrXrIxydazKsmFDUsX2DNDEuF9VGCkzwkIQtPSWZKmxSiYc8iyPIYRJFGMg3mb6lJ7FIfLUZ6L482HIS50/kXZkdBOHEPkBtjokIL4YUFvmzS+citz9D/w9U3uhyZpINrqbPgCZdMy1rYxV/XmImYS/fDbOb03wf8mNVU5PLi2zf8g9EJUrSrEU3eNXFuqQ7IyDaYW5MMH6PoGi3y4ep0y2CiOcHFsEq8CJZ/4oLDsAJLeoBLEowhNnWFY/WGnlB1l+is1ndFJtzlU0LjIRpedM5ljt6hgV0r83B/8ZPXk9fmya8aAoILhLE9S4gzifvPqZs6llfz7KihBw0/0r2Hfy+itQgJ/K54/TSCwm8ahWXEWItt4raOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(136003)(396003)(346002)(52116002)(2906002)(26005)(38100700002)(44832011)(37006003)(1076003)(16526019)(38350700002)(36756003)(6506007)(6666004)(6512007)(8676002)(956004)(5660300002)(83380400001)(186003)(2616005)(6486002)(4326008)(6636002)(34206002)(86362001)(66946007)(316002)(66556008)(66476007)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zvDqiIT6ZEjd8XYhbVoVpm8InBMwxK3AhruOUkAqzn10+Hcbx/F0auuTgRPC?=
 =?us-ascii?Q?8n3demCcKv4lXvB/6IikMDqxr1+OFHVqJaZDUfBBc+WUFSLAFFeR2FIHgpsP?=
 =?us-ascii?Q?2XT4oLSjJN5leY6r68jDJKjfyuXtsWmYBRBtcWLaL3p0a5vOJe/74OyOvQe+?=
 =?us-ascii?Q?orAOs5yOcg3QyazlXKfD+jyXZtX7hB5NmaBiANE6ftnNLOius1GNc6ADbO+B?=
 =?us-ascii?Q?l7Y0QPQ/5B2ssTXz17sOjVN9R+tBNJX32dFdh4ZrbSd4czvo6G4JLB3YEdLM?=
 =?us-ascii?Q?SGvpPCAdICI8Cn8Wj+Sh2mHhu2I/C1g/8dub3T9eLfzEtuOhpb8mBQ/YWImM?=
 =?us-ascii?Q?jvSf79ndAkiah0rCEnNHXnUXdR6pJ2Y2jFL1DGHqKAo0RF6EImEAtD3GQWnQ?=
 =?us-ascii?Q?M3EMaQ4DaBTwppTz9d1nLW0C3Qyby7EdSqZVL45kGkTAnGkteWMvH9JLEVFM?=
 =?us-ascii?Q?gCRqvp87sSOgT3P/yQnm2QEeuyvvGWb1zx2e3vJEHOA8Zog7vcAD1EMyvCUD?=
 =?us-ascii?Q?rlxDUd0OalOlLbOtbLa8a9BRGqGXRs2Uf5lCrE9mc6OFPuvBJ7xrXho/UNPd?=
 =?us-ascii?Q?R8RDzsfpH+pE+w7As5ctLeUTWZFU6Uwaqeizvt99gp1Z/trnDefFwbRs4VRl?=
 =?us-ascii?Q?x89Dq/ki/WE4n7C81N3gE7rMzyBG+5iBh+pQ4SCQDgdZySWlBNHmcK5xY5yO?=
 =?us-ascii?Q?XjTlNDzI7KDiEDhAkrSbysInXG2kClr+Txmx9FqTtHT3SgLaKouddPdclsU7?=
 =?us-ascii?Q?adnZEAAB9G5ElmL2tHFoWUKozsz6DE0KSeazLGeHDoMULSQ/3G60GxfukIXD?=
 =?us-ascii?Q?V4jRFsIRV/EOYZcUvl8A39qesbeygiE8jXtwiMkEkqcUyEK6+rMo7ypg0zb+?=
 =?us-ascii?Q?N4oJnNuVCajIci+H/4HAXsFgiRqiTax8Xe+QJI7bq44n7LvLwITv+bY+fswB?=
 =?us-ascii?Q?IqrLAVgclH9xwVMX7gwpQSTyjJosQWJCj9oGfm7K1p17zCCBHMGbXfoEuTAD?=
 =?us-ascii?Q?e+oQiLOEeqiqTxadLMg9oL9wD1pyHGGf5wcRCB4FXeXqouFN7FkJuMASE2RM?=
 =?us-ascii?Q?YJ7zM8jP04hELZ7piI07RSgwTEL46OSF6zAREWRCKxAQllZBi78d99b7IyfK?=
 =?us-ascii?Q?vLYCw3v0L77WZXG33E2kebYbiEDXLyQ5jspQUcWjGabkK8+RDw+087punVJm?=
 =?us-ascii?Q?SClLrxCOxmdzcWhBPaecGxshRNjvlyFl3Ea9BfxguIyS8lNDcgQzCdSmkvNh?=
 =?us-ascii?Q?O6ZQcawpJnlyAYTOkyiSRs4N9905SyewpDJFKshIbDFC7aYUcsqg7EXn1mmP?=
 =?us-ascii?Q?b9rcuUInzLFLEEWBSZXMBdWp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be186bb-eab6-4648-b6c5-08d9058b3731
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:36:13.5823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ua6X2EArlsOJit7rlF/kUPV6xHvRRYlV2uwR9RVXK3WR4RbZRhIvTLbzXPSHfGXLRhyUjHisFUB2HQt8dw4CXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0231
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
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
