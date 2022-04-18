Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB25C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 03:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBE110ED8C;
	Mon, 18 Apr 2022 03:56:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2CE310ED8C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 03:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEWW91lGZicXKVTyfHR9U6zvl0LitMRwNoufjd82xjxmrt0ORhAimrAnOmJxqEh5LiV5TC5xQQVkR88rdnd6G1A+6U3tQPmOYuGrCeV0xA4LfxPYtcbKy1AloQWrg/CA2GP0iuAUyKj2sZjCESN0aJCwzyOVMiX/EcfTieUrk5dXHWWvTnyDsDjWX3CwGS+g2uhINigdzPI0RXqyQuzrWIww3UB49zlmvpw4TptZAP/k2MiBZmWUTQQ1i4FjFnZCPY/O7SVa78TuZ4w8avYFdOz2/XF4EqWkqWj46LettHlaD/hQvAz1B+7NqkSk7+WShUfOfSQLScHZTxgd/OaVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9//OVsg9I9drHX95A7eP3SldR9XVkr24UXeVBJCXcU=;
 b=hOVrPImwKiVhW7zFlNFh2Jg4SyoWRiCkpjhGe5fSC7XNrZ2PgMTkQetVCXEqSPiq526Ox8DSJhDajousE1ThtqcK9Zn5HxGwz4hnPeT9OaTmV4vtgAeVIjggetxqCpEwiDqkvw5rU6/HaVO5g6SoN+FrUhp/RtdehhdpQFDIJDOvfwFtuLDgBuG6XY9EuZOY9c88IF5YzAAt1zuX0fB8k60rjNhtmMZDDI5S7hCRq6os3YmRX0mRjuzZI8HjgL7HuQwHX1p4iWpB2Oqe7p0P9w8AzQhubzuyo1XrAJukKo/qeLGJef5zVCWCjhEoC15+whgmMkDNuKPD0LgkH5TxxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9//OVsg9I9drHX95A7eP3SldR9XVkr24UXeVBJCXcU=;
 b=zMlyfYM7qD73n7DHnvwWgtgx5UQhvglo3nWnbLipmrKnGW6uN4j9Vtn0cb16SDYJzDr3hh4chYFIEFT+pXiCv3E6DFGQPsj9zfT/Ucg9SVh0MHK6qXtjp9LwLnR2VuJANdGzVJYNVQWL9/2AbaBeHaqGLZphfkH81gjLz3QJwXM=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4894.namprd12.prod.outlook.com (2603:10b6:5:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Mon, 18 Apr
 2022 03:56:13 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::6191:648d:c4a:dff%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 03:56:13 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Li, Candice" <Candice.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response
 status for TA load/invoke
Thread-Topic: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response
 status for TA load/invoke
Thread-Index: AQHYUtHNc7PqK/VJqke+8eyGjzZ8kKz1CoqQ
Date: Mon, 18 Apr 2022 03:56:13 +0000
Message-ID: <DM5PR12MB17706AD781619615A0A81B56B0F39@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220418030927.11320-1-candice.li@amd.com>
In-Reply-To: <20220418030927.11320-1-candice.li@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-18T03:56:10Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=dd1f126f-44c9-4803-b556-fb55a9e4708a;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-04-18T03:56:10Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: a7a4225f-e6f5-4cc8-9167-f7abb78d6f4d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 837f05dd-5aa8-45ed-f744-08da20ef61ba
x-ms-traffictypediagnostic: DM6PR12MB4894:EE_
x-microsoft-antispam-prvs: <DM6PR12MB489482834D7F2835FFEC612CB0F39@DM6PR12MB4894.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3nIVjYOQXIOI1S61Ap+Lp1nOMMYL2AsknwtjiUy+gRJveuSkPODgfIM6A0Cnu/bd5CqY7Nv4AqTGAYKyHx1dr8FXBS8/UeZuI8OR+BLXkfafeTK9FbDIFr6POkGvmJ9IcaMEi7gMt2ohUzodQooeaTYOw7wQLLEvMBfoApOS5L2xgNbj83LZdMDsTN85uyW9qRjhxiSVsLx+EkFlZZiJXyJEdqj1xEWUrDsGBOL9KmBjknbqE8aKFBka6iOYrNcEEVYlTIOgG9Rl0A4CT3JWAP6r2990pTQypkZyusthd6n3Z4ds3fiX02sOaoKz6X+EcSyKJokKdKkZ9N6kelrIMXKl87oDM9k/K7Tmz9W+SC0OvYkpeGRpV41p4FZ/zOCtSiA7m4cCBrGOTy+uPjXd0yA5KKr0LVP+0xpauzxQCbcj/RGoNaLX9B6aKast0TMRS7gcDjXYADQenIgWuoqPnyQHNOx1/YSVi/1TexLV0LQUPlfrRheM9+AfBhArrBn8vrKomK1VZmf0GSdeQFG3kXzb9zUA0/tF0EBI4nmnus2WNH75Ka/MPlM2ALH0OJJeDEOqgP/C9VxmSN2lZn9B4kCugL2VEhkhyCglX5l8Crq22Z0g3+L1/pCZF/6Or28PJ0FOIzTgLslakHs0NsN5hzqc1AJJt1LIhrGh6WK+ouJnDZaUa6ZxjRpN3euqZ5twlANPM+p/KyVPUoY234uO/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(7696005)(9686003)(26005)(6506007)(2906002)(71200400001)(66556008)(66946007)(66446008)(52536014)(4326008)(76116006)(8676002)(8936002)(122000001)(66476007)(5660300002)(64756008)(53546011)(316002)(33656002)(508600001)(110136005)(54906003)(186003)(83380400001)(55016003)(38100700002)(38070700005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QghtpRSaeOAKZtMY6utTvCrnh/9poWkcwdqXMHgmLS87/eBZYkoEPoIEj53E?=
 =?us-ascii?Q?IUXF2xAt9PvQwmIhD1F+LAMKAYqD30lRMhCir+kdAWwBUZ6bK556obdVLaov?=
 =?us-ascii?Q?t4sdcLbBbb6ooeHFDV2oD0Wu8XLh++j3Kz5P+z0iaEGa8TWAzMQGyqFSC8WC?=
 =?us-ascii?Q?bs9my1BYw2Jp2oDeVTZO3ds9AOxutd9Vm8NDvSzFsygHSjPgy2jNiZYqzO55?=
 =?us-ascii?Q?2TvbYIXLHMuOogK4mUTNBAW1Zk17q7b3CBhSmymoY6r1Jo97gtvyegzlM5TP?=
 =?us-ascii?Q?2mksnQ0/oCTRZeC6xRd5KlpgShZv00rm7GE+WgxZsGfc6fLaudf53XT8/bs9?=
 =?us-ascii?Q?CEU+RnUAkyYf6mdMY2q9nEOuk1EkYIIaMlGoAFhDkVUAIVQEpF2x/VQ43fTj?=
 =?us-ascii?Q?VtJcYOimPLa4wdJ5P6oCr13QKD1siC0VSTZGa44BlcCM0R3HBHU/2geMYQ4d?=
 =?us-ascii?Q?GPknjetjuaMdQP8Qx4PSWUSwdZY4oSepqWUMsF1urY06UfL6EybOkF3HdGbA?=
 =?us-ascii?Q?GBXcfHaXLRGPQJXY0JE9z2O9SUcT9zmgre0j5Tkr27Z6gCRJi+IPD7CoaMlw?=
 =?us-ascii?Q?mYmBk9ovIOXcgZm8sbjtoszRoP6DH8mYBwor1aZ6PeI4PAZPkVmDfUMFFC4+?=
 =?us-ascii?Q?n068ynxLUtFkjn1hFLAvjgo446WN05vd2cRXppNBADvze6ot1DijgZN0gIad?=
 =?us-ascii?Q?hLMaPsc3e2kz69rHeq+k/KlUSS9XDMX4Dx/0/6LLHqgn4NfpcrPrQRuYZRsx?=
 =?us-ascii?Q?zylVXZiJHg/iW0e9U5IoUe0m+2LUpxtsAz8lfgRQHQwZRVgk5rKd74ou/Vln?=
 =?us-ascii?Q?SFfckd5N5aphl3GCsXSpA7sqz+hzt1dtnuRoXlQGH+8DEr4e6ck1wtishvfT?=
 =?us-ascii?Q?NzGqubObh+zwQgF9u0L6aOfb3/XkbcD6OvJFCpVMg4CpZwbQrvJt7MzGM7xo?=
 =?us-ascii?Q?yeBHaBFEuq2A2UP97dYROAxQGGgSPkvnPq6gjtYXmyny7Gop8pEhBrXao5T7?=
 =?us-ascii?Q?pIwVvaSR20/Pw9N9JARyZhibRBOH7bwsAfvtw4t4RSaF5syhgJPp0KEfQ2Ln?=
 =?us-ascii?Q?BtStqc0Q+hhY2LX53cl8q0o9Ab9XlsbfIJpV9HZxMI93T+YXhlokYUwh+etK?=
 =?us-ascii?Q?33/x8HSU9amG5y+tMRfwbHGAjNMW82c4Zhi5ASDHo5XQB8E75nfaIBJxivRv?=
 =?us-ascii?Q?Xs9VZA69drDPlL9S8y0RcuKxgo6FTh1HPbM0KZXm5OxOf34yQHbWI7BDwm+t?=
 =?us-ascii?Q?ZVaDSikLArwWH0I8pn1d9cH1tQ6pL+2sAubo3/hPU8ru/TZxF4US/ZVGkGs5?=
 =?us-ascii?Q?Xjv4iCIuciLpZ8LcDLVCeDy2cNEZp8iSwKRANPXq2fvZse5d97ceroZT0Nrn?=
 =?us-ascii?Q?DdkzGZtKA03NYwz0gUH9vcnq0zNDpt0mzc6lweh+K9Z3WQcdMGszz1cpAlO4?=
 =?us-ascii?Q?DclQqYjirONjN3WowawR+OVIx/KN7xKZypKkDQAibOpxUzKwpaaAUl5o9QGL?=
 =?us-ascii?Q?2w2BghjhGrAEGCeSKiVob80lJMdSGXHSOkBUdxhr1TiFDC0ERbZu03DF1XYI?=
 =?us-ascii?Q?ECe7oCb3+4Un9EdyzFIKH5LtitFl6Hn+0UNhKCqTzp6Il3tzNJl6r4sEvaTg?=
 =?us-ascii?Q?gkvhH4Vd9rIbg6Pl0dgUA5QYSn22gncv1VXrOM+py2D/ptl+KbCcavWbQ1xw?=
 =?us-ascii?Q?HQ2zZDx5RBbXeE8qwheEA28GelEhxh/OgytwDHh46Vchl+xc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 837f05dd-5aa8-45ed-f744-08da20ef61ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 03:56:13.3699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b72NVZZY+NKf9WStyg5NWXGxYKSYsnNzjXcVDr3uj1vHftGHDz0cK0YcBKhRO7fP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4894
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Clements,
 John" <John.Clements@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Candic=
e
> Li
> Sent: Monday, April 18, 2022 11:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Li, Candice <Candice.Li@amd.com>; Clements, John
> <John.Clements@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: Use indirect buffer and save response st=
atus
> for TA load/invoke
>=20
> The upcoming TA debugfs interface needs to use indirect buffer when
> performing TA invoke and check psp response status for TA load and invoke=
.
>=20
> Signed-off-by: John Clements <john.clements@amd.com>
> Signed-off-by: Candice Li <candice.li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 60 +++++++++++++++++++------
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 26 +++++++++++
>  2 files changed, 72 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index a6acec1a6155d0..cb7e081b1ef426 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -46,8 +46,6 @@ static int psp_sysfs_init(struct amdgpu_device *adev);
> static void psp_sysfs_fini(struct amdgpu_device *adev);
>=20
>  static int psp_load_smu_fw(struct psp_context *psp); -static int
> psp_ta_unload(struct psp_context *psp, struct ta_context *context); -stat=
ic int
> psp_ta_load(struct psp_context *psp, struct ta_context *context);  static=
 int
> psp_rap_terminate(struct psp_context *psp);  static int
> psp_securedisplay_terminate(struct psp_context *psp);
>=20
> @@ -862,7 +860,7 @@ static void psp_prep_ta_unload_cmd_buf(struct
> psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_unload_ta.session_id =3D session_id;  }
>=20
> -static int psp_ta_unload(struct psp_context *psp, struct ta_context *con=
text)
> +int psp_ta_unload(struct psp_context *psp, struct ta_context *context)
>  {
>  	int ret;
>  	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp); @@ -
> 944,7 +942,7 @@ static void psp_prep_ta_load_cmd_buf(struct
> psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_load_ta.cmd_buf_len =3D context-
> >mem_context.shared_mem_size;
>  }
>=20
> -static int psp_ta_init_shared_buf(struct psp_context *psp,
> +int psp_ta_init_shared_buf(struct psp_context *psp,
>  				  struct ta_mem_context *mem_ctx)
>  {
>  	/*
> @@ -958,7 +956,7 @@ static int psp_ta_init_shared_buf(struct psp_context
> *psp,
>  				      &mem_ctx->shared_buf);
>  }
>=20
> -static void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
> +void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx)
>  {
>  	amdgpu_bo_free_kernel(&mem_ctx->shared_bo, &mem_ctx-
> >shared_mc_addr,
>  			      &mem_ctx->shared_buf);
> @@ -969,6 +967,42 @@ static int psp_xgmi_init_shared_buf(struct psp_conte=
xt
> *psp)
>  	return psp_ta_init_shared_buf(psp, &psp-
> >xgmi_context.context.mem_context);
>  }
>=20
> +static void psp_prep_ta_invoke_indirect_cmd_buf(struct psp_gfx_cmd_resp
> *cmd,
> +				       uint32_t ta_cmd_id,
> +				       struct ta_context *context)
> +{
> +	cmd->cmd_id                         =3D GFX_CMD_ID_INVOKE_CMD;
> +	cmd->cmd.cmd_invoke_cmd.session_id  =3D context->session_id;
> +	cmd->cmd.cmd_invoke_cmd.ta_cmd_id   =3D ta_cmd_id;
> +
> +	cmd->cmd.cmd_invoke_cmd.buf.num_desc   =3D 1;
> +	cmd->cmd.cmd_invoke_cmd.buf.total_size =3D context-
> >mem_context.shared_mem_size;
> +	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_size =3D context-
> >mem_context.shared_mem_size;
> +	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_lo =3D
> +				     lower_32_bits(context-
> >mem_context.shared_mc_addr);
> +	cmd->cmd.cmd_invoke_cmd.buf.buf_desc[0].buf_phy_addr_hi =3D
> +				     upper_32_bits(context-
> >mem_context.shared_mc_addr);
> +}
> +
> +int psp_ta_invoke_indirect(struct psp_context *psp,
> +		  uint32_t ta_cmd_id,
> +		  struct ta_context *context)
> +{
> +	int ret;
> +	struct psp_gfx_cmd_resp *cmd =3D acquire_psp_cmd_buf(psp);
> +
> +	psp_prep_ta_invoke_indirect_cmd_buf(cmd, ta_cmd_id, context);
> +
> +	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
> +				 psp->fence_buf_mc_addr);
> +
> +	context->resp_status =3D cmd->resp.status;
> +
> +	release_psp_cmd_buf(psp);
> +
> +	return ret;
> +}
> +
>  static void psp_prep_ta_invoke_cmd_buf(struct psp_gfx_cmd_resp *cmd,
>  				       uint32_t ta_cmd_id,
>  				       uint32_t session_id)
> @@ -978,7 +1012,7 @@ static void psp_prep_ta_invoke_cmd_buf(struct
> psp_gfx_cmd_resp *cmd,
>  	cmd->cmd.cmd_invoke_cmd.ta_cmd_id	=3D ta_cmd_id;
>  }
>=20
> -static int psp_ta_invoke(struct psp_context *psp,
> +int psp_ta_invoke(struct psp_context *psp,
>  		  uint32_t ta_cmd_id,
>  		  struct ta_context *context)
>  {
> @@ -990,12 +1024,14 @@ static int psp_ta_invoke(struct psp_context *psp,
>  	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
>  				 psp->fence_buf_mc_addr);
>=20
> +	context->resp_status =3D cmd->resp.status;
> +
>  	release_psp_cmd_buf(psp);
>=20
>  	return ret;
>  }
>=20
> -static int psp_ta_load(struct psp_context *psp, struct ta_context *conte=
xt)
> +int psp_ta_load(struct psp_context *psp, struct ta_context *context)
>  {
>  	int ret;
>  	struct psp_gfx_cmd_resp *cmd;
> @@ -1010,6 +1046,8 @@ static int psp_ta_load(struct psp_context *psp, str=
uct
> ta_context *context)
>  	ret =3D psp_cmd_submit_buf(psp, NULL, cmd,
>  				 psp->fence_buf_mc_addr);
>=20
> +	context->resp_status =3D cmd->resp.status;
> +
>  	if (!ret) {
>  		context->session_id =3D cmd->resp.session_id;
>  	}
> @@ -1415,16 +1453,10 @@ int psp_ras_enable_features(struct psp_context
> *psp,
>  	return 0;
>  }
>=20
> -static int psp_ras_terminate(struct psp_context *psp)
> +int psp_ras_terminate(struct psp_context *psp)
>  {
>  	int ret;
>=20
> -	/*
> -	 * TODO: bypass the terminate in sriov for now
> -	 */
> -	if (amdgpu_sriov_vf(psp->adev))
> -		return 0;
> -

[Tao] it seems the change is unrelated to the patch.

>  	if (!psp->ras_context.context.initialized)
>  		return 0;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index ff7d533eb746ce..cf8d3199b35bf0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -48,6 +48,17 @@ enum psp_shared_mem_size {
>  	PSP_SECUREDISPLAY_SHARED_MEM_SIZE	=3D 0x4000,
>  };
>=20
> +enum ta_type_id {
> +	TA_TYPE_XGMI =3D 1,
> +	TA_TYPE_RAS,
> +	TA_TYPE_HDCP,
> +	TA_TYPE_DTM,
> +	TA_TYPE_RAP,
> +	TA_TYPE_SECUREDISPLAY,
> +
> +	TA_TYPE_MAX_INDEX,
> +};
> +
>  struct psp_context;
>  struct psp_xgmi_node_info;
>  struct psp_xgmi_topology_info;
> @@ -151,9 +162,11 @@ struct ta_mem_context {  struct ta_context {
>  	bool			initialized;
>  	uint32_t		session_id;
> +	uint32_t		resp_status;
>  	struct ta_mem_context	mem_context;
>  	struct psp_bin_desc		bin_desc;
>  	enum psp_gfx_cmd_id		ta_load_type;
> +	enum ta_type_id		ta_type;
>  };
>=20
>  struct ta_cp_context {
> @@ -407,6 +420,18 @@ int psp_gpu_reset(struct amdgpu_device *adev);  int
> psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
>  			uint64_t cmd_gpu_addr, int cmd_size);
>=20
> +int psp_ta_init_shared_buf(struct psp_context *psp,
> +				  struct ta_mem_context *mem_ctx);
> +void psp_ta_free_shared_buf(struct ta_mem_context *mem_ctx); int
> +psp_ta_unload(struct psp_context *psp, struct ta_context *context); int
> +psp_ta_load(struct psp_context *psp, struct ta_context *context); int
> +psp_ta_invoke(struct psp_context *psp,
> +			uint32_t ta_cmd_id,
> +			struct ta_context *context);
> +int psp_ta_invoke_indirect(struct psp_context *psp,
> +		  uint32_t ta_cmd_id,
> +		  struct ta_context *context);
> +
>  int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data,=
 bool
> load_ta);  int psp_xgmi_terminate(struct psp_context *psp);  int
> psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id); @@ -425,6
> +450,7 @@ int psp_ras_enable_features(struct psp_context *psp,
>  		union ta_ras_cmd_input *info, bool enable);  int
> psp_ras_trigger_error(struct psp_context *psp,
>  			  struct ta_ras_trigger_error_input *info);
> +int psp_ras_terminate(struct psp_context *psp);
>=20
>  int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);  int
> psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
> --
> 2.17.1
