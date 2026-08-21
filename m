Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 002BBC5DF87
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 11:42:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D22B10E1D3;
	Fri, 21 Aug 2026 11:42:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jtvj2RoT";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4871510E1D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 11:42:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwFZZIHnAN8CRvvFG28Zi7fumPswWo2bINRtNwr1fO2+4l1xtSkc4xnsBCvWPyyNlnBop6HcsiSYoiUmhY9cBSE6hx00UJfhDF02mR6sy412O6QJGtozZ6fXKryXMwbWIjM6frZak3FiKRbnw19kdZc1y7HaWkZIEyUd9q9B1/6zzv2a4QUiNCZxD5pK2hJ5Hdu0QS4cBMfsBPWMeRsN3EolGyCG68CFAiTM7hDZTT8cN0zgL7a4VhieB9qTRM9QjNEI/rHw86px8XKdbnBNz1o99yY/uUmiDq0TKLrseEci1Ty5Qi4Vr4RKuAfdbEeHatPaAiNi7crpCncDO4QCWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMxW7HhyRVkbkq5L6nCvacBZ/GhOTuNeuXTmvVxSFiI=;
 b=bljr5OKpEJ87HKgBqksiE7QEbaBcqO679l8Fn1chu2oWQsjKXFWGTndYlVhCNzvWKlTyOzlsJ0l+S/m0CoytJA7WCD/1L251khdgJBV6RYFl44TjWaQuvTkTc8xQnlDYZjvWdZsnEIZu5xCEd54iKSQQ0rQWzwPz8jK72atrQq1fu1KKHdkySx0K+4LXngY6AukqwuDQVySA9ghkVZBIICzvWkex5fdWze+UIliy89XsV7wI8+1hGZjA8Q5HzdfxtGgC3IhlxXAwcpzMiC/6Ej5lSRZ9t5bDq7NQ5PAVcmBfBe4JQL46ykHJHpFHo4mxk9NkPOJDP454UV7uVC4VhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMxW7HhyRVkbkq5L6nCvacBZ/GhOTuNeuXTmvVxSFiI=;
 b=jtvj2RoTFCR6sXml6HWkfyDfMOk2/XxUTbqDMv9OKmFQCZ5exvMGQ/73G32t0wA0JWoxxn7hurkvcXVkqIDn4Ss6wdVi3dync7na3+fU0XmtURXGrs3T8k5YfcEByP/NGbZYmW0e4DTtTbllp0Gifp6j24QAxaISL6BGTuT61nU=
Received: from BYAPR12MB3192.namprd12.prod.outlook.com (2603:10b6:a03:139::14)
 by IA0PPF8FC6E1236.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bda) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 11:42:41 +0000
Received: from BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a]) by BYAPR12MB3192.namprd12.prod.outlook.com
 ([fe80::b4a2:3223:31a2:ab7a%4]) with mapi id 15.21.0315.016; Fri, 21 Aug 2026
 11:42:41 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Liu, Xiang(Dean)" <Xiang.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>, 
 "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amd/ras: skip the RAS firmware reload when the block
 is down
Thread-Topic: [PATCH] drm/amd/ras: skip the RAS firmware reload when the block
 is down
Thread-Index: AQHdMVkKqv4ZLNiBQU23kOj6BQD4LraoYY6Q
Date: Fri, 21 Aug 2026 11:42:41 +0000
Message-ID: <BYAPR12MB3192478845CD21634768F915FCA32@BYAPR12MB3192.namprd12.prod.outlook.com>
References: <20260821103628.1666226-1-xiang.liu@amd.com>
In-Reply-To: <20260821103628.1666226-1-xiang.liu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-21T11:42:21.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB3192:EE_|IA0PPF8FC6E1236:EE_
x-ms-office365-filtering-correlation-id: 50514717-1b56-41a7-4bd8-08deff794eeb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|11063799006|5023799004|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: jGthu+STfVfypyoSlglNPFPHustGXuPR2cCGrQyHIpQYepJNbT2SLeAY3/0nJPkDyK7JnkFxBEswNzhSdDlj7CGYtpHSKOg1R5Ol1gCu/dkRw770mgBk/ZhiL6+831Y7/Uwc9ACgeud6RR6k5X9MozrdeCPfOVT78ppyLe75cVfkSI7ELhpS8bwvQLmlcgg8PM2hpHWJRNeS++CTaJUqiLyfYlvGQaHgsZtQJkDC1WCszspRfHRSYd70eAMW3RNAPwNDPbJRz/15ZSwXX0AuxE0Kjb0fik875shECF4uLE+0nA1ArQd+vCG0gKg4JVtl9dFqmYwuvBpima6znZD92nZnmBXuCO7JUiIYdj7lxG00DV6zEfml6QGx52zp2WJ+x+dk3NeQX/x0cSPrRLVoTB5Io0uGszo6zmCuze7hGnOxw8X4p59Zwo7CkVsctYsAixyK4pnTVVKbEFNDl2rk3VT2Qh8ZcdCErBaciwwSaDIRUK6FxiSpYg3Kn6TwdOjG4w1RMs6xDJn5r0zdiXhBmaMzRW0KIx0kn0y0Ii5XusbiuUbUqLxgUaVRKuFb2KvcnrULQpJhZo244qb4FXne+dpILlWtNJT+EFBmHmnMwvjZTyvsAJfvuLbB1k4d0ObCP94qbjclfnEoA1LJfyAYlvWdRj2VtDaAExGkkHlQRixXuZDpY0tvn/mhNROJ9twuPCVEo4fJLHMTOHZi34vv2naZhGf28Gel6E9v6uO/iSA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+BwvUNg9sLsGkB2AJnrUVLxAAHHlaPoV6RHwUuSsF9JVSS1ZUEFZkKMriJms?=
 =?us-ascii?Q?edBnJq71cu2vl3Jm0gQcNXJx/jUBRS/Ga4z2dvDWFiGscCCXGuUohYxllXKI?=
 =?us-ascii?Q?g5JNsDXvkwBHgHdyaxE7kbAJnSocSQjc+czCOpQEveZ31qlRe9al4v2wXljQ?=
 =?us-ascii?Q?aOTkPqZQj+NE3w7TwAX+BHGQWTP/9hFLC4O37x0xNheAqq+weGWRqXuVId1B?=
 =?us-ascii?Q?x6rsn3uTRCzMe/C/pVFML14watq0ECOntgOnVZvw6SDR+hN3idLoe4W2A2hw?=
 =?us-ascii?Q?7vSWSPGnUCEb/YnW1Y3crTjeySLqCT2GAS1VFpFFXH5u0BS7hxlsJwqyPfpz?=
 =?us-ascii?Q?UxoIB0jGz6UFJx2bZEQm++p8ic9qwkOPcPnefjNjoebokgbdtNwZ/tBvXOhj?=
 =?us-ascii?Q?0imZP9A5EgUecx6ctTx/rXQStJG4qPjwBhGid80HyMgHnjLk94LJAjufsOx3?=
 =?us-ascii?Q?dmtdXvkhkR2ha8AYy42+Um50pzBSo1HEIA2VSf2VvXRrGNE04UvnAQe4TNhk?=
 =?us-ascii?Q?PY8wMaWB6fsozFAAGUVQHHFkMN9HqUzthWloIcKt8namklOqMtGZJuNYu8Lq?=
 =?us-ascii?Q?nQ1sSzUkdpoT7iIEr3L73rpYoLHAO0KW7tLzqd0/bQJBmPBSdlFL5AvnbhNH?=
 =?us-ascii?Q?Fdvy37E9fDGihDxUcBs7tO0sHBtEz8xXnygCCzNucfwUqXusS8nh2NWfWGTO?=
 =?us-ascii?Q?sbXk0gWksQLmawCnY67I6fAlNjgrtlwtIOdFlJ2JR/6oOiCVNf+8Qf0s0bjs?=
 =?us-ascii?Q?722c9N7a+KDzAS1Qz97ujuJSom3Nn337wTPDu/+M4ieghGpOfLzqESWa1dXh?=
 =?us-ascii?Q?HLY+MMNcWoUQvezfYgkwvlVI8ImfZpmlFijEbJEq/XJ3fyLzPVK8IgxEhWb7?=
 =?us-ascii?Q?E+LIvXy4ADq5f/zEwUcLgW8UR9rQz5iIRJ5Tj6wsGupQ4mjZIMLsNWaRmZeu?=
 =?us-ascii?Q?iVBEINigehp7g4mp+vYqHqRvumEMWlg6b6AQQSDpadNSigpJNV2e7OMqbIXo?=
 =?us-ascii?Q?WjGJ5CNwFnQ9VYnGSu9s+SmZsd8hIUVXnPt8mtHEjxyxf8pTFjgkJdIqkedO?=
 =?us-ascii?Q?MvEiqxYUTiIBEyc1vlnppM2r0accaeLwNuG3QgQ1l3aJAMLBP1NZj/citpat?=
 =?us-ascii?Q?y+gELk2Nl47VS2TB62BAixDjOzDsOaHzk8hI3Td9kfqaFWxKt08R1QS5wHAf?=
 =?us-ascii?Q?8RGjQvax3AVK9w3KooHFyrvQv94irZpZu6g5bes+74OPz9+z3Mi5HzJb5gr1?=
 =?us-ascii?Q?FkrLQYtBDyIfsd0ks93uEczihMpCMPHKVfU8z0EWUAPo0znHnjgFxDgW7v9+?=
 =?us-ascii?Q?RojuWBgQHjIO7mgWX7ivjYvFOmrTUFBQ4Z3KatPm7Tnodd4x7kkDEGNDktiR?=
 =?us-ascii?Q?0xn7l+NM5BKf0Ig16wYrB3FCVSTYo+7Kme6G+t5kFOknjUjuiqLWMzIJ98CK?=
 =?us-ascii?Q?/9ErNMs0nShzkAp+hbG7wp+BdU9Ka/3hDXIc3LjMhibWA3wI8z90cw21cC/A?=
 =?us-ascii?Q?hXiHFma+YdBVa1hFkE6PGqJPxxpmZiPC3ZZfcuyoa2RdL1vxrRBqk3hMFe2Q?=
 =?us-ascii?Q?r6vHQX02FhtyUKydwZydhMSwqrzOGHNkJ4Nh25FXFOOPDEqc6dnWADQUhYQk?=
 =?us-ascii?Q?gop+TzPXWx4cH0s+vMec0JjJQ/fJLYgXoxrru2JXdF6arybalTQtec4z7Xy3?=
 =?us-ascii?Q?+9Zh2nn6joHKCIzyhRjwRM2l0wlppv3M6+ScZANFaIA7nUyG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50514717-1b56-41a7-4bd8-08deff794eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 11:42:41.3324 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fKh+O4ak6PsqZz/4UdI8oTLWvXzRJObEKEOJ4MRs3jQZGD884TIp+t3goY80ifsGHQ82ZKsOewI2erVYyLbXLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8FC6E1236
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

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Sent: Friday, August 21, 2026 6:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; =
Liu, Xiang(Dean) <Xiang.Liu@amd.com>
Subject: [PATCH] drm/amd/ras: skip the RAS firmware reload when the block i=
s down

A reset on init lowers the init level to the minimal XGMI set, which leaves=
 out the RAS IP block, so its hw_init never runs and the PSP buffers stay u=
nallocated. The resume that follows the reset tries to reload the RAS firmw=
are into those buffers, fails with -ENOMEM and aborts the whole resume, tak=
ing every device of the hive down with it.

There is nothing to reload in that case. Leave the block alone and let
amdgpu_ras_resume_after_reset() bring it up, which is where it has to happe=
n anyway: the RAS hardware init reads the EEPROM and so takes the reset dom=
ain lock for read, while the reset on init path still holds it for write, s=
o doing it here deadlocks.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
---
 drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c b/drivers/gpu=
/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
index 3d806e35382a..b41117deb5f3 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
@@ -518,6 +518,13 @@ static int amdgpu_ras_mgr_resume(struct amdgpu_ip_bloc=
k *ip_block)
        if (!ras_mgr || !ras_mgr->ras_core)
                return 0;

+       /* Nothing was loaded, so nothing to reload. The hw_init has to run
+        * from amdgpu_ras_resume_after_reset() instead: it reads the EEPRO=
M,
+        * which takes the reset domain lock that reset on init still holds=
.
+        */
+       if (!ras_mgr->ras_is_ready)
+               return 0;
+
        ret =3D ras_psp_reload_firmwares(ras_mgr->ras_core, 0);
        if (ret)
                RAS_DEV_ERR(adev,
--
2.34.1

