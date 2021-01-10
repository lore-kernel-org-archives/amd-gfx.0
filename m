Return-Path: <SRS0=WAQI=GN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D21C433DB
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Jan 2021 23:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73DFD22A85
	for <amd-gfx@archiver.kernel.org>; Sun, 10 Jan 2021 23:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73DFD22A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA44289C49;
	Sun, 10 Jan 2021 23:12:48 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760047.outbound.protection.outlook.com [40.107.76.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1378589C49
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Jan 2021 23:12:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIhyvqmyoXCPjdfcHb+H6zlSvw2yE1qJuN976FoHfPuDKtGyBW5qnotdw7cPadsSfHoIx4PFkJaR39YPUWl2PgzWjTgHut0mWtQd9RXKLnwhfUJghkBHI3syXQxgDBQD7bpQCrNGU9E7PdxQDWu12CZV9qMPxmgstAdJSTHd4P+6w4LdS4Wdby0c7wvWm3/IoUsFYPQ1z+HUHUMbnam9DbUeId+ZEf/lvn5auOWq1QFQESqsc3BMqKIWzTS8shhjDcwveRS1X9zPD7LkRcdHeycP/xn1AyBCsGvJjnm2RyGZXZXnxMPl/uZSzxOi3eiMHQQk3QfaPZ9OsrDT3gekMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8uFO6BKZ0Djm4Y/0neRjInpmXElgrZxmgHG3SLIiRs=;
 b=O9J0AiRJo6AQMHiPDYdA+nERGjTNvOEJN1wAiI+nXRDyrZpho0AQWEvgiQhbYSgqWfMQmO7Fn2UddN8ZnghULu34jMLxo0QeYdAkd2I8+P0euqJOXx0LA/yS2LPyCgkQV+lLfblEZFxKYX5OB5A7vtKxbd3j/dmL/ft/kuOdjAnZ1aDWKuwR7KAwVhDKNTovnY8/OJWHzt3vAmvEvb4c7b9cNwuX0d8apAMfDjf1ZOdr1qKCKMeJ49zb/sU+Kf8y/3u9EZrdf5bgx9N5G83NwOLLkpebUup0cuUnAdnI3SgBHRpDLMH8L7LU6NYuXbwzTLuMNdsrEJu3WKkExHES+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8uFO6BKZ0Djm4Y/0neRjInpmXElgrZxmgHG3SLIiRs=;
 b=JsGawoGRYQ53W0Sd00VQJ28uUkxpMavEcNalqjAaVZqD1YfeOdgpipcF3hcAbhfU33DsYukdojTAvRB9ZDAj0y6AyMbF4g6JfDuT37oV/srtSwaAyYKBb/j5fUYkyrd+hKoXAedOKQb4ZELctrrIpm72AgUceNV3on9G0yTFbds=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by DM5PR12MB1516.namprd12.prod.outlook.com (2603:10b6:4:5::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3742.6; Sun, 10 Jan 2021 23:12:42 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::1cf5:9c9e:7374:4540%12]) with mapi id 15.20.3742.012; Sun, 10 Jan
 2021 23:12:42 +0000
Date: Sun, 10 Jan 2021 18:12:39 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 06/21] drm/amd/display: Remove HUBP_DISABLE from default
Message-ID: <20210110231239.bkc3xlezt4ipitmi@outlook.office365.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
 <20210108215007.851249-7-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20210108215007.851249-7-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60:f821:e4d6:e781:8a0c]
X-ClientProxiedBy: YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::45) To DM5PR12MB1753.namprd12.prod.outlook.com
 (2603:10b6:3:10d::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56e0:6d60:f821:e4d6:e781:8a0c)
 by YTOPR0101CA0032.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Sun, 10 Jan 2021 23:12:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e04333d-6002-4496-d3fe-08d8b5bd3ba4
X-MS-TrafficTypeDiagnostic: DM5PR12MB1516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB15167B8B924A25205329F16198AC0@DM5PR12MB1516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRGxTGCcNeaI20o73ok60mrqD6LbHSY+rnIWqRZTLrcvhht8hr8sVKSTFnxTCf4DRjHtb4mCP8yhGJsXxZZMPyB7dzeO8nL3DYSd1eUaIFvBLfekRDY/jwO8+akCRXX4E/4QZ0g4MZu9e3uK3d8G/xZUiWs1bKPU/8hMgn8U/XtIPL9mdRv6++0sdR5lNdWjcwvJaWS4BcpQZuaRLvHI57klHdX1noMi/3SXy7bPZ1qAxwrEJvyp6qg215PlBbmJUZ3dAhjueCXhupSoAbxvxkgsyzMq2s7tpXcjv2CETXcNqKhCPMwFBYkcZ1lcVe82pPXzp0HqhGx3O7P6wJVtWyIIjwFitnSrL2PPbiZlqnopb6ssSEa13xpzXjW9Qf8jo9xG5j/uh6up1IL/NetdZt3ve5upzuuRJAkqAEjwbZQMZc45AVHPp31ai+0ohUQir3DokrgQZLl6pFu8LxBDWY0vY4h2nzN9N6o+LfLSxDGyQct8edPyGyYyIDtgYDa0vZPAGzWpVjEWtIK9L7FfiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(66946007)(66476007)(4326008)(2906002)(66556008)(9686003)(478600001)(44144004)(966005)(186003)(8936002)(83380400001)(7696005)(6506007)(16526019)(6916009)(52116002)(21480400003)(86362001)(1076003)(55016002)(316002)(5660300002)(54906003)(8676002)(2700100001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?lcF+q2UGAonW1ffB90zP+DP6b6rLsifhv3zjOQopPpe+lIsVQT0gur+/qD2c?=
 =?us-ascii?Q?82RUxEjkglfTEC6Qayx9U1rQCONCoyhww2WXsdCSzuFdhEYE3UJxDnQjUyHC?=
 =?us-ascii?Q?0aNu5nRq+UcO4wDv2n4DPkGuyh4XaUzS2MM7QET0sJ3bmd1Qop1AltzNSAGB?=
 =?us-ascii?Q?48fA0RKb1ocPvIl75wp4AmyBOjxVQu1X5kOUq6cCRbdbIy2Rufwt1sbnfpb+?=
 =?us-ascii?Q?h0IliOUIaoaDS4nRMD0s1UQ55/GGculsI7T6n0+umJRt4II3VHdrOj6OSWIp?=
 =?us-ascii?Q?qqbfR+nB5CDE0GPWQbiaHlRxyH/kT/foDaEpsdWQt4/FFbhZ/gsRA3X8Yk7I?=
 =?us-ascii?Q?XpOzXkdjp/cPHNZqkBXZXaMyA97lgo7tLURH6Wx4aUF8ihHyBFNQ+uulQjCw?=
 =?us-ascii?Q?7Zl9KVT22qgBUIGLGRPkO4n7agyRaMlErA03bsBSuGeP1r1depbSa7ZtmCZn?=
 =?us-ascii?Q?wFmXSpNUAl6vUVq4WVAnkih4XTlnoVmuUIMxvpky40gDqnj3U+jmVqdHWtni?=
 =?us-ascii?Q?sLuEq6T+2pgF350zvLJE2wqQ/fHPbIUafQcvDThWcnCi3xG6Y/DrMGlvKjkA?=
 =?us-ascii?Q?AK4bTOppf/KxnJwqPJkxBjB5uzcxB+qFQSNlkM6Avg2ZktYTjrt9y7LEJmNX?=
 =?us-ascii?Q?mOz7c6Ev4v+a518nz6lLCS6f54GaYrM7bfrGsgeAS8k8dVUFLSf7eVvC48ds?=
 =?us-ascii?Q?c9PUfarxnFWM+AILt5QoQSkAo/C5dNuiidlB8EkgKOXSzdQK9bfGEX+DFuCK?=
 =?us-ascii?Q?tafnyXYkBjA2HwMzlNzadRMzZR9U+Eg6YrduXFmiYkD3WRtTNeMBAfEEgNZv?=
 =?us-ascii?Q?Orkk5CsKqCYJBaRY0xv3lGpfSsRY5iYX+iImuwtQJCmQvnXYp3+pLsdW6g71?=
 =?us-ascii?Q?XrLDoNVmg/h2t9kWze5WaFH5eFlEUMcthZf2wvxOB1KRaMFP6RJXHD2WL1Ka?=
 =?us-ascii?Q?LVBb4Ov3de8LmSQHHia43H87f2krWt8vMdWp0lzuQCFwO31YUkTtg/SwJuvr?=
 =?us-ascii?Q?2BjJnKBhT5oArZo+v0ORBHitLFaOoglPodvbt9G0d+s8Fv1JFUJ/ZWCl32sP?=
 =?us-ascii?Q?p4jEwVRw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2021 23:12:42.4350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e04333d-6002-4496-d3fe-08d8b5bd3ba4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTN/ABA3gAjAUcLnnIXFJN8wff9vRF5eg4Qy56jLOvJwVq0zsIsqDhTJCwF72ZQfa5x+dbfTHTMcPz0R7HRnGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1516
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
Cc: Aric Cyr <Aric.Cyr@amd.com>, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, roman.li@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: multipart/mixed; boundary="===============1325724056=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1325724056==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqnqzzcs63fvbxo3"
Content-Disposition: inline

--xqnqzzcs63fvbxo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

After a discussion, we decided to drop this patch from the weekly
promotion. Please, don't apply this change to amd-staging-drm-next.

Thanks

On 01/08, Rodrigo Siqueira wrote:
> From: Wesley Chalmers <Wesley.Chalmers@amd.com>
>=20
> [WHY]
> HW team plans to rename HUBP_DISABLE to HUBP_SOFT_RESET in future HW
> revisions. Those future revisions should not inherit the HUBP_DISABLE
> name.
>=20
> Signed-off-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
> Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  2 +-
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h | 22 ++++++++++++++-----
>  2 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/=
gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
> index a9a6ed7f4f99..80794fed6e20 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
> @@ -450,7 +450,6 @@
> =20
>  #define DCN_HUBP_REG_FIELD_BASE_LIST(type) \
>  	type HUBP_BLANK_EN;\
> -	type HUBP_DISABLE;\
>  	type HUBP_TTU_DISABLE;\
>  	type HUBP_NO_OUTSTANDING_REQ;\
>  	type HUBP_VTG_SEL;\
> @@ -644,6 +643,7 @@
> =20
>  #define DCN_HUBP_REG_FIELD_LIST(type) \
>  	DCN_HUBP_REG_FIELD_BASE_LIST(type);\
> +	type HUBP_DISABLE;\
>  	type ALPHA_PLANE_EN
> =20
>  struct dcn_mi_registers {
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h b/drivers/=
gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
> index f501c02c244b..98ec1f9171b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h
> @@ -161,7 +161,7 @@
>  	DCN21_HUBP_REG_COMMON_VARIABLE_LIST;\
>  	uint32_t DCN_DMDATA_VM_CNTL
> =20
> -#define DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type) \
> +#define DCN2_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type) \
>  	DCN_HUBP_REG_FIELD_BASE_LIST(type); \
>  	type DMDATA_ADDRESS_HIGH;\
>  	type DMDATA_MODE;\
> @@ -186,8 +186,12 @@
>  	type SURFACE_TRIPLE_BUFFER_ENABLE;\
>  	type VMID
> =20
> -#define DCN21_HUBP_REG_FIELD_VARIABLE_LIST(type) \
> -	DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type);\
> +#define DCN2_HUBP_REG_FIELD_VARIABLE_LIST(type) \
> +	DCN2_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type); \
> +	type HUBP_DISABLE
> +
> +#define DCN21_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type) \
> +	DCN2_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
>  	type REFCYC_PER_VM_GROUP_FLIP;\
>  	type REFCYC_PER_VM_REQ_FLIP;\
>  	type REFCYC_PER_VM_GROUP_VBLANK;\
> @@ -196,8 +200,12 @@
>  	type REFCYC_PER_META_CHUNK_FLIP_C; \
>  	type VM_GROUP_SIZE
> =20
> -#define DCN30_HUBP_REG_FIELD_VARIABLE_LIST(type) \
> -	DCN21_HUBP_REG_FIELD_VARIABLE_LIST(type);\
> +#define DCN21_HUBP_REG_FIELD_VARIABLE_LIST(type) \
> +	DCN21_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
> +	type HUBP_DISABLE
> +
> +#define DCN30_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type) \
> +	DCN21_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
>  	type PRIMARY_SURFACE_DCC_IND_BLK;\
>  	type SECONDARY_SURFACE_DCC_IND_BLK;\
>  	type PRIMARY_SURFACE_DCC_IND_BLK_C;\
> @@ -216,6 +224,10 @@
>  	type ROW_TTU_MODE; \
>  	type NUM_PKRS
> =20
> +#define DCN30_HUBP_REG_FIELD_VARIABLE_LIST(type) \
> +	DCN30_HUBP_REG_FIELD_VARIABLE_LIST_COMMON(type);\
> +	type HUBP_DISABLE
> +
>  struct dcn_hubp2_registers {
>  	DCN30_HUBP_REG_COMMON_VARIABLE_LIST;
>  };
> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--xqnqzzcs63fvbxo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl/7ieEACgkQWJzP/com
vP+lYw/8DsV+UzVUefuYdgnW+BJ+Y2l3xX1nN+Q3OhG8fh0nLakrKO+lxLlOVOYt
K6iS7KB7fsRwhhky404n7YhZNk6QGiv5iBrNv6rIRZIbPzNmUzCogCTCCN9mtD9P
iZlBMyyOD7duE2pYK4XVaDj606Lvk3SbiDAAiO2pZb5pPIQgLQQnLcfro4Q5sBwE
8C23izLgW8bW/9V436bKNOftcfWY0vEGLHhbmgaPCiOk0XK1VcPtifh8xdag1iZf
Xg6xsS6n2y/f4yiYY7l5Z5hOtTQMTzG+s+0GArBhGqmO1paFxa86akgXk7BS0gBk
mEnYJxwc+104kXTqaTwTJp+hyeYQt7naPl/kQgEmmQhZXe9F1t93Wi6eWEyiX44m
IMIxfF8SjxrJTAMtr4xHfo79LTp5HMJJNMjjPO6JQDX3cIdVgAaqJOQv5IQUToAy
O6t+84bEG5h70pS4lapmdS++oW2XQ+n0NoJ7D0Eu/864rYGLpBWj2A2UcXsY6fr3
G46fym299Mee3j1v0dik4GypzAmr42wwB1ZwF3EdH52//DZwGUkaiSeG/9wfeDEL
U/sPn3G/zT9Fg8KaSEO+fpWyAI9GMyGQ2ktrTIo/CIzSGEbtNqQoedOhRqqz5BkA
eeiH6yJhFba+4TQgE3JwDyNLZeDLFEKPu+0Xn5X25NMc0GOcOvA=
=fhvK
-----END PGP SIGNATURE-----

--xqnqzzcs63fvbxo3--

--===============1325724056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1325724056==--
