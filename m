Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473F7C61DB9
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 08:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB6110F2E2;
	Fri, 28 Aug 2026 08:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xP085hAU";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013061.outbound.protection.outlook.com
 [40.93.196.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E246B10F2E2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:42:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gzl++05bVPe6yUA9U9g3CXoHeWSjG06tSUfU/gghOXvAZyIJHNQZKY8XgNI0qNTCv75LajuN1qajRN38iXZ0mGjo+1zsbeEdATYf8j0/GeUwERKSp9550H0dDKEKKtG4iOX/ARUnIBtRf93Mx2MT8hI5Nikd8sGzb8WHqT3PA26ACTJvtzpA2HhglHpuZjkJ14KflRdZB2LgMiRojeRJBO3wYp2bXExSfLrnk2cs2WbDdt1So1rA1t83DHZHPQ6kzHVS87PjS+S8eswJIQu03kcISp7vD6TgbLKLLt1+e4m7vQ7F3E+yXw3Ds4kaQtYh+zMephcx0dFuH3UkL+UMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ZcBNxrg2CtEI8bCC9zKz9n6U2omwOvIRhQwGX6l7c=;
 b=sNTEEtVd92iDZkPGlUGz1+MFMvfhhQytXFYVrUDPKVOB6pCE0oiWT+2c7S6dESMJnIk+7ALqH6xqn/xmV3ZZP9aWyoC3yZGXOqyEdBtAr3H1YhoiVYPINQIaBVFkZOJfcLyf46RlPoKwRGJs8w42y2NhvfVZlQmR8B5XlIY84JV2vH3/xphz3XXJuhPIlTtq2+lgcI3qtmItZ11ScgK7no7g7i1+I41prkKrl1Dg4/PGkfp+szKN5e+FxomEneLDzhlJvBD84OBwWxNn4doHmwIPBFJmHDvff6JpjJihmfZ0ywXHk4bZVKO3v3jQB3S8B0/SultUB+CnoFwNXQQQmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ZcBNxrg2CtEI8bCC9zKz9n6U2omwOvIRhQwGX6l7c=;
 b=xP085hAUuOj+h7IAo1I8sCdORugCrQ1Xju8EEJoFa/YFTjoo6eU7EwsHyRISgUZ4UfXrUs6O+edLBrnBl1YUgbsG4Nr0DENvv7oErY4uWGza9fAsCrItOlMUylLJfTiHBM7KtgMJ1URxJL5pVzasbHM+eqmf8ybUY4eV1WAK+78=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 08:42:33 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 08:42:33 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Print caller in amdgpu_userq_state_changed
 tracepoint
Thread-Topic: [PATCH] drm/amdgpu: Print caller in amdgpu_userq_state_changed
 tracepoint
Thread-Index: AQHdNSKPiOzKeiL6+kyZL5HvWwjSULazJgyw
Date: Fri, 28 Aug 2026 08:42:32 +0000
Message-ID: <DS7PR12MB60057B707965A3081CFBBE3DFBAC2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260826061708.500576-1-Prike.Liang@amd.com>
In-Reply-To: <20260826061708.500576-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-28T08:35:19.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|SJ0PR12MB6782:EE_
x-ms-office365-filtering-correlation-id: a68287df-0383-41c2-c1b1-08df04e04d89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|3023799007|56012099006|5023799004|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: +NnpXFXa59DuN/1xlM1o0ZHa7RTDrOYq+1u9bEBND/P18DHEEgsGWyISm7j5YaCQxcCyU7Ek6mUiag3HskM9RzWuB2HJvhC9nYpI0aVKMO0PVcsmuBBX0/DFLw2T+qvFYOxUJdYpi31ec2KhcV97fgsQXy30wrorftiy959rAja+BPQiBcUjlB9U5lfQdtzwX1zCrjEHnnIukmymucoYZ4jbQlB/xP0+eChU8SRjB3vGBmP272vyygt7Pvs3s/JSfAxHhbPJaWq+YPyps0ZxkI3oAAUetqhQv4bNnPIOoEEO5YMOvx1eddKpQHKi/YtbaNLTmq+PccLpScMXie2NweMjxOVmccq3/IxcdzPEyhixWSb25rcXBDBAEZM9wYnDRzKcupKwAep76sbwkqfONWLeKyOq1DlF9C8BO7/ZK3Sq52zu5Nb+h1xdgxl6UZEKrIQJCxUyvk6MBG72mb6QX0yiY/Bu+JM81jITdfQYj0D3rbH0yGBxsIgX3QfqxqdPkZRF7jzxLGK0cS7BYyffZMu5pCq/h9oS85hEL8AWJ2+GvoG78Zc7YMn1tK7B9sumdksgLEH5/pXUXyObAym2SZrnA278W8gWBCCAV+pTrHkEQIfaxP3qR2NuGCzaOeJg/EQ+4zAJgQ7zhI7QoimVkyenKiaLICG7+oZ5TKVIK65b3OU7YIpjzwrrTT1f+Pxc3eFZV/yIKPXfZAq+hQHFlDZGEOudaUto7SZswKKat+g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(3023799007)(56012099006)(5023799004)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q82W1wRJNJqETtooJJQ0+Gp2hV4qUb+N8JR702bQMqhEnkNCDbmi1tY9/NeU?=
 =?us-ascii?Q?8mRgDbwGTkn5nINqTKHiRWZ8aqj8XhF+tBrQhXBMKBsXUTz8FToKtai5x8Ee?=
 =?us-ascii?Q?BnAZQxVpGFxenSRyIwxz9dxuWCpGdxDR0m38VzraLZtPvwPF/Iz5ZcUBdDsJ?=
 =?us-ascii?Q?WRGxhUU3yKSMHzfsalGbTRiY4ALeI7ldTQRq4pyO3SAG+NcPVKdnDVugbVsZ?=
 =?us-ascii?Q?qPMMqgy5UgpIJ1+zMN9d5ZnPGL5s7Op4ReqIMrDr9LS6ju1HrowJb8z+wytc?=
 =?us-ascii?Q?VEFvKASiU0X3KXLluQAnMiQHm4C12jlcZbIgAg33SpBeXQK0hGvF+5c++iKf?=
 =?us-ascii?Q?a68RKyz4cEdCZCr/pPHEE2stg6sNnp+vNl60O4s7JSl9KJhlSkW8HseILBgC?=
 =?us-ascii?Q?Qsuz2KtE/RHgmuPyXEfrTmsWQGQL35B3g+/o/fXR7brrCubcKawtcgZva3S6?=
 =?us-ascii?Q?nvUUAivD+h97YWsXDePL4bQgp/EL6GJ26sP3g+3zuS3XCWZrRbW+0/njrw5c?=
 =?us-ascii?Q?L1YDTGer4sXmnr6wlYtpoBQNH/2W6rXU7KtMnkIzzuRF6v+faQiQ0Rz9fPbv?=
 =?us-ascii?Q?Z7hoYoi1Rnw0BCba9fPbAQt5grsO4gVWQ0qAlTJWzYHR11KLDEKq+rHZsrZK?=
 =?us-ascii?Q?19cJNRtwZ7ErvbiOkPQeRIHCcTTXEN7xcRqHifJYnNnF2nHI3ECN3/E5Rdwo?=
 =?us-ascii?Q?/lJuK2yYphq2ewXE1rzEJmCW8+CWtZyT/rpOOEhQJecrEhgHug52B1HicPau?=
 =?us-ascii?Q?BSYNgzFjzxZkFJIsmlnQHvAWWyRKDKrMXCuoHoklVhsJKAD+3lshoV3Y7wN5?=
 =?us-ascii?Q?GotMY6HRS8ZHT5ZBgKcvnI9HX8HLQtWpKjQDSCf3Ag55+pbspYLbfwSAUbrf?=
 =?us-ascii?Q?0PZSb1HnETRs3NqxxfNZ9ogolHbc7ZwyddrDDEdimf6oo8rNWfU6EUkCRCPB?=
 =?us-ascii?Q?42fz/G2UmCDx8s1ZUKI7ZWbgp914MYCj1diMdC8C8MCQUKQZFOQHOTCJq568?=
 =?us-ascii?Q?T47hsjME01BA+IAkOCeO7vxKoN3zzV/bSNMheJB9d7uJ8jmx+DL/l5DENRIu?=
 =?us-ascii?Q?+4v7Z3RYcoPxbG+wb0Y4MNzuI2bPN4c7GqMsE22yciIawIqZKUkpz2kUBnxC?=
 =?us-ascii?Q?7WYERRsNHnfz6ubxvuEj+XvlJlLGlmHm89D+iXDCEwSfYopUbI7rLJqKl0Z3?=
 =?us-ascii?Q?U89cjPV3hF8a9V2Y+Si5DOb70iUPogWeuJgldSTsiVXi3X+sC0txNoNvFcte?=
 =?us-ascii?Q?B9G+zWs6Ej6dgtzQ6cafOg9roU8BERimi0Jo/7ZyPI+lrfYsbWwUa2+mWrAA?=
 =?us-ascii?Q?8Nx8hCJezkrT158g1Wnswiz5YTKx/tJQdfMrpvKTlm9qiDpj5o5FHOxP1Euj?=
 =?us-ascii?Q?/kI7vy+lQm97LmSHuOs+JHfZc3NrwuLfzvr6Rc6Un/b2QvD1gaV3ImXF0YRY?=
 =?us-ascii?Q?PNut5Em6PQkYdD8N+2tEnwYtqpXDLCmsfw4e8kZUWdj9MoI9QRaG/e4JNQtf?=
 =?us-ascii?Q?mF8e5xyaDpwnjVO+IsKaHC9iOH/TS1iR5kAO1lUb69vN+eTTqkT2NUwU+Ge5?=
 =?us-ascii?Q?2cEwWWPCR8D5A8vRZHCTg4fK6xyDG35I8VQOKR80Cc0SLkWYa8rvKW1p/aqP?=
 =?us-ascii?Q?fIQr4QKgCFMWoSu5IV52Sju0tu3BL6mxd4ar7km5wSPemKbOz+JlT8L51tz0?=
 =?us-ascii?Q?yVrxl0htnMTvRsAyTytZlli5BT62cLwsZVQJbDuxZ4Zyyq9F?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68287df-0383-41c2-c1b1-08df04e04d89
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 08:42:32.9804 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zFHzEVmIMQuY/hjQqUcHNzlKtRJEc9zSr1+ddUh2tE3vRYxhZhweyIbowSVE8tqV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782
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

Since the caller can be collected by stacktrace trigger and further parsed =
by tool lib, so drop this change.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, August 26, 2026 2:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: Print caller in amdgpu_userq_state_changed
> tracepoint
>
> Since `amdgpu_userq_state_changed()` is invoked across multiple state tra=
nsition
> paths in the userq lifecycle (e.g., creation, eviction, restore, and dest=
roy), logging the
> caller makes it significantly easier to trace the exact call sequence whe=
n debugging
> ftrace outputs.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> index 5324030a13f5..569e1e38704c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
> @@ -721,15 +721,18 @@ TRACE_EVENT(amdgpu_userq_state_changed,
>                            __field(u64, client_id)
>                            __field(u32, queue_type)
>                            __field(u32, to)
> +                          __field(void *, caller)
>                            ),
>           TP_fast_assign(
>                          __entry->doorbell_index =3D queue->doorbell_inde=
x;
>                          __entry->queue_type =3D queue->queue_type;
>                          __entry->client_id =3D queue->userq_mgr->file->c=
lient_id;
>                          __entry->to =3D new_state;
> +                        __entry->caller =3D (void *)_RET_IP_;
>                          ),
> -         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, to=3D%=
d",
> -                   __entry->client_id, __entry->queue_type, __entry-
> >doorbell_index, __entry->to)
> +         TP_printk("client_id=3D%llu, type=3D%u, doorbell=3D%llu, to=3D%=
d caller:%pS",
> +                   __entry->client_id, __entry->queue_type, __entry-
> >doorbell_index,
> +                   __entry->to, __entry->caller)
>  );
>
>  #undef AMDGPU_JOB_GET_TIMELINE_NAME
> --
> 2.34.1

