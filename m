Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E1CC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 12:35:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF2DE10E119;
	Thu, 30 Mar 2023 12:35:54 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2379110E119
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 12:35:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvMqjj/7oxB9IKhqni77BUQ/FICBoSGWTozhf8p1gKfDkHiD8ne35rMHZ8YBVS7dlOVU2QR5qdWmifidCSPsas2/6VbP/5DdDzo1gpu0hTpaB30cMEzaJvVUm+WrYCExyXoa/aC5bMmIr9Cp5ycl6rGj/x7raOxZzCg/XMD/9XijgoNixqAufdyx/xQPOJNpVuuhGAzGsgPPaHyjhJlBKZ7KjpmbpK84tKTceQWZDeatJeI8KTPhRHviFgKg7rBWyRJ+PXLhl+AZxzyGePXITzM/Dtdk7+YONq3aKfqFswAsM/QByBlUtbMl+QOyl30jL7Kkb2mcBWTpjVIwYuHpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TfgUrKbGbzbp1Tq0Jqc/VWuSgj2VKAwiKfg6sjiTS4=;
 b=N6iFIPLpBo4zVrPWLRsK8FzEfdl5asbaKWczFV8jDNTJiFGN+rgbBYNFeHaFndqv+dtcplRjCYcF+leJ3FSzuzwjospnHg6XWMtWzRnJ5uDi1odU2wsJh6lsPoMpy86mJVVAoK1HcFqLX2d8j1pzMWO0ZyF78ncLLYt75SmkkmNsBVR2V8fOcTLhWyvxkQZLgz2o2/3wY6wxK+9380q9gaZbVbxq6wtmFCPhjoQ6QatvXpk6p2P7VXoW8r799DJPce5QVrW3qR1srgeYj2gTUEAdz8D7SA5k2zBxiKAefoiFmPeO5Z/ajEb+Gpm05nj2HUuM5EUIBMVZ64STuP7RdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TfgUrKbGbzbp1Tq0Jqc/VWuSgj2VKAwiKfg6sjiTS4=;
 b=O9Kk6VE0QHz6pPhZ+exYUozPkmkOpZCb87eDAM0/zEv7gpZmOKmwoAsCWaYY4EvTFT1s7waCyWKFwXcPC3n6aIXUEjOuClcQzc5HTj4a1rc18hNB8of8RQWCg6fczjrzlWCx+GJjeAqMFU2AX/8bz7eEMJ7tkRmRXCeaq5LAE6Y=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 12:35:50 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f4d:82d0:c8c:bebe%2]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 12:35:50 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Huang, Tim" <Tim.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Topic: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when go to
 S4
Thread-Index: AQHZYrAN62s5S4/mPUq/rspXIxBBX68TQPAAgAAB17A=
Date: Thu, 30 Mar 2023 12:35:50 +0000
Message-ID: <MN0PR12MB6101CE23C61978D7BB091B48E28E9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20230330023302.2466048-1-tim.huang@amd.com>
 <CY5PR12MB6369DDBCCB94A420070C420FC18E9@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369DDBCCB94A420070C420FC18E9@CY5PR12MB6369.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T12:35:48Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=5a3fc095-13f7-41bb-81e2-5233fca07594;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-30T12:35:48Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f69db7e6-772e-4502-9f39-a4a13408c195
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA0PR12MB8713:EE_
x-ms-office365-filtering-correlation-id: 26f89d1f-3f57-4db3-1bc8-08db311b4b8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rgOsl3v0PHunOdX1qrKb2kQoW3rCfquosfBXyxJYEu6hA5e3vZA/B2NW7d6h0clpvfgHrQdQISj0GpjkIlaIPFGruz/rpgR361BOaxTbhFqUe5rv7XqLc7ZaVEtyEBCdmmhZzLdms+PDHKXW+9tjBDL7b4jNcvJ6DAwBHVR9NK5VtnlPNFAWh5z6SgsIufJCoNIvxIT/dmoHB8ORN7pvRd177TXXE4bdnN4EyM1lnGgVX0lxnRe1xefgCtPRaGzsttTwdwG9ZDaNctOBndWikzk6a54+Qbs4o/3SK5cXLHTolxi2Lo+uRdIRVyH+D0WKNnnuZ8xGZTWToq26FVk8DrpDvGRQMfdYWv6jPMmBNk2u0XouvhoifFViuLDTVk8lRqN8eym2LS7TpB21qRS0tJg0xuex7EQvs52h119aN8aW4JTesUi5/WbG9GQlPSY5gK+lcuDa0NHpB0Y82OYGldrTyI5EaZEt6Asyinsr1Z/HhYq/umCujA+zVsS0KZpvTP/5OCzsidD+gePsgISedW9QlswYBqL+zg2XMPKWIRGNrmF+VvGhZmmeKnlUBdKL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(33656002)(7696005)(71200400001)(38070700005)(86362001)(38100700002)(55016003)(83380400001)(122000001)(41300700001)(53546011)(6506007)(26005)(9686003)(186003)(316002)(54906003)(966005)(110136005)(64756008)(478600001)(66946007)(66476007)(8676002)(8936002)(4326008)(66556008)(66446008)(76116006)(52536014)(5660300002)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NYDSPSdtzEgg8cILoOZm7YtK+cxJ2YfyrGvzem+31YHshiTmR2L46pM99kBn?=
 =?us-ascii?Q?xREjzUYuWDsYIrxqKy8fscnu4THVKhNd8H3ro96qg9EKj3189f4kx7ql/miw?=
 =?us-ascii?Q?bpropT/7ClJy4pcnNmjwt1rhQrKt/hAw0STUQ7Of3kuHuLEBnpRgNDGWXGxK?=
 =?us-ascii?Q?aA0IF1mVRM88zQGxhbcFtiwnH3oyl9gkapQwSSlR+q64ieVKV9FRYg7T7Irt?=
 =?us-ascii?Q?gOIXpWSfhZzkUgIO5+6lVsMVDvdOeFWb50hsbV9zGsrsMDfmJmW3UI7EYRlP?=
 =?us-ascii?Q?Tuoa4MMO/RnzrLNU3nGu7WLLZ2KIN1R188wWPIvVZXpMXSUhZlJ/0BuDUKPc?=
 =?us-ascii?Q?/fjIDE4k3LhtOLuG0qKlV5MPdehA+jzt+6XRSEksYcSF8STLZuG0g5L2Rnyl?=
 =?us-ascii?Q?dudgH41q43fm59gnXzNrAf/A0+VdzcL4+HaLoNXlIiGdQC4OeQhLqsBMkmtM?=
 =?us-ascii?Q?2tB/A1tWXPVKN5iVE2KnxPiEFRV81eNc8/1e94LWvhK9aQhpdvbO+vgOB/ma?=
 =?us-ascii?Q?YNI2RX1/AfW9lPLEIf0ny2qNmZkcoV0xmu1LL5Mwqwey71jExXEoep9q3S4a?=
 =?us-ascii?Q?jO1+6mX8PoWaez1AdDSxY+kkvM1zJwC0mav+pCF9rrXIZBfXdctn05Z4EmP1?=
 =?us-ascii?Q?ln+6BB4eURiMF29kZOpzJVYruj0HxMGaxpWtRKlEAJNOVK1qeQkl2kGGum1d?=
 =?us-ascii?Q?S8Z+0HtIoagfv+hkeP3EY0iZOpvZREeO1s/uufnhbZI//cCFcYTNU6F8Q6AK?=
 =?us-ascii?Q?1ZvMJ7/2MkHMZvgmL9rdSX9MdeXtUj1jyuz7Xp+T2kwBuXYonhszFO2GCbMW?=
 =?us-ascii?Q?X+dtJ47OH736bEjX7H/2Ue1Mg12HvSA5DI4OwMMzmEtFlUn+AVVjrNaLg+vj?=
 =?us-ascii?Q?1/mpq4oCovW3w8g6TKqQnUQE5/eH60msg2GT0RCXpr1yhpvaPBPUQfeTmifS?=
 =?us-ascii?Q?nBiLrPb9XK0IeHnirtp/kq+K/m9NydixXoL1BErTOk80ablYNgLLOoZENX6J?=
 =?us-ascii?Q?45K0H/kq2j5ibQdee2rvXhk514zNQ7t7RMR8Uxrs777gzMWe4PRDQlH0hKr2?=
 =?us-ascii?Q?nw4yjOpy9yAjfqt0SLL5adKKcE1mIW9yRc1zyXWu6taqf2a87zVcU+XdK8jB?=
 =?us-ascii?Q?LMUkhGiv7JUc7DF8YduG+PZu/nJ5AuwjkoRYM1uUqaTvZhK5n2GV8gCTHmiv?=
 =?us-ascii?Q?fjhgbWgy6RC9ON3w7cjqXUx0+Z5GKXesVlUvEzg8hn/C0Z2SZH6i6J+HpI+p?=
 =?us-ascii?Q?izQkSw8wUhpo+EV+KZjJBrlpADKD2UZp0RCrHinNfZ7woFue7M7MwHMJLcvB?=
 =?us-ascii?Q?b2LRh3VgMh1xsrBJw8exMjSlJH9+y6+i+jkRM3OU//cShCJD/abLvmPtzeUe?=
 =?us-ascii?Q?eA1M2OdB+nLht5kRa2uenuYMLtIbIbnRf5iWojXM1M8Olw4SuV9VwJu4Oek8?=
 =?us-ascii?Q?D4UR8O3TB+AvAKpt7czw6IxFjhTbUUYYHJyxCKZGpsMQnh7bdIFgK6Kt+YOU?=
 =?us-ascii?Q?sdGQZDKP43MCA65zdnk5rjqspfCwYRG4nvDn5SaTv1NPEg68xWYMAH5bOYxl?=
 =?us-ascii?Q?5U1DpU7cnM9gMP8BG28=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f89d1f-3f57-4db3-1bc8-08db311b4b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 12:35:50.4060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BR8LgkL9JajCX6tVP4fiOcz/7e77DBDQPeM/3UZogrIPqegsQAtNfb0WZzwawn12h3si/6n4W0YuPRGkw4d9uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Yuan,
 Perry" <Perry.Yuan@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Also in commit message move the issue into Link tag.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2483

> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, March 30, 2023 07:29
> To: Huang, Tim <Tim.Huang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>; Du,
> Xiaojian <Xiaojian.Du@amd.com>; Ma, Li <Li.Ma@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset
> when go to S4
>=20
> [AMD Official Use Only - General]
>=20
> Please add a Fixes tag:
>=20
> Fixes: 2bedd3f21b30 drm/amdgpu: skip ASIC reset for APUs when go to S4
>=20
> in your patch.
>=20
>=20
> -----Original Message-----
> From: Huang, Tim <Tim.Huang@amd.com>
> Sent: Thursday, March 30, 2023 10:33 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>;
> Yuan, Perry <Perry.Yuan@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>;
> Ma, Li <Li.Ma@amd.com>; Huang, Tim <Tim.Huang@amd.com>
> Subject: [PATCH] drm/amdgpu: allow more APUs to do mode2 reset when
> go to S4
>=20
> Skip mode2 reset only for IMU enabled APUs when do S4.
>=20
> This patch is to fix the regression issue
> https://gitlab.freedesktop.org/drm/amd/-/issues/2483
> It is generated by patch "2bedd3f21b30 drm/amdgpu: skip ASIC reset for
> APUs when go to S4".
>=20
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 0f7cd3e8e00b..edaf3ded4a04 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -981,7 +981,12 @@ static bool amdgpu_atcs_pci_probe_handle(struct
> pci_dev *pdev)
>   */
>  bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)  {
> -	if (adev->flags & AMD_IS_APU)
> +	if ((adev->flags & AMD_IS_APU) &&
> +	    adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU
> enabled APUs */
> +		return false;
> +
> +	if ((adev->flags & AMD_IS_APU) &&
> +	    amdgpu_acpi_is_s3_active(adev))
>  		return false;
>=20
>  	if (amdgpu_sriov_vf(adev))
> --
> 2.25.1
