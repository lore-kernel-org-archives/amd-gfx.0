Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C177C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 03:35:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C00F112910;
	Thu,  7 Jul 2022 03:35:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA724112868
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 03:35:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFWSD/L7rzukeqmzUm5DPkbg663gmfEqBWmxjo9LNmcBikz0cnoR5wkTw4jlt3Ft6jewWmWHhALA2imuhzrBXYiBfDZQfKMjLKBk9H50kldftUxe9eIowdl8zxKq5Nw8bhf0QUB40kuDgTSOoNuqXDLlE1v5qGcp5N7G39rmWpFqWLE/+MxddVUO6IE06qV+aBjmCcOoMhGiyht8ovkbk1A0IOBnCTjb3pJKKTW7yt8GZK6+fsMTejFny+kuSIHRdCOs9VaU7acnRBu3DF7ppzoliUN+XKiGNEPL2Bx9VRRkTEu1tF5D8BPkhOWgWDfmLPULv0kCbk7M+OphFpyqXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YOD69jcmAyNWk1GbRJqqIsaL3T0trkNJjEkbJdXJmE=;
 b=gDKKLWyq0Whe4HVGAFOJ+0e3yUBwiUz/XyWZG8ySBD89YoZKLdD6YP6Sn3Hfv5yqmr62ec2qa8GP371yYBOLoUxJIHmnumuJT88LDViNsP+jbls7CPOj/4vJZDPiyvmdX15886k/iuw9k00HwEzKbaPZVu7rspVVTctCMwJ6Pi+nnvo3jL57YfbdLJovZrSK6wDBnH5d7xybgxw3nZBi8mBQ/GAi4jEmx8UwhntWNJ9gR6Z82f2SVdAEN8EYVGax1hn/0jpCn6UiKTka825Fq+wPrlWZF+qwaf9/9wnIzr0c9UVzjyxy4jB4NjwdBQsksgyp98pNUX6rmdbpdoG8vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YOD69jcmAyNWk1GbRJqqIsaL3T0trkNJjEkbJdXJmE=;
 b=FT+ZlYwU7Y7+rYXMOq0shJIfIdmCwF67xm3CfmIVpYJGyjtSQudU51DR83AMIKU+adIwrRv/zLkb7+dvg3yJvTfBGstZ4UTCGJ3dnBnT4+hDWDxg/WMnmVj0qASWLB6VfXqrQiP7zXKbd0+a3QF2VYXwE8/Jodv+n17Y+TTm2KA=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BN6PR1201MB2499.namprd12.prod.outlook.com (2603:10b6:404:b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 03:35:00 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::5ca4:efdd:b7b0:53c6%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 03:35:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/display: remove stale debug setting
Thread-Topic: [PATCH] drm/amd/display: remove stale debug setting
Thread-Index: AQHYkUyZk8Bv2CrvJ0OZsTYBWqR4da1yQkeA
Date: Thu, 7 Jul 2022 03:35:00 +0000
Message-ID: <DM6PR12MB2619920737E1B5E0AD351576E4839@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220706152507.1075669-1-aurabindo.pillai@amd.com>
In-Reply-To: <20220706152507.1075669-1-aurabindo.pillai@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-07T03:34:57Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=28b0ed8c-20b1-4f4c-ba72-39a441929268;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a8d9690-31ab-40bd-9ef6-08da5fc9abd8
x-ms-traffictypediagnostic: BN6PR1201MB2499:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w0hNp4bh6PA1OjjH2uHuowezEm9JaRjhGRosdPD2ISLeqWV9Oewwl++Wl6+Ko7M+xkF9+wyvSzd0MzfkXNSvQUxcSRwXK5pXrugF+jtqIZaGjpq2qrIc53z/6Pf6W550K6JnGd4wUHe4NdgFaQ5ey40MF54nz/ilcgxQEm5PZn9LEn0ruqJY5SEDJ7BimcY2isHBOe3HtECx8dMqJFAb9C+FYgGOemVyMGcC9Ofs+seoSHUJzGgDP8NZrGFZkUgBZcBTNlshA28rB1MdrnL99iBHisSH3B7Y2iIrxiPWh++BZuxsut+CanhDnmEQv8e25yiLQwlA0gkOA+g34FdfDloDStn3xwQwf65a/uvZ/6tYGsXXWCS/8gSb5pO2SUgbnJgXA8ztCph1rwH3lQniPsfLYuPi4e+eZpSWG3MobnlxC+KJEEyAXvTqcsDSzXUPPW1xEnH+2wfbRsSsQHWnYNQtKHiRfS8B2q5TEGEdSzt2Nb6IYM3v6rvf9K9GNYnCR6PG0wqDuf1PvaEhZAPPRI3TlYDzNov486Cco5226acuy06i9hQ8aDBiMPGx61+g4JBMPWC3BOEzSkIrDHDswBLowdNjEF8efqIjMI9AQPit7i9WssPSHWhyrFZYCp3Jrhmn0pYpotmHkeje7ibSYxpgYXOoeV8m0Pxdkwso+y6RU7R19ZiJKXJ3CLMem6F4bcoHhyW5K3/rTvHNHhnjnXFZQJ3cchqb3CdA2yQKD6vVoRmTyhHhBjN45rrL8Zkvpb506xsEvVJGzjDcp72/DijJaEWAoVpfuzE1sBHryMWTFKIOgMWarS3qRk7CyCFj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(316002)(83380400001)(122000001)(38070700005)(71200400001)(38100700002)(110136005)(54906003)(8936002)(4326008)(66946007)(76116006)(8676002)(66556008)(66446008)(9686003)(64756008)(5660300002)(66476007)(26005)(6506007)(53546011)(478600001)(41300700001)(2906002)(33656002)(186003)(55016003)(7696005)(52536014)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ipj9A/1jODPxVHuWD5lg4x191nUg/njtke7n/hhVnAZt35V4rt0p9sMyWFxW?=
 =?us-ascii?Q?hGifEI/kdV3pU+y3uuBCuLE4UFb5K46UWUCKSYhckb3k9ciQ0nJjVsenKFTi?=
 =?us-ascii?Q?uNwF9nfl6IWNAtrOcp3namMCOpvsTY9kaMuMhHJKkb+LsLTArLF332gaKMtc?=
 =?us-ascii?Q?61xn0BcJT95B+35HKJehFvHTocRJ6w2F4VlD42ywMvw4k/4w/RCECVp/A4XL?=
 =?us-ascii?Q?p6bRE5EXdwhuf4UA0gyn36GgJztmIyKTwS/W813iy7H85mkx9/qUHJwcaa6B?=
 =?us-ascii?Q?UgWMcr6s9zNYZFNSTsDsq2excK2Y4l11sgpbGdBGPGpBxS5lIf8l43k9G4X4?=
 =?us-ascii?Q?8G58tOu5IWi4OG2vC0NdtzVTnN4UGc71b4dUbDhoo2R2AnLIGM7Q5JEoN25o?=
 =?us-ascii?Q?5IuGRgEeYoWDtWoYE6NU6KtzNqTkFDnFWvIoMAUEhoCwohWbxgK6I7JPNMWu?=
 =?us-ascii?Q?jyhf3yvxW4MY2cUkCTlSOX6QxuC6KtkANSINn8y2LUfsVJAMYAsi22TzZ6bg?=
 =?us-ascii?Q?Rj5Cu0EuDhSnCifP6Cwp5NV61qz37mRy9HcMt/KCjl8hdIizkLKQy9jBwdCl?=
 =?us-ascii?Q?CSZvmrOEEtf4vjL+0NkPbUiNK/QJD6Psh7yqQIZr/hiYGfqmUSuRoBu1SJYp?=
 =?us-ascii?Q?kxGSH+5htwb4rVVmhBZKiaJBmhgK7tMGPvDN1ynRLxv3qGUKBEzTV/OURnba?=
 =?us-ascii?Q?fMXmmKTRXMgbPXny/kWaV+np2BDDvgn+Khiqz8HJV9gs+iu8riyqW/oCRVn5?=
 =?us-ascii?Q?cDT4w2ILp5JF6YkWxzgBg1R3r74ns5sskZqhCw6cQdPVK4wzaBLQpd82lZPM?=
 =?us-ascii?Q?ywXEMVIYUcKheEKFd+8XHQ1PmYqazmiHJ8s+xi23d37J/sOdHFUR9u4Z4VC2?=
 =?us-ascii?Q?TuwISDdSzXRNAzlinimAtLBa2qAo7UWWK19v8ARJLscj8g9RFb0CovdeSVYt?=
 =?us-ascii?Q?+Yu8YFLYqPcTARHAkMsBacSA2xyEq3T3Z1l9/zLK64V+etPzv+jiB472j27U?=
 =?us-ascii?Q?BpGzILEtOrzD+91Wmwh345aQ1RgADfyeluxR2HNJX4ly/TXtKnbMeyzk4CkB?=
 =?us-ascii?Q?amx685RkcSbDQYAHPQEBmR5L9OWSS4R8gMfm/fcPsAb9zA7QexX4EfyTsKUs?=
 =?us-ascii?Q?VKMMbb8uUXBWCzL6iKArkJSTaGe13fozIs7P9WXCqGTU52Xt0O8xH816gilC?=
 =?us-ascii?Q?oB/Mq2bGilbpzqpAyOL5AWFQQeXFBYYDlQmSWoJrCQm/AysU6h7T4Ys3yxwM?=
 =?us-ascii?Q?V6fm6UaMUR/2urZvONU5Eqg2uYHvlJ5MiDe5lL0sAyK7JDYOMIpUUZ1FgAFM?=
 =?us-ascii?Q?iHUxnO6EO7/Zzcj4K8OHIsWW7bOo1+VJCc2/jvvbCdfigCr7OgFHPTl0Wkh6?=
 =?us-ascii?Q?LodlKk+/BIn/KWZIjhXd7KbZK2tHQDyGRqO3G41Jp04wWyudlaWwWXn8DdZi?=
 =?us-ascii?Q?hTjThDDLpJjJVUO+btdyUo7hJ+xIbMyqqFvfqRtxp4lUg6N48eikBIEB+43q?=
 =?us-ascii?Q?SwK2E1nR2wE7j/S+80Zkarcrs/kT2zD2RkUOcK+zvv5dkv/TEGG0ucwQfd16?=
 =?us-ascii?Q?votnugQVYx/DPSVhz+g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8d9690-31ab-40bd-9ef6-08da5fc9abd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 03:35:00.2355 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H104MxMcHKuXNbitGzV81Bbx1nURzhdNaxJlr8MsQJo0lr2xlO8O6H2tjV3hKb7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2499
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-and-tested-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Aurabindo Pillai
> Sent: Wednesday, July 6, 2022 11:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> Subject: [PATCH] drm/amd/display: remove stale debug setting
>=20
> [Why&How]
> The debug option to disable idle power optimization can be dropped
>=20
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index baaeaaff23df..1cc1296aed9c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -736,7 +736,6 @@ void dcn32_init_hw(struct dc *dc)
>  	int edp_num;
>  	uint32_t backlight =3D MAX_BACKLIGHT_LEVEL;
>=20
> -	dc->debug.disable_idle_power_optimizations =3D true;
>  	if (dc->clk_mgr && dc->clk_mgr->funcs->init_clocks)
>  		dc->clk_mgr->funcs->init_clocks(dc->clk_mgr);
>=20
> --
> 2.37.0
