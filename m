Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED40C27C6E
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Jun 2024 00:31:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE08C10E02E;
	Sat, 15 Jun 2024 00:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eN/t8Smo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B98AB10E02E
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Jun 2024 00:31:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBfL7uGBsr1WnpYuX6BOklKljaFLBt1ao0sZIWZRZZC8UAauV61CYNib+LZZ6wrqrf0UvyMHQtT5LIN24htGEgr+AoarJp4qa3hn5t5BeSqIWd9o+9IkNM66rhwVzyv1oeh+9VtXaR9JVzvCohMrVBjGY9pN/wSRhKFdoKd9UaDDlwp2jSKzlAMHdPBUTi+iY6Jsd//ILb63DdXg1Tmhr6d69LMsAg+zmnfWYyPIUeEEhCmZ84egTKdbpxZ9XUvjLK35xuu51n8GtjcS6Wlu0//w3skO4sFlrdi5R7X85nrKWLm4QvkzefVfOXz+QslVEcILwUt9vGB89yNeIUKCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icxyJUTxWxD+ukEHKmU/Ec2NP5RWanfIAxpfneDZtXs=;
 b=ilLOlzJVoHTVWb000m9ARueSd3vkchxVlKkrHZpFzJgcv7Cew3t0/LVU/7YDorPt7btRsAdUjLc5QDHzVhPgQueF4P5ojAShFUJKCGhbqG4/Z7m74/Z/FbxoDHJ6N5QYyfq0lq4VobbtJTM4HVn7Rkg/ZSxwlUqSomB4Fhe2/ELP82VHKMSifpcX2LhVREXD3M0PqDd2ikw8Jq7ZzvOMDDzLpfrIyevnZXszt0vOntPs55UtQ/kG1Ar77t5Y0D0/d0Fbri4BYTig3BH/xKdDfLC95EuF3Ei5llUk7ihq/y2sIMOUwss0/NDB10+4fyQHCXBum7T+fpn/UWJdWUutZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icxyJUTxWxD+ukEHKmU/Ec2NP5RWanfIAxpfneDZtXs=;
 b=eN/t8SmoB6JbfhsGLmWY75t3HFt3mUx1xLyblERftMRwDaxV92SqFpvp9yFEyqWrFxuC6acUT3Gm0eg2Xf+jvfLMDshPBVFx+FCYmLpl2mylX432ULyLvkPGOcDixGByE6k2lf3RrbVxBOB0hxdCdvvhJMOFLmEj6yVOKL0YQMc=
Received: from CH0PR12MB5044.namprd12.prod.outlook.com (2603:10b6:610:e3::13)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26; Sat, 15 Jun
 2024 00:31:37 +0000
Received: from CH0PR12MB5044.namprd12.prod.outlook.com
 ([fe80::20cf:ff38:8a79:5fff]) by CH0PR12MB5044.namprd12.prod.outlook.com
 ([fe80::20cf:ff38:8a79:5fff%6]) with mapi id 15.20.7677.026; Sat, 15 Jun 2024
 00:31:37 +0000
From: "Chander, Vignesh" <Vignesh.Chander@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lu,
 Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
CC: "Lu, Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Do not wait for MP0_C2PMSG_33 IFWI init in
 SRIOV
Thread-Topic: [PATCH] drm/amdgpu: Do not wait for MP0_C2PMSG_33 IFWI init in
 SRIOV
Thread-Index: AQHavpn1CYbPpgKuUEmIA2mIp3+10LHH+MLF
Date: Sat, 15 Jun 2024 00:31:37 +0000
Message-ID: <CH0PR12MB5044147287F50EE24CCA8265ECC32@CH0PR12MB5044.namprd12.prod.outlook.com>
References: <20240614203205.4266-1-victorchengchi.lu@amd.com>
In-Reply-To: <20240614203205.4266-1-victorchengchi.lu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-15T00:28:44.3650963Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5044:EE_|MW3PR12MB4379:EE_
x-ms-office365-filtering-correlation-id: 6a4c451d-587e-491c-909a-08dc8cd28489
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?2SlxZFBJ48iAugN72kL8tCBVA2FmkdM3kUCuijcbXLccSup2LrxuRZW99eiA?=
 =?us-ascii?Q?07rle8pFi9Z16E3y7gbGgJ4oovmub2kSwlrwRlo47UM/JByirTIyTUoBZC2w?=
 =?us-ascii?Q?QYgyqLA8VeQwoVVsobUM8MaIJCHegjU/jaKRy+RGQhY0eo4uhxWAWLaMFKaA?=
 =?us-ascii?Q?7fqUzwrW3yzgIQMqkDrTweV6cuA052/1Re8Z3NWOGW6ZTjCW/AXRA3kREJqD?=
 =?us-ascii?Q?Zx/C5HScYJWBzLJXQuFZjvHT0WUV10SmipJxniE/ezegwPNSovp3WRCM8rLI?=
 =?us-ascii?Q?6bbrN+wb1Ll8U1IU+a3fos/TRUNR49UbKHzeYfnk3UeAmFAfH5h9BFrc6jSB?=
 =?us-ascii?Q?RHwuWjOD9WoVMBiciPFnxvasCwaAVOxEl1CoMr0RqBFkSc0ZhnTLhaV5SaTD?=
 =?us-ascii?Q?Mr0Pi7qolyI8lfMYl7T/fyQDK3mojssOylXs+bLZldGMOPAFkrzCqAoHlTfg?=
 =?us-ascii?Q?XtJTQd5+ktc4/fwZ+T26UYL7j85PJhJQST19NRSogImQLHGKbUOYkjydRdG7?=
 =?us-ascii?Q?rTX2sCzRPlrREGvJRXap0lFW9XDuO0ElBc8UIG32wNRiertZKJg1CsN0AAOr?=
 =?us-ascii?Q?o/xWgs0LvHAg3BW8t+Rx95DLVPJbEXd/xYD2k2sqBzSlBdZJ69GhwmEID4CJ?=
 =?us-ascii?Q?9o2mFavnlPUtjrt4mdP97SIVxCv+MFzrkMa4HQu4goCLx1HxAhtcYi8yrWTk?=
 =?us-ascii?Q?nVgkG2a0ECzUrNy8uDIm+eunQmpFjTyVX3gnKqtjMVS/u466IrH3q0T3tGX7?=
 =?us-ascii?Q?Yinp9PrLbxw9hh8Y3xJUwgI7KsbyKsyJ59Tlce8bowUhHDcJSMW4oBo6bfK0?=
 =?us-ascii?Q?XIeurN14NXeZCp68gQKGARClZ1uOitI7BaXA9DJu+ZAeLCtIh7Zi2MTezkL6?=
 =?us-ascii?Q?3dcDDktjpiLOfc6F32I5il+T3+kQjXt/0SU1phRXeDv+AyLggse4lDIyZqDe?=
 =?us-ascii?Q?jDJ0fiRGURHB2yYU5oJGJ/U1ZLr8y8o58WhcSe+oHclgvYFhfDMGRaVNApvr?=
 =?us-ascii?Q?UbnagTnkPsMpbc/u0pJwJIxxkJu+EI7Of+GBSA5YOW0iUTLKjx/yEtuFQnPz?=
 =?us-ascii?Q?YE6kQ7vILVfCV/5nV8ojZ98opCLX9HNqWRazqLe5/Ap6cW3Z7ihm6mU+dew3?=
 =?us-ascii?Q?PyULbQIvIgYLp1Z2j8+MoKT3YzUav4+gasSxoWzEMNR6unD0Am8ouwbbf3uI?=
 =?us-ascii?Q?m44yAApAee3kT0sfJNzYTZiQ98P/ZGelgBH9e/HfaypwXuP4+H+dyolEIK3s?=
 =?us-ascii?Q?5eYs4Ah5AxouVEiue7NFAVwGEdhY0CzKqY4oiUbYg3Ns8dQK4TZZU/sc7Hga?=
 =?us-ascii?Q?At8AQM9wu1RGZG0cenesbm1yTCwQGDxqCzcPP6Oz0RypoVKR2d3E2/P6dYab?=
 =?us-ascii?Q?xlUNXLo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5044.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(1800799021)(366013)(376011)(38070700015); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?emvx+ZMj4gWsI+kX1eOVxFhOAjpOV17SzRUhKqzbdwpZ/AS1pDACAWkpFojU?=
 =?us-ascii?Q?mY0jc1EGYEMEnfhHE3o/TGQvfX0dl1EG2yIiYfrz472bcjBjvFn4+8zIM9uG?=
 =?us-ascii?Q?1lnlnEEUX/8eV1yz/6YFs1HhLgIfwsJrb6dJCxTkjAqYT+TaWqPOnQMGGd4g?=
 =?us-ascii?Q?PDLfMdkDPbNuzH/vG9dgWkLSGZmeeaZRfehN178JzIsMgiV7uM7xQ7n0IgLV?=
 =?us-ascii?Q?oN3xp026iXsMWw9tiuI42xmKhXS+LSOoxCiY+adS2tO5/piYR6Qs4Vy3ZGOB?=
 =?us-ascii?Q?NekMaz0GOEoTfCvQm+ZOOMXcmYH4n52eVDnjasbnPqKLyDR/fI7RuNBOdtiD?=
 =?us-ascii?Q?Vn74NJGm8FbXLnFV850EhrxwMg0jxg14/A9fFrpv+3k1ZN9oEMF+SpQFzg+O?=
 =?us-ascii?Q?JXRx2Dm4ISFn/5BdHYg+p9RuOnkll7Mpk78n2v3NkvbFkXCY645UJAuZ8vBi?=
 =?us-ascii?Q?AWaNOigqaQk5YuKZu5D9nEaNYPCWPOy6adSUQ18BlTW0S3zdO7v5WqnCwYXA?=
 =?us-ascii?Q?1VSfiKMA1ICGSnCwvPRhYjNZYDnO9fjP4sL1LenRNoI9JV2+spyEXQl/at0s?=
 =?us-ascii?Q?z1umBQHYLeNk5Aszsq1R6ape/y5OfrP4T5+c+ipTDurrVguJpWqhEDTCp1Aj?=
 =?us-ascii?Q?HZli/2kTRJZkQNSGGc3p7iJ0qve/niAHZpkB6gg7ogTy7BvvtU2LdIPTIZoV?=
 =?us-ascii?Q?sj3ER6TtyBmmR6Ndd8XSm7E+Ydsce6K9k2itRX0zEJy/viBAlssvcX6bKfM1?=
 =?us-ascii?Q?02ciY/N2AazqXIoMwW4DJqEtf5MkkrlhwyNuWm5gMpmHKuqMKgG/8BR5oYvP?=
 =?us-ascii?Q?9x9zQ+pMlPF62O4sngJXZNggJ/Azgn8JWMaGjEqsSjF+XGg/PlH248LaSYBC?=
 =?us-ascii?Q?bHRpG1WdyTEeXkhx6j6qlY9/5O5QeoiA3mrmyLYbHoWhwgvWuGkt2fiSa6cD?=
 =?us-ascii?Q?x4PY8iNn5x8aUmjzzSTq1XEgeJEgz6Yq5vH8zwXgaUzKSXfMy8BbBQixnLm6?=
 =?us-ascii?Q?17t3pI+CPtD31pBpOzW87RWEgFF6lAqX+pXqRaToep9wbpXo7JvwSSOHQy2k?=
 =?us-ascii?Q?3p0sOlpVXUmZWVWx4t3GOV8yYja2mPPIn7iBkeuF777G/dNN4bIkb4XyADCI?=
 =?us-ascii?Q?Hl0EZbotidCKWLlFgAfOrYr6XlVanUdDu8EdNBcqtC/ea65hf1mgNboutYbG?=
 =?us-ascii?Q?pGo/O5utE2mQuYY4K/o51gxfKC7Xb+nfWKa6L2B9yP9E4bFgDVn76kM4hzTl?=
 =?us-ascii?Q?GkR0p25r4iJ5UFs4OZFhDnMV2A7nNF5NofIw/xubmMfGXfbs5m2/y1vg6nCs?=
 =?us-ascii?Q?XFw5cZ/Vocc2oHsQDlHFNV89F1hFFF+4h6ofYS4B76WV6MW0j7e1MLRQHyLe?=
 =?us-ascii?Q?Yd8rbvJlPq58ebsC2oij2p/bkpePDShjE3clO/DcAz8gxh8U+NWRGQ51THBy?=
 =?us-ascii?Q?ezAuCI7aGEBNRDZVy5OkdVISkOqxi53F3Db2/I1EuiUIlu/gk2FWbLQUbG+n?=
 =?us-ascii?Q?hdNHJXH/h3ru25LjywlmqWuVnUM79U0ZBJ8GfPzTShGgDRwJExdoBXtqVngJ?=
 =?us-ascii?Q?eywkbiZhRKt2MCsisU+/LfuVAPkNE8zEJzc6rKJ/?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5044147287F50EE24CCA8265ECC32CH0PR12MB5044namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5044.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4c451d-587e-491c-909a-08dc8cd28489
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2024 00:31:37.3823 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abk0UiCWmxSi8pqId8p+Koc3qJ94k7l5/54uSS0Gv0LM7TC/y/fd6yu0af4l0JlT4KAhCsMLDT1wiePu1b8WXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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

--_000_CH0PR12MB5044147287F50EE24CCA8265ECC32CH0PR12MB5044namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Vignesh Chander <Vignesh.Chander@amd.com>

________________________________
From: Victor Lu <victorchengchi.lu@amd.com>
Sent: Friday, June 14, 2024 4:32:21 p.m.
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Chander, Vignesh <Vignesh.Chander@amd.com>; Lu, Victor Cheng Chi (Victo=
r) <VictorChengChi.Lu@amd.com>
Subject: [PATCH] drm/amdgpu: Do not wait for MP0_C2PMSG_33 IFWI init in SRI=
OV

SRIOV does not need to wait for IFWI init, and MP0_C2PMSG_33 is blocked
for VF access.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 26 ++++++++++---------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index 9e0cfe06c8b1..4edcbd272fa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -264,19 +264,21 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,
         u32 msg;
         int i, ret =3D 0;

-       /* It can take up to a second for IFWI init to complete on some dGP=
Us,
-        * but generally it should be in the 60-100ms range.  Normally this=
 starts
-        * as soon as the device gets power so by the time the OS loads thi=
s has long
-        * completed.  However, when a card is hotplugged via e.g., USB4, w=
e need to
-        * wait for this to complete.  Once the C2PMSG is updated, we can
-        * continue.
-        */
+       if (!amdgpu_sriov_vf(adev)) {
+               /* It can take up to a second for IFWI init to complete on =
some dGPUs,
+                * but generally it should be in the 60-100ms range.  Norma=
lly this starts
+                * as soon as the device gets power so by the time the OS l=
oads this has long
+                * completed.  However, when a card is hotplugged via e.g.,=
 USB4, we need to
+                * wait for this to complete.  Once the C2PMSG is updated, =
we can
+                * continue.
+                */

-       for (i =3D 0; i < 1000; i++) {
-               msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
-               if (msg & 0x80000000)
-                       break;
-               usleep_range(1000, 1100);
+               for (i =3D 0; i < 1000; i++) {
+                       msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
+                       if (msg & 0x80000000)
+                               break;
+                       usleep_range(1000, 1100);
+               }
         }

         vram_size =3D (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
--
2.34.1



--_000_CH0PR12MB5044147287F50EE24CCA8265ECC32CH0PR12MB5044namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div dir=3D"auto">Reviewed-by: Vignesh Chander &lt;Vignesh.Chander@amd.com&=
gt;</div>
<div dir=3D"auto"><br>
</div>
<div id=3D"mail-editor-reference-message-container" dir=3D"auto">
<hr style=3D"display:inline-block;width:98%">
<div id=3D"divRplyFwdMsg" style=3D"font-size: 11pt;"><strong>From:</strong>=
 Victor Lu &lt;victorchengchi.lu@amd.com&gt;<br>
<strong>Sent:</strong> Friday, June 14, 2024 4:32:21 p.m.<br>
<strong>To:</strong> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freede=
sktop.org&gt;<br>
<strong>Cc:</strong> Chander, Vignesh &lt;Vignesh.Chander@amd.com&gt;; Lu, =
Victor Cheng Chi (Victor) &lt;VictorChengChi.Lu@amd.com&gt;<br>
<strong>Subject:</strong> [PATCH] drm/amdgpu: Do not wait for MP0_C2PMSG_33=
 IFWI init in SRIOV<br>
</div>
<br>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">SRIOV does not need to wait for IFWI init, and MP0=
_C2PMSG_33 is blocked<br>
for VF access.<br>
<br>
Signed-off-by: Victor Lu &lt;victorchengchi.lu@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 26 ++++++++++--------=
-<br>
&nbsp;1 file changed, 14 insertions(+), 12 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c<br>
index 9e0cfe06c8b1..4edcbd272fa4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c<br>
@@ -264,19 +264,21 @@ static int amdgpu_discovery_read_binary_from_mem(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 msg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, ret =3D 0;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* It can take up to a second for IFW=
I init to complete on some dGPUs,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * but generally it should be in=
 the 60-100ms range.&nbsp; Normally this starts<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * as soon as the device gets po=
wer so by the time the OS loads this has long<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * completed.&nbsp; However, whe=
n a card is hotplugged via e.g., USB4, we need to<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * wait for this to complete.&nb=
sp; Once the C2PMSG is updated, we can<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * continue.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_sriov_vf(adev)) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* It can take up to a second for IFWI init to complete on some =
dGPUs,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * but generally it should be in the 60-100ms range.&nbsp; =
Normally this starts<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * as soon as the device gets power so by the time the OS l=
oads this has long<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * completed.&nbsp; However, when a card is hotplugged via =
e.g., USB4, we need to<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * wait for this to complete.&nbsp; Once the C2PMSG is upda=
ted, we can<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * continue.<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 1000; i++) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; msg =3D RREG32(mmMP0_SMN_C2PMSG_33);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (msg &amp; 0x80000000)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; usleep_range(1000, 1100);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; for (i =3D 0; i &lt; 1000; i++) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D RREG32(m=
mMP0_SMN_C2PMSG_33);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg &amp; 0x=
80000000)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; usleep_range(100=
0, 1100);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vram_size =3D (uint64_t)RR=
EG32(mmRCC_CONFIG_MEMSIZE) &lt;&lt; 20;<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font><br>
</div>
</div>
</body>
</html>

--_000_CH0PR12MB5044147287F50EE24CCA8265ECC32CH0PR12MB5044namp_--
