Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3707FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE8F6521D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 15:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE8F6521D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C9589D44;
	Mon,  8 Mar 2021 15:37:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2F1C89CB9
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Mar 2021 15:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dt5Gn6uWhiVQZ0m6jrGEF0YQnVlrErlbK4DRaC5MC3Uf2Fp6rB5rSKv9CpgJvU+JX5A5rh5UDAmTNwvtVjU+MUcWImvKt/p/fLXjGJW5I+LG/w+pO/780YXeiwlPxly0VE2p+VLL9id+YAgHyKGoJPoCnCeLnUVXho5LL8amc3ckYumOXjO4qQ++2vC8+CP2pQWnf7i+npqe88UvE0u00RRFrNxj0k4FUosD3Kw/UJ08mYAfthgV2k4vBVw30cYdt6ZmtM2k0FOm9sKLOhpgMItl7Fcgp3KMMbbfjOrTNJ4Hgbvq5fAhdK+KtIj2SUGyl530J9loBR5NvUw0YvDOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcSlthMo0E9GkLmEnavlsntBAzhiy/qB9GAmmcSRVpI=;
 b=AjNVqdMVuL1lkP8Ag8NPV1tZEf1o4Q4CvujHAeYBx/qfbqwQkvlJV/A6DbHHt3+vPwq4H+edJWUwU/ZXknrKPp0Nk8RwpGcqKXwXnEhmTByVvoFU06hZ2ragLJrmIKkAxynFRX4WfJ13t3g0xrXoQL5qNOIbYfRXF0Xv0Y/Ojxzr7DnTSFP7ghhSf3PrIaGGHsLtRUchzaEWXozPTSdcFz29VpV/LbvGdn/fMTdYfkCFn7lu2u5Wp/tZKcd2txVNuW8idYkvMFSBB0lKWogufAqgV5ARZ0f6JEJritC3lWJA8mF/CYSqAjr7dS9v9UzjG8Vry9/TUA5zoZ29gk0nOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcSlthMo0E9GkLmEnavlsntBAzhiy/qB9GAmmcSRVpI=;
 b=ZwdZ6AIKuiphXGSr0uOE/SJPD+wpVMpS0jRxzrgA5aHCUjRvz9wLoOXQyt8gUhHI9gCASvKeu36KVaDDGo/tWyXK1ISKidTMC3MxHSZGefUWR4PVysHQ1/epFEkg7zoAOVzGAM63QnNqlqduOYZD1nmkY8LVKgy9exvn2zMpq/Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1237.namprd12.prod.outlook.com (2603:10b6:903:3e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 8 Mar
 2021 15:37:24 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 15:37:24 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/5] drm/amdgpu: use amdgpu_bo_create_user() for when possible
Date: Mon,  8 Mar 2021 16:37:04 +0100
Message-Id: <20210308153705.37414-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308153705.37414-1-nirmoy.das@amd.com>
References: <20210308153705.37414-1-nirmoy.das@amd.com>
X-Originating-IP: [93.229.42.112]
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (93.229.42.112) by
 AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Mon, 8 Mar 2021 15:37:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ce06105-22ff-4d18-1e1a-08d8e2481209
X-MS-TrafficTypeDiagnostic: CY4PR12MB1237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB12374F522DCF3C22FC5448368B939@CY4PR12MB1237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1qa+e0EVIwGizpbit7/42AGnDLZPu4IaGxOvrTkCpSx6uNf8xtxSb8JMDdbhyvQQG+lioSU2ieLQkc/n4MW9iJ1U7dHL2Wai0ZfKbTCmJI4IcpqWDQuk3jNUwXPOyBEtg7pN31kW5DUgbHVZLAKdgiLghzTCYZsuqiKe5mSuQSCRQvCXYDryew23JREhCtsDHK7Xqr4dY9DNV4Cf3IMf4NvNjuD+eZJ/SJcMBjXJcfxycRvbIDS8XgbkG+Qtbas4/7ILPvZRHkf8gFUHJ1YvomKWLEVWnb4yMrvXuF0+AB3g1RzJmvUjIkjkEr4K1UUwPDsuovmGh8tdbEBTwDz5QyQo9tBOZ4WtSFvPasDW9BwKKklEBhwd4OCuw7MHry4GypEiif6CTnkzfe11+hTeFbJ3NjByb8fUR1zMU4RGdW+8y/qpuWh8O7b+4PQxlO2rqa1WHJULKOa/4pyXzlIKXhAyBrRkHDN66HqEEhk+E33OYGd4kO3q8e088Tpis56QDWy8cthZ15KZJjkObtXcFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(186003)(86362001)(44832011)(2906002)(6506007)(16526019)(66476007)(6636002)(26005)(478600001)(36756003)(6666004)(34206002)(37006003)(4326008)(66556008)(5660300002)(6512007)(956004)(316002)(2616005)(83380400001)(1076003)(66946007)(8676002)(52116002)(6486002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1EfhoLBaMy0c8UTr2sBy4vic8MPecr5oRRDItScKfcCE7CXri+tV+QXK68wh?=
 =?us-ascii?Q?4ngH2ydWo/k9bpt767NJBjxwGpG+gioOkRMzR6ZjWxn/ryevJuZETfmLXqn8?=
 =?us-ascii?Q?jI8MKiYw1D0CQaxBUxdhJdHNTU73AaaN1Ma9f+4KZZQaW7mJObikG2CQsOnS?=
 =?us-ascii?Q?TWZAVmzwO5avhzoBowyVMr7AEdcYZ7VssLQVVra+4DFviyL5xc6WutUt4hAk?=
 =?us-ascii?Q?SBhwsMHMB1lN8hh24sXwY3viLpt1B8CZ3W52cFERLqKHxqb1+VRF20aw4+5d?=
 =?us-ascii?Q?jvSbA4bCBRBgFv/rIN27U+DAGPhoKrcnjsd26BiIabW2QVnFwDi5L3WstZUF?=
 =?us-ascii?Q?Dorht1iDB/L2Es9qooCCVxEJK1cH9ZPC61+YZO7tGZjMbfQy+WjnpfKIK1Kp?=
 =?us-ascii?Q?VuQborfUZ2v8Yc9z/clf3B90J7g0AjrQLgg9cP3JfsKR/BXDyuaU7wBa1if7?=
 =?us-ascii?Q?cJRfs15EEEuCMSwz5K6F8RvX1GmD0oRawazB6Sq7gvPV+OqhL6Z359TokcZ+?=
 =?us-ascii?Q?5kAiq6oLGy42uiiZRa7Pzi/ugf0xOgQFQzz5U5PVYdyi1jv4Iyq6N2AnZoI7?=
 =?us-ascii?Q?GKBQiWJo02HLl69IWu0n9sU8BQpqCravm98iJLSDlbtnfpu8N7qUUDmWrc6D?=
 =?us-ascii?Q?DOlkz8HA7G7ic+WpKoHbcMbZpSEgpo+mlS7xxLZS0rfSmDKm5lP+aRBK8aI5?=
 =?us-ascii?Q?alIoJ7IMH0E2kagU3/k7HLGzwAi5N3fK5vSU4kjRiYfRHViLmNfeGMZzlEeF?=
 =?us-ascii?Q?KjIPPRoWL7mccpW2xU/Gk+I0C39o+SDMTQ/tgCbAQxCuRB+5bDDsCYizQ5gr?=
 =?us-ascii?Q?AN+BwBEynfJWssGYePIhtz65CpcVeiZTuRJ2L8dN4ePdvzWbs5rIBd/VoX2D?=
 =?us-ascii?Q?PqrZKXA6UabNO+AxMrms6MqyhjR4sNMWwIAHsoq7gwVGJQMa5RWeGGzbb1YT?=
 =?us-ascii?Q?RpuzAGm3JoRC8Fp2eDtqk7eyJMTVf2Hx3qdjM8iGkVwnJIEErpKsyd3OV7sP?=
 =?us-ascii?Q?B1KU+jwd3R7ft597GB8G77ENdheIF2sOkUVDIcHISKpxK9XnfuvQkSoLKIBb?=
 =?us-ascii?Q?3Fqlt3jFxRnlEj5mwqEcIgPpmLSezIK0pIH4s+KQcwrr1qaDYXcFwIrPNhdw?=
 =?us-ascii?Q?zPbaLFvXgSwN2RbNuM6j6LOqtb3Z/X93a390dnzwklu1G+2ZCge97r5/QVKW?=
 =?us-ascii?Q?LeCWJb6J9oB/NF0Z4831AozyV6dp337vqBivbVDKCG2P4TFVPoEpuzWqRwUR?=
 =?us-ascii?Q?SPJ13kfbyJnHrTJRPiJL85QG3ulzDnRzVJruXJJGWaMRAEgw2o5IR/DUKpaM?=
 =?us-ascii?Q?Sr9q0pj0d5R10IlzW0gLnNJq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce06105-22ff-4d18-1e1a-08d8e2481209
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2021 15:37:24.3444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PIBEYCbnpcx1L02m0v0gG9hdZEnS1LCX2EH2A0GuLUwNNSh7EYJ+qPkxtuV8ZTAb6Zve8EV0MSLnOYa7zgNFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1237
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

Use amdgpu_bo_create_user() for all the BO allocations for
ttm_bo_type_device type.

CC: felix.kuehling@amd.com
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index f44185f512de..00ac5c272f47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -316,6 +316,7 @@ int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_bo *bo = NULL;
+	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo_param bp;
 	int r;

@@ -327,13 +328,14 @@ int amdgpu_amdkfd_alloc_gws(struct kgd_dev *kgd, size_t size,
 	bp.type = ttm_bo_type_device;
 	bp.resv = NULL;

-	r = amdgpu_bo_create(adev, &bp, &bo);
+	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r) {
 		dev_err(adev->dev,
 			"failed to allocate gws BO for amdkfd (%d)\n", r);
 		return r;
 	}

+	bo = &ubo->bo;
 	*mem_obj = bo;
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index fb7171e5507c..beff96ddc0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -58,6 +58,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 			     struct drm_gem_object **obj)
 {
 	struct amdgpu_bo *bo;
+	struct amdgpu_bo_user *ubo;
 	struct amdgpu_bo_param bp;
 	int r;

@@ -71,10 +72,11 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.preferred_domain = initial_domain;
 	bp.flags = flags;
 	bp.domain = initial_domain;
-	r = amdgpu_bo_create(adev, &bp, &bo);
+	r = amdgpu_bo_create_user(adev, &bp, &ubo);
 	if (r)
 		return r;

+	bo = &ubo->bo;
 	*obj = &bo->tbo.base;
 	(*obj)->funcs = &amdgpu_gem_object_funcs;

--
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
