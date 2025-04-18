Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C68C369AB
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Apr 2025 13:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A5D010EBA6;
	Fri, 18 Apr 2025 13:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bjLAo0R/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BC310E041
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Apr 2025 13:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jl5PMuuY6hPgKXWOigJCe7ksKuci/tLBxkrVYr/5E1gt00K1s7idn/vLCaK6h4HmWlOjiU839qapqJ7QU9uNkT5tasPiNvjSfpJsc+oJkMdlJ77U4/VDttm4zatvXsYaUtaqEcx0V/b7buuBNDJXAN8TyrSTKEJ8iIp1i+gKh2yt84K/oVyd+OlhxixBo6Vy1Ka6UP0RlyYJy02OYv8VueaBJpCNEmurWEgcMtGGbNRq9cFM6bUyyxVR2doZ+C94ieXVmMQaYH68es5KKoMH7DoQIt8NXDHs4EQ3CYVcys/cs8CxIDuavKa1GiAXnTMJeEk3iO1slQrAz3YMFkzs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfgXSCZYmvr6G7L61KZjimBKC2mtZQiqZ1JwG5F+Wps=;
 b=tVr6GJsW6a0ape6jkuI3oWLUX38j2jj4UOh9MXRCeK/n1OCk26Dw0Bwax2F31r21RMk/7yKVpq4LMml+jDAkd1Mg2qJY0gyapz8fFWP9TfJnjpptbJ+1JL9KF1zkZQVKUXmma4mzhcxDUhFBop94Q+FHWMDVgBSsQMCQNiqRGIsq4njR6VdmkxemNH8EGvYrd1Q8CBKW6i3kg7HFzigHjC/YSK1VY814pCOoX2a8OzR7bGZJiFcwK1lGuFhnpjFBWSVjm19VJAczCxQHRSO9sUa0dwmkUmk5kZ7qm/HCC5PDl1SCXqHAMnsPPq2kcHMCoWToZn+hi87TUxNIVh2fEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfgXSCZYmvr6G7L61KZjimBKC2mtZQiqZ1JwG5F+Wps=;
 b=bjLAo0R/a6Fyh2E6wvan90tlDwAUae2PYAn2zTm9zzl8Wxiy7tge8fI6SdCoTrjwUA3mWGrMU9M4ylaGDlZK8JJ0V/7sA0y56eFVNl/LGZiozcTPqg2bO30efmP6/cHY/VQb9Ojul9f2AYBop7iyEin9nmZVebaJyN1vw/tbdZk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 BL4PR12MB9483.namprd12.prod.outlook.com (2603:10b6:208:590::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 13:34:41 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8655.024; Fri, 18 Apr 2025
 13:34:40 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/7] drm/amdgpu: switch from queue_active to queue state
Thread-Topic: [PATCH 3/7] drm/amdgpu: switch from queue_active to queue state
Thread-Index: AQHbrx3hYY9O+8p9oUa8zZxkpzu7M7Opa5pw
Date: Fri, 18 Apr 2025 13:34:40 +0000
Message-ID: <DS7PR12MB60055C9E6523617B5C87BFBBFBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250416222046.1142257-1-alexander.deucher@amd.com>
 <20250416222046.1142257-3-alexander.deucher@amd.com>
In-Reply-To: <20250416222046.1142257-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=42a69b08-29fc-4581-823b-71ec55743cd4;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-18T13:22:31Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|BL4PR12MB9483:EE_
x-ms-office365-filtering-correlation-id: 24ad881c-8f85-4b52-8790-08dd7e7dc5b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?KsIBL1CNqwqf5KMum13mbOpN38p6d2IntUwF/x09iEUA1JeDGcecoz6OSHkv?=
 =?us-ascii?Q?76CPbcGAKGSftqluMFWikTlGnpPZKhZutJnhw4lZwZpaKwMnXLlq+qXTVn2+?=
 =?us-ascii?Q?dyuDn+/ttcq5we+kGL9yL0RQgbeuF0v3P8t+4KvgpKpmAI+GQDDDN4AvDWx5?=
 =?us-ascii?Q?v89kuEGp95Z/TykJXx4xLotU2FQcqo8sUlObsEUXLbmmZgjMEEkfj44uedQ/?=
 =?us-ascii?Q?xc4eS3urOcbVpnY2YilINXXhY1shX0d5JVueWPlLWkFkEQJ54PBrFWZI58BH?=
 =?us-ascii?Q?j3cc7ChBlJGQvotYHZH+a/RuozHQvAGf5R02Fw4vJ8BWBY2ZfzriPfkfwQ4M?=
 =?us-ascii?Q?C9HhCg0jeOlsSZ/leBYrQif53vFdPIWTnodSUw82Sv33CTHlypfmNFQFL8Ce?=
 =?us-ascii?Q?EM+UeiOhPsFiOhicxw18jUSroGJahkCdt6aHNt+t0lNWRB4ulnDRDuFn2fEz?=
 =?us-ascii?Q?6rp56w0nLZ7PqHYkDz9F5WSoErolpKy8attqTZMoRe7HtN450O6Q8F5spyBq?=
 =?us-ascii?Q?Ily09tYUegHRee/rBzhkcQ2PWyLowrRMPJo9eVi2W8ep1PI2arGVtpv3nzWW?=
 =?us-ascii?Q?EeHUzSQK0pNfdk/ZY7WgnJLnuCoXfht8CL98XXlLgOF2zxtq+Lm3YbXy7XLE?=
 =?us-ascii?Q?HHfKBUaMlUqhTeMDAoB+98Ok8zOlq1uiWDeKKX/VMYqqMYhmJ4PxG5YhzqkL?=
 =?us-ascii?Q?rUKNvQh95IBWjlMknHJKVnZyNI1jHuzk2bV/MWZ51jTBHyoDuiHK5E+vQQU3?=
 =?us-ascii?Q?JzDWb7LTdoydZLd7fy5dNd2QHEN6fu2cB3GwHmPB8Ua49s/i4iPJCM6sYdVs?=
 =?us-ascii?Q?yxvd7bK0IV2flPNH2c/KqqC6KIRuGEU0CZHLyNkBoJRu7eVwtJQ+zY8J5by4?=
 =?us-ascii?Q?XWSr3EZIxRR0IsDoEdid8sMqdvV7vtKSzFJ5yAHZjDLWlQ/Vr9yuTmESDsPa?=
 =?us-ascii?Q?UYjpM5UnaGRkqCQVSUd+xb1IMRvCBAhgvzG9q1c1epNaMGUFtXSUOHS2fDo5?=
 =?us-ascii?Q?r8h4BFU9+okaReG/zK61Lnza7OK5aK3/BTVO9WKKpAhW48vdrtF2Ory90JXd?=
 =?us-ascii?Q?9BnouqZAEx3KRBs5AGWTHp1KNsTZMQxeaxe6xmws+e0rHHRR8xSQGa5uZyPu?=
 =?us-ascii?Q?fcdzc2t+MDL938WEzD+s/GXPay/9ltNCJ7VPphA5twSxEQNYe2t21AjWvL8u?=
 =?us-ascii?Q?4vx1hSLvSZ8Sd+MylhFM3W+eDycsNDwmGgmRzMJPQ6aO0S0LN2Q4WDDcs+9Z?=
 =?us-ascii?Q?QUnUJdQMkfvyWSQTxCxpV6cTXHVFigcWSQBlGFBFWBzbKzcB9D6pZQU5uc7T?=
 =?us-ascii?Q?mMuFqFXeBgeTfRhdBBNQz1a8AbTAQO8YJdIQn9qAqAZbT1GXdbKghRay/qKC?=
 =?us-ascii?Q?08gRSqK7N00PwXE3Icy8ldsqmJxJ4mn6mnxVpjJ8Pdhm9oC6QNfyS4xI+uMV?=
 =?us-ascii?Q?tDhRbNm1VC08Nckq7yaLNKgaWtJhxF1ZdROTD4eWueyv/YRJwM+MR1Nn6Oe+?=
 =?us-ascii?Q?2uqg3gioECs26GI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lZv0qLgc2nGlw6H6qTtP4LH79d7PQVwrNR2YY2ymsIwEPcorzfiSmdhAbB9T?=
 =?us-ascii?Q?A5szMzvPLJRwHN8qlKi6g6GrkNT9l1jvYAEp5tXut3WNsIW9gM9bNN2+r3yD?=
 =?us-ascii?Q?rmpnSbNaSHcxFjIJ2twnzT80mQlg2nTTY1JC4da2asAisxduMCIydRPKurc7?=
 =?us-ascii?Q?EoHOhkFHeIoTI5RqyIH7ftgGy0MaUhL7oSrlJvFmC4G+C37TBwIum1pIu1E5?=
 =?us-ascii?Q?u/4sBdRSlM+GvC70Hm/Xnm3x0t+N0tpxLU6UNGUCBWAYJsEfIXSXbIEGzy01?=
 =?us-ascii?Q?stgkK5zRZD4CWiQPJ36TUbJmkge7W2ppb4QRzNXn435ragdOMNPUPDkrT0Vz?=
 =?us-ascii?Q?YPuxaTlaBFCIfysjElh+K+c4l9xbgHkCfesoFA0JceYPWnoiZn2c930mdEq4?=
 =?us-ascii?Q?co6zEY4E1bXET/9B5PTwVWOJ3VBNCFBlVBk06W/Fo8+GZA8foxG6bwBxxC9G?=
 =?us-ascii?Q?VCHjm40FWkfkuKKiItx8kQdWxzl3aK/O/2w6KP0vT7QTQPRebNMQcAFRLj5e?=
 =?us-ascii?Q?YiFMaAjkXJGbglZJEwfVk4pCiM8jWhsk5dzq/jT0bkeAjzuXTOjZqmgb/NT4?=
 =?us-ascii?Q?6RB2hvqsy2oQhwyhWqJQGbCvILeKj8nhQopAsygenhJ6NYVs2wixW6b6D6xE?=
 =?us-ascii?Q?dUu3UpFt6BgJ9HgTFrHVwTtWqPshbG23o6+3wH0PwEfB/dE7g8y9oUwOQzJs?=
 =?us-ascii?Q?CWeVtDYo8TKhSyt7hbBqW5xkltIq8zqwNFiEkOjEikJTLGqXU7mZ7gkC22BQ?=
 =?us-ascii?Q?+yv9uqJbRtKg/Y8QoEKZbnqBpS78sgNRdEUoRivh1Ab5at0wfa0lBrB5HE2b?=
 =?us-ascii?Q?mghNEo4kU4O+uf2MNECAgWBk1i3NKxKDt5pRrdwzH0yBukYFJWw2018C1Jwu?=
 =?us-ascii?Q?UTPHhNsr/iZhIWhSc+Vu6G7HGM0+ec+GMmAKzmLxmgr1oW9jdhb1HW3hQSKK?=
 =?us-ascii?Q?w07aTl48VfweIp/oXkrJmW6P6vx8mO4E4ahx8MSTTU87sD96LRKrgEmcvYXy?=
 =?us-ascii?Q?X0PqJPgJNcRtQztcVTQ4brD6+GwMnpwPvLZFZ4Vb9B71QrnyVmpCquzYv0yl?=
 =?us-ascii?Q?H0r/NHjHRq+S4q1qhEl2hVH0YuvNyZObI0FtB3aTtIa4OMAKKY0dCDhYT4tp?=
 =?us-ascii?Q?2EvD9aKRzmupHleEg9jk7L6JjqtPEu8cbDx12KwbtBniH2KuAzjWgGtMNTSW?=
 =?us-ascii?Q?VLLelAZuwid3AAlJE1wBl/qAxvkMd1b5jdmEH5aqAQBpCSTVC4SZSOGxAgQJ?=
 =?us-ascii?Q?9Kdau858trzrZCpT1fYLc4Ip94Dl8rTuHGSEf9gxxZDacDh5GVNma9vAcaSG?=
 =?us-ascii?Q?e0pM10JD+A2h0n5R8/ydesrECt+QmlY9do3f0XIyAl73wa0BEBdW8txxnVTN?=
 =?us-ascii?Q?HAZ4qt5Hbj72a3IZHnaD4Z8GsD1HopcFxw5eBD/9yPxBk7xyFST+1JwbLVrG?=
 =?us-ascii?Q?z0wpO6/hmaqGtUYSqVnq9ygbQ6yfIvRqs8gBmChAaB2A1iQC+2e4o/Pjz4ps?=
 =?us-ascii?Q?AzTJrFamMPZm4ex3TYxOlHNxJw08H2IWeVJVDKPTUjQhrn7abNokwMfC1Xa/?=
 =?us-ascii?Q?DJtfUjT7EYA8UxwlKn4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24ad881c-8f85-4b52-8790-08dd7e7dc5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 13:34:40.9233 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40pn/nZUGsXkqT3Re0ebJ9lB0cxCovJfNwsqznf7rHmREQGzTZ5mzwYelWvkz1MZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9483
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 17, 2025 6:21 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/7] drm/amdgpu: switch from queue_active to queue state
>
> Track the state of the queue rather than simple active vs not.  This is n=
eeded for
> other states (hung, preempted, etc.).
> While we are at it, move the state tracking into the user queue front end=
 code.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 101 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h |   9 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c    |   8 --
>  3 files changed, 77 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> index 04583f9d134f1..8e703dc9dfbbc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -44,6 +44,45 @@ u32 amdgpu_userqueue_get_supported_ip_mask(struct
> amdgpu_device *adev)
>       return userq_ip_mask;
>  }
>
> +static int
> +amdgpu_userqueue_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                           struct amdgpu_usermode_queue *queue) {
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     const struct amdgpu_userq_funcs *userq_funcs =3D
> +             adev->userq_funcs[queue->queue_type];
> +     int r =3D 0;
> +
> +     if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +             r =3D userq_funcs->unmap(uq_mgr, queue);
> +             if (r)
> +                     queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +             else
> +                     queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> +     }
> +     return r;
> +}
> +
> +static int
> +amdgpu_userqueue_map_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                         struct amdgpu_usermode_queue *queue) {
> +     struct amdgpu_device *adev =3D uq_mgr->adev;
> +     const struct amdgpu_userq_funcs *userq_funcs =3D
> +             adev->userq_funcs[queue->queue_type];
> +     int r =3D 0;
> +
> +     if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
> +             r =3D userq_funcs->map(uq_mgr, queue);
> +             if (r) {
> +                     queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +             } else {
> +                     queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> +             }
> +     }
> +     return r;
> +}
> +
>  static void
>  amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
>                        struct amdgpu_usermode_queue *queue, @@ -79,7 +118=
,7
> @@ amdgpu_userqueue_active(struct amdgpu_userq_mgr *uq_mgr)
>       mutex_lock(&uq_mgr->userq_mutex);
>       /* Resume all the queues for this process */
>       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
> -             ret +=3D queue->queue_active;
> +             ret +=3D queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED;
>
>       mutex_unlock(&uq_mgr->userq_mutex);
>       return ret;
> @@ -254,9 +293,8 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int
> queue_id)
>       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
>       struct amdgpu_device *adev =3D uq_mgr->adev;
> -     const struct amdgpu_userq_funcs *uq_funcs;
>       struct amdgpu_usermode_queue *queue;
> -     int r;
> +     int r =3D 0;
>
>       cancel_delayed_work(&uq_mgr->resume_work);
>       mutex_lock(&uq_mgr->userq_mutex);
> @@ -267,8 +305,7 @@ amdgpu_userqueue_destroy(struct drm_file *filp, int
> queue_id)
>               mutex_unlock(&uq_mgr->userq_mutex);
>               return -EINVAL;
>       }
> -     uq_funcs =3D adev->userq_funcs[queue->queue_type];
> -     r =3D uq_funcs->unmap(uq_mgr, queue);
> +     r =3D amdgpu_userqueue_unmap_helper(uq_mgr, queue);
>       amdgpu_bo_unpin(queue->db_obj.obj);
>       amdgpu_bo_unref(&queue->db_obj.obj);
>       amdgpu_userqueue_cleanup(uq_mgr, queue, queue_id); @@ -414,7
> +451,7 @@ amdgpu_userqueue_create(struct drm_file *filp, union
> drm_amdgpu_userq *args)
>       else
>               skip_map_queue =3D false;
>       if (!skip_map_queue) {
> -             r =3D uq_funcs->map(uq_mgr, queue);
> +             r =3D amdgpu_userqueue_map_helper(uq_mgr, queue);
>               if (r) {
>                       mutex_unlock(&adev->userq_mutex);
>                       DRM_ERROR("Failed to map Queue\n");
> @@ -489,19 +526,19 @@ static int
>  amdgpu_userqueue_resume_all(struct amdgpu_userq_mgr *uq_mgr)  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
> -     const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       int queue_id;
> -     int ret =3D 0;
> +     int ret =3D 0, r;
>
>       /* Resume all the queues for this process */
>       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -             userq_funcs =3D adev->userq_funcs[queue->queue_type];
> -             ret |=3D userq_funcs->map(uq_mgr, queue);
> +             r =3D amdgpu_userqueue_map_helper(uq_mgr, queue);
> +             if (r)
> +                     ret =3D r;
Can the error return code simplify as one variable ret through |=3D with th=
e map/unmap return value?
Anyway, this patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>

Thanks,
Prike
>       }
>
>       if (ret)
> -             DRM_ERROR("Failed to map all the queues\n");
> +             dev_err(adev->dev, "Failed to map all the queues\n");
>       return ret;
>  }
>
> @@ -647,19 +684,19 @@ static int
>  amdgpu_userqueue_suspend_all(struct amdgpu_userq_mgr *uq_mgr)  {
>       struct amdgpu_device *adev =3D uq_mgr->adev;
> -     const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       int queue_id;
> -     int ret =3D 0;
> +     int ret =3D 0, r;
>
>       /* Try to unmap all the queues in this process ctx */
>       idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -             userq_funcs =3D adev->userq_funcs[queue->queue_type];
> -             ret +=3D userq_funcs->unmap(uq_mgr, queue);
> +             r =3D amdgpu_userqueue_unmap_helper(uq_mgr, queue);
> +             if (r)
> +                     ret =3D r;
>       }
>
>       if (ret)
> -             DRM_ERROR("Couldn't unmap all the queues\n");
> +             dev_err(adev->dev, "Couldn't unmap all the queues\n");
>       return ret;
>  }
>
> @@ -759,11 +796,10 @@ void amdgpu_userq_mgr_fini(struct
> amdgpu_userq_mgr *userq_mgr)  int amdgpu_userq_suspend(struct
> amdgpu_device *adev)  {
>       u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> -     const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> -     int ret =3D 0;
> +     int ret =3D 0, r;
>
>       if (!ip_mask)
>               return 0;
> @@ -772,8 +808,9 @@ int amdgpu_userq_suspend(struct amdgpu_device
> *adev)
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               cancel_delayed_work_sync(&uqm->resume_work);
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                     userq_funcs =3D adev->userq_funcs[queue->queue_type=
];
> -                     ret |=3D userq_funcs->unmap(uqm, queue);
> +                     r =3D amdgpu_userqueue_unmap_helper(uqm, queue);
> +                     if (r)
> +                             ret =3D r;
>               }
>       }
>       mutex_unlock(&adev->userq_mutex);
> @@ -783,11 +820,10 @@ int amdgpu_userq_suspend(struct amdgpu_device
> *adev)  int amdgpu_userq_resume(struct amdgpu_device *adev)  {
>       u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> -     const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> -     int ret =3D 0;
> +     int ret =3D 0, r;
>
>       if (!ip_mask)
>               return 0;
> @@ -795,8 +831,9 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
>       mutex_lock(&adev->userq_mutex);
>       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> -                     userq_funcs =3D adev->userq_funcs[queue->queue_type=
];
> -                     ret |=3D userq_funcs->map(uqm, queue);
> +                     r =3D amdgpu_userqueue_map_helper(uqm, queue);
> +                     if (r)
> +                             ret =3D r;
>               }
>       }
>       mutex_unlock(&adev->userq_mutex);
> @@ -807,11 +844,10 @@ int
> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>                                                 u32 idx)
>  {
>       u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> -     const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> -     int ret =3D 0;
> +     int ret =3D 0, r;
>
>       /* only need to stop gfx/compute */
>       if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 <<
> AMDGPU_HW_IP_COMPUTE)))) @@ -827,8 +863,9 @@ int
> amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
))
> &&
>                           (queue->xcp_id =3D=3D idx)) {
> -                             userq_funcs =3D adev->userq_funcs[queue-
> >queue_type];
> -                             ret |=3D userq_funcs->unmap(uqm, queue);
> +                             r =3D amdgpu_userqueue_unmap_helper(uqm, qu=
eue);
> +                             if (r)
> +                                     ret =3D r;
>                       }
>               }
>       }
> @@ -840,11 +877,10 @@ int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev=
,
>                                                  u32 idx)
>  {
>       u32 ip_mask =3D amdgpu_userqueue_get_supported_ip_mask(adev);
> -     const struct amdgpu_userq_funcs *userq_funcs;
>       struct amdgpu_usermode_queue *queue;
>       struct amdgpu_userq_mgr *uqm, *tmp;
>       int queue_id;
> -     int ret =3D 0;
> +     int ret =3D 0, r;
>
>       /* only need to stop gfx/compute */
>       if (!(ip_mask & ((1 << AMDGPU_HW_IP_GFX) | (1 <<
> AMDGPU_HW_IP_COMPUTE)))) @@ -859,8 +895,9 @@ int
> amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev=
,
>                       if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>                            (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE=
))
> &&
>                           (queue->xcp_id =3D=3D idx)) {
> -                             userq_funcs =3D adev->userq_funcs[queue-
> >queue_type];
> -                             ret |=3D userq_funcs->map(uqm, queue);
> +                             r =3D amdgpu_userqueue_map_helper(uqm, queu=
e);
> +                             if (r)
> +                                     ret =3D r;
>                       }
>               }
>       }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> index b49f147eb69cb..8f392a0947a29 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.h
> @@ -32,6 +32,13 @@
>  #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mg=
r)
> #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr,
> name)
>
> +enum amdgpu_userqueue_state {
> +     AMDGPU_USERQ_STATE_UNMAPPED =3D 0,
> +     AMDGPU_USERQ_STATE_MAPPED,
> +     AMDGPU_USERQ_STATE_PREEMPTED,
> +     AMDGPU_USERQ_STATE_HUNG,
> +};
> +
>  struct amdgpu_mqd_prop;
>
>  struct amdgpu_userq_obj {
> @@ -42,7 +49,7 @@ struct amdgpu_userq_obj {
>
>  struct amdgpu_usermode_queue {
>       int                     queue_type;
> -     uint8_t                 queue_active;
> +     enum amdgpu_userqueue_state state;
>       uint64_t                doorbell_handle;
>       uint64_t                doorbell_index;
>       uint64_t                flags;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index b3157df8ae107..4c01c3a030956 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -120,9 +120,6 @@ static int mes_userq_map(struct amdgpu_userq_mgr
> *uq_mgr,
>       struct mes_add_queue_input queue_input;
>       int r;
>
> -     if (queue->queue_active)
> -             return 0;
> -
>       memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
>
>       queue_input.process_va_start =3D 0;
> @@ -155,7 +152,6 @@ static int mes_userq_map(struct amdgpu_userq_mgr
> *uq_mgr,
>               return r;
>       }
>
> -     queue->queue_active =3D true;
>       DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n",
> userq_props->doorbell_index);
>       return 0;
>  }
> @@ -168,9 +164,6 @@ static int mes_userq_unmap(struct amdgpu_userq_mgr
> *uq_mgr,
>       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
>       int r;
>
> -     if (!queue->queue_active)
> -             return 0;
> -
>       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_input));
>       queue_input.doorbell_offset =3D queue->doorbell_index;
>       queue_input.gang_context_addr =3D ctx->gpu_addr +
> AMDGPU_USERQ_PROC_CTX_SZ; @@ -180,7 +173,6 @@ static int
> mes_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
>       amdgpu_mes_unlock(&adev->mes);
>       if (r)
>               DRM_ERROR("Failed to unmap queue in HW, err (%d)\n", r);
> -     queue->queue_active =3D false;
>       return r;
>  }
>
> --
> 2.49.0

