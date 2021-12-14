Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBC5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 07:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D273F10E87B;
	Tue, 14 Dec 2021 07:48:46 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0492210E85D
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 07:48:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpyubuInpdX4TyuajlH6fFrh0h43iZzbleuAdYTqr5Fa4o3IQtvKkKdKdXKSx727Vi/yOtjA1vKbGJ4aZN8m+DY5MMsqt+NJSZk8/D1e7osbN41Xpj+MKVCJxWlbknuEz2zbGs2U+GFyUzVtsBSxumLAsa/fWhIxEEbS9ftpTy0WK+t3wn1yxC2jsRhNtxmwwtOhrQ0csHMJFEMQXtQ7HR500U7wy12KSRz/G/h2BF3RTnPtxoWQQ8JbqugfXmPhWYMUzyycam93TlQdixV8MwU7NMCv/OUabIwN909ADu5GBti6YwtL5UVljvO7CcdgsKk4pf0If7R5UClY5+/zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6V5Dye7q5Ov9i9Z/UdCBoHiX2OWichWkl2oX+w5llU=;
 b=HfxjztqDYQwx/g0pjbMkfuZf8fZ1GTSHHzDW1BGF/Lm2q2/rBYraOYqy5lueoNOaqbw+tVpRzWoFKOT1IOVbWxf3A4ZQDwPi6Iv9SnLqsRT2RkGH4sOiaqOIpUVgCQdU+0zyJhsTQwHxxZL0+tgAsBFvtRTX8XixB+LZEfDROHQOFnGzhqausdu4ORr8u2xB1I+USaOk8aBQqMO2XAKgAmnpgOmHPOE7JwJgNcHmeuCXOiCNZXxNa5n9VsLAMVmmr4QJqn1Z3gAHi8FQzp9SC2ei7YbK5iwppY+hCklCbbUaKhQgAVOm9m2YL/mxq+OBd6/eTFkWlATptTkzju96lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6V5Dye7q5Ov9i9Z/UdCBoHiX2OWichWkl2oX+w5llU=;
 b=02N6BYoicoIOZRtG7MqI1uFFWHsNDlW64ioGvxTO+3hRJjNC+OhChQub7qz8PFAuHBBY+46F6oMsQPN2ML4+jJp+v9aRk8Hjh9fwJhCTh/bEV+tu/0pNidaELf/uaKKsAOYm+bp91jRUVUdgqwlJ5vmMzAEHF4X9tMeH+tkQcEc=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4987.namprd12.prod.outlook.com (2603:10b6:5:163::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4778.15; Tue, 14 Dec 2021 07:48:43 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::15d0:4c36:2886:bbef%3]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 07:48:43 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Skip power state allocation
Thread-Topic: [PATCH] drm/amd/pm: Skip power state allocation
Thread-Index: AQHX8LoSLz3hyRm7/kSCYVdKmSrdLqwxnIdA
Date: Tue, 14 Dec 2021 07:48:43 +0000
Message-ID: <DM6PR12MB2619778EA64DB7691556D0C8E4759@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211214071259.580602-1-lijo.lazar@amd.com>
In-Reply-To: <20211214071259.580602-1-lijo.lazar@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-12-14T07:48:40Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e8f2a84b-66c7-42a2-8af7-70bf6f9682d2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d65f985d-1428-4f5c-3d15-08d9bed62712
x-ms-traffictypediagnostic: DM6PR12MB4987:EE_
x-microsoft-antispam-prvs: <DM6PR12MB49879A89A193BF83C2607672E4759@DM6PR12MB4987.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UG0oV1WgHoWo/tv333BcQsMmjTkgWdxxjpwFlAn8bkHuEASMM71kkzpP72paN0SAWPSKstx2QwocHek7JIXNSH8xADhL8552psOAq6KWTGL5LlUu4Nx/BWY6FXwAkEEuyIEmdJ5VYavnFZA5xT21uGKmHXYTPMlGmuGMMsV3JIqERvEdSfIqhArbmPczZJoO4ZqlTC2HhYzvihmMVpg4HYRJGa13jy5jfK+mdAJRzF+7SLKpKwR+C9svSxpM/Dw7b2LQyzbOW1me17UbJUIzMg+kyK8519PcpX/b43NHJ9UZTchYa+jSV6kdpdAmStvbP1NxuzLmSrp8865f9TB0AfC6CwRezD1xpUNJLX00X83Qe0+KyfMasTQ55nLZ05DUQtxtkAIhcOLfkm29yJqWmoOGkPjKpPh816gXh1PAjV0pp8hv1E8hCDP17G+94IjAohIXfA7zIrpxIZsD0evBpWlFjqxQxHWKlgbKc4e9BySbsh1f4CojeFnVkZmJtxwuoNBRrNU88otmBxfPTMDW2gS33/+M7RckojUs+fTmFThS2XkOAjhmtoYma4EA7ShUOKvxVVmXB0URBb/TnFO/7lw3MnTeZNLsZiWyndXTlfZG/pCfbxsT3zVzfxX8wqEeGlg1YINSpIh+ztNxzw9KRgI031TkNIF42JE4XU4ovx43+ATgu096q7jFB9sQ5gcnFpXE3SkbskbIPrzDsGuitw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38100700002)(52536014)(508600001)(9686003)(122000001)(7696005)(2906002)(54906003)(8936002)(5660300002)(4326008)(33656002)(86362001)(66556008)(55016003)(66476007)(64756008)(71200400001)(66446008)(26005)(76116006)(110136005)(316002)(66946007)(83380400001)(53546011)(6506007)(38070700005)(8676002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jTUNSliAVXEQWWlvGWTOZswSa1EgqNyKz/YHVKI1e2Op5Vbhb8ow6n8kY9QS?=
 =?us-ascii?Q?iYs6aDmc+C4wFT0Qc2gLhypHd4qm8KumiM9bAk3GI0k3W6TX0WkUOBfrhVzg?=
 =?us-ascii?Q?ezMIxuTU5yRo9Zfr3xTjclfnxZ8bi438mRw6GeKY8DSW3S71t7i0VSEjY59q?=
 =?us-ascii?Q?b5wYXoW3PbzIWQkro8ZSovnNehClNS2jFXAzzD6x28mU9GeVn+plXHUTaHEI?=
 =?us-ascii?Q?buS/w8zrC2nmLvxfcHF9pf0fpKRn33Hr383Dadpr0l6MD0Y1FY5T7vxtOjgp?=
 =?us-ascii?Q?8x8yc0uofLMjlUeU3L3WB6fwXhSdXnrS5Y68yO7PnFze75Deffb6ozJjyl/x?=
 =?us-ascii?Q?1DYAGbwbPsLKjSzy3rftHUBhFIvzd6nA5Teuce7E2JCBSSCfx7WkscIynfQx?=
 =?us-ascii?Q?og6GvpbieCT+yPqIA4ZDliR43mkKrjX+9jyDCsz+zFBvSgIioSN9NmQolMaL?=
 =?us-ascii?Q?kcHhIcpfsYb8SB1E1rl2MORFRWLu691VpO3NT7gvesgEhHK4Bt0m8J3zJX+Z?=
 =?us-ascii?Q?BC15l/ngL8zilJqpvPGufLKbkyBT6bM5pHDysLAbTj63a+Xeaokp2Nh/tKmP?=
 =?us-ascii?Q?k3jRc//ZqVU5zPceT3FDSclbutgGUBkbc0aLKGvqjz2620L3IwfEbqCdUwUl?=
 =?us-ascii?Q?QUooQTBwnTida+LNqrMuuRcnjRrWsYWcRhFsblKLGbIYWzfylKa9I0xnUJvF?=
 =?us-ascii?Q?sbGgZO6/03Air8f54HUgRNe0c56eUG4A4RWtAde+t34HNjWR7v7emVpmF9kW?=
 =?us-ascii?Q?aj//AsPQx1Kj9T+haEF75o28zmSKwUEO3RKtOVZfUHSpRI+o3ie5+Fj3m9iA?=
 =?us-ascii?Q?vHzYkGXeXQavq2xId4BwLLanpPz4iTd9mA6P2pbDaEYDtilYlV/Xe8ZH/a45?=
 =?us-ascii?Q?qw6PlObjaGYriCGvVjLdRbxXUjw1cZlGnn4xunRd2dIzqaTn3JLFdOPxRMKD?=
 =?us-ascii?Q?phW4Bl6sxQlIegyycpDi8q8STlTuuCAjLybDeZo10JKhxvxdmzKm1BbHqnia?=
 =?us-ascii?Q?Hl6/iw47zNREiCpu4pXgWfkXRSHe1OjX4bppnI52eCkc2Duwg4cTZqszEXOJ?=
 =?us-ascii?Q?omOkxCMi7udMSXFQxWZ/d5Rxs2GiZ6V7ctDuzf3ws6/8gdcg5EO+FfOFn2DW?=
 =?us-ascii?Q?9z+VPZHhtPEs3pMFjkAXr7kwoGvQRBeWKuPsml1INF3GiyglQGRKuyV2EADP?=
 =?us-ascii?Q?2dc1hnhMxSDTFiDmKM9G+da5awBnbhyNbfqWzG5ngBH+jqqqDKNjL0kehVAe?=
 =?us-ascii?Q?cuVGPrVdtMmV8uPs2Kg2EbrsXBcXHoJJFr2193JMOUeWMLXBzt+RcxrFMuuO?=
 =?us-ascii?Q?UEc0IT1pbWUYvMc1lN+7UPa3Thj8WUN8PnLRzm77I1gg6/kf2meCQ4aygK+l?=
 =?us-ascii?Q?NaSJRIjmCQBOizCt5mPT8zVmMn5g9PyBgUXwOAHfIH+t3lJ9wcUbFLR1Z6b/?=
 =?us-ascii?Q?YmkpEXx1wBSAaToJPQjpZUEtLjuU0JUYjxkvWsnRCE6yQAIyeSZwc87TgAeJ?=
 =?us-ascii?Q?NmR8nByI9EQAalv215hICBXKtYUKZZHbABUP1ieBpzlF9VZIr7HF/ImGXEUA?=
 =?us-ascii?Q?OZYTMfUdxK4wkfebQ6k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65f985d-1428-4f5c-3d15-08d9bed62712
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 07:48:43.5452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3fcBK7E+7t/pa2CEZTB5PAUTCAa8mjy+cvhQMe2CUriQuDWGzWY4Oh2yHGHEDcD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4987
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Tuesday, December 14, 2021 3:13 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Quan, Evan <Evan.Quan@amd.com>
> Subject: [PATCH] drm/amd/pm: Skip power state allocation
>=20
> Power states are not valid for arcturus and aldebaran, no need to
> allocate memory.
>=20
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c  | 10 ----------
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c | 10 ----------
>  2 files changed, 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 05defeee0c87..58bc387fb279 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -295,16 +295,6 @@ static int arcturus_allocate_dpm_context(struct
> smu_context *smu)
>  		return -ENOMEM;
>  	smu_dpm->dpm_context_size =3D sizeof(struct
> smu_11_0_dpm_context);
>=20
> -	smu_dpm->dpm_current_power_state =3D kzalloc(sizeof(struct
> smu_power_state),
> -				       GFP_KERNEL);
> -	if (!smu_dpm->dpm_current_power_state)
> -		return -ENOMEM;
> -
> -	smu_dpm->dpm_request_power_state =3D kzalloc(sizeof(struct
> smu_power_state),
> -				       GFP_KERNEL);
> -	if (!smu_dpm->dpm_request_power_state)
> -		return -ENOMEM;
> -
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index 6e781cee8bb6..0907da022197 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -262,16 +262,6 @@ static int aldebaran_allocate_dpm_context(struct
> smu_context *smu)
>  		return -ENOMEM;
>  	smu_dpm->dpm_context_size =3D sizeof(struct
> smu_13_0_dpm_context);
>=20
> -	smu_dpm->dpm_current_power_state =3D kzalloc(sizeof(struct
> smu_power_state),
> -						   GFP_KERNEL);
> -	if (!smu_dpm->dpm_current_power_state)
> -		return -ENOMEM;
> -
> -	smu_dpm->dpm_request_power_state =3D kzalloc(sizeof(struct
> smu_power_state),
> -						   GFP_KERNEL);
> -	if (!smu_dpm->dpm_request_power_state)
> -		return -ENOMEM;
> -
>  	return 0;
>  }
>=20
> --
> 2.25.1
