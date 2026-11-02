Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D460A2631
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ji2mfb3o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6846910EDC2;
	Mon,  2 Nov 2026 13:02:37 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013059.outbound.protection.outlook.com
 [40.93.201.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7692910EDC2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 13:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARGkcQ9yVV4mW8WUBfNJKxlfSYE4EQ4dDjA+J5hocMlVll7x8WK/BcSmMoA6s9y4/Z77QFk9jBESKVg9R5tyRL0JI+BGhWcGQpxlB6WbcwGX3OUr11WaB64bkKmeZW16Tfq6kZxlEKESBPtwagLsLC1zwRzVtSBoKFVFcwHvJVnntWx8JVHhmjsDwhqSOE52SiflkxMKAc78ObM0fLk9ne3xT9t5m/ZfYIFvUHvaf5xwoRd3kv8r/LovLYeCbObD5aVifUxqQss+PjHaKA43p8LTekBOtYy7M6fxJfwFe7hHAAs/r4WLrN64SdaNAcw10Vd/+S9ynbr2TYE42O3Y3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lUHBmEA3qcNPT1QHd6kPhsg1iqm1agdTtXjbDKTm+A=;
 b=KyOl7LaggyDIAzyRAN1sX/g2VIY1SeZPKoTyu8qhu8+ZvWjZf+XK02pim0F546ZDAdFKgeJBrSyCsFSBKiNsDURXvQpIF/PpktdUgNkC4KpYzoybRUeIntb30BRITHqNKNpNUcz0+a8xuvHOBXtqRaczzE0zfQzkUOeAaJqSjMwPQ6D/6aVcjLK+Ok7I+6NVIOloLlh6srw9HiLE4bc3OSBRyUZv2fXSnWM1Je+y2yJy5P1oADmGdWaWMO8kds7XsalfdS1kyr2ArKSFgc3Dp7Dl1GXI8mVr9xuoRV3DZ6AtkCamphgoz+jcpBmpU2y5iYxNowMS+dqlpJJIzJerjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lUHBmEA3qcNPT1QHd6kPhsg1iqm1agdTtXjbDKTm+A=;
 b=ji2mfb3oXw4eCpA0KGxM6Cntik0MDAdK5cBGVvqzKPFCmgF53TntKDG9jrbfaBnuowei4+k5Vfk4Nd3BpFCbMqOyLJTTOysimkqkGUydH1+v1wjxNWKF/lTpBO2cFSW9GDSLQAk9WUKaj7Su/NRhA/aBzvkNXRY0UEuSJUa5rzw=
Received: from PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 by SA3PR12MB7951.namprd12.prod.outlook.com (2603:10b6:806:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:23 +0000
Received: from PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4]) by PH7PR12MB6000.namprd12.prod.outlook.com
 ([fe80::757b:8342:952f:7cb4%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 13:02:22 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Pelloux-Prayer, Pierre-Eric"
 <Pierre-eric.Pelloux-prayer@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Topic: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
Thread-Index: AQHdWGIlEWucozmnYUWuewqTdziwCLcHyI7QgBMaWBA=
Date: Mon, 2 Nov 2026 13:02:22 +0000
Message-ID: <PH7PR12MB60007852782439A41045D115FB6A2@PH7PR12MB6000.namprd12.prod.outlook.com>
References: <20261010025024.2453900-1-Prike.Liang@amd.com>
 <20261010025024.2453900-4-Prike.Liang@amd.com>
 <PH7PR12MB60008793634464A78A3FA17EFB662@PH7PR12MB6000.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB60008793634464A78A3FA17EFB662@PH7PR12MB6000.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Alexander.Deucher@amd.com,Pierre-eric.Pelloux-prayer@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-21T09:15:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6000:EE_|SA3PR12MB7951:EE_
x-ms-office365-filtering-correlation-id: f087d954-3e70-403c-5aa9-08df38e188f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info: h9VJMRQcnTDVIMBNCY5aSkDMwNXLYvEUnuQvqT0B0CCm/g8oIeRwn4zIREW+se7l346+tKSYSnIOje1zwEzePy095HPh1zRc93bdogflSOJgHUK1SsQXJYFZMgVgdBUhnBAHMb/+82D2OCdg4vSku2TY0EODqO5hyxiqytLfr5l87yxtHg6EbdHlBZh2K3r+E0bHOh3hq5T+xzrvDN7XqBjvShy+AOG56SXbpQtT7g5EpeVYdK853rbpytCjAxAKaCpm8YnG7WJ0jBHgPeZ0Zyjo04oyLnGsGo7HIbxn63GJi4xr/gSEDW8tneeuvSJwtoQZ0MOVpP2FxomnjlPhp2as2Z7nBOTAbQ5BkdSYx/A+MessDeIp2qjR3NEadzHrf94ZndMZwgxk3h81ty2YgZfDIg+XMmhxVqg90r0zxReDd9hNzJB7WCFCF6eVZMXh1cuasCw/nUBT7FKzrpp2nSQWuIjFm7a5I0EoowAwe0SVScllrWSfUEVdHG5K7h94p4ZEDRB/vEiAYol5jTc8DDOwsCrvcll7nEZDEEQ60n3hlABpWE/wEkXcQ3lE9j4rhAv0QZK7bI8sDBUQzYbS4yJZU/t76P40MXGH9ZEm9xbpGQOaCYVxlooX9FwNJEAWVpJ88zyTXh+IfTQ9QzaEUg5t6mcLV1FUAATPbLtjo5w=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6000.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WhRLuAEL2QFH+4csA1srkpAknqvNptlw8H3ELotJQvoI6hVxAt4jyAayaMCh?=
 =?us-ascii?Q?OPQJt6BMyvc/SbJlNW70jL1NhOoK+7+MK8zWSjBmfK9uLRd3Gv2k1ERKe+9i?=
 =?us-ascii?Q?uV4yCSJcrbg/fX+CLEP0PNxMLcMSBQwRLE8Y3Y+f9sQdO9YuxfWw9/ijQ7Sy?=
 =?us-ascii?Q?8a4V2ECRoNxtUzVleCaU26MHehrFcCIjr3Dxe/zxyx3LajVbVWdW/QeQBg1q?=
 =?us-ascii?Q?lUR2Hc4rOQmKjuwHLYGD7aZgAZHUG2Ug3MMcw91NqOxzB6oktcXoVPlOiXRV?=
 =?us-ascii?Q?bs9AM0Opn2obj1qzRLsAGOuU0PVO2EmPs6YJVv2+Ez2ojerJxTCLPGKBktAh?=
 =?us-ascii?Q?D6YXqp/Ifzd6WF5pj44hk+fvIxtdiMYLdoiWsL/B09kg8Id8tylolIhFuqbB?=
 =?us-ascii?Q?fwJwCaVEWqDpBZWPVt2C3dcCw1eRoXum0b52JDg8TyFaKtZYCsnCcXs4o+pr?=
 =?us-ascii?Q?mqC+RksiQx6W0zxzHHQskOaXAlV0pW85rQWT0vYO/97AgQ58nlZhuIBjX0Kt?=
 =?us-ascii?Q?TJvoPPKtjSUe+ghwSVrmrKzLonXIOuC7RC01oImhS0k38aJIlKQut60Lgq2l?=
 =?us-ascii?Q?S20TLey8QIl/TrSSuEatDnIfCn2HeI7X8+xbiifsHl2mVlRitcF+UAkoR1sh?=
 =?us-ascii?Q?rY/5qyTXBUF6q7iDJimvC4x7ERptCEMG2VU6vi2Ngxtqg/xvQmUI/u9Z1KNj?=
 =?us-ascii?Q?v+464Q6uHWYtoFwmRqea88imbfnw9Sc2xs9zS2JRD6ra2V1pFSTngSQNQoNQ?=
 =?us-ascii?Q?qZtZbIBNHsQIUrCXyhUuHXDiqCfi4Ac0LKQZvIleco7k3h4PuOC6QSyLleU8?=
 =?us-ascii?Q?WoFvDZyvd9nmmZP3MibOG/bYSW/xWY+G8wS2Y3ItnFL5u2I2d5n1bYzyri4O?=
 =?us-ascii?Q?lPQ+i+00GvsBy5cdwLPLet2dCWpYHk5nk/lkHhHYUGbPB3zqgL5QTQZ+b5Mi?=
 =?us-ascii?Q?hIJ2nj2+LhR2s+zKFW4ORO05N64Dco4NSHGS3D65Cgcbph94a/YNa4lbAJ6I?=
 =?us-ascii?Q?GNJzhjor+MDEzv+mF8KHCywvJQ3aP9OwHYhUGsw3uhlbTDnNIOKVVxcpGsx7?=
 =?us-ascii?Q?dMmN1H6mwVa2HZzuFMgIvTfPwINQRDryU3j8D4n5DJKSiK8MFpBwQyTMpsKG?=
 =?us-ascii?Q?jF0MfqD2f/N9THqlPMfKBPoJn61blWwwzK6SSs3g6AG2TJ/d5eCB8+CfF+BV?=
 =?us-ascii?Q?8jYn4990i2JvnbWa/bMkzEAyuDASD9AvuvybIl3iEJ/ileQs5jBfWqjzFJX2?=
 =?us-ascii?Q?tsZtwLoDenzrLUmu0tcqxvWs8fq60SE4XAuW+VtEBftJTUeVpP7P2R2rHTZ7?=
 =?us-ascii?Q?/OgMvxDSyzD/YBXN9qZZBXvWweoOF0ZXJKeYgYtY4xJuAHZAGSEVO5mUT0Mc?=
 =?us-ascii?Q?02nXYT07vnbWDOuRw9m2DMUOYdn5e0JeW/mZf9YGZeOaD5zqHf9SnP3X7yLs?=
 =?us-ascii?Q?IRFJ+27qdw8Rgvy15P3tlp1OWpOOh8g6KaZyiiSF5uq0+2obiv8Vmn2HvbI+?=
 =?us-ascii?Q?SeYVUjk+4F70ZnKMpaYDyAZZkNzc4zj2Kpnqeiz2brpsiAxACbzurLc0jBug?=
 =?us-ascii?Q?bwkbK+l9OkjzyCvPZv8ma7XRKPKWV5sa+DsEg+Sqw1I5zQb9Qx7j8H8VsM9c?=
 =?us-ascii?Q?8NuoPukSt5acPeQVnPij6St1FJzZcI2nH6h5aKle52IRIDL7D4JzvIsky+qx?=
 =?us-ascii?Q?nMChqzTqPOc+pa3AIKQtCAYvKlSjrpaavP824Cmu4UWNaMqj?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6000.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f087d954-3e70-403c-5aa9-08df38e188f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 13:02:22.6015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GPQmN9dJwsiccrfGuNggP/+raSu+fPpaSO+Se8xuV2KR5R572GI3caxXdsna1vsp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7951
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Hi @Deucher, Alexander, @Pelloux-Prayer, Pierre-Eric

Could you please review the following patches, which include the libdrm imp=
lementation?

https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/487

Regards,
      Prike

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Liang,=
 Prike
> Sent: Wednesday, October 21, 2026 5:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pell=
oux-
> prayer@amd.com>
> Subject: RE: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progres=
s
>
> AMD General
>
> Ping on the series
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: Liang, Prike <Prike.Liang@amd.com>
> > Sent: Saturday, October 10, 2026 10:50 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pelloux-Prayer, Pierre-Eric
> > <Pierre-eric.Pelloux- prayer@amd.com>; Liang, Prike
> > <Prike.Liang@amd.com>
> > Subject: [PATCH v4 4/4] drm/amdgpu/userq: report GPU reset in progress
> >
> > Report an ongoing GPU reset through RESET_IN_PROGRESS at bit 1,
> > alongside BROKEN at bit 0, so userspace can query whether GPU recovery =
is
> ongoing.
> >
> > Validate query inputs using the same rules as queue deletion and
> > document the required fields. Drop the queue reference after releasing
> > userq_mutex because the final put may destroy the queue and acquire tha=
t mutex.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++++-
> >  include/uapi/drm/amdgpu_drm.h             | 8 +++++---
> >  2 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > index 6340e647a67d..6c4743ddf04a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -835,8 +835,11 @@ amdgpu_userq_query_status(struct drm_file *filp,
> > union drm_amdgpu_userq *args)
> >           queue->state =3D=3D AMDGPU_USERQ_STATE_INVALID_VA ||
> >           queue->generation !=3D amdgpu_vm_generation(adev, &fpriv->vm)=
)
> >               args->out_qs.flags |=3D
> > AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN;
> > -     amdgpu_userq_put(queue);
> > +     if (amdgpu_in_reset(adev))
> > +             args->out_qs.flags |=3D
> > +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS;
> >       mutex_unlock(&uq_mgr->userq_mutex);
> > +     /* The final put may destroy the queue and take userq_mutex. */
> > +     amdgpu_userq_put(queue);
> >
> >       return 0;
> >  }
> > @@ -898,6 +901,7 @@ static int amdgpu_userq_input_args_validate(struct
> > drm_device *dev,
> >               }
> >               break;
> >       case AMDGPU_USERQ_OP_FREE:
> > +     case AMDGPU_USERQ_OP_QUERY_STATUS:
> >               if (args->in.ip_type ||
> >                   args->in.doorbell_handle ||
> >                   args->in.doorbell_offset || diff --git
> > a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index
> > 98c3fa8a4a72..32ed4c4349a4 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -355,19 +355,21 @@ union drm_amdgpu_ctx {
> >
> >  /* the queue is broken because it is hung, has an invalid VA, or VRAM
> > was lost */ #define AMDGPU_USERQ_QUERY_STATUS_FLAGS_BROKEN  (1
> << 0)
> > +/* indicate that a GPU reset has not completed yet */ #define
> > +AMDGPU_USERQ_QUERY_STATUS_FLAGS_RESET_IN_PROGRESS (1 <<
> 1)
> >
> >  /*
> >   * This structure is a container to pass input configuration
> >   * info for all supported userqueue related operations.
> >   * For operation AMDGPU_USERQ_OP_CREATE: user is expected
> >   *  to set all fields, excep the parameter 'queue_id'.
> > - * For operation AMDGPU_USERQ_OP_FREE: the only input parameter
> > expected
> > - *  to be set is 'queue_id', eveything else is ignored.
> > + * For operations AMDGPU_USERQ_OP_FREE and
> > AMDGPU_USERQ_OP_QUERY_STATUS:
> > + *  only 'op' and 'queue_id' should be set; all other fields must be z=
ero.
> >   */
> >  struct drm_amdgpu_userq_in {
> >       /** AMDGPU_USERQ_OP_* */
> >       __u32   op;
> > -     /** Queue id passed for operation USERQ_OP_FREE */
> > +     /** Queue id passed for operations USERQ_OP_FREE and
> > +USERQ_OP_QUERY_STATUS */
> >       __u32   queue_id;
> >       /** the target GPU engine to execute workload (AMDGPU_HW_IP_*) */
> >       __u32   ip_type;
> > --
> > 2.34.1

