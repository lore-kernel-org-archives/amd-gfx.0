Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A335606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 03:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JiEXjJvh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 090C310E00A;
	Wed, 25 Nov 2026 03:37:10 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010071.outbound.protection.outlook.com
 [40.93.198.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E03EC10E345
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 03:37:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYcH5111CVp5ySqwZ6QwK3usodovQCcFOmTownum6hMMhALeNy7vOJhGfFHcuDXe8Zc5b01K8IGkQs7IUdj3nuEwd8TKptZ4ChCmv7oPBN2CTJH09KmlQjCM8XjgJ2/pRbfdy7qcAAmfwbLObEO6uu0ksuO2PQaOLm+XgaBvvfQWAvMpZ/FvwMmnx0i5NJqpL04zkzbbvThhYPIbDmzzu50zj7b4G0TM/8ljkS7GxQd0HwYifNg6y41Z+Roml8eSunKaZqEkL4gX9c6HpCy5EbKk9V0vsJ9pNT3YrKi6ZBUQ732KyjFmgXmIkCjp/W4AibKzjaes9JSqPcHA/KACUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjg1LDt/wKGBduhzyJuQXjeKghpF+vUWwZ733w94IRs=;
 b=BxPzDQDcu4DcmFTtGywnXMfeEWeIi8U2sY0BFDD3CeQkg3QbGYunj1Yivp73xLOqXyl363eW6dAuCtORScOThNopurp1JVzjN5q8aiim5qjQseRJU7JMW93FpHQftP2jlGDrpxtIhS8TOoUgu6J1uvs7SoujtooCEeiPs9211/8D0k+wTQ37Do6FDk4ISB17LLL3EsDJOkxjqPg0DsAcLC04H2Va9uxjFNT2ThyheYWEpjFpDqnpWDNAafzsaP7cPf7IktGXm26E1YzajGTI/RtTzh7Rk/MFKCXjx5kSU0gaInTT4GHZ0GIIq9u54fgVmXUpP/7sasuRU28ulOpZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjg1LDt/wKGBduhzyJuQXjeKghpF+vUWwZ733w94IRs=;
 b=JiEXjJvhzv6FbGCi5rHAAw7SK9SgRGNypSI4k/ejyclt1beOdWTPlihbaE4FL+U+1hpsn2Iseu/uj/9TgtF4Bm13e9RdH9VbxOvyMttNtBQR0901bsoljdU26t8tpjmq03nL6d70sbfGprrDHZNaGKa/l/jn4ScCKYgjFOmo8eM=
Received: from MW4SPRMB0025.namprd12.prod.outlook.com (2603:10b6:303:18f::13)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 03:37:00 +0000
Received: from MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3]) by MW4SPRMB0025.namprd12.prod.outlook.com
 ([fe80::8743:fbd4:589c:9ed3%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 03:36:59 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Min,
 Frank" <Frank.Min@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: only save VKMS modeset state if VKMS is
 initialized
Thread-Topic: [PATCH] drm/amdgpu: only save VKMS modeset state if VKMS is
 initialized
Thread-Index: AQHdfImAn4PPYAjV5U+gH4IjCqFTBLc+Iwnw
Date: Wed, 25 Nov 2026 03:36:59 +0000
Message-ID: <MW4SPRMB0025055DFCD4AB031AF7D4A2FB432@MW4SPRMB0025.namprd12.prod.outlook.com>
References: <20261125030255.767185-1-Prike.Liang@amd.com>
In-Reply-To: <20261125030255.767185-1-Prike.Liang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: Frank.Min@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-25T03:35:45.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4SPRMB0025:EE_|SA1PR12MB6728:EE_
x-ms-office365-filtering-correlation-id: 1ce40217-f2f3-498e-916e-08df4aa55c97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
x-microsoft-antispam-message-info: 63+QfWShtRo8eUYe7z/PzznftO1KPH15kNX90WciE6b/H7mmFiPZHSU7fajtyeUGoJ7smZhmv8cgwpD1NTCRPwJRxP/fivBJk+s37SyXrGj9Uep+HemxWN/aYrL7cShbtDtMC/Le4oWKFYYaGw5SCt/zTJOj36wAk17vbbGzkDSVfHVvVWhaAelIwItTVO2rVC6t/lf11A+X5MOk4mu7f7oFxluB8QXTIA9A82H6+Ym2uS2gjf4yNi5D8y3cDkFnzqG7AcBZT8d5a81A1yy34EYvi/0FmkhUaaP+iQYk2Uxe1/iEUCgnlNVT96u9yZJZGxr151mRcO57Pa6p+jBBA0iF5rR1TvTsUGvQDV7VOnYkJBxOfGL0QHziFAjjZCxzUB37Fp3wLzhKrprRw8GSlChaGdOly9Ev9YiJru/u+dq3qG1IdWzoYR3okso71WpXePH+a4ltT1HoGwMY//FI0p/gJSUoKjIdixIYcEBIUv5CcwhH+JFvVIyfA726L2UjuR7mjAskr2S9qECyKQ+l6DyzK6kTiTDhF6QRUkO3HW0l35KSCcqpgD0U19V7jAS44ePdIzl8JbXjVP8SPl5CvHY4l4Ehu81yRhV8ws9PhmiTFAXRAjXciDrcWx6cDGuDAncr2dDWxGskId+Sz0cg4tHLM26pvL+kkxr/rdwozO8HHJMsfAY6+Qc09nMUKlyH2w6cCx0yz3qpHwdPJ94WjVyZ0ndfp1ZYDafbRzLSIVk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4SPRMB0025.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EksZ/ofC6d60rTjDrtulc7BW5J4sSAsYEjcS6lEUrvCuMSY/6dsccSzyygwx?=
 =?us-ascii?Q?7Nl0XEha+tt7ByCEq/TYWFX8fWJLVe6SwGPy7flDevhvXvHVW2UyVEcxpjpx?=
 =?us-ascii?Q?pXVRTKy9LrH0bGC6DVH1xwp6uGuyNk2wULCaBexza93innEhTT63N611ljNC?=
 =?us-ascii?Q?RssCQW0Ic/WVn1zcN36u6b57B3UGReSv3G57ZU4gKCC1Qp+qRRqKJoNx0FQg?=
 =?us-ascii?Q?ALydIjj2RjG0qQfUa4TNYgLRXiZhpaAEfSaKM0KOTgMofQoG/XZ7VoV4xrP3?=
 =?us-ascii?Q?MuCLNQAmpdIJPy2Vask4mPPU+GEjE/iPiQ0Vh4WFTgvvwfU70UwWUSnIDOXX?=
 =?us-ascii?Q?97a9zNKbTD+gLlz+5b8MnllkYSL5Gq1tVjXZJ76u9K8xtEwDtPOz6oRp8EZh?=
 =?us-ascii?Q?XyRERSClpBnwMHO7AFyFnBZHTQMQV4as5ogpGwnMtO3PDTwtzBPvyZNrgTR3?=
 =?us-ascii?Q?SVJalWLlPEze8G/hgsaltleqouWJ4p+bme4I3FQWjvZljxBrKb0P0/seTmV3?=
 =?us-ascii?Q?L95Y8Jz6QNs9xGAegyD8jgK3wziyqzFkWxviq9ymm1862o7V2cACMdBPqlni?=
 =?us-ascii?Q?c2yKxfrhmgMr/3XSLtP9iic2sQaetG/I3I9BrBDQC1L/i0ZUYSsKUFrRrhHi?=
 =?us-ascii?Q?wkLXXJouGUxUqaxGuV8OUTC96ZERC2e3T/vQOKuDYMhOmMMuqmf/V2FBHV3H?=
 =?us-ascii?Q?o9BOpIWwJZChIT19G+YbEwh8SAkp8SvuxELzNOcVlLDizljIp8TqF/Szkwe4?=
 =?us-ascii?Q?lGmMzyQTlVg2gjRbhjjy/S5S2oOOGtxKkUkdTsxjhGNtLGO0xLBN5lN7Pfp+?=
 =?us-ascii?Q?F9xff4D+aBTw2CQoCrXOi5tu6jhSJxEO5nxYLR14ZBO4Zcgj5hC75YrXUypB?=
 =?us-ascii?Q?Sj5NILsOQk4uq9ecNjYCo3IM5PjAYUIyMfPB3tGnb5cbzpqlc+p3K/kyKW2m?=
 =?us-ascii?Q?kshoM6CcfBrJwutBNMesFmMdtRYwvCJV+NgLA+9iyZTWMlLHcQ87ye3xjWUc?=
 =?us-ascii?Q?rfAmg/wFcutejPGRMRM9LG/nabMWVqmuR7Ca58PdHIbOhj+iYYdZkiGVbQvK?=
 =?us-ascii?Q?144/IFobWId7PaUJBl5lJ0Yf6DKWiIy68tIkWDoBGd/qhOJQkfLIIfgEaBrE?=
 =?us-ascii?Q?RPFmFGGKDinET5BZ8MLSwTCPl6Wgw42W3ci3kIWfel/oONfcDQoyob+IibmF?=
 =?us-ascii?Q?8hlx1VWEyz44WcLqHbbh8g7Vj4ZwZgmY/xUEd1ZVa4xV7GzdOQmGlXXOSTin?=
 =?us-ascii?Q?4GLCGKcZKDNBK2pTUYC9QEauaZ0SI3Oy4Dd5iCPAOQnsGFMwCVHLxsBytJq6?=
 =?us-ascii?Q?uKI45T9TcUF3sO/y1qEvH/RsGnCVOgXEzc7nfQKvAoncEC7GjFTMUxDgs7ft?=
 =?us-ascii?Q?igrusIH6hQxqTyr7AfDoN4eCw5WI1zgXAxzqqElZycWRUye4JSQJMzia/hrS?=
 =?us-ascii?Q?fCjzaiQU7AyMJO9NoxWurtmKhLDbHVuLtkQkF3vOwyd9gcurxYiU1zKETmv/?=
 =?us-ascii?Q?wDoO+ypwmbc3sq1rWNEdvpqocysavDBkjzwRVk6Y5PtqCW6JZTQLRJshwWSr?=
 =?us-ascii?Q?wtg26ST8fy9KDXxyd3LPxZIK9jlSbFq4B/sOv6S2rWSt7yuC7p/rJU2k6jWd?=
 =?us-ascii?Q?aFTHWqUbs4mKNwPXH1XkjWjNTyhWRm73Q8PAtJuDMNn2WND7OM2ZwDi/Hm+8?=
 =?us-ascii?Q?axvVdbVz2hvxlC3AO8KkpjQLd8rFrFSFfMmR0YQxbkJSIupC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4SPRMB0025.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce40217-f2f3-498e-916e-08df4aa55c97
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 03:36:59.2695 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLUASZdcyT8GnW1cGsX7j1MsPO5VDASJ0t7mbhCFwWi5PJDB6/tTogzhJ+KpajKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Since @Min, Frank has a similar fix, I will drop this patch for the moment.

Regards,
      Prike

> -----Original Message-----
> From: Liang, Prike <Prike.Liang@amd.com>
> Sent: Wednesday, November 25, 2026 11:03 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>;
> Limonciello, Mario <Mario.Limonciello@amd.com>; Lazar, Lijo
> <Lijo.Lazar@amd.com>; Liang, Prike <Prike.Liang@amd.com>
> Subject: [PATCH] drm/amdgpu: only save VKMS modeset state if VKMS is init=
ialized
>
> Commit 11a08cd5ab25 ("drm/amdgpu: save VKMS modeset state from the system
> PM path only") moved drm_mode_config_helper_suspend()/resume() from the
> VKMS IP block callbacks into amdgpu_device_suspend()/resume(), keyed on
> adev->enable_virtual_display.
>
> That flag does not mean a VKMS IP block exists. amdgpu_virt_init_setting(=
) sets it
> on SR-IOV VFs from the common block's early init, after the IP blocks wer=
e added. A
> VF without a usable display IP gets no VKMS block, so its mode config has=
 no
> funcs, but enable_virtual_display is still true.
> The old .suspend callback was never reached on such a device. Now
> drm_atomic_helper_suspend() runs and drm_atomic_state_alloc() dereference=
s the
> NULL dev->mode_config.funcs.
>
> amdgpu_pci_shutdown() calls amdgpu_device_suspend(), so the guest oopses =
on
> every shutdown and reboot, after it requested full access for FINI and be=
fore it
> releases it. On a Navi32 (Radeon PRO V710) VF the host times the full acc=
ess out
> and resets the VF:
>
>   Received Event: VF1, event =3D 0x3(REQ_GPU_FINI)
>   VF1 entered full access mode.
>   VF1 full access timed out!
>   Issuing FLR on vf: 1.
>
> After repeated timeouts the host ignores the VF's REQ_GPU_INIT_DATA and
> REQ_GPU_INIT, and the next boot fails to probe:
>
>   amdgpu 0000:06:00.0: Doesn't get msg:1 from pf, error=3D-62
>   amdgpu 0000:06:00.0: probe with driver amdgpu failed with error -62
>
> Check mode_info.mode_config_initialized too, as amdgpu_device_fini_hw() d=
oes
> before it shuts the mode config down.
>
> Fixes: 11a08cd5ab25 ("drm/amdgpu: save VKMS modeset state from the system
> PM path only")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 0254b5531238..700d7517f22e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4603,6 +4603,16 @@ void amdgpu_device_complete(struct drm_device *dev=
)
>       }
>  }
>
> +/*
> + * enable_virtual_display is also set on SR-IOV VFs that have no
> +display IP,
> + * where no VKMS IP block was added and the mode config was never set up=
.
> + */
> +static bool amdgpu_device_has_vkms(struct amdgpu_device *adev) {
> +     return adev->enable_virtual_display &&
> +            adev->mode_info.mode_config_initialized;
> +}
> +
>  /**
>   * amdgpu_device_suspend - initiate device suspend
>   *
> @@ -4644,7 +4654,7 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool notify_clients)
>       amdgpu_ras_suspend(adev);
>
>       /* VKMS modeset state is saved here, never from the reset path */
> -     if (adev->enable_virtual_display) {
> +     if (amdgpu_device_has_vkms(adev)) {
>               r =3D drm_mode_config_helper_suspend(dev);
>               if (r)
>                       goto unwind_smartshift;
> @@ -4701,7 +4711,7 @@ int amdgpu_device_suspend(struct drm_device *dev,
> bool notify_clients)
>       }
>
>  unwind_vkms:
> -     if (adev->enable_virtual_display)
> +     if (amdgpu_device_has_vkms(adev))
>               drm_mode_config_helper_resume(dev);
>
>  unwind_smartshift:
> @@ -4803,7 +4813,7 @@ int amdgpu_device_resume(struct drm_device *dev, bo=
ol
> notify_clients)
>               goto exit;
>       }
>
> -     if (adev->enable_virtual_display) {
> +     if (amdgpu_device_has_vkms(adev)) {
>               r =3D drm_mode_config_helper_resume(dev);
>               if (r)
>                       goto exit;
> --
> 2.34.1

