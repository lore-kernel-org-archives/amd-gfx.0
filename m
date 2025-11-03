Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAA2CCF9F8
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 09:45:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B670610E096;
	Mon,  3 Nov 2025 09:45:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LKowyV/5";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010020.outbound.protection.outlook.com [52.101.61.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C32E10E096
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 09:45:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeSCFuweDjDNHnkiso6qN9W4xAzfiHGuM2JuwDLpkY/XCPuzo/CtMYE6LCna6cad8gda/lMf/R52e/x4Lq5n3krvUrrUw9dS8bvI917EiTcm1DKYjVA9Xn9HJ/ogJV6GsGxIKF9jR+0euv5KeDoK9PrmvwfmicxEqAC6327lfhcvGVn21X21VNzvs0ayEYI0DXii4JsZa0Ji9A6wU37paai1perZBOUtWTn/qKImXrgS+/LhGt35H0M5Eo7avhKmGFAuv8Og6Ees48uYgA8omS6DWe2ClOV4V79KYDNqn06H85VgjfHhYxbG/UUZGqeiN/THpXNOBMQm6wf4n/Zc8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP3Wv4qRbJzE3qEQzKeXKF1jI2ojRonPczjPybu1ljU=;
 b=rZFHR0y9uVzU3it2gEYOdjDmDsYWToiQeel9iXTh4IZQJOafUxhcS8OI7Ft8Um/Y4qhKf19ObRy37G05APHvat8SO6KHDhdnGoyvmNKKWSW/dRGDc/B2kAWBH2m0mQWiguQW2dzfa3mFF4/ism3rY9sJgbshKPQmS6zBejKbp9dosmKFKD9zQNnUjLflcVRhGSg0NPzNtvlno+0nYJQrINnzNhlbyie1d+3gZK8aCQPZv3fZ07/y3B1OjGixNT9m5GLsN6tdwyf8S0n1jb/h3heaUCiiAU6R/PQmx4+EwATASpb6jdrWT3GsLo+RSCHF8eUK4A7AyPnLyCOdo6Oh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP3Wv4qRbJzE3qEQzKeXKF1jI2ojRonPczjPybu1ljU=;
 b=LKowyV/5vrdcKkkw2TNDuYcTOnIvxiHxSxQfkQ5VdKFNMZtMgrGbiv8CFMjkqeZtAAEnrS7FWbC7ctppcRoN19zV2tx/1f4g8JcJimJXwxDdi4kC2R4n+sGVvfnAk3+S+/tBry9G+NrZc1DhUF/FYvy/xJ5g8rAfn68eMkN0urs=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 09:45:25 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::b053:488f:853d:892a%4]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 09:45:24 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, "Su, Joe"
 <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
Thread-Topic: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
Thread-Index: AQHcTKERcxTbDxEtFUe/NhR3DwBVO7Tgr6CAgAAC+DA=
Date: Mon, 3 Nov 2025 09:45:24 +0000
Message-ID: <CH2PR12MB4215ED2031B67116E5CDCB98FCC7A@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20251103090457.3036885-1-YiPeng.Chai@amd.com>
 <20251103090457.3036885-2-YiPeng.Chai@amd.com>
 <PH7PR12MB8796AF3604DAED28BD782129B0C7A@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796AF3604DAED28BD782129B0C7A@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-03T09:29:26.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|MN0PR12MB6078:EE_
x-ms-office365-filtering-correlation-id: c62c2c5b-96cf-4e12-6f24-08de1abdb690
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?M4v+YJ2ypjP1PH/HadbEbHEfeIL0Ky5ZH2XEac4hxR4JFgn24IspzIYmpUny?=
 =?us-ascii?Q?8OWk5mzfRGju66lZos+uJe+SA8dXegjeR7P8NY5gujPf9Bgr9YN3sEF5Be2f?=
 =?us-ascii?Q?YZKkk9a5jIfpKJVVD02rFO0CvUwmak8ZAFTVy9HoFV+toh+qrwCu+QAEB499?=
 =?us-ascii?Q?psODFZyP3RmK5rEAz0KPG7rNnmXnl79hor4BWM50ipxJs5QtGYya3IQ3RUDG?=
 =?us-ascii?Q?b9XTYQv70bpQ/3sl/agQucLtZBQ4xaatDxG76VZRgT2haoBTC/X6YPO0w95M?=
 =?us-ascii?Q?ufZUJsx2fuoVXrmN8h/yAdwy7PCaiOCkl1MlRXsN8gNhS7pu4g+hyF545pIs?=
 =?us-ascii?Q?Qtf76pXcTfWv7df38tWUvm+MTKEiouVuN8QUOpYq222Fd/jEl8f/raJ5vxuj?=
 =?us-ascii?Q?AyGPM2iYHkfGfoN5SBtieqSoFAcqAsrf1XGUX8Ro2S2jCqDU6qbu7k3CWMyj?=
 =?us-ascii?Q?2DvZm5Czwz3bj0V2ZBxoxY8j29graDhuG+9TQ2cx64QGwQ9su50Iu3V5T3KE?=
 =?us-ascii?Q?Qb1BUC/cshnc3Yd+yTxxqv5UCN9juFCNpHdNElUH+hEOLurLxefFjngMhIw5?=
 =?us-ascii?Q?sYriiaUj5QkS279w7xdsBbb80DaaxrxE3b2LCu2c/9iwUyXDTU+OsZPUsC0r?=
 =?us-ascii?Q?/biXpFvgBTNm3SQ4GlLT01UbgPL+r2fbIPL45u1KCrUJ2AUIV7jzdTD+hLOK?=
 =?us-ascii?Q?l4rgSUMGx9sdBQ70IGwPXyilkh7rLYi0K/JbcmFg30KXjfFjnHifwPA/atz9?=
 =?us-ascii?Q?z7GFlGEIgE+MYaB8fsJUEjkBPf1UEqele1n/u7b2osNs+9RFAOpr4M/T3QQi?=
 =?us-ascii?Q?q0jjmulJXyOmH5FfDFz1LQqEf2HF05IvDJ1TSiufS8hDu3+ir1zJ8K0S8Dg1?=
 =?us-ascii?Q?uWBkrhv52SuSv8Ia12jELmpjSu1Aw6cgED3MWJw0D1mbm+yhmr+5S1Pk3SHQ?=
 =?us-ascii?Q?y6HM3cYICscH0ZQPFzXF6a0xYyaeXMgtBQwZpESnNNbTrnrKNws8OZYCvQqi?=
 =?us-ascii?Q?HR8S1HbeFL3EeqrKT69DiA3FhGFoSwdL/7gfY8omqa4LlAt9ZGL+A+5o3NPR?=
 =?us-ascii?Q?dv91iHIf6hIpcwx/f791KvVbh2jTmo2AC+4RgHBK2BSO/m6RhZUqH86whCk2?=
 =?us-ascii?Q?d4cwDyMfSL7wJdH1bczo9OGn9kehfNz54rZ2l/6lM4Toqud7V2opJggrdJC+?=
 =?us-ascii?Q?HThlrLJWJuFRn/0mLy7zfTEPxbynWLncFKUYLSZvGXK3u87rlArVtvgBfsnF?=
 =?us-ascii?Q?wy4iuMbvYKJ3ptzcQJZ34PfisS8S6zsxam9xLkfwpBs2f7KL6lpNumpbofC8?=
 =?us-ascii?Q?YXm90zYgK4uYdL0OZk3laF7tPTaHSS64ZVfSLnroUj776GRMZrEH9JHuZiFC?=
 =?us-ascii?Q?rgE2KOz6E6Q1hxmW8PHtmqniKJYTtuSr6Fd2ACNC8LwxRlzDYNFlHqooOwXi?=
 =?us-ascii?Q?tIg7aeviRE2RxUgHMlUQqYPNghWbSoGA0v6Nh+l3e427TWxxc8wAHQr0LYDw?=
 =?us-ascii?Q?5Nbb/082l+HKLq01oKys21nArERSPlkaYcyc?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?snBU+PpMjM0WgOBwDF0jA4pKe6wodqTLr3d7cwq1gtERzDrhkj2JirS9qBnQ?=
 =?us-ascii?Q?E6AK/bG3783dIr3JuQJl3STlQX6fknmMd611QFUC9+P/eXh+n+7uoAsgMHEh?=
 =?us-ascii?Q?pu1aSTaPKE1TYPLiYpM0NQHnnBNymVZr7j7OUn9vTJg/ffm6eD8Ti5wpN3fX?=
 =?us-ascii?Q?BpvZDaBXjD0VmdtCOj9XeKGScVDsmZUolYGfAv6HyIH2tONZEILMYG05Rovg?=
 =?us-ascii?Q?UVhdWSiD1bw0HQWpbbWLUxljb6/OzAdCIMuQ4weDNiDsidXNFnj4qP0LZ5tc?=
 =?us-ascii?Q?zjoR/2YrC5z476LgG+SNnyIqmp3dJn7bMNbGhfexwT3SIi+iCrBhe3W8RKLs?=
 =?us-ascii?Q?9Mb/6+nHLR/q69IP7ERVGWn5vW5mnFC9YQoIdHr7FxWvy/QX3V105H3FSsMo?=
 =?us-ascii?Q?drElvldFnauHwLFOoH/MO7ECEpxO6+OPu0fd5oE6F51F6/g80JALj8kN7Ytu?=
 =?us-ascii?Q?jfSEye+AzGRbB39bOYoFCB1xQK7fO0ANmJdDeI6i6U5a8voO0PRgLYbjl1iq?=
 =?us-ascii?Q?nlPslrp9wIbIfHXLTGlJNMhsKSXv73oZ3wnwAl7REDw7rUxSdzynnOYY0rai?=
 =?us-ascii?Q?dff1vJzOaua31JkwucAquXR/lv5UNY5a52M+Gm4I/SMAwOoGEfVIvUPRdFdW?=
 =?us-ascii?Q?hTkO3fjFLhX7nY5GktQgPHsAuL+Cw2yCVSRy+e3ZDqLal8ODBCiNvFO/r87v?=
 =?us-ascii?Q?5PUnZGMDl4QPlI1IF9u1tBJggzN5fQxFlwgLeyJ6uTkMG4vR4+eO+/WVzHXe?=
 =?us-ascii?Q?loiI0dooJ4E+U9tEAwwI54GQ+j3JQ2nd9JdbvdCCalYGuuOhE5piR1hz13uL?=
 =?us-ascii?Q?78IlIZvVpx7PbMoOoMgEidQbfqxXr+IcLn/qko4AAMWuWCO6UIX68ZD9I0wh?=
 =?us-ascii?Q?xoIA6ifPPuewIqA6k4F+Q5dpFfJ8fYMc18yKplMTi1wa8Nw6g+VyjLUveWp2?=
 =?us-ascii?Q?bsbOnPyswS6h56IyRk04aSa5gaeaTAIBFDP3iPceEkYmTu7t2AmVPVce9EXQ?=
 =?us-ascii?Q?ZbS/sjqWsTe1Fpq4KTVmjt+jUo30wjh+d5FOevwKmKLBipmil8TPkJJDe/lc?=
 =?us-ascii?Q?qSuoJjGovygYHxErqocs8pN43ZUU942n/TY2XSy8AQ8ZmgGyB06Ty1Bcr+ZF?=
 =?us-ascii?Q?3pIyp2XORYt4ZHJ7FRvOmY95WJpnx2XCXnkz7wBwRPF//GM3MacH8N7HWNQu?=
 =?us-ascii?Q?eCjhtrVCyF51n25v9f5O8ni3rqHueoYpjo4A18GFYjVd0UB2GgL9DYMXmOxi?=
 =?us-ascii?Q?BEKliWnqUYcBoZjEMGn2rLWFmL7/mHTBX5O+53abFsIn9jrfZEDugjPz75D5?=
 =?us-ascii?Q?fhh9wJuN33vzns7RP/GyqDnDJaJWjygIfMmqtFrkFGvOYvXzB+qXGwx4R3uE?=
 =?us-ascii?Q?8r4+mN7K82LKR60wPf7aLQ3BiTFRLoLd2BUuuNkOzsKY/WjJ9AnDegYLWftE?=
 =?us-ascii?Q?yvwL7NbkFri5601c8/KWj7IOo5yEhVllW2xnmJ0Q3jh8LqhTRPW1ljbANqxC?=
 =?us-ascii?Q?djcKxZiNK7h8e+X/I554BLV4oZ1wcOJbHMjNfKTL93VUQTpy2pcIaEVR08qq?=
 =?us-ascii?Q?djFoos4ZdZYQDDSGuTg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62c2c5b-96cf-4e12-6f24-08de1abdb690
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2025 09:45:24.6684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kQCQ5iFj5/JaM1kZ77ry718gp1FUfa8ERBWQzv/ZyZYUsOVsFS0ofkVvPMm8VazW/xBrIfQ9M99jFNNQEUObQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078
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

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, November 3, 2025 5:30 PM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Candice <Candice.Li@amd.com=
>; Yang, Stanley <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, November 3, 2025 5:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Su, Joe <Jinzhou.Su@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>
> Subject: [PATCH 2/2] drm/amd/ras: Add ras support for umc v12_5_0
>
> Add ras support for umc v12_5_0.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 ++-
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c        | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index b06aab25d4cc..40b458a922d5 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -259,7 +259,8 @@ static struct ras_core_context
> *amdgpu_ras_mgr_create_ras_core(struct amdgpu_dev
>       init_config.nbio_ip_version =3D amdgpu_ip_version(adev, NBIO_HWIP, =
0);
>       init_config.psp_ip_version =3D amdgpu_ip_version(adev, MP1_HWIP,
> 0);
>
> -     if (init_config.umc_ip_version =3D=3D IP_VERSION(12, 0, 0))
> +     if (init_config.umc_ip_version =3D=3D IP_VERSION(12, 0, 0) ||
> +         init_config.umc_ip_version =3D=3D IP_VERSION(12, 5, 0))

>[Tao] can we use " init_config.umc_ip_version >=3D IP_VERSION(12, 0, 0) " =
here?


[Thomas] Discussed offline,  not modify it for now, but will modify it late=
r if needed.


>               init_config.aca_ip_version =3D IP_VERSION(1, 0, 0);
>
>       init_config.sys_fn =3D &amdgpu_ras_sys_fn; diff --git
> a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index 4067359bb299..4dae64c424a2 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -71,6 +71,7 @@ static const struct ras_umc_ip_func *ras_umc_get_ip_fun=
c(  {
>       switch (ip_version) {
>       case IP_VERSION(12, 0, 0):
> +     case IP_VERSION(12, 5, 0):
>               return &ras_umc_func_v12_0;
>       default:
>               RAS_DEV_ERR(ras_core->dev,
> --
> 2.34.1


