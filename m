Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36403C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 03:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D097310EAFB;
	Tue, 10 May 2022 03:16:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2043.outbound.protection.outlook.com [40.107.101.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5887C10EAFB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 03:16:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu5O9f3vMmsJ/Hi5Z4NODbakGb2lDaoDCFLs8GmdsM57D3/SPlCEEVKTt5vwOjt+YBoGGbDMLPH+2XNsioFaxw8NdX2ixJstKB9fDqlVjNk3WN39EwDezdDgs/kg1STPctLVml/uLgNW8YFM26AGF6K8Rq5Rvtv+cavhgsGjjcXD78BDgc8Anjw28WTzWJrxoE8U7jXw0/cRbi61EB7w7B27u2hinvzov3OFpw84RWKn0r/vpmSUbQ3mJilLk6CLjoi/hBRBZCN+U4zl+64vHtuU2l/mtDEVIhKX2OPSOQrJxbEtdxUg1p0SIIT5E/iUrzHx4qVpNI3yGDEP3JSOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qXr+gU5vL2OW92FRHO9T+4Eq6Or95jvm4uh3NcKXzk=;
 b=NxB8+wc+p2ZHZ3SklUDq0Jg4EuerGZVRvA+p0Dvpkmz33qDiXJ2fo6XzmfMbJKfWx2tskSH+m45KG4oC1FU11JR7RkfJS3K4sE6UOrau5azGyK+w4A7F+SH/fZVzTertj2/n7u2MCvA6ZkPK8WaeW9++vyRgd8p9SBJbqNJ+gfd6hkTvc5tPiztvv4AqAESNlethR0BrwQABvszMZSTMuMlvlG2ahJv92izwC5u/BtLvNWb7r/1XqsjSZ5BMAW58z8XZvMNzZ1j+WD+YhX9PRNd/r7zN96tsSYeH0jpTlPND1BfGLjEvEL++FRLoQ0W/EtuRsPHM6Gv8DxcciITluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qXr+gU5vL2OW92FRHO9T+4Eq6Or95jvm4uh3NcKXzk=;
 b=dqTx7b0bh7K7Xe42K+RQWup58G1b7q8I6jq4rfjGjmH5rVvKGTCVc8kwCkJhcK5r4ci0JLtX3pD3p5dLh+lc2t1ibDYj4rLvhh+9RRdh0LuS/Ilu2znSg4xmIoNO1q9Txvmw4q0voGCxLLvxJ2IHcnrXRpntyNP+anc83oJWSV4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY4PR1201MB0101.namprd12.prod.outlook.com (2603:10b6:910:1c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 03:16:14 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c429:9d84:9f6e:42bb%7]) with mapi id 15.20.5227.018; Tue, 10 May 2022
 03:16:14 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user
 changed it
Thread-Topic: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user
 changed it
Thread-Index: AQHYY9/17UGBaE8cqkmjAlqKA3T6Uq0XcNeg
Date: Tue, 10 May 2022 03:16:14 +0000
Message-ID: <DM6PR12MB261919A5B39C4D875597707CE4C99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220509200335.482514-1-alexander.deucher@amd.com>
In-Reply-To: <20220509200335.482514-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-05-10T03:16:12Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=15837066-f064-4284-99e7-71743fb332ca;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fc0ee6f-0c69-424a-65be-08da323370a7
x-ms-traffictypediagnostic: CY4PR1201MB0101:EE_
x-microsoft-antispam-prvs: <CY4PR1201MB010179D136EB9662BCD00CE9E4C99@CY4PR1201MB0101.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O1qx4WkrTk7PWxR5kJLK83bDZVDXG1nEU5T0JOJTaalDlT7JG7s8ZJFAysPTwz6TyDe+XTGUFDtmMJtrfi97MJ9QwNtDQ3NWJOP114q0an664leRi28cmJp8i8Xug9gR4IHWM+w9P/auvfFgRrA8Ov6Ei8/cWub3wJBIqCb593yRo5xmraC0YNVOJ+a1QavAqf9LIbybE7dNKnwkyCJjGPIsWmpF0Ghr5TfxlLKN5HFGZsTtXglk+mCOq5INK9ZaYQ56nYJff/0PBeAxMI2BJRefEwc9Aas2smRmm+oilDdVg5KklJ1mHRlFqNXuQ23/vy7O2h9ROzboiZBUANJm/A0j+Xu+F4SgFV459bPk3s0xFj6Ax0E/pBxh2OarpIURqViEIwKB0YC0wqqVlspCNcAlLWmXE1JYa4gonuqO9IEhvt5lytLWKxU1lglWFNWQR9P1BJsZ4mrFvPVwbY10Eq//5WN5NKv8AIrznruf2xqUAQcoXg9SezTPiSTQp5GQ9YTb1TnWyyaFsSldUNggIvvefRbLlzg+hBfA9jHQQ4ZP4a6+JpcsdL4M5lXVv+3/axtaPf+psxsB4GUCUBhkgMeQ+9E+r3M+hIsoQT3x1IGWtFblCT4GGCRaFerJtFzaPy/mBFmAszFCvFjrZDJd7ScXIm8suW4sABNXfbHLeRPHYdGcUK6iUdQCKIS3ahxTIpoc382KXpd86qyA+QQ+Bg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(53546011)(122000001)(38070700005)(83380400001)(26005)(9686003)(186003)(33656002)(316002)(8936002)(7696005)(8676002)(76116006)(66946007)(66556008)(64756008)(66476007)(66446008)(52536014)(4326008)(55016003)(5660300002)(2906002)(508600001)(6506007)(110136005)(71200400001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QcA5jM/W7woGoOPPQwipZsSmWIj2ra7RB72UD4redhISgWU9LzLN0piyR7uW?=
 =?us-ascii?Q?DCpe1C+4iDNKYR7LyECus4CsO1Q4EgxUf7WiwfXeRjz+7ZCUJsm6/kZxMY6P?=
 =?us-ascii?Q?Fh26CDiXWGFsK0iSZMVwggzteZ5WKzE9f6qlb/qsXw6lZyo+az+Wi+05Fuhi?=
 =?us-ascii?Q?NakEXjXIQIMUSKwiKtjqumonRm1LN+9wnoubJDW8Ub9GJt4PRj6pKNisAAUK?=
 =?us-ascii?Q?qSnfchJYhlswuDKuXtR7saOXSpD4opYD6zEtgNdkUc8q51VyKUxG6o++HSZJ?=
 =?us-ascii?Q?7OTcaNMy33y0GgEnKRJ2yCysCK3omHDGqm/9jdWO4GW+Y1E4Iu8knHkkfmnN?=
 =?us-ascii?Q?Wt0LfcTuEwq0EIvIND7azliiL67Wn3PDfxNCEf9033I0wCu8l/NUyOKIK1T2?=
 =?us-ascii?Q?KO+hstbpRqXKtvOW2ALuuNHGLUr4EiXd1SUoE/KCAM8pQ04Zd8ev0MVxB16D?=
 =?us-ascii?Q?nL/HNvtD9FJxtSAaUPyp+A2EBwNq9pqtZbZquMWlpbc4SRXtlPmCcY4SMDmd?=
 =?us-ascii?Q?9uc7d/8+jli1grsxNHqoJNjSEEumQtYz4QVEx4+p7ZUi6tAQEXSZjuIK1Q0o?=
 =?us-ascii?Q?dIXzXereHfzKyzECDMHvFLop8syBURgevK8Vl4TfdrTGsGI9Nphk1MlYbkcv?=
 =?us-ascii?Q?YYgHBXFYQvVV/o/Y+mwv6bhFQ+ZCIm3dCUI+vN5ngAzAoKqI16O0ea3sAnOg?=
 =?us-ascii?Q?93WezetvqcZex5tyBWN+3Rq8toeaWxuEJ09jwReNOF5z1BXKVGGBasFxuR3W?=
 =?us-ascii?Q?jScR59o0gsoOp7j7dsq7+Rsy11cAo8yCpNIen6gzkXsMcj0Ie31YvG58/6cL?=
 =?us-ascii?Q?oDnbgj2j7MeROxbNdW00M3fVdOZl5dP5Qppua0Sp8RgvAYUGBtxgK60ESFtG?=
 =?us-ascii?Q?Lj0ML0q1+5mqZkFwPr1QPtR9inlsOks3EiY1h+t5wYteFSYDgqK3BWdpVMnm?=
 =?us-ascii?Q?Nf8BINZqaYa9oL2tKmCKeYkQTtCdfFCcg48ztQ9L5IkxbaYP4JnPW56pCgQZ?=
 =?us-ascii?Q?jCeeAls2l+wURksjsmot5TmS6lJ26ta3jyHpLnpb04kbCZmA3+1ekwAGg0Hd?=
 =?us-ascii?Q?Q93MK68jcm8WqoYFayOshR5j8F2CdZtM3AFMvUPyftkaEe4aCas1cbKtqnlT?=
 =?us-ascii?Q?d16zTX9zHogkuigYVE5+KM6ZJCYH0SUwJgzqRoLk+nPJxqEurtNc4P9JCoo4?=
 =?us-ascii?Q?XXcXWuqhOdjUGMITJdlOZF1p9uwnuBvA3m8XIkDS0YGwNaKJFBnrdlHIIG/V?=
 =?us-ascii?Q?fBKQtrzigZmEe7knCgc+Spj5PajvkSsXKLNfcJNO3wmS6hPh/KYjibLYMlML?=
 =?us-ascii?Q?NMV7/djgZ2dklZIS523ECYm7swHRfhM+pFQkGaF/58YKTWuyR4Nu6IKiy7Wu?=
 =?us-ascii?Q?Vwa+aNuzQLuPBz6IcwnU7ioItT0fC12viHE/TfyrEFFvedgj2T2uutIx7EFi?=
 =?us-ascii?Q?wQts0zOlniiOiCCyTi9P9NTD2ovcwR8ntfOJ1gX/ZPff3MqVt7GquUss7QoO?=
 =?us-ascii?Q?fLpFZaGeza9M+7lP6uiJ/m2g9lpRl2KtKfvqtE6VGMQZk/wSnNgConKm4/Pv?=
 =?us-ascii?Q?ykG5MilS6b/yfw8Gnneg5KbcJryBgFT+/0ltyh5FNwuQeSnCBJlxwcFqO5N5?=
 =?us-ascii?Q?JLvwlXY/NOWY7mWLa8fIwcrLsG/Ty2t/SWXhvlZb/tfi9hrki5JRpNnu5zDZ?=
 =?us-ascii?Q?QG0Aw4tavgS7ZPs+9E/E+1CGDp0hwXEreri/gUMZTCM/Ew4i?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc0ee6f-0c69-424a-65be-08da323370a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2022 03:16:14.0929 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVj4vb9qqzNRc9NGUN4j/bStK8Qg02WDBBUGFRTc5tRpRQUwtYZzuvBali/iWObN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0101
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Tuesday, May 10, 2022 4:04 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/ctx: only reset stable pstate if the user
> changed it
>=20
> Track whether the user requested a stable pstate via the ctx
> IOCTL and only reset the pstate on context destroy if the user
> actually changed it.  This avoids changing the pstate on contex
> destroy if the user never changed it in the first place via the
> IOCTL.
>=20
> Fixes: 8cda7a4f96e435 ("drm/amdgpu/UAPI: add new CTX OP to get/set
> stable pstates")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 5 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 5981c7d9bd48..e4b0c6ec227c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -330,6 +330,8 @@ static int amdgpu_ctx_set_stable_pstate(struct
> amdgpu_ctx *ctx,
>  		adev->pm.stable_pstate_ctx =3D NULL;
>  	else
>  		adev->pm.stable_pstate_ctx =3D ctx;
> +
> +	ctx->stable_pstate_requested =3D true;
>  done:
>  	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
>=20
> @@ -353,7 +355,8 @@ static void amdgpu_ctx_fini(struct kref *ref)
>  	}
>=20
>  	if (drm_dev_enter(&adev->ddev, &idx)) {
> -		amdgpu_ctx_set_stable_pstate(ctx,
> AMDGPU_CTX_STABLE_PSTATE_NONE);
> +		if (ctx->stable_pstate_requested)
> +			amdgpu_ctx_set_stable_pstate(ctx,
> AMDGPU_CTX_STABLE_PSTATE_NONE);
>  		drm_dev_exit(idx);
>  	}
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index d0cbfcea90f7..f03e842209b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -53,6 +53,7 @@ struct amdgpu_ctx {
>  	unsigned long			ras_counter_ce;
>  	unsigned long			ras_counter_ue;
>  	uint32_t			stable_pstate;
> +	bool				stable_pstate_requested;
>  };
>=20
>  struct amdgpu_ctx_mgr {
> --
> 2.35.1
