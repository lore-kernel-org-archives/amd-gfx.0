Return-Path: <SRS0=JvQD=LK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF38C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 18:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C56561209
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jun 2021 18:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C56561209
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C6E589FD7;
	Wed, 16 Jun 2021 18:01:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E670A89FD7
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jun 2021 18:00:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbJ928FKKxZImOwE15jp0Nsc7suQ4wplIP3FHTq6Kd/naTSQKJOC+VXyBmFjS11xZt9MRTnCgtbFLdf4mG8ynrvzDEwqLMOipf/rGx3RpKHCqwcmUpDFzcYhPun3rlTuYqAZ1Zk7x7rW9cwes4AV93b2upn+pKdBe13AOjW+HtpQQAoJD+yGkcPTm775JKgfFwPBza3cO00OG6QICkvenG9GjRYOjSi6DQKoQEjNwaABZ2DBDZqqzMlPDs5VjpMQ1VjvIltjyilgqJ8c8xY+GTUudxeUnIJ0lY1LWd+XugLa9UBd5fqDK8OcepZarTxM6sakmpDz/3TEXz7zCWwkNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NphGBkOzoRCb40ouVd0B2n0ejRlr/7gP+40WdISby0M=;
 b=nltnReCJG6qAbd/edwSPSCdq35rcG8mbxXaxaooy9j6oSRZaYknJX616vEWR6Ox2ii24ZppmN7o7fKimTmVwwB/QXFnrotCivPHbSkEf9m2U9MHIqzZ4OR+ch3Vq/Til1d3QaU18nMz8IzUE3ViYSo09wmoUqTatZpSX0iahhP0Hp8ELDYBDivUseYRynnGA3I2iSoiBRAUxAyBQ+yfULnGRMtUHCTU6YC9WQ/da+9JlyX03gepuKjt4DSMlcmKzTG5pbW62H0cKVbwROjGCBIBldjdkeh6AQkTbd+3H58nXT/nxDVv0sa/dcChLKpa7rn1SFvOpWsLX7VXTJuSJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NphGBkOzoRCb40ouVd0B2n0ejRlr/7gP+40WdISby0M=;
 b=f9LZKGf4Cpg/wI08Qfkj61URcXVsfutX1gMf4aH4YaFxc+jWkcnKncPUI8L6f0cCCF/8r6x2kYnYXDGSxUmDp7FNDlB6Ko6MrgWx+H6V8zsEeAJyUD8j0L37gAnwipd23fBfgXOHG3z+rHDUvJpAB88OSjIRvSweUgmkGJAMM2c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB4299.namprd12.prod.outlook.com (2603:10b6:5:223::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.22; Wed, 16 Jun 2021 18:00:57 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::5531:f7ab:4bd2:2925]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::5531:f7ab:4bd2:2925%3]) with mapi id 15.20.4195.030; Wed, 16 Jun 2021
 18:00:57 +0000
Date: Wed, 16 Jun 2021 14:00:54 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: Re: [PATCH] drm/amd/display: Increase stutter watermark for dcn302
 and dcn303
Message-ID: <20210616180054.ifbkvhrllwtsw4yr@outlook.office365.com>
References: <20210616144702.56505-1-aurabindo.pillai@amd.com>
In-Reply-To: <20210616144702.56505-1-aurabindo.pillai@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:aac8:4ffe:d73d:b22c]
X-ClientProxiedBy: YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::26) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:aac8:4ffe:d73d:b22c)
 by YTOPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Wed, 16 Jun 2021 18:00:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26358ea8-e47c-4878-19d6-08d930f0b103
X-MS-TrafficTypeDiagnostic: DM6PR12MB4299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4299AF39332F19502D81A87D980F9@DM6PR12MB4299.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AG2wazGZkLmEJYi8hyB81Uv2+qMWy7H0Db2h4JwUQzJpounZ4NlUY7jrfQjDYCIfwaWXd4N2yc57qs+jbEk0uK+acuMANOX8+yauT/6Qwn21nX2SLuV4AOivF9vOezLIVNRP0jnIkP3GdAkcgM9wTvkcqXwln27YbVUKKrzk08B8UZ1JRzKYdkdD47DXqup8eDPHdz/+xnlCXf82Zq7gcBe74IRU1siQ5tq1uU+bfbeqp6+gh4a/mfWG+ysE7IqBd28MhsQL42DXrhsOlrBusBwg49ZKkg1GJIMrucjVi2l+5j4rmmdEEAeqJjeJYpaqQ6YLqAL4vTM0Rd5IXD+jVEB6nip3xPaiaZAPF21VdAGJn2OJXSxOkfZua/eSSU4CSywZS3QS2otAdWUAkKRkxv2PBGsEfphOwJ//+oBRlx/zclDXLqWYsBbecFSEZDjSDl4pWKBAypCLMAtKyLlwaZLcdiQ9Rsiuib3TEqKU5hIKMkKEQPsVmlz9JQKY1exOheTfp4HDP6dfUk93/hDE7hJB100+Yph7o6W6jU7IwBYtAwppDjV4wg7SByZYahnvCIVB47of/RuMh9jX4HjfZUHOVKr2ikOmk/JW1KDvUJSYQ199LynO2Ikb2s1v7cEDx+y8txWEdcwi6D2OiZBDTMBXLFMNV8TmW5eKWpHUSOrGWdYWLMCbT386sHM/ulPiTyrrmlVQbmpHJ8CWo0c025dIb1YNPLMt8J5ltjn3TOGnnt2mL018ZzT4Yn/n7OEIp3fEyT0aBNviMvBxT9HDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(6636002)(8936002)(5660300002)(1076003)(16526019)(55016002)(186003)(86362001)(52116002)(2906002)(7696005)(9686003)(6506007)(8676002)(83380400001)(66556008)(6862004)(66946007)(66476007)(38100700002)(316002)(45080400002)(44144004)(21480400003)(4326008)(478600001)(966005)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mHEAna7MPV5K3wRdFOxD/kwrNdNzdcO58CMff/ZwITCWa9C6citMOyRiWUHX?=
 =?us-ascii?Q?oyMk2R3n+fUNkB+J/opqptEvfKz3QrYFgyl2Dq8E3j1CW2rb8oSMd7AbwVWi?=
 =?us-ascii?Q?r/+1SHUlynGoeTp2I1TTB/nyPnBQ9oSFc2k6fi5V1/Vb/8ct5Qcr/pzmmgs2?=
 =?us-ascii?Q?bP2rTJN4PbM2bKpwG97sZNE4k9N04HOQS/KoUUFiVY8NITjV3nAAj38rGPR+?=
 =?us-ascii?Q?qtPHcTja0Rd+h49tmY+IkQqMNQVBdcW3oSDSA9gznyu4WMmzIsBsgGq8NpJ4?=
 =?us-ascii?Q?S/Z2jI+jw050CW4CSEUDIAeWhZzMTDaYjdiWC57hOhQcyu1SBdHHMZ4Tief8?=
 =?us-ascii?Q?oWP3DrfuQtVh3nWuOp1YgAKO9dPo1LbVeKrjgnl4dscwxrr5VHvputfYbnLT?=
 =?us-ascii?Q?1SG9AReV+qfGkVPkjusatiziXYh/AFmdBcXM/hkU63qRV5OAvGUac9rsyud7?=
 =?us-ascii?Q?I/7HHWE/1R/4ZjSnb8MSdsMP9XYBmprgDIJGrrzGvooWDbIa1UcFkwOm1Q2A?=
 =?us-ascii?Q?XschgX8b3RbvrUd5pBQV+txu1EvjsvyG3Ja6twElkJYKAaIQbT5x5bhvkl8O?=
 =?us-ascii?Q?0iJ9hhz5UHOxnW+wQx9UkabqzIC8sr8JA8OlqMCfvTtzPFp0ijpY5sRXDarn?=
 =?us-ascii?Q?tJcn5NNgmBr44LeN75HbCqlqBCyAHZ9xtcKGzr8FMIf1Uv07zW8EiHmWV8L4?=
 =?us-ascii?Q?MfOPXelPzwgf3Ikg6uupVgOKa+obB9xLqeDQ4477VMZsgegICleasRrv7B0v?=
 =?us-ascii?Q?wMpf3+TjGvvNJ48xsBEyaUJU6pCz87NcdFwpZ1bptwUSPv1xpjrCH/6UElPe?=
 =?us-ascii?Q?nSNi5L3YJihM4e6293/11PZ+Umff9cL+hOCERdjRUiuA3gEmg2KVt4YQGZEd?=
 =?us-ascii?Q?554Dq90tVlREBoq9aBcmi1WwRTVBgUsl7N4BNv4Q9LXsPL7hU+6IFostmClv?=
 =?us-ascii?Q?qHctxSsRggit44rajDrIrDvoDdZ5Jfig8frZgf5M2EQEEk1cVstjpP7fOHTC?=
 =?us-ascii?Q?KJmxbeBw1xXWM/nbY2nq1JMt2DcFOZDqOGMohxfd7zkhYUwJCm4hiz4IrPO2?=
 =?us-ascii?Q?wg3yH9vNuA4yA3/af3aq7XVi4wJpABK7WiXyUdvkkgn4yaml5iR94ktWE2KI?=
 =?us-ascii?Q?Fb2Lg70PPSwufIUzOvH8+YAgtZet2POuH5v91/RLQEjER/K4/ikZkRJMEpfo?=
 =?us-ascii?Q?8L/3PX+16z2NInrgJ5gKyEI9a7NJi9nr4WiZo7jCeYgQxLEs2iY5hqN4Bwin?=
 =?us-ascii?Q?0cOy+ySDCS+KucVL+fxMW5zNP9SC/VlEH0rFjueY0oIVTpoda6RFkFX6D1MQ?=
 =?us-ascii?Q?TRigolSSGt7G/MoPo0QKP6V2r6VJWXbEUb/XbI1W1DtX1LHimrti+PBkVhZn?=
 =?us-ascii?Q?/Jvkw4RxYy8W6wbU06OUMrO4QSuV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26358ea8-e47c-4878-19d6-08d930f0b103
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 18:00:57.1369 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJahkQxOOWiTcKCME/4AE8Z7gtpDZ+WpXff9DsJU7ad2NF+73O8Y/uN5wXLHTKGhZwbKxxXJkKn7BITWlQBAFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4299
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1555400284=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1555400284==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hgl4zo32kl5anvq3"
Content-Disposition: inline

--hgl4zo32kl5anvq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06/16, Aurabindo Pillai wrote:
> [Why]
> Current watermarks end up programming lowers watermarks which
> results in screen flickering and underflow for certain modes like 1440p.
>=20
> [How]
> Add 11us to stutter exit & stutter enter plus exit watermark.
>=20
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c | 4 ++--
>  drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> index b16d19a25d88..628b227f0a13 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
> @@ -164,8 +164,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc =3D {
> =20
>  		.min_dcfclk =3D 500.0, /* TODO: set this to actual min DCFCLK */
>  		.num_states =3D 1,
> -		.sr_exit_time_us =3D 15.5,
> -		.sr_enter_plus_exit_time_us =3D 20,
> +		.sr_exit_time_us =3D 26.5,
> +		.sr_enter_plus_exit_time_us =3D 31,
>  		.urgent_latency_us =3D 4.0,
>  		.urgent_latency_pixel_data_only_us =3D 4.0,
>  		.urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> index 758f89ba0192..88b609c32b0a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
> @@ -146,8 +146,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc =3D {
> =20
>  		.min_dcfclk =3D 500.0, /* TODO: set this to actual min DCFCLK */
>  		.num_states =3D 1,
> -		.sr_exit_time_us =3D 15.5,
> -		.sr_enter_plus_exit_time_us =3D 20,
> +		.sr_exit_time_us =3D 26.5,
> +		.sr_enter_plus_exit_time_us =3D 31,

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

>  		.urgent_latency_us =3D 4.0,
>  		.urgent_latency_pixel_data_only_us =3D 4.0,
>  		.urgent_latency_pixel_mixed_with_vm_data_us =3D 4.0,
> --=20
> 2.32.0
>=20
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CRodr=
igo.Siqueira%40amd.com%7C80a7c82e99294a159f5e08d930d59d86%7C3dd8961fe4884e6=
08e11a82d994e183d%7C0%7C0%7C637594516309239608%7CUnknown%7CTWFpbGZsb3d8eyJW=
IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;s=
data=3DVgD4IVqXp5IMbFizvKTSwlFObtJ465nSX1hvWVKEnus%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--hgl4zo32kl5anvq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmDKPFEACgkQWJzP/com
vP+qxA//Wgd51/AXIMAOIP7ywbDY9uj9LDbTYyrRo1iniMQgcgmsEr6HY1/lQoWB
bKvAzm4MG9rTQnOwvRxBHnibDo8cj0Sv7qsusycVjpO60ubP28W5rTdxbBl56edj
IsGSj6vgyXQAGPre+p8sDvCKg9KUgGfZuupEtwMe1X1kCmAwOmvZJWfX1h9gazK9
TlN7YcVJ0V0vSZRYFB+XsdvH8QXLpTpPL4ZiIEGAU0RXRMQNc/1kmeDUMmcBgpuA
92dyaf/qmU47i50cdAHyuUT1AULy0KegJ2MEjC/tivL4JLeBWNJYYZ0nN7XwLteY
6WrGjzWN1M+ucpU09q9HADeFwc1aRKX5XzUkeEDRWfLRrz1UMoFevPZfZLAnTUDe
I3R9pKHZCZ3tahGBNxDVFUyQxARlQ/S9o5rp6kwwGiGs14hBizJ4czU4oSpcHFAa
fHr92+WqIClVKRmCWTMSnxhoks7XeRCL2clfxY/rgX/l3cfCpRlsqJCFQnZ6h+3y
Vn0+b0Zl3//8t/NUEBik8A00JPINZeOkQUPo5u7m/4NGnA5ofXK6SK77sHh+y5cD
VbgVwQ/m/xD3acSEFpLEl9avOkyJeM9LQZnDryNJo/CqWN2J52YONrWEySeMg3sJ
1gAPR0i6UfPjWkL2CF5DIntSQXZpp1VEshxHRMUBiWLWmcsF0rg=
=9OeX
-----END PGP SIGNATURE-----

--hgl4zo32kl5anvq3--

--===============1555400284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1555400284==--
