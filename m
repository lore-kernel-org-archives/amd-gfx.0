Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B89EC83F1A
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 03:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0251510E3DD;
	Tue, 22 Jul 2025 03:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tPhjCQPu";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD35D10E3DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 03:11:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w180JZKlPtLmAPsoQLYmgP2cVuyhZlb9hmFAYCGV4t1LkHBRp3XDlFBct1dZucriRmiqpyrbzPHPW2zfRiOrYpuG0ushl+E3Y+W7gtnyzi4ArWgDZG/2AqG4i7pEigbdqgkYEYpqGNTKalGJwDxYAEFoPVX7wUvThSuzssXl3YcOxDIbdUFK4hTArKMhzCByVkfOZLmRMS3fTZL5qXYAeZg66B2sj4TL79HhrurYWEy9uyhgIq/VlZPn8KrsubiOakjCmYirMwjOybeVAbvucgrvhOXZ8nLmqSGH1+jskmPdhmJD/Z08FGFD1HElkP4hJbCcVN0or28gPRGKx8PD5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXGnb5MXAIR4HtsxCDNPe/7j5qxXJjBDaG4ayuBzhWo=;
 b=MXdVS4tifGl0xRQhavR9nqkFD38E1L3gHjy8Npc6XBBTkwdSWs5iO0j4QnqlZDbXOWIfCnNiAbnZZXewvQ+18eOwjpH0w1LKU+f/ANXokoe1oMoVhNKwNWlvuNUeQCTrNJ0BP1a/E0Qx4ODfdyb2TmYfMJpPa3bEZTrzMXNdK5WTFUV1TBHz18SocvYKk8DrgkO3FhxBVlOPTUVRw8Etp5hSM/byVt86xTd0+xJZmp0rDkCXMoM/fT6pfVZE/DMAo1ANo+vJJDVd6RkQ4wEn7fsQA+7LFjZ4sfBdw0ZN5q7TjrpENuc/jBizhHmv2++PHPLbGAWpX4pZdg7NgBzIfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXGnb5MXAIR4HtsxCDNPe/7j5qxXJjBDaG4ayuBzhWo=;
 b=tPhjCQPu6eGFc8aGJ1ZKxzEUFoIJMQ/X202FF6mSN+zo7l/okApiFPYZ4OXg4Br9UeumNEpwQ6U34beJLiyaiaTNWEariU3Pcvnv/UetVs93JTEFcflhNqVmnMLyNofZz5KWpzdKloZSKFkZoLhOLFtq/1hmt7mB3vx8QoGgQU0=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 03:11:11 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 03:11:11 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 types
Thread-Topic: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue
 types
Thread-Index: AQHb9p02iGBXqr6DXkK8UYwymIr8v7Q9dhKAgAAHwzA=
Date: Tue, 22 Jul 2025 03:11:11 +0000
Message-ID: <DS7PR12MB6005861E21B050830C142603FB5CA@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250716220115.3872837-1-alexander.deucher@amd.com>
 <20250716220115.3872837-2-alexander.deucher@amd.com>
 <DM4PR12MB5152FD2E9D0CB1289DCC5B59E35CA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152FD2E9D0CB1289DCC5B59E35CA@DM4PR12MB5152.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-22T03:06:00.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ2PR12MB8784:EE_
x-ms-office365-filtering-correlation-id: 2a20d1c0-e3cc-461e-548d-08ddc8cd68ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?b2RCSq3CefQyUMO+xg1xDO4gEZevcKmHqwG7gGUALuiGzahyCrOn5vGtb2?=
 =?iso-8859-1?Q?/Z4j/+pW8oxOiA+pPBTSa8b04YEzYEXiwe/idrv0nGF1G5nic7XPFoi7WL?=
 =?iso-8859-1?Q?J7xaxpBoPbLK0Itb8wqWxM9eIF/QBIVaIg7o254YcNPHFXxSKrgYHr4Mdt?=
 =?iso-8859-1?Q?32y3K0XTvN+lBKNmaJgtsbODhQCSj7d1sp9IwT8H+MkpQmmsFffoKUOT1S?=
 =?iso-8859-1?Q?Mr6Augw6s41B6KSHG5n7EVm8NQzyxrUv6XWhYoHr750rWGToAVmfkrlj65?=
 =?iso-8859-1?Q?owouBFgUNx+JCfJDu8wb/rsW7uQFQ1kV4QsqHEhVhkvcHSYkzMGsM7mfWl?=
 =?iso-8859-1?Q?wgsSonfnTVJRI3br/15vtm1DC3lyGMy4bDjLRkQnOBi2JJtxMJaydIcdJv?=
 =?iso-8859-1?Q?iw/uQ6+gIN/ewrSV+zQ5KLOOoc6oLJKwvHYP6P5OgFexcUB5MIUrtXbCJj?=
 =?iso-8859-1?Q?uax+pABCKfkl5hWT8dYQQ7GCEib9n3Aptg92+6eXJPdVzuDukxvhN9atzi?=
 =?iso-8859-1?Q?4sdjtxM+f/uzLpIctrOZUh8te3gwUF/P6E5oXa5c26bRHQzHJZzHw3TPbU?=
 =?iso-8859-1?Q?rvnbLtG3TJnR9jNJK6thS4tKgHJc7Pq9+xy9tydNLXPnOBNMlqyjfDHWw/?=
 =?iso-8859-1?Q?t1BDG+tK9lKY2gHwZeBEBePb+I9Y3MMX46j9TySt45AW9NJTLTc6xr19vG?=
 =?iso-8859-1?Q?41kVfv8l4aC392zIlMctxhOHUMjf3NjPWSde6gYLRXeLneztiXnsJJTaF3?=
 =?iso-8859-1?Q?w0T7mE7ji6DkD8yAc2wM15IwnLS5B9mMhGmudlHTxfr8gyOBoOL0Lnd3mr?=
 =?iso-8859-1?Q?VtTcPe1XtlkYYHaLaX5/To0VpNOsfL4vFl6EurIenD4UgkHSzE3e/yL5G6?=
 =?iso-8859-1?Q?kEWJV27aZwn4uPi77PZz4OsC1wiVNER96dmTKkrzdY+flbCEYuRqZ4Bv1m?=
 =?iso-8859-1?Q?60NIVGXDyWwCvRmMnZHILneXU4WQYyMW/2BvZKNL6Vx//PVRVsVR6OmziI?=
 =?iso-8859-1?Q?WuiMf/F67gnbFie/S9/IW/RyerqV3d/PSMk7Vtbh5LFq3XyjGk6EsPsJ4F?=
 =?iso-8859-1?Q?LNBaknIu4znbTFv1SI9xMZe8OsvNEzS7iyyfaBekys1oFEyG+FeRMmpJkb?=
 =?iso-8859-1?Q?NQiRObHycI9YREtYipFYvOYPUvT1Zy1hvvLyH6W8vhyaAh459BNPdVSHkF?=
 =?iso-8859-1?Q?IeYHmfBzFOUqaTMb629lTv16qQ9sn4+3BQ/DugkoI5L4WPwXf4lOQo8Zn5?=
 =?iso-8859-1?Q?2WI2GM8uL2N8tXZEIyUnR6teP3ozTCEJVWf3euJjjkG/Jsu1EW49BZ7Ugc?=
 =?iso-8859-1?Q?RsRdcGguVjwzAQzvTRwpoVQJsmIH4Qs2+yiToBtQNgXvfrk9EG/QUmfmMb?=
 =?iso-8859-1?Q?u2jKtkuVBh/X/kf4Q3CCUNEooQcrHlQ8Z8shbT1jdyueD9MPB871cW+qYr?=
 =?iso-8859-1?Q?a2hD646YOC28YYfB5oZ/gzTDLeyfkA/dqa2PdbFZ9c4LsmybuUmwu7sxi9?=
 =?iso-8859-1?Q?MA0NCb2+JQfVU2nelW0Y2e5N4UxfmYIzG5g8KHe9GfPg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+pbc6iMK8wbzw8t0HRMDOmO6gIx9uBj4xf/QwBwqhqf+UdCDgVU9EgLji2?=
 =?iso-8859-1?Q?OFu0sWhUbewR/V10WJb5XvckBnvAJGze98qVfpMWQARzmFlGiiZTIxT1OU?=
 =?iso-8859-1?Q?D5DS4MZS993k9HxGLcBC5aDbJk7vw0J25uM8DNVNnMkS513t7EMH+XMwQb?=
 =?iso-8859-1?Q?JK5RSYw3qw3AC4yM8ypLRUjMGk9qHHas+bO/p4L3xgvNGk2luzXX1dvBzt?=
 =?iso-8859-1?Q?1xsmcYBy9rFnKahL10FLFfdOhuy81LNyJ8EdxSE9ae2pDgDJ7qyhFFHeNU?=
 =?iso-8859-1?Q?e5qi2WNSSs/MVBEdYzXCvbLu0xorMQfOwkEf3K6nlfoCKcW0Im3UVhyZlk?=
 =?iso-8859-1?Q?WWNot6D4s6SXgDCm9z5uXBCU1YsDrvA+8g5NlBgFdUjrJoJw6qf5lDiNZJ?=
 =?iso-8859-1?Q?vkbINsY+Hk2nq/ec2ZDathcmoz9zSBGI6Wbghijk36KzaBbHczthqg2PKj?=
 =?iso-8859-1?Q?nRvL62MZ91X8BZ6B70Xexyh6iapFKO2X+NG8fcYwOufONH0/AuzN5X3zGs?=
 =?iso-8859-1?Q?NzFMvBziNEnPFH/+CKckVsOsS5PsfyLK/FRs+woX4NcuKchJHGDknn7llW?=
 =?iso-8859-1?Q?xCDLlD97idXwnq1aZC/9I5efc5DxqsokESt8doC286qHZN/vISfM6X/fsO?=
 =?iso-8859-1?Q?BIcZHjJsNgmcLhF0TJBZsJtSLBjuwox55D7JrKVxSQC21/E2YR2ZL+6tY/?=
 =?iso-8859-1?Q?iGkDSDqjf/GuiU4STHGbotlfNInEAgV52+Yvp/kzRKkA0i8nHILMjWjOel?=
 =?iso-8859-1?Q?ljCK1lioAhEDOI1nbdVrcaLL8xNnstl1PWc6hgCFhz8V3lr8OXvSr58Mp2?=
 =?iso-8859-1?Q?C3+9yrqmKYa6lDzhxd7J5FfpDN+bRW0Gfqx5K6j2jKuIAfAPkSRFDQENSa?=
 =?iso-8859-1?Q?wuboM6PVvaTS8shz4XHhmRGCjkLk1MyGtV3srrIjwEjIqqVe719BiKdzYx?=
 =?iso-8859-1?Q?SQGv72BLiixwHUovHVktUaD6jBWuPZC7cDW9iHf3ZHacpK5NOoExc+rLKs?=
 =?iso-8859-1?Q?x2DgdAv4CGb77Yl+pmslRwID+/OJz1rdxONy6NpW49g2Lrc7dIDaZL9P4o?=
 =?iso-8859-1?Q?2xL7eWET2m2yCjBnn3oB2vTt54GITLnfNwVS0ARGucMxTorJAgkf2/KDBe?=
 =?iso-8859-1?Q?Vg89B0TUb4K5MdPK7cIps5jSQ97nC3bZvb+F2nkhawSaZExOBcO8b95+DU?=
 =?iso-8859-1?Q?ZRMQrmlaXc0GZXATi7euQuYW5OZSfhrG13IB9qUFVUS7pxnvqr2Ggg6kov?=
 =?iso-8859-1?Q?nw/UneIirSYtBF/0u2J1WQ22vagbk4bck1BYKs4OHBJdb1rBBLyCJy5Ok3?=
 =?iso-8859-1?Q?j9xhZNcQP24kcJ8sqFJJnH9LQN3OVIqv1oDw4R45Y6muVt2D9yh5yycEo6?=
 =?iso-8859-1?Q?Xto6QDxlrXDCW0AjB9gI2bXoWUx92CTioD/ozEzlI0gFWZp3c/ArV395BX?=
 =?iso-8859-1?Q?RRG4k45l17D8+7k+o+PHSwuUjrheDmKe8Jg0JBJztGK+0/kiQxgGLkgGP2?=
 =?iso-8859-1?Q?8ahohaxkZ5NvVElDEPHn4o/8VwHXU9kB/R1x4+ShfDeNr959lVQFLZFAWc?=
 =?iso-8859-1?Q?Ft3/kh2qSCGpSEs4G4HuJQxWrzHD7bO37peOItfx4ZaUinGh7CukdbYuJE?=
 =?iso-8859-1?Q?0JlOUJJErmH3I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a20d1c0-e3cc-461e-548d-08ddc8cd68ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 03:11:11.1719 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UCuSUlRkmvK2kUt8athaGSqZDzr8CdLGniro2UCS8xRLoZv6MjPh4Owh5GwbAqL+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8784
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

[Public]

Maybe this issue is introduced by the userq mapped to a privileged queue, c=
ould you try whether the issue can be seen when only enable the userq?

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang,
> Jesse(Jie)
> Sent: Tuesday, July 22, 2025 10:38 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for qu=
eue
> types
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi  Alex,
>
> With this mqd configuration we get many cases of illegal register floodin=
g and reset
> not working.
> Should we create the privileged user queue ?
>
>
> Log:
> [drm:gfx_v11_0_priv_reg_irq [amdgpu]] *ERROR* Illegal register access in
> command stream [  180.429970] [drm:gfx_v11_0_priv_reg_irq [amdgpu]] *ERRO=
R*
> Illegal register access in command stream
>
>
> Thanks
> Jesse
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, July 17, 2025 6:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu/gfx11: set MQD as appriopriate for queue =
types
>
> Set the MQD as appropriate for the kernel vs user queues.
>
> Acked-by: Christian K=F6nig <christian.koenig@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 372dceceff359..9dd49b1caa605 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4129,6 +4129,8 @@ static int gfx_v11_0_gfx_mqd_init(struct amdgpu_dev=
ice
> *adev, void *m,  #endif
>         if (prop->tmz_queue)
>                 tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1)=
;
> +       if (!prop->kernel_queue)
> +               tmp =3D REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV,
> + 1);
>         mqd->cp_gfx_hqd_cntl =3D tmp;
>
>         /* set up cp_doorbell_control */ @@ -4281,8 +4283,10 @@ static in=
t
> gfx_v11_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> UNORD_DISPATCH, 1);
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL,
> TUNNEL_DISPATCH,
>                             prop->allow_tunneling);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
> +       if (prop->kernel_queue) {
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE,
> 1);
> +               tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE,
> 1);
> +       }
>         if (prop->tmz_queue)
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
>         mqd->cp_hqd_pq_control =3D tmp;
> --
> 2.50.1

