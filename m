Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F599C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:31:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8B0560295
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 15:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8B0560295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C8B789E2A;
	Mon, 15 Mar 2021 15:31:24 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC76889E2A
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 15:31:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQvq1TEFAC+lLNKTYZUfTGroS9gEpfGifnMGMYzCaWuNLRwJpPxdznI2mnelSEtKjK05QkGTOEMIswokfdjxmKNUfUJdyt6wtNf5Kkc9w7YZjCEOKAovGh8lDKswrq7bG75mz/rY6eYZogaFeMzzllgf4kofozSCQEDc5VYwsWSvOpad6Qnwhirm6Afj3OKBiMkTUUVnJQ1MVwsVT+lP2mpGA30l0sTwmBItlqo5fZlSY5PZnxz/cipx8//IzhiJmWLMfV019ZJi97zxkZcfpV+C780RK6mvlqhv9IfwcjpCGJhj7tC47nAonFt+JsNEaEN2dJSe5EttFjiOSlbLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rlV+Q1QQGzU/BLIa3lq1ZxD/gDiQ4UYlZ4tqvcZpq4=;
 b=moZDTQ+fPkZ5L+dxGvUeAIaGSN67QaIR5XUNk8/0ujZJ9HSkAmN9R6QDvW0TEEWVWlfcpv3YGe9HdCNkRKaPYeuF14aKoRBA1a0gIIwEntziiGS+P/uPmYjws4rsB9qLx+HItM4tRW+/ajRheiZ4KllavffjSkE2mr4uLbZfPQNynvMKoXnTo/p+QBY9ziIGU2/ceQiqJGRUEnD3sYyXzRs4h6S63xNelE7dQfuuijC22hWvDkJvacL+Da8YokRjXVwVhWX3PeoIb/j8eFIpFTWQeRzOKDbBzecDE513tJKAYNB9tR3npVuVZeKaHf7bIQeXCXv6jsRaeNwABBUq1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rlV+Q1QQGzU/BLIa3lq1ZxD/gDiQ4UYlZ4tqvcZpq4=;
 b=PXtP4O1RgNld+b6XWPRpSRHYbb41MJrMMIxHvDFYexYQbna2kN9eF8wdEKumYzwkn1F9D4K7HVcHRc4ykLlV3RdZg8MsQELcOOzw2EGu+py+b1bU1ajJYhnncUXdBvrwpYR8DOcp2S200VY71mzV/JBX0Wx04nsGHD+QJ1KZ78c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2601.namprd12.prod.outlook.com (2603:10b6:5:45::27) by
 DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Mon, 15 Mar 2021 15:31:21 +0000
Received: from DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089]) by DM6PR12MB2601.namprd12.prod.outlook.com
 ([fe80::e887:3273:c806:d089%7]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 15:31:21 +0000
Date: Mon, 15 Mar 2021 11:31:17 -0400
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: Victor Lu <victorchengchi.lu@amd.com>
Subject: Re: [PATCH] drm/amd/display: Free local data after use
Message-ID: <20210315153117.2drqz7xirr6i6dn3@outlook.office365.com>
References: <20210311180020.1103668-1-victorchengchi.lu@amd.com>
In-Reply-To: <20210311180020.1103668-1-victorchengchi.lu@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:1c97:7159:eca3:52ac]
X-ClientProxiedBy: BN6PR11CA0020.namprd11.prod.outlook.com
 (2603:10b6:405:2::30) To DM6PR12MB2601.namprd12.prod.outlook.com
 (2603:10b6:5:45::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:1c97:7159:eca3:52ac)
 by BN6PR11CA0020.namprd11.prod.outlook.com (2603:10b6:405:2::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Mon, 15 Mar 2021 15:31:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1a248b07-055a-45d5-62db-08d8e7c76265
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35150F81428EF636CEA17BD0986C9@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JXaOy5zcvU8Mne+UOvXAGA/Y05KOwPNbaqb3bNEVrcuIj/spbZ55WvWdRRdRt/4+/xsF/LE2XJTI3xPnZp6XxPfQee0qDzJXA17scyCdClcFOXTz0DI2UWCu6gpO4A2U/zlWVgfcmkeHVpUk82fG+pIK5cOitbqnMwTki89lVDJV69vbgPKc0GIQf2K5jwTcCaBYw03eOCSn9sXYY8OeU1pDwInXId33C8sHjUWLlwvai3x+6WlM1wRy4s+eA7mY9Znio6J+cKTKjNEeSdaqm1V4GJ2Q+T5OHg2vpsVnq/E9UGYKjmgGncxZwpcZneA0aFuvdKlj718tSgZD7dF4N6aSTfmgVVfj+/zN47B3VR01PMVQpzjin47wxl9ykE6bggbNNF4JNK1yuDIDTpQ+W+FDvi7DbD4iPzL03Smd4wh/zxeo+ESw3d8Kuqaj+Rc76OUb445gWX3dkxdtLzEIlIvmGoxOc0vMSoWme3VvoRRnHmJ1u+xsTSuOUGRrVzT5q9c5dNJjh3SmNlqFrYf5K5GANSvVcp+xz/D7Dcnzr7TmZxzCPfn+geKKWslCZ/k0M+wWxAo3ZW1sUHUVELoXEUtSokadaeQBetThvERpQI3J2b6SV7nQ08i+JAYVBtVycI0OJ6yeso0XvkDt5IjfVJYbpMjT5OWzwAWo9hfVhSWkSaC9HnVMUpoqntjOrCjrAwu6t5BmgoEw2mzwHC59kmxFhEHfLh0BkTY0Cq+/Wk0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2601.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(44144004)(66476007)(7696005)(66556008)(2906002)(16526019)(66946007)(8676002)(6506007)(4326008)(52116002)(1076003)(8936002)(21480400003)(86362001)(186003)(6862004)(478600001)(55016002)(6666004)(9686003)(5660300002)(6636002)(966005)(316002)(2700100001)(505234006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?p5HJ8JMlTPmP2x4YYngbai6sM3XndZB4H1/NwxWKFk1dGEsi5dh4edtHa1sT?=
 =?us-ascii?Q?rOECYojhJaXt9xDhLs1Gi+OCi1HFMDiubod4KuAo9F+sushYFOPDLYHavFXq?=
 =?us-ascii?Q?EwBL22xq/fI3xg4PQjpQ4yh5hwl2FLzG1yZ1OI60THKc+nLKP/f8F7AkBNnx?=
 =?us-ascii?Q?6axHQueObiCNB3ROhE05HEC/N8RhD69oQuhCkqehX5kYsQb2iwEpdModUxdJ?=
 =?us-ascii?Q?Aa+tWskNrT+unZ2aV9z9tvaQSdMK/ePXDSah9WpaRr6lz7aLOTsAfRdF0wU3?=
 =?us-ascii?Q?md01GaKi5O3gD/vAOlSVoizkQy6XBkjrhuyyhHHTOU8SdCUlkdXb8F5eZ7a3?=
 =?us-ascii?Q?9diKWFZb1Au+8sKqA9s3IerpLtrkU84OKT/WvEnrQBrxsjSUbDWzTMPy0jCA?=
 =?us-ascii?Q?kF0LEzrCKedqjNCS816kJOe5a/7i0NUdfuz7gw8DX0z0ah9tt4IKgaE8dhQe?=
 =?us-ascii?Q?wdTBFS9e1rIYfA3tzUvOnjbVKjIqv5iUXYV8U2kvRVEKdb12wvA7vKm1HV8J?=
 =?us-ascii?Q?YsobQsoIxXhoi+C9puJSOkMCd9BbhDGcc4P5KwVtntc6HqMjeIOywGlohhkj?=
 =?us-ascii?Q?UfWWxFGj/mJBn0roTwta/hDUV1qxona37uNmyKgtNcwRZj/cFttQUbFNac0G?=
 =?us-ascii?Q?QZKahj5rAYe+aPzAn4gRUi+mnIwe1ISThewqZi/HetplVDFXWmPJILWOkW4e?=
 =?us-ascii?Q?UnYmLPRqUEgoZ1x33nreYyIYJ67vtC5b3MqspkveBk+w1oVWZcQp8mEsK1+4?=
 =?us-ascii?Q?mZ0/qsh0NAyDUOBhkq+FWwPtM3Uiha/mcLG7GXKG3ViGqqu7DUrCp6/FaNbJ?=
 =?us-ascii?Q?OkglioB2+45B4EXATRCJn3myEMuL/ZfIuyHoOQ8HWpNLscOguf/jSKhoureM?=
 =?us-ascii?Q?BYAZeRspsZFjXzSARnUj5pvMH6pxCp2NYGtS6E6L9mUIc7l9FRHYFNw/D0m2?=
 =?us-ascii?Q?zGx5DlQDjsbhCNkGsHDHvnAORVpWtWJ00a861z1UXl98EuDo258qP72ChT+6?=
 =?us-ascii?Q?LoR4goLQZkYjkyqnW6/68FaXT8YraArlbxuXkOB5+sZ51ASkQIPT9oI5eQDn?=
 =?us-ascii?Q?DZrncgofLU71k0mGZEUUzGnwURO971mqAo9Lvai3W0k3XUk2jnzJDSWXI+bM?=
 =?us-ascii?Q?IjzqVu+MbaFkuIaKv3rSBrfqek5v8UeBLioEKmPF2zZ5RG71Z1yUX3tWgNi2?=
 =?us-ascii?Q?qXJRat7Tnu/TrxAx4086PA1FHIDjcbi54u/R8De2aAga4B/Sl9gRDQdLwqEi?=
 =?us-ascii?Q?oiOve/HhKdg4fe2Lc67qcLlp4XsjBa9KvfL1bMbaNTg4PYlCZpWkS8MT5ZSB?=
 =?us-ascii?Q?72cMrHPM+tynFA7lWsNAYKujkbo4y/EQ37D0tyE/P/vRyya8KWEp6Xqw70jp?=
 =?us-ascii?Q?cv3/reRGlQg+0OmqFL8gZcCLbbba?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a248b07-055a-45d5-62db-08d8e7c76265
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 15:31:20.9824 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZGGus92BaOqd3vD9ZvTRl4+twXMhF+s+lH/VW5kzcaIU98+Fl2GoD7ETVxOzx+3reyF5ALLSSLhNKrFHZHdzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
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
Content-Type: multipart/mixed; boundary="===============0816413758=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0816413758==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fzui337pinzc5brw"
Content-Disposition: inline

--fzui337pinzc5brw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Applied to amd-staging-drm-next.

Thanks

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

--fzui337pinzc5brw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAmBPfcUACgkQWJzP/com
vP9/5w/9G6qb6P6AB3+bCYKaCacpyi3RIwVRaNOnEx4xjmXNqDhGeL/Hut6EfuSB
x+o7Vb7l2N0UY2WDQh/AWJSr6lrIH3rw7lefQlmg9a4zf3J7wn8X26v87ES1zl4r
dtXCUTrec9i3bb82qecJ1CBag1x5UPjIAjMohJcmwu8qb8Bzjgk2YxEbxdwGwV7x
JDl1NPWTcqXBEQhlELinVsI1j1edkPlbY1TIESxu3nIeOwYzvNRt9h4pQ52WGM99
+n0/VUb6n1ieTqDcHsdXj6y5Ssav++c/BlYPX+pEY3aE1UwK7tWkdXttIc2s20ME
6s33lsZABV2FEpVbkYQZ6Qig5OtV+YpeSi7w0ZJ+7baA3nWr5tD1UGg43MhTYjmQ
/7zllrdvZ/jj2tMeVNW7GauHRKJYbydxavPgoFUixfRSqAqddx+9tA7Fe9Lc/Tdl
2NMGkW3CXza7T++v5VOLqVl7V1ZgzFOPc1lXuYD9dL3HPM4sRLHcg7g1Wbi78Q9e
gIKSVzRCHDP7JdGudVFgCyGNCpCHEIU2Fgjx6IlSeOB+Rp9qy4X6EE6vWnwhSHzF
TFfcQj2hPCG/bdZYWXktzjnj34SYKRvu8adgy6OcfxLuitbkghuYGkJMoe7mOi0I
KsyETR2+tf+rWHtLiXKS4FF0AGUgvKqUVl29XUp/GjtQxEmjBbI=
=AXrA
-----END PGP SIGNATURE-----

--fzui337pinzc5brw--

--===============0816413758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0816413758==--
