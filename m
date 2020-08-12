Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A832C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5AF2080C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 12:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dAtOlR2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5AF2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE2C36E0DA;
	Wed, 12 Aug 2020 12:43:47 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700048.outbound.protection.outlook.com [40.107.70.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD876E0DA
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 12:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbabyEJYpn5lyNruorYUjPVgPucgNkLE4E273Vnb8BMdH+CMvpvC1k2TWNwjfXt/IAtaKyEI+Hg7g1XbctBu8Ybg9ClgM0Vt/cypYM5xec/B1xWM3Z7JKk0WnDKay7wCve7lY/r1Q//36x2QSZrpvoIyjb5RcwyjAzvCr0uMJcbzyHt/p7D1F9I3JKVWEAVvKgO6eFrkAHRBrq1QB59/+w4PnDJ2+EM6fCnT6QEGV9u3ufyKSEoxbzZ/5yiAJxf0Nec4eQOygKxUKLG85s2UBTel4dP9Ala97iSwMSnsN9jBjAkh+IMG+1vmCbLDGzwsz4gvu/f91GvUqO7rKRyRhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4MY3+fRa+jA8zXXzRtKdI5D/ukKu5sbHt+GDqBZ0r4=;
 b=HpknYzlZViW02z6H6x9PAXz1ZAQpdS5+vBL+8Dsav5ZJwVrVSrycdCtku2XGggf26MOTUlaHR/IOt9xyGYy8fFNrxAovYbFYVQ8B/Xh8Wn66WKqmYEhkj0AI5eN6niiAd78k2NT0qKPPzpGXoausRczFKCtfqbilcPQIeMxLKmxXYxtfTdMPY6XPCcDkLUVBZxPdLNNe5S5wP29zytSpdwyX3XRWCZrXlAZda1EN14GTxRSzq8W+WlIvJlZqMk6M4JLwfskQBde+jBX0AAv2HzQzrDridpaGaMeaBhV5ExBlFZiJ991eol2es1KPbw43OQV5ZuXuRqvuIiSy8DMjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4MY3+fRa+jA8zXXzRtKdI5D/ukKu5sbHt+GDqBZ0r4=;
 b=dAtOlR2DpdYZn3BuKOsIK1nBDvayej/5xlHlQkpyt2wr4Oz6t8V5ZIizekA68xNMWv8kJ6HAIHOOk/0/4cWbv/EYhjR+7+dNkfzoYUeyPTPVgy2ZL1botnD36gPRDFS0N0CbZ5Ob4xjomV3DWtBaTSnbRK40Y1d6xDh2Ff8UDH4=
Received: from DM6PR12MB3547.namprd12.prod.outlook.com (2603:10b6:5:18a::20)
 by DM5PR1201MB0153.namprd12.prod.outlook.com (2603:10b6:4:57::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Wed, 12 Aug
 2020 12:43:40 +0000
Received: from DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a]) by DM6PR12MB3547.namprd12.prod.outlook.com
 ([fe80::446f:752b:f450:e89a%5]) with mapi id 15.20.3261.026; Wed, 12 Aug 2020
 12:43:40 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Das, Nirmoy" <Nirmoy.Das@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Topic: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arcturus
 ppt driver
Thread-Index: AQHWcKMBwaE+m4TZeEmsKDw7aj6cEak0aigAgAAAxyI=
Date: Wed, 12 Aug 2020 12:43:40 +0000
Message-ID: <DM6PR12MB354731EA392327C552D5083BF7420@DM6PR12MB3547.namprd12.prod.outlook.com>
References: <20200812122030.215907-1-tom.stdenis@amd.com>,
 <6352188c-e508-37d4-a021-02c31e6ca855@amd.com>
In-Reply-To: <6352188c-e508-37d4-a021-02c31e6ca855@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-12T12:43:39.764Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.84.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5644d96-cd8e-4eb9-0851-08d83ebd5705
x-ms-traffictypediagnostic: DM5PR1201MB0153:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB0153D15D1E12C60B355C75B3F7420@DM5PR1201MB0153.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:628;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Xievb+9Et75EYRX3EFMtIRujOJ62m9YjdOwCO7ojWnklS/YLbA7QdQ9KYJRoZnwBRaX9lFWeYwNcYdoyD3wgPTIIc8Lp/rg1sVU6rzQ12/dSDN1QqQVaNRjeSyp4t6o80xzQrz2lXLyZ+GMERF5pm1hZD+O/5xctlGie/6vZYvY6cUpkJ+/S0HD6PeoazP2Q8yvh1pjvmBl3fmufSYQa/FmQ02I8FQi4OPhc7RTDcbnjOW3CyEPp/t0LadOVZ4X5yJ3ZlkQMYsvQzynzUnIjVZzkG8ft1O9Ja2DF8JHdPfW7T+BaENX7l6l0PUJdsjrQalcmYDhS2wVLfb9Hk7Nzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3547.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(136003)(396003)(376002)(39850400004)(366004)(52536014)(5660300002)(83380400001)(8936002)(55016002)(53546011)(7696005)(71200400001)(8676002)(6506007)(86362001)(66476007)(33656002)(76116006)(110136005)(64756008)(9686003)(66556008)(66446008)(26005)(478600001)(2906002)(66946007)(316002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: kuLh/+evKhbSBZZyxK+mWHf9LLxg7fdKkTT44qVvoLPBDAw0Sys2dBeoEBwwcpsfJCMFf6wiqcXrG+fddIXqLc4DulmzdcasaTqRwyCxAI25HhrLL3Rltonu7ng6TP9zyCuaaDIUbynm25a6aMOhhNeJunDtaWDtPE2cr/jFL2gelcxVs70GejkkFL1ZU6Iw2/gZVb85DWai8UeoDnVZid9HNgrsQlbVlk5Z5RDlio3a8PSEkbHPTp6lSHSo9cWQzDKRTNnz7O9tbxP1cEV5PeyQ0TR8hyQoHmEQVz3Gld2HXg21zp2FCy0X322rZYrSbYS7f6zLURYqy2i2fcQsXba5EHC6XN4NCvkXYPLVgh9F5ndq2b7mqq9XHFNtdwt6hJRUrP/oe+RyBoccT7/uTyqYeO1JraEw2850vVrs4MwlSS/DMOyHsDTBQ0NmOht7gyKqeiRguuuWX3bynaH3nKuvatm/pvUIs4gJERJhSrEFt50i62Vl20XOQC7qUN/O9EsUFcoBq82xQPVKnR+3r3u6N1u+GJl27N88olrr+FdMt7mwVYCR1rcjkZmy+YgpvLciG8loTunYE/YpXjj5O3Nq+CNZTtqigECJhgPyPC5i8/0yBGCiocE9udON97XwCdOStCKdiEgNna/XmrCeXg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3547.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5644d96-cd8e-4eb9-0851-08d83ebd5705
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2020 12:43:40.1994 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjiqK8I3x6vRqJ17UBrHDVzY8LzFGdvRPPs9hICuoi468tFti1LAUJdQ6KaJooofqGyDbsxrhBb3ENONhFfNfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0153
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
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Possibly, but since the arcturus_get_smu_metrics_data() can error out we sh=
ould check that return value no?

(also setting *value to 0 avoids this bug in the future...).

Tom

________________________________________
From: Das, Nirmoy <Nirmoy.Das@amd.com>
Sent: Wednesday, August 12, 2020 08:40
To: StDenis, Tom; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amd/powerplay: Fix uninitialized warning in arctur=
us ppt driver


On 8/12/20 2:20 PM, Tom St Denis wrote:
> Fixes:
>
>    CC [M]  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_mst_=
types.o
> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c: In function =91ar=
cturus_log_thermal_throttling_event=92:
> drivers/gpu/drm/amd/amdgpu/../powerplay/arcturus_ppt.c:2223:24: warning: =
=91throttler_status=92 may be used uninitialized in this function [-Wmaybe-=
uninitialized]
>   2223 |   if (throttler_status & logging_label[throttler_idx].feature_ma=
sk) {
>
> by making arcturus_get_smu_metrics_data() assign a default value
> (of zero) before any possible return point as well as simply error
> out of arcturus_log_thermal_throttling_event() if it fails.
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
> ---
>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/d=
rm/amd/powerplay/arcturus_ppt.c
> index 8b1025dc54fd..78f7ec95e4f5 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -551,6 +551,9 @@ static int arcturus_get_smu_metrics_data(struct smu_c=
ontext *smu,
>
>       mutex_lock(&smu->metrics_lock);
>
> +     // assign default value
> +     *value =3D 0;
> +
>       ret =3D smu_cmn_get_metrics_table_locked(smu,
>                                              NULL,
>                                              false);
> @@ -2208,15 +2211,20 @@ static const struct throttling_logging_label {
>   };
>   static void arcturus_log_thermal_throttling_event(struct smu_context *s=
mu)
>   {
> -     int throttler_idx, throtting_events =3D 0, buf_idx =3D 0;
> +     int throttler_idx, throtting_events =3D 0, buf_idx =3D 0, ret;
>       struct amdgpu_device *adev =3D smu->adev;
>       uint32_t throttler_status;


I think initializing throttler_status here should resolve the warning.

>       char log_buf[256];
>
> -     arcturus_get_smu_metrics_data(smu,
> +     ret =3D arcturus_get_smu_metrics_data(smu,
>                                     METRICS_THROTTLER_STATUS,
>                                     &throttler_status);
>
> +     if (ret) {
> +             dev_err(adev->dev, "Could not read from arcturus_get_smu_me=
trics_data()\n");
> +             return;
> +     }
> +
>       memset(log_buf, 0, sizeof(log_buf));
>       for (throttler_idx =3D 0; throttler_idx < ARRAY_SIZE(logging_label);
>            throttler_idx++) {
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
