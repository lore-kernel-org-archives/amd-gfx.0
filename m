Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141F7C3ABB2
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Sep 2024 20:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A068110E3DD;
	Mon, 16 Sep 2024 20:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qf9x5bcI";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB4D10E3DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Sep 2024 20:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B5nloAXMBJP9D8DcQbhk4e3dauHB+qAB5/ELRDmcMIyfX5jBvk3+7AJjQKqVMRZsLWo1PefHFpmw1Ga7Od7+fN4QiTo1cNwi8KVeVHcDXEIXSWb1FCZCa0Fp9e/8y/OkUJLqNVmzgY8dhp49Gk/b0W3B9LBGq+7xlxQgoo4hFkejaxSoHFym5J4SnBMg7Q7/OiHn1aDuHAubvgYMOgLNDDrdQufzSm5w3bllSHkKf1ZR4irQrpGIjRh2LmxFOroeyNMnk0NLVFB8lD13vngaJrJAZAR10afCGFN5ztrRQ7biAnZ1lMjfTnQKLz2OI+1fIV4lry+9e4cKd1wwDUF55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n828PAGhw9MwURLtruy0g49BzavNwO4DCPy/2Hr9eRI=;
 b=hHk7VVh2tBHzSEDGcj8Q3qm3CXfhwQ2u8Zqs1x3qVtGoIZGGLScmQtrfha4LIee2Qq/qkU9sX68pRQdxcQsO7Oa/IMHIxiKXAR1rlGQ1H3Ogacs48IXeJhgkt/Flu9vYT+EI9g0aqRylZOzYAR4fbd1/vsx1VRj5GA9uOSBzfRrRuqDG2Q4zQTMWZ72VubTc8dvvnqv5cJ3mONjTysPgUwhssHLoC7RBQyX+xLqgqGYFQi+Vq4YOey82Z+jWjtp87cl4PxZu/7IDOijd+qEqRb83WStJJCUICbmVomlRRVrfKUdQsg3hQEVehyW3qinhJ4gBgWiFOtsmEl3cxDJsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n828PAGhw9MwURLtruy0g49BzavNwO4DCPy/2Hr9eRI=;
 b=Qf9x5bcIxfbx7KMrJNuoItaFRchs4mzSNrfIwD+b4ntjqE3v7AbzrQOPznlZ2IZbvDWDr8wYt91+k9J6uJUNQVyGNtQ/alGjwsbDQJI3LB5vbQBJg1yr1ZQXqcXpX/APlpjBmSvXi0gpsL0kvRtEwG5AiMATHu57cqcLLaiv1B8=
Received: from DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11)
 by SN7PR12MB6930.namprd12.prod.outlook.com (2603:10b6:806:262::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Mon, 16 Sep
 2024 20:23:08 +0000
Received: from DM6PR12MB4481.namprd12.prod.outlook.com
 ([fe80::2f5a:1dde:a3d6:942f]) by DM6PR12MB4481.namprd12.prod.outlook.com
 ([fe80::2f5a:1dde:a3d6:942f%4]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 20:23:07 +0000
From: "Zhang, George" <George.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu/bios: split vbios fetching between APU and dGPU
Thread-Topic: [PATCH] drm/amdgpu/bios: split vbios fetching between APU and
 dGPU
Thread-Index: AQHbCHNd5ugrZk2RdEeXjTXkrzGrT7Ja22fg
Date: Mon, 16 Sep 2024 20:23:07 +0000
Message-ID: <DM6PR12MB448166651870AE12807BBB0094602@DM6PR12MB4481.namprd12.prod.outlook.com>
References: <20240916200201.1874797-1-alexander.deucher@amd.com>
In-Reply-To: <20240916200201.1874797-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f1c02374-95f9-422b-9289-f620b540c5a7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-16T20:22:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4481:EE_|SN7PR12MB6930:EE_
x-ms-office365-filtering-correlation-id: eace853d-3081-49ae-1983-08dcd68d609c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8mUut/pZPyObvxqYSGcsDpdyjVGIxhORrS9OMvpRx14WPRrdvCPtm3MnSo1t?=
 =?us-ascii?Q?e+L39dT/8M/L0ZiAMNLPG8Qjo7c8FcKHmaeYvl0Bj7iC60JxQcee9e8TNxg1?=
 =?us-ascii?Q?98POtgJG1PumKsxkmzTMR/ggBIWMUe2lP1DObH41h4grmpCWDtC1c5eShq7a?=
 =?us-ascii?Q?rWHaKf9cMgrldigMZ7wGLIzA2wUYfIzuoYUlT91kV5H8hOiak70mHRuZ78HT?=
 =?us-ascii?Q?tnwdjSTG+/hRToBeb3x7xH5CSoLGueULSNKtE9Hl00YV1w8S4UbqaG8BUucn?=
 =?us-ascii?Q?QvzavcM5qVYddeeEELvYMNfF+sirCC5DBwa1B4pYZ4s4vJ+7EWtNCQGj6Nhm?=
 =?us-ascii?Q?ALnExqMUMsQHLXkEjj4zzCteNMdYAi+gOq8nMmtO9mR6DemMtixQF3pVBwCB?=
 =?us-ascii?Q?H8/Dz7RFeomJ1k3mDBiEgXxYy8ppPlmVwlo/iDkGgVTdK4lhCrNYO43fzd+B?=
 =?us-ascii?Q?egjzVTP60csceZEp3jBaUdU60/jKjjXef6/wq6Hsmeobmwf7AmolEmOGlP8u?=
 =?us-ascii?Q?uYYRgyNDEnk417z6z5b57bn8kGTQSagY6BJj2yXiiYTU6danMQkgEY4ZxERs?=
 =?us-ascii?Q?hykPv1wNPhmzBt0CTi1TRaKa6K81gnlla4rUvtZwex5q+iowfJfeMBV+PAkD?=
 =?us-ascii?Q?oLZUsqnSlgkn6okl/KIoUSXZfL/sNyNpeSWWswJVe3oLYMe6OY9ZNNka2ymu?=
 =?us-ascii?Q?7KaDebepSnbwmXiKJso0qlwh7GbAjKi27MA62F3Oz37MicqpHrPzLpAnjR5Y?=
 =?us-ascii?Q?noLBVrfPKeq3TXzcp+w6DxudXOO99S5ubqqi+s+Zg0HXl3PVh0MrxtL/0xPt?=
 =?us-ascii?Q?4dvSq7JYL3f47Vtp3Bhf/SyvJgkBneHnYOVsIvUWKl2L41OX3jjkBOd5hdnY?=
 =?us-ascii?Q?1YwD0fEzKmbtmHKiKHBe0hZGLX+WOzkWtvi2ahNEVM2H5FkKwscx6OC831lY?=
 =?us-ascii?Q?9oofC3KpwHWZqLwbiOQXJQlGacY6T03qjmD+mifv0uLFYXnGd7KeAK/wVnLv?=
 =?us-ascii?Q?ZJb3QXQ+bO5HvWa0VizAXACEvaPHPAV5NDzkf3Sg8/LTSpIHlTFVrbvzBZM+?=
 =?us-ascii?Q?YyfNInvArlkzxvIwSdJC8hmeQXN2nOPWExqoYkxDct+b23KX/wJHbr2dd2XD?=
 =?us-ascii?Q?KSl7Z05IZksV2Z1OW6sbOfoBCenAjR+PikzVdLViUFDz0/sv1pbIM5XWNXwh?=
 =?us-ascii?Q?kP/5TBQjy6iESxP86SEpri1CPB54qivHzIsmbxd/3S2S/z6jxqv9+17e5w1I?=
 =?us-ascii?Q?sK9RrQVZVoVD0dOQ/pqyasb4iWsQgGFsgQTIPbGNOrjZXFhglJrpW2gQEE6J?=
 =?us-ascii?Q?nixjC+kUILHpsWFhwKrLLdV6aM0VoZL3/Nq7qQQbmqEGteYuYx5bqONDgNWg?=
 =?us-ascii?Q?IFJnJJk4q2QDnNz6nF9O67OBFmkybsJ926kKWAtOLxe0HN7CtA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3JK4If0cUpJRwn6zljGVgMuydPKMIgQhOVcLi6HdaTUrkxzJD/wRok1UcCrM?=
 =?us-ascii?Q?bINwk93gFfvVrdsLwNdPjvA4B4SJrPRYwZFd1ggkwzomjxruZA3Sknk5d22p?=
 =?us-ascii?Q?T1Evn1+rmzj4SMd97vcEg43ehRow1waBYww/kfSAo9LWZqZN1XRDgbu9Hjfo?=
 =?us-ascii?Q?ziTdrm1EH+sPm6czb9q66i7H68AggfWFgwTT4ldrjXhT0/2xlldtCvLKeJsn?=
 =?us-ascii?Q?ERHWq1SexNuSlvCEw0pk24xe4ooUN1vfoSg3fCB784C3C4BMSnPiaOuVwmkJ?=
 =?us-ascii?Q?gkcgjyn3IeVgfYjR2S5ofcCLXukybxduM3jY/CHF+92NSwIc2Rk75KOj1/TK?=
 =?us-ascii?Q?IRpQQOzuzCEBg0FTAQLSJOScKMkAJFDAcGjjg2Iq7AO1nkm9LHml740ZB8Eq?=
 =?us-ascii?Q?hCpT486brivjuX2mhVn9z2ZXhWRqpMMOInJIrc6Ba716Gf8B0fGLAQgVJT1P?=
 =?us-ascii?Q?MGN7hXEvgmyFziZvTyTzk3vfpK3YkughpV4YH9dwP733X98Z+5+ruIs2PHAv?=
 =?us-ascii?Q?rLkWURhBHPw1wt8CBF8wIdX4kYaOc66vQgjCXYrAHUc1hWjj3uNAzxYA7rLR?=
 =?us-ascii?Q?VhqxIZEWyQMzXzNT1bzDC1Mo5p8XT3a74GjMlYcWyNPA5isdZ5n6+Y/FuLHf?=
 =?us-ascii?Q?MDSXrBHSFeSKtabFVTppnFWdVZLX33KFiB8Fj6gzwOoHAr0phVMgGoBx5Zan?=
 =?us-ascii?Q?DqwXdn10h2D9r2xW0x6sgf50UdciK5gn/m47L2dIzjLJYg0I9nKGBamMrzde?=
 =?us-ascii?Q?5hHnXw3K3+3necQNqAFfVL0Dmn5mJ1TnfDqQjPVWPlH7TAyHIOtQYK6utKRI?=
 =?us-ascii?Q?wg3GQw5fn5MWoeUbwrEE7i2IWLSBFfwaIbRL5NPlIQUnzmHepOHZRMkIyZq5?=
 =?us-ascii?Q?VHRydkFiy1hfDPI0f00pKA0EPf9IDGxqo914rrnVnCgwJr0VuKsdollOw3Ek?=
 =?us-ascii?Q?J/MFRuIppV3/53SPbzi4vr2Z1c2dGB/L6OS+ZU3RyFny2NE8Lwnv8OZUtU5c?=
 =?us-ascii?Q?I7xsXxGsNOz+Ykam6w7JxOBpNeuiE3UDZlWxaZNmgyrd8hvbSZQn2GHMHdXD?=
 =?us-ascii?Q?lPUf2ApUO0lyyGX6s81nBm8cxt7MzXeem5mtiolTLOJArE7sBll7O3JyBc0V?=
 =?us-ascii?Q?+akyGPL3FZ+yoX5RxuS5AZfOS8jdPuA2BHez/+JaNWUyVDvdZvB72bnDnSaQ?=
 =?us-ascii?Q?wrfFOowNtJ1UKhjtJSudYyhbQyPaDhvE7NbLXNIi6Brj009o2svuWdfEnP99?=
 =?us-ascii?Q?9gQaXCiMtl+S2f+pn8UO2774oI1sjYPbQR9HFdyIK9/C+/6RF2F+bbsp7Bvb?=
 =?us-ascii?Q?GagDNSUiN+eEgLqUe1C8PJuVrIXXCXwstsMIlIa5HXwgMoU/uGcMOfUZZVaO?=
 =?us-ascii?Q?ZN34rEGGfXjAZMoibWyprwjbTHR7xPmJWz+jBt17KysMKHwCHcGrBlf2m2ku?=
 =?us-ascii?Q?PQHA2y01z1pPUsj9DAZij3TpE+xhqKh4VVckcT2z8fjBENhPuA4VcnvCk+UH?=
 =?us-ascii?Q?ko5hvsPhVdgtNdVz06csAYJVp9OxJyLDaNzzHoaw6aDJWHZvTXMx31WLtSzS?=
 =?us-ascii?Q?Jfb6JZrEV9ksOMfQNms=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eace853d-3081-49ae-1983-08dcd68d609c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2024 20:23:07.8796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7j1DzJFd0zonG/XE2kbNixxxkmzEwjzGCYiGW1EfE8AyfbJuDWLBpTQTaEPKxLAA+shcL5hjiZzX0C0ZYgdXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6930
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

Reviewed-by: George Zhang <George.zhang@amd.com>

Thanks,
Georrge

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Monday, September 16, 2024 4:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu/bios: split vbios fetching between APU and dGPU

We need some different logic for dGPUs and the APU path can be simplified b=
ecause there are some methods which are never used on APUs.  This also fixe=
s a regression on some older APUs causing the the driver to fetch the unpat=
ched ROM image rather than the patched image.

Fixes: 9c081c11c621 ("drm/amdgpu: Reorder to read EFI exported ROM first")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 47 +++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_bios.c
index 42e64bce661e..e8f62d718167 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -414,7 +414,36 @@ static inline bool amdgpu_acpi_vfct_bios(struct amdgpu=
_device *adev)  }  #endif

-bool amdgpu_get_bios(struct amdgpu_device *adev)
+static bool amdgpu_get_bios_apu(struct amdgpu_device *adev) {
+       if (amdgpu_acpi_vfct_bios(adev)) {
+               dev_info(adev->dev, "Fetched VBIOS from VFCT\n");
+               goto success;
+       }
+
+       if (igp_read_bios_from_vram(adev)) {
+               dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
+               goto success;
+       }
+
+       if (amdgpu_read_bios(adev)) {
+               dev_info(adev->dev, "Fetched VBIOS from ROM BAR\n");
+               goto success;
+       }
+
+       if (amdgpu_read_platform_bios(adev)) {
+               dev_info(adev->dev, "Fetched VBIOS from platform\n");
+               goto success;
+       }
+
+       dev_err(adev->dev, "Unable to locate a BIOS ROM\n");
+       return false;
+
+success:
+       return true;
+}
+
+static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
 {
        if (amdgpu_atrm_get_bios(adev)) {
                dev_info(adev->dev, "Fetched VBIOS from ATRM\n"); @@ -455,1=
0 +484,24 @@ bool amdgpu_get_bios(struct amdgpu_device *adev)
        return false;

 success:
-       adev->is_atom_fw =3D adev->asic_type >=3D CHIP_VEGA10;
        return true;
 }

+bool amdgpu_get_bios(struct amdgpu_device *adev) {
+       bool found;
+
+       if (adev->flags & AMD_IS_APU)
+               found =3D amdgpu_get_bios_apu(adev);
+       else
+               found =3D amdgpu_get_bios_dgpu(adev);
+
+       if (found)
+               adev->is_atom_fw =3D adev->asic_type >=3D CHIP_VEGA10;
+
+       return found;
+}
+
 /* helper function for soc15 and onwards to read bios from rom */  bool am=
dgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
                                     u8 *bios, u32 length_bytes)
--
2.46.0

