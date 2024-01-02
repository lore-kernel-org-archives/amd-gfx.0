Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D61C47073
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jan 2024 08:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72DA910E121;
	Tue,  2 Jan 2024 08:49:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DE6D10E121
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jan 2024 08:49:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlR2T4ErHcLgQN7C9cu3D6AZj+xLBAolUI6c66eQS1TSSLLwqTS08z9ZYK3kXgAEwwTKwRACClmiG6VHJL9xi6SLjtD2BAXO6T3uG6YqtSSGvlobm6WrTJVA4K39QNgLA+t532H0hCUSkLBSOiBZCOVzONcN9Y2V9V60afbeNUAr8KhJ22NUoApn0Su957wkA2H+ArbE2wEmTmIjD8Yv9vVqm65ui0sN133tM8C0LLd2dIC0dAbxtWE/HyJB5wv7kXBIqhe2kOnyRUCmVq8ebDn3oDpAlnyJ1gIz2gDoZvst+M3PKa3JXVZ4RSHuXdXme1kzQGNUwSeTX9srYHuxnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0REFeY+SmRhCMfKavBMtk106ySNJv66Zmja6TjHoBM8=;
 b=Z8evq27+MZFY2HfJcv7kUTAcYgyLZYnESFDaqqzfm+Knh8rpD1+pqVAAdnPB5xxZYSqCHs0tjjoyzL2QdUMSlHFAbKzoQyEJXvH8k5Qm2/CjT9xWCfcQ2cxZMjFdFrkR2KgtxvvsJMjprIwT7k/wlAAAfGI5/REFidA7MludC9sxme229mvaz7BIMfecHgObqkbJMLRmOcbKS58m975AEumTv9eB/lst0MdRZTj6qJd1cecTz2MlA0kABsEL1IOF/FOrRKiBet/aosMKTdKXmEODog8WqWStEAqSZFMXPVIv67KFrckv9KcKaf+IpEgNnOVeM/3Ipx20eXySukV5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0REFeY+SmRhCMfKavBMtk106ySNJv66Zmja6TjHoBM8=;
 b=B1UEv2vMuy1Wwdl05M/xq4MN6xkDtF9VvwpKosOMYtqR091tHzO3S0jg8o2H2p2ww5/xaLLgyMn1pJYkWTvyqSIAD/vLwAWy6l+nSsOO7h6gRrnsENMi6AzWhqfTF5Kh7OSynPYO/yJaIuazt6gZJlAOUGUXeMcd87k+227VTJ0=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 08:49:09 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 08:49:08 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Chai, Thomas" <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Topic: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
Thread-Index: AQHaPS4Q0BwjW/hMTEiNhgDyA1nyO7DF++UAgAAFi4CAADSeQA==
Date: Tue, 2 Jan 2024 08:49:08 +0000
Message-ID: <PH7PR12MB87967060AC513D9C21E7B8CBB061A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240102034440.16376-1-Hawking.Zhang@amd.com>
 <20240102034440.16376-3-Hawking.Zhang@amd.com>
 <PH7PR12MB599727B1E79936287A6FD4F38261A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <BN9PR12MB525740D2D819B6626AB2393CFC61A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB525740D2D819B6626AB2393CFC61A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=ceb12e59-4c5f-4e48-abfe-0ce66c0726ba;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-02T05:10:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|DM4PR12MB6614:EE_
x-ms-office365-filtering-correlation-id: e7893a8d-7754-49f3-86a2-08dc0b6faee2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LJq/UoAWDa+oQuxrZqFWzqLaYlIaiJ8DUhXNwXyEWhvfCNFbXQRm+egcJoOjLYt3Bf1Ylol1hMUQGw5mbDBR4pTqa34Nfi0Dtu9A2HEm2OFePHyk8GhpIKRl6NPJUT6LQzjzU39SNi6S1glXmJhA0FBtxPIfUW7OyJdeUwoPjey2YB8HXjhsKyqMQak4WT3PfaRj0YkEqlB+5fGohBLY82VkWYXaIEUEctPoozlTbW9hWjVwI+t34f2RfIX0dogAPTucXervA2BwrhwJx4CLVIiGTRXh7+VxORwn/fwbcMCepeuHHO7KkcvkSrMDyylQT6gs1X+qwGob+GgE2CXoEYgL3miMNGwjlssYqoPfxWiafKnPq4UU9nz38/mBQGxv4zjEEpdfEkVs/bQRizwg85BuIm6vZDqIGN3B4DF8v+Qx9Xwf89cpHW9bx2g9WGJFgp+TLBpv7DAKNGPlR/okX2xTqW1U1bDoruLwl6pKBVp1Pil37vSxhPgaZSnf93RaYrKwHRGuvK5DHw8Scw5705bbcYqHyAvfReW2+IwnngReFvOEBTp07yQbqI443GPZS0AJlQ588pYayec8lnw+4oA8rVabtPUTv9SOsTTyh6eHuXqTppuFcobZ5htkBtU7P+jNo6YBS2boIWPgdr0dMw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(53546011)(41300700001)(6506007)(86362001)(7696005)(9686003)(4326008)(8676002)(8936002)(71200400001)(26005)(55016003)(38070700009)(33656002)(38100700002)(921011)(83380400001)(5660300002)(66476007)(66946007)(66556008)(66446008)(64756008)(54906003)(478600001)(2906002)(52536014)(122000001)(316002)(6636002)(76116006)(110136005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bstyZpCh1fHKNKHVNPdUc48B5gOYEk8T5LfuBNiFnXBpUTsXBsPkEuT8JLMU?=
 =?us-ascii?Q?7/kNYUPNGpqY27qL3gKgv59RPwU1NSyEvhYsRy0Sfaz9HDooHWUHmjY5X7Bh?=
 =?us-ascii?Q?ZkE6T98BmHm1vraqoGCUUoq3zf1yxWdSBgHbTqHdyGpYotJmHzBLnM7Jj60e?=
 =?us-ascii?Q?1RFkinxictoGPos8I3jpAVkenAB+FtrxYFm9EK7d5EO/xT+qkz9G4dZVKuhm?=
 =?us-ascii?Q?HmYifqYj0SxSQD+JpkUM53vempx6EDWyhHi6+ub9/yBzTrriuUCEeqpVRXX3?=
 =?us-ascii?Q?Kk28N9cKHV5hNblf2GuxkOVQ6RfNc/zXusdMN0yoW3nZe9sM46SM2i5WZp0r?=
 =?us-ascii?Q?8h+JAYXDlnHbzpgfh/cDcdhuzuTbAnTrdDRLWIrDKjY3KLHib6DTdvWm2DMp?=
 =?us-ascii?Q?d6tpRi3pPD/rNXyZWt0kFTawks+AFJBosOK/HxqDXieoZfSo4Yxzb+G4zGcN?=
 =?us-ascii?Q?w68lJpWLG1pvWACs+MOv7UYfr/ww0wBK4kE8cJYt4HIvZR7QfnsBXc7/8Reo?=
 =?us-ascii?Q?O1SImcoiCViXjMocKrgjiNPfZ+XJzqvTJpMuA8p/ISCZLduAZSjyZwhA4xx7?=
 =?us-ascii?Q?5VF8uTo222Ep/RDSZkGcFoukezNA+ZzpqlivIKGCK7R04xpxCh2RbyW3p1Hr?=
 =?us-ascii?Q?rY/DAxFbJ7/QTzF8/IrijhQnNnNFaGygWTXrz+0PsSgh5bszDUY8KzzSsiIC?=
 =?us-ascii?Q?ypj8P0xe2bmJcSOKTfXHqxGdFzGY29lO3Qxr4ZAS/eBcQPbzQUwICvUn6WfO?=
 =?us-ascii?Q?8PDvweELWmHdoyPF09kRhvmi9gTI1obhrErX7RXuJhAOurkQdreqk3iK7u6v?=
 =?us-ascii?Q?iHGfig/GUbQQH8rWDyXs43Y4OQm4d0KW7gw5F/XPFUy0iEQ1aJlfdR86Ubhi?=
 =?us-ascii?Q?NbYSR0tjzElAtmgCoex3sFQnxYj0Ac3Sbf7sW1xsDrULCckWlOg0REcDs+Ig?=
 =?us-ascii?Q?fLlIveKwNnM8mHYd1JXGNQ0MPf4Sdf8hETN0OstC59FbVtyYKRlNuMzCCp5D?=
 =?us-ascii?Q?bUf+byG7j9+IkG6bBkagwKhKNY2aa/pq/jETz+YpNO8Wh5MQg6iDBTCfQh0b?=
 =?us-ascii?Q?axC0Lfs1t6df6ZOQeRMR7WrBfbTtYGzh7VhOij2LJP7nazFuI1BcVD9Q9hUX?=
 =?us-ascii?Q?GlZwqWWm7BrbdVOXsGLuJf7MZ50Uhkil09nJYGsOv2dlgcjSVocOUeMaSErX?=
 =?us-ascii?Q?PONVx8QhJws/9LX2vT/wSWJeWSV55r5kLyA21M6cPrr4XjWi096Ukg1uTEcc?=
 =?us-ascii?Q?LoAcojfuZYGMqfZU2OlT22HObXmb2PiQsB2868noLr7DWQ0lwga0orqJSBN3?=
 =?us-ascii?Q?7eqeeSuEmY6Piq1QOcM9B4UsfIYvwPjCqEX4baDRHGtmMGvKYZrarKB0lWMs?=
 =?us-ascii?Q?cO5eiyrs1ivEY4CJ16XAGtyQwyeBGUiOs4BnzEW++H0dVFSDT8okoiGEA3ZV?=
 =?us-ascii?Q?uB6glzr19WEWC6sdKTQOWdeDFbknSql2UMv7i7lrFT/AAtyrfIuN9dHc2Mdm?=
 =?us-ascii?Q?DPXopHkOAxWE/jb1RcYFT9qScV2hbyCr4oKtNXFYEdq0xrrvrqh4EyGtHoIp?=
 =?us-ascii?Q?Fk7Dnf6cLT/TZ7sbGxg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7893a8d-7754-49f3-86a2-08dc0b6faee2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 08:49:08.2892 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2KgisyUt6yL67R/X7DZPm/68mpwlViaHYLrXq6IlGb7SW6ekwU06pWU8rc17bN/j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Tuesday, January 2, 2024 1:38 PM
> To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-
> gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley
> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice
> <Candice.Li@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Ma, Le <Le.Ma@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
>
> [AMD Official Use Only - General]
>
> The ret gives us a chance to fallback to legacy query approach (from vbio=
s).
>
>
> You might want to see patch #3 of the series for more details, go to the =
following
> lines in patch #3
>
> +       /* query ras capability from psp */
> +       if (amdgpu_psp_get_ras_capability(&adev->psp))
> +               goto init_ras_enabled_flag;
>
>
> Regards,
> Hawking
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Tuesday, January 2, 2024 13:19
> To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop.org=
;
> Zhou1, Tao <Tao.Zhou1@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: RE: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
>
> [AMD Official Use Only - General]
>
> -----Original Message-----
> From: Hawking Zhang <Hawking.Zhang@amd.com>
> Sent: Tuesday, January 2, 2024 11:45 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>; Yang,
> Stanley <Stanley.Yang@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
> Candice <Candice.Li@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Ma, Le
> <Le.Ma@amd.com>
> Subject: [PATCH 2/3] drm/amdgpu: Query ras capablity from psp
>
> Instead of traditional atomfirmware interfaces for RAS capability, host d=
river can
> query ras capability from psp starting from psp v13_0_6.
>
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 13 +++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  2 ++
> drivers/gpu/drm/amd/amdgpu/psp_v13_0.c  | 26 +++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 94b536e3cada..8a3847d3041f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -2125,6 +2125,19 @@ int amdgpu_psp_wait_for_bootloader(struct
> amdgpu_device *adev)
>         return ret;
>  }
>
> +bool amdgpu_psp_get_ras_capability(struct psp_context *psp) {
> +       bool ret;
> +
> +       if (psp->funcs &&
> +           psp->funcs->get_ras_capability) {
> +               ret =3D psp->funcs->get_ras_capability(psp);
> +               return ret;

[Tao] I think the code can be simplified as:

return psp->funcs->get_ras_capability(psp);

and drop the ret variable.

> [kevin]:
> This variable 'ret' seems to have no other purpose, can we remove it and =
return
> directly ?
>
> Best Regards,
> Kevin
> +       } else {
> +               return false;
> +       }
> +}
> +
>  static int psp_hw_start(struct psp_context *psp)  {
>         struct amdgpu_device *adev =3D psp->adev; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> index 09d1f8f72a9c..652b0a01854a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -134,6 +134,7 @@ struct psp_funcs {
>         int (*update_spirom)(struct psp_context *psp, uint64_t fw_pri_mc_=
addr);
>         int (*vbflash_stat)(struct psp_context *psp);
>         int (*fatal_error_recovery_quirk)(struct psp_context *psp);
> +       bool (*get_ras_capability)(struct psp_context *psp);
>  };
>
>  struct ta_funcs {
> @@ -537,4 +538,5 @@ int psp_spatial_partition(struct psp_context *psp, in=
t
> mode);  int is_psp_fw_valid(struct psp_bin_desc bin);
>
>  int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
> +bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> index 676bec2cc157..722b6066ce07 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
> @@ -27,6 +27,7 @@
>  #include "amdgpu_ucode.h"
>  #include "soc15_common.h"
>  #include "psp_v13_0.h"
> +#include "amdgpu_ras.h"
>
>  #include "mp/mp_13_0_2_offset.h"
>  #include "mp/mp_13_0_2_sh_mask.h"
> @@ -770,6 +771,30 @@ static int psp_v13_0_fatal_error_recovery_quirk(stru=
ct
> psp_context *psp)
>         return 0;
>  }
>
> +static bool psp_v13_0_get_ras_capability(struct psp_context *psp) {
> +       struct amdgpu_device *adev =3D psp->adev;
> +       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +       u32 reg_data;
> +
> +       /* query ras cap should be done from host side */
> +       if (amdgpu_sriov_vf(adev))
> +               return false;
> +
> +       if (!con)
> +               return false;
> +
> +       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) =3D=3D IP_VERSION(13, 0=
, 6)) &&
> +           (!(adev->flags & AMD_IS_APU))) {
> +               reg_data =3D RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_127);
> +               adev->ras_hw_enabled =3D (reg_data & GENMASK_ULL(23, 0));
> +               con->poison_supported =3D ((reg_data & GENMASK_ULL(24, 24=
)) >> 24) ?
> true : false;
> +               return true;
> +       } else {
> +               return false;
> +       }
> +}
> +
>  static const struct psp_funcs psp_v13_0_funcs =3D {
>         .init_microcode =3D psp_v13_0_init_microcode,
>         .wait_for_bootloader =3D psp_v13_0_wait_for_bootloader_steady_sta=
te,
> @@ -792,6 +817,7 @@ static const struct psp_funcs psp_v13_0_funcs =3D {
>         .update_spirom =3D psp_v13_0_update_spirom,
>         .vbflash_stat =3D psp_v13_0_vbflash_status,
>         .fatal_error_recovery_quirk =3D psp_v13_0_fatal_error_recovery_qu=
irk,
> +       .get_ras_capability =3D psp_v13_0_get_ras_capability,
>  };
>
>  void psp_v13_0_set_psp_funcs(struct psp_context *psp)
> --
> 2.17.1
>
>

