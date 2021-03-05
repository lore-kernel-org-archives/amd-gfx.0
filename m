Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCFFC433E9
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8B464F4C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 14:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8B464F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F4B26EB9A;
	Fri,  5 Mar 2021 14:35:54 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E9A6EB8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 14:35:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dh10inyEYN3fkif/O3sajyIPeC98dJnZdI/oJJ78wdxulbGWEHrvckv+4bBuV1DKz2iQxhOI8Xdg0U0VCaNzcbyIYnKyAmQzsipafENvviZe7aP5Q8lIHvrH+GcG6YeEs7ZUX9+qsn4irbwhhGlTSDfPgVKaO+8a2HI/s7z97l+7WKSsRDayJvc3GD+8HUC9hj8uONG4PlADeBFSckXn8ysoY4JMHchdiaWRT8ahS2RW0Y+6U9C7PiMJeUG8boqwqQDwr1GODAsw8hf8u2urBDcBcc7jkr4uyNRrrjFkTV+XnC9GWR713DKvLAjPu7Zh6zV+lPEsui5yPuRRkizyXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueknaKJM6I9jqM1ohBqzM62uUf2HwqF8x3pf7312buo=;
 b=RKaradXovXCV6veFPvw48pMn4Iq4KHgokL5n1/wY8O1UweEkfJwmNxA3vrM53N01FMt/UXokbQp08tdW62Yi7z00ZelCwUamBgChQAFxhFgHmBoZtYup80AjKMWblU/gR0LzGskkYeImhtKK8HCFWrjo4dx084KoN1Qjv2hrEMaCcifkxdkNjswfkEw0liK41LYUvNxbb62cJjndlbib2SK9eTq3dFZcEYi7hchhXqGz3GPMNiE4qU1UfkSOKVyzD/TDKloppqfRl3azS0qxZjad1YZo/XsC27XYpgYXMrtAEnc5jpTx4Ki7eHl+F27DTSfZvoX1ZQ8ypQeJBvQUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueknaKJM6I9jqM1ohBqzM62uUf2HwqF8x3pf7312buo=;
 b=cboOkMD30Ehmhf+Jz0D3twdqCDZi00btbuavM4Gtl9FDEleBCx5HJsdpDE5IF5gCR+eJAjDoXvC1EgEvmna3OZQlgvuLAL7v5zxuGvucSzkZTmPDDsyu+18jRSbIJ0iAniRxHIcR/uf3wwlJrV6Trbpm6/qwTztumhKnyQ3+sRY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Fri, 5 Mar
 2021 14:35:48 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 14:35:47 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/5] drm/amdgpu: allow variable BO struct creation
Date: Fri,  5 Mar 2021 15:35:28 +0100
Message-Id: <20210305143532.5936-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: AM0PR04CA0038.eurprd04.prod.outlook.com
 (2603:10a6:208:1::15) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 AM0PR04CA0038.eurprd04.prod.outlook.com (2603:10a6:208:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Fri, 5 Mar 2021 14:35:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fe009620-a5ad-4fe6-7552-08d8dfe3f76d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18453BBD0051CE61B0F8FC8A8B969@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8nB8RQsnsHnFC+KvJzlCyClkTiAZ7CuklUp/Z/FXLboQ1d4oReKLPZsyE35WDkE1CkO9tq4XFi4ST91Y9rh+QEsak+aC1oesKSncrGYNEKUjQ48tiblHEErA0lVvTr9+/cfAXJSDz7Ft2DP/Kcu76tVwQf2yyBa7IjIa8+ail14B5LUk6PhSgGqsb8JhlEOx3VCTQ3d6cuWfFpWxCaCLyN7EICc/eZGgyzJdF5Tcj7QpNkeSd/EdDbAGVVj+1sEiOmp70f+1Cmi2a09DKWrPmayjxD+9bW0r0OAUJ1O0SttjPiyhLFGraBJ36NOaNooXgDviClEloSXX4VzFIJr+aJlleGvdo3xze21nHWGfmgfiWZMSFcd3919xZKDkfqwsCYB1aLvbhR+Bm3qeAcQMQlWnFQ1K4YOLud+bGTuGeNyYM35lLprEBrAOrmyhr8hDtpqb5AxvPKJfnkBZzbaFl3Uy+sNKmsC0W+UnZ2GAzhqCoQVdU+5s/jj6j2pN2R6kgcb7WfvVr9VQsEm+HOsgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39860400002)(44832011)(8676002)(2616005)(6636002)(16526019)(6666004)(26005)(956004)(6512007)(4326008)(37006003)(66556008)(66946007)(186003)(5660300002)(6506007)(86362001)(8936002)(34206002)(6486002)(316002)(1076003)(52116002)(66476007)(2906002)(36756003)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sBgUNUcBYNiY5Hhtz3QAGwEX3nxgiZ8JenTp5O53a3iBixcbOC4KSn7jMG3o?=
 =?us-ascii?Q?yGYo0HcXfBJ96b3HkArwwK+i0NHRAfT/TgsbwOMlFt1chjaTcdad0k+DwWBT?=
 =?us-ascii?Q?p1Fq0cTXBTfyi4HYjmv0OguxQLr1T2wrAsuWOlDO2vEoWJUoE4IrmoAo+YaQ?=
 =?us-ascii?Q?dlvnFov7lZTYU2KHXAtMLLPyKn+cIHA8SzQin0NtpuXDovEKerEtTaQyYjhF?=
 =?us-ascii?Q?rhmQ0XRmb39Gf/d1pw0ngHN/Sjf48vRX1DWZU54Ta7A/o0XKBwG0b656FzCB?=
 =?us-ascii?Q?4f3Iw6StZa6E9YcPnoHBz0A+MXzICOYurpFZ41yDRqdXSmeR1/Rs8QAbk5/t?=
 =?us-ascii?Q?S3FWeYb/tZWVhQKGzUbroT5a0gyq4HU6C8lbJd+m7oBORxGidNMjnca4stht?=
 =?us-ascii?Q?ATVFRGS0sJ/bie1AA6PVLX28ePhxuqlVDkcW7ealFk8a48jRHrHaOVjWltXo?=
 =?us-ascii?Q?tWup4Y5vsTJkOH1fjRMa8UarFgOSeHecAiu9sNxmrtT/Ux5Rc3kCpxGcBQUz?=
 =?us-ascii?Q?DuSMnjmKIVOKq1MJWBIkFu9Qw2xFHs4+tFSu7SE30hK7z55nOjXDsy2ozYfg?=
 =?us-ascii?Q?Yf33NZ50/UeEN8MandiU74nkWCvNwc4AcU4a2WfLzhjYOhqwb7dMPoSE2BNj?=
 =?us-ascii?Q?mLJKrwYJbyVisffHviSqb+3Y+Lf33H+rVNiwToDTg+ZlOlG9wLAR40U1Y1Kh?=
 =?us-ascii?Q?5cC9nZ42KgsCbxa2nZEbrpYE6+6Mj0ZgD+s+z7ecP1zQqN4jaW0LTKmYnYeD?=
 =?us-ascii?Q?+OWGpzBDqSmRntvxG5103klTKV3XmnLT1k/owdqxlJ+y0RS24yobRdG7ZWR2?=
 =?us-ascii?Q?PrSxMNACpJtgEk7XrM/crrDLRF5+5IGDSdcj7Mr0s4QqFJUVpazEfxVobicZ?=
 =?us-ascii?Q?bDbBk7XnPC6Th8N/Y8IcuMthxFoPgk74Z1sERvdPyYngqNQjDGSTbY6bgCat?=
 =?us-ascii?Q?hyzNXaSVJ344GCN/kVKNOVq0gwY2WSv2K+fKs1bhdyMBDF6/xsmxGnFhBbcw?=
 =?us-ascii?Q?3NOAbnySS3VNr6Pmxiu9g7FWxU0VgFMoi+VE67mLjBjABMDVdga8eSzYgRLa?=
 =?us-ascii?Q?A9cmW4rsu4tiKkVR5fX/hh+2CdB7BA1F17hY9ZndUql1V2Up3agLyYuJax4H?=
 =?us-ascii?Q?CBSobUI/oVfsxZp63v6iffsm1/ANZES5w2pfedGoSVSweE8wHvDnDqdCwuhp?=
 =?us-ascii?Q?ZrZ4l8OQLHpo5Jkz5gvhMnDO0BqVr71J7zRoTiJzVJfbOfX7OlFxhJjhFklp?=
 =?us-ascii?Q?9rdkRd9K6y1RdcURT+GYOSAcV+5v++sDr7KjcXxEZdn+ACsFcgaKf/muUFey?=
 =?us-ascii?Q?klPAs+aIbu7p88ui7e9rjZVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe009620-a5ad-4fe6-7552-08d8dfe3f76d
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 14:35:47.8769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfGPIZ6vd42KMGkgmcdSih+ffjBzvx2QggMaCrVK4GT9JHyQR+JQYRXay0Coh4KBL1qFEdH5cBQLV3042UnKCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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

Allow allocating BO structures with different structure size
than struct amdgpu_bo.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 0bd22ed1dacf..745393472564 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -551,6 +551,8 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 
 	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
 				       sizeof(struct amdgpu_bo));
+	if (bp->bo_ptr_size < sizeof(struct amdgpu_bo))
+		bp->bo_ptr_size = sizeof(struct amdgpu_bo);
 
 	bo = kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
 	if (bo == NULL)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 8cd96c9330dd..848dc0a017dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -40,6 +40,7 @@
 struct amdgpu_bo_param {
 	unsigned long			size;
 	int				byte_align;
+	u32				bo_ptr_size;
 	u32				domain;
 	u32				preferred_domain;
 	u64				flags;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
