Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6FEC4706C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jan 2024 18:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E9410EB5D;
	Fri, 12 Jan 2024 18:46:51 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2407::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0CD610EB5D
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jan 2024 18:46:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5v7eNbDViUFT+X8HVrQyywXOryRfH4lN0P8IV+MnrXffyuCVtbo0FScWzymmoQy32x92keeUDQAjiUj9NQwZXWQcQq31O+EjlEfkafH152z0LglQVYxKwmo+FsVYciyM8x//VL1vC8BnFQlN88P5IsE53kZLDgomL/XTwavjMHn3qKk+Y2/fV2uXfX4ajshqVbETjWX5kkdUZOt/nDAThIfMcP/p4m94DKv5fKsoOvK6xaqt3frQnT/IYHGS3+7Jui4hd8axw7tbHf1ywJ1x2lQGLGtKSQ5sFRGw6CM21DyMISq94xw2v9JISBENmryIgrBlM6wPo3XHf1VSPgqag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z10eqNuVRd/7mpb9OY+Skz2/hB4qf8j2MVH5mDmx7kE=;
 b=b+WAaKq+qT3iSSZkvLRK5XwqQxJY5OD1cF6jIu+u5KJJMrA3koEtCAwXm1UWL6ZIFwaqYiV5HUqIj4H7OVZE9wxVcRbzMLUG2cDoAYykrMe2P3wH2lknJB1wymqFsznjvRc+/ioNqsbwSDBp4ZehNNLJ1SZqGetcA+BZCDWMAbHXpg3Iz0IZ/FvWphHzfQ35FNE4Tl/VujvTr9qgfYZnFNJiEiy9gxGPVJTWGEKjwZohLif8gd3QMaOmpTkOtQOi3318wxfVEGA++QbOYuc86+RtK/MLtXjl/zdIp/BmdSOBVoR0TqaIhTdLdA+BeldQ2EXUSLphWeQiOL56EitWog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z10eqNuVRd/7mpb9OY+Skz2/hB4qf8j2MVH5mDmx7kE=;
 b=Z34Nu8PI6DdKE+X8u5CTyM+PRc79RuzM4dmjmxObuYsw8DVbnMHRzupW02gV1X3u8mAR2oKuGpcx6EHx5C+v/Y0v7Q13Yf6CXTLR9GWSZZ/pKXnFbbUUGgl3IjW5x1k80PcSKb1F90a4CC+Si0MzveG756c5yV9d2uy0GXti2sQ=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SN7PR12MB6692.namprd12.prod.outlook.com (2603:10b6:806:270::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 18:46:42 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a952:d50:fdc8:fc95%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 18:46:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Alexander <electrodeyt@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: check PS, WS index
Thread-Topic: [PATCH 1/2] drm/amdgpu: check PS, WS index
Thread-Index: AQHaRKCZmZwj3T0yv0OVYDhjMT/A0rDWhgKg
Date: Fri, 12 Jan 2024 18:46:42 +0000
Message-ID: <BL1PR12MB5144B8A007BFFFCEC9C08491F76F2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240111150516.743276-1-electrodeyt@gmail.com>
 <20240111150516.743276-2-electrodeyt@gmail.com>
In-Reply-To: <20240111150516.743276-2-electrodeyt@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=618a63de-38e0-4d69-951b-7e3ee3d2087f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-01-12T18:46:24Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SN7PR12MB6692:EE_
x-ms-office365-filtering-correlation-id: ebb6f1f2-daaa-4ff0-d24c-08dc139ed19f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDnqEsfYblYelri6wE7G851w4UPFko6FUfuUoJcUir1zgYTW0RiEdeVVlAqJb6rdq2MqQtlY+ffMI/lXCqmqCkofyWMydEzeBlkGwayeG2R6S59LMXbbZ7toQ/YNbA3GJipguixYXP+K/OFXzjmjC+OReQ6HsuC5/OyZ+LHCqjWMJ5SE29NkA/83e8JnWX01cv9xui4b2lYLDf/+s5b1Mr3tLdjK5HRVUh6W8r8w6FA+4ysD6Og3cmxEViic0o4cmqx+t0sRMcYahnT7Xprtu9G+2P+woL0nkYxTydKQ0RKyyowj8Czp463MMmcpJspmBwhLNQ6BJn7iWoMFeOGyMGSVWm36REZS7jqi5TPyhopJb7h4EcjvlCw9Fr2YPMEw6TKXtmdQoYzUip3GG0R3puungSOh56mPbPxKB30B73SJUi6VwvG7E7zZuiDvJ/mykTz2zXLZqZlsnH69QhyfXytn0M9RxjgK6k8SlNd9xzrMJbhYOzZTCGhg8w9W9It35Bd8iM2UiovxUiKH2z+Mj2v6cgl3TlheYMEWopH7Diaohq0jzEkhpttMLiqxiu2/qpxcgeP+lj4ws6tg2uedoHsmkxNc4Z+SEcKL7ztrHQ7OqosT/p1olv/MtvvNOrsxCu/wcXHnrkmty+AzOHZoPSpGhyTZJ2TYE/SnDX4DUkw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(38070700009)(26005)(83380400001)(478600001)(53546011)(9686003)(6506007)(71200400001)(7696005)(33656002)(86362001)(55016003)(122000001)(38100700002)(5660300002)(30864003)(52536014)(2906002)(66946007)(66446008)(66556008)(64756008)(76116006)(66476007)(19627235002)(316002)(8676002)(110136005)(8936002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?99r9+lNEAnmrKxJQY0yelP23eL6PuC2m5bK3N02D+hkWZLdA+LyCtP+Ja9lP?=
 =?us-ascii?Q?pk/8UlqXPdRHj+BS5Vdhoayy+SuJB2FDZNdder1pHJkyTnQb6k8HJwjo+JxW?=
 =?us-ascii?Q?8wEEdHe7BZZXZu1Lzr82IEhDN2Ot8TgJAUNxvZp3ZRrHZvi4qrL2m4U6jLXv?=
 =?us-ascii?Q?CtUx3WF20oB/rsN6BunPvHtHXwvPHd0ZlqvNfOhIN9eqpXA1z6lLHJ/AYsg7?=
 =?us-ascii?Q?X7VdwIj//fz47gKki4tNi2M6wNJ2XBqFvyPbDyNskX4LN5QwX9Da+3cgDcCH?=
 =?us-ascii?Q?Bw94ReW/Kz52rEfLv8tBq56NFLdADNedh1bUvSfJmLVGD183f3lBJDNKotlU?=
 =?us-ascii?Q?Ri46qcxMJhsMJUBJ4wOo/4rad0a+1sAKBK68gxpsVzQ9XKHcPYXfLRDBxur7?=
 =?us-ascii?Q?U61u7VI6jW+dQ6/thi4ahpQL90MDv1q/08VmuVZSPW5rstQ7D+6MNv6fX8Vl?=
 =?us-ascii?Q?5QqCirwWPmr5EDTy4Dn9aMEV3hsh5wM+VwB9fxrXki1k+v88iOUYHAkmcbu8?=
 =?us-ascii?Q?QvGrbb+VNJFNtF00TeXN831qcGZ/oDWgxav/4m765ZmZ5ZzzG2haUWw58fFA?=
 =?us-ascii?Q?0dXA4F+llXyL6w2gheYfrl8FLqhyC+6Z3zGXp5zrq+VLmcxrmvuTx4nzmMkF?=
 =?us-ascii?Q?ycjf+klw1HDR4r1uXMrnwOlNEPEdmM4/760q+8pEbbQ5fKYTi0WR28TbZXWg?=
 =?us-ascii?Q?ulYOdpp6PeaYCN6Z7e1XF+sviLZmgQSsk22oyJEITyJ9XEDuCTMMxaN2G7II?=
 =?us-ascii?Q?b+qC+ZCpW85WiKctvP2r6tdzfq9Zah98hHgbhkeoRWQopreNI2mBNrFsI7Iy?=
 =?us-ascii?Q?XnHBkouU8Cy3dgc5BnVGMvQ6qVD6JMuuC9gC7Db7KEQqRHuhSmKpfnFXuRnS?=
 =?us-ascii?Q?yziY/8eC8bYE+/G3Yh7Z6ArO79MMg8VHbksoptNf1f//C+1VKIK1KDz6u6ZN?=
 =?us-ascii?Q?oJwXaUywdRDIU93fb+rWbr+2aZXcNfPwWcJexAFV4CYRetOndK+WU7l10hUB?=
 =?us-ascii?Q?dCwQO9rul88Nh4FepD0QJvoCGIO/ftm8+X7dc69A/yGN1Wyvk7FJ+2yNC2l3?=
 =?us-ascii?Q?RpSPKWwE0VMThj+HwWLLzirreEWGY+UP+aBnNdVsPAJmBJfTHYVN5DHtoyU7?=
 =?us-ascii?Q?JYFfdQQ3WipuTk65m89Ni81SzwMuR1f/5FZHo3WzMoge0LrNIr552z7Yufd7?=
 =?us-ascii?Q?zyBceWKTEYzRbHet5K1CLHACYrXBEae6ZeRNZWPWwfUfMKnIJSh301s7ODKu?=
 =?us-ascii?Q?OmH8gaHGijB7AQTy8gq+fdWoXUqQ0TqqnnofKtmSjzPDNyuRLetmW0PrMqPC?=
 =?us-ascii?Q?D5IcVKRJOMW0YaR+Cjn10RSzLBMWKNsqnfAX5vPi68Uuw4UKFUfJrDB4d5nA?=
 =?us-ascii?Q?V90EfggzSVOK5TXK9oqH233NMtx5zQ5Xa4hgIudmiuOKfxaLnuW3l6DLUoQO?=
 =?us-ascii?Q?Wg4J3VwZzqgDu9IIkmxWI7ooFFfWIUDYsrb0TfvhyPiRDnZ8/71IDZyQ6mCt?=
 =?us-ascii?Q?htHia64Zl+6WG1LK9SMTi6DZ3vHWqvzFepkyx23tVScPo5fEGpawtXd/7B4s?=
 =?us-ascii?Q?epFYIYi+cIVLZe/V6R0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb6f1f2-daaa-4ff0-d24c-08dc139ed19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 18:46:42.2278 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v/6Ny70oRGTt4zn8z9ky3JvNDubStagUTFhL8PZRudFTJ8bO84xlBKsymyi9VlMvuDksp/xz/w0iz4BS3gx/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6692
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Alexander
> Sent: Thursday, January 11, 2024 10:05 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Alexander Richards <electrodeyt@gmail.com>
> Subject: [PATCH 1/2] drm/amdgpu: check PS, WS index
>
> From: Alexander Richards <electrodeyt@gmail.com>
>
> Theoretically, it would be possible for a buggy or malicious VBIOS to ove=
rwrite
> past the bounds of the passed parameters (or its own workspace); add
> bounds checking to prevent this from happening.
>
> Signed-off-by: Alexander Richards <electrodeyt@gmail.com>

Applied the series.  Thanks!


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c  | 24 +++++++----
> .../gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c  |  3 +-
>  drivers/gpu/drm/amd/amdgpu/atom.c             | 41 +++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/atom.h             |  2 +-
>  drivers/gpu/drm/amd/amdgpu/atombios_crtc.c    | 28 ++++++-------
>  drivers/gpu/drm/amd/amdgpu/atombios_dp.c      |  4 +-
>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 16 +++----
>  drivers/gpu/drm/amd/amdgpu/atombios_i2c.c     |  4 +-
>  .../drm/amd/display/dc/bios/command_table.c   |  2 +-
>  .../drm/amd/display/dc/bios/command_table2.c  |  2 +-
>  .../drm/amd/pm/powerplay/hwmgr/ppatomctrl.c   | 42 +++++++++----------
>  .../drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c |  4 +-
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 +-
>  .../gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c    |  2 +-
>  14 files changed, 102 insertions(+), 74 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> index dce9e7d5e..52b12c171 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> @@ -1018,7 +1018,8 @@ int amdgpu_atombios_get_clock_dividers(struct
> amdgpu_device *adev,
>               if (clock_type =3D=3D COMPUTE_ENGINE_PLL_PARAM) {
>                       args.v3.ulClockParams =3D cpu_to_le32((clock_type <=
<
> 24) | clock);
>
> -                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args,
> +                             sizeof(args));
>
>                       dividers->post_div =3D args.v3.ucPostDiv;
>                       dividers->enable_post_div =3D (args.v3.ucCntlFlag &
> @@ -1038,7 +1039,8 @@ int amdgpu_atombios_get_clock_dividers(struct
> amdgpu_device *adev,
>                       if (strobe_mode)
>                               args.v5.ucInputFlag =3D
> ATOM_PLL_INPUT_FLAG_PLL_STROBE_MODE_EN;
>
> -                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args,
> +                             sizeof(args));
>
>                       dividers->post_div =3D args.v5.ucPostDiv;
>                       dividers->enable_post_div =3D (args.v5.ucCntlFlag &
> @@ -1056,7 +1058,8 @@ int amdgpu_atombios_get_clock_dividers(struct
> amdgpu_device *adev,
>               /* fusion */
>               args.v4.ulClock =3D cpu_to_le32(clock);   /* 10 khz */
>
> -             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args,
> +                     sizeof(args));
>
>               dividers->post_divider =3D dividers->post_div =3D
> args.v4.ucPostDiv;
>               dividers->real_clock =3D le32_to_cpu(args.v4.ulClock); @@ -
> 1067,7 +1070,8 @@ int amdgpu_atombios_get_clock_dividers(struct
> amdgpu_device *adev,
>               args.v6_in.ulClock.ulComputeClockFlag =3D clock_type;
>               args.v6_in.ulClock.ulClockFreq =3D cpu_to_le32(clock);    /=
* 10
> khz */
>
> -             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args,
> +                     sizeof(args));
>
>               dividers->whole_fb_div =3D
> le16_to_cpu(args.v6_out.ulFbDiv.usFbDiv);
>               dividers->frac_fb_div =3D
> le16_to_cpu(args.v6_out.ulFbDiv.usFbDivFrac);
> @@ -1109,7 +1113,8 @@ int
> amdgpu_atombios_get_memory_pll_dividers(struct amdgpu_device *adev,
>                       if (strobe_mode)
>                               args.ucInputFlag |=3D
> MPLL_INPUT_FLAG_STROBE_MODE_EN;
>
> -                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args,
> +                             sizeof(args));
>
>                       mpll_param->clkfrac =3D
> le16_to_cpu(args.ulFbDiv.usFbDivFrac);
>                       mpll_param->clkf =3D
> le16_to_cpu(args.ulFbDiv.usFbDiv);
> @@ -1151,7 +1156,8 @@ void
> amdgpu_atombios_set_engine_dram_timings(struct amdgpu_device *adev,
>       if (mem_clock)
>               args.sReserved.ulClock =3D cpu_to_le32(mem_clock &
> SET_CLOCK_FREQ_MASK);
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args,
> +             sizeof(args));
>  }
>
>  void amdgpu_atombios_get_default_voltages(struct amdgpu_device *adev,
> @@ -1205,7 +1211,8 @@ int amdgpu_atombios_get_max_vddc(struct
> amdgpu_device *adev, u8 voltage_type,
>               args.v2.ucVoltageMode =3D 0;
>               args.v2.usVoltageLevel =3D 0;
>
> -             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args,
> +                     sizeof(args));
>
>               *voltage =3D le16_to_cpu(args.v2.usVoltageLevel);
>               break;
> @@ -1214,7 +1221,8 @@ int amdgpu_atombios_get_max_vddc(struct
> amdgpu_device *adev, u8 voltage_type,
>               args.v3.ucVoltageMode =3D ATOM_GET_VOLTAGE_LEVEL;
>               args.v3.usVoltageLevel =3D cpu_to_le16(voltage_id);
>
> -             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args,
> +                     sizeof(args));
>
>               *voltage =3D le16_to_cpu(args.v3.usVoltageLevel);
>               break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index fb2681dd6..6857c586d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -941,5 +941,6 @@ int amdgpu_atomfirmware_asic_init(struct
> amdgpu_device *adev, bool fb_reset)
>               return -EINVAL;
>       }
>
> -     return amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, (uint32_t
> *)&asic_init_ps_v2_1);
> +     return amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, (uint32_t
> *)&asic_init_ps_v2_1,
> +             sizeof(asic_init_ps_v2_1));
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c
> b/drivers/gpu/drm/amd/amdgpu/atom.c
> index 2c2210007..86324a180 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.c
> @@ -62,6 +62,7 @@
>  typedef struct {
>       struct atom_context *ctx;
>       uint32_t *ps, *ws;
> +     int ps_size, ws_size;
>       int ps_shift;
>       uint16_t start;
>       unsigned last_jump;
> @@ -70,8 +71,8 @@ typedef struct {
>  } atom_exec_context;
>
>  int amdgpu_atom_debug;
> -static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, in=
t
> index, uint32_t *params); -int amdgpu_atom_execute_table(struct
> atom_context *ctx, int index, uint32_t *params);
> +static int amdgpu_atom_execute_table_locked(struct atom_context *ctx,
> +int index, uint32_t *params, int params_size); int
> +amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t
> +*params, int params_size);
>
>  static uint32_t atom_arg_mask[8] =3D
>       { 0xFFFFFFFF, 0xFFFF, 0xFFFF00, 0xFFFF0000, 0xFF, 0xFF00,
> 0xFF0000, @@ -223,7 +224,10 @@ static uint32_t
> atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
>               (*ptr)++;
>               /* get_unaligned_le32 avoids unaligned accesses from
> atombios
>                * tables, noticed on a DEC Alpha. */
> -             val =3D get_unaligned_le32((u32 *)&ctx->ps[idx]);
> +             if (idx < ctx->ps_size)
> +                     val =3D get_unaligned_le32((u32 *)&ctx->ps[idx]);
> +             else
> +                     pr_info("PS index out of range: %i > %i\n", idx, ct=
x-
> >ps_size);
>               if (print)
>                       DEBUG("PS[0x%02X,0x%04X]", idx, val);
>               break;
> @@ -261,7 +265,10 @@ static uint32_t
> atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
>                       val =3D gctx->reg_block;
>                       break;
>               default:
> -                     val =3D ctx->ws[idx];
> +                     if (idx < ctx->ws_size)
> +                             val =3D ctx->ws[idx];
> +                     else
> +                             pr_info("WS index out of range: %i > %i\n",
> idx, ctx->ws_size);
>               }
>               break;
>       case ATOM_ARG_ID:
> @@ -496,6 +503,10 @@ static void atom_put_dst(atom_exec_context *ctx,
> int arg, uint8_t attr,
>               idx =3D U8(*ptr);
>               (*ptr)++;
>               DEBUG("PS[0x%02X]", idx);
> +             if (idx >=3D ctx->ps_size) {
> +                     pr_info("PS index out of range: %i > %i\n", idx, ct=
x-
> >ps_size);
> +                     return;
> +             }
>               ctx->ps[idx] =3D cpu_to_le32(val);
>               break;
>       case ATOM_ARG_WS:
> @@ -528,6 +539,10 @@ static void atom_put_dst(atom_exec_context *ctx,
> int arg, uint8_t attr,
>                       gctx->reg_block =3D val;
>                       break;
>               default:
> +                     if (idx >=3D ctx->ws_size) {
> +                             pr_info("WS index out of range: %i > %i\n",
> idx, ctx->ws_size);
> +                             return;
> +                     }
>                       ctx->ws[idx] =3D val;
>               }
>               break;
> @@ -625,7 +640,7 @@ static void atom_op_calltable(atom_exec_context
> *ctx, int *ptr, int arg)
>       else
>               SDEBUG("   table: %d\n", idx);
>       if (U16(ctx->ctx->cmd_table + 4 + 2 * idx))
> -             r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->=
ps
> + ctx->ps_shift);
> +             r =3D amdgpu_atom_execute_table_locked(ctx->ctx, idx, ctx->=
ps
> +
> +ctx->ps_shift, ctx->ps_size - ctx->ps_shift);
>       if (r) {
>               ctx->abort =3D true;
>       }
> @@ -1204,7 +1219,7 @@ static struct {
>       atom_op_div32, ATOM_ARG_WS},
>  };
>
> -static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, in=
t
> index, uint32_t *params)
> +static int amdgpu_atom_execute_table_locked(struct atom_context *ctx,
> +int index, uint32_t *params, int params_size)
>  {
>       int base =3D CU16(ctx->cmd_table + 4 + 2 * index);
>       int len, ws, ps, ptr;
> @@ -1226,12 +1241,16 @@ static int
> amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
>       ectx.ps_shift =3D ps / 4;
>       ectx.start =3D base;
>       ectx.ps =3D params;
> +     ectx.ps_size =3D params_size;
>       ectx.abort =3D false;
>       ectx.last_jump =3D 0;
> -     if (ws)
> +     if (ws) {
>               ectx.ws =3D kcalloc(4, ws, GFP_KERNEL);
> -     else
> +             ectx.ws_size =3D ws;
> +     } else {
>               ectx.ws =3D NULL;
> +             ectx.ws_size =3D 0;
> +     }
>
>       debug_depth++;
>       while (1) {
> @@ -1265,7 +1284,7 @@ static int
> amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
>       return ret;
>  }
>
> -int amdgpu_atom_execute_table(struct atom_context *ctx, int index,
> uint32_t *params)
> +int amdgpu_atom_execute_table(struct atom_context *ctx, int index,
> +uint32_t *params, int params_size)
>  {
>       int r;
>
> @@ -1281,7 +1300,7 @@ int amdgpu_atom_execute_table(struct
> atom_context *ctx, int index, uint32_t *par
>       /* reset divmul */
>       ctx->divmul[0] =3D 0;
>       ctx->divmul[1] =3D 0;
> -     r =3D amdgpu_atom_execute_table_locked(ctx, index, params);
> +     r =3D amdgpu_atom_execute_table_locked(ctx, index, params,
> params_size);
>       mutex_unlock(&ctx->mutex);
>       return r;
>  }
> @@ -1553,7 +1572,7 @@ int amdgpu_atom_asic_init(struct atom_context
> *ctx)
>
>       if (!CU16(ctx->cmd_table + 4 + 2 * ATOM_CMD_INIT))
>               return 1;
> -     ret =3D amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, ps);
> +     ret =3D amdgpu_atom_execute_table(ctx, ATOM_CMD_INIT, ps, 16);
>       if (ret)
>               return ret;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h
> b/drivers/gpu/drm/amd/amdgpu/atom.h
> index c11cf18a0..b807f6639 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/atom.h
> @@ -156,7 +156,7 @@ struct atom_context {  extern int
> amdgpu_atom_debug;
>
>  struct atom_context *amdgpu_atom_parse(struct card_info *card, void
> *bios); -int amdgpu_atom_execute_table(struct atom_context *ctx, int inde=
x,
> uint32_t *params);
> +int amdgpu_atom_execute_table(struct atom_context *ctx, int index,
> +uint32_t *params, int params_size);
>  int amdgpu_atom_asic_init(struct atom_context *ctx);  void
> amdgpu_atom_destroy(struct atom_context *ctx);  bool
> amdgpu_atom_parse_data_header(struct atom_context *ctx, int index,
> uint16_t *size, diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> index 10098fdd3..3dfc28840 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> @@ -77,7 +77,7 @@ void amdgpu_atombios_crtc_overscan_setup(struct
> drm_crtc *crtc,
>               args.usOverscanTop =3D cpu_to_le16(amdgpu_crtc->v_border);
>               break;
>       }
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  void amdgpu_atombios_crtc_scaler_setup(struct drm_crtc *crtc) @@ -106,7
> +106,7 @@ void amdgpu_atombios_crtc_scaler_setup(struct drm_crtc *crtc)
>               args.ucEnable =3D ATOM_SCALER_DISABLE;
>               break;
>       }
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  void amdgpu_atombios_crtc_lock(struct drm_crtc *crtc, int lock) @@ -123,=
7
> +123,7 @@ void amdgpu_atombios_crtc_lock(struct drm_crtc *crtc, int lock)
>       args.ucCRTC =3D amdgpu_crtc->crtc_id;
>       args.ucEnable =3D lock;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  void amdgpu_atombios_crtc_enable(struct drm_crtc *crtc, int state) @@ -
> 139,7 +139,7 @@ void amdgpu_atombios_crtc_enable(struct drm_crtc *crtc,
> int state)
>       args.ucCRTC =3D amdgpu_crtc->crtc_id;
>       args.ucEnable =3D state;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  void amdgpu_atombios_crtc_blank(struct drm_crtc *crtc, int state) @@ -
> 155,7 +155,7 @@ void amdgpu_atombios_crtc_blank(struct drm_crtc *crtc,
> int state)
>       args.ucCRTC =3D amdgpu_crtc->crtc_id;
>       args.ucBlanking =3D state;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  void amdgpu_atombios_crtc_powergate(struct drm_crtc *crtc, int state) @@
> -171,7 +171,7 @@ void amdgpu_atombios_crtc_powergate(struct drm_crtc
> *crtc, int state)
>       args.ucDispPipeId =3D amdgpu_crtc->crtc_id;
>       args.ucEnable =3D state;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  void amdgpu_atombios_crtc_powergate_init(struct amdgpu_device *adev)
> @@ -183,7 +183,7 @@ void amdgpu_atombios_crtc_powergate_init(struct
> amdgpu_device *adev)
>
>       args.ucEnable =3D ATOM_INIT;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  void amdgpu_atombios_crtc_set_dtd_timing(struct drm_crtc *crtc, @@ -
> 228,7 +228,7 @@ void amdgpu_atombios_crtc_set_dtd_timing(struct
> drm_crtc *crtc,
>       args.susModeMiscInfo.usAccess =3D cpu_to_le16(misc);
>       args.ucCRTC =3D amdgpu_crtc->crtc_id;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  union atom_enable_ss {
> @@ -293,7 +293,7 @@ static void
> amdgpu_atombios_crtc_program_ss(struct amdgpu_device *adev,
>       args.v3.usSpreadSpectrumStep =3D cpu_to_le16(ss->step);
>       args.v3.ucEnable =3D enable;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  union adjust_pixel_clock {
> @@ -395,7 +395,7 @@ static u32 amdgpu_atombios_crtc_adjust_pll(struct
> drm_crtc *crtc,
>
>       ADJUST_DISPLAY_CONFIG_SS_ENABLE;
>
>                       amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
> -                                        index, (uint32_t *)&args);
> +                                        index, (uint32_t *)&args,
> sizeof(args));
>                       adjusted_clock =3D le16_to_cpu(args.v1.usPixelClock=
) *
> 10;
>                       break;
>               case 3:
> @@ -428,7 +428,7 @@ static u32 amdgpu_atombios_crtc_adjust_pll(struct
> drm_crtc *crtc,
>                               args.v3.sInput.ucExtTransmitterID =3D 0;
>
>                       amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
> -                                        index, (uint32_t *)&args);
> +                                        index, (uint32_t *)&args,
> sizeof(args));
>                       adjusted_clock =3D
> le32_to_cpu(args.v3.sOutput.ulDispPllFreq) * 10;
>                       if (args.v3.sOutput.ucRefDiv) {
>                               amdgpu_crtc->pll_flags |=3D
> AMDGPU_PLL_USE_FRAC_FB_DIV; @@ -514,7 +514,7 @@ void
> amdgpu_atombios_crtc_set_disp_eng_pll(struct amdgpu_device *adev,
>               DRM_ERROR("Unknown table version %d %d\n", frev, crev);
>               return;
>       }
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  union set_dce_clock {
> @@ -544,7 +544,7 @@ u32 amdgpu_atombios_crtc_set_dce_clock(struct
> amdgpu_device *adev,
>                       args.v2_1.asParam.ulDCEClkFreq =3D cpu_to_le32(freq=
);
> /* 10kHz units */
>                       args.v2_1.asParam.ucDCEClkType =3D clk_type;
>                       args.v2_1.asParam.ucDCEClkSrc =3D clk_src;
> -                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +                     amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>                       ret_freq =3D
> le32_to_cpu(args.v2_1.asParam.ulDCEClkFreq) * 10;
>                       break;
>               default:
> @@ -740,7 +740,7 @@ void amdgpu_atombios_crtc_program_pll(struct
> drm_crtc *crtc,
>               return;
>       }
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  int amdgpu_atombios_crtc_prepare_pll(struct drm_crtc *crtc, diff --git
> a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
> b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
> index 87c41e0e9..622634c08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_dp.c
> @@ -83,7 +83,7 @@ static int amdgpu_atombios_dp_process_aux_ch(struct
> amdgpu_i2c_chan *chan,
>       args.v2.ucDelay =3D delay / 10;
>       args.v2.ucHPD_ID =3D chan->rec.hpd;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>
>       *ack =3D args.v2.ucReplyStatus;
>
> @@ -301,7 +301,7 @@ static u8
> amdgpu_atombios_dp_encoder_service(struct amdgpu_device *adev,
>       args.ucLaneNum =3D lane_num;
>       args.ucStatus =3D 0;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>       return args.ucStatus;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> index 3ee219aa2..352eed114 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
> @@ -334,7 +334,7 @@ amdgpu_atombios_encoder_setup_dac(struct
> drm_encoder *encoder, int action)
>       args.ucDacStandard =3D ATOM_DAC1_PS2;
>       args.usPixelClock =3D cpu_to_le16(amdgpu_encoder->pixel_clock / 10)=
;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>
>  }
>
> @@ -431,7 +431,7 @@ amdgpu_atombios_encoder_setup_dvo(struct
> drm_encoder *encoder, int action)
>               break;
>       }
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  int amdgpu_atombios_encoder_get_encoder_mode(struct drm_encoder
> *encoder) @@ -731,7 +731,7 @@
> amdgpu_atombios_encoder_setup_dig_encoder(struct drm_encoder
> *encoder,
>               break;
>       }
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>
>  }
>
> @@ -1135,7 +1135,7 @@
> amdgpu_atombios_encoder_setup_dig_transmitter(struct drm_encoder
> *encoder, int a
>               break;
>       }
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  bool
> @@ -1163,7 +1163,7 @@
> amdgpu_atombios_encoder_set_edp_panel_power(struct drm_connector
> *connector,
>
>       args.v1.ucAction =3D action;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>
>       /* wait for the panel to power up */
>       if (action =3D=3D ATOM_TRANSMITTER_ACTION_POWER_ON) { @@ -
> 1287,7 +1287,7 @@
> amdgpu_atombios_encoder_setup_external_encoder(struct drm_encoder
> *encoder,
>               DRM_ERROR("Unknown table version: %d, %d\n", frev, crev);
>               return;
>       }
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  static void
> @@ -1632,7 +1632,7 @@
> amdgpu_atombios_encoder_set_crtc_source(struct drm_encoder *encoder)
>               return;
>       }
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
>
>  /* This only needs to be called once at startup */ @@ -1705,7 +1705,7 @@
> amdgpu_atombios_encoder_dac_load_detect(struct drm_encoder *encoder,
>                               args.sDacload.ucMisc =3D
> DAC_LOAD_MISC_YPrPb;
>               }
>
> -             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index, (uint32_t *)&args);
> +             amdgpu_atom_execute_table(adev-
> >mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>
>               return true;
>       } else
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> index af0335535..a65011143 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_i2c.c
> @@ -86,7 +86,7 @@ static int amdgpu_atombios_i2c_process_i2c_ch(struct
> amdgpu_i2c_chan *chan,
>       args.ucSlaveAddr =3D slave_addr << 1;
>       args.ucLineNumber =3D chan->rec.i2c_id;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>
>       /* error */
>       if (args.ucStatus !=3D HW_ASSISTED_I2C_STATUS_SUCCESS) { @@ -
> 172,5 +172,5 @@ void amdgpu_atombios_i2c_channel_trans(struct
> amdgpu_device *adev, u8 slave_addr
>       args.ucSlaveAddr =3D slave_addr;
>       args.ucLineNumber =3D line_number;
>
> -     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> (uint32_t *)&args);
> +     amdgpu_atom_execute_table(adev->mode_info.atom_context, index,
> +(uint32_t *)&args, sizeof(args));
>  }
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> index 818a529ca..86f9198e7 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -37,7 +37,7 @@
>  #define EXEC_BIOS_CMD_TABLE(command, params)\
>       (amdgpu_atom_execute_table(((struct amdgpu_device *)bp-
> >base.ctx->driver_context)->mode_info.atom_context, \
>               GetIndexIntoMasterTable(COMMAND, command), \
> -             (uint32_t *)&params) =3D=3D 0)
> +             (uint32_t *)&params, sizeof(params)) =3D=3D 0)
>
>  #define BIOS_CMD_TABLE_REVISION(command, frev, crev)\
>       amdgpu_atom_parse_cmd_header(((struct amdgpu_device *)bp-
> >base.ctx->driver_context)->mode_info.atom_context, \ diff --git
> a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> index 90a02d7bd..2bf407b9b 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
> @@ -49,7 +49,7 @@
>  #define EXEC_BIOS_CMD_TABLE(fname, params)\
>       (amdgpu_atom_execute_table(((struct amdgpu_device *)bp-
> >base.ctx->driver_context)->mode_info.atom_context, \
>               GET_INDEX_INTO_MASTER_TABLE(command, fname), \
> -             (uint32_t *)&params) =3D=3D 0)
> +             (uint32_t *)&params, sizeof(params)) =3D=3D 0)
>
>  #define BIOS_CMD_TABLE_REVISION(fname, frev, crev)\
>       amdgpu_atom_parse_cmd_header(((struct amdgpu_device *)bp-
> >base.ctx->driver_context)->mode_info.atom_context, \ diff --git
> a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index f503e61fa..8f5895473 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -226,7 +226,7 @@ int atomctrl_set_engine_dram_timings_rv770(
>
>       return amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> DynamicMemorySettings),
> -                     (uint32_t *)&engine_clock_parameters);
> +                     (uint32_t *)&engine_clock_parameters,
> +sizeof(engine_clock_parameters));
>  }
>
>  /*
> @@ -297,7 +297,7 @@ int atomctrl_get_memory_pll_dividers_si(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                GetIndexIntoMasterTable(COMMAND,
> ComputeMemoryClockParam),
> -             (uint32_t *)&mpll_parameters);
> +             (uint32_t *)&mpll_parameters, sizeof(mpll_parameters));
>
>       if (0 =3D=3D result) {
>               mpll_param->mpll_fb_divider.clk_frac =3D @@ -345,7 +345,7
> @@ int atomctrl_get_memory_pll_dividers_vi(struct pp_hwmgr *hwmgr,
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ComputeMemoryClockParam),
> -                     (uint32_t *)&mpll_parameters);
> +                     (uint32_t *)&mpll_parameters,
> sizeof(mpll_parameters));
>
>       if (!result)
>               mpll_param->mpll_post_divider =3D
> @@ -366,7 +366,7 @@ int atomctrl_get_memory_pll_dividers_ai(struct
> pp_hwmgr *hwmgr,
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ComputeMemoryClockParam),
> -                     (uint32_t *)&mpll_parameters);
> +                     (uint32_t *)&mpll_parameters,
> sizeof(mpll_parameters));
>
>       /* VEGAM's mpll takes sometime to finish computing */
>       udelay(10);
> @@ -396,7 +396,7 @@ int atomctrl_get_engine_pll_dividers_kong(struct
> pp_hwmgr *hwmgr,
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                GetIndexIntoMasterTable(COMMAND,
> ComputeMemoryEnginePLL),
> -             (uint32_t *)&pll_parameters);
> +             (uint32_t *)&pll_parameters, sizeof(pll_parameters));
>
>       if (0 =3D=3D result) {
>               dividers->pll_post_divider =3D pll_parameters.ucPostDiv; @@=
 -
> 420,7 +420,7 @@ int atomctrl_get_engine_pll_dividers_vi(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                GetIndexIntoMasterTable(COMMAND,
> ComputeMemoryEnginePLL),
> -             (uint32_t *)&pll_patameters);
> +             (uint32_t *)&pll_patameters, sizeof(pll_patameters));
>
>       if (0 =3D=3D result) {
>               dividers->pll_post_divider =3D
> @@ -457,7 +457,7 @@ int atomctrl_get_engine_pll_dividers_ai(struct
> pp_hwmgr *hwmgr,
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                GetIndexIntoMasterTable(COMMAND,
> ComputeMemoryEnginePLL),
> -             (uint32_t *)&pll_patameters);
> +             (uint32_t *)&pll_patameters, sizeof(pll_patameters));
>
>       if (0 =3D=3D result) {
>               dividers->usSclk_fcw_frac     =3D
> le16_to_cpu(pll_patameters.usSclk_fcw_frac);
> @@ -490,7 +490,7 @@ int atomctrl_get_dfs_pll_dividers_vi(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                GetIndexIntoMasterTable(COMMAND,
> ComputeMemoryEnginePLL),
> -             (uint32_t *)&pll_patameters);
> +             (uint32_t *)&pll_patameters, sizeof(pll_patameters));
>
>       if (0 =3D=3D result) {
>               dividers->pll_post_divider =3D
> @@ -773,7 +773,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&sOutput_FuseValues);
> +                     (uint32_t *)&sOutput_FuseValues,
> sizeof(sOutput_FuseValues));
>
>       if (result)
>               return result;
> @@ -794,7 +794,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&sOutput_FuseValues);
> +                     (uint32_t *)&sOutput_FuseValues,
> sizeof(sOutput_FuseValues));
>
>       if (result)
>               return result;
> @@ -814,7 +814,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&sOutput_FuseValues);
> +                     (uint32_t *)&sOutput_FuseValues,
> sizeof(sOutput_FuseValues));
>
>       if (result)
>               return result;
> @@ -835,7 +835,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&sOutput_FuseValues);
> +                     (uint32_t *)&sOutput_FuseValues,
> sizeof(sOutput_FuseValues));
>
>       if (result)
>               return result;
> @@ -857,7 +857,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&sOutput_FuseValues);
> +                     (uint32_t *)&sOutput_FuseValues,
> sizeof(sOutput_FuseValues));
>       if (result)
>               return result;
>
> @@ -878,7 +878,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&sOutput_FuseValues);
> +                     (uint32_t *)&sOutput_FuseValues,
> sizeof(sOutput_FuseValues));
>
>       if (result)
>               return result;
> @@ -909,7 +909,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&sOutput_FuseValues);
> +                     (uint32_t *)&sOutput_FuseValues,
> sizeof(sOutput_FuseValues));
>
>       if (result)
>               return result;
> @@ -1134,7 +1134,7 @@ int atomctrl_get_voltage_evv_on_sclk(
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> GetVoltageInfo),
> -                     (uint32_t *)&get_voltage_info_param_space);
> +                     (uint32_t *)&get_voltage_info_param_space,
> +sizeof(get_voltage_info_param_space));
>
>       *voltage =3D result ? 0 :
>
>       le16_to_cpu(((GET_EVV_VOLTAGE_INFO_OUTPUT_PARAMETER_V1_
> 2 *) @@ -1179,7 +1179,7 @@ int atomctrl_get_voltage_evv(struct
> pp_hwmgr *hwmgr,
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> GetVoltageInfo),
> -                     (uint32_t *)&get_voltage_info_param_space);
> +                     (uint32_t *)&get_voltage_info_param_space,
> +sizeof(get_voltage_info_param_space));
>
>       if (0 !=3D result)
>               return result;
> @@ -1359,7 +1359,7 @@ int atomctrl_read_efuse(struct pp_hwmgr
> *hwmgr, uint16_t start_index,
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> ReadEfuseValue),
> -                     (uint32_t *)&efuse_param);
> +                     (uint32_t *)&efuse_param, sizeof(efuse_param));
>       *efuse =3D result ? 0 : le32_to_cpu(efuse_param.ulEfuseValue) & mas=
k;
>
>       return result;
> @@ -1380,7 +1380,7 @@ int atomctrl_set_ac_timing_ai(struct pp_hwmgr
> *hwmgr, uint32_t memory_clock,
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                GetIndexIntoMasterTable(COMMAND,
> DynamicMemorySettings),
> -             (uint32_t *)&memory_clock_parameters);
> +             (uint32_t *)&memory_clock_parameters,
> +sizeof(memory_clock_parameters));
>
>       return result;
>  }
> @@ -1399,7 +1399,7 @@ int atomctrl_get_voltage_evv_on_sclk_ai(struct
> pp_hwmgr *hwmgr, uint8_t voltage_
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND,
> GetVoltageInfo),
> -                     (uint32_t *)&get_voltage_info_param_space);
> +                     (uint32_t *)&get_voltage_info_param_space,
> +sizeof(get_voltage_info_param_space));
>
>       *voltage =3D result ? 0 :
>
>       le32_to_cpu(((GET_EVV_VOLTAGE_INFO_OUTPUT_PARAMETER_V1_
> 3 *)(&get_voltage_info_param_space))->ulVoltageLevel);
> @@ -1526,7 +1526,7 @@ int atomctrl_get_leakage_id_from_efuse(struct
> pp_hwmgr *hwmgr, uint16_t *virtual
>
>       result =3D amdgpu_atom_execute_table(adev-
> >mode_info.atom_context,
>                       GetIndexIntoMasterTable(COMMAND, SetVoltage),
> -                     (uint32_t *)voltage_parameters);
> +                     (uint32_t *)voltage_parameters,
> sizeof(voltage_parameters));
>
>       *virtual_voltage_id =3D voltage_parameters->usVoltageLevel;
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> index a47a47238..82d540334 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.c
> @@ -258,7 +258,7 @@ int
> pp_atomfwctrl_get_gpu_pll_dividers_vega10(struct pp_hwmgr *hwmgr,
>       idx =3D GetIndexIntoMasterCmdTable(computegpuclockparam);
>
>       if (amdgpu_atom_execute_table(
> -             adev->mode_info.atom_context, idx, (uint32_t
> *)&pll_parameters))
> +             adev->mode_info.atom_context, idx, (uint32_t
> *)&pll_parameters,
> +sizeof(pll_parameters)))
>               return -EINVAL;
>
>       pll_output =3D (struct compute_gpu_clock_output_parameter_v1_8 *)
> @@ -505,7 +505,7 @@ int
> pp_atomfwctrl_get_clk_information_by_clkid(struct pp_hwmgr *hwmgr,
>       ix =3D GetIndexIntoMasterCmdTable(getsmuclockinfo);
>
>       if (amdgpu_atom_execute_table(
> -             adev->mode_info.atom_context, ix, (uint32_t
> *)&parameters))
> +             adev->mode_info.atom_context, ix, (uint32_t *)&parameters,
> +sizeof(parameters)))
>               return -EINVAL;
>
>       output =3D (struct atom_get_smu_clock_info_output_parameters_v3_1
> *)&parameters; diff --git
> a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index 5a314d031..2e7f8d5cf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -514,7 +514,7 @@ static int
> smu_v11_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
>                                           getsmuclockinfo);
>
>       ret =3D amdgpu_atom_execute_table(adev->mode_info.atom_context,
> index,
> -                                     (uint32_t *)&input);
> +                                     (uint32_t *)&input, sizeof(input));
>       if (ret)
>               return -EINVAL;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> index 5e408a195..ed15f5a0f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
> @@ -301,7 +301,7 @@ static int
> smu_v12_0_atom_get_smu_clockinfo(struct amdgpu_device *adev,
>                                           getsmuclockinfo);
>
>       ret =3D amdgpu_atom_execute_table(adev->mode_info.atom_context,
> index,
> -                                     (uint32_t *)&input);
> +                                     (uint32_t *)&input, sizeof(input));
>       if (ret)
>               return -EINVAL;
>
> --
> 2.43.0

