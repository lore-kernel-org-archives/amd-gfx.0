Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F175C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 21:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4602764E58
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 21:18:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4602764E58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7E96E7E5;
	Wed, 17 Feb 2021 21:18:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770041.outbound.protection.outlook.com [40.107.77.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB8306E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 21:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkXcEh4sFxeE+ckckIeHr9F7e7ahV3suTqIoI9pAcpFQDVQiPHXqmNEmQi15q3OGYSS2hBVqmhHGBAcjSnUmI7OlH/QnzzEgcY6Ns40iJagcLD2G7a2GygvqWOxeqK/FeHyeiWfm/1Ka1xLNbFFc7DbZcAW1B6O6Ycgmg460NJ4/re7D6KFfQ86Gu/RzbG2bPiVA6BwTyKyDvxUfCPDe/X4GtSUhDNZ9BVFsg0KWD7w73ATvyJvc58vTETqXdStpVI/Zc7/7F86oAjcX6tAI3tf4nEyaplvXxsXzDMxWzck6D9Uqt5os6tgcd+RImyh1k9yW3vM3bW2mVLEkfaYlLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrwwI9ekFWgtEvTHpik7YkQpnAP9J75n5HE+Bz10lRY=;
 b=ngD6rfjmDGbtfwi3vEI5QCMqf6z5/3kFtS8eSP7Fat4oTk6PcrNa/LRWIcXXiRajYa619S8zBrKPl9kcuB5WN1/mR4h1qT42Fex7fHzV0e0FtzSECogbrbx4Zi03MGn7FrlXYzbWFebd/f4co/5HvmJ0Ulyv04FRvmir6FIywD5UtZaLbRqwTDtd7/QqlV7FDcQyZpDLyZy0CWlM8RH50b8ElLc4mOilUSrcoH3yz994lA2A8xDiDAMQvw91rqaG5zwzLpL8Xuxt9Wo8e3nS7R+TQzLAzIOl3UKiJsHSR1LEB5kj9tyWX+GLfUALCXp5qjINyd7fG8Y6cNfeRPe6WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrwwI9ekFWgtEvTHpik7YkQpnAP9J75n5HE+Bz10lRY=;
 b=A0r3vXzsj2sz57VrZgD8TZqdoyA5slVreT3LXydNUqJ80I4mmiTEm+k8FwS1hNYugTrp5ba5oKXj+8NNyE7z5JAG2zZ3eIsKVf/Kn5AjF11D7+CHpbuAp6rR1bu/di12LAQnHdYUnQTvJ20pF3XuSZdENgal58fGa6SGwW3AnpE=
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27; Wed, 17 Feb 2021 21:18:24 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::4e6:1dd7:b89e:e9d8]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::4e6:1dd7:b89e:e9d8%4]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 21:18:24 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/8] drm/amdgpu: new resource cursor
Thread-Topic: [PATCH 1/8] drm/amdgpu: new resource cursor
Thread-Index: AQHXBV8tocsr7i5h8Ea+yJYvixx0s6pc2c5w
Date: Wed, 17 Feb 2021 21:18:24 +0000
Message-ID: <DM6PR12MB47326290D7F2370CF6EA399780869@DM6PR12MB4732.namprd12.prod.outlook.com>
References: <20210217190028.16409-1-christian.koenig@amd.com>
In-Reply-To: <20210217190028.16409-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=503e3c0f-5e92-471d-9226-9aa0fe239886;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-17T21:17:19Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [70.51.70.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3d2908b-f77b-4c44-ee20-08d8d3898f71
x-ms-traffictypediagnostic: DM6PR12MB4401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB440105257D17110D38039D0380869@DM6PR12MB4401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n1o6pe0eRvvEqrQQ6XC7XaSLaDqwVKMiCGvVQiHmxgulr6VQB57n2si2O/ZAQj628H6OMk4eqsBIt1kO9mGPSHXaVHEjh6IMfKfusiMClMa4/Odtt2fgo+c1fpVizGTI6unpz8SkVwQKQAO3zQeng7PMr5GcdVS4PJDA1iu/3jyeX4cBKhCeLyt8Ubx9wQVatgH+e0hJyj9LeGq7EKRlVVCI/ncd/CqC0L6Q08lwkaWIGFgufhwlZufC+OZd5GObx3b6Tiqefmad1hpEjb2EaMD/883npzIp0LDe8rFpEt2W/wmsFABUlDFVY6PcXKilqzmeJiC4k9JIM6Kbis1WkPzzc1t/Ry3PqeG4/3/cJMfo2ORVETuWz3FeoRlkgYVjGcAD1kXSMX/VmLqP9GR7CJEYUrWxbP7Da26k38ZzHsPstyTOSizswKtWBm8WQsITodmX40HNYe2N6ekynap3xZoUTy+EkpOa4IpMFxX2F96pUpN9s9qHxDDEAPH6yoIrvoUHecc6hi/TviqssWo8wX/7NwHPIN+GAqLsaSqEUKiBaT35brk4L8MNcBI39OrKU7KY4ZkhX9qjP7mMw8aMlqqc4NTvQqbaOio0/+/fr9A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(9686003)(186003)(66946007)(26005)(76116006)(55016002)(966005)(86362001)(53546011)(66574015)(478600001)(6506007)(83380400001)(110136005)(8676002)(52536014)(4326008)(71200400001)(2906002)(45080400002)(33656002)(5660300002)(64756008)(66476007)(7696005)(66446008)(66556008)(316002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ssgiPK+vfRiUs68LuQ9UJ2xlsIuUMAb20T4eeLtNaFaHn0VC2QMAWJLc54?=
 =?iso-8859-1?Q?16GFeKjohdzIs1a5LHBfEP0sYEcEic9IBE2m76azNktYK/rMmj5Wtp7JDL?=
 =?iso-8859-1?Q?PxUTkjujb+qsNqjXq1BI4xT82dOZ3e4NPVo8KorHuYILFrsPhNTmz5AjDz?=
 =?iso-8859-1?Q?UVtHNTxqpHYiECTl7dteIYLwCTlCHS6kdgfOsXymac/V9CVoxhwJEnrFG5?=
 =?iso-8859-1?Q?PizDgolJhP8RHGiPL9inEyxzZz1Wxtfz5zyP5O2/Sbm2+oH05BW+dh++ky?=
 =?iso-8859-1?Q?Ckzq7UOjbYHIQTSDnrqrl/gXuBl2NC6xEpyQJivNsfEHjDDCXnfRBnW6c5?=
 =?iso-8859-1?Q?cEgHLg1jHKV1sXLNEsQc5hdlsrBiMLDZJ1BLq4e70+AlwAIegStbowJ7mB?=
 =?iso-8859-1?Q?V6TIqrGT+kFAG3ZkedEU/kAa8pTyQtm4eQxvJ6pKCFaGvOokkGm4kzKoKn?=
 =?iso-8859-1?Q?n03WDUT7GTsu/Jnr/0oRhplqm8bE18ynStrD/OV51OEWwnQMd06xFhC4mk?=
 =?iso-8859-1?Q?zCiSZ5m++Rg+AEoo4P1RosnAeJMcJ+3lmvD3BY7PjFS4++6/vctqoKOo4X?=
 =?iso-8859-1?Q?prw629dVjWLp1ThjG1sY5MTCBfEzOypo9m/aBUmQSpTj8xHrWRxBOwObTn?=
 =?iso-8859-1?Q?D4xhVHsyHCjmabjPU2+D8A6wM0bn7pEEWYGKCWF+BKkxH+TJL5SQ21zHvV?=
 =?iso-8859-1?Q?VgJaR4LSqAG/t3wjQZErP8Xlu9Oq7fYrHArrmNR2AvwiOsiZItsB+BeSzp?=
 =?iso-8859-1?Q?JaCYzUrW6AREzS3f/VJ/Cg1qyoDngLFdQEzGjWsBFNN/qvL4tGGLwzoBb+?=
 =?iso-8859-1?Q?4MdlJcS66iP7ZGQswOznpSqeZXl960uvpn2UAK3rxYYez8ir39u42V08i7?=
 =?iso-8859-1?Q?kcBiz4WjnEfROYGFtxbiMFb7TBO76TXF9KNStwk7kr7ikwq1JxLIAZ3B0W?=
 =?iso-8859-1?Q?5jluEsHJrKbf/tzdLPo8ZJgZzyWKcRqz8Ym2WmTDNHKWtyGZlTTJDosgh4?=
 =?iso-8859-1?Q?4s0wAIu9HAjglUwHuRWDZx3NBDFbKz2CJ1Y8MvNg/7KD/36CjZaL/enM7D?=
 =?iso-8859-1?Q?JNxN3IRPCbGEI3BMbnEnxq+dqdGZ8j1ji8lgXU2Uyr8gfrcmBhcXf7joZx?=
 =?iso-8859-1?Q?s9EyFyjmW9zk6MDpr3zYG/rW2zBJJ2i5eJ+7QdrRsdVq4VlZRq1EUKAKdt?=
 =?iso-8859-1?Q?WaLF3yuPNTfaf9grhmXIJwP+/FpDbjJ5pMzVdwlhcb4iojRs064+L1F9ws?=
 =?iso-8859-1?Q?AgHOnTV+rtWvRn8kE3tzuNRBx0YFuNsYi0A8RdncR35CIGGaFiGRUGJV8U?=
 =?iso-8859-1?Q?gx0Bab9UsCS9kU+/jG/wA9Nk1MxPnIny+Au3mvDLgEnfQ48=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d2908b-f77b-4c44-ee20-08d8d3898f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2021 21:18:24.2914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpRiCyp62Gs2DuTdD6GEHk8ineW1Sn/kd5EiDghm0vQc2y+d21ns2jHn23pHeri6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4401
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
Cc: "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Very nice cleaning! Series is Acked-by: Oak Zeng <Oak.Zeng@amd.com>

Regards,
Oak

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Christian K=F6nig
> Sent: Wednesday, February 17, 2021 2:00 PM
> To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
> Subject: [PATCH 1/8] drm/amdgpu: new resource cursor
>
> Allows to walk over the drm_mm nodes in a TTM resource object.
>
> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    | 105
> ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> new file mode 100644
> index 000000000000..1335e098510f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_res_cursor.h
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * Copyright 2020 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person
> +obtaining a
> + * copy of this software and associated documentation files (the
> +"Software"),
> + * to deal in the Software without restriction, including without
> +limitation
> + * the rights to use, copy, modify, merge, publish, distribute,
> +sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom
> +the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be
> +included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> +EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> +MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT
> +SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> +DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> +OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
> THE USE
> +OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: Christian K=F6nig
> + */
> +
> +#ifndef __AMDGPU_RES_CURSOR_H__
> +#define __AMDGPU_RES_CURSOR_H__
> +
> +#include <drm/drm_mm.h>
> +#include <drm/ttm/ttm_resource.h>
> +
> +/* state back for walking over vram_mgr and gtt_mgr allocations */
> +struct amdgpu_res_cursor {
> +uint64_tstart;
> +uint64_tsize;
> +uint64_tremaining;
> +struct drm_mm_node*node;
> +};
> +
> +/**
> + * amdgpu_res_first - initialize a amdgpu_res_cursor
> + *
> + * @res: TTM resource object to walk
> + * @start: Start of the range
> + * @size: Size of the range
> + * @cur: cursor object to initialize
> + *
> + * Start walking over the range of allocations between @start and @size.
> + */
> +static inline void amdgpu_res_first(struct ttm_resource *res,
> +    uint64_t start, uint64_t size,
> +    struct amdgpu_res_cursor *cur)
> +{
> +struct drm_mm_node *node;
> +
> +if (!res || !res->mm_node) {
> +cur->start =3D start;
> +cur->size =3D size;
> +cur->remaining =3D size;
> +cur->node =3D NULL;
> +return;
> +}
> +
> +BUG_ON(start + size > res->num_pages << PAGE_SHIFT);
> +
> +node =3D res->mm_node;
> +while (start > node->size << PAGE_SHIFT)
> +start -=3D node++->size << PAGE_SHIFT;
> +
> +cur->start =3D (node->start << PAGE_SHIFT) + start;
> +cur->size =3D (node->size << PAGE_SHIFT) - start;
> +cur->remaining =3D size;
> +cur->node =3D node;
> +}
> +
> +/**
> + * amdgpu_res_next - advance the cursor
> + *
> + * @cur: the cursor to advance
> + * @size: number of bytes to move forward
> + *
> + * Move the cursor @size bytes forwrad, walking to the next node if
> necessary.
> + */
> +static inline void amdgpu_res_next(struct amdgpu_res_cursor *cur,
> +uint64_t size) {
> +struct drm_mm_node *node =3D cur->node;
> +
> +BUG_ON(size > cur->remaining);
> +
> +cur->remaining -=3D size;
> +if (!cur->remaining)
> +return;
> +
> +cur->size -=3D size;
> +if (cur->size) {
> +cur->start +=3D size;
> +return;
> +}
> +
> +cur->node =3D ++node;
> +cur->start =3D node->start << PAGE_SHIFT;
> +cur->size =3D min(node->size << PAGE_SHIFT, cur->remaining); }
> +
> +#endif
> --
> 2.25.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.
> freedesktop.org%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=3D04%7C01%7Coak.zeng%40amd.com%7C467ca2054278419a6e
> 8508d8d3764e38%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637
> 491852368143275%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DuZ
> t%2B%2FIVc7%2FD2jtq%2F%2BIogn17%2FpfU16l%2F6%2Fccf5QBSjqw%3D&a
> mp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
