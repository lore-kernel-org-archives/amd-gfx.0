Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF0AFC54E5D
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 13:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACB5810F712;
	Mon, 18 Mar 2024 13:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZUmtH/x9";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB0A10F700
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 13:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlZoF7BPLZNEUzqEdLLn4EqhGnvwf6THhS0dqDAAUO9uSjNlTU/txUdenOqdExa44aZFcZosDxS9wHhEGNa2lrhuOBsRW8THt+pZ8WMtHHmxIw5sE7gjk5Hw/nrfMuEbEBfe664y/jsFS41Bw+jnqt8Onr/6naA2lU4+GmTVYFrOgcQX69L7GzvfNOqFxUq9l08Znitzv1pFzLZtB1v6qpmyAc53iqwjQ5p/PDm7sTqVtB0i78mCgqcNnuiOw1/EtZEAYN22vS7JxGTiHRRisl7OmjJJIx9pXLbDP21P7Cvm+VXNRfXKVe6pDuD7hRtWQ+Vbi6uW7ezgbRNf1vMtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNyzXQZrYOjij/BvYl3AwtNfeeJ135/VkBN4NRnFs9s=;
 b=W8o36ZIUba0Q0nlhQ4iI9YQY6zUmAHkTPLPqS+VR0KpZvWsG9e6//c7YeqCoVA+A7ge0oa1K7NTlDkmNs4QA2tbhqfyodQOYiOvsCFb/1Wuf0JuOWMcwpjMqrGP8oBbbdJpizEDRqKw6SFB/ooEWWb9X4JmxWhO1lbcL1fJRJHYcZNq67ZoB161k4m8IKs/VtaR/ddkjN9piHtupWf/igpVUzvHthtXw7bofXCS0SS4t1oF62bzJqEVV7TcRF05c5VXycXjki1h3sZXqqzKmCR10OXhbzrIAmjN/3a2t7ntKMhG0aggin3sUb1YIyPrD1TWaUdXFlg+OrH6Qj2cF7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNyzXQZrYOjij/BvYl3AwtNfeeJ135/VkBN4NRnFs9s=;
 b=ZUmtH/x9IPZ7nN+Rgghcab+frJgGHJqdcUvArckM11xKE9pp4Fjd5JRL3fEnZG4p167HiM1Qv+jegNx5XltM+frjPz+xoIdPlI/ruShwLxYKZ4vbXWRpuqSFSPCjw/HzUhcoevZoBqhOmXzNg64TwV6ovXAuBt/XrihzbROxkVw=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.27; Mon, 18 Mar 2024 13:19:53 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f468:f934:754:7881]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::f468:f934:754:7881%6]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 13:19:53 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Dhume, Samir" <Samir.Dhume@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
Thread-Topic: [PATCH v2 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
Thread-Index: AQHadxIxBBt87rHJqUeQI1Du0q8xnLE9f6VQ
Date: Mon, 18 Mar 2024 13:19:53 +0000
Message-ID: <DM8PR12MB539905F5ED06B0A874C4F3EDE52D2@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20240315195059.862846-1-samir.dhume@amd.com>
 <20240315195059.862846-3-samir.dhume@amd.com>
In-Reply-To: <20240315195059.862846-3-samir.dhume@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8fdc6475-4abb-4b5d-9ff0-db723cce8825;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T13:19:23Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|DS7PR12MB6141:EE_
x-ms-office365-filtering-correlation-id: dd97374f-3e5b-47f1-e2ea-08dc474e193a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JdoIls4Wtgy8zVUCnYgtBQh+3om3gp/VT8V1yGxTNivDNG+wqDOnsyJWq6SmlxPf1cpEBNbV09NJTSAvHORHBj8cE+i8GeZvWc3/UWTDQ40H8g3uPU5UVrHPkqZe1OrE0A2kDMooPI8qqIrMUafNatkAegTRRmdtbZG8VsruTdyDKR/GMBnVTJmuih6l0oymabHt/xpVwk3N4+WL6CyzEnw9BcRXuKPO0s/xxBz/Z29CCZzGzScQi5iixw/fhRntCivU5MPxoFsZh4Ndt6FD9ygJhrc8l6scMpBmdV09xAxD2RRTBiif/xv/Ty2SZmMNBdZYXBZDuImoP8Q2M38VdWU69eeNqHg5NUEdDG7hPslKnjedDHoPWx9MwdqKKo5EpBbGlpuUiVRja6XTCxfN8j5vO4nJBewZ2tt0YJp7nKunSysfdSe01WbaS2E01Lv6ELJQIhK0NjpUXXfjCK8uk0KFOgratZgepdxiudbmZjKMRhL1EXFTYRac8w36XlaHUKqGqprdhpUsIgqxuLVwGyTV6zsVnj6M+pW7Eoj4MwlivpdP5vnikn5HqmnXRnuuZZ4irQDZj3KzSLAe+T1iDpyuQCliwdbRPbo7nmvEB93L2rHEyxVJgtpwSw7Xry14DPf3LpqgKwQDztv7V7YTC5IDT2BGaGFVo5YBi9zdQHlgv+AeBwOTTXiiQe6HrGxJxnuqXyPvn/4tJ1e6AfsRmQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ji5tLeIZNXBmvlk8yF1XiOEYGlYdWxNdD2ag+TUFiFFNcitpZC8hNc/4f6qj?=
 =?us-ascii?Q?1iIApC8cdoLiPiL+ONBpnj/zXFCUDLxt8RRTQJTkSO1FlOWp+itH9lgS+4oN?=
 =?us-ascii?Q?PomLvLTu/LB2bOSE/KkcKHF1N7FtYiBeW5uulbG3574FUmTnvK0u3GAj4xCC?=
 =?us-ascii?Q?t/Vdgf34Lv4/xRBgFwNHbSzP2stnAaIIJokjOvQ8a2cA/L3Uka4S5vgGjSWJ?=
 =?us-ascii?Q?levRr80UDGINxVYh5PQk8u0/VNaGaLXp0+OEKpG3arpayB5eldtq8CerN4Rz?=
 =?us-ascii?Q?xfD8yw0k3pBaPmANjs6s0kuSfPZkULncvGUeoxu8u95Tu79JQWHK+P5M95vR?=
 =?us-ascii?Q?er9lUfRCX3162zNSFLm4qlmodgbqYgBT/tMF0FhsbFDIxGMinyezm+Nf3Xzs?=
 =?us-ascii?Q?gj+5BrMtzbY2B9fVnPAO4elqv8mbw0RXxe9teL15ezx+JfzpLMluCRiJvZs8?=
 =?us-ascii?Q?x/C+FU2R4dlX880emG1wg+7qcyDe7d8T7gWnEMNpPnOaBM+n1F0a24k31FL8?=
 =?us-ascii?Q?f7n/II5ncynVO0pSH/Cf7JTW/L/XErqpMpxI8b2llufceIvTkXzG7Bs84l6j?=
 =?us-ascii?Q?fFJJ3Z8rQGzzA1k+psg43rwPnxeCd7XUX2EXRsxL7tF3GD6GsgJHHiKPrdv1?=
 =?us-ascii?Q?OB7pwIIaRCpadzAXhxvPoJF24Xu+50e6Ac8yfrLcDipYrjn9hbgCpbX+zDDK?=
 =?us-ascii?Q?Wt+NpzLWBXL2E8MquiIHEqFKb9qKOi/mgQ0yPTwTm7gOx0nBUvvzWkwkUu4Q?=
 =?us-ascii?Q?4ZxDvSUeXJfA3pNSxOhAhJdWm6VG1KNR8LdU9m77h/mVwZU0bWLin+vFIed6?=
 =?us-ascii?Q?/t0kOCb8n/q7h0yRadZxDMiDyjz53p3Pu3brrdnN0Ff5jFq41/m/9TRqdG90?=
 =?us-ascii?Q?7/0hWZA3JIXjO6fyQ4uAFRQSuc2oU0nbMe/jOyOZwTB0ahAx6QkERxCR0VnF?=
 =?us-ascii?Q?GySRCM71/s9eFsOcX1AI73NnI3HTPw2L+uPtdJFd+ZQJjzv7LYsUbyEA2Dkd?=
 =?us-ascii?Q?UTkO/PaBZHD2svUJPKYtbPp/v3YrDFCNPyeWYu1DLdJWqB55PKNjXu4eK2DF?=
 =?us-ascii?Q?t4JEb7/0rVqsAf8Nf4ANgHSVZ/DIPnlB92oki0WWV90dRNht33hM0IOlIP8J?=
 =?us-ascii?Q?inhOna2egZSYz7alnf585CXwdyghRybKhq4sbQp/+B6Crb9GfVrmCYRaKm53?=
 =?us-ascii?Q?emSi+Q7TcRDsaHzIArkHEySeXe+9eg+5/tfSvcVSTvC1GeGIqIoyn7OsopMT?=
 =?us-ascii?Q?QzFNWF21iC3GObeb0h86VufRy9RNgrmcQzShMczOYihxo5/Xf2vA8+wfMyuu?=
 =?us-ascii?Q?z4K9f0R4Kw8uApSRQWloHM4nTfI7QIOlJcFd6Ky/W5gijt5IciU8HfPyElS5?=
 =?us-ascii?Q?u6J5N/hXJ1In9zig7In6CNYWYc+dzfdCSZJ1bOENLrwbZ3dHd1a6Yq/DEs3X?=
 =?us-ascii?Q?cU7e79bnUMX5pcYWzmNhPIYMka+C6zwTvdBIA56EYsINBgEqDkjnYd7QJGez?=
 =?us-ascii?Q?xQQeqitlMhO6H+kSaS9+eL+URxgs0ZGBNt7lERgOEruGl6UxGTTnK3JIaAci?=
 =?us-ascii?Q?ubElDkUjKFnIb7GfkS0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd97374f-3e5b-47f1-e2ea-08dc474e193a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 13:19:53.5673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k8OmADSzZUu4VsGv3HRJDrKrFTHLqUk2wF1x2jMT/mUkGPDbv7ru47BEXed3T+pi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

Reviewed-by: Leo Liu <leo.liu@amd.com>

> -----Original Message-----
> From: Dhume, Samir <Samir.Dhume@amd.com>
> Sent: Friday, March 15, 2024 3:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Dhume, Samir <Samir.Dhume@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Liu, Leo
> <Leo.Liu@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH v2 3/3] drm/amdgpu/jpeg: support for sriov cpx mode
>
> In SRIOV CPX mode, each VF has 4 jpeg engines. The even- numbered VFs poi=
nt
> to JPEG0 block of the AID and the odd- numbered VFs point to the JPEG1 bl=
ock.
>
>                     Even-numbered VFs     Odd numbered VFs
>
> VCN doorbell 0      VCN Decode ring       VCN Decode ring
> VCN doorbell 1-3      Reserved          Reserved
> VCN doorbell 4                JPEG0-0 ring
> VCN doorbell 5                JPEG0-1 ring
> VCN doorbell 6                JPEG0-2 ring
> VCN doorbell 7                JPEG0-3 ring
> VCN doorbell 8                            JPEG1-0 ring
> VCN doorbell 9                            JPEG1-1 ring
> VCN doorbell 10                           JPEG1-2 ring
> VCN doorbell 11                           JPEG1-3 ring
>
> Changes involve
> 1. sriov cpx mode - 4 rings
> 2. sriov cpx mode for odd numbered VFs - register correct src-ids (starti=
ng with
> JPEG4). Map src-id to correct instance in interrupt- handler.
>
> v2:
> 1. removed mmio access from interrupt handler. Use xcc_mask to detect cpx
> mode.
> 2. remove unneccessary sriov variables
>
> Signed-off-by: Samir Dhume <samir.dhume@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 60 +++++++++++++++++++++-
> --
>  1 file changed, 53 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 32caeb37cef9..d95ca797412c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -68,6 +68,11 @@ static int jpeg_v4_0_3_early_init(void *handle)
>
>       adev->jpeg.num_jpeg_rings =3D AMDGPU_MAX_JPEG_RINGS;
>
> +     /* check for sriov cpx mode */
> +     if (amdgpu_sriov_vf(adev))
> +             if (adev->gfx.xcc_mask =3D=3D 0x1)
> +                     adev->jpeg.num_jpeg_rings =3D 4;
> +
>       jpeg_v4_0_3_set_dec_ring_funcs(adev);
>       jpeg_v4_0_3_set_irq_funcs(adev);
>       jpeg_v4_0_3_set_ras_funcs(adev);
> @@ -87,11 +92,25 @@ static int jpeg_v4_0_3_sw_init(void *handle)
>       struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>       struct amdgpu_ring *ring;
>       int i, j, r, jpeg_inst;
> +     bool sriov_cpx_odd =3D false;
> +
> +     /* check for sriov cpx mode odd/even numbered vfs */
> +     if (amdgpu_sriov_vf(adev)) {
> +             if (adev->gfx.xcc_mask =3D=3D 0x1) {
> +                     if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
> +                             sriov_cpx_odd =3D true;
> +             }
> +     }
>
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
> @@ -116,10 +135,14 @@ static int jpeg_v4_0_3_sw_init(void *handle)
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
>                               else
>                                       ring->doorbell_index =3D
>                                               (adev-
> >doorbell_index.vcn.vcn_ring0_1 << 1) + @@ -186,6 +209,7 @@ static int
> jpeg_v4_0_3_start_sriov(struct amdgpu_device *adev)
>       uint32_t size, size_dw, item_offset;
>       uint32_t init_status;
>       int i, j, jpeg_inst;
> +     bool cpx_odd =3D false;
>
>       struct mmsch_v4_0_cmd_direct_write
>               direct_wt =3D { {0} };
> @@ -197,6 +221,12 @@ static int jpeg_v4_0_3_start_sriov(struct
> amdgpu_device *adev)
>       end.cmd_header.command_type =3D
>               MMSCH_COMMAND__END;
>
> +     /* check for cpx mode odd/even numbered vf */
> +     if (adev->gfx.xcc_mask =3D=3D 0x1) {
> +             if (adev->gfx.funcs->get_xcc_id(adev, 0) & 0x1)
> +                     cpx_odd =3D true;
> +     }
> +
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; i++) {
>               jpeg_inst =3D GET_INST(JPEG, i);
>
> @@ -220,10 +250,14 @@ static int jpeg_v4_0_3_start_sriov(struct
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
> 1015,16 +1049,28 @@ static int jpeg_v4_0_3_process_interrupt(struct
> amdgpu_device *adev,
>               amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
>               break;
>       case VCN_4_0__SRCID__JPEG4_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
> +             if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[0]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[4]);
>               break;
>       case VCN_4_0__SRCID__JPEG5_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
> +             if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[1]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[5]);
>               break;
>       case VCN_4_0__SRCID__JPEG6_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
> +             if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[2]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[6]);
>               break;
>       case VCN_4_0__SRCID__JPEG7_DECODE:
> -             amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
> +             if (amdgpu_sriov_vf(adev) && (adev->gfx.xcc_mask =3D=3D 0x1=
))
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[3]);
> +             else
> +                     amdgpu_fence_process(&adev-
> >jpeg.inst[inst].ring_dec[7]);
>               break;
>       default:
>               DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d
> %d\n",
> --
> 2.34.1

