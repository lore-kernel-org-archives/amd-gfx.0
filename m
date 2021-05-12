Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C079CC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B736134F
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 19:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B736134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B72E6E3C4;
	Wed, 12 May 2021 19:40:43 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CECD6E34B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 19:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpQTdoce67TTuMd3Qog+iKZrpuqV5Pv5i2le2ML8mBmLNFhgQWZRrFBeQcT+BlVG+m5p4tf3+Q+d112dg2Y/PumtEqwxOu6lXFft5EK42ndkS0LbLQG6pdDYKwtjIRolQ3orfPV/8Qy9sHt+Ef/AJBmy4FQm6PGK9Pjh4gpiH0/7matIV5xJO6/Ka2Qb/5uJRjL6Gn5wL6ybj7YzPtpfUPcIfAiP0vYMJkY2TQba8cSQMeSWg88QzzbGiY1nuWPAz6Eio3D53EGzpmR//msxzg6bbAVGm26FDf7wTzpe24CAkkR/R8utneLBliPK3L98gPinLndwqjimeSyWp8LbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk8agEy1aOKDpmovhfwc9rfFtZ+bkwz6Evf/ta/FXFs=;
 b=gr+eG4MLAbazjJ19e+LNzV1sTSq6cywZxEFclNwau1QA23hHim5qDMnY+lyfI9/sh14gdADLgX/06cGprK85rt06O1ztC+iHTCQmTaZS1rc09iM5yDhc1b23H9seiIl9VUu+g46g7xLYb/0/G24HOyDWGkP35A62S7ZnbuWgw163rGt07k/J7c0oAsS6Gf4KOzBIBrD+PG9dBm1fRxUzbluJD2LgUb+CCBbwkMUpr+AMqkS23xaRBPgSTKMppT2IlZhXBODWiIKy2FMFiXZvCFnuF2epPa6rxQuXexRU0Q3qUtKHpdSv/uzj6aUl8UCeyes1Bvphv3o7tbfIHJ1e6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qk8agEy1aOKDpmovhfwc9rfFtZ+bkwz6Evf/ta/FXFs=;
 b=SpCQKMBawdTiUC54/2wz9b4SS3qPnj3WDJgGmYv7bHMXDO/lui62uWj7lFmmoVD1mJE2AEJWOL8SYOVNL3XiAlTiR3Nz+h6n1zjY7wbvwzfA52Jwc3rpEIRKwvYbJFQIGbYO96kzHwNNCohXYZTcwdliBcxTRQRtYRHzRWNosy4=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB4001.namprd12.prod.outlook.com (2603:10b6:a03:1ac::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 19:40:38 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Wed, 12 May 2021
 19:40:38 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix fence calculation
Thread-Index: AQHXRdsyILgvLWkSJUyuTo5sQyI/V6rd6aKAgACtdQSAANS7AIAAADUAgADVgpY=
Date: Wed, 12 May 2021 19:40:38 +0000
Message-ID: <BYAPR12MB2840F1AB3715C43C524133AAF4529@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <c1b6f68f-4b96-8752-c406-564e2b98ce41@gmail.com>
 <20210510202915.30502-1-david.nieto@amd.com>
 <20210510202915.30502-2-david.nieto@amd.com>
 <7579fa92-ad25-323a-0c41-ac07ac47fa42@gmail.com>
 <BYAPR12MB284099C33725C0BB0FDD8D48F4539@BYAPR12MB2840.namprd12.prod.outlook.com>
 <9b373f49-51ad-089c-2494-032b13a9a39c@gmail.com>,
 <f689c523-c60a-a0d2-ca6a-5dcb043ffc91@gmail.com>
In-Reply-To: <f689c523-c60a-a0d2-ca6a-5dcb043ffc91@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-12T19:40:37.630Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9217a00-2eb2-40b5-a24d-08d9157dd1f8
x-ms-traffictypediagnostic: BY5PR12MB4001:
x-microsoft-antispam-prvs: <BY5PR12MB4001E6CB596235353A1C6642F4529@BY5PR12MB4001.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xFCSiqiSuO1mdSetS/Ib+uBpEik1cqgCQlgJJzZTFIYbqsb8olI2R57ZI3AgAGsS+A3JjqWYAf4vyZuwqGm00ElrqJB1NwycyoIUtS4fmpStdN/yu1mIZIX4sURQeTH5A34L/ExcyAszuqbh7QUjR8dM3do9zrjXEI6IdyQduaaIwM4XPFZK/k6+oQ0RkRv45EmxHyHeQs0Dd7D+C88D2LRh6w9E/STQzk232UCdMjgoEj6A2c/CCLfgS4/ubMwy6jelCRT8RvKbkN0O5lYVHhxsDDexCrtBR7pJVvpYAzTFqfX8TTwQI8nJGdGdu5yZ01rZrLKyehrWWKJoJ/ge9CKZts8raEtuuRWawBVK0Mgu6c6O/uyQ1pulXs7bSLEEKzVEuaFTRrdBtUPBV5lg/Uhpo3NBcXDirSecA3wK3/49fKMp3ZyFLmV1w2fBqAfWceViFYEBCAxN5HG2mXoveIDWwOA5OtTDl5qUe7dD05T7TLPgT1elyJWDdx36DjU+8eP3KgcwH1k04GLNk6qGHkDl+O3Iy42aGVCRFlDlMoz0Zso5pfADJf+dC6NY7y7CaadeWPVMRDY50Dyk+d0tNGCGOSLjN53PvIIPKJ/hhjA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(136003)(396003)(376002)(186003)(5660300002)(2906002)(26005)(66574015)(122000001)(478600001)(66556008)(66946007)(66476007)(33656002)(9686003)(7696005)(38100700002)(76116006)(64756008)(19627405001)(8936002)(8676002)(71200400001)(6506007)(53546011)(83380400001)(316002)(52536014)(110136005)(86362001)(55016002)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?AUUpMNNyeXOTIb5Wq949aK8OD/Twy9qgpOZ36N3AtIlGeYy6wWjJTuCi5R?=
 =?iso-8859-1?Q?AEQo/7+Pex57h7SZ8T+BAiKDjcUcRAPKaOMioHA7Q2a97/2JMfg72Soi3p?=
 =?iso-8859-1?Q?XJcrLGe0LvAGPlvfRx7dYxQkieAlqbMguJSpe+XWtNlTeXMdIe7o+5bFOq?=
 =?iso-8859-1?Q?PxJpk56a5tJDd5rVr14+1ozJjR+BbfEG4OMFE0GYPYHvmkZIvYFazGJ5ev?=
 =?iso-8859-1?Q?tpUGLB4vRv3aE914blStXvb5oqIZbUbpv14QgC5BTRfLKsL++kCDccVw2H?=
 =?iso-8859-1?Q?m4DpWTpK4JtO1zAzdCmRfYwi4IemnZLoOhg9Bemv+hOykJmJFe9fMidaLl?=
 =?iso-8859-1?Q?qQlXKN7oMpOF1Xqb1lxKAWhQbihLFQNtkPeQ4NTsMmAj5UYE8q7TO/K0xB?=
 =?iso-8859-1?Q?IuJlU8Nx5Gp9UKH229MdW+grybUYWq9c/jc5psO0g1K62j/qe8M5mp1pQC?=
 =?iso-8859-1?Q?Rb+QjXuAMBK/tNGUADlwV1XoPqYAwmfLmWm1Vl0yCCQLCSN4Frr8GhRHmO?=
 =?iso-8859-1?Q?X2o9a+9ByDphK6ea02Xgxq814Xq6B90XbrgRGPHipOcLYJGa3ktByYtG4L?=
 =?iso-8859-1?Q?Y3+sXgIBx+3z9BXydBLfPCM0cZbENa4yo/lEeMcFUIh22vacNUcBy1qhAY?=
 =?iso-8859-1?Q?ZiNBr1YxNOedQ3PYg2sMXctSNHAyoGCMXhp+2TM0G1AS+t4bJ5bA9RaVph?=
 =?iso-8859-1?Q?w9lkz/89D1dgtYKs1gFU7iERAzEf3VWxBI3WNIWhFbmsOS+zrJ3sK9dmaZ?=
 =?iso-8859-1?Q?5zEUBPmUl01hhvwD+hfZhspz4wAotoUiBLoCLtbZKmanbUPOqVTtpyRyiO?=
 =?iso-8859-1?Q?o4N6iRdCicjWcfPjAaazCVmRXvxOCp9lFKAYzuxC8XUCQzXZL1pEoXJECd?=
 =?iso-8859-1?Q?MyIc3PkfVIDx6MXk99TZCrJARo2BfNmi8q/VbDZpcCae8Kp2HijWVxnGlF?=
 =?iso-8859-1?Q?VxP4Uaz7DRN5eADTqDez7seKoEQmuSK7/+AuZCuuNwSBKl/awLSqG5thoF?=
 =?iso-8859-1?Q?9P4unRwHYZ8dWv9LqDHJel+YzZAQcW16EsIUuC2Ef0BcfmsC/FEQN4ItAj?=
 =?iso-8859-1?Q?mLWCfjAhyEM24J4Es2Ff0q/rm98q3DBFd5RNwv1gwiqkBrZsarY3fiwhhv?=
 =?iso-8859-1?Q?o/CwnZl0Fh8rkU6xZKaLehOFBmoJS7j/X1xfZhmXlgEmOWAykvkxRRUmXc?=
 =?iso-8859-1?Q?qW5C5S5/+RxvxyASgmTkmsCc9Jf9RhvfINz9AgH+2gUnffzd6HJNM1/sr5?=
 =?iso-8859-1?Q?V80s+CEhcV4eIY1PpC35FhiIY6tOst0pGiQRGKXvIjgaBcGKupWiSIPXyK?=
 =?iso-8859-1?Q?PkSUX6FqT2XdLy8El1qCOcNOGjZrEC/31Og7vVz9IieKM33954gz5GFqcw?=
 =?iso-8859-1?Q?LRdQxHjtzK?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9217a00-2eb2-40b5-a24d-08d9157dd1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 19:40:38.4035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fI+UQLUR+A5s4oEWYCRpa/LQP6NGL4Hz4zceXXpXvK57r4Doj5uuhQgse2cNmMVK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4001
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
Content-Type: multipart/mixed; boundary="===============1314641714=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1314641714==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2840F1AB3715C43C524133AAF4529BYAPR12MB2840namp_"

--_000_BYAPR12MB2840F1AB3715C43C524133AAF4529BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

yep, you are right...

I'll make those changes.

David
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Tuesday, May 11, 2021 11:56 PM
To: Nieto, David M <David.Nieto@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation

And BTW amdgpu_ctx_fence_time() should probably be static.

Christian.

Am 12.05.21 um 08:55 schrieb Christian K=F6nig:
In this case amdgpu_ctx_fence_time should probably be changed to initialize=
 the variable itself.

That is really bad coding style otherwise.

Christian.

Am 11.05.21 um 20:14 schrieb Nieto, David M:

[AMD Official Use Only - Internal Distribution Only]

The local variables need to be initialized to zero, since amdgpu_ctx_fence_=
time accumulates and does not initialize

David
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Tuesday, May 11, 2021 12:53 AM
To: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>; amd-g=
fx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lis=
ts.freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation

Am 10.05.21 um 22:29 schrieb David M Nieto:
> The proper metric for fence utilization over several
> contexts is an harmonic mean, but such calculation is
> prohibitive in kernel space, so the code approximates it.
>
> Because the approximation diverges when one context has a
> very small ratio compared with the other context, this change
> filter out ratios smaller that 0.01%
>
> Signed-off-by: David M Nieto <david.nieto@amd.com><mailto:david.nieto@amd=
.com>
> Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 9036c93b4a0c..89ee464b9424 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -698,16 +698,27 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ct=
x_mgr *mgr, uint32_t hwip,
>        struct amdgpu_ctx_entity *centity;
>        ktime_t total =3D 0, max =3D 0;
>
> +

Unrelated white space change.

>        if (idx >=3D AMDGPU_MAX_ENTITY_NUM)
>                return 0;
>        idp =3D &mgr->ctx_handles;
>        mutex_lock(&mgr->lock);
>        idr_for_each_entry(idp, ctx, id) {
> +             ktime_t ttotal =3D tmax =3D ktime_set(0, 0);

There should be a blank line between decleration and code and please
don't initialize local variables if it isn't necessary.

Christian.

>                if (!ctx->entities[hwip][idx])
>                        continue;
>
>                centity =3D ctx->entities[hwip][idx];
> -             amdgpu_ctx_fence_time(ctx, centity, &total, &max);
> +             amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
> +
> +             /* Harmonic mean approximation diverges for very small
> +              * values. If ratio < 0.01% ignore
> +              */
> +             if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> +                     continue;
> +
> +             total =3D ktime_add(total, ttotal);
> +             max =3D ktime_after(tmax, max) ? tmax : max;
>        }
>
>        mutex_unlock(&mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.h
> index 10dcf59a5c6b..3541dfb059ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -30,6 +30,7 @@ struct drm_file;
>   struct amdgpu_fpriv;
>
>   #define AMDGPU_MAX_ENTITY_NUM 4
> +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*tot=
al)
>
>   struct amdgpu_ctx_entity {
>        uint64_t                sequence;




--_000_BYAPR12MB2840F1AB3715C43C524133AAF4529BYAPR12MB2840namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
yep, you are right...</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I'll make those changes.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
David</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Tuesday, May 11, 2021 11:56 PM<br>
<b>To:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: fix fence calculation</font>
<div>&nbsp;</div>
</div>
<div>And BTW <span style=3D"">amdgpu_ctx_fence_time() should probably be st=
atic.<br>
<br>
Christian.<br>
</span><br>
<div class=3D"x_moz-cite-prefix">Am 12.05.21 um 08:55 schrieb Christian K=
=F6nig:<br>
</div>
<blockquote type=3D"cite">In this case <span style=3D"color:rgb(0,0,0); fon=
t-size:14.6667px; background-color:rgb(255,255,255); display:inline!importa=
nt">
amdgpu_ctx_fence_time should probably be changed to initialize the variable=
 itself.<br>
<br>
That is really bad coding style otherwise.<br>
<br>
Christian.<br>
</span><br>
<div class=3D"x_moz-cite-prefix">Am 11.05.21 um 20:14 schrieb Nieto, David =
M:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
The local variables need to be initialized to zero, since&nbsp;<span style=
=3D"">amdgpu_ctx_fence_time accumulates and does not initialize</span></div=
>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<span style=3D""><br>
</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0); background-color:rgb(255,255,255)">
<span style=3D"">David</span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:ckoenig.leichtzumerken@=
gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Sent:</b> Tuesday, May 11, 2021 12:53 AM<br>
<b>To:</b> Nieto, David M <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mail=
to:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a>; <a class=3D"x_moz-txt-link-abbreviated" hr=
ef=3D"mailto:amd-gfx@lists.freedesktop.org">
amd-gfx@lists.freedesktop.org</a> <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: fix fence calculation</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Am 10.05.21 um 22:29 schrieb David M Nieto:<br>
&gt; The proper metric for fence utilization over several<br>
&gt; contexts is an harmonic mean, but such calculation is<br>
&gt; prohibitive in kernel space, so the code approximates it.<br>
&gt;<br>
&gt; Because the approximation diverges when one context has a<br>
&gt; very small ratio compared with the other context, this change<br>
&gt; filter out ratios smaller that 0.01%<br>
&gt;<br>
&gt; Signed-off-by: David M Nieto <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:david.nieto@amd.com">
&lt;david.nieto@amd.com&gt;</a><br>
&gt; Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 13 ++++++++++++-=
<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 2 files changed, 13 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ctx.c<br>
&gt; index 9036c93b4a0c..89ee464b9424 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; @@ -698,16 +698,27 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu=
_ctx_mgr *mgr, uint32_t hwip,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ctx_entity *ce=
ntity;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t total =3D 0, max =3D=
 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +<br>
<br>
Unrelated white space change.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (idx &gt;=3D AMDGPU_MAX_E=
NTITY_NUM)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idp =3D &amp;mgr-&gt;ctx_han=
dles;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgr-&gt;lock=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_for_each_entry(idp, ctx,=
 id) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ktime_t ttotal =3D tmax =3D ktime_set(0, 0);<br>
<br>
There should be a blank line between decleration and code and please <br>
don't initialize local variables if it isn't necessary.<br>
<br>
Christian.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!ctx-&gt;entities[hwip][idx])<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continu=
e;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; centity =3D ctx-&gt;entities[hwip][idx];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ctx_fence_time(ctx, centity, &amp;total, &amp;max);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_ctx_fence_time(ctx, centity, &amp;ttotal, &amp;tmax);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Harmonic mean approximation diverges for very small<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * values. If ratio &lt; 0.01% ignore<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; total =3D ktime_add(total, ttotal);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; max =3D ktime_after(tmax, max) ? tmax : max;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;mgr-&gt;lo=
ck);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ctx.h<br>
&gt; index 10dcf59a5c6b..3541dfb059ec 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h<br>
&gt; @@ -30,6 +30,7 @@ struct drm_file;<br>
&gt;&nbsp;&nbsp; struct amdgpu_fpriv;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define AMDGPU_MAX_ENTITY_NUM 4<br>
&gt; +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max &gt; 16384U=
LL*total)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_ctx_entity {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sequ=
ence;<br>
<br>
</div>
</span></font></div>
</div>
</blockquote>
<br>
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2840F1AB3715C43C524133AAF4529BYAPR12MB2840namp_--

--===============1314641714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1314641714==--
