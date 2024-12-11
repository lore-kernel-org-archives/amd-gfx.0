Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50834E7717D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2024 16:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B4A10EBA6;
	Wed, 11 Dec 2024 16:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B5lS6CES";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6A910EBA3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2024 16:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zhf08FYbIyarOtW3Yi1voMCwZtzFL+EpXstPyLMb1u6P675pZ2Zzl3lJSzyH5RXdC4uqcJFPLZrb22isHMGsDb5sHzw3IMwhn++PIeNr9yt1BN4Nwm89jBAD3ba+xaKerHnNFOkQKp/VorRknnkIQUpxw+FMZlppm8TIJNe1osxCgjFasdE01RWjChchfY++vO+3CGbaz7uQAKID+OQ9G4i7gl/wFQNMrM4RyyG9RDUr4uEzizRZtVfGUiCTfmqyPepx8PgoO3Bcp8Kc+9DrNNtwJtMp92WG4go51CwxpatpyRAzvulACSjUF7hlLeGuhmy2h38kfkF870FtKjGlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYbJe3zvtGk82t/PZ6gGagxwNm2aK+dqzqm98zDMb8Q=;
 b=WbCYJ392Fonob4gHHNKZgVV6sSLgqTk8xvSzmOaBM6jh+MODrCkBi1k5x2HspCEw8nJ7njcLQ8Jj70kvc9tHWiuE5diP3WVtwCK4HPfUXLfztS8xZ6NkEb0FXsg0XwWWE4FbmGCSfVVXsZzdoNn+KO156yFng6BWZ+tKX/0LA0tOc/7PcwzhdE8lRvSRKsX9iISeZ9rPMdeMKz+3HLYG3yPbpismG7FaNveOEUprKSOQaVwf2qQWGCLkNri0porpwUxAsnmDuY+Nev2wDaaWIApg0nrRsZA/AwC5+T/j1DuhaxrAubuHrp3J51aQhhMD/Um5YELPtDday8urDAiuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYbJe3zvtGk82t/PZ6gGagxwNm2aK+dqzqm98zDMb8Q=;
 b=B5lS6CES2eFhRD7GNAFt5UfXVgk+YhrqTSHQMQBtjYlUuahooN1dhgkFxKEPkJyO+QredXTPjunhxnTchSBDCwGcorKlVo5w7np7gkmYWoiFGXB0tj8bbe77wlJJ6grhkvW3Jj95N/8bt47fEHc2PyapQzA/KAQKmJDk+LFsKgI=
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB9007.namprd12.prod.outlook.com (2603:10b6:a03:541::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:18:55 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2ed6:28e6:241e:7fc1%3]) with mapi id 15.20.8251.015; Wed, 11 Dec 2024
 16:18:55 +0000
From: "Hung, Alex" <Alex.Hung@amd.com>
To: Guenter Roeck <linux@roeck-us.net>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "hersenxs.wu@amd.com"
 <hersenxs.wu@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Ma, Duncan" <Duncan.Ma@amd.com>
Subject: Re: [PATCH 10/34] drm/amd/display: Add debug prints for IPS testing
Thread-Topic: [PATCH 10/34] drm/amd/display: Add debug prints for IPS testing
Thread-Index: AQHaanX3dVYwz7GgNUKqIGZLWr7wHLLiIZuAgADY+zk=
Date: Wed, 11 Dec 2024 16:18:55 +0000
Message-ID: <DM4PR12MB8476E86FE65DEE9CA8DC7895F73E2@DM4PR12MB8476.namprd12.prod.outlook.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
 <20240228183940.1883742-11-alex.hung@amd.com>
 <abe64cad-4ac4-4372-9d46-5e77618b3836@roeck-us.net>
In-Reply-To: <abe64cad-4ac4-4372-9d46-5e77618b3836@roeck-us.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-11T16:18:55.235Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB8476:EE_|SJ2PR12MB9007:EE_
x-ms-office365-filtering-correlation-id: 49857d2c-1545-4e4c-4189-08dd19ff82b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|8096899003|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?S+DDV0Fd7FeGucYpKaZ6Qd9tJp7KkT8oRy41iTv5HM1DPF6Dl6id7hWFPB9s?=
 =?us-ascii?Q?cXChaMstI1ybDujsGZkdap48bJNneh3WMGUQxkS6vUJO/CT9kKLkWioOP2sP?=
 =?us-ascii?Q?uV+z772D8JI+fBRVU0moYg48+aEJjQDaurmNLbfQCt2C6wS6hsNI87XGVFab?=
 =?us-ascii?Q?iTZDoYrTOr4aSzk1LXZs9aDA3yqrzFrep35Yb0afpth1TR2U54OWW5ZCUOG1?=
 =?us-ascii?Q?FFEauUX6sC1Rs2EQ09oXVCBU6PpIzBdZWNQhrt8mAUEF9d+OSkB+3nvOocsK?=
 =?us-ascii?Q?vF4neN8uNwA1LWyyCVPYEeOXnwPvtD9b8wkjNxaqOiQrH1eZr0GUX3lHV4hw?=
 =?us-ascii?Q?guSMU5k7rZ7IrBJ2siJVvv7CqA8rJ8F7cN6ADbIRQ7U607TncLaz+qh1hZd4?=
 =?us-ascii?Q?0ajkd2trjPS9iK30VqjlBBrhc/U0OOz18Mb8pGflWlU7E5HFxLK6cZghnpzb?=
 =?us-ascii?Q?l7YsUxuG+3vOjHAFzMpVCqIeFg3z1oix2igxgjK5iTjBuMTwvokLytXI5a2M?=
 =?us-ascii?Q?Vj373iwvPqG7I1GZqsv99vGBpf19v+3U+93tz9bmIE8oCzOasgXLtHncTBOF?=
 =?us-ascii?Q?+hW0MR2cdMmOKMwiR5j/ATqEAPwPDvq9znJfv6fiGbebGMLUJdOwjBYzosrX?=
 =?us-ascii?Q?PU7oGZsE86JbxeVH9VdsNo64L+sbHtODLHznlXG6oAsDo6EWvz8lJUbPg5iD?=
 =?us-ascii?Q?E9c+HQVHmvvCaPssnYjv83UqS+JrhF4wL4e2XzzOmXiahvXJ/gQO02nT7iif?=
 =?us-ascii?Q?4+Z5veEGdY0zgtaan120Bq5sy1uaRYtqe2cPUEYyXomSaihEBLOEp7tslxNy?=
 =?us-ascii?Q?oPdjnKcarDxSAzH+9YgoXL4giwrsDKG+BP74ZG5AuDgU88SceEdF+BLis5mr?=
 =?us-ascii?Q?OzMHnDChMyqAO2e6bq4nrdjxq/p/x6nFByw+dN4mVnCLZrf9n9bgXJ9FEC7C?=
 =?us-ascii?Q?EeX0kVos9wmSvlDNL7ruXJZ3iUi6abU8joJISpp1Enjqxsso+QMP5yVV43Q+?=
 =?us-ascii?Q?VXu9r2c9lI2flvBGVrXlV2U09EoXfAG8GjQVyR2oL2qkcZBIgdRO8U52rBca?=
 =?us-ascii?Q?r1mFiDivVP4X3SY/KIITPYvNehcOWAw2le6VYMnk3gHf3zfMpCdq9hLV3lgR?=
 =?us-ascii?Q?8QQutc8fP11s5VnQ1v6F2K3KpUufhEvXMIhj/T+w5Xzsdg9N5eehxGeue4bX?=
 =?us-ascii?Q?8OUlkAqPGgvZow6MowOZhZ+BcwYBMt6UI+TGn1PwtQhzyGYssxMlk7Zhf73W?=
 =?us-ascii?Q?+Tn8uEgLtsH/FTf2q4Q4sbJrKjL4YmQE56n9O2snShftPkZ+D9KWO2p3EpiE?=
 =?us-ascii?Q?519NPpgn4azAaKVSS9T3gehRqM+rVJ1yoyRGQnhH1v7ocJ9W3ygLAj1i9/vw?=
 =?us-ascii?Q?KL7Rpws=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ij0iIqCV2NADGKkuL9ofT9Zy8LPjHYhwpZ51Ymwmc+ma/qZ3e6t0/CAv2iSz?=
 =?us-ascii?Q?fksZdWo9hasu+oU9ut272zvTjUVz+a2p07/PrvbQCUI/IAkrjw55bYzSjzhD?=
 =?us-ascii?Q?vXly0HbPCatDqjAi2hdHRrHP6iGpyIqXmMvoCTNOSyKu4DE3WQtXnp+UM4/E?=
 =?us-ascii?Q?nshCgCdp/P7+/RWj4fybmE41s0zw8eGIDNm4y6cNUfr1fqtKNIWbs2CXB3iz?=
 =?us-ascii?Q?EkWk1gjLKW6w6wpK6mJIfBqjRhWWzQtQyKGS1X/a+vIL1Tqmoi8aQ3wJ+N3i?=
 =?us-ascii?Q?smh1JroVmD9DEPk2llq/xOqdTbJa6exDdL+EJdfRaVo+LS6EgEyCL0LbDeGg?=
 =?us-ascii?Q?O0CJy9+r6QPb009LZObyf9X7OkENLRjo1HouU8py/C3xVhy9SLrV3JSg57sK?=
 =?us-ascii?Q?DH6I4ob5d035sbkUKsBG9UOe0ew0vikAlYUqs+l2mHC+aFyRcAfVxnfUKIpG?=
 =?us-ascii?Q?lIRZWklzOXSAHah9qgRWB8r1UIvH6mUv+tuxlgw1wfxfofkxnM/AIgH7PHfU?=
 =?us-ascii?Q?F8jNC2K2V0Ro0WCtXhoVWKxLPRu3OkKmOwq26rJTcutxRh/S0L7Q+Vlc4g/B?=
 =?us-ascii?Q?I94OL+nASyZwkTIwFhs9AC6yXUCj4UAtLOc23jiKbJzBRcGnm0V5DiVZFTQ/?=
 =?us-ascii?Q?SkkBGM+WVCudosKT2JHJm+4w4C7N9oxW/wgjZZ2ujEZgVnbrkGUCGT5dPDKG?=
 =?us-ascii?Q?7hsBtXyxpUIk1zQIxJzew16hypC115pvtANiKGBIDLdBJMdcdckPt5JvZoTi?=
 =?us-ascii?Q?c9GKVnNZiDVEm32yEPMfTWN4GUzxMHVnGhbiZBvUouI3KgVlTi0fVLxfhazf?=
 =?us-ascii?Q?gv6ij9wwCywRd4r4IE12Hn9gInsKmmk5u4yenLWQbDZot+WXViXtQFyAq7yy?=
 =?us-ascii?Q?sAC2glikSl7U0xyqIOQ4egbVQV7ife1glekpVgAbTOxhjrKA78Nu4WnVJKpA?=
 =?us-ascii?Q?9vd5cmpNazOhSTZXf8354iGPlLq5t/fqChWfKJAEfP0ioP6Z7DkJMKT8N3CU?=
 =?us-ascii?Q?YqGzpW8J14dQ8hv8e6DcmXwSxXEIp7KYGO8xUBlRTv1O6f6U7ALJTgl/brDL?=
 =?us-ascii?Q?JaWZaI0zf+ZPSh5iMR8f7DyEFrTJoidBy3/RNMrsl3mVTUytKrfnjulJiEwT?=
 =?us-ascii?Q?ZwEU3X+2meRzwNuDmrb/LPS0Qk2754rjINFpVGZJdIlsk5UH4ZX/0oLW0Rsk?=
 =?us-ascii?Q?SzGUA21A4yQoPDFuwr6k6J2N5egONLXXWoy0eyxWKG92J/QMVj2QPElSR6Rz?=
 =?us-ascii?Q?j/e6WHUzlbvmfmJSzGNDhxucHd6xFINKw8Iv3AiyMfxCdJ4SOATaxFhK5+q5?=
 =?us-ascii?Q?e+pGV8wx6KWVlx5q/LbJdflQ8gEjjHXtdm+AFFqd2UC4WbXzO1rLC1vPorsP?=
 =?us-ascii?Q?SKc/O8kt1yQYLh5N7Ko3HeLeCL9rk2F48pWXeejs7EV8fNLJtW1TMUEIrfwg?=
 =?us-ascii?Q?w1oyhYVjSzwVcvkaex2Ztp2cdxKrN3L7G4MXqKeP84xz3L6fYht/sKwVouAZ?=
 =?us-ascii?Q?BsU4+rx1bU5LKcUjfvf+uStWl2EbjVtnKlZqHXtxI8yGWheb7mxqVoN+J7+4?=
 =?us-ascii?Q?XU7QkIiPhX811NsR1PI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB8476E86FE65DEE9CA8DC7895F73E2DM4PR12MB8476namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49857d2c-1545-4e4c-4189-08dd19ff82b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 16:18:55.6695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqYsfMmDpwvnAtEtf06JIFYwR2vlsKz7gYIi840PRhBMcSYkE0CE9vnm5acnmV/p5hD0HWUEKhBAqdAt2jLsnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9007
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

--_000_DM4PR12MB8476E86FE65DEE9CA8DC7895F73E2DM4PR12MB8476namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Guenter,

Thanks for the updates.

This may be a real issue. Please file a bug at https://gitlab.freedesktop.o=
rg/drm/amd/-/issues and share your setup. This helps us investigate further=
.


________________________________
From: Guenter Roeck <groeck7@gmail.com> on behalf of Guenter Roeck <linux@r=
oeck-us.net>
Sent: 10 December 2024 20:17
To: Hung, Alex <Alex.Hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Wentland=
, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; =
Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.co=
m>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom) =
<ChiaHsuan.Chung@amd.com>; hersenxs.wu@amd.com <hersenxs.wu@amd.com>; Zuo, =
Jerry <Jerry.Zuo@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.co=
m>; Ma, Duncan <Duncan.Ma@amd.com>
Subject: Re: [PATCH 10/34] drm/amd/display: Add debug prints for IPS testin=
g

Hi,

On Wed, Feb 28, 2024 at 11:39:16AM -0700, Alex Hung wrote:
> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> [WHY]
> To log commit states and when we transition in/out of allow and idle
> states and the caller.
>
> [HOW]
> Add a new logging helper and wrap idle optimization calls to receive
> the caller.
>
> Reviewed-by: Duncan Ma <duncan.ma@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
...
>
> +     DC_LOG_ERROR("%s: DMCUB error - collecting diagnostic data\n", __fu=
nc__);
> +

This patch generates _lots_ of logging noise.

[689208.336969] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689219.628141] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689221.098993] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689222.645994] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689225.341470] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689226.467388] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689226.716755] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689231.507746] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689247.287990] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data
[689252.441150] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data

I disabled it in my private kernel build, so no problem for me. However,
searching for the string on the web shows lots of complaints. Not my call
to make, but claiming that this patch adds "debug prints for IPS testing"
seems to be a bit misleading.

Guenter

--_000_DM4PR12MB8476E86FE65DEE9CA8DC7895F73E2DM4PR12MB8476namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
Hi Guenter,</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
Thanks for the updates.&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
This may be a real issue. Please file a bug at <a href=3D"https://gitlab.fr=
eedesktop.org/drm/amd/-/issues" id=3D"LPlnk177690">
https://gitlab.freedesktop.org/drm/amd/-/issues</a>&nbsp;and share your set=
up. This helps us investigate further.</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Segoe UI&quot;, &=
quot;Segoe UI Web (West European)&quot;, &quot;Helvetica Neue&quot;, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Guenter Roeck &lt;gro=
eck7@gmail.com&gt; on behalf of Guenter Roeck &lt;linux@roeck-us.net&gt;<br=
>
<b>Sent:</b> 10 December 2024 20:17<br>
<b>To:</b> Hung, Alex &lt;Alex.Hung@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Leo) &lt=
;Sunpeng.Li@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;=
; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Li, Roman
 &lt;Roman.Li@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.com&gt;; Gutierrez,=
 Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Chung, ChiaHsuan (Tom) &lt;Chia=
Hsuan.Chung@amd.com&gt;; hersenxs.wu@amd.com &lt;hersenxs.wu@amd.com&gt;; Z=
uo, Jerry &lt;Jerry.Zuo@amd.com&gt;; Kazlauskas, Nicholas &lt;Nicholas.Kazl=
auskas@amd.com&gt;;
 Ma, Duncan &lt;Duncan.Ma@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 10/34] drm/amd/display: Add debug prints for IPS=
 testing</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi,<br>
<br>
On Wed, Feb 28, 2024 at 11:39:16AM -0700, Alex Hung wrote:<br>
&gt; From: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;<br>
&gt; <br>
&gt; [WHY]<br>
&gt; To log commit states and when we transition in/out of allow and idle<b=
r>
&gt; states and the caller.<br>
&gt; <br>
&gt; [HOW]<br>
&gt; Add a new logging helper and wrap idle optimization calls to receive<b=
r>
&gt; the caller.<br>
&gt; <br>
&gt; Reviewed-by: Duncan Ma &lt;duncan.ma@amd.com&gt;<br>
&gt; Acked-by: Alex Hung &lt;alex.hung@amd.com&gt;<br>
&gt; Signed-off-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas@amd.com&gt;=
<br>
&gt; ---<br>
...<br>
&gt;&nbsp; <br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; DC_LOG_ERROR(&quot;%s: DMCUB error - collect=
ing diagnostic data\n&quot;, __func__);<br>
&gt; +<br>
<br>
This patch generates _lots_ of logging noise.<br>
<br>
[689208.336969] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689219.628141] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689221.098993] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689222.645994] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689225.341470] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689226.467388] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689226.716755] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689231.507746] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689247.287990] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
[689252.441150] amdgpu 0000:03:00.0: [drm] *ERROR* dc_dmub_srv_log_diagnost=
ic_data: DMCUB error - collecting diagnostic data<br>
<br>
I disabled it in my private kernel build, so no problem for me. However,<br=
>
searching for the string on the web shows lots of complaints. Not my call<b=
r>
to make, but claiming that this patch adds &quot;debug prints for IPS testi=
ng&quot;<br>
seems to be a bit misleading.<br>
<br>
Guenter<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM4PR12MB8476E86FE65DEE9CA8DC7895F73E2DM4PR12MB8476namp_--
