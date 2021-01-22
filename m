Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFCAC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 12:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0943421D7A
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 12:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0943421D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902C16E9DE;
	Fri, 22 Jan 2021 12:35:25 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4DBD6E9DE
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 12:35:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OoHU/i0iH83L+/0TNa6OkOb3Og1nNcjZU5yLTTtbtAH2Eh182KD4OS7FDI/pViwQ4c+Oy/hWPL0NI2QPdRwqeoDoQYbAe00qErhQehSGBLy1cwG6Cc8KqNgjZdvdG1GiPD+RInwk2g7sGNvQLj8OL+ZshJNd8hau1rX8BBSH09Q35m/f+8wt5SiGCiNKZRgnmOkLmcT94dZ6np+IdqEr2NAwn/2ieXY+2i1yPgaXD2UN72PlStQSuSJZN+B2WLmiu41sbUu/xTVjGmxyEMBJpA1VfgufjRZzcqw2ps4p9k09Chv0cspT7CH+BCnAgzRG/mBH6R9L7O4XOQh+sL7IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojixRwj61ah2x54VXHrLLKmRdJCmCgHIcm0+a1DsXVk=;
 b=Gep4QnjDEFfUbLd5j5laBNgaB7Rl4Y/t97caVx2FdYZt1Q42q/dkFISBKqQU17VSm3Ppxv+/l3nSxyeF+5v4l/1kZGhoX4uIjBt5qat1XNVB4NOxdyEPiGG79E5a1eAlZI/y+kSQ0TSSjll86aTSe8I9lMszRQhLRSlB+0PrG8B2QITgsNFeC6ogjwm3qmHJZWb3rHZ6geANeGYxwd74nACi0SsOJR2ozScGJ7tuVbGVLc8Wv3IhVJYNFzL+4bzC5nXsW9ASaZopaiwEp1F/wOvVh6MKJD4fAEExOw5BVvcf+pEGeWHPNn2QRNWsKu/sRxrj5Ava459ouRsbr5lEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojixRwj61ah2x54VXHrLLKmRdJCmCgHIcm0+a1DsXVk=;
 b=MW++0gk7+GfulUOT8DO7XBa8Jyu0xU5PaIFroW22CgPGI1K0gi1Pl+qffo70xiBGc0/GTwosL8rstIT9mFMsF57teGNfXEbJ9ytZ3yaA11NbMw4EIqqvu5Lri13u8WJQbYithpqdcndUXQttA89KxcMAJ+IAVKNGU1QxcuSDvKc=
Received: from BYAPR12MB4629.namprd12.prod.outlook.com (2603:10b6:a03:111::11)
 by BY5PR12MB3828.namprd12.prod.outlook.com (2603:10b6:a03:1a4::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 12:35:20 +0000
Received: from BYAPR12MB4629.namprd12.prod.outlook.com
 ([fe80::353b:92ce:366a:8874]) by BYAPR12MB4629.namprd12.prod.outlook.com
 ([fe80::353b:92ce:366a:8874%7]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 12:35:20 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Thread-Topic: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Thread-Index: AQHW8J1MU4A6jX24jUSQqTeapCAHV6ozWciAgAAHzoCAABaT4A==
Date: Fri, 22 Jan 2021 12:35:19 +0000
Message-ID: <BYAPR12MB4629D3CC9D27EFB62C59B598FBA09@BYAPR12MB4629.namprd12.prod.outlook.com>
References: <20210122090059.851508-1-Lang.Yu@amd.com>
 <20210122090353.GB735357@hr-amd>
 <CY4PR12MB1287269C14BF57706BCCC78AF1A09@CY4PR12MB1287.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1287269C14BF57706BCCC78AF1A09@CY4PR12MB1287.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-22T12:35:17Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a1bfa3dd-21b7-4468-974b-ec82551fa343;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 686d0652-e044-4691-31aa-08d8bed22e55
x-ms-traffictypediagnostic: BY5PR12MB3828:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3828425B9213060062620CC2FBA09@BY5PR12MB3828.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ev2qPl8slJreDrsKeV1oaTo2JuADLZH8bjEOyomtBgT3LSoE+1/Ilg4PJ+i4MOH6lSuuZQBSnKpJLDqPK0DhjRYNIsvf2c+S2lFIg86Rrw4LXNtcJRkZDOxsf/SGL/laXsRYoc2Rlrl1RuTgqH4orl43B9AB/dxTqdiRidAGSDQY28Qe0cBL0NvZFlgKMs7ANtcRMk6U5yPfI5Tiei93jVjwWKJ2t/3GW7jbPdTb2GrtD98odSB/Nrr4w8SRFxF3h/Jq+uXWcF2ShD43Ggfgel5xqeMuMfSoOs//GGLggl7Gc6jrPx6Pql13GsCdmQcYfp4zhYVvsk24Vg14//VNoZG5I7VaVh+vntkY5vnTAr/p/0DHvnI8Suef88UFVmTZ6/RZUstpB1kwWh9JgmQdmmoS5IMJ0ixvLhHHMQ/ifTE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4629.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(966005)(478600001)(71200400001)(4326008)(45080400002)(33656002)(8676002)(316002)(186003)(110136005)(53546011)(8936002)(54906003)(7696005)(6636002)(26005)(6506007)(64756008)(66946007)(76116006)(5660300002)(66556008)(83380400001)(86362001)(2906002)(9686003)(52536014)(66446008)(66476007)(55016002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0KCV5A+CZjlJ307fPNFuR9rhaFR/b/qB1zeMrtoAWxdt/hfDE9SCB10HSfT1?=
 =?us-ascii?Q?fVriGedUdJXa/428ptQDa2mRydpFwJdlPTRbEc0ThyiIx64FBVVep3XS7vO6?=
 =?us-ascii?Q?oB4yKcairVh8fnebgNG9JS09El78NcJOoKLNT2I/ItZLd7XnVhlxrVGAvTem?=
 =?us-ascii?Q?7gI9T4KEmaMmGbxdhxhL2jl6PlChkuOpuoAAF1U03yB9nZNzqwtTNkdBy8fc?=
 =?us-ascii?Q?lRPKzcy9aZxW6ZD+WMDq8EWfjK6iPbvnPIltiLwYx9N/5PsbvyGPjXtHQYwR?=
 =?us-ascii?Q?p5dFO3n6F/78YKeEW16Ye0pCVkImB44sSWW8gm1FeGyx34juEo3QMxrHj91x?=
 =?us-ascii?Q?MRvmtqERlnalvTihGWayuhhtOIkjZuHgpZZX9Hz8DfYhZwUPizkX/H1eUSTU?=
 =?us-ascii?Q?BChKPYWBe2jt0XF2IB/G+MZO617aQrAxViLEDSej0q2AZ3wHKCzfJL60a4R/?=
 =?us-ascii?Q?2Z6ElzrISqODtFpOHIWCF3Rqe/tPGgtpNCiDZEyHe9bK4dZZ8XLs0KzEbNMX?=
 =?us-ascii?Q?a9LjSdHlZj4G05q+3goZYFEfO/07eEBTjYQLw8cr1ILSd8m9yg7sGQSnr3wg?=
 =?us-ascii?Q?/01yWzXhEoQqh4L0xkuoco1hqhWjNoDik58dS7HjexTyA5D2zjgNa3Sd+5z3?=
 =?us-ascii?Q?DKX3lL2Swvo11SyZqB3ui7M+tU+YB/AInkdbmRiIMGAZkBf1DIv6UOntNydl?=
 =?us-ascii?Q?ESJxptJ9RGlpIOCSqQvt4pFPKhWUMChGai9M1U84YEyeZgm/mpb20ksrEMXp?=
 =?us-ascii?Q?QmsccigOdCuyHSZKR1UmhuvKrCt2C877a3lx5JguueAQmG3BNCCYoxVGe1Ij?=
 =?us-ascii?Q?uoDtH4dLcR/vUvQdB7nS943k0tOvDYmYE6tLB5ZMAmhu4MWB1UFVicoiaKNn?=
 =?us-ascii?Q?SmDzzp9L8L/b5R72u0wV66NAoXmIGIM5oCboZUu6d9n9Sy/RyZpjKA9Ule0i?=
 =?us-ascii?Q?QswFbuCgacjCELGOCKCUrYzL5EMFEIHMXQIa4A9j3YI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4629.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686d0652-e044-4691-31aa-08d8bed22e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 12:35:19.9491 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Rp4rfpuyt0vzHlNP7w5hTab9UAxaYVNYmmvbTUfSCRuaJsSTHMmSxYjGRxr6/LKxtdSFHf1TQxg+FOamUrIFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3828
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]


The header <linux/math64.h> has been included by dm_services.h. The following is the sequence,

dm_services.h -> dm_services_types.h ->  os_types.h  ->  drm/drm_print.h -> 
linux/device.h -> linux/pm.h -> linux/timer.h ->  linux/time.h -> linux/jiffies.h -> linux/math64.h


Regards,
Lang 

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Friday, January 22, 2021 5:32 PM
To: Huang, Ray <Ray.Huang@amd.com>; Yu, Lang <Lang.Yu@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue

[AMD Public Use]

Maybe it's good to modify subject to " drm/amd/display: fix 64-bit division issue on 32-bit OS"

And if header <linux/math64.h> should be included?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Friday, January 22, 2021 5:04 PM
To: Yu, Lang <Lang.Yu@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; amd-gfx@lists.freedesktop.org
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
> @@ -772,8 +772,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>  							cursor_cache_enable ? &cursor_attr : NULL)) {
>  				unsigned int v_total = stream->adjust.v_total_max ?
>  						stream->adjust.v_total_max : stream->timing.v_total;
> -				unsigned int refresh_hz = (unsigned long long) stream->timing.pix_clk_100hz *
> -						100LL /	(v_total * stream->timing.h_total);
> +				unsigned int refresh_hz = div_u64((unsigned long long) stream->timing.pix_clk_100hz *
> +						100LL, (v_total * stream->timing.h_total));
>  
>  				/*
>  				 * one frame time in microsec:
> @@ -800,8 +800,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>  				unsigned int denom = refresh_hz * 6528;
>  				unsigned int stutter_period =
> dc->current_state->perf_params.stutter_period_us;
>  
> -				tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
> -						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
> +				tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
> +						(100LL + dc->debug.mall_additional_timer_percent) + denom - 1),
>  						denom) - 64LL;
>  
>  				/* scale should be increased until it fits into 6 bits */ @@
> -815,8 +815,8 @@ bool dcn30_apply_idle_power_optimizations(struct dc *dc, bool enable)
>  					}
>  
>  					denom *= 2;
> -					tmr_delay = (((1000000LL + 2 * stutter_period * refresh_hz) *
> -							(100LL + dc->debug.mall_additional_timer_percent) + denom - 1) /
> +					tmr_delay = div_u64(((1000000LL + 2 * stutter_period * refresh_hz) *
> +							(100LL + dc->debug.mall_additional_timer_percent) + denom - 
> +1),
>  							denom) - 64LL;
>  				}
>  
> --
> 2.25.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7Cd61b9d6686b64c78d73b08d8beb4ac34%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637469030487750031%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=zKx39HfCyPJmDR9NH1r0Vtap5HBImUxVBae7h1ORhUA%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
