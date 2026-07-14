Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A75C43458
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 01:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 208B110EB97;
	Tue, 14 Jul 2026 01:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5jlV3IjR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012016.outbound.protection.outlook.com
 [40.107.200.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10C410E695
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 01:38:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JW6bSETKYrMaT5AIgkHqHeq/eyIPkAWYZp1t9mdHZPW4RGQEvUAO+9nyCid5ZgUoD1rfWd2aStZZyZ6cKjkfYWLSE83+AuoZddfcM6eN/fkmHE8sHZ3Y1GwR5dqyJa6CxXVevJ4QXOtp+Zx4cznh8ETJtkbXPJku/o0U/BMwSWI6BDcv0Pn8FpmELn/m7a7h3ZTR07pqg2TghgMvJq/POnau0A0MeMHPQmt3X4pmfhx0yHGS7cu+KOJmnMcrv67yk8KQF4xDBnEt2IFnOlOtDMgzSftUeWwCL2qoNLnexzrKrqWkGCGv0Z63Rq+yl3xl6p3H8thDI0Xj8QhF3SxlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMN7ixpeutcBogO9mQ+kV0NVrH2BamHx7gkq9PNoSes=;
 b=vDuxMoghtXoMtDkXtDLpczKd1UyAdG4keKDke81yJ8Ub9aFRaVT9v4OaIAsHU7G3EsNEk3Ch5uP8eF7NXkaz0/eT+cvH0/eNm0s2b31/2dMMEepWYBvN/XxU3dSQi/op2yKm9fBBSHjZ53QxMgt9+wOrMUQlDg1nOxL1GkMlh+3RC/DA5GKagqfk0EbLeosOpFu5/J8fhvBeA1XXv3rVHR7UhmG1hE4r04ym2g6wCH2SWBc0Shd5b+k+SEu00ohLQFNQzopLcgrWFjWQHMMJMfJXetc/KjCjjCklZPkVAQZt5mJKzJbqobxVUcltDWPpQU7ra2Zt16HDVLvdqO/O1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMN7ixpeutcBogO9mQ+kV0NVrH2BamHx7gkq9PNoSes=;
 b=5jlV3IjRQXHgb6tfoNUtC0xEOibvBBIcxXAk4TfpEN5D06BSgHxyPC2GxXP3GSqVWMiFyNHC7O2Szpdcxh+cCwTWvUa+Q1Z4rozQtme62+SMY9f1TfwaKk6Fe0ntY9EFMzo6pcy6yZCqbqxr8BxNWzd9PpzClI4UXDBieW14q0Q=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Tue, 14 Jul
 2026 01:38:50 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0202.018; Tue, 14 Jul 2026
 01:38:48 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "SHANMUGAM, SRINIVASAN"
 <SRINIVASAN.SHANMUGAM@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Subject: RE: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Topic: [PATCH] drm/amdgpu/userq: properly account for resets
Thread-Index: AQHdEweq90Jme/L2M0qaoc/Rb+QkiLZsPLJA
Date: Tue, 14 Jul 2026 01:38:48 +0000
Message-ID: <DM4PR12MB51522EF711068BCB2B72C7DEE3F92@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260713203850.650426-1-alexander.deucher@amd.com>
In-Reply-To: <20260713203850.650426-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-14T01:37:48.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA1PR12MB8358:EE_
x-ms-office365-filtering-correlation-id: 9360c22e-5380-431a-ad64-08dee148a6b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|22082099003|38070700021|18002099003|11063799006|56012099006;
x-microsoft-antispam-message-info: 5Zh461yFFxrboGh2qH2493GcYEeWHDn5xGHXTaJMbWwUnU26RHHkEqEv1Ee4CC2rOpH5xrgYL/iLDojjWTYTyYF+dbOaARBZppAmIT+aWdFAAlfeb34v6Z1UjUkPLE1lWg5gzrBJEx2ICoKs8Fgpm1RKXoObwz+06IoGEJUi4ReNYcnCIjMo1LAiknZXYfQPD1eU0xfMAmAt2INDAcgWfZ0vjb9/NhqaHYMR/41E2boOz+ZqZElcx+04R9EqzljP5SKEClSydYOR0suxcra7rDDsQsepfwkIx8nxTuomjfEsK2JKiPtrGqR3zPsEWj15C/veZJbJmtJbYOWFf9i2tHkifeFyzOzCLQi5R36IbMYFT91teBriE6BDgtNIfbRbTlQw1jVuRpomxwud4TGGybkpNFaNfPLK0QJf8zEQ03H+jlNCJcByqjCU27fNTDlsBOnEhCpSipenHdkrOW6WokvIYNxcSGOlLcmo3ujY/45GiA9Y4VSHn1xyUZ5md362wFHDNNvNY0MMgych0BgEeumr+t2yl2MVQgJ+Zei0TbxPcSBRCObPMyJdsEtqDYkxKY29THcR82MTqSCgCIwzOUM5furX/Rb/ubzcsq0KoCZfQUyEtGf9YNL1KGwkHXHy6A8TXP9myflbO3IWYRCubB7Xmw3008UX7mTIS7TpatA6woBpp4TGlwAbR/23cfcUA6ipmnQ7PAQTcaQ8HabJvR9svT/GjA1FnUkeGJ+J3fU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(38070700021)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Duenbb4XRMQ7kECzXBlL8s0R1wRdK0AiW/exyDxsNSOy0zWS64CqdyCBv17w?=
 =?us-ascii?Q?hZFGoap3sG9yySQX01p51GJ+STNYTIZpCXNwwJvh9gQYwbae+6JRApT8/Jro?=
 =?us-ascii?Q?/8Nnw/mPx13dtT9B2Esh/IGhQGGBk8YGPE5W2k5nR3Ed5TgotE88uOZHg9aB?=
 =?us-ascii?Q?dj6SL1lx2FyJZvyeuU6FYxJPMdEcXdaMjAvIYA0TKhV7q+CWVOJQer65ZuLJ?=
 =?us-ascii?Q?ubd2cZt011tTPm7s/FFmBAaTohOznnZMbcKje8NzUtJLid1+IuIG5PbzwDFf?=
 =?us-ascii?Q?m5pW9f2E60PsVTJeDxBDlfjw55FxS58deioqUO5UhZs3OZQ4OQ5FHOMdSBxX?=
 =?us-ascii?Q?ycDeoK8dC8jfh51B3qIhBd/FFmQQYTbVS3oqKlFvUkRb3ASBAlXTULbgD9S+?=
 =?us-ascii?Q?7Cgwu0vIbp5AAWRTCeN0i4QhsTbAkcJ9DqIZ+L75z5Hu/5Vcv5k+kRtgoSJ2?=
 =?us-ascii?Q?1yYEsUynjwf8L5FKzCCT8lAe6ZVbKCEngBLUQDbh892ESTVKscmYpgLECUlf?=
 =?us-ascii?Q?dTtXyY/5+JN7U1tDGrdsAyGUa3zLgP2YS5BxOty1xxHgzw+9/fTqcLHOQXLY?=
 =?us-ascii?Q?2qSB+z8JRXB66wyfG5vM2jezfzdcXTI3wlmiRiFgHAjJ1JjhmG9F/aTh5m0S?=
 =?us-ascii?Q?U3C5NdoVs14/MY/WXxKdmwq8CJbrNt6Ksk/28SL9UhLRkOy7ELONP/OjKd8A?=
 =?us-ascii?Q?bv3YlBvqFmDjpr52fxs3kge3AOaqpDGMq3ef2vgbMUavaoaGA+iOii/t6/ty?=
 =?us-ascii?Q?oooCawsUrPwjJ0pqh5Afr0D2ZCA1P6PL+zBCuwZz57I7iGk2F1oKJYU8mwn4?=
 =?us-ascii?Q?MGrVVRulNvGFICB4W6qiddnV9pK07EbLTUCNsdb3LEnBbq5sTp7fMyl/bapI?=
 =?us-ascii?Q?hGeAG0AwGkNGhZBRJB2ZNMotRJVwf1tpb9jb6dbe7G1q2+PMS3AnVOQ49ywm?=
 =?us-ascii?Q?es545weHS+VYIAvsTGOFMH0ILhJK834XOWCMdugqwuzkcQ8lx9OCOsqMS3vV?=
 =?us-ascii?Q?vd1oL3Wgh/bmIY4X/dRTdqmMySwXJbBRiTtlngr6TkDu0+VVQhJtss666CmH?=
 =?us-ascii?Q?a2sScw5MKG90Km69dzfsCLiUDK7ERjc/VJo7ZX3bSJ1ydSEoYuYomuHf14gl?=
 =?us-ascii?Q?dZMc8vHFPR57ywQtT5CFsSieIXwcW1tqxN5Q1jtMzno9aO9OEVdmkLwcaaNJ?=
 =?us-ascii?Q?iznj8GQtexHrEv0eIO8eEJwQRqWIDXI3xw/VQ9wsLZv2u9aL5qyhvOsfWjHX?=
 =?us-ascii?Q?HK6U9lj/BHzCz9O4FzqxmezP2flKmHuWMYV9Bg/DH3o+x+a3ulo5TMEVmIG/?=
 =?us-ascii?Q?Ii+LWwMMJklRmSkkeDljjUBHK5UjE+SSlKmODmQMgVSauRzozpwcgRtdF625?=
 =?us-ascii?Q?Voq7748rodpDIATqkw+YAnJNZMQHJdBgls7tVO1XnACFzEQUB9EwDWQ3/02/?=
 =?us-ascii?Q?LrC9WpiK8KtG+Iv3cQKLswcysjzz7H/C09gpX893PugpZMeWMXrZpECufv/z?=
 =?us-ascii?Q?VOJuL0A1VUW8yL1s3CQpSlxqmAeSvPBx72jz3QBBjhWf0MKzs8XvpIzi9QUT?=
 =?us-ascii?Q?XV4545lkpFLHUguImIeLF2fwY3ruCMqsHX7sPBlnpfOWwZ6CtvOSIje/tc8X?=
 =?us-ascii?Q?7Cv+VhvrY0nS/fIDa6hNGLWZ0rmVBE0hZ3Eaf2SBzUQqGN22VaNoOd7K1AI0?=
 =?us-ascii?Q?+MT6nmVtr+OztfsmysazK21fFIBgAaG2ydS+bEUO3BbFrtsd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9360c22e-5380-431a-ad64-08dee148a6b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2026 01:38:48.3943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQL7+yfWh5rJpbx8HD0BWtrEc+lvFuNVjXC/tiEuOn4EzIZ5C0Hh4SHFmsX0fRsudAijz7snqG1//76KcAQOzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358
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

Reviewed-by: Jesse Zhang <Jesse.Zhang@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, July 14, 2026 4:39 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; SHANMUGAM,
> SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: [PATCH] drm/amdgpu/userq: properly account for resets
>
> We need to increment the reset counter, force fence completion, and set t=
he
> wedged event when a user queue is reset.
>
> mes_userq_reset_queue() handles this for collateral damage, but the calle=
r needs
> to handle this directly for the original guilty queue.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Cc: Prike Liang <Prike.Liang@amd.com>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 6aa75da27f912..5e1262636e1e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -146,8 +146,13 @@ static void amdgpu_userq_hang_detect_work(struct
> work_struct *work)
>                                                        queue, NULL, NULL)=
;
>               else
>                       r =3D userq_funcs->reset(queue);
> -             if (r)
> +             if (r) {
>                       gpu_reset =3D true;
> +             } else {
> +                     atomic_inc(&adev->gpu_reset_counter);
> +                     amdgpu_userq_fence_driver_force_completion(queue);
> +                     drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE, NULL);
> +             }
>       } else {
>               gpu_reset =3D true;
>       }
> --
> 2.55.0

