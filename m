Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D481C8303C
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 10:34:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A577710E437;
	Mon,  7 Jul 2025 10:34:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yMfVdt8D";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7C2E10E31F
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 10:34:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/hZ33hSdoYapar9tSl5VTSpIGZNIiAsQEKcHNH5xn5QbA8Dy7fcetol8vse9OJaKvv9IttFh/0V1a77wVf8YHJIfgI1ZqmN5fV6Hoa0sj8DUsvbkmtpUWtsBjS8KrP9+Z1RRW1BvLFaET922HSLt6wKd3HJVoYmEhcDKPel/LgtB6j7RB24z/vuE+NVeLEjZt/PCvNUp4vXjzAOrbW1eTwzSrmNTWA1L6k3aHeLiHSSCemxPLsrGoEksXePVM/XrOeoND0mwDOwgVEfaM/kdzgWWXUhRXRnjaUrikXwS+ucjdKPJBH82ATpDHlMe4D3Fd2mGNrqPojJttfCIBDHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NvGi4hOG8upeeEDUX6BhN3QStrTSAp2QuUJ5cq/8AKU=;
 b=fXESTZq1pGgPXHBPVfBwmE3xrRt6ew+I9Poufu0mJmsTSNAVhByCH4QMS2JIEZTR0Dda0aSGvIuZbYYR68Rzh66hp6iadY2Orzn6NTQC2dAxpIRUMUsYEm5x4M9wIgfdtmoEp4XA7U6Mnm8Oe0mdu9GLzRDKbhUhiiR0xkEmUK9MNEFddUC4U+8xz9wUpcz6V57kLOpDxgR1N4uKxHQGI/Lsen5wwgrt9Ud7LicplJU2q//r7XnBFHjGx+b9tdiRDMstwAwH10IatRVEKjfHp/V4WuHexGxn/KD1cZJIBfsz8Gr3mGbGXK0WRc1hdH9sEHifBfjb/whjSfYNzoM4fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NvGi4hOG8upeeEDUX6BhN3QStrTSAp2QuUJ5cq/8AKU=;
 b=yMfVdt8D1zYHTiNgU5/Y6gzPT9MR10K+5CjdoWwoAEv05UGXV+Eowful+ATcnKrrE6ms6Jp+wfRyIqeQqj7vFDJEFPgptLn4QwKmG1xBMejCxUkXm28w2DtDFI4xG0RtP1dvTWRlWhzJS3JuD4zMdA+0Z6T1ZUKKzcedbZekhFY=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY5PR12MB6227.namprd12.prod.outlook.com (2603:10b6:930:21::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 7 Jul
 2025 10:34:31 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8901.021; Mon, 7 Jul 2025
 10:34:31 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Index: AQHb7w4yA9MlwKwasEeOW/KBxO9yq7QmdBsg
Date: Mon, 7 Jul 2025 10:34:31 +0000
Message-ID: <PH7PR12MB8796F1FB8040BB467A44B811B04FA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250707070939.6852-1-ganglxie@amd.com>
In-Reply-To: <20250707070939.6852-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-07T10:22:58.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY5PR12MB6227:EE_
x-ms-office365-filtering-correlation-id: 56db40b8-da11-43a6-922b-08ddbd41dbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?OZC8qBXjkzkxtdN8+Ri7t2v+AD+Bwhg/dDD8WTVJ/+l9nWj79bYBO9GXNroq?=
 =?us-ascii?Q?dec+zulQ38BEcfaplCkbjeqCH6MpS6zuGufutZlLx8yVBAXwEg9HTvabnko6?=
 =?us-ascii?Q?i2fVpQDAAejfJWrkYc3k2Fox33FKcCQOVDzL5EW/laca1VbJh5RcxjW04D/C?=
 =?us-ascii?Q?zffp86PDrFkTq4+nfkJ/CKHyG+YRxhH1VnO2Qu/72cblIqPo6MVhQiqxh181?=
 =?us-ascii?Q?+oH6Z/VkkDaGXdL8rQWpme96asy1BN9OUCUPL98bOiB5HJWO6S9WlG00aaSD?=
 =?us-ascii?Q?O1gDKHCFx9pDq5znUU63cfkQ5iooyF8D5AmAp05+V2naIdQeheLx0qWcD9+k?=
 =?us-ascii?Q?JhaiwIWpWaKfj70IYOpfp/l6DwWnjXe08U/IGHDAbho4ZXuLcbguzdHWL6uP?=
 =?us-ascii?Q?aTjstLfiWGgeRpiiHCtw9Kdzc/EbVrvS550Lby5Yhg35mZ2C1BruD5KSt3nP?=
 =?us-ascii?Q?pqVsfgFYC9cgwkzELqzIvZs02Pu5WXNyRk5k2OFRFynfPJVpBDCrbP2ZarPp?=
 =?us-ascii?Q?vUVMFalNSHii1yGG+H9QTSw8Wjq3NrMo3Emrp9MKFymXS3DzAk8G8ERc7rAP?=
 =?us-ascii?Q?CchnfIEaQiAIOuBTVY7fVdOpX/dEiY2+ukOKJ9hCr1QgtgKU9dFWw2UKtvyc?=
 =?us-ascii?Q?NesA0VASQcIVHY3cVvpE6rZmMW/ZAOKPF621N7gee39tQ/lcUi4VO4XGnbqH?=
 =?us-ascii?Q?t6Mm9c2lCJM4LYzfCDsktrGzwXzII5ZL+H+FG1rZcB2HmwxMTcC1VEy1Bbc8?=
 =?us-ascii?Q?kEMczAkNcC3uJP+Aj3ypNchR9RahnhbmPmZT/7fquIHFw9LoOiYUlwAgKgsF?=
 =?us-ascii?Q?zHW9yz/56KRc4tj/HrS8EyZ7Kkh7iFtQVhslgoBY2X/FVHQbcu2xMRBoJ9S0?=
 =?us-ascii?Q?JbSc/Pc1ANjINx9xnXi8/MlUJulS0TQWXv9xwPmSf1FuBDd4Bdoa0JU2IuCc?=
 =?us-ascii?Q?SMinHA8uzk18rm5xXSPBSgXqjRfeyvOv2cvYi0Z++ng/SCv4gvAYJaez/4KA?=
 =?us-ascii?Q?kR7Me6iJ/SI1ICVr6NxJa673tvfD1Q1orkGA4gxddvFV2ChgMxlegXL8E+46?=
 =?us-ascii?Q?50mRtcJI0Vse8Rpd5KG+I4iFT8OiOWLsjoVQZ88Bke4KbHZKWURsH21aEJ1N?=
 =?us-ascii?Q?8evqifp1dDMaVAHv7Es26diTMorwRRN3HQSCmCkuShGjcb5Aza/6QLvwWV7K?=
 =?us-ascii?Q?+gU1EOfJOhAY33W9wnkx4HSpIgJXIgGM90zmwBoqJUaV+FVyR+oNrrePClYt?=
 =?us-ascii?Q?4FLY7ealVAxrkqlYc2QrHpKFxcGN1Eq5IaCcYoA0c3cDlxNLIOnt1FYqHs7A?=
 =?us-ascii?Q?WuX20jTjtQkbcZEXo6rSZ1Y8QtNZFubnyek9LGOd+xA+fFopoMnbaaj7F+/K?=
 =?us-ascii?Q?i3sfn+qmYa15+R5H17UnGA/iQ9lyJPDncMTe21LYrdwM/X7RG9msReiv+lQY?=
 =?us-ascii?Q?0FD4g76C2Z8dmC7VV3q/r66lnQ0TJlBm4DD0znIStQ59UR4t8tZHZO/e8iFM?=
 =?us-ascii?Q?bAvzJ0zste7SJts=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vIMr4gEIrgZunziFvsN4Crg9bu8QEWCSzAl75M/rbj7A2qaobLfSDTb8Cprk?=
 =?us-ascii?Q?BaXhaznYdVEM9a1V8d+gEjANfIQoI5+Z1v2rNTSQylu+jI7PjAo/Bpv+6KVK?=
 =?us-ascii?Q?my47OgRPlcyNvImqwN/V2kcW/DxjzVEfMaYnny8IQoMZ1KChPYLUFFwy4D6d?=
 =?us-ascii?Q?E1sH9HNXd8ARKJ8qVKAAh/VWIWnADfn/Kz1F9t6ZtCoG1ico9R03dcKBtAlf?=
 =?us-ascii?Q?k6z57xBhHaiC4kzflbiW06/u2OGSOU6FYxATVYbVLHAwimRb3w5to/GHGW+3?=
 =?us-ascii?Q?d5Hhejl4xpkz6HTo0iJIc76RCtMKpArB0Vug5RjqiOEuorqPtxVnE6OFgEf1?=
 =?us-ascii?Q?kygE2BgtR1+7Cka2KrzqMwmdyggkpuKNtnEe1zlwo/rJrHvQDJJReK3U/32Z?=
 =?us-ascii?Q?RlVKC7y6JUtH0BqdIl60Qstnbr598uGFVxXmlK6mTU14EV3bX81sQNpLX2VD?=
 =?us-ascii?Q?L+tZEp44zmPENSXiQRqLxsFT4KlJsgZmr73Q2aN5bnedeorDEeNndX4Vc206?=
 =?us-ascii?Q?W285tMj4hDKbnYdpAA/7mXasqtXaIvz2qFo2TF5DaNq3fqtYGmDyhgFi3v8k?=
 =?us-ascii?Q?rphJmBR2JOYddRgnqvtqi3aK+Fo/WKexielYjEm5MPMeShnazEjAum7AwjGq?=
 =?us-ascii?Q?1SfYytiIXw0vfy2e8K5ehOfDuc/hTAAsyI3JBJjHhR1jOPR5uPZZGbfr2ap9?=
 =?us-ascii?Q?BcjLVtBbt8xYxf/3A2JX+qKPTy7pNg7Gcp3vyYo3u6lCMowpAzsSl6Twgp7R?=
 =?us-ascii?Q?YO+kh8SqnTFRFswR2kmz7pHiQKgeBYaSHzsgU9sMQr3rTsL6zEhxahNbvNL+?=
 =?us-ascii?Q?Ebrap260WxqnyoqUkDRwyHHLUDlr0qGygWanvaw1KCTfIHoFDgpkwS9KQm/0?=
 =?us-ascii?Q?8bZR3AxWvFKQnPnuUMe15JrrSd/g+RCMvs4Tk8t82FUeqkzqCUkyURuaiQhn?=
 =?us-ascii?Q?KWck6OGlU2Aa+16sm6IKYdo1CREdKlPgOeGDMaGFQQ4ob4B6oN8EwmDzKLxP?=
 =?us-ascii?Q?LAccVbwISu20zjguLqHJTHdm/04QsC8Ok5Tt3QJE/m2cxi6a7QlXA/Hsyhdb?=
 =?us-ascii?Q?ntGrbY0zK1qBUvtUBBLbhso17DMdcrbY71iHK4i8BjFOgwLhL/KyYSMAzQqU?=
 =?us-ascii?Q?fAVpQak78Vv82Qt6reidx1s5OXWeslz729u87mPQdVBLfLlqY76LFsH0p3vD?=
 =?us-ascii?Q?cM4OXXk16zpBAnn9USyTcXhpUG0JE2iRr2OuyAmjnKdt/LMhfiC1y97uSGxH?=
 =?us-ascii?Q?k5uun6i8ABzymLe3kYuMALemFPYFzGmSeo4zUavBFQkm2qKXQ2w1T5GjCYUn?=
 =?us-ascii?Q?/h3Nkss/69Mhx2foc5wpXL51ZcjeHdq0Si+buXURJAXsAqMBMh559JOIpbyd?=
 =?us-ascii?Q?6kWKIz6x6v1qfpjrWtJArlZYm0Y3RAYr7hzdBneemm/A4WoeNWdj/1JSyV+S?=
 =?us-ascii?Q?sPKNLfPCL4xaHPmlA+SFBWEDW0rO2Hgc91RkD4IYIEtRJrrUBZcYqBmSb82l?=
 =?us-ascii?Q?h4oe+TuMfRUSPxjs2u0YIsdrFOTHZt+0hzHEiY6zRweQUtKrkNRM19M7yKbH?=
 =?us-ascii?Q?t4PuzSK3DpEIQWTlxFE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56db40b8-da11-43a6-922b-08ddbd41dbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 10:34:31.3559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wERda50+Mt1WZJMhEL5vMEZ82uBzuDBLtOEX/nAUPqaqkUhe/3bCVV1h17wbJWO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6227
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

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, July 7, 2025 3:10 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
>
> add eeprom data checksum check after data writing, before gpu reset, and =
before

[Tao] before gpu reset should be after gpu reset.

> driver unload reset eeprom and save correct data to eeprom when check fai=
led
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  7 +++++-
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 25 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       |  2 ++
>  6 files changed, 37 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 84fcaf84fead..ecdebca7f3f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6506,6 +6506,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device
> *adev,
>       if (!r)
>               drm_dev_wedged_event(adev_to_drm(adev),
> DRM_WEDGE_RECOVERY_NONE);
>
> +     amdgpu_ras_eeprom_check_and_recover(adev);

[Tao] can we limit the verification in mode1 and mode2 reset? No need to ca=
ll it in other gpu reset modes and modprobe stage.

>       return r;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 571b70da4562..1009b60f6ae4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2560,6 +2560,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>       struct drm_device *dev =3D pci_get_drvdata(pdev);
>       struct amdgpu_device *adev =3D drm_to_adev(dev);
>
> +     amdgpu_ras_eeprom_check_and_recover(adev);
>       amdgpu_xcp_dev_unplug(adev);
>       amdgpu_gmc_prepare_nps_mode_change(adev);
>       drm_dev_unplug(dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index f8a8c8502013..e03550be45b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -196,6 +196,7 @@ static int amdgpu_reserve_page_direct(struct
> amdgpu_device *adev, uint64_t addre
>               amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>                                        err_data.err_addr_cnt, false);
>               amdgpu_ras_save_bad_pages(adev, NULL);
> +             amdgpu_ras_eeprom_check_and_recover(adev);
>       }
>
>       amdgpu_ras_error_data_fini(&err_data);
> @@ -3539,9 +3540,13 @@ int amdgpu_ras_init_badpage_info(struct
> amdgpu_device *adev)
>               /* The format action is only applied to new ASICs */
>               if (IP_VERSION_MAJ(amdgpu_ip_version(adev, UMC_HWIP, 0)) >=
=3D
> 12 &&
>                   control->tbl_hdr.version < RAS_TABLE_VER_V3)
> -                     if (!amdgpu_ras_eeprom_reset_table(control))
> +                     if (!amdgpu_ras_eeprom_reset_table(control)) {
>                               if (amdgpu_ras_save_bad_pages(adev, NULL))
>                                       dev_warn(adev->dev, "Failed to form=
at RAS
> EEPROM data in V3 version!\n");
> +                             else
> +
>       amdgpu_ras_eeprom_check_and_recover(adev);
> +                     }
> +
>       }
>
>       return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2af14c369bb9..2458c67526c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1522,3 +1522,28 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>
>       return res < 0 ? res : 0;
>  }
> +
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev) {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_ras_eeprom_control *control =3D &ras->eeprom_control;
> +     int res =3D 0;
> +
> +     if (!control->is_eeprom_valid)
> +             return;
> +     res =3D __verify_ras_table_checksum(control);

[Tao] could you measure the time it costs if bad page records is more than =
100?

> +     if (res) {
> +             dev_warn(adev->dev,
> +                     "RAS table incorrect checksum or error:%d, try to r=
ecover\n",
> +                     res);
> +             if (!amdgpu_ras_eeprom_reset_table(control))
> +                     if (!amdgpu_ras_save_bad_pages(adev, NULL))
> +                             if (!__verify_ras_table_checksum(control)) =
{
> +                                     dev_info(adev->dev, "RAS table reco=
very
> succeed\n");
> +                                     return;
> +                             }
> +             dev_err(adev->dev, "RAS table recovery failed\n");
> +             control->is_eeprom_valid =3D false;
> +     }
> +     return;
> +}
> \ No newline at end of file
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index 35c69ac3dbeb..ebfca4cb5688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -161,6 +161,8 @@ void amdgpu_ras_debugfs_set_ret_size(struct
> amdgpu_ras_eeprom_control *control);
>
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control *control);
>
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
> +
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations amdgpu_ras_debugfs_eeprom_table_ops;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> index bfc86f1e84e5..f36fe46541ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
> @@ -80,6 +80,7 @@ int amdgpu_umc_page_retirement_mca(struct
> amdgpu_device *adev,
>               amdgpu_ras_add_bad_pages(adev, err_data.err_addr,
>                                               err_data.err_addr_cnt, fals=
e);
>               amdgpu_ras_save_bad_pages(adev, NULL);
> +             amdgpu_ras_eeprom_check_and_recover(adev);
>       }
>
>  out_free_err_addr:
> @@ -168,6 +169,7 @@ void amdgpu_umc_handle_bad_pages(struct
> amdgpu_device *adev,
>                       amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
>                                               err_data->err_addr_cnt, fal=
se);
>                       amdgpu_ras_save_bad_pages(adev, &err_count);
> +                     amdgpu_ras_eeprom_check_and_recover(adev);

[Tao] for poison consumption, you will verify it again after gpu reset, so =
no need to do it repeatedly if gpu reset is issued in consumption.

>
>                       amdgpu_dpm_send_hbm_bad_pages_num(adev,
>                                       con->eeprom_control.ras_num_bad_pag=
es);
> --
> 2.34.1

