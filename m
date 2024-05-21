Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDFEC25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 07:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73DA910E30E;
	Tue, 21 May 2024 07:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n8qEskld";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD5310E30E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 07:42:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGMLob8yHPZAxLsSAWmJ6EoUJGnWQYxE6CG+iHjHpJZR+VGfc3TbHuBv1Q85JszC/sRnOhh3C4GOxfUAlguecwswyNnanB4dNMGusQTUFsw8G9knPJMBtNt/5CKP6uqWR0vwOzKkNDMzgiZF1+FWjTsw+MQT6Yy1lKznFN+klUnWyvjfpcr7o+nPWD2SBmSex1II6Eps0lXbqIzMPTcpOTIFCm65+qj/3yO9v8+RGuhsplOV94vXF56OvlWafATSzLees4dtiX+cuo9IZctjG/G3GZAHmR4PnbCv+SMs+C9OOo90PuGT3udFeECICrEmbgGfbYGAz6YvPggPiSaGwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K94fYfOKhfIm28tLL3XlQO/S3SRd5J7Kb1W/2AbjGS4=;
 b=A6AuqKHV0Mzg0mIDjYI4K5vjxEtpz5FOWZqXXgVRtBAM9TgngVjuklz3zoYRRpogIUI1yJC868SZSATwOUQfgr64s1E0WHYyvuGn200QWzfD6ipcYV/dtAaO60T8zcabcRIxAl6TTj4WDZvJNXfB9+FkXfg5TIvd9q17deBsJHN7dBF0Nz+bogpFbOZsMEbQ0k0mfDKazR8skh3kZDsshMgCUz9HGLysXwPB4qdZ1tPdvMPyr4Zt5yFzUvM/l3qZxwTmP88RABhT8sZEDZx4Jor8P+zjCKf25BQqFTftr01A1AVN7hZS8FuHrbDhwiwLYLDwHGuKCVyr0sYtcum4xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K94fYfOKhfIm28tLL3XlQO/S3SRd5J7Kb1W/2AbjGS4=;
 b=n8qEskldBh7lRy17IjEWmTDFmO5UacWXh1HgeHCqAsUhU5nAfdtuecuxgcmvqPZUbpMDJwMvYRSiXSPDVky/V/Q/VurqM+u5F4bkV96iuyGNy7BOXrVgJwS2dEsad4dvxVaJNXj6nvcWk8DrhsUjJchnJ8haoW0QNfGi1im69Sg=
Received: from CH3PR12MB8074.namprd12.prod.outlook.com (2603:10b6:610:12b::9)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.36; Tue, 21 May 2024 07:42:15 +0000
Received: from CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9]) by CH3PR12MB8074.namprd12.prod.outlook.com
 ([fe80::7f58:8648:262d:89e9%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 07:42:15 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Subject: RE: [PATCH 4/4 V2] drm/admgpu: fix dereferencing null pointer context
Thread-Topic: [PATCH 4/4 V2] drm/admgpu: fix dereferencing null pointer context
Thread-Index: AQHaq08GEzcILJB7/kuLCQOcszBngrGhTWDA
Date: Tue, 21 May 2024 07:42:15 +0000
Message-ID: <CH3PR12MB8074EE909CE6D907C116101DF6EA2@CH3PR12MB8074.namprd12.prod.outlook.com>
References: <20240521071754.371526-1-jesse.zhang@amd.com>
In-Reply-To: <20240521071754.371526-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e616b7ec-05b8-4fe1-9627-bcf7d48a37ca;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T07:39:22Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB8074:EE_|DS7PR12MB8252:EE_
x-ms-office365-filtering-correlation-id: fed85ddf-c186-4591-3b7b-08dc796988b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Ekvj+8lyWZOLK4EdT7ESjI4UCDbC/LjJolc3OM8fjbOGDEIy5vPdk+rAtN?=
 =?iso-8859-1?Q?hWVO1Mt1k+Ue5Q3HJQ7qyWlVC9Lox2ahxmznz0IJ3bXIwtIv/IRHjzt209?=
 =?iso-8859-1?Q?2/tdyaCwoxRNKAgB0CzHG4BXh19q4qJa1/i4Knw20DHnEe3Tn1gsiJjZiR?=
 =?iso-8859-1?Q?MfK+xUCeXW5BefpN4UwjLKf6hmZRFXdbpdtQgPHLLH0nW1/vuLh+rE7Stf?=
 =?iso-8859-1?Q?gbDF5nqO+uUiq6l74sEybwtJl9lX7v6yCmvti4fOHe7PpZgJZ+s2J6PRPz?=
 =?iso-8859-1?Q?L9Yeh/L+kX3PKjWp2EPM1cSVuKc+OEYEt62RJX9DeWHRDLKGgL0Sui6ie0?=
 =?iso-8859-1?Q?nwFWNiQS/aKBv/CcD6xp5tIyZ2xE6HHqV+Ndb7LRG8OB7TNaq7pPqh+dIw?=
 =?iso-8859-1?Q?np4FB+DkYcThoQy0oDLIib2mViHUmXTz4KpqUE3jN99h00QxfDUyY6ipgu?=
 =?iso-8859-1?Q?i7RW5lmP93wqzhGvYrCpKcHNlXtVh3X0DIkLgX+GHvZv8SPeHvHag5Jl4E?=
 =?iso-8859-1?Q?dETlet4TgTkpO1SeVKVAzF76zpVpf1Bu2PyqeQ/EzNHwFUAs9Nf++t2l2K?=
 =?iso-8859-1?Q?oqdez8qFkCefrvzcQ39Pawqa6uvi6mN3D7QiGDYDVlDdByQ/JK3LGgqGU/?=
 =?iso-8859-1?Q?CslLNkv0aTDwSpozlu0h8ZO+Sc61sfmlf6QgsP0+Lg9JlvFiK6elW736kI?=
 =?iso-8859-1?Q?M8YeGRf6EwR8tfS+0hn2xXtwkbKYCXjXgZ6ABDeRTLGgwPijyfKH+kMRNx?=
 =?iso-8859-1?Q?/t5x9LbShxnQTe95o4QjA7FKKl1K+opc3TcsUatTs+y+ZvuTl4ls635Ffs?=
 =?iso-8859-1?Q?h7G6tYzsJWnOg/pjALJhT+HpFXkkN+LIReWVQ7nb2B5vVgtWHQ0dyBUWb8?=
 =?iso-8859-1?Q?XuiIl3Yyh4fgGYenK2cJu2g1Uu1O35Vxnq9FUni6nlZnTkaghCMwX6KhB2?=
 =?iso-8859-1?Q?PiU38Gkk6MKEXTtkrt+nMCJ/vUxeGJwTHNyZuevh7iNgFKaobVk6sT+3IK?=
 =?iso-8859-1?Q?jNL/vqYmAxslDce+mGWHf9RfYqssgOXXVUI4B1DvXv1dBxZbAKTOcm6qSw?=
 =?iso-8859-1?Q?mCDcGcFbPevfdLopbUBKype4/EiCaJzNjOALxzJByIu+b/vEDAfY4umISX?=
 =?iso-8859-1?Q?Ak+2afC/iWIQlzz5l2wERGtNRgkZ9pkfat0Xg4A1uxqk9u3ncP9nPN2iyl?=
 =?iso-8859-1?Q?VfN/7flZE25eglNvjapbNV/wMi7AbSLVJ+foxOo1cHqck8pW9xpS2Vkazn?=
 =?iso-8859-1?Q?H3XUYc+lbGT2J8o1E94zgDgzJ4lF/hBjQNXa0b+RvMj6OUoNdW4FX9zesp?=
 =?iso-8859-1?Q?ygsM5gvyYPEitgHqT0N2VCwb2KHaj5TxPzoZyG+yn/fuGttjAnSTEosMdy?=
 =?iso-8859-1?Q?EL2hAzvFaK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB8074.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?efzPFw9WYNy8QjalSKODyXhqY5CqWC9dkD1r49tF3As5sZCl/O7MvuLLtb?=
 =?iso-8859-1?Q?JdiZK9ASk3WNjAKLV9KDGOjf5Na0/fLj/XcPeMiGCQHxwSoMUlZRxbqSL1?=
 =?iso-8859-1?Q?q1/CydtOoV6ahBtmL82XI5OK2K0lZyaMpzbvOwLHYfI/zB9JHiAkaIHZHg?=
 =?iso-8859-1?Q?C338tnYNy/uFjaMyANheuWTMl32m2zR2aM3NFgIclwA7OGE7Rkt0qtTM9W?=
 =?iso-8859-1?Q?ds1MGqEHRUDSjunFudzDPOwscs5PAxeRfI+vIqj5FGvklPgmPPyHWg6M5I?=
 =?iso-8859-1?Q?dnYksctULkWMg6/SnwfmbyFM04cLT/1XrVpCuliJ6psIG79gJHhWA2Xbun?=
 =?iso-8859-1?Q?7t8zMRyMGM597k5A9LgLBf/33bkCI+UHc5CBhy+cH8byLe317yYXSErRaF?=
 =?iso-8859-1?Q?wLAU/BDnf9xp0hZJGDc3VIl+O+iWCooVwhoYCDrqAveefsVrHbtUezbNYB?=
 =?iso-8859-1?Q?yatshJ8PX7+o1iJ/U9iS+ClUBrsw+tao1eENIefhMt7y17VmNl5JVYo63A?=
 =?iso-8859-1?Q?BlNZAErIR4yNLPTgG8nqP0XA5/1pJcbPxiFrjs3wQYeTDXKsV/M4ug8yCE?=
 =?iso-8859-1?Q?zw/nQOJ2AMdy/0uwX8ELdErWpmT33kgAcaA/3kXA558FgVYPNOuXA7mJMo?=
 =?iso-8859-1?Q?fvwlbR1Z1mq7zeoXRuOQKaC6j/fadlYrupeHJ/E/B52Q9OMZRJdOtCv7h1?=
 =?iso-8859-1?Q?XRBYjoTjRSpvO9m3t9nBDWjd/z9mTxgG9p0WAneLjnEmUc3feoKoUT9vu4?=
 =?iso-8859-1?Q?HqqsG2l0Z9+/n92L5aLwIAQMvoy/PJ3tysNOfwl8g5CgnYJVOfDPjEDEPq?=
 =?iso-8859-1?Q?K3pe3yJ64wQfNAujuCPG7DpMp5au6B2+TCiCG+UDK377LKGCi4Ic6t6czg?=
 =?iso-8859-1?Q?iL9YtxUvFrx1eyRTyYrxlUfsHFNx0Ii6TueYPZ2y5bckPvW0lKZdkqzXi/?=
 =?iso-8859-1?Q?yGTaU1Ibb1uuFClrjlDbjLD7I3i0wbiaWemjt+DSBOYC4YrXLmLzRQnXfP?=
 =?iso-8859-1?Q?mwmDWxt5QDLXJmJS36P7K/qE2XVCf65ZOij2cOGXPaU8cykxBridrs6F9E?=
 =?iso-8859-1?Q?ZEaM3nw60GW2VkNrnsRS5VE0RhL5gkurncWVegmqneAn4H1lRUsp1QjwQx?=
 =?iso-8859-1?Q?CcypBvYkWR8gu27UE1EMDk6SPi+BRZ/3o3dzPTPxEq9Vg9F+uFMdQpLsad?=
 =?iso-8859-1?Q?WfyqLWJVscKkHe2xzpoICtztqGPyJ8efDeRjASzeSumSzkz2jadXO5m8h3?=
 =?iso-8859-1?Q?aSqA7CfUoid4cfkWHNpcCN/b1DU1uzsM/g+iS3q+cj3+KLY/YQoUKUABb6?=
 =?iso-8859-1?Q?7KsGdbuffZHHbrHwlX2sCm1KHgbhAWLB4OAou2wZXGmyrqeMVSlDm+Dt1x?=
 =?iso-8859-1?Q?Y+lyM4fUmlFG8k96lKDVNCrg5jK9wDb3BYTSwjgw2aJSUXBEkHC5QLHClD?=
 =?iso-8859-1?Q?SCX3kXDdP1VrAnR0F7S330OSc1rK7CZuESh80E5hdmfmG0cKts3WNvNys1?=
 =?iso-8859-1?Q?FwFaJOHpDPjAhQ8qS6USvQNBRkgPWmAssxRJFNHpDKKXANRh7Y4bboL+m4?=
 =?iso-8859-1?Q?yRvY/TH50SPPvJrQ+jaoXY44rmkexdA1YBAqTAgPnlOEE49hpgQwl80l9P?=
 =?iso-8859-1?Q?tJxDTaSmrTgH4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8074.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed85ddf-c186-4591-3b7b-08dc796988b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 07:42:15.1442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sF0QuwHsYn4Fymw6irI+/kaXbGfQ0aY1txdB7DFmrYoatUnZv5bTKmj0xTxfVNX606ST+tkADJeG6rwi7w0rvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
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

Series is,

Reviewed-by: Tim Huang <Tim.Huang@amd.com>



> -----Original Message-----
> From: Jesse Zhang <jesse.zhang@amd.com>
> Sent: Tuesday, May 21, 2024 3:18 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang,
> Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 4/4 V2] drm/admgpu: fix dereferencing null pointer contex=
t
>
> When user space sets an invalid ta type, the pointer context will be empt=
y.
> So it need to check the pointer context before using it
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Suggested-by: Tim Huang <Tim.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> index ca5c86e5f7cd..8e8afbd237bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
> @@ -334,7 +334,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file
> *fp, const char *buf, size
>
>       set_ta_context_funcs(psp, ta_type, &context);
>
> -     if (!context->initialized) {
> +     if (!context || !context->initialized) {
>               dev_err(adev->dev, "TA is not initialized\n");
>               ret =3D -EINVAL;
>               goto err_free_shared_buf;
> --
> 2.25.1

