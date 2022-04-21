Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB87C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 05:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDADB10F343;
	Thu, 21 Apr 2022 05:23:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429D610F343
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 05:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DuCWUWCSAw9sypd+qlB+wugM+ceJAQ0McAW3J4oi1zYiyC7OmCU9mMYXXTa2CJrXYZ/zOxkPAXD7v+teTqEvAKgRaf4QrPJJRcNRz7isvMizqbzROK2ZWw6jL3HrhXKktr8uCpfMPZgmXWeZkaVB3pVykZcHOsdmKr0iNHW7zpzijEwm9uLdI8PFeXCiqvRvLty0Uc7pHQIOJ3kXF4NPdeqr1p9q4AncK7z1GkwbvedHr+P8e+y2Vmvh2LvDe9XjrLwOM0PPlNLn0hyM8cYiIFqQ1ZrwM6oQtzLGrFs36Oli5vnY4Kg2q+CC7giqqaAJkBdLFu7xTE7AwhYeG2qvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qq+8CuI4wBAn8uxFlqx/DWQ4AAc+JoqHAVtT+dAGkbs=;
 b=cOiGOre/AxosbJzbTG3bseciSFJauqJ99WcNLed1FONCZShJNicYgz/Xwc0SGfRgPLBcmjkLIeBiIbRnYGMUsut42NjbDOd8YlpNGORcBuZvwHvHv7WysXjZSS3s+hSU6Lcg9X/jO9Aw3gZTeo6xYwTFt2kDGnNLRuog9kfGh0BOSmQL/DtltVYyntwPIqNlLG1DkwblhUDZYIOHm2EawCx/ElcKNngV0foXCgqiR70/bJlYLrG7Xv0i92upe4SkpKMbqAtJk5S2Fc769ZsN/7NuT+Eu3xSsG2lBSlAKxvlMC/M97Rp2evd8Gz5/HeGh3il5grKZ5EXlf564YwRHSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qq+8CuI4wBAn8uxFlqx/DWQ4AAc+JoqHAVtT+dAGkbs=;
 b=nRdKlGcLhkcK78+4XWdg795O1pmd0JjCyfp7j4LbbGjCnZVJ3qGRQ89ndyAunoY8JtlJPPZN4NlUXpBF3EvBP608cLDeNTQZnHgZAPWgum8bagHeHV9mlqJVkviKtsYTGnpjSSZJY9WmNhr3x81wTHQB5KsOTuDCQuEbPk3Digg=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Thu, 21 Apr 2022 05:23:03 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3%6]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 05:23:00 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Thread-Topic: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Thread-Index: AQHYVS432Zk5XhYXa0OBtAL/AccRrKz51Twg
Date: Thu, 21 Apr 2022 05:23:00 +0000
Message-ID: <DM6PR12MB26191DC7B831965BE81CC5CFE4F49@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220421031607.1745623-1-alexander.deucher@amd.com>
In-Reply-To: <20220421031607.1745623-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-21T05:22:57Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=1e7759d1-74eb-441f-a680-960296aa5bf7;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b72db5fc-8313-46f1-2877-08da235700b4
x-ms-traffictypediagnostic: BY5PR12MB4242:EE_
x-microsoft-antispam-prvs: <BY5PR12MB42429FBEE8EF5B89164FA6ABE4F49@BY5PR12MB4242.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0PnhqlIZMPh/7pMM0AmFhxKWrCtS9GARX3Pvc3R58EAX2T6wYcdWO8JrG7Q5uy0Rnv1Ph2RBijnDtOM7jYm6rKeVOhiDwX5nIPHUuTR9Ar0tQo4tJ1Zr8yB+1iAfmPopRSrmBDAvftNWKnLaUJxVRzBheur2ZiQnACg4jOzn7BJirysxwmkRc874wkcHZPm3WMTfGrT4tUUOAx2CzOV5ZnlYXjNHTtM1zFOFUwHY8Os4JE8rGu//xh2vLlzo0AOoshiuSeE4CHqB1RwDHdYYjeYpoKUTaIVsX8jqQ845DlgrZpGAZEgcDS2xN7IBTkhWd/laakNwZQNkoNDrgf6PdJ3I1ZXB8cYcNrk/QmKbLGCjEXjSIKgV45mYcJOukTAfHysnLIfTnURhNg907L7vFGkBvqU5DM3bEHF9++5sJ45dgRWBMIr9xEnYrKHLAQhwvL/xmwbCsbcDH53/o7txnKVojq1bA7EUnODmsWtWjeJkivGDaY51yo11hxOw0+y2+0LrISsdmdWwyMUjDolVNlRBWVVFG0oSrEHxuDUp5el2pHmEQ2XPVOmr8YGxM/eMQ0pTyNvlAdIEhVCNrC5ZSdlLoKaO+g7IoGjOfEVXh66/zYZLB9PbvarwYQzeR+c4KoH4RJ1xL2dBlAe/Ie0oewMOXa7/JA5NMREpja5F5Fl/qXlDHFDuWyypWlEl/sP8jDgaSuHwxrkf1MgIqhF0LB1m2eSPy/BcCUmQyksDcdE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(8676002)(86362001)(83380400001)(186003)(38070700005)(26005)(38100700002)(110136005)(5660300002)(54906003)(4326008)(9686003)(66476007)(66556008)(8936002)(71200400001)(66446008)(508600001)(55016003)(66946007)(52536014)(6506007)(15650500001)(122000001)(2906002)(7696005)(33656002)(53546011)(64756008)(76116006)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gxkwpReHbDf5R0WSGrJgedqwaLkATaw3GTqeKFMqL/0bMuH3VQ1EW8ca6nDn?=
 =?us-ascii?Q?UN6Muj7LMZKhwdTUfYHgrr9jc3dZAG517oSvsebgMjFI3O+Yu2Mhx73nnrOU?=
 =?us-ascii?Q?mbZRUCY0Ae6GZDEcYCZoUbQg6tLtAWhT8Yl4anzQWuv6HKihxvbdDytbDpE8?=
 =?us-ascii?Q?nbuZwpWM6pQ22XO5/F2qyitWB1u9ATm4R0O2rmEn9zLuSQTCK5pOFc9JhG5e?=
 =?us-ascii?Q?eELCCixeNnC1GNweca/+peAdCivnzawhs7jicQH9CtZ7ny3hRb2SdPYVCG1U?=
 =?us-ascii?Q?IXg1+MXxUWaLTmqJ08ZujnHbHSj2WHoNE4obPSqdJ40EyDbFkiXVovR8kHtn?=
 =?us-ascii?Q?TB3aoiC8RRHPmXwMtbxCIEqD4kOwA4zMI7HVED7EAeEsE7u/Cx7p3xRlvQga?=
 =?us-ascii?Q?1wDaY/zXyNh+JjAU34VnffwxzpMrUFLBq+Op0NB07sYmay5UKtkONLOPmwnJ?=
 =?us-ascii?Q?n2OjEUGK7TEc5PEWrMJHUNxcGIpgs5DsiWJiTGC2CqSHz32pEPJCRARfxNSC?=
 =?us-ascii?Q?2JDJj0YkUkQ0D/XVIGIFyPB//Xb5n8hM2lleiN84dWi0P4T43JlWXX7ol4bW?=
 =?us-ascii?Q?z0kErHAAOWD+mb2TZncI51GwcYQnlxbZ4VQg/SaHuiL8lqpxx3dDoryW6qse?=
 =?us-ascii?Q?Xlvte1Qcrq8L/GFC4duiNpS2FtbJ0/tdLFjRL09TnAQtUUnNa9ss9XYjoA6r?=
 =?us-ascii?Q?YK1WZ80IAgU2LY+RcWKVNoEzWxJvEs21G+kEoyYwY4pts90BNK1xeXfdxY7g?=
 =?us-ascii?Q?Aa53LCNRCWK/yDx/6ySqtkfa2724V7rNW90fOpfbwPQIJh0or2Qx1+ajlVY4?=
 =?us-ascii?Q?tQvaC+plTb/MAOmqmQgTTUUeM7LpjwgJEVYb55e2oyvxF1d+5jgmrvnikLyd?=
 =?us-ascii?Q?WykEK/mgMCoHp2T0o86WyI92Ob0UCqF6OKVEC7dwcr0JNC3ki3bFp2R7+IKv?=
 =?us-ascii?Q?024e9CjhISv7z+x8S/BmfMwEoIEUPO8qavlfmnv1/eZnPAW7H8JXCsd9vQZH?=
 =?us-ascii?Q?Xoo1IHsK4Jfr7nxxNCSaIWDG8rPkZ3JsDK/oXg7LBOf3s8aNbT3OkBSB+6U5?=
 =?us-ascii?Q?Vu8QhFGNfUyWJmgX1iYOh5syNOnkKz/4MJEa2ROrLPcOt6A8cxmwvRkZzUOw?=
 =?us-ascii?Q?QnShkB5d4LCODi2c2OJBs6aOF0kkjoZJ2lZnkY4zQ+qu3sIM5tYYDAPPI+ZY?=
 =?us-ascii?Q?mPV7jC5av1brQyZbZDwYpkNqv3962t9okl86z+toRrCeUUi+TSRNqJv78UCT?=
 =?us-ascii?Q?mkBm7B4JvdqBPUn33R8kpxg5sipoMBqmhffwQ4FDCELJDrsMT8G11VG/l+W7?=
 =?us-ascii?Q?Bb2WSBQH+sNbE0GKWJwQ/8JpMDij/+kv0S/e1P8///4FK7HH/2NyhCjApAoW?=
 =?us-ascii?Q?O6VKYXTGH0wkx2zWQYKlDOijdSpfm4uCautxKsmoXZT/xxSRv75NTJIUE13I?=
 =?us-ascii?Q?vnkRRAhhf4qOXd05InDENtK9z5y0y8aYexKbA0vcdSh3UC83J1oRI8QoPDMH?=
 =?us-ascii?Q?ZegCNYo01HTvXzKr/Zwrl4d38k4vsNrXlcYo62x0krRX7Wf/EV1i0GMxAIhC?=
 =?us-ascii?Q?PpcwEHWbc0cHcE+cSNbLeER5Qkpil9tdrQuktsp6q5Uo6buX31BZfwmi/uti?=
 =?us-ascii?Q?IoyrYjSdb1qcjvARi92QnBp7sv8aQPZ++LHHwTnX7wwN7NBjriKsauF6IvxW?=
 =?us-ascii?Q?xG+kUJCY4Sm2zqyxXsQ66HcSyyvm+I53IYYhved0/Fn+RLER?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72db5fc-8313-46f1-2877-08da235700b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 05:23:00.7124 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rikZfKa48d8qYctTuShW3UwMsvdXG2bOhqiHdrSybJl2fk810hJdD7kdh+RRlOx0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Michele Ballabio <ballabio.m@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Reviewed-by: Evan Quan <evan.quan@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 21, 2022 11:16 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Michele Ballabio
> <ballabio.m@gmail.com>
> Subject: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
> attached (v2)
>=20
> We normally runtime suspend when there are displays attached if they
> are in the DPMS off state, however, if something wakes the GPU
> we send a hotplug event on resume (in case any displays were connected
> while the GPU was in suspend) which can cause userspace to light
> up the displays again soon after they were turned off.
>=20
> Prior to
> commit 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of
> setting up AMD own's."),
> the driver took a runtime pm reference when the fbdev emulation was
> enabled because we didn't implement proper shadowing support for
> vram access when the device was off so the device never runtime
> suspended when there was a console bound.  Once that commit landed,
> we now utilize the core fb helper implementation which properly
> handles the emulation, so runtime pm now suspends in cases where it did
> not before.  Ultimately, we need to sort out why runtime suspend in not
> working in this case for some users, but this should restore similar
> behavior to before.
>=20
> v2: move check into runtime_suspend
> v3: wake ups -> wakeups in comment, retain pm_runtime behavior in
>     runtime_idle callback
>=20
> Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of
> setting up AMD own's.")
> Tested-by: Michele Ballabio <ballabio.m@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 105 ++++++++++++++++---
> -----
>  1 file changed, 70 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4efaa183abcd..ebd37fb19cdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2395,6 +2395,71 @@ static int amdgpu_pmops_restore(struct device
> *dev)
>  	return amdgpu_device_resume(drm_dev, true);
>  }
>=20
> +static int amdgpu_runtime_idle_check_display(struct device *dev)
> +{
> +	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
> +	struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +
> +	if (adev->mode_info.num_crtc) {
> +		struct drm_connector *list_connector;
> +		struct drm_connector_list_iter iter;
> +		int ret =3D 0;
> +
> +		/* XXX: Return busy if any displays are connected to avoid
> +		 * possible display wakeups after runtime resume due to
> +		 * hotplug events in case any displays were connected while
> +		 * the GPU was in suspend.  Remove this once that is fixed.
> +		 */
> +		mutex_lock(&drm_dev->mode_config.mutex);
> +		drm_connector_list_iter_begin(drm_dev, &iter);
> +		drm_for_each_connector_iter(list_connector, &iter) {
> +			if (list_connector->status =3D=3D
> connector_status_connected) {
> +				ret =3D -EBUSY;
> +				break;
> +			}
> +		}
> +		drm_connector_list_iter_end(&iter);
> +		mutex_unlock(&drm_dev->mode_config.mutex);
> +
> +		if (ret)
> +			return ret;
> +
> +		if (amdgpu_device_has_dc_support(adev)) {
> +			struct drm_crtc *crtc;
> +
> +			drm_for_each_crtc(crtc, drm_dev) {
> +				drm_modeset_lock(&crtc->mutex, NULL);
> +				if (crtc->state->active)
> +					ret =3D -EBUSY;
> +				drm_modeset_unlock(&crtc->mutex);
> +				if (ret < 0)
> +					break;
> +			}
> +		} else {
> +			mutex_lock(&drm_dev->mode_config.mutex);
> +			drm_modeset_lock(&drm_dev-
> >mode_config.connection_mutex, NULL);
> +
> +			drm_connector_list_iter_begin(drm_dev, &iter);
> +			drm_for_each_connector_iter(list_connector, &iter)
> {
> +				if (list_connector->dpms =3D=3D
> DRM_MODE_DPMS_ON) {
> +					ret =3D -EBUSY;
> +					break;
> +				}
> +			}
> +
> +			drm_connector_list_iter_end(&iter);
> +
> +			drm_modeset_unlock(&drm_dev-
> >mode_config.connection_mutex);
> +			mutex_unlock(&drm_dev->mode_config.mutex);
> +		}
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>  static int amdgpu_pmops_runtime_suspend(struct device *dev)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
> @@ -2407,6 +2472,10 @@ static int
> amdgpu_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
>=20
> +	ret =3D amdgpu_runtime_idle_check_display(dev);
> +	if (ret)
> +		return ret;
> +
>  	/* wait for all rings to drain before suspending */
>  	for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
>  		struct amdgpu_ring *ring =3D adev->rings[i];
> @@ -2516,41 +2585,7 @@ static int amdgpu_pmops_runtime_idle(struct
> device *dev)
>  		return -EBUSY;
>  	}
>=20
> -	if (amdgpu_device_has_dc_support(adev)) {
> -		struct drm_crtc *crtc;
> -
> -		drm_for_each_crtc(crtc, drm_dev) {
> -			drm_modeset_lock(&crtc->mutex, NULL);
> -			if (crtc->state->active)
> -				ret =3D -EBUSY;
> -			drm_modeset_unlock(&crtc->mutex);
> -			if (ret < 0)
> -				break;
> -		}
> -
> -	} else {
> -		struct drm_connector *list_connector;
> -		struct drm_connector_list_iter iter;
> -
> -		mutex_lock(&drm_dev->mode_config.mutex);
> -		drm_modeset_lock(&drm_dev-
> >mode_config.connection_mutex, NULL);
> -
> -		drm_connector_list_iter_begin(drm_dev, &iter);
> -		drm_for_each_connector_iter(list_connector, &iter) {
> -			if (list_connector->dpms =3D=3D  DRM_MODE_DPMS_ON)
> {
> -				ret =3D -EBUSY;
> -				break;
> -			}
> -		}
> -
> -		drm_connector_list_iter_end(&iter);
> -
> -		drm_modeset_unlock(&drm_dev-
> >mode_config.connection_mutex);
> -		mutex_unlock(&drm_dev->mode_config.mutex);
> -	}
> -
> -	if (ret =3D=3D -EBUSY)
> -		DRM_DEBUG_DRIVER("failing to power off - crtc active\n");
> +	ret =3D amdgpu_runtime_idle_check_display(dev);
>=20
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_autosuspend(dev);
> --
> 2.35.1
