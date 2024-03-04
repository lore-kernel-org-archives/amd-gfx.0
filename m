Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD8CC5478C
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Mar 2024 17:32:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1E791123C1;
	Mon,  4 Mar 2024 17:32:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ReUNj1cM";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46A661123C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Mar 2024 17:32:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cun83v/y7TFhJLOjJrrXIp8lrT7+WFbwltCh02/os5qEiLJ++HCHrOtFL7mKpUalWwaGua+UvPbwPyZrzKKRJj9XnQJiTq/HnX6Z64SldZRgixwMLXPzUVCNhNbTchLVdUsy6GxTqDee7K+86vYJ00LbUcyuwYtjH+r+YDv9BmILMOcr785aHWSbSOpN/WE5ItqZkYtrP3ZDbH8J5ggmviUa6VGnKVhINQRCXqJ0RM5Fo3/J6OACOufYFHhzkv2ZZd/uBVxSprEobhnbgDhu/hpPo5Yb2S/mE9zG21Ws6MlsDY20x5MdLvrYkSs7KoOrChK7Qm8LR/Xz2degq7lJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGNJTK+G6p4ruXXOsCOQzHBxRGWWEWMsufW00g8cWog=;
 b=QCzpQCVWx+ORKg9Gv0D4pjKfRPoSLsR6b96renVMkmTB2TwX+xfTf0ub49DEWVN7AtMSnnQTg2asmzxgC5lY95INcF9KAGvSwkShp8gxtZme4r5JEbsnkTX5Ls5pee7ZBPvZYjf6uFVez1MSgDfC+dlxnynT/w7q5UGyTGmpTKitQvA3wxuV1bmJhmBlSt+UxTYGbiISTrZ/VbgscuqCUMv3VrjEI5kzclpIDcoMy7S3yTCsHIjM7fDG1isP0ttscmWhIvhuKz4jwxO/RWOzoce7KM6c3yhvtYFE0xIftfAO59nmZ4q4K+TnO8uAxsPwdX2iMknhNKL5us98EMEMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGNJTK+G6p4ruXXOsCOQzHBxRGWWEWMsufW00g8cWog=;
 b=ReUNj1cM9MgBBiwUO3RmC1tgVpGDnmaSZJA3nOXKLAusESZykXlSvLkeOn7gtQ7xGInkkGJ/UfQPOuwU/AU2i6rZwnPbQa6uRs+S6BX3B4O6UCbPmdn6jat5EdgSqqB0tIfJWdudYFuVdonDB8RVx7b2pcNbM0DkSsfpdKPk6AM=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 17:32:47 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f468:f934:754:7881]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f468:f934:754:7881%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 17:32:47 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Dhume, Samir" <Samir.Dhume@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
Thread-Topic: [PATCH 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
Thread-Index: AQHabkdxafssGrASQ0KnVTKl/uaK/LEn1o3Q
Date: Mon, 4 Mar 2024 17:32:47 +0000
Message-ID: <DM8PR12MB539925E4E00DD99EF104C70BE5232@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240304151931.802397-1-samir.dhume@amd.com>
 <20240304151931.802397-3-samir.dhume@amd.com>
In-Reply-To: <20240304151931.802397-3-samir.dhume@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f5078f52-c121-494a-abb7-1523a9fa0b30;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-04T17:29:47Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|SN7PR12MB7249:EE_
x-ms-office365-filtering-correlation-id: efff0f7e-fa20-48a5-a1f3-08dc3c711bce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fzDBgJIxYGFE/vizXvicefzbkrNSgjYkIuyZsdGz66USdLkNSLVjC3mgPosFlr2TplWUB+s4Mpw/opm4xAZQMIYVxQRawWyrLnDhvVtN79wT0Cl18OoDNn41Lsj7cuW5yTsH7xR6/Ytz0C1lc41EOL1m5v2zBw2KpaqLYZe0sAg3fLu+sep6DHI9hWsemHP3xnmmvwe5w5SXkQjN+3smlypQi5M6IVrLL5LF+AVtinEjis2+OmAR9OOkP/cLHijTLY3xtobyD5g7PgfDHMTXKU8IvIU1zmZXd5wO+pLXXq9mN/q0+hOw3+mR7R47ZfgGA+uiDv0pHnvWoBmCs4eQbLPKNSzq19eTIVn6OFUEuvJsA7PDgDhWYBZkPg4BT3iJCoVkUK6GGSuDYPFoUqNwBGXL1ILLRI3yuecP4bSulxLmTZV3miyUQQpvypMONjmrok+O5xFLoPh2o9abAQdGoKqxnfy2mHBrXnkwujP/YdK++6LN3FraD2R9iLHAx/Ejyebmxj0jgA4rxfpKdAqdf9eQ6dCjp9htJlNxhhvgF/rBrh8CBN8FgHZlkCo8RGukpU4g6GdxmbJqC652hXS5QZi22BUi7j4dU5pLav8fnLfO4QFwx7rzIfBJ6v+4EdxAsjyNWI7MVPIJoK0OfTCMs07G6Ij3Zb2am7qsgzmaYAhsBZrYniXCqiaXAQcS17rKvpXS3ejrIKDuNktR6aSYlg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wKsR8zIpTu/FTAU91uAsLFS1z4pvc37fVUh3BAr7A6sR2qHgFVB9F16aptWJ?=
 =?us-ascii?Q?FAyddJuRB0gJEwOmZIeLkguBp2kG1X+WdxL8jPNNmeg9701eCXENFvSma6uM?=
 =?us-ascii?Q?94Zu12pJmnR+WtxkBSvxU2XGWVtp2OMIeSgbjiGmmIKUFWq16dhwtVh+osbJ?=
 =?us-ascii?Q?7LDvouKjulX165D14wTFkCBmSlG70xZJgrRd+3msS30l6sLF+Vq3Rhkcf8O3?=
 =?us-ascii?Q?dQ++wXL6io2Yu/uU0DwUIGkbs77eGBtmGXmGC58dqJozQShtb7CLk2W4WBMP?=
 =?us-ascii?Q?RmJVnrS+27B/O1xjexjFQyzfDIpjscmbOLfnE9tdtCx8+oEBs5Ya2j+lDID7?=
 =?us-ascii?Q?NRCeizAPqmLE+pLxLpLgmpXlH4cawFyyCaRtk4u5VJ+SqHtpz2wpbxalgxaM?=
 =?us-ascii?Q?01ivnIVeIuDr7vCJiLnA6d/w+HBkVfa3R/6p9z5YqSUJYTl3YU5BCVNcm5N0?=
 =?us-ascii?Q?loGhpZDbcQMvshJKfxByeimINMgJ/fpr8ePRbctpDD/nXrBfRydPnz9KAvVG?=
 =?us-ascii?Q?QeKP9YGpFECUr1mSReYie5HV8uo6c4100DMbXkjPyO9jai4IMNhnL7fgLUaw?=
 =?us-ascii?Q?t+auUSMyfij7oXsJwElHXMQnSK9ehXemMchWzXajYsOX5vvMUpFgW/Jy8Zah?=
 =?us-ascii?Q?jhOnznj98Zkcte9Ta7zQuXDxnbs2c0jTVUCv5YqiFIg0g1MLrumQlbA5zHA9?=
 =?us-ascii?Q?PrfXtwGanb+AkTV7DmCsQst8iog6X4a8bfzgp5494Tnut2e34xkUGB2IZrW5?=
 =?us-ascii?Q?mgH7Ao4o2UEnPLPvDbYqeWUllJZiRhlA6m5+ggOHovRt35J65HUWniq1x5Gt?=
 =?us-ascii?Q?nI2Cl7FI5rXwct9RWurGGBJuNpvG6tvskDbr2viIgY1t5OHWCBcNYhn5g2K/?=
 =?us-ascii?Q?1R7N8X9ERnLGN8mbfDebuimQSPPWj/533YGIjGRKnrLWe9QXp0ob+2VqFlEa?=
 =?us-ascii?Q?LIQjU8RRd5E3rv+RfiCl2YUH+8/0T5Sya+uXTc6Gx8pWwlfO3ejxwcscSXqc?=
 =?us-ascii?Q?wrWsuDrroH/fF7egalIUD+yuzkujatzqGgFpnappuLQ/pw2P3MnwDkW0CzFi?=
 =?us-ascii?Q?lBl2p9K1tXWJmSacwz35kXmmwghUix5NXnAk44JDoQbUBE0WZ2C0bYZHwajr?=
 =?us-ascii?Q?5sFl8v1moEHWTyQnnqgE2bSEgwtdqKXsCEG4p3h+SY76Y6zDvRNQh+HFC8md?=
 =?us-ascii?Q?iMD5ot9mK3BO3gAgKOR6u+BzjeYzqVaxKheLCmecIJPKdp6+blhcLeccAM7V?=
 =?us-ascii?Q?6u51fiRg1rvazI1MgQTJX6rZddNedH6o0fjCcQWEdpgavlM27JEmUaML41bv?=
 =?us-ascii?Q?rxpKBk1H2lqbb6kKC2Utvq4trU4hGrppKVwiom0JZKDOJvdU5hIaEKzXwWZI?=
 =?us-ascii?Q?uqOe3e5uRFGKvMlW027trG0plnPe0Uh83w6opUT1aoF1YI+4ywmKtS6Zojhb?=
 =?us-ascii?Q?dXsuie3AXgLbSKjx9ycg4WBOu502qRcs9JyxR3vTHcqIrlmWxHLCLz5AYMDv?=
 =?us-ascii?Q?3OTcR17TbyiNjbfKWX+J1RIXDYMKyn6pXAaMpXWxAbmc3G/lEkBPyHUgNmds?=
 =?us-ascii?Q?og1G0y2DA75vnyetvMU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efff0f7e-fa20-48a5-a1f3-08dc3c711bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 17:32:47.4699 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J57trLlPqHrBG3XaT6yRaucoSxKHiYp8wqmQzqEq/LgSbtIsyu2P+vDhc9LDQJEt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249
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

[AMD Official Use Only - General]

> -----Original Message-----
> From: Dhume, Samir <Samir.Dhume@amd.com>
> Sent: Monday, March 4, 2024 10:20 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
>
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 80 +++++++++++++++++++++-
> --
>  1 file changed, 73 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 32caeb37cef9..4bf087f8ca2b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -65,9 +65,15 @@ static int amdgpu_ih_srcid_jpeg[] =3D {  static int
> jpeg_v4_0_3_early_init(void *handle)  {
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> +     struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;

In general, to make the path clear, can we define and use the SRIOV specifi=
c variables and function within "amdgpu_sriov_vf()" ?

Regards,
Leo

>
>       adev->jpeg.num_jpeg_rings =3D AMDGPU_MAX_JPEG_RINGS;
>
> +     if (amdgpu_sriov_vf(adev))
> +             if (adev->xcp_mgr->funcs->query_partition_mode(xcp_mgr) =3D=
=3D
> +                             AMDGPU_CPX_PARTITION_MODE)
> +                     adev->jpeg.num_jpeg_rings =3D 4;
> +
>       jpeg_v4_0_3_set_dec_ring_funcs(adev);
>       jpeg_v4_0_3_set_irq_funcs(adev);
>       jpeg_v4_0_3_set_ras_funcs(adev);
> @@ -88,10 +94,28 @@ static int jpeg_v4_0_3_sw_init(void *handle)
>       struct amdgpu_ring *ring;
>       int i, j, r, jpeg_inst;
>
> +     bool sriov_cpx_odd =3D false;
> +     struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
> +     int mode;
> +
> +     if (amdgpu_sriov_vf(adev)) {
> +             mode =3D xcp_mgr->funcs->query_partition_mode(xcp_mgr);
> +
> +             if (mode =3D=3D AMDGPU_CPX_PARTITION_MODE) {
> +                     if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
> +                             sriov_cpx_odd =3D true;
> +             }
> +     }
> +
>       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; ++j) {
>               /* JPEG TRAP */
> -             r =3D amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
> +             if (!sriov_cpx_odd)
> +                     r =3D amdgpu_irq_add_id(adev,
> SOC15_IH_CLIENTID_VCN,
>                               amdgpu_ih_srcid_jpeg[j], &adev->jpeg.inst-
> >irq);
> +             else
> +                     r =3D amdgpu_irq_add_id(adev,
> SOC15_IH_CLIENTID_VCN,
> +                             amdgpu_ih_srcid_jpeg[j+4], &adev->jpeg.inst=
-
> >irq);
> +
>               if (r)
>                       return r;
>       }
> @@ -116,10 +140,15 @@ static int jpeg_v4_0_3_sw_init(void *handle)
>                                       (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) +
>                                       1 + j + 9 * jpeg_inst;
>                       } else {
> -                             if (j < 4)
> +                             if ((j < 4) && (!sriov_cpx_odd))
>                                       ring->doorbell_index =3D
>                                               (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) +
>                                               4 + j + 32 * jpeg_inst;
> +                             else if (sriov_cpx_odd)
> +                                     ring->doorbell_index =3D
> +                                             (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                                             12 + j + 32 * jpeg_inst;
> +
>                               else
>                                       ring->doorbell_index =3D
>                                               (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) + @@ -186,6 +215,9 @@ static int
> jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
>       uint32_t size, size_dw, item_offset;
>       uint32_t init_status;
>       int i, j, jpeg_inst;
> +     struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
> +     int mode;
> +     bool cpx_odd =3D false;
>
>       struct mmsch_v4_0_cmd_direct_write
>               direct_wt =3D { {0} };
> @@ -197,6 +229,13 @@ static int jpeg_v4_0_3_start_sriov(struct
> amdgpu_device *adev)
>       end.cmd_header.command_type =3D
>               MMSCH_COMMAND__END;
>
> +     mode =3D xcp_mgr->funcs->query_partition_mode(xcp_mgr);
> +
> +     if (mode =3D=3D AMDGPU_CPX_PARTITION_MODE) {
> +             if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
> +                     cpx_odd =3D true;
> +     }
> +
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
>               jpeg_inst =3D GET_INST(JPEG, i);
>
> @@ -220,10 +259,14 @@ static int jpeg_v4_0_3_start_sriov(struct
> amdgpu_device *adev)
>                       tmp =3D SOC15_REG_OFFSET(JPEG, 0,
> regUVD_JRBC0_UVD_JRBC_RB_SIZE);
>                       MMSCH_V4_0_INSERT_DIRECT_WT(tmp, ring-
> >ring_size / 4);
>
> -                     if (j <=3D 3) {
> +                     if ((j <=3D 3) && (!cpx_odd)) {
>                               header.mjpegdec0[j].table_offset =3D
> item_offset;
>                               header.mjpegdec0[j].init_status =3D 0;
>                               header.mjpegdec0[j].table_size =3D table_si=
ze;
> +                     } else if (cpx_odd) {
> +                             header.mjpegdec1[j].table_offset =3D
> item_offset;
> +                             header.mjpegdec1[j].init_status =3D 0;
> +                             header.mjpegdec1[j].table_size =3D table_si=
ze;
>                       } else {
>                               header.mjpegdec1[j - 4].table_offset =3D
> item_offset;
>                               header.mjpegdec1[j - 4].init_status =3D 0; =
@@ -
> 986,6 +1029,16 @@ static int jpeg_v4_0_3_process_interrupt(struct
> amdgpu_device *adev,
>                                     struct amdgpu_iv_entry *entry)  {
>       uint32_t i, inst;
> +     struct amdgpu_xcp_mgr *xcp_mgr =3D adev->xcp_mgr;
> +     int mode;
> +     bool sriov_cpx_odd =3D false;
> +
> +     mode =3D xcp_mgr->funcs->query_partition_mode(xcp_mgr);
> +
> +     if (mode =3D=3D AMDGPU_CPX_PARTITION_MODE) {
> +             if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
> +                     sriov_cpx_odd =3D true;
> +     }
>
>       i =3D node_id_to_phys_map[entry->node_id];
>       DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n"); @@ -1015,16
> +1068,29 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device
> *adev,
>               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
>               break;
>       case VCN_4_0__SRCID__JPEG4_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
> +             if (!sriov_cpx_odd)
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[4]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[0]);
> +
>               break;
>       case VCN_4_0__SRCID__JPEG5_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
> +             if (!sriov_cpx_odd)
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[5]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[1]);
>               break;
>       case VCN_4_0__SRCID__JPEG6_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
> +             if (!sriov_cpx_odd)
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[6]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[2]);
>               break;
>       case VCN_4_0__SRCID__JPEG7_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
> +             if (!sriov_cpx_odd)
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[7]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[3]);
>               break;
>       default:
>               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d
> %d\n",
> --
> 2.34.1

