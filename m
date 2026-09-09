Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6364AC79FBD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2026 17:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A0710E212;
	Wed,  9 Sep 2026 17:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ixW6xll/";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DFA10E212
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2026 17:16:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AlehbhLdZgoMYNQ30FtbmlsNoW1Ne3lKrn61vi06nNoIobMGgk+kBY56pwglSeTgt6rvj0Fb27PSWZOAe9OcjVfBgvXlxs/mwszDeh2OkZ/WwVmif3ew9jlSIao9DJfwtrCZfipa+QKWeszj/BKiq1Vvu6xsxm8AhobdkEwfITqhi4uK1NBVzTtCQ60iLbkgHTu5UHFdDgWNiIOxSOaBTDXDhCeQON1qdGKLgvZp/xehVaTCVO32Be6Oc4avGIaHof8iZTuftSMZovbAyt9BMDv5xsZ19pYyjN0LW4Qrko+ZLvxTzWL88JFFKYcjpbqsFfMpLmRQYkuldBEgGVy6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25CiB5mcLaHbaFaa3LQznWhSwz2HnplZ1NY9kZ78al0=;
 b=nct9jszwh2VfoXpSI2r+4uLsbuk805trj1tZbIpH3Xp+d7ssBmEw51Ng33KVHekavuL3ovNz5jHXMCFIZdNFRvplhw1riJIBGe/YPxGwq+OIjVxqlhkMyMbFivsyZ+WC6vm2rBbheNNfZuWsaVY1hCfy3V6612LEdO8PrY8aP1m9fXrh9NgheSeOr6gnp+zjlRpAka8DdjFB156nka7Zgpo/51Rr7IttPzgmQILhjj+mVi0/oZY4t//bxBs7PUnR+d1hUiLoeOF+hU8HS/8cwkTwOejimeDlxItLDwwEzFhREuComSXSdHLxvxEe+cmEbNwNXM3g3zEKGnIXh34C/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25CiB5mcLaHbaFaa3LQznWhSwz2HnplZ1NY9kZ78al0=;
 b=ixW6xll/wXn5wbMX2dLsATXsKJ6Ntm/nP/KhthBcJlv94Pr4rLPlRNzhrd/Xt/uMoICCg4QFHPXM9xcCp/pBdwTCATgijpAUUTL19EkD6if0KY4rjiNVhF5hBPXiQtfiMSpC/n81hYCx2JGFuZ88Su9WJHRlOmG1OXgq61rpucQ=
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 (2603:10b6:510:3ca::15) by SA1PR12MB7152.namprd12.prod.outlook.com
 (2603:10b6:806:2b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Wed, 9 Sep
 2026 17:16:01 +0000
Received: from PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4]) by PHXPR12MB999256.namprd12.prod.outlook.com
 ([fe80::9cc3:e12c:d992:4ce4%6]) with mapi id 15.21.0382.014; Wed, 9 Sep 2026
 17:16:01 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
Thread-Topic: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
Thread-Index: AQHdQDATaULcXYgWTUyb69+6BzOgBrbGe1BggAAB5pA=
Date: Wed, 9 Sep 2026 17:16:01 +0000
Message-ID: <PHXPR12MB99925686D0CF8AEFFA32ECACB1EEB02@PHXPR12MB999256.namprd12.prod.outlook.com>
References: <20260909075121.598208-1-lijo.lazar@amd.com>
 <PHXPR12MB999256240CD7E1B296F833E70AEEB02@PHXPR12MB999256.namprd12.prod.outlook.com>
In-Reply-To: <PHXPR12MB999256240CD7E1B296F833E70AEEB02@PHXPR12MB999256.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-09T17:08:33.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PHXPR12MB999256:EE_|SA1PR12MB7152:EE_
x-ms-office365-filtering-correlation-id: ecfa77c9-5bd3-43c8-042d-08df0e9605e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|10067099003|11063799006|4143699003|18002099003|56012099006|22082099003|6133799003|38070700021;
x-microsoft-antispam-message-info: o0B3XIJBYOtiqARWG6r1Mw3Ds+V8iIe9p0vMw0+RBQHz1tW7tqFWRl2i7c3PThr4VckvWXZEoGDI3KTRpePgvAp0gdEQV3Flq758JgtjXbMLbJ2KsuyQVJML6a7axOQytE18yTMfZ3F6LL7syiI+8/mRHJERR31pMj/WEBASHsBniTodR6DchJa/PRNgZuNNMWSlP8iU4VGfKJZpl7z03B73vPJXWmVgkxC0GwqkTVBnPNhuqzQBQpDLuzIDjqAh3lTRcEe/uFsWLEVyNHnRf3++olt486GgrTA8cEqFmaiE1Y42Zv1s/vz7NAj2zhnMrKWiatlEyc6qVixJWf0KORxCWqv8WBxb1cLzKg9xYLHf6QKFaNf3DtvFCEJWtr2/WOUtoBOmrvO/ulL5M4jhWDgcX8SgxxKrA7Gz6SOAl0kFPaFX2wnl4JkjUD+Pq6UUXxUz0b2Gav5mZ1+8mpfobeGEYDk0EBEoT6YzwZ10lPEw8e1RBkaEP90jN/RCMU3BrNdcDSCxqG5PBzAo4wAkRiGzhat3w/mZ8px/qXHaLhD29tkNH4yXe4aG8nhVZ5RsV5kHn6bKJmEtZE5isP9wRFeirRVBB5ZCZi0gikQPROEb4j8pPr5zVQ5DJ7qi/VnsUkW26PhxW5oWpfapDYXrfTNxX7areZmCto3v0aVj35AoY68s+1sTTG1IwZVfPVY79X2N57eaHgnCpIhOY6UzMs+MH5VMAiTWXe4AUuuXcKY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PHXPR12MB999256.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b4vLSwKRKh0q1Pi0mbRj9pBy3yI9AzHMBLL+wmZtXgk1Mtpy4bSlqV6VzXBn?=
 =?us-ascii?Q?sDUBbO21BB5V0vVSYJ6iBv9ea4by6VHGOJL0chLJ+c1YoTaPQl14tWKtlyQQ?=
 =?us-ascii?Q?+plakiMtlXLpe9CSf6oxUX56DlpcI9ZUWdovjVvfj0yNstAQyh6QHJ33wePk?=
 =?us-ascii?Q?MvZVcrAVb5SJosti/3NStQ9k7Eo023XCvcOD0tEbhAejXRq2kDLejkdA/8Z+?=
 =?us-ascii?Q?zbpt8s22tq4D8Z8LphHmB2aCuzQmDKCMF1wSQPo/dFzKlHRWZscfBCO+Iu+U?=
 =?us-ascii?Q?sfVaTWitEC9xcuRddF8cJ82eTkBd2YoG5w+8q4LKgItupt0lK7ufrTeeOydv?=
 =?us-ascii?Q?rGw7kN1NPSKSuIlyQWlmGJjPRReBNPv7jDP3Xc5pAaESJy8KTn5b9cWLB9Fk?=
 =?us-ascii?Q?Qp8CadoSWJXbAo1XpUS3wBTTVjt0dq615Vz9HtmKr8D7r6pJm3yhD07euY0V?=
 =?us-ascii?Q?d/XxLpFnGPexw1V0lnUIwGz4JI9B8qYB5v5mfeftU5/nQRIlKAN0aDYv/XzL?=
 =?us-ascii?Q?vxAJNatKyV97wEYlswN81XB75gpxbY9oCDWwRBXBMDq6pP+qicEZMGeSzZuP?=
 =?us-ascii?Q?eiCIvHUp6opsaNG7jG5u5Atp6LQDfM40i56vNTMUi8Na/LgO8NJo1/NPs9Db?=
 =?us-ascii?Q?L0eQ4o7bJycCjRsz9V4AWcuDlMqb19svIyuYtvUKpQmQ6Rt8vS06FQ1V7wRo?=
 =?us-ascii?Q?ReljlyvnTV+bTGIQqTBfgV8iyUTayMw+FDBq9E1lXaQBBbPzIGbRN3mOLhWd?=
 =?us-ascii?Q?VnJro+QbQJOhv4+asgDUDenZ6njedGxU8GeMA4sWF9EVyC8WajvlNtRiTcIr?=
 =?us-ascii?Q?p025um7nH/BpT+pe4xC6iN3bcWi+EnK7vSwuIaZOM/XvXEx8O/1rhK86HObq?=
 =?us-ascii?Q?iA2Hw8CBmLBhI9Yrl7HvPYlkNVKU+BUdqJ1WyEJepTzpXuvE52XpUdETkcwE?=
 =?us-ascii?Q?iEL+uJLu4VGpxJ84oRyonb9P9topcahyn2Kx7SyYWlyNAbJQxamoPlSzI1fe?=
 =?us-ascii?Q?kHqnUIejEkJHR/i9GIyaCT5442cHiwyEYVqAb7iYW6N7IEsMSqgreHxfpEQ8?=
 =?us-ascii?Q?B05N/XbPcB7mpYCQJHOZOqBJWP5YZNdiVIfeqQtwW79ne1oKth2k8aYf1MZC?=
 =?us-ascii?Q?kGNat804Sy+BSZqTEFPJFBFxB3jgNF4XlMdP5A0wvxpvaKg+P5OuGzO21l3r?=
 =?us-ascii?Q?5oDmLfl/J2LyjAITVV9aAPEBXE+HZ4+a65/LdLqJfzV5C+XeKfzYHFxQz2Ws?=
 =?us-ascii?Q?OTuhOqkrhLG0Awh2GIdr5jl/aZS9C39bOrhP50AOTSUVfbRJkKbIT9TcfNKc?=
 =?us-ascii?Q?2+a0RNGFfjLyMsK4olZ5ux5C9e0BEVAXVZhxAwDIeBzdlts3BZ8L3hKoWqhn?=
 =?us-ascii?Q?hZEO2jSk0+YPSPn1zMkj1pAEXVTcOjnohZ4Nsvu7qLivNgqOFc30tX2Ylnr2?=
 =?us-ascii?Q?0zaEz8mK7iY/bvXGwV3H89Jvuj4XL4PSVl03BEbbobqWlRjyLrFcAHGNfG0z?=
 =?us-ascii?Q?eTIo3HPlkaXWgnczEHYfBj94zKLPC2EaZdDJ8OjJYrQa87yxCFXmoc3T6RNy?=
 =?us-ascii?Q?j+WkNjbCj3k1cZiH8ryZMthjcLyfQbzIrU5orDQteRXXB8Md6TJPcY6YvByS?=
 =?us-ascii?Q?sVe/00iu7P31AAFzUiXRCEAA+n/mIcJrAUJaw/cx6DiBA1EPslUpsfAM+FFu?=
 =?us-ascii?Q?qc7w9ikclOce9W/pchNQ+rS5rUYTpQ6Ce4bFNeyEaYYoUtbn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PHXPR12MB999256.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecfa77c9-5bd3-43c8-042d-08df0e9605e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2026 17:16:01.6109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9sVNtup5oOtAYGp+1c3+0wVqbHcMEQpuREt8Ewaym/7THCvlGxAmWXKmpc/PqPgxlOQ2VZ+/fg8ma8n2hShcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7152
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

AMD General

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Joshi,
> Mukul
> Sent: Wednesday, September 9, 2026 1:14 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
> Liu, Xiang(Dean) <Xiang.Liu@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
>
> AMD General
>
> > -----Original Message-----
> > From: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Sent: Wednesday, September 9, 2026 3:51 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>;
> > Joshi, Mukul <Mukul.Joshi@amd.com>; Liu, Xiang(Dean)
> > <Xiang.Liu@amd.com>
> > Subject: [PATCH 1/2] drm/amdgpu: Fix kfd device lock during partition
> >
> > The compute partition switch locked the kfd device, freed it during
> > the pre- switch teardown, and then unlocked at the end - by which
> > point
> > adev->kfd.dev referenced the newly reinitialized device, so the unlock
> > landed on the wrong object and the per-device lock was never balanced.
> >
> > Add a dedicated prepare function to unwind and clean up kfd device.
> > Don't use the global lock during teardown. A new device is created
> > after partition switch; hence there is no need to do 'unlock' on a
> > different object after the switch.
> >
> > User is not supposed to run any process on the device during partition
> > switch. Keep acquire/release semantics for init_complete so that the
> > device remains unavailable for a process till its reinitialization is c=
omplete.
> >
> > Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   | 19
> > +++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h   |  6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c      |  6 ++++--
> >  drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c   | 11 +----------
> >  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c        | 11 +----------
> >  drivers/gpu/drm/amd/amdkfd/kfd_device.c      | 10 ++++++++--
> >  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c |  6 ++++++
> >  7 files changed, 45 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index 09feb45584ba..a2a368f1e290 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -245,6 +245,25 @@ void amdgpu_amdkfd_device_fini_sw(struct
> > amdgpu_device *adev)
> >       }
> >  }
> >
> > +int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device
> > *adev)
> > +{
> > +     struct kfd_dev *kfd =3D adev->kfd.dev;
> > +     int r;
> > +
> > +     if (!kfd)
> > +             return 0;
> > +     r =3D kgd2kfd_check_and_lock_kfd(kfd);
> > +     if (r)
> > +             return r;
> > +
> > +     adev->kfd.init_complete =3D false;
> > +     kgd2kfd_device_fini(kfd);
> > +     adev->kfd.dev =3D NULL;
> > +     amdgpu_amdkfd_total_mem_size -=3D adev->gmc.real_vram_size;
> > +
> > +     return 0;
> > +}
> > +
> >  void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
> >               const void *ih_ring_entry)  { diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > index 1b7dc0d3963b..36e222f3ac5b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > @@ -170,6 +170,7 @@ void amdgpu_amdkfd_interrupt(struct
> amdgpu_device
> > *adev,  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev);
> > void amdgpu_amdkfd_device_init(struct amdgpu_device *adev);  void
> > amdgpu_amdkfd_device_fini_sw(struct
> > amdgpu_device *adev);
> > +int amdgpu_amdkfd_prepare_partition_switch(struct amdgpu_device
> > *adev);
> >  int amdgpu_amdkfd_check_and_lock_kfd(struct amdgpu_device *adev);
> > void amdgpu_amdkfd_unlock_kfd(struct amdgpu_device *adev);  int
> > amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev, @@ -431,6
> +432,7
> > @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf);
> > bool kgd2kfd_device_init(struct kfd_dev *kfd,
> >                        const struct kgd2kfd_shared_resources
> > *gpu_resources);  void kgd2kfd_device_exit(struct kfd_dev *kfd);
> > +void kgd2kfd_device_fini(struct kfd_dev *kfd);
> >  void kgd2kfd_suspend(struct kfd_dev *kfd, bool suspend_proc);  int
> > kgd2kfd_resume(struct kfd_dev *kfd, bool resume_proc);  void
> > kgd2kfd_suspend_process(struct kfd_dev *kfd); @@ -485,6 +487,10 @@
> > static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)  {  }
> >
> > +static inline void kgd2kfd_device_fini(struct kfd_dev *kfd) { }
> > +
>
> Maybe follow the pattern of having open and close branch on new lines as
> done for the other functions.
>
Sorry I meant open and close brace here.

Regards,
Mukul

> >  static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool
> > suspend_proc)  { } diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > index a8c79a66df1d..92fa15ace438 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -694,14 +694,16 @@ void
> > amdgpu_xcp_update_supported_modes(struct amdgpu_xcp_mgr
> *xcp_mgr)
> >
> >  int amdgpu_xcp_pre_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
> > u32 flags)  {
> > +     int ret =3D 0;
> > +
> >       /* TODO:
> >        * Stop user queues and threads, and make sure GPU is empty of
> > work.
> >        */
> >
> >       if (flags & AMDGPU_XCP_OPS_KFD)
> > -             amdgpu_amdkfd_device_fini_sw(xcp_mgr->adev);
> > +             ret =3D amdgpu_amdkfd_prepare_partition_switch(xcp_mgr-
> > >adev);
> >
> > -     return 0;
> > +     return ret;
> >  }
> >
> >  int amdgpu_xcp_post_partition_switch(struct amdgpu_xcp_mgr *xcp_mgr,
> > u32 flags) diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> > b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> > index cddfe4015f53..699e797679ec 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> > @@ -391,15 +391,9 @@ static int
> > aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
> >               !adev->in_suspend)
> >               flags |=3D AMDGPU_XCP_OPS_KFD;
> >
> > -     if (flags & AMDGPU_XCP_OPS_KFD) {
> > -             ret =3D amdgpu_amdkfd_check_and_lock_kfd(adev);
> > -             if (ret)
> > -                     goto out;
> > -     }
> > -
> >       ret =3D amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
> >       if (ret)
> > -             goto unlock;
> > +             goto out;
> >
> >       num_xcc_per_xcp =3D __aqua_vanjaram_get_xcc_per_xcp(xcp_mgr,
> > mode);
> >       if (adev->gfx.funcs->switch_partition_mode)
> > @@ -413,9 +407,6 @@ static int
> > aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
> >       ret =3D amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
> >       if (!ret)
> >
> >       __aqua_vanjaram_update_available_partition_mode(xcp_mgr);
> > -unlock:
> > -     if (flags & AMDGPU_XCP_OPS_KFD)
> > -             amdgpu_amdkfd_unlock_kfd(adev);
> >  out:
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > index 757da0a30fdc..28eca48c6596 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > @@ -1097,15 +1097,9 @@ static int
> > soc_v1_0_switch_partition_mode(struct
> > amdgpu_xcp_mgr *xcp_mgr,
> >       if (adev->kfd.init_complete && !amdgpu_in_reset(adev))
> >               flags |=3D AMDGPU_XCP_OPS_KFD;
> >
> > -     if (flags & AMDGPU_XCP_OPS_KFD) {
> > -             ret =3D amdgpu_amdkfd_check_and_lock_kfd(adev);
> > -             if (ret)
> > -                     goto out;
> > -     }
> > -
> >       ret =3D amdgpu_xcp_pre_partition_switch(xcp_mgr, flags);
> >       if (ret)
> > -             goto unlock;
> > +             goto out;
> >
> >       num_xcc_per_xcp =3D __soc_v1_0_get_xcc_per_xcp(xcp_mgr, mode);
> >       if (adev->gfx.imu.funcs &&
> > @@ -1126,9 +1120,6 @@ static int soc_v1_0_switch_partition_mode(struct
> > amdgpu_xcp_mgr *xcp_mgr,
> >       ret =3D amdgpu_xcp_post_partition_switch(xcp_mgr, flags);
> >       if (!ret)
> >               __soc_v1_0_update_available_partition_mode(xcp_mgr);
> > -unlock:
> > -     if (flags & AMDGPU_XCP_OPS_KFD)
> > -             amdgpu_amdkfd_unlock_kfd(adev);
> >  out:
> >       return ret;
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > index 1c1e7878a2a7..76b308286095 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > @@ -952,7 +952,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> >
> >       svm_range_set_max_pages(kfd->adev);
> >
> > -     kfd->init_complete =3D true;
> > +     /* Release pairs with the acquire in kfd_init_apertures(). */
> > +     smp_store_release(&kfd->init_complete, true);
> >       dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev-
> > >vendor,
> >                kfd->adev->pdev->device);
> >
> > @@ -977,7 +978,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> >       return kfd->init_complete;
> >  }
> >
> > -void kgd2kfd_device_exit(struct kfd_dev *kfd)
> > +void kgd2kfd_device_fini(struct kfd_dev *kfd)
> >  {
> >       if (kfd->init_complete) {
> >               /* Cleanup KFD nodes */
> > @@ -991,6 +992,11 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
> >       }
> >
> >       kfree(kfd);
> > +}
> > +
> > +void kgd2kfd_device_exit(struct kfd_dev *kfd) {
>
> Open brace should be on the next line.
> Maybe run it through checkpatch once if not already done.
>
> > +     kgd2kfd_device_fini(kfd);
> >
> >       /* after remove a kfd device unlock kfd driver */
> >       kgd2kfd_unlock_kfd(NULL);
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > index 04c5e26f01ed..da61d939b35c 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > @@ -396,6 +396,12 @@ int kfd_init_apertures(struct kfd_process *process=
)
> >                       continue;
> >               }
> >
> > +             /* acquire pairs with the release in kgd2kfd_device_init(=
) */
> > +             if (!smp_load_acquire(&dev->kfd->init_complete)) {
>
> Do we need similar smp_load_acquire() at other call sites of this kfd-
> >init_complete?
>
> With the minor nit-picks above fixed, this series is:
> Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
>
> > +                     id++;
> > +                     continue;
> > +             }
> > +
> >               pdd =3D kfd_create_process_device_data(dev, process);
> >               if (!pdd) {
> >                       dev_err(dev->adev->dev,
> > --
> > 2.49.0

