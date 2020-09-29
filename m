Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB684C4346E
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:53:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63D10206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 06:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="sYeTYbQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D10206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A9089DA4;
	Tue, 29 Sep 2020 06:53:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F7B989DA4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 06:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7gD5av2k4/QJGiObT7QtthDOl91v2gRSvPFBf7Uk99iCdRgyLPCIy5z6tVRGKy2Im92M7rILeGUWQgwcUhtTRIhD+74hdK3mwXdAjb16u21o98HQDjyeyqCTE3zVbOA+apkQyFt9WnFgfPcXcsm3jvAx2Q+aV7eOgHyKf6DfNKvQG8nJ+e6g3F3Zp+OiI4c9C8z7PQgNJ/gf1fVSDMbJFih/Hh0NLn4Kxgni+utVI7AlucUV8uv88tSffQlCTjzS/FGuqTk21bzTSj0hHdybBHGwteNqMr63qfMjBg3bVuXZNyy3dY2g1buZQd/04CeJPfbnrmeIIJKkKTxghBvLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKdW9jyl6ep5Iln5UFDEAPmOl+6VOkt4OjN7VX508XU=;
 b=XAC+veWmI6MY6bc7W3jXjeYV5arZkrVH1lCNazJfzLdqYfUwEKge+JoOyo2YN3npy113AwCoZus6amVWJBX8Z9LUnEFz/fDfl0tWXkzVZaF8tSWglxEXCWYndE4glt/NzYZH+johtq+xG4rAe8pO1rxaJw5bQznEJ0mTTjF14Xm+3THhD52U1tCmwkMB7oAgL4MMrtkiYV26llnncDxotjZcU0EIwkrZh41ffvD55zXAsMHLQzV1lIOHQdwk2HTo4yDXq5woQ67xwvRjf4eaU/Q33roo7267NdjK3eWigC1ixYKGNxZC4dpocrro6Or4eRBl601Mj92q3ekpJKeAUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKdW9jyl6ep5Iln5UFDEAPmOl+6VOkt4OjN7VX508XU=;
 b=sYeTYbQtwBIYJ3GGBuyVJFVkS3xc8QVr+iHt7sCjYruE0Z/aSoGTd5xIjOw/Eq6w+QTHVOUJEPVUOnAwfLy0V9QRjHrr1hbRRN151e9Wq0dedHSfE8OwHfgInzhjTdWHlOm2mKmjIxW8t7n07OU3t2n2HfjboR/DyLPHuO1zj/c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1283.namprd12.prod.outlook.com (2603:10b6:404:19::8)
 by BN6PR12MB1729.namprd12.prod.outlook.com (2603:10b6:404:108::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 06:53:13 +0000
Received: from BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::9dd6:2e3a:c449:f58c]) by BN6PR12MB1283.namprd12.prod.outlook.com
 ([fe80::9dd6:2e3a:c449:f58c%8]) with mapi id 15.20.3412.026; Tue, 29 Sep 2020
 06:53:13 +0000
From: Guchun Chen <guchun.chen@amd.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Hawking.Zhang@amd.com, Dennis.Li@amd.com, Tao.Zhou1@amd.com,
 John.Clements@amd.com
Subject: [PATCH] drm/amdgpu: drop duplicated ecc check for vega10 (v3)
Date: Tue, 29 Sep 2020 14:52:55 +0800
Message-Id: <20200929065255.11856-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK0PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::28) To BN6PR12MB1283.namprd12.prod.outlook.com
 (2603:10b6:404:19::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from guchchen-System-Product-Name.amd.com (58.247.170.242) by
 HK0PR01CA0064.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend
 Transport; Tue, 29 Sep 2020 06:53:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4d0175c1-9840-4aac-4b79-08d8644455be
X-MS-TrafficTypeDiagnostic: BN6PR12MB1729:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB17294FB0071044F82889D378F1320@BN6PR12MB1729.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYhzAyEKe94NAqX+Sa4mORZQT84XOuM+1JBVgPZYHt9u6m2JolfhmlYp8xMd9Z6ikigNUZn1+Ov71jQtvX+xrjZLf8YrDrfvjSnI78gFXjfXn8HypFguAyRTDvp4Gc/qao7q8neyRAemCB0v/cYoZYOOsAhB/qWUwt9XpfrnnyMX8XyxZBOhhQ/uGiehMI2qxoq7khFgc70ldp5DH7oYVbtZXXyTycdGjk1r19R2O0VbQz55lyCpweFBt6rEpFvwcc6f5pn5TABf7E1V+nd/qIOlESrQibL2HmNH7HqiWnoP9kc4Gt4MPSFUMl+drRlRFwRjwOJxwTTy/Oir5UY8h4dA10aY6fYCHCXtKmjB+0Mdh6wIg2SlXAx7IrR4x14K
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR12MB1283.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(4326008)(6636002)(6666004)(8676002)(44832011)(66556008)(66476007)(66946007)(83380400001)(7696005)(956004)(2616005)(52116002)(1076003)(16526019)(6486002)(8936002)(316002)(36756003)(26005)(186003)(478600001)(2906002)(5660300002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: T8IFSvf0ykakSvj1dlHjLZUxRTdJhXq4plRHdgnnHHEP+XUryC+Ph0ro2K3fy/Fow98isMJfOGjTRq75GcYfbMiiBrjUYDENjHr50G+ucMlJHxiOdOxVK9a5tMIY7yNrkeWfE+WBVvEMRsY3CJ+S2Ac6QjFqmEGh1Wvo3BI3l1X+/x1HSs7LY6/gx6xRrGk0gu1dE8pabAXTwWjTTl3ex1ENdqq87o4yNK8N5ExQ0KJqdx0j9FJ2K+1ni/AutVrpwfPkzPdbv6+P2byjzrrhhjRrGnzv8hjh9CKaifjwTt44S4J632x8PprW+PoRlro+5E3ACDIYy46A/4x5VhgBNP342CC3g7GwAlCyZxW3rWCiZLc2BIwcN37mxHx6XLXZInBZbTBX3Ib8jZotaxQm6MVjijYx8hLoS9wsEDSYAUBr2v+vIu8EXVyXMUqRlE17x66GNZ1jFt53CDeseOusrCAlZpAKSphgST0kkXiLw6dhuqFOImS5MJFj+BuZKz+Eu19mGjQYjf49ukcIWq+CTefczejrcYaAPf29Wajh1JDZiRLxFfm/+ykXviDRoI4xCzQXXSIo6eHkTMU01pc2SnUFnphPSYnDnNT0PqO2blOu5aI05VewIhUrPYxtW4YvFwWa5voEcQu4+IfjF/MHLw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0175c1-9840-4aac-4b79-08d8644455be
X-MS-Exchange-CrossTenant-AuthSource: BN6PR12MB1283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 06:53:13.4172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w3ef5gSPIh1v8EmX+fPODw/aBu9Yiz+MBYJ45Oj5nPdsZBJHYTPfjkpJE2SPS34t5VT8CBCocnGTRJTkOAf/OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1729
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
Cc: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The same ECC check has been executed in amdgpu_ras_init for vega10,
prior to gmc_v9_0_late_init.

v2: drop all atombios helper callings
v3: use bit operation

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3dddbc60fe3d..9599946e4bee 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1193,21 +1193,13 @@ static int gmc_v9_0_late_init(void *handle)
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
 	if (r)
 		return r;
-	/* Check if ecc is available */
+
+	/* apply DF parity workaround */
 	if (!amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_VEGA10)) {
-		r = amdgpu_atomfirmware_mem_ecc_supported(adev);
-		if (!r) {
-			DRM_INFO("ECC is not present.\n");
+		if (adev->ras_features & (1 << AMDGPU_RAS_BLOCK__UMC)) {
 			if (adev->df.funcs->enable_ecc_force_par_wr_rmw)
 				adev->df.funcs->enable_ecc_force_par_wr_rmw(adev, false);
-		} else
-			DRM_INFO("ECC is active.\n");
-
-		r = amdgpu_atomfirmware_sram_ecc_supported(adev);
-		if (!r)
-			DRM_INFO("SRAM ECC is not present.\n");
-		else
-			DRM_INFO("SRAM ECC is active.\n");
+		}
 	}
 
 	if (adev->mmhub.funcs && adev->mmhub.funcs->reset_ras_error_count)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
