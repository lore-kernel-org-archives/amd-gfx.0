Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A37FC433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 18:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2269A20771
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Yxa8ZiZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2269A20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 025696E303;
	Fri, 14 Aug 2020 18:51:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D96BB6E303
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 18:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkG6jwdfPuf9/mgEOmwZFJ5n7Ck1U5TRXXRCJ/9tqeeotZPASqj/c66XJNlv0VtohTeY9nbhTkCtzpcHUtlI3tg9C2V0kEEh8dN075jlcdLMbaGDL+Rb6GmHZUP2aYpbofWdjRXfzHxmj4q4G3JUtiKfsWwP0fezeqgQdGF5QYC5zpmOelyg8EmWFhpCGrM/ar/UYL+A7XAZYJ0CEBAS8QF1hLqCxitCIXqYT5K8KZIktyz9ysECrg9cMolZh8Z3AK+89ohUIt9vtD57rlWlnCMf5o6GDUU2rvPPehOWTYB36p83WqtfwiGa+P4qV0rxz9HFeJjvydA/kJjK5LZz0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LhmmjVnURpG/upCV0bLlyfRNiZoMdrwpgIOyy6CINU=;
 b=CxHzLjvqa1CANwZMIfhXaLXuIbfh0s6beH88By55lR6ZMiXXEHZO/8q4k1GhxvJCsFAHlNcXyBLOeEqQWToc/HiUKnekGzv9iQxNCJFZnQgSuk7mf4zeM8usj2UWd3IlVTTc133hhMBKiK2/3+Q5h/KT//q/iQI40IAXhtunVlnwmeeEdKObzAq6uisd6YbDk1JubDxu0TTnQVv3azZO9Sd6qvNXgQ35626hVkcbfIQuo4R0UiOq/Q5dH+NquKJPJZ9TSxGDxuWAs8CdXoGhUMiGswKiMOjYJCJDLsytS4G4TdhNg4cVKv3OucETuneH1pg33CcUGiDtz/5zZhG7CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LhmmjVnURpG/upCV0bLlyfRNiZoMdrwpgIOyy6CINU=;
 b=Yxa8ZiZjPV3J3fhwwkFVd9GUQIfHJgoij/TUD1S4e8vbCDYXTkopsFcR7oKpQF/WCfuGEk5ztp9Z2y795ZbeTgltGqO9FYRa3W4iJxmn7V0Gyt++WTt2JOjUAGmBjBdID3gMXbLZVmbVJ0QXnG9ckAsofamIOpPC/Ofsa8VbeCE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 18:51:45 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.022; Fri, 14 Aug 2020
 18:51:45 +0000
Date: Fri, 14 Aug 2020 14:51:37 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add DSC_DBG_EN shift/mask for dcn3
Message-ID: <20200814185137.yoocct2mmkeuajvk@outlook.office365.com>
References: <20200814165711.26394-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200814165711.26394-1-Bhawanpreet.Lakha@amd.com>
X-ClientProxiedBy: YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::30) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60::2db6) by
 YT1PR01CA0121.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 18:51:44 +0000
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b3afa066-9574-445a-dd08-08d840831775
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB012341F904FF9B1760C236CC98400@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XgFkJ3vuk60gal/q0UOuHlSoYgDPFmOxidhng9UYFrFe/NSEKTbrz7AhP7asELO0elf+1VfRyx3p7TjBhic90fekkvSU51pgZ3LR5u4Q3NDCuEyrm0GBJCOelA+Z92JExgUaWIUk0KC7O+Tn3G8/Ebe04R+JFkUf/wIn1aNr2fiC5riS0qqXkghFhpF6PQBtKg3UX5kMD1Wz13w1EO1gSAs4PuAr2d7jS8JsUZJdi9d22VclOi9daw3xIii1A3qfEH0MOXl3mvf4pWTleXhbdg1/vhujQ3HSHLcXF8iagcC/9RIHnuBvRa039TU5TOZhJg+V7Jv7sjd1fp80I6jjwqy79wDoN/bWixBC/6Ff34hTtnrI8KCJGyL/0+Ig8XZ0EjU8RH6a38ufXcgXxXtAF2aILywERyB9Ltq83M+jMM1+SPkH4b+TKRxfcc+0aOle0qKRrbMoCQ7vu5Fq8YwBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(1076003)(9686003)(45080400002)(186003)(21480400003)(8936002)(4326008)(6506007)(966005)(316002)(6636002)(8676002)(478600001)(83380400001)(6666004)(2906002)(66476007)(66946007)(52116002)(66556008)(5660300002)(6862004)(55016002)(16526019)(86362001)(7696005)(44144004)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: DAbJRpKlvhp2MmWfQVHW7fQOKsXTlxgRziWMOXGrD6SvkqC8Uq4VPWMumLGloY4pPK5asE8eszQE6NVlFYqvNk+TYdyV0IK4xWSEqGIDLdMV/mBBz/aE1SrKENNLm5XsqnoDgGsHrg0b/3d30BhI4+36pXKn7ji1ClIElegHqBjI28mQstz7ZzcdDgKFoFieIk1jENRYYSuchFW8smBPpoa0d655hHz75EP/ksW53sf0FSCLacwqKGyFbKdeShMELw2Ltq+ED84HTl9FlhZd1lnJojfilnkAZe+vn3mOHe3SCIsphUW/Ejgj23mwLqXD8jY3nSWXn14THmSUvt96t5cTI+/72r7f9T7ie8N7iZRWznde0r5G0z0tkqBzUpby5KE2XPG/YPTxhQIxty+uT7coYaznH60U6D59Rl1PcYF8TXPezdC6oMY+MDRw7WgxesdHhBXO+7Cn6XzCqqjvT/mA1j+mKKWAi/rVCzxTrA9QoSLnbC345G6CAJR3cEabKFJZZVlrzufxN1Lsj/yk/8VUAstXY6Oc927pDmZyaLRSiOskkqcZHvGnUM5kz0f+ZhfvaIQfwK9gbRtdk8+nJjxp4dh84k1vPK77zWtCF5609ZiqGeUmiImcUyoCIkhA9xf9juijNo+KNbxcYgB0vUI3wtDfxyEo0kIM6Ov5mOXBB86pDvqYX4X/QiBWUEP0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3afa066-9574-445a-dd08-08d840831775
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 18:51:45.2364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QROI10YMYN+HvUpJUYnUTd7hQBCUOl3MVXtcWxmPefhLAfbz2yQ30nCDL8Xcyg7E3gzNQnvqQ9/rfL8bPZBCKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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
Cc: alexander.deucher@amd.com, mikita.lipski@amd.com,
 nicholas.kazlauskas@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============2010876601=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2010876601==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lrubpxbhnc77ozcr"
Content-Disposition: inline

--lrubpxbhnc77ozcr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 08/14, Bhawanpreet Lakha wrote:
> This field is not defined for DCN3
>=20
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h  |  1 +
>  .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  | 22 +++++++++++++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h b/drivers/g=
pu/drm/amd/display/dc/dcn20/dcn20_dsc.h
> index 667640c4b288..1118e33aaa2c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.h
> @@ -94,6 +94,7 @@
>  	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_CLOCK_EN, mask_sh), \
>  	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DISPCLK_R_GATE_DIS, mask_sh), \
>  	DSC_SF(DSC_TOP0_DSC_TOP_CONTROL, DSC_DSCCLK_R_GATE_DIS, mask_sh), \
> +	DSC_SF(DSC_TOP0_DSC_DEBUG_CONTROL, DSC_DBG_EN, mask_sh), \
>  	DSC_SF(DSCC0_DSCC_CONFIG0, ICH_RESET_AT_END_OF_LINE, mask_sh), \
>  	DSC_SF(DSCC0_DSCC_CONFIG0, NUMBER_OF_SLICES_PER_LINE, mask_sh), \
>  	DSC_SF(DSCC0_DSCC_CONFIG0, ALTERNATE_ICH_ENCODING_EN, mask_sh), \
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h=
 b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> index 0e0319e98c07..ea683f452bb3 100755
> --- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> @@ -50271,6 +50271,10 @@
>  #define DSC_TOP0_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                     =
                                      0x00000001L
>  #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK           =
                                      0x00000010L
>  #define DSC_TOP0_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK            =
                                      0x00000100L
> +//DSC_TOP0_DSC_DEBUG_CONTROL
> +#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                   =
                                      0x0
> +#define DSC_TOP0_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                     =
                                      0x00000001L
> +
> =20
>  // addressBlock: dce_dc_dsc0_dispdec_dsccif_dispdec
>  //DSCCIF0_DSCCIF_CONFIG0
> @@ -50789,6 +50793,9 @@
>  #define DSC_TOP1_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                     =
                                      0x00000001L
>  #define DSC_TOP1_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK           =
                                      0x00000010L
>  #define DSC_TOP1_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK            =
                                      0x00000100L
> +//DSC_TOP1_DSC_DEBUG_CONTROL
> +#define DSC_TOP1_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                   =
                                      0x0
> +#define DSC_TOP1_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                     =
                                      0x00000001L
> =20
> =20
>  // addressBlock: dce_dc_dsc1_dispdec_dsccif_dispdec
> @@ -51308,6 +51315,10 @@
>  #define DSC_TOP2_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                     =
                                      0x00000001L
>  #define DSC_TOP2_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK           =
                                      0x00000010L
>  #define DSC_TOP2_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK            =
                                      0x00000100L
> +//DSC_TOP2_DSC_DEBUG_CONTROL
> +#define DSC_TOP2_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                   =
                                      0x0
> +#define DSC_TOP2_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                     =
                                      0x00000001L
> +
> =20
>  // addressBlock: dce_dc_dsc2_dispdec_dsccif_dispdec
>  //DSCCIF2_DSCCIF_CONFIG0
> @@ -51826,6 +51837,9 @@
>  #define DSC_TOP3_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                     =
                                      0x00000001L
>  #define DSC_TOP3_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK           =
                                      0x00000010L
>  #define DSC_TOP3_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK            =
                                      0x00000100L
> +//DSC_TOP3_DSC_DEBUG_CONTROL
> +#define DSC_TOP3_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                   =
                                      0x0
> +#define DSC_TOP3_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                     =
                                      0x00000001L
> =20
> =20
>  // addressBlock: dce_dc_dsc3_dispdec_dsccif_dispdec
> @@ -52346,6 +52360,10 @@
>  #define DSC_TOP4_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                     =
                                      0x00000001L
>  #define DSC_TOP4_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK           =
                                      0x00000010L
>  #define DSC_TOP4_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK            =
                                      0x00000100L
> +//DSC_TOP4_DSC_DEBUG_CONTROL
> +#define DSC_TOP4_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                   =
                                      0x0
> +#define DSC_TOP4_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                     =
                                      0x00000001L
> +
> =20
>  // addressBlock: dce_dc_dsc4_dispdec_dsccif_dispdec
>  //DSCCIF4_DSCCIF_CONFIG0
> @@ -52864,6 +52882,10 @@
>  #define DSC_TOP5_DSC_TOP_CONTROL__DSC_CLOCK_EN_MASK                     =
                                      0x00000001L
>  #define DSC_TOP5_DSC_TOP_CONTROL__DSC_DISPCLK_R_GATE_DIS_MASK           =
                                      0x00000010L
>  #define DSC_TOP5_DSC_TOP_CONTROL__DSC_DSCCLK_R_GATE_DIS_MASK            =
                                      0x00000100L
> +//DSC_TOP5_DSC_DEBUG_CONTROL
> +#define DSC_TOP5_DSC_DEBUG_CONTROL__DSC_DBG_EN__SHIFT                   =
                                      0x0
> +#define DSC_TOP5_DSC_DEBUG_CONTROL__DSC_DBG_EN_MASK                     =
                                      0x00000001L
> +
> =20
>  // addressBlock: dce_dc_dsc5_dispdec_dsccif_dispdec
>  //DSCCIF5_DSCCIF_CONFIG0
> --=20
> 2.17.1
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7CRodr=
igo.Siqueira%40amd.com%7Cc6285b82567b4565541d08d840731e6b%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637330210522549360&amp;sdata=3DPqUidLq7uHZZAw%2=
B78gvJ6jsnG1pmL5ywo5fT8u3A060%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--lrubpxbhnc77ozcr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl823TQACgkQWJzP/com
vP8ToQ/9GHHQw8d6upI5t65/L0AXyrq/oHhS0tGdXh4TaFyoR5wUnTR6xbdDBC2s
CjvJ6jqjLD66Vb9ngsEuftW3Nz2kLUnqhTfOj+9f5PtuWtHBWxHnuat24bMhQtzc
ZwGkOB3RGXhgI6eUBFBkXswYe90rNH9LOcijdrdavaIOKO7FE4oICjdvy4rtvWs5
WsS0gXk4YkhVf0tWULhTmVTDCmvNaARx8B2LOEnNe9mblEgUvPykUVgT/v3Aw19N
6cjnYiCtqfbFemEu1vMhBLeVQVi5Hyjeben3PS9oddGKWMFrJidQHWDVXQpzOey6
KAEfgnj6rX4315DwnwABcHa2XMg3HAMChpFYDV7hBGxE7x8h2G6nThwLXqJXqhZZ
boVDJtKPcw4xevINbGASedpI27S/YneF9iD4BK/u6KL6A9yVW/MfhYiSjkQoC6Py
Ll/R18boUF9TetfpulABCYeHILN3MoITm04hyVTXJB6KA0iYjyPaLZVET7VbWiBw
YXIMAqzio4EC+6at51iWgNB3grQtN27XXlEL6q+mNMBIvpRH36ActqxOkxUlutmd
zjM6ouqPo/am2xVCYIib6sx4UQgs9xAioPiAX1XZnw3rUv/9gAxs+VrQdML3yATh
rRUnHIW8irfcsznzQrJ2q7wzaFtjqDVX97GekaWut75XF9QlBUY=
=2ord
-----END PGP SIGNATURE-----

--lrubpxbhnc77ozcr--

--===============2010876601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2010876601==--
