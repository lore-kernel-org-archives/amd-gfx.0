Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E123C2B9F7
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:22:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E53B361443
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 10:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E53B361443
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD906EC50;
	Wed, 26 May 2021 10:22:06 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 345DD6EC50
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 10:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lCT5lKwpMXZJR9yq5Cp05VCiSajH/nGHFm6FcQiw6prRic3MwuzCvPHkZ4P+7l74PJP2pKNl8XmIEJGyfrR4kX3ah14W+HabNB8vyM0lBDIJjJBAGHXMNBlYR2tgqZIX4ZVi28ZQeh/A0aea4l3MGLJkUxGCUHrB02Y0uFrHnnM96J75Ew8ii6u0ZqI1mMrEBZ7z+SBBzIN5U+XA3XFVRybTX7BF6zEZQ60ERpqyWqSawqyhZrc77+/dkCA8kbWJzaFd9ufK/pcI4Br7M0rF7OXx+/Qgre4weDZA07pCsLaGWI/FCmLh7O/glTWlD4aBrJFj4si1BoHUClQP+b7URg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ2D9v3d0bDZlv5KnnBxQ8y14tHK7XaF+a+C7DMlz6c=;
 b=XHPPZ7bu5RZKIAj2D39mIWO4btVNiBDL5GmKqkYDrsGwMS2zlw5tks9iukqOJQRj/1N9pbKaFK5q7xZK2G/oWXXuZkAF10mMhS0PbbyEakrSOL/adEbpTJ2TJGpnNpVqH4TQLo5H7WDuMPQ9B8DmUxpM72Ei6wwHeP96JN6lQFoP7l6OkdmeTEirTOjCZCom25jC/T0jR4l/XlWfwi+34dq2gRT0LGarTl/7WgTEVhLQB7UYIEl4x3nEuhYOXm9/63+wTUYpKfizcA+8kdiu7YRd8Jvo0AvyUVkJJQkd4l5KG7Q5Ma3qIhCJkm9z5kQ8k+zqCfHgAtFUjP21hp2sdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ2D9v3d0bDZlv5KnnBxQ8y14tHK7XaF+a+C7DMlz6c=;
 b=Z+DSqU8alunMkC3mI149/fA9DMZwdR6ObV5INMepF+7stcFG/dZQq2biJTVs8eAd9FYs+BVcu+3L2aRbN6ORaal6kaRlvTMjf35C6p94PfkP9c97nx7RFwgEWPBP+DpBYfZhqcydFBQ91u658SzoXIw2C/n6UWccbUorv/iq/fc=
Received: from MN2PR12MB3839.namprd12.prod.outlook.com (2603:10b6:208:168::22)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Wed, 26 May
 2021 10:22:02 +0000
Received: from MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c]) by MN2PR12MB3839.namprd12.prod.outlook.com
 ([fe80::c14f:8ae9:c5fd:212c%5]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 10:22:02 +0000
From: "Sundararaju, Sathishkumar" <Sathishkumar.Sundararaju@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu/acpi: fix typo in ATCS handling
Thread-Topic: [PATCH 1/2] drm/amdgpu/acpi: fix typo in ATCS handling
Thread-Index: AQHXUd5vPvambmhsLkyAaiaUqFZeOKr1T/oQ
Date: Wed, 26 May 2021 10:22:02 +0000
Message-ID: <MN2PR12MB3839C0425423717DE2DC916D9D249@MN2PR12MB3839.namprd12.prod.outlook.com>
References: <20210526032233.1260674-1-alexander.deucher@amd.com>
In-Reply-To: <20210526032233.1260674-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-26T10:21:24Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=a752db95-a47b-490c-a8f8-6bea4477a872;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.37.171.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 377b8eb9-ab1f-4059-1354-08d920301a61
x-ms-traffictypediagnostic: MN2PR12MB4565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4565686417BEFF17EAEE96B99D249@MN2PR12MB4565.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:42;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yasC7g0UiKR7XGq8dZPqR7dZBuH5t/pVrFCtehM2Q3wl0XnnfrgE4EXaQqWEhCM+iVH5NBqlkUzVreroyAlJf6EeZfPkhJ1oa+nocLklo/BB0WiTkvVHIEVlQD0YsF7H3Ha5X0csxMCptC7aZw5a000VXgBLxVT7/vHVGRBOg4Oz4FQ9SEMgqFPzMBldgud1aTkDDZqSuEhQwOJU8NTYxmv0qTw5U5MEObaGJEr1svWHBGeYZbjtz/2nVpV3jDX2oFCr0qavApbFrcodEKbrYcBQnsEyz6ILjqWjLM5KfMjTvdr1X73b4VwciX0DlruoWmSxuFGt3fGrmobpTNbQc86b8s43SKP0FPpApBAF3V1BqhCVdVPzQ/e5Ir4DvcUqQlxwnvoOL24OdzR+zNApAdNv10lZnlKpcIS/uwj/dHEGBieuQqYKN37/hFmugoJ+V5iWbGP/pVAGy6wAYePrE9MuzOKw1QExzKAjK7dZGpSlk27lDElOIO3zBLC1a5sF70dksdbct2fzROQujT6vBEX1f+wk0Jv9xwEcESMxCA0kaYgnLjV9BHtwjpngwCR2Z40EQ9zmOcQjqQmDWqsRBycbVL9KDRiWwO/i4UWKblxScJn1sMY24+f6zoEoQf90
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3839.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(8936002)(55016002)(76116006)(86362001)(122000001)(83380400001)(110136005)(186003)(45080400002)(2906002)(66946007)(478600001)(52536014)(66476007)(66556008)(64756008)(33656002)(38100700002)(7696005)(66446008)(26005)(316002)(53546011)(71200400001)(966005)(8676002)(9686003)(5660300002)(4326008)(6506007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bgckWFSZJ6fnap7EGBDXlBQIlDZEZT3w87n8hikEiljYzMw1Mu0YdM2HOmAq?=
 =?us-ascii?Q?0zkMqvvQ+jU+o3k2sFs3cNvq58tyZ+G6WcBryVubTuhzd8aB7/UFbeodPJEv?=
 =?us-ascii?Q?ySb6z8wv6/dKGr7In+XeKsQnAbtpWUgpPkGTqKB2IFutQNCyjrZqOYdAVc8L?=
 =?us-ascii?Q?v8dTJATvQhxnOOYO5bnS/9XpPb1Z6SXzMFJrbIQSrBPLx7nFsznaiNx6TEVV?=
 =?us-ascii?Q?K9axVVjIwCJAqPWN/jbsw8yOvFOYCqecyLlyCfyLGHXHRFC6VDtH7wd4/vQF?=
 =?us-ascii?Q?Rkvcjc4hkaNCK/bNq3ZK1gMDs9LIsN8EUl82acD7uh9JnMm8GNO7I4zUMoHY?=
 =?us-ascii?Q?WDncJqoJyxuKmt2ccOkrCpx7Tchrwtw6gSeRe6lylAsM0ewwaC854I4Qb7Wb?=
 =?us-ascii?Q?vpfaObZPSwWFgJFtYiD2EgJkWfNRy5m4nr3o7G3q8bo76+S909vF8+I1QZ4k?=
 =?us-ascii?Q?Fm+TvfTdhvNEGynYD6+OZR4FnILb40o4Uh4Cu3qudmQLOn4K6lGRBdeHg+Pm?=
 =?us-ascii?Q?XRWaeatYY4CFmq+lU+o0sTI7EGXOWXcUiaaccKcOnYDCO3QAuqBi5ybbZp9r?=
 =?us-ascii?Q?ceAODN6wKbR3Z8yU/5l/LwAmjmx1BrpADvOsdW/4Xyk9Vtk04Cu+liVJvjp2?=
 =?us-ascii?Q?bFK2F/iMmKgKLFivavxFDJOoyrzuaZFUXmJTsVu0vCCDcocmVATmUrE4nuc2?=
 =?us-ascii?Q?FWb9buWXI3ZK+zGPE/cBhJnsjQ2nUTfqZknvjIYxdD5rpm4Ir7C0h0gvAEnZ?=
 =?us-ascii?Q?x4ZSX4UFY3k+FF38kfWPimyuj0H17ZTLtiZuEffnLZ2L/poADSFKd4MXauBG?=
 =?us-ascii?Q?4FrZzYmGCQzThSYnaQCq5+j6aO49bxU4agtTYCdMmyr8VKFG3+LvxxwN73kw?=
 =?us-ascii?Q?te6PxUz2M4BoZ5bXQU81Anu+pNTrIZD5tQ6vQG/6n7OyaWNrzFt+b0gBA5sB?=
 =?us-ascii?Q?mDy4t2DgJpGvTHk5a8YXTT9Dtu5YnBfaxEBOTksmEvbWgPB+/UsjDnB+u0Nd?=
 =?us-ascii?Q?fOhZYX/DDeBfor9JTp6N+pMUCgFibx89NkeBjEGPeHuycE2mVV1521ZbDSqW?=
 =?us-ascii?Q?lLHUUbSWDrt4TRynR0HNarYvYj9P462amgmkywtaeBRZ33tYrps0e+l7wbsH?=
 =?us-ascii?Q?kAIyjYWUzkEbFBg0EuHKbhCQ0CmQ275vV1DlbYkbKYcyJJJP3uSnzbQl/XQa?=
 =?us-ascii?Q?QSkrKRHFYsPnmJ6cso9GUA++UyW36fKfZyOEnVru+vcOZ4+uIIPfAaFM6hu1?=
 =?us-ascii?Q?T4s5NEuvAwqXwgPOOE9+HVcB6ORPse7SMXG+dA73iVIQRhrvKzcPCMjbROE7?=
 =?us-ascii?Q?Nb+o1kgHpF9jBiHU4VzNO7kk?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3839.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377b8eb9-ab1f-4059-1354-08d920301a61
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 10:22:02.1435 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pjgy7Ef5/ZgjWjMBdd7Ygkjl8JfXOzGYVy+Xv5s+z2DRCnfUOMGwPxQ/w72DzUPULOQnV14leC83/dcFpum/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Wednesday, May 26, 2021 8:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/acpi: fix typo in ATCS handling

Path should be NULL when we already have the handle to the object.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index dcde3f658a7a..2195e24acb69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -557,7 +557,7 @@ static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
 		atcs_arg_elements[1].integer.value = 0;
 	}
 
-	status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
+	status = acpi_evaluate_object(atcs->handle, NULL, &atcs_arg, &buffer);
 
 	/* Fail only if calling the method fails and ATIF is supported */
 	if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Csathishkumar.sundararaju%40amd.com%7C8462e227c11e4b969bf908d91ff590ac%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637575961820648982%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=S9L%2FvF6pAf0WXWLVRjceyKoGbnheNrIOMu89duTKiVg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
