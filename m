Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B30C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 08:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CFB810F464;
	Mon, 18 Mar 2024 08:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KUfymbpS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E468510F464
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 08:00:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENYzgyYns1vtABdT0WbYx191BE5x1PbY5Av8rABw7j9BuQAyadnpUc42iihjxH4b3m49IdYncTyfxE2ucdUCjCkAq13UZqlhFd+8eoZEXGlCSvmVkTMZ5/Zhsa+dgwhPg1pJGJFq88950vE6VCHWlYZMaA48Oc15E5IYnQs4XlTprhkxEXdpohh3j7P6+04QzNyTEs5k+sux2BsRyyHhG5cuRcNenOJT+3Kk28ZefXaJYJQEMMMHpHAqDRU9BmYN5Lja0ybuEud7yqn5dOJX3ObdY8d/3fIxFuR/F8OOx+iDvxUJpfoUwexkW3RJpCp19ChQMTQcavEolUtxLyCEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeUP6NQWVN/uBt7JYWWt/PEakiKoiQtrH3YN4jAaz50=;
 b=lbSvBG8yybRGctrYGedLABc2rGSF9l47HuK85JySocVgfXlf2squYIl/IoFoEybgVCByVEEDC7y83xtP6pbS8oac3YhrXywrsk0xbctCnGljs5b5iAeijiqY70o34Sbx1L+lzvvzYQI7fSTNuHqJPsl6ccovwSYdCOD1ZZvVuux8hl2jJF/mhBP5jHI4yL0HyppqTFvaa740vD8w3xljKnXsbiuQh5V9TlueSqxuLybs3870vZuyU/qhtHb7votloH/+k08eixkhqltXKf71RNKF/QD2BwxIEYa2FpJ8I8K6fYTWLR8qxxKHOWYyLUT5/Y4/kjQXu2l9f6DaHKEB+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeUP6NQWVN/uBt7JYWWt/PEakiKoiQtrH3YN4jAaz50=;
 b=KUfymbpStg5fPYqN0UhfG/g1Yynl4KCt2BQLKpoSBb9NXctohwW39v2PpkTp8/PI9bViv2FeOlJ/9AUqkYBFmO2i0qrZj+bxfGUQVZG35K7h7uU3n2LPFMs6iIbEJfOha0e7N1kZdFZiD/Nuz/JvLvPInPbz0I/QUfRnfXjOENA=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 08:00:16 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::74e4:f50f:79af:c996%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 08:00:16 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Topic: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS
 poison
Thread-Index: AQHaeQWjJPR8Frv4C0mYY2RQEOWzjLE9InlQ
Date: Mon, 18 Mar 2024 08:00:16 +0000
Message-ID: <BN9PR12MB5257F6689E8A4F4266CB308CFC2D2@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240318072623.352614-1-tao.zhou1@amd.com>
 <20240318072623.352614-3-tao.zhou1@amd.com>
In-Reply-To: <20240318072623.352614-3-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f3be08ef-e9ae-4dce-a8b6-6990cc6701cb;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-18T07:59:53Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|BY5PR12MB4148:EE_
x-ms-office365-filtering-correlation-id: c43bb0a8-43c6-4ab6-a193-08dc472172d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a8+4BuBVCET+dQXPwzmL/uufbanmjxRauo0x7Vw3vbYKCIJXsNP/2g3njpYmV87uDsXZxHtVLB/ByMBwfRTSoJ5oyyYXb75jGYnHyRzVsGUjeiQkmOucaJkv+9w8LMoDXze9Fm+KVOKja8V9EvvAHd2XCwiZh23CKfKmcR91L65DxGHOpVwjFgXnjYlyowphR8UZb/ZUb+8heyuWgzxICdgkkM7VsduHqS2w6HXFsPLuOzpggW+FtU+6tQ0QcWwpS/HXRrv/SydCWKm+eapwfLkshoUSOIdwNOi77vblZreG35N9XZqNm0/gR731zq1SLgYB/meaJJtS44F8B7jhbIZiTHGepEh31KpgSgffXiuOR5RYCDI7LopSntI0N+RaJ4YmP4TiAbxL22BWoAMMbdnufWN+NWpnXiHIpY+1X4F/BOKfbvnu+1hXHMonTsCBkdKbQk60ng4T2vun0ON8js9T+QZwhplABdzQM43aakcqPTaPbthquaHcmO1YSjrHTsYQBcBeOv+i6x5sDLN1KXxA1SlqH6fnYL/9kXikIk/GboN4x3vGq/ih5jemwumAhHQQf+MaL24iDSiJk3/2wRBQle25KOKRPmH5lCrnaYXwDV0kWrgXT8vxskzYkc3j0FOK0TmwqrjJnRUhTOo6m4ChCzzwh+aAtLwlqrW9UHTOXVoEjgTVWmjc7ovhpAMW9MWNV+IiANr6dsRtTt4xsUmtDvczcwZ4OCx8Pt9BDJ0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kq946/htPzh6EN18a94Ig7fTPGkgTiMU/UQyrJJ7k/Qiru6hJzCnA5UOaYzk?=
 =?us-ascii?Q?07NbO+NO6dR5lNv5KwkVbbrakI8zIAayps7H2lRptnucYAzrzxjVSF3cFOhP?=
 =?us-ascii?Q?hOeqqrg4F3nAeMMPCxbjMF13X8f3dN+ZdZ52TNlhf/Rm+zguHVJ1HdNK1xKD?=
 =?us-ascii?Q?HBQvU40L/AELZYHmpPxl7oG5Cmg5Hax/AB8+7t2hVjCXN7wVZKUG3FZm9kJ2?=
 =?us-ascii?Q?Y/P4QWILruQCozgoOCnKNYrIsMbaA5PXysKpw0BQyzNDUrm5QtI+9cXU4jUJ?=
 =?us-ascii?Q?03MuG2qMTlXado/f64jcZxLpZaEnYgBBlQxWpNh9qHyRFX3ksLpTETbiVQXo?=
 =?us-ascii?Q?iVz3dSSrXMZJ5XPbVjh6h5Q35PXVZN4uUVyGu868qMiu1AX/RY1dq0qJDyMB?=
 =?us-ascii?Q?TJIEAU99MgAPTDC2qHN5sZDu5UYaWNhKCGYt6UQ3X6RG7zNsO6Yqou2Px+iA?=
 =?us-ascii?Q?4AU6SOYacorj0Wg4J4Oy2SFCdKYDWQ63uKITt/MNA5TCDjL2kQjYSDCzFBZs?=
 =?us-ascii?Q?ZLs3jMMk0wosDeEnYtawr6UHDZld+jbMm3+gi8qj1DbiCF2JJFlN4+1xIFwr?=
 =?us-ascii?Q?4tiIh+zNY1egSQI2ZK9IfhmHHADi+RzQ7SCLmDnSocRVi1eOEOsfkkOymT4R?=
 =?us-ascii?Q?HJv75QvFEc+a+ZV9he1E5D0CzUJDN4pj/jDkGomX+gqm7AKLjmjHgY3jqvFA?=
 =?us-ascii?Q?U84w3FBEpUjFW+9eEHp+RiQR7lRha3o/ofF2LBN5wd7wJPRMvO+ZtsmHNK5/?=
 =?us-ascii?Q?5pDPHS+HREO0GRtgrfalISagRYOYYIazOBr+veTyaIGp5SkBAbWxGmamKUp8?=
 =?us-ascii?Q?qWVTigMy5EXPwXZukPeLBvydEOkZfXIlHC3W5rjg70VpWgzMO1BG7fUtw+i4?=
 =?us-ascii?Q?3YafrMk5YMCXqAhndxZFPjhdxwW20nClyfh2Zx70G/O3VzSbeLSYi3HpWLQb?=
 =?us-ascii?Q?4+EdizZprVKkxL0QoYscmj+Tvw4NE6NiPEJ325d0E3nsMU+I1B7erOapPUYq?=
 =?us-ascii?Q?MhxI6SwXWf1jn2uRjM/VZHqRHCgdd7JM8+OrwydHPDwy1+/gFK2/aoSpEr0V?=
 =?us-ascii?Q?jGFMHi+CKrs/nX/1GECxFbbxBNw5L09pEG/rqK7KN1+2QbKWSFKJB6KoNzNG?=
 =?us-ascii?Q?D87MgFrSoZ9LLfK42a4Zuuo521kgcY9VVt/6zmWR9oU2zQo5Q02I0VlXojNn?=
 =?us-ascii?Q?xVSijBGDvUmzIl9PKsRiS/1pjXkraHCvY4e4vxh8PWCTVsLIqMAXuEBzu/hF?=
 =?us-ascii?Q?Ihz1gk+2ncUQ/f21rrEwg/nh1zEu1fvRqLbbc7HJczbN0s/pQg/eGxkLTEXt?=
 =?us-ascii?Q?diZRBC8WYUkuwMUCroty3uuQl7SjknOIJd5dmlpD3Lwl7c24a8Mf7AueyOLY?=
 =?us-ascii?Q?GFYFvouBWVwADJ90ws7Io0RhqeJkZk7rt8HKUzfHIEOZdsvGEYeiauR2kSzq?=
 =?us-ascii?Q?w18gUch4ShdBqMuGIkM/5p0PYQ9yKxGRx/EzabuLp4Drs3JQc+Z42eXuBAiH?=
 =?us-ascii?Q?V1wudj8WgdGz4fkyrQVL+yyZUCLXr6ZdzDmpTfU2kZE2TmTSXCYnrbdJvpIq?=
 =?us-ascii?Q?oQlhvWtmbPkut8T4/tWE4OMwnel6unZUvoRscQDN?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c43bb0a8-43c6-4ab6-a193-08dc472172d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 08:00:16.5052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GzVr/mnCSBVZ5BpCCSoqbRGNOVBe6NdW79y03bBw3WGooAoDAmrd2jkixDPol4vRwcyS1AhQ5lUsy03f6v9HMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148
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

Series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Tao Zhou
Sent: Monday, March 18, 2024 15:26
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: make reset method configurable for RAS poi=
son

Each RAS block has different requirement for gpu reset in poison consumptio=
n handling.
Add support for mmhub RAS poison consumption handling.

v2: remove the mmhub poison support for kfd int v10.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c       | 14 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h       |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 13 +++++++-----  .../gpu/d=
rm/amd/amdkfd/kfd_int_process_v11.c  |  9 +++++----
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 20 ++++++++++++++-----
 8 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_amdkfd.c
index 0b4910108f61..66753940bb4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -760,7 +760,7 @@ bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev)  =
}

 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
-       enum amdgpu_ras_block block, bool reset)
+       enum amdgpu_ras_block block, uint32_t reset)
 {
        amdgpu_umc_poison_handler(adev, block, reset);  } diff --git a/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_=
amdkfd.h
index 03bf20e0e3da..ad50c7bbc326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -400,7 +400,7 @@ void amdgpu_amdkfd_debug_mem_fence(struct amdgpu_device=
 *adev);  int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
                                struct tile_config *config);
 void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *ad=
ev,
-                       enum amdgpu_ras_block block, bool reset);
+                       enum amdgpu_ras_block block, uint32_t reset);
 bool amdgpu_amdkfd_is_fed(struct amdgpu_device *adev);  bool amdgpu_amdkfd=
_bo_mapped_to_dev(struct amdgpu_device *adev, struct kgd_mem *mem);  void a=
mdgpu_amdkfd_block_mmu_notifications(void *p); diff --git a/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e32a186c2de1..58fe7bebdf1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2045,7 +2045,7 @@ static void amdgpu_ras_interrupt_poison_consumption_h=
andler(struct ras_manager *
                }
        }

-       amdgpu_umc_poison_handler(adev, obj->head.block, false);
+       amdgpu_umc_poison_handler(adev, obj->head.block, 0);

        if (block_obj->hw_ops && block_obj->hw_ops->handle_poison_consumpti=
on)
                poison_stat =3D block_obj->hw_ops->handle_poison_consumptio=
n(adev);
@@ -2698,7 +2698,7 @@ static int amdgpu_ras_page_retirement_thread(void *pa=
ram)
                atomic_dec(&con->page_retirement_req_cnt);

                amdgpu_umc_bad_page_polling_timeout(adev,
-                               false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
+                               0, MAX_UMC_POISON_POLLING_TIME_ASYNC);
        }

        return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.c
index 20436f81856a..2c02585dcbff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
@@ -186,9 +186,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,
        amdgpu_umc_handle_bad_pages(adev, ras_error_status);

        if (err_data->ue_count && reset) {
-               /* use mode-2 reset for poison consumption */
-               if (!entry)
-                       con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;
+               con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
        }

@@ -196,7 +194,7 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_=
device *adev,  }

 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-                       bool reset, uint32_t timeout_ms)
+                       uint32_t reset, uint32_t timeout_ms)
 {
        struct ras_err_data err_data;
        struct ras_common_if head =3D {
@@ -238,8 +236,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,
        if (reset) {
                struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);

-               /* use mode-2 reset for poison consumption */
-               con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               con->gpu_reset_flags |=3D reset;
                amdgpu_ras_reset_gpu(adev);
        }

@@ -247,7 +244,7 @@ int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_d=
evice *adev,  }

 int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-                       enum amdgpu_ras_block block, bool reset)
+                       enum amdgpu_ras_block block, uint32_t reset)
 {
        int ret =3D AMDGPU_RAS_SUCCESS;

@@ -311,7 +308,8 @@ int amdgpu_umc_process_ras_data_cb(struct amdgpu_device=
 *adev,
                void *ras_error_status,
                struct amdgpu_iv_entry *entry)
 {
-       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry,=
 true);
+       return amdgpu_umc_do_page_retirement(adev, ras_error_status, entry,
+                               AMDGPU_RAS_GPU_RESET_MODE1_RESET);
 }

 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev) diff --git a/driver=
s/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 26d2ae498daf..4365a20eeb49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -103,7 +103,7 @@ struct amdgpu_umc {
 int amdgpu_umc_ras_sw_init(struct amdgpu_device *adev);  int amdgpu_umc_ra=
s_late_init(struct amdgpu_device *adev, struct ras_common_if *ras_block);  =
int amdgpu_umc_poison_handler(struct amdgpu_device *adev,
-                       enum amdgpu_ras_block block, bool reset);
+                       enum amdgpu_ras_block block, uint32_t reset);
 int amdgpu_umc_process_ecc_irq(struct amdgpu_device *adev,
                struct amdgpu_irq_src *source,
                struct amdgpu_iv_entry *entry);
@@ -123,5 +123,5 @@ int amdgpu_umc_loop_channels(struct amdgpu_device *adev=
,
                        umc_func func, void *data);

 int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_device *adev,
-                       bool reset, uint32_t timeout_ms);
+                       uint32_t reset, uint32_t timeout_ms);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_int_process_v10.c
index 650da18b0d87..740f89aafbc0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -134,6 +134,7 @@ static void event_interrupt_poison_consumption(struct k=
fd_node *dev,  {
        enum amdgpu_ras_block block =3D 0;
        int old_poison, ret =3D -EINVAL;
+       uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

        if (!p)
@@ -153,6 +154,8 @@ static void event_interrupt_poison_consumption(struct k=
fd_node *dev,
        case SOC15_IH_CLIENTID_UTCL2:
                ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__GFX;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
@@ -160,6 +163,7 @@ static void event_interrupt_poison_consumption(struct k=
fd_node *dev,
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
                block =3D AMDGPU_RAS_BLOCK__SDMA;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        default:
                break;
@@ -170,17 +174,16 @@ static void event_interrupt_poison_consumption(struct=
 kfd_node *dev,
        /* resetting queue passes, do page retirement without gpu reset
         * resetting queue fails, fallback to gpu reset solution
         */
-       if (!ret) {
+       if (!ret)
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, false);
-       } else {
+       else
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
-       }
+
+       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);
 }

 static bool event_interrupt_isr_v10(struct kfd_node *dev, diff --git a/dri=
vers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/=
kfd_int_process_v11.c
index 7e2859736a55..d3d6b5c180b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -193,6 +193,7 @@ static void event_interrupt_poison_consumption_v11(stru=
ct kfd_node *dev,  {
        enum amdgpu_ras_block block =3D 0;
        int ret =3D -EINVAL;
+       uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

        if (!p)
@@ -212,10 +213,13 @@ static void event_interrupt_poison_consumption_v11(st=
ruct kfd_node *dev,
                if (dev->dqm->ops.reset_queues)
                        ret =3D dev->dqm->ops.reset_queues(dev->dqm, pasid)=
;
                block =3D AMDGPU_RAS_BLOCK__GFX;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        case SOC21_INTSRC_SDMA_ECC:
        default:
                block =3D AMDGPU_RAS_BLOCK__GFX;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        }

@@ -223,10 +227,7 @@ static void event_interrupt_poison_consumption_v11(str=
uct kfd_node *dev,

        /* resetting queue passes, do page retirement without gpu reset
           resetting queue fails, fallback to gpu reset solution */
-       if (!ret)
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, false);
-       else
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
+       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);
 }

 static bool event_interrupt_isr_v11(struct kfd_node *dev, diff --git a/dri=
vers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/k=
fd_int_process_v9.c
index 11641f4645e6..2a37ab7a7150 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -145,6 +145,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,  {
        enum amdgpu_ras_block block =3D 0;
        int old_poison, ret =3D -EINVAL;
+       uint32_t reset =3D 0;
        struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid);

        if (!p)
@@ -164,6 +165,15 @@ static void event_interrupt_poison_consumption_v9(stru=
ct kfd_node *dev,
        case SOC15_IH_CLIENTID_UTCL2:
                ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
                block =3D AMDGPU_RAS_BLOCK__GFX;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+               break;
+       case SOC15_IH_CLIENTID_VMC:
+       case SOC15_IH_CLIENTID_VMC1:
+               ret =3D kfd_dqm_evict_pasid(dev->dqm, pasid);
+               block =3D AMDGPU_RAS_BLOCK__MMHUB;
+               if (ret)
+                       reset =3D AMDGPU_RAS_GPU_RESET_MODE1_RESET;
                break;
        case SOC15_IH_CLIENTID_SDMA0:
        case SOC15_IH_CLIENTID_SDMA1:
@@ -171,6 +181,7 @@ static void event_interrupt_poison_consumption_v9(struc=
t kfd_node *dev,
        case SOC15_IH_CLIENTID_SDMA3:
        case SOC15_IH_CLIENTID_SDMA4:
                block =3D AMDGPU_RAS_BLOCK__SDMA;
+               reset =3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;
                break;
        default:
                break;
@@ -181,17 +192,16 @@ static void event_interrupt_poison_consumption_v9(str=
uct kfd_node *dev,
        /* resetting queue passes, do page retirement without gpu reset
         * resetting queue fails, fallback to gpu reset solution
         */
-       if (!ret) {
+       if (!ret)
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, unmap queue flow succeeded=
: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, false);
-       } else {
+       else
                dev_warn(dev->adev->dev,
                        "RAS poison consumption, fall back to gpu reset flo=
w: client id %d\n",
                        client_id);
-               amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, blo=
ck, true);
-       }
+
+       amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, block, rese=
t);
 }

 static bool context_id_expected(struct kfd_dev *dev)
--
2.34.1

