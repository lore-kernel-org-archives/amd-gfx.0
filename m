Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74D7C77B76
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Apr 2023 05:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDAA310E041;
	Sun, 23 Apr 2023 05:59:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666C810E041
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Apr 2023 05:59:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NahO1oqH1zLgiWph/uVZa8n9LvcTVmmjFGcbwTD4A44Rr5U5qcg2DG6LTQoHmsH4qr9dT70BhNzY0AaalVcYg6/JSa8lIqnYWBgOXNHZJXovf1JcO4TcPmNc0pVcvWwKm8DP7jX9DHnH5FUaWfvYNBQ45VvdMzoNApCi3XVWR0hKORSRXPlMuy06cIrddfJYfT9UjPIhrtpDKDuLnTxWJ2suy+tIuVbx2jF9u7p/MY8Ycm1Ssx1ctoMM7iW/ykSQCjVrV132KtjS2tgX4TYie7aqJkF+AOJdn8/oeUsZBeCRuyFVPycFKTsQ41ezWKCDRX+9nrZZE0RIFf/v61m5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oFVWB9elwGoD8/c9AI4ZJpN3pxYtDhpqK2ZYgYEnLY=;
 b=mHqEAeeqbHYMgiZJhRh/pe8IbT+RUk1XMGqJBkgG9S50vLsBY85lceHoBtc0TpX5TapqzpmC3RYx3DkKpMIBro228gvtmD/uNoFA1uQepV/e10Mq0n5lnPjsKRqmdUR/XAVkQmWPXH847TAaYdNq9fmK+xeeuzBbYyA2s5lESs+11N7BCer6QkJA6IWJkgEPiYFJ4p+NNpguNL15Pd5DVQg9DpJ6DMfYxU1p3jluAo82kkzj6w7d41lqKz8qWPgcCllRkwRzjXjxkNCpz5pRUimP9ACaW9joVDGgjTI+kCms7sTRo9yEINelb42GyU87XagLnaOfonAr55uJnAKLfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oFVWB9elwGoD8/c9AI4ZJpN3pxYtDhpqK2ZYgYEnLY=;
 b=aZsZgufuASp+kA08F+0ES7QQSjJn1rclZMu0Wk3A5R9iTgnAPmOQ7gaktQ0CYPBo1P3Ygzi527qkiBW0BAYBQLuzOL2JTONGYMQaT2/EAeemIA+xsWBhqmkv0FMtGF/ke2Nu6rCrsiLNRVZ0QSBvAoo/el7XpAHMZLwXrFKl1Sg=
Received: from DM4PR12MB5261.namprd12.prod.outlook.com (2603:10b6:5:398::22)
 by CH3PR12MB8727.namprd12.prod.outlook.com (2603:10b6:610:173::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.31; Sun, 23 Apr
 2023 05:59:03 +0000
Received: from DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127]) by DM4PR12MB5261.namprd12.prod.outlook.com
 ([fe80::5cad:78df:6b83:6127%7]) with mapi id 15.20.6319.032; Sun, 23 Apr 2023
 05:59:03 +0000
From: "Xiao, Shane" <shane.xiao@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Topic: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
 successfully
Thread-Index: AQHZccK2PHIdMCo/skGPhrTuoVhwe684bbyA
Date: Sun, 23 Apr 2023 05:59:03 +0000
Message-ID: <DM4PR12MB52613FDE8131C8D991C67D939D669@DM4PR12MB5261.namprd12.prod.outlook.com>
References: <20230418065443.878721-1-shane.xiao@amd.com>
In-Reply-To: <20230418065443.878721-1-shane.xiao@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-23T05:59:00Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=22dc7dc4-3ff1-4c81-8177-a03daae7b2ac;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-04-23T05:59:00Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: fd4c7807-4888-427e-b5c5-63642cb1a08d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5261:EE_|CH3PR12MB8727:EE_
x-ms-office365-filtering-correlation-id: 36f4adec-a978-4b6b-2b05-08db43bfd738
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHzeczS0vLIyZ8sxZkIsH763C0nO+9UbMxL22TlCqfA/eZF39/MoJuNJD28Uj1Spe4O7e8o80q1mGyPX1P2QoDMuFCKjcQbDgmlJnzAd5wOpyKQ9W4wTIsEEWlh0ot1Ds0rOhG4S9TviPgR1xcF43yskjc/OyLieCsZxM44gF9TkY9vPDJa4e9FptsvJihKjSDYL3wbiHGiJx6yBhR2f4ePNmjgwyVhJcwWJhxP0HsyUm4eALW0DUxFdz0Mz49xzU8sw7AmjYowj8IqvSQMf/5vbjYPBKapSXoI4hhJcXJB9UjnUb6JmeWduwc8My90/A33W9zaaaOjf4KqIJttaGqRuELnIqGKaLwwyimLByjk5KjzR+gj8ugpkTsMfG3TCiqQPR+6h7xXlJ300MURSabqgImfFEyN6mX6T2zv1Gm3z3QmjXCTfSBedXgRoLHai+P9mtg5YBfxbuHoml0mT+oGnEKR9TegWRg7iJ4YGIHthfvQqMgZxpnHaosi3gXHOTTbJvNCvbqjRtaGE0obUE3qhlBfc3ZYaW3hE+Y8jFs6mVDAdnc/vgkd5VKbTWXDzAkZT974cU75lbadvPoIjqr0lzjKi0FbMIGwyX3MFwdQJ+Azxr16i8DknvZpjluiZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5261.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(8676002)(316002)(5660300002)(38100700002)(52536014)(83380400001)(66556008)(41300700001)(122000001)(66946007)(76116006)(66446008)(64756008)(2906002)(66476007)(38070700005)(4326008)(71200400001)(33656002)(110136005)(478600001)(8936002)(54906003)(86362001)(7696005)(26005)(6506007)(9686003)(53546011)(55016003)(6636002)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bLQkSX1cdqsdmx3nP8FYa/Xnm5hGq1UmX3AHGRh665+Vz0YzuBTE5Y+4RoYl?=
 =?us-ascii?Q?u80LBBKHu7abjhZPwixLI6+dmawbQkGWjUh0iAYFlnTFBZdiqnFoACjDyy9a?=
 =?us-ascii?Q?7Hd/H7j93zVlZtgggPG+1kVl0D4SmOJmCGbhVQnZndGvoVggNdY6v+iirM2r?=
 =?us-ascii?Q?wkW2h+5kQ9iYvRcWU1PV49PonjXeo/SP48IebGGKVcAEaQb+BwyIXe3Q90GE?=
 =?us-ascii?Q?V18p60+UDdmwuz1fwHrCiUBNNYSC6DxRHsqPWa9xNpRWgK6YW0dBgJ2eScv2?=
 =?us-ascii?Q?xc4s4RaiuWX11fMNPNOQj4exMxQf7tEujczSmQKpVKl70SBaID98NaO8SZ+y?=
 =?us-ascii?Q?SHB0gu1fbcZdUc/oH8VzNUMzJXeN1QOo+apmqT5jnO48H5QeUXd/sjxw4Mnx?=
 =?us-ascii?Q?7G/AZ0zA5p2X17FCR/tcKKEqaoJjA/4If4KZhiMRq/q8XpArTlAMJcoEfoOX?=
 =?us-ascii?Q?RGxmuhRFJbTvfXgZFb3j5tl3nKXXY1iQKQtAHVYum+KPEPZrjBvfzSySiH6f?=
 =?us-ascii?Q?QtM9gnmV77MKADbm3aGmhXihREpKvW5HTEWXxBUuT/xS36E4BiorEUgxiWRO?=
 =?us-ascii?Q?5Rqutfm5BDhTnruhT7/NCj4WD1rdahlrXNhRa4X8PVBKfBWk7NCARxwRAiG0?=
 =?us-ascii?Q?0AGeSDJ7gIFk1QSZucWY3IdWeWg8+gWbqbFwhUy3JID+vwZ2VZZ04QYIFdBU?=
 =?us-ascii?Q?LaS95I8YtbW4O78x2iYvOqxo10a1c/voZlK/hm9BmIGucCT7cCEGN1cKek83?=
 =?us-ascii?Q?7fG3uCb/Iv170AwLzQpsCy8YEUOCxWIihwx0aHWS82l8zuO2Bz0+JZWKtbiJ?=
 =?us-ascii?Q?O9I7l7kmnGGUo4lJuZaNooyp6zDM0lWvn/y+969i3SGkZn9b6wh5EKYl5DM6?=
 =?us-ascii?Q?EZbFhd8/MO6bfToe+5VjtamfjH9hVCCR0hwzjOWGEKIM1hb6g6PDPmiWQgBT?=
 =?us-ascii?Q?yiFlN2ABwChLWhclVpqv0KldfE4MdgAYgCM+ia0u0j7gkuhEmyD/V05ai8/h?=
 =?us-ascii?Q?htNjA/Jf5GFQ+JcaKV72/91dbX91F3Z5ou69fNRxjkeQEudQLkwhSRyOPHWv?=
 =?us-ascii?Q?kxtqPuwHiY/4JzwqnmV6gJtv1z8AvJaZif8cBi5042sd400C15qO2w3pdZQl?=
 =?us-ascii?Q?OJHNBb4Y+IIuIPKBmfsoIM4Cb5JGuDRpPflOyLk/uZluBMSJepdt26RwXUfT?=
 =?us-ascii?Q?KholWwY2VKjms2jRgousD1tXiX+H7vGI6t6Sakr5fAuwkIpfDUEoRrCWDJJA?=
 =?us-ascii?Q?AYpgv1/+F4idUU+1LLRpNyj+S0pxIWB3k8qaWp9PSlo9quB+lyYAxVY5EJ/0?=
 =?us-ascii?Q?xhlOg+WiuMR1MiFIgSKo/YvC2LdkEFbouM0vuvsd+PVaQFWTSeM/Z78vQlk8?=
 =?us-ascii?Q?cgNBr8UIxnyMhL+EJYO+kOJu8pHjXZjXhVbIrmJMfF/UOW01UVXvRXCVQCsl?=
 =?us-ascii?Q?UsRKnK2T7PCQWa75cH2ZKOze6S7GrhaJD/ucZbfRcimQReR0Qbr39fPPmJ0k?=
 =?us-ascii?Q?M4jHNA6jp4uaeLZH5BDUzIDYiTIsEU0H1/MuZmjCh38ySgBS0wIn16+YuQ3h?=
 =?us-ascii?Q?nJTYKemgqC/E/PO1Pdc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5261.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f4adec-a978-4b6b-2b05-08db43bfd738
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2023 05:59:03.1645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DsK6xKFrZtAr3sGBRrD4Db2d6mD3lIcrcGl8ubh/eyts6BitbXIH8H4pujEkyQnh4DKx+owFOu/teLfjjFdDzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8727
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
Cc: "Hou, Xiaomeng \(Matthew\)" <Xiaomeng.Hou@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Ping.

> -----Original Message-----
> From: Xiao, Shane <shane.xiao@amd.com>
> Sent: Tuesday, April 18, 2023 2:55 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Xiao, Shane <shane.xiao@amd.com>; Liu, Aaron <Aaron.Liu@amd.com>;
> Hou, Xiaomeng (Matthew) <Xiaomeng.Hou@amd.com>
> Subject: [PATCH] drm/amdgpu: Enable doorbell selfring if resize BAR
> successfully
>=20
> [Why]
> The selfring doorbell aperture will change when we resize FB BAR successf=
ully
> during gmc sw init, we should reorder the sequence of enabling doorbell
> selfring aperture.
>=20
> [How]
> Move enable_doorbell_selfring_aperture from *_common_hw_init to
> *_common_late_init.
>=20
> This fixes the potential issue that GPU ring its own doorbell when this d=
evice is
> in translated mode with iommu is on.
>=20
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> Tested-by: Xiaomeng Hou <Xiaomeng.Hou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c    | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-
> drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c index 47420b403871..f4c85634a4c8
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -535,7 +535,8 @@ static void nv_enable_doorbell_aperture(struct
> amdgpu_device *adev,
>  					bool enable)
>  {
>  	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> +	if (!enable)
> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
> false);
>  }
>=20
>  const struct amdgpu_ip_block_version nv_common_ip_block =3D @@ -999,6
> +1000,7 @@ static int nv_common_late_init(void *handle)
>  		}
>  	}
>=20
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index bc5dd80f10c1..0202de79a389 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -623,7 +623,8 @@ static void soc15_enable_doorbell_aperture(struct
> amdgpu_device *adev,
>  					   bool enable)
>  {
>  	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> +	if (!enable)
> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
> false);
>  }
>=20
>  const struct amdgpu_ip_block_version vega10_common_ip_block =3D @@ -
> 1125,6 +1126,7 @@ static int soc15_common_late_init(void *handle)
>  	if (amdgpu_sriov_vf(adev))
>  		xgpu_ai_mailbox_get_irq(adev);
>=20
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>  	return 0;
>  }
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c
> b/drivers/gpu/drm/amd/amdgpu/soc21.c
> index 514bfc705d5a..cd4619085d67 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -454,7 +454,8 @@ static void soc21_enable_doorbell_aperture(struct
> amdgpu_device *adev,
>  					bool enable)
>  {
>  	adev->nbio.funcs->enable_doorbell_aperture(adev, enable);
> -	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, enable);
> +	if (!enable)
> +		adev->nbio.funcs->enable_doorbell_selfring_aperture(adev,
> false);
>  }
>=20
>  const struct amdgpu_ip_block_version soc21_common_ip_block =3D @@ -764,6
> +765,7 @@ static int soc21_common_late_init(void *handle)
>  			amdgpu_irq_get(adev, &adev-
> >nbio.ras_err_event_athub_irq, 0);
>  	}
>=20
> +	adev->nbio.funcs->enable_doorbell_selfring_aperture(adev, true);
>  	return 0;
>  }
>=20
> --
> 2.25.1
