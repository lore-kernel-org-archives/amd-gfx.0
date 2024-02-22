Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36205C54788
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 13:24:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88FB10E0E3;
	Thu, 22 Feb 2024 13:24:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jQOvk7Sg";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047E510E0E3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 13:24:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlXlARJsFLr+4K0CA47SmXXncPkLHRFO6nfcxK+/ecMQXm9UyCigTQ1ppLbF2e9FdwIR80hOmwYMkipFCZhAsnTv5NagG3wCADbBJP+MlsOoFypGoIBDi075pO0Joqnsq/1zsVA58m5sZd6/ZewEluzhT6pxFK0rCsNTDYVBqqMDa7IVj4O0vf5VymhNg3T/5OOzbJci1pYd329Hur292CjEnW+Z7A3PDrI8k3gIDo9ctlAnJ7mo7lTKNmBOnWf/1E7LPizg622Vxe+XKSASuDQsXEohbSaC5ZOZ1P7yp41VzYnTvR9P6afryYB0BoIUFx08yVQJfvM7ZQoY2iASHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wn/n/W/eKmVVnLMBMe97hRrofNi6OStNAZmqY09hfj8=;
 b=klBlatBbbdq6By06YzZtWzUIYQAoyy68vjJkB/cE+4Fe6sFbbGm16p6S97y5hFI9qNQ40++DhYxwBGbVQgrQg7AVl/J3CEeX2MP7UBG902Vv8dBI7SoZCxjSu5cZZng5JoTzjFhMrAog5BD4jB1xXLN/gdr8Jd5bcWOsc+Bnt//3Ovsx3UUFejW8wO+Mx1NxZDb6yysYsSGQhnyL24Tp+Ik1eZvN5KM/lcI67JLg5ssVtGMNnClhn3FLl36PrywvgG4TIFWf4oLxYvalB8ceFsbcAzo7M50reYHKQE+8ct6ciY2W3zGxsjCRdq12CBvSZ4EJfNP8S8BZlVPopMfKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wn/n/W/eKmVVnLMBMe97hRrofNi6OStNAZmqY09hfj8=;
 b=jQOvk7SgmdaUNzetLibZhwGxC1/Z/rm6bQZNXDEjMRXw4MBEEY5Qwqmdp2FbleEacfzkc4rQFizE4cAnaXu4nM7kq1uPt2dlYtROGMi5uLSzbuWwXNIkwRhwgM7qU1UeYqw55Z64zsEotlknyoQCuoo5+mx1IpPSqv6XiHsphk4=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Thu, 22 Feb
 2024 13:23:57 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f4b:5839:c5ec:cebe]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::6f4b:5839:c5ec:cebe%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 13:23:56 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add fatal error detected flag
Thread-Topic: [PATCH 1/2] drm/amdgpu: Add fatal error detected flag
Thread-Index: AQHaZXhibOddLtbyuEuOyPeVeezHC7EWWZLw
Date: Thu, 22 Feb 2024 13:23:56 +0000
Message-ID: <DS7PR12MB607144CEE5C880E7871518A28E562@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240222101728.135595-1-lijo.lazar@amd.com>
In-Reply-To: <20240222101728.135595-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=9736e14f-809a-44be-96d3-e1f0f9ced1f0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-22T13:22:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|PH7PR12MB7137:EE_
x-ms-office365-filtering-correlation-id: c164543b-9914-41e5-b923-08dc33a985e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bfTKmSjb3vEtGGH2lxco4eNXqZ+XORIyQKWmwa4VDY1qrmYeATqUVihv4YOgQlZY6BIEHuhTDg+C3/i4gW7ha7nsOC26iGOnokuuDY8flU+Q8FbCyj5fmjFsMg7UY3OHPt9vHg3iDtw8uVPnfOQwny8GUFFPVqgj+i/FO+heceaPkzqcjTyUrJIGC5HxOxzEzt1jW9gsx3NLz9hzmdScZBksSW/WXi9uiBu8F4SzhusudRdidaugYqQBeSCkIGCzCgaZ1UukD0z4v6oh3UGQ6E1ImE5knTmLBYUb/Eae+3wkDO8w3Hot2Qp6HoOl+2An+c4NgcniuhZpW3C1qwON8NXUmw6n57GzVWQCcvK5eY1csh7CeEnPUmMaVHqeWNx2ENb7sm9rWV1n+CulnOTXl0zUthRm7fU6sXC/yZGHrT0alSxfCQsB/TFmP4ssxeyydL0MXvlEms8QXJK7jpRubhH1t1p5lL1O4NWSGpDCdq56bRvZAeebMcFUOX99P4IwhwEJkcnWb9vkEExDCQt3lHBlBuakzRhVl5PyZG7pZaGzPDHRRzX1uQldYbAVHVgCYk4mSTrkreeWosj1p+cZQgjPsCUKQO93XB6QqenPcFIstzl+gGB8+Vp+Hg5SYf36
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JVnxBtLJ9hAYqU8SJaBvB6DG/ebOY5IN0/SFzNEJM1lCtbiCDgdPH2d8DEUr?=
 =?us-ascii?Q?TGb96LHPX9G0J7bP6luyoTjJy9e0rfAY9BC81Cif3uWDK3Re2oDu/6LXBLEu?=
 =?us-ascii?Q?LQUXK0aOOkjgDultbbQ0QhyWFT7/OOFtJemZtaDX/7Uj0/OnyS+qPcwYhD8k?=
 =?us-ascii?Q?cq2xRamXz/fpM7h8c1hWEj6o82OG6XJU90B/lFPUQa3fFt22oaU8mXKRVIQy?=
 =?us-ascii?Q?4mDguZdgQYhixfmRStBSBjOCrPQTYt38bBIgAJDHzAwWWhTwKL8z+UCdBcFK?=
 =?us-ascii?Q?Cotxr0unApadZUEbnShroyHYKhoD5HbMoua/h3PtBj9Z2emXMfeN/yOekaCE?=
 =?us-ascii?Q?lMFYtan61fJ5jEvWf2Txg3OldTKEcUuEJFq7gzGkI40rFV2prPUs7RdKth0P?=
 =?us-ascii?Q?nZ8NSYHIT6mJCZqKlee4VuHZppqslPMZC3kIib1FzRDsNjIIRWiZxaxO+BSK?=
 =?us-ascii?Q?UqNxX6Yj9EU0nBYlFkYEipNJc+2wD6aSbY7knDaZF9wFrZ5Wo9Eo2Qxcatfr?=
 =?us-ascii?Q?rVaiijnFn/bkbbTa9WfSXQvtVESJnhcMTavOPalOlQwFTxpzFTUBOxxGv1yV?=
 =?us-ascii?Q?ob+1EoT5SsRYyq4fdouYfDtpy/VLbsi6vFSV73ukCdj5YCz7UXg3nVSV5FWK?=
 =?us-ascii?Q?ICmO3NO2rBx+0VuFWwlPpocgWtZsYxUC9VqRASYpqfgBOAN4aL2ClS44I+W4?=
 =?us-ascii?Q?pNyxY+BJkwKU7fcWFY+pYKXXWF+J1F/OtkoZ+KaVEfN79mIM3VAEfPiVHv3Z?=
 =?us-ascii?Q?Oi/FQ6H2phuARFZ/sWQEtplLszC5YsxdtTL8kz1Pp6m08feIYhNT6Qw4R7pT?=
 =?us-ascii?Q?Bm4gVBhKyCZ81vl3MF64oYOvFluJLtnqa2F8JljfWy46kXdd9vMu71AcuxkP?=
 =?us-ascii?Q?mWDBdL7TiaTxqHt7Lpb8P8KaxzLiqfb8Ag+yoPnbaBnBmm/LmvIKmdSVmMc6?=
 =?us-ascii?Q?7kci2/6xxhCpVxAWOcCrnDq83cUVwMJWA3Y29Cla7g1EWJUEMjZ/UopKBbk6?=
 =?us-ascii?Q?jXKLMwu2SLH60oYHcx8DtCp7p/NuGv/8r5eueNOcXXk403PTGBmYMNBYC5mz?=
 =?us-ascii?Q?U4OcfmXrZiHm5HnZ0dZezFuUdiADRjucXMPPMUJsxqCWar71AWOQp8dDQSAZ?=
 =?us-ascii?Q?SkI6cuIbKedBLj7hzRyq8VQOK/1qw9W7LvFYiUjc4Ag7jMWuICVir8jtAwsp?=
 =?us-ascii?Q?ql0aTA6bw3KH6JoCEp/qUHwkHzhDrHfiwcSmstfi5g0Z0cfBwVCq5kCASBz5?=
 =?us-ascii?Q?fpfM+4MHJ1D1R3ldhdiyucuParKieFg9Zg19AcnE2t84LoFtevms/G80+yeI?=
 =?us-ascii?Q?6SQvet2oJSPRJbMjUmXkXU6M1P3D2HCKhCBwzGwiANewaXDORkGD0qD5BhOy?=
 =?us-ascii?Q?1jDDvQv/friskvftv1KVDSiq5R7yBSJgTnsgxeCw8LPljUuA+uIGNw70OJwL?=
 =?us-ascii?Q?yPhx/IEIuhDkkObEqlTgeYC2mm41MTLEqtUX0G1cJczIntmC02Jf4zne3cxN?=
 =?us-ascii?Q?1zpHjxRbHbQIr6/7rU9B3prPG+fW5Ic4OhJeUw4yTC2D2Dac/ozxWdshAbMM?=
 =?us-ascii?Q?OXc00AP++t9mDn7CsFQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c164543b-9914-41e5-b923-08dc33a985e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 13:23:56.8174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdqVvfAEyvNEnp2g11rQoFGFCpLxCuYRs5RbHiTC/UQ40IitAQCP+p+vCeeUNLFaDQZeLGaTiofS6IUdxa2FNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
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

[AMD Official Use Only - General]

Series is Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, February 22, 2024 3:47 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Joshi, Mukul <Mu=
kul.Joshi@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add fatal error detected flag

For a RAS error that needs a full reset to recover, set the fatal error sta=
tus. Clear the status once the device is reset.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 32 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h    |  6 ++++
 3 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 1ef892bea488..d475c54c0a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5308,6 +5308,7 @@ int amdgpu_do_asic_reset(struct list_head *device_lis=
t_handle,
        list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
                if (need_full_reset) {
                        /* post card */
+                       amdgpu_ras_set_fed(tmp_adev, false);
                        r =3D amdgpu_device_asic_init(tmp_adev);
                        if (r) {
                                dev_warn(tmp_adev->dev, "asic atom init fai=
led!"); diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_ras.c
index 46f3d1013e8c..2c94de305c69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2439,6 +2439,18 @@ static void amdgpu_ras_do_recovery(struct work_struc=
t *work)
                                ras->gpu_reset_flags &=3D ~AMDGPU_RAS_GPU_R=
ESET_MODE1_RESET;
                                set_bit(AMDGPU_NEED_FULL_RESET, &reset_cont=
ext.flags);

+                               /* For any RAS error that needs a full rese=
t to
+                                * recover, set the fatal error status
+                                */
+                               if (hive) {
+                                       list_for_each_entry(remote_adev,
+                                                           &hive->device_l=
ist,
+                                                           gmc.xgmi.head)
+                                               amdgpu_ras_set_fed(remote_a=
dev,
+                                                                  true);
+                               } else {
+                                       amdgpu_ras_set_fed(adev, true);
+                               }
                                psp_fatal_error_recovery_quirk(&adev->psp);
                        }
                }
@@ -3440,6 +3452,26 @@ int amdgpu_ras_fini(struct amdgpu_device *adev)
        return 0;
 }

+bool amdgpu_ras_get_fed_status(struct amdgpu_device *adev) {
+       struct amdgpu_ras *ras;
+
+       ras =3D amdgpu_ras_get_context(adev);
+       if (!ras)
+               return false;
+
+       return atomic_read(&ras->fed);
+}
+
+void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status) {
+       struct amdgpu_ras *ras;
+
+       ras =3D amdgpu_ras_get_context(adev);
+       if (ras)
+               atomic_set(&ras->fed, !!status);
+}
+
 void amdgpu_ras_global_ras_isr(struct amdgpu_device *adev)  {
        if (atomic_cmpxchg(&amdgpu_ras_in_intr, 0, 1) =3D=3D 0) { diff --gi=
t a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/am=
dgpu_ras.h
index d10e5bb0e52f..e0f8ce9d8440 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -477,6 +477,8 @@ struct amdgpu_ras {
        wait_queue_head_t page_retirement_wq;
        struct mutex page_retirement_lock;
        atomic_t page_retirement_req_cnt;
+       /* Fatal error detected flag */
+       atomic_t fed;
 };

 struct ras_fs_data {
@@ -873,4 +875,8 @@ void amdgpu_ras_add_mca_err_addr(struct ras_err_info *e=
rr_info,

 void amdgpu_ras_del_mca_err_addr(struct ras_err_info *err_info,
                struct ras_err_addr *mca_err_addr);
+
+void amdgpu_ras_set_fed(struct amdgpu_device *adev, bool status); bool
+amdgpu_ras_get_fed_status(struct amdgpu_device *adev);
+
 #endif
--
2.25.1

