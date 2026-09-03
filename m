Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B13C624A4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 09:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE74E10F487;
	Thu,  3 Sep 2026 09:22:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RTCzxOCV";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3430A10F487
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 09:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtWELc62Y0mdoHrg6C1RgN/K42u7JYRHSjS3y3KWRZC9OF1zpoLgLGoUvCDIgvciNiTWYtxwQnrCiv/x1DGzHLyL9BYv2qDaaVYXyShbdai0UcWEBa6R1Dega0cUhpd1Dy0bIv68SsD7dvH3Ops1z4dGIreppbOFIkt4fM9kCGfSdNOebZghG4bvDFVDyta6r9eVUvrA+Yw3zsGHlC9yDb1MWwf5317n06wK4FFLBcAIxkBzSdNMwLz+g/e92BhpNJJ4FyBXW6tRSZPWOXyT/Sx2qpYs6wgN8BfVS4GKfz6j+X9M0UreUrNA1LlCB+KPiRpFM1HeKcOvlgqBaAuGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3mHZDeefSIkWcJGnIEunZgRGGn37M7ApAVuoQZ9Di9k=;
 b=a4eFQPPgNs0jUpX2gGUqmdgsClf9MUZQ6lCwHrdF7Ngw1BqVGk5HsduvZ/Ox9M6cuqTzLAOlowuRXRoFXYTlQMWoBZu35Cx1N8Cl/UOvVAiAlJ3LDLSE5tyLGAKBhLCICPkTk/yh2faIhzAgVy4sNv0FYiWZGJw1l6uq9+nS5wtLk6aPzcyunHBjHmDAVAuMDIHZgzcBYIP7sMPOlJwAF3DWz95joILUgmcEdIYZJPeFS5nQAA0y6lK6KMM1MqsPsRL9TywtQOON7CWXB7qHFU6Re22lLG6xs18guy3+W9IOeW4OTIHZZuvaOE1pCCkw2bk2liu38RPAPwQ9J/lLnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mHZDeefSIkWcJGnIEunZgRGGn37M7ApAVuoQZ9Di9k=;
 b=RTCzxOCVP1vVkRNEWpJ1ve3sDT0pUWvsvdIChAdkF+jjSMqaXWaADhi3OYh9c/QwRtDcs0QoEzBQuJRcgES5sCuF/KkJLYMrCshFME8hnPVcbKCKrzEBP0jg2qYNR91kvFrpPFSGlo5jDF55J71M0N6ZCpfOoTlOk7nJf5ww59Y=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by CH1PPFF5B95D789.namprd12.prod.outlook.com (2603:10b6:61f:fc00::62a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 09:22:26 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 09:22:25 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH V3 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update
 into per-IP helpers
Thread-Topic: [PATCH V3 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update
 into per-IP helpers
Thread-Index: AQHdOQkdHRScsyYDMk2QpvCtbprYU7a8mVjg
Date: Thu, 3 Sep 2026 09:22:25 +0000
Message-ID: <DM4PR12MB5152CC47BABD9E5DBAE83862E3B62@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260831052513.1518180-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-03T09:22:14.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|CH1PPFF5B95D789:EE_
x-ms-office365-filtering-correlation-id: 0d6276b5-053d-4d8e-300e-08df099cde3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|11063799006|10067099003|22082099003|18002099003|56012099006;
x-microsoft-antispam-message-info: DcISCjCqSEK4nUtxpKiiGGLc2e4OoMPxgTZqs7LhqvNwb795Yihlx2SMaZ+mIDxmLPkADs7kAubHWtr7St4TaFu7YI8PRbFXLaVdioQ4UIQ84jWD9eUL4H4NL17pxLoYMPW60XICfZ2Bi5B5ZqeR2UDDWBuy3BDjv8Lywfzm9ySeoiMMcRIHX0piGg0Yzcj00TJ2y2i6l8cgOIDJbgsM7aCsduK3qx87tScrbdbAp0U7W1V4FJ18Fe36W0d+yCLFfHjP4faxZpx/H8Ke4BkcXW/Amke1SWlNMmnEhlyxIBPpCsS0HeBBjGNF2hIFeF/YX2NnE+dOeqCRQ9h2IG4ow5UBRna8NvoYu2QeXhMAl/SCk+hUwqlpraRII0VwHLVNWQdn/RA2WNl395HzFEQsIngyHjtnGsHxN1Fkk1MiB70dSZwMqCyWpJSHt6/kC4fwxlVqvMJaNvtmjteo1p4l8+nqcOXNmYQJREGJPV9Mx3yHntSpFc516K9NjGkViPp8hZan+1Vslpl/z9JcG3CMrjLeLJmxtnwEmB+t4bTfQGQGB69j4RFgw2QerOVNLfZHCATttHZ1B7sBRwYN90DyX17AzpUYaQ0J0OONl+0GVSG/frp6Yadou6UIIFJc+3Kt8BbGBTGpeUNwGSYPTaPOF4vkRoNROQYPl4lXtPZYgh8rXCEyVFF4Gx+K5lXfbmTn8MTjKXetd3rPS5Tu9C3Xlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BYTvaG7usanI11bsDNjjuffr49IVuhzqh/YYNoO8TXD2L29cjCjXqUOqX95D?=
 =?us-ascii?Q?IU7y5ttL/1ohXZDO6jUxMWuX1knf+KbUGULy1WBBpCMKaXB5CsP6RRTY5Gpc?=
 =?us-ascii?Q?ulgMKtUaGo0RXpJhWofzmwi5mrScnQ9+ytNR5mGUDabVicd6zZsMQk7IRubg?=
 =?us-ascii?Q?0nYD2MK7/lu40SaGSX7KRmT9zvMHfr3ku4H2EFohCZu6XBjPGJkP0fRcI7bY?=
 =?us-ascii?Q?eOgBUHj/Q4YUFOfQt7NbhjwPgGlPo1FS4MBsHngM5IEdQVglcQBn+kHdu9y4?=
 =?us-ascii?Q?oRiASD1QKFyN68eQhvakphc4sH7h+fKUqn8VJ3fDXaqnnIJ9biq4PnEHisrC?=
 =?us-ascii?Q?7RnmIY7znBRE13vEHMDLsrSqArt9FScQzMX9xe6Yvy1cvi5bIoQ0uJWXtLaD?=
 =?us-ascii?Q?6yB+H7nWkNMHgjOK+L5u4g9fdRKfw3tANbXN5giLuHOOLSZjYc02A5uINjvm?=
 =?us-ascii?Q?PgGgZSs+1c34Ci9F7k9qcqaekp3dRyZMkCdmgQZ4cATQ/gNICuraRiUwokwO?=
 =?us-ascii?Q?MlYElwo7oW2IcScXmveJLxfxp7SZmOXC86lKffx9rIGFFyA4eMl5lFVepMqk?=
 =?us-ascii?Q?srsvYlOi6/wgdAlxR5yPEPsy76Nlrkm6K9IiHeah2NIsS0RfjmKrDzfMLWMP?=
 =?us-ascii?Q?58HAep/+k3C0eZ41qVbbfCVRSptYHY6QIieoX8zTn3b1dXDuFk/FDsdIEloz?=
 =?us-ascii?Q?EUIZNxFfsVGXFzQaZCLEe/FeoqB7duUb/cBL8YvJh3IhQZUgX0eQ4Ak6B5d1?=
 =?us-ascii?Q?BwUoO70ICJsf9StaH7j02r4tNBARBBBAwcDBdV0GNRKc8MAGQnAcjVdiPWSY?=
 =?us-ascii?Q?OpM1CcNw5RR6yrhQHdvbc8fsV20AsLJ1k1SbGYJEHYiLflS3Nbiqo6KUSr1A?=
 =?us-ascii?Q?Emp7aZWsay4a/V1nvAr9hERMjCk6hSocFc9MUraft9VgrJ7tw3EBLOwTPZe6?=
 =?us-ascii?Q?dk90nFvL0Qh7CcQa6YxS8vegyl7m/xAYRvOky1jhKJbUPftpbYR2K3l1/tra?=
 =?us-ascii?Q?XbQdcsvHVlSfIssG3vWxUNsrhkA6Sj8Eny7lyoXZ+WQU0Ky1d+D/nTqe2+cG?=
 =?us-ascii?Q?6KWEtb+8yOxLqD+FqN64pwWehM/8j9WSiD6Js62F/iySwtF1LdkmOVsN6QEK?=
 =?us-ascii?Q?3RtPuk1SS06agqqntBt3qfbLzKjyGaw6QDEPt3MtJoMcGh9Zhx6hXsCVq31T?=
 =?us-ascii?Q?0Y2KjhUrTtvFoDHk4B0xoUneRy4vYarVBZl6rwiID9utEA/jCRzrQsGUXPb9?=
 =?us-ascii?Q?iUenoM2vKg0QvwpsHl90+uQPvYx3Vdk7WZdu6gq4YHJwjayAx4IuNhrQstYq?=
 =?us-ascii?Q?WZbNBA0iA+zvbouocV68JpiNsgaRCsa73xCP6FB1UTk/grf/WjJjZDA6R+Yo?=
 =?us-ascii?Q?dQBpG8QPPaFRdV3GS237u+wBEgxsPkQn+q28aTVxyeo1dYDe5VCmTE3vzVKa?=
 =?us-ascii?Q?1FrfLwjUT2uEtoFhBPfCE6uxHpmALjHpRHOeT5Eg0EG6Cnx0MuQBpPrgmr5o?=
 =?us-ascii?Q?2aUd05p5sGURin8x1gicEnM70pWMthAWPv2SRBuZarpr4qy7j6j3MFX2PZpQ?=
 =?us-ascii?Q?oO5nSRO+FvXPpOCiPTgL4kLlMOhqP52R9ROyff5Z+iDuOiF7WB7Xq4wv5F7w?=
 =?us-ascii?Q?j6xqhC5drK7EaWBpknf8zpww0l+ZLmoRd/g3PQLfVvDzpybhL0U5YIE5zxml?=
 =?us-ascii?Q?6aZnCcYg7sXahis8GCAvJYfhGqU7JXS1WkFD48TvOuwheZ6b?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d6276b5-053d-4d8e-300e-08df099cde3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 09:22:25.8020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6lCk/nxKZrO0CYwdtnGc7rMc5hsi+s68Ox11w9cUlbf6rL4hn9NGntt+VeIn+mhmLfZ4tvn9etyCkFmyBW5tuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFF5B95D789
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

Ping ...

> -----Original Message-----
> From: Jesse Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, August 31, 2026 1:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH V3 01/10] drm/amdgpu/mes_userqueue: refactor mqd_update i=
nto
> per-IP helpers
>
> Split the inlined compute path out of mes_userq_mqd_update() into
> mes_userq_compute_mqd_update() and turn the former into a dispatcher that
> switches on queue_type, giving other IPs an obvious place to hook in.
>
> No functional change.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index ad72ced472dd..82bb4369451e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -681,7 +681,8 @@ static int mes_userq_mqd_create(struct
> amdgpu_usermode_queue *queue,
>       return r;
>  }
>
> -static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue, str=
uct
> drm_amdgpu_userq_in *args_in)
> +static int mes_userq_compute_mqd_update(struct amdgpu_usermode_queue
> *queue,
> +                                     struct drm_amdgpu_userq_in *args_in=
)
>  {
>       int retval =3D 0;
>       struct amdgpu_device *adev =3D queue->userq_mgr->adev; @@ -689,12
> +690,6 @@ static int mes_userq_mqd_update(struct amdgpu_usermode_queue
> *queue, struct drm_
>       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue-
> >queue_type];
>       struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd_v11;
>
> -     if (!queue || !userq_props)
> -             return -EINVAL;
> -
> -     if (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE)
> -             return -EINVAL;
> -
>       if (args_in->mqd_size !=3D sizeof(*compute_mqd_v11)) {
>               DRM_ERROR("Invalid compute IP MQD size\n");
>               return -EINVAL;
> @@ -720,6 +715,19 @@ static int mes_userq_mqd_update(struct
> amdgpu_usermode_queue *queue, struct drm_
>       return retval;
>  }
>
> +static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue,
> +struct drm_amdgpu_userq_in *args_in) {
> +     if (!queue || !queue->userq_prop)
> +             return -EINVAL;
> +
> +     switch (queue->queue_type) {
> +     case AMDGPU_HW_IP_COMPUTE:
> +             return mes_userq_compute_mqd_update(queue, args_in);
> +     default:
> +             return -EINVAL;
> +     }
> +}
> +
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)  =
{
>
> --
> 2.49.0

