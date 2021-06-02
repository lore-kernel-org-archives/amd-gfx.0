Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50EFC47092
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9995161C2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 16:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9995161C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC3516ED99;
	Wed,  2 Jun 2021 16:49:52 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F0A06ED9D
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 16:49:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5PdLPJW4G2xXoqFaoIBcxK0/jAlgAHptnOS14Awd8EnFVO1QGQ0sCeLGrYf5NOhMoVADl6r5fN320Q8SxazQFug6NvDdsIB4/scn4Oeutt5x7dS8MFqHOba9wTXRxEINhEtEvVUxafGtRdMTeZz5eJzxa1UIvCrKqAsjp34F/BSbW4Epe6SxYL1RfNEDZ+oUFP96esxbJ58ST4qfIPsrS87cl07wGaj4g9AoWuDk+I9yxMMXSE49nzwJopiSMQciFP7YQe5OZPvNnIi6ZDqz+6c24n3BEDJOSGqehe5tWYcAua4Vg+hiblmhAY72q1QJ2XVmR8kD0pZvAMHEtVW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OnVmrJFcVfrtxh1Szed+Sqz5Uyu3qkALgUi1ZdJMus=;
 b=gknD2DXibpBSAi5ybM7+sDt15Nf2NnedryMH7nn89kbWvYuOdcEsU8/jGGbyivJNoN1hY5/Hfh+wcx46jdgxNfAahIggItNF6zZ03J6KBxjBHxAmkbjnY/hfdQOi+FtSJJqGGNP6HkVM5KZEeFm0fMLr1C2V4iTyNBY4xhceLR7FcG+fm78Feb1Ru3wVMqnmxBJIhbagBjSh36RbOxV/DEAVVqUUmsqmH6o2Ef2298GJRuCLAqCMzfLwSpSZRh2Dv47VdqrrTQ2ytODC9v0Ur3173TdEaAxOUfIdQ+HXlvLY+q6hZtFYMt+PK9LR6HWnBgPDN5IaaAJA00HPEjE4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OnVmrJFcVfrtxh1Szed+Sqz5Uyu3qkALgUi1ZdJMus=;
 b=X9m2QBlTHbStrrKUcpI4qzMMaZZAB2uGnvNfvR23UYcF4HyAq2A7sw4mC/+6wujtCHgFsyBJhMJ620nloSLT/Clw8gS6pvb6api1IkzNINvWXVaWJ068oqEujUYpWMr2v9DC4ZFQl+OmnULWNkG7+pGT3c/3xXnnaeXNxjM1F08=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4533.namprd12.prod.outlook.com (2603:10b6:208:266::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 16:49:50 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::25f7:664:3a8f:25b6%7]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 16:49:49 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 30/89] drm/amdgpu: add GFX Clock Gating support for yellow carp
Date: Wed,  2 Jun 2021 12:48:09 -0400
Message-Id: <20210602164908.2848791-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602164908.2848791-1-alexander.deucher@amd.com>
References: <20210602164908.2848791-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.207]
X-ClientProxiedBy: MN2PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:208:160::20) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.207) by
 MN2PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Wed, 2 Jun 2021 16:49:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bde04d66-9504-4d0c-e267-08d925e66fac
X-MS-TrafficTypeDiagnostic: MN2PR12MB4533:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB453396FBDE80C9E9FB1C8C25F73D9@MN2PR12MB4533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GulEi3Vd5Wma/fYwWN7iFhsgZoILfSUUX0O9E1E4EPJqEDJPyWZGLB/OB166bckd/1EAfMQHxJTcLpvGtEX5+qEdgkQ7raxnRUzSScm+eiycToNOU0TFqUnAY7sxgr7XSziNbWfqDjeR/ZrBIXvm4fXUWVycLGvTB/DvQx2p2kn19mJX1Z3nOLj4UlW3oMSg4W+tKj9dwpaBj/6sTRPr+QjOQ4QDHL/LxbI6GVyvSsHSQ/J2ES16Di3A5a6EO0BboExpncgvjxF6Urtk1LNR/mvueT7eSh7Z6jjGUadZ2mcWlgmSMs12nWT5BlYpo3Qh3jgpu4NifNeNYqrQvPt9yiLwbVNYJkRvYMpb+bdDmLojbSxHBTQMvlh2l9gzTZpjxHaHvNu3L38fidOYh84Nu+1WYiixtOnpIVaiU5b68SFTduArax6EQ7bI7nPaLM1K7IwjPs4IYEasMwJQ6iMlmgyb5S/tLgJBy6z8ASFP0niJ+GeMdJYi6XUKD+EZkb36+ui+G3ednYGJESURE/3zc1n2c7ITdyBcUbG/6rNZxW91dPjXYd42y/W3JkflfL0fapUnwIi/3voNhgNUwbeXR3J3rXjaIQNJfO6a+4sW0VkKgE6yJSUEgbivb8pLm2Zfp2I5lFxwwGEyK2VTvyxAmgvoRhVqrtEI7haanJQYzYznvIbdvi9IBv0CXjTsj7jb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(4326008)(36756003)(5660300002)(1076003)(6916009)(52116002)(6486002)(8936002)(6512007)(38350700002)(38100700002)(6666004)(8676002)(86362001)(66946007)(956004)(478600001)(66476007)(66556008)(16526019)(186003)(2616005)(26005)(6506007)(2906002)(54906003)(316002)(83380400001)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ACpRO1tcIQ5rfyDIcvtT0Vb492gF34k8m9Tuf0qlLrvexn+8ieIsGZ8rIvYN?=
 =?us-ascii?Q?uJ8F0svp3SsPUsLLKClsfuVUNdMHvyP6QSGeezmupRlZrBYY1b/mwM2MCchi?=
 =?us-ascii?Q?l02gwRyFmQGvrDBD1Tx8vFZXbQwAI8RRG5A+Gf6gHYaCgdDcdW6+hq4qv/11?=
 =?us-ascii?Q?gnXjYSZ7VqLXPAW9TwtVy3cHanaT+Tc8O2WlusruyjqC04VsBMEDaxDOMT7j?=
 =?us-ascii?Q?BiVxBYkL9j5IqshY0OEEVQRQ8FdXvNFcsNfF94K0Nx1nhXK9q2Pq+0j9D5og?=
 =?us-ascii?Q?dV1MJdjvBufFMbhT+csRVExm91LKmTrSKsdQfkFriRNI0Igg8KVVi7UqBfjp?=
 =?us-ascii?Q?UKTk39jx99O7UrDAIupPv+FpaOGAZoLzeDhLEvEcqxYBxrlnguDIEXBDH71G?=
 =?us-ascii?Q?Roga/5j20vJRafdeYMKUekVOtaBHDAZsMUDcnUzIHQTWO3HQ/2721mUIpTF2?=
 =?us-ascii?Q?P2BMvVgTgH7igJhaO6fJ0D56GnyodLOo8F4K/1+Qs88gL4xiCVdK5S7Y8ikx?=
 =?us-ascii?Q?xk1YbXWUgGnx4WSKSscG4CBxEBGSF20hR1z2xCB8RyNjaDoVUj7Turcqpml1?=
 =?us-ascii?Q?H/kasw5jbs8IFon2odNBYBTFn5nMojNUvXNSXGbuQCCbYuwFyS2XkArdBDQq?=
 =?us-ascii?Q?9/hWJjw5jKAqdcvPtSfCUz0+KpBg3QOyIao0/EOBBS5Jdjve+arFd9GbL97n?=
 =?us-ascii?Q?fQsIC8aMJdeOr+aHsz9x4c/SQ1FdQKUQXj4xxWM4u7sVOfL5VIji1K7XWMxf?=
 =?us-ascii?Q?UWDEw7taWBIWusH8TMEShjkQeJLuHhfw55fd0viYmSxUmQGomXbN8Ba9wdf7?=
 =?us-ascii?Q?jnE1/bm47eIeY8ulhZDST6j4I8uhFHm8/uF8wKW/nu84gWAl90/jOYPH6B83?=
 =?us-ascii?Q?PIdd+Jb0ta7hrDnvJBBsWNgYAMUlr/14MK7qDhbOArRCTGgmh1HjLGeJQhWL?=
 =?us-ascii?Q?vP09QUPVgJqKKycisLnd5r9UH21zn5wfV3D7Y8mL/f8sxJtShUdlcWktEGSx?=
 =?us-ascii?Q?55hn+eIEC0kiW4XVQxs6FfoH63b6OhgIUTHfPYBKD3oeGsZgFHQayepiEY+H?=
 =?us-ascii?Q?ctP6fYGhqchfQl9egLPZxDDMwa3yhaSkhh5idmJ1IHuq6uD4FJ59H/WdMleV?=
 =?us-ascii?Q?3o9MZEFcvb+jnbTH1cCiVCisXT/MFpiBq/qSXL1kFPCPWhUQfQ6j5+L/nHjB?=
 =?us-ascii?Q?fNFYUQQbyEYXwl/E82xh4KHlw9BHa+BhoBWcCYmA1Uv1VF+iBncKZQ2eP1Y/?=
 =?us-ascii?Q?be9k1Txy97so4iEF3zse2Bz3dcu/Z0DHOPMGN4a5bF53V3hrNG1uXH/aY4zA?=
 =?us-ascii?Q?qcI6mVF8bEXG+OHeqxSBPQS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bde04d66-9504-4d0c-e267-08d925e66fac
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 16:49:49.7585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gxSfoJt+KGMOh0EQkou/25LeVmn11WgOJTQK1NuZdnlwSsvXTuHteVbiOTGoGrRBkvoby0rLgwy6s7XHSLw+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4533
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aaron Liu <aaron.liu@amd.com>

Add below supports:
GFX Coarse Grain Clock Gating(CGCG)
GFX Coarse grain light sleep/deep sleep(CGLS)
GFX Medium Grain Clock Gating(MGCG)
GFX Medium Grain light sleep/deep sleep(MGLS)
GFX Fine Grain Clock Gating(FGCG)
RLC MGLS
CP  MGLS

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index e6ebd53568d9..a605cbfd7fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -1325,7 +1325,15 @@ static int nv_common_early_init(void *handle)
 		adev->external_rev_id = adev->rev_id + 0x46;
 		break;
 	case CHIP_YELLOW_CARP:
-		adev->cg_flags = 0;
+		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
+			AMD_CG_SUPPORT_GFX_MGLS |
+			AMD_CG_SUPPORT_GFX_CGCG |
+			AMD_CG_SUPPORT_GFX_CGLS |
+			AMD_CG_SUPPORT_GFX_3D_CGCG |
+			AMD_CG_SUPPORT_GFX_3D_CGLS |
+			AMD_CG_SUPPORT_GFX_RLC_LS |
+			AMD_CG_SUPPORT_GFX_CP_LS |
+			AMD_CG_SUPPORT_GFX_FGCG;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x01;
 		break;
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
