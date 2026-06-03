Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE8A0CD6E55
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 12:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAF510FD45;
	Wed,  3 Jun 2026 12:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VSINBV5G";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F43810FD3F
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 12:29:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgBA+SNL0msYGS+B1QNkoZx7HIUOfUIp4H35ePc4Hd2KWsCkrS7vhqipa+NwXrgPIRJI9LIq2AOM5ZXQZPP6J0CpJYoQZyd2RNwjOEBzSqpUHztpXuHMfjZuJwkGdgT//fBX0Z+XLFjEaanhMTrLVE2Z5q1p6ZGdk1mjPlnok5sK4CbhRYQqOBv4oFiDW4HKicECT0ytj/A6ql/XHQjdRapq3i73CEHvlUj14YcjjWQDl0FkerZtXYhXKyCBLTy46luDejONM2Syu1enKbx3QVi4PZsvAP3aaGgyXxP4jeJdKtFLY7OlDZEa91+MZW65CMZK4ozBEdfJs2wMKDJC9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQGASjq/YBoRsytiMnB1XKak/7wFEhsq4AhbJRmmrck=;
 b=jjBlHKpAgkcFAW56DLF8qYqz5D+kZV41OunGM0pmKitGL2JOlkBKUop8y1hjAQx9zr9Au8hhAWjAonZei+0Gn24EYu9AKjTuHsWAuuYgtPfE0zeIMqCHQkOJEcng8EtU8zLds5S3jO+1R+4Gf3Bb5SLnFOzDxHRwinY8Bh5ijEtwklYln3O3TyRAnfAPx2UHe0pnXZkumatPReCDicY1hQ1AX5oqzhxzYFWzMDaBFY15GHEmbfVE3YvPGv4a0+iEf6s2AMbunCJgT8TaobZyeXJeJi8SuuUkNqPuqv73pkf3reyzcHv0sflBhhB7Ttpvi4mNnUpZ+szWN/e+n4ZneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQGASjq/YBoRsytiMnB1XKak/7wFEhsq4AhbJRmmrck=;
 b=VSINBV5GNediHB3ZKTGKoTkw6zjATf/EqfL0S0+wCTnw9PKFLG/m3c1Dkztxrs1Q9r4UJFtcVxKz4hOgrCcCn7diA8/dFK8V5+HGq/5/RwiNj0j8JKZLb6zUVARYLjId0TunsThLBttG4SmthZCxYj932T7d5T36I9Ijel/C9G8=
Received: from DS0PR12MB7993.namprd12.prod.outlook.com (2603:10b6:8:14b::14)
 by PH0PR12MB8005.namprd12.prod.outlook.com (2603:10b6:510:26c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Wed, 3 Jun 2026
 12:29:55 +0000
Received: from DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41]) by DS0PR12MB7993.namprd12.prod.outlook.com
 ([fe80::2151:86cd:773:eb41%4]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 12:29:55 +0000
From: "StDenis, Tom" <Tom.StDenis@amd.com>
To: "Kamal, Asad" <Asad.Kamal@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>, "Zhang, Morris"
 <Shiwu.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: Re: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Thread-Topic: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel
 lockdown
Thread-Index: AQHc805zf8Zn7hLA90m4iw4KUYKpfbYswmdm
Date: Wed, 3 Jun 2026 12:29:54 +0000
Message-ID: <DS0PR12MB7993177B829CF9CCE0BA7DFEF7132@DS0PR12MB7993.namprd12.prod.outlook.com>
References: <20260603114459.938031-1-asad.kamal@amd.com>
In-Reply-To: <20260603114459.938031-1-asad.kamal@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-03T12:29:54.421Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB7993:EE_|PH0PR12MB8005:EE_
x-ms-office365-filtering-correlation-id: 2f74bd14-168f-4848-d6b1-08dec16bd14b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|18002099003|56012099006|11063799006|3023799007;
x-microsoft-antispam-message-info: Zcb51O1G/bz5TkxEnby0+j5YdgitHFAI3N9js2nGuReeMq4xAtpy5ACSbUGfVcjX2ae23+HRFSpqyLo7fjUn6N+FERumdZLNh8+fHzbwVCmrV/hwgCGkX79uioEi/WYn7tTzK6vtTxuM2opybHz53ahtCcFnJueBW4uIroiHrvcradzI/SUJqbxEcxe7dwHwJaWPi7iYI0clsrLII2XZAezTh/DC1CJhbDmZMd6Q0kVZ9ZmZdwvZzHsCvmFPWAR08y21zbvVfsJ27SThxbwSKaYbuAWxAzISxeOjZSE0eAXuTfWZLBDdnSqS51bOEHHJbnSG0jlDMbbrNF0d0Y8V/GROLa2cpz9dh/i3EAnk++JMWRkYWMW5fXHC8lFO1FhZAKCJ2qiXZQhAQAArERqfLRfeEMYKLZWUf8uMRixT7D+OVjiHCd9pBOBoHlBzNNQ6UyLxM7FuHUIoEcmTb3vNqQ+Tj29uoYXoG6wPDCX3tdP7HDAEzTuBDYV0ZleeDw1VZ3MuVXzE2WRZiVwvH1ubCynm6eQJnH+MADqo7wyjLZ0SefHn96zGmJU7NEiNm/hhDDBbUOZsqklZSfHUyXD3u/BGoWLZkw5qa2CaBwSVf5rS/QJ6Q+ydefnHAtm6ev2YN5DzDnfhg1d9C2Y8wIxW2BNZKCK+wuWj1fAuoeDhOApMj88JvlmWsgZtZDlS9jg4HNyncH9tWmC3N7vNenx+MHNAuCh3y8hNPsv8BxADnefnMdHB7OJ7yiR88QcRZTqG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7993.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(18002099003)(56012099006)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?JpTAa9t7vwloNobWg90i9re2qlmYj4vFoNKGWsYoyY2P4ZP4tK/uHuNutA?=
 =?iso-8859-1?Q?6UImeDQ3OIo7Nq786mBcDOcRY9HgXDRJv/25eLRgroo8ELN5mdenSsBi9x?=
 =?iso-8859-1?Q?XBmApDw4PY8KTxy0FB5S+asLJ+CicY9cKkZDByIlEKuRjQ/yxT4fFQjV4s?=
 =?iso-8859-1?Q?g6HGr5wbZoLkpoNJfuO9g3iYwDn1Cs6D2lA5l7qrcpvcsf8BP2V7cR3RLV?=
 =?iso-8859-1?Q?/isYVS5F7cwDwDIY5JUH3Vv7a0K1Udt0ZUMatxOd9kXtuPry8wCuFUwCrj?=
 =?iso-8859-1?Q?tV3zvACzNfvAerGI52h/ukAnG/YaB2RwTK5juv3lgdrE9lCMT6H0/8FB9+?=
 =?iso-8859-1?Q?pjwOYgj44ULAUFQKP7sv/ohEXluP8UlBfyQajNkaXllOu8CJ3mRkmEk72J?=
 =?iso-8859-1?Q?I2cnDBK/LANpv3OZ+cp03EkD185WtIu1NNFS7pVNDzdzh29sSWz0mrsPls?=
 =?iso-8859-1?Q?57AAE3hZU+XAIjh7EHfq6syUsr0JZqutUiySJ1sNPrCit593jBFr/K95vO?=
 =?iso-8859-1?Q?PtVew0ODwMYpALj7DWc+ldRiNUsph2eWVIeVt8k6SW4Et0Y3IgFClQ3hQX?=
 =?iso-8859-1?Q?i+qSThPoMEjzcWVlERxAWHFAUFAR7V3dx5Y+KaijRaoAiPu6XIGLyS7J2/?=
 =?iso-8859-1?Q?nxLRP6XX0FTAjRYvBQq+hCqixD9DQjpN0D5HO+lyQlsF/8MRRUQ1Uh3kDy?=
 =?iso-8859-1?Q?4++8zU2FRCzXcy6M1cDaiO0ZqcAqGMhXBoqmgRycXvJdqlDTchISM9dwtU?=
 =?iso-8859-1?Q?3CqG39RyJmAguiX1SZXm8Lf6Pje1vueOVHgEgzYJr+Db+R1r99QBntqxlM?=
 =?iso-8859-1?Q?CchyXAv3iAVHj7PcB16GsKV6KYPcsDDLdHubjErvzDgs3+/L9N+OY5Q0J+?=
 =?iso-8859-1?Q?2Yt6nHJl4o7DLUQ4QFmy9MkKNAqyvUk/FLTF1L6pMOi9gghOnNGxHDUbuj?=
 =?iso-8859-1?Q?/Rb8usiCuaAy3ucwHDER57VtDOTaYBxCwOaN5vVYuf0OhL6afyNXiG0nK8?=
 =?iso-8859-1?Q?NJIHUbbZsFapIBkH1/l5lOKr/jXtjyDgLQFv4Ka8pduQtI09w79fwoWC67?=
 =?iso-8859-1?Q?bL/K2e1rbxLsGCBQNZiFhBQJwDsI7fB2y5M73WclKdG5SbU3dWBe3dTKpv?=
 =?iso-8859-1?Q?UmJAat6XxHyM9A1QSp5PzF1D4Bz/Qh1oYDM2Ohj6fsdYIqTdMQyRJM+Afr?=
 =?iso-8859-1?Q?I0hrMTorSEkzW4UQ82qvfWF/xu2A3V010sudpncDFwoPACuefs0PGgLXwD?=
 =?iso-8859-1?Q?1g3iayncwcOBf8d7gzhKHq5cq6qDlYjGKfwIIrpR9QBkbazM6EBySDamxl?=
 =?iso-8859-1?Q?EVLoa6ag1LVjI0YknGWyYnRGpAacbTs+pIUVvEXSDzRiHWixThgm38Wc9Z?=
 =?iso-8859-1?Q?DSjHYsbr0mNLIo+msI76tJQBlVvJt+B2I6FRiQdX7RmKLqs6V5BZ180On2?=
 =?iso-8859-1?Q?/OsGrvhO+Y585RQEmIbiXDFJ86mRhaFcagt4lbvBXq9Zna5NRJWh7Wz+Kx?=
 =?iso-8859-1?Q?bu62iS5WLTzRpanASTCkF7eG3tPD8DdANIJbjvaREASwGCQcUejXrD9zt1?=
 =?iso-8859-1?Q?ybWaqZr5eR8hsRhV04UgCstBP//etX8U6tUODNxBhNYYQlAD5bZtiK4WPG?=
 =?iso-8859-1?Q?rvb72d0Rp+Plg6ggsbU2oHaDwG68TyQPWBsU9Pz0KtyFEsWVefZd3i0aJc?=
 =?iso-8859-1?Q?nDEK2/+lj0+qq0+yI4DMAzBLSM95IL4AWrAL/wEwx1eEEBWp8LOWhcxK/h?=
 =?iso-8859-1?Q?g2uCNEs8NVKKO9KeDwfJpV7Z5VGezhGbNnMy4eBBZmxRWo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7993.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f74bd14-168f-4848-d6b1-08dec16bd14b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 12:29:55.0020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9jqK/iBm3zb3WC6pp96NPrFbqS+Y8po7cWmKnn3aDSJUXNwIeghJ6Kr3a25qFIqegpOgWS3cl2eIO4/w947Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8005
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

HI Asad,=0A=
=0A=
This should be fine for umr.  UMR detects when the lockdown mode isn't "non=
e" and warns the user that the tool might not work. =0A=
=0A=
So the net effect of this patch is the debugfs files are just not created a=
t all?  That'll likely cause umr discovery to fail (after it prints he warn=
ing) which is still fine.=0A=
=0A=
Tom=0A=
=0A=
=0A=
________________________________________=0A=
From: Kamal, Asad <Asad.Kamal@amd.com>=0A=
Sent: Wednesday, June 3, 2026 07:44=0A=
To: amd-gfx@lists.freedesktop.org=0A=
Cc: Lazar, Lijo; Zhang, Hawking; Ma, Le; Zhang, Morris; Deucher, Alexander;=
 Wang, Yang(Kevin); Kamal, Asad; StDenis, Tom=0A=
Subject: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown=
=0A=
=0A=
amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow=0A=
arbitrary MMIO read/write via RREG32/WREG32 without checking=0A=
security_locked_down(). On kernel_lockdown=3Dintegrity systems=0A=
this bypasses the same restrictions as /dev/mem and PCI config=0A=
space sysfs.=0A=
=0A=
Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every=0A=
debugfs handler that performs direct register access.=0A=
=0A=
v2: Use consistent check as per previous check to use=0A=
LOCKDOWN_DEBUGFS(Lijo)=0A=
=0A=
v3: Do not create any entry from amdgpu_debugfs_regs_init() if=0A=
LOCKDOWN_PCI_ACCESS is active and log once. (Lijo)=0A=
=0A=
Signed-off-by: Asad Kamal <asad.kamal@amd.com>=0A=
---=0A=
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++=0A=
 1 file changed, 7 insertions(+)=0A=
=0A=
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c=0A=
index 0ce6e2e4342c..5c4d4ff001ea 100644=0A=
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c=0A=
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c=0A=
@@ -26,6 +26,7 @@=0A=
 #include <linux/kthread.h>=0A=
 #include <linux/pci.h>=0A=
 #include <linux/uaccess.h>=0A=
+#include <linux/security.h>=0A=
 #include <linux/pm_runtime.h>=0A=
=0A=
 #include "amdgpu.h"=0A=
@@ -1739,6 +1740,12 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *a=
dev)=0A=
        struct dentry *ent, *root =3D minor->debugfs_root;=0A=
        unsigned int i;=0A=
=0A=
+       if (security_locked_down(LOCKDOWN_PCI_ACCESS)) {=0A=
+               drm_info(adev_to_drm(adev),=0A=
+                        "amdgpu: HW debugfs nodes disabled (kernel lockdow=
n)\n");=0A=
+               return 0;=0A=
+       }=0A=
+=0A=
        for (i =3D 0; i < ARRAY_SIZE(debugfs_regs); i++) {=0A=
                ent =3D debugfs_create_file(debugfs_regs_names[i],=0A=
                                          S_IFREG | 0400, root,=0A=
--=0A=
2.46.0=0A=
=0A=
