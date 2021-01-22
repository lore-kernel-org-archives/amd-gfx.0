Return-Path: <SRS0=42b/=GZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5752DC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C5E20739
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jan 2021 09:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C5E20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70D716E9CD;
	Fri, 22 Jan 2021 09:31:53 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A9176E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jan 2021 09:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eB+C2zhz8VL4CuzMjX5jLU8rRCHRkC3KETct49wy5I0qb0U853gwOwiq2evt9OlcESzZsAPC7q3kEJrqO0az5DC1BY44jWnmxpu2oBUTHWmU0ipsZDThuO69QJgE235HENsLnHJgUVNmT4cGhDTFIk/Ns3C+wkpCkiXKTx07TH7XnWJXCM9AWU7+Xx+xGZjspOCRwiRPyeCXD41VMNKd1jsLskTj0xKKWRJ9ivZmL/RrxnR9kT+RqLEfSX2M/doQhcAKwHqJVVzHaTvwa0vlTcn8MoRt68g+NSt5Dshe4xk7Xxn8F7ur0emk1n5qOml+oxh4f8lAva9vs14jqdNqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHWW5IceaUoUD11rcESogwVGpxMl84ymfLkwhtD8ZM8=;
 b=Mt6OFniV13HXktzNJ2iqtjXpSMoh7IVXebguT9or3v+lyuzrHQTnYgbwZ2u/I/vmI+MI5wf8V7y8A7pXwySyQk48AkQZePL7WZehopCfZo1qs8uDWkdVnL+mmv8RevfncNhjL3lsBABL8ebD6YXaz8dJP2zNjS2YjQAp2X6YSaCOCmtFnL+IDynmXZJWtW4i0GLXlr4WzpT8DnB7yhzHUhLoaDf4yLWsFQ+aiN8ZP7CWFWC9gkqgPRrTUcyJHq2b4dM1na3XhzXPH83iuMZjKoTQ8klQAJsG+0MvW4W92iRuV2YsEHGjAfcijcsVua20zWupu3cQU4AlYvtrXsI8yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHWW5IceaUoUD11rcESogwVGpxMl84ymfLkwhtD8ZM8=;
 b=SoDksfheMT5Fh+00a/1qMWmRT7Jsb8YWr6s88mhO3oPq4B/JyIerMRaJJNivUZxlkXpBuz+1HeroYD50HTUSDKJY6nyXGjmvhGhIq75nanRNQZICVkN/w1uMmgqCmtLphjmPm9YGrNeyARFFdIKQUuRSwpLznSf4iu9fmCqH4dQ=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB0038.namprd12.prod.outlook.com (2603:10b6:910:19::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Fri, 22 Jan
 2021 09:31:49 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::bc0f:dd2:ef80:de2%12]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 09:31:49 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>
Subject: RE: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Thread-Topic: [PATCH] drm/amd/display: 64-bit division on 32-bit arch issue
Thread-Index: AQHW8J1TBgoio5S+3UGEQz0nVCT6GqozWciAgAAGu0A=
Date: Fri, 22 Jan 2021 09:31:49 +0000
Message-ID: <CY4PR12MB1287269C14BF57706BCCC78AF1A09@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210122090059.851508-1-Lang.Yu@amd.com>
 <20210122090353.GB735357@hr-amd>
In-Reply-To: <20210122090353.GB735357@hr-amd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-22T09:31:47Z; 
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
x-ms-office365-filtering-correlation-id: 1a99ed07-33b9-4260-dd61-08d8beb88b73
x-ms-traffictypediagnostic: CY4PR1201MB0038:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB003851362CA4E2485E15D02CF1A09@CY4PR1201MB0038.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fz8WEo2ROdGDQAlNOsBlMabSrpgzw1yWyE2B015Pdc+xQNxaeJvXN7vBVPutJfO7jpixkABR/wjMX3kOpFn29y36F/g3k75wcCdGca80TWFBdhMDp2NrV9X8PQoRjgZ6IPfiCjPCTVxYXpereNCVemPoKqfDgb70zPagMUD/L2NfxCZv/cKurFBW32XWk13RLiciZYrIIJp5RzN700zunesUvkWi3uUdSjqqYNOLBVT7MVwNl8V9mZZDCfaXW+qjzmBYi1OpDJ3BNqha2cIdrlGjzQ+iQ3bxjbsnblg+mswF2F6k+OfnVUKJIK7lC4IbueHLITzzxiHlFf7nvhgQcufvJeSPgy7T/aDw7OnMQqkZuyFHFIFGY7cE5Frh86+/BPRBzXb9HZWz1W8M0oRq7uSyKWuy2pvMwVJi2ZBTuCM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(83380400001)(7696005)(53546011)(110136005)(5660300002)(86362001)(64756008)(966005)(6506007)(66556008)(66446008)(52536014)(33656002)(478600001)(66946007)(2906002)(54906003)(8676002)(45080400002)(26005)(66476007)(76116006)(186003)(71200400001)(6636002)(55016002)(9686003)(8936002)(4326008)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2pwItF9CUJSuBz4I39GKwfKcVkLLsV1I1TBK88q/OSIBZAI76/meeLv1fzgD?=
 =?us-ascii?Q?41TmWisvn4JwfA7izgBGm2zEVXCOPIWl8yiEgLgmvkrdAgtMYAG8PHbN5RFj?=
 =?us-ascii?Q?QmR4x4dI40yMKagNFRUfzi7eDgUOmSNkvr+V0tCBADtS/vLdzSwZtKQakUiP?=
 =?us-ascii?Q?xpJv9jbHuLWjYqtD6KtP75o2VJoCKlMDjxv/STA+QaVggIx4c2MuyJgdJZm/?=
 =?us-ascii?Q?l7hVQeCxgn/U+Z0DX7o0lqM4Lvy5/9gvHd+BUOCidHdXKcfdMvlm8+1Gut0e?=
 =?us-ascii?Q?QUXem6lSOcxhod2ED5Nyy4ncxudHQLuWkTBRBVCnIWzK97lPuM6/qjCpeoH0?=
 =?us-ascii?Q?LXwp1pag3w3PHKlSVJ9ClnbNADN28I7BcvevM8goIZ+4ic5qkunQrZWHAANn?=
 =?us-ascii?Q?7uptuUYoJzzKuW3SEYYh4h3MKvh1Iv2jV5MM3sXzaHt3ARaHNZxOsDjcRbPR?=
 =?us-ascii?Q?XyYuaLazYMhFN3HqQsosfT1oyfWZ1QzUS5XiyRg3mlKrV4eYNOf+gyB321+8?=
 =?us-ascii?Q?AlX6L1qRYrXGxIj8e9W9PHD1ks1JKmrpOeAi2ui2Uoyr7ct86AaRiqGNV4X2?=
 =?us-ascii?Q?Nsxy+Cpxz3p09KrvA01G+eIU5uXceQqYcozs50H7fk37nM25HcbJmcpsvk50?=
 =?us-ascii?Q?hdw5c+P5AxyYqDrYAEQk3M/3Z9MmIoUbAAF//Sa6jW9QyX2KzTCmhGFUwDs4?=
 =?us-ascii?Q?VtxMPzuOolEGgXcJKJthbzl5xzjlYPLmoL850Uov0sqmTZxks2jjEgN3v6xS?=
 =?us-ascii?Q?o0+mkHSqtdgnDwSqGtqdofu8NBDAxhp8o3AgL1m6YVyyTQB3UZ986TcOA4ZX?=
 =?us-ascii?Q?bR/Dqvy9UnFMQaIJCgni+1d2FqaZVHVbsVNc1mRl1nceWm8Fo4OkNH75Ftip?=
 =?us-ascii?Q?7S64oxN66+oxvHd/q1BkHRKCTntSX2bP7c53XO337CakCDo5lSNpG9sGXLlA?=
 =?us-ascii?Q?5crvCF8tBSTsc+sLbwt00Ndy4PjVxHEN16pRzuOGFew3T+uh6eG4Ga1rtLcN?=
 =?us-ascii?Q?rrI+LcvgzurqE8B9GmnDyluBidtlhqVPxjn4Mf4LnjnZ6arMIrZLmbBUKsvS?=
 =?us-ascii?Q?K0CS+wbU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a99ed07-33b9-4260-dd61-08d8beb88b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2021 09:31:49.5191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6BaZpa7W4BIbrLsuH2MT7874ya3koHjarWtE8GdiwfJMUXmtbtreowfXPAfXq9Rp0GqtAMOzUMpvbmPpmK+/iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0038
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
