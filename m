Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8648DC83F1A
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jul 2025 08:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27BA210E9CB;
	Fri, 11 Jul 2025 08:45:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J6aXD5ER";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD9C10E9CD
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jul 2025 08:45:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAJDfaGfuN7stJg9gKuBMNQcUTGXazS1IQi4okB8y9JuxYmIO6AcCTM9hdrVJVI1fQzz+1c8RDExQx0frF+NTC8y5tGH93AcVSdJ4hMHW6T8FKIrm/WCXMpWB5J6Huz/2UobGXmIndEp2z7YOt/Knm2ppAWgDi39lde4FNJJvjk4uNlVnL63ANpbBAp8cFFP/DXXVtMd5NARy3RvvueUSWbIjSlhnCpjh+wa8TZK/iInik3yozvJDlcHEIT2hX9A+l9HMMN1WmHDaLjCFsmdYwSWspZ1m+Ay2jk2mha4TB4lJz+Rb94rv1U9pXlElFHdWb9G7FLr2dvgARnGskbvwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwF3n2MyWNNjvCWaQD/Up+XJVta0rQkiD2AyHe+t8W4=;
 b=Qc3PaD+7bUuYZvMven4DxyUKM8v1PyWOfuEOWwmr9H7EI3BjKBxfcyUiDUpfYxd8t/PF2mUlraOPEhe+fW027oVjIbrECxp5Pwi2cat1QByH2tq8uvm4LxmPcspop8E3gwJXPAWSSc5U5toRU61W4mkthoidD5tv6J/Fd1LYmjTr1fKZN+XpcZ9y401ubL8ob+ySqIR/sV7mK1YAUgb2z19lHCyvdIKCj3qy11kwLYFPT0fvUEXSb7nW0ynWO3V4vsKrHpQvPrWjh6sq6V5bJClOaMHw9chbTzSfHUbcYwnCCNnctCIQPDzYKrxuXxIRBCAXpMmYUVB1LyZXTO/g5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwF3n2MyWNNjvCWaQD/Up+XJVta0rQkiD2AyHe+t8W4=;
 b=J6aXD5ER/k89MCIH4PsbiJO9/O88tlrZIXaJiATUc3HoVQHM/hJIlieWA7z5Ww1/LBTSYT3SMxbZBY6cCNNK3gYPrqMWnyRnEPEz6Mc9XhoO1YQth6eWQyLbZlOy+KGlyCHq1YuINsa0RVMirzKp6nt33hWLFtXM3XoZjpjgpQk=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by CY1PR12MB9626.namprd12.prod.outlook.com (2603:10b6:930:106::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Fri, 11 Jul
 2025 08:45:21 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.8901.021; Fri, 11 Jul 2025
 08:45:21 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Topic: [PATCH 1/2] drm/amdgpu: refine eeprom data check
Thread-Index: AQHb8jzECo45rC1V0U+K5Q9A0nwS+bQsm2sw
Date: Fri, 11 Jul 2025 08:45:21 +0000
Message-ID: <PH7PR12MB87960EEFD48B164D2D2B1317B04BA@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20250711082051.29344-1-ganglxie@amd.com>
In-Reply-To: <20250711082051.29344-1-ganglxie@amd.com>
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
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|CY1PR12MB9626:EE_
x-ms-office365-filtering-correlation-id: 8891c638-0558-47db-166e-08ddc0574529
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?/0nt2o88ctqEL5KShDXE1NdtJliVUorcbSa9SVdQF9ry4b3CnffnEqvBJOiV?=
 =?us-ascii?Q?g2bdUIaGgLKhmg3LdbHYtM7vYOccBoU7ChomXpIo5Uwuxx5ZNUyKRSIkZpK1?=
 =?us-ascii?Q?F86sh3dWWmIdfNypliceDtbnEcvsxUSYVvcrxAbZXb6G7eChj5zlYeA7nP7l?=
 =?us-ascii?Q?A//+gINuu2h7dDxHusGGkqEOiSKaK2cpV/LtqCR14uz/HhADvMHHbpx5Mxd8?=
 =?us-ascii?Q?NVNajHmvOcyA0lsLc2rPjKai7uTpm2oyK8UWzzPvQsUQLh0Dr4CsCl37/fIK?=
 =?us-ascii?Q?lY+RL0pN9Xxzg47kWt8GKjagSy3ZYagvLCS7O8A1oZq5JwE6fl5sI5iBtPEF?=
 =?us-ascii?Q?neyNQcL54R+AQmlmBo3wadIbeDsS7eIPwPgJOztwG8MFFNi9mlvI+3fFHYFB?=
 =?us-ascii?Q?L8wfE6XOKWr1YPcPifDeYze2iN6Y+zCNyNEal3L58XOGehpKd/wMFjENHtsz?=
 =?us-ascii?Q?Yoq8pE7TxeZPCq1fxYn/JeaNBRtAld5H7J/WOgh4QCtI5X/17jCi6UmjHasb?=
 =?us-ascii?Q?cLssR35B3OBy5Q1N/tuiKsQrh8L4lM00cRA8UaAcQGO7g2+4nzRW3aqfUOwv?=
 =?us-ascii?Q?YkWSCAl07buIyDsVjPdexYDkVC3FCxM/Ax/7AKGnMg/Du4patmarKwEGFm+2?=
 =?us-ascii?Q?kM0sgcXTzSvR4qZWq7fdpIq3xpW2XtkSBJ+UqHDJ3lk7/eDMdCvxAnhFOUno?=
 =?us-ascii?Q?4cfNRf7q0lhGOzlDyIEHddJkpckLO5g6zSiJ+sg5sKdW0fIicziPAjhH1osY?=
 =?us-ascii?Q?KpGS6OxmvLfyvDWm+ojw/rOPCvfN5GF+qeXuwxdGV8HvnVpBzAhH+eeBmF7B?=
 =?us-ascii?Q?AJyGxYcH9LOLIf2rJv/9tGlLfAju6qk/62okQd5yuDukFd8mcL/wWqu9iUT3?=
 =?us-ascii?Q?/FR3FagwQcem4jw4sFR85IU/0Ml78MmfM6xFC5ZWvFwylKnNNGhoyWHO38i7?=
 =?us-ascii?Q?8jZ5C5foocB5qmoJbQSHhsdGVn3uldjJ14PXDFgL7q2qI/JdBO2HwJshZiPh?=
 =?us-ascii?Q?eR+NXAqjhoKY/BmlPAfj8ZYx4nUsfsAxK6Sg17CSj5sZjsm40jm/S7xSrFae?=
 =?us-ascii?Q?So3HOVkFfpRTF0On3Yo2AtrV0B+8RtiHeJ6psOsMNfp78FCAXTfFYlp6IKt8?=
 =?us-ascii?Q?Xw8Yple/fC/UggeS9jiqatgTsDmBcA+XOLgWVGkoAMjEtGgAFhYo8IEO7dIJ?=
 =?us-ascii?Q?lKzD1UG28ueKy7IYMlPAsw7odoQsskuSyUoCuaGWnihmEJtxq9cv/TZSfB4t?=
 =?us-ascii?Q?IagX2BgFqUdjH2deU+8EcjjAvbh2WcKWjGd0qoWL7oRBUSQMGCoxbnQA+Tea?=
 =?us-ascii?Q?GHKwS4zoc/6RAVurw0Hy+VrzNcRJ4WEZqhTErdxmymkhdd8IGfq68nqg6AEf?=
 =?us-ascii?Q?lMu11YE830PMHRKLV8QR8FvsXT652BFRxJXBefer0gVKvnomCVVWNetRrTyI?=
 =?us-ascii?Q?OSPVE+7ZQ6+MF1RsYJlA9leJlqo+1OGydaNXFra9GpOrTf4pGQI+9Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+aEP48awMr9EbXMhJOnOvNoA2O1Iw5MTauDpLvprVb1b8GCGwKwyYHErQnro?=
 =?us-ascii?Q?bS7/COCrKcx1edMbXMAIlBl58jJlTUMPPXk1QKEoD5KOl4H7Tl8hNgy0ilWF?=
 =?us-ascii?Q?SMZEC3POMEB/VHYSi0XmpD0VAtTzD3dmgzu90plqZ2SIhnJyeZjaWRIznwo1?=
 =?us-ascii?Q?+RhnAg6i0SMp1YiuFpQerMo+srN17A59VMqYkfr15ARAToPU0D20RYeH8Cjs?=
 =?us-ascii?Q?63pXx1cS4qBezwAkruxDPVk5RsJ8pImziID3pL3iX6m03a/lgrnoYQNqsHib?=
 =?us-ascii?Q?O82IG0hfEuFxkH7G556vV+3hQStw2o+Fao7EnOurIYta7tGzBDIdRTJjEzGi?=
 =?us-ascii?Q?ICLaiMdYkk3qppEnOw1nIZlGR8Z6O2FpflxF+ByIcyrTjUXmA1cYQ6dpCadO?=
 =?us-ascii?Q?RPcURUyNflNTgvS7ILMcgiV6y/0nUABinxaUQh7Owr4OjPkYFiPZspnpos36?=
 =?us-ascii?Q?VwOVwrKFmreT03hVkZjdAWgpCOcdDC9I/4sCtFAtxoBX54Vt6C5ZrqAvQrwY?=
 =?us-ascii?Q?hFVK+qPfbWfGDZoKLjdX1LNlFUfddURQetvjwWHQJ8wAryNxDuv0H3nbbHQ2?=
 =?us-ascii?Q?y5qojT48BAfb7gpzMPocJWbdomo/Z1sCb4/u+naOwHQIKqfeCMGk8bM+JKbn?=
 =?us-ascii?Q?unOHPaukdYz1maHHYYAsYgCYZexCG7+8AS4jYCOfES0CKZJ48G0WKkTdBYRg?=
 =?us-ascii?Q?H3CbBC8MUr9m4XWXyY6LCmD0CPUmC5WMYUWeVX65+JsnpP4XGEN2/GF8TqrU?=
 =?us-ascii?Q?D8oT0saX94Y1VYrK+1B25k9FHTYCKMgC/gZJoNLeM9QDsmaYf7FHOTiGh01S?=
 =?us-ascii?Q?VlkenyMK32pRXss+HUXKibtNmhBn8rSNk34+E+XHgb/dVrTFmIK1YguA4K+z?=
 =?us-ascii?Q?eqnGbiyveyiPg/n5VJWnXHw/sWCrX9mnveHFCYUjZ1KLV/Mw8axsMEhmdT/Z?=
 =?us-ascii?Q?A/7JJlInJKlxNU1hGO8v8M6bJg0SFAb3KhaQleScd2F24D1WnDN1Ednb9l5r?=
 =?us-ascii?Q?mI4Py4JI5iJqo0IWUzCGqK8iKhCr4DJaABf/0Urn3GX1/L2etL7JbGt/DJwE?=
 =?us-ascii?Q?k9w9MLm4dX1HyH3pHuVjQRQyTL3kUwHMtF3+OcaAsZK1kaqpz9XVBCDjmFlV?=
 =?us-ascii?Q?y3HcdTFq7v+TMM8NhnesAWC8JEl7/xrEQcvoQ28MPUSfLAalNykDMjRWWEEO?=
 =?us-ascii?Q?60mWyLiE8XF8MTn2GR4e35VytIaIpNVypO5OYowIbAl+ewehWE0fBeRxzWO8?=
 =?us-ascii?Q?NiBTL/NjwTAQinO92jNBWfOT2l/LVnz/2ID81Rq5ZDKk9Qtu8Ws+ok3XRRFb?=
 =?us-ascii?Q?eMs+NTa6r1fN4NEYpeG8LojNuiGQYaRkH6BS30ht6YWZG15xEroh4NQSh5te?=
 =?us-ascii?Q?GRy4bQT4gxqjbLxQNSm75p6LG5CsIbUxm3uVuEPGieMzXM7kxBpjYVMkfTDJ?=
 =?us-ascii?Q?zTq2HOB2ae3ChDt33DMO9qp62x0+78VcJg05q5ZhIVQBjVT9Z7ka7E/Sz2tQ?=
 =?us-ascii?Q?Hyz5D6sdBa5205sUflE+/1eH+4j3nKIHnpwRvIOLCoLDNbRvYykr+WbmlL+S?=
 =?us-ascii?Q?pL08oK0u3Nvq6WL6ed0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8891c638-0558-47db-166e-08ddc0574529
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 08:45:21.0909 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N3zP8vBYAIzNZDWpGCfOu+TI/yMBa7DUyCA/aIBqXAiPl3JGvh9iG1+a3CIymQJB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9626
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

The series is: Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

Please make sure the patches are verified by checkpatch script.

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Friday, July 11, 2025 4:21 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: refine eeprom data check
>
> add eeprom data checksum check before driver unload. reset eeprom and sav=
e
> correct data to eeprom when check failed
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
> --
> 2.34.1

