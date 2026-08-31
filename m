Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1DAC624A4
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 13:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A2A510E816;
	Mon, 31 Aug 2026 13:28:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qCWrZfTf";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012048.outbound.protection.outlook.com [52.101.53.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E2210E816
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 13:28:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PB1T5/7AzL7kjyFxJNZrroOsR8zVKM8AOCOl+SgsiFMEKohX66+vPNq/C8YnIvHjZC/3g/2nQxx1luJQTbyZvCKUCeaFws29lA+bBxTuEbx5TUjTirA+VN8mx3iwP26404+q+P7lQ8/IIbAHTe1JKlTgQnrkoc95FZuGeDizlX3wsNUoPApsj9FL+714Vpu5YLT3JN/zU4/5h1Qk6rcJC5uHHADWCcjyuNGtMTAkVNxfVWIZIK6kQRZo2gqk9SmKa3ywbFt5l9aVMApry8efl5lPt4Pt3CELQ0g8JNeFM25AnKm151B9hgj54BOv/QZ1eOMb3q3MBTfP0g/M1u/hcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PL7HU0vg1ompwgicb+nKmx+wjC2oxG0Y+7Xmk04nDpU=;
 b=gPKFPhMl9RAosYzv6yrRVUl1baqc1ZLBef+mrse8MXYVgB0Utq4h4uFYUr4fqzZs9asPXjdxTCNZv6aLP/KuwhqbrQzLI2yQTjjs0y+I4my9t7jQ8HkPCpi41iKVkNw0hKARMCBPdPktUFHL4b3JvZqfZBWnVm/ZQcIrMe2BA21ZK924+CdUIApEaDLOdtin1OhZbE/MRURM4NMFgRroCFvknOQgDRBm9QDMZ3IWFY/zYogiavV27U99NblBYcjJpZgA+Zj//uOyVz5AL0j4N+CM3oWMAL5u09foz+9XR572Cld2lnwRiePevc0WMH1OQQ2Bzn6N8r3qWEiAn2GYyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PL7HU0vg1ompwgicb+nKmx+wjC2oxG0Y+7Xmk04nDpU=;
 b=qCWrZfTfFwMONKWnrhaQDgbCcCTHpBA65dbo8bKjZ0RGt+CpCrIV3H4WgLsToDEKYl2Lg0oXdCklsL7E76kCVaHyJs+8Lzmaz4dxXwbNSltfYtItEq6CIpuIRX9czlfoHWeiu1i7KKOUaLP0SuUpbyjTjt8rNKHTn8YXJw9tSkw=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 LV2PR12MB5847.namprd12.prod.outlook.com (2603:10b6:408:174::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 13:28:45 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 13:28:45 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Lin, Ping
 Lei" <PingLei.Lin@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/59] DC Patches Aug 26, 2026
Thread-Topic: [PATCH 00/59] DC Patches Aug 26, 2026
Thread-Index: AQHdNbDYzZxTnk6h+k26rXnnpUi5ara4LZ+Q
Date: Mon, 31 Aug 2026 13:28:44 +0000
Message-ID: <DS0PR12MB65345C134E482F347CE4C81B9CA92@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-31T13:28:34.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|LV2PR12MB5847:EE_
x-ms-office365-filtering-correlation-id: 95737759-256d-4fbd-0717-08df0763c80f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|10086099003|38070700021|5023799004|56012099006|3023799007|11063799006|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: qU3JYH+/JQuJ2mYPXki/oBsz/Q0MhAhr+T1DtjQs4OeyhDcvlaKizpqf2lXloIloHPf6cDDQdbRqCbY867znMYLnzZolQPEi9znDaa4yY3cxzwbeCx2MKWJgTCEnTRDyucC42Pru4P+FzXvjrQWyhGqI9lXu5KSHzXite8li6/9639f5ha5YSqbGkMPltRxL9hElOTT0o3yLO396gXJrb/IgQvrKqnmv0OKU69Od3N9BjEfGKiw+e1Yp+1wIfCj/rDqqGIwPH359yEWsQQPaRSYOT5j2z/28K4F9fQulMfJnyjkersS6VyU9jfZll6ZxU8JNLppzO+mJgKJTg0jqusx5aNh3Tdith2FGyNUEcY1ARk2sSaU3pZ882TXm9Z8/rRsSzQHft+xrm3rNSJ4BgQTo8uJ4J+bW30Rrfuges1ikQgG187Th3dLTuQ3dDGO26eEo+IJ0XQRujv+Ox/C0bi9LLhsgNKOA6F46WjmVxrcDnXuavhXhXdyNrsAYzuVBPpDRTGZIe6rzoU3IOdztZmDDhZQZBHFwu8ZB0ywfCqAj4qKHLYK6Qm8PsOGlYN4sI/win6dFh7a0hBWITkuXq5Cz7jatVUhNCctkdoCO8CJpVMf2gRig1bYHkECeEjKAk3oZNf2S2qFcxHwE+auR+9U9B1jtw1K/v/8FS8hAxVu+6SwvOG+92JUV3t9/38jmvNe6r/A3MwCn6H529mUpaU5pIyKYW5FXZJAbJcDu09g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(10086099003)(38070700021)(5023799004)(56012099006)(3023799007)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DgWHaW7PB2YZA8brz+g37RZcxceQiHkKhZqFb4USgEIx1ETbmmvWhiiks0?=
 =?iso-8859-1?Q?xSWP0Jm/gxbCTe0r4+MLuC6ZhzazFhQa6O64T8Yo0IjzXBc4sBp5Q0O0gF?=
 =?iso-8859-1?Q?7w20ragtHmrgj4FOjZTBk7Gt4O18g9qAXpE9sLh9vKkbIGaf8mtOtJNlXV?=
 =?iso-8859-1?Q?l8dV9KveUJX67Mh7f4B+BvnnsGG6KowkRbZiWGM8lxypzYmDZ/psSIsTgD?=
 =?iso-8859-1?Q?aI9VRvKmL6xPVDiUdbc3NNTa8fJ3nwswPaFFgSsEzlMb3pmu3BM32Bty3O?=
 =?iso-8859-1?Q?q1RkKFAto+SUR4VYcoqY6DTsFvF0E7Vs80XmiblAWduzkySfY3tGDRf5e1?=
 =?iso-8859-1?Q?OGtDRNsZarrw6xlECCM9pbRJEwmf8UykEzer9rpb7aEwJ5yX/VvWN7vg99?=
 =?iso-8859-1?Q?7OPoUQ9wn6imFTgaC286GpZg4W3+/piiXvuxzO7j72K4zr4KDwlcDF02o8?=
 =?iso-8859-1?Q?vov0rLeorMSH1pVktRfxnbHPpDdxVTvc0q1iEgFstmlZGZg7qrMGHBJ6oU?=
 =?iso-8859-1?Q?c8oFbmxQRZ4WIyYItAB+Y7GFixKfYzXicwM5FkI0ZfxY/MkxJ0tlbqkf5z?=
 =?iso-8859-1?Q?j5y8By2ybz5DOUmif2IPEvUGORCK4Uch5HeOVeqht3IeegGBFrRRkDNisI?=
 =?iso-8859-1?Q?aqEhBnxRgNrgOcFFi8eh4CK2sNXt6bazWfJxT1reRJZdqSLSYoLHqODxd/?=
 =?iso-8859-1?Q?rrIlNuXBZ6k9Xj7+UmNYJ+RGcWuRoWBaj676jUIQ8pJ3VfGLBawPpTPap5?=
 =?iso-8859-1?Q?N4gA5LgxTQ9C1io6qoTH0Dp+z9EGrVoLyjwnfnRiEqpRxWw1LGPZ4FC0H7?=
 =?iso-8859-1?Q?fHkfvlz4A48MORLnnPZiYVI4danC62nXujlKejWaQDddKEIgZHDOMsgIEU?=
 =?iso-8859-1?Q?e1Mwy4x8JTqXGY8ih9DTa7fWLLgC/3/4oynNpNDNvMMtXDzU6jBjyNx2oN?=
 =?iso-8859-1?Q?yUKyZeR9FzRATm1h0qqcRjlL4oABDKh6AWQP+sIoF9gKcVF/7geDG6jMfT?=
 =?iso-8859-1?Q?VapfgWqxcJLhaISEg+scSjYS3kBk2NifIpeYOx6uHJMfBQ20z2F3Or/X3+?=
 =?iso-8859-1?Q?uyCcK6sNOU7pak5S8k2FYh8dgp1Jbwz1r4ddg7C3tMOUiIWmTlOQdADeeF?=
 =?iso-8859-1?Q?+CmwRqhjk0GLq9sLykFeSkZp1QgGaC6H2Be7QLkHyVgiJRnqXlurbAblWz?=
 =?iso-8859-1?Q?hyq7U10VUNSWCVMbgbr+uAGh/dDIB2zfzV3m4FM1YsP4uWV0nhROgpR33Z?=
 =?iso-8859-1?Q?xgrYSOouyW1qacIVKaIWULXE3BUOFIU+wUf0ISzGuHQtLK+QdjEx9gH3N9?=
 =?iso-8859-1?Q?zi0nBgWEU5b5viHFixs2DkTCDcq1JURw5um1kCRgdcV2Tyy1AnujK8o6yw?=
 =?iso-8859-1?Q?Wn8zm5W4/kMBjhnY1hnov+XOp/Yr/gaiVw50eT1G2VZdkj4iZPXHEuHfIG?=
 =?iso-8859-1?Q?xX8wwizVJbH6NBa0tzVcVVlZa6oBRLlpp6rnNI2qMvqZthTiARp5Kh8ghF?=
 =?iso-8859-1?Q?lwvLEuKp8B1jtFnH7hGBGk1vF/9igkyxkGvxN59yU/M5WnZOnIlK9F5A7w?=
 =?iso-8859-1?Q?RUhavx/1LvWQPGRzuzZealBc7QOxGxE9PHpYZ8doG7s5CRaiqC/X7Jy5Af?=
 =?iso-8859-1?Q?T5dItsPMQp1mnQPIM8Wme+6Mj892C0qmYlgfZ8my7zfXZBzcgQH0miauQC?=
 =?iso-8859-1?Q?dYCh7RLQvWzh9L51+s4H5iv6HGGPi+mS3Dceg96HdsKAZObPmtNlBhBZ60?=
 =?iso-8859-1?Q?wIATgiwKJ0lC+VFutmciDr9afgS/vll1Cc1K0UuAeqiLsu?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95737759-256d-4fbd-0717-08df0763c80f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 13:28:44.9431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8etFXcDWZkYunQs55+InSO9dSEoFlymZCc4cWqQDq1rlXqcbkzmwactCRfiayia3m+NbM9O3zB1ixJGdFT+iyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5847
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

Public

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 75a=
5e1b6b3661c3f946885d01eebeb6b031035ef drm/amdkfd: guard against NULL restor=
e_mqd in CRIU queue restore) with new patches added on top of it.

Tested on Ubuntu 26.04, on Gnome Wayland.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, August 26, 2026 7:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/59] DC Patches Aug 26, 2026

This DC patchset brings improvements in multiple areas. In summary, we
have:

* Move the DML wrapper into its own component.
* Fix DCN5/6 DML2 compilation warnings.
* Fix DCN60 DPP PRE_GAM offset, HDMI link rate and DSC handling.
* Fix backlight control for luminance-capable OLED.
* Restore native cursor mode early return for disabled CRTCs.
* Fix NULL hubp deref and CalculateFlipSchedule ordering.
* Remove duplicated fixpt and custom float code.
* Drop pipe_ctx param from MPC_VISUAL_CONFIRM.
* Move cursor SDR white level calc out of the hwss executor.
* Set gpuvm min page size to 4K on DCN35/36.
* Update RBBMIF timeout control conditions.
* Guard DAL port idle optimizations by ASIC rev.
* Re-enable multi-dwb support and clean up per-DPM struct.
* Add max_downscale_src_width debugfs for IGT validation.
* Expand amdgpu_dm KUnit coverage.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (34):
  drm/amd/display: Test ISM idle commit
  drm/amd/display: Test ISM idle exit arms
  drm/amd/display: Test ISM delayed workers
  drm/amd/display: Test colorop error paths
  drm/amd/display: Model ASSERT as path terminator
  drm/amd/display: Test backlight caps validation
  drm/amd/display: Skip ACPI backlight caps test
  drm/amd/display: Test vblank counter and scanout position
  drm/amd/display: Test DM atomic private state helpers
  drm/amd/display: Test affected MST DSC CRTC selection
  drm/amd/display: Test cursor commit
  drm/amd/display: Test vblank event arming
  drm/amd/display: Test page flip interrupt state update
  drm/amd/display: Test CRTC memory domain change detection
  drm/amd/display: Test PSR dirty rectangle filling
  drm/amd/display: Test plane reset decision
  drm/amd/display: Test link and sink dump
  drm/amd/display: Test HDCP update
  drm/amd/display: Test global modeset lock acquisition
  drm/amd/display: Test timing sync trigger
  drm/amd/display: Test IP block teardown and link emulation
  drm/amd/display: Test mod_power stream updates on modeset
  drm/amd/display: Test atomic commit setup
  drm/amd/display: Test MMHUB config read
  drm/amd/display: Test power module init
  drm/amd/display: Test vline0 irq control
  drm/amd/display: Test DMCU firmware load
  drm/amd/display: Test SW init and fini
  drm/amd/display: Test DM late init
  drm/amd/display: Test mode and plane init
  drm/amd/display: Test DM early init
  drm/amd/display: Test DC plane info fill
  drm/amd/display: Test DC plane attributes
  drm/amd/display: Test MST VCPI slot calc

Alvin Lee (1):
  drm/amd/display: Fix DPP PRE_GAM register offset on DCN60

Austin Zheng (5):
  drm/amd/display: Preparations To Move DML Wrapper Out Of DML
  drm/amd/display: Clean up Per-DPM Struct
  drm/amd/display: Fix Order Of Operation In Calculate Flip Schedule
  drm/amd/display: Remove const Qualifier From Non-Pointer Fields
  drm/amd/display: Move DML Wrapper into its own Component

Dillon Varone (3):
  drm/amd/display: Guard DAL port idle optimizations by ASIC rev
  drm/amd/display: Re-enable multi-dwb support
  drm/amd/display: Change RBBMIF timeout control conditions

Hansen Dsouza (1):
  drm/amd/display: Add debug bit for force p2cpm

Ivan Lipski (1):
  drm/amd/display: Fix DCN5/6 DML2 compilation warnings

James Lin (1):
  drm/amd/display: Avoid NULL hubp deref for remaining mpcc_id
    assignment

Peichen Huang (1):
  drm/amd/display: Do not use panel_inst in pr

Relja Vojvodic (1):
  drm/amd/display: Update HDMI link rate and DSC handling for DCN60

Roman Li (3):
  drm/amd/display: Set gpuvm min page size to 4K on dcn35/36
  drm/amd/display: Fix backlight control for luminance-capable OLED
  drm/amd/display: Apply debug bit for force p2cpm

Samson Tam (3):
  drm/amd/display: Move custom float structures from opp.h to
    custom_float.h
  drm/amd/display: Remove fixpt and custom float duplicated code
  drm/amd/display: Remove internal references

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.396

Tom Chung (1):
  drm/amd/display: Restore the native cursor mode early return for
    disabled CRTCs

Tomasz Siemek (2):
  drm/amd/display: Move cursor SDR white level calculation out of hwss
    executor
  drm/amd/display: Remove pipe_ctx param from MPC_VISUAL_CONFIRM

Tony Qi (1):
  drm/amd/display: Add max_downscale_src_width debugfs for IGT
    validation

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  187 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   77 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   41 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  110 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   28 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   40 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |    1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |   17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   20 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    8 +
 .../tests/amdgpu_dm_backlight_test.c          |   53 +-
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |  232 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  101 +
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |  367 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 3552 +++++++++++++++++
 drivers/gpu/drm/amd/display/dc/Makefile       |    1 +
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |    3 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    5 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   75 +-
 .../drm/amd/display/dc/core/dc_link_exports.c |    3 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    5 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   18 +-
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |    8 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   13 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper.h   |  106 -
 .../dml21/inc/dml_top_soc_parameter_types.h   |   32 +-
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |    8 +-
 .../dml2_core_dcn5_funcs_mode_programming.c   |    4 +-
 .../dml2_core_dcn5_funcs_mode_support.c       |    5 -
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |    4 +-
 .../dml2_core_dcn6_funcs_mode_support.c       |    4 -
 .../src/dml2_core/dml2_core_shared_types.h    |    4 +-
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |    2 +-
 .../drm/amd/display/dc/dml2_wrapper/Makefile  |   61 +
 .../dml21_wrapper}/dml21_translation_helper.c |   15 +-
 .../dml21_wrapper}/dml21_translation_helper.h |    7 +-
 .../dml21_wrapper}/dml21_utils.c              |   11 +-
 .../dml21_wrapper}/dml21_utils.h              |    7 +-
 .../dml21_wrapper}/dml21_wrapper.c            |    2 +-
 .../dml21_wrapper/dml21_wrapper.h             |  107 +
 .../dml21_wrapper}/dml21_wrapper_fpu.c        |   19 +-
 .../dml21_wrapper}/dml21_wrapper_fpu.h        |    7 +-
 .../dml2_dc_resource_mgmt.c                   |   60 +-
 .../dml2_dc_resource_mgmt.h                   |    0
 .../{dml2_0 =3D> dml2_wrapper}/dml2_dc_types.h  |    0
 .../dml2_internal_types.h                     |    2 +-
 .../dml2_mall_phantom.c                       |   70 +-
 .../dml2_mall_phantom.h                       |    0
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_policy.c |    2 +-
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_policy.h |    0
 .../dml2_translation_helper.c                 |   21 +-
 .../dml2_translation_helper.h                 |    0
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_utils.c  |   28 +-
 .../dc/{dml2_0 =3D> dml2_wrapper}/dml2_utils.h  |    0
 .../{dml2_0 =3D> dml2_wrapper}/dml2_wrapper.c   |    6 +-
 .../{dml2_0 =3D> dml2_wrapper}/dml2_wrapper.h   |    0
 .../dml2_wrapper_fpu.c                        |   45 +-
 .../dml2_wrapper_fpu.h                        |    0
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |   11 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |    7 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |    8 +
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |    4 +-
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |  131 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |    6 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.h    |    2 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   26 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    4 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    3 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |    3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   11 +-
 .../gpu/drm/amd/display/dc/inc/custom_float.h |   21 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   14 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |    2 +-
 .../drm/amd/display/dc/link/link_detection.c  |    2 +
 .../drm/amd/display/dc/link/link_factory.c    |    2 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |   36 +-
 .../dc/link/protocols/link_dp_panel_replay.h  |    2 +-
 .../link/protocols/link_edp_panel_control.c   |   47 +-
 drivers/gpu/drm/amd/display/dc/os_types.h     |   18 +
 .../dc/resource/dcn32/dcn32_resource.c        |    2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    2 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    2 +-
 .../dc/resource/dcn60/dcn60_resource.c        |    4 +-
 drivers/gpu/drm/amd/display/dc/sspl/Makefile  |    5 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  130 +-
 .../display/dc/sspl/dc_spl_isharp_filters.c   |   10 +-
 .../display/dc/sspl/dc_spl_scl_easf_filters.c |   88 +-
 .../amd/display/dc/sspl/dc_spl_scl_filters.c  |   24 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |   60 +-
 .../amd/display/dc/sspl/spl_custom_float.c    |  152 -
 .../amd/display/dc/sspl/spl_custom_float.h    |   29 -
 .../drm/amd/display/dc/sspl/spl_fixpt31_32.c  |  495 ---  .../drm/amd/disp=
lay/dc/sspl/spl_fixpt31_32.h  |  526 ---
 .../drm/amd/display/dc/sspl/spl_namespace.h   |   17 +
 .../drm/amd/display/dc/sspl/spl_os_types.h    |   43 +-
 104 files changed, 5459 insertions(+), 2114 deletions(-)  delete mode 1006=
44 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_wrapper/Makefile
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D> dml2_wrapper/dml2=
1_wrapper}/dml21_translation_helper.c (99%)  rename drivers/gpu/drm/amd/dis=
play/dc/{dml2_0/dml21 =3D> dml2_wrapper/dml21_wrapper}/dml21_translation_he=
lper.h (94%)  rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D> dml2=
_wrapper/dml21_wrapper}/dml21_utils.c (99%)  rename drivers/gpu/drm/amd/dis=
play/dc/{dml2_0/dml21 =3D> dml2_wrapper/dml21_wrapper}/dml21_utils.h (96%) =
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D> dml2_wrapper/dml2=
1_wrapper}/dml21_wrapper.c (100%)  create mode 100644 drivers/gpu/drm/amd/d=
isplay/dc/dml2_wrapper/dml21_wrapper/dml21_wrapper.h
 rename drivers/gpu/drm/amd/display/dc/{dml2_0/dml21 =3D> dml2_wrapper/dml2=
1_wrapper}/dml21_wrapper_fpu.c (96%)  rename drivers/gpu/drm/amd/display/dc=
/{dml2_0/dml21 =3D> dml2_wrapper/dml21_wrapper}/dml21_wrapper_fpu.h (95%)  =
rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml2_dc_re=
source_mgmt.c (96%)  rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml=
2_wrapper}/dml2_dc_resource_mgmt.h (100%)  rename drivers/gpu/drm/amd/displ=
ay/dc/{dml2_0 =3D> dml2_wrapper}/dml2_dc_types.h (100%)  rename drivers/gpu=
/drm/amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml2_internal_types.h (99%) =
 rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml2_mall=
_phantom.c (97%)  rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml2_w=
rapper}/dml2_mall_phantom.h (100%)  rename drivers/gpu/drm/amd/display/dc/{=
dml2_0 =3D> dml2_wrapper}/dml2_policy.c (99%)  rename drivers/gpu/drm/amd/d=
isplay/dc/{dml2_0 =3D> dml2_wrapper}/dml2_policy.h (100%)  rename drivers/g=
pu/drm/amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml2_translation_helper.c =
(99%)  rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml=
2_translation_helper.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2_=
0 =3D> dml2_wrapper}/dml2_utils.c (98%)  rename drivers/gpu/drm/amd/display=
/dc/{dml2_0 =3D> dml2_wrapper}/dml2_utils.h (100%)  rename drivers/gpu/drm/=
amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml2_wrapper.c (97%)  rename driv=
ers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml2_wrapper.h (100%)=
  rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml2_wrapper}/dml2_wra=
pper_fpu.c (93%)  rename drivers/gpu/drm/amd/display/dc/{dml2_0 =3D> dml2_w=
rapper}/dml2_wrapper_fpu.h (100%)  delete mode 100644 drivers/gpu/drm/amd/d=
isplay/dc/sspl/spl_custom_float.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_custom_float.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_fixpt31_32.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/sspl/spl_namespace.h

--
2.43.0

