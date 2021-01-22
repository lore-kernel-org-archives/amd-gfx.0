Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4EDC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535C223AFC
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 20:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535C223AFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F17F8991A;
	Fri, 22 Jan 2021 20:03:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47B328991A
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 20:03:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0i5qSHooMiU48150RxlsZyhajBk/P8PTLiJc4yHAa4vMCyZMz9kmQS9cpccqIK8k+seixKvFpp756ILVi8pTzycfpvqUY84OjRgszQRTpuKpueSdPK7i2Q/HZQZlOpSbybzLQv/qimGBCXmRJ65xOOMHzO3ny/OwCdKO84lEqs5BrKqWzCemc7ewmsiz0kB3PCdcKc9WjK35bG3S1kpL4AJtI9B9I+kMzrxv7qwUXMqwdbccMnyhPiL66PWxt2crp7B8Sx0LSB3Q5atH7Koyn/yGdDQ2RbB7iUYZNJYkD/54IU5QeZKSdueD8qk+UX65VFKi7f1jbkiWyB7fIjxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oxELoweuH/VElAZ9kMLyvlUGoQ4Lq55+BFeF0cgsEc=;
 b=hQ//e9vv8gSS8BpJxoo24tKLO2eBBkEsbRy2Ba72A6FWbIGjzJ0FuT1ghcTXi74Yjw4qlMZ+IfirggzoA+vHYAUM9g2Lw2/HuF9wPpxS5gmtps+tmxJxUAmSWkX3jQ6ADQdJ1R7hN8TYMzhlv4nL3UIPoL750/ET8A4iiLCYLFIeYQSSWL/r7S6vXrEIvvHCsfi+il1qddhzGvBEdvOh6EGIME91rFZUUx80FUmXLDil3Cm1mEulkhlytaFOqOm4i8lGm3kbzvgPBFeeS0nZ2BxLaSV/1Z/VfCghn063/UJTTgtgjh2ii9vbL7ub/S0PQw1O7vC8yDz/AvW1SeHz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9oxELoweuH/VElAZ9kMLyvlUGoQ4Lq55+BFeF0cgsEc=;
 b=Ud2Q6+xd1xQvCnJMo/coV8h7eFVRvEkGfw7fI2LR/nHl7gVc1CXVsTsbY6ia9P4d2Ul2Qsp1Ys3HIMLHR60jgb6iol8DBbt25340d4ahHx2xkJrfO9QpGYlVXM+aZsphThAS8J8FVNHVTB0dUFBT7MZ41be1ad2DoLFOWDy94gA=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR1201MB0142.namprd12.prod.outlook.com (2603:10b6:301:55::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 20:03:05 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::858e:d929:4fab:5ac3%9]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 20:03:04 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Thread-Topic: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Thread-Index: AQHW8J1OplVWaF8fO0yFO6NYtuw8Z6ozWciAgAAHzoCAADNFgIAAe8/i
Date: Fri, 22 Jan 2021 20:03:04 +0000
Message-ID: <MW3PR12MB455414BD4DE437CC81F6DA98F9A09@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20210122090059.851508-1-Lang.Yu@amd.com>
 <20210122090353.GB735357@hr-amd>
 <CY4PR12MB1287269C14BF57706BCCC78AF1A09@CY4PR12MB1287.namprd12.prod.outlook.com>,
 <BYAPR12MB4629D3CC9D27EFB62C59B598FBA09@BYAPR12MB4629.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4629D3CC9D27EFB62C59B598FBA09@BYAPR12MB4629.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-22T20:03:03.519Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 207a98d3-5970-4b36-7c65-08d8bf10baea
x-ms-traffictypediagnostic: MWHPR1201MB0142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB01420C2A1859D8F8DEE2BB8CF9A09@MWHPR1201MB0142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4RG0MzckSwLfYGR2rqvS6S+3Uz2pv8s4ZlJrepdvXiZTkrVBogTnuLLMjAn+pkHcmepvYK0WnJclMmzkRpQ7xw0egHYP9YcFwoTP+GpkRYR1ZbhZnYW+8FSUevRTyp1RXM2d4jxvM5NJD9DgFEZRKCsqB40tnbk4QEP2r4ETkxVi6O2W06cDMtcdLxl2UNqYeN5Kn5tBWSzWjr/77vEr3eSjn7Lmpk6DDkexy+ebZFC+rrmrFNxxD6PYxvxk5GZjLB3jsB89ITkJRQ5ns5D3wBsugbikkApzVeGkQp5kZKoZHDM68rNFbPpa1ga0LHT4738oEC5udK+Kpve1PpGnqa6eePs+Rx3ZA9lq6oGnMP99tKqDPAuR73bFQFxDRZHsoNzA/LGe5N6uPDsJvQ+m1o8qQJMEO4Z3J7FhTdCfSY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(6636002)(76116006)(53546011)(9686003)(64756008)(66446008)(19627405001)(6506007)(26005)(316002)(54906003)(166002)(83380400001)(55016002)(4326008)(45080400002)(478600001)(966005)(110136005)(86362001)(8936002)(8676002)(2906002)(66556008)(52536014)(66476007)(7696005)(71200400001)(186003)(66946007)(33656002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?75bz3VC0ScEe9jHPRXACSkT0J4igVXxGcDnkGYonGzP4xXsJog8gp8V7?=
 =?Windows-1252?Q?q6YyOyxwggbSiJpy3vG9UEno8awUji0leizdVdGtLcfH16K3dCY4R7pN?=
 =?Windows-1252?Q?wz3da/zxrZdrIelALM4mBYKNTxkfSkN6Lp9PAWt7QFW+FQZEq/5XKLNA?=
 =?Windows-1252?Q?YKmmVyz0WO7ufyJx16nZ4szo5r/DMIXMH5L0ks3uGSP9t59ZsKAtsDot?=
 =?Windows-1252?Q?mDRHjEsWzZsFv3AErrpVpzbVumPjK9bAaUpHLqA3fgw5bO63D3rk/QcE?=
 =?Windows-1252?Q?cPcSjr8Ea7CbA4W4DZ1xVicLDz6ILgC2V/lBf1tfL9ZLuF8ysMQdpaTF?=
 =?Windows-1252?Q?m+w275B+J1+3dJKzCBpBNtdVQo95goeaGp+474R++5p0rvVVUdiJxqaU?=
 =?Windows-1252?Q?yvl+SDAQeoIOOeMW5AXNIWaBg2lfPCAecvTL2L1uxFspDeWZUtqJCl//?=
 =?Windows-1252?Q?L0d46wNmxbC6lXxfo69djBRhS7Ev4u0w0oqrpYkwhhem1jOg356UNTvA?=
 =?Windows-1252?Q?AdywgI1zwRbnY3Juw3PquRAHRhg0NjGnhb2YRBD4Y0XT57jNDsEIzhsK?=
 =?Windows-1252?Q?Pj6rTC/jVDET22DtrVLLkZX3Ge00dUPVcvd+qFIAotFBtgmBlPVukF84?=
 =?Windows-1252?Q?jxVeQyOzkLXmXY1PIPzoNQKMi7FQl89Zz+dFzsaa9PZoxhqW5vastdb4?=
 =?Windows-1252?Q?/AaNKkteM5lO5p/wrIqdbdzzZLV+mFaa+gP+A+oofyjoha5e42dpssUJ?=
 =?Windows-1252?Q?It6/3XpsqwJKJcYSbjySO5+XXuFFFCLhh9yxu1NZoOvMuj+YtgNdWHyi?=
 =?Windows-1252?Q?F/Z63iOLCNAuehEqK2stNXFcGx2YfnRAeNy5/E2NZqfnJkkF1en7q37v?=
 =?Windows-1252?Q?wIuqfOjkvT4bTCacm1aUQoNrVlBnxWAyyj2cXOWEY88exF71r4BoX+dz?=
 =?Windows-1252?Q?FrTB53LUz1ra16ym6JGTPX/b/PhdeI3MqPDpmkinZ20vYwJawybJGDT0?=
 =?Windows-1252?Q?/LiGmnScbQ5hrubrj6c2J1+NB+HJbIuE8Gq2WXG1+1Kj8/QMQN14r9vi?=
 =?Windows-1252?Q?FfUVG2a5GkDiDMC2wE1mf7JarWZLemajdBw8FcH05eMMPExe5BO47hux?=
 =?Windows-1252?Q?YQOFQfr29AO93hyKzhfsN3HD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 207a98d3-5970-4b36-7c65-08d8bf10baea
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 20:03:04.8390 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRM9wvy3AYZUhOuoSuWyaUH6assdCnRouIdcXClrLNDTPR9HihddYJBeQI4keL1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0142
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0924695886=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0924695886==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB455414BD4DE437CC81F6DA98F9A09MW3PR12MB4554namp_"

--_000_MW3PR12MB455414BD4DE437CC81F6DA98F9A09MW3PR12MB4554namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Thanks for the fix.

Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>


Thanks,
Bhawan
________________________________
From: Yu, Lang <Lang.Yu@amd.com>
Sent: January 22, 2021 7:35 AM
To: Chen, Guchun <Guchun.Chen@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bha=
wanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freed=
esktop.org>
Subject: RE: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue

[AMD Public Use]


The header <linux/math64.h> has been included by dm_services.h. The followi=
ng is the sequence,

dm_services.h -> dm_services_types.h ->  os_types.h  ->  drm/drm_print.h ->
linux/device.h -> linux/pm.h -> linux/timer.h ->  linux/time.h -> linux/jif=
fies.h -> linux/math64.h


Regards,
Lang

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com>
Sent: Friday, January 22, 2021 5:32 PM
To: Huang, Ray <Ray.Huang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bha=
wanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue

[AMD Public Use]

Maybe it=92s good to modify subject to " drm/amd/display: fix 64-bit divisi=
on issue on 32-bit OS"

And if header <linux/math64.h> should be included?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Ru=
i
Sent: Friday, January 22, 2021 5:04 PM
To: Yu, Lang <Lang.Yu@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bha=
wanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue

On Fri, Jan 22, 2021 at 05:00:59PM +0800, Yu, Lang wrote:
> Replace "/" with div_u64 for 32-bit arch. On 32-bit arch, the use of
> "/" for 64-bit division will cause build error, i.e.
> "__udivdi3/__divdi3 undefined!".
>
> Fixes: 27755cdf83f1
> drm/amd/display: Update dcn30_apply_idle_power_optimizations() code
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index dff83c6a142a..9620fb8a27dc 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -772,8 +772,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *=
dc, bool enable)
>                                                        cursor_cache_enabl=
e ? &cursor_attr : NULL)) {
>                                unsigned int v_total =3D stream->adjust.v_=
total_max ?
>                                                stream->adjust.v_total_max=
 : stream->timing.v_total;
> -                             unsigned int refresh_hz =3D (unsigned long =
long) stream->timing.pix_clk_100hz *
> -                                             100LL / (v_total * stream->=
timing.h_total);
> +                             unsigned int refresh_hz =3D div_u64((unsign=
ed long long) stream->timing.pix_clk_100hz *
> +                                             100LL, (v_total * stream->t=
iming.h_total));
>
>                                /*
>                                 * one frame time in microsec:
> @@ -800,8 +800,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *=
dc, bool enable)
>                                unsigned int denom =3D refresh_hz * 6528;
>                                unsigned int stutter_period =3D
> dc->current_state->perf_params.stutter_period_us;
>
> -                             tmr_delay =3D (((1000000LL + 2 * stutter_pe=
riod * refresh_hz) *
> -                                             (100LL + dc->debug.mall_add=
itional_timer_percent) + denom - 1) /
> +                             tmr_delay =3D div_u64(((1000000LL + 2 * stu=
tter_period * refresh_hz) *
> +                                             (100LL + dc->debug.mall_add=
itional_timer_percent) + denom - 1),
>                                                denom) - 64LL;
>
>                                /* scale should be increased until it fits=
 into 6 bits */ @@
> -815,8 +815,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc,=
 bool enable)
>                                        }
>
>                                        denom *=3D 2;
> -                                     tmr_delay =3D (((1000000LL + 2 * st=
utter_period * refresh_hz) *
> -                                                     (100LL + dc->debug.=
mall_additional_timer_percent) + denom - 1) /
> +                                     tmr_delay =3D div_u64(((1000000LL +=
 2 * stutter_period * refresh_hz) *
> +                                                     (100LL + dc->debug.=
mall_additional_timer_percent) + denom -
> +1),
>                                                        denom) - 64LL;
>                                }
>
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cguchun.c=
hen%40amd.com%7Cd61b9d6686b64c78d73b08d8beb4ac34%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637469030487750031%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DzK=
x39HfCyPJmDR9NH1r0Vtap5HBImUxVBae7h1ORhUA%3D&amp;reserved=3D0

--_000_MW3PR12MB455414BD4DE437CC81F6DA98F9A09MW3PR12MB4554namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks for the fix.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
Reviewed-by: Bhawanpreet Lakha &lt;Bhawanpreet.Lakha@amd.com&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks,<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Bhawan<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Yu, Lang &lt;Lang.Yu@=
amd.com&gt;<br>
<b>Sent:</b> January 22, 2021 7:35 AM<br>
<b>To:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;; Huang, Ray &lt;Ray.Hua=
ng@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lakha, Bha=
wanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; amd-gfx@lists.freedesktop.org &=
lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd/display: 64-bit division on 32-bit arch=
 issue</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Public Use]<br>
<br>
<br>
The header &lt;linux/math64.h&gt; has been included by dm_services.h. The f=
ollowing is the sequence,<br>
<br>
dm_services.h -&gt; dm_services_types.h -&gt;&nbsp; os_types.h&nbsp; -&gt;&=
nbsp; drm/drm_print.h -&gt; <br>
linux/device.h -&gt; linux/pm.h -&gt; linux/timer.h -&gt;&nbsp; linux/time.=
h -&gt; linux/jiffies.h -&gt; linux/math64.h<br>
<br>
<br>
Regards,<br>
Lang <br>
<br>
-----Original Message-----<br>
From: Chen, Guchun &lt;Guchun.Chen@amd.com&gt; <br>
Sent: Friday, January 22, 2021 5:32 PM<br>
To: Huang, Ray &lt;Ray.Huang@amd.com&gt;; Yu, Lang &lt;Lang.Yu@amd.com&gt;<=
br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lakha, Bhawanpree=
t &lt;Bhawanpreet.Lakha@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Subject: RE: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue<=
br>
<br>
[AMD Public Use]<br>
<br>
Maybe it=92s good to modify subject to &quot; drm/amd/display: fix 64-bit d=
ivision issue on 32-bit OS&quot;<br>
<br>
And if header &lt;linux/math64.h&gt; should be included?<br>
<br>
Regards,<br>
Guchun<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Hu=
ang Rui<br>
Sent: Friday, January 22, 2021 5:04 PM<br>
To: Yu, Lang &lt;Lang.Yu@amd.com&gt;<br>
Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Lakha, Bhawanpree=
t &lt;Bhawanpreet.Lakha@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Subject: Re: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue<=
br>
<br>
On Fri, Jan 22, 2021 at 05:00:59PM +0800, Yu, Lang wrote:<br>
&gt; Replace &quot;/&quot; with div_u64 for 32-bit arch. On 32-bit arch, th=
e use of <br>
&gt; &quot;/&quot; for 64-bit division will cause build error, i.e.<br>
&gt; &quot;__udivdi3/__divdi3 undefined!&quot;.<br>
&gt; <br>
&gt; Fixes: 27755cdf83f1<br>
&gt; drm/amd/display: Update dcn30_apply_idle_power_optimizations() code<br=
>
&gt; <br>
&gt; Signed-off-by: Lang Yu &lt;Lang.Yu@amd.com&gt;<br>
<br>
Acked-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 12 ++++++--=
----<br>
&gt;&nbsp; 1 file changed, 6 insertions(+), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c<br>
&gt; b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c<br>
&gt; index dff83c6a142a..9620fb8a27dc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c<br>
&gt; @@ -772,8 +772,8 @@ bool dcn30_apply_idle_power_optimizations(struct d=
c *dc, bool enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor_cache_enable ? &amp;cursor_attr :=
 NULL)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int v_total =3D stream-&g=
t;adjust.v_total_max ?<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; stream-&gt;ad=
just.v_total_max : stream-&gt;timing.v_total;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; unsigned int refresh_hz =3D (unsigned long long) s=
tream-&gt;timing.pix_clk_100hz *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100LL / (v_total * stream-&gt=
;timing.h_total);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; unsigned int refresh_hz =3D div_u64((unsigned long=
 long) stream-&gt;timing.pix_clk_100hz *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 100LL, (v_total * stream-&gt;=
timing.h_total));<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * one frame time in microsec=
:<br>
&gt; @@ -800,8 +800,8 @@ bool dcn30_apply_idle_power_optimizations(struct d=
c *dc, bool enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int denom =3D refresh_hz =
* 6528;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int stutter_period =3D<br=
>
&gt; dc-&gt;current_state-&gt;perf_params.stutter_period_us;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tmr_delay =3D (((1000000LL + 2 * stutter_period * =
refresh_hz) *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (100LL + dc-&gt;debug.mall_ad=
ditional_timer_percent) + denom - 1) /<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; tmr_delay =3D div_u64(((1000000LL + 2 * stutter_pe=
riod * refresh_hz) *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (100LL + dc-&gt;debug.mall_ad=
ditional_timer_percent) + denom - 1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; denom) - 64LL=
;<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* scale should be increased until=
 it fits into 6 bits */ @@<br>
&gt; -815,8 +815,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *=
dc, bool enable)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; denom *=3D 2;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tm=
r_delay =3D (((1000000LL + 2 * stutter_period * refresh_hz) *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (100LL + dc-&gt;debug.mall_additional_timer_percent) + d=
enom - 1) /<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tm=
r_delay =3D div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; (100LL + dc-&gt;debug.mall_additional_timer_percent) + d=
enom -
<br>
&gt; +1),<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; denom) - 64LL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; <br>
&gt; --<br>
&gt; 2.25.1<br>
&gt; <br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Cd61b9d6686b64c78d73b08d8beb4ac34%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637469030487750031%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DzKx39HfCyPJmDR9NH1r0Vtap5HBImUxVBae7h1ORhUA%3D&amp;amp;res=
erved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cguchun.chen%40amd.com%7Cd61b9d6686b64c78d73b08d8beb4ac34%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637469030487750031%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3DzKx39HfCyPJmDR9NH1r0Vtap5HBImUxVBae7h1ORhUA%3D&amp;amp;res=
erved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB455414BD4DE437CC81F6DA98F9A09MW3PR12MB4554namp_--

--===============0924695886==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0924695886==--
