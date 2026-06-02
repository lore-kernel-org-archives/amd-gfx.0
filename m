Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481F4CD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 20:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DE7810F5B5;
	Tue,  2 Jun 2026 20:26:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O360j6SI";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 053B710F5B5
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 20:26:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYU673yG8cjz2ubHVyGmiFvFbTYHv8oW8GiNzHb5sSkbWOet5TRfHWwaV4RX/jEAaoO0TgxeutzjQ2A8QaEu9kzuczI/4+wFsb7PyRqCOB4HJNdJCW54Zrx0LuLZZxfHQ740Tqs7bUmpM/UMHjQ1PVr3uo7ZV6n6Q9GyVwrcodPy8WR+pbl5+1YgHkWbjhz4rs1byyfUQbPEmCZu4euqJ428dpAvtrOLRJL+w0AwcQsiCW0AebpzXSBpLKjP2JWMpur+c8dp5huXFDPz9kwq0NtFVbk2XecLVQgPt8UPod3tkHJ5daamtLdLOoiU+MyUGK/79FbXGHRdx+V3X+Giyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6e7GtWDN9F9BhvC0rnZWlTVPDp57Aes7Wh6UgnTxutA=;
 b=KXYIKm2PvZQqZatbtSJnQhG2vmgr59yulXInIsgTom7th1GWaF9qH64z9/lq9PbyRYdC3KWCzzKanKA8baoRKWEsYaparLTuedtaX0Rqaqt5wNd2EcjfKs3HIF2OqcsZvpO/ASBZxeQSkhRV5OCb2tYxl7TFcoVkps9Set2BcwndK4N+arxzNdrjgZ2M4UDPleSnyIagjK001AoDyQdY0+VVSw9ngwFTANnyJFw1bLvtw/E7cuchUQKRi1sk/H8vumip4Hw0DZ2FuqJzKJcfken/Mijy+8UoaDqru8jyR2u+nIcLPtKzqC1X38lK2GiZNmCQtVKgxF6iVw/2btDZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e7GtWDN9F9BhvC0rnZWlTVPDp57Aes7Wh6UgnTxutA=;
 b=O360j6SIxJzUlFOtIocUXT9w9MRSR7DBpz293EdIVyRWNYsqOmUd7So7HRRu9hCJNvZQtfOR/cNBc0Oa4xnbpI/ZG3Piea6NxheAEexKxZkjZmFT2z7dobfaInysw5I8aK1hKUnBDT6/iJiYeP6oQke7D76jWqAOHBJIpvbPMWg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Tue, 2 Jun 2026 20:26:38 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 20:26:38 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Khatri, Sunil" <Sunil.Khatri@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 1/3] drm/amdgpu: validate the mes firmware version for
 gfx11
Thread-Topic: [PATCH v2 1/3] drm/amdgpu: validate the mes firmware version for
 gfx11
Thread-Index: AQHc8r0Th+0dmQjfD0K9L0JjOke8MrYrtqI/
Date: Tue, 2 Jun 2026 20:26:38 +0000
Message-ID: <BL1PR12MB514431CC974614F82CFC27ABF7122@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260602182429.3543432-1-sunil.khatri@amd.com>
In-Reply-To: <20260602182429.3543432-1-sunil.khatri@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-02T20:26:37.783Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=1;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DM3PR12MB9392:EE_
x-ms-office365-filtering-correlation-id: be53e6f7-04f9-4d86-3d13-08dec0e53fc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099006|38070700021|8096899003;
x-microsoft-antispam-message-info: EbiB8ooFo6uHjXlqwk1GrCh9t4Q0NMTt0x/ir0spIDkctwmJcJRJGEKwx5Cz1qYitE7Oad5602e09muTxZ/luczjBIvyb92aDcHnT6rBLL9oRh7fKtO7/Y0WKuZiqm87KXPyaBrIL8lzt+wQ1dFi1Vf59hgrCCB4VXx0clh/R+n4p9aDL6wCfIt0QpeZcYAXNi+M8frM2DYgNT7iwVVGVdiuI+HmF3OnzsXoCZPzD4pFv4H6hxqdLrZflEe3qdsiP04wXetUN9rYvyw6/tDOgBa2zmoLcK3wufGyGtMbVdV+v3QPhBkGimrk4X9N8CNpFY6CXxcZYvtlOZu8Wis6KVbuyPT8I/PcaIyQ6NYAdyg18mMzyvRatWrDJrachTtVJJ9PNj6Pb9Ou6RrtmCgBdttxESKuNqB+XtNncZcUkI6sHdArJAOavPoa1nWgRVDCXXy6S179QqrZ9w7oeNWAXU4sfqS5IvOsNvJHRysacKpmShdFI/tIJOm7CRRt0LXk3ZPBF8g8MXrSOawDV8kSBDzzGvl457lXEhU/zzDSj1UhxEee5uz5s6BxZt+AiqWJ6FBCbqZywfzoHWB+2kxcFcCK4nmqgFi56/Te0EFi09cRWnPBnhA333b8pToqtOpQjiDqzVPScQfYnsku2408ggS/ugreqVNSXv+utZQjavsT439TjLr2t0ubUwlut9qIYEtbQFBgoS57xMBvh33Ima0ZmTGxmtwXs4wEcjXb/X1yxeT/6Ukz3Alwy7V6C7YC
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nUYkU9Qw/uTGvI+AvZuIllp+tHTozHb/6UAq/OVLOKfkp4HFa0rDqUTx//7k?=
 =?us-ascii?Q?bZ0Qi7PDV/2tMD7EIRMXXC0cvuNTq31u/hUhAN527g9/uReE1Vnagd81Xgd8?=
 =?us-ascii?Q?L74z80hKO6AGMDuNRZ8aJJ8/S3BWU+auQ6qZBpLn32XXdXmoYNbgpVPp6kXR?=
 =?us-ascii?Q?tUqg4QPilzyI3eM79O8LVg8d8iZs3F1puH7U+9IZDYthf6wSxMIbjlzxjZnD?=
 =?us-ascii?Q?wvQo92XLEtoORbxgx5EEuU5DaSiazbP4Z7VCTk0Rmyz4Pqn79upGhJVID+Te?=
 =?us-ascii?Q?/cgD+J+pzDW8WpobGyRKQQU/9b779xz4UL6VT0jNe8tuWCCJfTqwJyRTJ+DJ?=
 =?us-ascii?Q?yC24ifLGS0MGmUpzcE7qhmvZ8q5hINvEbfq5QFrkF5gu9Ewlc9O3/uBJB+ry?=
 =?us-ascii?Q?hmfd+c0u19+DF2O+fHNyt/l7QDpO0FZQ1MmhQD8U8s8LGHBgScPw60OjPpfw?=
 =?us-ascii?Q?CtyoC2qrKrJFZgP0zxa3mNYdyAKfU7ACUfWOw1OdFr7ZcqxmKyXQ3oIn9N23?=
 =?us-ascii?Q?VU+GMqNsRaqDmoeE9rEps3fQ9ApXSaMRzf3VlsgWBKWpZPTy2d+PKbvh2Rya?=
 =?us-ascii?Q?bysn6AB8bheZDOBL8UhtgG91Xz5MXBsrxrn3vrN4JF0IP1+2haXBQv89EGBp?=
 =?us-ascii?Q?1jMzFgrX1F4k+zJpzIV3xFHtpKnZ2BneOLnG8bY0VWD2E5SXAGbCB8WFRMx3?=
 =?us-ascii?Q?BfyYm1EjOtGc0dyozTl5G2iqgWDN7pEHg0wXQvWHo/NFLNlDIuJjy75L4Tbt?=
 =?us-ascii?Q?qHeM+NBo7BAEpG2J1AkWr12tjHNGUp9hMSsHjx+knNV4l5KvQ2a5Vc+rPnHf?=
 =?us-ascii?Q?XRL6ePJS8Oe3nOSofBtJAypvqoQ//J2E2q8Y4hcGh4TSNwf6S6JdtEz6H28T?=
 =?us-ascii?Q?CPLvOjEluum87t3nGL8qxqxQ+3Ads8Ygm1gpxc3HBkwe2OrmD65KZuBTFdCC?=
 =?us-ascii?Q?C0mpVa49letOh5zgN6rhWIJKcCRivyWqqEYJBnLiQUGW3YkvkPgWXzGQBqmK?=
 =?us-ascii?Q?510/zJe7csTXgwZrI3vZL05LwXMv2IO0D4zOgpGctstadNhFyCaCydLcI0gU?=
 =?us-ascii?Q?DFWF7kj3vZQbxs1xTt6nDymdDdgYuV6A3Dw9PzZWiLMaK3ayiAaQ/fbRxl1b?=
 =?us-ascii?Q?deVCcQIP5T0JMFQVn82vod774tgtRZzI69WK/x8+xkSsTsVzHXGysQtDLvIe?=
 =?us-ascii?Q?uP6oZrC8d65hD3BE4ITlHAtarEqwZAgc1rAFYf+At/hPyl//sdDq7j3Lx7ev?=
 =?us-ascii?Q?TKYMn5ZP5ErYlDUUTWSOltMXPQyo8FOuQKRIXbaSXq7MstZn7omRVnCazPhu?=
 =?us-ascii?Q?TJ94ThnyS2NIQwz3UXJozJNREHsW+ymVpIcDLu/L7wgxUhhiQKPJ9PRFWELX?=
 =?us-ascii?Q?YHFC+rGmcBIhaEKUtgF+3DE2UKAxTFTVZH/G8s19ZE686L3Oi/G9tv0vf8JI?=
 =?us-ascii?Q?lHrxK3SMOm/47sdHoK4dDG3JnnJWKH4tCAru9O1Zz7PlEuLQIsvH6sm9FbSQ?=
 =?us-ascii?Q?ehn5wjQStOWKEmTxRrThkeew2fj/lw2u+Poh1SCtWZLlXYf5cXf52xrNC5g7?=
 =?us-ascii?Q?0aLa2YbE7hM4P6eyXYMhR8DJDjmI5nlkX3+XwogcLZHrGnJcqngYJK6CYlyI?=
 =?us-ascii?Q?s8qnnOCmiAfEFp9cd2TOp8tYTO45ScJZXopsC0ydLjyCgJyA950e780H8cQ1?=
 =?us-ascii?Q?tNK4wfnfpisCOqxfSbxCsBR+1hxjTCYrUavpRppaEqBsAyn6?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514431CC974614F82CFC27ABF7122BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be53e6f7-04f9-4d86-3d13-08dec0e53fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 20:26:38.2257 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4dY9Ru22wJKuAZx3He31VX5WNUjeVM9d8tByXM07ugdLzZnzTcGj4QDa/I2WRHenWaAvA4ewUMaA9y3sV31OUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
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

--_000_BL1PR12MB514431CC974614F82CFC27ABF7122BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Public

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Sunil Khatri <sunil.khatri@amd.com>
Sent: Tuesday, June 2, 2026 2:24 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Khatri, =
Sunil <Sunil.Khatri@amd.com>
Subject: [PATCH v2 1/3] drm/amdgpu: validate the mes firmware version for g=
fx11

MES fw should report the fw version same either read from the
register or if read from the firmware ucode. That is not the
case for MES firmware and we add a warning in case it is not
same.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c
index c9467b26e42c..e3972673fd64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -781,6 +781,18 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *ad=
ev, int pipe)
         return r;
 }

+void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev)
+{
+       u32 fw_from_ucode =3D adev->mes.fw_version[AMDGPU_MES_SCHED_PIPE];
+       u32 fw_from_reg =3D adev->mes.sched_version & AMDGPU_MES_VERSION_MA=
SK;
+
+       if (fw_from_ucode !=3D fw_from_reg)
+               dev_info(adev->dev,
+                        "MES firmware reports incorrect version in ucode b=
inary (0x%x vs 0x%x)\n",
+                        fw_from_ucode, fw_from_reg);
+}
+
+
 bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
 {
         uint32_t mes_rev =3D adev->mes.sched_version & AMDGPU_MES_VERSION_=
MASK;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h
index 93990d4990f2..fdd06a17520a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -441,6 +441,7 @@ struct amdgpu_mes_funcs {
         (adev)->mes.kiq_hw_fini((adev), (xcc_id))

 int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);
+void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);
 int amdgpu_mes_init(struct amdgpu_device *adev);
 void amdgpu_mes_fini(struct amdgpu_device *adev);

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c
index a926a330700e..0db378d126fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -1686,6 +1686,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)
         if (r)
                 goto failure;

+       amdgpu_mes_validate_fw_version(adev);
 out:
         /*
          * Disable KIQ ring usage from the driver once MES is enabled.
--
2.34.1


--_000_BL1PR12MB514431CC974614F82CFC27ABF7122BL1PR12MB5144namp_
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
Public</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sunil Khatri &lt;suni=
l.khatri@amd.com&gt;<br>
<b>Sent:</b> Tuesday, June 2, 2026 2:24 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Khatri, Sunil &lt;Sunil.Khatri@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2 1/3] drm/amdgpu: validate the mes firmware versio=
n for gfx11</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">MES fw should report the fw version same either re=
ad from the<br>
register or if read from the firmware ucode. That is not the<br>
case for MES firmware and we add a warning in case it is not<br>
same.<br>
<br>
Signed-off-by: Sunil Khatri &lt;sunil.khatri@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |&nbsp; 1 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mes_v11_0.c&nbsp; |&nbsp; 1 +<br>
&nbsp;3 files changed, 14 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.c<br>
index c9467b26e42c..e3972673fd64 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c<br>
@@ -781,6 +781,18 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *ad=
ev, int pipe)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;}<br>
&nbsp;<br>
+void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 fw_from_ucode =3D adev-&gt;mes.fw=
_version[AMDGPU_MES_SCHED_PIPE];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 fw_from_reg =3D adev-&gt;mes.sche=
d_version &amp; AMDGPU_MES_VERSION_MASK;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fw_from_ucode !=3D fw_from_reg)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;MES =
firmware reports incorrect version in ucode binary (0x%x vs 0x%x)\n&quot;,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_from_uc=
ode, fw_from_reg);<br>
+}<br>
+<br>
+<br>
&nbsp;bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *ad=
ev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t mes_rev =3D adev-=
&gt;mes.sched_version &amp; AMDGPU_MES_VERSION_MASK;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_mes.h<br>
index 93990d4990f2..fdd06a17520a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h<br>
@@ -441,6 +441,7 @@ struct amdgpu_mes_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev)-&gt;mes.kiq_hw_fini=
((adev), (xcc_id))<br>
&nbsp;<br>
&nbsp;int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe);<=
br>
+void amdgpu_mes_validate_fw_version(struct amdgpu_device *adev);<br>
&nbsp;int amdgpu_mes_init(struct amdgpu_device *adev);<br>
&nbsp;void amdgpu_mes_fini(struct amdgpu_device *adev);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v11_0.c<br>
index a926a330700e..0db378d126fb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c<br>
@@ -1686,6 +1686,7 @@ static int mes_v11_0_hw_init(struct amdgpu_ip_block *=
ip_block)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failure;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_mes_validate_fw_version(adev);=
<br>
&nbsp;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Disable KIQ ring u=
sage from the driver once MES is enabled.<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BL1PR12MB514431CC974614F82CFC27ABF7122BL1PR12MB5144namp_--
