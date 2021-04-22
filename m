Return-Path: <SRS0=IWiu=JT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81850C43460
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2516861417
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Apr 2021 12:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2516861417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B966EA78;
	Thu, 22 Apr 2021 12:36:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA6516EA6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Apr 2021 12:36:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLI3QZKOALdR+zjrq1usg7Ry8Zm3RHJ9JvaSFFM1k3CuHpVwGVNiZSGkXbh4eWNvqxCSwO3Eu6fsiO0i6QaLl+7dN40qXu8c4CO+JhrmMImFkYRDcH5djiRXI3htmFWYFT1A0uOtXAAWpX+BPsStpdQEQKcrwTWqb0/CBfG5/HEFb1B/TPoP293Vmf/wuBkSMDWAStPwAq1CMaPRr2fC7Pmn5chqaStSU3FkBv4Cx4Ccn4fzJwwNsEXUuaB02aYHmH7LxvTYveWqjOQz5I2yDQ5Wrw0iAAkZWzM1oqZLg8V2ntMc4AAGPU+Ep1GaDFVbF7kc4BqTZdJi2Z55NjdCZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT4RnS/j5fw9LL0BHYB//ggeIJJFP3ncGQUPZRUryHM=;
 b=KzQI5erW5MZ65uICYfX1cLIw73469E94nSWpjTZSlxlrv0faQzFLVEkp5Hcdtusw3ULIzmqy5YAEJsqd8dkywWco/cNif+7eB1+64Rucr6Oy3fTKk1NgN4fKwtfz8+ggyG63LNMP8+ZrnUnHqlbGkini8/8o5tiZfYFS53wMkL7nDDQ1EIL5AQSBYLjwaSqyXtLvXi2ex4mvE51RVS4sTbNKdTUO+iDFzpQENanC/ZX1bqWqDA1Pqlhc5o/xfUHONBB2yocxaVV5eTxMKnCValjizBTUG582TLyDHfrcnbOz7hTG3v57sPWWPXspvj8rmLpk9YhNCjvCtAKeUtx4OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT4RnS/j5fw9LL0BHYB//ggeIJJFP3ncGQUPZRUryHM=;
 b=DDDzH5o1yhYr7uMIspsuiUM5FigRm68T2sWbEvgNAL7ZP2s3RdToeuYfPfVYxAP2x6t9UeOycv67NW1xB1kKD5npRHxYCSssGFvvOYXuLghj7ts+nDDhB0PAheScJu6kLfcs3K6oo9Ur/R8bPeHVAtAl2EqIICejBxHUVf5b5t0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0231.namprd12.prod.outlook.com (2603:10b6:910:24::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Thu, 22 Apr
 2021 12:36:17 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 12:36:17 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_create()
Date: Thu, 22 Apr 2021 14:35:44 +0200
Message-Id: <20210422123545.2389-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210422123545.2389-1-nirmoy.das@amd.com>
References: <20210422123545.2389-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.127.111]
X-ClientProxiedBy: AM8P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::13) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.127.111) by
 AM8P190CA0008.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20 via Frontend Transport; Thu, 22 Apr 2021 12:36:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1ef93b7-01d9-4c11-db68-08d9058b3996
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0231F1719E6C1BC8FDF6A04A8B469@CY4PR1201MB0231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vNi5oIj7R6V+y6z6LZGTmaInJlX84+xSoVEllLIYnCmbVwwCnsxLjvkIcNHVQLJe52YV80IyMIvxyu7byT9EwLwKvcAGP7qtgijg3tmYkFJ72l8se2OHPxLO2mZ9ewtFqBf1D5R4LsqbND3l7KVyyruB4rCp7WrJ4KHUQFW5cv+rCor7BJYCBnJTqSbDsdwpC/D/pThAQ2WbCRroVPtO5yMOiqw0stE2xoH9EJIBcdtoO5H416DJ1P2wdPzy/2hE4UYaaxUS6GEWR77EQKa+a55GvEPhNbZV0E2PWB4x9SNikpCmYBUM+GuxhOe6dz6gkEMoxWIiXm50TAvzjZvgQpxcIlBN/Q+xhYxLbWdxTovAZNCiMcUC9mTMSQsnR3PyI7BSs58vb1rZZ+DRR4b/smc3EBmz5RMAJqRo+xvBTbwEDmLDyjq20Gtmm/18I1VC3bLN+H/rur26d+1/srL5h25QgAGZj7+eagM6hNUO59bygAxF+x4w6Wtd4Z8e3M6elJHHYT/9hKGnMMa4Frf8OODr9fPdJwBO+EkFpwhOWDJDygSdFLuzgocIyMwwnlsJRheOQXS/mAFtHvj0Dsf1iZOnpuBPYsZSIHH87MoNXNzPM8oExmkwDygjU6OPU7titPRghnKrEWFE8tF1xnTwnTtrx0lsBtO3OYYcICU9svQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39840400004)(376002)(136003)(396003)(346002)(52116002)(2906002)(26005)(38100700002)(44832011)(37006003)(1076003)(16526019)(38350700002)(36756003)(6506007)(6666004)(6512007)(8676002)(956004)(5660300002)(83380400001)(186003)(2616005)(6486002)(4326008)(6636002)(34206002)(86362001)(66946007)(316002)(66556008)(66476007)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3RNrVf4DKb+5DYk+K2JOMKbW6ogudEf9r5c+yBhIqZOtojFdryJ4LdrPC7hg?=
 =?us-ascii?Q?uSBuXgur6Oq5Xe2coinlCvJItj+Ot90i1bBEh+1mNpc78DB/ykNo/FM9aCDa?=
 =?us-ascii?Q?/ZNgm38KClV1TIRm//+ZtZN9v7m53hGnsT927U86GLamLcwfhGYSihYHYtYK?=
 =?us-ascii?Q?yJNwfMIAoL32Mn6qBHQ9RgUjCau7dyO53yLQBDpf/QFWJrc7H4ulChUltIVx?=
 =?us-ascii?Q?oa32PLyyvQnewj/2w5q2nk+5lRPpqhiKHwonZT3ehap8CFXJZO/+Glg6jSn/?=
 =?us-ascii?Q?CEtCUn//QzKjKDg4WUAokWVr+QxYR9Iv+U/7PwiNX6A4Z+jw580hGLx/NPew?=
 =?us-ascii?Q?AXXBwu7bTsaRa4uF4tSe4ZGkxs8HlufybYtLSjryaLrEcaLpb1wR++jI5JR8?=
 =?us-ascii?Q?FmUO5vICJQMlPE3kBHb5jyjPi6OsI9WtGqhpbgIDRdXTdmBrJUFM7mkpZg8y?=
 =?us-ascii?Q?YPlC/U8WD88/OVXg5SsJR+n1hsOTO9tCoehCl+t5lbdkGMKoD4xZv76Pb3HY?=
 =?us-ascii?Q?7hywSEjr9IwQHAL6f9fMOzYnHxwr5CKQllUbD6Tals4h9P5eIJjbvCox0qzZ?=
 =?us-ascii?Q?WFw33etbMf53e5pMuI70JxiuDe+RGCIKOWXC6D5xsquYQKYhnJ/8G/0GumI3?=
 =?us-ascii?Q?US7f5okfKRTu3qLH0+PdaQ0wklJltaotwCzkBQLpfZInKcImcKP94oarM9DD?=
 =?us-ascii?Q?DiECfHafgicYsX5HEO/0hAIIIcS4f1Cr96h/IYO1whB7o4idQ4xl/6NX5Nly?=
 =?us-ascii?Q?dM+FMfqylU8ERFLe9RwfSlsYCB+XNSOW331oG0ODW+Jb7pSks1icy9vZ1kli?=
 =?us-ascii?Q?mI7aNApsOoCvQkjUJmrMNIO39e8Y6hRlOw2cFTA4GQAV6OTLA52ijY2ZihBN?=
 =?us-ascii?Q?FggEVHBVPtWRlaolzU9FtLJcMS/7Fz2Yzc1tBMr1nkpAV5zrQzavIECZQD9h?=
 =?us-ascii?Q?h+Vqwn+qmpEjI2o68VrgarxBhihss5qyiE3M00aIUKITiUXwXWCiIfjIRwGL?=
 =?us-ascii?Q?5Bs28zyTLcaQqSUTWbzW/FQqOxQf7P1zcaj/giC4ThSeOM8+Ee5SD8wAeuYr?=
 =?us-ascii?Q?B6YJWJmbWq6Ui9QyXFmFp4sFOILxafXEIikttfiBpa3hbE1uLGFQkU62/CtT?=
 =?us-ascii?Q?Ic2wLVuorSG6roLNbiQ3iIZ7d4DntoUREprZVDEoBW9lYHChHJtBcETMjA8I?=
 =?us-ascii?Q?sZqIkkEzZ0GcpJ3esPymZDnI49jf9yzT+yJOdrRgxYlcMelaOMLWvR8GoZDm?=
 =?us-ascii?Q?/7boedc40ujbMSRhN3nWL7xwxGH+t1d0NDplfPwexocmeB24ChLiwY5Dfxi1?=
 =?us-ascii?Q?sn5yo+r5PvvDuK0dZ6apWyK2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1ef93b7-01d9-4c11-db68-08d9058b3996
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 12:36:17.5786 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wiv4f6no3q669J+z0KqTqx8+TNckTo44CTwdG51asqDUUXC7QDYD/ygc9kVrvVx3QGkp7nx72etRh5jDJFNkcQ==
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

Remove shadow bo related code as vm code is creating shadow bo
using proper API.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 30 ++--------------------
 1 file changed, 2 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 9cdeb20fb6cd..4256cbfec5eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -661,10 +661,7 @@ int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
  * @bp: parameters to be used for the buffer object
  * @bo_ptr: pointer to the buffer object pointer
  *
- * Creates an &amdgpu_bo buffer object; and if requested, also creates a
- * shadow object.
- * Shadow object is used to backup the original buffer object, and is always
- * in GTT.
+ * Creates an &amdgpu_bo buffer object.
  *
  * Returns:
  * 0 for success or a negative error code on failure.
@@ -673,30 +670,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		     struct amdgpu_bo_param *bp,
 		     struct amdgpu_bo **bo_ptr)
 {
-	u64 flags = bp->flags;
-	int r;
-
-	bp->flags = bp->flags & ~AMDGPU_GEM_CREATE_SHADOW;
-
-	r = amdgpu_bo_do_create(adev, bp, bo_ptr);
-	if (r)
-		return r;
-
-	if ((flags & AMDGPU_GEM_CREATE_SHADOW) && !(adev->flags & AMD_IS_APU)) {
-		if (!bp->resv)
-			WARN_ON(dma_resv_lock((*bo_ptr)->tbo.base.resv,
-							NULL));
-
-		r = amdgpu_bo_create_shadow(adev, bp->size, *bo_ptr);
-
-		if (!bp->resv)
-			dma_resv_unlock((*bo_ptr)->tbo.base.resv);
-
-		if (r)
-			amdgpu_bo_unref(bo_ptr);
-	}
-
-	return r;
+	return  amdgpu_bo_do_create(adev, bp, bo_ptr);
 }
 
 /**
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
