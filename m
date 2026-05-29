Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825C4CD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 20:33:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D35AB1124F1;
	Fri, 29 May 2026 20:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="as52Ymjk";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE011124F1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 20:33:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=svFra1Onzs1vQmXTJlrkzVmiQaT/g2MvDZ4oRH775NDMcqZZnCG77kDwNb87le8R/Zxk156Iex3E1Ng4AG0BU3GbHathtWzpNXgW09X92WCKmwwDm0GiQLEDRNn4qj8KrwpGRR3muYffVRej51jXBnliu9VcbceHoS56jGCYVdjuy6ad3PXUzf0DSP1lcxvx9qZptsFFh1C61yVmPCcVHtrmrqZLgh5fBbgXMsc+ZL8FcyIHmIOaE+8KTu+TN/aUTRuxTm53MDKxGWFNWXQuo5F7DJYdTRAH9Vdes5u6UD0/ICTLxeXvV30HMIAgmOmUd3iavkKhbf39cNS2lId8Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2UiVhSX2qVujtwi4tGnp0AuJa1FH8/8vSZiAmnVo58=;
 b=SADi/WDTNetyaycTJt3Ypao4qN+VNg1Yfi9Opz3R33JM/fM3DeOSljwgCqqjUB0i/WLRBN1lqv5C65vrimvR2ImKGJHvOgXwpTgfE3jMO7nMiQU7egAQZcdBAqyG4LT1FJMcSDqYRd+/eNtu+jqFEqNZSlqTjJw5wae8DDSMuBI5fzJ6yUOS2jZHjUCG3Pe/vektxmVXSoi21cdoSw7tPLi9hY983lVNCbJ7MK7e9660mul8VPHMjQr/17Q23E/YU7i6kMrgEBJaJ3QDfJFvhZG3C4CrVSGoHm+6Sbsa8+AtJPsXcawq+5S8yfBH/k22z69mAs/YZ9KUuHDbWZJSqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2UiVhSX2qVujtwi4tGnp0AuJa1FH8/8vSZiAmnVo58=;
 b=as52YmjkWe7uBiZO084E7nfaOb4A/jGkLOXYqROz9SYwdXKZzQFfiDghywuQp4R+yv3v1xCvy5yKMYhTJB+xFzHGWVyWr/s8hoJE8nNBlaHt7OnjIGi8nG+7VfuFng/RXvuIHij+cjw2/knBhfCi02zD5Fx8pfoZL+Og0NuXDsk=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 20:33:49 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 20:33:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Timur_Krist=F3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Jeremy
 Klarenbeek <jeremy.klarenbeek99@gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
Thread-Topic: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7
Thread-Index: AQHc52tfXhVK7GP6RkK1Dp8qwG2PbrYcwRSAgABSCoCACHK2pQ==
Date: Fri, 29 May 2026 20:33:49 +0000
Message-ID: <BL1PR12MB51440DCA164ED993EA5FAFBFF7162@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260519084158.72960-1-timur.kristof@gmail.com>
 <CAOGA6Hix7yPkF2o3hapz9zfpRZ5HHjaaJuDcyWjp+Aoihxf9-A@mail.gmail.com>
 <3626507.sQuhbGJ8Bu@timur-hyperion>
In-Reply-To: <3626507.sQuhbGJ8Bu@timur-hyperion>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T20:33:48.823Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|BL1PR12MB5994:EE_
x-ms-office365-filtering-correlation-id: 3661670a-9393-46f0-7139-08debdc19708
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|13003099007|4143699003|18002099003|22082099003|56012099006|11063799006|8096899003;
x-microsoft-antispam-message-info: OCOhE1+HwNB5TzdxldL/2BwLA57ee9Krdzk3ECAK6ZX3epu47m7G5iNwcRwYxC3g9xkq5qtxZ2KH4tQmuU/0qpxP6pGwne4o17O8GHFGxOdUTpuLosvZqhPavwZB4S/f4RXfyU4AfAmgy+t67cZZJ63UK1jxaYwM+BSnERzeAHxiUBE8216v7+aEPKoEWlwLKVJ1hQi9g3H86/RCvz6VKmSJEKzgKnOSIprguV6jdPqIMPMtU+n4nLxSYepmtg9aS/0OioQ1C/AkPztsvEWeYLMvoFRdgWk+jiVWGerTtaJvlUcSC8Uu2cXnkg9lw+OIbQrCC29OL/HjPMQruz+QYuJjmUySAUlrKUSN3nYVHqv2+spKv90ofGmg3UNtfF+ceg7m+p0OkxS2aK782XFv+i2jsneoObge8d3aSF1ymE9hVitT7Z2VWLFLzSZVO3CqeI+ugHpqAT8nqMB5aeRvZ2OJ79pJ7aNOTGZDPWrVC0xoFpIFCO9Jr6XBbcsFBnl11+DjsKdZB5JvFmuiRhN5tkdQ1cm13ShAwcisxopU5tE/VMzbyOLc7NSgXHMZwhW9SF/uNHWNotnLVDFY7bsw0Y2gHF6ykWYnDIdo5TCkFXShG6/O15fTOum4qklTGlLtesxstznfxT4YghjTrQPY+LXhghnCVeMltsnfK6o9I+/1c/fv8XVHP509O8l82g7Neow7V58E3yELBoxjNT3VnA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(13003099007)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lNu2wMRE3gMTSxVwqS3RsXTBeLChQSyHQsXl5XjPz0eWLoTV9GydDfQobz?=
 =?iso-8859-1?Q?KiL+v6oH7Dmoysy6+7KhyR1uG+LmxdQTE+H4YidIPD1Pwch3ZmFJGbcRaP?=
 =?iso-8859-1?Q?0V5nWj6q1OMFsfUODS1/pGcTBBRR2WYN1MLyYFy+bPW/aEZr40nnObXxMB?=
 =?iso-8859-1?Q?+uB8TCYhuG5srxpTFNGq0XM0dKCWfhNgKorVEgpkfzV+7qd9RyRgRUUQ1f?=
 =?iso-8859-1?Q?lB4G9XmJtcL2Ul70a8eqUJ29UWAjjd/vQDUnXYoaB9IIPAfe72buN2vLXt?=
 =?iso-8859-1?Q?Od9gNwISrTjbMOSgJGeoO19EMhO41q9/p8HC6ovHyQYy62IB+p++dtIqOd?=
 =?iso-8859-1?Q?FI8szdvnOrOQmzkxwuogXwIlxRaR7A58JwrAh4tfbz6jFIzvpxlYgTVMvQ?=
 =?iso-8859-1?Q?ujX5r6HbKrCpGtyntycEkZlv56lhaj0Gn5R75snODJOzLLNnHIw8OMhiUs?=
 =?iso-8859-1?Q?mrFZj/z7RgjFgoZKx8e0fFrv3+xEnEQ7WAbfYziq0ndzkXTVUdZKPEttZz?=
 =?iso-8859-1?Q?V4Xpu0ElvbM8PzZMhuOLWvsQLCQHm2m6/foHtt/EFC/pRhpsh+yDjqxrhS?=
 =?iso-8859-1?Q?1KiTu0MViL/bWz649DiP0Iu91wjvmg04uoN1V1hOLht1mQIT8Ii6wTGOP4?=
 =?iso-8859-1?Q?zSzebp42LRe9P7X3YZV5mCRsOEhMH3unbjYp0zrV5IobUdoj3V1Va3omPs?=
 =?iso-8859-1?Q?q5R4IM+l6fw9wrHaLwxIoGZReOq4izbpTBKkfCMtJgiomZo9PjzSvBXyJf?=
 =?iso-8859-1?Q?MVwdpYPs/Y0Q+pvqrkJhjdO4gA86D0VYTTEEcc5UdHJ50RHelWSXIzJEc6?=
 =?iso-8859-1?Q?yQNZWKiDAQPEsbonvwUZaUtJrginGnpF4M5Y7qzO+llrAF9uvFXd3vDMcn?=
 =?iso-8859-1?Q?T9jWmspUyQiORYrtgVKmABSw7hFJ3AVYR7lL25Yz3cV46/yfsZuurJLJzR?=
 =?iso-8859-1?Q?JGHPgVa/C7SvavUrLiWla4fIV8PebdeOlMekfUoHvGwBavV7P2Qvlca7nK?=
 =?iso-8859-1?Q?6XcQuaab0hRDPVWCNQ+vwA/dAN7P+4U0cq2zFFdyUf2f1psvBztjxaTIuW?=
 =?iso-8859-1?Q?0sZYzwo00WxVq76nFQ0au/DtZO3XvCdjVKAEucGMKXqR6KNJLIQ08WilmZ?=
 =?iso-8859-1?Q?dpZ7JRfITlBO4T8lKs8j3H4n5pWYzqKSKI/EVZR/oKGVuKwPm4cNFjttU8?=
 =?iso-8859-1?Q?7z/sAXfkAhJYNJhPU3HL8mvpsCPcGHBjfRv1aI9HB20jktD15SACa7USnR?=
 =?iso-8859-1?Q?6vw2LWNHhpSWln2mTNZRmOp/eio8cjeAf48iADc+thbzAoEPit7uT18izt?=
 =?iso-8859-1?Q?BCcVBCE7zk3M5R3YKb2I955qFkKxySbiPt+DsLCltmcCl4DzYD7kzL6N9u?=
 =?iso-8859-1?Q?uxqKPw2Cx1Vn7FIjZb6SnEIUYcccwirG/nevl9TrRzxWMs09sMJ/W9gVQG?=
 =?iso-8859-1?Q?T2FAxFGb1Gzd3sG9tY5z6f9qQ4lTA1iyby+vyFCdFdK7kPtegDhI6FloZN?=
 =?iso-8859-1?Q?zSXmouWuucbR9LXqeOzBzUaNa6iSYjaRJbxq8PxXFlvnf5QxbFWqR+HwgI?=
 =?iso-8859-1?Q?kCqFXase6Ta3STUvFa5tk1WO4jhJ5LPcDnbEBoEYm6e4BhiVx0qaY8aull?=
 =?iso-8859-1?Q?Nc0f5mpj3yXfOei9AyWKOUaxSpiSOqfZkzBphU5IFbZ+9mHRxRVYWnfTJl?=
 =?iso-8859-1?Q?aAzpZoRezTAgp/yt6LRJQAHBLI+c0UQtvvXLfjyZxJzHHUeSONFhTeJ8Cc?=
 =?iso-8859-1?Q?T2/0rzcUF2z1jNIYKMQNkf7SwhxMdMHaAwUCIM7vFhXFPM?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440DCA164ED993EA5FAFBFF7162BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3661670a-9393-46f0-7139-08debdc19708
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 20:33:49.3201 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c21Rr0JAMpgyYn3aiMR725XEx6C9xdeSxXytS7AJGJIvr23FaDljHluf+7PZbqjIZ0HEJWJTytFQJWkSINREew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
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

--_000_BL1PR12MB51440DCA164ED993EA5FAFBFF7162BL1PR12MB5144namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

AMD General

I dug into this a bit more and the ATOM_PP_PLATFORM_CAP_HARDWAREDC check is=
 inverted.  Switching that should fix it.

Alex

________________________________
From: Timur Krist=F3f <timur.kristof@gmail.com>
Sent: Sunday, May 24, 2026 7:32 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Jeremy Klarenbeek <jeremy.klarenbee=
k99@gmail.com>
Subject: Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7

Hi Jeremy & Alex,

> Apologies for my late reply. I tested the patch series (SI laptop
> 1002:6606) and the problem remains where the clock speeds don't boost upo=
n
> switching to AC. Timur and I investigated this and found 2 problems

Thanks for getting back to us on this topic.
At Alex's suggestion, I removed the clock recalculation and added the check=
 to
verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I'm sad to hear that this broke you=
r
patches. I apologize for that.

Unfortunately I don't have a SI laptop GPU to test this stuff, so there was=
 no
way for me to verify the correctness of those changes before I sent the
patches to the mailing list.

> 1. It seems that it is necessary after all to recompute clock speeds when
> toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no effect.
> Each ASIC family's apply_state_adjust_rules appears to be responsible for
> the switch by setting the max_limits, and this function is only called as
> part of computing clocks.

That's right. I took another look at:
si_apply_state_adjust_rules()
smu7_apply_state_adjust_rules()

Both of these rely on adev->pm.ac_power when determining max_limits, and th=
ey
set the maximum clocks accordingly. We should indeed re-calculate these clo=
cks
on both SI and SMU7 when there is an AC/DC switch to make sure to apply the
updated max_limits. Additionally I think we should probably lock the mutexe=
s
to ensure that we are sending only one message at a time.

My suggestion would be to call pm_compute_clocks() inside notify_ac_dc(), a=
nd
also to lock the mutexes:
https://gitlab.freedesktop.org/Venemo/linux/-/commit/
e98279dff480cc297cbb1fe50c2b71ebd65b9576

if that works, I'd like to submit that patch (and will also port it to SMU7=
).

> I'm considering removing the .notify_ac_dc field
> from the IP block entirely and just calling .pm_compute_clocks from
> amdgpu_pm_acpi_event_handler, but I only know for certain that this works
> for my GPU.

I don't agree with that. amdgpu_dpm is generic between all supported HW
generations and shouldn't contain HW generation specific code. Also, it cle=
arly
doesn't work the same way on every GPU generation, so we shouldn't generali=
ze.

Furthermore, we should minimize the amount of messages we send to the SMU, =
so
we shouldn't send the RunningOnAC message every time we recompute the clock=
s,
only when it actually switches to AC.

> 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU, causin=
g
> PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled
> erroneously, or we're interpreting its intended usage incorrectly.

It's hard to judge that without having access to the hardware or docs.
Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on your
laptop? Isn't it enough to just re-compute the clocks?

Can you check what exactly is the value of adev->pm.dpm.platform_caps on yo=
ur
laptop? Maybe we are looking at the wrong flag, or maybe the HARDWAREDC fla=
g
only refers to the AC->DC transition and not the DC->AC transition.

This is just guesswork on my part, but maybe we should look at the
SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0.h:
/* This cap indicates whether power source notificaiton is done by SBIOS
directly. */
Can you check if this flag is set on your laptop?

Thanks & best regards,
Timur




--_000_BL1PR12MB51440DCA164ED993EA5FAFBFF7162BL1PR12MB5144namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif;">
<span style=3D"font-size: 12pt; color: rgb(0, 0, 0);">I dug into this a bit=
 more and the
</span><span style=3D"font-size: 11pt; color: rgb(0, 0, 0);">ATOM_PP_PLATFO=
RM_CAP_HARDWAREDC check is inverted.&nbsp; Switching that should fix it.</s=
pan></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Alex</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Timur Krist=F3f &lt;t=
imur.kristof@gmail.com&gt;<br>
<b>Sent:</b> Sunday, May 24, 2026 7:32 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Jeremy Klarenbee=
k &lt;jeremy.klarenbeek99@gmail.com&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] drm/amd/pm: Fix laptop issues on SMU6-7</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hi Jeremy &amp; Alex,<br>
<br>
&gt; Apologies for my late reply. I tested the patch series (SI laptop<br>
&gt; 1002:6606) and the problem remains where the clock speeds don't boost =
upon<br>
&gt; switching to AC. Timur and I investigated this and found 2 problems<br=
>
<br>
Thanks for getting back to us on this topic.<br>
At Alex's suggestion, I removed the clock recalculation and added the check=
 to <br>
verify ATOM_PP_PLATFORM_CAP_HARDWAREDC. I'm sad to hear that this broke you=
r <br>
patches. I apologize for that.<br>
<br>
Unfortunately I don't have a SI laptop GPU to test this stuff, so there was=
 no <br>
way for me to verify the correctness of those changes before I sent the <br=
>
patches to the mailing list.<br>
<br>
&gt; 1. It seems that it is necessary after all to recompute clock speeds w=
hen<br>
&gt; toggling AC/DC. Sending PPSMC_MSG_RunningOnAC on its own has no effect=
.<br>
&gt; Each ASIC family's apply_state_adjust_rules appears to be responsible =
for<br>
&gt; the switch by setting the max_limits, and this function is only called=
 as<br>
&gt; part of computing clocks.<br>
<br>
That's right. I took another look at:<br>
si_apply_state_adjust_rules()<br>
smu7_apply_state_adjust_rules()<br>
<br>
Both of these rely on adev-&gt;pm.ac_power when determining max_limits, and=
 they <br>
set the maximum clocks accordingly. We should indeed re-calculate these clo=
cks <br>
on both SI and SMU7 when there is an AC/DC switch to make sure to apply the=
 <br>
updated max_limits. Additionally I think we should probably lock the mutexe=
s <br>
to ensure that we are sending only one message at a time.<br>
<br>
My suggestion would be to call pm_compute_clocks() inside notify_ac_dc(), a=
nd <br>
also to lock the mutexes:<br>
<a href=3D"https://gitlab.freedesktop.org/Venemo/linux/-/commit/">https://g=
itlab.freedesktop.org/Venemo/linux/-/commit/</a><br>
e98279dff480cc297cbb1fe50c2b71ebd65b9576<br>
<br>
if that works, I'd like to submit that patch (and will also port it to SMU7=
).<br>
<br>
&gt; I'm considering removing the .notify_ac_dc field<br>
&gt; from the IP block entirely and just calling .pm_compute_clocks from<br=
>
&gt; amdgpu_pm_acpi_event_handler, but I only know for certain that this wo=
rks<br>
&gt; for my GPU.<br>
<br>
I don't agree with that. amdgpu_dpm is generic between all supported HW <br=
>
generations and shouldn't contain HW generation specific code. Also, it cle=
arly <br>
doesn't work the same way on every GPU generation, so we shouldn't generali=
ze.<br>
<br>
Furthermore, we should minimize the amount of messages we send to the SMU, =
so <br>
we shouldn't send the RunningOnAC message every time we recompute the clock=
s, <br>
only when it actually switches to AC.<br>
<br>
&gt; 2. The ATOM_PP_PLATFORM_CAP_HARDWAREDC flag is enabled for my GPU, cau=
sing<br>
&gt; PPSMC_MSG_RunningOnAC to never be sent. Either the flag is enabled<br>
&gt; erroneously, or we're interpreting its intended usage incorrectly.<br>
<br>
It's hard to judge that without having access to the hardware or docs.<br>
Are you actually sure that the PPSMC_MSG_RunningOnAC is necessary on your <=
br>
laptop? Isn't it enough to just re-compute the clocks?<br>
<br>
Can you check what exactly is the value of adev-&gt;pm.dpm.platform_caps on=
 your <br>
laptop? Maybe we are looking at the wrong flag, or maybe the HARDWAREDC fla=
g <br>
only refers to the AC-&gt;DC transition and not the DC-&gt;AC transition.<b=
r>
<br>
This is just guesswork on my part, but maybe we should look at the <br>
SBIOSPOWERSOURCE flag instead, which is explained in pptable_v1_0.h:<br>
/* This cap indicates whether power source notificaiton is done by SBIOS <b=
r>
directly. */<br>
Can you check if this flag is set on your laptop?<br>
<br>
Thanks &amp; best regards,<br>
Timur<br>
<br>
<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB51440DCA164ED993EA5FAFBFF7162BL1PR12MB5144namp_--
