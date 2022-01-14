Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DABC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 06:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC0510E58A;
	Fri, 14 Jan 2022 06:45:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7626B10E58A
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 06:44:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=anDfP7oUcy12C32f2dDvokaSKvdy0qi0wiSL8CBM526EU/DR++13vdLM6ZPFb3F6r0RJTyl54em5MO2lcCu9Yp54umDZy1OfDP5dfgZ8XbxFH5H9nop1FvocwZfzeWyTv8y8zLkRVs040BGdTr4Fpi5KkWVnMDekmalp624MadvfxtXjOjjIiguRnTp0ayUfmnGYffj1c8goFM107oE2FyNG8vjjvFrLGc40vdHAKVpnNLYQlcG5+9mpRDY6aQj6gpSf4VIz0Rv18bXqG5UW9+snLh2q0jq2XKDac9NmYOEQ150FZA/JvruOq5O5YgRsM1oMfwt15+8HXgvhD6Rijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmAsZgHWVwik7YZc+KF3oRc8HaP7SW0DbWQR3PYP+bI=;
 b=ZFeljNdA1s1YzzobsHM/qEvWxRup8Y1gT2tEo91eVy3PuP0x56cQ0WO4G59xvbVdI2UddZmIj111cq9uWBYVs5qAhDLOl7AYJh/TUu2qZzw/YHZsgkEOssNAfaNmgG7+qa8bhdkewHhpP5F7KVqusiRHn7v40GwV1N+l8qcWh7UTxZ2p2ir+OixSiumd6xR9b5zS50j7UymoKIHNYYYU5Slmy1AsloQIWrRMTab1ni5tbVPrTTmdGQzIsTO2CEj3QEKeaq2FmI0eO+WDaOVktLSXxLKVmWosN0MPy/2Z0HfXHcqxYjoBLszthuf/VZJhV8tMGURfmUcIqDaj8lA7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmAsZgHWVwik7YZc+KF3oRc8HaP7SW0DbWQR3PYP+bI=;
 b=Gaf7gjVtQjHeI4EQQRFiiONRdWcuGnaCo2yFQbUGnk4VND0MaqZW5mz2nEcHb7zGMoBaqmOKjo488mVpZWWl6BQkB+7gqmY0a9cksS/899PkknjDLBpmkldcdv3ya887NVAEHEb3AZcx1ltMGrFMGfGZkkmgliPW/xE7CN1LZrw=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM5PR12MB1641.namprd12.prod.outlook.com (2603:10b6:4:10::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 06:44:57 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.011; Fri, 14 Jan
 2022 06:44:57 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH V2 1/5] drm/amdgpu: Fix the code style warnings in
 amdgpu_ras
Thread-Topic: [PATCH V2 1/5] drm/amdgpu: Fix the code style warnings in
 amdgpu_ras
Thread-Index: AQHYCQh0KUlGt9yUMUKKIPsd0+maK6xiEl8w
Date: Fri, 14 Jan 2022 06:44:57 +0000
Message-ID: <DM5PR12MB177079EC6D56F9639D398A85B0549@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220114053407.4035049-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T06:44:55Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=b6ba3a85-725c-42fa-8bee-ceae484a0910;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-14T06:44:55Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ef8aa1a0-4d0a-4625-a0b1-02c8cdaca342
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74bb1391-389f-47d3-c5ca-08d9d7296162
x-ms-traffictypediagnostic: DM5PR12MB1641:EE_
x-microsoft-antispam-prvs: <DM5PR12MB1641615D3CFDD1A64C7BB8E4B0549@DM5PR12MB1641.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Aq0Aqe3jzNrbAyUBWd2vR1AGQmNNgntTGqIRj/KJLEtCE6LrcNHp6rJl8xtvMv0GlOPDz6gKzPkzyAHcwPCkN/iBa4PlRyoLM+N1bJcmTb+2cZo7G+g327jezCRu415KApX8lyk82+D9b0hm5h5cEop/7wjB8nnUjDQx2K+hstpFAaUiWrG1wRdb1/riXbayawRfoQ7oeo4341DFSN1x7rT2/GNdbp2VNXtozVQTkvVE0GdCuTyQ2HdhrWYGCrBQLrw2obvH58D74XMows5cTxM9tOHvBnbuLYHsyRG3IxuAT1uIq7wNVEq1gBb1qO5k4mIT7BMqrjuweSW9AqVEwPTXrP2LDCjPLIJ1WtbwRG278OPyjSz6iWFdC3aJ3hzhbk37ImfRr2f/EuKI7y7kcGZhqcw0FhAoSpOaeuiffY01gkMBsklcBeSX0xg2VV+jlWvD9pFSKxLAl4EuaNl9KZ1Ks4B4ghVDo+KwcE/d+N1gNww3SE+AxezzKtybGjt46gRM9gVagixhUIkUJSnD+tw7btd8KR77GEs3/3BLGgCk++ngkb2eJUcthAQ2uDpsXd9je8iwiWd/WAAh6nT7P4rYJ068HBk1mX37GJKg7p+KDiwHvM4NomGA75RetYxSIc+8TLJo1yue+LiUtH5gn0NYMYI0w4Qdb2w3hB8gPdLb1711XDeljkXNlML2g97N/V6ODYCocB6r3Km+lkdYIzYqCbZuNU52sc9lcRzer6M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(83380400001)(66476007)(4326008)(55016003)(66946007)(38070700005)(8676002)(64756008)(66556008)(76116006)(316002)(5660300002)(7696005)(66446008)(122000001)(26005)(8936002)(508600001)(186003)(6506007)(2906002)(38100700002)(9686003)(54906003)(52536014)(86362001)(53546011)(110136005)(71200400001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0S0JbzscTooh6IGn8BWOYi2uwmdMby5ql7WdJhgjuPGWqnFrsyTdYEIww9WR?=
 =?us-ascii?Q?zZfIw4/nUSp4WLXZDtCqG/4nbekmQIsO3t+CxMoof8e2nvI+XMISDXHiHRux?=
 =?us-ascii?Q?U1L/SDLXvNo873Pekzmj56fad71/fkToNc+HeJH9s89SlZXO44MW8uHgeZSv?=
 =?us-ascii?Q?QlCJhHVPk1gaJwLx31dieAeQdJeA66TQBLFSfl+iKfrdSVhBSoApimlUDz7D?=
 =?us-ascii?Q?3ukr64+KKzOpKvvEQOoWdYQYzqrrLQU32++3gS4Ga+BxPnIHH2ma5OMOiqv6?=
 =?us-ascii?Q?wHUolelb8fspFa0g+v7Nm+5VoSijbdUkwzVq/4rhHAofuqWqU2sgBbksxaxH?=
 =?us-ascii?Q?09EYzN4+kplQxaYEjkhOhodFujb+KIVVCfzosaMrpaEF6QiE9dgibSVqHsaW?=
 =?us-ascii?Q?N0j4yS0Uh8E0Oo5TSuv0p/h2EsKwLRJFtvl2SZErDI8nIPYqwD8i30N/AQKL?=
 =?us-ascii?Q?v8ECxGoj8ejLISGZVUpGsG0wJ3mCPJNXXkWT19PIm/lOoVZPOcuk8leJyMRr?=
 =?us-ascii?Q?6Tij6IeEa63tzRSRCt72uU7RNnYyLh+IYXbxN1Z1Dn4/3d4ujClbBXDjCObU?=
 =?us-ascii?Q?XrrGHivXyoL1rAeVAMnQWKal63tbXgyOEWbRWBiMVisqRBBHZiJCaJcYnWag?=
 =?us-ascii?Q?ScRITpEfJsW6UdX+s6GhqrOanvqyDNOnLKNTrJeEHgOTCsCZ8Fg/MCHx2QxD?=
 =?us-ascii?Q?0FjlS4JIpOFchypSwMkBXWHpPD14pI6eaVTzCxW4TpxmJzWarhqgLJwetJPs?=
 =?us-ascii?Q?QLMOZXk39r1tMxSwlHZDuxSwERpqO7IEudQOaifXSn3ck8b2B+3htmpv/hz3?=
 =?us-ascii?Q?R+dMZ6d6dv/kc2Bq7TwoSOrsndee7m8EMwhVS7IV/S7xAFoWZTjJOlAwK/1I?=
 =?us-ascii?Q?K9Pl8COYBwqD+B7tocnndqevK3JrmZVWn75TV4fCOP/lVow2FcGyL/99BVa8?=
 =?us-ascii?Q?hHpQa96Wm+jAuO/uvQE2qAaWNbbxhsizBOv5b2uMpe9ygrd9ASqRoq1tPU13?=
 =?us-ascii?Q?hXur0F3X+sBEOPy+IyPLZW2KUcNtAorPkPIZBPDdlDTnqohl++8MCYxp2TVu?=
 =?us-ascii?Q?3gK5gxkVU6arPSLNngvX3CbYMyKCwkhk5lFL/lPQU0GpLma9phGukLPRpm+W?=
 =?us-ascii?Q?mMn0pnHO9absHODuXKMtJd7sQxVmibBmVn4y3T4Lw6XublphrdtTp4T/C8Pb?=
 =?us-ascii?Q?Gm7U31quRYyHJrPfhJAM90af/X2yeiitx21Iy5ISqE1H+j/UkVgVkB3I2Le0?=
 =?us-ascii?Q?ALIeadj0QN1GfgQSXJDxg6A1E3UVNvlXINVyaXMQI+av++q/wuH6p3Z7FHm5?=
 =?us-ascii?Q?M1JDuiEtbbnH+mgoVkXVzB8FugilwKiA5lEjWQW04/+WDpg7qxJDNfzbUZkw?=
 =?us-ascii?Q?Sf0w4MrCpMZdfw2izeJ+JNVtX3+A6nBIxKvdcQL679LHccES0J89udqaXo7S?=
 =?us-ascii?Q?CgdDeFBGfI6BXWco0oAHz7BE31jSuIR/irVl9uTe60+LDGi8EjV6FIrO9Mvy?=
 =?us-ascii?Q?4t6/3PAf3cJSZCJxA//EgTzIoFytIwDslZSEP884tCydsQEouyD2/p8U+IUx?=
 =?us-ascii?Q?kMGQ9eFwNURvdOydrMM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bb1391-389f-47d3-c5ca-08d9d7296162
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 06:44:57.5411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEZB8N6TnYbLXGIUvmiWHmw8M/8Rl3+/Mex3c8ddqkMlP3GCcg1ws4bbrsAGbn8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1641
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, January 14, 2022 1:34 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH V2 1/5] drm/amdgpu: Fix the code style warnings in
> amdgpu_ras
>=20
> Fix the code style warnings in amdgpu_ras:
> 1. ERROR: space required before the open parenthesis '('.
> 2. WARNING: line length of xxx exceeds 100 columns.
> 3. ERROR: "foo* bar" should be "foo *bar".
> 4. WARNING: unnecessary whitespace before a quoted newline.
> 5. WARNING: space prohibited before semicolon.
> 6. WARNING: suspect code indent for conditional statements.
> 7. WARNING: braces {} are not necessary for single statement blocks.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++----------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++---
>  2 files changed, 30 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 0bb6b5354802..23502b2b0770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -872,7 +872,7 @@ static int amdgpu_ras_enable_all_features(struct
> amdgpu_device *adev,  static int amdgpu_ras_block_match_default(struct
> amdgpu_ras_block_object *block_obj,
>  		enum amdgpu_ras_block block)
>  {
> -	if(!block_obj)
> +	if (!block_obj)
>  		return -EINVAL;
>=20
>  	if (block_obj->block =3D=3D block)
> @@ -881,7 +881,7 @@ static int amdgpu_ras_block_match_default(struct
> amdgpu_ras_block_object *block_
>  	return -EINVAL;
>  }
>=20
> -static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct
> amdgpu_device *adev,
> +static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct
> +amdgpu_device *adev,
>  					enum amdgpu_ras_block block,
> uint32_t sub_block_index)  {
>  	struct amdgpu_ras_block_object *obj, *tmp; @@ -941,7 +941,7 @@
> static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct
> ras_err_d  int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>  				  struct ras_query_if *info)
>  {
> -	struct amdgpu_ras_block_object* block_obj =3D NULL;
> +	struct amdgpu_ras_block_object *block_obj =3D NULL;
>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
>  	struct ras_err_data err_data =3D {0, 0, 0, NULL};
>=20
> @@ -953,7 +953,7 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  	} else {
>  		block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block,
> 0);
>  		if (!block_obj || !block_obj->hw_ops)   {
> -			dev_info(adev->dev, "%s doesn't config ras function \n",
> +			dev_info(adev->dev, "%s doesn't config ras function.\n",
>  					get_ras_block_str(&info->head));
>  			return -EINVAL;
>  		}
> @@ -1023,13 +1023,14 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,  int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>  		enum amdgpu_ras_block block)
>  {
> -	struct amdgpu_ras_block_object* block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
> +	struct amdgpu_ras_block_object *block_obj =3D
> +amdgpu_ras_get_ras_block(adev, block, 0);
>=20
>  	if (!amdgpu_ras_is_supported(adev, block))
>  		return -EINVAL;
>=20
>  	if (!block_obj || !block_obj->hw_ops)   {
> -		dev_info(adev->dev, "%s doesn't config ras function \n",
> ras_block_str(block));
> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
> +				ras_block_str(block));
>  		return -EINVAL;
>  	}
>=20
> @@ -1066,7 +1067,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device
> *adev,
>  		return -EINVAL;
>=20
>  	if (!block_obj || !block_obj->hw_ops)	{
> -		dev_info(adev->dev, "%s doesn't config ras function \n",
> get_ras_block_str(&info->head));
> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
> +					get_ras_block_str(&info->head));
>  		return -EINVAL;
>  	}
>=20
> @@ -1702,19 +1704,25 @@ static void amdgpu_ras_log_on_err_counter(struct
> amdgpu_device *adev)  static void amdgpu_ras_error_status_query(struct
> amdgpu_device *adev,
>  					  struct ras_query_if *info)
>  {
> -	struct amdgpu_ras_block_object* block_obj =3D
> amdgpu_ras_get_ras_block(adev, info->head.block, info-
> >head.sub_block_index);
> +	struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev,
> +									info-
> >head.block,
> +									info-
> >head.sub_block_index);
>  	/*
>  	 * Only two block need to query read/write
>  	 * RspStatus at current state
>  	 */
>  	if ((info->head.block !=3D AMDGPU_RAS_BLOCK__GFX) &&
>  		(info->head.block !=3D AMDGPU_RAS_BLOCK__MMHUB))
> -		return ;
> +		return;
> +
> +	block_obj =3D amdgpu_ras_get_ras_block(adev,
> +					info->head.block,
> +					info->head.sub_block_index);
>=20
> -	block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, info-
> >head.sub_block_index);
>  	if (!block_obj || !block_obj->hw_ops) {
> -		dev_info(adev->dev, "%s doesn't config ras function \n",
> get_ras_block_str(&info->head));
> -		return ;
> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
> +			get_ras_block_str(&info->head));
> +		return;
>  	}
>=20
>  	if (block_obj->hw_ops->query_ras_error_status)
> @@ -2715,7 +2723,7 @@ static void
> amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)  }
> #endif
>=20
> -struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
> +struct amdgpu_ras *amdgpu_ras_get_context(struct amdgpu_device *adev)
>  {
>  	if (!adev)
>  		return NULL;
> @@ -2723,7 +2731,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct
> amdgpu_device *adev)
>  	return adev->psp.ras_context.ras;
>  }
>=20
> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras=
*
> ras_con)
> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct
> +amdgpu_ras *ras_con)
>  {
>  	if (!adev)
>  		return -EINVAL;
> @@ -2755,7 +2763,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)
>=20
>  /* Register each ip ras block into amdgpu ras */  int
> amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
> -		struct amdgpu_ras_block_object* ras_block_obj)
> +		struct amdgpu_ras_block_object *ras_block_obj)
>  {
>  	struct amdgpu_ras_block_object *obj, *tmp;
>  	if (!adev || !ras_block_obj)
> @@ -2766,9 +2774,8 @@ int amdgpu_ras_register_ras_block(struct
> amdgpu_device *adev,
>=20
>  	/* If the ras object is in ras_list, don't add it again */
>  	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> -		if (obj =3D=3D ras_block_obj) {
> +		if (obj =3D=3D ras_block_obj)
>  			return 0;
> -		}
>  	}
>=20
>  	INIT_LIST_HEAD(&ras_block_obj->node);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7a4d82378205..a51a281bd91a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -496,7 +496,8 @@ struct amdgpu_ras_block_object {
>  	/* ras block link */
>  	struct list_head node;
>=20
> -	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
> enum amdgpu_ras_block block, uint32_t sub_block_index);
> +	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
> +				enum amdgpu_ras_block block, uint32_t
> sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
>  	void (*ras_fini)(struct amdgpu_device *adev);
>  	const struct amdgpu_ras_block_hw_ops *hw_ops; @@ -504,7 +505,7
> @@ struct amdgpu_ras_block_object {
>=20
>  struct amdgpu_ras_block_hw_ops {
>  	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
> -	void (*query_ras_error_count)(struct amdgpu_device *adev,void
> *ras_error_status);
> +	void (*query_ras_error_count)(struct amdgpu_device *adev, void
> +*ras_error_status);
>  	void (*query_ras_error_status)(struct amdgpu_device *adev);
>  	void (*query_ras_error_address)(struct amdgpu_device *adev, void
> *ras_error_status);
>  	void (*reset_ras_error_count)(struct amdgpu_device *adev); @@ -
> 678,7 +679,8 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
>=20
>  struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
>=20
> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras=
*
> ras_con);
> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct
> +amdgpu_ras *ras_con);
>=20
> -int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct
> amdgpu_ras_block_object* ras_block_obj);
> +int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
> +				struct amdgpu_ras_block_object
> *ras_block_obj);
>  #endif
> --
> 2.25.1
