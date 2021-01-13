Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E847C433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:16:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BFF23383
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 15:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BFF23383
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 828C76EA87;
	Wed, 13 Jan 2021 15:16:20 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680080.outbound.protection.outlook.com [40.107.68.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4E246EA87
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 15:16:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpdmv3moP34ZaHFkl3P35upQ/EVkiq1k6WGWiTjbpMBrCFkXBB8Xek25rF6mnsoRR1CePMQPacS2rlq7S3byamuoUrtgxH+SZYitd0MjAjjN3nGt/Rm7DUHFQUFEnraKexuKTYea+SxtCcqXHdL0XnAZEP/rwKCOp4D67IR4Su76Ybs43DvSPE6OKSfIqE6nOLVlkIfblbLu8RJAAvIqfxfX2BB8AA9RyfRG+kqcCOE3Os6dkt3wnKdhZ9hO0KLt1CvmSjtk703kAXU/KXD8qu7N7P1zpkCgvFXSM88aBMkf8kN1YbqgXcUc5Fr/OFbfgazueC1YNXWg1puZsxiA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI7cd37RT4Ns/fxEKyijTwOctPokhFIQuUmhfP9zHog=;
 b=YuJldQHHDheQJmPhke6bhi9VQI90kr+lVHyM3r3N26dlsSHZ677yXxkHvUEsvENjSnm4eGDipgC8DA3Ol3AZc/k3zwUvBFVIoEEhPwAW094n0qND2bI4AVrZG9JqZRkFx1hisfGwEuyoc8MjsvDBHvqMN6edSrv6lqBpW71CUehdJyPo70f/x+jotZJfIVVhVjOwSSXxIB+gvbPe0LmXOw6tlPB4dvHhE/uZUVqKMT1THWy+QHgeNRml7ug6QMYydaTskJNaYv6zGuWzvqGONs35KoSO74m+bHyf0qfoDEfEJjohwtZHM46uh0nG58b7gZWqJ9io/a+iVR2rsswT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xI7cd37RT4Ns/fxEKyijTwOctPokhFIQuUmhfP9zHog=;
 b=4W79d6/FY4EPdcd84Q5lmWMb3NXll2w+kDK3vhCMjk48HQPrym0cDmTUju9Ni9jFpaetE199wHWgemeZdQoXepZyN+nicUHMb498sUKNUSGuxxNOwPZUh/vJJeiMrGV7hNonpyEnc+FDKOBToPYM5rfA2xkiz1ZsZaq3GyCo1yo=
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2960.namprd12.prod.outlook.com (2603:10b6:208:101::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.7; Wed, 13 Jan
 2021 15:16:16 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::709e:b0ae:fbde:fcc6%7]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 15:16:16 +0000
From: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>
To: "Su, Jinzhou (Joe)" <Jinzhou.Su@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add secure display TA interface
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add secure display TA interface
Thread-Index: AQHW6V5qdGA48kJl/UuxbP0M4tCJgqolqd/r
Date: Wed, 13 Jan 2021 15:16:16 +0000
Message-ID: <MN2PR12MB30229E48072E88610B32FCDAA2A90@MN2PR12MB3022.namprd12.prod.outlook.com>
References: <20210113034354.14557-1-Jinzhou.Su@amd.com>,
 <20210113034354.14557-2-Jinzhou.Su@amd.com>
In-Reply-To: <20210113034354.14557-2-Jinzhou.Su@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-01-13T15:16:15.890Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c5f8bc2-b985-47a6-8180-08d8b7d62c6f
x-ms-traffictypediagnostic: MN2PR12MB2960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB29600471CAE194DAACF8057DA2A90@MN2PR12MB2960.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJ+3ziXEuHokjm2C7rh4sH5yAJoLv12smtmckqRSKNiAftlsDv0+z58OHMPlB3mCiN22NgIUp865d46S3f4nyLXsuJwBV4tlyXCdmRMSZED+PZu0JJia/CC6f3KOgbmVmeEsSTvb7UZ9afiEc+lcSwVXANgwybfz3R5I6fnUCs7zPxsbfID1ey5gQdVtJh6MXuOy85TiFtj0j16dqj02ebdRicydd1Yo1zQgZ5Xuf0nb9lk6w99DJ0IsjChaH6ByfGa9tMT4Hy8WHhvBiJVSBNWmNznLG/s+NYkZzwYVitEUUSYJKcnbBRJ7JdAJLU80aYhH2fmk923Bqo+mwx2TqAkLuqQSIoqbWOQwtFDilDiB+sZzSdQtHwFQrlEjO2NMjiTUyVp4iLW1JgjqfgXAzfpvy2eujg2MLqpoC9+dQI6PxOHZ+uZFw2zUxD84HW03/1E6lLEGGvNdr4qo1j+/idXEceqOnMoSyiPmztTalV8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(52536014)(26005)(316002)(186003)(55016002)(30864003)(2906002)(71200400001)(6506007)(478600001)(4326008)(8936002)(45080400002)(86362001)(110136005)(33656002)(966005)(9686003)(76116006)(19627405001)(66556008)(64756008)(91956017)(7696005)(8676002)(66446008)(83380400001)(5660300002)(66946007)(53546011)(66476007)(166002)(21314003)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?cHI2K3JTcWRiT0V2eHpCT0k0NHUzcGwxVmtERkhtNWsvM0lnT1lBTjA1?=
 =?iso-2022-jp?B?Z25UNXErbEFrQ0w5NEcvdTlNMmJLRzBmZUJvSGp4YXZ5dk9BUmE1T3Ja?=
 =?iso-2022-jp?B?Y1EyRVAzdFc3N1hsS2hkUTdPQUlMUWtYeGw1S2lWYzdmOHAzNVV3OHJN?=
 =?iso-2022-jp?B?Sk5Obk9rOEFnb2ozR3ZTaXRTTlFteGxNZTVSMVYwTU5tWkVZTCtQZWlq?=
 =?iso-2022-jp?B?TG5nMUxLWnJuenp1eWNsSGw4Y3oyNFJHUEVIS0h3dFB5MlYySmVER2xP?=
 =?iso-2022-jp?B?c0VvM2FnY0xWSW1qcVhNYmU4S20zZGRIc0NETHVETjgyWGpOaDIyTFhv?=
 =?iso-2022-jp?B?Y0h5aEtwT3p6UGxLRUJKcmNRVzRjbzlBaGVwNFh5MDVvdW5BMmlwdmRO?=
 =?iso-2022-jp?B?ZlplSjhPWXM1cldkZm4vK3l1MWF2M3pqbDZnbVhVSWk3OXRjZDJHc3dZ?=
 =?iso-2022-jp?B?SWt4RDZLK1kxaTVRSndDWUgvR3orNkJrbVNSdy9TWjVNZHNhanpmYkZZ?=
 =?iso-2022-jp?B?NDQvRHhQZWpIN2dOR1psc1J1WnZJeThLNWZwdUZWRXJJZ0IvVTRla0Zr?=
 =?iso-2022-jp?B?bEszbWx4bDJLUHVWUTR5dld1VTVXTUhtOEdjOEtDZUc0M0hVQ2NXZjVk?=
 =?iso-2022-jp?B?N25qcWpOdEFnRWZ0OHd4ZExWakVGNEVXaWpoelhuMGNqOUVDdmlhNEpB?=
 =?iso-2022-jp?B?K2FOVkxjSnhSTnNjUFNmVFJZclVBK2daaUNaclBLRVZWQitMbmdiQUl4?=
 =?iso-2022-jp?B?amxDMGtqQmtOMFZyc1Jpc0tuNkZVWk9yVU1lUk5oOFZwcnpsUXBzMk4y?=
 =?iso-2022-jp?B?S1B0TVVmc2toTWhJZmhaM05GLzhHWWJHRE9jeU5EYjN3cjhqcG9WeGtP?=
 =?iso-2022-jp?B?c1V4R1daREUrY3F6QUJHQlYvZjZ5b2w1NlZGYzIrZGpqUXdKeUk1WXdj?=
 =?iso-2022-jp?B?RXNUdlprUHcyWXcySDY1ME9MNndJQm52OGUxc0FKU3JnNTMxQ2lFQmsy?=
 =?iso-2022-jp?B?RUpoaW9Zcml1VU9qMi9ETEpwVnhKcldiQmx6NGtHQzVCcHp5QWVwL0xm?=
 =?iso-2022-jp?B?d1paMnBsQm1KK3VSZDlybnhuWGFKTE5uVjdsL0UyT1p1ZmtOcVNGRUsw?=
 =?iso-2022-jp?B?djVrUFFuZHlyQk5OWG9wQWFmQ3hMUjI0Vllac1gvemNRb3pBQVJIMWlu?=
 =?iso-2022-jp?B?VzQ3aEIzZFpMWlZ6N1h2aGVEYWllWThGOVpNNlZiME5nemxRQmNIc01z?=
 =?iso-2022-jp?B?QnVMaXJ3VitNSjJhL2xRNm4ycFFVWFlsMEEzRENUbGZrakNlSjlBQk9P?=
 =?iso-2022-jp?B?SlpuNllOT3RxeHNZZEEzc3BwRm1ydGsyQmVsQ21OdngwdkpSTzczUytV?=
 =?iso-2022-jp?B?dVFOdElRYVZvaG1vUFNrdUo3WFMrc1o0YUJBbWdaRWV6R2x2Yz0=?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5f8bc2-b985-47a6-8180-08d8b7d62c6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 15:16:16.8065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqv8mmnPqec6PFvQ8Lq1zWA3aQNeLjcP4iNji490XYm8OAGCSjrA5TQoME3cTTDG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2960
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: multipart/mixed; boundary="===============1653006187=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1653006187==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB30229E48072E88610B32FCDAA2A90MN2PR12MB3022namp_"

--_000_MN2PR12MB30229E48072E88610B32FCDAA2A90MN2PR12MB3022namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]



________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jinzhou =
Su <Jinzhou.Su@amd.com>
Sent: Wednesday, January 13, 2021 11:43 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Su, Jinzhou (Joe) <Jinzhou.Su@amd.com>; Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: Add secure display TA interface

Add interface to load, unload, invoke command for
secure display TA.

v2: Add debugfs interface for secure display TA

Signed-off-by: Jinzhou.Su <Jinzhou.Su@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 195 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  17 ++
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 174 ++++++++++++++++
 .../gpu/drm/amd/amdgpu/amdgpu_securedisplay.h |  36 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c        |  12 +-
 8 files changed, 440 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile
index c6262689e14e..e4bebbfa88af 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -56,7 +56,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \
         amdgpu_gmc.o amdgpu_mmhub.o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.=
o amdgpu_vm_cpu.o \
         amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbi=
o.o \
         amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
-       amdgpu_fw_attestation.o
+       amdgpu_fw_attestation.o amdgpu_securedisplay.o

 amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 477bead4fab1..4c38c5771cbc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -35,6 +35,7 @@
 #include "amdgpu_dm_debugfs.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_rap.h"
+#include "amdgpu_securedisplay.h"
 #include "amdgpu_fw_attestation.h"

 /**
@@ -1666,6 +1667,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)

         amdgpu_rap_debugfs_init(adev);

+       amdgpu_securedisplay_debugfs_init(adev);
+
         amdgpu_fw_attestation_debugfs_init(adev);

         return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 523d22db094b..eb19ae734396 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -36,6 +36,7 @@
 #include "psp_v12_0.h"

 #include "amdgpu_ras.h"
+#include "amdgpu_securedisplay.h"

 static int psp_sysfs_init(struct amdgpu_device *adev);
 static void psp_sysfs_fini(struct amdgpu_device *adev);
@@ -1642,6 +1643,179 @@ int psp_rap_invoke(struct psp_context *psp, uint32_=
t ta_cmd_id)
 }
 // RAP end

+/* securedisplay start */
+static int psp_securedisplay_init_shared_buf(struct psp_context *psp)
+{
+       int ret;
+
+       /*
+        * Allocate 16k memory aligned to 4k from Frame Buffer (local
+        * physical) for sa ta <-> Driver
+        */
+       ret =3D amdgpu_bo_create_kernel(psp->adev, PSP_SECUREDISPLAY_SHARED=
_MEM_SIZE,
+                                     PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM,
+                                     &psp->securedisplay_context.securedis=
play_shared_bo,
+                                     &psp->securedisplay_context.securedis=
play_shared_mc_addr,
+                                     &psp->securedisplay_context.securedis=
play_shared_buf);
+
+       return ret;
+}
+
+static int psp_securedisplay_load(struct psp_context *psp)
+{
+       int ret;
+       struct psp_gfx_cmd_resp *cmd;
+
+       /*
+        * TODO: bypass the loading in sriov for now
+        */
+
+       cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+       if (!cmd)
+               return -ENOMEM;
+
+       memset(psp->fw_pri_buf, 0, PSP_1_MEG);
+       memcpy(psp->fw_pri_buf, psp->ta_securedisplay_start_addr, psp->ta_s=
ecuredisplay_ucode_size);
+
+       psp_prep_ta_load_cmd_buf(cmd,
+                                psp->fw_pri_mc_addr,
+                                psp->ta_securedisplay_ucode_size,
+                                psp->securedisplay_context.securedisplay_s=
hared_mc_addr,
+                                PSP_SECUREDISPLAY_SHARED_MEM_SIZE);
+
+       ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+       if (ret)
+               goto failed;
+
+       psp->securedisplay_context.securedisplay_initialized =3D true;
+       psp->securedisplay_context.session_id =3D cmd->resp.session_id;
+       mutex_init(&psp->securedisplay_context.mutex);
+
+failed:
+       kfree(cmd);
+       return ret;
+}
+
+static int psp_securedisplay_unload(struct psp_context *psp)
+{
+       int ret;
+       struct psp_gfx_cmd_resp *cmd;
+
+       cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+       if (!cmd)
+               return -ENOMEM;
+
+       psp_prep_ta_unload_cmd_buf(cmd, psp->securedisplay_context.session_=
id);
+
+       ret =3D psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);
+
+       kfree(cmd);
+
+       return ret;
+}
+
+static int psp_securedisplay_initialize(struct psp_context *psp)
+{
+       int ret;
+       struct securedisplay_cmd *securedisplay_cmd;
+
+       /*
+        * TODO: bypass the initialize in sriov for now
+        */
+       if (amdgpu_sriov_vf(psp->adev))
+               return 0;
+
+       if (!psp->adev->psp.ta_securedisplay_ucode_size ||
+           !psp->adev->psp.ta_securedisplay_start_addr) {
+               dev_info(psp->adev->dev, "SECUREDISPLAY: securedisplay ta u=
code is not available\n");
+               return 0;
+       }
+
+       if (!psp->securedisplay_context.securedisplay_initialized) {
+               ret =3D psp_securedisplay_init_shared_buf(psp);
+               if (ret)
+                       return ret;
+       }
+
+       ret =3D psp_securedisplay_load(psp);
+       if (ret)
+               return ret;
+
+       psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+                       TA_SECUREDISPLAY_COMMAND__QUERY_TA);
+
+       ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__QUE=
RY_TA);
+       if (ret) {
+               psp_securedisplay_unload(psp);
+
+               amdgpu_bo_free_kernel(&psp->securedisplay_context.securedis=
play_shared_bo,
+                             &psp->securedisplay_context.securedisplay_sha=
red_mc_addr,
+                             &psp->securedisplay_context.securedisplay_sha=
red_buf);
+
+               psp->securedisplay_context.securedisplay_initialized =3D fa=
lse;
+
+               dev_err(psp->adev->dev, "SECUREDISPLAY TA initialize fail.\=
n");
+               return -EINVAL;
+       }
+
+       if (securedisplay_cmd->status !=3D TA_SECUREDISPLAY_STATUS__SUCCESS=
) {
+               psp_securedisplay_parse_resp_status(psp, securedisplay_cmd-=
>status);
+               dev_err(psp->adev->dev, "SECUREDISPLAY: query securedisplay=
 TA failed. ret 0x%x\n",
+                       securedisplay_cmd->securedisplay_out_message.query_=
ta.query_cmd_ret);
+       }
+
+       return 0;
+}
+
+static int psp_securedisplay_terminate(struct psp_context *psp)
+{
+       int ret;
+
+       /*
+        * TODO:bypass the terminate in sriov for now
+        */
+       if (amdgpu_sriov_vf(psp->adev))
+               return 0;
+
+       if (!psp->securedisplay_context.securedisplay_initialized)
+               return 0;
+
+       ret =3D psp_securedisplay_unload(psp);
+       if (ret)
+               return ret;
+
+       psp->securedisplay_context.securedisplay_initialized =3D false;
+
+       /* free securedisplay shared memory */
+       amdgpu_bo_free_kernel(&psp->securedisplay_context.securedisplay_sha=
red_bo,
+                             &psp->securedisplay_context.securedisplay_sha=
red_mc_addr,
+                             &psp->securedisplay_context.securedisplay_sha=
red_buf);
+
+       return ret;
+}
+
+int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
+{
+       int ret;
+
+       if (!psp->securedisplay_context.securedisplay_initialized)
+               return -EINVAL;
+
+       if (ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__QUERY_TA &&
+           ta_cmd_id !=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)
+               return -EINVAL;
+
+       mutex_lock(&psp->securedisplay_context.mutex);
+
+       ret =3D psp_ta_invoke(psp, ta_cmd_id, psp->securedisplay_context.se=
ssion_id);
+
+       mutex_unlock(&psp->securedisplay_context.mutex);
+
+       return ret;
+}
+/* SECUREDISPLAY end */
+
 static int psp_hw_start(struct psp_context *psp)
 {
         struct amdgpu_device *adev =3D psp->adev;
@@ -2116,6 +2290,11 @@ static int psp_load_fw(struct amdgpu_device *adev)
                 if (ret)
                         dev_err(psp->adev->dev,
                                 "RAP: Failed to initialize RAP\n");
+
+               ret =3D psp_securedisplay_initialize(psp);
+               if (ret)
+                       dev_err(psp->adev->dev,
+                               "SECUREDISPLAY: Failed to initialize SECURE=
DISPLAY\n");
         }

         return 0;
@@ -2166,6 +2345,7 @@ static int psp_hw_fini(void *handle)

         if (psp->adev->psp.ta_fw) {
                 psp_ras_terminate(psp);
+               psp_securedisplay_terminate(psp);
                 psp_rap_terminate(psp);
                 psp_dtm_terminate(psp);
                 psp_hdcp_terminate(psp);
@@ -2230,6 +2410,11 @@ static int psp_suspend(void *handle)
                         DRM_ERROR("Failed to terminate rap ta\n");
                         return ret;
                 }
+               ret =3D psp_securedisplay_terminate(psp);
+               if (ret) {
+                       DRM_ERROR("Failed to terminate securedisplay ta\n")=
;
+                       return ret;
+               }
         }

         ret =3D psp_asd_unload(psp);
@@ -2313,6 +2498,11 @@ static int psp_resume(void *handle)
                 if (ret)
                         dev_err(psp->adev->dev,
                                 "RAP: Failed to initialize RAP\n");
+
+               ret =3D psp_securedisplay_initialize(psp);
+               if (ret)
+                       dev_err(psp->adev->dev,
+                               "SECUREDISPLAY: Failed to initialize SECURE=
DISPLAY\n");
         }

         mutex_unlock(&adev->firmware.mutex);
@@ -2620,6 +2810,11 @@ static int parse_ta_bin_descriptor(struct psp_contex=
t *psp,
                 psp->ta_rap_ucode_size     =3D le32_to_cpu(desc->size_byte=
s);
                 psp->ta_rap_start_addr     =3D ucode_start_addr;
                 break;
+       case TA_FW_TYPE_PSP_SECUREDISPLAY:
+               psp->ta_securedisplay_ucode_version  =3D le32_to_cpu(desc->=
fw_version);
+               psp->ta_securedisplay_ucode_size     =3D le32_to_cpu(desc->=
size_bytes);
+               psp->ta_securedisplay_start_addr     =3D ucode_start_addr;
+               break;
         default:
                 dev_warn(psp->adev->dev, "Unsupported TA type: %d\n", desc=
->fw_type);
                 break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h
index da250bc1ac57..cb50ba445f8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -30,6 +30,7 @@
 #include "ta_xgmi_if.h"
 #include "ta_ras_if.h"
 #include "ta_rap_if.h"
+#include "ta_secureDisplay_if.h"

 #define PSP_FENCE_BUFFER_SIZE   0x1000
 #define PSP_CMD_BUFFER_SIZE     0x1000
@@ -40,6 +41,7 @@
 #define PSP_HDCP_SHARED_MEM_SIZE        0x4000
 #define PSP_DTM_SHARED_MEM_SIZE 0x4000
 #define PSP_RAP_SHARED_MEM_SIZE 0x4000
+#define PSP_SECUREDISPLAY_SHARED_MEM_SIZE      0x4000
 #define PSP_SHARED_MEM_SIZE             0x4000
 #define PSP_FW_NAME_LEN         0x24

@@ -171,6 +173,15 @@ struct psp_rap_context {
         struct mutex            mutex;
 };

+struct psp_securedisplay_context {
+       bool                    securedisplay_initialized;
+       uint32_t                session_id;
+       struct amdgpu_bo        *securedisplay_shared_bo;
+       uint64_t                securedisplay_shared_mc_addr;
+       void                    *securedisplay_shared_buf;
+       struct mutex            mutex;
+};
+
 #define MEM_TRAIN_SYSTEM_SIGNATURE              0x54534942
 #define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES   0x1000
 #define GDDR6_MEM_TRAINING_OFFSET               0x8000
@@ -298,12 +309,17 @@ struct psp_context
         uint32_t                        ta_rap_ucode_size;
         uint8_t                         *ta_rap_start_addr;

+       uint32_t                        ta_securedisplay_ucode_version;
+       uint32_t                        ta_securedisplay_ucode_size;
+       uint8_t                         *ta_securedisplay_start_addr;
+
         struct psp_asd_context          asd_context;
         struct psp_xgmi_context         xgmi_context;
         struct psp_ras_context          ras;
         struct psp_hdcp_context  hdcp_context;
         struct psp_dtm_context          dtm_context;
         struct psp_rap_context          rap_context;
+       struct psp_securedisplay_context        securedisplay_context;
         struct mutex                    mutex;
         struct psp_memory_training_context mem_train_ctx;
 };
@@ -380,6 +396,7 @@ int psp_ras_trigger_error(struct psp_context *psp,
 int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
+int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id);

 int psp_rlc_autoload_start(struct psp_context *psp);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.c
new file mode 100644
index 000000000000..455978781380
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
@@ -0,0 +1,174 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ */
+#include <linux/debugfs.h>
+#include <linux/pm_runtime.h>
+
+#include "amdgpu.h"
+#include "amdgpu_securedisplay.h"
+
+/**
+ * DOC: AMDGPU SECUREDISPLAY debugfs test interface
+ *
+ * how to use?
+ * echo opcode <value> > <debugfs_dir>/dri/xxx/securedisplay_test
+ * eg. echo 1 > <debugfs_dir>/dri/xxx/securedisplay_test
+ * eg. echo 2 phy_id > <debugfs_dir>/dri/xxx/securedisplay_test
+ *
+ * opcode:
+ * 1=1B$B!'=1B(BQuery whether TA is responding used only for validation pu=
pose
+ * 2: Send region of Interest and CRC value to I2C. (uint32)phy_id is
+ * send to determine which DIO scratch register should be used to get
+ * ROI and receive i2c_buf as the output.
+ *
+ * You can refer more detail from header file ta_securedisplay_if.h
+ *
+ */
+
+void psp_securedisplay_parse_resp_status(struct psp_context *psp,
+       enum ta_securedisplay_status status)
+{
+       switch (status) {
+       case TA_SECUREDISPLAY_STATUS__SUCCESS:
+               break;
+       case TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE:
+               dev_err(psp->adev->dev, "Secure display: Generic Failure.")=
;
+               break;
+       case TA_SECUREDISPLAY_STATUS__INVALID_PARAMETER:
+               dev_err(psp->adev->dev, "Secure display: Invalid Parameter.=
");
+               break;
+       case TA_SECUREDISPLAY_STATUS__NULL_POINTER:
+               dev_err(psp->adev->dev, "Secure display: Null Pointer.");
+               break;
+       case TA_SECUREDISPLAY_STATUS__I2C_WRITE_ERROR:
+               dev_err(psp->adev->dev, "Secure display: Failed to write to=
 I2C.");
+               break;
+       case TA_SECUREDISPLAY_STATUS__READ_DIO_SCRATCH_ERROR:
+               dev_err(psp->adev->dev, "Secure display: Failed to Read DIO=
 Scratch Register.");
+               break;
+       case TA_SECUREDISPLAY_STATUS__READ_CRC_ERROR:
+               dev_err(psp->adev->dev, "Secure display: Failed to Read CRC=
");
+               break;
+       default:
+               dev_err(psp->adev->dev, "Secure display: Failed to parse st=
atus: %d\n", status);
+       }
+}
+
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct secure=
display_cmd **cmd,
+       enum ta_securedisplay_command command_id)
+{
+       *cmd =3D (struct securedisplay_cmd *)psp->securedisplay_context.sec=
uredisplay_shared_buf;
+       memset(*cmd, 0, sizeof(struct securedisplay_cmd));
+       (*cmd)->status =3D TA_SECUREDISPLAY_STATUS__GENERIC_FAILURE;
+       (*cmd)->cmd_id =3D command_id;
+}
+
+static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const ch=
ar __user *buf,
+               size_t size, loff_t *pos)
+{
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)file_inode(f=
)->i_private;
+       struct psp_context *psp =3D &adev->psp;
+       struct securedisplay_cmd *securedisplay_cmd;
+       struct drm_device *dev =3D adev_to_drm(adev);
+       uint32_t phy_id;
+       uint32_t op;
+       int i;
+       char str[64];
+       char i2c_output[256];
+       int ret;

[Kevin]:
the driver should avoid allocate big block size memory in kernel stack. (x8=
6_64:: kernel stack size is fix16K).
In other words, you don't know how many kernel stacks will be used in upstr=
eam.
Generally speaking,  there is no problem, but it is really unreasonable.

Best Regards,
Kevin
+
+       if (*pos || size > sizeof(str) - 1)
+               return -EINVAL;
+
+       memset(str,  0, sizeof(str));
+       copy_from_user(str, buf, size);
+
+       ret =3D pm_runtime_get_sync(dev->dev);
+       if (ret < 0) {
+               pm_runtime_put_autosuspend(dev->dev);
+               return ret;
+       }
+
+       if (size < 3)
+               sscanf(str, "%u ", &op);
+       else
+               sscanf(str, "%u %u", &op, &phy_id);
+
+       switch (op) {
+       case 1:
+               psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+                       TA_SECUREDISPLAY_COMMAND__QUERY_TA);
+               ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMM=
AND__QUERY_TA);
+               if (!ret) {
+                       if (securedisplay_cmd->status =3D=3D TA_SECUREDISPL=
AY_STATUS__SUCCESS)
+                               dev_info(adev->dev, "SECUREDISPLAY: query s=
ecuredisplay TA ret is 0x%X\n",
+                                       securedisplay_cmd->securedisplay_ou=
t_message.query_ta.query_cmd_ret);
+                       else
+                               psp_securedisplay_parse_resp_status(psp, se=
curedisplay_cmd->status);
+               }
+               break;
+       case 2:
+               psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
+                       TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
+               securedisplay_cmd->securedisplay_in_message.send_roi_crc.ph=
y_id =3D phy_id;
+               ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMM=
AND__SEND_ROI_CRC);
+               if (!ret) {
+                       if (securedisplay_cmd->status =3D=3D TA_SECUREDISPL=
AY_STATUS__SUCCESS) {
+                               memset(i2c_output,  0, sizeof(i2c_output));
+                               for (i =3D 0; i < TA_SECUREDISPLAY_I2C_BUFF=
ER_SIZE; i++)
+                                       sprintf(i2c_output, "%s 0x%X", i2c_=
output,
+                                               securedisplay_cmd->securedi=
splay_out_message.send_roi_crc.i2c_buf[i]);
+                               dev_info(adev->dev, "SECUREDISPLAY: I2C buf=
fer out put is :%s\n", i2c_output);
+                       } else {
+                               psp_securedisplay_parse_resp_status(psp, se=
curedisplay_cmd->status);
+                       }
+               }
+               break;
+       default:
+               dev_err(adev->dev, "Invalid input: %s\n", str);
+       }
+
+       pm_runtime_mark_last_busy(dev->dev);
+       pm_runtime_put_autosuspend(dev->dev);
+
+       return size;
+}
+
+static const struct file_operations amdgpu_securedisplay_debugfs_ops =3D {
+       .owner =3D THIS_MODULE,
+       .read =3D NULL,
+       .write =3D amdgpu_securedisplay_debugfs_write,
+       .llseek =3D default_llseek
+};
+
+void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev)
+{
+#if defined(CONFIG_DEBUG_FS)
+
+       if (!adev->psp.securedisplay_context.securedisplay_initialized)
+               return;
+
+       debugfs_create_file("securedisplay_test", S_IWUSR, adev_to_drm(adev=
)->primary->debugfs_root,
+                               adev, &amdgpu_securedisplay_debugfs_ops);
+#endif
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.h
new file mode 100644
index 000000000000..983446c72520
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h
@@ -0,0 +1,36 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included=
 in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS=
 OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ *
+ */
+#ifndef _AMDGPU_SECUREDISPLAY_H
+#define _AMDGPU_SECUREDISPLAY_H
+
+#include "amdgpu.h"
+#include "ta_secureDisplay_if.h"
+
+void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev);
+void psp_securedisplay_parse_resp_status(struct psp_context *psp,
+               enum ta_securedisplay_status status);
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct secure=
display_cmd **cmd,
+               enum ta_securedisplay_command command_id);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h
index 0e43b46d3ab5..46449e70348b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -122,6 +122,9 @@ struct ta_firmware_header_v1_0 {
         uint32_t ta_dtm_ucode_version;
         uint32_t ta_dtm_offset_bytes;
         uint32_t ta_dtm_size_bytes;
+       uint32_t ta_securedisplay_ucode_version;
+       uint32_t ta_securedisplay_offset_bytes;
+       uint32_t ta_securedisplay_size_bytes;
 };

 enum ta_fw_type {
@@ -132,6 +135,7 @@ enum ta_fw_type {
         TA_FW_TYPE_PSP_HDCP,
         TA_FW_TYPE_PSP_DTM,
         TA_FW_TYPE_PSP_RAP,
+       TA_FW_TYPE_PSP_SECUREDISPLAY,
 };

 struct ta_fw_bin_desc {
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index d7f92634eba2..4b1cc5e9ee92 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -92,8 +92,6 @@ static int psp_v10_0_init_microcode(struct psp_context *p=
sp)
                         (uint8_t *)ta_hdr +
                         le32_to_cpu(ta_hdr->header.ucode_array_offset_byte=
s);

-               adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucod=
e_version);
-
                 adev->psp.ta_dtm_ucode_version =3D
                         le32_to_cpu(ta_hdr->ta_dtm_ucode_version);
                 adev->psp.ta_dtm_ucode_size =3D
@@ -101,6 +99,16 @@ static int psp_v10_0_init_microcode(struct psp_context =
*psp)
                 adev->psp.ta_dtm_start_addr =3D
                         (uint8_t *)adev->psp.ta_hdcp_start_addr +
                         le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
+
+               adev->psp.ta_securedisplay_ucode_version =3D
+                       le32_to_cpu(ta_hdr->ta_securedisplay_ucode_version)=
;
+               adev->psp.ta_securedisplay_ucode_size =3D
+                       le32_to_cpu(ta_hdr->ta_securedisplay_size_bytes);
+               adev->psp.ta_securedisplay_start_addr =3D
+                       (uint8_t *)adev->psp.ta_hdcp_start_addr +
+                       le32_to_cpu(ta_hdr->ta_securedisplay_offset_bytes);
+
+               adev->psp.ta_fw_version =3D le32_to_cpu(ta_hdr->header.ucod=
e_version);
         }

         return 0;
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7CKevin1.W=
ang%40amd.com%7C105d330e2a9f417d324408d8b775887e%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637461062772245289%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL=
jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3Dj3=
wrRxVVnVEu9UWN%2F1UiLZUHyO6jNy8tBEOlkq0DOGk%3D&amp;reserved=3D0

--_000_MN2PR12MB30229E48072E88610B32FCDAA2A90MN2PR12MB3022namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jinzhou Su &lt;Jinzhou.Su@amd=
.com&gt;<br>
<b>Sent:</b> Wednesday, January 13, 2021 11:43 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Su, Jinzhou (Joe) &lt;Jinzhou.Su@amd.com&gt;; Huang, Ray &lt;Ray=
.Huang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Add secure display TA interface</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Add interface to load, unload, invoke command for<=
br>
secure display TA.<br>
<br>
v2: Add debugfs interface for secure display TA<br>
<br>
Signed-off-by: Jinzhou.Su &lt;Jinzhou.Su@amd.com&gt;<br>
Reviewed-by: Huang Rui &lt;ray.huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/Makefile&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c&nbsp;&nbsp; |&nbsp;&nbsp;=
 3 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 195 ++++++++++++++++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; |&nbsp; 17 ++<br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 174 ++++++++++++++++<=
br>
&nbsp;.../gpu/drm/amd/amdgpu/amdgpu_securedisplay.h |&nbsp; 36 ++++<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp;&nbsp; 4 +<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; |&nbsp; 12 +-<br>
&nbsp;8 files changed, 440 insertions(+), 3 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c<=
br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h<=
br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdg=
pu/Makefile<br>
index c6262689e14e..e4bebbfa88af 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/Makefile<br>
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile<br>
@@ -56,7 +56,7 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_kms.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_gmc.o amdgpu_mmhub.=
o amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_sdma.o amdgpu_di=
scovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc.o smu_v11_0_i2c=
.o amdgpu_fru_eeprom.o amdgpu_rap.o \<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fw_attestation.o<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fw_attestation.o amdgpu_secure=
display.o<br>
&nbsp;<br>
&nbsp;amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 477bead4fab1..4c38c5771cbc 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -35,6 +35,7 @@<br>
&nbsp;#include &quot;amdgpu_dm_debugfs.h&quot;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
&nbsp;#include &quot;amdgpu_rap.h&quot;<br>
+#include &quot;amdgpu_securedisplay.h&quot;<br>
&nbsp;#include &quot;amdgpu_fw_attestation.h&quot;<br>
&nbsp;<br>
&nbsp;/**<br>
@@ -1666,6 +1667,8 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)<b=
r>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_rap_debugfs_init(ad=
ev);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_securedisplay_debugfs_init(ade=
v);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fw_attestation_debu=
gfs_init(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_debugfs_add_=
files(adev, amdgpu_debugfs_list,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 523d22db094b..eb19ae734396 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -36,6 +36,7 @@<br>
&nbsp;#include &quot;psp_v12_0.h&quot;<br>
&nbsp;<br>
&nbsp;#include &quot;amdgpu_ras.h&quot;<br>
+#include &quot;amdgpu_securedisplay.h&quot;<br>
&nbsp;<br>
&nbsp;static int psp_sysfs_init(struct amdgpu_device *adev);<br>
&nbsp;static void psp_sysfs_fini(struct amdgpu_device *adev);<br>
@@ -1642,6 +1643,179 @@ int psp_rap_invoke(struct psp_context *psp, uint32_=
t ta_cmd_id)<br>
&nbsp;}<br>
&nbsp;// RAP end<br>
&nbsp;<br>
+/* securedisplay start */<br>
+static int psp_securedisplay_init_shared_buf(struct psp_context *psp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Allocate 16k memory aligned t=
o 4k from Frame Buffer (local<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * physical) for sa ta &lt;-&gt;=
 Driver<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_kernel(psp-&=
gt;adev, PSP_SECUREDISPLAY_SHARED_MEM_SIZE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PAGE_SI=
ZE, AMDGPU_GEM_DOMAIN_VRAM,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;securedisplay_context.securedisplay_shared_bo,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;securedisplay_context.securedisplay_shared_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;ps=
p-&gt;securedisplay_context.securedisplay_shared_buf);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static int psp_securedisplay_load(struct psp_context *psp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: bypass the loading in s=
riov for now<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx=
_cmd_resp), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(psp-&gt;fw_pri_buf, 0, PSP_1_M=
EG);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy(psp-&gt;fw_pri_buf, psp-&gt;ta=
_securedisplay_start_addr, psp-&gt;ta_securedisplay_ucode_size);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_load_cmd_buf(cmd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;fw_pri_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;ta_securedisplay_ucode_size,<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;securedisplay_context.secured=
isplay_shared_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PSP_SECUREDISPLAY_SHARED_MEM_SIZE);<b=
r>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL,=
 cmd, psp-&gt;fence_buf_mc_addr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto failed;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;securedisplay_context.secured=
isplay_initialized =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;securedisplay_context.session=
_id =3D cmd-&gt;resp.session_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_init(&amp;psp-&gt;securedisplay=
_context.mutex);<br>
+<br>
+failed:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cmd);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static int psp_securedisplay_unload(struct psp_context *psp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx=
_cmd_resp), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -ENOMEM;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_ta_unload_cmd_buf(cmd, psp-&=
gt;securedisplay_context.session_id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_cmd_submit_buf(psp, NULL,=
 cmd, psp-&gt;fence_buf_mc_addr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cmd);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+static int psp_securedisplay_initialize(struct psp_context *psp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct securedisplay_cmd *securedispl=
ay_cmd;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO: bypass the initialize i=
n sriov for now<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;adev-&gt;psp.ta_securedi=
splay_ucode_size ||<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !psp-&gt;adev=
-&gt;psp.ta_securedisplay_start_addr) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_info(psp-&gt;adev-&gt;dev, &quot;SECUREDISPLAY: securedispla=
y ta ucode is not available\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;securedisplay_context.se=
curedisplay_initialized) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_securedisplay_init_shared_buf(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_securedisplay_load(psp);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_prep_securedisplay_cmd_buf(psp, &=
amp;securedisplay_cmd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_SECUREDISPLAY=
_COMMAND__QUERY_TA);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_securedisplay_invoke(psp,=
 TA_SECUREDISPLAY_COMMAND__QUERY_TA);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp_securedisplay_unload(psp);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;securedisplay_context.secured=
isplay_shared_bo,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;securedisplay_context.securedisplay_shared=
_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;securedisplay_context.securedisplay_shared=
_buf);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;securedisplay_context.securedisplay_initialized =3D fals=
e;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;SECUREDISPLAY TA initialize =
fail.\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (securedisplay_cmd-&gt;status !=3D=
 TA_SECUREDISPLAY_STATUS__SUCCESS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp_securedisplay_parse_resp_status(psp, securedisplay_cmd-&gt;s=
tatus);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;SECUREDISPLAY: query secured=
isplay TA failed. ret 0x%x\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; securedisplay_cm=
d-&gt;securedisplay_out_message.query_ta.query_cmd_ret);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int psp_securedisplay_terminate(struct psp_context *psp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * TODO:bypass the terminate in =
sriov for now<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(psp-&gt;adev))<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;securedisplay_context.se=
curedisplay_initialized)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_securedisplay_unload(psp)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;securedisplay_context.secured=
isplay_initialized =3D false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* free securedisplay shared memory *=
/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;se=
curedisplay_context.securedisplay_shared_bo,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;securedisplay_context.securedisplay_shared=
_mc_addr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;securedisplay_context.securedisplay_shared=
_buf);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+<br>
+int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)<=
br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;securedisplay_context.se=
curedisplay_initialized)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ta_cmd_id !=3D TA_SECUREDISPLAY_C=
OMMAND__QUERY_TA &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_cmd_id !=
=3D TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;psp-&gt;securedisplay=
_context.mutex);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ta_invoke(psp, ta_cmd_id,=
 psp-&gt;securedisplay_context.session_id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&gt;securedispl=
ay_context.mutex);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+}<br>
+/* SECUREDISPLAY end */<br>
+<br>
&nbsp;static int psp_hw_start(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D psp-&gt;adev;<br>
@@ -2116,6 +2290,11 @@ static int psp_load_fw(struct amdgpu_device *adev)<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(psp-&gt;adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAP: Failed to initialize =
RAP\n&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_securedisplay_initialize(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(psp-&gt;=
adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;SECUREDISPLAY: Failed to initialize S=
ECUREDISPLAY\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2166,6 +2345,7 @@ static int psp_hw_fini(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;psp.t=
a_fw) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_ras_terminate(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp_securedisplay_terminate(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_rap_terminate(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_dtm_terminate(psp);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp_hdcp_terminate(psp);<br>
@@ -2230,6 +2410,11 @@ static int psp_suspend(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_E=
RROR(&quot;Failed to terminate rap ta\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_securedisplay_terminate(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;=
Failed to terminate securedisplay ta\n&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_asd_unload(psp=
);<br>
@@ -2313,6 +2498,11 @@ static int psp_resume(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_e=
rr(psp-&gt;adev-&gt;dev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;RAP: Failed to initialize =
RAP\n&quot;);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_securedisplay_initialize(psp);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ret)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(psp-&gt;=
adev-&gt;dev,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;SECUREDISPLAY: Failed to initialize S=
ECUREDISPLAY\n&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt=
;firmware.mutex);<br>
@@ -2620,6 +2810,11 @@ static int parse_ta_bin_descriptor(struct psp_contex=
t *psp,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;ta_rap_ucode_size&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 le32_to_cpu(desc-&gt;size_bytes);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; psp-&gt;ta_rap_start_addr&nbsp;&nbsp;&nbsp;&nbsp; =3D=
 ucode_start_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_FW_TYPE_PSP_SECUREDISPLAY:<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ta_securedisplay_ucode_version&nbsp; =3D le32_to_cpu(des=
c-&gt;fw_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ta_securedisplay_ucode_size&nbsp;&nbsp;&nbsp;&nbsp; =3D =
le32_to_cpu(desc-&gt;size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp-&gt;ta_securedisplay_start_addr&nbsp;&nbsp;&nbsp;&nbsp; =3D =
ucode_start_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dev_warn(psp-&gt;adev-&gt;dev, &quot;Unsupported TA t=
ype: %d\n&quot;, desc-&gt;fw_type);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.h<br>
index da250bc1ac57..cb50ba445f8c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
@@ -30,6 +30,7 @@<br>
&nbsp;#include &quot;ta_xgmi_if.h&quot;<br>
&nbsp;#include &quot;ta_ras_if.h&quot;<br>
&nbsp;#include &quot;ta_rap_if.h&quot;<br>
+#include &quot;ta_secureDisplay_if.h&quot;<br>
&nbsp;<br>
&nbsp;#define PSP_FENCE_BUFFER_SIZE&nbsp;&nbsp; 0x1000<br>
&nbsp;#define PSP_CMD_BUFFER_SIZE&nbsp;&nbsp;&nbsp;&nbsp; 0x1000<br>
@@ -40,6 +41,7 @@<br>
&nbsp;#define PSP_HDCP_SHARED_MEM_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x4000<br>
&nbsp;#define PSP_DTM_SHARED_MEM_SIZE 0x4000<br>
&nbsp;#define PSP_RAP_SHARED_MEM_SIZE 0x4000<br>
+#define PSP_SECUREDISPLAY_SHARED_MEM_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
4000<br>
&nbsp;#define PSP_SHARED_MEM_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x4000<br>
&nbsp;#define PSP_FW_NAME_LEN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; 0x24<br>
&nbsp;<br>
@@ -171,6 +173,15 @@ struct psp_rap_context {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&nbsp;};<br>
&nbsp;<br>
+struct psp_securedisplay_context {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; securedisplay_initialized;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; session_id;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; *securedisplay_shared_bo;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; securedisplay=
_shared_mc_addr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; *securedisplay_shared_buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
+};<br>
+<br>
&nbsp;#define MEM_TRAIN_SYSTEM_SIGNATURE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x54534942<br>
&nbsp;#define GDDR6_MEM_TRAINING_DATA_SIZE_IN_BYTES&nbsp;&nbsp; 0x1000<br>
&nbsp;#define GDDR6_MEM_TRAINING_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8000<br>
@@ -298,12 +309,17 @@ struct psp_context<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_rap_ucode_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ta_rap_start_addr;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_securedisplay_ucode_version;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_securedisplay_ucode_size;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ta_securedisplay_start_addr;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_asd_context&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; asd_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_xgmi_context&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; xgmi_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_ras_context&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_hdcp_context&nb=
sp; hdcp_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_dtm_context&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dtm_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_rap_context&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rap_context;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_securedisplay_context&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; securedisplay_context;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; mutex;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_memory_training=
_context mem_train_ctx;<br>
&nbsp;};<br>
@@ -380,6 +396,7 @@ int psp_ras_trigger_error(struct psp_context *psp,<br>
&nbsp;int psp_hdcp_invoke(struct psp_context *psp, uint32_t ta_cmd_id);<br>
&nbsp;int psp_dtm_invoke(struct psp_context *psp, uint32_t ta_cmd_id);<br>
&nbsp;int psp_rap_invoke(struct psp_context *psp, uint32_t ta_cmd_id);<br>
+int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id);=
<br>
&nbsp;<br>
&nbsp;int psp_rlc_autoload_start(struct psp_context *psp);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.c<br>
new file mode 100644<br>
index 000000000000..455978781380<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c<br>
@@ -0,0 +1,174 @@<br>
+/*<br>
+ * Copyright 2020 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ *<br>
+ */<br>
+#include &lt;linux/debugfs.h&gt;<br>
+#include &lt;linux/pm_runtime.h&gt;<br>
+<br>
+#include &quot;amdgpu.h&quot;<br>
+#include &quot;amdgpu_securedisplay.h&quot;<br>
+<br>
+/**<br>
+ * DOC: AMDGPU SECUREDISPLAY debugfs test interface<br>
+ *<br>
+ * how to use?<br>
+ * echo opcode &lt;value&gt; &gt; &lt;debugfs_dir&gt;/dri/xxx/securedispla=
y_test<br>
+ * eg. echo 1 &gt; &lt;debugfs_dir&gt;/dri/xxx/securedisplay_test<br>
+ * eg. echo 2 phy_id &gt; &lt;debugfs_dir&gt;/dri/xxx/securedisplay_test<b=
r>
+ *<br>
+ * opcode:<br>
+ * 1=1B$B!'=1B(BQuery whether TA is responding used only for validation pu=
pose<br>
+ * 2: Send region of Interest and CRC value to I2C. (uint32)phy_id is<br>
+ * send to determine which DIO scratch register should be used to get<br>
+ * ROI and receive i2c_buf as the output.<br>
+ *<br>
+ * You can refer more detail from header file ta_securedisplay_if.h<br>
+ *<br>
+ */<br>
+<br>
+void psp_securedisplay_parse_resp_status(struct psp_context *psp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ta_securedisplay_status status)<=
br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (status) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_SECUREDISPLAY_STATUS__SUCCESS=
:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_SECUREDISPLAY_STATUS__GENERIC=
_FAILURE:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;Secure display: Generic Fail=
ure.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_SECUREDISPLAY_STATUS__INVALID=
_PARAMETER:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;Secure display: Invalid Para=
meter.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_SECUREDISPLAY_STATUS__NULL_PO=
INTER:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;Secure display: Null Pointer=
.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_SECUREDISPLAY_STATUS__I2C_WRI=
TE_ERROR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;Secure display: Failed to wr=
ite to I2C.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_SECUREDISPLAY_STATUS__READ_DI=
O_SCRATCH_ERROR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;Secure display: Failed to Re=
ad DIO Scratch Register.&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case TA_SECUREDISPLAY_STATUS__READ_CR=
C_ERROR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;Secure display: Failed to Re=
ad CRC&quot;);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(psp-&gt;adev-&gt;dev, &quot;Secure display: Failed to pa=
rse status: %d\n&quot;, status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct secure=
display_cmd **cmd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum ta_securedisplay_command command=
_id)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *cmd =3D (struct securedisplay_cmd *)=
psp-&gt;securedisplay_context.securedisplay_shared_buf;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(*cmd, 0, sizeof(struct secured=
isplay_cmd));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*cmd)-&gt;status =3D TA_SECUREDISPLA=
Y_STATUS__GENERIC_FAILURE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*cmd)-&gt;cmd_id =3D command_id;<br>
+}<br>
+<br>
+static ssize_t amdgpu_securedisplay_debugfs_write(struct file *f, const ch=
ar __user *buf,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size_t size, loff_t *pos)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D (struc=
t amdgpu_device *)file_inode(f)-&gt;i_private;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context *psp =3D &amp;adev=
-&gt;psp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct securedisplay_cmd *securedispl=
ay_cmd;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_device *dev =3D adev_to_dr=
m(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t phy_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t op;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char str[64];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; char i2c_output[256];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">[Kevin]:</div>
<div class=3D"PlainText">the driver should avoid allocate big block size me=
mory in kernel stack. (x86_64:: kernel stack size is fix16K).<br>
In other words, you don't know how many kernel stacks will be used in upstr=
eam.</div>
<div class=3D"PlainText">Generally speaking,&nbsp; there is no problem, but=
 it is really unreasonable.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Best Regards,<br>
Kevin<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (*pos || size &gt; sizeof(str) - 1=
)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(str,&nbsp; 0, sizeof(str));<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy_from_user(str, buf, size);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D pm_runtime_get_sync(dev-&gt;d=
ev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret &lt; 0) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pm_runtime_put_autosuspend(dev-&gt;dev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return ret;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (size &lt; 3)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sscanf(str, &quot;%u &quot;, &amp;op);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; sscanf(str, &quot;%u %u&quot;, &amp;op, &amp;phy_id);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (op) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 1:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp_prep_securedisplay_cmd_buf(psp, &amp;securedisplay_cmd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_SECUREDISPLAY=
_COMMAND__QUERY_TA);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__=
QUERY_TA);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (securedispla=
y_cmd-&gt;status =3D=3D TA_SECUREDISPLAY_STATUS__SUCCESS)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;SECUREDISPLAY:=
 query securedisplay TA ret is 0x%X\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; securedisplay_cmd-&gt;securedisplay_out_message.query_ta.query_cmd_ret=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_securedisplay_parse_resp_status(psp, se=
curedisplay_cmd-&gt;status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 2:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; psp_prep_securedisplay_cmd_buf(psp, &amp;securedisplay_cmd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_SECUREDISPLAY=
_COMMAND__SEND_ROI_CRC);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; securedisplay_cmd-&gt;securedisplay_in_message.send_roi_crc.phy_=
id =3D phy_id;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ret =3D psp_securedisplay_invoke(psp, TA_SECUREDISPLAY_COMMAND__=
SEND_ROI_CRC);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (!ret) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (securedispla=
y_cmd-&gt;status =3D=3D TA_SECUREDISPLAY_STATUS__SUCCESS) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(i2c_output,&nbsp; 0, sizeof(i2c_outp=
ut));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; TA_SECUREDISPLAY_I2C_B=
UFFER_SIZE; i++)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; sprintf(i2c_output, &quot;%s 0x%X&quot;, i2c_output,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; securedisplay_cmd-&gt;=
securedisplay_out_message.send_roi_crc.i2c_buf[i]);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;SECUREDISPLAY:=
 I2C buffer out put is :%s\n&quot;, i2c_output);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_securedisplay_parse_resp_status(psp, se=
curedisplay_cmd-&gt;status);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_err(adev-&gt;dev, &quot;Invalid input: %s\n&quot;, str);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_mark_last_busy(dev-&gt;dev=
);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pm_runtime_put_autosuspend(dev-&gt;de=
v);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return size;<br>
+}<br>
+<br>
+static const struct file_operations amdgpu_securedisplay_debugfs_ops =3D {=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .owner =3D THIS_MODULE,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .read =3D NULL,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write =3D amdgpu_securedisplay_debug=
fs_write,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .llseek =3D default_llseek<br>
+};<br>
+<br>
+void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev)<br>
+{<br>
+#if defined(CONFIG_DEBUG_FS)<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;psp.securedisplay_conte=
xt.securedisplay_initialized)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_create_file(&quot;securedispl=
ay_test&quot;, S_IWUSR, adev_to_drm(adev)-&gt;primary-&gt;debugfs_root,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev, &amp;amdgpu_securedisplay_debugfs_ops=
);<br>
+#endif<br>
+}<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_securedisplay.h<br>
new file mode 100644<br>
index 000000000000..983446c72520<br>
--- /dev/null<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.h<br>
@@ -0,0 +1,36 @@<br>
+/*<br>
+ * Copyright 2020 Advanced Micro Devices, Inc.<br>
+ *<br>
+ * Permission is hereby granted, free of charge, to any person obtaining a=
<br>
+ * copy of this software and associated documentation files (the &quot;Sof=
tware&quot;),<br>
+ * to deal in the Software without restriction, including without limitati=
on<br>
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,<br>
+ * and/or sell copies of the Software, and to permit persons to whom the<b=
r>
+ * Software is furnished to do so, subject to the following conditions:<br=
>
+ *<br>
+ * The above copyright notice and this permission notice shall be included=
 in<br>
+ * all copies or substantial portions of the Software.<br>
+ *<br>
+ * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY KIN=
D, EXPRESS OR<br>
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY=
,<br>
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO EVENT=
 SHALL<br>
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES O=
R<br>
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,<b=
r>
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR<b=
r>
+ * OTHER DEALINGS IN THE SOFTWARE.<br>
+ *<br>
+ *<br>
+ */<br>
+#ifndef _AMDGPU_SECUREDISPLAY_H<br>
+#define _AMDGPU_SECUREDISPLAY_H<br>
+<br>
+#include &quot;amdgpu.h&quot;<br>
+#include &quot;ta_secureDisplay_if.h&quot;<br>
+<br>
+void amdgpu_securedisplay_debugfs_init(struct amdgpu_device *adev);<br>
+void psp_securedisplay_parse_resp_status(struct psp_context *psp,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum ta_securedisplay_status status);<br>
+void psp_prep_securedisplay_cmd_buf(struct psp_context *psp, struct secure=
display_cmd **cmd,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; enum ta_securedisplay_command command_id);<br>
+<br>
+#endif<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ucode.h<br>
index 0e43b46d3ab5..46449e70348b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h<br>
@@ -122,6 +122,9 @@ struct ta_firmware_header_v1_0 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_dtm_ucode_vers=
ion;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_dtm_offset_byt=
es;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_dtm_size_bytes=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_securedisplay_ucode_versi=
on;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_securedisplay_offset_byte=
s;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ta_securedisplay_size_bytes;=
<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;enum ta_fw_type {<br>
@@ -132,6 +135,7 @@ enum ta_fw_type {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_HDCP,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_DTM,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_RAP,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TA_FW_TYPE_PSP_SECUREDISPLAY,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct ta_fw_bin_desc {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c<br>
index d7f92634eba2..4b1cc5e9ee92 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
@@ -92,8 +92,6 @@ static int psp_v10_0_init_microcode(struct psp_context *p=
sp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint=
8_t *)ta_hdr +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_=
to_cpu(ta_hdr-&gt;header.ucode_array_offset_bytes);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_fw_version =3D le32_to_cpu(ta_hdr-&gt;header.uco=
de_version);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_version =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_=
to_cpu(ta_hdr-&gt;ta_dtm_ucode_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_size =3D<br>
@@ -101,6 +99,16 @@ static int psp_v10_0_init_microcode(struct psp_context =
*psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_start_addr =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint=
8_t *)adev-&gt;psp.ta_hdcp_start_addr +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_=
to_cpu(ta_hdr-&gt;ta_dtm_offset_bytes);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_securedisplay_ucode_version =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_securedisplay_ucode_version);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_securedisplay_ucode_size =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_securedisplay_size_bytes);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_securedisplay_start_addr =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (uint8_t *)adev-=
&gt;psp.ta_hdcp_start_addr +<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; le32_to_cpu(ta_h=
dr-&gt;ta_securedisplay_offset_bytes);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;psp.ta_fw_version =3D le32_to_cpu(ta_hdr-&gt;header.uco=
de_version);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7CKevin1.Wang%40amd.com%7C105d330e2a9f417d324408d8b775887e%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637461062772245289%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3Dj3wrRxVVnVEu9UWN%2F1UiLZUHyO6jNy8tBEOlkq0DOGk%3D&amp;amp;r=
eserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D0=
4%7C01%7CKevin1.Wang%40amd.com%7C105d330e2a9f417d324408d8b775887e%7C3dd8961=
fe4884e608e11a82d994e183d%7C0%7C0%7C637461062772245289%7CUnknown%7CTWFpbGZs=
b3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C10=
00&amp;amp;sdata=3Dj3wrRxVVnVEu9UWN%2F1UiLZUHyO6jNy8tBEOlkq0DOGk%3D&amp;amp=
;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB30229E48072E88610B32FCDAA2A90MN2PR12MB3022namp_--

--===============1653006187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1653006187==--
