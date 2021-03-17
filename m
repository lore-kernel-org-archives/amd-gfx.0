Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C049C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD1F64EED
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:40:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD1F64EED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF8B96E839;
	Wed, 17 Mar 2021 17:40:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42B36E839
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 17:40:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAgTIsUWOn+O2qS61svvM/3jzZQb9qmqiz2Nf6KQdQZaGefst85Q/cfsu0eTS0Z+YJGU1Rn3IahTnCpK4pMy/Reoo0ARn4GrMY5U67I4kmzx7Tbw+ZTMenkBHS8F4heeLR5bLSXMj1ErsPMFj7Vx6OezcScYEe65H9YjRaZNrLCqSTDehXQ61pZPtJiGPpu7va0nX9RiwFAaofN+NuQaHJYIn2BJ22CftyZoLoXO3kCeDwS+noFp7c1POJz/LzMq9RSRq2XThewuEToxcQkLORkdZWrfhg7JPJspVa8Je3f+DKjQRJ8GWASkotlKt1Y+MAuwp2RmtIidtILnuuZB1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn3EeAczlvXmalIlgU4cxKBfZ0Qpps6En5p8NIdKO0k=;
 b=F2IP5SoEizA/LeS5bokM2CBmciB6ha4f0+8LyUw9lM/cOwxg9MSjkHHvxgzuhsY9UcPTQQhAqoAEHpcwYpb+3FEiY+gGAuEZiu2dHd+ubnCUmD87E6k1tjUX8wMqKaRIprR/xWOhsuyRXdBSwTlZOvx+eyfqk7XdSd3AKnCK7FckU57T4g+JUybpoAHbatH6QdPYTImEjdsgg8nXXfv4tfKk+WtOvATNw+RTjThfUKOIagWa+d6LqZne3iJJEw/y1nGFzAfvqzGjQWILCbdodpoT3MFkuBF0TcaCFp3z9MKHeWgJThEOQfd2PB5RrldKwyMC/fSYDq/WePwirJ57gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dn3EeAczlvXmalIlgU4cxKBfZ0Qpps6En5p8NIdKO0k=;
 b=Vtcymd78XXz1dEpa8g8uJCzduj6YWcNc4ztJTEhcdkOTYk7vv3dd9RRGmEiWtN4dx6uJSggAF7bZbQGPcK60NLy5KzfLRvlIcwwrrmL2rToMGyL35Bgqyq+bTmvb3xQPp7UhmrCT+xj0EHJ62tu7sznQ7pXzjbGMUPCPEgZZC6M=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4620.namprd12.prod.outlook.com (2603:10b6:5:76::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Wed, 17 Mar 2021 17:40:38 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 17:40:38 +0000
Date: Wed, 17 Mar 2021 13:40:35 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
Subject: Re: [PATCH] drm/amd/display: Remove unused calls
Message-ID: <20210317174035.2uwtbiq4mr5w6hc7@outlook.office365.com>
References: <20210317171442.11344-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210317171442.11344-1-qingqing.zhuo@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:2066:87be:b836:35e]
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:2066:87be:b836:35e)
 by YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Wed, 17 Mar 2021 17:40:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4bb41e60-182c-4cef-c614-08d8e96bc73d
X-MS-TrafficTypeDiagnostic: DM6PR12MB4620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB462076270335E4968C12BFC9986A9@DM6PR12MB4620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bnkVTyEFyJBDvfNOlTGHfsWW5o7fIaRSDcpFfsVr9vh2cILPEzx+GbZulrx7OJEThAbNfvFHo4xhF+WLyjrHtelk9+ClYI6APbDffzpHqNIoCysDGp9cfK2YzMIpErOQI34aBi+80L9MwXCV6xvSUDPhLvnkzgZ3F3hFzQSLii5ve0LU+8E+q6WGPWBshkB+rzuusmnML8EBAEBQyU/yZxAI417M0sYs3IhmgGlKyBFwDn24sOLMjmDu61zsy2B/t2ovdBU/5S7+LhF5zPn5dIs3tfTMzn/M882skkiANpvbquHiQHA33Ooif2uhs6jrJEARTb4n2WPXtx65bmdBaLbnIFEBAq79TtmHeW4viutzeavT33N+3Act3vDV3O09eDp+bg+MwEdBidA1ck+Y5c36BzMLWdug20+JqnznGIJqhzBVboPynjUw3iEJTZ6nTqDpRcqjB0d+R/dd6/MSHNqyHYm7yiKO+RNMnXgslPqJd3BtnLwvCHKBp1Lb/07eCPjh2YWiE0pGBNoMWZn6QNI8hVh//3WQ1epvt3W07fEqIZuj4jEoPD4cIEP3VQpngbd6A3SzaYW1L8v1rtLfCTt2NEPyAwG3TRCSLLExiSJCr1+2A7P6zYEzNH+3WrKe3rNgNQcEHup6MA/xlZNi4Ac3WbEkpIAd2cO2byz9yN30eeOmEgqsl8UDBykFwAV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(5660300002)(86362001)(4326008)(6666004)(66556008)(7696005)(2906002)(6862004)(8936002)(21480400003)(6506007)(966005)(1076003)(16526019)(55016002)(478600001)(52116002)(44144004)(66946007)(6636002)(316002)(83380400001)(186003)(66476007)(9686003)(8676002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PN3SZNrhD9LBkjXP+q5FRmxBHgeRXA5dsn3jua2sglONXsx0m29WBCIPqUx0?=
 =?us-ascii?Q?f1VfmGWegkjAaEKJVonj8V+rX0l2Pqrm/p87ZtEqTk8BzoDxHFcq1AqGp9FD?=
 =?us-ascii?Q?GWK6jRiazNoADWBVbq9RV0XVBws7rXllZTbh3uD/ltbCFhrq5Mkr9/KA5xeB?=
 =?us-ascii?Q?rVFMEuOzzbXnLDtgdv29naHdLatcupePQqC0chMsjm1JYZVnYTsyHSfeJGEP?=
 =?us-ascii?Q?iZlNeTlnMcGkct5SR77xVyzB+D8AtqcbLPYCEelpZL4taP1vWPxbkaJcLgGb?=
 =?us-ascii?Q?ZcoxHRp2giD5oW9wYZdWliEHDx+JuJYCVx97zz0E1+QPGMn0psj3R8aUGGwE?=
 =?us-ascii?Q?YA2kAMORIuiEVb2wboovF5ZEv1gm4FidphzYLwriqe6+IVp518sRaI7pySqP?=
 =?us-ascii?Q?Da4T4qjkppdXtyMuDpdcWBc3HnzhcenZ9pufZUKMwnlpdZUmfSlaUSM5AFkm?=
 =?us-ascii?Q?aHeV6Uk4/5eruRO4hPhRKDc3IlTVjllHNrT58YYDuSsI2VYAlYCt1heP0MEh?=
 =?us-ascii?Q?M191ea8rac9eP9MVpjrbsL4qkZ7u29AJgqsyYRLVIpYt7VIdxLKD3GHimaLN?=
 =?us-ascii?Q?Fhy3MbiSfNumjKEaX3dG/y9iPuMpvCQUJT96HdOwEdR9F1jDSYXsdh8K1xc6?=
 =?us-ascii?Q?P2fwL7kWsjjHIJJgxWWGIysQh2uQRcz40P7/T48FuFlxpr9Cbw/vb8SmqdwO?=
 =?us-ascii?Q?sSQ2RmlCwo72zwF17Z/4QRuPxPYC8wDQpXdlP7LU+sCO+AGXDlXDPCs6waH6?=
 =?us-ascii?Q?xiUtJ+Qm1NoTVqds2cvjAk11OUU4g5xyaQu73efy1ynXXskpQKhzLHPPdKrx?=
 =?us-ascii?Q?PjNzZywtIj5MmNCrhMoTck9hJAvtB1EYnxnkxY3IE6mBmsb58L2ACRcxSvP0?=
 =?us-ascii?Q?MaQnIDNpclZ1FiErVU3oRF4m7QyTDacyyB7ItK1JC6d4HB852GeRAgenfMA0?=
 =?us-ascii?Q?YY4/kj8pBLGP9iR4m55XkDt4QwFsFln24im1Nkb/BYjbSmOkBMFyaAt+zJrW?=
 =?us-ascii?Q?L+cpO+AD4daSzf1g/2Yzsriysjggbzvp8V1iEZ454juYhXNW9x+eL69mb+ea?=
 =?us-ascii?Q?A2VSzKhNuuaa8kdZToJ3emN2Y96QzTvOZrNI3kXWXVD1/X8rmb9faLvJaAGe?=
 =?us-ascii?Q?9cNjgLu4ZX36ZrM6MS6J65BSlKjwEYKc+7aeR07YLqNwmVz0SUgeij7BBzBi?=
 =?us-ascii?Q?oKE4+51lE2A/p9hPcRfOvfjwQMb2nw105cvIzQn4OL9s0rleTG/FFlMNEDQV?=
 =?us-ascii?Q?WrDF70gIkh17ElE7XWsR2XyXguQ1HnK1KAcTtP4tIiDodLH7EZGZFQ1EAgDv?=
 =?us-ascii?Q?JEx1hsxJa6cPj2efMDbmuWmQHUekTcYT8EOszDEJz9vm0pQ7u4hLrLgtOUib?=
 =?us-ascii?Q?RK3hUm08bvX+xvNURrWfmV+6hjhW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb41e60-182c-4cef-c614-08d8e96bc73d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 17:40:38.8890 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhi4xBHgzdStFWU2XRJhT3p/EXWI/EysWg1WOBlSjZq70SzvPIhbKkyKQn1MShUTUGpJkl4WK3YFRpb+Dp3Efw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4620
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: multipart/mixed; boundary="===============2032428933=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============2032428933==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="czttqeorf5fruvsf"
Content-Disposition: inline

--czttqeorf5fruvsf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 03/17, Qingqing Zhuo wrote:
> dmub_trace_int_entry() was introduced unintentionally, causing
> compiling issues.
>=20
> Fixes: 53e9c0f651421136 ("drm/amd/display: Support vertical interrupt 0 f=
or all dcn ASIC")
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c  | 8 --------
>  .../gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c  | 8 --------
>  2 files changed, 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c=
 b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> index 48a3c360174e..3908ad929176 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn21/irq_service_dcn21.c
> @@ -278,13 +278,6 @@ static const struct irq_source_info_funcs vline0_irq=
_info_funcs =3D {
>  		.funcs =3D &vblank_irq_info_funcs\
>  	}
> =20
> -#define dmub_trace_int_entry()\
> -	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] =3D {\
> -		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
> -			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
> -		.funcs =3D &dmub_trace_irq_info_funcs\
> -	}
> -
>  #define vline0_int_entry(reg_num)\
>  	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] =3D {\
>  		IRQ_REG_ENTRY(OTG, reg_num,\
> @@ -411,7 +404,6 @@ irq_source_info_dcn21[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	vline0_int_entry(4),
>  	vline0_int_entry(5),
> -	dmub_trace_int_entry(),
>  };
> =20
>  static const struct irq_service_funcs irq_service_funcs_dcn21 =3D {
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c=
 b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> index 68f8f554c925..4ec6f6ad8c48 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> @@ -276,13 +276,6 @@ static const struct irq_source_info_funcs vline0_irq=
_info_funcs =3D {
>  		.funcs =3D &vblank_irq_info_funcs\
>  	}
> =20
> -#define dmub_trace_int_entry()\
> -	[DC_IRQ_SOURCE_DMCUB_OUTBOX0] =3D {\
> -		IRQ_REG_ENTRY_DMUB(DMCUB_INTERRUPT_ENABLE, DMCUB_OUTBOX0_READY_INT_EN,\
> -			DMCUB_INTERRUPT_ACK, DMCUB_OUTBOX0_READY_INT_ACK),\
> -		.funcs =3D &dmub_trace_irq_info_funcs\
> -	}
> -
>  #define vline0_int_entry(reg_num)\
>  	[DC_IRQ_SOURCE_DC1_VLINE0 + reg_num] =3D {\
>  		IRQ_REG_ENTRY(OTG, reg_num,\
> @@ -405,7 +398,6 @@ irq_source_info_dcn30[DAL_IRQ_SOURCES_NUMBER] =3D {
>  	vline0_int_entry(3),
>  	vline0_int_entry(4),
>  	vline0_int_entry(5),
> -	dmub_trace_int_entry(),
>  };
> =20
>  static const struct irq_service_funcs irq_service_funcs_dcn30 =3D {
> --=20
> 2.17.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--czttqeorf5fruvsf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmBSPw8ACgkQWJzP/com
vP+iXg//TllhLbvz0+zuhx5GicFBs6k6yd/TVO/98ALuewxySOuF2OkwgUGvMwUn
FT34jPGw0UposmKxsMn8xeYQ5SCJULNg3nA8NEjZb8oG0W6O2JJI8eLgT8GUdNmi
t2WgnQ2GGBZgszeywcGlWztdvWxvYDVi8VJKPm3DZL2tj8Iu4OGmdQZXEgTC0k4+
33S/Jk90Bn4EU0ysCu717c0gRA/xPATgl880A07TFfJNoZ4qFRclW5dwQmFYdm6z
2pzIeK3sJZ271Ry8YPNF2jeHf5NXBZZzBEE3KIM5aKeP262hoBivPZr6e1fV0AAj
r6g2fEMjz9ICPV794j4hm+Adg9zh0tyLSf92s4QZ9hRkcQBBhv71mFrTghP9wu+V
8zo/y9oSL7/pJyRjWiS2qu8JOYnxqMdZA/697Xkhv6TpG9Rx4OVnAHE59hD7kqar
XQft7tYrovc6c7fcA1UVn13WIZ0enF4nRamUGzG0Zu7u5IDqCAvtQgwpthslObQm
MIpg3+4cVKV1nSAeJL606TQPuQo357do0Q6ExXe4ZydpqYlQF3w/cgEkSWctSXX7
VLLxWCCNHInvYq4MpTnV1WszrdesCeYgDgISEp1QEeXTpvQmvU2ASn3esZUnAmaO
OjsLHd0UoZAFjsGwA+ot8B/G/SEqvMR8HUEptx8e45dDlwptVvk=
=n/Lo
-----END PGP SIGNATURE-----

--czttqeorf5fruvsf--

--===============2032428933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2032428933==--
