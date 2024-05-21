Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D55C25B75
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 06:27:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F44B10E089;
	Tue, 21 May 2024 06:27:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IX1PYMVo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30B4910E089
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 06:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFRBuapG3dv/+sjmGLjr3qyr0ChCYJm/nwtJDmpkP1JoT1VfK0OOj2SXZV6YtYAWs3UVpXoAdpvDfNQOE5l6WNNf58M1eLKTByH3+asxd5k4VFN1F93WfASwjlNJmVsZevQpFVB9ommIjoZWW+09JdXxTF3NS7hmZinsRCNEDIq7yFW8bPhXilUe+sM+V+wppzpyY56jN1itK5LeUWBhp5OndhvGQJWI4mn46vvlFUFr33pvmO233k/pFc0D6ZCkkqchmI1fbzwA+0AF3x8eCRPt21MsknoQRW/iVfDbJy5XPUnvKQjXD1QUDvaiUcM4Rq3fqDk9K/mzJNvSD0qBpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ClNVmGefV4LbJ6t79/zYnB2SxCrKm+j1BFroOlAv88=;
 b=VyJvKENrSRbJ5Pl7NWpbrD5pTEKYMNSCibX0txiw1hCNnNCBmWIu9O4HzXDWyWUsEADU86BizFqgJcDNmZIoIU3Y52uVsC3BI0tbdwmgxYUmNc76jawg+Dqbk0FaZrfFmv0U6L4IQRe8U3xwkCSZ4A7Hqc0DSjPDF3vs/MP8Uct9cHrn8QZDkQ0ymMnMcjzJqIlU33FxAGsmYfkH13OSG6HUwtah/mEDCYOChP4cgeua95JUx8GToghIFgvRlS6WNzVSdhIeVujeDGTbHn8hzAdcoSByU2qMy+jVtloBDgIR2jDONC1dCS3ZqOHaHrzDuAVDeDWb8y18J0pZhRI7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ClNVmGefV4LbJ6t79/zYnB2SxCrKm+j1BFroOlAv88=;
 b=IX1PYMVoTE29ktPcW/hPyyogAOqfK89lXn9/Ml3nCrIVx1PlxVnYJuGbVrOx1btJOGcNa2SRkKSLxM09nzQwiTBwAY1Ql3ib49cdD+nC/TWiLQtxs58zS2Qy4Ey8rB4UJ14UD0OvzXvr6hEoWJdkHWCTZ+7tVwtt8i+5eCw6a8Y=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB5631.namprd12.prod.outlook.com (2603:10b6:510:144::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 06:27:47 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 06:27:46 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer context
Thread-Topic: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer context
Thread-Index: AQHaqy6kCZsCiYKX9EG2+ja9gcuY8LGhNRgAgAAETNA=
Date: Tue, 21 May 2024 06:27:46 +0000
Message-ID: <BL1PR12MB51445A5AE0F92415B60CC5AAE3EA2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240521032550.288684-1-jesse.zhang@amd.com>
 <CH3PR12MB80741397D72C5073520DD833F6EA2@CH3PR12MB8074.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB80741397D72C5073520DD833F6EA2@CH3PR12MB8074.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c502bf7f-46d9-4916-8939-f642410fe205;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T06:03:48Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB5631:EE_
x-ms-office365-filtering-correlation-id: 93f85653-35cc-4f67-ee41-08dc795f2135
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?ztSt01w83tlnEi/zhbqgQk4yyHBBfrWbI+MuPEMiAJJdmR4ofTeGWj4gqx7M?=
 =?us-ascii?Q?Cqgz2Aso9PkqiNgDSOLIdY2mAwIE7fRgsXsUe6+OPbPQcWzErA/cWOKAXV6U?=
 =?us-ascii?Q?bnDWH+xnX88NCLT4S+NvYXxIENB4dH7K/1mSiMbSiCpMX8bVSPmL8IL/r3/B?=
 =?us-ascii?Q?0jCpHwleQaNejpdHsLS8ky2GyD+tliqFZ3zD0CTXghq7Qeg1J0BlalkgfkKL?=
 =?us-ascii?Q?AgnyXHiJhuTQzABo5UZQnOxLSP9Hu/rt44OO74zZQG4NAVr30KeEr3G3XxvC?=
 =?us-ascii?Q?EudaPZJUBPJy+kqUJaSUbvwB9GFTvrJoaDOdibLdys7RnSlyar2n0AcBv+kK?=
 =?us-ascii?Q?bkUYYjvZcQy3+MVMDxB+6mS+zXbmlNZ0wRzSwClYVdJceFqcOOGkXaVCfB4p?=
 =?us-ascii?Q?lPy7BUxqJKR0x3Ms5nN5ZR9wt2uh4evKaqpiJbkwHDd6bd/h6n9EaiexqRIx?=
 =?us-ascii?Q?oM00GlRi2HH4uhc3ad/AmbjwL1uVGbsVPvgjc6M7QWTvl6fpT/9Stwvle8Rw?=
 =?us-ascii?Q?sPAlLnqiC7+0ffpAGfc7lM10joh22RbIYiJjbXMMs0a5EVrzRv6WV1inrn1K?=
 =?us-ascii?Q?nyPj7hCd3ZGmcBPneQgULiDIG1R9kA4F4dwDzMFmqwAr4skajry7o+dhRS4o?=
 =?us-ascii?Q?svfgoFekl3Pa36VLinmBft5nsYDGjemadDkUK2vFZflu3cq6UzGQqGniLM0Q?=
 =?us-ascii?Q?bU3R+0JhBcxsGnF4g/2GHhr85dxrQW3NqGiqkBPtH/ETUsyDh2a7EOZWHsT8?=
 =?us-ascii?Q?BmD6ORKYBmTrwyEOet8mRayQJw8mA5xhgoe0b3KpdMGXqMk6bDl7hOEBSTdk?=
 =?us-ascii?Q?dc785bmBnIkDH1mmYRDZdn1+iofbN++VMW6jcZSwfJXzE+dS0qObIYVE24Z/?=
 =?us-ascii?Q?Hg6FfzZIEvZUC5BV6txWGshBca2wHVwP6plRVADsiM+QTBr6D9LZBY+ZkAPZ?=
 =?us-ascii?Q?2mzwoiOTbpqB571/6ghQ4OKwdhmwZjQ2KExF0VCdbWFTedvpDjonNZiHpE4n?=
 =?us-ascii?Q?86vXOVHlwx/o7JE9LBLWYOsmiZPVB5Snhww/rF0ZskG3wOYo9SMUlFfPlXx9?=
 =?us-ascii?Q?AW4Py7FkUcL1SfRNOW8V/d+IhsEU0fSxtPSIY0wEyzdB+ZBUzJn42M3NAAJu?=
 =?us-ascii?Q?GcK2Y0FkWz3RZV97Ul5cycIaFBHacjKJ+0Dtd/vu25lNPBfQ6rnM8f5q94KA?=
 =?us-ascii?Q?t6K4iDWRad5YHcw0dnIZAPvk09U/iK+i88ocGJ4+nZ91PAmk0+1UhnC4d+05?=
 =?us-ascii?Q?AMP5Os59JfRQ170MKztxC12ZJHVjfKKppB/ShY/ml9Ew2XTPw0PIDFN2L3A9?=
 =?us-ascii?Q?HPqAz/Vffg+FzEdSKgCKxscBwz/Z5n9Jz0pEszaBg4cybw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uRP2Ydwt8JZIiPqUd0H2ZjsMQEHngflYxhPGMGFgZmPsxSMNvBEo9v/JUeQs?=
 =?us-ascii?Q?MPp/URwN4gR191Rgtf1NuNFhIq3J6/phWFKbB5cblCoYW4nVGOCX3OIeuu7P?=
 =?us-ascii?Q?oi2anHQhQZSZ3vxU7l7WLUXlRfxd3XBHwaD5vk6z3M5LczRWB1BHBXfCaBAI?=
 =?us-ascii?Q?R5TyZMkC111G3Qsq/A8jq7OkZ6JsKGPpInsxEI4T+jgupFtBcQOqki4QT6qJ?=
 =?us-ascii?Q?sLOasJP7AxYwcTWOaOJLzwo0/kU6NAjsNiGvrc+iaZhl9+CINiK0gN30siSi?=
 =?us-ascii?Q?bqXwKMtNrBHfpQk0J2qEfmQ7lxMzE3CDLAgonMB1HCuZ6IywuUi7njf17YU4?=
 =?us-ascii?Q?UnBU6ejUhK66DWsiymsoY9KcgYWXgcmmdfwwPHik6aq8Zpqo+HTdX0gU9L+O?=
 =?us-ascii?Q?XarXvHL7CoxDhnHVYaywhMvGcxh8l5x68TWjBOn9d5DTBgL+54bBObbeNQxf?=
 =?us-ascii?Q?+tebSr8uu0JRAYDJw9IKCqWTXp/1I0rQ3vvKh51sQ05fTUK+X4zZ/v+h72em?=
 =?us-ascii?Q?l+ggTjKqEDo3Ckl1FsN4dX1p7vw+OfSvkznSdYtyY6Bb+MIXuU1uY2+QncGc?=
 =?us-ascii?Q?reT11Kg+2akiDN13U4vN2uuc580SFK1/RBtUWlZ3KGqsLz3nBnJwwhrJuecQ?=
 =?us-ascii?Q?P08wzkLYenZ1wK2wxe+he1Ce0XFw2lh15qbcAVle3gQZvSVLGFA4G3o23Wxj?=
 =?us-ascii?Q?x6DEiYcoKPU7t9UUczBXhMpEIULHPO7eQCM4n+Kf5h1SHy2gptaVjLTEJg+K?=
 =?us-ascii?Q?zMX2sjhDuQHtuq1dhQ62+6B3ay91lx9N9Qh5hquhvpeAya/7nckUlDgfoHwe?=
 =?us-ascii?Q?4ftEOPNTudqtvCux0TaxZ6nqfiGb1cj+0MZ9pTOln3su4vU/U5F4tLhM5ZQ1?=
 =?us-ascii?Q?uMo7D6Uzs+FyucoHKgC5Z29LvBsQma03MXOV557bHXDGR1Trm/VAFYfiHym7?=
 =?us-ascii?Q?tcPoCN0EjOLOwy+r5MpCOrdX5/bnnJs5Yl5NEgMnfpsnNPcCCnboExk1aTLg?=
 =?us-ascii?Q?ZidHAJ9m9FhuhsMh7paTv1gPCz+fX2cmJjHLM3mmjPWPYP7JGZowj7xS1IdL?=
 =?us-ascii?Q?eltRt3Ovaq4OA9tzF2Ae15WxNrVcOwA8oljjGze8Yg4kvvr3l8eudP6bU816?=
 =?us-ascii?Q?rlJ9PIOJCsikiBCgZ1u9vRO8pRFtJsiPCobBnZlDwrfXbucV31z6YbkBqKTG?=
 =?us-ascii?Q?rnhShEkVj/B33y6BSLcGgtZEG+OwUSfmcxyQ2r9hJlXOp0YtDY0QyGj/ySSz?=
 =?us-ascii?Q?XRRpEzk1O7GdF+h/8hAqZyGunOfUDz8E8GEt+4nEFceDe4/T7ERoSEctATLo?=
 =?us-ascii?Q?N2ZKD9xQ4rBCF+ZfPoJ3TgGJmHzsyzjLenMLDlSTrr2LsQlHsFWOg7mk7kEB?=
 =?us-ascii?Q?Ul2NnR4Q336dUCHJs/h2LGIZ2Dkq6MpN5TWUxIosCnQDHW62CIIHK0m1B+zW?=
 =?us-ascii?Q?SrYPzQu7/OjhPj5hlOc5n0fy2LjShjuiBXvkwaw0ur9/vbjc106RulmRnJRh?=
 =?us-ascii?Q?g0YgnkXUAUgVmq88aruTWC9/HfoGyCcMs8NHVeM+21tccE/OumOXWXIjN2tW?=
 =?us-ascii?Q?QorMGZVm0/An8xJ27F4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f85653-35cc-4f67-ee41-08dc795f2135
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 06:27:46.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rhXcd13gTsaM3XvjXHGYe2N1GRpY2nk1BhPN5mgKfCFjpsBOpp9cghqV+yFjLlxbsYnrXk8hFe+BrXY3ELUEKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5631
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

Hi Tim,

-----Original Message-----
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Tuesday, May 21, 2024 2:12 PM
To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jess=
e(Jie) <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer context

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Jesse,

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Jesse Zhang
> Sent: Tuesday, May 21, 2024 11:26 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 4/4] drm/admgpu: fix dereferencing null pointer
> context
>
> When user space sets an invalid ta type, the pointer context will be empt=
y.
> So it need to check the pointer context before using it
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index ca5c86e5f7cd..ac1f423dd28f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -334,7 +334,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct
> file *fp, const char *buf, size
>
>       set_ta_context_funcs(psp, ta_type, &context);
>
> -     if (!context->initialized) {
> +     if (context && !context->initialized) {
This can help to avoid using the empty pointer context but still needs to h=
andle the context =3D=3D NULL case and return an error.
[Zhang, Jesse(Jie)] Yes, Thanks, I will update the patch.
Thanks
Jesse

Tim
>               dev_err(adev->dev, "TA is not initialized\n");
>               ret =3D -EINVAL;
>               goto err_free_shared_buf;
> --
> 2.25.1


