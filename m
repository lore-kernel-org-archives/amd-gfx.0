Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C0ACD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:14:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFAF110E96A;
	Tue, 16 Jun 2026 09:14:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wlsF55zh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B8210E96E
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:14:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sDOpC1bBrtFBR7FTbb0ut2AIx/+j6RztA6tiOtNB2tupGaVOWrqMkb6kDuFSQCB1/spGFWGZKMSmOZo8DXc7yA4OlGX7RlfZzdrTC8D7A3EGUBt2J/WhPZKJ/nn9vGnafk0EKYjE9shG+fdaDXdXh7bjBR6vokW9K2clHtyOK7qxRxCXPUP0uI/snoeZBn1py9X7yGrsBtX9hIXNPbBXkGeN5w6ielHyELVwCkUv6I+2l41OT+890iAsRjj6EKZMlFsSC90pS955EHOhcGm20SAJmkUjzk6VHvpg3b4/ZIhK9qvwGD9GzuvUkbal+3RbnjBZ25fKWZ2smMFfv/5s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fmDDhxjF/rd9sDqw1sU2pxMXfnxjuSctmsSZHUd/yA=;
 b=gDUu5fEpusH0/13+VucPiTKJ4P+deynC3I3JJ1ngS5dIFuMy7jdqxkXCQYcFnENB/rBVizBz4IhDF6yvDXAZiLanm8W/T62snhd4W1T1rtTlSEGejWxPJ5NbWiUEEPF8tbqYE217GwWk0I/4omx2oRGCQx8qjH96+nQR5W8eGk+BhBjfx7Ja5XYQhH7SnCbGzJjIaM/0QwJUwdHTyjaNPoe0CEGNiP3zQKp5xee1LzJO5c1U8Nok5qaahlcgo4BiPz4ga5gyt2YsmwHFXxbEDZoTYV584X+FaOAGZwwjmHSFUKMYQp2FR4PXVifT0TidxrgFqSRfWwWZ3A4HqMjOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fmDDhxjF/rd9sDqw1sU2pxMXfnxjuSctmsSZHUd/yA=;
 b=wlsF55zh6kQ+XPDC3fPM/RmSUSA1SYNA/UeMvLPGsuhKEim6+xH42Z9u3hg4QCbQTzlYy1BJJ5obWgYqoLQIZKevSDaGjO3koeK5oOQcO8AzU6eHeQR3ZG01RqSXJsOfCmQkoGwT1AnBssoNfqObYfU8Wu6la9dZjiYLi9DlXDk=
Received: from PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20)
 by IA1PR12MB8288.namprd12.prod.outlook.com (2603:10b6:208:3fe::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:14:41 +0000
Received: from PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0]) by PH7PR12MB5595.namprd12.prod.outlook.com
 ([fe80::6c0:e416:3955:9ea0%4]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 09:14:40 +0000
From: "McRae, Geoffrey" <Geoffrey.McRae@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: clean up discovery and preempt sysfs
 entries on shutdown
Thread-Topic: [PATCH 1/1] drm/amdgpu: clean up discovery and preempt sysfs
 entries on shutdown
Thread-Index: AQHc8YRH7Jod8bLdDkesH7xq9a7jgrZA8rGAgAALVXw=
Date: Tue, 16 Jun 2026 09:14:40 +0000
Message-ID: <PH7PR12MB55959EF4222C9BE782AFEB3088E52@PH7PR12MB5595.namprd12.prod.outlook.com>
References: <20260601050502.102957-1-geoffrey.mcrae@amd.com>
 <df020cb1-0612-4b5a-a7d2-154ca1b771f1@amd.com>
In-Reply-To: <df020cb1-0612-4b5a-a7d2-154ca1b771f1@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-16T09:14:40.671Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5595:EE_|IA1PR12MB8288:EE_
x-ms-office365-filtering-correlation-id: e72a2c3f-04d0-48b8-a668-08decb87b276
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: YKVkcxKvtcIda88b/y75fSgIgyiikB+j/FYqSLD/rQoB2SafmIJCQdFBl8m0V1sagAZV6tfceP8i97AzGpYkOsCuR/hdGGNAQROlyMQQL1mqJSf/y7Sq5gcZ5JrvkKo0OdU+E5u8IzeKDI8Ea/G/TnGQQqrOKn/U7MRuLomP1NX16kb3NURKA8Z5SmzY6ekPwxl/suiz02B/6VEJgbq+lMMuIhU0aFZciDZlOTVZ4E4jbiKzlnVaLisdPELA7xoed6NRmp1xhydSNRuzElEkcW3jfZeTYIu72Q/pRrxCQ4DjzLrWaLrSs9gWfkn3iqmjswDNOjZQ2zxC01iGqfUfc0LYWV5lowZzQEwfPuNyNTRMAXVAnSWmATXz25dhT0VeLTU67CsiTZn3wQLOPrxYVHT1MJT35t5kGaBjnyTNvssiThFHUxCJW5xJW1Yixw30B6+pHzy2xDrlkbnqqBSnm6ejjMRXggPU8gx99bNuORxa2tt5oK8wB+lWLMRQk1uakLSCOMGbcvn9kk6n1dUH2U5BAJYoCg12NN+fV+bkKgoheY2jpiZMU4po6ZG6hG9x/fdpRaY8c4onxKDcgJkDf9Abuxcd4UIj6Q0P/ZJW9cRTrz5km0Fx8OpY2xmM8wUkLZloZvccFgqq6iJrUVM5viyghhbNrVabl7AKqdiqKu3BMmB7dFTBMbIGtlS7DC/cHTI/QrLgKAxLZNbr26tn7YqKnaJ2YhCoaD8iVe3VYjmPXCkf0d+CVkyW6CPxWcRF
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5595.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(38070700021)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qY7/L+nbqjnbxQBMCMG4qE1wNiBOrF6rFXpTM/60TySeczr1URlqVdQe5F?=
 =?iso-8859-1?Q?ii0BRVRY569UkGr4y6lFZQxk9K+d1qcqke/8aVwb7U6E82U+fMSn3GYGGx?=
 =?iso-8859-1?Q?q3nllm738CI2pdGIst54QJH/uppk0JXm4Hx5sxc6FdL1lTozttAnm6Rtke?=
 =?iso-8859-1?Q?p0bdVVUhIs5/GOqWLjRJFBKR/9sAG/bvdeXE23/eLormSADllMy6RbLy3Y?=
 =?iso-8859-1?Q?KiOc89fDdGS8/B72j1PoLe9R/itfXiDz74xLYPgNSoP77F6RNRkMe5SRlG?=
 =?iso-8859-1?Q?0wX3O3VMxzMHAIhALkr7pRptqu4OoBnqRWti9iuyO03ojQbVRBKyZwTLO/?=
 =?iso-8859-1?Q?3MD46ps6qAxM2wCy99xDV2rExgnse/LwVr9aOnirst3bngcV/NW5kF80Y6?=
 =?iso-8859-1?Q?2OYBnBuJ8qw7EHgBB+6ZbcABZrqz/X7MDLCeWVt5ZQr60ggukQMUUVc25p?=
 =?iso-8859-1?Q?tXd0P0VwaEJjGmvhOF3LOCQup4QVf3HOFWXGNKaBPpwrYk0u1C1RRJP5oQ?=
 =?iso-8859-1?Q?tNF7pZLdCYsQ1D9I/xHmffjlSj4qusD6KnFCVWeLVIfrrJq/ouWbPbS42a?=
 =?iso-8859-1?Q?KyioamBFwWv3prVri5evgJaNoz0Lp5HsEhT56+LzIjrx6DwaBtza4OCnBL?=
 =?iso-8859-1?Q?cicFDaPCSWcywe2I+J6wEOj4E4aDNYSl8/obq4pOyoAQk2xz+Lgf2WPsaS?=
 =?iso-8859-1?Q?YS2uPKvow8jHOP7tpFfIzpgZaJHU51DyHLAy8gQvpLBFtqq6en6i6Nese4?=
 =?iso-8859-1?Q?rQ5YDOK/I+Xs/V+fBOtaRyHEZvU2uMtIpqmFrxrCDrV0tx3/MlMN5fHGRL?=
 =?iso-8859-1?Q?DQpB4WZqs3GYj4ZOkWaI56shDbv5skkMPPgDSKDTfZwm7gr8DIEwxAyDvl?=
 =?iso-8859-1?Q?32uEQbPeGioGIoeY0dbKxk3mxKkAF7JFIEv3wm8yaj3oTsm7KMAMXQMvEm?=
 =?iso-8859-1?Q?nvnkMBHR918vTNsT3SY+DixIqisznEo7zrH0xItv6HM3fXdI47FzxI8ZOg?=
 =?iso-8859-1?Q?LcjOGc0185C76SSiumgbSlEvPiBkl1LPxJ+3REok1AHIoSqIOhW1coB51B?=
 =?iso-8859-1?Q?0l9vPf8EV4hWebYgATpn1i2GTS39U4MINpXmfjmlzs/8ZOohyg9/7CY1jA?=
 =?iso-8859-1?Q?CiV60FrvRQJD1C/iZZTTxmzJ0T8xX70yBxn2OPOPl/pRMBQqG41eRnu4e9?=
 =?iso-8859-1?Q?bmJ52Kw/pkKKDyzps4qUYppU7OSR3tkXWsjYQH/VFSpwgRkCc+f5lQdEtE?=
 =?iso-8859-1?Q?o7QoNa/2AVLF4TUtPO7cN8jDs7FxsQTPxQF6r3C+T5S/6NkorLKqoj/fjg?=
 =?iso-8859-1?Q?blLVNlYTXCqpABP8A9nTXTLm5beDBTho8lXuDGUvbmv1tFfU37WZ3DQvT6?=
 =?iso-8859-1?Q?nYycFL4dpmOF1Uv6DIqz8CqZctPZe8JaTqaMGdW2QiamMauz+h24xANkQa?=
 =?iso-8859-1?Q?TTEOvMEm8AGgIfPcGl1d82XGWrFCmG4zuGjDi7WIwbnHq6x92LPzByVMo8?=
 =?iso-8859-1?Q?sVSJmlGXhs390Xx0Wohass3D8YRG+xmg1Uiqc8eiGM6gznFUazYH/mR5BP?=
 =?iso-8859-1?Q?90S/idh4oB/Tu5wHVAQps3dIPyZUOYb4Ffr0iBX29hm3zpDJJc+7TuakyD?=
 =?iso-8859-1?Q?kKwxae7P4v2Aijlu3R4rn4LVfG1t60/uiEgHqHHOKBVOEN317Ba49Mbt3j?=
 =?iso-8859-1?Q?aP5Y5oSz9muCgzYLlVZYUq4IwGhvwnmzh8sza/GWJw8P0HK/9bONIOwP1y?=
 =?iso-8859-1?Q?OySCO8Bk2MFr6DfeusqpxroLxjh8pDfR1ceSd4bgG0pWE3?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5595.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72a2c3f-04d0-48b8-a668-08decb87b276
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2026 09:14:40.8034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Do0U7YLsrvhw4iQfGDp7Z1QIPt6cFXz5kBZU1AP5Yv7eWZyF5f9NbaZchRmeQx7iK9w/AKy/g7E/craxLn2SSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8288
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

Ack on all counts.=0A=
Thanks.=0A=
=0A=
________________________________________=0A=
From: Koenig, Christian <Christian.Koenig@amd.com>=0A=
Sent: Tuesday, 16 June 2026 6:33 PM=0A=
To: McRae, Geoffrey; Deucher, Alexander=0A=
Cc: amd-gfx@lists.freedesktop.org=0A=
Subject: Re: [PATCH 1/1] drm/amdgpu: clean up discovery and preempt sysfs e=
ntries on shutdown=0A=
=0A=
On 6/1/26 07:05, Geoffrey McRae wrote:=0A=
> Fix a sysfs duplication error when reinitializing the device:=0A=
>=0A=
>   sysfs: cannot create duplicate filename '.../ip_discovery'=0A=
>   kobject_add_internal failed for ip_discovery with -EEXIST=0A=
>   ...=0A=
>   Failed to create device file mem_info_preempt_used (-17)=0A=
>=0A=
> The failure is caused by stale sysfs entries not being removed during=0A=
> device teardown, leading to -EEXIST when the driver is reprobed. In=0A=
> particular:=0A=
>=0A=
> - amdgpu_discovery sysfs kobjects were not fully torn down early enough,=
=0A=
>   and ip_top remained non-NULL after cleanup=0A=
> - the preempt manager sysfs attribute was removed only conditionally=0A=
>   and not during the common hw fini path=0A=
>=0A=
> Fix this by:=0A=
> - calling amdgpu_discovery_sysfs_fini() and=0A=
>   amdgpu_preempt_mgr_sysfs_fini() from amdgpu_device_fini_hw()=0A=
> - making amdgpu_discovery_sysfs_fini() externally visible and clearing=0A=
>   adev->discovery.ip_top to prevent reuse=0A=
> - centralizing preempt sysfs removal into a helper and reusing it from=0A=
>   both fini paths=0A=
>=0A=
> This ensures sysfs state is fully cleaned up before reprobe and avoids=0A=
> duplicate kobject/file creation.=0A=
>=0A=
> Change-Id: Ib91bf9eac4a1901c05bdb17b20de3e4122323b34=0A=
> Cc: Christian K=F6nig <christian.koenig@amd.com>=0A=
> Cc: Alex Deucher <alexander.deucher@amd.com>=0A=
> Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>=0A=
> ---=0A=
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      |  4 ++++=0A=
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c   |  5 ++---=0A=
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h   |  1 +=0A=
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c | 14 ++++++++++++--=0A=
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h         |  1 +=0A=
>  5 files changed, 20 insertions(+), 5 deletions(-)=0A=
>=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c=0A=
> index 5ff224163bab..ef5cc4997656 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c=0A=
> @@ -4200,6 +4200,10 @@ void amdgpu_device_fini_hw(struct amdgpu_device *a=
dev)=0A=
>=0A=
>       if (adev->mman.initialized)=0A=
>               drain_workqueue(adev->mman.bdev.wq);=0A=
> +=0A=
> +     amdgpu_discovery_sysfs_fini(adev);=0A=
> +     amdgpu_preempt_mgr_sysfs_fini(adev);=0A=
> +=0A=
=0A=
That should probably rather be in amdgpu_device_sys_interface_fini()=0A=
=0A=
>       adev->shutdown =3D true;=0A=
>=0A=
>       unregister_pm_notifier(&adev->pm_nb);=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c=0A=
> index 7c2212985273..a2ae26bb11ff 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c=0A=
> @@ -704,8 +704,6 @@ static int amdgpu_discovery_init(struct amdgpu_device=
 *adev)=0A=
>       return r;=0A=
>  }=0A=
>=0A=
> -static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);=0A=
> -=0A=
>  void amdgpu_discovery_fini(struct amdgpu_device *adev)=0A=
>  {=0A=
>       amdgpu_discovery_sysfs_fini(adev);=0A=
> @@ -1391,7 +1389,7 @@ static void amdgpu_discovery_sysfs_die_free(struct =
ip_die_entry *ip_die_entry)=0A=
>       kobject_put(&ip_die_entry->ip_kset.kobj);=0A=
>  }=0A=
>=0A=
> -static void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)=0A=
> +void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev)=0A=
>  {=0A=
>       struct ip_discovery_top *ip_top =3D adev->discovery.ip_top;=0A=
>       struct list_head *el, *tmp;=0A=
> @@ -1400,6 +1398,7 @@ static void amdgpu_discovery_sysfs_fini(struct amdg=
pu_device *adev)=0A=
>       if (!ip_top)=0A=
>               return;=0A=
>=0A=
> +     adev->discovery.ip_top =3D NULL;=0A=
>       die_kset =3D &ip_top->die_kset;=0A=
>       spin_lock(&die_kset->list_lock);=0A=
>       list_for_each_prev_safe(el, tmp, &die_kset->list) {=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.h=0A=
> index e0010f6a3eda..cff33ab2cb25 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.h=0A=
> @@ -41,6 +41,7 @@ struct amdgpu_discovery_info {=0A=
>       bool reserve_tmr;=0A=
>  };=0A=
>=0A=
> +void amdgpu_discovery_sysfs_fini(struct amdgpu_device *adev);=0A=
>  void amdgpu_discovery_fini(struct amdgpu_device *adev);=0A=
>  int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev);=0A=
>=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_preempt_mgr.c=0A=
> index 34b5e22b44e5..eab81206c050 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c=0A=
> @@ -46,6 +46,17 @@ static ssize_t mem_info_preempt_used_show(struct devic=
e *dev,=0A=
>=0A=
>  static DEVICE_ATTR_RO(mem_info_preempt_used);=0A=
>=0A=
> +/**=0A=
> + * amdgpu_preempt_mgr_sysfs_fini - remove PREEMPT manager sysfs attribut=
es=0A=
> + *=0A=
> + * @adev: amdgpu_device pointer=0A=
> + */=0A=
> +void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev)=0A=
> +{=0A=
> +     if (adev->dev->kobj.sd)=0A=
> +             device_remove_file(adev->dev, &dev_attr_mem_info_preempt_us=
ed);=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * amdgpu_preempt_mgr_new - allocate a new node=0A=
>   *=0A=
> @@ -137,8 +148,7 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *ad=
ev)=0A=
>       if (ret)=0A=
>               return;=0A=
>=0A=
> -     if (adev->dev->kobj.sd)=0A=
> -             device_remove_file(adev->dev, &dev_attr_mem_info_preempt_us=
ed);=0A=
> +     amdgpu_preempt_mgr_sysfs_fini(adev);=0A=
=0A=
That looks superflous now.=0A=
=0A=
Regards,=0A=
Christian.=0A=
=0A=
>=0A=
>       ttm_resource_manager_cleanup(man);=0A=
>       ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);=
=0A=
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h=0A=
> index 2d72fa217274..00acec7226f5 100644=0A=
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h=0A=
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h=0A=
> @@ -140,6 +140,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, u=
int64_t gtt_size);=0A=
>  void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);=0A=
>  int amdgpu_preempt_mgr_init(struct amdgpu_device *adev);=0A=
>  void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev);=0A=
> +void amdgpu_preempt_mgr_sysfs_fini(struct amdgpu_device *adev);=0A=
>  int amdgpu_vram_mgr_init(struct amdgpu_device *adev);=0A=
>  void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);=0A=
>=0A=
=0A=
