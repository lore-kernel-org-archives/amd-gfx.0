Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0591C48297
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Feb 2024 15:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44D0E10F5F4;
	Fri,  9 Feb 2024 15:21:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xPaU0v0K";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57D3110F5FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Feb 2024 15:21:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZ1pnStleJ4nsX77+qlDkJinUr4dyDmQHqRNoSGytjUkKaqWu3bd09iHcOSwliqGHuPq7kN8OBugFMdTlNORqTdW6MxW86xeBYKBJliy6pMW5gq15H2OLVCqELXfxHKUd1AotfJcpp81DpA0Cn0tMECPVulMCoD/lmhgMOh/+hggOfTXDsqkETy423RK4OXShD460Tad8RuWrb0fwpgSrBK8LXxj/w/J11/apS6dPPz487Lgx10BfI/j6Kr2cd8mmSASXdGyuZzecpdDxQrCMX0jf2+KdqUcKTRtxXanuvBvRhTJzb9BB0iB6Ovh8fkJzxepXiUuuXgVs1NA5Vm/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA5Atm7IWeP9PeRoUAR5x+v+/2Y6mMpxUadB7tv95mo=;
 b=AHFCTKxsbvWQyX8ezT6aKPar3WKiMbGjc4JQ8g5nSOsBTLQZuzeCpAxfjY9X1sMwcKpY8C/GWEgc/MNZLJoAWhj8KtQM2hmZtVZ8wQyxpWh4/jSRF4YHjWXcMUA0nO+VXNZfTE504EPwoGpUn1/mnr93+Psi3W3wfUt6WEDXHpoVG5/+L1wJp9gwwdkggZlMsWSJr92KUAouaeUvUM20la8edkaSdKuVgkSrcR1T3FLKY3GcsTD70NBE47BVibogn7K9PxF8cABibGMX2ArJjrqxXv7dBQUSwCeV3VKiKs7me4vzWgK5YoOoxpjwtRyclZ5pO/h+/pGE39tiaquaSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA5Atm7IWeP9PeRoUAR5x+v+/2Y6mMpxUadB7tv95mo=;
 b=xPaU0v0Kj59bn8xDvwzTRPQlL0d75asmKl2T/2U2b1pNX+kp227b+tCGXM3bEt3w7tRxMZL0qLJO5lz+RmYzizIS/8zTdaqR92AQRUkJ5oW+klG8rlzR0pvNe9S5qhnfzkfi0XJ5E1G9g2SKPu8oHezFGsJvlJKORReoLxADYTY=
Received: from CY8PR12MB8193.namprd12.prod.outlook.com (2603:10b6:930:71::22)
 by IA1PR12MB6307.namprd12.prod.outlook.com (2603:10b6:208:3e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Fri, 9 Feb
 2024 15:20:58 +0000
Received: from CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c]) by CY8PR12MB8193.namprd12.prod.outlook.com
 ([fe80::92fa:88b3:a796:2c8c%5]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 15:20:58 +0000
From: "Li, Roman" <Roman.Li@amd.com>
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, "Liu, Wenjing"
 <Wenjing.Liu@amd.com>
Subject: RE: [PATCH] drm/amd/display: Initialize 'wait_time_microsec' variable
 in link_dp_training_dpia.c
Thread-Topic: [PATCH] drm/amd/display: Initialize 'wait_time_microsec'
 variable in link_dp_training_dpia.c
Thread-Index: AQHaWYHmU61kRmfb20CfGKPOyF/0c7ECISjA
Date: Fri, 9 Feb 2024 15:20:58 +0000
Message-ID: <CY8PR12MB81938434AF2565F35BDEFF9E894B2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
 <20240207045501.3344729-4-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240207045501.3344729-4-srinivasan.shanmugam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=16b38a6b-8839-45a4-b66a-c347165f89db;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-09T15:10:22Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB8193:EE_|IA1PR12MB6307:EE_
x-ms-office365-filtering-correlation-id: 60722159-f4f1-49ac-bb3d-08dc2982b7f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: inqjZJxALxaNdyBd6TY8935zvw5QPYjnF4s40vITRjDYe5ylk1ylSARqZCN3z+VghWlJALwz7r2kXB0ma5v+G1zbbNK9pA8g40JXdn7pt2j5flkrkVy/OMzj3xSTfz/gcze4+6tZ83dVsjjtFS/WpAKX9QbSPJop2UUyWCajHCmN3HUQKbf+RuH6ustK5BBfC+vCy9FUz6wmFSuUFEqijYvj4s5rC9FPBtRJIrO4L96PuykiaE5pObgZVu5L3MFL56Sd5hHrAFlU/nXh2UG6Z/uQm+ZD1nhY5mX29z0cfno7gVa94ldAUMP5Sgha7K7vS+xpzhpskJcmwweHEtaaHwQDaMG642oeQCQFgInNMRgW4s0QEkTn1+KqvFLPxBnNNiwLUYX5vBoeyKAlvWlWtT4Fc5wVEcqmf2qjx3jsARuqIocslptUsfQOe8rrtLmpmQSy1y7WQzwhqHVTj6za1bBHMsaL03VbqNDftKKwAPPpsnYL2oucVY98swkp/MWqmF2JWTXxXhfa4VeWjH3YYwCgDFjoelf6+PEB6keIkksk7YtWb2p/xwXPZmvWLo3Uk3CiBi4wLsDodB4QiWzXvKDS9HlCVTSlSWQQVGk2QCMXVk9ADN9XYE37PWPXphc7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB8193.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(122000001)(55016003)(6506007)(41300700001)(2906002)(26005)(6636002)(316002)(71200400001)(83380400001)(7696005)(53546011)(478600001)(9686003)(38070700009)(5660300002)(8676002)(110136005)(4326008)(64756008)(66476007)(76116006)(66946007)(54906003)(66446008)(66556008)(52536014)(38100700002)(33656002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TvOsrMrZjduIr1KviLucMFZiUMXGDz6Qjq73ZTb70/GrDenK/zB1M8osif5Z?=
 =?us-ascii?Q?VCkiL3vTgrtWllczB7IiozHoumirrjZveb3/wICMf0fkcipeDd+V3Xw7ls9p?=
 =?us-ascii?Q?I8kDdYuzzrz8YuGNXgAZ1oDPCQkNQvPI3X7qx8UtunVd3dSElS4LgsWu8MRT?=
 =?us-ascii?Q?/FOKQZJ1tBZjbidfdSnV5e2pWfjSAaQCam/JMBYVsp3zaT4EX681K5BsFwY7?=
 =?us-ascii?Q?tAEcskb55aXOvei3BxeUXoGVepKkesNXSW4Uv/HtFmaz9mT82QwUwQub9CiO?=
 =?us-ascii?Q?dKVeumkmOlLNGISRDLFLPljlfqGypXzEVIcrd66fTUwfBoaDaihOpagvNgZ1?=
 =?us-ascii?Q?d3/7mNP5HvBGq16z+kyFyT2pnyqKqyclhv3YfUMdUuUrfXv/z6vDbZepQbpl?=
 =?us-ascii?Q?aHpBwelQRY1omqz8TzmqQBtNRV+dkbSkpACdC+1g+KE9JUOwiL4h7SUVxDax?=
 =?us-ascii?Q?71XKc+H54pWFvWlEnIpDMdei4j0hyj0pDOPX6PbLJsRxpkjT8HLpKIqUVJwr?=
 =?us-ascii?Q?VMlszDHXsv5gPwUTIL7kkwb+b8Ixm0L7G+PZy9bYCOi/bLs6UE6oAQZ5ljhX?=
 =?us-ascii?Q?KFjh+Tv1P2JhMEmwfRLCITbFPkeYeJ9TJaINFxLVw3n6pI6EfzLstH/lDvGS?=
 =?us-ascii?Q?2bRI9nhF7lTqyq413pct9pWkD8HeSRhv7gl1hv9BhzpABUDyr4PRh+9iYpaA?=
 =?us-ascii?Q?1JAIFj3w51c+WrdagHSv7nC/D7zHxgRzDYHrJQEMTvYJqzy8QxrH1rvP8WlV?=
 =?us-ascii?Q?bM5ZHvtb1TvjNv2i+5tJz2flMSUcxENWT95SxuZ3FRD1+eBelzVXXe76woK5?=
 =?us-ascii?Q?XM/1jjGXshdK7klOjYginhcGwDZH6kdUEMG3bgRP1ZIVcMKOioFx0uwFSLGc?=
 =?us-ascii?Q?0PDCncOgbFRMYCwKGyoHq+wqUdAjICCO8uEx3EAJVMdcG4SyxM1+cl+23nhI?=
 =?us-ascii?Q?PxqmoL9DhTlf9N56uiSynFCV/IavIYeLxrYmDDMtZNjkynBjiIzIgi6O+obJ?=
 =?us-ascii?Q?Q3Czo3SXUloQZmW7VOZFdZhpZpbRgcXbt/2dnQxntdNs6OWD28ZBrtwMq40Y?=
 =?us-ascii?Q?YGtELKSBvuGcbr/0Zw0E4Zo9UvWhn9VT0vgMnyV3T4yLgMkg3AM8WrqoNv3E?=
 =?us-ascii?Q?+X70FSOUMZEPal6R3VhOeYgFxJeVIH9RiE+g/x4uvvUqP1W6l7R/7uttP+Pz?=
 =?us-ascii?Q?HuMk3YV+Ny0vUAjjJ5JLx+1a2c1tbsu8swwhNrZFwKD2oaxD7Qzp6dt2Q+gQ?=
 =?us-ascii?Q?b+fSeQH0eu6Zcb2em5CZCtRYEOurnEj9lUM22qminSznzIhrYVNNMlry+Rtp?=
 =?us-ascii?Q?P7BTgmkUEPVRWiUwwp+v3yNf6Q8t+/IhnMnRF2CFghH3qgRpeq5zDKgZ01qp?=
 =?us-ascii?Q?x+ec0pLmK+vkVsldAlayxR+smITySuD5NMY/pGe87EzuyTrkWkqfsfwqLBnb?=
 =?us-ascii?Q?rdtfR0La9OEbXwSYNhAs7SJTy1XltLS8jhQrEJVK+2sjs9/Lzc6UQLVTFtn4?=
 =?us-ascii?Q?SqHA5dKlfU06zKicWpTlyBtpiWyF4F0vc5hyFEA9Nwl1/9TmRgwkLNMbI7ia?=
 =?us-ascii?Q?RwjBTUhoaC0xacPViBw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60722159-f4f1-49ac-bb3d-08dc2982b7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 15:20:58.8401 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xY6+N62JJvnSa9xPOUxqZWbFwQXb/knePAo8ZFfJwWCkTDjiv5xErgnMLKQHaY5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6307
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

Reviewed-by: Roman Li <roman.li@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Srinivasan Shanmugam
> Sent: Tuesday, February 6, 2024 11:55 PM
> To: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo
> <Aurabindo.Pillai@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; SHANMUGAM, SRINIVASAN
> <SRINIVASAN.SHANMUGAM@amd.com>; Liu, Wenjing
> <Wenjing.Liu@amd.com>
> Subject: [PATCH] drm/amd/display: Initialize 'wait_time_microsec' variabl=
e in
> link_dp_training_dpia.c
>
> wait_time_microsec =3D max(wait_time_microsec, (uint32_t)
> DPIA_CLK_SYNC_DELAY);
>
> Above line is trying to assign the maximum value between
> 'wait_time_microsec' and 'DPIA_CLK_SYNC_DELAY' to wait_time_microsec.
> However, 'wait_time_microsec' has not been assigned a value before this l=
ine,
> initialize 'wait_time_microsec' at the point of declaration.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training
> _dpia.c:697 dpia_training_eq_non_transparent() error: uninitialized symbo=
l
> 'wait_time_microsec'.
>
> Fixes: 630168a97314 ("drm/amd/display: move dp link training logic to
> link_dp_training")
> Cc: Wenjing Liu <wenjing.liu@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  .../drm/amd/display/dc/link/protocols/link_dp_training_dpia.c   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git
> a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
> b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
> index e8dda44b23cb..5d36bab0029c 100644
> --- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia=
.c
> +++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpi
> +++ a.c
> @@ -619,7 +619,7 @@ static enum link_training_result
> dpia_training_eq_non_transparent(
>       uint32_t retries_eq =3D 0;
>       enum dc_status status;
>       enum dc_dp_training_pattern tr_pattern;
> -     uint32_t wait_time_microsec;
> +     uint32_t wait_time_microsec =3D 0;
>       enum dc_lane_count lane_count =3D lt_settings-
> >link_settings.lane_count;
>       union lane_align_status_updated dpcd_lane_status_updated =3D {0};
>       union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] =3D {0};
> --
> 2.34.1

