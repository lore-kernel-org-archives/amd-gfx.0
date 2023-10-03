Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C4DE8FDB7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 21:11:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B7410E318;
	Tue,  3 Oct 2023 21:11:40 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE4A10E318
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 21:11:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjqRAGulg1/Bzr5iwmbQt0k5SrIOWI2EfBn0mpibOCGRsUkFiaKA5oQ72VX9acapf5kjbmThe6szmkT3YAfhcAe/wWEh3IrlI44wb38ABkRj64cT+AM3XLv1QP22xpJQD7TiSTWBA3ermvU37alT1QxB/j/JLov2/o5D7/afuxadRTB0Bs8qLI7lShwGUHiLpZZRc3W9plSE/N1nj38nn4XiRH9xN1R1D2riniISa/3o5HTG+v6i4RNjgaYteW4ic2WwbMUm5iPMRE2Lv8thDo/NbNnm/USTUDoMePcVv+guhSTNZjIq7QpQeD1PTZ9gBJNARQn+ZpjjbnXmp//6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swMjykbXepGPIlaonfjHHeUhuGctt1ZNcUnYtX2ZCdI=;
 b=Y2ZdVv9/0mV+ZmtI80GSWZxWF1alwcASrwfuByACTWg+ANzsH/DirtIvwRiasyLdnbsl8InwwTSDzlQwFRnXmEZElkF44sFNdVx0EaNYf12kMJA6nu/5LBnkd7tpcoCpAiWsP4rQiXYdJG1FJRkMIEWREjKTxGoOsQYmilfMb2xhJ2yu1Kt8OWLj2upyVIZviLoRJregq6bo5vEkzLFmbEinIOhsyFQTVb4KPg8Go+AhYB0on+/BSz9HE91sIpp5fCWPoOIOtMwrhCKRrtj7P2KTbmB1jIRsV62KIUVXVPu2Ljv9zYCDVBCzy8rLmfRnkXC/1jLMT80ccCgUWN4kOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swMjykbXepGPIlaonfjHHeUhuGctt1ZNcUnYtX2ZCdI=;
 b=jn8Z/rFDr5hIGBLgkPoU1AAl7KYlsRFd2c46oLtGdzlxZhgSlG5Dz8Q+4n9OvPmVy1WQQIGKujqQI8KDsUvDPISjBHRS/wEshKIWJFD57Om76QeMzfy44xVZJ/QJX48SM0u6xE3UJ75F/qO4nC1Sq/PmELlyxGvv/lA+Z75ufmw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 21:11:35 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:11:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
 callbacks
Thread-Topic: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
 callbacks
Thread-Index: AQHZ9jw/rE7ml0xJWkKAxqE0Oy0+KLA4jsyQ
Date: Tue, 3 Oct 2023 21:11:35 +0000
Message-ID: <BL1PR12MB51447D279FB7F5AA88D328D2F7C4A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
 <20231003205437.123426-2-mario.limonciello@amd.com>
In-Reply-To: <20231003205437.123426-2-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=99d53f20-5bcb-4662-8f37-ed02590365f3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-03T21:08:23Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB6976:EE_
x-ms-office365-filtering-correlation-id: fdedf5b4-913e-419d-5180-08dbc4555360
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CKMCEUTfASU4ULSjGxkRyznG4UajHFtWOqQn9IjAseN7eNxjW5r2bcJmTlQ+9NzDIb85FFqiVu8vEngMrycH81aeLW93G4bIKpNp6V40vAeHUxUdY41SupgK4Gh+2OtjCaeBnYiNrV5HwBTrDjD0ZlPS0rKcMidO/crs5ia+qesVXGtQ0KaiymPXZtQ9IWOrYUBLTFYfDJFJXHXRhm0pnCnjE9EF7gxXtYt6eAKaASSj8/O3O5XkpuSdJK5gUL9dbw90K3zK8Hq1erWtXOChoy/IYGu1iJbn7r6290KS5MlaGpuBBGVwysa487GvmnexqAuaYrM9TSUbZj6l5OFxFAL7LNezzs+1phOltJeG2+9tgDqqGiUMCvIZ93jZ1rAOST45IoCm8k4VdR49bUZch2xGRtznT6mXFobkugh2Ephh1x6tJXOq19e1a6FWZxmmIpuCRNFtgWrQhFSA43ZTCUOzc/xIkcWlhPohOwrBdGsL/UPQwDmlG75ENC/LSNByvV6Y44ZEYZPmX6BONqDYXz89ut2++RzOvuj0mzU6mCzo8DAz3T65bGwAk/or9trBbipeXSE2XIKjIoG6e30/XIZQSqU9XnNxzSoz9d5pOBwgtewsWWDhvz19RwMu5qYO
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(52536014)(316002)(66946007)(5660300002)(8676002)(4326008)(8936002)(66446008)(478600001)(55016003)(110136005)(54906003)(66476007)(64756008)(53546011)(2906002)(71200400001)(6506007)(66556008)(76116006)(7696005)(41300700001)(9686003)(33656002)(86362001)(83380400001)(38070700005)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d2OzmkEnzBq0kKlf2PAhG4K8obWFD+JJL3/nXtF+zeMng4XdPGx3GNNlzdxh?=
 =?us-ascii?Q?097ObKAjoB6fX30TCNzvZMViYjtJ+yHEX4Dg6n0byUqAi9XRfX7IXAQ2onu6?=
 =?us-ascii?Q?qQCEkyziOezhqgynNNwFMed2nRaKLzQfWTW6NisKpMEhr3t3hM0J7shuUbYP?=
 =?us-ascii?Q?9Oy8VznoPzPMJAP9JfizqAK0d/Yf2XnLxOmjIfFPNueZJiA8sVLG9CYpsSIi?=
 =?us-ascii?Q?S+/2hntL6vJ7sSNj1dr8BC/7wVbHEerZo8mypeJiS86Qal8yPNhwKC93wnvZ?=
 =?us-ascii?Q?x4bPZj3exX7kKmQOiwYA8OnIDOiUt9+WWJjpR/Bi8aUdRD3US0cufJWaVv7D?=
 =?us-ascii?Q?Vclpp0Pf/xTFum5tHMtyyu4DjgntzFSwq93Q7lYxGHVGHfW/JMWpsBT5Ydz0?=
 =?us-ascii?Q?KQyFDaCLqpWUA5lhlQz8lRDNwfGh0k5UVIZa0DGc4857ducVYtH0V9J6H2gG?=
 =?us-ascii?Q?bSCxS3kc/Rm92QTEL/1M2y53H1LKSmT35u8de4DtPmqrGKsJdAZJ4pBJLEUT?=
 =?us-ascii?Q?dx623nQM9MuC5eqMZhvrIrwBQtNnOn7ERJafD5i+0S20qV7naaH1y1fplRY+?=
 =?us-ascii?Q?UJ7dnbt738GtJ+UUwRPG6DO0aty2Uh7SZ7M0/iaxdPIfNwMLivbpSIEYtN6A?=
 =?us-ascii?Q?NVYdCCYHBb5/BhaDvRwdoOd2KFh/Kp7sKEDWp5x7YcmDe8tr8SsQHASn2W3s?=
 =?us-ascii?Q?r1WYZ4dtmRqVxpS8guzNCx2Ezcw4viS5ixMKiVE6I2d8FI5WLp4rmdXd6loc?=
 =?us-ascii?Q?ym7b+T6Z8JrE4tD40BhrvtcD7soaJ8rBZmljwWAaeTafDtvjr0QkyMdFX3BX?=
 =?us-ascii?Q?vLd0EIbXM9j1UAUf7iDOq6nnOp9SKOAoSChSSW9TIaesrY6K1G68Va5y/GQ8?=
 =?us-ascii?Q?8tvgV1tGL+m0l9sRhvHcEkmk/SYGy81HYtkpA/yQg+HL+2sw7Sfp47sLIqxc?=
 =?us-ascii?Q?4jE1jKcGrMiLpJlEZug3cv21CPrgJf/h4sL5kCPTy9Pk8LhKbBkw7b+Z7uel?=
 =?us-ascii?Q?/34FDKBYuTIzkdTtSIc7RQk4bWdCH4vxqmYSjWhNvyrlnZSBzdKUl0gZULQe?=
 =?us-ascii?Q?FmD+AIwI7IVvrX75CKtTs3gb+htGI9+HhKQXpzFwWKh9cZRFPtSSKEOEjXVh?=
 =?us-ascii?Q?m8XKXcW7ERF5biHbsch/dP38+43mBU7237Yc4LNLWdPI27VgGs/sOcKBgvIt?=
 =?us-ascii?Q?mFYR++vRagrbp285JWFomLXd3iOdIOxLNcSQ/y61E8cPhHwa1hNbN2eTAyB3?=
 =?us-ascii?Q?4osEHmrHFXaA2cuiKP6L5n91HnzpYR/ApZT6+A1q2JDvJncsiH55Ny4/pXWe?=
 =?us-ascii?Q?4bvhZy/xUx4F96iUlCjvkOit2vUoTKaNI6ARRuVw6+yXIq8TxK8yCWGIkNvK?=
 =?us-ascii?Q?azEST963QjPlnAObx6VtfXEJIg+zSWlhxxYo1YbllNe+Nhjikico/0ENKMBW?=
 =?us-ascii?Q?vQmgpjXw05zx5X2V0sAffzKYqElAFRPQaU4Vu6IgGIpvcAxiHZli1VMPnYwI?=
 =?us-ascii?Q?6mYW+zOYuxykb+pWpqdKGksAMVOgwYhwYeoDai2qk1arEIMuiHzTYMgdxA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdedf5b4-913e-419d-5180-08dbc4555360
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 21:11:35.2924 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yF3sHjKgQ9mZo2ntvEkBtjvErQ0YNBMkn7nX0k1Z5iljl2AqyZyEZcUldp9sAC+9XEiWswCutHjqLIuZHq8kRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mario
> Limonciello
> Sent: Tuesday, October 3, 2023 4:55 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
> callbacks
>
> Linux PM core has a prepare() callback run before suspend and complete()
> callback ran after resume() for devices to use.  Add plumbing to bring
> prepare() to amdgpu.
>
> The idea with the new vfuncs for amdgpu is that all IP blocks that memory
> allocations during suspend should do the allocation from this call instea=
d of
> the suspend() callback.
>
> By moving the allocations to prepare() the system suspend will be failed =
before
> any IP block has done any suspend code.
>
> If the suspend fails, then do any cleanups in the complete() callback.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39
> ++++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++---
>  3 files changed, 46 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 73e825d20259..5d651552822c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1415,6 +1415,8 @@ void amdgpu_driver_postclose_kms(struct
> drm_device *dev,  void amdgpu_driver_release_kms(struct drm_device *dev);
>
>  int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
> +int amdgpu_device_prepare(struct drm_device *dev); void
> +amdgpu_device_complete(struct drm_device *dev);
>  int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);  int
> amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>  u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc); diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index bad2b5577e96..f53cf675c3ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4259,6 +4259,43 @@ static int amdgpu_device_evict_resources(struct
> amdgpu_device *adev)
>  /*
>   * Suspend & resume.
>   */
> +/**
> + * amdgpu_device_prepare - prepare for device suspend
> + *
> + * @dev: drm dev pointer
> + *
> + * Prepare to put the hw in the suspend state (all asics).
> + * Returns 0 for success or an error on failure.
> + * Called at driver suspend.
> + */
> +int amdgpu_device_prepare(struct drm_device *dev) {
> +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> +     int r;
> +
> +     if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
> +             return 0;
> +
> +     adev->in_suspend =3D true;
> +
> +     return 0;
> +}
> +
> +/**
> + * amdgpu_device_complete - complete the device after resume
> + *
> + * @dev: drm dev pointer
> + *
> + * Clean up any actions that the prepare step did.
> + * Called after driver resume.
> + */
> +void amdgpu_device_complete(struct drm_device *dev) {
> +     struct amdgpu_device *adev =3D drm_to_adev(dev);
> +
> +     adev->in_suspend =3D false;
> +}
> +
>  /**
>   * amdgpu_device_suspend - initiate device suspend
>   *
> @@ -4277,8 +4314,6 @@ int amdgpu_device_suspend(struct drm_device
> *dev, bool fbcon)
>       if (dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
>               return 0;
>
> -     adev->in_suspend =3D true;
> -

We also set this to false in amdgpu_device_resume() so that should be fixed=
 up as well.  But, I'm not sure we want to move this out of amdgpu_device_s=
uspend().  There are places we use amdgpu_device_suspend/resume() outside o=
f pmops that also rely on these being set.  Those places may need to be fix=
ed up if we do.  IIRC, the switcheroo code uses this.

Alex

>       /* Evict the majority of BOs before grabbing the full access */
>       r =3D amdgpu_device_evict_resources(adev);
>       if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index e3471293846f..4c6fb852516a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device
> *dev)
>       /* Return a positive number here so
>        * DPM_FLAG_SMART_SUSPEND works properly
>        */
> -     if (amdgpu_device_supports_boco(drm_dev))
> -             return pm_runtime_suspended(dev);
> +     if (amdgpu_device_supports_boco(drm_dev) &&
> +         pm_runtime_suspended(dev))
> +             return 1;
>
>       /* if we will not support s3 or s2i for the device
>        *  then skip suspend
> @@ -2435,12 +2436,14 @@ static int amdgpu_pmops_prepare(struct device
> *dev)
>           !amdgpu_acpi_is_s3_active(adev))
>               return 1;
>
> -     return 0;
> +     return amdgpu_device_prepare(drm_dev);
>  }
>
>  static void amdgpu_pmops_complete(struct device *dev)  {
> -     /* nothing to do */
> +     struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +
> +     amdgpu_device_complete(drm_dev);
>  }
>
>  static int amdgpu_pmops_suspend(struct device *dev)
> --
> 2.34.1

