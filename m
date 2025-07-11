Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF47EC83F1D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 09:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6187B10E9E0;
	Fri, 11 Jul 2025 09:23:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R7KQHh7/";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC21410E9E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 09:23:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMolW3ZzM3oLYR0iqwWLecYkCYiR0H3HNCfcjM4z2+Snceor9zSRE6nlflhza2wOfDxkMLEUiuOGU+AldYGIJfw4FSc9uEqNuDfOn5cIg/YFubD9NUqAYbd9Jx88C2C7xczpza0JrFmurIfpndxDanoZTISZgWL/I3/WRxMMghaL5Agmr9mOhm+quTGK9O57bM2SCx51dNr2ZlAXnqN4sCjF0jV8tR5L5VuEZ+qE8zIThVV6xz2u5RyGqqBcNb/Y0GgOIS/kmS+dmJUHHqypKNy7xkf/oO/AISLRuHFRU3XdvFs0vKLtKrQpqMSbEXZES+CsMu5Cn3N6ka82IGSKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYoSYnCRj8cONO3BDFP0eRSyNiQ8/GTmM9pyo6EV/4w=;
 b=woyRisEe0ztqx8tBkrR0nidc1pCaj84bhv4d4GKBRjCadPYXBP9kdyi9r0/oIHFuvlE8eWvexInEn4jMX5c6ojipKYFHVbnB9HGBnZFFkwacrlhwS+h7shPQchBBnve4lVeimeLe662qKelfthzBp4dP1OeNTYuOEybJCu8khpu/JqY2Qg5aGzsC9QSRWUElR1NViV0PGWa15KGhSdMcwXcqaZJL7vMuiRsS8N/zG3JLWX7DvecFyWAes1b7vpox9A3hiOeA+kK9p0tn+vBlS9QjINsd0fati7JIFES63BOflkTQSTkPYlCDUhf23KyK3hH0tD2yQ/sCruyINvloNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYoSYnCRj8cONO3BDFP0eRSyNiQ8/GTmM9pyo6EV/4w=;
 b=R7KQHh7/MeENeVA3qtlmJmIKYiqMmLtidWU9kvplt2H7Gfm3wk69bMv+SilzbhNbo/Pf4FV2Qd639i6VGtuVhcX6Yveba875ps/yr/CkV+AfKLZ08gwt+Iq1E3HL+RoOaQ3zHrOiz3wP4IvWEjHz8cot8m52YFPgxG8oFU5HWUk=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 11 Jul
 2025 09:23:50 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::9eac:1160:c373:f105%5]) with mapi id 15.20.8922.017; Fri, 11 Jul 2025
 09:23:50 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Index: AQHb8jzEESmXbvECt0+EEqTiw9+cZLQsm8uAgAAKkfA=
Date: Fri, 11 Jul 2025 09:23:50 +0000
Message-ID: <MW5PR12MB56847DB9C67B22B8CD96E96AE54BA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20250711082051.29344-1-ganglxie@amd.com>
 <PH7PR12MB87960EEFD48B164D2D2B1317B04BA@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87960EEFD48B164D2D2B1317B04BA@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-07-11T08:43:59.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|SJ2PR12MB8009:EE_
x-ms-office365-filtering-correlation-id: f5b8f0a0-fca4-4453-9f32-08ddc05ca574
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Zi4ppwV5OkGTydhG7s7d7KFz3BEa9XHP1Z/EtLluWpy55FPCfPLYoj9QUe2e?=
 =?us-ascii?Q?csReUFZ+2qJVkD7t8bve6FCB0qLglhEzqGcZDw/eitWfcEuMQDt4rKk2X2yB?=
 =?us-ascii?Q?TcMzv76j0gzFYlVshgxeb83s1SwEbJsK9Zvv1HyW8Ah0r8VSw9zWiFSrYNAN?=
 =?us-ascii?Q?JQ5kaF7fe7tcjgAHO+wZbcnb3B3+rFVMdD8EJ/hA5/rzgPugcyLF8s+e9uld?=
 =?us-ascii?Q?D0Waw/jCwaVQ6hyi+Ps1/oVvtNon+qUR/XOD4USY8Sdkq3FWj2JJ1ZTDipru?=
 =?us-ascii?Q?JyrIbta35jtpCDQX1Eni7+Q77CBDOiIcXhShrrt3uBpDqPjEias00zJPplhP?=
 =?us-ascii?Q?u1T0PSN8preRPEjykBdMGOiZ5pszOUbI/+ek/Wxja1T4x9JtqLI68gFIOmgj?=
 =?us-ascii?Q?ai7C6prUfGoaXA/AFEnu5sTjzdbDWYiWusMX1f8ukWiimupMV16EzHWV6OZG?=
 =?us-ascii?Q?/IrdNcDyV7wDjcXLJPzJ6YbpmKamXV5yLHY3/zvBbs0fI14uLJ0s1NB7rT+K?=
 =?us-ascii?Q?UyCGDMEYafypYhcOIQN2ovWtw2dD+LHoQW32eAiX12w1tO+c3AIUft5g+E9e?=
 =?us-ascii?Q?vSQuI591bt7qB4w4IgR1KRsGchZN5GxsZCrkiW9yPDrT8wTVHmpofahlbNOX?=
 =?us-ascii?Q?VbM35iUP9rYgz28//Twif/B8oLlR3MZTGGmwejGWsxQud5eZc2yKtMtH8sU7?=
 =?us-ascii?Q?PM08qC7/6OGp+xveFt6yIYOaCc4P5K0YmL9ZYt6UJN5HxdIza8jhs8yfw5kQ?=
 =?us-ascii?Q?uHmTuzcMUoUGgbjFWNmbibflAU0MLYYzehKEhcPTRtmjrxhbjMUWCAzTkX3D?=
 =?us-ascii?Q?QiG+z4xQqf9p7VJ56z3pJQHQJmog2bq+7Bi7ibi+URePIw7Qg1pXMJJEj6Qb?=
 =?us-ascii?Q?1xQrhKON3IhYjRxKib26jIW2ngHGjjR18VRus0pSyS2rx7HRPYeqMDe54U9f?=
 =?us-ascii?Q?zn7dx/wwY1+uTe9RIA+8sT+r83la3+CilKwlZBQJzxzpqHcLONo/Yg0gd/43?=
 =?us-ascii?Q?T5cWH+9PGjacPUtyaFqwtsnq0c60yTHZmgsrfknYcNdQ4KPc86jdN480vGie?=
 =?us-ascii?Q?7OXOHVcYtze0qgnizp+Z4q2qlgkLoxCkJMjW1E8UVnp7JriVsRnth85aqNOf?=
 =?us-ascii?Q?bQamO0F+MJqOIZKsM+POR+6BQnFv6q9bfjJHjiz9nAHCnSsInnt8N3zOyTdG?=
 =?us-ascii?Q?bWB/pXKM4VPcGy/mqGV3+MdiU3RrARqPTzspRqXEgtnRAXrFX4HB1sTgygkR?=
 =?us-ascii?Q?JWFlrF/Oq1tPLYX5prFUKl09syIJt7iJFsVJgb41/Zggd+HbwixMW42oWFZG?=
 =?us-ascii?Q?4rf6lS8wv6Ttos3gFeevOHGSnmhbCqjVh9HBUwnAj7CceBZPTJwTbr+92gIE?=
 =?us-ascii?Q?J5Kfq+R6Kc2PnBEBgnxqd4m+tQ56MvOJQakVwpqvyAzfNjSo3+96oFhO1on0?=
 =?us-ascii?Q?LLFkctHwvC+MQRB8sXF0xQUNJCCSZDm0eIo/P1D0YynzgWsFo3I4GZkxV6ks?=
 =?us-ascii?Q?BCOlXG0XhMk2rU0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7RojjlZ9oSJ29Ys3tcFKYOeQTpqHoK7jEF5h1nDD8hJThlDhRvFwc6kzrqwO?=
 =?us-ascii?Q?U980bYaEHtnLiBWE1+Nkvpf1xtHI/cj4hanV2C+5LmlsRexizxSCSsyHDtf0?=
 =?us-ascii?Q?eAUDPXMaxaG+0W18jY9dJXKMMnSyWS9zRueSlBECxtw4o6dBKHU0u/GQ7B/G?=
 =?us-ascii?Q?S+iuMg6QNFAuZTXnwlnb2ggsOby4HSKCbOUiJimjcD3lAFWdI4RiXbPM9qvk?=
 =?us-ascii?Q?Fm74knDQ3RDWdmlilkP/m8ptqVyzeMAiE2d4HCLFHLL3/GKO3ePYAaAY3p5w?=
 =?us-ascii?Q?P21FLO745Xph8gogomYwWtbCJg0MItqITs9wN/yDJY83hBMoPu2UbUui5Uxz?=
 =?us-ascii?Q?HRvG05HjBoJUzYKO7/cVqI5k97eTmYQqw4Gcst8j1w3KNaPEovaRSfxJs0Fy?=
 =?us-ascii?Q?u3QhdXH79CJICWeYSXPeal7yOudqVnBhAfrU0cada8bYG2w7O6W5W7VMaYzm?=
 =?us-ascii?Q?3iG7Ri/n7GfWEVFfEyvA6PKVRI3RYMzs90TYGRUKFERlfkUtN14VVXN67yOf?=
 =?us-ascii?Q?ml30HX6kM5uCiW2XrsRvn6RaYcpuHecoxyXcgKDkMDdUKKDr8lRDs3w1gNlE?=
 =?us-ascii?Q?usjFRsKCj39GPl3aFkCvjs2CQNENhkPmTHQmTkfP0VGHggGb0v78DSWLJa0Q?=
 =?us-ascii?Q?DSieqmk4n0T7x4YAlBixW9FlgaAvm2meUWbKuTKR1Eu1f/bH6mBRRuDyPd66?=
 =?us-ascii?Q?vUig355RBIOZxaaYg0Yuw79YhqSdHT/UUU3lIKykBglA5+H6pz4HGL44mOfJ?=
 =?us-ascii?Q?UnYbghAtdw3b95RKetrWNemD+rKV+VCPotgrp4N0aZOdhqp98VmNV/VDD/3E?=
 =?us-ascii?Q?z6gSdUjuMxARv0ByfGHjDFbc5Nyq2h3EPYcLomUg89Pdqdb8D96/mv177NyY?=
 =?us-ascii?Q?QwJ1byNzmjsKUprzRhEDrdK/2EbkfqK/DAR/lgyCrmTZL8Yw4xCoTNHumhG9?=
 =?us-ascii?Q?WLDGXhJSOOw3/NxVOvK32MncLiS2ZaKUoEIItT6Qev6EL+3Y8ZZCa6iXLg+6?=
 =?us-ascii?Q?YtkPN8DijtB9jWrcngyRpnckcSzYArNNX0srZgiwfOBWdNSXQu/rHxdv3Ucq?=
 =?us-ascii?Q?neTB6wfW3zf5xOdYBsdmJENtdoDc8D+KNQRdguErpjsxe9nvZ1IzJNIm7Vsk?=
 =?us-ascii?Q?tqtHuT9S181WgOe+EDzU8zeR7uBaXzzK1/QUAHtCtfd4w6+g1qTm+2ltYtHk?=
 =?us-ascii?Q?JNeshHSKWauKNFV91ayBNQ655K38H550T/2efD/UEN6JHn2ZLSEOFxZBK5WZ?=
 =?us-ascii?Q?63EnFAl/CSnpraDdTZUV+E8E+skjVyC5hOeneropgSPqUFD+kMrQDcce34JA?=
 =?us-ascii?Q?x4y+zbhe9hkeYaWUzQdZV3SqVtMDjb8/YvTZUMwdmWY/W0rpQOLnjgzRINZU?=
 =?us-ascii?Q?AsfMyQpKeJ18UMK6ATtrsK2eAZpvQxzyrqWJzqzhyUPbYr/CaYjbaA5/vcDi?=
 =?us-ascii?Q?dww7t4aQ2MGTcjpJOb2/ygk0Xmq2EdgI9Ha4QnMBAue7cUUUJt1B7svTEO1n?=
 =?us-ascii?Q?MK32fKtRCf0BMsFki17Uz01A1pGQmue61FxNBUDGvIotlFnfiWwUediTeQa/?=
 =?us-ascii?Q?mmHy0NasCJF3KBn97tY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b8f0a0-fca4-4453-9f32-08ddc05ca574
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 09:23:50.1480 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5t02Sa106Psw6Kre+nI2TQTcWfH9Jd9HWMZdWRmgHDbNtMKihQe1JnAyFeSUsWAUF0fH22EIIHhzrGDXVnsDYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009
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

Sure, they have been verified by checkpatch.pl , thanks

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Friday, July 11, 2025 4:45 PM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 1/2] drm/amdgpu: refine eeprom data check

[AMD Official Use Only - AMD Internal Distribution Only]

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Please make sure the patches are verified by checkpatch script.

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Friday, July 11, 2025 4:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick
> <Gangliang.Xie@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
>
> add eeprom data checksum check before driver unload. reset eeprom and
> save correct data to eeprom when check failed
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    | 28 +++++++++++++++++++
>  .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h    |  2 ++
>  3 files changed, 31 insertions(+)
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index 2af14c369bb9..b66e09ad0cc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -1522,3 +1522,31 @@ int amdgpu_ras_eeprom_check(struct
> amdgpu_ras_eeprom_control *control)
>
>       return res < 0 ? res : 0;
>  }
> +
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev) {
> +     struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);
> +     struct amdgpu_ras_eeprom_control *control;
> +     int res;
> +
> +     if (!__is_ras_eeprom_supported(adev) || !ras)
> +             return;
> +     control =3D &ras->eeprom_control;
> +     if (!control->is_eeprom_valid)
> +             return;
> +     res =3D __verify_ras_table_checksum(control);
> +     if (res) {
> +             dev_warn(adev->dev,
> +                     "RAS table incorrect checksum or error:%d, try to r=
ecover\n",
> +                     res);
> +             if (!amdgpu_ras_eeprom_reset_table(control))
> +                     if (!amdgpu_ras_save_bad_pages(adev, NULL))
> +                             if (!__verify_ras_table_checksum(control)) =
{
> +                                     dev_info(adev->dev, "RAS table
> + recovery
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
>  int amdgpu_ras_eeprom_check(struct amdgpu_ras_eeprom_control
> *control);
>
> +void amdgpu_ras_eeprom_check_and_recover(struct amdgpu_device *adev);
> +
>  extern const struct file_operations
> amdgpu_ras_debugfs_eeprom_size_ops;
>  extern const struct file_operations
> amdgpu_ras_debugfs_eeprom_table_ops;
>
> --
> 2.34.1


