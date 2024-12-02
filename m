Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D271BD4979F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 06:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8642310E1DA;
	Mon,  2 Dec 2024 06:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QRE41n+T";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC4E10E1DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 06:14:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsjB5SW+/pmyeh8yZXOpN87mY72LoxpuTRq4ged7r/4fmM2G8rpDt8ysZehZfxRcULJcTeIP0nFSGPg4l7IGqhQrYPi9bew6SHrtRagLktKNJlEz1eHaU3QF+81QwXx3YekkgDGJ7Byx0H0KJXd09rKXthkSFkKHmX51n+P3uJYwU9s2WzJhVWg0FGBovK1Gjy0ywZY0yS7y/g2R/8b3g3fK0QfWgPMGaslSoADsKPXk4frU1HO25KxSGCP1DXyiIGN90sXcTiKa4meqkjiNUxL+Drk8bMQvqblKiKc8m2HKJmi/1xNoCWthsngG6vxu/i0DK5RJFCAwjLW1gk022w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov0u13CjW6PW+tmaIwTfG5bi+PAYcOG/hj18rAEuY34=;
 b=AlnW2KKSwGGnWT+tY40wVSyVAn/76AWUnfbUzPUNF7Aji0EMGPALew3+vSyPmDYeZV29fODjez7cJ9xAk+OX4cmF9ukbjD4MULFb5QOkmTlZfXZoBPI8+nNB0D5tvgTNw7GjApRN41KGWhv5Gic1eJ0uEfhX+L7521DjZxDus78VhUY+NdH8zvmLkyqAk1PsntQe44mepOPPIrthZghZugl6AGmvpuMVIbtJpr3WVDatWJKwWdSpYvKo0MCfPEHx/WfUif5MF/N8kvcx+vf3FMPAU4bGHpsT2tqSGf9XE+LPqIBTBfeUGl/Nh9hv8YEmMHKDIsiVu9C8clHHOqVr5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov0u13CjW6PW+tmaIwTfG5bi+PAYcOG/hj18rAEuY34=;
 b=QRE41n+TFOWxuzjIVTUFLlLn5hFwF+eos+qQY5Mhm4X7DQeJ1sFLgml5+8u3Vd1/nec7i3v8rFlRjAhzziTQccWNJ8kEXmmeJZg/SREl5MXCo+Hl27pGAaKxIqgBa96WzxENVSVuFmmN7M4KK9qx982UoLQVUSO6t3FJt5N1/tI=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DM4PR12MB6472.namprd12.prod.outlook.com (2603:10b6:8:bc::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Mon, 2 Dec 2024 06:14:13 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%6]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 06:14:13 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Thread-Topic: [PATCH] drm/amdgpu: return error when eeprom checksum failed
Thread-Index: AQHbRHtAm+qxpkuv60+Ycrw1PINMkbLSdBPQgAAESxA=
Date: Mon, 2 Dec 2024 06:14:12 +0000
Message-ID: <BN9PR12MB52573AE0D13ED21B0FC01C86FC352@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20241202052945.7303-1-jinzhou.su@amd.com>
 <BN9PR12MB5257A530EE46FF0C44C08239FC352@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257A530EE46FF0C44C08239FC352@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=7525017c-c273-4d6d-a23f-8d21c118582f;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-02T05:53:32Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DM4PR12MB6472:EE_
x-ms-office365-filtering-correlation-id: 316650bf-ed09-40c1-a9a8-08dd12988ad5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?D4dtQW0AScYW34dELQXgfFdd3/8nV4N6Co6ev+T1a1JS5ljC1mYv9rPmTNq7?=
 =?us-ascii?Q?3dxWyS30TloN3Xfego3RZptaB9ng4wQCeJcZNsnIMkyh7t8jJID63Tqmw/Pb?=
 =?us-ascii?Q?bN+IGF8adu7MoJy1uawgszqr+JJD6btlr0UmHqT2Pa+6Lo0Ddk8iuMmizNt0?=
 =?us-ascii?Q?OwuQjJ5zZnBfk4sReWoGN3LjuBc6WVgWkzY2W01cLv5/ipTuawnbctrRN4Ai?=
 =?us-ascii?Q?EoKp+I2afcXTU6UFiavN7J/z+rJbftDu8euyGug0PdJFGmtK+wvm/6MrIfaC?=
 =?us-ascii?Q?IpIeGs8GnxRf0ILtz4+pkMar+nxGKNEkciyYQUQAE7+BWMoQId895dCpOFDA?=
 =?us-ascii?Q?czbq1+4H484nGRekDegKzF9LhumTtOYJvCGRgEN9L89x/vGQdRiiB2LABjGj?=
 =?us-ascii?Q?PZnCNNURGJayYMXV5q/+4Wzy0u+4i7djJtIQkFfp6v82E/cfa4BAinC05PUs?=
 =?us-ascii?Q?rQ9fFPpMvf32WQpweY7ORdRKdGmfH3XKmE3ENfrZPATy3aalwNteVi7/ztsq?=
 =?us-ascii?Q?EhgxMsIyvZML19r3dRkT96Y7cgZCNOzGq1LcYcUnxVIlhSCyy8JsZDpZbs35?=
 =?us-ascii?Q?+ihDM5fVOy0MoRAxeqRW/bwhipZVcsSu5CwYBeAtMPM5X4DHdMLR1qCuL/zK?=
 =?us-ascii?Q?mlRPmuBvU0nchI3gRXlfRdMTCsKQsvcb0Suq+j6QBJACjD3QNtGX2AvmoQYF?=
 =?us-ascii?Q?mqSI6lyMr/jdzL335Lo9Q9zce5WyvdwiVCpRWarceGRVRXIMWmms4k6Fq2/D?=
 =?us-ascii?Q?KjNg34iBi4uZxRHagDvqnCaVbx4axnGvbr7qTZcW54S2NzzXfaayWgQVChe1?=
 =?us-ascii?Q?Sk393vkcFIj7qt0GsjIKjoY3NlkBE5F14/BnkPaayh664HR9PE8ylFMRB2/H?=
 =?us-ascii?Q?7cS3HU+8IMdMsyAy9X8S4XSjZjn/J1vET/nQ0VWdmDqHvkXuoLMXKZxIB+oj?=
 =?us-ascii?Q?MlyXJPunEHtX9WPIdMGWdIzKJXhTzc6imP6MwSymClBHAT1kB598L7WZhJcU?=
 =?us-ascii?Q?ueU5GuRDlvfIsGCFeziXLh1miULGSYSQZskoGqPsslJEDYSEd2g9ix9oRkog?=
 =?us-ascii?Q?RuqRiN3r4DGkdjmFwkPAR+0PST8QnKjokYh4fJ6Ettiv3vOlkFNhm3N4WUKg?=
 =?us-ascii?Q?YQqIznK4hpOz46HRToXIKmg9bOgQy4wSFONlEytPO5gBd8TtrgICE4ZVfO19?=
 =?us-ascii?Q?LBEdT6GvW2RTPZbXPEPeUm58UPZs/bapLSiF5J4eNqQi6GMe7gZnDbW8phzG?=
 =?us-ascii?Q?35+eTZcDndxgoR5Z9M8HutVctsjL+oEY+7V4OhfRZpZjiKT7IIKQMbGb6wat?=
 =?us-ascii?Q?2UOJKP0aZYa6cGh8JDHrNVWRTxEsMfx/nMph0ywBpoce2dAzNMivAuelIgaj?=
 =?us-ascii?Q?kbiarALvPTlkWKMpLjhBf9K4steuhERZ9nzBk38tIV29BoNqmQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aHt25LGDe1PduKDsWbUrp6yH9YbE5KT917iCnC0YpfFwXKzDDIJEtL++vNzA?=
 =?us-ascii?Q?FSMVR3/B70910HPQnkgbPjJfPz5wpfqKfNs3PtRgumJl+mUjVrxd0iHb+RBr?=
 =?us-ascii?Q?5Frjhyd9tlM/kdkoEp3jSQM22yfoDkTYpCJLMCEvO7lyibQV0canc/qg0ATP?=
 =?us-ascii?Q?Ok46qwKxAHm+f7exB0P5+aIbCeRD5VF/PN4tlNYwgDCA06DxqO/ts8Ogtdai?=
 =?us-ascii?Q?JC1wPzljOI0PQcnpd61KCzUzVuV4TZfv9dQskl/MXYH8j243R78ujREltJAU?=
 =?us-ascii?Q?k7W33vru3IyD79d3A4VWtnB+qZ2D34OzOK9vpUWrpZ10Bt150Xv+AIOKIX9i?=
 =?us-ascii?Q?TNCxdsiNpftBo6FM/R8S8gEyarDPlT87UTPg0L9FIO8oaMsWn9JBzn/KmD2Q?=
 =?us-ascii?Q?tP3aO78pSOFBvpQMHVaP1ArLurbEqciaDWOkAk6Ktk5R7N+J5uxcN5kxh7si?=
 =?us-ascii?Q?NRIkdw6lRn3JJhXtwnr2jTqbCJihkoLXG66SBAoHDOWXKRVLj41A2Z2XDTot?=
 =?us-ascii?Q?TOKvX43t35TK7k18dMY8Ttshpa09ZoiSs8bMIfXFz931A8q4zzUayiLGHT32?=
 =?us-ascii?Q?Jzi80/X4rMZZIvUn7TNWjSTC+yQdVEu7b+yiBB8e61kdO+ilyrA/Fotz+Cpq?=
 =?us-ascii?Q?KJClLl3e56B+YpmKh7dpJje1IwcB6Ix6pfX10QpocT8WVXE5TZ6xD2GOTkcs?=
 =?us-ascii?Q?4gmT1e8uIFgyEgDNu9inpeuLE5+qXCW2pHm+1GS4DSQLj5qCNyv2Fue2KNDk?=
 =?us-ascii?Q?rqINvbmLQzTAgzt/NdWgXEKgbfzpbEo1Cgyayn7C+CysrIoaiEBVilcBGDqp?=
 =?us-ascii?Q?C7lY+c24hNDVWSpsxYuozgaAeGq7/NCHwX1F+UAebeQzcHkPAS/Bf665KWVl?=
 =?us-ascii?Q?08nUraC7VfF+pNTBK3l0QgmOT6bGuoTzWl+uZN+kqiS+O9FE8CBVn6X/KmnS?=
 =?us-ascii?Q?9oH2PYLCstTwMEIS9O2TVd8swXuFCzTyZmspur/TzUKL9zBh4Ahx21lf9STw?=
 =?us-ascii?Q?TDvWBuPm+1uEy/VraOcdBsK1jePElOmRR4yFg3CcnWk7a051WSwQBURh5rsJ?=
 =?us-ascii?Q?tdYtNja9mgf2ZI5jbszMsQVh/i67nKRTrurEHHo8+flaoiuEgvg+Km7XbSbt?=
 =?us-ascii?Q?93wMXKaLLCE2vcIZNni48jKxemReJvW2LxmeFKDzq0UA4/oLKei5URqaMDT8?=
 =?us-ascii?Q?Bx6So71PEUsK4jk+NGYKirxDWzHDRVPyuRQ6ERMQBsqvd1Xxx64mJS8BQx2M?=
 =?us-ascii?Q?e5XFclwC5qk1JpSr6I+z8Whn50wAOuhe2SXEEk9V5HYEFVMR5gDgNfxjcNly?=
 =?us-ascii?Q?Kh3uboabu0kgmZSoPQqHnF8RZd6XcB+xodnSZGXpQjA3KHAMKNc/DulvYVpo?=
 =?us-ascii?Q?5Sv8axQUJOSkxIONMgGkHGIszROm4wPC5PbYuaNDczy2ZRNLBnrrgQUmxJHj?=
 =?us-ascii?Q?S/tUGVA/eShL2H8Xae+c8zyxuyzpUS90hEnmiILoWRboh5aWRxncIEp6iaEb?=
 =?us-ascii?Q?jHVW1VrRq4KZpAHbCl5ZinFxJ7AkKb7gZVouIn7KMPMAxGDlaOnchNECmQgw?=
 =?us-ascii?Q?51Tkty/0DYI920+2FwI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316650bf-ed09-40c1-a9a8-08dd12988ad5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 06:14:12.9561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1vOOwr+mUvVvYmQsEddHAYz+1cA6w0XI47mVUsDpD7iaKCedRjmMWbP8o5t/jkxwMTTijPEbaF91WibCPvL9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6472
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

Ah, hold on please. I assume even the BADG is written to headers. There are=
 still valid eeprom record available in the eeprom, right?

Regards,
Hawking

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, H=
awking
Sent: Monday, December 2, 2024 1:54 PM
To: Su, Joe <Jinzhou.Su@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: return error when eeprom checksum failed

[AMD Official Use Only - AMD Internal Distribution Only]

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Su, Joe <Jinzhou.Su@amd.com>
Sent: Monday, December 2, 2024 13:30
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd=
.com>; Su, Joe <Jinzhou.Su@amd.com>
Subject: [PATCH] drm/amdgpu: return error when eeprom checksum failed

Return eeprom table checksum error result, otherwise it might be overwritte=
n by next call.

V2: replace DRM_ERROR with dev_err

Signed-off-by: Jinzhou Su <jinzhou.su@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ras_eeprom.c
index f4a9e15389ae..bd8acb55f76f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -1412,9 +1412,11 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_=
control *control)
                }

                res =3D __verify_ras_table_checksum(control);
-               if (res)
-                       DRM_ERROR("RAS Table incorrect checksum or error:%d=
\n",
+               if (res) {
+                       dev_err(adev->dev, "RAS Table incorrect checksum or=
 error:%d\n",
                                  res);
+                       return -EINVAL;
+               }
                if (ras->bad_page_cnt_threshold > control->ras_num_recs) {
                        /* This means that, the threshold was increased sin=
ce
                         * the last time the system was booted, and now,
--
2.43.0

