Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1C9C28B2F
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 21:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66FEC10E0E6;
	Fri, 14 Mar 2025 21:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cBLrid0U";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40AF710E0E6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 21:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKBLlPgy/NYlWqIEf0uhLiphjiwd7K6Fffc4C8shOXd5if4+i2qpEc1pUEvqNY5j1zotUHv5M5w9SggtkvB6R75O0HD7BopaF9400pPL83eGDYW3n+tCzziQpPGiPIUIHfli6BME0QEj6PxBJdsXoiFL964iy8uqpenzVFt/R6zIIsrN479Elnbts2I7gALlJUt4NNiOmKhiF8wM5+UwZOSZzirIFWpyufNGppv0p/pD97VVwsCReIkKHz2HdSCaE/4cSDJU4fk/OAdOiTLQ7SLvz+B+sG+B3P8lcjPsBJR9M0adMpVF9KVxKPGJ09mVZlo/IZNuF0J90huMVIaWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EFvCWG+JxuC52d79oT5fLZHcmyUvskZJolfgEB3rm4=;
 b=U9wWQZt1FNGHfGKcDs/GaHWnuycF9CGmhRc2jzh0syZiFAxS3a8bsh/VnxesU6tbX1H/As/f/ZUcPQgt8u7NSTmOhc6p1wU5LMhSplBPyvwyDkA6lCE2nu8Q4QkTXLTw7e/gxQ6ng3yuHUuinkhVm4Dwm4Z6VelaOw1k3r0tXqrdsimEUuCC04InjhEPirhwq8gCQJ5hL0Y2rk18P/A6SwOFEHS9pjzUIXnuKYL6oDafGrDcCidxXnvSSMy1NJijjExTOnetm+qOP5KUo7NCDEDo2QCbShJaprrXTbI6Aef3QhKWNTqzHLUiD56Q0tYirA5kwrYqAn3Ws1yzFx8cdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EFvCWG+JxuC52d79oT5fLZHcmyUvskZJolfgEB3rm4=;
 b=cBLrid0U6JInaDActQgAcJHOnx+sEyoVnbMLVpEmNUEXKZjkLU9c1V9aIkBRmGcLWnUaQnaDL/SwB/nKLwT1POHVdpHn+zlj8ohfNchdWy3iXajkcjzw+ikgtV/VkRbHS1euqfXJiZ3w89noYYMoLQHllbGrhKifjVuylpL/6Oc=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DS0PR12MB7852.namprd12.prod.outlook.com (2603:10b6:8:147::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Fri, 14 Mar
 2025 21:34:39 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 21:34:39 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Topic: [PATCH v2] drm/amdkfd: Update return value of
 config_dequeue_wait_counts
Thread-Index: AQHblR7eJxwPqtu9HEGoIgvDOM4+0rNzFhAAgAAI/YCAAABHMA==
Date: Fri, 14 Mar 2025 21:34:38 +0000
Message-ID: <CY8PR12MB7435798AA23F01B8875E77AD85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250314202211.251641-1-Harish.Kasiviswanathan@amd.com>
 <CY8PR12MB743573AF240E36758EED60DA85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
 <CY8PR12MB7099D2903862C6C0943644BB8CD22@CY8PR12MB7099.namprd12.prod.outlook.com>
In-Reply-To: <CY8PR12MB7099D2903862C6C0943644BB8CD22@CY8PR12MB7099.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=02da4d1b-0448-45fd-b918-53eee9f4fbaa;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-14T20:35:03Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DS0PR12MB7852:EE_
x-ms-office365-filtering-correlation-id: 4fe4cbb1-719f-4ac9-719a-08dd63400640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?fAJruHb3nkB77iG03aDQzteQyMTFn5y2Ho2AfbnrhChvt7BRcLx22RxovPAp?=
 =?us-ascii?Q?VUIhSEvDRRTH5I5HgbN8Yc3TGWFrZFMmTJxQoe32pmqmdfc5v/xeZd+0GNGU?=
 =?us-ascii?Q?6dsCpsXldOO8jmXld+XGZix81AUp/DytxMCxCvyxQkYfRPLlZnecv9Nc/K8m?=
 =?us-ascii?Q?hyw0mst3X2jTmnRA+nd6IEAkMzHLAP4DkLSEzD5Qyop5MHZ9OSnYrmj2SjCx?=
 =?us-ascii?Q?yCkHPjKbC5vNBKX9URPsJKqyF1OJIiAMh2WC+GnXd8kSyzKYa/jnZNKkmVog?=
 =?us-ascii?Q?o6TLx01Uy/jAmlhQ+BpYovxMzDDTDMYPpWt8TcAKuGQ2XWZVmQfCYR60rQwa?=
 =?us-ascii?Q?uc261dYNKtVa5gqLfigCShtQ0w/m9KEipN4cN6cnOOq1DRPXtCece6DFWIXk?=
 =?us-ascii?Q?YB56rZHyPdxv0nq9NxEmIPonibtev7AJjxFGjDeTwUZbV2iLiapwKpfJ7tjP?=
 =?us-ascii?Q?QGjIJjsq/hlKvJSw2EQ/J2K61iPUZ0+N0h4o7HZ8tkx80peowVHJYleG362Y?=
 =?us-ascii?Q?oYd5AF/BhhlwAebhOiFMc5KbZ976gK2j4uLrJyDEHpdU2Kbo62e4pu6H46Lh?=
 =?us-ascii?Q?iMOAPm5VEAQEc6sYiJG2bFGI3mOrGDEFOByD6oaEBMdF85G+y+TE+08AaTGi?=
 =?us-ascii?Q?Q5z4KVlTfazUJa5OBlpN9NksvqrR9GturaYklC42o4PAX0k0jwD7Jscxd1sX?=
 =?us-ascii?Q?SvXddSr3PFi89ep6baMcHHiitB4c39SEOjPw8ZwLSj7KUOPc8Hf8c2sCSyg/?=
 =?us-ascii?Q?bS7m8jWiT8Ag5rQe4ygv1pOwEuatf92/O8sDU0iHtR0ZCA4xjjPde5CEYq7U?=
 =?us-ascii?Q?hCB5+V2XERO8S9sJvGpBH+MVymG7t1424ZRjhYRjLaWLLGm3THlnhQkiOSg/?=
 =?us-ascii?Q?Jbainb+1D/KWWW13Ac83WtGMRg8buZ4VZiOh7EOi0jD8WF+p+DhvTckJDYh+?=
 =?us-ascii?Q?M8ettSVg9lPaYGw7r/D9Dwxv6eygP2ATxsrG1fc/JFMPLl4ppX/Esi4Qyd1N?=
 =?us-ascii?Q?R/5KoK54MFcNpsUP3lfb5te78+ceELWbHmcNAlV/HpJkuTrn5lfb9FCNJKQb?=
 =?us-ascii?Q?pXhtVb5v3guJLEwBJ7ku7yNL+xLGBxdy4mhtyU++676iHEGu3WjIzQcCUAI6?=
 =?us-ascii?Q?UfX5VS+NTwV06r+1jo7exEAPjWW1iAg80j+4cu9a5bDqAUu88TbBgWj91Ygy?=
 =?us-ascii?Q?SF8QllC1O3F4UhE63fisSyVOK4WZEixRqD6UXfD/WLdmR79R6hrhq7YjJ4s9?=
 =?us-ascii?Q?Ke2dQyb3T+bewCAPRyKLuEw0TwzCZ9hFNpKU/JmJ2c1zbGtgkXXDVG8wvvC4?=
 =?us-ascii?Q?gppmXGNrofL0iGJM5tmq4QCkHjx0V8P1WkfgzKpK6vwob0ebS6lKC3u8SpOa?=
 =?us-ascii?Q?u5COARPJ+ekVi3hjNrfRX3iYycei4wb3qBMU4dp+Lo+Tayos/1N+nrPG6p1n?=
 =?us-ascii?Q?nstLh/5UEi2qMgszbQBpOdWpz7aje2gP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V+Ji3TWxyErU9NJk9luTUTu/EyK9ivNzUX6PEG9Pc+xF65aYlZNSkulzDLpS?=
 =?us-ascii?Q?xI0krTaNr+xsiMBzE5OO4HzcdQG4tWY8D76KpKjwkh0/6tefemWkV5y/hgFZ?=
 =?us-ascii?Q?he6kDXSWyKxKVerzrXVJ3o6YRHB2ORMA0Zr2Cb3kZHKDztpfOOK/tTJX0NbG?=
 =?us-ascii?Q?44AkWctvJ5rG7QSjV8mRxVHi6GwzkXokjMwtCrHxr1oMxDlmjP/uekR4Fu6Y?=
 =?us-ascii?Q?X7dZ01ZmPUWuTdjj0SFPccphk0A7oIkhehfsNF/lWGnfZ1lvrVNkm8wpIgtn?=
 =?us-ascii?Q?QH6VOLq+bUptm7SXm9W1hDLwgOs8XzDy4+le6fYT61giAwJAs1+A4WzP/1NO?=
 =?us-ascii?Q?tZ0XuUnWZaHXVUXPYra8fKD+fW9umOBGHx3lmuJsNaroye1X11UQMEU5Ar33?=
 =?us-ascii?Q?yQ5eGuGQ8iQIIMDzeatRvT8VLfbuX0wmLFKQNCVo9nVZDeIQ6Qgg9GD233dp?=
 =?us-ascii?Q?UP24smemv/2bqq/Zd6q552o2pXvTAvpmSCqH2KeLvBo89xkodePz9AJEnV0Q?=
 =?us-ascii?Q?dshtVv8viaS5XD5yTv2J9R9+GIVXY8RQrnEScY8vUQxNJYtd1EUeyBOWeJxp?=
 =?us-ascii?Q?44n7HTBMaXddwnmVI8PNpmlRk2O4zvTKWkWkfHtb548HksyDcGaF2cqV9V08?=
 =?us-ascii?Q?e0CV/FIB8Y1rQiQ3q0qvP3nEEb04UhEr++PF+3uQZb1i31LuSEIpG9TsqSJn?=
 =?us-ascii?Q?gI9KG2UViZ4Sqq64hxgx42tAbV/hsheA2X9cFB/hutv8XKn+hm2icGHOH33C?=
 =?us-ascii?Q?C7nZOKunO8DEREtI8pDhlLzjo5F1ujkGn5pPdpiRfwSQwcN+RMCG0KsX7fH0?=
 =?us-ascii?Q?rsSXzlqPxOX1Ci2cWbD2uLIZnOD0eJa+USvWmvp2Zv/xGVZocNLy+zYC9ptR?=
 =?us-ascii?Q?yxFhHZzDztD2c+cyeQydHxf4yqww6ifVfCpcFzy6vpPMiiuydLBfTyF9rS8s?=
 =?us-ascii?Q?+DRh12WDEbn0lHq8ReHx6edYghIVBvalwWIUhJn9wEefGNkPdourzvcRo/yJ?=
 =?us-ascii?Q?NiAJW+RpuEp/2EExseJHZdzPMqqAjQ9IJGfjeNAG7WKcLedLFLoXExYdg7MP?=
 =?us-ascii?Q?EER+5umhEgzgOrIArJy/TnvNGn4mRUfqtRyFhYuWvJ3n07SlZLj+tNjKbq1N?=
 =?us-ascii?Q?cP+PIGDBtPmjpEZw3NHy90gLvS6vwt+9wDRGMfr5P0cSsckuLVU7hf6TabBr?=
 =?us-ascii?Q?7AmUGLcpcqOPxvTqb8H00SA/LnEYQ0+5zNlHY2Lg2K9LglMAY6Du47VeixVo?=
 =?us-ascii?Q?7Fntut/LxjX8SF7W0o4XiZLcYSJLPpxs9q+YDkJCiR9rf+Dt6uH5epbRsCwK?=
 =?us-ascii?Q?opkVsSgxPPnXBc37mMVqB7eigbChd/5gcjfWYEythhsRbnimfgcP+9MXU9Ew?=
 =?us-ascii?Q?GB6y/lkcwQ9gh54en7hNTiaOz6f7lcIxzAVGnlRCfvFMBE5uNJ6KQKlvqy+w?=
 =?us-ascii?Q?1/WkmvFFUg5pJ7MOKPiphFVrVbuZPx1qtUNZh5vFvFrew0Tz0gI8VwPp9k+a?=
 =?us-ascii?Q?W/j4dlx73vNSDU3igwSFgGyx9QIwicA3JODh7VQxgq1ijhgcqI9pmFCaS+17?=
 =?us-ascii?Q?O9aOKVO970RPrpk2UKE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fe4cbb1-719f-4ac9-719a-08dd63400640
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 21:34:38.9814 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gYZdrGLQC4jVETf32BXuxxzS4eOolStM2PR1NnRK3r7QXT75ZSyEr8jgvL6dDGUv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7852
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

> -----Original Message-----
> From: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Sent: Friday, March 14, 2025 5:04 PM
> To: Kim, Jonathan <Jonathan.Kim@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
> config_dequeue_wait_counts
>
> [Public]
>
> -----Original Message-----
> From: Kim, Jonathan <Jonathan.Kim@amd.com>
> Sent: Friday, March 14, 2025 4:41 PM
> To: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; amd-
> gfx@lists.freedesktop.org
> Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> Subject: RE: [PATCH v2] drm/amdkfd: Update return value of
> config_dequeue_wait_counts
>
> [Public]
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Hari=
sh
> > Kasiviswanathan
> > Sent: Friday, March 14, 2025 4:22 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>
> > Subject: [PATCH v2] drm/amdkfd: Update return value of
> > config_dequeue_wait_counts
> >
> > .config_dequeue_wait_counts returns a nop case. Modify return parameter
> > to reflect that since the caller also needs to ignore this condition.
> >
> > v2: Removed redudant code.
> >     Tidy up code based on review comments
> >
> > Fixes: <98a5af8103f> ("drm/amdkfd: Add pm_config_dequeue_wait_counts AP=
I")
> >
> > Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> > ---
> >  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 14 ++++----
> >  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    | 36 +++++++++++--------
> >  2 files changed, 29 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > index 3f574d82b5fc..502b89639a9f 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> > @@ -436,19 +436,19 @@ int pm_config_dequeue_wait_counts(struct
> > packet_manager *pm,
> >
> >               retval =3D pm->pmf->config_dequeue_wait_counts(pm, buffer=
,
> >                                                            cmd, value);
> > -             if (!retval)
> > +             if (retval > 0) {
> >                       retval =3D kq_submit_packet(pm->priv_queue);
> > +
> > +                     /* If default value is modified, cache that in dq=
m->wait_times
> > */
> > +                     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> > +                             update_dqm_wait_times(pm->dqm);
> > +             }
> >               else
> >                       kq_rollback_packet(pm->priv_queue);
> >       }
> > -
> > -     /* If default value is modified, cache that value in dqm->wait_ti=
mes */
> > -     if (!retval && cmd =3D=3D KFD_DEQUEUE_WAIT_INIT)
> > -             update_dqm_wait_times(pm->dqm);
> > -
> >  out:
> >       mutex_unlock(&pm->lock);
> > -     return retval;
> > +     return retval < 0 ? retval : 0;
> >  }
> >
> >  int pm_send_unmap_queue(struct packet_manager *pm,
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > index d440df602393..3c6134d61b2b 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> > @@ -310,6 +310,13 @@ static inline void
> > pm_build_dequeue_wait_counts_packet_info(struct packet_manage
> >               reg_data);
> >  }
> >
> > +/* pm_config_dequeue_wait_counts_v9: Builds WRITE_DATA packet with
> > + *    register/value for configuring dequeue wait counts
> > + *
> > + * @return: -ve for failure, 0 for nop and +ve for success and buffer =
is
> > + *  filled in with packet
> > + *
> > + **/
> >  static int pm_config_dequeue_wait_counts_v9(struct packet_manager *pm,
> >               uint32_t *buffer,
> >               enum kfd_config_dequeue_wait_counts_cmd cmd,
> > @@ -321,24 +328,25 @@ static int pm_config_dequeue_wait_counts_v9(struc=
t
> > packet_manager *pm,
> >
> >       switch (cmd) {
> >       case KFD_DEQUEUE_WAIT_INIT: {
> > -             uint32_t sch_wave =3D 0, que_sleep =3D 0;
> > -             /* Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> > 0x40.
> > +             uint32_t sch_wave =3D 0, que_sleep =3D 1;
> > +
> > +             if (KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(9, 4, 1) ||
> > +                 KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0))
> > +                     return 0;
>
> From my last comment, I suggested to put this at the beginning of the non=
-v9
> pm_config_dequeue_wait_counts call that calls this function.
> Then you don't have to make the return value more complicated than it cur=
rently is.
>
> [HK]: Ah ok. I didn't really want to put asic specific code in there but =
in this case
> code it is fine as you mentioned we have already overloading these functi=
ons.

Right.  Which is why I also suggested that you could create a front loaded =
flag or mask if you didn't like this idea.

e.g. of a mask:
declare dqm->wait_times_override_mask in the kfd_device_queue_manager struc=
t.

Do some defines in a header somewhere:
#define KFD_DEQUEUE_WAIT_SCH_WAVE_OVERRIDE_FLAG 0x1
#define KFD_DEQUEUE_WAIT_QUE_SLEEP_OVERRIDE_FLAG 0x2

Then in initialize_cpsh:
if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1) &&
    KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) {
        dqm->wait_times_override_mask |=3D KFD_DEQUEUE_WAIT_QUE_SLEEP_OVERR=
IDE_FLAG
if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev->gmc.is_app_apu &&
    (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4, 3)))
        dqm->wait_times_override_mask |=3D KFD_DEQUEUE_WAIT_SCH_WAVE_OVERRI=
DE_FLAG

Then at the beginning of pm_config_dequeue_wait_counts:
if (cmd =3D=3D KFD_DEQUEUE_WAIT_INIT && !dqm->wait_times_override_mask)
   return 0;

And pm_config_dequeue_wait_counts_v9 gets simplified to
case KFD_DEQUEUE_WAIT_INIT:
   uint32_t que_sleep =3D dqm->wait_times_override_mask & KFD_DEQUEUE_WAIT_=
QUE_SLEEP_OVERRIDE_FLAG ? 1 : 0;
   uint32_t sch_wave =3D dqm->wait_times_override_mask & KFD_DEQUEUE_WAIT_S=
CH_OVERRIDE_FLAG ? 1 : 0;

   if (!(que_sleep || sch_wave))
        return -EINVAL;  // for safety

   <etc .. etc..>


Otherwise, splitting the IP check is a quick and dirty fix.

Jon

>
> Also KFD_GC_VERSION(pm->dqm->dev) > IP_VERSION(10, 0, 0) is incorrect and
> should be >=3D because want to also exclude anything with a major version=
 of 10.
> [HK]: good catch
>
> Jon
>
> > +
> > +             /* For all other gfx9 ASICs,
> > +              * Reduce CP_IQ_WAIT_TIME2.QUE_SLEEP to 0x1 from default
> > 0x40.
> >                * On a 1GHz machine this is roughly 1 microsecond, which=
 is
> >                * about how long it takes to load data out of memory dur=
ing
> >                * queue connect
> >                * QUE_SLEEP: Wait Count for Dequeue Retry.
> > +              *
> > +              * Set CWSR grace period to 1x1000 cycle for GFX9.4.3 APU
> >                */
> > -             if (KFD_GC_VERSION(pm->dqm->dev) >=3D IP_VERSION(9, 4, 1)=
 &&
> > -                 KFD_GC_VERSION(pm->dqm->dev) < IP_VERSION(10, 0, 0)) =
{
> > -                     que_sleep =3D 1;
> > -
> > -                     /* Set CWSR grace period to 1x1000 cycle for GFX9=
.4.3 APU
> > */
> > -                     if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->ade=
v-
> > >gmc.is_app_apu &&
> > -                     (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9=
, 4,
> > 3)))
> > -                             sch_wave =3D 1;
> > -             } else {
> > -                     return 0;
> > -             }
> > +             if (amdgpu_emu_mode =3D=3D 0 && pm->dqm->dev->adev-
> > >gmc.is_app_apu &&
> > +                 (KFD_GC_VERSION(pm->dqm->dev) =3D=3D IP_VERSION(9, 4,=
 3)))
> > +                     sch_wave =3D 1;
> > +
> >               pm_build_dequeue_wait_counts_packet_info(pm, sch_wave,
> > que_sleep,
> >                       &reg_offset, &reg_data);
> >
> > @@ -377,7 +385,7 @@ static int pm_config_dequeue_wait_counts_v9(struct
> > packet_manager *pm,
> >
> >       packet->data =3D reg_data;
> >
> > -     return 0;
> > +     return sizeof(struct pm4_mec_write_data_mmio);
> >  }
> >
> >  static int pm_unmap_queues_v9(struct packet_manager *pm, uint32_t *buf=
fer,
> > --
> > 2.34.1
>
>

