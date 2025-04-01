Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80429C36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 13:02:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D15A10E59E;
	Tue,  1 Apr 2025 13:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gL8F24lW";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2080.outbound.protection.outlook.com [40.107.101.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D22A410E59E
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Apr 2025 13:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeAymTucRZ2ytWLlMz40Zb+oATcqKNF1zXYBft2VgtD62H7/YzS/P9Y1whUnhU7CWTuxVeoJPwU6iZ5y8D57/bx2T/451jKRyycDeV0RWFMEaPZ77nTfqsnXAT3hYcFII8AesElcrSDFlWrSKXfDSboGSp+mwasGLK1vEk8DjU6QMQtScaP40851jb7+CsHZOPeboCx6OaLANYn4WVeweBeSqaTu3uCKOF8ETH3q7iRxd+ITkb35xsNebPIlIJpiBtjdkZZlYJl7CBld+VkV7A8wUxPmoLBf2TfR8fADOOQ2HTGrrLpU+tLVNaxbsVEUf6Ont3grSDXo0HGiCK0KpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixJfJ+jK04kds0d4qccpLXChgQJlj19y1xxDMCjz4DM=;
 b=iFtgJjg9KOzOfoNITyQ9QWJj+BIR8SlXFORMM0XO0DD4lgg5Davghnn1TwibvGCYhs9zCrXbSGEqWBUoGnoOvYTzPixMziqWB7GoCOXqvQ+z3rD4syLc2WjID9063M/AMd/uDIytWP5XySHq3p17RyqsQebHpkRkTKsOz0w2xdyNBYDg7Co3Esvq6KT1umqAqYFXqYvbwoo1Sqz21Y6CTpDQBouuYRuWPY2oYTfty2vEr6sVawy9C+Ka+NoQtKXZww2i8a7WjmRavX8KF2F+0y6VFQjG2u7LhECj740KI+ArVGogTl1IKh8iXGwCdFgsuyXzWlBDNLXQs5XXq0lliQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixJfJ+jK04kds0d4qccpLXChgQJlj19y1xxDMCjz4DM=;
 b=gL8F24lWIH2TnhfOUtaASHpHo9vghW8vPSp7+y6bL/m3tguF6MND7pcbrCnfvob+0dMRAk0WdywrOv4F3jWLEh5oMH/vLQ3OUQ5M0R1qLMKZ7L3ijqfKEoVnULxHdpRzU/s8gH1zGDVTJmAJnsqw7HVXVOi8HoqWlWk75HdGXBE=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.49; Tue, 1 Apr
 2025 13:01:55 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.8534.043; Tue, 1 Apr 2025
 13:01:55 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 2/2] drm/amd/amdgpu: disable ASPM in some situations
Thread-Topic: [PATCH 2/2] drm/amd/amdgpu: disable ASPM in some situations
Thread-Index: AQHbot0qq3ONoLSbpEaVQhDc3PFcp7OOxqxw
Date: Tue, 1 Apr 2025 13:01:55 +0000
Message-ID: <PH7PR12MB5997BDAB32773291296988C082AC2@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250401080742.816734-1-kenneth.feng@amd.com>
 <20250401080742.816734-2-kenneth.feng@amd.com>
In-Reply-To: <20250401080742.816734-2-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6a1509c6-841e-4343-a5eb-391a999fb091;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-01T13:01:36Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB5757:EE_
x-ms-office365-filtering-correlation-id: 4ba1fd1f-6a3c-442b-b7db-08dd711d60fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2BqzcVnnye/sr2Z8+u19029d6kTuN/2245VYHHNqttSrGBSDRNYvxEWvQ+bX?=
 =?us-ascii?Q?lNHGDksHM2iahJLsdWgUc8CMSosqtBt8YdsWeSVlCq0XtBXTbrxmYwiDQohm?=
 =?us-ascii?Q?rewmLJBrwPuS97Iq7Bh1PKZBWXymgaC4a7/E48wR9h65fdpM4KFJ1/juu7Km?=
 =?us-ascii?Q?fY4Tyakh0LVYgwXaBbRd8RLdfmCQi5cEFoNH3GweLNCloTviyPzFqO+C/cwj?=
 =?us-ascii?Q?fa31DJkSS5K+xZmGdXXTGCinGkpBH6ZSTeAhjgdwpAIy1+6VpJUW5a8m2hUf?=
 =?us-ascii?Q?JkoUUppNCqU4avoPbxesOSEYeDXQMQiIx+m7+k40/ThJyvZfWjrhlo4CnQAy?=
 =?us-ascii?Q?DLClIVtDMHbakORprTQk2Jm9GjmJJNJDn9nrlkYUEtv9D0ywrQ2tiHAte9ee?=
 =?us-ascii?Q?fZ3NE+PmYzo7YaVqNR7F7+M6U2uvqWUsfEf175TipGSlMnNdxsKPwjgNjggJ?=
 =?us-ascii?Q?FLmukb6EwgRWS9v+aIoC5q+zJAbiuCZSZFiwkD/DhV9Qcb3oADdfCZQz2tDD?=
 =?us-ascii?Q?45+NvOKa6aOqSoGHUKrSUo0M6oxSidED8wc1BDHhMHZbF3pCS6OaNpmgUH4D?=
 =?us-ascii?Q?CFP2/Qu3Jjhw/UO2mX/OYHS2x56AIGQpTWsj4qFpia2C70WCz6V+91QftYe/?=
 =?us-ascii?Q?L5tpbIqoDc+blURt5qsiN33GDInJhJwyUws9DDyUADmcSqC6h9xoTpr+e+FR?=
 =?us-ascii?Q?rFDM+87hT2bbMUotYugVjQ8sksFQ8Lichr4CeLkSMmI85sWW5E2SX1v6h0BK?=
 =?us-ascii?Q?g/LIHIQmRqzrmwhHXbw8u386GIauYeehfENSSSfeOGx84G0MakAXSiyl2j2g?=
 =?us-ascii?Q?bOV3I/wc6Mdq/ywJvlRDM6+kTjZhfd/pjtVx5F+R82evZiBvriR3j2z4mlux?=
 =?us-ascii?Q?biZfTzTTKjoQ06m+Un6W5IPhI1oSq+Cx++3RM8nXrhL0W17awfhVSFAmOXgO?=
 =?us-ascii?Q?W0LgJBkNz9dWYPgtOS/Zbw/IfZP8NK4H/cgIMcXGy3UqDHltOqVBmz/suy0s?=
 =?us-ascii?Q?B4iPKV7lRIBWmiTbhN1hyROA+XFs5tKCLlnda7oa11227X16516XzBA6dIgO?=
 =?us-ascii?Q?VH+fCv+NoFp8SiAScOfhkO6WyKQxlfL/qsiZ+VgK4H568UgHaPo3r87uEEmV?=
 =?us-ascii?Q?UIclbswetEQ3h6048F8q71gBPfrLoIJ19y/RmUXFJ+/0gB+6E/gTMH0BVVj1?=
 =?us-ascii?Q?GCFbt97kbkCAC0GDJpcdnILsQ6qzvU84ATVJTaWS2nT+Ibk0ikjw8mt2KDMC?=
 =?us-ascii?Q?XTGqO5pbqkScicKg+kPoyvqPOotIJxE4aRkgAB3CPa/melgV0PSoMooTu62E?=
 =?us-ascii?Q?7FoiHq0NDq+gM288ieoWI11pbdnhHvJ2F1qbE3AGO0nwRrYhPJbkQsue8bnh?=
 =?us-ascii?Q?w2A9Q36+8E3BrbGJueafCpIdT71ZqWOsJ3j/f1huayMwtFYhR1VF+gKSGbcV?=
 =?us-ascii?Q?M1dRAW2krjd7PXJMiasRscEDP+yl+pex?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gcRtzVQl0pc0h9Rn4jXJv9aZgbhamFcR2XJsbVkTjKtGZAHaNiRDThMhrNUL?=
 =?us-ascii?Q?EQvQRPLt44j1rwKVNJhqOdT4RjESVWnG6a2aALIkJeKByzV1WELj0GGSVJc3?=
 =?us-ascii?Q?awfzHtvNVj9Vq1ZFADimCYRAeBLWYjIdA/8zNhUzKCviAsGIGWfEnfpz6sJv?=
 =?us-ascii?Q?sh6NvXVbRyb0VNsDit5YakE0hl/ZeBaY0BN83O1R9+N6aY2RgQTAovMC0f/U?=
 =?us-ascii?Q?FRLcrfIb/xnBvt0muwKZ/iKaRsr6wFmoveC8p7B/txThODoNYhJKTKhX40s6?=
 =?us-ascii?Q?2sVgMS6PZ57baX5vgPGstQBk5EO4pVk2cU51cCPJjbJR9Q8ephhL3XeYlsCT?=
 =?us-ascii?Q?0SRM0m016nF5ZcqcfFQ76DzwEOea1ilV4NpSYDfyv63z9pJFEuATvVlGMQEA?=
 =?us-ascii?Q?goroxHAQ3nRaowpzThjZ/oxKFNmdLRO8iCCvPqNygOiqnKEHc1J/kopzAo9b?=
 =?us-ascii?Q?UGz4dwcol/Hnc3JjezXmZ7qitJJ/fjLon8WKXvqOZ9At2TbqVxl8W+cDY8qi?=
 =?us-ascii?Q?Co8tSmQzAxd6lSQapT91l1JJ960JVCIlQ3GE7B+0FPmBJFK5q1L/jZRXaa8d?=
 =?us-ascii?Q?+WCVv3s0W3RLyrP2RGSWmke/fydsitePeXh0OWO3TO2/goHD+QateYBj5e7s?=
 =?us-ascii?Q?7DUzEIbhUP31bEYZr9rN6JU7fJQMvcN/2b9H9Fuoo1H3Zq9AHv8Fxyo24oHX?=
 =?us-ascii?Q?5F9Qs1e276uuaiErcsgPwaVDnNf7yvp3lZRqSNa9kdks/3LIylU3OQiAUdcA?=
 =?us-ascii?Q?Pha/rISNrvK5pAjfc9X732+mehAooGsaHK5Tfg8yPm8UP27yfP7Lz9UVtbWB?=
 =?us-ascii?Q?0MhPRq0qAklbgHDi8xHSxzfXQ5f+S5WyoxVc8tHR9ADIwMig7AtPA7W8BWBB?=
 =?us-ascii?Q?2gPVaEWOlOLZOh2RQNTaWFOwGUKqGnkS7Ui/jOB0vvN3XcpzOwrp79KZS/r3?=
 =?us-ascii?Q?zo/XfLmqGlE8HK7fwzVL8KtECMkia7dl4aVXLiyiFzBg7K56/MvPNic7EpUg?=
 =?us-ascii?Q?ErUHcJC1z9l+K/vqjDOW7CRvOLQIvhT+gpg639doj6eZbsPocjg8JwZO/wx6?=
 =?us-ascii?Q?OOS+gbnEQ8DcZI3SQXWvBm9lPKyRlP+lwa2KBwf0Q7GLxYfH3DBhgYSQ8LXP?=
 =?us-ascii?Q?icbO4FRlceGJm2TnyiaiBtp4TfyR6wHTJlHFhw7W6udwKkTiPMteij8HJbGb?=
 =?us-ascii?Q?tyKEDGpxbXhAWSAqj38xUsjPObiOjpY7zwBOFLWHU7RPruWR2Y/Y5R/4Xzni?=
 =?us-ascii?Q?pj5As7U62ZuE6kFyL1CfejF7DOeMcl86gJk4tC1HKjp/jgVVGGx2XxGKv+Y+?=
 =?us-ascii?Q?+YYVCbxG43XzNFJBOFOLtXEiMF3rwC0JGUbKT+JcpnM/PUxPShtEjGTKcUVi?=
 =?us-ascii?Q?t/67HdQKzSjsu9qZdOQx6XlrzjNoFFPpVLQrs5DEBJZIYF1K43CZsfQgoJ8e?=
 =?us-ascii?Q?EsxCJl5BYbfJbYKAmHUfKAneJzVorwoX2L3Ja7Fct5hm6MPg1y0R492wJyZL?=
 =?us-ascii?Q?fYwm1mCVIU8XzyAvBA4SqTU0Ik4+35RUukpE3bJu1rddp8mCmV5K3ghiFMYV?=
 =?us-ascii?Q?pzWBWK4sMwYrtk9i9sY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba1fd1f-6a3c-442b-b7db-08dd711d60fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2025 13:01:55.1037 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3RvRLA0CEvShXlc9DLtLdPY8nYw+cW3rdTtJ0Hx2vM/YDp2GGJTgV7OFd63cnmc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5757
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

Series is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Tuesday, April 1, 2025 16:08
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH 2/2] drm/amd/amdgpu: disable ASPM in some situations

disable ASPM with some ASICs on some specific platforms.
required from PCIe controller owner.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index e4793e56cead..091d87ff236f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -85,6 +85,7 @@

 #if IS_ENABLED(CONFIG_X86)
 #include <asm/intel-family.h>
+#include <asm/cpu_device_id.h>
 #endif

 MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
@@ -1873,6 +1874,35 @@ static bool amdgpu_device_pcie_dynamic_switching_sup=
ported(struct amdgpu_device
        return true;
 }

+static bool amdgpu_device_aspm_support_quirk(struct amdgpu_device
+*adev) { #if IS_ENABLED(CONFIG_X86)
+       struct cpuinfo_x86 *c =3D &cpu_data(0);
+
+       if (!(amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12, 0, =
0) ||
+                 amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12,=
 0, 1)))
+               return false;
+
+       if (c->x86 =3D=3D 6 &&
+               adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5)=
 {
+               switch (c->x86_model) {
+               case VFM_MODEL(INTEL_ALDERLAKE):
+               case VFM_MODEL(INTEL_ALDERLAKE_L):
+               case VFM_MODEL(INTEL_RAPTORLAKE):
+               case VFM_MODEL(INTEL_RAPTORLAKE_P):
+               case VFM_MODEL(INTEL_RAPTORLAKE_S):
+                       return true;
+               default:
+                       return false;
+               }
+       } else {
+               return false;
+       }
+#else
+       return false;
+#endif
+}
+
 /**
  * amdgpu_device_should_use_aspm - check if the device should program ASPM
  *
@@ -1897,6 +1927,8 @@ bool amdgpu_device_should_use_aspm(struct amdgpu_devi=
ce *adev)
        }
        if (adev->flags & AMD_IS_APU)
                return false;
+       if (amdgpu_device_aspm_support_quirk(adev))
+               return false;
        return pcie_aspm_enabled(adev->pdev);
 }

--
2.34.1

