Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDEFC71136
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 11:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07E5210E77C;
	Thu, 12 Jun 2025 11:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="teT8iUFY";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C5D10E770
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 11:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dU8Emd/vjUZKIqkI4fEBpFAQXMyt64Za1mDjXV+BZ0SQGq6ZnWHPKQSbo+C88fnBRb44Et9QSPKG1GjzWCdybsuM8Wmn+Tf+LjgaeMpmNc1uVgWCBDkuB74JZHvSm6N/o26f2Urch6ZKM5N3ZhK/i4oXHD4rmG6ANI4U9GtuXw4pMO1TlKu2kf3IQuIa3oHKHmYxL7R/sbOfO2LpYTZWAnkwIAsMamhDfmv85WdXszdEFbIsyaJf1i9qVN/73Kll8ApSx33qe5/O0qDeQIuRUv4ucSlYhAhBNw5iBZzkTOEt6aNdwoFaQIilb1tf2ApamdD6gCB5YZwtBfAR5UBhyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4raJyGGwDwaUWwz+ayyHlxiCGgtPdYkw8dDFVP1jrb8=;
 b=gW9decozkSm5ZGK2LQov3PiipIWNZjKUSg2PhelOWjYr/lWdlV/ltvv+wP7pvZa4D1Pt9iNelxQpjtr/ydFOwTvup3Z3ZEZ0zcJgQx0GI3hRp/PjK7RBtL3GVzldyHbcqdQYphIcR0cL09YxpfBGvTShUPIqhFqyMz+DvYs8FmvuKknz3LQxApOXgoQi1Sztc+2iK57+eiasn1uLaLlydJ0iMxLwmC/o7M6qg7uoCU5ufJ1eaGEBepqGj5u9rtPpsrX4SE9DciBQgJGZzgGrEU9q+nngFJ+HF4r8oT/42CAkvnzjZ4TUZLN2BbsOHpR5ukBr6loFKui6yDIghz9mYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4raJyGGwDwaUWwz+ayyHlxiCGgtPdYkw8dDFVP1jrb8=;
 b=teT8iUFYePiYowlGV0l7x1fBD/6w0Abwef05JOE65DzKRVPq8eoNBOBicFyZ2vmfkRWuAD6vmGYGpEF9h00Uy7lFr1NXxE7UPnvOSOIjhlGreBD2/AW7ukMZCT8BxF3fHNOlnw/NzbyAvluAkENMrP1DWPhiBaWPPhJgAxt3gdg=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 12 Jun
 2025 11:19:42 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%7]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 11:19:42 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: change usage definition of
 amdgpu_bad_page_threshold
Thread-Topic: [PATCH] drm/amdgpu: change usage definition of
 amdgpu_bad_page_threshold
Thread-Index: AQHb23LUpZQtCI2g2EKlKKOR2j1SG7P/YFpQ
Date: Thu, 12 Jun 2025 11:19:41 +0000
Message-ID: <PH7PR12MB879675A493078D04F2106438B074A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250612081943.183189-1-ganglxie@amd.com>
In-Reply-To: <20250612081943.183189-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=77bfc2a2-eccf-4f39-b875-8ec431d5344b;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-12T11:17:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|BN7PPF39B20C1D8:EE_
x-ms-office365-filtering-correlation-id: c56f7535-0d9c-49da-51b0-08dda9a306ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?U0Ft6H3IvjMgX/iItMLnOSxWv76YzjpuIduHvQMT7xhLbwmznijVzAjyLXyL?=
 =?us-ascii?Q?nQYnQyLkkdRc8rIt7eAT5QYWQTMTBGW7FnOTExXRDHQyR2OrDZj6S9857WZC?=
 =?us-ascii?Q?45kjigYNofPQNqf59+EM08OW35QfYNIfGmQ2D2/6ckMzRAfRCW+ukTcX6xbw?=
 =?us-ascii?Q?citjG6vgxyLFGYXzR81OCjO+mFeWUxZdqPjNIZaWfj8tE/ngExxUc8s0AnUE?=
 =?us-ascii?Q?RkjOJvKiMjwSQdgjzx8qDpNEu4eduD820oHs1bSA6Ybd7YCxD8xWTo7zj2az?=
 =?us-ascii?Q?vqariEwtB0rPs5TK8E6cnqg3Q+4yVoLoOdyP892q/247ogSjwnwDxJ3TfgjJ?=
 =?us-ascii?Q?HxeLhFYjIhNrV3sct3V0AgnOBFTNDoOUYkqDiUY3V0SJFFapg8ipDkLq5JT7?=
 =?us-ascii?Q?AujSylfcjcu32lO3ulxWX4HOYXqoqUuxTxkFT0E6EheCqHby6xiwTeFcd2BZ?=
 =?us-ascii?Q?7AM0GC2yFnYnZ/m/aU4pPEYgz2c/6X03O+RscUcRlRf46b2RcK1zRiVaMkOw?=
 =?us-ascii?Q?RoaDrYmQ/r7cp13JAaNpx9mZppA24CNb320P+skOUa3j+5Q7Ctmy9ud0QLeg?=
 =?us-ascii?Q?5NXlpPyulk9cNF8+fJxOiBoiJyNMKY//t73fHkaW4VxLmUidmyBnAeMRVXUx?=
 =?us-ascii?Q?vfzi7OWcyuwcv3vvmxXVDOSh0Ou26dQMedLk6ojG7q7cE48DuUbtCHL9+RFM?=
 =?us-ascii?Q?taobdPlxpH0WDaiKIZjdr+kaMrkYoCDMHPUZBspWrGNkMz0VoXpEzywzWCjG?=
 =?us-ascii?Q?PsWAo8iiIRVoCJyFkUHwB0QcHQSNoZojrsv9F76vqvpvujru9/JEBRFu6xkO?=
 =?us-ascii?Q?IqYZoPjNT9dIACuSwBqaXsdHA11SIwS1+nxmj6x0imB9OlgHEvCPTilYI/P5?=
 =?us-ascii?Q?ZAZaKS8Ax25ZrZ7VtpMZUyE6ePjY9H0J7syPvTKZKgOFAUYj5tZoPDgbOE30?=
 =?us-ascii?Q?/GFzqS+OkO0AD5ymbgqeqFRkzKwlEINC0V29MAeICpKH8phKqI5mXnrnEFEu?=
 =?us-ascii?Q?CIDiPvn2ojEI0RaUVkU7Djc6SZbzCfpb1zt+753HYNAXNbzsJ74WS084ei3e?=
 =?us-ascii?Q?OyDwpeNww8PFfwDMkNLTm5cuGywXcwBGZ4Rq623vBN/hioYYQta1gReG/bpd?=
 =?us-ascii?Q?KhC029WDfMeFNvcOhmecegN0geKfaAAlOCcw9isV5F/N36bfnsXafA4zjT/m?=
 =?us-ascii?Q?y+lNn6ipiqiSgN7cSBVzfGvY7Tj6HaBu8EG75pjwBVHlMUid9D+0XQnc7dAb?=
 =?us-ascii?Q?N4Pl0DC5/p4nKPOKxpsDwWNmrMZNgT9wknd4iZ9FHMm+kCLM5sObGOfRJ7sl?=
 =?us-ascii?Q?xk0nz/VUIGeD2Ri8gdGiD5lFGARjRNUND9YvweC8LWX9qj9YUOVajGj9/6ak?=
 =?us-ascii?Q?7Urw8q43AGLp/RQ5jZVjTtYJFphJJ8gXHxyGHuELfXz0WYMj3eJ6evmsAgLW?=
 =?us-ascii?Q?V+VXB9DmOCyV2Rz5Tks6Q+Jt5CkUgbzzzXz6D9pupL1I4zS/00igOg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VpboojjtQpfSMUbzM0CpeizGiUJTnEkguI8vo+VeD1tt13UDgUlVGBUcKk9H?=
 =?us-ascii?Q?04EIKKW9HU+U6179gei3t8rMzE+vKpaTQr8l8UaRsDz8NddiKpwwpTNF5wXH?=
 =?us-ascii?Q?RQ3w7EprdvRxmr8sFvZVMPdbaJJ87i4nFejTu0QgFGTL7UYENyh5euFsOy4s?=
 =?us-ascii?Q?AILWSRxKJlUMJTt8FFZrA5uet1ImpkrPvVDWjEBGRaGEIFKv7MrXLY73C2te?=
 =?us-ascii?Q?Uf3ciHGbC38Pkb7rQulxmTdqIs4UH/YNcZFWtHO0dnLTgZS6mkKjD2WZoCfs?=
 =?us-ascii?Q?2tgmXSt7X8NIcCvKcwfFP9kLqyK4y/8r3RI8jA1V2SZ46oK19e1B4oGU5bk2?=
 =?us-ascii?Q?bw3674wQbKr8g8CApe0Vyzyzs2ra3eIc+qQj32ku6P+wjSEn/myDSub5B9mG?=
 =?us-ascii?Q?KgofkaS1kSmypEoHXsbvDWzbxU51tXZ6g/0YFiUJXDKwsYI8ErEdbkmHAfd+?=
 =?us-ascii?Q?uAcOz+0tXSkZ7QM+/1+dDJ+/4rfG+7m0YJ9ZQizANCF9tWoDj4Nv+3GmLsch?=
 =?us-ascii?Q?9VC4oqAh39b9907Hq1uK8L/Uo4iL7LxLuNU5VWKKrhk7H+fMLnex/5ioXiAT?=
 =?us-ascii?Q?/QLHp6O5kgqpvu6i0GiuJgN30J7NrLT1SwPNxUyeooLfnbJ5z+WvP50lEbVo?=
 =?us-ascii?Q?e3maxT3zkRhlg/+/XvcQ9OXplNKg1hQvhD0uD2Ny8cXrapfEFK66C6X5jBhE?=
 =?us-ascii?Q?uNN52r22EEGYoVnFmOeVgc4prgJHXjbRmpBkYn90/2r/opRF953o2ftkKulT?=
 =?us-ascii?Q?63TEhB+ZwrfU40oYmEjNkFwzbUD4FE594o1gkS1tsDJbFNGH9K7wD+jFo00i?=
 =?us-ascii?Q?Tt3Ts9fFHk3iLD0UrMDSMddwmGwb9Lu7ljbJedlqAp3ZTsg3YYUEEoWi3Xc1?=
 =?us-ascii?Q?LVaCqbVJfSq9spbnx95yJjXUnVqRqKD4qqAamzYLIi4gljMsgTOlMWnD8ct0?=
 =?us-ascii?Q?YchdSzjL9PSnJX0knAPQt4zcKyfaZ9Vvvmz/0D5xzmDl8nqxcCtm/aLr0NQr?=
 =?us-ascii?Q?JpdNf24zDTDpKOtXvZsBxd0Rxtj2Dq65il1MTevDMopzhZpMjAIxuCHoHANM?=
 =?us-ascii?Q?x5ZcYTgMbqLyvDvFc1u/br58w6dFBVdgX6rh8itDhCmRg0CCFUtnnhbagxPR?=
 =?us-ascii?Q?hgngtKgjSmO9V7KthGbSIxqsyyI9Zl/w0pEEZffp2Cb/S75sWPfkg5hTlbLz?=
 =?us-ascii?Q?wK3gYqYgR9izOIjk5zufivgvoNHpFl0k+8qeEVJKbxtgvA/hhzrepAziEeMU?=
 =?us-ascii?Q?j+YsKSSmC4V+YG6B0vUFfWtkuwOI3LHQHkubqyZ1gjch9GkDg4g6Kcta9OVF?=
 =?us-ascii?Q?LbgvuGJMN3M5+Tuk7V4twDvu0vsB4iIIgRbAq8dumrWna7LSKb6KxBmIT1Dt?=
 =?us-ascii?Q?ziuSYKVenYY8+TDO71vE+hxBA0QKC2PqaDQra8YG25aGPhS8Txpi9ODIi+yO?=
 =?us-ascii?Q?5wj3ycnlCbhsgvxV1pGY/4RaeXbNYatHUdicLmud4wraU1MCPlqBIH0/IkyH?=
 =?us-ascii?Q?qSDabRoAbiFB1KgJcxYmLJvAqTYLrJv5AAAukVG0awNJWKnafSrZ2fTplpYX?=
 =?us-ascii?Q?TMrr3eUJBM5bIRUUCIw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c56f7535-0d9c-49da-51b0-08dda9a306ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 11:19:41.8211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLf+2KWJ65VjMA+DIXnWtzXsPeRHnu4FuSwlZEGGhPaArfsy9rXUbcuBdMm9adNc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
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

[AMD Official Use Only - AMD Internal Distribution Only]

There're 3 changes in this patch, for the first and last change, it's bette=
r to get Hawking's confirmation.

Tao

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Thursday, June 12, 2025 4:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] drm/amdgpu: change usage definition of
> amdgpu_bad_page_threshold
>
> when amdgpu_bad_page_threshold =3D=3D -1, driver won't write BADG and RMA=
 when
> amdgpu_bad_page_threshold =3D=3D -2, driver will write BADG and RMA
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  2 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 26 ++++++++-----------
>  2 files changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 9dfef13babfe..a1b97d516a27 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -3161,7 +3161,7 @@ static void amdgpu_ras_validate_threshold(struct
> amdgpu_device *adev,
>        *      which is intended for debugging purpose.
>        * -2:  Threshold is determined by a formula
>        *      that assumes 1 bad page per 100M of local memory.
> -      *      Driver will continue runtime services when threhold is reac=
hed.
> +      *      Driver will halt runtime services when this custom threshol=
d is reached.
>        * 0 < threshold < max number of bad page records in EEPROM,
>        *      A user-defined threshold is set
>        *      Driver will halt runtime services when this custom threshol=
d is reached.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2ddedf476542..50a6e975addb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -568,8 +568,7 @@ bool amdgpu_ras_eeprom_check_err_threshold(struct
> amdgpu_device *adev)
>               if (con->eeprom_control.ras_num_bad_pages > con-
> >bad_page_cnt_threshold)
>                       dev_warn(adev->dev, "RAS records:%d exceed
> threshold:%d",
>                                con->eeprom_control.ras_num_bad_pages, con=
-
> >bad_page_cnt_threshold);
> -             if ((amdgpu_bad_page_threshold =3D=3D -1) ||
> -                 (amdgpu_bad_page_threshold =3D=3D -2)) {
> +             if (amdgpu_bad_page_threshold =3D=3D -1) {
>                       dev_warn(adev->dev,
>                                "Please consult AMD Service Action Guide (=
SAG) for
> appropriate service procedures.\n");
>                       return false;
> @@ -763,18 +762,16 @@ amdgpu_ras_eeprom_update_header(struct
> amdgpu_ras_eeprom_control *control)
>               dev_warn(adev->dev,
>                       "Saved bad pages %d reaches threshold value %d\n",
>                       control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
> -             control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> -             if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) {
> -                     control->tbl_rai.rma_status =3D
> GPU_RETIRED__ECC_REACH_THRESHOLD;
> -                     control->tbl_rai.health_percent =3D 0;
> -             }
> -
> -             if ((amdgpu_bad_page_threshold !=3D -1) &&
> -                 (amdgpu_bad_page_threshold !=3D -2))
> +             if (amdgpu_bad_page_threshold !=3D -1) {
> +                     control->tbl_hdr.header =3D RAS_TABLE_HDR_BAD;
> +                     if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_=
1) {
> +                             control->tbl_rai.rma_status =3D
> GPU_RETIRED__ECC_REACH_THRESHOLD;
> +                             control->tbl_rai.health_percent =3D 0;
> +                     }
>                       ras->is_rma =3D true;
> -
> -             /* ignore the -ENOTSUPP return value */
> -             amdgpu_dpm_send_rma_reason(adev);
> +                     /* ignore the -ENOTSUPP return value */
> +                     amdgpu_dpm_send_rma_reason(adev);
> +             }
>       }
>
>       if (control->tbl_hdr.version >=3D RAS_TABLE_VER_V2_1) @@ -1508,8
> +1505,7 @@ int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control
> *control)
>                       dev_warn(adev->dev,
>                               "RAS records:%d exceed threshold:%d\n",
>                               control->ras_num_bad_pages, ras-
> >bad_page_cnt_threshold);
> -                     if ((amdgpu_bad_page_threshold =3D=3D -1) ||
> -                         (amdgpu_bad_page_threshold =3D=3D -2)) {
> +                     if ((amdgpu_bad_page_threshold =3D=3D -1)) {
>                               res =3D 0;
>                               dev_warn(adev->dev,
>                                        "Please consult AMD Service Action=
 Guide
> (SAG) for appropriate service procedures\n");
> --
> 2.34.1

