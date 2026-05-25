Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860D6CD5BC8
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 09:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293DC10E06D;
	Mon, 25 May 2026 09:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YiZq4lLR";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB70410E06D
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 09:45:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WsM7nWfDGBDj8qvL6ZyGDzpgqcrmfc3rsLkrT+mBaDNGnjyEe9nNE0e9+Tc3297luucxrQK76ixrPv2pBsNTs3LLCp60iwG8IOR0Egf75iNcNdwVmIy7CblnbA4cz/okvmqpFJr7cS1h9qKgiL9wiCdH5YcD6YahHDfWQaLasW2558CfgPNkwCdLNhQrNSt4D6Tyt10fm3HSBINTlD/bUvzqloLLETOQn1GVzt52+P5pqHhQNInwI6CQ61XFRxKNDuKsRmzlw7dZ+VLiC5yFRLqq5yeLLeVneY74rZxk6nLGgMbf/9pmh+pMvuj3qdxyiE9E4efs+mh/2RNxa829BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9b7TUg5R7hXasGDE00orTzaygH1eaIjwe6H+ltmRow=;
 b=H3+WbRcGLQWS3gBvwBPLfcpAgxTr9ooPp2LZcsTkrMvKKVmKGeoRS+cCK46ISF1ATj1sLuwDiG1GvCr65rVEnbo5IZk6VOxIORzeORaU8iqa5XVMiR5AhGrBikv4fHJBrOFRHQsIwEwLRhYFJuEF+Z5cLWeL193SUpCZxZH5CrRMUi/5TiWBwlje5f5+FTYOA+cph41LTMYrOt/UN0mXCaPM0LwFjp73i2lzyqEny6Yky2Sv/py+qKZRpTDpXKlEaKpDqynrfOKTnLMJYdwXNB66JH40JcoDwcWvZzU0P7JT91V74suJjuiPc+2v9qLhj+qItWpWeloVnFTVOYE6kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9b7TUg5R7hXasGDE00orTzaygH1eaIjwe6H+ltmRow=;
 b=YiZq4lLRMe1sC9BN7kd+0PuoWBKqnycj0tHT11xYRvJEFfyMYs6R9usU4Q5oLr6JfhiZdP7LYdbMj2RLyPhrQ702aXpw2RkJtz/vA9Ql7NMNaLRnQjHeL0PBAkZfWpORfjUwq5jpt1SJ5M01yLj79H1xPEC/L0+As2v2o+XU8Cg=
Received: from PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 09:45:00 +0000
Received: from PH7PR12MB7425.namprd12.prod.outlook.com
 ([fe80::f3a5:abac:97f4:e406]) by PH7PR12MB7425.namprd12.prod.outlook.com
 ([fe80::f3a5:abac:97f4:e406%3]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 09:45:00 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Topic: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to
 userspace
Thread-Index: AQHc7BtjoRzOcaNt4UKtQ0mi5aTMT7YebtyAgAAPGyA=
Date: Mon, 25 May 2026 09:44:59 +0000
Message-ID: <PH7PR12MB742503D81597692529CB5F9F9A0A2@PH7PR12MB7425.namprd12.prod.outlook.com>
References: <20260525075145.41818-1-Stanley.Yang@amd.com>
 <BN9PR12MB5306AD8575F8AA230AE56725FC0A2@BN9PR12MB5306.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5306AD8575F8AA230AE56725FC0A2@BN9PR12MB5306.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T08:45:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7425:EE_|SJ2PR12MB7798:EE_
x-ms-office365-filtering-correlation-id: bfa40cf6-d361-4677-1dd9-08deba4249aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|3023799007|11063799006|4143699003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: ydffwCOg8ofUSDeDiV4oN4GIQWBQWqbY8J3x52s5RvooVmalJHHc6wC7JbWomWNi8HEtoA6YMEPKhNq36ekEYhXNCmLd7mlBj9ZFJZlRNwMNG0lfCAY2whb4GwBxCKW5KvV2/tgPQT7YEjGFY5T78JKd9Smb3O4w8fD1Yo4iXRt48hAHzulecFsSGfooRf6I6TuVUsoMb/y/Ml2M4V6oFGTvqVd1ripwKu+aRjP54rJDOtTmdx52xaSZ3eMWOU/q9KMdnBUvh8aVBg4X1S/rjoHNQEb5YdyNI52+u3VoVwUAV9JSNBmKP/7ZzG2soZLue5cfblzh3rIof/SBoGz7oyS34FRf/vWgQqcfXXWL12tNNoUn9nfg2jGwi+KzB6HbnabKKJQLA30us8Iv7rPjl9q1Bolto1eo1Igk7xP7L1GVlk2jQEK1FAoG8VGgK1oeKunKtyrG+eIEX9djIVvLG0wUx+cOtVg4y+hnjCJ3IfcjulgOvTsrV+H+Hy1yc3j2/gj3M4JSndur+d/k/os6Asx76CG0xxPWMBsT5P9YWusobBfpPc4dcnQkfbi17Ws2WoeTRihJYPzAyRqMWGmA3TqAVqRq9rWhquHRyWzXkXZMWBM1Y/HMZ/J9Mx50pDlz45lzZWR6ssfmGCw9w6Q6BufVUc68dAhuo3qZoEY9HDAUiJGtBHYaT552c+MPzWgQOH5/5ph1POFZsxxBPRxp22wS57tjepUmEymg7upsMCE4FLFbbydayUj3PYEzKFFO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(3023799007)(11063799006)(4143699003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ll/2oJ8O3nm23Bhlc0En946LAo0Udi+N8X2CgvaIusvZzhs7MBsURSZkHfFQ?=
 =?us-ascii?Q?Xm5FDgi/c2JRdEm6RKPdxZkaN5zpzvg9ZMMWzvVxnEYodo4bnpk01BT9qboP?=
 =?us-ascii?Q?ZuKhaWw7BLbo4IuOAeJvjrok3S8fzA1p876rBR/qyG7hz38K05tpPGsDeWqt?=
 =?us-ascii?Q?bGoozS4TARdZO4niPwRTqzVvH1pSDyd5cKPj5OQPzrWc112bKSpEiekO0gJD?=
 =?us-ascii?Q?kuULuk0dfW891Ni3JGFLrQT4G89/8i8wTbLQms6G8QAArFP77kKWEZG8V2bI?=
 =?us-ascii?Q?hBapG5rW2/F5TLmPtHpqgEuiGrn+x7AcGVoR8SvVRWaGIjB/dS7lin3zEBXs?=
 =?us-ascii?Q?Y0cygxK6zgoC8oMzIFUSIoohuVnShnysXQGrLMnTL4OAVuRDfp3qf+eJFo0R?=
 =?us-ascii?Q?0k1OhWwzCkRy7hq4CqxAIGBxMFXnBdalsqrZEZ16YT0Tw4WX2PGDzJ7ZehJj?=
 =?us-ascii?Q?qPbuq8irg7ChGfOcmhIACiSgynNM6KgwO5wtTp+kbavzm4uWeAQpodsxvG0e?=
 =?us-ascii?Q?3e1Gc2PZ52/8J3swmkK7fQaq5j2FAXdTd0O8BwqhV+vm7Ap4QjXpUEPTIhcZ?=
 =?us-ascii?Q?v0Xfi3c+GGOykBOTOMtW9O/N9Ue714wdDF95SIelwQdoKDtSFfCul3Sp0Eto?=
 =?us-ascii?Q?gAfuMDlCFycYuc6QTepj1LOsGFC2d2g2vzYVNaZdImHdnQcaO7+T2FrQZMOr?=
 =?us-ascii?Q?zuhM8gbmbrAKXjXM+VjtpNyhamsg1mQEhNC3Grk5/yVaBwB3BanP3DwSDQc6?=
 =?us-ascii?Q?96MGH6M+WxBAhfjeJhxt+0I5ID6NNXlq0Ezej1E3cDaSm73px9HdjT8hoPT3?=
 =?us-ascii?Q?dngsRHHSQDNclkDadwOJ0E4ZsdHq4R0BkFZXJBwsj45eBNbSqmYQpcHpl/rh?=
 =?us-ascii?Q?/e4HtkJmRNSNv3oyFHe3Z2mgUV/V8+Xv6jKD+IafRWWOsH4nRChBFqy9FpB8?=
 =?us-ascii?Q?8vxCtbZESzsBJcnktrclYytWo6qpEk0fF6vBHoykYkYxb8q8Z9B2Lc+hfM+Q?=
 =?us-ascii?Q?5YH3Ba2igo7A9E+4cGXls7URSdNP+gScJI7V97nnOTysD00GmeTqbI+I/HUp?=
 =?us-ascii?Q?ygwN+R2MtBk29drN74TBVPaOofSCvZGa4Jl68ej836+0VF5Gxsk/BZ07QuAQ?=
 =?us-ascii?Q?1rrE+iXPMkdurejr59bqengXOjPwsc3KdIv5iQHPHECEiicp5xan+v8EUxqr?=
 =?us-ascii?Q?eqszl5QSWq5/Ah4XqBL0Uklnj5yCCLLTM1JgjzBf8jGpSZO75NobrI7ZgQMs?=
 =?us-ascii?Q?h0We2rabdqgXRHCFndQQX8Ng8bsmTixzpswghjgZiGtTLKb3dPBhzX/kUtGK?=
 =?us-ascii?Q?OJ+pvBKDMNMHgPJq8ajHG3lFD9p8IdQBK1litCrJXALB9B+MAJgHkPJlDRby?=
 =?us-ascii?Q?9wi64jZve21bIY/hMFgGAoSvpQp7Z31K84R7Cej2+q0gLwMHrXLY91iqlP0q?=
 =?us-ascii?Q?IORaGbZW5xh+Vt7wLM3+ttk6P+mIHjm5WMnX5Xt3I3xwdBJNH90326lejTBV?=
 =?us-ascii?Q?9xA/w3G7jtRxWCzAQ9fyfulrLZgOEO5j+f0cebkdCWPrc0Yz3LcrxDcJOPOu?=
 =?us-ascii?Q?0LNfzNjyZA03VePHuzWOwWj8w/52y7MLwyy71JMeXcp0AqymsfiQRD8Se+sP?=
 =?us-ascii?Q?FrnuZwA2QkAhbbyJD8TKk+tkF9VBf2yUvD18vK6WpYUUTuvpU3knmChdCFx+?=
 =?us-ascii?Q?QXR48XG9yn0opjYmIFaTrzhDdmu6GKAHNuedzo3aiif1nL6Z?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa40cf6-d361-4677-1dd9-08deba4249aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 09:44:59.8949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HrY7xMgWC0yfqrHZ7cCGHOttO5xlGl5qM1ZbuTL9JyYigKS8I1UKcOf1c2weHe705ouutNIQ78GnzJFCkSFmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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

AMD General

Will send v2.

Regards,
Stanley

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Monday, May 25, 2026 4:50 PM
> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>
> Subject: RE: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to
> userspace
>
> AMD General
>
> Best Regards,
> Thomas
> -----Original Message-----
> From: Yang, Stanley <Stanley.Yang@amd.com>
> Sent: Monday, May 25, 2026 3:52 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice
> <Candice.Li@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: [PATCH 1/1] drm/amd/ras: Return RAS TA injection result to
> userspace
>
> Return RAS TA injection result to userspace that avoid app continue to lo=
ad
> work once injection failed.
>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 3 +++
>  drivers/gpu/drm/amd/ras/rascore/ras_psp.c        | 5 +++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index ef09a6fad659..11f01b2ec211 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -686,6 +686,9 @@ int amdgpu_ras_mgr_handle_ras_cmd(struct
> amdgpu_device *adev,
>         if (!ret && !cmd_ctx->cmd_res && output && (out_size =3D=3D cmd_c=
tx-
> >output_size))
>                 memcpy(output, cmd_ctx->output_buff_raw, cmd_ctx->output_=
size);
>
> +       if (cmd_ctx->cmd_res && cmd_id =3D=3D RAS_CMD__INJECT_ERROR)
> +               ret =3D cmd_ctx->cmd_res;
> +
>         kfree(cmd_ctx);
>
>         return ret;
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> index 5d556e2a7000..e26fe8107ac7 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_psp.c
> @@ -417,6 +417,11 @@ static int send_ras_ta_runtime_cmd(struct
> ras_core_context *ras_core,
>         if (!ras_cmd->ras_status && out && out_size)
>                 memcpy(out, &ras_cmd->ras_out_message, out_size);
>
> +       if (ras_cmd->ras_status =3D=3D
> TA_RAS_STATUS__TEE_ERROR_ACCESS_DENIED)
> +               ret =3D -EACCES;
> +       else if (ras_cmd->ras_status)
> +               ret =3D -EINVAL;
> +
>         __check_ras_ta_cmd_resp(ras_core, ras_cmd);
>
> [Thomas] Can we refactor __check_ras_ta_cmd_resp to return a value and
> assign ret =3D __check_ras_ta_cmd_resp(...), moving the above changes int=
o the
> __check_ras_ta_cmd_resp function?
>
>  unlock:
> --
> 2.43.0
>

