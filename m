Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF71C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 07:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F2FB10EEF3;
	Fri, 26 Apr 2024 07:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BnfA3Xwl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33F0A10EFF6
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 07:51:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAt1DrhwqabPWHRS+DaBmJbnRVu8OniHqltO25j3nJHtceRhDU7RQRf1tgFNz4k0PkBU8jYuOW/A2NyLY3OBZut6zqCLNH/DziVP/0/2ZRXBTeKKZpjxz/K+oFpNKxbd8j4kjsy++zBVUcpKlh2DdmNMhNKEh0cPofu0uStz4QuJwVEvqpPimtaZLmilNUTZbdpaT9l1h0GuHYxiQCNhK7tYMF5fkjpvBXfigLCb0eVuTOwnnprcjXc8n71mfg37x7CCaxQ09HWpNdz0nTV3nuWDmaU9xkAt+qHXng4MD7w7WQR3n53uHiJQ2b5v/XSp4+p3Y71n1hTZAmlX36Iq6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyIagjXoJUHdsecVQVmdpQYy+y8KiMCpHB3Pc/4lhMg=;
 b=XnY0NkdwoUWxaAGggesVep5j3dBfke3b108DpyP3JUaDQoTfZ9CTqjRwPUajPFvEwan1sOGxraRLdxsWhEIXplzLsQq1jzmULDdNC0dbYLmlftvAbbLMcBDdVGMWkdqSzAdxVbwrPiyk0AZfQaXw5RLKgeMs1bMQ31klIEP5EFap0XKw7SHm00Tg32fnO4PMiy27EloZWcmHxKRWdgnuTu/6MTNHJQ2c0HompSzwe4tTxJLWn4hNPND8tY66CJFKh4LQj8lHbLo/jv9JE2esfkNJBkBtvdfQfyUEAGjkrDjwnyjpsBJxrfp90YqhHBn57O/fLr7Zui63yCAZmSLgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyIagjXoJUHdsecVQVmdpQYy+y8KiMCpHB3Pc/4lhMg=;
 b=BnfA3XwloVEpOvIaSDO087vNlmgQ+0TcEPFi9oF3Z+XMuT0vHewNyUF4wQoRBMQO9jkgpwOb0gSwG7GrTpu49cpYGaDw8lOaN3JfiR6F5xrwNIvPH+LHQBXt+/QadbjAi3O/ClXSvEep5l0xH8VIMSWe/bXD5UspygiJ8VWyrrI=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by BL1PR12MB5996.namprd12.prod.outlook.com (2603:10b6:208:39c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 07:51:46 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 07:51:46 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0
Thread-Topic: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0
Thread-Index: AQHakHS9COnP/xC3DUax0Li+OX5ye7F57tiAgABM8MA=
Date: Fri, 26 Apr 2024 07:51:46 +0000
Message-ID: <PH7PR12MB59976662E43E4AE435AF73EC82162@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240417031003.1251031-1-kevinyang.wang@amd.com>
 <PH7PR12MB879669EA5B060D239933FFA5B0162@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB879669EA5B060D239933FFA5B0162@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=0b21567b-f021-4069-bfe6-d32304055f1e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-04-26T03:12:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|BL1PR12MB5996:EE_
x-ms-office365-filtering-correlation-id: c124158b-4d3e-495a-84ab-08dc65c5b8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?eG6s3q82Fs2LLTHowpEY4HfvH492NqJ4rxaUcu/TU4vEtcF1pGscYwyHf170?=
 =?us-ascii?Q?AlRP6dRdZCFf5t+2KyX8UPn3zfqK18yyR6BKyyFzhFNjkg6afvp86d5PGd1h?=
 =?us-ascii?Q?LtttJynJnCpDI5Fg4Tcw7RukYrbTRHkXj2cfY30y5EM81TGpLw1ea8oGYu88?=
 =?us-ascii?Q?tmqBFoS+SIUEScDiwANdwfacxoDxvuF3vLWvJWsDW7oop0dAQgAlYBWs2bUL?=
 =?us-ascii?Q?4DcOLar9XKlcvT1UqmCNaYnihhtldYkGfyfBeL4UrxvhbZv3ek7ByutBC+ov?=
 =?us-ascii?Q?L1w2VJ5psW+KfVN24C2daLw+6XQuoHQtKUWe8nVdaGSr9n2/NYd+zQTbOL5l?=
 =?us-ascii?Q?24qERvFPmlZmbz1qBov5kKKUX63EaIn+pEVKmnvlti3onC1HuQhn6FKviivd?=
 =?us-ascii?Q?rlQZdLzp6Gx5fKL03PX/FNeAC7qqph3l/WeCzDJZU7OSMVXtAVI1BO902a0H?=
 =?us-ascii?Q?ycvLL4RmZDrqLUZ6IJ0TH1kl0uq6f33Pi2D6ZFSUTpPfH02EfJVXrZdfO5zz?=
 =?us-ascii?Q?tHBIgv29fCFCzw3h24STWcIi6yYllEuom2MPnYaNZekXQuc1qep9wAEGcM/Y?=
 =?us-ascii?Q?ZSaedT61vwiCV7esKQUhrQAebzetLGSPML56amzd8MeUZc5VCzZAey71onmR?=
 =?us-ascii?Q?AfYYWBPf/64F8s7Zz7uAcgi+oRcOloNwozwO1SC0qnfNIYbBSatSDGZBdZyA?=
 =?us-ascii?Q?Jsanv2qOYg0w7SCioUNujJfM6I9pyfH0MUDzzZc0JnXd7uJnVTDn77hhlo4B?=
 =?us-ascii?Q?tdZx8xJPx9EkytP6CzclOhBTCb/510w51xzGHnibfv4yBrHKFzQZitJf3FLp?=
 =?us-ascii?Q?usnU7BPPEo817S1eVA5ZhG9ZtmJOXICgNkVC11iV4pmJ1PEfaeDHhfEaCMtd?=
 =?us-ascii?Q?z3tfRVf8ro8qvN42dNLbxldlq/SFbEWQT7JxamGENRiTXerRo3Ic+l12wgZa?=
 =?us-ascii?Q?DJb1T98TTb35jy6tkS7cMI7dahtyiUMg4+DxcFm9GpjfQSocTJT7hOH/zBjY?=
 =?us-ascii?Q?PoAiOr9g6+LniHoa4NAKQwvcqpBoZdEboYchEFBiZj/l9tzg3gXjKz8zc/K2?=
 =?us-ascii?Q?9y2b7pHdVFzmGRh5nFHeNeG73WbANSrOaWK7btGoYCICPUgUjKuuaU6bCkMs?=
 =?us-ascii?Q?mcw/JsmldTzTo38nN1tgQFDCrSxfPbG6vRTHWElfMhVSi3b/EPc8XyHLk00b?=
 =?us-ascii?Q?Y3nQYC2T5mzmt47bB802a+BZziZG8DeyEFUnBzIHNQgYlWqIG3YGSz5qPpXw?=
 =?us-ascii?Q?2/tajIrxWidd98nW/fens+V7i3uSZqDeFUq5m1mQkZQY7ROXiFz9Pi823Rty?=
 =?us-ascii?Q?/Qht1z2Bucd//rTzaxpPZIxlj+OmNotpZe46ZSF+cKl+yA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WfaTrpEKRDGwkN5Lue5p8y0lLxkUwD128tb+4PT+LvKpprKcPGprmUxwngow?=
 =?us-ascii?Q?avpJpPGolW2dELlY6lWLtANBRb8/sG795BOk+UVdlK/TO/Xk+olpszABgRsK?=
 =?us-ascii?Q?whpOjiYmD0nQp8KK4ZMJjpbij3G1zZmaIbZ4d44T5epj8wr2m5ui7/l5A1sO?=
 =?us-ascii?Q?LUPWTL8lFitXD3/NV6vlrSZEfG9c5vCv7KeebjGzvNt/Up+5fqmQE8MMecup?=
 =?us-ascii?Q?qsYpWCew8ACCJatR0vM21hG5ezaxd3hCD6h6G4VR68t5G3zzDOeFh+OVMUHF?=
 =?us-ascii?Q?djhMBB1Sw9WvIfN9KGaRZuMfhz5EnmzQUGH2mSpch8hz/3DObbm1Aqe6k+Kb?=
 =?us-ascii?Q?PItCJEFtig2rTUcgLFo2/OxTdZMtEcAaj5SR7UmDadUkAbg01uf079y9euW3?=
 =?us-ascii?Q?p2v431f/5eMxvybJuH1tqzVb6yFgxYVX+y3CjoojRXrLPBRFIwcjVhHuVHHx?=
 =?us-ascii?Q?6Bdh+1q5PtSViGlIvU2jsO8DgfIqHarqzDe/mpIwQqC92GUZjja1F+zU3ak8?=
 =?us-ascii?Q?Ax6XOtKBjjg2rlufUhvjZIMj8BMIXHG2Ey1jfX+zfmCoEjm3LhMlDUiZbotV?=
 =?us-ascii?Q?ZTavAMvHOY9dJqIW23wJgR1GxK99/fT1Vfnvx5s6HkqEhZQJz+3eoyEuMa+8?=
 =?us-ascii?Q?XRttPoYlzeUV9ckLog47v9YlGQgJwj0VT6yEa00kQ10rk8F+sYXC8rbyLsNH?=
 =?us-ascii?Q?gwVyxefnWVGBZmjPKf01RLZT999YP8EI64PEF0RFOG3fAxNYt58ZsiGqoHGP?=
 =?us-ascii?Q?thZ4yWl0jr89tW4Fva7uUsD7T0YEhnuWEorsMw9shupHlaKsU97FT+wD24Lx?=
 =?us-ascii?Q?wzT/7bEgy31dnlCK/jM+KEa9ef+cV3cr49L0opt/A48UOsQkXbyui0Px0pUl?=
 =?us-ascii?Q?dx1klYCoqgo5rGCmPVlEQmGeAKZmszPBSChytNydryd/w/J0SZd0G6d6MOFT?=
 =?us-ascii?Q?5JrkQLJ46gHoIQX9epssTaem1+41GNqWfU+lzyYDvKD1Bi5FVcXdmdDGDfGn?=
 =?us-ascii?Q?fwAwzSXfmwXXPunFNL7KyG3EWVaZOADDenT01BL3WrGs7BCemhIs/+s+vUle?=
 =?us-ascii?Q?K6iWdJMeN31bRlOWAq0iScMxV9sAgPcAp2JgSDVr32AopLUvA5Gtr2H74Az2?=
 =?us-ascii?Q?84Qq4R2NVZWwrnPsoL1fetzmjhRHZapz/RF72G3KdLACG68iszPLkGDxDDcJ?=
 =?us-ascii?Q?zrXYKl6UkjoS/5VDgPwcuGBKHSt1Io6weFjMgn7nBCmmaeDf2yNSVuAo31cc?=
 =?us-ascii?Q?DaEylWvT9gN2rV3Lnz2djYXrnzoYXVkw5xjRKspSrZynsLAE9i418ab3nVcQ?=
 =?us-ascii?Q?Jr2EcJUC/diITmFLcByofVO8Cn/I46U5wR3QJaFKfFBy/l29HtYBhUFKqylu?=
 =?us-ascii?Q?b7gyi0MJNdyBxcPeNt+aMSu8+JrxG21gF/3PY19wWTg4FCcol487kyeJK+py?=
 =?us-ascii?Q?NZrDiIAdfHGfLent4TNPfYD0wcUrzicoKrSTQmQ8BslD+sdba/PbDF4YjesV?=
 =?us-ascii?Q?Se7FwcbaoQR/q6ibXl8Se38H2wwCRaGxG+YwGbxWORT/W6kz7Fgd7whUQp4y?=
 =?us-ascii?Q?FKRcth3hRtIN7J/tl3o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c124158b-4d3e-495a-84ab-08dc65c5b8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2024 07:51:46.3596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXD9Oj4p6jqqTXrQpgtUjtgFNx6gkLX9qtNkdY69tPAPEUYs16PO1utDLZWInPHP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5996
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

[AMD Official Use Only - General]

Please ignore this patch, Thomas will submit a new patch to replace it.

Best Regards,
Kevin

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, April 26, 2024 11:15 AM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>
Subject: RE: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0

[AMD Official Use Only - General]

> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Wednesday, April 17, 2024 11:10 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH] drm/amdgpu: add ACA error query support for umc_v12_0
>
> add ACA error query support for umc_v12_0.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  6 +++---
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h |  4 ++++
> drivers/gpu/drm/amd/amdgpu/umc_v12_0.c  | 18 ++++++++++++++----
>  3 files changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 352ce16a0963..46b7f0c5cd8a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1268,9 +1268,9 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device
> *adev, enum amdgpu_ras_block blk)
>       return 0;
>  }
>
> -static int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev,
> enum amdgpu_ras_block blk,
> -                                      enum aca_error_type type, struct
> ras_err_data *err_data,
> -                                      struct ras_query_context *qctx)
> +int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk,
> +                               enum aca_error_type type, struct
> + ras_err_data
> *err_data,
> +                               struct ras_query_context *qctx)
>  {
>       struct ras_manager *obj;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 8d26989c75c8..487548879c49 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -898,6 +898,10 @@ int amdgpu_ras_unbind_aca(struct amdgpu_device
> *adev, enum amdgpu_ras_block blk)  ssize_t
> amdgpu_ras_aca_sysfs_read(struct device *dev, struct device_attribute *at=
tr,
>                                 struct aca_handle *handle, char *buf,
> void *data);
>
> +int amdgpu_aca_log_ras_error_data(struct amdgpu_device *adev, enum
> amdgpu_ras_block blk,
> +                               enum aca_error_type type, struct
> + ras_err_data
> *err_data,
> +                               struct ras_query_context *qctx);

[Tao] is it used in this patch?

> +
>  void amdgpu_ras_add_mca_err_addr(struct ras_err_info *err_info,
>                       struct ras_err_addr *err_addr);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> index f69871902233..9f2c46814a4f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -317,16 +317,26 @@ static int
> umc_v12_0_err_cnt_init_per_channel(struct
> amdgpu_device *adev,  static void
> umc_v12_0_ecc_info_query_ras_error_count(struct amdgpu_device *adev,
>                                       void *ras_error_status)  {
> +     struct ras_err_data *err_data =3D (struct ras_err_data
> +*)ras_error_status;
>       struct ras_query_context qctx;
>
>       memset(&qctx, 0, sizeof(qctx));
>       qctx.event_id =3D amdgpu_ras_acquire_event_id(adev,
> amdgpu_ras_intr_triggered() ?
>                                                   RAS_EVENT_TYPE_ISR :
> RAS_EVENT_TYPE_INVALID);
>
> -     amdgpu_mca_smu_log_ras_error(adev,
> -             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_CE, ras_error_status, &qctx);
> -     amdgpu_mca_smu_log_ras_error(adev,
> -             AMDGPU_RAS_BLOCK__UMC,
> AMDGPU_MCA_ERROR_TYPE_UE, ras_error_status, &qctx);
> +     if (amdgpu_aca_is_enabled(adev)) {
> +             amdgpu_aca_get_error_data(adev,
> AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_CE,
> +                                       err_data, &qctx);
> +             amdgpu_aca_get_error_data(adev,
> AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_UE,
> +                                       err_data, &qctx);
> +             amdgpu_aca_get_error_data(adev,
> AMDGPU_RAS_BLOCK__UMC, ACA_ERROR_TYPE_DEFERRED,
> +                                       err_data, &qctx);
> +     } else {
> +             amdgpu_mca_smu_log_ras_error(adev,
> AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_CE,
> +                                          err_data, &qctx);
> +             amdgpu_mca_smu_log_ras_error(adev,
> AMDGPU_RAS_BLOCK__UMC, AMDGPU_MCA_ERROR_TYPE_UE,
> +                                          err_data, &qctx);
> +     }
>  }
>
>  static void umc_v12_0_ecc_info_query_ras_error_address(struct
> amdgpu_device *adev,
> --
> 2.34.1


