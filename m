Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D7D10F92E9
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 18:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445B410E9D9;
	Tue, 31 Mar 2026 18:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="azGJSOrr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013046.outbound.protection.outlook.com
 [40.93.196.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F5810E9CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 18:18:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMot2nTxdJP6gOHWpCPm4crCHdOzofo+2oe8zq4y/5nyjP0SDJiRa78t5pYdGHpxEsuxdvuKoOnIcIYtixGMkaj9JVrTaRst6y13m0TDz4IGXaR5lfb2Cf5W8Rb4FbUKNJBl3rxRXVZjiOBsxM/Zg/EIGuzyGpFEib48kND+x+EaQDqeWfHpVnoHTEz0kIsrfSajD41b2tZSuqJFmhzEPFhrpq+15PMyyVS+N9UTrMRJKFm6yap5aYyWqKTirZuV+nzT3/uJ2/FZy+o33zTxZfNaMSuSaZlL7OyBKZVscEPvTtE9PHUJDwUrhvPdWucwxggCxUb8ywp8ImO+orj6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZm0b5ll+yvOhuieXMzg5RzpvXJ/8dZ2ONQTBgGWlqc=;
 b=DuBvBxC34jSheEQ2tbX4fxn6Tl9QOw2+ey+P15JtRrrky8kTmprjVVc9tcx9UgtY9mGXzNVo92d8bXkb8hvLn+lLx54uAagBODkYG+AnkpthUhbjoZV7ANX14aJX2j8j12MhJwRBlqJ+pCqzTRnIa+4vSMgB/K/GQUoDl3cAup7JRhiP/utXdAKqsPY8zGcWEO8COTm2LnMKB8UkLBHZllHL33Mo3FR32J8x3SfoGXLmamQy9Jodw3XebCQFTerP5f7m+wpK3aCRvEza6qcqRt33GQlSmQMYU95uLFAb4VxWQxm2haX4Jzj5EE/IDyS1gB7cK+ZkasNlIzpYasOM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZm0b5ll+yvOhuieXMzg5RzpvXJ/8dZ2ONQTBgGWlqc=;
 b=azGJSOrrNDx0QNEZWKPQ4yNLDzS5z4eXv1QHO84Frvd3brsxLvj3jGSaKOSq0zxeWFAt+kcC6N2tihAqH7ZaPv29gu0drOs837jrjI/p/mVU5iPYqSIQSZ4JzKAkCYau5xftBxe0T8wW1+AhmbGegEL4t+S/QvlfLZkqpUzpiuM=
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com (2603:10b6:a03:544::13)
 by BL3PR12MB6620.namprd12.prod.outlook.com (2603:10b6:208:38f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 18:18:21 +0000
Received: from SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957]) by SJ2PR12MB8650.namprd12.prod.outlook.com
 ([fe80::574c:e97b:b0d8:3957%6]) with mapi id 15.20.9723.018; Tue, 31 Mar 2026
 18:18:20 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Liu, Alysa" <Alysa.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v3] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Topic: [PATCH v3] drm/amdkfd: Add upper bound check for num_of_nodes
Thread-Index: AQHcwR3VaAkdBr9NMkyO55Qvg8+tzrXI8sJV
Date: Tue, 31 Mar 2026 18:18:20 +0000
Message-ID: <SJ2PR12MB86500FB6C585E8C81238B9FE8C53A@SJ2PR12MB8650.namprd12.prod.outlook.com>
References: <20260331145106.10925-1-Alysa.Liu@amd.com>
In-Reply-To: <20260331145106.10925-1-Alysa.Liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-31T18:18:20.050Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=1;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB8650:EE_|BL3PR12MB6620:EE_
x-ms-office365-filtering-correlation-id: 270eed58-cdc9-437d-f78d-08de8f51e34e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|8096899003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: vjMyMnkDHYJN/PJXpVs42S3GpIe2QEdcw23gZEB8ohqyjsIUENzzuY/FpAPivzuvlT6kWCoBYjhmBTDZtllKvfJD5u9dBdzegsyHM7T6Qyd1TdRmU/6SXWH083FDj2v79CE4TMPiJmIO8G8UAjDpBxtY+UnlNEwLSYwy54GDCi5AVxQGIrC4M23ta6hyrLOulNnSRkQ3y71tPfS1NN27KB2DdFAxNsngJqxw6xVt1CAIvLoBh7nD+xBl8AtY2+OQsjzeMUjSVhrQlXfP2k33vPhtEcGTi5JJyCSNEWGAOMAQF4jw+ZPGQnkBJtsnJgdI+QniJJEKedu+01Kns6GMPRXIsi/WBaTTml5nfBsW0hFusDaZZISPSGBvwEWh435/so3iUqfstFOY1TsomZCxbopO05xTnkulzFXSXhFRfeljxaScya++AHhQK89bXrCpQMbtohwlLTuS96B5ieOB3eHjsSd+f10MnNu9U85EfB4nhDo2TWc3th3gBfQoU1bINxVsvdSjABoCKw5fdAvKPfy1di4t8VM9DdB4jUfWZxe7BMaPD3kPsN9/KPIvamf6tRTWL6neUQGxfKlg0Rnm+BlgSvYemxTSUSapFE8Vw0C2tmVXJJ17ImSTuJJoY/FgnI+viHMzzmg2HdGUhW0qwmoeS/VsRsAfQQqgdOaJmTI0YzKm2BuGxVLyaHgIvNOjV8MErOkWv0H9685+oSjTsX8TA4mAQ6IKOm7wf16aNaI7CW2XLXi47w/5HUbTAwJHjvq1Kump98LGOkWBqQ1W/lcz5LOtwUA7zqxRmJqpl1Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g/ux0QAfsRN31oRbTL9AGk9s+7cT7Kfpp9WFMD3hoYHy4ysbHqeHPCWinu?=
 =?iso-8859-1?Q?aFRgmAY41HTb1i4l+nVOANI73sF+vdD5as5SMOAKLK5tHp77rAG8aKuLIz?=
 =?iso-8859-1?Q?C5zLqGk2wjlv8E0lsfwZrd+IrQ/PLDgvxXN93M2CTBipwS+Wc3EI3nfPsJ?=
 =?iso-8859-1?Q?nd0A/cZoCYA9FeDC75d/Mqh7FzAC6GNEeGW4vQk37wnR/ziBJH/Rxugjfx?=
 =?iso-8859-1?Q?6X44sA1aK+EKTcTFkrBkx7O506iQJEP7QUOpjDU6XXFp9rYEhOQuNPDxxB?=
 =?iso-8859-1?Q?6QfVBpFPM80fBnhP/fqWDrIWGdo+7vqbWpPF7Bgfp4gUMKfm1shkapJ7Qz?=
 =?iso-8859-1?Q?R9DFGT4xwyK9qWVH1Xnbvny6AMpGH3dLE8S6YcecvDGMgUrGNKLXywkxGm?=
 =?iso-8859-1?Q?GXi0l6nkY0TiWwlRbiJXczu8ZlCTa8bFj7Qt/N36N84242pvUJDbo6/vMr?=
 =?iso-8859-1?Q?fowf42CIqf5A6hsK/KA/4AQ5/hsWBqFBkmM0qKjvOvjtN/X53RYgU9iQTl?=
 =?iso-8859-1?Q?UY4TlJzoQvby6IGmFaIJUIXR/xZWih5DIQYaxIv0e/Sb154wq1nI4IzmcR?=
 =?iso-8859-1?Q?GsdXjlAPRGblJNFkDsazWyfYNjS3IrBOyE2IvVpBYOqyPM1drS/k9beyxM?=
 =?iso-8859-1?Q?OgLdRGZlA9qVaW0csC2GDzb0pGPQHU9tDiAXCqRa0yG3jFIKz6Ah9i2wkN?=
 =?iso-8859-1?Q?aG5txegjE2RJwsp4RGpwvR9fgv/lHsts+REm3J03AjcKurmR6G+izb7Xdq?=
 =?iso-8859-1?Q?B96B+vSL7xj95DDQEazB3Linvnp9tGoVZcMSJvNVGO7DPPs57yZfXjSQsE?=
 =?iso-8859-1?Q?VwnhL8EZY/oz7+KOlk93vHtFPkP2maEX1f2+X0HaVVoX/ogH0qW4W93sca?=
 =?iso-8859-1?Q?4rkIlY0gClAb6VuXDDqxLhUbqigbESNnZB+08vwGFKAMcFV7RDVPy2of68?=
 =?iso-8859-1?Q?itBSPJWRR4pmfMAKy+lsDnWb1j10Fhj9JZ6MPBwQbbm1dPYHSPUsoc7jgb?=
 =?iso-8859-1?Q?NkFrJErt8EyCDQpW7NPEh95GV9VNOMXJBZTz/jvhqbz0QC102G+U8A1aou?=
 =?iso-8859-1?Q?kDtyZogI33OMX2Y33xfpstsZE3Zltu8FHrlcdj3YKoemPEx3wyQaL5OQzQ?=
 =?iso-8859-1?Q?jwl0G4m9vzUG4qeyx3YrwzU322EDlss3PMN+6184V/13dOBF+4hkh6hVxv?=
 =?iso-8859-1?Q?Mm51POoLMbvpXBuYFT9L9ODafuVBcyiRIKudv4BBnHZNWvj8sDoNyMjbVr?=
 =?iso-8859-1?Q?bG4GTgmrh/rSW/ALcN3vVQ+n/+QE3rKVRsnS3snWtkJvb3pmP96M0KmASn?=
 =?iso-8859-1?Q?TagHXB2iaMFPSDHkK5WaYs31ErMDtj3FBsAJ/Ko0v5xxLyOZcfzK52twdv?=
 =?iso-8859-1?Q?uucUtc0zC2Hevw5wuOAZz+pHLoIQM5F65OmBXValmE9G4cJFif2ZnOskh+?=
 =?iso-8859-1?Q?POPGGyg+jnNFzx+Ua0PfIF/P6xMq0vd0oBTECoYU81O9gK3qat3r0OljW8?=
 =?iso-8859-1?Q?/OD8T9PRTJV6pKCROgBYsbeqbISCTnOxsRw3hqENp00sMASZcn4rCjgEkI?=
 =?iso-8859-1?Q?KvY2ESMcr3GuEcXLj/EHRGjxqYlEs+HVkr6ocQv456eSbqxNMUYrgm64Gw?=
 =?iso-8859-1?Q?yVcGE/5sqkM5PB2tZXkcYKNsfbPWTenQ2KaMBOEHOqK5bMs6YzZ7y5T60i?=
 =?iso-8859-1?Q?ah5nN6XAi6NJ/SnlQ4/r9pP+plapZW17Wifj21qUvxvE/ZJYYzmrFHrwhg?=
 =?iso-8859-1?Q?bV+Xxmu0+7XjoRGgmMe0dFTP0+y+8UKc+QvW15Hoiy+gkI?=
Content-Type: multipart/alternative;
 boundary="_000_SJ2PR12MB86500FB6C585E8C81238B9FE8C53ASJ2PR12MB8650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 270eed58-cdc9-437d-f78d-08de8f51e34e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 18:18:20.1409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: End9uBJyQFi4JcZxjNccBIsoPpVpFpIrGc0+qBOJZLzoOYxSMEXbcBLBSTHFNELet5yJw5/gta/Dhb9ffskjNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6620
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

--_000_SJ2PR12MB86500FB6C585E8C81238B9FE8C53ASJ2PR12MB8650namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

One comment is below.
With that fixed, this patch is Reviewed-by: Harish Kasiviswanathan <Harish.=
Kasiviswanathan@amd.com



________________________________
From: Liu, Alysa <Alysa.Liu@amd.com>
Sent: Tuesday, March 31, 2026 10:51 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Kasiviswanathan, Harish <Harish.Kasiviswanathan@amd.com>; Liu, Alysa <A=
lysa.Liu@amd.com>
Subject: [PATCH v3] drm/amdkfd: Add upper bound check for num_of_nodes

drm/amdkfd: Add upper bound check for num_of_nodes
in kfd_ioctl_get_process_apertures_new.

Signed-off-by: Alysa Liu <Alysa.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c
index 1db565442c48..5435419a7bd9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,
                 goto out_unlock;
         }

+       if (args->num_of_nodes > kfd_topology_get_num_devices())
+               return -EINVAL;
+
         /* Fill in process-aperture information for all available
          * nodes, but not more than args->num_of_nodes as that is
          * the amount of memory allocated by user
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h
index e7a8f3e17872..af7b687d729c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1191,6 +1191,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(st=
ruct amdgpu_device *adev,
         return NULL;
 }
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
+uint32_t kfd_topology_get_num_devices(void);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 uint32_t kfd_gpu_node_num(void);

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c
index 1ccd4514d3ee..453b3577ea0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2297,6 +2297,11 @@ int kfd_topology_remove_device(struct kfd_node *gpu)
         return res;
 }

+uint32_t kfd_topology_get_num_devices(void)
+{

It is safer to have a read lock here

down_read(&topology_lock);

+       return sys_props.num_devices;

up_read(&topology_lock);

+}
+
 /* kfd_topology_enum_kfd_devices - Enumerate through all devices in KFD
  *     topology. If GPU device is found @idx, then valid kfd_dev pointer i=
s
  *     returned through @kdev
--
2.34.1


--_000_SJ2PR12MB86500FB6C585E8C81238B9FE8C53ASJ2PR12MB8650namp_
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
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 128, 0)=
; margin-left: 5pt; font-size: 10pt;">
[Public]</div>
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
One comment is below.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
With that fixed, this patch is Reviewed-by: Harish Kasiviswanathan &lt;Hari=
sh.Kasiviswanathan@amd.com</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
<br>
</div>
<div id=3D"appendonsend"></div>
<div><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<b>From:</b>&nbsp;Liu, Alysa &lt;Alysa.Liu@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Tuesday, March 31, 2026 10:51 AM<br>
<b>To:</b>&nbsp;amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop=
.org&gt;<br>
<b>Cc:</b>&nbsp;Kasiviswanathan, Harish &lt;Harish.Kasiviswanathan@amd.com&=
gt;; Liu, Alysa &lt;Alysa.Liu@amd.com&gt;<br>
<b>Subject:</b>&nbsp;[PATCH v3] drm/amdkfd: Add upper bound check for num_o=
f_nodes </div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 11pt;">drm/amdkfd: Add upper bound check for num_o=
f_nodes<br>
in kfd_ioctl_get_process_apertures_new.<br>
<br>
Signed-off-by: Alysa Liu &lt;Alysa.Liu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_chardev.c&nbsp; | 3 +++<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp; | 1 +<b=
r>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 5 +++++<br>
&nbsp;3 files changed, 9 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_chardev.c<br>
index 1db565442c48..5435419a7bd9 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c<br>
@@ -776,6 +776,9 @@ static int kfd_ioctl_get_process_apertures_new(struct f=
ile *filp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto out_unlock;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (args-&gt;num_of_nodes &gt; kfd_to=
pology_get_num_devices())<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Fill in process-apertur=
e information for all available<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * nodes, but not mor=
e than args-&gt;num_of_nodes as that is<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the amount of memo=
ry allocated by user<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/am=
dkfd/kfd_priv.h<br>
index e7a8f3e17872..af7b687d729c 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
@@ -1191,6 +1191,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(st=
ruct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&nbsp;}<br>
&nbsp;int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev=
);<br>
+uint32_t kfd_topology_get_num_devices(void);<br>
&nbsp;int kfd_numa_node_to_apic_id(int numa_node_id);<br>
&nbsp;uint32_t kfd_gpu_node_num(void);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_topology.c<br>
index 1ccd4514d3ee..453b3577ea0e 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c<br>
@@ -2297,6 +2297,11 @@ int kfd_topology_remove_device(struct kfd_node *gpu)=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return res;<br>
&nbsp;}<br>
&nbsp;<br>
+uint32_t kfd_topology_get_num_devices(void)<br>
+{</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
It is safer to have a read lock here</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-size: 11pt; color: rgb(0, 0, 0);">down_read(&amp;topolog=
y_lock);</div>
<div style=3D"font-size: 11pt;"><br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return sys_props.num_devices;</div>
<div style=3D"font-size: 11pt;"><br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);" clas=
s=3D"elementToProof">
up_read(&amp;topology_lock);</div>
<div style=3D"font-size: 11pt;"><br>
+}<br>
+<br>
&nbsp;/* kfd_topology_enum_kfd_devices - Enumerate through all devices in K=
FD<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; topology. If GPU device is found @idx, the=
n valid kfd_dev pointer is<br>
&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp; returned through @kdev<br>
--<br>
2.34.1<br>
<br>
</div>
</body>
</html>

--_000_SJ2PR12MB86500FB6C585E8C81238B9FE8C53ASJ2PR12MB8650namp_--
