Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF46C35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 09:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5058010E351;
	Wed, 19 Mar 2025 09:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8KXo4xE";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A215410E351
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 09:03:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQh3Cz5riClrAkexHc1dhW8TSe9uFR5YkzwzeyoL5URjdDMqaGCHpyukzbmSfPX6ju8eZfzuQ1cpRj8/cCx5MvLENqeGCaxChl1vu3SQThCa9EVVK21oRgZsF1RprB/gm2JT2myYNyj0qx5fPMUJtY3yk6WR67R3HhvS+UHmWLaUFFSC7iAL7a1/v3ruehFm70Lc2GbapRdTvCtDDu1T9TbszwjYUQhsTYOQwafa7KkwIrujBION6T3x8LoO6AOi+yBvwqGR3hymRhh/04byBnoS/B6QXSFgJ1zAkT4UX6tjfIsucsyOZUHM764LTYLGtFx+p1zn9K1OwbCyZg0+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/5JFIoshPFUqjQX33xETJWpAVdmvJ3HsgYiU4OP+SU=;
 b=FjQah96zSdnn8NxWxwt78jhlu0nAC/vLQOBM6u4yelYA1jP3AB9tUIOEPNeLGHJ3hzg0K9YTa0gmmh9h0ST7aogZhf6KiHHnCkLCkmzgX5KU4DO5dTXaCAp53fcDvYkkV2AVUzlf91oOirg73ykBBDTpIkPam5kej4WwwUjNXU6YvLqef2oCsqqtqRMwpbxTzGzM3Jo7oJZ0l9tUAY/WCDAJnS5ZLJR39CFPfUENe02egqihApzObjxrNHjgeeQRsV+SzDhY8rKEgT5wIkgu+2diaL0XFaIVWpZ69Ow/8VGGS2GQ035j2CkExif1Cz0y+A3lf85Edz4plzOV7RQBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/5JFIoshPFUqjQX33xETJWpAVdmvJ3HsgYiU4OP+SU=;
 b=L8KXo4xEQ9haWNOxldGXtF0bQQCjBbmNq59qjdezWDRqBunKhdkCo4T1aBoC2Gn+R5JysejbRakfea3OqrnR5VRYyPIH8I3HEl7yY2HuRqV9cX3587TKJap3dCcbqNcZwWGjdeXOfYrybkGtgCT0mHt7/iwZevyxr/NcEbOu4Xc=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:02:58 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%6]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:02:58 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>
Subject: RE: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
Thread-Topic: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
 disable_kq=1
Thread-Index: AQHblCYZBGGRR/xjRk+q5dM8slx6zrN6LWPQ
Date: Wed, 19 Mar 2025 09:02:58 +0000
Message-ID: <DS7PR12MB600516A56433E841BA20BD3AFBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-7-alexander.deucher@amd.com>
In-Reply-To: <20250313144136.1117072-7-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f9b01a2b-089e-41c6-8c31-3f77675881b6;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-19T08:42:45Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH1PR12MB9623:EE_
x-ms-office365-filtering-correlation-id: d8078f9d-9d2a-4993-8f3c-08dd66c4d822
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bGd8roym9R/sF0jhS1DPqb2PEf2v95bzgAn4NpdY49i/VIaww/DxbKioJ4Xm?=
 =?us-ascii?Q?orGyNMFlReptRLPqCIi6za6upJFw5EbaZCx1avlBXVlAnQZHwhXhQ9TuHgaD?=
 =?us-ascii?Q?HMPCsNyvhk1xzlnT2hxZvJ3DQihqUd60Jv1tLrgCXXIrupBHCXkiPewwLlDE?=
 =?us-ascii?Q?UK4HJ59V5pFXQ3DppktkqaGM8vNynBcZjATtCbK+DohjQVdPiXpLvSLf51fO?=
 =?us-ascii?Q?gYT1J6L2OFfI3/Yl79kDZiJjSlwS+Vz1nvJi+C+PetPyUdi23euy1FZDQ9hJ?=
 =?us-ascii?Q?XsqCwp2NFZKamS97lM4yWQccXB+l4JV87bMJPis0ZZmjZETrH7QE0YgrXEcS?=
 =?us-ascii?Q?kGHiXFk5OkkuxhIQkhHGVBcIPdbnBci5Jc3UYKVY71dkDBufnbM0nOdtbzkp?=
 =?us-ascii?Q?aCvaVAqKi0jPXDXvxPw/Po286Xzy+5qWRUqOFiA3pBgqc1kB1VKj1eJJBbC+?=
 =?us-ascii?Q?DQ5ixZyj7OPg2ozEiA4zaLnjjMY7xyMJEZFAPIYI7l32XjxVv0W06aO6i7Qo?=
 =?us-ascii?Q?3FWSZcP6q4wg7ecdtcphuf9lzMNE4N43SkxGcow700acI4wO/RJmEDhAbZcb?=
 =?us-ascii?Q?jXqj850Z1TDJXWhBA5PXSSaoob+/uWf1VMp8+NhD7+ApMHeoRAd/KZZXGVYe?=
 =?us-ascii?Q?P17cyXBA9J7aiDstlBBQqulli5WncCsVYNGbEt3GG5It6O322gLBsYg7TtWV?=
 =?us-ascii?Q?VBObZqqXWByIYzYMN15dFbrXT25Q+L6dBmC7Us/fGauUgRGhmCRcQb49KQYc?=
 =?us-ascii?Q?r3FTWX3ZDLax9Gn1nIlcfo3FmSqlJa+YKq87Dtd/ZvWMvH43uIAnV2jY9V2F?=
 =?us-ascii?Q?4ULDIzFba8iQ+tV9TGlbhjc9fBmDs2yQNuoQ7TKUDWNLXRLN5FS8TE/mha3M?=
 =?us-ascii?Q?cvHRchaShgm0yffumrvVWekKjFwl2UHWd07xyvEkEPd8/b0A7/D6LkBxxmlv?=
 =?us-ascii?Q?nyuD0O1hc6etMlIRz8GaLTPrVDBcptzEyJyNcjXrWmdRM17vBFDRmfjXSEIF?=
 =?us-ascii?Q?pyj4Ui6qkW9uia5UP8mhLBhtyPd6aRj+QAazTd3LLGOX1laL9rU/ilp1sNx8?=
 =?us-ascii?Q?G4+XCtLBlZJ1K1GPw8E+vcxpWScdjT8vJ7U+BPzFOiVYCKzcleHvvWgU0JC+?=
 =?us-ascii?Q?WBER4cs80zWy+fs3mrKcr2Fta7at9/YBZWNm13h+Tbg5K0YHyTs3HWz5kN45?=
 =?us-ascii?Q?Q6t21kzvt4YdeJHLa8CdUwHRz4hn5rP11R/lcqWAk9bCt310sYpfXW0N5FJ3?=
 =?us-ascii?Q?u6Jr7SOQO9UPnPmo1Ra7B+izZl2zThv1yBeRMAINoh+mwONI6oeukbQ3hJoT?=
 =?us-ascii?Q?/Lp4o3rvSrrUVlixA6fwK6QchosLn+bU0iJCuisv+qwP7MJTXPs1u4sv++qk?=
 =?us-ascii?Q?SdGtLLKKa32XWy0TNrVPbTOizGA2pxnCLZ7/IAO2EJRvhtzd0J2KfWO4OMEY?=
 =?us-ascii?Q?ypgrcQo1BFownLXc24ZA+Km0V1sSaLtF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lRHd2mTDwQjqXF+W4nypkU+S/mcXorx88FPJcRbbyGnGawWFqQLB8BNU4oU7?=
 =?us-ascii?Q?irepxv5tzpZMjUdALGcBxmXsdPxC+4JhB43oe4jDALOYwboGzxKhHLCtV+l6?=
 =?us-ascii?Q?rPo8zHLaIuxBQvctZqEM7xI+fKaSHgshamnRoxWDpjK5vSWlakrg0TA06mXX?=
 =?us-ascii?Q?C/HY4Qa9ZkTQ5Xbb63hpNcPL8+B9Q0K1Kp5VjyeXrzydEZ+8ND9suQJ0L//g?=
 =?us-ascii?Q?sUQyKQ7kxfJyPlCxECTiZRh0WGuiokSfRGtx4psCiCx8UrJ0RTZVMhQIf4Ry?=
 =?us-ascii?Q?yD+UlemmZkeMoEt6SafCGgS5bopO29awiURxVVjHvempP7l3RUigc1/T5UGQ?=
 =?us-ascii?Q?WrWUjU29mYZZAb9R8shVYSdj6c95u9zmFWqBzGHROyxYHOOJzkoR1GY5RGAX?=
 =?us-ascii?Q?CWtcNKtXjo9yQ/sq9JxppJiGathq4Y1UE7CDQCKBGZ9hRlK4bYWn66a7Y/JC?=
 =?us-ascii?Q?rqz/pF9KLxxq5LSbiBUMKr7ndqv0GNLdt2OMff18JO+mUCWUqXYFtXDxWEX/?=
 =?us-ascii?Q?T3VrR5leuFX8oyEHdhZ4Ih0mc6weCcIE1V53dU+EnqQ9YzTDlYBL8PCt9bsF?=
 =?us-ascii?Q?y8zLz1N0d7M0rPiGuYcju+jEwlCkPIcCyxPyNho4iNgymAMhjy49bc/YOHoV?=
 =?us-ascii?Q?Rhj47RrI7mmxCZbcCyNjm2AIu6DKPZId1EhMnUjBsuCXDQSnH8jUAYKef5QL?=
 =?us-ascii?Q?1kOgxxZWJ/SslDZowAKVdSVAZNqzRLXdWWA/hEB4O1GJ3LKYBcx9Ss2DTWWi?=
 =?us-ascii?Q?YStfsMz/wV3PmS0dPNBnYpvriGuHZffwd1VDXlQy1XRd03Q/5Nvt1Ick4UE7?=
 =?us-ascii?Q?0hlt4nZZIxoDctVi94GI0qEkrKud89qI/BQgEqGU4DSwPPNJbsr9QqHPrhAa?=
 =?us-ascii?Q?VWhzh2zbRuTapmrwUXUb+D6V5Gp9H6Bet7LjJ4zIFGwHGfD8RbHQYIW1Ullf?=
 =?us-ascii?Q?w0RzdpkimH1KxVGLnuZ6xls5ke6wrLhPATmIIievqjR84DClU+sRtfIAassS?=
 =?us-ascii?Q?b+KY4VHrqRlNZBhdaHpVOpGbeK6umBURLG0b3A4d6JsYNL7t+dXaPCu/civg?=
 =?us-ascii?Q?HjB9vZq9bLMLqtVSCIQ9XfYJASMaXNNwY5vuQ/ctM8zB0Vy9bWpVAGNUZxFt?=
 =?us-ascii?Q?Efp1ZvQwjauuIbXvRYijaysNxCjM4/ZyA9WOnP5taDOX0/Q2qk1sdEC4cPxE?=
 =?us-ascii?Q?DVBEjSDL6Ob+rKjUbFcObAzQXpeRdUIIDDNVzE4qZhNL9gIhIQmlQyOFGL4W?=
 =?us-ascii?Q?kcU1lqpKa5aStZG7t1KVHJzZ2XVKQOzIRpqzhQpFjcuJ2QC/UDSqSN7ZrHO1?=
 =?us-ascii?Q?+XadoaLgG0gqV+3wSAImCmm67w8kHDt00r2+3cz2upjnRnQbX6aDMtLLv9rh?=
 =?us-ascii?Q?cQRZl1lZZxwi+YMiTnuGh1XzlJpXjowXwyIrSXn0U5+gyueysYcA3YpeZkhp?=
 =?us-ascii?Q?FdRWyMCfIfPG7bJ4SOfRqNAzPejZviuL810LgzMkAyGuE8UHxzWkx4KhjgCe?=
 =?us-ascii?Q?tUY05q/3SUuQubv70SQt8rUOYnkvGQkZn1uI1fzBsldeFcrLhDYjsFHtFv28?=
 =?us-ascii?Q?H2WOobT+m33FNjsvnyE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8078f9d-9d2a-4993-8f3c-08dd66c4d822
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 09:02:58.1859 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FnncICNGon/rihZdO3ifIpnYXcE0f3zekmK4bVTuTerQmcpiOuJrveiphNbmk/Qp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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

> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 13, 2025 10:42 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>
> Subject: [PATCH 06/11] drm/amdgpu/mes: make more vmids available when
> disable_kq=3D1
>
> If we don't have kernel queues, the vmids can be used by the MES for user
> queues.
>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 2 +-
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
> drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 971bf01fe46a9..a536a78342a09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -106,7 +106,7 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>
>       adev->mes.total_max_queue =3D
> AMDGPU_FENCE_MES_QUEUE_ID_MASK;
>       adev->mes.vmid_mask_mmhub =3D 0xffffff00;
> -     adev->mes.vmid_mask_gfxhub =3D 0xffffff00;
> +     adev->mes.vmid_mask_gfxhub =3D adev->gfx.disable_kq ? 0xfffffffe :
> +0xffffff00;
>
Question: Why here only set some of the GCHUB VMID to validate? Is that VMI=
D reserved for other specific usage?  While it seems vmid_mask_mmhub is not=
 further used in the MES FW?

Anway this patch is: Acked-by: Prike Liang <Prike.Liang@amd.com>


>       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
>               /* use only 1st ME pipe */
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 95d894a231fcf..19a5f196829f3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -900,7 +900,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>        * amdgpu graphics/compute will use VMIDs 1-7
>        * amdkfd will use VMIDs 8-15
>        */
> -     adev->vm_manager.first_kfd_vmid =3D 8;
> +     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_kq ? 1 : 8;
>
>       amdgpu_vm_manager_init(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> index bf8d01da88154..a2f6c9f4ebf2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> @@ -838,7 +838,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>        * amdgpu graphics/compute will use VMIDs 1-7
>        * amdkfd will use VMIDs 8-15
>        */
> -     adev->vm_manager.first_kfd_vmid =3D 8;
> +     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_kq ? 1 : 8;
>
>       amdgpu_vm_manager_init(adev);
>
> --
> 2.48.1

