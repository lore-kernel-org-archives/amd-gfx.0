Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE56C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jan 2022 09:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DE44890EB;
	Fri, 21 Jan 2022 09:54:35 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A9A10E9C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jan 2022 09:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwcOezStRqG9dZ0ErHf+0vSBY5m0xnoWpc1TRjiHPpkIEecByq8Ee+xH7j4oLmXy06msFSkCmfkLmrFcJyzE/4qkcFDQLrDb20KNWNUUJitTvaEM6JVQWb64b3ZLLj9/Bd1JBY4Rhd1iX0WVrZNNWsAQchuPqmWselyN6GurvPOmpIMkydlBZrcC4UP421uydfknn/rTsreojkC+IvGMCoTzJEXIiU0eRdn089/ftVZh6Vpc2RiClL9aXGccmbxnIPIBjfsGSdL+FVNwP4yCWjj1SRrKTmNoZQu9EVGQxGq46sBTt0M2UShZJynYJafXmy/RLiAucm2GqSzdYGg+fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybe9SdtmB6Bv0FoB0fzzQyI5HDXBqLmyeUNt9wub+s4=;
 b=FsnM+mkesf8CnoMaoG1ppgNpNvD8geXw5fIpBYjcrZyJ1Q4kI/FwjeEHc/uk6LbJlBnDRMtFc0qu36okUazl/bk8Z7fX6tmAQT0WNqKQq08IYi25J0WJUfN4YXax2FFY33IhLtxDrKmBBwQHcnoRVY7eG4ZJJ6uGtEcgne1GFU+8Yl5TALNaR9e6N7yrq/SjJUgfjtiiBarBQLW1xsfCaZPwveLBnDUVDFzeMJ+p266kj+2qm7hmC7QI59e+hYj10X5boGRZfbAakBauya67rWqqEvGrq/OJxfmrkJyl1+1WUlezFEatRkbumMokqLMfGJBDR06sH/OrOi22YfmSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybe9SdtmB6Bv0FoB0fzzQyI5HDXBqLmyeUNt9wub+s4=;
 b=1atsoPNB7YlRhDK5HlQ7a4cmRJ9I2qeJG7qcUb2EcnEWcbiYUV6wNMm5BlrtlgPK2QLe188Q8jL2Kbg8k43mrF/p5RULOh/ClNeew6Mq5wYwsaHDzGxw6xyz8cOTMRBASjCCqOw6YchX15q1QbRc9maJoN6Fl1KX3YpFj/c2X5Y=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by CY4PR12MB1462.namprd12.prod.outlook.com (2603:10b6:910:8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.12; Fri, 21 Jan
 2022 09:54:31 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4909.012; Fri, 21 Jan
 2022 09:54:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Ziya, Mohammad zafar" <Mohammadzafar.Ziya@amd.com>, "Clements, John"
 <John.Clements@amd.com>
Subject: RE: [PATCH Review 1/1] drm/amdgpu: fix channel index mapping for
 SIENNA_CICHLID
Thread-Topic: [PATCH Review 1/1] drm/amdgpu: fix channel index mapping for
 SIENNA_CICHLID
Thread-Index: AQHYDqogPvII660ahEypj4LbYMtF5KxtO1rw
Date: Fri, 21 Jan 2022 09:54:31 +0000
Message-ID: <DM5PR12MB1770EE6792FDE748E484B12DB05B9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220121093439.29089-1-Stanley.Yang@amd.com>
In-Reply-To: <20220121093439.29089-1-Stanley.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-21T09:54:27Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=577ffc30-6e98-4545-b8e1-704a8d2101d8;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-21T09:54:27Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: bab8ab99-8d59-4d71-8a10-020c31b37534
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 12ccf645-424a-4bda-d4e0-08d9dcc405ba
x-ms-traffictypediagnostic: CY4PR12MB1462:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1462F657500CAEF1C2112546B05B9@CY4PR12MB1462.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z57AaCrl914TVD5PgVkV0Cc1wHHOY+m6mwjp97CA2qG+r7g4fc+Lb5PC3OccQYT4rzKkY9H91XNIB3bXp5qZ00xp22JIA8OXZq7Owuxpbjwwx1/lNOfYobsa8LpKbYp534+l+7F00boqDvd1iUR89x8JMoBCEtcUwFNY646NMe7D6gXUieSkphO2DweApuAWWsOElqcHWhFPupDqQuIKbcmpbeQST5BLkUP/1m3UcApUyME2QEJzb4At5XEvpXDiuCMV/OisJ80KVDbofYJP+zpIoOd92tfxIhtGyGfN3JWH/grkKLiYeEu8uwuIBZbKSb9WREE8eq3IS4IfFncNR9O1EckKhewuchT+7udpCmYjt7/FXS0MWhbt5NL85D2kaQBPjoTMr5dFGgIpwDVJLkPSttHswkHpirDw71vBo0RBUODfW5ZjKzrlSdS3on0EG82APEi81RTY3DVHibY9e09YTTsAZUP+1dxjm9HMcCIdLagCzgPv8+4JFyaEphhBbepB1SuDTTR8uvq6dPx/QFNsc+zPoedv8ZREzkek9dYn7hWCb3A9F3J+IfSpuqJzkLyo3MkIj4akjWlGrgqi4jRQFnG8OPuXZtC2P9ipkp7rDNvba/VjC52RtCPCcj5UmyymInCq0mTu6c4aaHRI7SccWyXAra8mHpNSF90Y+wCrcJKf/TlvKXzsvU9kQyqrBvTm5WgLpSpRYmjsmCKZfw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(9686003)(186003)(8676002)(26005)(8936002)(2906002)(55016003)(38100700002)(122000001)(38070700005)(83380400001)(66476007)(66446008)(64756008)(66556008)(66946007)(52536014)(316002)(86362001)(4326008)(33656002)(5660300002)(110136005)(71200400001)(7696005)(53546011)(6506007)(76116006)(6636002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LE0dZtsTNJ0qcVONkhtG2ySasawcjwcztWoWmPAY9F7KbAz3XWMF+Yj9yrCn?=
 =?us-ascii?Q?YgycWTT0UyCXmI0VOO+lKao6KDhYtdB1tYfSxIanQfLiXaAyUkygyyRxbTUS?=
 =?us-ascii?Q?z1pXJy3m3czIDpcEbr63a+4Vkhy5yfy6Q+zTxI4dKxS/OHk6XgwzhlHyObEi?=
 =?us-ascii?Q?0jg5reJfl5+asRJy4JCjJWJSa/qi648SoPRFJ1PSbX5mJ/BgXqX5DdTAYG4C?=
 =?us-ascii?Q?EJG2/K/xFygL6F+w3UGH19Bav6WFarqHu/pwMzGJvkhrzepuDDipdTvYV4+z?=
 =?us-ascii?Q?qsyrdD9rxdhyIqaGRM97UNK/qxZ9O2bSqL66OePSb4hEgPIPGtJFnInrh0T8?=
 =?us-ascii?Q?JGCClmS1pPeSHjyIQfdNdZfqf1K6IYjUGeSkqZGZsZgzBnYMRUUy2u0pVNG7?=
 =?us-ascii?Q?Zwo7hTit+liFFnMfokwrso5+fuvjBC+bhLIMIM5Wvbsu24EoPUTw7bHrRCL6?=
 =?us-ascii?Q?GvP59IoW8WvikQaLW3NwAz3X42HU1QdInM7TlOpgIPLx1QyzqoiRFoMnzMkD?=
 =?us-ascii?Q?KaMs8YNkCgt55soM4qU3Y/cII9dDaPhakxcnwHnuN5ej4tTqBam55UQujUTn?=
 =?us-ascii?Q?78PlWCMqYgmtbhhdNIDiLfDrhAo/OFREjzI5Dew5vb5ttnFQ+fXoQV4PyLIP?=
 =?us-ascii?Q?ccaJ6AaLvB/EYbIJqu1EXhGJAfA3owjWY6e2+6PeygfylHkxZrxb8Wn3eu4E?=
 =?us-ascii?Q?x4zJq4dqN0InK/fQ0sEQbWyalHvusvXVN2twMVlnfgjJb1VnOQQAdHISKgaa?=
 =?us-ascii?Q?oCAet+x+p9P/qiNopRgL6zqucNKfqiRT+fKqoSPHcx0CxhEql5zbHMIH7zUu?=
 =?us-ascii?Q?gTkpDHNFLa3OPPZkfDedgqJwL6h2S7AV1WRFoSELiwc5Kb64iy7bnjgflR/s?=
 =?us-ascii?Q?tY3+JXGb7cNJRDrMf4aGqKXcB8XwuIVBib7TqDwll+zDV9kALOLqVgzvisXc?=
 =?us-ascii?Q?/DygOXjdxLwHFlJhneMNFMZ1HpjBPW2ISxnrYFKysukjVY47tX8w5tMTCdue?=
 =?us-ascii?Q?Z/oGRjZKxKIyHCXY+ZA3NvVymZ6Ani7Ov+cpFq56r0WgJMp9fi2ZS5/TZmUY?=
 =?us-ascii?Q?Gb5e/AICvE4F10mIzHYS4V+bNVwcXfAW+kC5YM1dZMq7v/5BAVz7iiezknYZ?=
 =?us-ascii?Q?IVVKwt2vlj17ZuAZPq2CfizUU93PEgspLZL2pkxs44yv764D1ZvuEFdcUQwg?=
 =?us-ascii?Q?FlcH+KT6uKwTFCgY+wU8jiPyu2ObYRCjCDDsT1NlA+7FOuam4Up+hChQ6yRf?=
 =?us-ascii?Q?46ioKEg8dKOV0LMVXadKFRjGomSHEoUuCmlLGKGu7X5r9WMcoH7GBC0mfGhN?=
 =?us-ascii?Q?ozPSBLRwc5HJRVw8Klp/ZMQroDcH+JMgEPuv5a1Gbl0Eopt7bCv5ROhz0o1+?=
 =?us-ascii?Q?8BlpW9QOxtj4wZ2dUt/mOyrgzdW3KiTXaqfJPOgRQIrcvAqZyDmLbGtm4t7v?=
 =?us-ascii?Q?zVcOZqgfUztNIXFf3TG8AaOs03LQtM/j6AgNyrYT0GZrtpddb9RhFwWnVnKV?=
 =?us-ascii?Q?n/GhQ8wxP4xIrUL6a4CUa0+4wHzbfEyi6uJLguVa5ruyNxBFZT1/8uKQtNWs?=
 =?us-ascii?Q?kxfJNzlRvBbD26YWciQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ccf645-424a-4bda-d4e0-08d9dcc405ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2022 09:54:31.5748 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Wvf1ZLyh2Pg0ietoZWmxz0tMCUbhRzGZ+3DuUROIn58NHMyOhM0NjU6w/WhAC4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1462
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
Cc: "Yang, Stanley" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]



> -----Original Message-----
> From: Stanley.Yang <Stanley.Yang@amd.com>
> Sent: Friday, January 21, 2022 5:35 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Ziya, Mohammad zafar
> <Mohammadzafar.Ziya@amd.com>; Clements, John
> <John.Clements@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>
> Cc: Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH Review 1/1] drm/amdgpu: fix channel index mapping for
> SIENNA_CICHLID
>=20
> Pmfw read ecc info registers in the following order,
>      umc0: ch_inst 0, 1, 2 ... 7
>      umc1: ch_inst 0, 1, 2 ... 7
> The position of the register value stored in eccinfo table is calculated =
according
> to the below formula,
>      channel_index =3D umc_inst * channel_in_umc + ch_inst Driver directl=
y use the
[Tao]: use -> uses

> index of eccinfo table array as channel index, it's not correct, driver n=
eed
[Tao]: need -> needs to

The patch itself is OK for me, with the comments above fixed, it's:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> convert eccinfo table array index to channel index according to channel_i=
dx_tbl.
>=20
> Change-Id: I26c3a99d161a00a69f7d00bd177942b6cd65a0de
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/umc_v8_7.c | 29 ++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> index cd57f39df7d1..d70417196662 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v8_7.c
> @@ -55,29 +55,36 @@ static inline uint32_t
> get_umc_v8_7_channel_index(struct amdgpu_device *adev,  }
>=20
>  static void umc_v8_7_ecc_info_query_correctable_error_count(struct
> amdgpu_device *adev,
> -						uint32_t channel_index,
> +						uint32_t umc_inst, uint32_t
> ch_inst,
>  						unsigned long *error_count)
>  {
>  	uint64_t mc_umc_status;
> +	uint32_t eccinfo_table_idx;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> +
>  	/* check for SRAM correctable error
>  	 * MCUMC_STATUS is a 64 bit register
>  	 */
> -	mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>  	if (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1 &&
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)
>  		*error_count +=3D 1;
>  }
>=20
>  static void umc_v8_7_ecc_info_querry_uncorrectable_error_count(struct
> amdgpu_device *adev,
> -							uint32_t
> channel_index,
> +							uint32_t umc_inst,
> uint32_t ch_inst,
>  							unsigned long
> *error_count)
>  {
>  	uint64_t mc_umc_status;
> +	uint32_t eccinfo_table_idx;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
> +
>  	/* check the MCUMC_STATUS */
> -	mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>  	if ((REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Val) =3D=3D 1) &&
>  	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) =3D=3D 1 ||
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 || @@ -94,20 +101,16 @@
> static void umc_v8_7_ecc_info_query_ras_error_count(struct amdgpu_device
> *adev,
>=20
>  	uint32_t umc_inst        =3D 0;
>  	uint32_t ch_inst         =3D 0;
> -	uint32_t channel_index   =3D 0;
>=20
>  	/* TODO: driver needs to toggle DF Cstate to ensure
>  	 * safe access of UMC registers. Will add the protection
>  	 */
>  	LOOP_UMC_INST_AND_CH(umc_inst, ch_inst) {
> -		channel_index =3D get_umc_v8_7_channel_index(adev,
> -							umc_inst,
> -							ch_inst);
>  		umc_v8_7_ecc_info_query_correctable_error_count(adev,
> -							channel_index,
> +							umc_inst, ch_inst,
>  							&(err_data-
> >ce_count));
>  		umc_v8_7_ecc_info_querry_uncorrectable_error_count(adev,
> -							channel_index,
> +							umc_inst, ch_inst,
>  							&(err_data-
> >ue_count));
>  	}
>  }
> @@ -120,12 +123,14 @@ static void
> umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	uint64_t mc_umc_status, err_addr, retired_page;
>  	struct eeprom_table_record *err_rec;
>  	uint32_t channel_index;
> +	uint32_t eccinfo_table_idx;
>  	struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
>=20
> +	eccinfo_table_idx =3D umc_inst * adev->umc.channel_inst_num + ch_inst;
>  	channel_index =3D
>  		adev->umc.channel_idx_tbl[umc_inst * adev-
> >umc.channel_inst_num + ch_inst];
>=20
> -	mc_umc_status =3D ras->umc_ecc.ecc[channel_index].mca_umc_status;
> +	mc_umc_status =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>=20
>  	if (mc_umc_status =3D=3D 0)
>  		return;
> @@ -140,7 +145,7 @@ static void
> umc_v8_7_ecc_info_query_error_address(struct amdgpu_device *adev,
>  	    (REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, UECC) =3D=3D 1 ||
>  	    REG_GET_FIELD(mc_umc_status,
> MCA_UMC_UMC0_MCUMC_STATUST0, CECC) =3D=3D 1)) {
>=20
> -		err_addr =3D ras->umc_ecc.ecc[channel_index].mca_umc_addr;
> +		err_addr =3D ras-
> >umc_ecc.ecc[eccinfo_table_idx].mca_umc_addr;
>  		err_addr =3D REG_GET_FIELD(err_addr,
> MCA_UMC_UMC0_MCUMC_ADDRT0, ErrorAddr);
>=20
>  		/* translate umc channel address to soc pa, 3 parts are included
> */
> --
> 2.17.1
