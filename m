Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D837DCA1013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 10:44:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70C7E10EB7B;
	Fri,  5 Sep 2025 10:44:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Femr9KPP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362B610EB7B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 10:44:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCf7nlY952LdhtMSRJtm0nn8hdgEJrMX9QBCVabhk2lphTU1OEysh0/iuB4w6mE3qZ1E9Lmhgp4BWOfxnVmIKAU1JgTXqXyb2qKsyVFBB+kz1S62h9RMhaJ5vHVQARRktWKKqiTZxLeKqiEygG4Az19rsgQz1TtFJ53HqOggxsmxuG/hSLGDtOftMJBCQZiiq8R777kNcskyXDCeMZUTn2LpIBC60YKOyf4le5n5kbDGS12fSbEPPXGw0VQcNheI7mA1cMkiE0en1CkUBpoEqTjmn1FhqQH2nOWyo5lb3K6VPkoKEpHBUDKN3iGjNGxl/WSTPsEXggPoZV9YFdKIRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnXNl8drKr9jHPt/1cK0VVAKjozxBEjNN7FWIyD0Zh0=;
 b=jwxrqUe7oFIgmy5E7lQ/oup3BbHALVOFDX+MQCoq3ytTAVR4cRBSgJ18BoisjRb6YWpzzddzj+Ym9kR4zU0liQvrortYkUIREBPMCsSXNQ3hfgF94GUB7uaiEiCfXLyAbA7zH53ZZZCcxdaC3MpinXdT9DI1w4tMntiZRu78nGUGesewJFQ8sQC7Sy5ihI2pgDhH1Ht+hZ51UAr9I9XfKt1PWy6Xe7kFGTx8fpGHDrMvLJtJbtzSCgfHWF4f5/y7i6yiSZIaavOTCQF0O3/B3mkDDrKmsGY7CWJNagRE/d2UqzkF4B8Ftvxjv0IMhBJFQi0t9ri69mi7/YyWZK8JaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnXNl8drKr9jHPt/1cK0VVAKjozxBEjNN7FWIyD0Zh0=;
 b=Femr9KPPRQFnDx5rwAaw1Zt3lQOmqqh2RIoo2lOZ1zW83C8SbXD9B2IYCGnohqqb5I4GWXvEtFC5uYx1ejAQQHXQfdyrV7qQ83bal2eki7nKi6kqFyHK2dyx0LGDqgyZ8nDHJzh0liwJMxyPNqqdcaKBiP4R1wZkb9K+604Z/+8=
Received: from MW4PR12MB6875.namprd12.prod.outlook.com (2603:10b6:303:209::5)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 10:43:56 +0000
Received: from MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::3d7b:7e5b:458d:a32e]) by MW4PR12MB6875.namprd12.prod.outlook.com
 ([fe80::3d7b:7e5b:458d:a32e%4]) with mapi id 15.20.9094.015; Fri, 5 Sep 2025
 10:43:56 +0000
From: "Li, Candice" <Candice.Li@amd.com>
To: John Olender <john.olender@gmail.com>, "Wang, Yang(Kevin)"
 <KevinYang.Wang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix NULL ptr deref in
 amdgpu_device_cache_switch_state()
Thread-Topic: [PATCH] drm/amdgpu: Fix NULL ptr deref in
 amdgpu_device_cache_switch_state()
Thread-Index: AQHcHk2ovJSsA+NOP0OoLcFOW3tEX7SEZ04w
Date: Fri, 5 Sep 2025 10:43:56 +0000
Message-ID: <MW4PR12MB6875050BFAB0270A51DE72999103A@MW4PR12MB6875.namprd12.prod.outlook.com>
References: <20250905101128.3058191-1-john.olender@gmail.com>
In-Reply-To: <20250905101128.3058191-1-john.olender@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-05T10:43:46.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6875:EE_|DM4PR12MB6255:EE_
x-ms-office365-filtering-correlation-id: c98b43a5-6a3a-48e1-a193-08ddec691d8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?SCJGZTVBgHZKHC8AIffsziOn3yQEt121UMuQOg2PqYHiNz6yufbKsOP0RPUp?=
 =?us-ascii?Q?KAF2/Km2fwXYcgHQI44ZIbmKrht5tBD6HHvbY3yFOIsCsuyZBNKR4EnKLrtv?=
 =?us-ascii?Q?MDs3FAHQTSDAePykFcYKBVrgcNB6Kz2YVJpBNYAP8EH0sS0HSfZwdZjGhs6z?=
 =?us-ascii?Q?MFzzfBXf+2xZEO+3EDlaYkSlUmgpYzpiNmk5RgNJhA983WbceAcptHvdhkfE?=
 =?us-ascii?Q?OkXTOUbt95BecdyBJPfzAh9Nvrifc0cGfzZNYgMU5w5aKDIkMTEKELph/dlJ?=
 =?us-ascii?Q?T/mbzFxk1IvqDUFRTGWklh0iIXZClpUlzn4U7U+XbHofZrT9IWo+bAKiBUpe?=
 =?us-ascii?Q?kA8CV8u+UtUYIlxy5+WwC6VZQmKiqj2Ecuzxyoo+V2pW19RcmEk5sfjpN824?=
 =?us-ascii?Q?R/kzyRqAtklC4SB1wB4TUT3XQIVCxXnMAxKuQ9LVl9YHeiytrc3brOfGjZY2?=
 =?us-ascii?Q?wf1xq0ExgGMPWzJxnOctKoL2rrDTmvvslkXcy8tSa3V9tuP/cWeCnwin52+N?=
 =?us-ascii?Q?0to64J+KfA6zWt65j/APhVYChc2ijez5CKRynTk3SRHIzyhTi3Nr0WB7fQYm?=
 =?us-ascii?Q?/M3DZhH91rTQzQDgsjJBVgoPTwSgDntQrzYnnkiNi7zD70iznBcMYwFim5ey?=
 =?us-ascii?Q?uFcRKUzEYqLkMywWvV9h/0xNV7ANguhKLmVNlLwlytBdiGfdUa1ytipTlmt1?=
 =?us-ascii?Q?FpyBTIMxpdCT8Fts0HXp/EPFK57EmOnTZkbCueeIuxzboZ/ThiUJgKTzpF/W?=
 =?us-ascii?Q?Mb5G8/1lanhbLXu8exEEr8O/CmHS2wbzpxlwaMoGBKfJQJ+mPoPBaaDsxXGV?=
 =?us-ascii?Q?nR28+d8hkXcvd6UgAufD/gJYUS5fOL2GmZ3GzopErjpeK2WMTO3i3Db41k0b?=
 =?us-ascii?Q?eDDgMtlkoezsYVjKcerdIpYgvmcQjIPJFSOFqJgYdceHJQC3S0X7tmjokQJp?=
 =?us-ascii?Q?c6FieBAvT6xjeS+s1hEfPO2zSrjZRWHFvUGwIFebn7io0zffiaP5yoGfjKn8?=
 =?us-ascii?Q?w0mcq1maUjsxg9BGayUC/c2mt8RLowpc1ljcI2eGG4ZcLKzP9tIS/5tXf/o2?=
 =?us-ascii?Q?T+FWPRJae/h7AazEqLZoGulDZmmUlSvHruXtbaSt9eDERjGOjgbAs77LSU/h?=
 =?us-ascii?Q?P71xmGMzq2nHfllQbFR6W8TSlfs3iqa77fgZkP2ebCam5gq3v6EjToHGm34P?=
 =?us-ascii?Q?gG3Xm0EGCWm074cVBsyQdoFxJAvKZATxWlcoDgubISucmubwe0f7ld5csDK6?=
 =?us-ascii?Q?ZhdQcfV++P9iCaD9j9ZaEgvV/D1+V2F5gJvwmx2cwOvyNhkBtPDa8pKpWhv1?=
 =?us-ascii?Q?D99IZiK4WBTlZ1EgZWgp0DfCfdYiyhRbWPB2suw2MWz6/Fp8Mmkv9ZM30Np9?=
 =?us-ascii?Q?3qe+WcVHaH4lRUY5x6ZXoWtqDXhYrJJdgRtGW4n5iCtyTDNoy5+X2OhOM9Jk?=
 =?us-ascii?Q?cH1crOxrAtET5Q6KTRhzPe9UfTdkgJbxQNZFSYyruSq3IzjTmQ+KgmecNtBr?=
 =?us-ascii?Q?cr257vfmP095f2c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6875.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jwdiUqOx5UAfsmITghrGftZ8CodfE23cXxpHoKpxQbGrOgHC9jBWwWpZ29Hh?=
 =?us-ascii?Q?YSwSjokv9Kmutq5s30lBQAoV5S8/Qq6czCUzoCFxN56eprN17EBDE9sixCLk?=
 =?us-ascii?Q?wG+gco3iw6feI5Wm8bL16o1/WxzoFdgVO1Z6OjTAR6C7tK6fpjPoLFOhuEQe?=
 =?us-ascii?Q?B0cne7n4kgwLOOGYlsc5kGmQ4PSBHdiokO7tjGHjgkgcvSloZ8RAXZz6lbZG?=
 =?us-ascii?Q?GXQCQ1MlQK+215cfSj+DFaivk5lluwOY4NVNLBGKfn20E9ATa4++I733A4Xr?=
 =?us-ascii?Q?ghEBiNlCjlBAdp93I1Ve9cMCQ42gQDFOp2NrZmpyKZYezWe6WR+B5HvJsbkz?=
 =?us-ascii?Q?m7h/KLEgL0aseRVjC98T1LKSy9rqzHcr1zdjH2q2iLYCUizu2NQD59ysS2y1?=
 =?us-ascii?Q?3mCMqfqa/OabU8WZV8QLt9UL0sPO0rQ8NGqa6fgSX9ocGA9vt/5rxtVWXEK8?=
 =?us-ascii?Q?tZaxhVgJvcQIyekix7I9MkBXpdnoEq8QtHVvqDsi6ParXV5nBcubiEQROjzO?=
 =?us-ascii?Q?BThQDBcWTzgZw8ICtpI14NuMm4SVKAk0/ETwQlgs3dDJeZbZRCcGdafIqsDS?=
 =?us-ascii?Q?rdoTs/IHj3i2zCtqQ7fOOATUERgNwwB4Ll7uR++hiQDuWV2nQ9U+HWMBHPQu?=
 =?us-ascii?Q?yMFA93glvBPjz7Sf1P0u3+UTVm84kn7nvXKpbhFyTUA0ke06PJ/Vto9g470j?=
 =?us-ascii?Q?CFnsY8L6FBGCD0dVrlI36YS0YD63GAoFWucKM2//8gtyKfsHEg0SvcbRfcLq?=
 =?us-ascii?Q?pZ/d8kLfRpZ1jdhE5jQ67o/FHTvuiYDISUYa0EnkWP9oHBCOOq/fn5XiaSaz?=
 =?us-ascii?Q?otHeIfZf/IhOIJWqUpmyARmHQuTIxU0i8N4ek4p7lHnx7ph2SpFNDVUghWpr?=
 =?us-ascii?Q?MkBjqGRp1W8p0hn6Gb7sBkzIVPqinhDb/to2hzpoJzXKHROJyAuqB9V6vUgB?=
 =?us-ascii?Q?Z+Yx2gFFsm9Zp+F7hdOjkyCx5z+BebAjO6+ClTwKWj3l1lWxinGNwTBxdcmk?=
 =?us-ascii?Q?Sp5TUqphtVhvMEfYN1mh7BDCbu6FYOisI9gugEy7MEnIHGutMCddj8vepn37?=
 =?us-ascii?Q?JoikQFQUjdkXSIpUqN1pE4koVPJJNLE2XVP2g0/qBJb2cm0pi6/wjDUNo7If?=
 =?us-ascii?Q?s/Tj3rAXMm8B/ZtjEqcK1w1TPT7RMSDjeVKd0PMT1K83aADSimetYQVXbHRH?=
 =?us-ascii?Q?QrWUvtvURT7exUznucDCeNXuYC3vj6p0mTCingJOhUnqCTBGKeLxUATwCkr+?=
 =?us-ascii?Q?ddueQ8V4fyhSqnS1GfY73LRP2GaQp31iJE3VlcYU/YpfBjmURoBRvyZWnNQz?=
 =?us-ascii?Q?OMZEIuBFddNOJyYYMDKjS8ERSUk9UiRiLQTdFfBlLsX2GX9NwQ2yIcYIIEin?=
 =?us-ascii?Q?CGi0svcqctCScNDJCFKyPOolja46iHVIYVEWURKk+b/jCxiaAPGwDuBGFFPM?=
 =?us-ascii?Q?Rn5iWO//uA6eZp9RGNcNBOxBs4Iteui6oyrvuy6BCqh3FbXghyeDwRzTVwm0?=
 =?us-ascii?Q?C4tYFNqD0KAbzwyGlJs5CxzpnLcKndE3O446NpGK2enfHz4rGr/RJhjZjCav?=
 =?us-ascii?Q?Cb0UtkEa6GZkc9hZzKA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6875.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98b43a5-6a3a-48e1-a193-08ddec691d8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2025 10:43:56.7663 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3nXMvI9rVEhUaM3hC97YBjkr0zS7GrDl3U8+AhaH55h3PrGm7+cW/LIxttyrIPX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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

Reviewed-by: Candice Li <candice.li@amd.com>


Thanks,
Candice

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of John Ole=
nder
Sent: Friday, September 5, 2025 6:11 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>; John Olender <john.ole=
nder@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix NULL ptr deref in amdgpu_device_cache_swit=
ch_state()

Kaveri has no upstream bridge, therefore parent is NULL.

$ lspci -PP
...
00:01.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] K=
averi [Radeon R7 Graphics] (rev d4)

For comparison, Raphael:

$ lspci -PP
...
00:08.1 PCI bridge: Advanced Micro Devices, Inc. [AMD] Raphael/Granite Ridg=
e Internal GPP Bridge to Bus [C:A]
...
00:08.1/0e:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AM=
D/ATI] Raphael (rev c5)

Fixes: e5e203e0cd53 ("drm/amdgpu: Save and restore switch state")
Link: https://lore.kernel.org/amd-gfx/38fe6513-f8a9-4669-8e86-89c54c465611@=
gmail.com/
Signed-off-by: John Olender <john.olender@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 7783272a7930..ca58cde66446 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -7148,7 +7148,7 @@ static void amdgpu_device_cache_switch_state(struct a=
mdgpu_device *adev)
        struct pci_dev *parent =3D pci_upstream_bridge(adev->pdev);
        int r;

-       if (parent->vendor !=3D PCI_VENDOR_ID_ATI)
+       if (!parent || parent->vendor !=3D PCI_VENDOR_ID_ATI)
                return;

        /* If already saved, return */

base-commit: 035edba1e204b302ae74269d4f09e355153a79ac
--
2.47.2

