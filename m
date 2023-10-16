Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F29DCDB482
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Oct 2023 13:20:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ED0010E1D7;
	Mon, 16 Oct 2023 13:20:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254F710E1D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Oct 2023 13:20:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvVDytkghTY58fPxA6Dq1g1R6Uq4TVqR0GA3lNzLMH/4rEipr/4V+QnriOtiamJkS9pxMaWz5zlssVvm95Jf8bWfdjSg72bl/uTOGUA+ggQIidbYNFRB1X6UZi6iBdfU3yvFsJlXoSi1lLZY+S+P2N8XV+FzeALWWdIhyPxuNUbD/UcySaP6dugvC5HUzullTvzdhpFjhwWNTtZJ5XP1QhU1MkRLr0DCu64RDk4fgbwcX9ns0R/I/pj4QqeCq8kgle/aebX5su8XNnft7PnHO9iLuEUJBmKr1XY/ge/q3N/ZG/IH+hUSMBBMFmChHJEzl6HtqBXo7c0+YPxzu1Kc5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcmQAmIQXzyxWvKuvOU4tWKUvOwx6iNRvpvF+wwImIk=;
 b=RHoXyUodf819jYN0fIz/bJNlz3sqQM+QpIfx/Bcsd6fjb0C3pBMB5GBEkI4fhsr1sECZBXBj84TdccqM2GSpva3Vd3SWWYFlnXywXB0k7WeWfW1a8rYurPTUUgjYrMexe7mjp00XFmM9Z5oEfKiIPv5n7jEoV23elfRIgQ53flce2uDE+nmSIugeXgYZk852pGpgUHMEbxEJKvQ5xm4goXnKAi7Cg+9Tvt6Urp3Y2zYYKvxxtGdoyQ3TywQww6K3h400r3LYSdgKPKDga/sAFSVG9jG+5GFCRp/2AeahEYosQ4LO/8OadivPAWU2MtKKQBuj/zq2HVB75tBGwOoICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcmQAmIQXzyxWvKuvOU4tWKUvOwx6iNRvpvF+wwImIk=;
 b=5KlV0d+Ytgj9hgm8TF+0xiadFlt2R1ABZ+laThgxMTmdm77GnIccm+5nXcCgTLbvsGiFJxgS/WImV1iiX6hyLrIiMjpeHag5E921/NZjWm0y87xqMp0ZetOHodlAkI4lRXD4Z33o+K1Nf2e/sHSVgHLR2b1xSiEZ1RQCilbdSwU=
Received: from DM8PR12MB5399.namprd12.prod.outlook.com (2603:10b6:8:34::5) by
 IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 13:20:21 +0000
Received: from DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::ee90:6ffc:283d:8130]) by DM8PR12MB5399.namprd12.prod.outlook.com
 ([fe80::ee90:6ffc:283d:8130%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 13:20:21 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Zhang, Bokun" <Bokun.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3] drm/amd/amdgpu/vcn: Add RB decouple feature under SRIOV
Thread-Topic: [PATCH v3] drm/amd/amdgpu/vcn: Add RB decouple feature under
 SRIOV
Thread-Index: AQHZ/fzVOVnxnSVRekaIsD1GL92ZYbBMZS/A
Date: Mon, 16 Oct 2023 13:20:21 +0000
Message-ID: <DM8PR12MB53992E23B6DB20C5332ABF9CE5D7A@DM8PR12MB5399.namprd12.prod.outlook.com>
References: <20231013174312.128566-1-bokun.zhang@amd.com>
In-Reply-To: <20231013174312.128566-1-bokun.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9de81a1b-2c35-4d09-a21c-9f1e8d3d083f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-16T12:59:21Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5399:EE_|IA0PR12MB8839:EE_
x-ms-office365-filtering-correlation-id: 83eca1de-3568-48b1-3b66-08dbce4aa62a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wpVqXSA3RLImkoDj7EwuFHGRC3UBXmozWxoXGDMRvatADz89/OfDm2nHjuggUAV9Js10FKhHt6hrPdaxGN61lA8xQjPg7GumimpbMSW26GnaXYDDZFB8BsgeFCi23WNCnsYVyBQ8qwvUlOelTtpXX86A4/f6LrrNX1dn4cJcgWq6k807I8/8aGTFOVXlZ2+jus7Xsy2n0+REUViBhl2Y/A+JZM0GgVDfOHaN1XKJ1IWDKx8A/S+pYsNEqkJGbOX+m0AUwQp4k/NOL4vZY6WKSBHhUZYuywAx7xwb/mn5InEbEp/GKQqra8w+bSc3JIKdHVYnMZ6Ls2NMekGqeeM0U54vpIwoa7Wz7p42aaqB9Jqq1J25lukdHK769wJ0jLQws3kCLulMZjdtIG859pFEjjhYMae3Jl74F2Tf2yqkjp9kzftsuJmU6lmzznYYX1QG2oVQ6oXgpD6ZuNjkC0vQMje1dTlFGuJm7vB8ILwy5U0fSkG72wgbyja2a1Oc+kwT6qQHWZY/5+jAYx2WxkjDnwnUxfHtT6GCxJBkZKnljMtrr+YSKeZ8KkqfIY38aCNruW/pjeGdetNkj4cFvxatIMNXDPnrLEC5VLSVMkkzdZwLnRUWl6Fg8Du4Nuhrgh6q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5399.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(55016003)(30864003)(83380400001)(76116006)(110136005)(64756008)(66556008)(66446008)(66476007)(52536014)(66946007)(8676002)(4326008)(316002)(8936002)(71200400001)(53546011)(41300700001)(9686003)(7696005)(5660300002)(6506007)(478600001)(2906002)(38100700002)(38070700005)(122000001)(33656002)(86362001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mLXidfeeVXHC/IR2r88laRlxKzWFhZO7R5swgyM7ySrQWGnRgAwt8qtM25Dd?=
 =?us-ascii?Q?QHYz5LhqkfDv7isrm7w4Pc0W1p7xlwe6fxFSmEAJ5Tm1w190l6o7WNzO7UWI?=
 =?us-ascii?Q?RUH9cUC9KmZwLbA85mhDVMyWJ9+bJ77uNVHn0+piQgc1PEts9TKTy2pV/fps?=
 =?us-ascii?Q?UFwsIT9MPbhybUBPBRnz4AXuiCLVPhCwEaRj9Bph3qxfLHotit1L2STjxm+q?=
 =?us-ascii?Q?eveiSc5MuEqypuGjb2cf450qtYx5DieMs5g1SQHyVOk2SsE5igRJdq8+3Kie?=
 =?us-ascii?Q?jM3JkdQD2lSopfgB39zIXubk+Noc08obg6IrwnFcGRkHnxM2ODVGslXIyspU?=
 =?us-ascii?Q?ZAjVLALuZ2NrzNKgozAHdzezkDfwXX8/TyWTCZWAoVdrx4Z6DAkrWaWLJb0v?=
 =?us-ascii?Q?zMFG8NeUyVv+qfaaIeD0LkCPAuRgeO2O9zurizlidX44GBB69pXVXiflwU/a?=
 =?us-ascii?Q?E+TmoD1KA01xp3+FyY6uonZt8Qej2PjlVkQ0zpjahlzhwy2IRe4y29v9cWun?=
 =?us-ascii?Q?x1zUWTLPX0ONzoCu1FfDL/2P8qR4g/QOA87uz5KGkwoKNjrYnWYI8rwPWlci?=
 =?us-ascii?Q?qk019grIWdBflECnvlKqADaBRS1iSMttVwRHMMgHINLCm7EitAFew8lKIDNc?=
 =?us-ascii?Q?ajb2Z76eAWotgdNxbVaUn45L+7D8PuTwFbXeW04hI+zK0SVePjYhSE81NVzr?=
 =?us-ascii?Q?XM77IZAf0OPL9I4Mskqr8QqMs2yOViq0o3kNXbIKlSDAiR0otXk2KOUWnR9S?=
 =?us-ascii?Q?a7ZOj0Xt0dxdjYGK0Z4PeETrAP+iC2ULo9SBGGJPkpz1lPk6oZov8bBFhtAH?=
 =?us-ascii?Q?MFdvEMJlBzmmuyY9Mo1L5MDjtGoZoQvpLyu5FaSYCL8ntCD97BTcYf5/Q1ui?=
 =?us-ascii?Q?Rn0ulF7jzpyhkPONc+4kRJ58h1eFU7LXlTmiU0SllG4vsLUjreBS7gtr8BYm?=
 =?us-ascii?Q?8PViZ2g6kusZgW+CN5e0qY659bX3KO5Hb3VAI6iMq/+P0FpgZy2PXAjvnoIM?=
 =?us-ascii?Q?suRBMsYh2iXjAqvucBCkxFBCSKcp2Wm3kbh7MzfG85beKUQ1VYLotcQetaHj?=
 =?us-ascii?Q?P+feyNu0ODmAx+bmWF6lCkUs8vPcybIqBN2eDwiKF7VKXwwUOaPQRu3l2zsk?=
 =?us-ascii?Q?QMhrcIy7HOejGp3rIUPv0372wSSaWRZCDlpqXXpPg/GGZ6srN9zKbmE0vIS9?=
 =?us-ascii?Q?VjXAnQonkZ76HP34EETShBkR7f+bEHe6XXx+nhf08GsmTSQuiSl+5bLzDIyP?=
 =?us-ascii?Q?Z3Ziy5HhX9BfKAKPRwf9oXB3+NkENcOP0ZFQzAGmKk1xbh6PIgfCoRm1LgvU?=
 =?us-ascii?Q?XwEj0cQM2DLeZlLz50iUJ1SZlMiMMMnSGC8eKU0wMuKx43Pq16CjjQY6BLuX?=
 =?us-ascii?Q?h0GcQRAUEjkYcIY5pXAR6ENmtBag9uPTRzmKqMMnCk+HFz7y4BOfTPptu/wn?=
 =?us-ascii?Q?VTnhu+HycFApO1eshq1+oeX9HtQZcRQ7H/n1d4hHVlgfqc8VrRXY+FsipP0+?=
 =?us-ascii?Q?t4UD3Y1hygkmNhI89mLBpLomCxvFErqJ0zyJws8Foc/u0xD5p0IH4vMIazhn?=
 =?us-ascii?Q?7bjeOxqL08R7Nq8hyd0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83eca1de-3568-48b1-3b66-08dbce4aa62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2023 13:20:21.3717 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aLWcZ9FcRbr/eTHuk7pfX6T7FSTetEK1/bz6mvEVKajYdGFBbkc/t1iHJnymJY6D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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
Cc: "Zhang, Bokun" <Bokun.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Bokun Zhang
> Sent: Friday, October 13, 2023 1:43 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Bokun <Bokun.Zhang@amd.com>
> Subject: [PATCH v3] drm/amd/amdgpu/vcn: Add RB decouple feature under
> SRIOV
>
> - Add code to enable RB decouple feature.
>   This feature is controlled by SRIOV host.
>   Once enabled, it allows VCN0's job to be remapped to
>   VCN1 at hardware level and improves VCN availability
>
Since this is feature is only used by SRIOV, we need to make sure the chang=
es not affect BM path. Also please split the patch into multiple patches.


> Signed-off-by: Bokun Zhang <bokun.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h     | 52 +++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h    |  4 ++
>  drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h |  5 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c       | 71 ++++++++++++++++-----
>  5 files changed, 110 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index f4963330c772..7e8c2dbb34fb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -204,6 +204,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device
> *adev)
>               adev->vcn.inst[i].fw_shared.gpu_addr =3D adev-
> >vcn.inst[i].gpu_addr +
>                               bo_size - fw_shared_size;
>
> +             /* clean up fw share */
> +             memset(adev->vcn.inst[i].fw_shared.cpu_addr, 0,
> fw_shared_size);
> +
>
This should be redundant, since it should be got cleared when allocation.

                adev->vcn.inst[i].fw_shared.mem_size =3D fw_shared_size;
>
>               if (amdgpu_vcnfw_log) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index 0815c5a97564..6935ab74f481 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -169,6 +169,9 @@
>  #define AMDGPU_VCN_SMU_VERSION_INFO_FLAG (1 << 11)  #define
> AMDGPU_VCN_SMU_DPM_INTERFACE_FLAG (1 << 11)  #define
> AMDGPU_VCN_VF_RB_SETUP_FLAG (1 << 14)
> +#define AMDGPU_VCN_VF_RB_DECOUPLE_FLAG (1 << 15)
> +
> +#define MAX_NUM_VCN_RB_SETUP 4
>
>  #define AMDGPU_VCN_IB_FLAG_DECODE_BUFFER     0x00000001
>  #define AMDGPU_VCN_CMD_FLAG_MSG_BUFFER               0x00000001
> @@ -335,22 +338,46 @@ struct amdgpu_fw_shared {
>       struct amdgpu_fw_shared_smu_interface_info smu_interface_info;  };
>
> +struct amdgpu_vcn_rb_setup_info
> +{
> +    uint32_t  rb_addr_lo;
> +    uint32_t  rb_addr_hi;
> +    uint32_t  rb_size;
> +};
> +
>  struct amdgpu_fw_shared_rb_setup {
>       uint32_t is_rb_enabled_flags;
> -     uint32_t rb_addr_lo;
> -     uint32_t rb_addr_hi;
> -     uint32_t  rb_size;
> -     uint32_t  rb4_addr_lo;
> -     uint32_t  rb4_addr_hi;
> -     uint32_t  rb4_size;
> -     uint32_t  reserved[6];
> +
> +     union {
> +             // 12 DWords

This can be removed.

> +             struct {
> +                     uint32_t rb_addr_lo;
> +                     uint32_t rb_addr_hi;
> +                     uint32_t  rb_size;
> +                     uint32_t  rb4_addr_lo;
> +                     uint32_t  rb4_addr_hi;
> +                     uint32_t  rb4_size;
> +                     uint32_t  reserved[6];
> +             };
> +
> +             // 12 DWords

Same here.

Regards,
Leo

> +             struct {
> +                     struct amdgpu_vcn_rb_setup_info
> rb_info[MAX_NUM_VCN_RB_SETUP];
> +             };
> +     };
>  };
>
> +
>  struct amdgpu_fw_shared_drm_key_wa {
>       uint8_t  method;
>       uint8_t  reserved[3];
>  };
>
> +struct amdgpu_fw_shared_queue_decouple {
> +    uint8_t  is_enabled;
> +    uint8_t  reserved[7];
> +};
> +
>  struct amdgpu_vcn4_fw_shared {
>       uint32_t present_flag_0;
>       uint8_t pad[12];
> @@ -361,6 +388,8 @@ struct amdgpu_vcn4_fw_shared {
>       struct amdgpu_fw_shared_rb_setup rb_setup;
>       struct amdgpu_fw_shared_smu_interface_info smu_dpm_interface;
>       struct amdgpu_fw_shared_drm_key_wa drm_key_wa;
> +     uint8_t pad3[9];
> +     struct amdgpu_fw_shared_queue_decouple decouple;
>  };
>
>  struct amdgpu_vcn_fwlog {
> @@ -378,6 +407,15 @@ struct amdgpu_vcn_decode_buffer {
>       uint32_t pad[30];
>  };
>
> +struct amdgpu_vcn_rb_metadata {
> +     uint32_t size;
> +     uint32_t present_flag_0;
> +
> +     uint8_t version;
> +     uint8_t ring_id;
> +     uint8_t pad[26];
> +};
> +
>  #define VCN_BLOCK_ENCODE_DISABLE_MASK 0x80  #define
> VCN_BLOCK_DECODE_DISABLE_MASK 0x40  #define
> VCN_BLOCK_QUEUE_DISABLE_MASK 0xC0 diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index fabb83e9d9ae..858ef21ae515 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -126,6 +126,8 @@ enum AMDGIM_FEATURE_FLAG {
>       AMDGIM_FEATURE_INDIRECT_REG_ACCESS =3D (1 << 5),
>       /* AV1 Support MODE*/
>       AMDGIM_FEATURE_AV1_SUPPORT =3D (1 << 6),
> +     /* VCN RB decouple */
> +     AMDGIM_FEATURE_VCN_RB_DECOUPLE =3D (1 << 7),
>  };
>
>  enum AMDGIM_REG_ACCESS_FLAG {
> @@ -326,6 +328,8 @@ static inline bool is_virtual_machine(void)
>       ((!amdgpu_in_reset(adev)) && (!adev->virt.tdr_debug))  #define
> amdgpu_sriov_is_av1_support(adev) \
>       ((adev)->virt.gim_feature & AMDGIM_FEATURE_AV1_SUPPORT)
> +#define amdgpu_sriov_is_vcn_rb_decouple(adev) \
> +     ((adev)->virt.gim_feature & AMDGIM_FEATURE_VCN_RB_DECOUPLE)
>  bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);  void
> amdgpu_virt_init_setting(struct amdgpu_device *adev);  void
> amdgpu_virt_kiq_reg_write_reg_wait(struct amdgpu_device *adev, diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> index 104a5ad8397d..51a14f6d93bd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgv_sriovmsg.h
> @@ -90,10 +90,11 @@ union amd_sriov_msg_feature_flags {
>               uint32_t host_load_ucodes  : 1;
>               uint32_t host_flr_vramlost : 1;
>               uint32_t mm_bw_management  : 1;
> -             uint32_t pp_one_vf_mode    : 1;
> +             uint32_t pp_one_vf_mode    : 1;
>               uint32_t reg_indirect_acc  : 1;
>               uint32_t av1_support       : 1;
> -             uint32_t reserved          : 25;
> +             uint32_t vcn_rb_decouple   : 1;
> +             uint32_t reserved          : 24;
>       } flags;
>       uint32_t all;
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 88e17f5e20b2..bf07aa200030 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -176,9 +176,6 @@ static int vcn_v4_0_sw_init(void *handle)
>
>       AMDGPU_DRM_KEY_INJECT_WORKAROUND_VCNFW_ASD_HANDSH
> AKING;
>               }
>
> -             if (amdgpu_sriov_vf(adev))
> -                     fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
> -
>               if (amdgpu_vcnfw_log)
>                       amdgpu_vcn_fwlog_init(&adev->vcn.inst[i]);
>       }
> @@ -1209,6 +1206,24 @@ static int vcn_v4_0_start(struct amdgpu_device
> *adev)
>       return 0;
>  }
>
> +static int vcn_v4_0_init_ring_metadata(struct amdgpu_device *adev,
> +uint32_t vcn_inst, struct amdgpu_ring *ring_enc) {
> +     struct amdgpu_vcn_rb_metadata *rb_metadata =3D NULL;
> +     uint8_t *rb_ptr =3D (uint8_t *)ring_enc->ring;
> +
> +     rb_ptr +=3D ring_enc->ring_size;
> +     rb_metadata =3D (struct amdgpu_vcn_rb_metadata *)rb_ptr;
> +
> +     memset(rb_metadata, 0, sizeof(struct amdgpu_vcn_rb_metadata));
> +     rb_metadata->size =3D sizeof(struct amdgpu_vcn_rb_metadata);
> +     rb_metadata->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
> +     rb_metadata->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_VF_RB_DECOUPLE_FLAG);
> +     rb_metadata->version =3D 1;
> +     rb_metadata->ring_id =3D vcn_inst & 0xFF;
> +
> +     return 0;
> +}
> +
>  static int vcn_v4_0_start_sriov(struct amdgpu_device *adev)  {
>       int i;
> @@ -1334,11 +1349,30 @@ static int vcn_v4_0_start_sriov(struct
> amdgpu_device *adev)
>               rb_enc_addr =3D ring_enc->gpu_addr;
>
>               rb_setup->is_rb_enabled_flags |=3D RB_ENABLED;
> -             rb_setup->rb_addr_lo =3D lower_32_bits(rb_enc_addr);
> -             rb_setup->rb_addr_hi =3D upper_32_bits(rb_enc_addr);
> -             rb_setup->rb_size =3D ring_enc->ring_size / 4;
>               fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_VF_RB_SETUP_FLAG);
>
> +             if (amdgpu_sriov_is_vcn_rb_decouple(adev)) {
> +                     vcn_v4_0_init_ring_metadata(adev, i, ring_enc);
> +
> +                     memset((void *)&rb_setup->rb_info, 0, sizeof(struct
> amdgpu_vcn_rb_setup_info) * MAX_NUM_VCN_RB_SETUP);
> +                     if (!(adev->vcn.harvest_config & (1 << 0))) {
> +                             rb_setup->rb_info[0].rb_addr_lo =3D
> lower_32_bits(adev->vcn.inst[0].ring_enc[0].gpu_addr);
> +                             rb_setup->rb_info[0].rb_addr_hi =3D
> upper_32_bits(adev->vcn.inst[0].ring_enc[0].gpu_addr);
> +                             rb_setup->rb_info[0].rb_size =3D adev-
> >vcn.inst[0].ring_enc[0].ring_size / 4;
> +                     }
> +                     if (!(adev->vcn.harvest_config & (1 << 1))) {
> +                             rb_setup->rb_info[2].rb_addr_lo =3D
> lower_32_bits(adev->vcn.inst[1].ring_enc[0].gpu_addr);
> +                             rb_setup->rb_info[2].rb_addr_hi =3D
> upper_32_bits(adev->vcn.inst[1].ring_enc[0].gpu_addr);
> +                             rb_setup->rb_info[2].rb_size =3D adev-
> >vcn.inst[1].ring_enc[0].ring_size / 4;
> +                     }
> +                     fw_shared->decouple.is_enabled =3D 1;
> +                     fw_shared->present_flag_0 |=3D
> cpu_to_le32(AMDGPU_VCN_VF_RB_DECOUPLE_FLAG);
> +             } else {
> +                     rb_setup->rb_addr_lo =3D lower_32_bits(rb_enc_addr)=
;
> +                     rb_setup->rb_addr_hi =3D
> upper_32_bits(rb_enc_addr);
> +                     rb_setup->rb_size =3D ring_enc->ring_size / 4;
> +             }
> +
>
>       MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(VCN, i,
>                       regUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
>                       lower_32_bits(adev-
> >vcn.inst[i].fw_shared.gpu_addr));
> @@ -1810,6 +1844,7 @@ static struct amdgpu_ring_funcs
> vcn_v4_0_unified_ring_vm_funcs =3D {
>       .type =3D AMDGPU_RING_TYPE_VCN_ENC,
>       .align_mask =3D 0x3f,
>       .nop =3D VCN_ENC_CMD_NO_OP,
> +     .extra_dw =3D sizeof(struct amdgpu_vcn_rb_metadata),
>       .get_rptr =3D vcn_v4_0_unified_ring_get_rptr,
>       .get_wptr =3D vcn_v4_0_unified_ring_get_wptr,
>       .set_wptr =3D vcn_v4_0_unified_ring_set_wptr, @@ -2023,16 +2058,20
> @@ static int vcn_v4_0_process_interrupt(struct amdgpu_device *adev,
> struct amdgpu_  {
>       uint32_t ip_instance;
>
> -     switch (entry->client_id) {
> -     case SOC15_IH_CLIENTID_VCN:
> -             ip_instance =3D 0;
> -             break;
> -     case SOC15_IH_CLIENTID_VCN1:
> -             ip_instance =3D 1;
> -             break;
> -     default:
> -             DRM_ERROR("Unhandled client id: %d\n", entry->client_id);
> -             return 0;
> +     if (amdgpu_sriov_is_vcn_rb_decouple(adev)) {
> +             ip_instance =3D entry->ring_id;
> +     } else {
> +             switch (entry->client_id) {
> +             case SOC15_IH_CLIENTID_VCN:
> +                     ip_instance =3D 0;
> +                     break;
> +             case SOC15_IH_CLIENTID_VCN1:
> +                     ip_instance =3D 1;
> +                     break;
> +             default:
> +                     DRM_ERROR("Unhandled client id: %d\n", entry-
> >client_id);
> +                     return 0;
> +             }
>       }
>
>       DRM_DEBUG("IH: VCN TRAP\n");
> --
> 2.34.1

