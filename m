Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D0F606A31A
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 22:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KQqL4nF9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF4310E0AD;
	Fri, 23 Oct 2026 22:46:40 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8256010E0AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 22:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9hDOHp6i10QtlZhDpo7m/GDcQ6FSkrj90ldEpRc7cJiYiFWoP54JEm9KSbXKxNZ0prNR5oBCGvnmXF0PpkSOTmd/A9mDA5rj1DLfCna/KhunvGcpbVLfwVNbbk8KhnX5CtVtLF2Afn153K//iX3OyU01TujcYbtPNKGqjAcBPGegwU2ovFabsXsNmtH3YzADZBsHD9Ssuu/KLhJr6foY+E76YnkHQrTlkkeYrAq/DmNxZlg6nn5k4mVT6lRdVNVG72XN1+sBBXUYyYSmHWneRzDD4OgXC+luMXMX5gVSCvMPvYBDP8bbwxd6QKMNM7jbDY4QtBWVrHaAeLwcmA4Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR4B+I7bloQS2GRK/bAA5sSKGahnLSJ1bWVF97rng4c=;
 b=CRjPbH8/1dmYdhQC0lYtaXXhkLSwDiluYqUZYfYlZysaBjYw9L6yuM5x6n4SHE97OHusZ/EKPOwSfdrok6nVFiDzwW1NwVJAS8iyimI7nzhT91ojKyD4aswwWnl35gW1Asm66rbxp6nYaVt0zqNvzzkigpN+Wy1827q2pwI5eU6JhrgeiIBSKRwqqtX5HRT/orMPaezu0oNtfimp30+A+u4ei2pofwGEa6osSHO/UOhx3z7KQutWI5FrMDWS/K8oWFPEOSNDIhyumgEdHKDQgRx7OM7+8OD/SU9Z33C/O/9FuWbd7awtA1NrwKUXtiRlZqRhQjQcibQBKQTOUeMUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR4B+I7bloQS2GRK/bAA5sSKGahnLSJ1bWVF97rng4c=;
 b=KQqL4nF9/zJfPbKkuAUeQinvLl4bF5cFH4q4wB1y6EoEY8+O8xKhSyV8ZFegHg6Lrbe2SZB00nUm3+OgkKulLT2J41J+kpv0dWHxMe9KIbCKv7HqgvsTTD1pJEnJyvLrT54u9XsMrEZYGiMSgAQrBjRNANtO/7gxU8bOBy2Obtk=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by DSAPR12MB820198.namprd12.prod.outlook.com (2603:10b6:8:51d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 22:46:31 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::234c:7f13:920d:3cc8%6]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 22:46:31 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Liang, Prike" <Prike.Liang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Prosyak,
 Vitaly" <Vitaly.Prosyak@amd.com>, "Liang, Prike" <Prike.Liang@amd.com>
Subject: RE: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Topic: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN
 idle work
Thread-Index: AQHdYslo88eLyLqXy0GjsxTisxnSPbcLucaw
Date: Fri, 23 Oct 2026 22:46:31 +0000
Message-ID: <CY8PR12MB7435B329FCC59091483D66E4E5642@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20261023083422.3049246-1-Prike.Liang@amd.com>
 <20261023083422.3049246-5-Prike.Liang@amd.com>
In-Reply-To: <20261023083422.3049246-5-Prike.Liang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-23T22:41:42.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|DSAPR12MB820198:EE_
x-ms-office365-filtering-correlation-id: 2185385b-d4bd-448e-1ec5-08df31577b83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|42112799006|23010399003|376014|366016|1800799024|38070700021|4143699003|5023799004|11063799006|56012099006|260925022911599003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261009220027099003|261009223327099003|261009221227099003|261009223027099003|261009221727099003|10067099003|260925021911599003|260925021311599003|18002099003|22082099003|3023799007|6133799003;
x-microsoft-antispam-message-info: b/iq6F3PVc+lDEUJlsQAC0MudhmfyiKCO01bYohXecWAU9w4y9bt0M/X7D+VTjEnWF1bNhBzEXjCz4qLtqdBsJTyeih7BlM69Q9fUwRbsX7bNz9vTkb3ZUnA91vTJ6pnOaroA0MysZhCrViPQjhcnAnyBQXbzjfs/OW4MCDPfOfKFVmgOB2rVep8+xzfxpo0TERHmuV1qLbHFkQogdh93/NqfovOYPgHP9X0hDPl1qvKd7ncwoLVAT65m271zX3HYm7Np+Zc8HrlcfNxbJRSHl/jY1NGgiHfwbQd8Pd+pRUCBhjBxM0TSSsr8zQ2kswUBbtssUw5hFAOKGK7pMbaFtLo7a5dkCjbRk9aHaSjbase+mhWnQIM9syOAIhLhOkbTL+Hs//I7WFqMs2z5zck402cL7Y97MgTfEIDUWakBNh+i+mtnvAKjQxuSvX9rUhNTCtkixgdEeNFiUl007bC2tbcFbcqRn5xoDIkGYjRDvhi1PCmcom8rVUd3TxG8Rntu5GF/TOrw9Ax6/5yiivSAena3HxOkl9/3QYtf9nyVKbCISCGRGjJ7LoICSA4rkUFgygbZqd8GOnGTHqbhX7y1+/9MCQUyGmjQ71i805Te388OKvk7GUmPpC7urk9nk7afiA6UYua6XhbZwvS6MRt71vGACJ9JrQObEIKIuQXtuM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(23010399003)(376014)(366016)(1800799024)(38070700021)(4143699003)(5023799004)(11063799006)(56012099006)(260925022911599003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261009220027099003)(261009223327099003)(261009221227099003)(261009223027099003)(261009221727099003)(10067099003)(260925021911599003)(260925021311599003)(18002099003)(22082099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wD4rSJE1l/fSXdLAw/wNR0Tbnsqo7NK8KvM1J86wVikgPZr0aIqjxnbF7E5V?=
 =?us-ascii?Q?8Sj+34b4o6IoRB0kE7g+jGNcH4BxJP2rbcdI3xRYqZAIG1t/5oJsxJRM6F6/?=
 =?us-ascii?Q?oe+HSdKj2MEwS5+ygE+21vwAXVo3l1lrOGf5A8hvF/8JuPIhoFb+Pdgmwwug?=
 =?us-ascii?Q?VnOHSqG5vsx7kl1tRP1TpcSt8HPRfLwPpvkQhuFrDWmRCgb6gn+gp0rsqnVA?=
 =?us-ascii?Q?zkQLX1AsmGyl3pInBHzgf/35RqWrv0tuAhA6RhINkdPfxeJ5aI3/FXNdi8JC?=
 =?us-ascii?Q?/oB7xrK9JayX3F+nNO7B6KmckHIQk0CZ2R4N0VW2GlV6Sw/M8bkPuOQESNLj?=
 =?us-ascii?Q?eCPd4cqdWuCf249/Z3TN6U2E3DTrPJJJ4adaIlcM91weR6PGVTG5BbgOJJB8?=
 =?us-ascii?Q?9Xx6iukSPCCL6uEftVRgM4TNt5XPG3+lPkX4ODD9eE2EanpYbNDwN1nuuvxH?=
 =?us-ascii?Q?Rhh8oLa2BkwF//X8LSUi436PFg7gh/4rUciUUqiOtDBvapVah+ItG1Ju/B+R?=
 =?us-ascii?Q?Bnx9hWmSu6okhFChJpeywGxRZpbpky2XZOOU7shYeh1uC4+GVmuTEUkUxKdV?=
 =?us-ascii?Q?JptvzipHRuqzNQC0cEYjSJplQ/7aaptFxcoRMvsENnxZiZw/xT3GP70QdT2s?=
 =?us-ascii?Q?Nf5mzSviUIj83KTLxG4e7FWUN44juZxfae224hk7acAOKIwG3ij0Z6wmE7Gw?=
 =?us-ascii?Q?0sDKGTyEfCaFi9Z/FmREz4yXiMeRZJbI2NRBweZNq7zOU0yJ80IHH7OG4gDS?=
 =?us-ascii?Q?MhvpfcuxRIDTirbkcvjgbm/uJgGawXupjRzw8ITJg8FW4fLOujtENYIKdXYX?=
 =?us-ascii?Q?fu4T0tmaoaB+dFQa4zp2SQYydRp98ltGLtbBTiTLdBZhQZeoWZdSH24K5VPM?=
 =?us-ascii?Q?ouYfV5F42COhDcajdBrg7dgPOdVUmhEH7bwSzIjnljWJawei5KKOlBnk10s2?=
 =?us-ascii?Q?sRXjkL+nDtVM1XcWzKdQznqslKXgO/dYhMqeX4ayLI4BtI8vhPqIakTaEvVJ?=
 =?us-ascii?Q?C7VDzpWf6lXpm+EVn89xywkD6CDHxuaCbNnnJzEnaTQ2DIWjjOeM34dryJDX?=
 =?us-ascii?Q?zgdaniQ8SMaFPO5mpmnBo0eePiQoToRn466U6lSw3cdP9+rkfz1Bks0+sKYy?=
 =?us-ascii?Q?XVjRLsGKWKDdiE2UJ9O6rArXpcGf8je97LCR8gSVKBq0XlhbcJfQXhbwbfzn?=
 =?us-ascii?Q?rqNM8yQ8ahfA/OA/eKV6IMtniJSCF94l57zCt18LGpu3bVsH+LZ3L88+5Ta3?=
 =?us-ascii?Q?m2VGDfCCPdvdsvwuskpUA/PkBEhELJw9/wE+s2WyKb79TM6ZFiFgL4gHAcou?=
 =?us-ascii?Q?D0B+V9ybWCBnvp+z8Hf9tkKf+u/wHMvnTxJ7isJSfW47PQJpUaExEqFbdO7A?=
 =?us-ascii?Q?qqloa5oMjaMFwLmsr+qSyo1RHwKqcIerm7L/FkaW2E+2SIP8u5stDAUmMA3/?=
 =?us-ascii?Q?oaSMSxQ/u+ZaHQJ9yMsUypgKKo4NRjwVu6VMPt5fxqlOQySfD3oSjsVoN4cM?=
 =?us-ascii?Q?IWOq6upu/PrVnFY0Y1qN2L1xOIL/7CXwfgP2+QOSLRbHfD5D/vZixSXdvtpC?=
 =?us-ascii?Q?mBUvmYoTn3mDCH8Ps6RkyHt6otjYGKo1nK5lJlsWM1lbz6QTnevufcr3KRdU?=
 =?us-ascii?Q?MWtJt6Kb1OUwY4pdrQmiILMpU6PdpokNFLU/f71E6S0X41zz6Dja7Pjp1coO?=
 =?us-ascii?Q?cqXnTJ4Y68ILRQa41E4jNEESpeJxVd6Z4q1rEx7rG/xBnAk5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2185385b-d4bd-448e-1ec5-08df31577b83
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 22:46:31.3776 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e7APz6KHr80FFch/uFtMVGgLkgGqg5O0cazGnxH6ptRGl8IoLGdLyZmZOASlaYRj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSAPR12MB820198
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Prike
> Liang
> Sent: Friday, October 23, 2026 4:34 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Prosyak, Vi=
taly
> <Vitaly.Prosyak@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH 5/8] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN =
idle
> work
>
> The common JPEG and VCN idle workers program power gating and DPG pause,
> so they must not run while a GPU reset is in progress. Recovery must not
> wait for them either, since everything the workers depend on then
> becomes a dependency of GPU recovery.
>
> Make the workers take reset_domain->sem for read, so they wait for a
> running reset instead of touching the hardware. hw_fini/suspend and
> begin_use, the latter for the IB tests, run from GPU recovery as well,
> so only skip waiting for the idle work when the reset itself calls them.
> The reset holds the semaphore for write and would otherwise deadlock on
> a worker blocked on it. Outside a reset the cancel stays synchronous as
> before. sw_fini always cancels synchronously, it never runs with the
> reset semaphore held.
>
> Update versions: https://lore.kernel.org/amd-
> gfx/PH7PR12MB6000698A62D208E47BB358D7FB662@
> PH7PR12MB6000.namprd12.prod.outlook.com/
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 20 ++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 18 +++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  1 +
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  2 +-
>  23 files changed, 58 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> index 87f879a2e4f4..2bddef322870 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -74,6 +74,8 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>  {
>       int i, j;
>
> +     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +

I think this is redundant when hw_fini() ran normally,  they are only neede=
d when hw_fini() was skipped - i.e. when hw_init() failed and status.hw was=
 never set.
Also, UVD and VCE should be covered as well.

Thanks,
Leo

>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1U << i))
>                       continue;
> @@ -95,9 +97,18 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
>       return 0;
>  }
>
> +static void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev)
> +{
> +     /* The reset mustn't wait for the idle work, which waits for the re=
set */
> +     if (amdgpu_in_reset(adev))
> +             cancel_delayed_work(&adev->jpeg.idle_work);
> +     else
> +             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +}
> +
>  int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
>  {
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_cancel_idle_work(adev);
>
>       return 0;
>  }
> @@ -114,6 +125,9 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>       unsigned int fences =3D 0;
>       unsigned int i, j;
>
> +     /* Nothing holding the reset semaphore waits for this work */
> +     down_read(&adev->reset_domain->sem);
> +
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1U << i))
>                       continue;
> @@ -129,6 +143,8 @@ static void amdgpu_jpeg_idle_work_handler(struct
> work_struct *work)
>               mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>       } else
>               schedule_delayed_work(&adev->jpeg.idle_work,
> JPEG_IDLE_TIMEOUT);
> +
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
> @@ -136,7 +152,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring
> *ring)
>       struct amdgpu_device *adev =3D ring->adev;
>
>       if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
> -             cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +             amdgpu_jpeg_cancel_idle_work(adev);
>
>       mutex_lock(&adev->jpeg.jpeg_pg_lock);
>       amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_JPEG,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 34e1242d66ea..631f9471be1f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -269,6 +269,8 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev,
> int i)
>       if (adev->vcn.harvest_config & (1 << i))
>               return;
>
> +     cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +
>       amdgpu_bo_free_kernel(
>               &adev->vcn.inst[i].dpg_sram_bo,
>               &adev->vcn.inst[i].dpg_sram_gpu_addr,
> @@ -459,6 +461,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device
> *adev)
>       mutex_unlock(&adev->vcn.workload_profile_mutex);
>  }
>
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
> +{
> +     /* The reset mustn't wait for the idle work, which waits for the re=
set */
> +     if (amdgpu_in_reset(vcn_inst->adev))
> +             cancel_delayed_work(&vcn_inst->idle_work);
> +     else
> +             cancel_delayed_work_sync(&vcn_inst->idle_work);
> +}
> +
>  static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
>  {
>       struct amdgpu_vcn_inst *vcn_inst =3D
> @@ -470,6 +481,9 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       if (adev->vcn.harvest_config & (1 << i))
>               return;
>
> +     /* Nothing holding the reset semaphore waits for this work */
> +     down_read(&adev->reset_domain->sem);
> +
>       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>               fence[i] +=3D amdgpu_fence_count_emitted(&vcn_inst-
> >ring_enc[j]);
>
> @@ -499,6 +513,8 @@ static void amdgpu_vcn_idle_work_handler(struct
> work_struct *work)
>       } else {
>               schedule_delayed_work(&vcn_inst->idle_work,
> VCN_IDLE_TIMEOUT);
>       }
> +
> +     up_read(&adev->reset_domain->sem);
>  }
>
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> @@ -507,7 +523,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
> *ring)
>       struct amdgpu_vcn_inst *vcn_inst =3D &adev->vcn.inst[ring->me];
>
>       if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
> -             cancel_delayed_work_sync(&vcn_inst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vcn_inst);
>
>       mutex_lock(&vcn_inst->vcn_pg_lock);
>       vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> index bea95307fd42..a6438950854e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> @@ -526,6 +526,7 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev,
> int i);
>  int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
>  void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
>  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> +void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
>
>  bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
>                               enum vcn_ring_type type, uint32_t
> vcn_instance);
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> index 72069b77f6f1..b048fd4b8b59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> @@ -177,7 +177,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> index 2968256d4cd7..f6a9258ae3ca 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> @@ -239,7 +239,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int i;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> index 564e40899df2..922711aa06a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> @@ -192,7 +192,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> index b29ca3a49939..fe7ab9cb35bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -221,7 +221,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>                       RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> index 0343a64595f2..f4896ad9d1de 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> @@ -455,7 +455,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> index 4da3f9c995c1..87efc3c2b9e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
> @@ -250,7 +250,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int i;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       for (i =3D 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>               if (adev->jpeg.harvest_config & (1 << i))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> index dcdb089b4308..91968ad26f17 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -189,7 +189,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> index f2debf6b6bd0..27116d1e9e64 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> @@ -326,7 +326,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> index dd0abce73687..7e068c2d4d6d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
> @@ -299,7 +299,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       int ret =3D 0;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (!amdgpu_sriov_vf(adev)) {
>               if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> index 8ddd12740a04..16daeb61114c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
> @@ -172,7 +172,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>
> -     cancel_delayed_work_sync(&adev->jpeg.idle_work);
> +     amdgpu_jpeg_suspend(adev);
>
>       if (adev->jpeg.cur_state !=3D AMD_PG_STATE_GATE &&
>             RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index 76793a5caa70..470d8f110799 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       if (r)
>               return r;
>
> -     /* Override the work func */
> -     adev->vcn.inst[0].idle_work.work.func =3D vcn_v1_0_idle_work_handle=
r;
> +     /* Own lockdep class, this work is still cancelled synchronously */
> +     INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work,
> vcn_v1_0_idle_work_handler);
>
>       amdgpu_vcn_setup_ucode(adev, 0);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index 7d2b9e4b913a..ba451f2a2534 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -322,7 +322,7 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       struct amdgpu_device *adev =3D ip_block->adev;
>       struct amdgpu_vcn_inst *vinst =3D adev->vcn.inst;
>
> -     cancel_delayed_work_sync(&vinst->idle_work);
> +     amdgpu_vcn_cancel_idle_work(vinst);
>
>       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
>           (vinst->cur_state !=3D AMD_PG_STATE_GATE &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> index 10ef5616b2f5..9dd4c313cbe7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
> @@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block
> *ip_block)
>               if (r)
>                       return r;
>
> -             /* Override the work func */
> -             adev->vcn.inst[j].idle_work.work.func =3D
> vcn_v2_5_idle_work_handler;
> +             /* Own lockdep class, this work is still cancelled synchron=
ously
> */
> +             INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work,
> vcn_v2_5_idle_work_handler);
>
>               amdgpu_vcn_setup_ucode(adev, j);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 0f4f4d66e2e4..3e85abd1e82c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -449,7 +449,7 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 4b7f7bbe18da..5b47a643d725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -374,7 +374,7 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> index 3f39aa83c319..5aa09c3bd79b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> @@ -417,7 +417,7 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> index f30f80c1b07f..9693950cd16d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -327,7 +327,7 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> index 7b7c3bc9f046..0c189063a6ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -291,7 +291,7 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block
> *ip_block)
>               if (adev->vcn.harvest_config & (1 << i))
>                       continue;
>
> -             cancel_delayed_work_sync(&vinst->idle_work);
> +             amdgpu_vcn_cancel_idle_work(vinst);
>
>               if (!amdgpu_sriov_vf(adev)) {
>                       if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index c9e990ab297d..3fa553fb41d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -364,7 +364,7 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>       }
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> index ed47ddd5b08c..eb13f792e25d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
> @@ -279,7 +279,7 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block
> *ip_block)
>       for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
>               struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[i];
>
> -             cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> +             amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
>               if (vinst->cur_state !=3D AMD_PG_STATE_GATE)
>                       vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
>       }
> --
> 2.34.1

