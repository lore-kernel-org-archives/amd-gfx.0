Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463ADC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 22:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B0064F4A
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 22:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B0064F4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9668E6E890;
	Thu, 25 Feb 2021 22:23:35 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770043.outbound.protection.outlook.com [40.107.77.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0021F6E890
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 22:23:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMSiij/dfitwgbEFBbScBEAEOGis1VXt5R5oeOURyYEdBIZNlo7lYsZy2FqYg8xW78f1RsBSBl+TcndpuR/VKAUwoSLR64a7GJ3OOftE9nMVmekjMma4rJNwJUtZUsEDe6CcfNDxZCTsENld4JQad0bpe5O3wLKO8N6aZaNv6hD8HpSayV9ZL5ZCVkfRfNdFUUjRZnWMMDdPLCuUi8O9sLz2O+v7YwO2+J0SQiDaUD0g6Iyeewo8DcQRTCyuglflPdiwITDnfy8Pewu1Hh0GrloGiuAg3//MUjUx/DZ23YjvAalRu7OD6LSJDeIqfZKKq5TDgPpOLMv8+OHKr8O1ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6OpkaUwOINT+0KDKqd6KE7e9yf0jwXU5BuInhGBf1c=;
 b=HiS3f48yPTrOBoG2LRPR4f6V4/3bluxwX1VStp6etXq+MVXkrf+v+OTzdfFNJb44RawIndF5LxeVqO960SOJaH0g1EU2RUHox/mIgTCy+Tx5XkN0k7iV7QrWi6zR3F34FxG8FpOg70eKiOBTCRQ1m7mLNoyt3hlwyzmm4AH8/zbpnL2bhbx9IcoQRrCt5Rl7GDwB8ZqMeHST/szhVtlJyH2Z1S6+RQXWK1eTBWCSXAUCJAnSePfUD4nIzlY/fLzfYAO3skk9MC7LVogXwsToyk9T+3e9L0nBv3tQxmMOsI5ilW0p22wciFYijK6CL5hCq3rALVaXJGx/OuQ/BqZ+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6OpkaUwOINT+0KDKqd6KE7e9yf0jwXU5BuInhGBf1c=;
 b=49Apik9MiwK/zHx3gv0HBfONywFtjS5rwAEYO0Tj1k2ukewpZnYs0ZpPkQ2MB7beIYoq8IdWA+STDtEWWiCw+y3J0Ov8T8lkRxN4WnHEw5ir7GNjsPXbQbfWv0MwHvM3PHLkfIcMVd43wVOaek7HDDHnV4igwFyOTQFDi1/LJZk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4471.namprd12.prod.outlook.com (2603:10b6:208:26f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 22:23:30 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 22:23:30 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: remove unused variables
Date: Thu, 25 Feb 2021 17:23:10 -0500
Message-Id: <20210225222310.1157977-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tr4.amd.com (165.204.84.11) by
 BL1PR13CA0022.namprd13.prod.outlook.com (2603:10b6:208:256::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend
 Transport; Thu, 25 Feb 2021 22:23:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2b5541a-9328-4d95-ad68-08d8d9dbfa81
X-MS-TrafficTypeDiagnostic: MN2PR12MB4471:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4471168C3FFD0C757070F81CF79E9@MN2PR12MB4471.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5fBWAx/Jl7IRcfOyp/PJgOzKyFXIbmWHyyKJX2iQU1M4w9G85PIHHzyBFmZ6R4H0K5G2JYv70aSLYX86UmTt6W+8o9pGgEOfGSF0lmELvZbJGZRWXMYWUnV3fgKidFZcFBGpWwWdHqQvXLVhPqBcgTN9QlUQwTqOWZO3Is6aBAmrwcTEoLn4ow+fZXuS1Las9+X7VnMyGEboaomX6Y3VYIWjA+gTuX1WDPIEB0541MgKO82aV73dzt0/8aIYA1S/c4pKWpnNU8T0N2BgM3n5Vrmq7Ijn2UqY2u22ekLB+HlAf1ej1mq7HkW2cbMiz+KdKo3sx+DjRDveU4/VZFSDzidQmpRx3JBoaFYwJwBizVmvH5OvpvmyASHULEMB70B21h4LlrilqeKGB2nvlf0WM5/EWPvtwU+3Oa7onpyak9ZvsQqAXbWL+B+o3BSRBO/N68J0I62e2jyPELiEI5uraTlRqpquyiiqdSto3NtrssBNKCatJ8i3AgQHw50n//cH/K7+exviGtpn3zbv0BgeZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(2616005)(956004)(26005)(316002)(86362001)(66556008)(6486002)(52116002)(8936002)(66476007)(54906003)(66946007)(7696005)(16526019)(2906002)(186003)(83380400001)(4744005)(6666004)(6916009)(1076003)(36756003)(8676002)(5660300002)(4326008)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZXnU5D1RjSdmUcQIeoCt6dEL9BYJrhlRU1O7Vvd4Nmx4BAS5RGbJEoGhpUKa?=
 =?us-ascii?Q?XvhDfGB00Y0V0KnYWY7on54omhB2f+eqLYudFfaWNQ5VjadKiSQA5IO1OU+h?=
 =?us-ascii?Q?9MkD0HsrXrpQIpsdpJt5AUxKX+Vlo/VcWJcPHBF0ELk8ZwqBIMBY28HKgd8I?=
 =?us-ascii?Q?Sm0nm+IwBWZV1Ir6LyyULJwmhNeRhHGlE2px4X3p0778/k7W2ZsIGLSP+moW?=
 =?us-ascii?Q?QvoSHKPIC1q+2bllmErvYiMvqx4E+Y/yhPPv5/69rGx0UN3a8VX8HkzU2wIm?=
 =?us-ascii?Q?5GJ/kAq+uSAuy8bWlKDmsiFgZCQyJk8f6P6lBkazpeFzYAKIPEUyMV+SS5qR?=
 =?us-ascii?Q?H01AogNB2wINHfReYmVKwCf888aYb4HalO6kYX+bVWW6cz2WaFddBSQUVutu?=
 =?us-ascii?Q?3XkYyjszt9/6yrykZzh8SZkzXREBlOF6tSQdKXpTtHsS5IXrPDaj8JyDcjjH?=
 =?us-ascii?Q?gWaajOzkgipNOIDGRg/HgBkPKJViyarl0a4Ar2itjbafi3NnmUOY2C4YTT8o?=
 =?us-ascii?Q?KInCzsYQ4YzAepRWN6ad/U9iXSc4eYo6MQUQaRYT0JVGiBNyvOFlxSVMDn+P?=
 =?us-ascii?Q?0sGZ+LZveR6/9tj04GjzFmm2aQoFQkDB5kIAV+Pf7gWnr1mE3bWdubLU86ze?=
 =?us-ascii?Q?zFiplZCy7m2kdRPEYGOZXYv/KlgSqVsP9xxLt2TdFRJ9EsesYwpXrla5JTjK?=
 =?us-ascii?Q?T34DcGBmymF/XzhjNnuwkBinOeQ1h90hkFmfJ1QhvOcaIPowl+Bud1kxk3cg?=
 =?us-ascii?Q?I+MG+oY7jSCVp1N4IEiGm02avFh2L/VTGIt6kSksoKJPwoiL0vJMl2oOZdKc?=
 =?us-ascii?Q?SlJu75ntO4QN1kXJ2Ta1xGX22a4lp5opu5hyKYsnUeSI6QJVtdJZRkq+8OwO?=
 =?us-ascii?Q?UyOblhO7fexUwndPDfw1ND8wM9HywC11ihmZXPu6Zz9CRYGddDz/+RNhfFAI?=
 =?us-ascii?Q?onRJ8DEfS/ym78FzWNxtdrrdT+ItrVHaWA6wvZ1bIFjONm999pisiNH3alGW?=
 =?us-ascii?Q?URA+L6CPEPpaLxYFya9rHJpy56hBPednjBSAsbDGqkBvAKW/R531IggNTc86?=
 =?us-ascii?Q?vHBY0RojmiQOeZWiPKsLtvtrjBsqAb0Yw9v8oeKBDkOHrBvxTNfLk6Rjfxtt?=
 =?us-ascii?Q?TxP+9deFRXsx1OB+XbBlbttlLumoShW7JzkJUq2ca+GA/JLtK7qVAh64hWXo?=
 =?us-ascii?Q?S8FWqggbI8pAKjAMwYpbNkO2OVau19z23L9E0PsYn05HsVmyBpQvQH2dJocN?=
 =?us-ascii?Q?86hvl7ks/Go4I0LpBCN1Z6A/bwqtE0HP98jlj9orpimGu9euX3yy6F5uqJ8D?=
 =?us-ascii?Q?137budoOQXMsbiUFq1nW7Joo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b5541a-9328-4d95-ad68-08d8d9dbfa81
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 22:23:30.0267 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IklqkJUngo2rmuJe8kJkC87VurrSO8Tle/Si3zUj4bPRfn122Glps8NapapN8X4CQq58uK8zcBEO45AzBAjtpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4471
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
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Not used so remove them.

Fixes: d2d0c920a127 ("drm/amdgpu: Remove amdgpu_device arg from free_sgt api")
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e83d73ec0e9d..5ec6556ebf7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -356,10 +356,6 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
-	struct dma_buf *dma_buf = attach->dmabuf;
-	struct drm_gem_object *obj = dma_buf->priv;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-
 	if (sgt->sgl->page_link) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
