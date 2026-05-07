Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2ECCD343F
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 20:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24ADC10F209;
	Thu,  7 May 2026 20:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xVMM95Ix";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5FF10F209
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2026 20:13:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJP7s5MMheSSeb8GHJ9wAr/cQclGjo+ANmyi9l11wOskWwU8JwK8/DaKt3x94XQHL/fNf8jiiHzhypkfGQGuJ7FnoBIgDa1m96j1V0+1gWEVVqpbe0dK0woIc58krGcJ0/bsgGh63sWhzaBluWy/A0gOZM0HEK52lymu00YV5Vge1MNUJhWexcVITbaJKZlL9dpW80z6EVzpoD+noG90TLU4I+RtX5BUDNYBoJZM4r3RQY6hlknRktrh3lUvrq2IeM8KCi2TmgD5CWufeOpMEN2czmJr3QMUkIbBU4+bIUjRSy8jUT66Joy+Gg1L8GKaEVZQ3RWRjnad3rRCI5Q3EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3S0JyZteBTOjs7xHz005GA27fsjmgs+y5MGLeSiFb4=;
 b=EjpPiUS6MP4q1XYw6mA/Ry4FrOfErbbVGEvEAg214qZAgoL+G8pjfQlTyyvW+7ZoTPPPSxmHxooMVivJ+Yo1Q9xafPACOxbUBFL7WRHNqSLiEQv2eCggjLBvG8nFI7ZjAX5xoyxhcXYsxhNnKz5vg/Im8C8Wpg48rZ3slsi3Ceaqv4scjw1aBUeO2fVCobkP2Ez42piWuNhM2/Mq0JBnCyBuKj79AG1UbGKYB3BWjfMZW07SD31FMlSlnxSdSCooVdqlF2PYYaQPvn0fx3IXWDNiXrUvwna9UoRkVRl9JxAd8dT6YfgRZWk9D61nHKLhaYaSuN/d1QHgmsPKnwZ6VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3S0JyZteBTOjs7xHz005GA27fsjmgs+y5MGLeSiFb4=;
 b=xVMM95IxADHNnDI31WMBdMHXVphvQdz4fNJ+YiqWAAVHNB+cp+Asme+ZQGSH5HnsvrXxglgPdntkIAV1Bs3EVpUqXIMC8lhxX9eakHsizYz+jN8CR/+BkMXyOIrKXofmnVs704dzZ2emv2NE7Ps9LqrdONs13K3BI8ax3PZWLBU=
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com (2603:10b6:a03:45c::6)
 by SJ2PR12MB8955.namprd12.prod.outlook.com (2603:10b6:a03:542::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 20:13:05 +0000
Received: from SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67]) by SJ1PR12MB6121.namprd12.prod.outlook.com
 ([fe80::3fd:549f:f30:cd67%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 20:13:04 +0000
From: "Xie, Chenglei" <Chenglei.Xie@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lu, 
 Victor Cheng Chi (Victor)" <VictorChengChi.Lu@amd.com>
Subject: RE: [PATCH] drm/amdgpu: bound bad-page list writes to allocated
 capacity
Thread-Topic: [PATCH] drm/amdgpu: bound bad-page list writes to allocated
 capacity
Thread-Index: AQHc3jAVmCK3bZNpM0e9UFAfnAuah7YC/nWQ
Date: Thu, 7 May 2026 20:13:04 +0000
Message-ID: <SJ1PR12MB6121C866664DDBE850559F22803C2@SJ1PR12MB6121.namprd12.prod.outlook.com>
References: <20260507144449.25778-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260507144449.25778-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-07T20:09:32.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR12MB6121:EE_|SJ2PR12MB8955:EE_
x-ms-office365-filtering-correlation-id: 76380e84-3445-4b63-936d-08deac750c32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|18002099003|22082099003|38070700021|56012099003;
x-microsoft-antispam-message-info: T9vE1IGjmBlxV++guRiN3a7e0KTYDd7WVs7SXdAcuJH6CiXMogR/46pZ49TWTBA1W+pflYxiJyRqmuCqb21V8TL4rSQpEQSwjpyn2cMAielnIm9+hiRtLpKb0ei03nHhsklCwj6i63RuapNI2B0VSWVp3q+xNpCqkymkfH+jdiTzqsyoVvaGgxk8ANUA0NeSJr4s7c2IozwUZ2lUY5PChLm164Xh43XDRWYLIXcPCwfZAXkFElvGw0mr+E90gGV2uqkFyXOMU+XWt0IGJ8PcC0eXSC8uH6VLcmstVsR+g/ScHilqPZA263aLwl40DfZhCp0lg9fy22XrmkQMvhPruYZhUOsytb5JlYX3PttVAyQlkY2bqID8iDlEZjlockkzJ5dDbdoG2DIT/U4u4juX1bG1vBJdf+IcmArDZXkHFQNPGRdt9aWEweMUQf/3tZ4sxEc/Brt8MN44hOXIGnWzqqMF+PyPmAQQQ93Zu2W5dkgXIhmmExYzBjrjDm5Cyn1Rnfh6XgRGeQq0ugPx0yIm02UzPlh/XQQXRRfQjcxQMHd9s/plpEaAOApSRw3kvex9OCoPEtehFIvg3jb0G8efALpSX4WaMwxE+o2z1lAkaD25C1KVfKsrlsbQu0gvaVWV9tlLIlerEMDsVft5eM5+8HF/VB63zkFsM3y+PCVTXas0u4l4GuIPitNjv49OHvIYqaU7PoTQggrP8RNQryKqgtQXrypRqGaCoMPPN1OAg0WyjP6Zzc5ScWBoalrO3dxcVVRuFCpKTA14fXAMEAs38Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ1PR12MB6121.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(38070700021)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rKEjLgtpX1onYd8X+r23F92MRGYySgxSc19R19zZlpj2y8Nr1JhkMgcB3roa?=
 =?us-ascii?Q?MblvA5qvxGj4dwvT9z8TSoQj3IJB2+qKGpb3kN8M7hQeGUszye1NOBNECnVt?=
 =?us-ascii?Q?BnpsEzZeX6Oygk8DntK+KAH6V9wLndIjOO1lG3mWvSOXIAugmi/QWXPak1FC?=
 =?us-ascii?Q?e1JIF8OMZ5g0dV4iLD4hbBPPDOFyu46fPH1IzcUq8M4CDpXzUNNLhSdPxrBa?=
 =?us-ascii?Q?IZkLAzKkRWw3MoP/p+hkQ75C3+sXxYySyHIA8VLUQ7lh9iCOVL0J6Cn32Fyj?=
 =?us-ascii?Q?KLenkd8XYudqJpJs7ye/IyJjZVsyMBoj6EwxRXWMQZjYRTd7vmyYp+ExWqxj?=
 =?us-ascii?Q?D93U/pRf5ISoK0xCCFqSqJj2YHs+ozToyurl5Loq6K7Yw2+plXIGbpedu53O?=
 =?us-ascii?Q?Fil6dKwdB4up4McKi06Ujj4z5qr/sifJbSWgix4iGt/G8gOAGembJLUOsrhn?=
 =?us-ascii?Q?82mEWrSn2VWt3qUIGjkSZABLIXHn6NSlx56Ao1qfc9PR8soA9gLLo/PISWZG?=
 =?us-ascii?Q?bREZlb12wjzEm3siumNhpw/BrPite7k92xh1LhD6v0XYVvmXi24G6t8fn+50?=
 =?us-ascii?Q?nj4Sb+uPVYT1CWX+a/K3PjlV0UfkzDlrdw/WQuFD+n3z/XwoLmBQPFqzeT1J?=
 =?us-ascii?Q?a85RegPOEIoGNSfmql7yEei85C2qPK5URvDRb/dM1Iy3n3RyZXX08FHBBPD2?=
 =?us-ascii?Q?TPdMuqT5R6T/A5PpHIi7EXL1TMbbrAmsVObZ9rdQFWrKtgy0U5JL6g79BBJ+?=
 =?us-ascii?Q?nntqMLDz6V643VG3/RtFrZh9BnlC4GWWKbS1Y80M/4vshXp5cYN19XJibW4D?=
 =?us-ascii?Q?PtpbLcOQ5qMCcVxgcJdBMtINQl8KfN/8zX2d68wrGYGYgBYY21I3Yek1e59F?=
 =?us-ascii?Q?Z+o58s5XUke6bZ8nYn+f4xDPnNnIFr+9xpNKzL+sYsFhnEKYrkMBIy9t/z/h?=
 =?us-ascii?Q?c3vzM1/cmEH2L6f7wHK3uLzsM/BEOLNNjwUrfPXcRdkH+xEaBJ6LT2vIChGd?=
 =?us-ascii?Q?E/nCo3ZggZq9rwIOFQPssOQ/gqfdAft+QRr6r22H2vKKNwiDgZukPFrxl8wP?=
 =?us-ascii?Q?XPznLrAUgprFaZPhsH7l7h5q/BDXyeSbPjKl57+cF1/vONUpjAQM6L3Nls8V?=
 =?us-ascii?Q?bbvrkYPX+54qLDMpsC8YOdhAT5ox7ZHAJQrjOR4kccDbcnQbwRKFyxzEERo5?=
 =?us-ascii?Q?F5lH0IYCS0gV4NOyxe4N6pCeCSrVm/UFny2MmwaD74sxGXQeqpKBecjhtC6q?=
 =?us-ascii?Q?W10l0L7DnckJ+1ynRH9hrjsVwvPs/yWUH8RfgQO+cDSjD2FTd37j9vrpD8SS?=
 =?us-ascii?Q?JDVG7QC13lBXDKpftcgeOud642U+vLGKAx+kll3upSnRLrFqoOjmVSQ3YeXp?=
 =?us-ascii?Q?5RHex1wRtbujCFD32KGX59X1SERTb8De0XP8yyZf5Kcw6VwR7voyY0Lfxm3M?=
 =?us-ascii?Q?gQnV2HOdYlilFuRafHvp8aEeh8ZlJPEk0WOHD2RKXH3XRCwEaFA3pj3O1/ud?=
 =?us-ascii?Q?GPgMNd0rjOetSx2W3p/sf+qaTdJ9ZOIcyGXdb/KByv0d3HQbIhGs3boV67YW?=
 =?us-ascii?Q?yJhaewHYk2m2t0mOlXL0tl0VVfaAlJRcUpNnUF/JlQuVRXIiokLH0ki/2gK1?=
 =?us-ascii?Q?B+61Oem/Y08/BBWF20jyibEVaZhZ/FBKl8bfzV75kbJb2FUGwY1fuOG+hLx/?=
 =?us-ascii?Q?oQzYxf6XzFRG8TLcvfv/Za5VG/JawLi9s07CJIEt/m0pb4gu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6121.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76380e84-3445-4b63-936d-08deac750c32
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 20:13:04.8885 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y+iNSNNDV/5U+rRBu4dghUoCZm0S39RoekDYpBf9hjfZ+uEqbtIvOVhrQ6CdiGCNJd3ZWcNf3wnAdthYYlPJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8955
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

Hi team,

Could anyone help review this security bug fix patch for https://ontrack-in=
ternal.amd.com/browse/SWDEV-589525.

Thanks,
Chenglei

-----Original Message-----
From: Xie, Chenglei <Chenglei.Xie@amd.com>
Sent: Thursday, May 7, 2026 10:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang <Zhigang.Luo@amd.c=
om>; Deucher, Alexander <Alexander.Deucher@amd.com>; Xie, Chenglei <Chengle=
i.Xie@amd.com>
Subject: [PATCH] drm/amdgpu: bound bad-page list writes to allocated capaci=
ty

PF2VF bad-page data can provide more entries than the VF-side bad-page buff=
er can hold. amdgpu_virt_ras_add_bps() copied entries without checking rema=
ining capacity, which can overrun the 512-entry allocation.

Add an explicit max bad-page constant, validate pages against remaining spa=
ce before memcpy(), and make the helper return bool so the caller stops pro=
cessing when the buffer is full. This preserves normal behavior while preve=
nting overwrite from malformed or malicious input.

Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>
Change-Id: I924d2b5e369bef007eb1577f287a2274ec83d5a9
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 53 +++++++++++++++---------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 6974b1c5b56c2..8ac808d70356c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -283,14 +283,12 @@ unsigned int amd_sriov_msg_checksum(void *obj,
        return ret;
 }

+#define AMDGPU_VIRT_RAS_MAX_BAD_PAGES 512
+
 static int amdgpu_virt_init_ras_err_handler_data(struct amdgpu_device *ade=
v)  {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data **data =3D &virt->virt_eh_d=
ata;
-       /* GPU will be marked bad on host if bp count more then 10,
-        * so alloc 512 is enough.
-        */
-       unsigned int align_space =3D 512;
        void *bps =3D NULL;
        struct amdgpu_bo **bps_bo =3D NULL;

@@ -298,11 +296,14 @@ static int amdgpu_virt_init_ras_err_handler_data(stru=
ct amdgpu_device *adev)
        if (!*data)
                goto data_failure;

-       bps =3D kmalloc_array(align_space, sizeof(*(*data)->bps), GFP_KERNE=
L);
+       /* GPU will be marked bad on host if bp count more then 10,
+        * so alloc 512 is enough.
+        */
+       bps =3D kmalloc_array(AMDGPU_VIRT_RAS_MAX_BAD_PAGES,
+sizeof(*(*data)->bps), GFP_KERNEL);
        if (!bps)
                goto bps_failure;

-       bps_bo =3D kmalloc_array(align_space, sizeof(*(*data)->bps_bo), GFP=
_KERNEL);
+       bps_bo =3D kmalloc_array(AMDGPU_VIRT_RAS_MAX_BAD_PAGES,
+sizeof(*(*data)->bps_bo), GFP_KERNEL);
        if (!bps_bo)
                goto bps_bo_failure;

@@ -361,17 +362,27 @@ void amdgpu_virt_release_ras_err_handler_data(struct =
amdgpu_device *adev)
        virt->virt_eh_data =3D NULL;
 }

-static void amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
-               struct eeprom_table_record *bps, int pages)
+static bool amdgpu_virt_ras_add_bps(struct amdgpu_device *adev,
+               const struct eeprom_table_record *bps, int pages)
 {
        struct amdgpu_virt *virt =3D &adev->virt;
        struct amdgpu_virt_ras_err_handler_data *data =3D virt->virt_eh_dat=
a;

        if (!data)
-               return;
+               return false;
+
+       if (pages > AMDGPU_VIRT_RAS_MAX_BAD_PAGES - data->count) {
+               dev_warn_ratelimited(adev->dev,
+                                    "RAS WARN: bad page buffer full, count=
=3D%d pages=3D%d max=3D%d\n",
+                                    data->count, pages,
+                                    AMDGPU_VIRT_RAS_MAX_BAD_PAGES);
+               return false;
+       }

        memcpy(&data->bps[data->count], bps, pages * sizeof(*data->bps));
        data->count +=3D pages;
+
+       return true;
 }

 static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev) @@ -44=
3,20 +454,22 @@ static void amdgpu_virt_add_bad_page(struct amdgpu_device *=
adev,

        memset(&bp, 0, sizeof(bp));

-       if (bp_block_size) {
-               bp_cnt =3D bp_block_size / sizeof(uint64_t);
-               for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
-                       retired_page =3D *(uint64_t *)(vram_usage_va +
-                                       bp_block_offset + bp_idx * sizeof(u=
int64_t));
-                       bp.retired_page =3D retired_page;
+       if (!bp_block_size)
+               return;

-                       if (amdgpu_virt_ras_check_bad_page(adev, retired_pa=
ge))
-                               continue;
+       bp_cnt =3D bp_block_size / sizeof(uint64_t);
+       for (bp_idx =3D 0; bp_idx < bp_cnt; bp_idx++) {
+               retired_page =3D *(uint64_t *)(vram_usage_va +
+                               bp_block_offset + bp_idx * sizeof(uint64_t)=
);
+               bp.retired_page =3D retired_page;

-                       amdgpu_virt_ras_add_bps(adev, &bp, 1);
+               if (amdgpu_virt_ras_check_bad_page(adev, retired_page))
+                       continue;

-                       amdgpu_virt_ras_reserve_bps(adev);
-               }
+               if (!amdgpu_virt_ras_add_bps(adev, &bp, 1))
+                       break;
+
+               amdgpu_virt_ras_reserve_bps(adev);
        }
 }

--
2.34.1

