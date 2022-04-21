Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C7CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Apr 2022 02:53:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0326410E334;
	Thu, 21 Apr 2022 02:53:54 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A119910E319
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Apr 2022 02:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTDAEljWAbMpuDhhjuwQ+s4el6Ggu1MLe5hpQ0gkwP+mwFLAqNB2dOjITZRqyLjfztrzHjj52vV0bY2NcSlkz2B50kDh/2HqUnXSL1pd99HDIftiqk02qgvX+X+xEsLFx7HxUxqaLZWji3bOSYZLV0+M9RJrth8TRY1fS475cO/TR3j9NzmOCEBOyMALOBx+bwWLZ2YbqsDmz5So1xs8/AHggfh9oIX2TrNf2zHwAzgRR9+zpGM4YHwtXJn0i2nB9/BA+GjjXjppGNyrgN7yXj5dHAjiy8oZ4uLCUILovoP74DQI/adHtsA1VgtrbPLlAaPIRRL6/RWepkOsltiuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HVQMxSNkyhNQTCCxVRQdFQTijkkXdyjjGtaMoiBr7k=;
 b=aDZvOrfZMS2sdy2B4nfgzMOgYiCpiXP2/9l+PYZA/wJHneDEcA+hMQT39PeoK0DuaH+HE9CNGFmF0bl7zl6TZrfo6rRBimbg+HBJasaoh0BMuWEwPblOeT5KP67RrqQPIt8B1tW2Tqfw5ZByTNuMcJEWvCB4hPqqo4GLmc6YsViMbSBv1n9o8McrB6Pbhe5IKJdMXFbl+Qnz2bTBB3Ob9qzEDUAwullW9Peq3HILSsNvFyg6/RJNoefL2bOpTr1o32BfyAk9AHNsaF+45SB/x1TCJBNVp4bfLncqNXlCK9JZS/7zMJ4ubyASOhRYYee13aTp04NPprrgEta38RFSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HVQMxSNkyhNQTCCxVRQdFQTijkkXdyjjGtaMoiBr7k=;
 b=kKAhC5Z+b3LuNDkStXTcq9nNd4w/8TTg6N4C2DsuKVKlx5QqZ0Cia56Pzvmhk4Q+rkzVrjpGdrDvGK1EDbI4k6MsE9b9CXgr9mrvKKO6BiVwRsgTSfQXBUdche3nqo8vFuKdDV0XZ5d9c4i1V15J/OBmA8Q87iBxeiJYDuOwnl8=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 BY5PR12MB4869.namprd12.prod.outlook.com (2603:10b6:a03:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 02:53:48 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::8558:f9a2:7eec:cfa3%6]) with mapi id 15.20.5164.026; Thu, 21 Apr 2022
 02:53:48 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Thread-Topic: [PATCH] drm/amdgpu: don't runtime suspend if there are displays
 attached (v2)
Thread-Index: AQHYT3NE52A/RBVSRU6jaHIUdD3XHqz5tU0w
Date: Thu, 21 Apr 2022 02:53:48 +0000
Message-ID: <DM6PR12MB261964F5BCF0D48BF1A8B911E4F49@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20220413201522.2084041-1-alexander.deucher@amd.com>
In-Reply-To: <20220413201522.2084041-1-alexander.deucher@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-04-21T02:53:45Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e7e188f4-95c2-4560-adf3-7172ef9385a2;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1a0e05b-a2f2-400e-2bf3-08da234228a6
x-ms-traffictypediagnostic: BY5PR12MB4869:EE_
x-microsoft-antispam-prvs: <BY5PR12MB486967B5BA97AD1EC176B17CE4F49@BY5PR12MB4869.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cdEUv7eAM7JZdPJHO5E4Kydn983xU4shFrNtZFQJW1mR94FlG/Sh9HO6lQeZpDT+aftgvhFKESSq4uWptzgQTqdiIWLFTsTuqvWiZ369EQVPqplJeLZJpJbqpo4u3uMdfI4NIlvbo1GLSZazVWGtoNJ/4yntIEKPL10SR40uwd7tVubrxlDETYBRhOdAebSyak15zk7600EDlLZCmxQrfaVjAlTw++It+MzVv0Py6DqNRIH6skiJUH3+9ZXAAWkjEsO319proMhHundzvYUawG8WNNgonjOQEH7CFoL5mwzJeg/xqekG83AxeMZoKiORK2/rUTxZap/m8VuW3vecybWf1ADDJ6carBHZfQrlX1bX93BqugiCOCZVfVR6+Id1eaROl4yCe2VdvWw7or/I0NNvFdqjuJ5jA73n7fT3gBjl0c/PGdq7tcjAfIZO9GJgjuQFSzVV70+M8zes1jZau2a90/04zO/2UOX8SCFl4CREd0+sf6FgspfZYTvS+eq3zVoXS+8eGMalpzozNSnygqSvuOwqVqlACIcTfMVhFixa5diQrs+APlSz4UsvvDb38mNPDPYh5w06x2zl+GUbf0QU9v/Way/x2BrncrfT5u5X7eSAAxIqhkbzALm4kVec5vh00HEAW1bhKPRry+rDaxet03jEjYoPXKCVL1BVMN5h9RLsJIZ+cXXLh+kW31xQHr1VlOyZSevzROiTmotMxAe6nGBZDgj58+ZzDSlS7A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(64756008)(33656002)(76116006)(26005)(71200400001)(53546011)(54906003)(186003)(7696005)(66556008)(66476007)(66446008)(8676002)(66946007)(9686003)(2906002)(6506007)(5660300002)(4326008)(15650500001)(52536014)(508600001)(55016003)(8936002)(38070700005)(38100700002)(316002)(110136005)(122000001)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Tr6ZcbhTlYdifd1kJBQsGV+MdeCnXaiPrb1vbKMp4KIvjh2+VCa90giuoT34?=
 =?us-ascii?Q?SYuXUJQuHNNQn0cKlwSi/jhwjpdpmbN3Dto1J5OXL2HGXojMYSUI7UkVUo4B?=
 =?us-ascii?Q?JoJeCa/icsOLKnfV0mD9bLpj6RYD7uEVBbF94ictBMpV1qLuiFX/xPaYxPIa?=
 =?us-ascii?Q?XyU0hghsbkLTtzhe6O12wHlgq8GlBE4VzEp0AFbz1YQWXqUlZ0cdoF3wNmZ4?=
 =?us-ascii?Q?2ZN9xCVIUSp011GPy9CUWM0gyj4Fz2vVZXCqq/mynKVWpOV8j+Gm7agtXwEJ?=
 =?us-ascii?Q?VEgiUlDut+mD5cY4n4LraIq61JmjV6f4bBmECxCcmqRxO3E9xTQKSjODHHYo?=
 =?us-ascii?Q?nvZiztyIr87mBJoBm4acdoQ8r/PWEnlaqBh11lAzJ0MPwoMUkFVxpARTzB2I?=
 =?us-ascii?Q?0mP3fKE/03Y1Nm/rlZllZr/Ks0ACLGDq29NVNj3d6aRk0LC5Z1qED+m4roNI?=
 =?us-ascii?Q?I23AKmk35ek5WLd7Viyw2JcYq7vhClEVJ86q+OBf9ycBAGiVWOSWoKYhG/eh?=
 =?us-ascii?Q?M3UN3aJyevTYxi+vy2gC6gC6VvLJK8HWvJVnPZ3EWvdsdKG/mpyy6LBTNxRt?=
 =?us-ascii?Q?GkCZ147H9SX2DG9Px0P/Bo5JRxh/iQ+T8Nr382dhmyme2v7hTdpUllI1RKOC?=
 =?us-ascii?Q?Op4CRLR0ClWIpGSxc2kjdSvx39JixIebmjFvczB3SiIyycbeBzQSm9VtptXp?=
 =?us-ascii?Q?9s4gsVFZXHWS3d4bO5eD2vtz/+smJFyuLqC+pkoObuJEh1m2XIGrmNtt1O2S?=
 =?us-ascii?Q?Bpao40s/ZtTmpvrLmwkCyi1Dq0xzz2VRqR5x8pRc5Fy7atj1cIurcMOZlmv0?=
 =?us-ascii?Q?MSAKOmT5wxDE3IadtaPpz0JyqZqqgIxYeSk6d6Q9cwLv+/TaugnNEDf1vrYr?=
 =?us-ascii?Q?ZgrJXfxJLDeU5C8idCim5wFemmGC89IHUfwOZSWsGO8FZOl1c8HsiBEHV241?=
 =?us-ascii?Q?WdXa3pVyqIfhZ6dc4KEmcA0o0pvydtN7a1KLp+nEwyhGsKUJUG7XIm55hq60?=
 =?us-ascii?Q?R7q1HE7fU5BwlRdYcKKcQv+EPD/ZapIj2KTlRB52x5U36AK/P/taFXSjJUMs?=
 =?us-ascii?Q?H070vRCPc3O0Ejv+xuuppNQq59GtMfJlWavjSABdzy54lBvCbFzdpTo0h2Ag?=
 =?us-ascii?Q?jU8t+n+jXQQ6nlgrqR/9Bh0pIzPcFPsRdPMyVzLYL2JheVW/I0L4wVFVTo0j?=
 =?us-ascii?Q?0mnFOvg3z3Zu+hUgcS8KOOg6AZuDDof39vw5hGfoBBMqQzRA2QCK78PlRJ1A?=
 =?us-ascii?Q?5FVuv8pgL5HzQOOQKVMC+y4eHO0XDJtQmVQoznh49JV4aboHHG/biESJWuum?=
 =?us-ascii?Q?MjUK0ja6OwbiTRb8W0LV6qobfc8eTfAT8ls/Pw4xG0SwYTwZH2JwITiCSJiZ?=
 =?us-ascii?Q?FoD6GMwIVTJNrnxpY5zJ6z617D76cQhH73eHyjehQBe9bibtwJwHwsxJ34Qx?=
 =?us-ascii?Q?2jeWdsFsl3mRNW4nvAQ5pvNduPol8ClwV9nMEc+/KMKM50AYARBnNNV08KAb?=
 =?us-ascii?Q?pQdz3I6Ka+bnqJM7LCs6nOnrLZjlE1Kaf9Gp0J1UYJZNrHWVpltp9p1T4A9i?=
 =?us-ascii?Q?IvEi/Vv6+FXOu5cpcTmbkzW5SDnk4PUktREqEGfZRtUgpzxu5maGdjlU904T?=
 =?us-ascii?Q?kvLGit9rnpgjOfFkAk/BsaAKA3C5k7G08SWb+UFH/j1m9sFV0BACAmsygu/U?=
 =?us-ascii?Q?iINi6GLvd22CEs2RvUR9MKXId8Apr7b7jj4J60n6Se6oVY8R?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a0e05b-a2f2-400e-2bf3-08da234228a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 02:53:48.2357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBkHpkEmjUNFOw6uyOBh42i+q48bL9k8r8Vl+610Dw3ELQSKfhH05WreQRrdHF5F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4869
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



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, April 14, 2022 4:15 AM
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
>=20
> Fixes: 087451f372bf76 ("drm/amdgpu: use generic fb helpers instead of
> setting up AMD own's.")
> Tested-by: Michele Ballabio <ballabio.m@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 107 ++++++++++++++++---
> -----
>  1 file changed, 72 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 4efaa183abcd..97a1aa02d76e 100644
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
> +		 * possible display wake ups after runtime resume due to
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
> @@ -2516,41 +2585,9 @@ static int amdgpu_pmops_runtime_idle(struct
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
> +	if (ret)
> +		return ret;
[Quan, Evan] Previously, the following actions(pm_runtime_mark_last_busy/pm=
_runtime_autosuspend) will be still performed even if ret is set as EBUSY.
But with the new changes, it will abort directly without the following acti=
ons performed.
Is that expected? Will that make any logical change?

BR
Evan
>=20
>  	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_autosuspend(dev);
> --
> 2.35.1
