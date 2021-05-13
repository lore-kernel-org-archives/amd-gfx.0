Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563BC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C75C613CB
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 17:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C75C613CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3E06ED98;
	Thu, 13 May 2021 17:42:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DEB6ED98
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 17:42:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQb2avu1URYh2GEKKDatytAxkqJ7MkZFIfjDQcxlqoBEkvTAV8Uhv2zNnxiV92TVNbM6oXjjiyWN8j9tlnH2nNMIt6X+VYPTTbNk4JGYZtc6wGNsUmy/rNdsJ+E64+AkF5I1wLwGPWEqGH3nOg0uvm3rOW0oIE7ISoB4qcQBovV8COQeo5GquUpcTmXnW7aKKf/AxBdQrWeWmMfHAqNwv8C1X9ud/zSRs8iYdQrHR8WEq1Wi2h0ETVOs56c9XHb6uqczkzolyLdu+kMUzqKg1X/cbHZmcjzoQUhp5ZzWrIh57Ji9FGz/RMfAO0ZXDE0nW2TEWt8H/3euYdJYe2RLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJozx/EV2709GdjOBOBVuivHJo8xNnmp/LoqCXE3OeY=;
 b=l7ixG0csSErm+GisjD2SNKPc3aXcQURtCBhNc4oBTkQcBHSXU2fiwoywbwBETaSdT0nrfwyX2TsnU56L9Jj9+x/uzB3xmupDA52JFXUP17KVU2XRxTPtuQ0Ua3mYUrAQ2H9JgRxdMXuSwNlSWmrosm8E4/dG7bY2Nzh4HoogPMd2sux6CRq1ZhnSiSv7QymJvd65vqQAPQw1vHd9SflKHBdupYq/1GNtWyxuIL9JoBXvlfwEYuV1NjoE6GSJEgcnJ6ZSpmN0JSNsM+13LComSaA8l8lmc7J8Xo2pPnucQkYi9f6iVnJNRPWdV5uuXmgkdXtiVt8XAD7lv9CTSpmj/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJozx/EV2709GdjOBOBVuivHJo8xNnmp/LoqCXE3OeY=;
 b=oZaaECkj44VZ8JKkl1bR/XB5SyPVZwsUzrSA1tz4O/mySGkoJMiiz4+IxGVQ4GqrnHjOcdK1MFhARRLy0m1I09+TD0UuTbP94ana/WPJxmt7UK7Dr/qfMSreRfLpKNsqZCvET6jScPOteQw912Zc1ChQzpVFwX/Ez9xwvi6pAUg=
Received: from BYAPR12MB2840.namprd12.prod.outlook.com (2603:10b6:a03:62::32)
 by BY5PR12MB3876.namprd12.prod.outlook.com (2603:10b6:a03:1a7::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Thu, 13 May
 2021 17:42:15 +0000
Received: from BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616]) by BYAPR12MB2840.namprd12.prod.outlook.com
 ([fe80::7c65:7181:6d1d:8616%7]) with mapi id 15.20.4108.031; Thu, 13 May 2021
 17:42:15 +0000
From: "Nieto, David M" <David.Nieto@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix fence calculation
Thread-Index: AQHXR2djhB9UqIzU8k2f30KaF+yGFqrhEGAAgACfIFk=
Date: Thu, 13 May 2021 17:42:15 +0000
Message-ID: <BYAPR12MB2840EA2467563CF0293F2CDEF4519@BYAPR12MB2840.namprd12.prod.outlook.com>
References: <f689c523-c60a-a0d2-ca6a-5dcb043ffc91@gmail.com>
 <20210512194527.7687-1-david.nieto@amd.com>
 <20210512194527.7687-2-david.nieto@amd.com>,
 <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
In-Reply-To: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-13T17:42:15.078Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.53.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a45d219-0c28-4f92-e454-08d916367296
x-ms-traffictypediagnostic: BY5PR12MB3876:
x-microsoft-antispam-prvs: <BY5PR12MB3876524903D1D829F7BAD657F4519@BY5PR12MB3876.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lC4aKPB8Rlo6+itd0YtLFfeWJ3pliXFJ4KLVFqB5XNmiTEo8kh+YPlUUQJepxSHlD+7gz0pCkyFGlZudM8hljXxKbPgCnnwMu/u1BZWQjvtVeGn0JSeDumMzZ9KmTPhGFu9GXi8gkNcUPzSUiq5OanhDUKdGlmfQdjEMqDjH59sJH/wRmw1n0PUwlgEa0Y6KVpw8pQJWZiZaduBckACqtsl9lrnjvLywU+D4/9RC4aLVOppjvesVwCcTXpuLBpa1oFwvZy1f7DUe2h4wDpDQ+sWzjnsITITeTv4/0Yq2u5XFhk37jlyLU3bB7Ru/Jfus3TnLAshtQEawtg6WTny1nfIU3dm+PSf1W4wnWSzcyT6Yx45kK3TRNe9rz6JcSdwqSOD/8P+cz95khUruHU5GOH+Th9bj0dTfk/v98/h92e9lGfMj3sgPD98Do/4yHl+NGHf5RDPNLbUWklmnf8CQY4vrmQwyVGNpqYYDhEIMsflMh+EZvgYvnJleH2E0N8NSe9MsSMYpdMIa4xNBdl9RwMB/u7E7E2jDjNH1jlbjT2W26A1vrXQSTyxHGfcyzTTY+pcGySWSKziYTN5QtUIUcZUULvDPQMKqz+tQGJfnmng=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2840.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(396003)(39840400004)(376002)(346002)(7696005)(86362001)(9686003)(478600001)(83380400001)(8676002)(2906002)(6506007)(55016002)(186003)(64756008)(53546011)(316002)(52536014)(66574015)(26005)(66446008)(122000001)(66556008)(5660300002)(66946007)(8936002)(71200400001)(110136005)(66476007)(76116006)(38100700002)(33656002)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?S1lafePsA4Eraqu6kfVzNLW7JpebsvGnfxms6UGTbOEaLdvknNM8drrxsr?=
 =?iso-8859-1?Q?Gw3KH4VvyUbP+7zh8AfL/wqLKJPBaKWRrKtJZuAa6AWZtiQHtz7C+0l/uK?=
 =?iso-8859-1?Q?gUp5MN59Z6uHJhboOeErHLQq+1/9sjIILhTIqVDK4zqNqTrtXBpISJiG8O?=
 =?iso-8859-1?Q?intwOM4AqlnVllYNR+CAuvDXPf6CKRMnPNlbzKDIB1xIYBLP4Kgk0du3sE?=
 =?iso-8859-1?Q?+xS1JoFRd+BSpAOsZAfng0JY0ovN43eRhipjRd0+OfIg/jd2XjcWaD9dMS?=
 =?iso-8859-1?Q?UlzM3SLtbem5+B/3V6nK7+AFwGOYFe7N/3dfrhM4KCgCizFAPTCF2xB86V?=
 =?iso-8859-1?Q?cs3CXYtuAhmazvEBvrlIGSF4rZ/uLCN2C46YDMVm86b7/tYAbBXKlctMLM?=
 =?iso-8859-1?Q?g96W6j8XxFcinxWF/C9QhaDZS3L05bREFyj1x0p/VrT+7kGMqvbZTxL+b0?=
 =?iso-8859-1?Q?tUxvimYE5cBwR2i+lUO8FSw+RY3TsTs0MNagk9FUatfdx9UaE7dtO+kyZY?=
 =?iso-8859-1?Q?BXHNSYQp6IWieT+8DiXJHRtd9sutNmjV7NAB63k0VqZrTeb5SVFCrp8U71?=
 =?iso-8859-1?Q?AXKzQ8TBr3fDnB8Qav6pDvCuu/QD2miBF6E9SLpnqTCmtN/gbAyzakfF+G?=
 =?iso-8859-1?Q?q+vOfGCGcQA/RbIkPt1208DooMlIOF4GqLRtF4foNaCgE3y/zB9EHpEhQE?=
 =?iso-8859-1?Q?hoL+GV/l5lfcE+O+hzieUSK73OywWhWLMI1z1vHWBV9oZRM/bD1blObJPZ?=
 =?iso-8859-1?Q?FKVDBRI5nEkQ8H6jAPoMoHneGc1qhu4sr5WDZ5pfgLR+vRXJJTlRpobZSr?=
 =?iso-8859-1?Q?33maKSJx7gOsBQwWlF/Bnmsi8zb0eLpTkPsGIf/Do7rWnxMsvb/gs1jDhs?=
 =?iso-8859-1?Q?VVa4dFlxnvz5F48He+fXTZ+FTNsf2el5BPiffcLfsNScAodUDVRap7cGGW?=
 =?iso-8859-1?Q?vfR17GqaTXc9bD25TU53W/5RWIX8Chhvau4A/HsiatY8tvdig2w5tsaQ2t?=
 =?iso-8859-1?Q?VlxIiKcvrPzjZX45rzQmIRtg08KP/crA2gkgNVaNUvzv+JfSKCOE4chzX8?=
 =?iso-8859-1?Q?36w10txCh6qYOHWZsmeQREbfUDi4w4yNmgLlBjp8CgxsjbKrJ45mkt7nmD?=
 =?iso-8859-1?Q?TUZPMwwdWpVHpbcSTffpvflM0PltoVnsibJUTSceyjJa3j6UY/UrigDySn?=
 =?iso-8859-1?Q?PAeDFSH/LdVlxnnC7wxxKywCw31qk48VwlTRZBEFTmcEI0c6DAfAiKZix9?=
 =?iso-8859-1?Q?sKtqSXhfIM8uzVnQmjdv8XEE/p3EjiZm3uKVeVI/3xrK5aK/ZSi60jmzkt?=
 =?iso-8859-1?Q?h4XohVHfBqGe8fE+dJ7mzau8/BmSKahSaLjQQIg/vONsMRiv677lpWGFl7?=
 =?iso-8859-1?Q?9vFxAqrgMJ?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a45d219-0c28-4f92-e454-08d916367296
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 17:42:15.4373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8+DJtmFdYq/7ZRJ1bTFzn+sxU63AMEkTjnbAAeU60G9HLBPWslY5HQOSN3+Ysry7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3876
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
Content-Type: multipart/mixed; boundary="===============1371593282=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1371593282==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2840EA2467563CF0293F2CDEF4519BYAPR12MB2840namp_"

--_000_BYAPR12MB2840EA2467563CF0293F2CDEF4519BYAPR12MB2840namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

DOS line endings? That is weird....

I corrected the issues that showed in checkpatch.pl (the > 80 lines)

I'll re-upload
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Thursday, May 13, 2021 1:11 AM
To: Nieto, David M <David.Nieto@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation

Am 12.05.21 um 21:45 schrieb David M Nieto:
> The proper metric for fence utilization over several
> contexts is an harmonic mean, but such calculation is
> prohibitive in kernel space, so the code approximates it.
>
> Because the approximation diverges when one context has a
> very small ratio compared with the other context, this change
> filter out ratios smaller that 0.01%
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b

Looks good to me now, but the automated tools complain about "DOS line
endings" plus a couple of other nit picks and won't let me push it :)

Please use the checkpatch.pl script found in the Linux kernel to fix
those errors and resend.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 17 +++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ctx.c
> index 9036c93b4a0c..b919615e6644 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -652,12 +652,14 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr=
)
>        mutex_destroy(&mgr->lock);
>   }
>
> -void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_ent=
ity *centity,
> +static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_=
ctx_entity *centity,
>                ktime_t *total, ktime_t *max)
>   {
>        ktime_t now, t1;
>        uint32_t i;
>
> +     *total =3D *max =3D 0;
> +
>        now =3D ktime_get();
>        for (i =3D 0; i < amdgpu_sched_jobs; i++) {
>                struct dma_fence *fence;
> @@ -703,11 +705,22 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ct=
x_mgr *mgr, uint32_t hwip,
>        idp =3D &mgr->ctx_handles;
>        mutex_lock(&mgr->lock);
>        idr_for_each_entry(idp, ctx, id) {
> +             ktime_t ttotal, tmax;
> +
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


--_000_BYAPR12MB2840EA2467563CF0293F2CDEF4519BYAPR12MB2840namp_
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
DOS line endings? That is weird....</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I corrected the issues that showed in checkpatch.pl (the &gt; 80 lines)</di=
v>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);">
I'll re-upload</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Thursday, May 13, 2021 1:11 AM<br>
<b>To:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; amd-gfx@lists.freede=
sktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: fix fence calculation</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 12.05.21 um 21:45 schrieb David M Nieto:<br>
&gt; The proper metric for fence utilization over several<br>
&gt; contexts is an harmonic mean, but such calculation is<br>
&gt; prohibitive in kernel space, so the code approximates it.<br>
&gt;<br>
&gt; Because the approximation diverges when one context has a<br>
&gt; very small ratio compared with the other context, this change<br>
&gt; filter out ratios smaller that 0.01%<br>
&gt;<br>
&gt; Signed-off-by: David M Nieto &lt;david.nieto@amd.com&gt;<br>
&gt; Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b<br>
<br>
Looks good to me now, but the automated tools complain about &quot;DOS line=
 <br>
endings&quot; plus a couple of other nit picks and won't let me push it :)<=
br>
<br>
Please use the checkpatch.pl script found in the Linux kernel to fix <br>
those errors and resend.<br>
<br>
Thanks,<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 17 +++++++++++++=
++--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |&nbsp; 1 +<br>
&gt;&nbsp;&nbsp; 2 files changed, 16 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ctx.c<br>
&gt; index 9036c93b4a0c..b919615e6644 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; @@ -652,12 +652,14 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *=
mgr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_destroy(&amp;mgr-&gt;l=
ock);<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_=
entity *centity,<br>
&gt; +static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdg=
pu_ctx_entity *centity,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ktime_t *total, ktime_t *max)<br>
&gt;&nbsp;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ktime_t now, t1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i;<br>
&gt;&nbsp;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; *total =3D *max =3D 0;<br>
&gt; +<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; now =3D ktime_get();<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; amdgpu_=
sched_jobs; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dma_fence *fence;<br>
&gt; @@ -703,11 +705,22 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu=
_ctx_mgr *mgr, uint32_t hwip,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idp =3D &amp;mgr-&gt;ctx_han=
dles;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgr-&gt;lock=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idr_for_each_entry(idp, ctx,=
 id) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ktime_t ttotal, tmax;<br>
&gt; +<br>
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
</body>
</html>

--_000_BYAPR12MB2840EA2467563CF0293F2CDEF4519BYAPR12MB2840namp_--

--===============1371593282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1371593282==--
