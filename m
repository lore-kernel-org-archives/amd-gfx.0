Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFFFCD4F5B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 02:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC61D10E412;
	Wed, 20 May 2026 02:46:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rADRXbFq";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010002.outbound.protection.outlook.com
 [40.93.198.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9EB10E412
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 02:46:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMDPQlfDocAHxf/YYA+f4AqzIcqIQDdJB+E6fhZljPbAQ1Ithxy1sPpeTuoJ8/tg+xcx+8cTUyZI6Os2tE1VcOQqwnEeuU2KenU3mCMDMNSt1K6Y068Y5UY2GJSWNnxYFZbCoPsCZlMvGAYsxxze+jfLNVgqvvO2nH9hwXCiYNC/ACWvgoVG+AAWzN2zvlQwGbqg3IPWWRb5AEV0AdK0HZ3sFtw/dd+HNKmPApc+qhtfpEGIb4SMP4nq1CjFpHcN/TWW72DK8R1J4FZ+y5BpB35vXtohSN0qsKnDsUrDzFWN5UK/7RWhUctTQSYZJeNuJmUCPBq55tsDqiNpmN1tig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blGnsgKwy/+Z73B7uJ89Ni0YReMWsvjCDzXq+dF0CDQ=;
 b=JgoFjbMu3xMQIV6TJGxGzEVYz6jjGmT8N53+pa2smdxLAtTUvGrPFOg/tJOfqlAoS3/Ns0MDuvdi2H7ANLnhfBnOQfad+gcR5qXI4gkKejB8JxzEngvoDjB6+Wae48/byEoHlmU+vr9ivXyRormOYM69vETw1JOhk7n4uRL3sE4e3Gov28ReNf2RAQB6GaoZ0NzqQXdbM1N5PviBv3jeH7qyXEC6SeOjeCQtrDJXIhBhQZguzyGUN4MnHAr/ELU1iJ5IoXHm2CRk0brIzfr9M5u1eKryqtaogKCWyrwqMW28oqx5gbtNI1+JaTCcwHLw/6HqnM+sFyZlcq0r4dg35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=blGnsgKwy/+Z73B7uJ89Ni0YReMWsvjCDzXq+dF0CDQ=;
 b=rADRXbFqj0suwxCHCpgbMkCqtBWUJcQXK9jk0nzeGVP/7uZMLEWKpPx0X3L6u1Uzyd0vjqv3c7rq+3AKRwZ6Z5A69iWAg1gEE0RVLzwPJnEwNa5+PN1moDBeDPpj2OUNRwn3LUX7ifn0Zwx/lZPceTCxkzjVBoUMZD9qtzD9eDw=
Received: from BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12)
 by LV3PR12MB9257.namprd12.prod.outlook.com (2603:10b6:408:1b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 02:46:07 +0000
Received: from BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d]) by BN9PR12MB5306.namprd12.prod.outlook.com
 ([fe80::9976:3768:a636:3c3d%2]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 02:46:07 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu: bound SR-IOV RAS CPER dump parsing against
 used_size
Thread-Topic: [PATCH] drm/amdgpu: bound SR-IOV RAS CPER dump parsing against
 used_size
Thread-Index: AQHc4Xx4OYM2aei9yUqsfjYtLyiNgLYWQpRY
Date: Wed, 20 May 2026 02:46:07 +0000
Message-ID: <BN9PR12MB5306B4A5A68B40588A0D0F2AFC012@BN9PR12MB5306.namprd12.prod.outlook.com>
References: <20260511192912.55862-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260511192912.55862-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-20T02:46:06.638Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5306:EE_|LV3PR12MB9257:EE_
x-ms-office365-filtering-correlation-id: e4cdc527-615e-4d52-81e4-08deb619f13d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|8096899003|11063799006|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info: TZdjaLYM+40gC0MAaMn6plYsz6LVYzZab/QUOsgsDzRwX/Sw/AcRb/eziTQDBZnUEOb24K+8HkDCy2d6dgE4Ha/5zT7JZi/VY+qvU5PS++cRxRLTFew+2ZRY0ER4+mAoBqO/wqhLYtFSbqwemx781sir0eDfRSFF/oZUNZBRlalamrBtKokG8h1SlafI1sKPsI2MXdGk4ozoO9nU7YVF/ohU1J7HAFebe2/VnyReyoRduL2uKTKjhcWbQsGwtflMtpXQg+RbelJFxhtZsxgiPb8PhWGtZalYffGNaTO2zBVnveoysvvLbpru2z42ZwwLaKkmHChwLTFKmn8LYpw9TWU5OGSjHGXwZfxCG8JV6fkjIG5Rs42CqSZcxLr+h8nuhcI3uaIUHnW4Rs0sku7/2lkZQFF1j64TrhbFuFoUT+VQ2g4tHU69ZIzdLYZzgsVC75eHymAVHVNkefRKQImqdvcKJZPQiStSihs5Ha0vPsjWP5xRMpe/fc9E0hLXNt6hGnMtiATb3QG4zOPUckBmaFdMmNS6b/gdm+S2hvJJCbKGlrAsFbt4ekrpt1hJ/4rzrkxrNGYBOJTxeV0RPzA646QPx0Y8tPikZsvwkFrPHHGJf37irg33k3rMudU6Ec/8tSxV7vFY6meBP4w3gzXFWmFDBRgZIOaE0uV8qCob/VwXsBN+lNlQUMo6PZOg8Wck5zNmhwvIHUMnkNBmqGtsL9lXC+Wlhn/5ndsys0JTJPGPz7uvIiNlbKmEIrJbnFgx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5306.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(8096899003)(11063799006)(22082099003)(18002099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3bnWBGlMFTK2iqRESdPv0qk1gZhpeRpsqK6GQJEBZ8d7itWEqFcVEMTGNP26?=
 =?us-ascii?Q?oZByXQibnbDO37+4TSuA1e+P1Pans/ZcZQBNiaA/kG53+e+Z7ABe761HEbUI?=
 =?us-ascii?Q?rcx9BbvoTflxSf0m/JbAh6UTPY1PRvU0TrmIGbnQTbeIs0Rgihw4JowUP1Lf?=
 =?us-ascii?Q?wP7CApOnwDrLLxHvcIQ9nKTJ+2rgYMcDWXYgRM+R5N2/VZdKthL+MkcD32G/?=
 =?us-ascii?Q?47Q29thxrhN6jnFkvf4p0dJUNa20pY92APS19zYQlY5Ffa00tyvN+b3WSsYL?=
 =?us-ascii?Q?ZKDLWMq9lqRPQVqVXg1iasiCeCpPpKx4GTNsA7sN/0Ib21WlvtianCOdTpYb?=
 =?us-ascii?Q?leZGpzlKvNqx102BrQxBueW5AomYOfL5ppYv+9BL+A0AeRlUKudqb8HalDf8?=
 =?us-ascii?Q?K82a7B/BG1x5OIOUyH0QvA3psekS+J+cdiogN2ury2MMPAhNem9hEsOlved0?=
 =?us-ascii?Q?ieo0xw0k9A9suSRBG09KPaMAs9MnnLyPthlK/+x3nv5tmv5QJN9L5rZofC3F?=
 =?us-ascii?Q?1ymJh6Da+CoP6d3NLiCYbfFjSgrWcwUkZhipyZ5MamwCxpqnb0VyjPi05/wg?=
 =?us-ascii?Q?r0+Qxh/xvk1cq5HeqLf/zpIRZw6WKjqAWuy8Opxb3lcssSF8JEe6f7gxZqYa?=
 =?us-ascii?Q?7Aeqjjg1kUhXwxC5KAMuVfDfwDkvO98z5JzXW2PVtQNhvy2ROSFXeLaGQ6rQ?=
 =?us-ascii?Q?ovE05xO9yfYFqrw5jzJFYa+nlJDTYnZf41+2fyBjA4T4vzwkduiP901YVh81?=
 =?us-ascii?Q?CyELCl2U9NSXfPebYK3Zs6BYJ2+10vN9FMvgwML07/S9uHhhT1uiCn9TGDgj?=
 =?us-ascii?Q?eCJAWFMClF8pQqdxe09ApzoTtdMu1qlJ4/XTGt5e4z1mK2hrhyU/HYnG4NO0?=
 =?us-ascii?Q?sIfnRJXEDKt9ZdHvGjEMqQ2jlAZj0VbC7sqwVomDedqpkO3P7iKKPp4ja3l4?=
 =?us-ascii?Q?GslT7w8kzZZ3VvdZgTi2d1euRoJNlhy86RgP8jt1pXc3Pju9bUNRp5RPoEew?=
 =?us-ascii?Q?EqchAbnyzzsI56y3U7YarnpITIjORo6Dizg9RG6f0WjG7/BRkjTkmKqg+KvL?=
 =?us-ascii?Q?fBhbBts2o9/pHtAUQyINnqlKLhKIwxOHJG3DHk/Pvcjy34WwfwTgOrZRccwU?=
 =?us-ascii?Q?2EW0Wqpup2zJmeESPuWjjhOYEFxx5aFosOFAvm6jR4lSwyh1kc2zf/Gmlsiy?=
 =?us-ascii?Q?isfwm/0T59i+BoZqSWnOKDUwdm2DO+XrO7H++gjszkHxAt+UjOdA+dA//kli?=
 =?us-ascii?Q?Cf+bM8nINtsOEy08jG2u/qKSE0CGl84q8COjPY/xsR/um2Es0tfRmLpWrD9I?=
 =?us-ascii?Q?0+4AdXKy3UooXeWyn+HHcb6zBu+5bZby5WzR8rFj8BIkoYujV0ojfR1Y96xl?=
 =?us-ascii?Q?GLF+UD31UnOGHQltgqmIqADWubbGZyzaVvPCpRSD3DZGNWVnuCMOuRN7mqBL?=
 =?us-ascii?Q?nE7vVuRKhzq+wrwnpNce3CB23RT+uEAiCTVrKE5syTfyAykKf4MizN/GgFI/?=
 =?us-ascii?Q?9JPhWvymyxMfivvZHhVVpF5hf2SIqd6nlBkaazd1jTEN3Mg5CRLcsZwUy1Tk?=
 =?us-ascii?Q?bOgjUwqeczvynzq1PhGpARdgekUC9tIoB1g03VgLNM7QZRM4378CTHqRrzZ+?=
 =?us-ascii?Q?uYKAq9j065OkhmPePhoOFTcN+ou/DeoEwdZCPwKlUOGGlgaKTFEYfK2+0xxR?=
 =?us-ascii?Q?uZ38Io2Xxce0tX9mPT1Iymun8uwXEuK89Qm8EVqxTE+bTDp6?=
Content-Type: multipart/alternative;
 boundary="_000_BN9PR12MB5306B4A5A68B40588A0D0F2AFC012BN9PR12MB5306namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5306.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cdc527-615e-4d52-81e4-08deb619f13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 02:46:07.0765 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0o7RMTNBzaqqeMBCIiut+Sp/+TidSOHjioGuJvNkkdANgeEqep9wsq+iussJAK80X3KDN+dZ5KewAb0fzOtqVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9257
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

--_000_BN9PR12MB5306B4A5A68B40588A0D0F2AFC012BN9PR12MB5306namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Reviewed-by: YiPeng Chai <YiPeng.Chai@amd.com>

Best Regards,
Thomas
________________________________
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Tuesday, May 12, 2026 3:29 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: [PATCH] drm/amdgpu: bound SR-IOV RAS CPER dump parsing against use=
d_size

The VF copies a PF-provided CPER telemetry blob and walks records using
cper_dump->count and each entry's record_length. count is u64 while the
loop used u32, so a large count could loop indefinitely. record_length was
not limited to the kmemdup'd region, so the first iteration could read far
past the allocation; record_length =3D=3D 0 could spin forever on the same
entry. Together that allowed a malicious hypervisor to leak heap past the
blob into the CPER ring or hang the guest.

Require used_size to cover the fixed header before buf and stay within the
telemetry cap. Track remaining bytes in buf, cap iterations with u64 and
CPER_MAX_ALLOWED_COUNT, and reject record_length outside
[sizeof(cper_hdr), remaining] before writing to the ring.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: Ic21f4523eebc6c4b4f8c6b62b84104b18cf86a48
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..c8bec62bdffb2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1798,13 +1798,15 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
         struct amd_sriov_ras_cper_dump *cper_dump =3D NULL;
         struct cper_hdr *entry =3D NULL;
         struct amdgpu_ring *ring =3D &adev->cper.ring_buf;
-       uint32_t checksum, used_size, i;
+       uint32_t checksum, used_size;
+       u64 remaining, cnt, i;
         int ret =3D 0;

         checksum =3D host_telemetry->header.checksum;
         used_size =3D host_telemetry->header.used_size;

-       if (used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
+       if (used_size < offsetof(struct amd_sriov_ras_cper_dump, buf) ||
+           used_size > (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 << 10))
                 return -EINVAL;

         cper_dump =3D kmemdup(&host_telemetry->body.cper_dump, used_size, =
GFP_KERNEL);
@@ -1829,11 +1831,19 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,
         }

         entry =3D (struct cper_hdr *)&cper_dump->buf[0];
+       remaining =3D (u64)used_size - offsetof(struct amd_sriov_ras_cper_d=
ump, buf);
+       cnt =3D min_t(u64, cper_dump->count, CPER_MAX_ALLOWED_COUNT);
+
+       for (i =3D 0; i < cnt; i++) {
+               if (entry->record_length < sizeof(struct cper_hdr) ||
+                   entry->record_length > remaining) {
+                       ret =3D -EINVAL;
+                       goto out;
+               }

-       for (i =3D 0; i < cper_dump->count; i++) {
                 amdgpu_cper_ring_write(ring, entry, entry->record_length);
-               entry =3D (struct cper_hdr *)((char *)entry +
-                                           entry->record_length);
+               remaining -=3D entry->record_length;
+               entry =3D (struct cper_hdr *)((char *)entry + entry->record=
_length);
         }

         if (cper_dump->overflow_count)
--
2.34.1


--_000_BN9PR12MB5306B4A5A68B40588A0D0F2AFC012BN9PR12MB5306namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: YiPeng Chai &lt;YiPeng.Chai@amd.com&gt;</div>
<div id=3D"Signature" class=3D"elementToProof">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, sans-serif; font=
-size: 11pt; color: rgb(0, 0, 0);">
Best Regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, sans-serif; font=
-size: 11pt; color: rgb(0, 0, 0);">
Thomas</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Xie, Chenglei &lt;Che=
nglei.Xie@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 12, 2026 3:29 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Chan, Hing Pong &lt;Jeffrey.Chan@amd.com&gt;; Luo, Zhigang &lt;Z=
higang.Luo@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt=
;; Xie, Chenglei &lt;Chenglei.Xie@amd.com&gt;; Chai, Thomas &lt;YiPeng.Chai=
@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: bound SR-IOV RAS CPER dump parsing agai=
nst used_size</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The VF copies a PF-provided CPER telemetry blob an=
d walks records using<br>
cper_dump-&gt;count and each entry's record_length. count is u64 while the<=
br>
loop used u32, so a large count could loop indefinitely. record_length was<=
br>
not limited to the kmemdup'd region, so the first iteration could read far<=
br>
past the allocation; record_length =3D=3D 0 could spin forever on the same<=
br>
entry. Together that allowed a malicious hypervisor to leak heap past the<b=
r>
blob into the CPER ring or hang the guest.<br>
<br>
Require used_size to cover the fixed header before buf and stay within the<=
br>
telemetry cap. Track remaining bytes in buf, cap iterations with u64 and<br=
>
CPER_MAX_ALLOWED_COUNT, and reject record_length outside<br>
[sizeof(cper_hdr), remaining] before writing to the ring.<br>
<br>
Signed-off-by: Chenglei Xie &lt;Chenglei.Xie@amd.com&gt;<br>
Change-Id: Ic21f4523eebc6c4b4f8c6b62b84104b18cf86a48<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 20 +++++++++++++++-----<br=
>
&nbsp;1 file changed, 15 insertions(+), 5 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c<br>
index 6974b1c5b56c2..c8bec62bdffb2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c<br>
@@ -1798,13 +1798,15 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd_sriov_ras_cper_=
dump *cper_dump =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cper_hdr *entry =3D=
 NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
=3D &amp;adev-&gt;cper.ring_buf;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum, used_size, i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t checksum, used_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 remaining, cnt, i;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; checksum =3D host_telemetr=
y-&gt;header.checksum;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used_size =3D host_telemet=
ry-&gt;header.used_size;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used_size &gt; (AMD_SRIOV_MSG_RAS=
_TELEMETRY_SIZE_KB_V1 &lt;&lt; 10))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (used_size &lt; offsetof(struct am=
d_sriov_ras_cper_dump, buf) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; used_size &gt=
; (AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1 &lt;&lt; 10))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cper_dump =3D kmemdup(&amp=
;host_telemetry-&gt;body.cper_dump, used_size, GFP_KERNEL);<br>
@@ -1829,11 +1831,19 @@ amdgpu_virt_write_cpers_to_ring(struct amdgpu_devic=
e *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry =3D (struct cper_hdr=
 *)&amp;cper_dump-&gt;buf[0];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; remaining =3D (u64)used_size - offset=
of(struct amd_sriov_ras_cper_dump, buf);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cnt =3D min_t(u64, cper_dump-&gt;coun=
t, CPER_MAX_ALLOWED_COUNT);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; cnt; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (entry-&gt;record_length &lt; sizeof(struct cper_hdr) ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;record_length &gt; remaining) =
{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D -EINVAL;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; cper_dump-&gt;co=
unt; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_cper_ring_write(ring, entry, entry-&gt;record_=
length);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; entry =3D (struct cper_hdr *)((char *)entry +<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; entry-&gt;record_length);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; remaining -=3D entry-&gt;record_length;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; entry =3D (struct cper_hdr *)((char *)entry + entry-&gt;record_l=
ength);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cper_dump-&gt;overflow=
_count)<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN9PR12MB5306B4A5A68B40588A0D0F2AFC012BN9PR12MB5306namp_--
