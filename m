Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47386C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 17:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C67B10E60C;
	Wed, 13 Jul 2022 17:04:01 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C6C10E208
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 17:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI2JiaX1rz7JkFGHZLmC6da2Alw/x0WUCzb90Hljhf/HZh/bwx+8asG4MSwlOIuTqvgWsMr4a5DRmrhewJisqQM4CrgNySrRzexIJSKUjin8wbK8z5eaI9a/EVFR0Q154gdQSwv/r1ltsNHMQC7SMgTASKDWMzXTrbXdc4GRhpFIjFHITBNaiPsodSQvY/YCet5W88tglDJNf9VBTgEyQFj834sqnRhVs3BdQuYmc5b4sRwHUEsHP4UK2Zmtk8IzmqXVE+2Onan/rMqiKy71UgZIU5Hf9COkgbZJy0l2xTpR9KFlVCviP3JnfErKN+ce5MUp4qFRN1BVdKahfo73Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OGqgUnftaV8K9q3fA1MMlNBGaTufmIXQpmetPvqLi4=;
 b=ROwnJdpDqK854SxS0wPQxsdUaUY4Wdtj1hgaOaJAd4ZFLf1PrPyGM1DrO92e5njFwB2V1pYWxJ1KpihO/ExxPCNLMeP/GQsH3rOd+tbeAv/u8G3qxkzmoJhrnrUNrutWb1fOWdHhUEo8yOJ796DP6y+BvA0DA1C+6G4ApfCk4e+LLoGjc/xP7tJkxjW6MP9R63U9dF0kPJbrMCyZcwVg3wCUiai7O4xdcu0kgN7bSONlTmosmgT3fCIAYRjhIYTnL+m5nraDg6PLiICD7uQ45gDx2m/ZBG98CRT8sCRMjXq2PeCkaz/oAA1Ut7ae1b25tPIPzr369uiLRlozwvr1bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OGqgUnftaV8K9q3fA1MMlNBGaTufmIXQpmetPvqLi4=;
 b=w+Kpqg2/yT3+MO+VRUQpeUMLlfJoUlNV74jB3v5uh4wTZtpGdvyZZNdlSjWypW3XkVHN5PwvrllOmZ99/VvXka8qNl0pimnfJlHJGsD8+eZ1EYILRs6Yimo0AaC8/eT+iWC4CdHaiRS9j/N3nmgHjXHJclizP4s/mM81cUFkXqQ=
Received: from DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16)
 by BN9PR12MB5164.namprd12.prod.outlook.com (2603:10b6:408:11d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 17:03:57 +0000
Received: from DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::61fd:e91e:1113:cb27]) by DM5PR12MB1753.namprd12.prod.outlook.com
 ([fe80::61fd:e91e:1113:cb27%5]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 17:03:57 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2] drm/amdgpu: limiting AV1 to first instance on VCN4
 decode
Thread-Topic: [PATCH v2] drm/amdgpu: limiting AV1 to first instance on VCN4
 decode
Thread-Index: AQHYltHKeC023LWwLUe8KOEyAXFn6618hzod
Date: Wed, 13 Jul 2022 17:03:57 +0000
Message-ID: <DM5PR12MB175396CB686CA710C8E9BF0AE4899@DM5PR12MB1753.namprd12.prod.outlook.com>
References: <20220713155955.4328-1-sonny.jiang@amd.com>
In-Reply-To: <20220713155955.4328-1-sonny.jiang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-13T17:03:56.960Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 977a1db9-33c6-40a6-8dae-08da64f1acbb
x-ms-traffictypediagnostic: BN9PR12MB5164:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IjU9HcsS6dDe4uNMZFg6MU4UDx4/LUtbSbuRTlCVGSxTlluFfSGrPIVqr+507EoEx53EqWtmOgKsZozYrikLH+A2BA8CZhatxSXjNdcxd27yNus8YOM0HP1r/F/yGzV4V4yIGVSyoUTsMi8hz23eMhNgQBuIU9g80kIk64Ke4PDmTHp5nffBq7Dl755FPnCvVDvJ/a2epCJRVfPblf3nvE//pLNl+LsP92rHnouAVBcf5VtYuG9mO0ZlvCsQa6QtT7jQyT0JNy1alVq0zhet00U6z7NttodeFlSR/jAADh/+M5qHxXqzZkew489b8euIeYbCNRzp7OK1EbioOgd5N6+YqD96LmZ4kp3uNH7UoEb4ULCFft6Lk9BKP8z01yQyXgGb7cnkt+tj5nodV1m6LEkdFGH3/hf/96hwggBRPc4lQBqq4nRUR5Di/n6QY3+JKeDGexh4RMoKBThJVseIoe3HwK0bEXcf46CgdCIdUXAhuJObtHMqt7aPm9rWiekFbLvOtJI+EfjH52KQAchAgod6o9VL5Hik97P1Qw9UXKrtwqqB/kPVVL0zTqYI7KJwcccmOowqX4c3/x6JuwaqDHj4cMIZ7CpQ3fQEHvbn/o1V3ABVgBxZcbEkQRTE0W6WeCOOiwoQpDiPuGdxmCzifLaHqD7Xfr56XyPRWJLHEriYMgxtIKSglMqBXl6ud3HXvSYZ97PpAowTsT4V2fvdxb2s/QHviWPrEUPgenb7tXpP7HcMuk44Lrh/YAe9WVPLqnMV/l06to76GVzXIKMo12RRVnai/PNN8Vy3SHWTq3D1j09zphGeOgNWOIkYR4jx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(71200400001)(110136005)(478600001)(122000001)(6506007)(83380400001)(55016003)(76116006)(91956017)(33656002)(7696005)(66556008)(38100700002)(86362001)(66446008)(41300700001)(316002)(66476007)(186003)(64756008)(8676002)(66946007)(52536014)(53546011)(8936002)(5660300002)(26005)(2906002)(38070700005)(9686003)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9PUlVzOcwlUQmvQDCwQogymaDycsN1SZ5R5DqCrVA/uWxkxjttYKodvCoqlq?=
 =?us-ascii?Q?oqz7m8RQus4TosdBp32b53Sq9cDk+T6R/0/j15eg07hAKLrLeaxkZVRmplN2?=
 =?us-ascii?Q?MH3oLl9XUfTv0a3coPKZm5qEPEb2L7O27r49fQVpvjl28jWWiKGuWu7ebiAp?=
 =?us-ascii?Q?MoxhvY+wJ4yPxjXcZNo3AnZOamK57eiDigy/oXD3NSR2etDBrwsyNLC4lSBS?=
 =?us-ascii?Q?3abhellf7toOJ5ry0G3kaheQetjESyFeEnqhedLxvpthhLuqF2ES/EE0E1mC?=
 =?us-ascii?Q?MeOiJXzMOd/M5XDTSCBCQdBAcCJ+TJvSrat0z+cyoUb+/dNMIrPH2ueAMyOk?=
 =?us-ascii?Q?oHdtex4vDPtEZJjo6ncKIteN6TFioQktTg+KAiNZENnePtZYO9EsppT6KWb9?=
 =?us-ascii?Q?GExszDfWm5DmUmjXOP+SssVzrAJYji2fw0ghbxwmvW/KveCgatZsfJ/K+eUO?=
 =?us-ascii?Q?bURqad0bmc63DSdk5Z2lm3SJVeSKXh5YiIiO2yJDI8guN/3Ipx8O9Jpnwj2W?=
 =?us-ascii?Q?BARfy8HRL0kcmjCAzIcpPQbiDB/2m6lIUA6bvHtXM8T/g8EmHYi5ZNbaUfI7?=
 =?us-ascii?Q?bYvLmplq24an+rKJESSWhMfk9KlTMRjs6+vePiQvGFXNOIBsMeULEu7d/RWY?=
 =?us-ascii?Q?pxkhbfTwgeeI/ZtRE0Dy9MPVKtU4FvtnXTkr0QnFTZsNJBTqmTyXz7+gSn2K?=
 =?us-ascii?Q?bV+QMLxlnZVId9W8E3DZJppfwBdP8x2nj4dygdsO7ZIa/hBDzQDOHrApjfDN?=
 =?us-ascii?Q?DRt5PmOjFncqq+8MpYCO9o+yky3JwN5TSON4kC9ZEURkQwWrYDwCsVG9wqcj?=
 =?us-ascii?Q?57fFZ5SfrsJzDr3Hne7qOubIIIIkBhtCOX/URriWKxqUs3qj4l3H5n1Q3mZq?=
 =?us-ascii?Q?nw7cS7XYy72WsQbVnXmT7AxO+5uouyB783j9c11piWywX+UwXj6mD3Za3ubb?=
 =?us-ascii?Q?TR8mGHS7JQrFQ8iXRpfD/bNXOtqWeDjpS+m5/Y2KgPh02isNxTrHAa0flmxH?=
 =?us-ascii?Q?c6rHYSyvEncemTILa4E+9lSBTb9MosfSRspaP5gqe0pyqitXb9//Xc4BErZC?=
 =?us-ascii?Q?DK6+TrHtzOQsDUqYsM8/odapEc3grszfLtcxWuGEuHKPnuJqXkTmDrolGe8m?=
 =?us-ascii?Q?kqhJfvb8tvlLmiWyQVbRur9lDtd7dDWWtFrUxtZ60qzTCzOzEfJMno3AanPb?=
 =?us-ascii?Q?BXi4fliVUWZITMEsz265MOT+e0+DVzf357UW0eJ+An9irN1A4cJqBS1laxtN?=
 =?us-ascii?Q?wl+1Kg2egoCjv/Hv0XS16RR/zHNRoHmUveBwLbO4xzH/PwEeFyjpgYr1uda+?=
 =?us-ascii?Q?LLVII9gFnpZXHt7CyirELLfoW0AUw/KODPces++nsxw4b59soPVW2oi61g4J?=
 =?us-ascii?Q?jpAtnBMUbMUlaEfWIojB/CyQqEblufLI6PG4G/LiTC2uOV9gvcdSmu2sC0zF?=
 =?us-ascii?Q?5BIxo+ym86LEIG3QR1tm6nbdoAaAXtYY6DHOe5HoBJazVs2vGhNtMNjldMN5?=
 =?us-ascii?Q?zXCOaERZApul7w0hFSo4qQN8uT8ifRw+xJqipn+640vA6k0TFFoHmyZTePke?=
 =?us-ascii?Q?gOHfF+N9c4ZFxev2OSs=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB175396CB686CA710C8E9BF0AE4899DM5PR12MB1753namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977a1db9-33c6-40a6-8dae-08da64f1acbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 17:03:57.3746 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V23GGFMywF10B2oS5A1C/qxZZ4avVT1ndLfIoMU2nKwXnA9eydcxzoSEuNXvx+Wy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5164
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

--_000_DM5PR12MB175396CB686CA710C8E9BF0AE4899DM5PR12MB1753namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

This patch is Reviewed-by: James Zhu <James.Zhu@amd.com>


________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Sonny Ji=
ang <sonny.jiang@amd.com>
Sent: Wednesday, July 13, 2022 11:59 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com>
Subject: [PATCH v2] drm/amdgpu: limiting AV1 to first instance on VCN4 deco=
de

AV1 is only supported on first instance.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 131 ++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c
index 84ac2401895a..a91ffbf902d4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_hw_ip.h"
@@ -44,6 +45,9 @@
 #define VCN_VID_SOC_ADDRESS_2_0                                           =
      0x1fb00
 #define VCN1_VID_SOC_ADDRESS_3_0                                          =
      0x48300

+#define RDECODE_MSG_CREATE                                                =
     0x00000000
+#define RDECODE_MESSAGE_CREATE                                            =
     0x00000001
+
 static int amdgpu_ih_clientid_vcns[] =3D {
         SOC15_IH_CLIENTID_VCN,
         SOC15_IH_CLIENTID_VCN1
@@ -1323,6 +1327,132 @@ static void vcn_v4_0_unified_ring_set_wptr(struct a=
mdgpu_ring *ring)
         }
 }

+static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p)
+{
+       struct drm_gpu_scheduler **scheds;
+
+       /* The create msg must be in the first IB submitted */
+       if (atomic_read(&p->entity->fence_seq))
+               return -EINVAL;
+
+       scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
+               [AMDGPU_RING_PRIO_0].sched;
+       drm_sched_entity_modify_sched(p->entity, scheds, 1);
+       return 0;
+}
+
+static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)
+{
+       struct ttm_operation_ctx ctx =3D { false, false };
+       struct amdgpu_bo_va_mapping *map;
+       uint32_t *msg, num_buffers;
+       struct amdgpu_bo *bo;
+       uint64_t start, end;
+       unsigned int i;
+       void *ptr;
+       int r;
+
+       addr &=3D AMDGPU_GMC_HOLE_MASK;
+       r =3D amdgpu_cs_find_mapping(p, addr, &bo, &map);
+       if (r) {
+               DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+               return r;
+       }
+
+       start =3D map->start * AMDGPU_GPU_PAGE_SIZE;
+       end =3D (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
+       if (addr & 0x7) {
+               DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+               return -EINVAL;
+       }
+
+       bo->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+       r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+       if (r) {
+               DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r=
);
+               return r;
+       }
+
+       r =3D amdgpu_bo_kmap(bo, &ptr);
+       if (r) {
+               DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
+               return r;
+       }
+
+       msg =3D ptr + addr - start;
+
+       /* Check length */
+       if (msg[1] > end - addr) {
+               r =3D -EINVAL;
+               goto out;
+       }
+
+       if (msg[3] !=3D RDECODE_MSG_CREATE)
+               goto out;
+
+       num_buffers =3D msg[2];
+       for (i =3D 0, msg =3D &msg[6]; i < num_buffers; ++i, msg +=3D 4) {
+               uint32_t offset, size, *create;
+
+               if (msg[0] !=3D RDECODE_MESSAGE_CREATE)
+                       continue;
+
+               offset =3D msg[1];
+               size =3D msg[2];
+
+               if (offset + size > end) {
+                       r =3D -EINVAL;
+                       goto out;
+               }
+
+               create =3D ptr + addr + offset - start;
+
+               /* H246, HEVC and VP9 can run on any instance */
+               if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create=
[0] =3D=3D 0x11)
+                       continue;
+
+               r =3D vcn_v4_0_limit_sched(p);
+               if (r)
+                       goto out;
+       }
+
+out:
+       amdgpu_bo_kunmap(bo);
+       return r;
+}
+
+#define RADEON_VCN_ENGINE_TYPE_DECODE                                 (0x0=
0000003)
+
+static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
+                               struct amdgpu_job *job,
+                               struct amdgpu_ib *ib)
+{
+       struct amdgpu_ring *ring =3D to_amdgpu_ring(p->entity->rq->sched);
+       struct amdgpu_vcn_decode_buffer *decode_buffer =3D NULL;
+       uint32_t val;
+       int r =3D 0;
+
+       /* The first instance can decode anything */
+       if (!ring->me)
+               return r;
+
+       /* unified queue ib header has 8 double words. */
+       if (ib->length_dw < 8)
+               return r;
+
+       val =3D amdgpu_ib_get_value(ib, 6); //RADEON_VCN_ENGINE_TYPE
+
+       if (val =3D=3D RADEON_VCN_ENGINE_TYPE_DECODE) {
+               decode_buffer =3D (struct amdgpu_vcn_decode_buffer *)&ib->p=
tr[10];
+
+               if (decode_buffer->valid_buf_flag  & 0x1)
+                       r =3D vcn_v4_0_dec_msg(p, ((u64)decode_buffer->msg_=
buffer_address_hi) << 32 |
+                                               decode_buffer->msg_buffer_a=
ddress_lo);
+       }
+       return r;
+}
+
 static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs =3D {
         .type =3D AMDGPU_RING_TYPE_VCN_ENC,
         .align_mask =3D 0x3f,
@@ -1331,6 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_unifie=
d_ring_vm_funcs =3D {
         .get_rptr =3D vcn_v4_0_unified_ring_get_rptr,
         .get_wptr =3D vcn_v4_0_unified_ring_get_wptr,
         .set_wptr =3D vcn_v4_0_unified_ring_set_wptr,
+       .patch_cs_in_place =3D vcn_v4_0_ring_patch_cs_in_place,
         .emit_frame_size =3D
                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
--
2.36.1


--_000_DM5PR12MB175396CB686CA710C8E9BF0AE4899DM5PR12MB1753namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
</div>
This<span style=3D"color:#c0c0c0"> </span>patch<span style=3D"color:#c0c0c0=
"> </span>
is<span style=3D"color:#c0c0c0"> </span>Reviewed-by:<span style=3D"color:#c=
0c0c0"> </span>
James<span style=3D"color:#c0c0c0"> </span>Zhu<span style=3D"color:#c0c0c0"=
> </span>&lt;James.Zhu@amd.com&gt;
<div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p><br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Sonny Jiang &lt;sonny.jiang@a=
md.com&gt;<br>
<b>Sent:</b> Wednesday, July 13, 2022 11:59 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;Sonny.Jiang@amd.com&gt;<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: limiting AV1 to first instance on VC=
N4 decode</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">AV1 is only supported on first instance.<br>
<br>
Signed-off-by: Sonny Jiang &lt;sonny.jiang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 131 +++++++++++++++++++++++++=
+<br>
&nbsp;1 file changed, 131 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v4_0.c<br>
index 84ac2401895a..a91ffbf902d4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c<br>
@@ -25,6 +25,7 @@<br>
&nbsp;#include &quot;amdgpu.h&quot;<br>
&nbsp;#include &quot;amdgpu_vcn.h&quot;<br>
&nbsp;#include &quot;amdgpu_pm.h&quot;<br>
+#include &quot;amdgpu_cs.h&quot;<br>
&nbsp;#include &quot;soc15.h&quot;<br>
&nbsp;#include &quot;soc15d.h&quot;<br>
&nbsp;#include &quot;soc15_hw_ip.h&quot;<br>
@@ -44,6 +45,9 @@<br>
&nbsp;#define VCN_VID_SOC_ADDRESS_2_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x1fb00<br>
&nbsp;#define VCN1_VID_SOC_ADDRESS_3_0&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x48300<br>
&nbsp;<br>
+#define RDECODE_MSG_CREATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000000<br>
+#define RDECODE_MESSAGE_CREATE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x00000001<br>
+<br>
&nbsp;static int amdgpu_ih_clientid_vcns[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_IH_CLIENTID_VCN,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SOC15_IH_CLIENTID_VCN1<br>
@@ -1323,6 +1327,132 @@ static void vcn_v4_0_unified_ring_set_wptr(struct a=
mdgpu_ring *ring)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
&nbsp;<br>
+static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_scheduler **scheds;<br=
>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The create msg must be in the firs=
t IB submitted */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (atomic_read(&amp;p-&gt;entity-&gt=
;fence_seq))<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scheds =3D p-&gt;adev-&gt;gpu_sched[A=
MDGPU_HW_IP_VCN_ENC]<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; [AMDGPU_RING_PRIO_0].sched;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_modify_sched(p-&gt;e=
ntity, scheds, 1);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t addr)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ttm_operation_ctx ctx =3D { fa=
lse, false };<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_va_mapping *map;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t *msg, num_buffers;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t start, end;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int i;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr &amp;=3D AMDGPU_GMC_HOLE_MASK;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_cs_find_mapping(p, addr,=
 &amp;bo, &amp;map);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Can't find BO for addr 0x%08llx\n&quot;, addr);<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; start =3D map-&gt;start * AMDGPU_GPU_=
PAGE_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; end =3D (map-&gt;last + 1) * AMDGPU_G=
PU_PAGE_SIZE;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (addr &amp; 0x7) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;VCN messages must be 8 byte aligned!\n&quot;);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;flags |=3D AMDGPU_GEM_CREATE_C=
PU_ACCESS_REQUIRED;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_placement_from_domain(bo, b=
o-&gt;allowed_domains);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D ttm_bo_validate(&amp;bo-&gt;tbo=
, &amp;bo-&gt;placement, &amp;ctx);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Failed validating the VCN message BO (%d)!\n&quo=
t;, r);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_kmap(bo, &amp;ptr);<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_ERROR(&quot;Failed mapping the VCN message (%d)!\n&quot;, r)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msg =3D ptr + addr - start;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Check length */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg[1] &gt; end - addr) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D -EINVAL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (msg[3] !=3D RDECODE_MSG_CREATE)<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; goto out;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_buffers =3D msg[2];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0, msg =3D &amp;msg[6]; i =
&lt; num_buffers; ++i, msg +=3D 4) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; uint32_t offset, size, *create;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (msg[0] !=3D RDECODE_MESSAGE_CREATE)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; offset =3D msg[1];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; size =3D msg[2];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (offset + size &gt; end) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D -EINVAL;<b=
r>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; }<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; create =3D ptr + addr + offset - start;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* H246, HEVC and VP9 can run on any instance */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || create[0] =
=3D=3D 0x11)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; r =3D vcn_v4_0_limit_sched(p);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (r)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
+out:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(bo);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+}<br>
+<br>
+#define RADEON_VCN_ENGINE_TYPE_DECODE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; (0x00000003)<br>
+<br>
+static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib)<br>
+{<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D to_amdgp=
u_ring(p-&gt;entity-&gt;rq-&gt;sched);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vcn_decode_buffer *deco=
de_buffer =3D NULL;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r =3D 0;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The first instance can decode anyt=
hing */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!ring-&gt;me)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unified queue ib header has 8 doub=
le words. */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ib-&gt;length_dw &lt; 8)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return r;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; val =3D amdgpu_ib_get_value(ib, 6); /=
/RADEON_VCN_ENGINE_TYPE<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (val =3D=3D RADEON_VCN_ENGINE_TYPE=
_DECODE) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; decode_buffer =3D (struct amdgpu_vcn_decode_buffer *)&amp;ib-&gt=
;ptr[10];<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (decode_buffer-&gt;valid_buf_flag&nbsp; &amp; 0x1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D vcn_v4_0_d=
ec_msg(p, ((u64)decode_buffer-&gt;msg_buffer_address_hi) &lt;&lt; 32 |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; decode_buffer-&gt;msg_=
buffer_address_lo);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
+}<br>
+<br>
&nbsp;static const struct amdgpu_ring_funcs vcn_v4_0_unified_ring_vm_funcs =
=3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .type =3D AMDGPU_RING_TYPE=
_VCN_ENC,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .align_mask =3D 0x3f,<br>
@@ -1331,6 +1461,7 @@ static const struct amdgpu_ring_funcs vcn_v4_0_unifie=
d_ring_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_rptr =3D vcn_v4_0_uni=
fied_ring_get_rptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_wptr =3D vcn_v4_0_uni=
fied_ring_get_wptr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_wptr =3D vcn_v4_0_uni=
fied_ring_set_wptr,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .patch_cs_in_place =3D vcn_v4_0_ring_=
patch_cs_in_place,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_frame_size =3D<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +<br>
-- <br>
2.36.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB175396CB686CA710C8E9BF0AE4899DM5PR12MB1753namp_--
