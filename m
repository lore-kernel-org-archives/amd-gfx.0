Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B05DC61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Mar 2023 07:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8ED1C10E0EE;
	Mon,  6 Mar 2023 07:40:49 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7CE10E0EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Mar 2023 07:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2tnAz8b/7VIaI3Y+D4v4uR4XkUL1zKEXleRv+yoP+VXGAxqXjQBRMZtLR5xReokDgXhm6A/Y6gb0R4sIP0IKn3xWfBmzDZZDqGWTJwg82nt6FT1jPXrUfwmSmJyMJ594T/LSqZCD8/CE5A8AZJdNxIgtRO+kfI2j1C9B/4u8YVaQ4uoWy6xWEFAhPVGCEM4pgjaKEWkm58vWlcUtDh1EzBUSbKi9+roSORsbWqlXp7vlAxHGMRqU+0MGyJuazGQ6T6GtGnxI/xlaayZTYVNq/rj7mAMTvJOvLcL1lSB+b/19Nfa2JHhmSSLwZTOqnsuQ1XluW3NSh3WOrVTTD1mkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbWctS+1StOkXA6jlceYWTdJwB7MJtbHuD9n47qIa/g=;
 b=bF23MkloHssEQtY7hpYi63vRlHSNlhhZmDbCuzJ4fIAgYUyZjxD+ZhkbpIiUaWOiYFyzGPpqKrK3XPF/OAHf6tjiz5rsmaDtsYp2JnodqgWGKkIDLGp+5DOg05s+re7+msxcHWbB+gaJjfe1cRpyfVaDyPOiBkP/wNF9/dauprSDGNTZjs1avMrwYBol3t1VhShOEnbW/RNUuQcL2hG16BlasFlRA0uphiWJxwGOIupBScQ7mfMzWjm6SfwQyZG6cefZVrITh2I6emg3wQ7jMnTV6BaqI5bsEWcBwNLM9ZldbCDtjhGQ4CbCHgXyYAj3qDs3Xu1uJ4NflMMFte3dWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbWctS+1StOkXA6jlceYWTdJwB7MJtbHuD9n47qIa/g=;
 b=gHlD1tOYWxBoO26taLJQX8omP0rffO453AljQE4XBxEVH6DezJVpzT35fF+1kLV2zpoCNfJz7yVfqcSGHfQW5BipRX51BhLV2imkvGP3DN7MTJ+TkH/lwbZCFhzx0tOI7CETnjcUwFFcrDX48hey7g87S9IMMT5GXQ/o6u53XVc=
Received: from BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22; Mon, 6 Mar
 2023 07:40:44 +0000
Received: from BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8]) by BL1PR12MB5334.namprd12.prod.outlook.com
 ([fe80::f228:6619:2cd5:9bf8%7]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 07:40:44 +0000
From: "Yang, Stanley" <Stanley.Yang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li,
 Candice" <Candice.Li@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 10/11] drm/amdgpu: Rework pcie_bif ras sw_init
Thread-Topic: [PATCH 10/11] drm/amdgpu: Rework pcie_bif ras sw_init
Thread-Index: AQHZT9QEewICi4hqVE2wfBfmjRmSoa7tXAog
Date: Mon, 6 Mar 2023 07:40:43 +0000
Message-ID: <BL1PR12MB5334721DA717AC64723BE6F39AB69@BL1PR12MB5334.namprd12.prod.outlook.com>
References: <20230306023200.29158-1-Hawking.Zhang@amd.com>
 <20230306023200.29158-11-Hawking.Zhang@amd.com>
In-Reply-To: <20230306023200.29158-11-Hawking.Zhang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5334:EE_|IA1PR12MB8519:EE_
x-ms-office365-filtering-correlation-id: 64488dff-e9bc-4aac-4376-08db1e1617ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WkjdYanhkjkDT0a1fHjHylmBUYLfD2cTB6sXIxAX0WV/VUEOZkkY0Nf9ifNo1q9UxjyHuYD3kmKV93XKc1+rK500I+nI27JASsU+/AO4SwOdwCe5gdK95lnz5l6zbYY4t+xWxXyJ6VM87SWVDASF/X41KsRA7tZNHYaCUhKZz5n1tSt7AiKHpaDXHXZwWyTJtN08dCoVzAbIjF6FZbQ9MFCdkEuVC7dpbUBbhIvNlaX4EOwKuhyOeAu2L6RO+cB0EaOqSnTBF6ix/ILEzlfl+BT42RzOTFvLjnEkjtAbgF3fn2t2ptcyEyH9P/Sk5JebCie6iGeicYsAMcTuXS0ioHK+2zStcdl4kdlhCDdcj0UJ9I8fA3wamml9Hj82WA/Zc1nqNT2DIYtA+TBGpui8XWBrHKqnyPcOvpR1663qh1MxGX7fdumXwneXa4W8JEiqDd+vFTEtwM5D00sP9OjvekM5RkJWxbnSw6RPGTNbeUPr6xbWKuJ93ZiKpTP5aQvrFeKRzyrci/B4m9Zpip+0pYfCxTVtEjaSKiBD/jNTBb0dDMkieulhUoTycml8fMhzLonJUeVDtFz4u8no/Xrn4n3d61IjxSJVLkF1BbygyW7cMBHT4I058Vv/SutvOxmzoNL6ldUwzrGok88DvbF+aI/DKPLDsIomFo45f35eLBY8xlZJwHVU0LuBp0IdLYl9D3jlWNGxEbnrgnJu/tZJvw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5334.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199018)(66446008)(186003)(9686003)(122000001)(38100700002)(38070700005)(52536014)(64756008)(66556008)(8936002)(8676002)(41300700001)(66946007)(76116006)(2906002)(5660300002)(7696005)(6506007)(71200400001)(26005)(66476007)(53546011)(478600001)(6636002)(110136005)(55016003)(86362001)(33656002)(83380400001)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mSiPenmc9IsKaqU44HlmfHcLospdv5y7dTK61ewMAiY++v6LIJhiePtq0FY8?=
 =?us-ascii?Q?iYZQcrrBrYH7NNhH/rULGcO2Jzl628rj+0bYo5nR7EoD4/74sbWh1EmetEUB?=
 =?us-ascii?Q?aHLW4vJfHPfmPHTw+anY1qLMffxICKqoTbIHopu2PHYbkWxQSQXgpSR9VfzJ?=
 =?us-ascii?Q?HYg/H+DKuT14jT4HHApl7avUcizF9M0V/wEdB+08g98IBtg0TcH1/WPcV+wX?=
 =?us-ascii?Q?hcKtY1wH3AN+aRf7JvIpWxjioRuiSnAgebIUQQRVsbUcqnhJxeuDOMd2cKlF?=
 =?us-ascii?Q?T+hi8nA10iumsN8xirYJO/8XgEXMcbGYskHH3FIwjXTPt2d9a/czsr3+OoiC?=
 =?us-ascii?Q?fV950rwI3vcQQQU9YkM0fZ/7DbLotXsgmCVMrmqm8CqyjJvwW+bsiK2k9Ctc?=
 =?us-ascii?Q?p+K+FW7YZIFYt7ktdHWwDxPHo46lp3tzBeEJsM5X9+Wj4mvXKyBpTR+rdFyv?=
 =?us-ascii?Q?NYC+2uS3rm6e8/tcEsPNaN8jwfdG4iJO/snUQOxx2Bx3aCaApLEt0SMPzGcy?=
 =?us-ascii?Q?kDQxDumY0Pzx2lU8ddbRojQFTBJiUb5DedL7I1+NQ0qlqj9sq2Y87jMXaPgJ?=
 =?us-ascii?Q?0zODkL63DGwKhonyaVIOczFa1GTxTTH2mgbeL7to95dC0hT9MLI98k0X59HU?=
 =?us-ascii?Q?9eaegyhWNHyLpPk+pciAr4vvYSFkKDq7lcICKjR5j778nkgilRVMRkKrozIg?=
 =?us-ascii?Q?qmz8bUD2GEduiFOI5Y3EbDtHHcha6n3PeUZYBk5wxzUfYWq6wd8UgBatWiAm?=
 =?us-ascii?Q?KLuld38S+oZy3tVVKH//hLVSh5PTVFHb4/I8qBvipjVHu5Q/C/wfoSr0yqYY?=
 =?us-ascii?Q?3LjEtOVZtUMgc7WJWN8CVNhBzuBMKuD5fVyDX4upqWkMMG2tnIEyiA+x18xO?=
 =?us-ascii?Q?WZW3XMMGrmvRcgGg9zIiVtlj5aR2ILkMkF7p9TGqwAM4gLhEq5UABuDpGqFz?=
 =?us-ascii?Q?chTkWyfJmb7POiiRVbda2CET154IevqF+spV6ZAQYRbPP25T7/ZrVgqxWr/S?=
 =?us-ascii?Q?5MtmsTwFy6pA4PY6az5syD6pr3YgG3cpjAmoxHoXj1/0HDGViEkfEl3Qhee6?=
 =?us-ascii?Q?YJx1EQ5mRbQejDPdZuvko90r9qHxzeN0KxHHpGk4H3jUUR9nC6bgnvarV9jA?=
 =?us-ascii?Q?JWreMuHpv+YNPgUEfp4phBT5C8vhiy3OlwlytgIMkcEf1XIa3zQCXrk0oiJ3?=
 =?us-ascii?Q?ndXWHAnmfyycDIHC0ckw0u7iv0xK0hjpgJgQ/b/d8IupUO6Gx1Ul2FoHYxBc?=
 =?us-ascii?Q?dWUrhWM6jGLamDEyTUwH7RIqnNZx+8d0VgQTC/jW0KHouQEwCMJaFF63/qxT?=
 =?us-ascii?Q?S/lj0UwY1WbqighKzPwnW5IrG55YClQkB5PyG5fKfpPTPsDW4J4dglcQV3X1?=
 =?us-ascii?Q?1XdFekVrW6uuwN4vkZgNhyNA+zz43YXnbH3udMuZXxOUbkK8EqXx6c6ptNsm?=
 =?us-ascii?Q?c1JEBZaFgNJdZwAioqYcAGJfJI75uiC6dV2LvalzmxrxUMuYU/md6NZ0oL6d?=
 =?us-ascii?Q?iRDH8dAkgs2lbKkND6xg0ox8qbOy+sPXrip+9BejGJsPMlS859DW2QxD4Ij0?=
 =?us-ascii?Q?l0ZS1cR8p9UWB8lhS4wIWer0+iBEPXedep/GecZB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5334.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64488dff-e9bc-4aac-4376-08db1e1617ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 07:40:44.0095 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zq5hZiw7UODqE9A4uuE/3I5+QHgzYr9PSo6PmgQU/q2rYZWyhV5hXmlVbtG0Mz+TFTV+vPvHYxhmkiwIAKOHxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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



> -----Original Message-----
> From: Zhang, Hawking <Hawking.Zhang@amd.com>
> Sent: Monday, March 6, 2023 10:32 AM
> To: amd-gfx@lists.freedesktop.org; Zhou1, Tao <Tao.Zhou1@amd.com>;
> Yang, Stanley <Stanley.Yang@amd.com>; Li, Candice <Candice.Li@amd.com>;
> Chai, Thomas <YiPeng.Chai@amd.com>
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
> Subject: [PATCH 10/11] drm/amdgpu: Rework pcie_bif ras sw_init
>=20
> pcie_bif ras blocks needs to be initialized as early as possible to handl=
e fatal
> error detected in hw_init phase. also align the pcie_bif ras sw_init with=
 other
> ras blocks
>=20
> Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c | 23
> +++++++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |  1 +
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 16 ++++++++++++----
>  3 files changed, 36 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> index 37d779b8e4a6..a3bc00577a7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.c
> @@ -22,6 +22,29 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>=20
> +int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev) {
> +	int err;
> +	struct amdgpu_nbio_ras *ras;
> +
> +	if (!adev->nbio.ras)
> +		return 0;
> +
> +	ras =3D adev->nbio.ras;
> +	err =3D amdgpu_ras_register_ras_block(adev, &ras->ras_block);
> +	if (err) {
> +		dev_err(adev->dev, "Failed to register pcie_bif ras block!\n");
> +		return err;
> +	}
> +
> +	strcpy(ras->ras_block.ras_comm.name, "pcie_bif");
> +	ras->ras_block.ras_comm.block =3D AMDGPU_RAS_BLOCK__PCIE_BIF;
> +	ras->ras_block.ras_comm.type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
> +	adev->nbio.ras_if =3D &ras->ras_block.ras_comm;
> +
> +	return 0;
> +}
> +
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block)  {
>  	int r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> index a240336bbc6b..c686ff4bcc39 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
> @@ -106,5 +106,6 @@ struct amdgpu_nbio {
>  	struct amdgpu_nbio_ras  *ras;
>  };
>=20
> +int amdgpu_nbio_ras_sw_init(struct amdgpu_device *adev);
>  int amdgpu_nbio_ras_late_init(struct amdgpu_device *adev, struct
> ras_common_if *ras_block);  #endif diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 63dfcc98152d..f42480b8a8d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2558,17 +2558,25 @@ int amdgpu_ras_init(struct amdgpu_device
> *adev)
>  	case CHIP_VEGA20:
>  	case CHIP_ARCTURUS:
>  	case CHIP_ALDEBARAN:
> -		if (!adev->gmc.xgmi.connected_to_cpu) {
> +		if (!adev->gmc.xgmi.connected_to_cpu)

[Stanley]: Same as patch#8 and patch#9.

Regards,
Stanley
>  			adev->nbio.ras =3D &nbio_v7_4_ras;
> -			amdgpu_ras_register_ras_block(adev, &adev-
> >nbio.ras->ras_block);
> -			adev->nbio.ras_if =3D &adev->nbio.ras-
> >ras_block.ras_comm;
> -		}
>  		break;
>  	default:
>  		/* nbio ras is not available */
>  		break;
>  	}
>=20
> +	/* nbio ras block needs to be enabled ahead of other ras blocks
> +	 * to handle fatal error */
> +	if (!adev->gmc.xgmi.connected_to_cpu &&
> +	    amdgpu_ras_is_supported(adev,
> AMDGPU_RAS_BLOCK__PCIE_BIF)) {

[Stanley]: Do we need to check gmc.xgmi.connected_to_cpu here? The AMDGPU_R=
AS_BLOCK__PCIE_BIF bit flag is not set when xgmi.connected_to_cpu is set
 	    according to amdgpu_ras_check_supported function.

Regards,
Stanley
> +		r =3D amdgpu_nbio_ras_sw_init(adev);
> +		if (r) {
> +			dev_err(adev->dev, "Failed to initialize pcie_bif ras
> block!\n");
> +			return r;
> +		}
> +	}
> +
>  	if (adev->nbio.ras &&
>  	    adev->nbio.ras->init_ras_controller_interrupt) {
>  		r =3D adev->nbio.ras->init_ras_controller_interrupt(adev);
> --
> 2.17.1

