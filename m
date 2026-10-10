Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C94CA9EBB
	for <amd-gfx@archiver.kernel.org>; Sat, 10 Oct 2026 02:43:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDE010E698;
	Sat, 10 Oct 2026 02:43:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HcypmL0Y";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010054.outbound.protection.outlook.com [52.101.85.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C2410E698
 for <amd-gfx@lists.freedesktop.org>; Sat, 10 Oct 2026 02:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIwhD5oupm0osjyFjq8fpCU7sPKyXCCGPlia+zXMjb01+k5QBp0EhsAvMCBjt/Q48rS3iJ2iAHFxJlxudji2XnQ1kHF8wbRh+iLkQrfOrUSwZvlCqPUF8jMgx2ipVXwQ/DGiyFy/ue+oKGgrgaCCsWcvVs+Q8jIs3RyGCgXdtLqcibNdrsXzS4qK+GmJVWzhTZW6fnoMJrcVZx8tMgJj2yJtJqTyNQaHxIHailRRzWnFkFCzlOpqk0YVn8pJxDPZlepBNFrkXfeypmljA/oi9OL9tuX5QDTMZ3epx5X5ChPx1hOkMvcDsvzZjj4mgw85y3ypimDZQhFFJUDkd7GdlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iy6p9dNa/eD4djoW9Hz+wTLDjqka3wwMaEjmAdBU4U=;
 b=ZwkzQTyqMRg2bEUUfKjhH+caq4ID0XllGYawTnbHWtpRh1/RhrY52vJsccTdZLndntkHK0i1t2470SX5XrTdMw6mM+IWSjQKMNQXDuMpSeZm9AMGaanzMcNLnllM4gKwRfNY9+TMC20DNti9c0Km2y9i+GqKCGxBW5a4UN6pz1ZmKcQxmVBzOwr6+VHNgSsktcxCDnp88UnQyGlIA1PzpGJOXb4xLwUk+3zMU+dj8bAqZFXLVR/qAT3T5hpI4YPoTb2iKbDSRmFKsgivBEr/fFYu9dH40zbSshVhGdAWbBTR+gjwECLNQ4DF0urzuL42eP+q34LhI7j+sdsL0odW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iy6p9dNa/eD4djoW9Hz+wTLDjqka3wwMaEjmAdBU4U=;
 b=HcypmL0YHLtAMDsKrRCWA7amcTQlVh8MbTmgtQiNK4FFCIDCMCeW2o4R7sW3scRaUDscNfrllM5saq5lWev3gvxmgitw5MlG5nMFa0Sjcr+kEJzZB+vtAnTzplk5YNfmM4ddFYtYY/8CgOAK4SuXQjZ6i41JHrOj+/Yl1WlDdyk=
Received: from CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Sat, 10 Oct
 2026 02:42:56 +0000
Received: from CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85]) by CYYPR12MB8729.namprd12.prod.outlook.com
 ([fe80::1f0c:463f:a438:d85%2]) with mapi id 15.21.0451.026; Sat, 10 Oct 2026
 02:42:56 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1
 IP_VERSION(13,0,12)
Thread-Topic: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1
 IP_VERSION(13,0,12)
Thread-Index: AQHdWA4lzL9iaJo57UKRbr0uJBFuCrb2CbjggAAHhOA=
Date: Sat, 10 Oct 2026 02:42:56 +0000
Message-ID: <CYYPR12MB8729B2A6097AC6E2EDD51066B0912@CYYPR12MB8729.namprd12.prod.outlook.com>
References: <20261009164906.206393-1-cesun102@amd.com>
 <CYYPR12MB8729678CA60FD006F6E21E80B0912@CYYPR12MB8729.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB8729678CA60FD006F6E21E80B0912@CYYPR12MB8729.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-10T02:13:18.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8729:EE_|DM4PR12MB8498:EE_
x-ms-office365-filtering-correlation-id: 72f0fcb6-dad4-4ba1-4641-08df267830cb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261009223027099003|38070700021|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: CaPe3g409UBa36PbAU6Oq8/Plou7nPz/MkFxw0NeFM3d6G8FXImaW4GIBsAp4Xuq6JjQoG9DXtY8iS8jWAJPDHHAVP5R761iraDeKVbA40RarUDtoWOkhPhL3xs6vRBvZEuBXoxM0SuoJAzdTYzzYBPd3xXJKgg3ec58zcDDVrrlfm1km9MtarnXfETQIx6II9woOzA26JEkZJHBxkj9VVAFJXx2DfhwfJWukUxdO/c/i67tE6v9Kpe13w/tikqCA71c23BZdDSOEbdQkGYuDEJhC9xiSIb1rpPjcv8qdxE3t0EQtegm/8xOI6dbaROuH4lVxjDUSIdNSE42VzN1YeIn8y2L9U1cuG/jwvl6urvlZK3ZjQsbb7UJHHfvn8iV23zom9nR7JLPgWUEz6K8T8exPE9qCCFOfeF8sx1F2tkykKohrCLIirVhBpoiA0K6Bt6X/zflg+RM5DWmZu8RmoXpu58h6WXi6d2v4h3BL5obgbAME225jDJdVzDD1WzXsTQSlWgwMjoOgvpW6DB5Tp98em4AKGOaYLdwtmKRzriVkYYxphZZzXnhhuWW/L/D6675h3Bwnmb5NsvCsGc4WMxSML8jUdzqetozulSpGvFXpsB0DfpokOdWGILYG5XtoDU37xT8eB5GchZVH2y5vXZGlItEmsHvqJN43o4/Hy/q7Nsci8HMCF2mhh1XUiN0ltirZOXmH2wqRT7llU7FNy6nTU50Ik/tEgKq6VulzZ4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8729.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(38070700021)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jWmvU2mzIyJMUMX1iJ+MW0xs9MfEM2pKcDXiOfmhSy5/tWoaNg82eLSIAVZN?=
 =?us-ascii?Q?s4IgR8tD6f+aqHM/iKW/PO2YfJKZ00seP5puFweSqISrFU0rlK4yNfp9UapL?=
 =?us-ascii?Q?BZ5J754fKrDFk+wxyIwsl+xQbn34QXkPsb6tmppBFSlFxwTL2cWZv2Gpzo+Q?=
 =?us-ascii?Q?73YkBOFS3amSZVMtGt17wYIcS/HWPIME6wXw//S230E5IaUJHneP8sX4906b?=
 =?us-ascii?Q?7xueNEBJL4I3LBEx0anfW5/yQnDPLwgDsdsw+Q68CAj9KMEvoNRtfSziOs4m?=
 =?us-ascii?Q?6po5Ewrhks38R0T6ky1dmBf44RccHwDDkqIa+4sieOaKXJ+M2OU9JOPfVnWN?=
 =?us-ascii?Q?azKmqFofiXAvwKQy89/0MHrR1skJmOfTXniZfrVfS1T2iRbbadib8Z/D6DE8?=
 =?us-ascii?Q?rJ1KYI979HROznWu8spbzt/NZL5OpO1eCiCo1jLXjNdtzo0slJO9W0BDr5Hl?=
 =?us-ascii?Q?MKDWB06rkZkZuqr2eZppvJFmXVq4PtrdIdYTQoe8mYcN2+T3Chq59dIeuNZz?=
 =?us-ascii?Q?9ZjOS/qeRHUwRKiANUtMB1KqtCBGb/x/3Wg/R3uKlNOZYzNzLZ+j8OAKAGLS?=
 =?us-ascii?Q?BQh7cbFzEVKJCLQx1H5BjH4Cai4Y/GRM2ZvmNWqoIuJF7MDZI8NJ15IhbS3i?=
 =?us-ascii?Q?wDSxR1GCNq6+coMk8tDo4KnvH3GHuxgeMHv4hWJ6/bmSIcFBn5HlRWmGIGFt?=
 =?us-ascii?Q?uNhxmVsiJOwFxj846pP0dspE6V8XbG9gKaZ906hNgTcubGX3fE0wdFAsZ0N3?=
 =?us-ascii?Q?bYHPhj9cD682GyOXFP41Q/GL8nwqKHeoAv7j+4lPdGZGcRiSQvJr1ceMtm2D?=
 =?us-ascii?Q?NSAmo0eWtbb102j+vUFDqECfUJzPm2gPUjo+dsNLyuekQidq8ANjK3IatL0Q?=
 =?us-ascii?Q?AIGEzlZvFLs8s5seMu+pC405PzMZy/ioHlm2iJrjuyGOf82UxecieTbG3UQC?=
 =?us-ascii?Q?HAghFUfxmR0LaZJrG+WOcP0pFs6AuPpZe1/+aCctrRc1qArsyRD8AdNIl1M4?=
 =?us-ascii?Q?/M71ew0ZvxAGh/oJRQEJZ+kA2haaIv/GCclcajjymPOJAIodaa2LAG/yTlV0?=
 =?us-ascii?Q?iu1m7nvC0NjEwBpwkjjC5ozUkJa/4620Q+bZn7b0/2jUS9hh7zir0zAZfQFF?=
 =?us-ascii?Q?Yp3W+muRifk0554+KLtEuyw9vGqGyMMbAp4kvB8W3B17kO18cnpaZoWutyAv?=
 =?us-ascii?Q?G8MS2BeDtt3m7zoXWw1n/Yr9+m3BID2WOYAcFu1WXd282OaAHh2l1eK0x9tp?=
 =?us-ascii?Q?kNdD4V60Yib+HBsIRadqu5vBVgORmaGBIMybST+D9ncZ9ErnzaodgQSRbMkQ?=
 =?us-ascii?Q?XUnxJ+gKiDCYrKVoN0oCvYpueez/ESOa08BgYgt52tcGPjAxapaNa6mes5+6?=
 =?us-ascii?Q?pGJ/hsjlQYIWfxhRwAYSVMYdXY/P/hDOGzp8Yy1/BpFBm8/TnoXaYd5/BuOz?=
 =?us-ascii?Q?A3E5TvlisQhJ9Lvsmb4OG6tdpRnIrJX6uDj1dS/xQxPN8wO8Q7Xd8WDgJpHE?=
 =?us-ascii?Q?gNz8j/x7dPh7Cqn6CSmznQ9o44O8xtr8XHHy9WICRkvpF4wcyAGd6YQAnT/+?=
 =?us-ascii?Q?/aoraow2p92AlqsOM7UWg/5bqHzRplj85GuFFu8oCa5gUo4Kn9hotMHSbfEX?=
 =?us-ascii?Q?kzgFFGuijqowzAV/pS+TWa7aBw5q5+BoP2Y95Z02DyALM7Vz8Z41Hl1MfdOF?=
 =?us-ascii?Q?AmCIQtsVm2viuhJ/IbIepQEJgWKpqoRi9e06XyVbDxpNgwT7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8729.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f0fcb6-dad4-4ba1-4641-08df267830cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2026 02:42:56.5642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8RS5RnF75peZTjyZa8REt59p49LfiXlAu52KvDeaNcJnywRPIjIi3aoSQzignFfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

> -----Original Message-----
> From: Zhou1, Tao
> Sent: Saturday, October 10, 2026 10:14 AM
> To: Sun, Ce(Overlord) <Ce.Sun@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: RE: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1
> IP_VERSION(13,0,12)
>
>
>
> > -----Original Message-----
> > From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
> > Sent: Saturday, October 10, 2026 12:49 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas
> > <YiPeng.Chai@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> > <Stanley.Yang@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
> > Subject: [PATCH] drm/amdgpu/ras: Use fw-managed EEPROM for MP1
> > IP_VERSION(13,0,12)
> >
> > For ASIC with MP1_HWIP IP_VERSION(13, 0, 12), enable firmware managed
> > EEPROM
> >
> > Signed-off-by: Ce Sun <cesun102@amd.com>
> > ---
> >  drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> > b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> > index fe0e35357af1..cd332fc267be 100644
> > --- a/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> > +++ b/drivers/gpu/drm/amd/ras/core/ras_eeprom_mgr.c
> > @@ -40,11 +40,10 @@ static const struct ras_eeprom_ops
> > *ras_eeprom_mgr_get_ip_func(
> >     switch (ip_version) {
> >     case IP_VERSION(13, 0, 6):
> >     case IP_VERSION(13, 0, 14):
> > -   case IP_VERSION(13, 0, 12):
> > -   case IP_VERSION(13, 0, 15):
>
> [Tao] Why is IP_VERSION(13, 0, 15) affected as well?

[Tao] since there is no IP_VERSION(13, 0, 15) actually, then the patch is

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

>
> >             mgr->eeprom_early_init_service_supported =3D false;
> >             return &ras_drv_eeprom_ops;
> >     case IP_VERSION(15, 0, 8):
> > +   case IP_VERSION(13, 0, 12):
> >             mgr->eeprom_early_init_service_supported =3D true;
> >             mgr->fw_record_enabled =3D true;
> >             return &ras_fw_eeprom_ops;
> > --
> > 2.34.1

