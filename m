Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64738CCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 05:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D21B310E0A6;
	Mon, 13 Oct 2025 05:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EUPYkOZF";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010012.outbound.protection.outlook.com
 [52.101.193.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DDE10E0A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 05:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isPud+yMsvkMAQy0jkhIMtfjOvmaQ1jRSNqm8M7fwCFTM59XBDoW5ILpEloKhfYtKA0obcdwi3zsTyEmwbJLjuxsTZKnSgJlztUq3NPB38P+we7dPyYdhdZ/KJnwHR5e6PGfYgXlM+TlwPaQEGofc/txWtqm6G6KhoEX0dH6Ye+z7meVEtHiQTYYlGDCLGU3t1gyZC+wWsKULhTts3i+XcsWav/td05XvSnxf9sKOhPVhdVRldW1MV2/DW6h5Bvl03FMQRXeZEueqtnIouzoYqa/s2zjK3TEGLGyiVKul5bYWqmBOTAoemIvdUhchYE34FYB9IUtB0W3KUwpHJgE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMlN75c7AQ6jX0xNGtyN986KKmYY4lmi12I0Nmbbxk8=;
 b=F2hKY1C/f6XwRr+Wqk0eUD/Vt6YrjflT59OrP1DEJ57GZD/Dlte9JQNYOG+oWKRZY7CkP35J/kZUOk1r12gwTA9qbbFqCVB2L3JZKECStIE+oZCsKVG1PTogoUOMm9EYn2SUc7zCiIWuXYD3rKMPwJKOI0LyPKsDOV/qbXgcdp/PxMe/tJERzQIrtqMdpQbr+1NBzyZzDCm9XzycEUaauvSrZmCuRv2x2iBfXnqWmlrlQrQ97nb+JQHOI1HIAdrM7BWRokpyVNx7dl3qcK69lH/1lPdYzZM3v+mkADAVNNGmOVFQlAvFMF+6CERUWqBT6FBprLlPiDwEEV18p9KGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMlN75c7AQ6jX0xNGtyN986KKmYY4lmi12I0Nmbbxk8=;
 b=EUPYkOZFVz+nqK/i2KLwKY+fc2VfkDReURNAmgJV5nUdTFWW+KNAezrjWu04g1BSxo2TdDH/uGv/R+fhh9sLndpIv89lKxDcNgBYmbA1yBQ5y0nhNJe8dAZiFxEwNmVlMi5hRxFtUVt2SwKm1TqJQW7TPwYAfY36edpIe5Tahec=
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:35:03 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::7606:59:8d0d:6d4c%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 05:35:02 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Pan, Ellen" <Yunru.Pan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Chan, Hing Pong" <Jeffrey.Chan@amd.com>
Subject: RE: [PATCH v3 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to
 init from dynamic crit_region offsets
Thread-Topic: [PATCH v3 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to
 init from dynamic crit_region offsets
Thread-Index: AQHcOhaQoXB/i2YyVUmkxxbrj0TrNbS/jh1g
Date: Mon, 13 Oct 2025 05:35:02 +0000
Message-ID: <PH7PR12MB7820CC66D274F586E7723EBD97EAA@PH7PR12MB7820.namprd12.prod.outlook.com>
References: <20251010184849.9701-1-yunru.pan@amd.com>
 <20251010184849.9701-5-yunru.pan@amd.com>
In-Reply-To: <20251010184849.9701-5-yunru.pan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-13T05:20:52.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7820:EE_|SJ1PR12MB6027:EE_
x-ms-office365-filtering-correlation-id: 7029aed8-756b-4e91-1ee5-08de0a1a4205
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?HADsMy53Z4rHzMEdYYw8wDJzkkhU1SUC3gII5ji6nA7tMKJF2cIaRPqy0eOD?=
 =?us-ascii?Q?mJVEVFGLr+8LCilwLJvDp2xBM5JTEsht8Br4pYfFDKK89JWNEvonHKfDTuRw?=
 =?us-ascii?Q?wGx1HQU0Ryoav6XuX3BIfOyS+m4Jpd3chHW9knmPVrFEPa8E23B0R+q06Q/+?=
 =?us-ascii?Q?EB9K1cQ3qfiH1j8huCVCFVtzNeTyVfA6qMgcELxF0ncC0GgrulKrCZKmnUvd?=
 =?us-ascii?Q?MpKOux2MluVRFMuDTJwgOInDsjPgRzOPN9azxCQYnFftZK5i/iRnol2R5qRV?=
 =?us-ascii?Q?1dBnUO9AAjhv9vnbW6d12wMT/XP5xaatBWp4YI7VwenPyDLtEYm4WlmW1HRP?=
 =?us-ascii?Q?wRZgsDGqU5mP61ShtLHOlVOFBo4yxYXEoyh0jgSOP3cdx6G/X1C0CTUsu2bt?=
 =?us-ascii?Q?0UN719qFjACGT0ltBdyyxF9mccn6dvABaw3x1ZTa3kv93LdE4a5ae0Wm1pN7?=
 =?us-ascii?Q?peiKJvNPquTyvRHjmTWhFNZ/N6YyutmGm/FL7y48tHnqQNH8pie2+TM2AWRq?=
 =?us-ascii?Q?33lnSJBtXtl/hE8ZKI/rOiEt9QOgVyyUyyO2BigW+8ALfceavOxJWYi3fDOs?=
 =?us-ascii?Q?jhNnvBxPwnM5ewpvBW0JZe5cf6Ro0JAUU3few4SrLSvQOOabgPdyISStUcVf?=
 =?us-ascii?Q?8sb0KGkmShpt9D67Li2s6KuXGMI8xNna0N0M7jTQphagKazsAmvwpTm3xXRM?=
 =?us-ascii?Q?uv6JuuSqJ12k5ZDcM51FGP0n5TktwY/agZscS2h8QSSD+2ftIqa7vmYikzum?=
 =?us-ascii?Q?BF73vJOuoRTJ2Y2UYJ9D8fOzWzcLOJ502coilT5D6OuQ1h9hHxSWU+QD8QSX?=
 =?us-ascii?Q?eHpjEjv9Q2HG9BeKjFT5Gd1FtTGoodvJbI7gdoG2aFSY4e3cbOkwNN6FUEeR?=
 =?us-ascii?Q?b0g9kMzeYYYAGHQshU+HwV+F8rqjHo+7yzqZRo8ccgREd2ULJc7byueBYPJ1?=
 =?us-ascii?Q?7n2qD+NmgrKbvOf5PkI/2YDyFl1abJAed/GD0ogw/N112dRiR2RTd/L4r2Td?=
 =?us-ascii?Q?ONOAItWAIT80YINZhsqBiukxnwk4WrE/ilHEbI7gEk4pMMh2kOTz+L8+NZtA?=
 =?us-ascii?Q?TWqoUcKdEhYoL7BPxhb4ttoxIghnE43M/8clQedncYWMKqXNv8uDpsbF02He?=
 =?us-ascii?Q?GQs71GmnQPIiB7MpTbY/bi7WTcpKSSkmqs3TknkGC01khDFHew4mGu2cpD0L?=
 =?us-ascii?Q?bYeNy51ZroRbSD0KSePUkSWZQFvyX9PS1p/QrOVihUMU7byYApjxgWei+aov?=
 =?us-ascii?Q?Su5g0PbVOs0mbxZUjY0iBrFm/YKwGNIzyjELX3Js69FbXWO2fQH62i4VbWLo?=
 =?us-ascii?Q?SItKQbzhHXgbcPRRT/TMBdVpSqRTuGuzH8wCUb94CQhYH0y6LvNI9wTf0BJq?=
 =?us-ascii?Q?y6Dsno4E+KqUDBzFscW+QlZzuIdQZTl3otsNDET7n0It6EUYUBx2VAsXJWct?=
 =?us-ascii?Q?SaS04UYdWoWiChNMeEXmLsFOYtrw+wmn71dDsLvqBPQxTb5vsMQPilXGKiLF?=
 =?us-ascii?Q?u7S+kgyHWUloCjDxIEihRyg9aKoUuN04oE9n?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U2WYRlP/uhqzEBHKm/Za3EM+YAJ4Cod4umg+ljcEzZ8+fxW5SUZIGJrarDAl?=
 =?us-ascii?Q?ZYGD0e6AsENUIFwOiotMfxLKwH/MUpV7U7xjhQxZusIULhmmWwy4BCVAhO70?=
 =?us-ascii?Q?tQQ2cUk+3wBnDE8Kau0qRHVkSZPh20iWOauemfSF02l0zfJIqSqu3hPrimpm?=
 =?us-ascii?Q?ExK2HMQr3+NUf0/X/4poXpJpAQat7LGRUQ8a0Kbge1vXClN6pJ2W7xR211Jp?=
 =?us-ascii?Q?O1qd415+CWwZt5ANLZrwISXjxxfaiklHUgrvK4MmtSh2nK/MSBQg2H7nWIS8?=
 =?us-ascii?Q?UOxP4xp85KwnYVVRvjerWWZWda2OMdObZA5qkhg198G7VU7nsNdGlkT5nQm5?=
 =?us-ascii?Q?EehUEN80j/+fm6wnOCzowooeb5CajaDGfZRPB77RyhtXWNYZmJZ7zWT3W+IC?=
 =?us-ascii?Q?qCcP9blTyyOi7wOJmRXtArLqjhsxKLx928suRuZdcJ5J21c30KcS7EV9xM0x?=
 =?us-ascii?Q?1o844EwjSqfHd5k/ZLiE9MgcbCTVZNz/DxlxhogqqEgY2u8GdJOIiV+HPtsh?=
 =?us-ascii?Q?w1Hh1rf5yVH5b0r+18s9TjF1iuWIdyq1PvUeBu93s1ELcCq6gV9RPp6Bwy7i?=
 =?us-ascii?Q?1wdSvyD3zF543l08jRjK94RGWeYkjz8rlOXuL3KgvzF6ecy7llXj+7BGZKMS?=
 =?us-ascii?Q?EhX7U/fHVi++Kkr2hZ/kzfeX5UREj/iQAIK867sIWhgtaPaRVBHCqEtDCVhD?=
 =?us-ascii?Q?/L96TTJafq4dIpK1KNkFbbbXjS9uE7v7qAhGTPX1LIwbexxRXVmSyIrgK2QE?=
 =?us-ascii?Q?Y1U3JBNeyWlv49ZD57yfOl1rHECt20e/EWP/aN9IZGmcUZB6r31GHmF32xQk?=
 =?us-ascii?Q?d2juqHqM1lx4x6dnXCr6n56Ndir+d2TNo3bONH5dnwKnzTZwBp0zjkb8g2VZ?=
 =?us-ascii?Q?RY+tyuTqxNoN65lzVoYpVa++yNsfkrF2s8Zv/NJx0o3354ErBv+KK7HdkW5V?=
 =?us-ascii?Q?NvcD8JRxIr9s2oyR0smvFp0WkrK7FqOqgv0p/d5sWEtv/wdgf+dqrGErmfUv?=
 =?us-ascii?Q?38kqaYvX+EkZfYphd1Qng44PC4b661rcdD6vSmQ8rKRmBvQR8UpcxVsi/rpa?=
 =?us-ascii?Q?/iQgT1fTYYKix/M5Ima2qLhrLCw99LBYlMjB+GRcFjuhh18XtbnVr3aOXLjv?=
 =?us-ascii?Q?GMY/TXGgc4+FhMK7io1psAkLqwPBRHeB5zL9O0DOa1H/vCUSQNzv2yYPGd1p?=
 =?us-ascii?Q?wpoJLOM3QWgjG4DhVKiaCqyR/bpJffhyzIyuAcOAySoxqMD/kmZVw4dOo103?=
 =?us-ascii?Q?3F9wQ74suIid1a7pagf7PjZ0mR85fdIBTKjwmDHZJAT7hEgsVP7vz+FQy510?=
 =?us-ascii?Q?jvxDL4lZ5rj5WgORg9QTKbtFQRq36R0P+qAwe4GAq9fLh6juCa/LLXU8s5/j?=
 =?us-ascii?Q?X90OtEquJjDzfGLGNQ4B1Hrw3ziGglq763f5eMtmH3k4HofQEDrrati49l20?=
 =?us-ascii?Q?xItjzM+aDLexo2BHVOWljKVy7LtwJQWiKXxDkXUYiPQf9rMe+wfMuLA7ukiK?=
 =?us-ascii?Q?ZrBc86qSfD/wYTnGiUS3YB82EpDTOZRiSnvWVOc5tdBBWTAJiegUkfVGEGcN?=
 =?us-ascii?Q?rPePLu6ccgJLL4sp5yU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7029aed8-756b-4e91-1ee5-08de0a1a4205
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 05:35:02.5888 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8xIju9qyVBYi9kFcPBD2zxOIKvCE3CWipOx4l+Z7JLUFM5C96GZTnVrDTEhuIZlw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
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

>-----Original Message-----
>From: Pan, Ellen <Yunru.Pan@amd.com>
>Sent: Saturday, October 11, 2025 12:19 AM
>To: amd-gfx@lists.freedesktop.org
>Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Chan, Hing
>Pong <Jeffrey.Chan@amd.com>; Pan, Ellen <Yunru.Pan@amd.com>
>Subject: [PATCH v3 5/6] drm/amdgpu: Add logic for VF ipd and VF bios to in=
it
>from dynamic crit_region offsets
>
>1. Added VF logic in amdgpu_virt to init IP discovery using the offsets fr=
om
>dynamic(v2) critical regions; 2. Added VF logic in amdgpu_virt to init bio=
s image
>using the offsets from dynamic(v2) critical regions;
>
>Signed-off-by: Ellen Pan <yunru.pan@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c      | 17 +++++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 +++-
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 53
>+++++++++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |  2 +
> 4 files changed, 80 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>index 00e96419fcda..41f8fe04126f 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
>@@ -96,7 +96,8 @@ void amdgpu_bios_release(struct amdgpu_device *adev)
>  * part of the system bios.  On boot, the system bios puts a
>  * copy of the igp rom at the start of vram if a discrete card is
>  * present.
>- * For SR-IOV, the vbios image is also put in VRAM in the VF.
>+ * For SR-IOV, if dynamic critical region is not enabled,
>+ * the vbios image is also put at the start of VRAM in the VF.
>  */
> static bool amdgpu_read_bios_from_vram(struct amdgpu_device *adev)  {
>@@ -114,7 +115,19 @@ static bool amdgpu_read_bios_from_vram(struct
>amdgpu_device *adev)
>
>       adev->bios =3D NULL;
>       vram_base =3D pci_resource_start(adev->pdev, 0);
>-      bios =3D ioremap_wc(vram_base, size);
>+
>+      /* For SR-IOV, if dynamic critical region is enabled,
>+       * the vbios image is put at a dynamic offset of VRAM in the VF.
>+       * If dynamic critical region is disabled, exit early to proceed
>+       * the same seq as on baremetal.
>+       */
>+      if (amdgpu_sriov_vf(adev) && adev-
>>virt.is_dynamic_crit_regn_enabled) {
>+              if (amdgpu_virt_get_dynamic_data_info(adev,
>AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID,
>+                              (uint8_t *)&bios, &size))
[lijo]

This doesn't look correct. Please be consistent with the meaning of the par=
ameter of this function. If it's just a uint8_t *, pass the buffer which is=
 allocated outside and the function fills it. If that's the route taken, th=
en you could allocate adev->bios with arbitrary size, pass it and do a real=
loc if required. The size param will then be in/out (as out param, it will =
return the actual size). If it's a uint8_t **, then the allocation can be d=
one inside the function.

>+                      return false;
>+      } else
>+              bios =3D ioremap_wc(vram_base, size);
>+
>       if (!bios)
>               return false;
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>index 73401f0aeb34..23aec57295c0 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>@@ -283,7 +283,6 @@ static int
>amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>                * wait for this to complete.  Once the C2PMSG is updated, =
we
>can
>                * continue.
>                */
>-
>               for (i =3D 0; i < 2000; i++) {
>                       msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
>                       if (msg & 0x80000000)
>@@ -292,6 +291,16 @@ static int
>amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
>               }
>       }
>
>+      /* For SRIOV VFs, if dynamic critical region is enabled,
>+       * IPD binary is retrieved via this call.
>+       * If dynamic critical is disabled, fallthrough to normal seq below=
.
>+       */
>+      if (amdgpu_sriov_vf(adev) && adev-
>>virt.is_dynamic_crit_regn_enabled) {
>+              ret =3D amdgpu_virt_get_dynamic_data_info(adev,
>+                              AMD_SRIOV_MSG_IPD_TABLE_ID, binary,
>NULL);
>+              return ret;
>+      }
>+
>       vram_size =3D RREG32(mmRCC_CONFIG_MEMSIZE);
>       if (!vram_size || vram_size =3D=3D U32_MAX)
>               sz_valid =3D false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>index 461e83728594..4a7125122ae7 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>@@ -965,6 +965,59 @@ int amdgpu_virt_init_critical_region(struct
>amdgpu_device *adev)
>       return r;
> }
>
>+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
>+      int data_id, uint8_t *binary, uint64_t *size) {
>+      uint32_t data_offset =3D 0;
>+      uint32_t data_size =3D 0;
>+      enum amd_sriov_msg_table_id_enum data_table_id =3D data_id;
>+      char *data_name;
>+      uint8_t __iomem *buf;
>+
>+      if (data_table_id >=3D AMD_SRIOV_MSG_MAX_TABLE_ID)
>+              return -EINVAL;
>+
>+      data_offset =3D adev->virt.crit_regn_tbl[data_table_id].offset;
>+      data_size =3D adev->virt.crit_regn_tbl[data_table_id].size_kb << 10=
;
>+
>+      switch (data_id) {
>+      case AMD_SRIOV_MSG_IPD_TABLE_ID:
>+              data_name =3D "IPD";
>+              if (!IS_ALIGNED(data_offset, 4) || !IS_ALIGNED(data_size, 4=
)) {
>+                      dev_err(adev->dev, "IP discovery data not aligned t=
o 4
>bytes\n");
>+                      return -EINVAL;
>+              }
>+
>+              if (data_size > DISCOVERY_TMR_SIZE) {
>+                      dev_err(adev->dev, "Invalid IP discovery size: 0x%x=
\n",
>data_size);
[lijo]

This looks like validation of table entry. I think that's better done at th=
e place where you fill in table entries - amdgpu_virt_init_critical_region.

>+                      return -EINVAL;
>+              }
>+
>+              amdgpu_device_vram_access(adev,
>+                              (uint64_t)data_offset, (uint32_t *)binary,
>data_size, false);
[lijo]

There is no NULL check for the binary or validation of size. Better the siz=
e be taken always as in/out parameter.

>+              break;
>+
>+      case AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID:
>+              data_name =3D "BIOS";
>+              if (data_size > *size) {
>+                      dev_err(adev->dev, "Invalid vbios size: 0x%x\n",
>data_size);
>+                      return -EINVAL;
>+              }
>+
>+              buf =3D ioremap_wc(pci_resource_start(adev->pdev, 0) +
>data_offset,
>+data_size);
[lijo]

This doesn't look correct.  You just need to fill in the binary with amdgpu=
_device_vram_access().

Thanks,
Lijo

>+
>+              *(uint8_t __iomem **)binary =3D buf;
>+              *size =3D (uint64_t)data_size;
>+              break;
>+      }
>+
>+      dev_info(adev->dev,
>+              "Got %s info from dynamic crit_region_table at offset 0x%x
>with size of 0x%x bytes.\n",
>+              data_name, data_offset, data_size);
>+
>+      return 0;
>+}
>+
> void amdgpu_virt_init(struct amdgpu_device *adev)  {
>       bool is_sriov =3D false;
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>index f46edc03f57f..5d8e3260f677 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
>@@ -438,6 +438,8 @@ void amdgpu_virt_fini_data_exchange(struct
>amdgpu_device *adev);  void amdgpu_virt_init(struct amdgpu_device *adev);
>
> int amdgpu_virt_init_critical_region(struct amdgpu_device *adev);
>+int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
>+      int data_id, uint8_t *binary, uint64_t *size);
>
> bool amdgpu_virt_can_access_debugfs(struct amdgpu_device *adev);  int
>amdgpu_virt_enable_access_debugfs(struct amdgpu_device *adev);
>--
>2.34.1

