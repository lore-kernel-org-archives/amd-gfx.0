Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE1C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:28:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C98E64D99
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C98E64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B496A89D7D;
	Mon, 15 Mar 2021 15:28:03 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6427A89D7D
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 15:28:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFnOOJbmgXpHpDJ1gw91BYpqQQsYedqmkEplIGqsoP6SjfLjUpfETDREklWBKyo9Yph2jWUjJqyILV18SCrclipzjfN/lA775wMvN4+FySDsGUncQk6O4D0cYzO/J5pUOVynPfqjm+O8Z3LZ5SqvcTmwibchDGyVEWQd/2MRkhj/otpZClI68MQy1MxYBTFXWBVCtz5cPB3/EfYTWTPYOXwIjorRLnZ7R45SGP7V9np3n1wEyB9H0QnsvHcuBi3ZTisdmWkT2CkthJPSioXZKhmDlJs5wbmAk7rUIDnepL5wB7PovC68rlsajgLAxQdtv1YNyo69ULPzreJgbrXZug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsgqyAby2D1ZzvrsIyxl0FtnQo/bI2u/3Te3vY1F1Ao=;
 b=c+koF2aEPK6BUKx3YAuE8I9JIk+pURn4PDzTVTQWKBf7pFJZHvng/bNFuYVSvqal1dU2cr1rxE1izPrpEdkhYuaYxTovd5xRVKSTAfFmcxY681MHqGS4ss0bN6Q6BKhicSo4tx79EgLSi9Lv/gyKTwFPRESxW4IMtRMqZva/nRoBktnCiZ/TbMpixFZlfrAw1mTIFnMLa+qjUxRwh0uSMIR789KdcsG/xTAXGCMiwlftHue6ZUTlIvtSYPnbDm2KwBOSDVcH21AEovZ+zeTeoc0+MJBQTz7nhnZ12f5Bk7uWwkUXgeGQhoJAHVBX+dpitfFd9f3wv05Ay0di8u7Gpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsgqyAby2D1ZzvrsIyxl0FtnQo/bI2u/3Te3vY1F1Ao=;
 b=tSwdVQuymvb8Hh4qKdoYEnOfkjpUwdnx7TfLyLRZpTdEEvDBcclXYCFeabjRs3ZELPMPkJKXN/aUw2jV4YJI12eRe5pXhjOHwuJeotXsZCyUG0DO0p/YOHEDatNBwaRV4ALYEtcleITzEaN4/2l7AkeYuuhpZ+6grnZNiQM/1Ak=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB2858.namprd12.prod.outlook.com (2603:10b6:5:182::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 15:28:01 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 15:28:00 +0000
Date: Mon, 15 Mar 2021 11:27:57 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Victor Lu <victorchengchi.lu@amd.com>
Subject: Re: [PATCH] drm/amd/display: Free local data after use
Message-ID: <20210315152757.jsli34keg5lecxbt@outlook.office365.com>
References: <20210311180020.1103668-1-victorchengchi.lu@amd.com>
In-Reply-To: <20210311180020.1103668-1-victorchengchi.lu@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:1c97:7159:eca3:52ac]
X-ClientProxiedBy: BN9PR03CA0289.namprd03.prod.outlook.com
 (2603:10b6:408:f5::24) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:1c97:7159:eca3:52ac)
 by BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Mon, 15 Mar 2021 15:28:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2deeeb67-cce9-4470-1b79-08d8e7c6eaff
X-MS-TrafficTypeDiagnostic: DM6PR12MB2858:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2858B321AB653B163C0F2539986C9@DM6PR12MB2858.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DBzVdVOXcJ5mR56dQW4jQIrI5DXNkJtECgvnl5GL9PV8YMYFRxzsDjwwowCrPR62WzaMzp4A93aUCjcQlP//cqtP+EHMP9d+dyvMSEmqlypiiMxc79ATv4vpqE1x8tVqVmwZyybPOdITa0VhpYmOFKWeoKt28kBiFQ4E8UTjRP/MRi1cgiyY4WmBuAQxGr6phcH0ww/CxRilWRMP1AH6fQuw1akXNCATte3HSEmTMlVJWlX9IGkqdjSvfP6QBwROrtT8VnKmhmhU2snnJdZMasV8C5r0qggqxWAyW5HUuUeXT5/Y6j3Llewg8bpvjLLnaaiLE8sQ93fFCXttfGWG1YSDJPhL62dKt3Q6qgfgF44gIvtwbhqpJCiC+f0tc80frmM5toNIB0QeqWuzW8vNrY813tdsA+whYXVTHXiCn1sJdpDPZNoKXZWG458nQ+/1efPSb/lQn6I8hDRzh0DHTGXcGR11W9WEAyEDq/SVuqbOGcaoxIkl1tO9Qk7dt6APX1Gn1xeF0vO0zYtPkEZXVMGPN29bx/SR83X7A6cbCE+x+7HxUxvooFfdVSA1EJGJBF92JfvHDAsYlm3j6xiErhvFqH5p777NPGITDjKcNz5+yZcyx7CTEVTIxQUza9sqCRZIO2UZfKvfaFU/eISYez7L+tJlZ1Fk3OmhPGrHDOCDxzgGbgmWKpL1ZOh/7Dl++230v6A1CKU8LnnH1iXVQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(186003)(16526019)(44144004)(55016002)(21480400003)(66556008)(6862004)(6636002)(4326008)(6506007)(66476007)(1076003)(66946007)(6666004)(86362001)(2906002)(478600001)(9686003)(5660300002)(316002)(966005)(52116002)(8676002)(7696005)(8936002)(2700100001)(505234006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QLJtMPC3AKyw8x+8TfHuD3d8n7/HYqhnLYocjU6xpsyry9+p9LS9r9nOLXzx?=
 =?us-ascii?Q?36vPkY5lcP3kuSC6hrkojStj8KTuV3zIEftKEwWB4fmWZ2NVMMveYHpZBLFj?=
 =?us-ascii?Q?qdUNCfhnhHTwRSbIFDrNeSD+zUn+tAImez+zmzdnUsEC37bpgTzZujNJdTWD?=
 =?us-ascii?Q?UcPvH6ArO4yNYet+mQMrn1fLobDavipKI0EJEoaoYs7CckwnTACERHgkR40+?=
 =?us-ascii?Q?g0gVOu1swZ+aUp0YUjKZXEHd3WwdUxVVtQf+VL2Jjkc9ckGvElJGBGMYE0hF?=
 =?us-ascii?Q?il8ttSfOWSB+6knyRCPY+tiIG+uJECTWSrbW/1ZI5AaMMMszdoSuhu1qN/cP?=
 =?us-ascii?Q?j70QefRrElfjzH0sdmrb+cYafgHT+W2s43fs368wZSv8VCrywgYHS8UzJ9Jg?=
 =?us-ascii?Q?+OlL7EqvhyfgMlQTopTYpZ8bEuVekxu9WZSNL3SzFFES2iMat+ZvmdW4ii4N?=
 =?us-ascii?Q?cAA+n3sNUnl5dqD8V29N5oiPHhpqTCkFu3nxQt4tXKGW4cKJPJVQiS0LOwZg?=
 =?us-ascii?Q?m1fNQn8GuEtR722/twH5PkaBoY8YIH7u62UcJ/i1cP9qCa3iWvyxpH81k5mp?=
 =?us-ascii?Q?ujx+R4Rxzep4ia2NQGFznwV1IurfsVXigmiokXXx+5j7G1IWsP0Acz12L2QO?=
 =?us-ascii?Q?9EZAx0cAuA5AUS3aoTaAJpkCmg7gBkHdamFVqqyU365JVKc58JvaLQ6Ydnar?=
 =?us-ascii?Q?lTqGkuI0lSwq5heMAfHpQhQkilX9G8dZVpyvl13at9xO/XBrPDtoElzyI2II?=
 =?us-ascii?Q?QCa4lLCJLFy72uWfRA8qgH7DaRDJhS3xQr07Ey8WU0wHzGnTcTiK2OHoRNw4?=
 =?us-ascii?Q?FMPAw15VQ9nYlrU4mzQBvz/3fG3zH/ERGL2Jd/UJJeVGWI4l0yB+yZuKBs3P?=
 =?us-ascii?Q?VgHqTFzGdxkShb/23s97dZUGhUbAwq2U7ahjcd/3JENsadnpxuDz6Gcv0xY8?=
 =?us-ascii?Q?+n0UAOZcyLrmnbVqeE9i9dezjTqTBCwtu8l3rk5BN8S6faPeVsVvguym+AgM?=
 =?us-ascii?Q?zMh2JmGNkcFdPdMiQjb1O6pGSr/jBCHN+R6+r+fzQErLChWeOHm8RRW4j0u0?=
 =?us-ascii?Q?jFoVwNQdlX6w2UwHVhMNHhEL2+Pbdb2q9QzWZUEN885MScUGLesvRD7uNQaE?=
 =?us-ascii?Q?IPUZTGjzHOOA6KTrwZF73zB42FStH+78kLZcX13PSo5UUeai5j5WpxON3xWX?=
 =?us-ascii?Q?WcLICZodeX+ojFhfFOb7Epwt94Y+FJ1T1bzH5KcOn+4K78z2tbSUl+Y3hzLY?=
 =?us-ascii?Q?BWGhkGbpacyRkOxdkMmZj8JqMx09EUVa+UFINDyAargU6/Kux1jpUryYExmc?=
 =?us-ascii?Q?CRtPf6/P7Fgv9uRjQoXuSPrTfVm/FTYAVzujRQ8NCTzKLg4fea5Hj2u+6P1O?=
 =?us-ascii?Q?H46LmCTYIoohSVc72/D4iRuhuuuP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2deeeb67-cce9-4470-1b79-08d8e7c6eaff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 15:28:00.7262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4eNaZk3uV2CMrxs91NkhQ8rGgb9wO8pUO5Cn1lYZem3aAft3sT8OW1t5iK4YB98iVTYG6D7Ze/K++yGj+m8Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2858
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0744070251=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0744070251==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aih34zvtsfeiqwxz"
Content-Disposition: inline

--aih34zvtsfeiqwxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Nice catch!

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 03/11, Victor Lu wrote:
> Fixes the following memory leak in dc_link_construct():
>=20
> unreferenced object 0xffffa03e81471400 (size 1024):
> comm "amd_module_load", pid 2486, jiffies 4294946026 (age 10.544s)
> hex dump (first 32 bytes):
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
> backtrace:
> [<000000000bdf5c4a>] kmem_cache_alloc_trace+0x30a/0x4a0
> [<00000000e7c59f0e>] link_create+0xce/0xac0 [amdgpu]
> [<000000002fb6c072>] dc_create+0x370/0x720 [amdgpu]
> [<000000000094d1f3>] amdgpu_dm_init+0x18e/0x17a0 [amdgpu]
> [<00000000bec048fd>] dm_hw_init+0x12/0x20 [amdgpu]
> [<00000000a2bb7cf6>] amdgpu_device_init+0x1463/0x1e60 [amdgpu]
> [<0000000032d3bb13>] amdgpu_driver_load_kms+0x5b/0x330 [amdgpu]
> [<00000000a27834f9>] amdgpu_pci_probe+0x192/0x280 [amdgpu]
> [<00000000fec7d291>] local_pci_probe+0x47/0xa0
> [<0000000055dbbfa7>] pci_device_probe+0xe3/0x180
> [<00000000815da970>] really_probe+0x1c4/0x4e0
> [<00000000b4b6974b>] driver_probe_device+0x62/0x150
> [<000000000f9ecc61>] device_driver_attach+0x58/0x60
> [<000000000f65c843>] __driver_attach+0xd6/0x150
> [<000000002f5e3683>] bus_for_each_dev+0x6a/0xc0
> [<00000000a1cfc897>] driver_attach+0x1e/0x20
>=20
> Fixes: a8e30005b47a ("drm/amd/display/dc/core/dc_link: Move some local
> data from the stack to the heap")
> Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index 9337e87a73e7..b60e0a4dc4bc 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1615,6 +1615,7 @@ static bool dc_link_construct(struct dc_link *link,
>  	link->psr_settings.psr_version =3D DC_PSR_VERSION_UNSUPPORTED;
> =20
>  	DC_LOG_DC("BIOS object table - %s finished successfully.\n", __func__);
> +	kfree(info);
>  	return true;
>  device_tag_fail:
>  	link->link_enc->funcs->destroy(&link->link_enc);
> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--aih34zvtsfeiqwxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmBPfPgACgkQWJzP/com
vP+nMQ/9F0thq692bZjRBlfgLCuXh5nVCLk3yyOUJ6rDunZHba5qA988RRWKXWnr
CITwj7a9rWAkzxCBxv29YsY1LvWYC+nsPjfjg8V8VpYk77OCPyrvBclMGsgm25Wh
fFKXmbxSivIKI33NX/YxZ0twCoRyiMATAezuVVPNXvThtcxEiMnbDta9fioBGgDD
CQyGekSWNRdVxYH+Ychj1NVQJ5RiBszajurcjUzRUlRKZubbvckvT8n0Jw1c7sUQ
XPojfE9DqzJMgtbTb/igiyply57t2Nv3zCxGSB5mZgsm1H3Wnx8VY2JN2jiJoM0T
0hvwtsPniBVSDSCaeQoZ5vyPqRX4zX0Tk2DjnMQtjrbe+v425O83OjohMaPLNmaJ
iR4AKVLZRfLivWW0HqlGDeRNKcyo2pJYDHxQmmwyQWqnw/wtcKAV+QqRjyeVY53c
sYOnZFDpZjs4On+jFusAZ9w3LaoNXH1NEgIQa5hoei1u8cf1+F3CRMhuGdDKPN3d
OEL8Udf9E+UGqbH/4ykktZne45bVv3Iac+Ssovb91Wx3mEIdGzdDKNNdoCEI1Dd+
MR50GEmcc97p6jZ8BXGayLFM+dLeDVjPG/FEqbQfzd++0YqaAkEzxbZ+tv20w3gH
lPoQNQ7EfTuahFIHS2TLEJaBj9c4D0ekSyiUcbj8TZTm3hRTYFw=
=FT86
-----END PGP SIGNATURE-----

--aih34zvtsfeiqwxz--

--===============0744070251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0744070251==--
