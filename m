Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27214C46CD2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jan 2024 15:12:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B265211319A;
	Tue, 30 Jan 2024 15:12:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBDBC1131B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jan 2024 15:12:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnl+/6mVWmFYMUmdrb8UP5m8V05p3dMg64vYtn17icye+wjdPv4tI0kwtUe88LKdZd1ytvSD9KrL7TXF7TZ/Mp9BE7atlq8EE52wpE4ChG6XxmD8LczR4CFYM7GWrQPnLfYzos47yrk0G3gmUSv0Gooeb6eSsJOmG2B+2RjxalE8gZfQ7M+ixlZUKGTID5gSLwTnxAJgpMg7luMeoixp9Z24SX46dtt0MgOKpoPeAUDozZVJRhC9C9DkMxlHgU7IsMc5SbwRZG8xTXGdRSlQcFmep5peYgVrjwKUvwYmJPlSyRpcEIMsS/giimGZ9v5yXqj4RL6SKWnXIY2xcrsh6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BLwXoZrpAGRB0DXeu+fi/ZZQEBUTpmRT5MXwbHrA5I=;
 b=HWWBzlfHyQ/Otqo8tw8KiWbXrsM/AKOtZJIUiz0iTiKT4qHrPlRA1dh583zAo1UTR9JwaTgc2JQCP50BwTUJ7cGRocmKV2ItY8SXf39di+Cw88VGoWtu2axgpVq8AeDA3saxSUpssr5TmMYKTnnv7iUi4yEliE9NH/S91no2UU8LeNUICCqM4TwI2lvi7iEI8HKvXAXIq9jRVwgj6NEP4e1xxjZTncWEkBzpZpL83pylVGdxoCsyUiRiTWFejhaXq0LX93/nfaEiKiPonX+ba91xmN3Zo/SdDZ+r6vcVSsUpBIzDB+CMRaWG4FRMmxiR62HHV9ycJ1q1YIpydlZR+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BLwXoZrpAGRB0DXeu+fi/ZZQEBUTpmRT5MXwbHrA5I=;
 b=xfHD6eRN7/gz61PIVHefPxevCjFTR9h9zuJyMRwoTV0kQKzh/HUh7un1gBHooDngBhgbKwMIxCf4MHkqjx2mEYyTyi/iOn3FFVM8eY3wL36rQDHNAxexo6dPec24mQWpt74unvK6wryfAnJ8bHIMEAnoqWE8vCxU/qh9xmqhBHI=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by IA0PR12MB8254.namprd12.prod.outlook.com (2603:10b6:208:408::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:12:30 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::dd5e:e866:b2c4:2c05]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::dd5e:e866:b2c4:2c05%6]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:12:29 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add NULL check for kzalloc in
 'amdgpu_dm_atomic_commit_tail()'
Thread-Topic: [PATCH] drm/amd/display: Add NULL check for kzalloc in
 'amdgpu_dm_atomic_commit_tail()'
Thread-Index: AQHaU1iLw70bs+vBmEmyDoVroO9zsrDyG2qAgABX6SM=
Date: Tue, 30 Jan 2024 15:12:29 +0000
Message-ID: <CH0PR12MB5284680193BDCBE28EE7A1ED8B7D2@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20240130084156.404153-1-srinivasan.shanmugam@amd.com>
 <bc1a5ab4-a3d4-48e7-b058-f6d36ce64122@amd.com>
In-Reply-To: <bc1a5ab4-a3d4-48e7-b058-f6d36ce64122@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-30T15:12:29.473Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|IA0PR12MB8254:EE_
x-ms-office365-filtering-correlation-id: 4120033d-c802-48f2-fbd0-08dc21a5e07a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g4fTMi9bqP0Xs+Q1iCdzafcU44uN0tDC4jfUeAoE9P/RXUkKytpEvzbbityMW+lxmZftqxmsmuhYSh0DqQdEQ5XyS4euHQU2NC6BW+64vbYusOjCX2ymyf49+gJeEXgWwDN+98suDZB8ssOg2tCpoz7pgIs/1rgo5IrdOnQuMdZtUycti9CTJKvQ2RPIy9LXJ5r4eyT+mdTn7sGiZ7TYw4nwxQh+dtmp1KyEGXX9xpawgFdv+bSbgk9ITpa81n/PUvanfhRCzTDTsEGuNIyRZH1kjJy0D13I9Tu9MdsslF7QRtJj3pUV6lSXc2M6liUqXc2CvFvncFu7cFtudB7q83vieXujiFgTRy73Nk2edFbPHO8BItvM48edr7LJeZ2FGDee31Ev2zzdy6Oe/HyXwvEDKTNYkA03lvJLJGqqN3RljJlo2+Fk/q96Ax1VU2YJYLZPUUZz2PA1jNVIktxG9HwVgOEQyDL0er4cBHw7ez6+7K+bE7I3FuuOG+oaekfqDEFoIJ4PaR7RPmk1ZM7xZrpaPYmDpQBmDwQuugvGzYFSTLSlyLlT79OwIfadrC8AOagO2JvNxuOeDEuUZP9543yq9Kx8AFr/jEA42DScBaQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66446008)(64756008)(316002)(4326008)(66476007)(8936002)(66556008)(33656002)(66946007)(76116006)(8676002)(6636002)(110136005)(83380400001)(91956017)(19627405001)(478600001)(86362001)(71200400001)(5660300002)(52536014)(38100700002)(2906002)(966005)(54906003)(55016003)(7696005)(53546011)(9686003)(122000001)(6506007)(38070700009)(26005)(166002)(41300700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eYkFrDoTiYxaxshfElGBhovTJWCDeApcfv0OY2XAkr/zI2luH+Oq16S4ZQbM?=
 =?us-ascii?Q?h5Db8YUJWnt+GrhDtepraJjp6K8S/Q5k+leTJqjjRVWpt5T+6igEYw3XNeqi?=
 =?us-ascii?Q?Mt2OOL4nKiSIrMieBi01goFH8T4jqEvq6ujmIZ1zQJjPGJe8ST10phLOn+1R?=
 =?us-ascii?Q?OlYm50nWNjyo7r2SG0Ez66ILJ289gITugtJrWwG2kXQi7bFmUXD8A0IMl6/k?=
 =?us-ascii?Q?F2BtCRHI356FZZ+aI6elB+HWTKPotIX5XdPZo5vmmqg+LbGuO9RalJm47QMr?=
 =?us-ascii?Q?4XFvLdp5MdWbj50hPl6JOrMdVrhjVS5BvbNjrExgqq25LijQhElieQjbxven?=
 =?us-ascii?Q?R2Rzq8XItcOl1A4j33n/oJq5UCgzAuSqQKkLXQn9zM3jd+XttnMXLYdw3vmq?=
 =?us-ascii?Q?XUFE9bVcAMxaTQPiHxw+H5mDrpJGq3bVNLKFeaZ8l97FgmtOi43Bfix/YO9r?=
 =?us-ascii?Q?9/vbVFKyi5/T9RR7hzXHkIk1VGrEkpEHy5JQUuk1JZCnNPzd8zJ4y5+ohh6i?=
 =?us-ascii?Q?HDhNpnkrZ3BpBq7smQZfB+KtSv76g3PoXSpYTyvAQ/uhC61cIqnUm9eVUknr?=
 =?us-ascii?Q?Mr0neeebSUFMPSWRdK3QO4gi4WldN/T7saxW9d7qazRR1JCLB5mbtzWx+Dma?=
 =?us-ascii?Q?715IA7eADO3T7ptc0/Nvd/5B8DecVOLTuYIxkgLbDZfotWYpwPADXTgtYkOR?=
 =?us-ascii?Q?3Byzu1JlM4YMOZpQZ2LFHc3wM6dlI8jELqKTvYN+k8s/3A6JEV8/Qxf1CLxS?=
 =?us-ascii?Q?SFHuSHf9LopfdWeXbV8VWsiTl+CUS51+pKBk7wIZY+Je1aercBU3Ctajcuvt?=
 =?us-ascii?Q?pfSaW5rwuEkluDUItXMnyEFQXettT+HLGSVSUEjywcm/gsL66hUJSRlFOuRv?=
 =?us-ascii?Q?uP52PkU5l66lBErkANQA/quUZMVj4JbpqTOEx02JWb01NLZWoG235WsG5kV6?=
 =?us-ascii?Q?mCp6L4XKxVVpHOKjjAfBB8jHyQXrRFw5VZ+RDf9vcJDDg9tYxdJEfdTNwIyn?=
 =?us-ascii?Q?6ZP5xXQKAk0CV2msyHEH9TOo3eOHS1kWQV6JTVvvfCoRcSyJw7Vcy+7xsjV8?=
 =?us-ascii?Q?aKW3HxE+cpIa41mGvLyGBXBQ8GQeKefwCHPoSqc0tUyXhPtp2Hl+GFAhKYmB?=
 =?us-ascii?Q?is+OGvBk47FjEqx3GbkaO4U+UaS85BZMlk0UN85Gbr5CkVzJZn+QCN+Xxt3K?=
 =?us-ascii?Q?I/BOSo91DvkCr1NCXWtARXChLW55XFLZPYthA9jGSqahkD5JU/CdTISjz9Ck?=
 =?us-ascii?Q?YesQiWITaYosVpscPzpjYRjybVYGYiysYp0mAzh4cGKH9ru94/CajQDCw4zV?=
 =?us-ascii?Q?tNWyVYevlyoYH/TUAcItJmvto0Oh9O0BKiEFfOoVD9tZY/sPbX1brT2mnQOC?=
 =?us-ascii?Q?JDB8jaaJ/cPvZWbyxYqK9uMATOPsL8aGyaJpunDTYBdpc/sbHWVtarDwAQqA?=
 =?us-ascii?Q?IZSz1BMX+bnfdbfj7L0wKB4cJgXtJ3Q7wfn2RUVzV8pMfBzU2AiiHtpnCVH7?=
 =?us-ascii?Q?PQpf34lUL4nkBHYZVyOONWX8dZqAZtfrPex2g9tTPgw3Kfq7ztSgQKngM8b5?=
 =?us-ascii?Q?Od/154250Gx1ds8iA3M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284680193BDCBE28EE7A1ED8B7D2CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4120033d-c802-48f2-fbd0-08dc21a5e07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:12:29.8687 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBouVdjihtCZ7DYEhZx92ogwZaZ1jq0bFoMHnC0beWMH/zyu8jaur4jGMu9EIQcMtmxMorZuCVNj85m33ze0Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8254
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
Cc: Julia Lawall <julia.lawall@inria.fr>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Chung,
 ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_CH0PR12MB5284680193BDCBE28EE7A1ED8B7D2CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Prefer drm_err instead of DRM_ERR: https://elixir.bootlin.com/linux/latest/=
source/include/drm/drm_print.h#L468

With or without that fixed, patch is

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>
Sent: Tuesday, January 30, 2024 4:45 AM
To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabi=
ndo.Pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Julia La=
wall <julia.lawall@inria.fr>; Hung, Alex <Alex.Hung@amd.com>; Deucher, Alex=
ander <Alexander.Deucher@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@=
amd.com>
Subject: Re: [PATCH] drm/amd/display: Add NULL check for kzalloc in 'amdgpu=
_dm_atomic_commit_tail()'

+ Cc: Tom Chung <chiahsuan.chung@amd.com>

On 1/30/2024 2:11 PM, SHANMUGAM, SRINIVASAN wrote:
> Add a NULL check for the kzalloc call that allocates memory for
> dummy_updates in the amdgpu_dm_atomic_commit_tail function. Previously,
> if kzalloc failed to allocate memory and returned NULL, the code would
> attempt to use the NULL pointer.
>
> The fix is to check if kzalloc returns NULL, and if so, log an error
> message and skip the rest of the current loop iteration with the
> continue statement.  This prevents the code from attempting to use the
> NULL pointer.
>
> Cc: Julia Lawall <julia.lawall@inria.fr>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0bf1bc7ced7d..8590c9f1dda6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9236,6 +9236,10 @@ static void amdgpu_dm_atomic_commit_tail(struct dr=
m_atomic_state *state)
>                 * To fix this, DC should permit updating only stream prop=
erties.
>                 */
>                dummy_updates =3D kzalloc(sizeof(struct dc_surface_update)=
 * MAX_SURFACES, GFP_ATOMIC);
> +             if (!dummy_updates) {
> +                     DRM_ERROR("Failed to allocate memory for dummy_upda=
tes.\n");
> +                     continue;
> +             }
>                for (j =3D 0; j < status->plane_count; j++)
>                        dummy_updates[j].surface =3D status->plane_states[=
0];
>

--_000_CH0PR12MB5284680193BDCBE28EE7A1ED8B7D2CH0PR12MB5284namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);">Prefer drm_err instead of DRM_ERR:
<a href=3D"https://elixir.bootlin.com/linux/latest/source/include/drm/drm_p=
rint.h#L468" id=3D"LPlnk793248">
https://elixir.bootlin.com/linux/latest/source/include/drm/drm_print.h#L468=
</a></span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
2pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
With or without that fixed, patch is<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> SHANMUGAM, SRINIVASAN=
 &lt;SRINIVASAN.SHANMUGAM@amd.com&gt;<br>
<b>Sent:</b> Tuesday, January 30, 2024 4:45 AM<br>
<b>To:</b> Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Pillai, Aura=
bindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Julia Lawall &lt;julia.lawall@inria.fr&gt;; Hung, Alex &lt;Alex.Hung@a=
md.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Chung, Ch=
iaHsuan (Tom) &lt;ChiaHsuan.Chung@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Add NULL check for kzalloc in =
'amdgpu_dm_atomic_commit_tail()'</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">+ Cc: Tom Chung &lt;chiahsuan.chung@amd.com&gt;<br=
>
<br>
On 1/30/2024 2:11 PM, SHANMUGAM, SRINIVASAN wrote:<br>
&gt; Add a NULL check for the kzalloc call that allocates memory for<br>
&gt; dummy_updates in the amdgpu_dm_atomic_commit_tail function. Previously=
,<br>
&gt; if kzalloc failed to allocate memory and returned NULL, the code would=
<br>
&gt; attempt to use the NULL pointer.<br>
&gt;<br>
&gt; The fix is to check if kzalloc returns NULL, and if so, log an error<b=
r>
&gt; message and skip the rest of the current loop iteration with the<br>
&gt; continue statement.&nbsp; This prevents the code from attempting to us=
e the<br>
&gt; NULL pointer.<br>
&gt;<br>
&gt; Cc: Julia Lawall &lt;julia.lawall@inria.fr&gt;<br>
&gt; Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
&gt; Cc: Rodrigo Siqueira &lt;rodrigo.siqueira@amd.com&gt;<br>
&gt; Cc: Alex Hung &lt;alex.hung@amd.com&gt;<br>
&gt; Cc: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
&gt; Signed-off-by: Srinivasan Shanmugam &lt;srinivasan.shanmugam@amd.com&g=
t;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++++=
<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 0bf1bc7ced7d..8590c9f1dda6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -9236,6 +9236,10 @@ static void amdgpu_dm_atomic_commit_tail(struct=
 drm_atomic_state *state)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * To fix this, DC should permit updating only str=
eam properties.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dummy_updates =3D kzalloc(sizeof(struct dc_surface_upda=
te) * MAX_SURFACES, GFP_ATOMIC);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!dummy_updates) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Failed =
to allocate memory for dummy_updates.\n&quot;);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; status-&gt;plane_count; j++)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dummy_u=
pdates[j].surface =3D status-&gt;plane_states[0];<br>
&gt;&nbsp;&nbsp; <br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284680193BDCBE28EE7A1ED8B7D2CH0PR12MB5284namp_--
