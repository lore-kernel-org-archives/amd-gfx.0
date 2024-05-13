Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EDFC25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 07:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81D1910E464;
	Mon, 13 May 2024 07:37:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yDYPOHI5";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6759A10E464
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 07:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIduda3su137rgjOxcg0dFyfZhSf4UwhDX4M/Yi+9EOfEs82f6bDEP2x3IMppE57aeJ5pPNGeMFE0QPcZhBxzj0iV2xaQamN/l2RDl1T/rM1VpxTqgxeKMvB8pK9KLMI9qDPHJehkgeLP+Mi/yBhq4iv781zG9D7NDhaQAVtLCJHEp3qyzXEBRXaW6EnjVHv/1nR1jAeEhL7ZClcjte/x8+V9C+1M6xyBafkWcV9o2jGM5AHy0f50p2SaCOKhbI7MdhJkcbbhUNbScH7sP6mY3icpJqhfqHEGdHu8hnmMVOFpqr4SRNcJ8g0GScymhi8reuJclOCZUFVbJ6L3xg1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2pXeY/Q7LmRVaqLbkEyWhnEu4BdZiR6hokJ6EgI3cI=;
 b=Q41cV+4KhLmYk987U11j/pS4ONTGKPm5VD6QbJzLQMQdVjsru7wgIyn9Y3J+kwBB5ciYLbUBTQmWbCBJwW/TKTR3vAx5kKS2V0i3iCx1dnkTw25OLurJlAE8Ft48Fl1QSsEpTNSkcFImNtOkamzk+lhrJRp1R1uBq0n9WBordSc9hwbgkSyO/l9QRaYthRV7KacnQXTMGPjCqOzyfPLYgoty7wfNwIYEHCMCK13gGz51onfbgksWeLKmg8h+bI/yBh32W19NQegZ6wN8SjbrVHHyW6z0h5MdAZYrdhhtNshORVBxy9m9XiLz5OgFRYjpPe5kzgogBDhUapnVz5+pWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2pXeY/Q7LmRVaqLbkEyWhnEu4BdZiR6hokJ6EgI3cI=;
 b=yDYPOHI5FZC0mRp/XgyOi5/zJiKQ2TeCukQNbnl2zujpbAVvce3rL9bkt1AOorG6BWXLHDiweClb/KZt5SCtMzTk6FDGZoMnAC64m5Rvk2/8RC/ck7TziOqBlz3Cjuu3FYb+vkdc890rLCNHPdVWpmT9PczpVf5AMGupz+ddaJw=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 07:37:21 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 07:37:21 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 2/22 V2] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Topic: [PATCH 2/22 V2] drm/amdgpu: the warning dereferencing obj for
 nbio_v7_4
Thread-Index: AQHapQffiN1eDnPrBE6bkHMfEQc6G7GUxp3Q
Date: Mon, 13 May 2024 07:37:20 +0000
Message-ID: <CH3PR12MB80748C64C5A71C05908150A5F6E22@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240513073322.3612851-1-jesse.zhang@amd.com>
In-Reply-To: <20240513073322.3612851-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=d76a8e4d-1d8b-4bc5-acab-f5595cbababc;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-13T07:36:59Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|SA1PR12MB8700:EE_
x-ms-office365-filtering-correlation-id: be35fcab-ac63-45c8-d282-08dc731f8604
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?SZEcbh/XEEgpZAyc6w3wNpHu0WQawIQWqSaGm7IKjePcZBEEh9dU7irgHn?=
 =?iso-8859-1?Q?/mbtSqgSep9XbqCGOvlwHgu5dK/AOMK5IeMyJ0CBLPT5e8TFSeHR7jETlj?=
 =?iso-8859-1?Q?FLsr+mOPnmrtMT+l8tGcX413fXfOLC3yf95VwtX47KSurgxYgFLziTfJ8z?=
 =?iso-8859-1?Q?VaevPsEwGz+dD5yOIXFlVmd1xdIqQxZ1Td+smm2OAffbjHzE+IqH3tGKOG?=
 =?iso-8859-1?Q?Ms0H+BJmAjjoliNbCmn7ylG0b/N0EZgLvZDlpg/59HET+7nbzMl2trGZlS?=
 =?iso-8859-1?Q?Uy6Wci7vdXTLFf6QImE1Yvb0aBjd4/oKLCR8oC0V5hiG0a8CHoBTx+MDvR?=
 =?iso-8859-1?Q?bKKxS3xCtbUfM5chsFPBXL+/KiVXhMZ2wvzsVEVA7SgLbyx7NT8C/+b+mm?=
 =?iso-8859-1?Q?R6HPWfAocuekN059K/Vyb+0Sz3c2iIKA7KXCOhn48KpsQkR26mMLWGDRbh?=
 =?iso-8859-1?Q?LhXkjYmVLjCiLxDeoAJpT1BPyZXCIBGMHnBQj1PWYGIq8dDFfWqQk+P6ge?=
 =?iso-8859-1?Q?r6weuS/f1OffkcNPphGNbKXH9iujXbqZSFL3ZInbzoSUpG1qeS4e1X0ONO?=
 =?iso-8859-1?Q?whyvQq5kIOIoplG3KfcORtEqaBFG7G+0h3I2c4CBvOOIj8rubaqWKHPPlo?=
 =?iso-8859-1?Q?oAjhGaGCLFZSShiOGTLlf6GunbjCFNMBH4hH3BxJgZDt2FcsDdozm69G0e?=
 =?iso-8859-1?Q?gEEkQKuho4mLzoAS3knbN3Z+hEBLHwyRq5Q+HTJqaL1BKwGA0UkZkSLbid?=
 =?iso-8859-1?Q?9EVp9dNliwnSxRT+fwzV3x4KedxtDmVR4h9KPZ7FKjAlY2DSDGQbf/46kp?=
 =?iso-8859-1?Q?zeu3H6dGR2OjirLUSBzD+rZwDbfJGq47tXc2aJFklnmTJwlwmF7O+ZGXlQ?=
 =?iso-8859-1?Q?QTo+lCHEA4zBrb/1xZ0ZQB0THm7ymseKQK+Ll6UYKzMXnuVwvTp3pEhv9z?=
 =?iso-8859-1?Q?vzFxogM3+xhMaZknOYRlbz/upTCZ5zqqPFRfJbN7kQB3z7Rj2PLI8Oiprk?=
 =?iso-8859-1?Q?i/U3/eAG2mMug7dcykcri7fmX5ItgNLhvqcu3B64fsKRJtsepdZHwL+mLy?=
 =?iso-8859-1?Q?XczNJklFmG+S5Kqu6d6wPVUqwnbOL9qzYkH6PTilVLgsKkpYN0Ai1VVZXy?=
 =?iso-8859-1?Q?VaavHM+YSElXqIcF20dAoHgHr19NHhBPHXvHYv1oQF+MhQDbRq9iXLtzpY?=
 =?iso-8859-1?Q?21IZyo9mt4KSjkKTKW3TNSwbEO/GnyJvZHqhxhDHJXVS3SuwDo51cARARe?=
 =?iso-8859-1?Q?tM/WXxzxTPi/RJlqfa0xncgeVnKzNeepIz3DcNBEI998pEmjC+H0dHvQ3u?=
 =?iso-8859-1?Q?1EwBnlfChBIKH79qdZGLj3hejTIJfStTd6pNpwL05QOE8Pj5o8AHSGPkv7?=
 =?iso-8859-1?Q?K/lh34XAsV28+f8pxPjqZemFsHrHpCTw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ipgtztLfWNYVyki768P/RHju2OkFup2/c2Bu4upF+hX/Mre5WyetO3RrOl?=
 =?iso-8859-1?Q?kvxKGmUsHW5lncU2jBSkBFUtJe2hKajD6cD36RSwJaFy6JipHdhvg0/ibk?=
 =?iso-8859-1?Q?qRlzOPAfEWyhlaAf5eX88tRaBxfx0lrmf9SmP3zt5w4g92HeM/5CRO7I2S?=
 =?iso-8859-1?Q?qJJGD3LQK1fwyaDxDIxP0kZEGjIFJsKl4foYELGZ3EJ0fWS04o50dcQK5m?=
 =?iso-8859-1?Q?otRwN9XT8cFFJ5HvwlNzQ5KqYBW1EoV+ytkiYGFhAn6OaR/EKupqQw6CoJ?=
 =?iso-8859-1?Q?iH5AUOQ2RKxrdXMzyzqdMLNgxVnnOAu25sTt10j51fSD71T+432lPz9yie?=
 =?iso-8859-1?Q?fiagsfTmqELA72Jkf2PQhgLWkSy8yBrQnH6JFuardKkrnp9lc1RH3fZBrj?=
 =?iso-8859-1?Q?FNwZL6dSIuw//3BzsSfkXoPcBWMhj9Xz/w8kmOAuZRXkk9eq9uVIRigC9p?=
 =?iso-8859-1?Q?t7YuUMH41XOBUCcZNhdYO8JEtImSdsd2TW+zo5RFLmOdt+gcuIUP7lwcgx?=
 =?iso-8859-1?Q?kd4T11tyKWZF/aLkHYPMtODObMSruYbwzZ7bhFoFE1XTR12bsw9MsxQpq+?=
 =?iso-8859-1?Q?GZibJHT85n0VJX0Fithes1Wb1JEU3+E+lWn+XenevkonoRR5ryT3thQDh6?=
 =?iso-8859-1?Q?gHUZU4YYzRNB6TUHS9mk6HHfjbQhxoxtFZ9ZrpAv1kmCzLX4WioFYd9C0c?=
 =?iso-8859-1?Q?rV60SFVm166x28M+nt99TuToXTdd5JSckoiS/8e+YgUWFFtz08Y7gqQ5sL?=
 =?iso-8859-1?Q?DeWz5vHioHLabuNb1FXQCAZK3BHrdz9EZyiDsvriN2uSVbdPniwzLvus1Z?=
 =?iso-8859-1?Q?B4HbZyvY0mrYJFBlwSbJs4qafW1Qka4LMsWCiOUgQeYt7VwR/pMbpNtK4S?=
 =?iso-8859-1?Q?vJAuJ8kXpVFs0Mb0jAFhJIveN06Lo0AIKrMl8oo07AAsnHHdFk3Nav9y4w?=
 =?iso-8859-1?Q?4J3TiL78y2GRhdEt3mgbFO982X8gaffEuiEJJyDQ5Oxlz1bEH3s0e7JjCx?=
 =?iso-8859-1?Q?W8NXN2RP3blAD1DTfBwN8wtBEPoynDusJdEtdXxCDQZn4OGeqoadMYq1ub?=
 =?iso-8859-1?Q?nbIdGHWmdmYWFIJlPHdiJ9xkESTnPS3PA8pyMvaLxS+My8kEhOHkWltC1y?=
 =?iso-8859-1?Q?xkhiiK0KUP9IS1ktJZvdr5uoKFwEVPg5TCdq+iW34lp718wGJTJCD4c6G8?=
 =?iso-8859-1?Q?7DL4VRlQ3R71gScnxCxPLpyX0BCRXM2tgultcQw0SI4BmzBXpwvjlgRtDi?=
 =?iso-8859-1?Q?KSP/x1NUtgsB3HUmKyqFzRj6OhIUg2OwS4yufmAbzchHqrjak2lBKlO0ot?=
 =?iso-8859-1?Q?iodMIO9t1mPMeVHS1laIvbyLQlRUkimgsGGn3q9gTGoFPCcAsLts4zjNkB?=
 =?iso-8859-1?Q?mBvQ1Bk4bCMRjtWmDXzQBAHkplMWMzg4UisPI3srTFbmo7jdOmji5L1LyR?=
 =?iso-8859-1?Q?28GaRNiZ1RI36x2uUUXxVqji7T/xCe9V6SavHkXCJCs4EkoCBJhoApBkf1?=
 =?iso-8859-1?Q?HB0RWv2B7XWLNqQz7NAraehaIQwnrdrhzfl1jnGByPorhEr4tG+zaaTe+d?=
 =?iso-8859-1?Q?bizj3YnDbfn7p9A7gdTpQbn8KEmVIcfwJyXQ4ZB1GYRywuTWVKMKIskwZ0?=
 =?iso-8859-1?Q?VoqeB5ulK2qBk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be35fcab-ac63-45c8-d282-08dc731f8604
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 07:37:20.4219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q6Y/uLz95HnGZCXVGePFn7G7JOKkwYdsGOQj9oiWiIRtJ/oiHsfMgJpgHh7MbXpV1xPOIpL8fwWvzuBx7cWH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - AMD Internal Distribution Only]

This patch is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Monday, May 13, 2024 3:33 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 2/22 V2] drm/amdgpu: the warning dereferencing obj for
> nbio_v7_4
>
> if ras_manager obj null, don't print NBIO err data
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index fe18df10daaa..32cc60ce5521 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -383,7 +383,7 @@ static void
> nbio_v7_4_handle_ras_controller_intr_no_bifring(struct amdgpu_device
>               else
>                       WREG32_SOC15(NBIO, 0, mmBIF_DOORBELL_INT_CNTL,
> bif_doorbell_intr_cntl);
>
> -             if (!ras->disable_ras_err_cnt_harvest) {
> +             if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
>                       /*
>                        * clear error status after ras_controller_intr
>                        * according to hw team and count ue number
> --
> 2.25.1

